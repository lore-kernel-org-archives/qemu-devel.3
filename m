Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278C7C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 12:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdUuK-0000Fr-He; Fri, 23 Feb 2024 07:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rdUtF-00080t-W1; Fri, 23 Feb 2024 07:42:59 -0500
Received: from mail-dm3nam02on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2405::601]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rdUtB-0003l9-HZ; Fri, 23 Feb 2024 07:42:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2J9VNV0a6TYBdyBpxjiJaXrkGHpcvIwy5jyb8lr+v+ZGdH+ZSi1y3F34hlg++cVWi8IIpS3w+PZWTVP/GKRDQKCIRhgbfgX/ef4oTaOuS9w9uliXkpyEomLjmw/W2vwgX9dJag0IJvP5SzLCUCIoSsKOAb1sEEH5fbaZvMzJGQlp7xpJax6fZPHCBp1zoIgKyXoQEa/mJoYooZJ+FP2x6DXP2goS0vBdCHFPNB8QHRtt1a08OkO3cwkF2vY0BATZSeO0MoMDhsp1Bd6dTo+aAfN3ZOZXmVvjblKlLC03LnpGfz5T3q5PnWTO6kWZbCA9N7U7CZ5LMzj71+PsVO76Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzcquAmQCcwJssB6bOGQTQOk55IttVlUgc5yvgr9EGU=;
 b=ncfqhYBLYO3gWkW8F9knIYmt4YWZta49SrPIV7iN5yEqqgjCoSl/CvUgHZNKlQf3ncVDZMXfBJHgoaBrOqPi5U8afEdxuA1djNm6/HnSh8NULzVrHVTLhEhLXG1k9jvsAUOjHyBk8AC0tp3hvCoUgt8ZIfy7+Kl89Oe4SBEgQib7aKCDhTUB83rYCWOk1IgkwH98VFTDGbhWNTX8VOIjWFoyJf6JuEh+DgvoyFjXXDBH0mbg55gdYDmvgT7QOG8vc3lFDNlKP+74RnxMNfvhoV7m3Omc0kzUaj0Ofi/mP+0W1TByRFUrpbvq039hlfP8RlL16rXZJ35YVuYGyQ6YxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzcquAmQCcwJssB6bOGQTQOk55IttVlUgc5yvgr9EGU=;
 b=riGyjU2F3L03RQvZCXhkTNtgnmFpI7dZtkKpIK9hKfACFxq16fVzKhPE6f4pHMJhPgvb+sN7RqT7rB0Njxt7uyREVGkhVsBzQ8q7WUg+/1kk69dPTB9UrW8obT5p8NdLKM5fvz2+nKfENxlQvWh8/peiJVXjBB+ESefitCFO4CDpDsM41vZKAnzh6WcaJcbpimRw1GNxc8SAdRqcCNi1Y5eomn22kIOEjqEwwm7bRpsdX7l4oMVmY/cH9A/fKELlOyx6dFt/mizM2+0h8/gcqVijC6cSJjAtWN2+n7hYzHekHQ6ktIzZkeg/0+sYbNEJ+tz8AuxSwMOA+DJhb3s/+A==
