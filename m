Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96A5C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 23:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwTgk-00024p-Tq; Tue, 18 Aug 2026 19:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgj-00023L-4W
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:57:49 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgh-0005EK-J8
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:57:48 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-44ae14b4fd6so219219fac.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097466; x=1787702266;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ov6n3a3M5ogrqOylpDInjV/9y04Z0hk/nlpSW1eYoXI=;
 b=PoQM3h3ibGsHC1n6g4orfYl1YaXD462ng1qifGaRM05I+i0MhR2dH+nl5lE6iFuOVh
 7kEoijThzBdOKKbJj2kXxl5WPtiT1VzEA/AVSjB1n9MAO3dhfE33chVR3ROKqdZdGxjW
 scOjMDEJQ3lf8/gu29JJhUKiV1avz2FZz0A3eg3Tp3efAp/XYsaNee2LEQhd+IOpai37
 GRrrn6owMymJuNjxxEuc/vQc7XP5/ttMWBnf1DnM/MdLkNRxgjLRLWgtKE8H2u/MgLUM
 wVlq6qv468vvkJl6K0u8EHRxxjw1apgmovldYcL4/z5+5FKpYvz6w0/pEVvU+ZTAkVfJ
 Ureg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097466; x=1787702266;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ov6n3a3M5ogrqOylpDInjV/9y04Z0hk/nlpSW1eYoXI=;
 b=YzXblWxTIAqI7L5zKuvk2QAMc4zXkBjydnoib0vl2N3YkJOrrNJai/2asdSZY6SN67
 jmql/D4Bh8dvt+3pNgjNVlLD91x4QS+jiPt9iUCe/pKxZ7lQyEecpWQiwQ1sacxktkPZ
 aFT+JHEkQWgRqU3zXhj8Qdt4rbH7BQmpflB9jZl9KtG4QANBmcP16/6s7eFBbjkAjXWi
 IAma1g0Xstn49MspAqa341I99xtIoPjRRJDJ5NUEHguYwPMpfNVhlBUeshi7Qb9ODvNT
 QO80ELtgIB6zGvgeLeW74ZcvXDECYgq3/ej5uucLGUWQ/QbK24maUcSBbjbRuWjMsn6T
 esTw==
X-Gm-Message-State: AOJu0Yy+vtcDsA9zqiwbt767my946tKX0LhemuTephmvFJ99Sia3ScOn
 f42+Pd4XiGIsG14+9oCP/5XpS+2l09cN+omqpbGi+iSn8jCzfMavVNDo7mgCpZURlLw=
X-Gm-Gg: AR+sD10VD31zp/IbB0SOUelI6I8eePKLAoEKFV0U7MCarugzsIcJGsNNYUtDhDOyiGG
 +w+mgagb9A1BQtGM23K4e6UDZ7/BJgslZawicExsDQAbRNAdEbUDE9CpXxx9gmObhGxxtYx/uZQ
 iEVGicVSX+MfgAFBY37Z9Md1MfLW389p1VBHVnrwTqW7azRjfnNVEpuLPc84ketIq4Ik4/6ZXDy
 6c4Ox8XwOU6yeH4xfE84coCBT83L/wI0XNySXpF7TAl0QXQmYtiZxURok4LIRo1zajsaRmtSxQS
 OPD8iOUn9WRpykDooMusBpb6uTh88bk+xoT9clZF4HDvIB2mkOiVjgWhFCSPG5LbRzzDzNBiRiC
 MnvM2ByPnx+cT+Eu5HeLnKMEvoQC4l0SvKQ1au1SKW35c29LWqWQjpVRaJA+602j7hti0ICy9aD
 wbXCrEl225yrds/5/Vi49yyZ3zgo2kAscxMUtDDlARAMa02ZM=
X-Received: by 2002:a05:6808:1824:b0:4ae:f5be:fe29 with SMTP id
 5614622812f47-4b2bc936382mr301283b6e.5.1787097466219; 
 Tue, 18 Aug 2026 16:57:46 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:57:45 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:56:03 -0600
Subject: [PATCH v4 10/40] bsd-user: Fix realpathat for FreeBSD 15.0 and newer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-misc-2026q2-v4-10-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1512; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=U4QLAf4pRBB7RfP8WXIa842IBu1rtlLK+V6DfrN5Ez0=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPEuFxHBqBMYYB5nALTDjBg7aLfxTlNqo0Nh6
 wE5kdcJK6SJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxLhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQAnFBAAqub4wXAHl8cTUyeNMZOzwhvZpIwSODI
 w5W2lxunAMsTYUiclYIs5CfiRMII73RedlAhg4naGa2hpzpbSdxHNs/yl+/RKmjGoqJmXgAYyWi
 OQaH5Jma0H7oEjS972JQemJegxsPBLOkwLBL4ZSm7zGysF3yzooRJ2IiCuZdbZh2MqZsdvLJa06
 6Wigz5g1c/HIpvgVyOTV0c0ACxzkSHEacGxrkWdfMu9aGWPOMMwDXnlje2gwx5bzVxQ6fZk//XW
 6hpfYBGrhhRtL24YTNvP14X1v+CGpqOaQf+o50U0pAyhE5bF3mo1LF6JAuX4OvUFx26L4wGfU5T
 2iQcHBtj3kalgipzDMxUYPOLnaO+KFePGuVleE9pB1ur+XW/gLvC6t+iofoy6xCtRIJetGgW3Vf
 fQZeUCSPikFpTx9JbL5VUIfgvTR3a3Je43HWO9i3ENpjk2sNSA4m1bpZ0iyCk2Kqq2iqe3vlL6S
 CSgEbW690K5tIbMbFBY9zQJayST995RqTmu0OsjTqunmRrcF9M9Qczfh6y/8YX3a+XLG8qiJ/T4
 OqMe1gFpxtEBTjylDpr9x4ArsggYwiYK5epzLHJ65RjiLMTDX77yHGsYZ+Q4LmTOjKkRLgp9b5f
 LCdYsiUqFegrJv+ptEqnVgaiP/QoH/o8GZTJtUn56OuXlAevX26M=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::2b;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fix __realpathat to use __sys___realpathat on FreeBSD >= 15.0.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-stat.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index ea95aa6344..4e5fc30de4 100644
--- a/bsd-user/freebsd/os-stat.h
+++ b/bsd-user/freebsd/os-stat.h
@@ -622,11 +622,6 @@ static inline abi_long do_freebsd_fcntl(abi_long arg1, abi_long arg2,
     return ret;
 }
 
-#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300080
-extern int __realpathat(int fd, const char *path, char *buf, size_t size,
-        int flags);
-/* https://svnweb.freebsd.org/base?view=revision&revision=358172 */
-/* no man page */
 static inline abi_long do_freebsd_realpathat(abi_long arg1, abi_long arg2,
         abi_long arg3, abi_long arg4, abi_long arg5)
 {
@@ -640,12 +635,11 @@ static inline abi_long do_freebsd_realpathat(abi_long arg1, abi_long arg2,
         return -TARGET_EFAULT;
     }
 
-    ret = get_errno(__realpathat(arg1, p, b, arg4, arg5));
+    ret = get_errno(syscall(SYS___realpathat, arg1, p, b, arg4, arg5));
     UNLOCK_PATH(p, arg2);
     unlock_user(b, arg3, ret);
 
     return ret;
 }
-#endif
 
 #endif /* BSD_USER_FREEBSD_OS_STAT_H */

-- 
2.55.0


