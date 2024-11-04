Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27433D11194
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kqC-0001fl-CW; Sun, 03 Nov 2024 19:21:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kqA-0001SQ-B7; Sun, 03 Nov 2024 19:21:06 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kq8-0002et-4k; Sun, 03 Nov 2024 19:21:06 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-720be2b27acso2847190b3a.0; 
 Sun, 03 Nov 2024 16:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679662; x=1731284462; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YtkgHq+h1yz7RdAbxWc78/msbsXSwcz8UPn8XVg1wi0=;
 b=LZYhELycLi7q0FoxIe4zNw9HpL1xZ7FNo0UDQxHQYspa/cemyCvmVvGJa3jd/wp07h
 8tZWsdBIULyQHsIpgsgkxQSvzji2Ax8cE62ktQW8v4gqgL9dpDGnAipbRl5pGCnCYQ2u
 NVlizwPBdxk0I5w6lBj2X3ZXCVHDbGM57cPlYU/irezsF3ieu7PJKBbsBWO19lPjpnO9
 9rUXT8SrRdGd3JjP4lpoyzOQXRwNrMlQNtyOcKuobxLQ3wdsPNeYZNOt7cVU90eS3QLv
 rrCQAjHXeFW7D7My71GoVHmAGQkcCcrZilMdp3dRzrGHZAsUcVqVbSVfTxP4rVZaVber
 tFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679662; x=1731284462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YtkgHq+h1yz7RdAbxWc78/msbsXSwcz8UPn8XVg1wi0=;
 b=luGxfhMxwkmVU/FyRin2vbtAHPN+WnVUmgpPEaT5yCkxOExxDtfAv1s30g4F/sbIDz
 LvLPz7DxdAB6K8A7+z4xenQUX3uylS00TAFKO/C0D3JVzGeqCOUxwspJuWTRy+mBg6Lc
 pGI0MTDnsArBqFuwxpt0Bnan/nAjEvYgoX8+Gb6uaRChT6JrZos0wNHok9xNcDHflRoz
 OdLhY+BXk/1LrYe9kS7hsBuA2xWbk7/FtXtrLlFALCSe804jpuxRtPo6dUcGbzZUtK6B
 NJWF9O2jdLXGYnPkPebSZXM6zk80Vfv43ZIf8W9sxSGEGaYI3TbvWA9P+3x7ErFApAzs
 yNqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDvWJMtj1cQatHJqkFZCAaeawFBYEVjUrOR2hY2LWMmFrVz+eNKlfpgQVDX0QHGIslrvwbiKC99Q==@nongnu.org
X-Gm-Message-State: AOJu0YyTGjsFgukVlrSF9XRYOBd2HeeWQovckFI42dBEi2ZWC9bHxkAT
 6wigt+ZUtldG3aLrlByzUw9jZo4B34gv4NOUiDNftEcjM9jaJ62wE+PAiw==
X-Google-Smtp-Source: AGHT+IHixjsMkSN5IU+VbY2KDjW78W83+IPLtlTw1PL186Zkw+IoiQj0zTyS0MWJXTV8ZMpC/WDaZg==
X-Received: by 2002:a05:6a20:1589:b0:1db:de38:294b with SMTP id
 adf61e73a8af0-1dbde38296amr1542248637.38.1730679662028; 
 Sun, 03 Nov 2024 16:21:02 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:21:01 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [PULL 30/67] target/ppc: Reduce code duplication across Power9/10
 init code
Date: Mon,  4 Nov 2024 10:18:19 +1000
Message-ID: <20241104001900.682660-31-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

Power9/10 initialization code consists of a lot of logical OR of
various flag bits as supported by respective Power platform during its
initialization, most of which is duplicated and only selected bits are
added or removed as needed with each new platform support being added.
Remove the duplicate code and share using common macros.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
[adityag: renamed many POWERPC_* flags to PPC_* flags, checkpatch fixes]
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Tested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 124 +++++-------------------------------------
 target/ppc/cpu_init.h |  84 ++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+), 109 deletions(-)
 create mode 100644 target/ppc/cpu_init.h

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 011e53d961..7c3716b56f 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -52,6 +52,7 @@
 #include "kvm_ppc.h"
 #endif
 
+#include "cpu_init.h"
 /* #define PPC_DEBUG_SPR */
 /* #define USE_APPLE_GDB */
 
