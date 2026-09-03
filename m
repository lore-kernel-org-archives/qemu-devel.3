Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD5EC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 04:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1zLl-0002ri-AV; Thu, 03 Sep 2026 00:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1x1zLj-0002r0-Ht
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 00:46:55 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1x1zLh-0006Wm-7N
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 00:46:55 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2d9db539a54so17432275ad.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 21:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788410811; x=1789015611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rQsPzQa7eqpjkTonKJlYkpSnhYjMbhwY9QKZd7KCfos=;
 b=jJZ/9K/HifO+Wkszn8EJSp26yLvRm9h8AIBpUASlHuVCyMhDlhX56p3Qf+YM4n+1y6
 g0UQGJp73qZm+eXJWPbkXnlE/md3io6QQAzmLY/0B+srDsnotAStWI+meB9+l/v1UmOr
 na1PmOhQI//gUbfE1SwlCu2jvJPGPG6KG1neh3E/7sE666RcmyXx67J2VgvK8Cc0G5a5
 e1fBIq3kOjxc5D8fER3lIrf15YumyouB7qnvcPQa8+1zTy79Y9GNzjHwoahEIzLsXp5Q
 kjVK0TJaeBQEEEm9CGH3DEepwRujc9phUuiJp65U5yiGhQ7UW7jN7pV6SMxz4GTtzKQ3
 qA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788410811; x=1789015611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rQsPzQa7eqpjkTonKJlYkpSnhYjMbhwY9QKZd7KCfos=;
 b=OkBoDf3Uvhhn8MNvI41k0BaTRbwvRR9xrlv5PuGTV79VJZmRnsZi9vb4rqUyBn9oUS
 MuZhVU9YZpRxgRV8sL1MY8xXTQNPi8QQcaF5Wf0nLz16fIerR+2aFHrurfWgyJUej8u4
 3PqoeDprT46bemrlFRbzt4j6i1Gbx6jgGsmdzTvpLNkYGthDiNL7OlPU5NoYFvcC5bpa
 kXmk0OfAUr0QbZoW7v1Uy/VHPe1ISeZhNePsZzB4qMMZYvNQ9yVj1u6EswjHhER0zPxp
 933yW3SWQhvKbjg3lLe7Odw61FpBbNr7+JPlcpQHKjWYg3Fzlzo3lcO2m4haPKFEqzLx
 aA9w==
X-Gm-Message-State: AFuF++kkGWJpRzHPaJNuzl0gxSrHzL1RMbZHqtYdAVLP97FK78CKXGJ+
 j4h1o1hMmbqG9Hnvscu0Ijpo5Z4uQMLi4EtPTwoMwS6Asi3oRLPWGjmI3tgTJhYH
X-Gm-Gg: AYBFou1OOxqJNsImuqC63XfOg8o1+x66Ha87GQBDwSwAaZNkkgc0uzASGRCPBzZn76m
 PNzE8uttHzgs4jkGQfgOHlbHCiJKUoZOPwxzrZOtp7aWekGUzp+kcAKrmp3/huWV2+iGf4YlE8u
 D8Wj8aZjYgD4ISw3ySpjkgItO00b8T7ngJjA42uoYjk4y7fJKj2FErXXmZ2uGaCh0Ath4zYRb08
 E/QsZzWciKmt909Phl+xorx2qNjTzKoAJD8daiM8LiiDzg08wlqm9c+ed3OC5wjHW7NsRZIiRF9
 7/n0LpCaPbENCEjThYb/wzffEN2T+GIuiOpQjESQ9/FKVMO01CUkf94CNL7veVCY99n2rXeLS+1
 R60vEzIm1anhsodv4ahEStutqpw/bdx94WvlRr6muUKSm1kmXFPXHV/gj0WpnvV0ha0PXT3do+n
 HcqXOQtaNBR+0LiEGJQTrmmIMOeTqpGxLbV5aEIUsDsWKNHZ2C6d8GHVMDSWcsFOk+SA6HpafiB
 suKk7t5LIhEsY70+A==
X-Received: by 2002:a17:90b:1dd1:b0:398:a486:81ec with SMTP id
 98e67ed59e1d1-39aedf5b05fmr16960751a91.11.1788410811114; 
 Wed, 02 Sep 2026 21:46:51 -0700 (PDT)
Received: from localhost.localdomain ([76.133.142.170])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1431994db8csm2337726c88.9.2026.09.02.21.46.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Sep 2026 21:46:50 -0700 (PDT)
From: 54weasels <54weasels@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	balaton@eik.bme.hu,
	54weasels <54weasels@gmail.com>
