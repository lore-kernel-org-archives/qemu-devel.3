Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B95E67482
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 14:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXKHW-0002Zt-80; Sun, 21 Dec 2025 09:19:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vXKHN-0002Zc-Mf
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:19:26 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vXKHK-00008p-St
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:19:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=WQ98TkzobVimMQoi/lkf046CuMEdeeKPobxJL4R4MVg=; b=s9QAXuoGtxWEPX0
 Amgiv5wG/LAhR+xSOJxX+EnU6TMggtqNLeQY3ez3IsPaT3sUreb021Dr/ujUABTDShZIpsd+k8AZw
 gugp547a6GsYGQv1oeZW+9JhCJuE3BossepJ/pN72QQ2dNY1E49iXhK/RsdQ0jhE+JBkm5v7kDomk
 rs=;
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com,
	Anton Johansson <anjo@rev.ng>
Subject: [PATCH] target/hexagon: Widen MemLog::width to 32 bits
Date: Sun, 21 Dec 2025 15:22:32 +0100
Message-ID: <20251221142232.22738-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

MemLog::width is a uint8_t value mapped to a TCGv (32 bit), the only
reason this currently works is because MemLog::width is padded to 32
bits.  Widen the field to uint32_t and fix the size of the TCGv
operations as well.  Use uint8_t when passing around the
field as an immediate to retain previous truncation behaviour.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hexagon/cpu.h       | 2 +-
 target/hexagon/op_helper.h | 4 ++--
 target/hexagon/translate.h | 2 +-
 target/hexagon/genptr.c    | 6 +++---
 target/hexagon/op_helper.c | 4 ++--
 target/hexagon/translate.c | 4 ++--
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 43a854f517..9d3df84ee6 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -46,7 +46,7 @@
 
 typedef struct {
     target_ulong va;
-    uint8_t width;
+    uint32_t width;
     uint32_t data32;
     uint64_t data64;
 } MemLog;
diff --git a/target/hexagon/op_helper.h b/target/hexagon/op_helper.h
index 66119cf3d4..ff65a94d57 100644
--- a/target/hexagon/op_helper.h
+++ b/target/hexagon/op_helper.h
@@ -20,8 +20,8 @@
 
 /* Misc functions */
 void log_store64(CPUHexagonState *env, target_ulong addr,
-                 int64_t val, int width, int slot);
+                 int64_t val, uint8_t width, int slot);
 void log_store32(CPUHexagonState *env, target_ulong addr,
-                 target_ulong val, int width, int slot);
+                 target_ulong val, uint8_t width, int slot);
 
 #endif
diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index d251e2233f..9e8f54edb5 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -271,7 +271,7 @@ extern TCGv hex_pred[NUM_PREGS];
 extern TCGv hex_slot_cancelled;
 extern TCGv hex_new_value_usr;
 extern TCGv hex_store_addr[STORES_MAX];
-extern TCGv hex_store_width[STORES_MAX];
+extern TCGv_i32 hex_store_width[STORES_MAX];
 extern TCGv hex_store_val32[STORES_MAX];
 extern TCGv_i64 hex_store_val64[STORES_MAX];
 extern TCGv hex_llsc_addr;
diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index cecaece4ae..9c66ca181a 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -401,10 +401,10 @@ static TCGv gen_slotval(DisasContext *ctx)
 }
 #endif
 
-void gen_store32(TCGv vaddr, TCGv src, int width, uint32_t slot)
+void gen_store32(TCGv vaddr, TCGv src, uint8_t width, uint32_t slot)
 {
     tcg_gen_mov_tl(hex_store_addr[slot], vaddr);
-    tcg_gen_movi_tl(hex_store_width[slot], width);
+    tcg_gen_movi_i32(hex_store_width[slot], width);
     tcg_gen_mov_tl(hex_store_val32[slot], src);
 }
 
@@ -444,7 +444,7 @@ void gen_store4i(TCGv_env tcg_env, TCGv vaddr, int32_t src, uint32_t slot)
 void gen_store8(TCGv_env tcg_env, TCGv vaddr, TCGv_i64 src, uint32_t slot)
 {
     tcg_gen_mov_tl(hex_store_addr[slot], vaddr);
-    tcg_gen_movi_tl(hex_store_width[slot], 8);
+    tcg_gen_movi_i32(hex_store_width[slot], 8);
     tcg_gen_mov_i64(hex_store_val64[slot], src);
 }
 
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index e2e80ca7ef..823307696d 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -52,7 +52,7 @@ G_NORETURN void HELPER(raise_exception)(CPUHexagonState *env, uint32_t excp)
 }
 
 void log_store32(CPUHexagonState *env, target_ulong addr,
-                 target_ulong val, int width, int slot)
+                 target_ulong val, uint8_t width, int slot)
 {
     env->mem_log_stores[slot].va = addr;
     env->mem_log_stores[slot].width = width;
@@ -60,7 +60,7 @@ void log_store32(CPUHexagonState *env, target_ulong addr,
 }
 
 void log_store64(CPUHexagonState *env, target_ulong addr,
-                 int64_t val, int width, int slot)
+                 int64_t val, uint8_t width, int slot)
 {
     env->mem_log_stores[slot].va = addr;
     env->mem_log_stores[slot].width = width;
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 8fce219c0d..6151bdd4a6 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -51,7 +51,7 @@ TCGv hex_pred[NUM_PREGS];
 TCGv hex_slot_cancelled;
 TCGv hex_new_value_usr;
 TCGv hex_store_addr[STORES_MAX];
-TCGv hex_store_width[STORES_MAX];
+TCGv_i32 hex_store_width[STORES_MAX];
 TCGv hex_store_val32[STORES_MAX];
 TCGv_i64 hex_store_val64[STORES_MAX];
 TCGv hex_llsc_addr;
@@ -1079,7 +1079,7 @@ void hexagon_translate_init(void)
             store_addr_names[i]);
 
         snprintf(store_width_names[i], NAME_LEN, "store_width_%d", i);
-        hex_store_width[i] = tcg_global_mem_new(tcg_env,
+        hex_store_width[i] = tcg_global_mem_new_i32(tcg_env,
             offsetof(CPUHexagonState, mem_log_stores[i].width),
             store_width_names[i]);
 
-- 
2.51.0


