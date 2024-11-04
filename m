Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB96D11198
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kqO-0002t8-E7; Sun, 03 Nov 2024 19:21:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kqL-0002aV-AF; Sun, 03 Nov 2024 19:21:17 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kqJ-0002fx-6v; Sun, 03 Nov 2024 19:21:16 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-72041ff06a0so3061844b3a.2; 
 Sun, 03 Nov 2024 16:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679673; x=1731284473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c1XsHuBIcfUyMOIaLjJZ+AcxJBNg7k7Apo9qjCBzFG0=;
 b=EA2qnhO6H1fXuBkyv+la86q7zaWVNXnVO73++6V+lXyk/yDvjdPM4hwo1pK6sjuUGT
 WD0wqGNN6M9SNADVTZDYe3OaC2QcWOK7iYoeIJ9tCWoLAqE32xV16wMoebDtAq0vrFGZ
 B2rvMutjLbcTWKi2Hp4upOvexdxgtJaiSIwTi4N1DvW0N6lE5PwCT0A3u6nyo6/p+jZO
 IURKCNJQ+fX40xhQwggAeMujxohGc3usxok3gvFnOQUfk62mNXi//B5U3jgppyG7P2js
 tRcLzVl1d0xWpxxTujEZWpHsuaChIvBtbYSiIi+N+/+OrZOy5ndB2HyTpI6E6cdjYDGX
 PJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679673; x=1731284473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c1XsHuBIcfUyMOIaLjJZ+AcxJBNg7k7Apo9qjCBzFG0=;
 b=ixcEWHclNQINBGnGHxe5/pRi6qC1aAEoffUFJvtKbCdarMQ4xTkJPNxJ3HIwMGJI7D
 zTT9a/hGYi2ePc+Mkq2ULiAg1nFKB9QAz+nDVG3c0wlJnmaxCWFINiUVt6iSuerPvbUP
 5d2qvvJywd4+2pyb3f7kkzbgHdEOWp/1QHZQAcN4k0IU832Rk2WPGHu7GMTkH3DxMrfe
 cI7oJQUaMZP8hzTh/FytUU8603ZBxse8Ni/M5g3pKjBMD+Epuh4bNEnfCgnDS4c8jFiR
 dy4gpJ6N3fMNEexgaoEf+2PSeMXQmBqlykZQsM9o3a/MnNlFdddOboJXwdYEWyLvEyWR
 7wNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI9SoeVMrKxEf3O6ZgS9ETeJhTzCKip3GPMlGNnvckNPJywMKvNSymlal97qQM+btL4Dlj/NByyQ==@nongnu.org
X-Gm-Message-State: AOJu0YyUXeLd7nUMIMFMu/UpQA1RpoAyQ2snYwTvYVTf7UPaKigz3xVm
 luszpHdEq/w0vdHcevMvBdSWxyl99ZNSUIbytIkJLa/5PULm7blw+V7jnA==
X-Google-Smtp-Source: AGHT+IFQqdF2mCD88K9cq8LMxbfi2d3Xy3o0HLqFRwmpgcNyPOfmWaUaNLS8wzvessuuSW1H30pxLg==
X-Received: by 2002:a05:6a20:d488:b0:1d9:1045:3ed5 with SMTP id
 adf61e73a8af0-1dba52a4592mr14872743637.11.1730679673106; 
 Sun, 03 Nov 2024 16:21:13 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:21:12 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Aditya Gupta <adityag@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [PULL 33/67] target/ppc: Add Power11 DD2.0 processor
Date: Mon,  4 Nov 2024 10:18:22 +1000
Message-ID: <20241104001900.682660-34-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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

From: Aditya Gupta <adityag@linux.ibm.com>

Add CPU target code to add support for new Power11 Processor.

Power11 core is same as Power10, hence reuse functions defined for
Power10.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Tested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/compat.c      |  7 +++++
 target/ppc/cpu-models.c  |  3 ++
 target/ppc/cpu-models.h  |  3 ++
 target/ppc/cpu.h         |  2 ++
 target/ppc/cpu_init.c    | 60 ++++++++++++++++++++++++++++++++++++++++
 target/ppc/cpu_init.h    |  7 +++++
 target/ppc/excp_helper.c |  4 +++
 7 files changed, 86 insertions(+)

diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index 5b20fd7ef0..0cec1bde91 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -100,6 +100,13 @@ static const CompatInfo compat_table[] = {
         .pcr_level = PCR_COMPAT_3_10,
         .max_vthreads = 8,
     },
+    { /* POWER11, ISA3.10 */
+        .name = "power11",
+        .pvr = CPU_POWERPC_LOGICAL_3_10_P11,
+        .pcr = PCR_COMPAT_3_10,
+        .pcr_level = PCR_COMPAT_3_10,
+        .max_vthreads = 8,
+    },
 };
 
 static const CompatInfo *compat_by_pvr(uint32_t pvr)
diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index f2301b43f7..ece3481781 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -734,6 +734,8 @@
                 "POWER9 v2.2")
     POWERPC_DEF("power10_v2.0",  CPU_POWERPC_POWER10_DD20,           POWER10,
                 "POWER10 v2.0")
+    POWERPC_DEF("power11_v2.0",  CPU_POWERPC_POWER11_DD20,           POWER11,
+                "POWER11_v2.0")
 #endif /* defined (TARGET_PPC64) */
 
 /***************************************************************************/
@@ -909,6 +911,7 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
     { "power8nvl", "power8nvl_v1.0" },
     { "power9", "power9_v2.2" },
     { "power10", "power10_v2.0" },
+    { "power11", "power11_v2.0" },
 #endif
 
     /* Generic PowerPCs */
diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index 0229ef3a9a..72ad31ba50 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -354,6 +354,8 @@ enum {
     CPU_POWERPC_POWER10_BASE       = 0x00800000,
     CPU_POWERPC_POWER10_DD1        = 0x00801100,
     CPU_POWERPC_POWER10_DD20       = 0x00801200,
+    CPU_POWERPC_POWER11_BASE       = 0x00820000,
+    CPU_POWERPC_POWER11_DD20       = 0x00821200,
     CPU_POWERPC_970_v22            = 0x00390202,
     CPU_POWERPC_970FX_v10          = 0x00391100,
     CPU_POWERPC_970FX_v20          = 0x003C0200,
@@ -391,6 +393,7 @@ enum {
     CPU_POWERPC_LOGICAL_2_07       = 0x0F000004,
     CPU_POWERPC_LOGICAL_3_00       = 0x0F000005,
     CPU_POWERPC_LOGICAL_3_10       = 0x0F000006,
+    CPU_POWERPC_LOGICAL_3_10_P11   = 0x0F000007,
 };
 
 /* System version register (used on MPC 8xxx)                                */
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index daa12f8733..945af07a64 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -216,6 +216,8 @@ typedef enum powerpc_excp_t {
     POWERPC_EXCP_POWER9,
     /* POWER10 exception model           */
     POWERPC_EXCP_POWER10,
+    /* POWER11 exception model           */
+    POWERPC_EXCP_POWER11,
 } powerpc_excp_t;
 
 /*****************************************************************************/
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index bc8ec77fa0..c26e5b269c 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6675,6 +6675,66 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
     pcc->l1_icache_size = 0x8000;
 }
 
+static void init_proc_POWER11(CPUPPCState *env)
+{
+    init_proc_POWER10(env);
+}
+
+static bool ppc_pvr_match_power11(PowerPCCPUClass *pcc, uint32_t pvr, bool best)
+{
+    uint32_t base = pvr & CPU_POWERPC_POWER_SERVER_MASK;
+    uint32_t pcc_base = pcc->pvr & CPU_POWERPC_POWER_SERVER_MASK;
+
+    if (!best && (base == CPU_POWERPC_POWER11_BASE)) {
+        return true;
+    }
+
+    if (base != pcc_base) {
+        return false;
+    }
+
+    if ((pvr & 0x0f00) == (pcc->pvr & 0x0f00)) {
+        return true;
+    }
+
+    return false;
+}
+
+POWERPC_FAMILY(POWER11)(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
+
+    dc->fw_name = "PowerPC,POWER11";
+    dc->desc = "POWER11";
+    pcc->spapr_logical_pvr = CPU_POWERPC_LOGICAL_3_10_P11;
+    pcc->pvr_match = ppc_pvr_match_power11;
+    pcc->pcr_mask = PPC_PCR_MASK_POWER11;
+    pcc->pcr_supported = PPC_PCR_SUPPORTED_POWER11;
+    pcc->init_proc = init_proc_POWER11;
+    pcc->check_pow = check_pow_nocheck;
+    pcc->check_attn = check_attn_hid0_power9;
+    pcc->insns_flags = PPC_INSNS_FLAGS_POWER11;
+    pcc->insns_flags2 = PPC_INSNS_FLAGS2_POWER11;
+    pcc->msr_mask = PPC_MSR_MASK_POWER11;
+    pcc->lpcr_mask = PPC_LPCR_MASK_POWER11;
+
+    pcc->lpcr_pm = LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPCR_OEE;
+    pcc->mmu_model = POWERPC_MMU_3_00;
+#if !defined(CONFIG_USER_ONLY)
+    /* segment page size remain the same */
+    pcc->hash64_opts = &ppc_hash64_opts_POWER7;
+    pcc->radix_page_info = &POWER10_radix_page_info;
+    pcc->lrg_decr_bits = 56;
+#endif
+    pcc->excp_model = POWERPC_EXCP_POWER11;
+    pcc->bus_model = PPC_FLAGS_INPUT_POWER9;
+    pcc->bfd_mach = bfd_mach_ppc64;
+    pcc->flags = POWERPC_FLAGS_POWER11;
+    pcc->l1_dcache_size = 0x8000;
+    pcc->l1_icache_size = 0x8000;
+}
+
 #if !defined(CONFIG_USER_ONLY)
 void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
 {
diff --git a/target/ppc/cpu_init.h b/target/ppc/cpu_init.h
index 9e027876f3..f8fd6ff5cd 100644
--- a/target/ppc/cpu_init.h
+++ b/target/ppc/cpu_init.h
@@ -12,6 +12,7 @@
      PPC_CILDST)
 
 #define PPC_INSNS_FLAGS_POWER10 PPC_INSNS_FLAGS_POWER9
