Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF46C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 11:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPhIX-0003Uq-E3; Fri, 05 Jul 2024 07:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sPhIV-0003UC-AM
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 07:40:15 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sPhIS-0007ac-6l
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 07:40:15 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFs3W1GFLz6K6bx;
 Fri,  5 Jul 2024 19:38:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 285E9140A30;
 Fri,  5 Jul 2024 19:39:57 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 12:39:56 +0100
To: <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: <linux-cxl@vger.kernel.org>, Markus Armbruster <armbru@redhat.com>, Li
 Zhijian <lizhijian@fujitsu.com>, <linuxarm@huawei.com>, Zhao Liu
 <zhao1.liu@linux.intel.com>, Xingtao Yao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH qemu v2 0/3]  hw/cxl: Misc minor improvements
Date: Fri, 5 Jul 2024 12:39:53 +0100
Message-ID: <20240705113956.941732-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
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

v2: Switch patch 1 from a patch that removes the cfmws_list element
    of CXLState to a fix that makes use of it to fix a crash.
    Now based on master as precursors merged.

Before pushing on to more significant features a few unrelated patches
doing tidying up + one to avoid people setting the memory backend both
for a CXL type 3 device and as normal RAM in an attempt to get SRAT to
cover it correctly.  We've had multiple 'bug' reports from this and if
nothing else I'd like to stop getting those!

Fan Ni (1):
  hw/cxl/cxl-mailbox-utils: remove unneeded mailbox output payload space
    zeroing

Jonathan Cameron (1):
  hw/cxl: Check for multiple mappings of memory backends.

Zhao Liu (1):
  hw/cxl/cxl-host: Fix segmentation fault when getting cxl-fmw property

 hw/cxl/cxl-host.c          |  3 ++-
 hw/cxl/cxl-mailbox-utils.c |  7 -------
 hw/mem/cxl_type3.c         | 15 +++++++++++++++
 3 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.43.0