@@ -6510,58 +6511,15 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
     dc->fw_name = "PowerPC,POWER9";
     dc->desc = "POWER9";
     pcc->pvr_match = ppc_pvr_match_power9;
-    pcc->pcr_mask = PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_07;
-    pcc->pcr_supported = PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 |
-                         PCR_COMPAT_2_05;
+    pcc->pcr_mask = PPC_PCR_MASK_POWER9;
+    pcc->pcr_supported = PPC_PCR_SUPPORTED_POWER9;
     pcc->init_proc = init_proc_POWER9;
     pcc->check_pow = check_pow_nocheck;
     pcc->check_attn = check_attn_hid0_power9;
-    pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |
-                       PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
-                       PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
-                       PPC_FLOAT_FRSQRTES |
-                       PPC_FLOAT_STFIWX |
-                       PPC_FLOAT_EXT |
-                       PPC_CACHE | PPC_CACHE_ICBI | PPC_CACHE_DCBZ |
-                       PPC_MEM_SYNC | PPC_MEM_EIEIO |
-                       PPC_MEM_TLBIE | PPC_MEM_TLBSYNC |
-                       PPC_64B | PPC_64H | PPC_64BX | PPC_ALTIVEC |
-                       PPC_SEGMENT_64B | PPC_SLBI |
-                       PPC_POPCNTB | PPC_POPCNTWD |
-                       PPC_CILDST;
-    pcc->insns_flags2 = PPC2_VSX | PPC2_VSX207 | PPC2_DFP | PPC2_DBRX |
-                        PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 |
-                        PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206 |
-                        PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |
-                        PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
-                        PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
-                        PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL | PPC2_MEM_LWSYNC |
-                        PPC2_BCDA_ISA206;
-    pcc->msr_mask = (1ull << MSR_SF) |
-                    (1ull << MSR_HV) |
-                    (1ull << MSR_TM) |
-                    (1ull << MSR_VR) |
-                    (1ull << MSR_VSX) |
-                    (1ull << MSR_EE) |
-                    (1ull << MSR_PR) |
-                    (1ull << MSR_FP) |
-                    (1ull << MSR_ME) |
-                    (1ull << MSR_FE0) |
-                    (1ull << MSR_SE) |
-                    (1ull << MSR_DE) |
-                    (1ull << MSR_FE1) |
-                    (1ull << MSR_IR) |
-                    (1ull << MSR_DR) |
-                    (1ull << MSR_PMM) |
-                    (1ull << MSR_RI) |
-                    (1ull << MSR_LE);
-    pcc->lpcr_mask = LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |
-        (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR_AIL |
-        LPCR_UPRT | LPCR_EVIRT | LPCR_ONL | LPCR_HR | LPCR_LD |
-        (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE | LPCR_EEE |
-                             LPCR_DEE | LPCR_OEE))
-        | LPCR_MER | LPCR_GTSE | LPCR_TC |
-        LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDICE;
+    pcc->insns_flags = PPC_INSNS_FLAGS_POWER9;
+    pcc->insns_flags2 = PPC_INSNS_FLAGS2_POWER9;
+    pcc->msr_mask = PPC_MSR_MASK_POWER9;
+    pcc->lpcr_mask = PPC_LPCR_MASK_POWER9;
     pcc->lpcr_pm = LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPCR_OEE;
     pcc->mmu_model = POWERPC_MMU_3_00;
 #if !defined(CONFIG_USER_ONLY)
@@ -6574,10 +6532,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
     pcc->excp_model = POWERPC_EXCP_POWER9;
     pcc->bus_model = PPC_FLAGS_INPUT_POWER9;
     pcc->bfd_mach = bfd_mach_ppc64;
-    pcc->flags = POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
-                 POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
-                 POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |
-                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM | POWERPC_FLAG_SCV;
+    pcc->flags = POWERPC_FLAGS_POWER9;
     pcc->l1_dcache_size = 0x8000;
     pcc->l1_icache_size = 0x8000;
 }
@@ -6690,60 +6645,15 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
     dc->fw_name = "PowerPC,POWER10";
     dc->desc = "POWER10";
     pcc->pvr_match = ppc_pvr_match_power10;
