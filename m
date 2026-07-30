Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E57DC54FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH7h-0005UB-Gj; Wed, 29 Jul 2026 23:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH7H-0004gW-KQ
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:27 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH7F-000312-Vk
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=2vGWytjTwZWET4H4FTbOQuyUsF34x6Z1y1ZwobIFReg=; b=IHaKI+aKDHXx5Rv
 EQy2hJcQupVOTsm0N6kWmKquhEOmEsGsm2LS80b3NIuBddj8KOP6w0Lx0dE3mWU5nc/NsL853XeLP
 rqwt0nvstV/QKXH8tHp05qGAWuoL8Hl4EdjU2hrL2vPRZdrv/Ddo/bUPa90pAal1HgcgQTMGoQDtl
 IM=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 41/50] target/hexagon: Add get_tb_mmu_index()
Date: Thu, 30 Jul 2026 05:10:15 +0200
Message-ID: <20260730031025.12926-42-anjo@rev.ng>
In-Reply-To: <20260730031025.12926-1-anjo@rev.ng>
References: <20260730031025.12926-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Adds a functions to return the current mmu index given tb_flags of the
current translation block.  Required by helper-to-tcg in order to
retrieve the mmu index for memory operations without changing the
signature of helper functions.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hexagon/translate.c | 12 ++++++++++++
 target/hexagon/translate.h |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 199b4f8c2e..bfd84bba4e 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -128,6 +128,18 @@ intptr_t ctx_tmp_vreg_off(DisasContext *ctx, int regnum,
     return offset;
 }
 
+#if defined(TARGET_HELPER_TO_TCG)
+/*
+ * Returns the current mmu index given tb_flags of the current translation
+ * block.  Required by helper-to-tcg in order to retrieve the mmu index for
+ * memory operations without changing the signature of helper functions.
+ */
+int get_tb_mmu_index(uint32_t flags)
+{
+    return FIELD_EX32(flags, TB_FLAGS, MMU_INDEX);
+}
+#endif
+
 static void gen_exception(int excp, uint32_t PC)
 {
     gen_helper_raise_exception(tcg_env, tcg_constant_i32(excp),
diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index 2fca157553..6cf3b2fe3b 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -345,4 +345,8 @@ FIELD(PROBE_PKT_SCALAR_HVX_STORES, MMU_IDX,        5, 2)
 
 void gen_framecheck(DisasContext *ctx, TCGv_i32 addr, TCGv_i32 ea);
 
+#if defined(TARGET_HELPER_TO_TCG)
+int get_tb_mmu_index(uint32_t flags);
+#endif
+
 #endif
-- 
2.52.0


