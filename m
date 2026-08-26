Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F3CC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz8mx-0001fw-Pl; Wed, 26 Aug 2026 04:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wz8mv-0001fW-Vt
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:15:14 -0400
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wz8mt-0000eE-6v
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:15:13 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20260826081503epoutp019d6c9c2f5665f3b0a014d494275e0255~PTOBKkSdG0680806808epoutp01H
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 08:15:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20260826081503epoutp019d6c9c2f5665f3b0a014d494275e0255~PTOBKkSdG0680806808epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1787732103;
 bh=SQXj/9l+rMnTTINxJGJSqKcLnI0ozzZ6odUUtMvj6p4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=I5WdMq3azXXkLv+jxSYz0vz2RHhrTiQm0wDH2xw/KanZe7g6Ps2gUvJZ4tl2yHxcQ
 OTrID+x2h3a3ae6t+l0IiJfxmgA8K8CPSed37plwSVdLcmmWUPce8nebU6pR1kc2WB
 4H2QZOrL9JzdGdf5J4Pbw5WWVdgErJ08Z/nfgTeE=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
 20260826081502epcas5p1d625b17183fd73fff7774bfe5582e8fb~PTOA4kgfg2310023100epcas5p1E;
 Wed, 26 Aug 2026 08:15:02 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
 epsnrtp01.localdomain (Postfix) with ESMTP id 4hVHWV6q8Gz6B9mN; Wed, 26 Aug
 2026 08:15:02 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20260826052029epcas5p202545a5a4a264b9f9dd7a33cbbaf1b1d~PQ1mOQfKc3052030520epcas5p2n;
 Wed, 26 Aug 2026 05:20:29 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
 by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260826052027epsmtip28d5be75a0fded45a17fa2cabe0260588~PQ1knCxqA1126911269epsmtip2A;
 Wed, 26 Aug 2026 05:20:27 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, junjie.cao@intel.com, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, qemu-devel@nongnu.org
Cc: shrihari.s@samsung.com, arun.george@samsung.com, cpgs@samsung.com,
 dave@stgolabs.net, dongjoo.seo1@samsung.com, gost.dev@samsung.com,
 s.neeraj@samsung.com, vikash.k5@samsung.com
Subject: [RFC V2 02/10] hw/pci: Move 'x-256b-flit' property from
 cxl_root_port to pcie_root_port.
Date: Wed, 26 Aug 2026 11:04:02 +0530
Message-Id: <111374580.41787732102942.JavaMail.epsvc@epcpadp1new>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826053410.1322176-1-shrihari.s@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260826052029epcas5p202545a5a4a264b9f9dd7a33cbbaf1b1d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260826052029epcas5p202545a5a4a264b9f9dd7a33cbbaf1b1d
References: <20260826053410.1322176-1-shrihari.s@samsung.com>
 <CGME20260826052029epcas5p202545a5a4a264b9f9dd7a33cbbaf1b1d@epcas5p2.samsung.com>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=shrihari.s@samsung.com; helo=mailout1.samsung.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Relocate 'x-256b-flit' property from cxl_root_port to its parent
pcie_root_port so that both can utilize this property.

This is a pure refactor and does not impact any existing behavior.

Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
---
 hw/pci-bridge/cxl_root_port.c  | 1 -
 hw/pci-bridge/pcie_root_port.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index df69c5200f..e82685d1ab 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -237,7 +237,6 @@ static const Property gen_rp_props[] = {
                                 speed, PCIE_LINK_SPEED_64),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_32),
-    DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, true),
 };
 
 static void cxl_rp_dvsec_write_config(PCIDevice *dev, uint32_t addr,
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index fe3ced5685..eeee24e042 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -152,6 +152,7 @@ static const Property rp_props[] = {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
     DEFINE_PROP_BOOL("disable-acs", PCIESlot, disable_acs, false),
+    DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, true),
 };
 
 static void rp_instance_post_init(Object *obj)
-- 
2.34.1



