Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0ABC83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 11:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZpUy-0004nW-D6; Thu, 10 Jul 2025 07:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZpUw-0004Jv-D2
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 07:31:30 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZpUu-0005Hp-4N
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 07:31:30 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a54690d369so886277f8f.3
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 04:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752147085; x=1752751885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lDJ2vIkPhvwM5DiRQNz5jjkVQ813bG8xx9tfM2SSO8c=;
 b=hYFMJGhzKLdYAxhkzjKJkLNDMRNvxS39Kl6rE0IB7Wd1fAP/yzRptwHmJp8Ev4lIlW
 6Uyky3du79BQdmA1ZrcTPZZFKAVqGwLqsFPeRrPwKKxaEj6oqxh2evRObc1o/tEEVp46
 yhr3C/yJ8nUIYEpKh37EUSygaddDUSF0KloWYrrbRYHv7OmK6sMJYeWq1DEHQd6Yqb9y
 j5f6HNbUUgOuMNoOu4/LK9hmyLTB4CRw+y/ddNxy7zHtZrQpkNsU1u7Q0sG3rIemL+Ke
 Y8x2pEiB6NJswozpyEfqG0l7vb3EdelSOGzCl5Ze97NbkDpkEroDtcgJ6cNzNegRVmiQ
 UFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752147085; x=1752751885;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lDJ2vIkPhvwM5DiRQNz5jjkVQ813bG8xx9tfM2SSO8c=;
 b=oqztZsxnF0Xd8X89PacBsrBAmoJHYTktkxZD/Y8feOlbGNPVK9qleaW2dM2MnoHgt2
 PDFvePSI/m7mp44oO7k4C1AXeuvfUTxBD0m1hXDf649FjurID/Limr4WcufTlSXQUkYM
 W0xAZzOyS8ASdZa23gTz8JHOn9Fv+Exi4mf+yrOivkM9uJlLwp85uu9iDBwp8k+apJI/
 7XThOVC5rD2/VS8At3D5zUTOBOt+kDjmxyDqkZubCxHJV6FmxzWIKW1/5FqUJM5Y/lAF
 2oNjaDr11O48MaHBB+rtq2p8AnRCzPgCrZlgtjQGMH7mVe9087ZbFqcvTZbQVQLS/oT7
 FXSw==
X-Gm-Message-State: AOJu0Yxv+9RcgPsD3wlFdRk6TEm+lMFDI5ijUsUywEglhpcey33kF0J5
 dyI4pV+j8TxgtQmLvly4sD2mWyPkdPfvz/6D2D1zKFBbZtPiwLLef+L9bMVInECVM4ts1ASydGE
 W4cTu
X-Gm-Gg: ASbGncveZoUhtqkHJlALHqbEWN+8f0QTc+BQYdtnhawFz0btn2p0wjQ+X3SHxy1kpIi
 41OgUb4tgS23Q6lOfdAKcgX+f6cBa9fv3TtmK0sMVqgJUeYheserqsklUQMxRFIB4tNvzgs0rLN
 +zr/Tk/Y7vddoSzMyZz6nJFjiXOmysLPNHzM8kSOCuTVcoV101/NCzAa/Ox1E/dMxsD3L6znWkZ
 HlgS1cpLLsADFniTIO7DhtcVrptPf5ZhwYzOYWUf5fjk9xjvlfl3aqrjSv0uKbxVnXzEr5L7hvP
 Em90bIyHZd/rljIPesCXui+Xj+uxj1BEC2LhCbtfwmGI5coa49jVTZa1+Fo5iuD4oRf7
X-Google-Smtp-Source: AGHT+IFmBmAjMZVsA7CQSA/Qtm2zH2jFe2gzq3jIxzdEAMYUIEPtxLXejQtuq0Jj1LVxjKC6DBOkGQ==
X-Received: by 2002:a05:6000:290b:b0:3b5:e077:af24 with SMTP id
 ffacd0b85a97d-3b5e866f3b6mr2218812f8f.14.1752147085475; 
 Thu, 10 Jul 2025 04:31:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d289sm1638405f8f.55.2025.07.10.04.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 04:31:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] linux-user: Implement fchmodat2 syscall
Date: Thu, 10 Jul 2025 12:31:23 +0100
Message-ID: <20250710113123.1109461-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

The fchmodat2 syscall is new from Linux 6.6; it is like the
existing fchmodat syscall except that it takes a flags parameter.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
v1->v2: don't bother with trying to fall back to libc fchmodat();
add missing braces for if()
---
 linux-user/syscall.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index fc37028597c..e1b1476936c 100644
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


