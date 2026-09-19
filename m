Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4537C982D8
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yFB-0002q0-5S; Sat, 19 Sep 2026 12:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yF8-0002pq-UG
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:48:51 -0400
Received: from mail-oi2-x11.google.com ([2607:f8b0:4864:32::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yF7-0008FM-F4
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:48:50 -0400
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4c2c08ff3f8so1282182b6e.1
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836528; x=1790441328;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mDkP0dtWB36TzbGajHdmCtPZU5XPoaXCX6IaOFZEw+0=;
 b=qdKeGEzIwzLGJvcYL0uDYnBZzegZkuK+pq8vR6NonFvcWtwiHzEPSwZ2CgtUGD3uMx
 PArgEWlTN8byvQ26RdDdRkjuJF0ErC1XgH8/ETr9Ouerl0HNEyZHrSYxFpFILhJLpnkL
 DlII72gS1CGhoZRlTbDROtz7hlfBM/mWqktEvQZ32w9Nq2ovmQ9Hticvbar9ChemMeH6
 iCZWFRzrbFctmVSxyn2kuwrujB7EQ2PKZ2tXD1q+F7IlRfC9rvyUgvnrUvKPUMFbKpa0
 tIhepvpgooGnjXgob4Vc/ZBeSjAN5zGni4Vj9U/ao3bZZRV+/tZgkcG74L5XompThmZK
 RvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836528; x=1790441328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mDkP0dtWB36TzbGajHdmCtPZU5XPoaXCX6IaOFZEw+0=;
 b=jfBJ2E1HmTjfQxp6NKtS/8nKh4rlTePbII2l+5q/wQLhWLQMeNeOkjTEUkZLUsO98i
 jOhvt161DJe387lqS8HdWXqKaFD/IL+Urbhqnf9zODiXsdE142E1hj6c2Zko1Z3x5ot9
 Yid11f4khL9v+iqNRl9GvGB7ckCQRhzQn5/60Ct/mJ6NUpKIXIoUvRbZjDBghUjbmi1v
 h8t1/WP6TRkFqsztApqPhXxntv7NrIsROa0kDh0dd3mQmV3mJ6m36ECeEKHA0/Oa5sCq
 bH8ww2BqvNHdfgVk/4Xh/Sh9+dmHko7wRLIeAjjYym05xoACmeebWWYNy1CW1r7dX6ph
 dNGg==
X-Gm-Message-State: AFuF++lCotkT58i0mwPB5WeD8IRL59Rthkg2HnN8cH0XqrVpu8i8JDnh
 YYA85Sr+aWrTpQ7iQ5MNv9quHFXjK+jAUmrbfyoi98WGp4SdL/ZQGyLO3t/9CD+mRqQNHDBu7KW
 WXQwDhgg=
X-Gm-Gg: AYBFou2TBWsR/vbUqjSdH+JDHzoRUkHqCTd/ppOxOoJSZHLAYAgs/22faD4sdxNLDvT
 XBZsz+YDEQKraVjg1JBBtAkOL55nPel79kCTPSLwEPXoBsrTzeVannWGNVXLh8kUeAmVNp61WS0
 eNfwKBtMqW9qWgKeBwDvG+Bycc4xSFI80eiht++VSSjOayqfsKAdA0mUV/qGZ9Hu8HwbX2083qC
 BYQStSoO0L11jv1q//7Buo+9xDpLWufTGEA/MaJMItjrSn3ZWBZm2MF4RlO/PxaYqjVYJ7vJ2MJ
 uHUdGIkuHS0EM8p7INKshqyFLVKykxi4EIr6a11UPwPQi+Twz/K+1VeI3qdbgzGEw+MnXvnhLQJ
 nECESYQuccJPdyd3iTTiFN932zyRYxaTtJ0/OOwpWCfWiywNPPOnkQrg0w2DBTs3B9pzbydmxZY
 HiV+LYbAnFeNQiNY3kcShM3u0IPLDYxSWXcWCkw2jXOJHA3WHIc/DtLTyNKA==
X-Received: by 2002:a05:6820:4b82:b0:6b6:71f7:ecac with SMTP id
 006d021491bc7-6ca9c25263amr5395810eaf.32.1789836528480; 
 Sat, 19 Sep 2026 09:48:48 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd35712c0csm3281927eaf.11.2026.09.19.09.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:48:47 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 11/41] bsd-user: Fix realpathat for FreeBSD 15.0 and newer
Date: Sat, 19 Sep 2026 10:47:39 -0600
Message-ID: <20260919164810.70151-12-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919164810.70151-1-imp@bsdimp.com>
References: <20260919164810.70151-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::11;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x11.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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


