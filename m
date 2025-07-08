Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C429C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 19:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZEFu-0002ju-F0; Tue, 08 Jul 2025 15:45:31 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZBOc-0008MW-Av
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 12:42:54 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZBN1-0003wD-V3
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 12:41:46 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5550dca1241so4455467e87.0
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 09:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751992582; x=1752597382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZXKQqfZ2ciokJ1PutVi8XKnjYw3wpn3AxACuTTQC2Dk=;
 b=CqW+GJn0BjLcA4jOuOI3+zg2zbkm3rlmEzV0HK9xxnGXtmHNCCOu+510u9Edhdzean
 j0izVN8S7lzIQDVkGwZzsf43g+4+figOdS9VKtVs2+WiV2NbWnNwcINVfRnkJeb3PU8p
 bstlkerkpy60pdxILPCIwtsBcG/8d5LrtbLwFROldsa6HfyT7VGYlh2Vu67eyY+4tdEs
 /tbFctjRqbhflRvANXYmDmssmwbt96KdJmgt+45f0JbCJYUvtRuOU3hD6hELnuy4RE/Z
 50uExb8NgN+xTT050gCUF7Ls1+c1SzAq5RYMzPN3ytDiblby3FUgcEkOMPaUKkdqmodQ
 0RQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751992582; x=1752597382;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZXKQqfZ2ciokJ1PutVi8XKnjYw3wpn3AxACuTTQC2Dk=;
 b=ODYLGI7kTSKdc6UQKHdr3gVCozh5weWpOZUpUNNBEYpwmgePl9yf3AX4PwzlueuUir
 SItIucXOZEQN0ErYEhCnZ6ntf5ti2bmJLVVCuiP57WvExq2sJqdyksKGT6LIO1KvuZ3v
 +0Fx7Wplqrd7VVbUcwO+sQMUpuHtxYOsVn+v8AjTYhW4VhEsmCsrPjuMwPlLRpvHK1vo
 E+hIDYf9Whg9jp9PR3gbYzbfcqyW68IJhLp34ebdtgQkpvuczelAgQ8KMoP/LVEQoYk6
 GlG+jRxQAGPpJNeC6UdvScweP/Y30tyvzFTz6xSNXapqnG91t7uIu5tomoEaTEFJs66g
 gX2A==
X-Gm-Message-State: AOJu0YwhYPeeM1dlc/eITELGp+nwz+MK7WlzNHDlHqjlGkZyTv0D2JxH
 y69zzAY7gE1yyQ3GESrpyOns4ZuQLPFdsNRf2KdpOQY8z9o43o83ZDfo6WOitcxrdKS/wSvxTa7
 EhHXc
X-Gm-Gg: ASbGncvz1Q6wNQSmw5EvtYX3a/OTEiuMJXSbIA36KaCLqZ89rTX5iLS1KhGlUvkG0WA
 0BuetXNlpdjK0im9wTl5ELMvScODqt2+J1h/NctvP2BnKhayr23Ls3hpshZDH9VjkMKwSgJXMYZ
 GDcP8Uo9A0RKwEIex+WsN43p66uIVdXyIgVY9qWlDgSFEQf1GnbdGHzUnHzkzJ8tJwpnUPv1Ypz
 ZQyTvFjThAnR8EQzr3hV+Kd4kzU5f1Wgje1KUHtBr0TnzqkPPsN257vnPKuVABIp4Fi6+/JSHkZ
 MTG9jQDPasn352HEKIzEM5LupzebGOHTkQWOqZa4+a6jFhXJHwO2lflSgGZNgCuxS3uM
X-Google-Smtp-Source: AGHT+IGkMovD7CLqYjmt7UQNNGbSgCsvyR46lNmn+WoUzq1mGVlB8qHUY6Cc9TV/1qN5c015NocnKg==
X-Received: by 2002:a05:600c:3493:b0:442:cd03:3e2 with SMTP id
 5b1f17b1804b1-454b306a122mr172746835e9.2.1751991055287; 
 Tue, 08 Jul 2025 09:10:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd43c638sm26970085e9.8.2025.07.08.09.10.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 09:10:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] linux-user: Implement fchmodat2 syscall
Date: Tue,  8 Jul 2025 17:10:53 +0100
Message-ID: <20250708161053.853322-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The fchmodat2 syscall is new from Linux 6.6; it is like the
existing fchmodat syscall except that it takes a flags parameter.

If we have the host fchmodat2 syscall, we implement it as a
direct passthrough call; if we do not, then we can fall back
to using the libc fchmodat() function. The fallback can
handle the AT_SYMLINK_NOFOLLOW flag but won't be able to
do anything about AT_EMPTY_PATH.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Tested very lightly (ran an fchmodat2 test from the
Linux Test Project test suite).

You could argue that the fallback-to-libc-fchmodat here isn't
worth bothering with, I guess.

 linux-user/syscall.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index fc37028597c..827b432bb31 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -790,6 +790,10 @@ safe_syscall6(ssize_t, copy_file_range, int, infd, loff_t *, pinoff,
               int, outfd, loff_t *, poutoff, size_t, length,
               unsigned int, flags)
 #endif
+#if defined(TARGET_NR_fchmodat2) && defined(__NR_fchmodat2)
+safe_syscall4(int, fchmodat2, int, dfd, const char *, filename,
+              unsigned short, mode, unsigned int, flags)
+#endif
 
 /* We do ioctl like this rather than via safe_syscall3 to preserve the
  * "third argument might be integer or pointer or not present" behaviour of
@@ -10713,6 +10717,22 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         ret = get_errno(fchmodat(arg1, p, arg3, 0));
         unlock_user(p, arg2, 0);
         return ret;
+#endif
+#if defined(TARGET_NR_fchmodat2)
+    case TARGET_NR_fchmodat2:
+        if (!(p = lock_user_string(arg2)))
+            return -TARGET_EFAULT;
+#if defined(__NR_fchmodat2)
+        ret = get_errno(safe_fchmodat2(arg1, p, arg3, arg4));
+#else
+        /*
+         * fall back to using libc function: this will work for
+         * flag AT_SYMLINK_NOFOLLOW but not AT_EMPTY_PATH.
+         */
+        ret = get_errno(fchmodat(arg1, p, arg3, arg4));
+#endif
+        unlock_user(p, arg2, 0);
+        return ret;
 #endif
     case TARGET_NR_getpriority:
         /* Note that negative values are valid for getpriority, so we must
-- 
2.43.0


