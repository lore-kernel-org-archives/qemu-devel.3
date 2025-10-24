Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A6CCCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 06:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCBkW-00007k-Gk; Fri, 24 Oct 2025 02:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vCBkU-00005O-8l
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:58:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vCBkM-0006pj-LH
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761289077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ODv99cL0iNnIxFvnGruknaJOB2DYNklkGCyxNPqY2jE=;
 b=gaMiucdVxiolX0rROlrodd/rJ9B0e2SXKo+nqCeL5D/lF3vOqwxEc5GHfihbREwaQYLEf6
 y8f7YGU5Hs2wMyDO4pg2QsDt7qzpVAeqlLpZIqHXbJuDOA6Z+/iw6XRXMP0q/0GZt2P05O
 jQiU3ZD7wVNVLvhrqqxNP5++ik8A3jw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-UcM_MFSuPmKxtAb0kmVsZA-1; Fri,
 24 Oct 2025 02:57:38 -0400
X-MC-Unique: UcM_MFSuPmKxtAb0kmVsZA-1
X-Mimecast-MFC-AGG-ID: UcM_MFSuPmKxtAb0kmVsZA_1761289057
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 005A91975AEE; Fri, 24 Oct 2025 06:57:37 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.49])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1B6D51800577; Fri, 24 Oct 2025 06:57:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 2/2] target/ppc: Remove the unusable e200 CPUs
Date: Fri, 24 Oct 2025 08:57:26 +0200
Message-ID: <20251024065726.738005-3-thuth@redhat.com>
In-Reply-To: <20251024065726.738005-1-thuth@redhat.com>
References: <20251024065726.738005-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

There is currently no machine in QEMU (except the "none" machine)
that can be run with with one of the e200 ppc CPUs - all machines
either complain about an invalid CPU type or crash QEMU immediately.

Looking at the history of this CPU type, it seems like it has never
been used in QEMU and only implemented as a placeholder (see e.g. the
comment about unimplemented instructions in the POWERPC_FAMILY(e200)
section of cpu_init.c). Being completely unused and unusable since
such a long time, let's just remove it now (without deprecation phase,
since there were no users of this dead code anyway).

Note: The init_excp_e200() is used by the e500 CPUs, too, so we
rename this function to init_excp_e500() instead of removing it.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/ppc/cpu-models.h |   4 --
 target/ppc/cpu-models.c |   5 --
 target/ppc/cpu_init.c   | 147 +---------------------------------------
 3 files changed, 2 insertions(+), 154 deletions(-)

diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index c6cd27f390e..a439eb37ee4 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -120,10 +120,6 @@ enum {
 #define CPU_POWERPC_MPC5200_v12      CPU_POWERPC_G2LEgp1
 #define CPU_POWERPC_MPC5200B_v20     CPU_POWERPC_G2LEgp1
 #define CPU_POWERPC_MPC5200B_v21     CPU_POWERPC_G2LEgp1
-    /* e200 family */
-    /* e200 cores */
-    CPU_POWERPC_e200z5             = 0x81000000,
-    CPU_POWERPC_e200z6             = 0x81120000,
     /* e300 family */
     /* e300 cores */
     CPU_POWERPC_e300c1             = 0x00830010,
diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index 89ae763c7f6..26b6debcfc9 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -244,11 +244,6 @@
                     CPU_POWERPC_MPC5200B_v20, POWERPC_SVR_5200B_v20, G2LE)
     POWERPC_DEF_SVR("mpc5200b_v21", "MPC5200B v2.1",
                     CPU_POWERPC_MPC5200B_v21, POWERPC_SVR_5200B_v21, G2LE)
-    /* e200 family                                                           */
-    POWERPC_DEF("e200z5",        CPU_POWERPC_e200z5,                 e200,
-                "PowerPC e200z5 core")
-    POWERPC_DEF("e200z6",        CPU_POWERPC_e200z6,                 e200,
-                "PowerPC e200z6 core")
     /* e300 family                                                           */
     POWERPC_DEF("e300c1",        CPU_POWERPC_e300c1,                 e300,
                 "PowerPC e300c1 core")
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 12c645699e8..86ead740eec 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -1811,7 +1811,7 @@ static void init_excp_G2(CPUPPCState *env)
 #endif
 }
 
-static void init_excp_e200(CPUPPCState *env, target_ulong ivpr_mask)
+static void init_excp_e500(CPUPPCState *env, target_ulong ivpr_mask)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000FFC;
@@ -2782,149 +2782,6 @@ POWERPC_FAMILY(G2LE)(ObjectClass *oc, const void *data)
                  POWERPC_FLAG_BE | POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_e200(CPUPPCState *env)
