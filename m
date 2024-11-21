Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E94D743FD
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwJM-0005EW-7P; Wed, 20 Nov 2024 20:48:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwJH-000583-Rq
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:48:43 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwJG-0004mp-GV
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:48:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=XQcHvwKeA4tB1CDjW/j9CD6mQBUj91ZRHILJBcsMegA=; b=OPxBex1NZfeN/EC
 wRovIjE4FSRL9AjG+jVw4fn4xV184i4Cfu7lNXifikh0zauwP29m0NKkh3qUVCldYUKwr91du7Noq
 NDSP7vHnOEGBYQpewS/rnHSj+Rp4oqNJoa7zQgchfKp3z6yetuN3K86J37x8hSNr9OCwuM4UXgy12
 fM=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 36/43] target/hexagon: Add temporary vector storage
Date: Thu, 21 Nov 2024 02:49:40 +0100
Message-ID: <20241121014947.18666-37-anjo@rev.ng>
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

Temporary vectors in helper-to-tcg generated code are allocated from an
array of bytes in CPUArchState, specified with --temp-vector-block.

This commits adds such a block of memory to CPUArchState, if
CONFIG_HELPER_TO_TCG is set.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hexagon/cpu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 7be4b5769e..fa6ac83e01 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -97,6 +97,10 @@ typedef struct CPUArchState {
     MMVector future_VRegs[VECTOR_TEMPS_MAX] QEMU_ALIGNED(16);
     MMVector tmp_VRegs[VECTOR_TEMPS_MAX] QEMU_ALIGNED(16);
 
+#ifdef CONFIG_HELPER_TO_TCG
+    uint8_t tmp_vmem[4096] QEMU_ALIGNED(16);
+#endif
+
     MMQReg QRegs[NUM_QREGS] QEMU_ALIGNED(16);
     MMQReg future_QRegs[NUM_QREGS] QEMU_ALIGNED(16);
 
-- 
2.45.2


