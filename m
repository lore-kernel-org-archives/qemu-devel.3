Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B50CA1002
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 05:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uulKj-0000Yc-3T; Sat, 06 Sep 2025 01:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uulKA-0000Ma-JJ
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 01:18:54 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uulJt-0006or-1q
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 01:18:54 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45dde0c8254so2216055e9.3
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 22:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757135908; x=1757740708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tqfT+leZhy7Rg922mo2u8oPpLUYve9eJPBZJd2GWVis=;
 b=jFhYFvACYCZfmV3WR9gETNsHqGQQGD0iRt0GKkZZa+SRd6sIuKbSYXl1qyg66aK+pK
 gkTNIxATeWmVvb0oV08PA5hIvBUwsc3qTTpqJWdfppeuaAxc5WGawvu9hpydAdj1F9a7
 G5+AZlVEZeJW3G4fpkkMIswgxCcrtOxfvw086KUA/M9dGIcX88kI8YESCii+sJ9tICc9
 wfyCKUI/vpwTKZXaodznQlF8VAB7eQhuTSc/G/eA3GOUIwLUDYagadGbVwrDBFdjF1Ug
 2VNF/w+7SR7ERlvWagPfzHO1tnCgQlqKjyFNAQP8805mwqV+uqbj2ilQkfHqz8jf5Jf6
 erFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757135908; x=1757740708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tqfT+leZhy7Rg922mo2u8oPpLUYve9eJPBZJd2GWVis=;
 b=ZcDQ+v6PU/xG67IarLIDwJ47TBHk4U7h7irPYZhLGIiHGGDDVIk61Wpc+jA8iJ1KeN
 qh1FwmMXBhy0YzVl99wfezHrWwIwWdukUOWnknIxSpyTwBgL3k8hRpxJ32kT0HCQA/9Z
 wZFlpbAcvwV+ZwJyT8f/ebwS8Rgva2HdoIaHvqCbU2xyuW5wHRaggsnJiREHtiNizB4W
 ug4fyr9YhPIDLpBE7NDuYmjZ6NXjR3scylLLo+/GcRkdy33h8LsiFxpC1Jmfj0k4hSSj
 Cp0C4ar0TzvGF0Mv4s779zFAwyjsfUNa3Pa+/v8UF2D8heVJ/0mIcVPSYRj86szayjBJ
 VFDw==
X-Gm-Message-State: AOJu0Yzl3ItlWCoIA/jAVpcjkYv202slasxqjLkXQsdPAPPvJWhiVXHm
 1tRadnlTq5QvFpgbd8XXV7lncBsV0QzM2s+g7nICbFcizO7exk/2Z+JccHxvflmngz85oqeY/6H
 MEjMerCE=
X-Gm-Gg: ASbGncvVawxz55ZRHjingbsBhVjsECN/qYqrB2pytSv3nxkvbm3kZ3vfiVsGvQR2hEw
 QBx9NdPHznMyDRUESEj/kh7zwjCQJ/rZ6fTlywfKgmamBdZqPMM7Cxp1YSXtTXezKyUT+kHBbTG
 tsDssQrqdBBpmBNjCC7grbylo8567tqAoVZiJLpVw+Z5EO640BAXK78Ce4Bs5/kt0u38H/typvJ
 6Rnkl+S4ACojdgEpKxbFKjcsgTe2I88FDqp/EpZNFT0JPrU71pfWqq2otfrBg5ha/u2gNKWlAEI
 VVYmTdPW+Isn+T8jY/0Yxa/c9ajzEwWKrc9gHqwL/yr9ut9QL9TtUtUKevv3kYaCjppXWuVxJjP
 Cxr4eKXPDdwRHLabyUDK3SnOG7FKD3kl8XCzc+I4Lfr/ArdlEwuS1jcHRxMdAjsg6RNu/t7GkDn
 Rji/jsO8k=
X-Google-Smtp-Source: AGHT+IHn8pbOhFCIcFZb74BzVRbNrrbOOP8PeToenFp90YnkTqJiSML0XxFAWQPjl9Y+qZgU/kvILA==
X-Received: by 2002:a05:600c:6995:b0:45d:ded8:3b6e with SMTP id
 5b1f17b1804b1-45dded83cecmr5669825e9.17.1757135908035; 
 Fri, 05 Sep 2025 22:18:28 -0700 (PDT)
Received: from stoup.21wol.it (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306c22sm441197735e9.13.2025.09.05.22.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 22:18:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	philmd@linaro.org
Subject: [PATCH 07/11] linux-user: Use tb_flush_exclusive to start second
 thread
Date: Sat,  6 Sep 2025 07:18:16 +0200
Message-ID: <20250906051820.160432-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250906051820.160432-1-richard.henderson@linaro.org>
References: <20250906051820.160432-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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

When we start the second thread, we discard all translations
so that we can re-do them with CF_PARALLEL.  Since there is
as yet only one cpu, and we are processing a syscall, there
are no live translation blocks and we have exclusivity.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c    | 4 ++--
 linux-user/syscall.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 002e1e668e..bd2bbaf1f4 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1010,7 +1010,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         CPUState *cpu = thread_cpu;
         if (!tcg_cflags_has(cpu, CF_PARALLEL)) {
             tcg_cflags_set(cpu, CF_PARALLEL);
-            tb_flush(cpu);
+            tb_flush__exclusive();
         }
     }
 
@@ -1450,7 +1450,7 @@ abi_ulong target_shmat(CPUArchState *cpu_env, int shmid,
      */
     if (!tcg_cflags_has(cpu, CF_PARALLEL)) {
         tcg_cflags_set(cpu, CF_PARALLEL);
-        tb_flush(cpu);
+        tb_flush__exclusive();
     }
 
     if (qemu_loglevel_mask(CPU_LOG_PAGE)) {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 91360a072c..d9c394856f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6633,7 +6633,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
          */
         if (!tcg_cflags_has(cpu, CF_PARALLEL)) {
             tcg_cflags_set(cpu, CF_PARALLEL);
-            tb_flush(cpu);
+            tb_flush__exclusive();
         }
 
         /* we create a new CPU instance. */
-- 
2.43.0


