Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D35C55160
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH7f-0005FP-D1; Wed, 29 Jul 2026 23:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH7T-0004mZ-Tz
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:40 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH7S-00033F-Hi
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=CgRS/dIhltOBSTrgSM2uh1yyyoZl/8xCL474UlnGPbo=; b=Nycr6vhUR+UbNRr
 56bWx24zikXlJtCkohsaX9YoyedG6kZkDCbSZi1Ay+jPaVc+0gbgIrLqrcfyV08XGuzHOKS+4GtiZ
 0trZ7O71cGHMxdGWdtMOY5kEwJFFmZsa66I8wqTYCbi+4dtuWnETtxkX0tMqUnr7hB7ARc7fDCL6G
 Uo=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 49/50] target/hexagon: Use idef-parser as a fallback
Date: Thu, 30 Jul 2026 05:10:23 +0200
Message-ID: <20260730031025.12926-50-anjo@rev.ng>
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

Only generate input functions to idef-parser for instructions which
failed to be translated by helper-to-tcg, and which have no overrides.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hexagon/gen_idef_parser_funcs.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/hexagon/gen_idef_parser_funcs.py b/target/hexagon/gen_idef_parser_funcs.py
index 32bce9b002..6bcc6e4bd0 100644
--- a/target/hexagon/gen_idef_parser_funcs.py
+++ b/target/hexagon/gen_idef_parser_funcs.py
@@ -49,10 +49,13 @@ def main():
     )
     parser.add_argument("semantics", help="semantics file")
     parser.add_argument("out", help="output file")
+    parser.add_argument("--helper-to-tcg", help="file of instructions translated by helper-to-tcg")
     args = parser.parse_args()
     hex_common.read_semantics_file(args.semantics)
     hex_common.calculate_attribs()
     hex_common.init_registers()
+    if args.helper_to_tcg:
+        hex_common.read_helper_to_tcg_enabled_file(args.helper_to_tcg)
     tagregs = hex_common.get_tagregs()
     tagimms = hex_common.get_tagimms()
 
@@ -62,6 +65,12 @@ def main():
         for tag in hex_common.tags:
             if hex_common.tag_ignore(tag):
                 continue
+            ## Skip instructions with overrides
+            if hex_common.skip_qemu_helper(tag):
+                continue
+            ## Skip instructions translated by helper-to-tcg
+            if hex_common.is_helper_to_tcg_enabled(tag):
+                continue
             ## Skip the priv instructions
             if "A_PRIV" in hex_common.attribdict[tag]:
                 continue
-- 
2.52.0