-{
-    register_BookE_sprs(env, 0x000000070000FFFFULL);
-
-    spr_register(env, SPR_BOOKE_SPEFSCR, "SPEFSCR",
-                 &spr_read_spefscr, &spr_write_spefscr,
-                 &spr_read_spefscr, &spr_write_spefscr,
-                 0x00000000);
-    /* Memory management */
-    register_BookE206_sprs(env, 0x0000005D, NULL, 0);
-    register_usprgh_sprs(env);
-
-    spr_register(env, SPR_HID0, "HID0",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_HID1, "HID1",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_Exxx_ALTCTXCR, "ALTCTXCR",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_Exxx_BUCSR, "BUCSR",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_Exxx_CTXCR, "CTXCR",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_Exxx_DBCNT, "DBCNT",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_Exxx_DBCR3, "DBCR3",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_Exxx_L1CFG0, "L1CFG0",
-                 &spr_read_generic, SPR_NOACCESS,
-                 &spr_read_generic, SPR_NOACCESS,
-                 0x00000000);
-
-    spr_register(env, SPR_Exxx_L1CSR0, "L1CSR0",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_Exxx_L1FINV0, "L1FINV0",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_BOOKE_TLB0CFG, "TLB0CFG",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_BOOKE_TLB1CFG, "TLB1CFG",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_BOOKE_IAC3, "IAC3",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_BOOKE_IAC4, "IAC4",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000);
-
-    spr_register(env, SPR_MMUCSR0, "MMUCSR0",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
-                 0x00000000); /* TOFIX */
-
-    init_tlbs_emb(env);
-    init_excp_e200(env, 0xFFFF0000UL);
-    env->dcache_line_size = 32;
-    env->icache_line_size = 32;
-    /* XXX: TODO: allocate internal IRQ controller */
-}
-
-POWERPC_FAMILY(e200)(ObjectClass *oc, const void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(oc);
-    PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
-
-    dc->desc = "e200 core";
-    pcc->init_proc = init_proc_e200;
-    pcc->check_pow = check_pow_hid0;
-    pcc->check_attn = check_attn_none;
-    /*
-     * XXX: unimplemented instructions:
-     * dcblc
-     * dcbtlst
-     * dcbtstls
-     * icblc
-     * icbtls
-     * tlbivax
-     * all SPE multiply-accumulate instructions
-     */
-    pcc->insns_flags = PPC_INSNS_BASE | PPC_ISEL |
-                       PPC_SPE | PPC_SPE_SINGLE |
-                       PPC_WRTEE | PPC_RFDI |
-                       PPC_CACHE | PPC_CACHE_LOCK | PPC_CACHE_ICBI |
-                       PPC_CACHE_DCBZ | PPC_CACHE_DCBA |
-                       PPC_MEM_TLBSYNC | PPC_TLBIVAX |
-                       PPC_BOOKE;
-    pcc->msr_mask = (1ull << MSR_UCLE) |
-                    (1ull << MSR_SPE) |
-                    (1ull << MSR_POW) |
-                    (1ull << MSR_CE) |
-                    (1ull << MSR_EE) |
-                    (1ull << MSR_PR) |
-                    (1ull << MSR_FP) |
-                    (1ull << MSR_ME) |
-                    (1ull << MSR_FE0) |
-                    (1ull << MSR_DWE) |
-                    (1ull << MSR_DE) |
-                    (1ull << MSR_FE1) |
-                    (1ull << MSR_IR) |
-                    (1ull << MSR_DR);
-    pcc->mmu_model = POWERPC_MMU_BOOKE206;
-    pcc->excp_model = POWERPC_EXCP_BOOKE;
-    pcc->bus_model = PPC_FLAGS_INPUT_BookE;
-    pcc->bfd_mach = bfd_mach_ppc_860;
-    pcc->flags = POWERPC_FLAG_SPE | POWERPC_FLAG_CE |
-                 POWERPC_FLAG_UBLE | POWERPC_FLAG_DE |
-                 POWERPC_FLAG_BUS_CLK;
-}
-
 enum fsl_e500_version {
     fsl_e500v1,
     fsl_e500v2,
@@ -3159,7 +3016,7 @@ static void init_proc_e500(CPUPPCState *env, int version)
     }
 #endif
 
-    init_excp_e200(env, ivpr_mask);
+    init_excp_e500(env, ivpr_mask);
     /* Allocate hardware IRQ controller */
     ppce500_irq_init(env_archcpu(env));
 }
-- 
2.51.0


