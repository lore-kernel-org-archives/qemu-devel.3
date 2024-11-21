Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC17D743FE
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwK1-0007Wp-Ls; Wed, 20 Nov 2024 20:49:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwK0-0007G3-1z
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:49:28 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwJy-0004sv-I8
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:49:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=v6yNgUtqmAbkKUCCRshTh81ZOJJ3PLSMzGXN2kDgk8Q=; b=xS8Fw53VsdnzzE6
 YRiEaY0hJrpW902X1vcnNeE6nQ9lUswJNRvHrwUzEme39lYv4HTz7WgVY2KimuNl3sSQijDIcqr2U
 FlvJyLuajDjmsqmXGWUX5MBp/HBmxAP6DVRMslk2RBTp6zFA42URNpIG8F+BZD7TQr+okFwzgYi4X
 ik=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 37/43] target/hexagon: Make HVX vector args. restrict *
Date: Thu, 21 Nov 2024 02:49:41 +0100
Message-ID: <20241121014947.18666-38-anjo@rev.ng>
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

If pointer arguments to HVX helper functions are not marked restrict *,
then LLVM will assume that input vectors may alias and emit runtime
checks.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hexagon/mmvec/macros.h | 36 +++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros.h
index 1ceb9453ee..dfaefc6b26 100644
--- a/target/hexagon/mmvec/macros.h
+++ b/target/hexagon/mmvec/macros.h
@@ -23,26 +23,26 @@
 #include "mmvec/system_ext_mmvec.h"
 
 #ifndef QEMU_GENERATE
-#define VdV      (*(MMVector *)(VdV_void))
-#define VsV      (*(MMVector *)(VsV_void))
-#define VuV      (*(MMVector *)(VuV_void))
-#define VvV      (*(MMVector *)(VvV_void))
-#define VwV      (*(MMVector *)(VwV_void))
-#define VxV      (*(MMVector *)(VxV_void))
-#define VyV      (*(MMVector *)(VyV_void))
+#define VdV      (*(MMVector * restrict)(VdV_void))
+#define VsV      (*(MMVector * restrict)(VsV_void))
+#define VuV      (*(MMVector * restrict)(VuV_void))
+#define VvV      (*(MMVector * restrict)(VvV_void))
+#define VwV      (*(MMVector * restrict)(VwV_void))
+#define VxV      (*(MMVector * restrict)(VxV_void))
+#define VyV      (*(MMVector * restrict)(VyV_void))
 
-#define VddV     (*(MMVectorPair *)(VddV_void))
-#define VuuV     (*(MMVectorPair *)(VuuV_void))
-#define VvvV     (*(MMVectorPair *)(VvvV_void))
-#define VxxV     (*(MMVectorPair *)(VxxV_void))
+#define VddV     (*(MMVectorPair * restrict)(VddV_void))
+#define VuuV     (*(MMVectorPair * restrict)(VuuV_void))
+#define VvvV     (*(MMVectorPair * restrict)(VvvV_void))
+#define VxxV     (*(MMVectorPair * restrict)(VxxV_void))
 
-#define QeV      (*(MMQReg *)(QeV_void))
-#define QdV      (*(MMQReg *)(QdV_void))
-#define QsV      (*(MMQReg *)(QsV_void))
-#define QtV      (*(MMQReg *)(QtV_void))
-#define QuV      (*(MMQReg *)(QuV_void))
-#define QvV      (*(MMQReg *)(QvV_void))
-#define QxV      (*(MMQReg *)(QxV_void))
+#define QeV      (*(MMQReg * restrict)(QeV_void))
+#define QdV      (*(MMQReg * restrict)(QdV_void))
+#define QsV      (*(MMQReg * restrict)(QsV_void))
+#define QtV      (*(MMQReg * restrict)(QtV_void))
+#define QuV      (*(MMQReg * restrict)(QuV_void))
+#define QvV      (*(MMQReg * restrict)(QvV_void))
+#define QxV      (*(MMQReg * restrict)(QxV_void))
 #endif
 
 #define LOG_VTCM_BYTE(VA, MASK, VAL, IDX) \
-- 
2.45.2


