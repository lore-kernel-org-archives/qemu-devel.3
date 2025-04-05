Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30A3C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 15:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u15na-0006CW-Gz; Sat, 05 Apr 2025 11:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u15nQ-0006AG-T3
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 11:51:01 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u15nP-0002gL-82
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 11:51:00 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-736b34a71a1so3668538b3a.0
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 08:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743868258; x=1744473058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vpl2ab9dTaditwWj6WYvgHB9ekBgYkRpHOJXzTSaFrI=;
 b=pBe50kVCS4EbJZ7ZvBFjSNDOHbdAYqTyWoWRhp9jlAr1yf7ifXwcL1VvYZ8dg0RDqL
 xS51nW+HSFF3AKMEuGOV5H5oLyl8B+A2fcvN79DaKkqmI0Q4s2s9IQjos4724O51ybHn
 p7EXwXeiriHRb/LykAW6dR2BsdB9zMeKn07FQVYoiKekNu6AnM9mDxrAhqq4isl77sqB
 nybBMHINLsFSyjOsauEzxVuaeGykEf1PTBq+noWLAxNflb8WEo3h2dS6ZG3LV3tpUqWv
 JVSWyAMxq99uUmMsg+rXmiG2NN7cIGC5u3bp+8nElUgZLfPqCNrOlUT0aDFoNJ43xcu8
 TNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743868258; x=1744473058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vpl2ab9dTaditwWj6WYvgHB9ekBgYkRpHOJXzTSaFrI=;
 b=J8fUcgfoa2rICv3xfFuOG6yVyVrbOA8IlaPXVq6A1F0WAYkdeWCDK8PdvVNbP1KL9L
 Jix3QS+toRBri2vGFuU00SDi5YyHqmGvK18ooUHkLNzttPBnDuvjxvxuEbFNmN7ukwbO
 lrF+ME02CGi3xsB0OV31Kk9GkK1qpCMJ9tEQ2tM+2xQhqU8bMN4g+Mh1w4AGQxrQwH3/
 dh3z3t3gaQnaaafr9iXAtujYzXZP1PNAig327qe/doUQ/eRHUe8uptRNlJHLeE9x3ori
 yQFoVAx3l/WfGUyd06PgliNOa72rwAtaTx67ELtTFT5ArC3sbkrFmh9YlcWKT8USZg6u
 ps+g==
X-Gm-Message-State: AOJu0Yy10nBQ227dpIlCYPlNaMtw2k/VN5PyY0R8CH9S8i/DkUeJ5rTK
 QmDQgyTQbSJU1U5gi7lVl2aeYbGEQWQEGed304ZUqTDbfYEJnzLQodJ+84hNy/V5cZ9B4/uMGus
 H
X-Gm-Gg: ASbGncu5oJ734DB7KtK0IdmWAw/2ihSWFP2Wl1XX74l4cVEs5T+LJGlkFe8Z0qksr1g
 Kg60A9+Uao3856uwmI8u/ZBqaLnU778dLZBzT18jp+ceQebDBpLcxFyPr7HrC3sUl1S2ZC58ROj
 IwgDi5HRBfPck0AnbPCdxoWIfShP94eFcjO1ZojxPpyNnZIJVacb4m38fK4qsqRJcTd9cWWppML
 K3GanI0tCKwfvkZNgp1TEbqyeHA95Q6CAmcnpmuy81aavVbmjwmMmyk3pB7Y/RCXPQseP/lhv3q
 rBq7+CqOwb3bX1Jv2cQVweyoc0Qf5+McYyyStNg16yUbrYkFfTw3
X-Google-Smtp-Source: AGHT+IFQOIhyeoMzNptn5MLTrWoVSvpB0CY7hetS8N+YGJyTd5DqJmujj0Fi1A7zS3gkG5VjzmaiFQ==
X-Received: by 2002:a05:6a00:398f:b0:730:9752:d02a with SMTP id
 d2e1a72fcca58-739e48cefc2mr10706367b3a.4.1743868257766; 
 Sat, 05 Apr 2025 08:50:57 -0700 (PDT)
Received: from stoup.. ([173.164.107.234]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739da0b4851sm5554790b3a.146.2025.04.05.08.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 08:50:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 2/3] accel/tcg: Add CPUState argument to
 tb_invalidate_phys_page_unwind
Date: Sat,  5 Apr 2025 08:50:52 -0700
Message-ID: <20250405155054.967307-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250405155054.967307-1-richard.henderson@linaro.org>
References: <20250405155054.967307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Replace existing usage of current_cpu.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-internal.h | 3 ++-
 accel/tcg/tb-maint.c    | 8 ++++----
 accel/tcg/user-exec.c   | 5 +++--
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/tb-internal.h b/accel/tcg/tb-internal.h
index 08538e2896..1078de6c99 100644
--- a/accel/tcg/tb-internal.h
+++ b/accel/tcg/tb-internal.h
@@ -50,6 +50,7 @@ void tb_invalidate_phys_range_fast(ram_addr_t ram_addr,
                                    uintptr_t retaddr);
 #endif /* CONFIG_SOFTMMU */
 
-bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc);
+bool tb_invalidate_phys_page_unwind(CPUState *cpu, tb_page_addr_t addr,
+                                    uintptr_t pc);
 
 #endif
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index d479f53ae0..714dcaedc9 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -1045,7 +1045,8 @@ static void tb_invalidate_phys_page(tb_page_addr_t addr)
  * TB (because it was modified by this store and the guest CPU has
  * precise-SMC semantics).
  */
-bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc)
+bool tb_invalidate_phys_page_unwind(CPUState *cpu, tb_page_addr_t addr,
+                                    uintptr_t pc)
 {
     TranslationBlock *current_tb;
     bool current_tb_modified;
@@ -1083,15 +1084,14 @@ bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc)
              * the CPU state.
              */
             current_tb_modified = true;
-            cpu_restore_state_from_tb(current_cpu, current_tb, pc);
+            cpu_restore_state_from_tb(cpu, current_tb, pc);
         }
         tb_phys_invalidate__locked(tb);
     }
 
     if (current_tb_modified) {
         /* Force execution of one insn next time.  */
-        CPUState *cpu = current_cpu;
-        cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(current_cpu);
+        cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(cpu);
         return true;
     }
     return false;
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 90b345a0cf..39b76d9654 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -749,7 +749,8 @@ int page_unprotect(CPUState *cpu, tb_page_addr_t address, uintptr_t pc)
             len = TARGET_PAGE_SIZE;
             prot = p->flags | PAGE_WRITE;
             pageflags_set_clear(start, start + len - 1, PAGE_WRITE, 0);
-            current_tb_invalidated = tb_invalidate_phys_page_unwind(start, pc);
+            current_tb_invalidated =
+                tb_invalidate_phys_page_unwind(cpu, start, pc);
         } else {
             start = address & -host_page_size;
             len = host_page_size;
@@ -772,7 +773,7 @@ int page_unprotect(CPUState *cpu, tb_page_addr_t address, uintptr_t pc)
                  * the corresponding translated code.
                  */
                 current_tb_invalidated |=
-                    tb_invalidate_phys_page_unwind(addr, pc);
+                    tb_invalidate_phys_page_unwind(cpu, addr, pc);
             }
         }
         if (prot & PAGE_EXEC) {
-- 
2.43.0


