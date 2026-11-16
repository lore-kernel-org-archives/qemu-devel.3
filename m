Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F32606A329
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=ZDb1KbrJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3PB-0006Fh-4z; Mon, 16 Nov 2026 15:34:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Ms-0002EC-R5; Mon, 16 Nov 2026 15:32:11 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Mf-0004ip-52; Mon, 16 Nov 2026 15:31:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860767; bh=mZUm6xTh3/cuzmJw3eBEPERmqphBaRT94JY3IJ2ClJs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZDb1KbrJZYdagQfjrMcxZ9O4nxIMYsj7vC4rNlRRUDsevBhs5UmwDngqO19lqu77A
 zjLBvYer+w6MHDcUFbbcECxf/dxo6nukvo7pD4xXlc03SoiHpi5NJaVxlqBxb14Z8l
 227e5G7JTh1xx/w/qKdlyyMhhMsiyijw72Gy7e4c+fCs5Qg0+JA+2al3cEIlGz1Hmi
 2AUvAP+90pU3jKmhkMJx/TrOY8u4Xogit0+m4khVdb5VmP9+P2LABshv41oqCOAJX7
 sjVzv6YA3vuKlyDySWIrTYsnQwjm1M+9T2tEOLnDiicEOWd+12OpzTu0lEyuOw+1iS
 VCXdeAI2UsrVA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EC02C1E71CA;
 Mon, 16 Nov 2026 23:26:07 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E930145FBF5;
 Mon, 16 Nov 2026 23:26:07 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id E2D5AB8EAE; Mon, 16 Nov 2026 23:26:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 52/63] block/vmdk: Avoid overflowing multiplication in
 vmdk_open_vmdk4()
Date: Mon, 16 Nov 2026 23:25:31 +0300
Message-ID: <20261116202554.535325-52-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

In vmdk_open_vmdk4() we set the uint32_t l1_entry_sectors with:
    l1_entry_sectors = le32_to_cpu(header.num_gtes_per_gt)
                        * le64_to_cpu(header.granularity);

We have checked that num_gtes_per_gt is at most 512, but the
header.granularity has not been checked at this point, and so the
multiply can overflow the 32-bit variable.  This overflow is harmless
beacuse we're about to call vmdk_add_extent(), which will fail if the
header.granularity (cluster_sectors) is more than 0x20_0000, but it's
a potential trap for the future if code that relies on the
l1_entry_sectors value gets added between where we set it and where
we make that check.

Check for overlarge granularity at the point of multiplication so
it's clear we can't overflow.

Cc: qemu-stable@nongnu.org
Reported-by: Tristan <https://gitlab.com/TristanInSec>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4029
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261103143516.2182626-6-peter.maydell@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 43d614ab3a2dfbbe8549b4410aef5ff0b8b0c661)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/vmdk.c b/block/vmdk.c
index a9d32360a4f..473893370d9 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1050,7 +1050,10 @@ vmdk_open_vmdk4(BlockDriverState *bs, BdrvChild *file, int flags,
         error_setg(errp, "L2 table size too big");
         return -EINVAL;
     }
-
+    if (le64_to_cpu(header.granularity) > 0x200000) {
+        error_setg(errp, "Invalid granularity, image may be corrupt");
+        return -EFBIG;
+    }
     l1_entry_sectors = le32_to_cpu(header.num_gtes_per_gt)
                         * le64_to_cpu(header.granularity);
     if (l1_entry_sectors == 0) {
-- 
2.47.3


