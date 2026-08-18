Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C03C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 02:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww9U1-0007Vz-C5; Mon, 17 Aug 2026 22:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1ww9Tz-0007VD-Gf
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 22:23:19 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1ww9Tx-0008LW-CZ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 22:23:19 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso6005381a91.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 19:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787019794; x=1787624594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JkyOCPkyAxST0wESByKfCzgjt9wC3k6oCK82FLVpN/s=;
 b=PBTEZ/4x5AIcFbz4wi7doXHXrW1u4U4K9AvYzW/yX8o+xZstKl9F37JobXlvdf970z
 QJM0nMmlclKpGan6SmZOmhkiXUDyd02l1rxcmQYw24bsAmVLJQFxkg3HWQeQb3TUqfXO
 Q7yNxcXDxurAYfTg/aMZWPer/91ffGWPqHjS3Lo/oMEeh79cIrz64qkU1a2sMZAacQCn
 rcNUsYYLUvQqprhkc0t0x6goL5D7vmlv22ukZTJHzGSEfnV+D1e9MAA1B6mQtbURPmoZ
 JVbZFJCZ1saJsBkMiSzBn/fl/hslXOfsvDOipA4vY/xjQ5CcqSI+3gCG7DbXkgWsgriM
 tlkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787019794; x=1787624594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JkyOCPkyAxST0wESByKfCzgjt9wC3k6oCK82FLVpN/s=;
 b=NkDAQl3K4Qbvm8OQXZzrWn4n4vLd4yTcwQWm03TfVNCwPY4vLPk434ER8o5RgbcElx
 wNhLYuPz+7YyfUJJMIK0F522D6BcBNWQ5j4CcP2zXCREXGcWBI8/tCU5QXA6sQOQby1Y
 vU6PzSTaZFuGJhcESXD71dnDgISebwHlzOrRATo9czFGHO3hT56tw2Q11XxvfIitjgwD
 9GrzHi+cgUt2JNEcIO6AHKa2VNMzMloQ/BfZSGhgUaD5RnK3ehF7la/S6UsERuiNMo2p
 O6LIyfGHE5+BV5c4wCX4dglTZB7DsYDf7hQJyCW3B8iq99iJbL9lN1ED2+W+XicAuRnG
 X1+A==
X-Gm-Message-State: AOJu0Ywvctv2x8EEsvhDKaN7lnwoAHtXmaBfy7u3Httz7dEA8AKPmzR7
 pwOKAiKJpa0LfmYiTRP+E4tTEDkAQfC4a2Vh/xCXV5wuIovqZab50qk/O5ZxMw==
X-Gm-Gg: AR+sD12aUVPMnrAbSWfLZSJDRPempCp/jeD4+Ii4hhHCCpsam0Eq2MWx9Axk43bK0ww
 bX43VRX8RvURoMclUY2MbTzq/UqUuunBMfWpXPuV/WUoIlfB5bhNWmQ+SHfh8zuknBAMPK/5VbC
 nJ8fhnbdJTDY/9Ba5HlTB42C+t8M0xgjJlq1x9/YUN3LCSZy6faXk0Z/efFTR4o1rIpFtl+9g1M
 FchhUE0EzfhVqXahCi9YtvaR60cGf+mrr8RAvKCyKp2JeShsseHLQXKglyYRuYCaiZlTu3GQjpl
 nvq/shpqF9r76i+7XodoVi9EW5krVsTSxxTKrC09sffvMj5kuFPevAb5XYz6hyuALJhURFq/Woj
 RUQLu5tpUdAwXcmfliMOv4SyOciGiOtKhI+WhAKS2q0NvZN1t9Eo2HWjqqIgtPRAaPgv5hpOkSV
 ZIWel51gEchfnhn6euK31J730ZljclNWFXDrjnMIe/W7mXTfj3cKKdmEEHVKz13QHtiN0VHe3IE
 Ezm
X-Received: by 2002:a17:90a:38a1:b0:395:543a:cf3b with SMTP id
 98e67ed59e1d1-395543ad373mr5859668a91.2.1787019793766; 
 Mon, 17 Aug 2026 19:23:13 -0700 (PDT)
Received: from newsled.lan ([76.133.142.170]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c389363sm10897816eec.23.2026.08.17.19.23.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Aug 2026 19:23:13 -0700 (PDT)
From: 54weasels <54weasels@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	54weasels <54weasels@gmail.com>
Subject: [PATCH v4 5/6] target/m68k: Implement custom MMU intercept hook
Date: Mon, 17 Aug 2026 19:22:21 -0700
Message-ID: <20260818022225.31801-6-54weasels@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260818022225.31801-1-54weasels@gmail.com>
References: <20260818022225.31801-1-54weasels@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=54weasels@gmail.com; helo=mail-pj1-x1033.google.com
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

High level description:
Boards like the Sun-3 use an external custom MMU logic array rather than the standard 68851/68030 embedded MMU. This patch introduces a `custom_mmu_get_physical_address` opaque hook, allowing board initialization code to intercept TLB fills and delegate translation directly to the machine's external MMU implementation.

Impact on existing functionality:
Zero impact on existing boards. If the hook is not explicitly registered by the board initialization code, the standard 68k MMU translation pipeline executes normally.

Context: This patch was originally submitted as part of the monolithic Sun-3 Machine Emulation series (https://patchew.org/QEMU/20260503015756.99176-1-54weasels@gmail.com/) and has been split into atomic components.
---
 target/m68k/cpu.h    |  7 ++++
 target/m68k/helper.c | 89 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 42d34502fc..d4ecb1c3ef 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -153,6 +153,13 @@ typedef struct CPUArchState {
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


