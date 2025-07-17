Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56271C83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 08:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucgJW-00080D-4U; Fri, 18 Jul 2025 04:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ayush.m55@samsung.com>)
 id 1ucgJP-0007v0-Hw
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 04:19:23 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ayush.m55@samsung.com>)
 id 1ucgJG-0001Tz-5t
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 04:19:21 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20250718081901epoutp0242567e894b32aa1f3b31e306f1e371c2~TSqJ-acXK1583415834epoutp02C
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 08:19:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20250718081901epoutp0242567e894b32aa1f3b31e306f1e371c2~TSqJ-acXK1583415834epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1752826741;
 bh=cOokfbc9c4TzXNfl5s7zwonsIacN1OcYbXez7r/js4E=;
 h=From:To:Cc:Subject:Date:References:From;
 b=b94aNm6JWdUmyBiUhJMbaclomPhCJ8CebGKLc8x+iukeQbpr8IA+kEP3ymFO+R614
 qtC3s8OmFU/rLs+lXCyhftoN+XT5PqvDmlwjI1+xpr1JY3IXWyFnW7jLB7VyTwdRRC
 yrHWjhxOec1sSe0+0Ib7QcFe9AVYUoVM3BVt2oHM=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
 20250718081901epcas5p229d3b2b026d147947d0a48130e1cbee2~TSqJh17Zr2839428394epcas5p2w;
 Fri, 18 Jul 2025 08:19:01 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.94]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4bk2kX40PVz3hhTH; Fri, 18 Jul
 2025 08:19:00 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20250717114154epcas5p3a532088018909ae109f726c8f8518fab~TByAtw5at1458814588epcas5p3S;
 Thu, 17 Jul 2025 11:41:54 +0000 (GMT)
Received: from test-X570-AORUS-ULTRA.samsungds.net (unknown [107.99.41.42])
 by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20250717114154epsmtip2a8df438e17b0982331ed96e2c1f61dc3~TByABHuTG1245312453epsmtip2f;
 Thu, 17 Jul 2025 11:41:53 +0000 (GMT)
From: Ayush Mishra <ayush.m55@samsung.com>
To: qemu-devel@nongnu.org
Cc: kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, Ayush Mishra
 <ayush.m55@samsung.com>
Subject: [PATCH 0/2] hw/nvme: Add support for LID 00h and LID 12h
Date: Thu, 17 Jul 2025 16:50:27 +0530
Message-ID: <20250717112029.28242-1-ayush.m55@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250717114154epcas5p3a532088018909ae109f726c8f8518fab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250717114154epcas5p3a532088018909ae109f726c8f8518fab
References: <CGME20250717114154epcas5p3a532088018909ae109f726c8f8518fab@epcas5p3.samsung.com>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=ayush.m55@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series adds support for:
- Log Page ID 0x00: Supported Log Pages
- Log Page ID 0x12: Feature Identifiers Supported and Effects

These changes improve compliance with newer NVMe specifications and enhance introspection capabilities for NVMe devices under QEMU.

Tested using:
- Custom log page queries from guest OS
- Manual validation of returned data structures

Regards,
Ayush Mishra

Ayush Mishra (2):
  hw/nvme: Adding support for LID 0x00- Supported Log Pages
  hw/nvme: Adding Support for Feature Identifiers Supported and Effects
    (Log Identifier 12h)

 hw/nvme/ctrl.c       | 95 ++++++++++++++++++++++++++++++++++++++++++++
 hw/nvme/nvme.h       |  2 +
 include/block/nvme.h | 32 +++++++++++++++
 3 files changed, 129 insertions(+)

-- 
2.43.0


