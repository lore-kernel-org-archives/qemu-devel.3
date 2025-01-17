Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE73DC02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 03:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYdHI-00010G-Io; Thu, 16 Jan 2025 22:44:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1tYdHC-0000zv-K5
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 22:44:06 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>) id 1tYdH6-00044q-0i
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 22:44:02 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCHjz_10YlnG7SrAA--.34355S2;
 Fri, 17 Jan 2025 11:43:49 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwA3Uaf00YlndZYMAA--.1676S3;
 Fri, 17 Jan 2025 11:43:48 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: jonathan.cameron@huawei.com, fan.ni@samsung.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, chenbaozi@phytium.com.cn,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [PATCH 0/1] cxl/cxl-host: Support creation of a new CXL Host Bridge
Date: Fri, 17 Jan 2025 11:43:42 +0800
Message-Id: <20250117034343.26356-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwA3Uaf00YlndZYMAA--.1676S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQANAWeJYwMBjgABsN
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7uFWxtry8GF4fJF1fZF13urg_yoW8CF15p3
 WDGrWfGr1DCry3Jws3A3yUJa1rWrs5WFW5Zr1I9w18AF15tF4DJr1kKa1ava4DC345uw1f
 tFnFqrn5K3WUZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Background
==========
Currently the base CXL support for arm platforms is only on Jonathan's
patches[1] which have not yet merged into upstream. Some platform like
SBSA-REF can be more like a real machine, thus the support of cxl could
be meaningful. However, the pxb-cxl-host realization on this platform
seems not satisfying their requirements[2].

New CXL HOST design
===================
This work defines a new cxl host bridge type (TYPE_CXL_HOST). This
could be considered as a prototype of an independent cxl host bridge
which combines gpex features (ecam, mmio windows & irq) and pxb-cxl
features(CHBCR) at meanwhile.

The root bus path of CXL_HOST is "0001:00", that would not affect the
original pcie host topology. In the previous, the pxb-cxl-host with
any cxl root ports and cxl endpoint devices would occupy the BDF
number of the original pcie domain. This new type provide a solution
to resolve the problem.

Also the CXLFixedWindow struct adds a new member 'target_chb' to
record the target list of CXLHostBridge. And necessary is to adjust
the logic of 'cxl_cfmws_find_device' and 'cxl_fmws_link_targets' to
allow different types of cxl host bridge.

Move 'cxl_get_hb_cstate' & 'cxl_get_hb_passthrough' from pxb code
into cxl-host code.

Link:
[1]: https://lore.kernel.org/linux-cxl/20220616141950.23374-1-Jonathan.Cameron@huawei.com/
[2]: https://lists.nongnu.org/archive/html/qemu-arm/2024-11/msg00522.html

Yuquan Wang (1):
  cxl/cxl-host: Support creation of a new CXL Host Bridge

 hw/cxl/cxl-host-stubs.c             |   2 +
 hw/cxl/cxl-host.c                   | 220 ++++++++++++++++++++++++++--
 hw/pci-bridge/pci_expander_bridge.c |  20 +--
 include/hw/cxl/cxl.h                |  23 +++
 include/hw/cxl/cxl_component.h      |   4 +-
 include/hw/cxl/cxl_host.h           |   6 +
 6 files changed, 242 insertions(+), 33 deletions(-)

-- 
2.34.1


