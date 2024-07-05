Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46050C41513
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 12:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPhiJ-0006Yb-N6; Fri, 05 Jul 2024 08:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sPhiH-0006Ul-6Z
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 08:06:53 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sPhiE-0003aD-TV
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 08:06:52 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFsfP6M56z6K6f3;
 Fri,  5 Jul 2024 20:05:33 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id E0A26140A30;
 Fri,  5 Jul 2024 20:06:43 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 13:06:43 +0100
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
 Fan Ni <fan.ni@samsung.com>
Subject: [PATCH qemu 0/4] hw/cxl: Add support for scan media.
Date: Fri, 5 Jul 2024 13:06:39 +0100
Message-ID: <20240705120643.959422-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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

Now DCD is upstream, a number of sets that were dependent on it, that have
otherwise been in a good state for a long time, are (hopefully) ready to
upstream.  I was also holding back series that were less critical for
kernel testing to make sure they didn't distract from the progress of
Dynamic Capacity.

This 1st series includes a couple of more general improvements that interact
closely with the scan media changes.  This series applies directly on master
and can go in parallel to

[PATCH qemu v2 0/3]  hw/cxl: Misc minor improvements

The Scan Media commands enable recovery from the situation where a poison
list has overflowed and the OS has no other way to find out which
memory is bad, or because the user wants force a recheck for uncorrectable
ECC errors. This functionality is emulated by keeping an additional list
of injected poison that is not exposed via the existing get poison list
command.  This list is 'discovered' during processing of Scan Media as
if the hardware had detected these errors in real memory.

Davidlohr Bueso (2):
  hw/cxl: Add get scan media capabilities cmd support
  hw/cxl: Add get scan media results cmd support

Hyeonggon Yoo (2):
  hw/cxl/mbox: replace sanitize_running() with cxl_dev_media_disabled()
  hw/cxl/events: discard all event records during sanitation

 include/hw/cxl/cxl_device.h |  15 +-
 hw/cxl/cxl-events.c         |  13 ++
 hw/cxl/cxl-mailbox-utils.c  | 326 ++++++++++++++++++++++++++++++++++--
 hw/mem/cxl_type3.c          |  26 ++-
 4 files changed, 355 insertions(+), 25 deletions(-)

-- 
2.43.0