-    pcc->pcr_mask = PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_07 |
-                    PCR_COMPAT_3_00;
-    pcc->pcr_supported = PCR_COMPAT_3_10 | PCR_COMPAT_3_00 | PCR_COMPAT_2_07 |
-                         PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
+    pcc->pcr_mask = PPC_PCR_MASK_POWER10;
+    pcc->pcr_supported = PPC_PCR_SUPPORTED_POWER10;
     pcc->init_proc = init_proc_POWER10;
     pcc->check_pow = check_pow_nocheck;
     pcc->check_attn = check_attn_hid0_power9;
-    pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |
-                       PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
-                       PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
-                       PPC_FLOAT_FRSQRTES |
-                       PPC_FLOAT_STFIWX |
-                       PPC_FLOAT_EXT |
-                       PPC_CACHE | PPC_CACHE_ICBI | PPC_CACHE_DCBZ |
-                       PPC_MEM_SYNC | PPC_MEM_EIEIO |
-                       PPC_MEM_TLBIE | PPC_MEM_TLBSYNC |
-                       PPC_64B | PPC_64H | PPC_64BX | PPC_ALTIVEC |
-                       PPC_SEGMENT_64B | PPC_SLBI |
-                       PPC_POPCNTB | PPC_POPCNTWD |
-                       PPC_CILDST;
-    pcc->insns_flags2 = PPC2_VSX | PPC2_VSX207 | PPC2_DFP | PPC2_DBRX |
-                        PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 |
-                        PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206 |
-                        PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |
-                        PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
-                        PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
-                        PPC2_ISA300 | PPC2_PRCNTL | PPC2_ISA310 |
-                        PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206;
-    pcc->msr_mask = (1ull << MSR_SF) |
-                    (1ull << MSR_HV) |
-                    (1ull << MSR_VR) |
-                    (1ull << MSR_VSX) |
-                    (1ull << MSR_EE) |
-                    (1ull << MSR_PR) |
-                    (1ull << MSR_FP) |
-                    (1ull << MSR_ME) |
-                    (1ull << MSR_FE0) |
-                    (1ull << MSR_SE) |
-                    (1ull << MSR_DE) |
-                    (1ull << MSR_FE1) |
-                    (1ull << MSR_IR) |
-                    (1ull << MSR_DR) |
-                    (1ull << MSR_PMM) |
-                    (1ull << MSR_RI) |
-                    (1ull << MSR_LE);
-    pcc->lpcr_mask = LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |
-        (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR_AIL |
-        LPCR_UPRT | LPCR_EVIRT | LPCR_ONL | LPCR_HR | LPCR_LD |
-        (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE | LPCR_EEE |
-                             LPCR_DEE | LPCR_OEE))
-        | LPCR_MER | LPCR_GTSE | LPCR_TC |
-        LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDICE;
-    /* DD2 adds an extra HAIL bit */
-    pcc->lpcr_mask |= LPCR_HAIL;
+    pcc->insns_flags = PPC_INSNS_FLAGS_POWER10;
+    pcc->insns_flags2 = PPC_INSNS_FLAGS2_POWER10;
+    pcc->msr_mask = PPC_MSR_MASK_POWER10;
+    pcc->lpcr_mask = PPC_LPCR_MASK_POWER10;
 
     pcc->lpcr_pm = LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPCR_OEE;
     pcc->mmu_model = POWERPC_MMU_3_00;
@@ -6756,11 +6666,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
     pcc->excp_model = POWERPC_EXCP_POWER10;
     pcc->bus_model = PPC_FLAGS_INPUT_POWER9;
     pcc->bfd_mach = bfd_mach_ppc64;
-    pcc->flags = POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
-                 POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
-                 POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |
-                 POWERPC_FLAG_VSX | POWERPC_FLAG_SCV |
-                 POWERPC_FLAG_BHRB;
+    pcc->flags = POWERPC_FLAGS_POWER10;
     pcc->l1_dcache_size = 0x8000;
     pcc->l1_icache_size = 0x8000;
 }
