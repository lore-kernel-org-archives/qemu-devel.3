Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED38C54FCD
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH7h-0005US-LA; Wed, 29 Jul 2026 23:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH7J-0004hR-E0
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:31 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH7I-00031M-1O
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=KrUA14IUsSbr9Wds92GLD313FBynG/oxdLVdhWG7UhE=; b=XekgEHj6ybrt2rk
 FRLDRJKohelF5ibk5bfUpdfffWuHM5k/EFIOZDIYyxe0l87mBW53GRlHZyLID2O3vHRn26c0MP8J7
 qAlEtXh71z6JL+ybLFxykEZ0aL9hTo1PSVxgiO/SElYUadlAp5keIZYrj9z3mW8COsupHpp7EaIDr
 Xs=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 42/50] target/hexagon: Increase VECTOR_TEMPS_MAX
Date: Thu, 30 Jul 2026 05:10:16 +0200
Message-ID: <20260730031025.12926-43-anjo@rev.ng>
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

Doubles the number of vector temporaries from 4 to 8, useful when
emitting vector instructions with helper-to-tcg to handle more
complicated helpers.  `tmp_VRegs` must be later specified later to
`helper-to-tcg` through `--temp-vector-block=tmp_VRegs`.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hexagon/cpu.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 7694fd91fa..02ac011632 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -117,7 +117,7 @@ typedef struct {
 #define SET_EXCEPTION           (env->status |= EXEC_STATUS_EXCEPTION)
 
 /* Maximum number of vector temps in a packet */
-#define VECTOR_TEMPS_MAX            4
+#define VECTOR_TEMPS_MAX            8
 
 typedef struct CPUArchState {
     target_ulong gpr[TOTAL_PER_THREAD_REGS];
@@ -160,6 +160,10 @@ typedef struct CPUArchState {
     MMVector future_VRegs[VECTOR_TEMPS_MAX] QEMU_ALIGNED(16);
     MMVector tmp_VRegs[VECTOR_TEMPS_MAX] QEMU_ALIGNED(16);
 
+#ifdef TARGET_HELPER_TO_TCG
+    uint8_t tmp_vmem[4096] QEMU_ALIGNED(16);
+#endif
+
     MMQReg QRegs[NUM_QREGS] QEMU_ALIGNED(16);
     MMQReg future_QRegs[NUM_QREGS] QEMU_ALIGNED(16);
 
-- 
2.52.0


