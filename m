Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABEEC25B4F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 18:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s437R-0000vv-RY; Mon, 06 May 2024 14:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1s436E-0000Sw-6Y
 for qemu-devel@nongnu.org; Mon, 06 May 2024 14:30:10 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1s436B-0006lp-61
 for qemu-devel@nongnu.org; Mon, 06 May 2024 14:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=GJF+Sz6x4AUpNN0GfoyFi916cCA6Pbkoi+xPdgr51OQ=; b=KLBYfskOO58Eouz
 l7gjXynTSy27s70Y3/tLkAitHQx7AJw+zoR7AsecWPHAiApQGkfwiJSmkODgZFr7r3adI1en5/vL/
 PTGSbvHZ4kg2AmfnAFP7688HrI/8x7JZBY01/+I4cBdirHJdksNM3NoGnSLHYfn06Ea/DvTEYV9Sp
 dE=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng,
	ltaylorsimpson@gmail.com,
	bcain@quicinc.com
Subject: [PATCH 4/4] target/hexagon: idef-parser simplify predicate init
Date: Mon,  6 May 2024 20:31:17 +0200
Message-ID: <20240506183117.32268-5-anjo@rev.ng>
In-Reply-To: <20240506183117.32268-1-anjo@rev.ng>
References: <20240506183117.32268-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
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

Only predicate instruction arguments need to be initialized by
idef-parser. This commit removes registers from the init_list and
simplifies gen_inst_init_args() slightly.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hexagon/idef-parser/idef-parser.y    |  2 --
 target/hexagon/idef-parser/parser-helpers.c | 20 +++++++++-----------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/target/hexagon/idef-parser/idef-parser.y b/target/hexagon/idef-parser/idef-parser.y
index cd2612eb8c..9ffb9f9699 100644
--- a/target/hexagon/idef-parser/idef-parser.y
+++ b/target/hexagon/idef-parser/idef-parser.y
@@ -233,8 +233,6 @@ code : '{' statements '}'
 argument_decl : REG
                 {
                     emit_arg(c, &@1, &$1);
-                    /* Enqueue register into initialization list */
-                    g_array_append_val(c->inst.init_list, $1);
                 }
               | PRED
                 {
diff --git a/target/hexagon/idef-parser/parser-helpers.c b/target/hexagon/idef-parser/parser-helpers.c
index bae01c2bb8..33e8f82007 100644
--- a/target/hexagon/idef-parser/parser-helpers.c
+++ b/target/hexagon/idef-parser/parser-helpers.c
@@ -1652,26 +1652,24 @@ void gen_inst(Context *c, GString *iname)
 
 
 /*
- * Initialize declared but uninitialized registers, but only for
- * non-conditional instructions
+ * Initialize declared but uninitialized instruction arguments. Only needed for
+ * predicate arguments, initialization of registers is handled by the Hexagon
+ * frontend.
  */
 void gen_inst_init_args(Context *c, YYLTYPE *locp)
 {
+    /* If init_list is NULL arguments have already been initialized */
     if (!c->inst.init_list) {
         return;
     }
 
     for (unsigned i = 0; i < c->inst.init_list->len; i++) {
         HexValue *val = &g_array_index(c->inst.init_list, HexValue, i);
-        if (val->type == REGISTER_ARG) {
-            /* Nothing to do here */
-        } else if (val->type == PREDICATE) {
-            char suffix = val->is_dotnew ? 'N' : 'V';
-            EMIT_HEAD(c, "tcg_gen_movi_i%u(P%c%c, 0);\n", val->bit_width,
-                      val->pred.id, suffix);
-        } else {
-            yyassert(c, locp, false, "Invalid arg type!");
-        }
+        yyassert(c, locp, val->type == PREDICATE,
+                 "Only predicates need to be initialized!");
+        char suffix = val->is_dotnew ? 'N' : 'V';
+        EMIT_HEAD(c, "tcg_gen_movi_i%u(P%c%c, 0);\n", val->bit_width,
+                  val->pred.id, suffix);
     }
 
     /* Free argument init list once we have initialized everything */
-- 
2.44.0


