Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8B0C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 09:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpl02-0008BH-9r; Wed, 05 Mar 2025 04:25:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tpkzz-0008Ap-Be
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 04:25:07 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tpkzw-0000qE-96
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 04:25:06 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z76Wd22Ppz6M4nf;
 Wed,  5 Mar 2025 17:22:05 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 479BD140CB1;
 Wed,  5 Mar 2025 17:25:02 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Mar 2025 10:25:01 +0100
To: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>, <mst@redhat.com>
CC: <linuxarm@huawei.com>, <fan.ni@samsung.com>, Yuquan Wang
 <wangyuquan1236@phytium.com.cn>, Arpit Kumar <arpit1.kumar@samsung.com>,
 Sweta Kumari <s5.kumari@samsung.com>, Vinayak Holikatti
 <vinayak.kh@samsung.com>, Davidlohr Bueso <dave@stgolabs.net>, Ajay Joshi
 <ajay.opensrc@micron.com>
Subject: [PATCH qemu 0/8] hw/cxl: new features for 10.0 (possibly)
Date: Wed, 5 Mar 2025 09:24:51 +0000
Message-ID: <20250305092501.191929-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Michael / All,

This is a bit late in the cycle due to some travel and alignment with the
end of a kernel cycle which has made me very busy. If needed I'll send a
rebased version of these right at the start of the 10.1 cycle.

As in previous cycles I have been gathering up reviewed patches so as to
resolve merge conflicts etc before proposing a set to merge to Michael
Tsirkin (and for additional review). The focus of the CXL support continues
to be on emulating a subset of features useful to Linux kernel testing +
more limited support for out of band management over mctp
(one patch in here)

Note that I've only picked up the first of Arpit's series for log
manipulation as the clear and populate log functions are only useful if
any of the supported logs actually allow those functions otherwise they
will always return an error (which will occur for all logs we currently
emulate) The capabilities query is applicable for the Command Effects Log
and indeed indicates that we can't clear or populate it. So that is fine
on it's own.

Otherwise this is a mixed bag of features. The media operations are
particularly interesting as they enable offloading of memory zeroing
/ wiping.  Support for aborting background operations is needed to
enable testing of a feature that allows us to enable userspace access
to background commands without risking lockout of urgent kernel commands

Thanks,

Jonathan

Arpit Kumar (1):
  hw/cxl/cxl-mailbox-utils: Added support for Get Log Capabilities
    (Opcode 0402h)

Davidlohr Bueso (2):
  hw/cxl: Support aborting background commands
  hw/cxl: Support get/set mctp response payload size

Sweta Kumari (1):
  hw/cxl/cxl-mailbox-utils: CXL CCI Get/Set alert config commands

Vinayak Holikatti (3):
  hw/cxl/cxl-mailbox-utils: Add support for Media operations discovery
    commands cxl r3.2 (8.2.10.9.5.3)
  hw/cxl: factor out calculation of sanitize duration from
    cmd_santize_overwrite
  hw/cxl/cxl-mailbox-utils: Media operations Sanitize and Write Zeros
    commands CXL r3.2(8.2.10.9.5.3)

Yuquan Wang (1):
  docs/cxl: Add serial number for persistent-memdev

 docs/system/devices/cxl.rst  |  18 +-
 include/hw/cxl/cxl_device.h  |  43 +++
 include/hw/cxl/cxl_mailbox.h |   6 +
 hw/cxl/cxl-device-utils.c    |  14 +-
 hw/cxl/cxl-mailbox-utils.c   | 668 +++++++++++++++++++++++++++++++++--
 hw/mem/cxl_type3.c           |  22 +-
 6 files changed, 722 insertions(+), 49 deletions(-)

-- 
2.43.0


