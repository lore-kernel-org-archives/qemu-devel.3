Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C2DCFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 22:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOkuD-0001c2-58; Thu, 27 Nov 2025 17:56:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vOku1-0001a4-Hy
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 17:55:53 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vOktu-0001NF-N1
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 17:55:51 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dHWw22Nz6zHnGcV;
 Fri, 28 Nov 2025 06:54:42 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id A6FA51402E9;
 Fri, 28 Nov 2025 06:55:31 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.72.83) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Nov 2025 22:55:30 +0000
To: <qemu-devel@nongnu.org>
CC: <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>, <eblake@redhat.com>, 
 <armbru@redhat.com>, <berrange@redhat.com>, <pbonzini@redhat.com>,
 <mst@redhat.com>, <lizhijian@fujitsu.com>, <anisa.su@samsung.com>,
 <linux-cxl@vger.kernel.org>
Subject: [RFC QEMU PATCH 0/7] Application Specific Tagged Memory Support in
 CXL Type 3 Devices
Date: Thu, 27 Nov 2025 22:55:18 +0000
Message-ID: <20251127225526.700-1-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.47.72.83]
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Application may need memory for specific purposes. For example, a
database application may want to allocate memory that is optimized for
workloads involving large datasets and frequent read/write operations.
Or there might be a large read only dataset that can be mapped to a CXL
Type 3 device.

There must be a way to feed this memory into the VMs. This series
introduces a tagged memory backend object that allows tagging memory
regions with application specific tags. The tagged memory regions can
then be used as backing memory for CXL Type 3 devices.

This series includes the following changes:
 - A new tagged memory backend object is introduced that allows
   allocating and managing memory regions with specific tags.
 - The CXL Type 3 device implementation is modified to support using
   tagged memory regions as backing memory.
 - New QAPI commands and structures are added to facilitate the
   management of tagged memory regions and their association with CXL
   Type 3 devices.
 - The CXL extent management code is updated to handle tagged memory
   regions appropriately, including lazy loading and direct mapping
   optimizations.

# Assumptions:

1) Each extent must be mapped entirely to a single tagged memory
backend.
2) Punching holes in extents is not supported, and not allowed.

# Diagram that illustrates the design:

                  VM
                  |
                  | FMW.0
                  v
                +--------------------+
                |   CXL Type-3 dev   |
                |  +--------------+  |
                |  | extent0 T0   |----> backend0 (tag T0)
                |  | extent1 T1   |----> backend1 (tag T1)
                |  | extent2 T2   |----> backend2 (tag T2)
                |  +--------------+  |
                +--------------------+


# Tested scenario:

Created two different tagged memory backends with different tags at
runtime with QMP commands, and then added two different extents that
cover the whole memory backends specified by tags.

# Changes to the kernel:

UUID/tags must be allowed in the DCD patchset available online from
Ira which is series depends on [1].

# Commands used:

# First memory backend with tag 5be13bce-ae34-4a77-b6c3-16df975fcf1a:

{
    "execute": "object-add",
    "arguments": {
        "qom-type": "memory-backend-tagged",
        "id": "tm0",
        "size": 1073741824,
        "tag": "5be13bce-ae34-4a77-b6c3-16df975fcf1a"
    }
}

## Second memory backend with tag 6be13bce-ae34-4a77-b6c3-16df975fcf1a:

{

    "execute": "object-add",
    "arguments": {
        "qom-type": "memory-backend-tagged",
        "id": "tm1",
        "size": 1073741824,
        "tag": "6be13bce-ae34-4a77-b6c3-16df975fcf1a"
    }
}

## Add capacity extent with tag 5be13bce-ae34-4a77-b6c3-16df975fcf1a:

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

## Add capacity extent with tag 6be13bce-ae34-4a77-b6c3-16df975fcf1a:

{
    "execute": "cxl-add-dynamic-capacity",
    "arguments": {
        "path": "/machine/peripheral/cxl-vmem0",
        "host-id": 0,
        "selection-policy": "prescriptive",
        "region": 0,
        "tag": "6be13bce-ae34-4a77-b6c3-16df975fcf1a",
        "extents": [
            {
                "offset": 1073741824,
                "len": 1073741824
            }
        ]
    }
}

