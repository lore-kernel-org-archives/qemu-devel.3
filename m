Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F6CC30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 12:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPi5c-00017b-Ul; Fri, 05 Jul 2024 08:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sPi5U-0000yy-7q
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 08:30:53 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sPi5R-0007kU-HK
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 08:30:51 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFtBY4FlTz6HJcl;
 Fri,  5 Jul 2024 20:29:57 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id C98DB140B38;
 Fri,  5 Jul 2024 20:30:41 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 13:30:39 +0100
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: <shiju.jose@huawei.com>, Gregory Price <gregory.price@memverge.com>,
 <linuxarm@huawei.com>
Subject: [PATCH qemu v6 0/4] hw/cxl/cxl-mailbox-utils: Add feature commands,
 device patrol scrub control and DDR5 ECS control feature
Date: Fri, 5 Jul 2024 13:30:34 +0100
Message-ID: <20240705123039.963781-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

I believe this is ready to merge (I was holding it until DCD was
in place and that is upstream now)

Changes since v5:
- Include Gregory's patch to bring forward the renames.  Not strictly
  needed here, but a sensible change and it makes reordring my
  CXL staging tree a lot simpler.

Based-on: [PATCH qemu 0/4] hw/cxl: Add support for scan media
Message-id: 20240705120643.959422-1-Jonathan.Cameron@huawei.com

Add support for the feature commands, device patrol scrub control and
DDR5 ECS control features.

CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub control
feature.
CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 Error Check Scrub (ECS)
control feature.

This series is one of the test vehicles for the support of RAS feature
control in Linux and having it upstream would be useful to support that work.
There are also a lot more 'features' using the feature infrastructure
that are dependent on the first 2 patches.

Gregory Price (1):
  cxl/mailbox: move mailbox effect definitions to a header

Shiju Jose (3):
  hw/cxl/cxl-mailbox-utils: Add support for feature commands (8.2.9.6)
  hw/cxl/cxl-mailbox-utils: Add device patrol scrub control feature
  hw/cxl/cxl-mailbox-utils: Add device DDR5 ECS control feature

 include/hw/cxl/cxl_device.h  |  58 +++++
 include/hw/cxl/cxl_mailbox.h |  18 ++
 hw/cxl/cxl-mailbox-utils.c   | 432 +++++++++++++++++++++++++++++++++--
 hw/mem/cxl_type3.c           |  23 ++
 4 files changed, 512 insertions(+), 19 deletions(-)
 create mode 100644 include/hw/cxl/cxl_mailbox.h

-- 
2.43.0


