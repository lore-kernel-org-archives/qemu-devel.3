Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF0CD58E47
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 04:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwunR-00019I-CK; Sun, 01 Mar 2026 23:22:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwunQ-00018R-AS
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:22:16 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwunO-0006uG-Pk
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:22:16 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d4c9537f90so3120236a34.0
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 20:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772425333; x=1773030133;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=19ljbr1o0BvpqD1t+GIQAZ/Y0zwNuoL7pQE8K/HzaYw=;
 b=GPMDUGRs0/U2aP8bR9cKJ4JmDFd/hVBVx0/1xqxzUSMTOF16Z9GRW3iyVDzN1r4Ru6
 hVl1qJs9FGhu5GdrMiGnwm816O1o1+K7JJjyzGpO4U9v7MgJsVFcyOPccXL7EGdrrzlX
 m/OHzrzRCmXglkihb5nRsF4gNvudIcEntz5uF/4bhRcbn+xGI3F8Ji1Zd+TAf6DVykQt
 dtRLTBUphkyjFWw6Q4PbnsXFvBjvUWabNIJo+7bf9NFx6rWL72Jf0KRaGi0QE74skNlb
 OltWS/u1dkYFO7P8tcgGHbeSGU8RlqExKKOHAHZOQQGaZOe5sxdaG1x1/wdyiHSFJNIc
 X6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772425333; x=1773030133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=19ljbr1o0BvpqD1t+GIQAZ/Y0zwNuoL7pQE8K/HzaYw=;
 b=VZUxwaP97EkkRY0tf6FRlKimklo81IAftdqr1BpoEiuOR4SV6WdIrRN4JyGrG5YyZc
 fSACqdmoypny7QdRlo0qpTcUMXcbxyKVUcl7xAb+cJ38N7PP5RuuyoIVblgFY6LgIFlp
 G/H097eQY7a3IINZ5w0yoRFNYnqctK3NmUsgwCEyTghrtSZBovFBDPRzmCsE07eeFagt
 +BemXJn6ilkby4iABAvy+ofU/akbvLxeBB6UgeMYdDYuarf6wfUDV51PD5gkQEJXMI1x
 4HY4IqeD9AzW9n+L4S6tumlFq69AYKxBkOXEas3I2VbbkgSK6/2CsZ2tuDDXBdudXAaU
 lugw==
X-Gm-Message-State: AOJu0YwAsThTTnDyg1Fy0HPBvV4SbncWPfWxestoSEQUvjnMTO0oveWK
 yzJB7PJo2YAKRCve2/lJbXCrs+gbXGBA38Bnf3uAM6Qp5bhxpyYkxtlniRtS0gM8mlODxOxaEcU
 vi0Ga
X-Gm-Gg: ATEYQzzxYtw55bFJPtkBVbXK981ASfBUw6ewEqKOi8GV61/Occe8u1aybN2OQm6hV2w
 uutXKqbGgEiBcDyGMKzatlOZZMaYQuzhPSe7Oc8+PU8ETamazjNZgCU+m/tBbjEtBeYgRps42x7
 /E+xeAcmz4JGpN2IgnErk5s9NHI9c2pmMmFuTMbwSMeIiNc4yXTZgaVBxxUiBNcZByXtz5ALZAW
 JvTxy+gBEIkqB+Ba1wZk/lruP4QNh1AdHcs6ZsvlGP5CydVCPLhWQMky5+dDEDFaZSPB9CRKhy9
 +Zkl0S0S68xnN7wDzRa2AyFOlmQdd0QgziuSmQJioPCXQ8kH86qbkmdoyN6wYFOfdB8PRzqh/Ge
 s7eozF/Km50LPCijFkXXHBYi7TwCM20TbBi6LVRUkhutdsAAI4OEsbjia5hlCsIZvOeImNsaOUs
 ZZlnTm3Ls3cg==
X-Received: by 2002:a05:6871:36c8:b0:404:3569:5a45 with SMTP id
 586e51a60fabf-41626ffa12emr7426978fac.40.1772425333428; 
 Sun, 01 Mar 2026 20:22:13 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41668233c4bsm2236778fac.19.2026.03.01.20.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 20:22:12 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 26/27] bsd-user: Add miscellaneous BSD syscall implementations
Date: Sun,  1 Mar 2026 21:21:14 -0700
Message-ID: <20260302042115.83410-27-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302042115.83410-1-imp@bsdimp.com>
References: <20260302042115.83410-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32b;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32b.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Wire up the remaining miscellaneous BSD syscalls:
- quotactl(2): Quota control (stub returning ENOSYS)
- reboot(2): Reboot system (stub returning ENOSYS)
- uuidgen(2): Generate UUIDs
- getdtablesize(2): Get descriptor table size

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index f39e521e42..85e5db19a3 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -933,6 +933,22 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_obreak(arg1);
         break;
 
+    case TARGET_FREEBSD_NR_quotactl: /* quotactl(2) */
+        ret = do_bsd_quotactl(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_reboot: /* reboot(2) */
+        ret = do_bsd_reboot(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_uuidgen: /* uuidgen(2) */
+        ret = do_bsd_uuidgen(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_getdtablesize: /* getdtablesize(2) */
+        ret = do_bsd_getdtablesize();
+        break;
+
         /*
          * sys{ctl, arch, call}
          */
-- 
2.52.0