+#define PPC_INSNS_FLAGS_POWER11 PPC_INSNS_FLAGS_POWER10
 
 #define PPC_INSNS_FLAGS2_POWER_COMMON                                \
     (PPC2_VSX | PPC2_VSX207 | PPC2_DFP | PPC2_DBRX |                 \
@@ -25,6 +26,7 @@
     (PPC_INSNS_FLAGS2_POWER_COMMON | PPC2_TM)
 #define PPC_INSNS_FLAGS2_POWER10                                     \
     (PPC_INSNS_FLAGS2_POWER_COMMON | PPC2_ISA310)
+#define PPC_INSNS_FLAGS2_POWER11 PPC_INSNS_FLAGS2_POWER10
 
 #define PPC_MSR_MASK_POWER_COMMON           \
     ((1ull << MSR_SF) |                     \
@@ -49,16 +51,19 @@
     (PPC_MSR_MASK_POWER_COMMON | (1ull << MSR_TM))
 #define PPC_MSR_MASK_POWER10        \
     PPC_MSR_MASK_POWER_COMMON
+#define PPC_MSR_MASK_POWER11 PPC_MSR_MASK_POWER10
 
 #define PPC_PCR_MASK_POWER9         \
     (PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_07)
 #define PPC_PCR_MASK_POWER10        \
     (PPC_PCR_MASK_POWER9 | PCR_COMPAT_3_00)
+#define PPC_PCR_MASK_POWER11 PPC_PCR_MASK_POWER10
 
 #define PPC_PCR_SUPPORTED_POWER9    \
     (PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_COMPAT_2_05)
 #define PPC_PCR_SUPPORTED_POWER10   \
     (PPC_PCR_SUPPORTED_POWER9 | PCR_COMPAT_3_10)
+#define PPC_PCR_SUPPORTED_POWER11 PPC_PCR_SUPPORTED_POWER10
 
 #define PPC_LPCR_MASK_POWER9                                                 \
     (LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |                           \
@@ -70,6 +75,7 @@
 /* DD2 adds an extra HAIL bit */
 #define PPC_LPCR_MASK_POWER10   \
     (PPC_LPCR_MASK_POWER9 | LPCR_HAIL)
+#define PPC_LPCR_MASK_POWER11 PPC_LPCR_MASK_POWER10
 
 #define POWERPC_FLAGS_POWER_COMMON                                       \
     (POWERPC_FLAG_VRE | POWERPC_FLAG_SE | POWERPC_FLAG_BE |              \
@@ -80,5 +86,6 @@
     (POWERPC_FLAGS_POWER_COMMON | POWERPC_FLAG_TM)
 #define POWERPC_FLAGS_POWER10 \
     (POWERPC_FLAGS_POWER_COMMON | POWERPC_FLAG_BHRB)
+#define POWERPC_FLAGS_POWER11 POWERPC_FLAGS_POWER10
 
 #endif /* TARGET_PPC_CPU_INIT_H */
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index b619a6adde..087235bd62 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1661,6 +1661,7 @@ static void powerpc_excp(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_POWER8:
     case POWERPC_EXCP_POWER9:
     case POWERPC_EXCP_POWER10:
+    case POWERPC_EXCP_POWER11:
         powerpc_excp_books(cpu, excp);
         break;
     default:
@@ -2018,6 +2019,7 @@ static int ppc_next_unmasked_interrupt(CPUPPCState *env)
         return p8_next_unmasked_interrupt(env);
     case POWERPC_EXCP_POWER9:
     case POWERPC_EXCP_POWER10:
+    case POWERPC_EXCP_POWER11:
         return p9_next_unmasked_interrupt(env);
     default:
         break;
@@ -2378,6 +2380,7 @@ static void ppc_deliver_interrupt(CPUPPCState *env, int interrupt)
         return p8_deliver_interrupt(env, interrupt);
     case POWERPC_EXCP_POWER9:
     case POWERPC_EXCP_POWER10:
+    case POWERPC_EXCP_POWER11:
         return p9_deliver_interrupt(env, interrupt);
     default:
         break;
@@ -3168,6 +3171,7 @@ void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
     case POWERPC_EXCP_POWER8:
     case POWERPC_EXCP_POWER9:
     case POWERPC_EXCP_POWER10:
+    case POWERPC_EXCP_POWER11:
         /*
          * Machine check codes can be found in processor User Manual or
          * Linux or skiboot source.
-- 
2.45.2


