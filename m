Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C0AC54FCD
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH7e-0005BT-By; Wed, 29 Jul 2026 23:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH7P-0004jM-Bk
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:38 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH7N-000329-V3
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=g3rR72cUu4RAZYghnI33FnwuTTm+/4Uy8+WhyZsLQnw=; b=orradDewPeiSYnV
 vSpobLq7bpQEpTQSnsSfxFFq8CaU5aHEEK26LxBxkamEz3XWLY1vYHYTCvjKbA0E19CgtFAGaXmkD
 9TLr5UcF+fphdh5T7tD2kLMagU7bcnrrM3tZXF1r5xeKtGIrHNmYPfgAnTYorDWBKJh4p3GCaAbJ+
 uU=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 46/50] target/hexagon: Split probe_and_commit helper
Date: Thu, 30 Jul 2026 05:10:20 +0200
Message-ID: <20260730031025.12926-47-anjo@rev.ng>
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

Split function into a slowpath such that the faster function can be
translated by helper-to-tcg.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hexagon/helper.h    |  1 +
 target/hexagon/op_helper.c | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index 033e5619d6..74d5b7ffe8 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -107,6 +107,7 @@ DEF_HELPER_4(probe_noshuf_load, void, env, i32, int, int)
 DEF_HELPER_2(probe_pkt_scalar_store_s0, void, env, int)
 DEF_HELPER_2(probe_hvx_stores, void, env, int)
 DEF_HELPER_2(probe_pkt_scalar_hvx_stores, void, env, int)
+DEF_HELPER_4(probe_and_commit, void, env, i32, s32, i64)
 
 #if !defined(CONFIG_USER_ONLY)
 DEF_HELPER_3(raise_stack_overflow, void, env, i32, i32)
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 1a067cd1ce..c175cecb71 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -488,7 +488,8 @@ void HELPER(probe_pkt_scalar_hvx_stores)(CPUHexagonState *env, int mask)
     }
 }
 
-#if !defined(CONFIG_HEXAGON_IDEF_PARSER) || defined(CONFIG_HELPER_TO_TCG)
+#if !defined(CONFIG_HEXAGON_IDEF_PARSER) || defined(TARGET_HELPER_TO_TCG)
+
 /*
  * mem_noshuf
  * Section 5.5 of the Hexagon V67 Programmer's Reference Manual
@@ -500,8 +501,18 @@ static void check_noshuf(CPUHexagonState *env, bool pkt_has_scalar_store_s1,
                          uint32_t slot, target_ulong vaddr, int size,
                          uintptr_t ra)
 {
-    if (slot == 0 && pkt_has_scalar_store_s1 &&
-        ((env->slot_cancelled & (1 << 1)) == 0)) {
+    if (slot == 0 && pkt_has_scalar_store_s1) {
+        helper_probe_and_commit(env, vaddr, size, ra);
+    }
+}
+
+/*
+ *
+ */
+void HELPER(probe_and_commit)(CPUHexagonState *env, target_ulong vaddr,
+                              int size, uintptr_t ra)
+{
+    if ((env->slot_cancelled & (1 << 1)) == 0) {
         probe_read(env, vaddr, size, MMU_USER_IDX, ra);
         commit_store(env, 1, ra);
     }
-- 
2.52.0