Subject: [PATCH v5 5/6] target/m68k: Implement custom MMU intercept hook
Date: Wed,  2 Sep 2026 21:45:18 -0700
Message-ID: <20260903044626.24453-6-54weasels@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260903044626.24453-1-54weasels@gmail.com>
References: <20260903044626.24453-1-54weasels@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=54weasels@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Why this change is made & How it will be used:
Boards like the Sun-3 use an external custom MMU logic array rather than the standard 68851/68030 embedded MMU. This patch introduces a `custom_mmu_get_physical_address` opaque hook, allowing board initialization code to intercept TLB fills and delegate translation directly to the machine's external MMU implementation.

Impact on existing functionality:
Zero impact on existing boards. If the hook is not explicitly registered by the board initialization code, the standard 68k MMU translation pipeline executes normally.

Signed-off-by: 54weasels <54weasels@gmail.com>
---
 target/m68k/cpu.h    |  7 ++++
 target/m68k/helper.c | 89 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index aadaea770a..b850997a00 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -156,6 +156,13 @@ typedef struct CPUArchState {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
+    /* Custom MMU intercept logic, if any (e.g. for Sun-3) */
+    void *custom_mmu_opaque;
+    int (*custom_mmu_get_physical_address)(void *env, hwaddr *physical,
+                                           int *prot, vaddr address,
+                                           int access_type,
+                                           hwaddr *page_size);
+
     /* Fields from here on are preserved across CPU reset. */
     uint64_t features;
 } CPUM68KState;
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index f3ee95441a..1eef6dcaaf 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -920,6 +920,21 @@ hwaddr m68k_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
     int access_type;
     target_ulong page_size;
 
+    access_type = ACCESS_DATA | ACCESS_DEBUG;
+    if (env->sr & SR_S) {
+        access_type |= ACCESS_SUPER;
+    }
+
+    if (env->custom_mmu_get_physical_address) {
+        hwaddr custom_page_size;
+        if (env->custom_mmu_get_physical_address(env, &phys_addr, &prot, addr,
+                                                 access_type,
+                                                 &custom_page_size) == 0) {
+            return phys_addr;
+        }
+        return -1;
+    }
+
     if ((env->mmu.tcr & M68K_TCR_ENABLED) == 0) {
         /* MMU disabled */
         return addr;
@@ -1001,6 +1016,80 @@ bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         }
     }
 
+    if (env->custom_mmu_get_physical_address) {
+        hwaddr custom_page_size;
+
+        /* Delegate translation to external board-specific MMU if registered */
+        ret = env->custom_mmu_get_physical_address(env, &physical, &prot,
+                                                   address, access_type,
+                                                   &custom_page_size);
+
+        if (likely(ret == 0)) {
+            tlb_set_page(cs, address & TARGET_PAGE_MASK,
+                         physical & TARGET_PAGE_MASK, prot,
+                         mmu_idx, custom_page_size);
+            return true;
+        }
+
+        if (probe) {
+            return false;
+        }
+
+        /* page fault */
+        cs->exception_index = EXCP_ACCESS;
+        env->mmu.ar = address;
+
+        if (m68k_feature(env, M68K_FEATURE_M68040)) {
+            env->mmu.ssw = M68K_ATC_040;
+            switch (size) {
+            case 1:
+                env->mmu.ssw |= M68K_BA_SIZE_BYTE;
+                break;
+            case 2:
+                env->mmu.ssw |= M68K_BA_SIZE_WORD;
+                break;
+            case 4:
+                env->mmu.ssw |= M68K_BA_SIZE_LONG;
+                break;
+            }
+            env->mmu.ssw |= M68K_TM_040_DATA;
+        } else {
+            /* M68020/030 Special Status Word (SSW) */
+            uint16_t ssw = 0x0100; /* DF - Data Fault */
+            switch (size) {
+            case 1:
+                ssw |= 0x0010;
+                break;
+            case 2:
+                ssw |= 0x0020;
+                break;
+            case 3:
+                ssw |= 0x0030;
+                break;
+            case 4:
+                ssw |= 0x0000;
+                break;
+            }
+            if (qemu_access_type != MMU_DATA_STORE) {
+                ssw |= 0x0040; /* RW - Read */
+            }
+            /* Function Code */
+            uint8_t fc;
+            if (mmu_idx >= MMU_MOVES_FC_BASE) {
+                fc = mmu_idx - MMU_MOVES_FC_BASE;
+            } else {
+                if (mmu_idx == MMU_KERNEL_IDX) {
+                    fc = (qemu_access_type == MMU_INST_FETCH) ? 6 : 5;
+                } else {
+                    fc = (qemu_access_type == MMU_INST_FETCH) ? 2 : 1;
+                }
+            }
+            ssw |= (fc & 7);
+            env->mmu.ssw = ssw;
+        }
+        cpu_loop_exit_restore(cs, retaddr);
+    }
+
     if ((env->mmu.tcr & M68K_TCR_ENABLED) == 0) {
         /* MMU disabled */
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
-- 
2.50.1 (Apple Git-155)


