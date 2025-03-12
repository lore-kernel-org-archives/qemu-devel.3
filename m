Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E450C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 19:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsS20-0001mp-9a; Wed, 12 Mar 2025 15:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tsS1E-0001h7-EI
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 15:45:33 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tsS19-0006N4-KI
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 15:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=lAJ7z9+A1MxQwCRsU5x2nT+Gzbox9DbplSabX+doYYY=; b=nHH1/J8JHpWBCzT
 HMR4eXE8vqK7/yIlg2dIypvT+CHLXfW067Tr9Zn4KH+mTtNVYyilDQLlwDrxbjrj5zZex7pluxHo3
 G+pt9PFfeFOmRODNlRR41G7VD/TgleVQ/13eYiOXWvzaEz42eD15uoHkAM6MzM2m/B+k7mj2l9INB
 QA=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, brian.cain@oss.qualcomm.com,
 philmd@linaro.org
Subject: [PATCH 2/2] target/hexagon: Drop `ident` postprocess step
Date: Wed, 12 Mar 2025 20:45:47 +0100
Message-ID: <20250312194547.7364-3-anjo@rev.ng>
In-Reply-To: <20250312194547.7364-1-anjo@rev.ng>
References: <20250312194547.7364-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The indent command is not available on a default mac osx setup with
xcode cli tools installed.  While it does make idef-parser generated
code nicer to debug, it's not crucial and can be dropped.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hexagon/meson.build | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
index abcf00ca1f..246dc7b241 100644
--- a/target/hexagon/meson.build
+++ b/target/hexagon/meson.build
@@ -323,30 +323,13 @@ if idef_parser_enabled and 'hexagon-linux-user' in target_dirs
         command: [idef_parser, '@INPUT@', '@OUTPUT0@', '@OUTPUT1@', '@OUTPUT2@']
     )
 
-    indent = find_program('indent', required: false)
-    if indent.found()
-        idef_generated_tcg_c = custom_target(
-            'indent',
-            input: idef_generated_tcg[0],
-            output: 'idef-generated-emitter.indented.c',
-            command: [indent, '-linux', '@INPUT@', '-o', '@OUTPUT@']
-        )
-    else
-        idef_generated_tcg_c = custom_target(
-            'copy',
-            input: idef_generated_tcg[0],
-            output: 'idef-generated-emitter.indented.c',
-            command: ['cp', '@INPUT@', '@OUTPUT@']
-        )
-    endif
-
     idef_generated_list = idef_generated_tcg[2].full_path()
 
-    hexagon_ss.add(idef_generated_tcg_c)
+    hexagon_ss.add(idef_generated_tcg[0])
 
     # Setup input and dependencies for the next step, this depends on whether or
     # not idef-parser is enabled
-    helper_dep = [semantics_generated, idef_generated_tcg_c, idef_generated_tcg]
+    helper_dep = [semantics_generated, idef_generated_tcg]
     helper_in = [semantics_generated, gen_tcg_h, gen_tcg_hvx_h, '--idef-parser', idef_generated_list]
 else
     # Setup input and dependencies for the next step, this depends on whether or
-- 
2.47.1


