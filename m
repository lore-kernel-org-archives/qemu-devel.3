Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E08D743FD
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwKE-0000uk-Co; Wed, 20 Nov 2024 20:49:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwKC-0000ei-OG
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:49:40 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwKB-0004uW-AA
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:49:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=dmXpWhtvpyPXyh2A6q90RECDvEn6x4P02umFqSdoGtk=; b=vU6S1umXgQtilM/
 Pkd0N6voSAC2bHfG5+dDtbRuWN1CxVF8Ja+TLYYBxpRkS4gplxar23AVLUMX/+tUmHk26LJBEZ/Mj
 KZ1Rz+mnd0k6RYLiU0tL/OeisqoJ5xBp1iGs9Kc02+j6PA+voZglQ3FlfFe4gWfuCBP0WK1eig+8/
 8k=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 42/43] target/hexagon: Only translate w. idef-parser if
 helper-to-tcg failed
Date: Thu, 21 Nov 2024 02:49:46 +0100
Message-ID: <20241121014947.18666-43-anjo@rev.ng>
In-Reply-To: <20241121014947.18666-1-anjo@rev.ng>
References: <20241121014947.18666-1-anjo@rev.ng>
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

Only generate input functions to idef-parser for instructions which
failed to be translated by helper-to-tcg.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hexagon/gen_idef_parser_funcs.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/hexagon/gen_idef_parser_funcs.py b/target/hexagon/gen_idef_parser_funcs.py
index 2f6e826f76..08ae94a646 100644
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
 
@@ -60,6 +63,9 @@ def main():
         f.write('#include "macros.h.inc"\n\n')
 
         for tag in hex_common.tags:
+            ## Skip instructions translated by helper-to-tcg
+            if hex_common.is_helper_to_tcg_enabled(tag):
+                continue
             ## Skip the priv instructions
             if "A_PRIV" in hex_common.attribdict[tag]:
                 continue
-- 
2.45.2


