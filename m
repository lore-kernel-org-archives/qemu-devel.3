Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C284FCD1296
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt7t-0001xI-LQ; Mon, 08 Apr 2024 13:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt7k-0001v3-Pk
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:49:45 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt7g-0003bs-6s
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:49:38 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-53fa455cd94so3615622a12.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598575; x=1713203375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xtbJ/p7JEFHTppWK8T4w7KJEZi+x0bHxbuO/ApHynWI=;
 b=zZ6zZYb2Er4ofVDVLCqamUJHoZhEB1rOi5Gj/nvgfpMXZlT1rnozsXnQhoBJKr6lqc
 dl2PF/6O4S7TgrqBIXJTyQpXid792IkJkR9n/BjmUcXB54A5h/srCs5VxXkWmyrEo/w/
 r1wcNd7YTNug8fm3aNaPgey9XA9cZO5LFLz5VMAaxWWmCnxrbXfKKpoBnzroz9peYF+l
 etSnzOcbAoXUtX0eD+jLHOz6hRk+iJtK6N0a46+VuK5vav8bYP0GdQrZjXD92P7B2Tkh
 OjU2CMugtj6Y7pW1kXs4VYQjVJHA0htjuiqP6zT+JEF61hBl0T/tA4Rt3ulNEdZCPe82
 WOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598575; x=1713203375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xtbJ/p7JEFHTppWK8T4w7KJEZi+x0bHxbuO/ApHynWI=;
 b=vtm+QEkZgBORIaacvtpYCL6LZ+Vh7vvAEHIehwlq/CGaiCNvIza99R4Kr2jknSGHTx
 NvbuJB6NwPUqtUxf1/nDbMsvLuG4AKdGQU7HDN+MCVxtk18AhGBLIHrggZb2mK80+Km/
 YBGAHMNXX/R3zZf9CHcQjhXFlJFpiE6NBbAc+In5KQyMElpsAiajz/tni4I/YpumpT2l
 Mu86Aa/zrobm2wT7YoS/Hn6C3MubrbxvbL+iLNGwtq38dMaJeH4nIGP8czsmbn1/X5o0
 mhypxpNIe9RO8g2RZNrqGRTpl2Ra+CxI3XepbkUsHtH2dwuSYp2G+ACv2foYiMe965HB
 yjOg==
X-Gm-Message-State: AOJu0YzeRy7eHnKGxx2i9vzG7ORjd40Eldr+lE8hnO2DnAfBy56Vsbd3
 sgDKegV21SBIu7pMDb82Vr5psDoAkLceREUGIM0p7g7DvOR68d+Lk6I/FtYmBU8WVuQAZLbLks/
 K
X-Google-Smtp-Source: AGHT+IGHicWknxCBzPhfCPBG8RpqA30tSZsp7vVMT9Dm1ESyfMUt9EdPgxBRVs8UntkxrLurT43XuA==
X-Received: by 2002:a05:6a20:100d:b0:1a3:c3e0:51bc with SMTP id
 gs13-20020a056a20100d00b001a3c3e051bcmr7070227pzc.56.1712598574779; 
 Mon, 08 Apr 2024 10:49:34 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.49.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:49:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/35] linux-user: Fix waitid return of siginfo_t and rusage
Date: Mon,  8 Apr 2024 07:48:56 -1000
Message-Id: <20240408174929.862917-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
References: <20240408174929.862917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

The copy back to siginfo_t should be conditional only on arg3,
not the specific values that might have been written.
The copy back to rusage was missing entirely.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2262
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e12d969c2e..3df2b94d9a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9272,14 +9272,24 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_waitid
     case TARGET_NR_waitid:
         {
+            struct rusage ru;
             siginfo_t info;
-            info.si_pid = 0;
-            ret = get_errno(safe_waitid(arg1, arg2, &info, arg4, NULL));
-            if (!is_error(ret) && arg3 && info.si_pid != 0) {
-                if (!(p = lock_user(VERIFY_WRITE, arg3, sizeof(target_siginfo_t), 0)))
+
+            ret = get_errno(safe_waitid(arg1, arg2, (arg3 ? &info : NULL),
+                                        arg4, (arg5 ? &ru : NULL)));
+            if (!is_error(ret)) {
+                if (arg3) {
+                    p = lock_user(VERIFY_WRITE, arg3,
+                                  sizeof(target_siginfo_t), 0);
+                    if (!p) {
+                        return -TARGET_EFAULT;
+                    }
+                    host_to_target_siginfo(p, &info);
+                    unlock_user(p, arg3, sizeof(target_siginfo_t));
+                }
+                if (arg5 && host_to_target_rusage(arg5, &ru)) {
                     return -TARGET_EFAULT;
-                host_to_target_siginfo(p, &info);
-                unlock_user(p, arg3, sizeof(target_siginfo_t));
+                }
             }
         }
         return ret;
-- 
2.34.1