## Release capacity extent with tag 5be13bce-ae34-4a77-b6c3-16df975fcf1a:

{ "execute": "cxl-release-dynamic-capacity",
	"arguments": {
		"path": "/machine/peripheral/cxl-vmem0",
		"host-id": 0,
		"removal-policy":"tag-based",
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

## Release capacity extent with tag 6be13bce-ae34-4a77-b6c3-16df975fcf1a:

{ "execute": "cxl-release-dynamic-capacity",
	"arguments": {
		"path": "/machine/peripheral/cxl-vmem0",
		"host-id": 0,
		"removal-policy":"tag-based",
        	"tag": "6be13bce-ae34-4a77-b6c3-16df975fcf1a",
		"region": 0,
		"extents": [
		{
			"offset": 1073741824,
			"len": 1073741824
		}
		]
	}
}

## Checking if capacity extents are removed successfully:

{
  "execute": "cxl-release-dynamic-capacity-status",
  "arguments": {
	"path": "/machine/peripheral/cxl-vmem0",
	"host-id": 0,
        "tag": "6be13bce-ae34-4a77-b6c3-16df975fcf1a",
	"region": 0
  }
}

Response:
{
    "return": {
        "status": "not-found"
    }
}

# QEMU Command:

$ qemu-system-x86_64 \
  -cpu max \
  -smp 8 \
  -drive file=debian12.qcow2,format=qcow2,if=none,id=mydrive0,index=0 \
  -device virtio-blk-pci,drive=mydrive0 \
  -kernel bzImage \
  -append "console=ttyS0,115200 TERM=linux root=/dev/vda1 nokaslr ignore_loglevel \
           fsck.mode=skip cxl_acpi.dyndbg=+fplm cxl_pci.dyndbg=+fplm cxl" \
  -nographic \
  -serial mon:stdio \
  -machine type=q35,accel=tcg \
  -virtfs local,path=hostshare/,mount_tag=hostshare,security_model=passthrough,id=hostshare \
  -qmp tcp:localhost:4444,server,wait=off \
  -netdev user,id=network0,hostfwd=tcp::2025-:22 \
  -device virtio-net,netdev=network0 \
  -m 12G,maxmem=20G,slots=10 \
  -object memory-backend-ram,id=vmem0,share=on,size=2G \
  -device pxb-cxl,numa_node=0,bus_nr=23,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
  -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
  -M cxl=on,cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=6G \
  -device cxl-type3,bus=root_port13,id=cxl-vmem0,num-dc-regions=1,dc-regions-total-size=4G

BASE: 2a3af116a78e1adceb24521d76199b97f08c0f1d

Depends-on:
https://lore.kernel.org/linux-cxl/20251013160151.000039dd.alireza.sanaee@huawei.com/

Depends-on:
https://lore.kernel.org/all/20250413-dcd-type2-upstream-v9-0-1d4911a0b365@intel.com/

[1] https://github.com/sarsanaee/linux/tree/allow_uuid_ira

Alireza Sanaee (7):
  hw/mem: Add tagged memory backend object
  hw/cxl: Allow initializing type3 device with no backing device
  hw/cxl: Change Extent add/remove APIs for lazy memory backend.
  hw/cxl: Map lazy memory backend after host acceptance
  hw/cxl: Add performant direct mapping for extents
  hw/cxl: Add remove alias functionality for extent direct mapping
  hw/cxl: Add tag-based removal functionality

 hw/cxl/cxl-host.c           |   6 +
 hw/cxl/cxl-mailbox-utils.c  | 190 +++++++++++++++++++--
 hw/mem/cxl_type3.c          | 326 ++++++++++++++++++++++++++++++------
 hw/mem/meson.build          |   1 +
 hw/mem/tagged_mem.c         | 116 +++++++++++++
 include/hw/cxl/cxl_device.h |  44 ++++-
 include/hw/mem/tagged_mem.h |  31 ++++
 qapi/cxl.json               |  46 +++++
 qapi/qom.json               |  15 ++
 9 files changed, 707 insertions(+), 68 deletions(-)
 create mode 100644 hw/mem/tagged_mem.c
 create mode 100644 include/hw/mem/tagged_mem.h

-- 
2.43.0


