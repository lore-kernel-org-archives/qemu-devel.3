Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57EB109C058
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 18:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5TCN-00024L-Mq; Wed, 25 Mar 2026 14:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1w5TCM-00024B-8F
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 14:43:22 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1w5TCJ-0005qH-Cz
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 14:43:21 -0400
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fgwl43pFjzJ46F4;
 Thu, 26 Mar 2026 02:42:56 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 78CD340584;
 Thu, 26 Mar 2026 02:43:05 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.66.203) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 25 Mar 2026 18:43:04 +0000
To: <qemu-devel@nongnu.org>
CC: <anisa.su@samsung.com>, <armbru@redhat.com>, <berrange@redhat.com>,
 <eblake@redhat.com>, <jonathan.cameron@huawei.com>,
 <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, <lizhijian@fujitsu.com>,
 <mst@redhat.com>, <pbonzini@redhat.com>, <gourry@gourry.net>,
 <nifan.cxl@gmail.com>, <me@linux.beauty>
Subject: [QEMU PATCH 0/9] Application Specific Tagged Memory Support in CXL
 Type 3 Devices
Date: Wed, 25 Mar 2026 18:42:48 +0000
Message-ID: <20260325184259.366-1-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.47.66.203]
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

This series is a rework of the earlier RFC posted at:
https://lore.kernel.org/all/20251127225526.700-1-alireza.sanaee@huawei.com/

The overall goal is still to support application-specific tagged memory
for CXL Type 3 dynamic capacity, but the backend model is now different.

The earlier RFC introduced a dedicated tagged memory backend object.
This version does not. Instead, the first patch adds a `tag` property
to generic host memory backends, and the rest of the series teaches the
CXL Type 3 DC flow to find and hook up those tagged backends lazily at
runtime.

In practice, a device may now be created with `dc-regions-total-size`
and no `volatile-dc-memdev`. When add-capacity is requested with a tag,
the tagged host memory backend is looked up, validated, and only mapped
after host acceptance. The committed extent keeps the backend and fixed
window metadata so that:

 - direct alias mapping can be installed for the performant path,
 - teardown can happen correctly at release time, and
 - tag-based removal can locate and release extents by tag.

Assumptions, limitations and reasons behind it:

 1. Each lazy-backed extent maps to exactly one tagged host memory
    backend. In VM scenarios, we just need to add a backend which has
    one extent representing the entire backend tied to one region. If
    more extents required then more regions can be added.
 2. Partial release of a backend-backed extent is rejected. If a
    backend is represented by the one extent then partial release of
    a region does not makes sense.
 3. The current lazy flow only supports a single extent per add
    request. This can be changed if required later.

This series contains:

 - add generic host memory backend tag support;
 - allow creating DC-only Type 3 devices with total capacity but no
   backing device at init time;
 - wire tagged host memory backends into the DC add flow;
 - store per-extent backend and fixed-window metadata;
 - map the backend after host acceptance;
 - add the direct alias fast path for accesses;
 - tear down aliases and lazy mappings on release;
 - add tag-based removal support; and
 - add a status QMP helper for orchestration layers.

Tested with two tagged `memory-backend-ram` objects and QMP-driven add
and release flows, including tag-based release.

Example flow
============

Below is a short tutorial-style example based on the earlier RFC, but
updated for the current design where generic host memory backends carry
the tag.

1. Start QEMU with a Type 3 device that advertises dynamic capacity via
   `dc-regions-total-size`, without an initial `volatile-dc-memdev`.

   -device cxl-type3,bus=root_port13,id=cxl-vmem0,num-dc-regions=1, \
           dc-regions-total-size=4G

2. Create tagged backends at runtime with QMP:

{
    "execute": "object-add",
    "arguments": {
        "qom-type": "memory-backend-ram",
        "id": "tm0",
        "size": 1073741824,
        "share": true,
        "tag": "5be13bce-ae34-4a77-b6c3-16df975fcf1a"
    }
}

{
    "execute": "object-add",
    "arguments": {
        "qom-type": "memory-backend-ram",
        "id": "tm1",
        "size": 1073741824,
        "share": true,
        "tag": "6be13bce-ae34-4a77-b6c3-16df975fcf1a"
    }
}

3. Add capacity by tag:

{
    "execute": "cxl-add-dynamic-capacity",
    "arguments": {
        "path": "/machine/peripheral/cxl-vmem0",
        "host-id": 0,
        "selection-policy": "prescriptive",
        "region": 0,
        "tag": "5be13bce-ae34-4a77-b6c3-16df975fcf1a",
        "extents": [
            {
                "offset": 0,
                "len": 1073741824
            }
        ]
    }
}

After the host accepts the extent, the tagged backend is mapped and the
direct alias path becomes active for the committed extent.

4. Release by tag:

{
    "execute": "cxl-release-dynamic-capacity",
    "arguments": {
        "path": "/machine/peripheral/cxl-vmem0",
        "host-id": 0,
        "removal-policy": "tag-based",
        "tag": "5be13bce-ae34-4a77-b6c3-16df975fcf1a",
        "region": 0,
        "extents": [
            {
                "offset": 0,
                "len": 1073741824
            }
        ]
    }
}

5. Query whether the tagged extent is still present:

{
    "execute": "cxl-release-dynamic-capacity-status",
    "arguments": {
        "path": "/machine/peripheral/cxl-vmem0",
        "host-id": 0,
        "tag": "5be13bce-ae34-4a77-b6c3-16df975fcf1a",
        "region": 0
    }
}

For the Ira patchset from Intel, I allowed UUIDs in the kernel-side
flow, and that change is available here:
https://github.com/sarsanaee/linux/tree/allow_uuid_ira

Depends-on:
https://lore.kernel.org/all/20260318171918.146-1-alireza.sanaee@huawei.com/

Depends-on:
https://lore.kernel.org/all/20250413-dcd-type2-upstream-v9-0-1d4911a0b365@intel.com/

--
Alireza Sanaee

Alireza Sanaee (9):
  hw/mem: Add tag support to generic host memory backends
  hw/cxl: Allow initializing type3 device with no backing device
  hw/cxl: Hook up tagged host memory backends at runtime for DC extents
  hw/cxl: Carry backend metadata in DC extent records
  hw/cxl: Map lazy memory backend after host acceptance
  hw/cxl: Create direct fixed-window aliases for accepted extents
  hw/cxl: Add release-time teardown for direct-mapped extents
  hw/cxl: Add tag-based dynamic-capacity release support
  hw/cxl: Add QMP status query for dynamic-capacity extent release

 backends/hostmem.c          |  72 +++++++
 hw/cxl/cxl-host.c           |   6 +
 hw/cxl/cxl-mailbox-utils.c  | 223 ++++++++++++++++++++--
 hw/mem/cxl_type3.c          | 361 +++++++++++++++++++++++++++++++-----
 hw/mem/cxl_type3_stubs.c    |  10 +
 include/hw/cxl/cxl_device.h |  41 +++-
 include/system/hostmem.h    |   2 +
 qapi/cxl.json               |  46 +++++
 qapi/qom.json               |   3 +
 tests/qtest/qom-test.c      |   8 +-
 10 files changed, 703 insertions(+), 69 deletions(-)

-- 
2.50.1 (Apple Git-155)


