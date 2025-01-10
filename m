Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB29DE7719D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 14:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWFqL-00033m-Mc; Fri, 10 Jan 2025 09:18:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tWFqJ-00031Y-Qu
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:18:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tWFqH-0005Bf-Vf
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:18:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736518709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iUWQBC/jAFQCp56LLtQZPbK6/JvUTHoQKoSBChi6Dc4=;
 b=BFj9AzYcoAS9faVuVJY/og/ZrSn2WW9W2vLYgUI8Xr/C66gl/DrtG8jzT2B7pRBAk7+zDu
 BSogPqQyqP86gKyIner4s64itleFNfE1ClJr+rCYonWzGASpKlZ8j4/FV29ZgQFQy8Xh7S
 cqaT8eKZG8AZkTHwixN9PKThJZUgPUM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-fLzQQnfdOFSrcDSk4vxUKA-1; Fri,
 10 Jan 2025 09:18:26 -0500
X-MC-Unique: fLzQQnfdOFSrcDSk4vxUKA-1
X-Mimecast-MFC-AGG-ID: fLzQQnfdOFSrcDSk4vxUKA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 117971955DD8; Fri, 10 Jan 2025 14:18:25 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.35])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6969E195E3D9; Fri, 10 Jan 2025 14:18:23 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 8/9] ppc/ppc405: Remove TLB instructions
Date: Fri, 10 Jan 2025 15:17:59 +0100
Message-ID: <20250110141800.1587589-9-clg@redhat.com>
In-Reply-To: <20250110141800.1587589-1-clg@redhat.com>
References: <20250110141800.1587589-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since the 405 CPU family was phased out, these instructions have no
users anymore.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 target/ppc/cpu.h        |  4 +-
 target/ppc/helper.h     |  1 -
 target/ppc/spr_common.h |  1 -
 target/ppc/mmu_helper.c |  2 +-
 target/ppc/translate.c  | 81 -----------------------------------------
 5 files changed, 2 insertions(+), 87 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index f83f01a62a12..6850d67b6875 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2383,8 +2383,6 @@ enum {
     PPC_SEGMENT        = 0x0000020000000000ULL,
     /*   PowerPC 6xx TLB management instructions                             */
     PPC_6xx_TLB        = 0x0000040000000000ULL,
-    /*   PowerPC 40x TLB management instructions                             */
-    PPC_40x_TLB        = 0x0000100000000000ULL,
     /*   segment register access instructions for PowerPC 64 "bridge"        */
     PPC_SEGMENT_64B    = 0x0000200000000000ULL,
     /*   SLB management                                                      */
@@ -2432,7 +2430,7 @@ enum {
                         | PPC_CACHE_DCBZ \
                         | PPC_CACHE_DCBA | PPC_CACHE_LOCK \
                         | PPC_EXTERN | PPC_SEGMENT | PPC_6xx_TLB \
-                        | PPC_40x_TLB | PPC_SEGMENT_64B \
+                        | PPC_SEGMENT_64B \
                         | PPC_SLBI | PPC_WRTEE \
                         | PPC_405_MAC | PPC_440_SPEC | PPC_BOOKE \
                         | PPC_MFAPIDI | PPC_TLBIVA | PPC_TLBIVAX \
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 025f2b5ac902..102f3e8aecf3 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -746,7 +746,6 @@ DEF_HELPER_FLAGS_1(load_hdecr, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_2(store_hdecr, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_2(store_vtb, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_2(store_tbu40, TCG_CALL_NO_RWG, void, env, tl)
-DEF_HELPER_2(store_40x_pid, void, env, tl)
 DEF_HELPER_2(store_40x_dbcr0, void, env, tl)
 DEF_HELPER_FLAGS_2(store_booke_tcr, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_2(store_booke_tsr, TCG_CALL_NO_RWG, void, env, tl)
diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
index 4aab0e5f8291..7535a016ee6b 100644
--- a/target/ppc/spr_common.h
+++ b/target/ppc/spr_common.h
@@ -136,7 +136,6 @@ void spr_write_dbatl(DisasContext *ctx, int sprn, int gprn);
 void spr_write_dbatl_h(DisasContext *ctx, int sprn, int gprn);
 void spr_write_sdr1(DisasContext *ctx, int sprn, int gprn);
 void spr_write_40x_dbcr0(DisasContext *ctx, int sprn, int gprn);
-void spr_write_40x_pid(DisasContext *ctx, int sprn, int gprn);
 void spr_write_booke_tcr(DisasContext *ctx, int sprn, int gprn);
 void spr_write_booke_tsr(DisasContext *ctx, int sprn, int gprn);
 void spr_read_403_pbr(DisasContext *ctx, int gprn, int sprn);
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index a802bc9c62b0..faa4522ec8b0 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -673,7 +673,7 @@ static inline int booke_page_size_to_tlb(target_ulong page_size)
 #define PPC4XX_TLBLO_ATTR_MASK      0x000000FF
 #define PPC4XX_TLBLO_RPN_MASK       0xFFFFFC00
 
-void helper_store_40x_pid(CPUPPCState *env, target_ulong val)
+static void helper_store_40x_pid(CPUPPCState *env, target_ulong val)
 {
     if (env->spr[SPR_40x_PID] != val) {
         env->spr[SPR_40x_PID] = val;
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 779103c0472d..997b8647b137 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -955,13 +955,6 @@ void spr_write_40x_dbcr0(DisasContext *ctx, int sprn, int gprn)
     ctx->base.is_jmp = DISAS_EXIT_UPDATE;
 }
 
-void spr_write_40x_pid(DisasContext *ctx, int sprn, int gprn)
-{
-    TCGv t0 = tcg_temp_new();
-    tcg_gen_andi_tl(t0, cpu_gpr[gprn], 0xFF);
-    gen_helper_store_40x_pid(tcg_env, t0);
-}
-
 void spr_write_booke_tcr(DisasContext *ctx, int sprn, int gprn)
 {
     translator_io_start(&ctx->base);
@@ -5096,77 +5089,6 @@ static void gen_rfmci(DisasContext *ctx)
 #endif /* defined(CONFIG_USER_ONLY) */
 }
 
-/* TLB management - PowerPC 405 implementation */
-
-/* tlbre */
-static void gen_tlbre_40x(DisasContext *ctx)
-{
-#if defined(CONFIG_USER_ONLY)
-    GEN_PRIV(ctx);
-#else
-    CHK_SV(ctx);
-    switch (rB(ctx->opcode)) {
-    case 0:
-        gen_helper_4xx_tlbre_hi(cpu_gpr[rD(ctx->opcode)], tcg_env,
-                                cpu_gpr[rA(ctx->opcode)]);
-        break;
-    case 1:
-        gen_helper_4xx_tlbre_lo(cpu_gpr[rD(ctx->opcode)], tcg_env,
-                                cpu_gpr[rA(ctx->opcode)]);
-        break;
-    default:
-        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
-        break;
-    }
-#endif /* defined(CONFIG_USER_ONLY) */
-}
-
-/* tlbsx - tlbsx. */
-static void gen_tlbsx_40x(DisasContext *ctx)
-{
-#if defined(CONFIG_USER_ONLY)
-    GEN_PRIV(ctx);
-#else
-    TCGv t0;
-
-    CHK_SV(ctx);
-    t0 = tcg_temp_new();
-    gen_addr_reg_index(ctx, t0);
-    gen_helper_4xx_tlbsx(cpu_gpr[rD(ctx->opcode)], tcg_env, t0);
-    if (Rc(ctx->opcode)) {
-        TCGLabel *l1 = gen_new_label();
-        tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_gpr[rD(ctx->opcode)], -1, l1);
-        tcg_gen_ori_i32(cpu_crf[0], cpu_crf[0], 0x02);
-        gen_set_label(l1);
-    }
-#endif /* defined(CONFIG_USER_ONLY) */
-}
-
-/* tlbwe */
-static void gen_tlbwe_40x(DisasContext *ctx)
-{
-#if defined(CONFIG_USER_ONLY)
-    GEN_PRIV(ctx);
-#else
-    CHK_SV(ctx);
-
-    switch (rB(ctx->opcode)) {
-    case 0:
-        gen_helper_4xx_tlbwe_hi(tcg_env, cpu_gpr[rA(ctx->opcode)],
-                                cpu_gpr[rS(ctx->opcode)]);
-        break;
-    case 1:
-        gen_helper_4xx_tlbwe_lo(tcg_env, cpu_gpr[rA(ctx->opcode)],
-                                cpu_gpr[rS(ctx->opcode)]);
-        break;
-    default:
-        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
-        break;
-    }
-#endif /* defined(CONFIG_USER_ONLY) */
-}
-
 /* TLB management - PowerPC 440 implementation */
 
 /* tlbre */
@@ -5879,9 +5801,6 @@ GEN_HANDLER(icread, 0x1F, 0x06, 0x1F, 0x03E00001, PPC_4xx_COMMON),
 GEN_HANDLER_E(rfci, 0x13, 0x13, 0x01, 0x03FF8001, PPC_BOOKE, PPC2_BOOKE206),
 GEN_HANDLER(rfdi, 0x13, 0x07, 0x01, 0x03FF8001, PPC_RFDI),
 GEN_HANDLER(rfmci, 0x13, 0x06, 0x01, 0x03FF8001, PPC_RFMCI),
-GEN_HANDLER2(tlbre_40x, "tlbre", 0x1F, 0x12, 0x1D, 0x00000001, PPC_40x_TLB),
-GEN_HANDLER2(tlbsx_40x, "tlbsx", 0x1F, 0x12, 0x1C, 0x00000000, PPC_40x_TLB),
-GEN_HANDLER2(tlbwe_40x, "tlbwe", 0x1F, 0x12, 0x1E, 0x00000001, PPC_40x_TLB),
 GEN_HANDLER2(tlbre_440, "tlbre", 0x1F, 0x12, 0x1D, 0x00000001, PPC_BOOKE),
 GEN_HANDLER2(tlbsx_440, "tlbsx", 0x1F, 0x12, 0x1C, 0x00000000, PPC_BOOKE),
 GEN_HANDLER2(tlbwe_440, "tlbwe", 0x1F, 0x12, 0x1E, 0x00000001, PPC_BOOKE),
-- 
2.47.1


