Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA758C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 10:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFALm-0007M3-MN; Thu, 06 Jun 2024 06:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1sFALl-0007Le-Jh
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:28:05 -0400
Received: from mail-dm6nam12on2064.outbound.protection.outlook.com
 ([40.107.243.64] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1sFALj-0000WR-3W
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:28:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAr0xBG/Nb5yI5gdw9PuTdFxjFTX4HPTtVEznVnw3UqmuOspVFN3i3O8DSjsmzqkddG8rznSsI7jEIe/SybsY0Zxv9pI2DaIp4K037W5meEAcqe7yzfB4tLAD7spsR3+CePdIm4P9nO9VNUXEzxzFeAPAkhDuR4Npt/DaiOcMf1clA9ljItBtEciGfzMpQ9wgGlFwChY39iw9QXO/yllRdYLlck58hl2JeQe6Py7Slm6PXz4nqTodKPgB8vyacGTg3j4WYXuF7NfG/eRNppFx1f2pHJGIsoBtSVtO9GCzTEwo9R7RGCCCgSSk8v2FsUzYEIxWYiuvsfvterM1pRjGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8D3XBFbaWkGE3X1KdxaHT9sS6SivQ8wkwCbP8Wz2L2M=;
 b=IF4eeyovHtUqOvdmU6Y/WKIT4qUmWdSAEcCDj28JMMlV4kS1WqyEHiGyIwWZKJOrKThoyBQU/HrKjW6M6dJkhXywJkEQgkNS/KhBhAbH81ziUmAD8y43zEAt6wyrRou4j7JKBCn2CGIp1zxYxPPh+X4EKp5JGrq1z4VhLJXzbYo7mzxiwJMkREo43VncypVBr+fa6Y4tMWbclzdCtA/eK8CXHURL1hpBHXshpDAy89LqgEQ3DDpsSc1pax/Q6PXYt9WLBXgXraDsU9BzopDBBqiNX3tesC3B4i/rCa2U5iIf+1PMeBjBuBrp6rYeoLomFQc7f2WMWHJl0wWnhlOjNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8D3XBFbaWkGE3X1KdxaHT9sS6SivQ8wkwCbP8Wz2L2M=;
 b=wm+wPd6wZX4rxWDZUaVEnu7053wegMYuwqYTEUHsJUqqjMcKSUyiJQhEPS5cFwuiMkEESO4+Z0h2jzAhwcBhArbB14b9dZw1OgElgXbyjvTvXyiDCWp3nHmFYJPjjEH9+kSJ0aasRxNAiNaACWv7IvG8jHq2Nk5fHPob34tSoxQ=
Received: from PH7PR10CA0021.namprd10.prod.outlook.com (2603:10b6:510:23d::20)
 by DM4PR12MB8571.namprd12.prod.outlook.com (2603:10b6:8:187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Thu, 6 Jun
 2024 10:22:53 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::f8) by PH7PR10CA0021.outlook.office365.com
 (2603:10b6:510:23d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 10:22:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 10:22:52 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 05:22:50 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
CC: <qemu-devel@nongnu.org>, Huang Rui <Ray.Huang@amd.com>, Jiqian Chen
 <Jiqian.Chen@amd.com>
Subject: [PATCH v11 0/2] S3 support
Date: Thu, 6 Jun 2024 18:22:03 +0800
Message-ID: <20240606102205.114671-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|DM4PR12MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 74cb30ff-90c3-4665-5016-08dc86129ff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i8fc9kOrghnN+rbFjSRjH7Cw5UQjA4gUXnvTB+XD7V59UOEns8yUnn4NQWsK?=
 =?us-ascii?Q?l/3Aukmu38AqI2j0I0QJnx16n8yoyDdjt596UWNTObvW0ZMhI65UBwvVTkPH?=
 =?us-ascii?Q?X8NPt6GZ/5pQEAUDTJRTt+3RD/7CLxu+wpiomuvyLuincUGU5qYG4o7Qi1nZ?=
 =?us-ascii?Q?L+pyN2uKQ3gKlewXTRBg/M+QXHv+njas/WDBRinZwig2OIlXuAwxMELLiwyz?=
 =?us-ascii?Q?CAzepeL1w69QdqGvkUPsRcct4Jn7ayPQx0ktXd0vU7VNhI6+a2spbQvrugCD?=
 =?us-ascii?Q?Wv65OETGuPtC3esxk/pc1DVV2BlVlTMl9UOprCuiJgf1/k2GCfgyMtD75ZK2?=
 =?us-ascii?Q?YTD3fXmpVybTtwFPvKJRihrrJkcF9e68nWsJJCPKm6l0PnEPvhuDvbxZ28lh?=
 =?us-ascii?Q?jwUyAzKuZskiI9BDYHPGJeEwEC1Bfpx2dWoafACCUPOrKKxaUQBpa8Bz+J+N?=
 =?us-ascii?Q?6791VzBnTRiUnj6CIc50GarZA3lMjMXSFGz9iWM1U7cMG2xrW2fkVnKAilBy?=
 =?us-ascii?Q?2hukIESF9x165OiB5nO/cdITr9A00TYjbd8xxwGVCavIzbiiCaQozTd7R6ex?=
 =?us-ascii?Q?ClusjjWAJgXamrfO+bWenROije7VvXDYT0Oes9vEiPCCdNjhlyhOxPS6qLrs?=
 =?us-ascii?Q?PJYhb55ugis3Hpp/3T2aZkAgbZfO4Q7ShLbUrdCXW0hfs11gpL6XRFKMQlbs?=
 =?us-ascii?Q?iIScgA3TZkH0+j0yOnHmMrDNqA8OW0edh1ESqLrGzWpPthBmD+qoUnKlcPUw?=
 =?us-ascii?Q?SZHELdiriWCQkTpMhPjQNi4HeAX/NM7La8RvO+bSIIk40+2I4ZduNiztwCDq?=
 =?us-ascii?Q?qsCs8dttq8/Z07WU6sp2VTYsy+TOv9Ymlh2XEr8qNPLtwOvawyOUY1bhVRO+?=
 =?us-ascii?Q?N1Ns/dZtACuJOz7PIYRmfNItYEP+pspxFXHWS2SsSMppWwgvoeqPmcMDGnuS?=
 =?us-ascii?Q?srZuQ/zntFNcSM8CtpIxLyIdoO1fETvLuSSDQF1C/Nz+LDJP0wP2BDjBuSYx?=
 =?us-ascii?Q?CbX0QUWHmZWqLLxQ+u7dgQtLQBbsreZ5gYIaz8yNlebcYtzZo1tqVGQovvW8?=
 =?us-ascii?Q?dLZ7LFkQZEU81R+d2+Cjq6XrUrL4E7LmEnPklVX+13b0dQdEJUSyDy2TpBCH?=
 =?us-ascii?Q?YfhLADRu8NbTDpk2r+iWz610dMPTW+j4AauaSJVXPZqWvEoJd9YyEUTsa9jS?=
 =?us-ascii?Q?4bIQoP4uAKXX0NcB0TbcoUneJEgy54a0B7QBvYZONSk11ue3yiv/qL2QEDcj?=
 =?us-ascii?Q?PXFjACdt3rA6TBoj3b38Ctpp1LRGeRYqbpSpCpQn1UGj3MA0VH145FqvwrAM?=
 =?us-ascii?Q?hMugjciqfJtHVqL1gzvEAdXecePW/A4EQ+8xeJVrk8ZdlnhInEsDjY65ZmPU?=
 =?us-ascii?Q?CxL/9OE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 10:22:52.9639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74cb30ff-90c3-4665-5016-08dc86129ff4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8571
Received-SPF: permerror client-ip=40.107.243.64;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi all,
This is the v11 patch to support S3.
v11 makes below changes:
* patch#1 no changes.
* patch#2 add "x-" prefix to pcie-pm-no-soft-reset and add old machine compability.


Best regards,
Jiqian Chen



v10 makes below changes:
* patch#1 change the description of commit message.
* patch#2 no changes.


v9 makes below changes:
* patch#1 no changes
* patch#2 remove unnecessary parentheses.
          add some comments to remind we may need to consider SUSPEND bit in future.
          change the commit message to describe which virtio device was tested.
		  keep No_Soft_Reset bit false by default for safety.


v8 makes below changes:
* Add a new patch#1 to fix a problem import by 27ce0f3afc9dd25d21b43bbce505157afd93d111,
  the right action is that only the state of PM_CTRL can be clear when resetting.
* patch#2 is the original patch to implement No_Soft_Reset bit, and in this version, I
  rename function and change some condition sequence.


v7 makes below changes:
* Tested this patch with Qemu on Xen hypervisor. Depending on kernel
  patch (virtio: Add support for no-reset virtio PCI PM:
  https://lore.kernel.org/lkml/20231208070754.3132339-1-stevensd@chromium.org/)
* Changed the default value of flag VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT to false
* Fixed coding style violation
* Modified the content of the comments.
* Removed useless flag PCI_PM_CTRL_DATA_SCALE_MASK.


V6:
In current code, when guest does S3, virtio devices are reset during that process, that
causes the display resources of virtio-gpu are destroyed, then the display can't come
back after resuming.
This v6 patch implement the No_Soft_Reset bit of PCI_PM_CTRL register, when this bit is
set, the resetting will not be done, so that the display can work after resuming.
This version abandons all previous version implementations and is a new different
solution according to the outcome of the discussion and suggestions in the mailing
thread of virtio-spec.
(https://lists.oasis-open.org/archives/virtio-comment/202401/msg00077.html)


V5:
v5 makes below changes:
* Since this series patches add a new mechanism that let virtgpu and Qemu can negotiate
  their reset behavior, and other guys hope me can improve this mechanism to virtio pci
  level, so that other virtio devices can also benefit from it. So instead of adding
  new feature flag VIRTIO_GPU_F_FREEZE_S3 only serves for virtgpu, v5 add a new parameter
  named freeze_mode to struct VirtIODevice, when guest begin suspending, set freeze_mode
  to VIRTIO_PCI_FREEZE_MODE_FREEZE_S3, and then all virtio devices can get this status,
  and notice that guest is suspending, then they can change their reset behavior . See
  the new commit "virtio-pci: Add freeze_mode case for virtio pci"
* The second commit is just for virtgpu, when freeze_mode is VIRTIO_PCI_FREEZE_MODE_FREEZE_S3,
  prevent Qemu destroying render resources, so that the display can come back after resuming.
V5 of kernel patch:
https://lore.kernel.org/lkml/20230919104607.2282248-1-Jiqian.Chen@amd.com/T/#t
The link to trace this issue:
https://gitlab.com/qemu-project/qemu/-/issues/1860


v4:
Thanks for Gerd Hoffmann's advice. V4 makes below changes:
* Use enum for freeze mode, so this can be extended with more
  modes in the future.
* Rename functions and paratemers with "_S3" postfix.
And no functional changes.
Link:
https://lore.kernel.org/qemu-devel/20230720120816.8751-1-Jiqian.Chen@amd.com/
No v4 patch on kernel side.


v3:
Thanks for Michael S. Tsirkin's advice. V3 makes below changes:
* Remove changes in file include/standard-headers/linux/virtio_gpu.h
  I am not supposed to edit this file and it will be imported after
  the patches of linux kernel was merged.
Link:
https://lore.kernel.org/qemu-devel/20230719074726.1613088-1-Jiqian.Chen@amd.com/T/#t
V3 of kernel patch:
https://lore.kernel.org/lkml/20230720115805.8206-1-Jiqian.Chen@amd.com/T/#t


v2:
makes below changes:
* Change VIRTIO_CPU_CMD_STATUS_FREEZING to 0x0400 (<0x1000)
* Add virtio_gpu_device_unrealize to destroy resources to solve
  potential memory leak problem. This also needs hot-plug support.
* Add a new feature flag VIRTIO_GPU_F_FREEZING, so that guest and
  host can negotiate whenever freezing is supported or not.
Link:
https://lore.kernel.org/qemu-devel/20230630070016.841459-1-Jiqian.Chen@amd.com/T/#t
V2 of kernel patch:
https://lore.kernel.org/lkml/20230630073448.842767-1-Jiqian.Chen@amd.com/T/#t


v1:
Hi all,
I am working to implement virtgpu S3 function on Xen.

Currently on Xen, if we start a guest who enables virtgpu, and then run
"echo mem > /sys/power/state" to suspend guest. And run "sudo xl trigger <guest id> s3resume"
to resume guest. We can find that the guest kernel comes back, but the display doesn't.
It just shown a black screen.

Through reading codes, I founded that when guest was during suspending, it called into Qemu
to call virtio_gpu_gl_reset. In virtio_gpu_gl_reset, it destroyed all resources and reset
renderer. This made the display gone after guest resumed.

I think we should keep resources or prevent they being destroyed when guest is suspending.
So, I add a new status named freezing to virtgpu, and add a new ctrl message
VIRTIO_GPU_CMD_STATUS_FREEZING to get notification from guest. If freezing is set to true,
and then Qemu will realize that guest is suspending, it will not destroy resources and will
not reset renderer. If freezing is set to false, Qemu will do its origin actions, and has no
other impaction.

And now, display can come back and applications can continue their status after guest resumes.
Link:
https://lore.kernel.org/qemu-devel/20230608025655.1674357-1-Jiqian.Chen@amd.com/
V1 of kernel patch:
https://lore.kernel.org/lkml/20230608063857.1677973-1-Jiqian.Chen@amd.com/

Jiqian Chen (2):
  virtio-pci: only reset pm state during resetting
  virtio-pci: implement No_Soft_Reset bit

 hw/core/machine.c              |  1 +
 hw/virtio/virtio-pci.c         | 37 +++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-pci.h |  5 +++++
 3 files changed, 42 insertions(+), 1 deletion(-)

-- 
2.34.1