Received: from MW4PR03CA0275.namprd03.prod.outlook.com (2603:10b6:303:b5::10)
 by MN6PR12MB8471.namprd12.prod.outlook.com (2603:10b6:208:473::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Fri, 23 Feb
 2024 12:42:46 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::e3) by MW4PR03CA0275.outlook.office365.com
 (2603:10b6:303:b5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.45 via Frontend
 Transport; Fri, 23 Feb 2024 12:42:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 12:42:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 23 Feb
 2024 04:42:25 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 23 Feb
 2024 04:42:24 -0800
Received: from localhost.nvc.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Fri, 23 Feb 2024 04:42:23 -0800
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <jgg@nvidia.com>, <alex.williamson@redhat.com>,
 <clg@redhat.com>, <shannon.zhaosl@gmail.com>, <peter.maydell@linaro.org>,
 <ani@anisinha.ca>, <berrange@redhat.com>, <eduardo@habkost.net>,
 <imammedo@redhat.com>, <mst@redhat.com>, <eblake@redhat.com>,
 <armbru@redhat.com>, <david@redhat.com>, <gshan@redhat.com>,
 <Jonathan.Cameron@huawei.com>, <zhiw@nvidia.com>, <mochs@nvidia.com>,
 <pbonzini@redhat.com>
CC: <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <vsethi@nvidia.com>, <acurrid@nvidia.com>,
 <dnigam@nvidia.com>, <udhoke@nvidia.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: [PATCH v7 0/2] acpi: report numa nodes for device memory using GI
Date: Fri, 23 Feb 2024 12:42:21 +0000
Message-ID: <20240223124223.800078-1-ankita@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|MN6PR12MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: dcd217e1-9a99-49b4-ff60-08dc346cef44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wrVGEgsmf5tGdyHFvisBkVtMTxBeBo3gLSblVbH63H2rzuKc8ZxQF9eWbiyri3rWv9WHAPjZ3NSxkCh8HSihkMGbfLO1ACf2O9uNLdInU5GZEqcwIISo835kExa0VDSOQl4PpFyRrnWSju4QamOrseD4O1ZARQI3uJRelYCSz5jm7q1E7w8hxqBOuCXrcwGoz6dgrLiUAKz6m7R9doxMqGMfcYL6/zWPKTws44LCDe4/HCNt/5EgKAx58SGblCYpJKrelvU23FOj3JuJQL4Mujdz6VLcaqGahbrSz68s5XxUZCTyBQ3ylcAV8aK5q3Bux25j69kuwRaDVPY/anWubnPRKg4Q16X6qXE/2bEpzGoKdL1GbksHDgLyFikl8INZ8bElmCp6bwQWHoKbGj79QvAoFz4tu0iRXb+Eztg9C0fQqSxZIVJ1xaGmXFq4Gh1JiJrzJQrDSOzlZOMgvBuhGJVBRIz95BMzkbaAzuydXgt6kiR9w5Pbi/4jz6ukPBXyMLs9f77/2TJJi0zbzb84pVhFUbj/VM2R115y1K5hBfnpTcqkpzPmlZNB48rQ0k6yJBuCGii0CY0uXM+WcjZVhTcoL3qks4Yp8fhN7nRQLExf9k11ElVkTdwNXht5l1dzbD3tl4OTUl9rRtt2AN74dMeCtF4ctMP/YxcleA8O/68VDWpNB1Wgh2cmdJO/+QTdtzg5be622xCY+i+VMKSJuA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(36860700004)(46966006)(40470700004)(921011); DIR:OUT; SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 12:42:45.3594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd217e1-9a99-49b4-ff60-08dc346cef44
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8471
Received-SPF: softfail client-ip=2a01:111:f403:2405::601;
 envelope-from=ankita@nvidia.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ankit Agrawal <ankita@nvidia.com>

There are upcoming devices which allow CPU to cache coherently access
their memory. It is sensible to expose such memory as NUMA nodes separate
from the sysmem node to the OS. The ACPI spec provides a scheme in SRAT
called Generic Initiator Affinity Structure [1] to allow an association
between a Proximity Domain (PXM) and a Generic Initiator (GI) (e.g.
heterogeneous processors and accelerators, GPUs, and I/O devices with
integrated compute or DMA engines).

While a single node per device may cover several use cases, it is however
insufficient for a full utilization of the NVIDIA GPUs MIG
(Mult-Instance GPUs) [2] feature. The feature allows partitioning of the
GPU device resources (including device memory) into several (upto 8)
isolated instances. Each of the partitioned memory requires a dedicated NUMA
node to operate. The partitions are not fixed and they can be created/deleted
at runtime.

Linux OS does not provide a means to dynamically create/destroy NUMA nodes
and such feature implementation is expected to be non-trivial. The nodes
that OS discovers at the boot time while parsing SRAT remains fixed. So we
utilize the GI Affinity structures that allows association between nodes
and devices. Multiple GI structures per device/BDF is possible, allowing
creation of multiple nodes in the VM by exposing unique PXM in each of these
structures.

Implement the mechanism to build the GI affinity structures as Qemu currently
does not. Introduce a new acpi-generic-initiator object to allow host admin
link a device with an associated NUMA node. Qemu maintains this association
and use this object to build the requisite GI Affinity Structure.

When multiple numa nodes are associated with a device, it is required to
create those many number of acpi-generic-initiator objects, each representing
a unique device:node association.

Following is one of a decoded GI affinity structure in VM ACPI SRAT.
[0C8h 0200   1]                Subtable Type : 05 [Generic Initiator Affinity]
[0C9h 0201   1]                       Length : 20

[0CAh 0202   1]                    Reserved1 : 00
[0CBh 0203   1]           Device Handle Type : 01
[0CCh 0204   4]             Proximity Domain : 00000007
[0D0h 0208  16]                Device Handle : 00 00 20 00 00 00 00 00 00 00 00
00 00 00 00 00
[0E0h 0224   4]        Flags (decoded below) : 00000001
                                     Enabled : 1
[0E4h 0228   4]                    Reserved2 : 00000000

[0E8h 0232   1]                Subtable Type : 05 [Generic Initiator Affinity]
[0E9h 0233   1]                       Length : 20

On Grace Hopper systems, an admin will create a range of 8 nodes and associate
them with the device using the acpi-generic-initiator object. While a
configuration of less than 8 nodes per device is allowed, such configuration
will prevent utilization of the feature to the fullest. This setting is
applicable to all the Grace+Hopper systems. The following is an example of
the Qemu command line arguments to create 8 nodes and link them to the device
'dev0':

-numa node,nodeid=2 -numa node,nodeid=3 -numa node,nodeid=4 \
-numa node,nodeid=5 -numa node,nodeid=6 -numa node,nodeid=7 \
-numa node,nodeid=8 -numa node,nodeid=9 \
-device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.0,addr=04.0,rombar=0,id=dev0 \
-object acpi-generic-initiator,id=gi0,pci-dev=dev0,node=2 \
-object acpi-generic-initiator,id=gi1,pci-dev=dev0,node=3 \
-object acpi-generic-initiator,id=gi2,pci-dev=dev0,node=4 \
-object acpi-generic-initiator,id=gi3,pci-dev=dev0,node=5 \
-object acpi-generic-initiator,id=gi4,pci-dev=dev0,node=6 \
-object acpi-generic-initiator,id=gi5,pci-dev=dev0,node=7 \
-object acpi-generic-initiator,id=gi6,pci-dev=dev0,node=8 \
-object acpi-generic-initiator,id=gi7,pci-dev=dev0,node=9 \

The performance benefits can be realized by providing the NUMA node distances
appropriately (through libvirt tags or Qemu params). The admin can get the
distance among nodes in hardware using `numactl -H`.

This series goes along with the vfio-pci variant driver [3] under review.

Applied over v8.2.1.
base commit: f48c205fb42be48e2e47b7e1cd9a2802e5ca17b0

[1] ACPI Spec 6.3, Section 5.2.16.6
[2] https://www.nvidia.com/en-in/technologies/multi-instance-gpu
[3] https://lore.kernel.org/all/20240220115055.23546-4-ankita@nvidia.com/

Link for v6:
https://lore.kernel.org/all/20231225045603.7654-1-ankita@nvidia.com/

v6 -> v7
- Updated code and the commit message to make acpi-generic-initiator
  define a 1:1 relationship between device and node based on
  Jonathan Cameron's suggestion.
- Updated commit message to include the decoded GI entry in the SRAT.
- Rebased to v8.2.1.

v5 -> v6
- Updated commit message for the [1/2] and the cover letter.
- Updated the acpi-generic-initiator object comment description for
  clarity on the input host-nodes.
- Rebased to v8.2.0-rc4.

v4 -> v5
- Removed acpi-dev option until full support.
- The numa nodes are saved as bitmap instead of uint16List.
- Replaced asserts to exit calls.
- Addressed other miscellaneous comments.

v3 -> v4
- changed the ':' delimited way to a uint16 array to communicate the
nodes associated with the device.
- added asserts to handle invalid inputs.
- addressed other miscellaneous v3 comments.

v2 -> v3
- changed param to accept a ':' delimited list of numa nodes, instead
of a range.
- Removed nvidia-acpi-generic-initiator object.
- Addressed miscellaneous comments in v2.

v1 -> v2
- Removed dependency on sysfs to communicate the feature with variant module.
- Use GI Affinity SRAT structure instead of Memory Affinity.
- No DSDT entries needed to communicate the PXM for the device. SRAT GI
structure is used instead.
- New objects introduced to establish link between device and nodes.

Ankit Agrawal (2):
  qom: new object to associate device to numa node
  hw/acpi: Implement the SRAT GI affinity structure

 hw/acpi/acpi-generic-initiator.c         | 154 +++++++++++++++++++++++
 hw/acpi/meson.build                      |   1 +
 hw/arm/virt-acpi-build.c                 |   3 +
 include/hw/acpi/acpi-generic-initiator.h |  58 +++++++++
 qapi/qom.json                            |  17 +++
 5 files changed, 233 insertions(+)
 create mode 100644 hw/acpi/acpi-generic-initiator.c
 create mode 100644 include/hw/acpi/acpi-generic-initiator.h

-- 
2.34.1


