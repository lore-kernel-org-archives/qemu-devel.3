Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298BCC30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 13:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPiX9-0006iu-7a; Fri, 05 Jul 2024 08:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sPiX6-0006iZ-GX
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 08:59:24 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sPiX2-00044h-CW
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 08:59:22 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFtq21P9Vz6K6mb;
 Fri,  5 Jul 2024 20:58:06 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 56AF1140A30;
 Fri,  5 Jul 2024 20:59:16 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 13:59:15 +0100
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: <fan.ni@samsung.com>, Davidlohr Bueso <dave@stgolabs.net>, Fan Ni
 <nifan.cxl@gmail.com>, <linuxarm@huawei.com>
Subject: [PATCH qemu v4 0/1] hw/cxl: Support firmware updates
Date: Fri, 5 Jul 2024 13:59:14 +0100
Message-ID: <20240705125915.991672-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

v4: Trivial rebase due to reordering of patch queue for upstreaming.
    A couple of white space fixes (checkpatch)

This one was waiting on a v3 revision from Davildlohr (which he posted
last week) rather than DCD as such, but the various series before this
one cause a lot of churn so it's easier to merge in this order.

Details in patch 1, but in short this fakes firmware updates, allowing
testing of the OS support.

Based-on: [PATCH qemu v6 0/4] hw/cxl/cxl-mailbox-utils: Add feature commands, device patrol scrub control and DDR5 ECS control feature
Based-on: [PATCH qemu 0/4] hw/cxl: Add support for scan media.

Based-on: Message-id: 20240705123039.963781-1-Jonathan.Cameron@huawei.com
Based-on: Message-id: 20240705120643.959422-1-Jonathan.Cameron@huawei.com

Davidlohr Bueso (1):
  hw/cxl: Support firmware updates

 include/hw/cxl/cxl_device.h |  15 +++
 hw/cxl/cxl-mailbox-utils.c  | 205 +++++++++++++++++++++++++++++++++++-
 2 files changed, 215 insertions(+), 5 deletions(-)

-- 
2.43.0


