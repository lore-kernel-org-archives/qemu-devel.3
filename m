Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC77E7719D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 14:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWFqD-0002v0-P5; Fri, 10 Jan 2025 09:18:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tWFqB-0002t7-0w
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:18:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tWFq9-00059y-Cm
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:18:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736518700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jC0SzzuEE4pf0D06oY+b+ihgJQJrBdiXMgseL+om+P8=;
 b=Sg3AsQHz1ATfrctXSXRBsbV4I1c4Xw9FkkN4a7nyNHvLW5Ax3HG4PFdP5auwD8wnaJbNGJ
 a9cz378O+UWBCk8beV9iflaWl7YLAKjOHGON4nLY1lvR+mMt42QvE8zNuxU1zHyaccu0wT
 x5p0KhCneV/lO0HSo4sl9/NtaLS2Gds=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-Tm9hzjl1O8qJvu93c-40iA-1; Fri,
 10 Jan 2025 09:18:17 -0500
X-MC-Unique: Tm9hzjl1O8qJvu93c-40iA-1
X-Mimecast-MFC-AGG-ID: Tm9hzjl1O8qJvu93c-40iA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76BFC19560B0; Fri, 10 Jan 2025 14:18:16 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.35])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CFEEC195E3D9; Fri, 10 Jan 2025 14:18:13 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 4/9] ppc/ppc405: Remove storage control (SLER) SPR
Date: Fri, 10 Jan 2025 15:17:55 +0100
Message-ID: <20250110141800.1587589-5-clg@redhat.com>
In-Reply-To: <20250110141800.1587589-1-clg@redhat.com>
References: <20250110141800.1587589-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since the 405 CPU family was phased out, the SLER SPR has no users
anymore.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 target/ppc/cpu.h         |  2 --
 target/ppc/helper.h      |  1 -
 target/ppc/spr_common.h  |  1 -
 target/ppc/helper_regs.c | 10 ----------
 target/ppc/misc_helper.c |  5 -----
 target/ppc/translate.c   |  6 ------
 6 files changed, 25 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0fe44cedb1b3..2f3741860076 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1620,7 +1620,6 @@ void cpu_ppc_store_purr(CPUPPCState *env, uint64_t value);
 target_ulong load_40x_pit(CPUPPCState *env);
 void store_40x_pit(CPUPPCState *env, target_ulong val);
 void store_40x_dbcr0(CPUPPCState *env, uint32_t val);
-void store_40x_sler(CPUPPCState *env, uint32_t val);
 void store_40x_tcr(CPUPPCState *env, target_ulong val);
 void store_40x_tsr(CPUPPCState *env, target_ulong val);
 void store_booke_tcr(CPUPPCState *env, target_ulong val);
@@ -2172,7 +2171,6 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_7XX_PMC1          (0x3B9)
 #define SPR_7XX_PMC2          (0x3BA)
 #define SPR_7XX_SIAR          (0x3BB)
-#define SPR_405_SLER          (0x3BB)
 #define SPR_7XX_MMCR1         (0x3BC)
 #define SPR_405_SU0R          (0x3BC)
 #define SPR_401_SKR           (0x3BC)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 5a77e761bd3f..86f3bbc087f6 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -753,7 +753,6 @@ DEF_HELPER_FLAGS_2(store_40x_tcr, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_2(store_40x_tsr, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_2(store_40x_pid, void, env, tl)
 DEF_HELPER_2(store_40x_dbcr0, void, env, tl)
-DEF_HELPER_2(store_40x_sler, void, env, tl)
 DEF_HELPER_FLAGS_2(store_booke_tcr, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_2(store_booke_tsr, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_3(store_ibatl, void, env, i32, tl)
diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
index 01aff449bccc..e98fb07bb285 100644
--- a/target/ppc/spr_common.h
+++ b/target/ppc/spr_common.h
@@ -138,7 +138,6 @@ void spr_write_sdr1(DisasContext *ctx, int sprn, int gprn);
 void spr_read_40x_pit(DisasContext *ctx, int gprn, int sprn);
 void spr_write_40x_pit(DisasContext *ctx, int sprn, int gprn);
 void spr_write_40x_dbcr0(DisasContext *ctx, int sprn, int gprn);
-void spr_write_40x_sler(DisasContext *ctx, int sprn, int gprn);
 void spr_write_40x_tcr(DisasContext *ctx, int sprn, int gprn);
 void spr_write_40x_tsr(DisasContext *ctx, int sprn, int gprn);
 void spr_write_40x_pid(DisasContext *ctx, int sprn, int gprn);
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 3ad4273c1649..1e5ba9a1c64b 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -354,16 +354,6 @@ int hreg_store_msr(CPUPPCState *env, target_ulong value, int alter_hv)
 }
 
 #ifndef CONFIG_USER_ONLY
-void store_40x_sler(CPUPPCState *env, uint32_t val)
-{
-    /* XXX: TO BE FIXED */
-    if (val != 0x00000000) {
-        cpu_abort(env_cpu(env),
-                  "Little-endian regions are not supported by now\n");
-    }
-    env->spr[SPR_405_SLER] = val;
-}
-
 void check_tlb_flush(CPUPPCState *env, bool global)
 {
     CPUState *cs = env_cpu(env);
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index f0ca80153b2b..78bb29d441a7 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -404,11 +404,6 @@ void helper_store_40x_dbcr0(CPUPPCState *env, target_ulong val)
     /* Bits 28 & 29 affect reset or shutdown. */
     store_40x_dbcr0(env, val);
 }
-
-void helper_store_40x_sler(CPUPPCState *env, target_ulong val)
-{
-    store_40x_sler(env, val);
-}
 #endif
 
 /*****************************************************************************/
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 80638ab53597..918bf8f3a0cc 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -967,12 +967,6 @@ void spr_write_40x_dbcr0(DisasContext *ctx, int sprn, int gprn)
     ctx->base.is_jmp = DISAS_EXIT_UPDATE;
 }
 
-void spr_write_40x_sler(DisasContext *ctx, int sprn, int gprn)
-{
-    translator_io_start(&ctx->base);
-    gen_helper_store_40x_sler(tcg_env, cpu_gpr[gprn]);
-}
-
 void spr_write_40x_tcr(DisasContext *ctx, int sprn, int gprn)
 {
     translator_io_start(&ctx->base);
-- 
2.47.1


