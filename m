Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C2CC83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 17:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaHSj-0001jR-48; Fri, 11 Jul 2025 13:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaHSh-0001h4-Dq
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 13:23:03 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaHSf-0002zp-L2
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 13:23:03 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-40a6692b75cso1515176b6e.1
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 10:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752254580; x=1752859380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6qpBCj8B3P31E5+6mdM0X+L5puDyaY4r0XRv24VE9kQ=;
 b=gFdtRsZcfqEYuUu9CvxGcWca5w5aVKN/Kk7uVDGiHgxmN09C+iT4YMLkr+n9PkRTbM
 SDVqpIOvFo/AcNRSViETzZ5dX6rwOjWujXYWB0msi7fab6CZr+MfK0XECDME8JlaJJdX
 sI1RkccnzxHx+fDQOqA3xu7/cVDt46mz5+jGFh2gU2k1kgpqs03ykHv5MtHJEq50ML41
 vSoIhZEX5Kso1BLpEudV/1dtAWWiiL8EVA1iHMSU5h7n+NJwylvhq+ilv9MRivxPi3ma
 t71asZcxHw5LKVvHQFO+9mXgY5ANBx/ppHIa08/lHg5+kW86tUmoX+DG+vntYiTKkzvv
 OsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752254580; x=1752859380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6qpBCj8B3P31E5+6mdM0X+L5puDyaY4r0XRv24VE9kQ=;
 b=kUnwWOJh6khNe7Qu9HE5l5e4ARDPaQ4v1VT4iSI7iBH+Lc4s73dJA6ujeYW9M/fxRF
 jDMr78RBWkp2jxR+7OY/Hf1FWKtJfaqyM0HskCmlbZdKHqhHbr1htShd9PyguLNfVZ6Z
 Fy7YAAnWu4vD4czVF7CiuJzLu1fH+UtgrxcmFSM3tjzDE0Wzc8y/gm8lWMWyAGubA9nA
 A1OtKiqQwzo2wlcoYv9pXsoNUBHwtYYa4XUrIQbwvPR5sSScLALPxzJyOb4VyIYbZcZq
 oXW0FPhATyDsEhoxuTC7dsGaeX6CTxc254vx24N98RHIJbpjIxPFMqzS2ljv006bvJC0
 PwOQ==
X-Gm-Message-State: AOJu0YxxJ/OwTrrqFoBADBQ8LftIyy4H17ACWUTSEKC2zptFTEiHz2eL
 QsuW+rSz0RAm2IYE/u4gxzR7mOosBicL7gGVk/sBlb3ukYGlj1y0alqgU9pq8Eq8XGtH+nsZfve
 KgvVJ4V4=
X-Gm-Gg: ASbGnctZhxfL861is7B2fspVMHzHyqf9dhNI93G6WVjM+ByB/2eFwh92SPj7ePVc10b
 xhofBETtiu5aUJZOo869L+yDFZgKa50ju/MrXEQN0Uv7xQ5Qe1TYL/wMKyW0CEls4IS9jjwZBea
 sRWIbJ8ILWPh6DQSnUvytajuk8+w+abBzHSyDWSlG/4hCd0hFmHXy8W54lUuIvhgk5qTWjAL8jT
 gJAOW/58A9sr+sF0hWEJMhnzvnHVwfxAKkQmxQs1hidGef0K3gb0bSyI6Et40CeUJAi91b4ySA3
 qqAVOFbkCRhFOvOUp4XXHk7E05rhYFqy/FEbIuM/DwurCTgpyz0Dk4o+5MQduzeEzPn2FOjCaFZ
 hNcstmbK97KcT1lVbARaIlYGvsu/S3axm0IFxWOtclmSjtxIF8FQGoZ2mmrKB6afR0e3lJYfRR+
 Z6GEu7C/SJbyN/xPglEL0=
X-Google-Smtp-Source: AGHT+IFjzrbmncPLFSof2n6hqBlix3Hxng8UxTF+98oEWqkCL+svbgzX3lMO4hwMKO3iSZbe+Y6KtQ==
X-Received: by 2002:a05:6808:ec3:b0:40b:555b:9a9a with SMTP id
 5614622812f47-4153a27afe3mr2435391b6e.36.1752254580120; 
 Fri, 11 Jul 2025 10:23:00 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4141c77ada0sm602041b6e.44.2025.07.11.10.22.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 10:22:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/9] linux-user: Implement fchmodat2 syscall
Date: Fri, 11 Jul 2025 11:22:47 -0600
Message-ID: <20250711172254.229201-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711172254.229201-1-richard.henderson@linaro.org>
References: <20250711172254.229201-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

The fchmodat2 syscall is new from Linux 6.6; it is like the
existing fchmodat syscall except that it takes a flags parameter.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3019
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250710113123.1109461-1-peter.maydell@linaro.org>
---
 linux-user/syscall.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index fc37028597..e1b1476936 100644
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
@@ -10713,6 +10717,15 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         ret = get_errno(fchmodat(arg1, p, arg3, 0));
         unlock_user(p, arg2, 0);
         return ret;
+#endif
+#if defined(TARGET_NR_fchmodat2) && defined(__NR_fchmodat2)
+    case TARGET_NR_fchmodat2:
+        if (!(p = lock_user_string(arg2))) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(safe_fchmodat2(arg1, p, arg3, arg4));
+        unlock_user(p, arg2, 0);
+        return ret;
 #endif
     case TARGET_NR_getpriority:
         /* Note that negative values are valid for getpriority, so we must
-- 
2.43.0


