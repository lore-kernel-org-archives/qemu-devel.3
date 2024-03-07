Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F70AC54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 16:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riGDw-0005HC-Rt; Thu, 07 Mar 2024 11:04:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1riGDh-00056c-0B
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 11:03:48 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1riGDb-000634-Ux
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 11:03:44 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TrDVg0ZJVz67c1W;
 Thu,  7 Mar 2024 23:58:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 3D440140C72;
 Fri,  8 Mar 2024 00:03:25 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 16:03:24 +0000
To: Liu Jingqi <jingqi.liu@intel.com>, <qemu-devel@nongnu.org>,
 <ankita@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
CC: <linuxarm@huawei.com>, Markus Armbruster <armbru@redhat.com>, Daniel Black
 <daniel@linux.ibm.com>
Subject: [PATCH v2 0/2] hw/acpi/hmat: Misc fixes
Date: Thu, 7 Mar 2024 16:03:24 +0000
Message-ID: <20240307160326.31570-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

v2: Fixed a link in patch 1 description so it points somewhere stable.

Two unrelated fixes here:
1) Linux really doesn't like it when you claim non existent memory
   is directly connected to an initiator (here a CPU).
   It is a nonsense entry, though I also plan to try and get
   a relaxation of the condition into the kernel.
   Maybe we need to care about migration, but I suspect no one
   cares about this corner case (hence no one noticed the
   problem!)

2) An access outside of the allocated array when building the
   the latency and bandwidth tables.  Given this crashes QEMU
   for me, I think we are fine with the potential table change.

Some notes on 1:
- This structure is almost entirely pointless in general - most
  of the fields were removed in HMAT v2.
  What remains, is meant to convey memory controller location
  when the memory is in a different Proximity Domain from the
  memory controller (e.g. a SoC with both HBM and DDR will present
  2 NUMA domains but memory controllers will be wherever we describe
  the CPUs as being - typically with the DDR)
  Currently QEMU creates these to indicate direct connection between
  a CPU domain and memory in the same domain. Using the Proximity
  domain in SRAT conveys the same. This adds no information but
  it is harmless and avoids migration problems.

Notes on 2:
- I debated a follow up patch removing the entrees in the table
  for initiators on nodes that don't have any initiators.
  QEMU won't let you use them as initiators in the LB entries
  anyway so there is no way to set those entries and they
  end up reported as 0. OK for Bandwidth as no one is going to use
  the zero bandwidth channel, but that's a very attractive latency,
  but that's fine as no one will read the number as there are
  no initiators? (right?)

  There is a corner case in ACPI that bites us here.
  ACPI Proximity domains are only defined in SRAT, but nothing says
  they need to be fully defined.  Generic Initiators are optional
  after all (newish feature) so it was common to use _PXM in DSDT
  to define where various platform devices were (and PCI but that's
  still not read by Linux - a story of pain and broken systems for
  another day). That's fine if they are in a node with CPUs
  (initiators) but not so much if they happen to be in a memory
  only node. Today I think the only thing we can make hit this
  condition in QEMU is a PCI Expander Bridge which doesn't initiate
  transactions. But things behind it do and there are drivers out
  there that do buffer placement based on SLIT distances. I'd
  expect HMAT users to follow soon.

  It would be nice to think all such systems will use Generic Port
  Affinity Structures (and I have patches for those to follow shortly)
  but that's overly optimistic beyond CXL where the kernel will use
  them and which drove their introduction.

Jonathan Cameron (2):
  hmat acpi: Do not add Memory Proximity Domain Attributes Structure
    targetting non existent memory.
  hmat acpi: Fix out of bounds access due to missing use of indirection

 hw/acpi/hmat.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

-- 
2.39.2


