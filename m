Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DE2C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz8n0-0001hV-US; Wed, 26 Aug 2026 04:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wz8mx-0001gC-Lv
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:15:15 -0400
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wz8mv-0000oX-Cm
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:15:15 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20260826081504epoutp035e51bdaa7ac3951d43875b41e5dbd5e1~PTOCbr-vH1885418854epoutp03c
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 08:15:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20260826081504epoutp035e51bdaa7ac3951d43875b41e5dbd5e1~PTOCbr-vH1885418854epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1787732104;
 bh=ziyb5Srv8be4vjbuZR5zJAzHI58TQNlpseKjs9DHxak=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lQyNlJWzVUoVAVRjc9Qv3H6VfSYi2fN6UBPGY3gGZ48n45o7XOvONKp70lQcPxv5T
 DiZNV908rwtQAOJ1U3pZJXykj7+hilQSGQsHfWfK8TxmBnL1TdpVyJphkpklVs/0tC
 TUnfOK/b9QCnGc4UAQWr8jkBR4s+iIv/ul8zoJFY=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
 20260826081503epcas5p33361c4dded308ed6a0e71d62a394524e~PTOBkRF0S1852318523epcas5p3A;
 Wed, 26 Aug 2026 08:15:03 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4hVHWW4xFsz6B9mC; Wed, 26 Aug
 2026 08:15:03 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20260826052035epcas5p2b479db213a421f1e2a184bdff593e7e1~PQ1r2ZCU73052030520epcas5p28;
 Wed, 26 Aug 2026 05:20:35 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
 by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260826052033epsmtip20884dbde8099bcc334171c7358d77306~PQ1qO5Hz_1150511505epsmtip2B;
 Wed, 26 Aug 2026 05:20:33 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, junjie.cao@intel.com, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, qemu-devel@nongnu.org
Cc: shrihari.s@samsung.com, arun.george@samsung.com, cpgs@samsung.com,
 dave@stgolabs.net, dongjoo.seo1@samsung.com, gost.dev@samsung.com,
 s.neeraj@samsung.com, vikash.k5@samsung.com
Subject: [RFC V2 04/10] hw/cxl: Add Streamlined Virtual Channel (SVC)
 property to CXL ports
Date: Wed, 26 Aug 2026 11:04:04 +0530
Message-Id: <278240974.81787732103676.JavaMail.epsvc@epcpadp1new>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826053410.1322176-1-shrihari.s@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260826052035epcas5p2b479db213a421f1e2a184bdff593e7e1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260826052035epcas5p2b479db213a421f1e2a184bdff593e7e1
References: <20260826053410.1322176-1-shrihari.s@samsung.com>
 <CGME20260826052035epcas5p2b479db213a421f1e2a184bdff593e7e1@epcas5p2.samsung.com>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=shrihari.s@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add Unordered IO (UIO) dependent property SVC to CXL ports.

The following properties are added to CXL ports:
    - x-svc: To enable SVC capability in the port

Note: 256B flit mode property was already added in CXL ports, so reused it.

Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
---
 hw/pci-bridge/cxl_downstream.c | 1 +
 hw/pci-bridge/cxl_upstream.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 7c7a1d1221..1c8c3b4636 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -260,6 +260,7 @@ static const Property cxl_dsp_props[] = {
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_16),
     DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, true),
+    DEFINE_PROP_BOOL("x-svc", PCIEPort, svc, false),
 };
 
 static void cxl_dsp_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index ef5480b116..999ee0b56b 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -437,6 +437,7 @@ static const Property cxl_upstream_props[] = {
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLUpstreamPort,
                                 width, PCIE_LINK_WIDTH_16),
     DEFINE_PROP_BOOL("x-256b-flit", CXLUpstreamPort, flitmode, false),
+    DEFINE_PROP_BOOL("x-svc", PCIEPort, svc, false),
 };
 
 static void cxl_upstream_class_init(ObjectClass *oc, const void *data)
-- 
2.34.1



