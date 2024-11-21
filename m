Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065D5D743FD
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwJ9-0004vT-GW; Wed, 20 Nov 2024 20:48:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwJ6-0004uZ-18
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:48:33 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwJ4-0004lT-Pp
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=iuOj1a1gnKZAf92H8D0zYKZjKUE/7EIVKEMc77kWSCk=; b=a6hf772In8tH27c
 Bk6u9m1sqobXM9d/HLRAN1vg5TBsGQOz4ebrw0VSbWKr8z4vEzDuZA38MJ7MV+5PKADwFEWN+SQxa
 MVS52J0VRGKhko4Dep23o9QAG1Naj2vYYWBsLTStyKw1kEdyr9gwyx40oTUlj1WfkJFvheWPwNtDE
 M4=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 39/43] target/hexagon: Keep gen_slotval/check_noshuf
 for helper-to-tcg
Date: Thu, 21 Nov 2024 02:49:43 +0100
Message-ID: <20241121014947.18666-40-anjo@rev.ng>
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

Makes sure gen_slotval() and check_noshuf() remains defined when
helper-to-tcg and idef-parser are both used.  gen_slotval() is needed
for creating a TCGv of the slot value fed to helpers (generated
helper-to-tcg code), and check_noshuf() is needed for helper definitions
used as input to helper-to-tcg.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hexagon/genptr.c    | 2 +-
 target/hexagon/op_helper.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index dbae6c570a..ea3ccf649a 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -399,7 +399,7 @@ static inline void gen_store_conditional8(DisasContext *ctx,
     tcg_gen_movi_tl(hex_llsc_addr, ~0);
 }
 
-#ifndef CONFIG_HEXAGON_IDEF_PARSER
+#if !defined(CONFIG_HEXAGON_IDEF_PARSER) || defined(CONFIG_HELPER_TO_TCG)
 static TCGv gen_slotval(DisasContext *ctx)
 {
     int slotval = (ctx->pkt->pkt_has_store_s1 & 1) | (ctx->insn->slot << 1);
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 90e7aaa097..0f9c6ab19f 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -567,7 +567,7 @@ void HELPER(probe_pkt_scalar_hvx_stores)(CPUHexagonState *env, int mask)
     }
 }
 
-#ifndef CONFIG_HEXAGON_IDEF_PARSER
+#if !defined(CONFIG_HEXAGON_IDEF_PARSER) || defined(CONFIG_HELPER_TO_TCG)
 /*
  * mem_noshuf
  * Section 5.5 of the Hexagon V67 Programmer's Reference Manual
-- 
2.45.2