diff --git a/target/ppc/cpu_init.h b/target/ppc/cpu_init.h
new file mode 100644
index 0000000000..9e027876f3
--- /dev/null
+++ b/target/ppc/cpu_init.h
@@ -0,0 +1,84 @@
+#ifndef TARGET_PPC_CPU_INIT_H
+#define TARGET_PPC_CPU_INIT_H
+
+#define PPC_INSNS_FLAGS_POWER9                                       \
+    (PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB |             \
+     PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |                   \
+     PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE | PPC_FLOAT_FRSQRTES |      \
+     PPC_FLOAT_STFIWX | PPC_FLOAT_EXT | PPC_CACHE | PPC_CACHE_ICBI | \
+     PPC_CACHE_DCBZ | PPC_MEM_SYNC | PPC_MEM_EIEIO | PPC_MEM_TLBIE | \
+     PPC_MEM_TLBSYNC | PPC_64B | PPC_64H | PPC_64BX | PPC_ALTIVEC |  \
+     PPC_SEGMENT_64B | PPC_SLBI | PPC_POPCNTB | PPC_POPCNTWD |       \
+     PPC_CILDST)
+
+#define PPC_INSNS_FLAGS_POWER10 PPC_INSNS_FLAGS_POWER9
+
+#define PPC_INSNS_FLAGS2_POWER_COMMON                                \
+    (PPC2_VSX | PPC2_VSX207 | PPC2_DFP | PPC2_DBRX |                 \
+     PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 |      \
+     PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |   \
+     PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 | PPC2_ISA205 |              \
+     PPC2_ISA207S | PPC2_FP_CVT_S64 | PPC2_ISA300 | PPC2_PRCNTL |    \
+     PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206)
+
+#define PPC_INSNS_FLAGS2_POWER9                                      \
+    (PPC_INSNS_FLAGS2_POWER_COMMON | PPC2_TM)
+#define PPC_INSNS_FLAGS2_POWER10                                     \
+    (PPC_INSNS_FLAGS2_POWER_COMMON | PPC2_ISA310)
+
+#define PPC_MSR_MASK_POWER_COMMON           \
+    ((1ull << MSR_SF) |                     \
+     (1ull << MSR_HV) |                     \
+     (1ull << MSR_VR) |                     \
+     (1ull << MSR_VSX) |                    \
+     (1ull << MSR_EE) |                     \
+     (1ull << MSR_PR) |                     \
+     (1ull << MSR_FP) |                     \
+     (1ull << MSR_ME) |                     \
+     (1ull << MSR_FE0) |                    \
+     (1ull << MSR_SE) |                     \
+     (1ull << MSR_DE) |                     \
+     (1ull << MSR_FE1) |                    \
+     (1ull << MSR_IR) |                     \
+     (1ull << MSR_DR) |                     \
+     (1ull << MSR_PMM) |                    \
+     (1ull << MSR_RI) |                     \
+     (1ull << MSR_LE))
+
+#define PPC_MSR_MASK_POWER9         \
+    (PPC_MSR_MASK_POWER_COMMON | (1ull << MSR_TM))
+#define PPC_MSR_MASK_POWER10        \
+    PPC_MSR_MASK_POWER_COMMON
+
+#define PPC_PCR_MASK_POWER9         \
+    (PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_07)
+#define PPC_PCR_MASK_POWER10        \
+    (PPC_PCR_MASK_POWER9 | PCR_COMPAT_3_00)
+
+#define PPC_PCR_SUPPORTED_POWER9    \
+    (PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_COMPAT_2_05)
+#define PPC_PCR_SUPPORTED_POWER10   \
+    (PPC_PCR_SUPPORTED_POWER9 | PCR_COMPAT_3_10)
+
+#define PPC_LPCR_MASK_POWER9                                                 \
+    (LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |                           \
+     (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR_AIL |                  \
+     LPCR_UPRT | LPCR_EVIRT | LPCR_ONL | LPCR_HR | LPCR_LD |                 \
+     (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE |      \
+                          LPCR_OEE)) | LPCR_MER | LPCR_GTSE | LPCR_TC |      \
+     LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDICE)
+/* DD2 adds an extra HAIL bit */
+#define PPC_LPCR_MASK_POWER10   \
+    (PPC_LPCR_MASK_POWER9 | LPCR_HAIL)
+
+#define POWERPC_FLAGS_POWER_COMMON                                       \
+    (POWERPC_FLAG_VRE | POWERPC_FLAG_SE | POWERPC_FLAG_BE |              \
+     POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |       \
+     POWERPC_FLAG_VSX | POWERPC_FLAG_SCV)
+
+#define POWERPC_FLAGS_POWER9  \
+    (POWERPC_FLAGS_POWER_COMMON | POWERPC_FLAG_TM)
+#define POWERPC_FLAGS_POWER10 \
+    (POWERPC_FLAGS_POWER_COMMON | POWERPC_FLAG_BHRB)
+
+#endif /* TARGET_PPC_CPU_INIT_H */
-- 
2.45.2


