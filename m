Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C8ACCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 10:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE35e-0005wT-Si; Wed, 29 Oct 2025 06:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vE35d-0005wB-79
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:07:37 -0400
Received: from mail-eastus2azon11010024.outbound.protection.outlook.com
 ([52.101.56.24] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vE35W-0004YR-WE
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:07:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1d+icwdyHYNgh8GZp8KZMvhVNLLNDgk0wL3SxOJ/QkIWMS22MR9JY2Md9ESD0nYrIEGVJJZSo3fm7lvYCrCwrHK1YPY7MIM7y0zAGpKN0dko2ryN9k0tVdnLU5QCNhIJww0nLecGSR/DVdWXLhncAEHa18B3r6O21mz1jWb8V1xcdg5Y+XCAyOr2NEzv19KYFMQswk4vQ8YjE+AbxnVdsffcvR6fBl+bF65ex5J0uD2l/FVit4hbVTqYAKCre0p/6ns/xOcGI1yl7N8mBSaXNUj40o22evZREMfAOaMs5SscYB2wJ7xi9A4uXnRA5J6EGKPkZi4060bQjwIcS1lPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wekBdG0pmGpk7mBzoPcnd1WJeOYaIZ9cLxz4ABYwSs=;
 b=YVBRbSS4xtFrQrMZGfSTBAj+dcTDPRPgCFsxJ3NTaoo5YRscIIYThYaI1RdQHHREGnVN2F2flPcdSRgtnYeQySaoLkYNeBjg9oJkp1eTqUmvvpKRHN+PmH87Kd8LvywGhYxZMGSOhm5/vVjvCFET07JhADA/5FpuPGovDqLNeefXhxGEsl28+JZWi6KVMChv+ghAfEbX4qqTEIQ0H1dAaZvPIdNvrgzSub0YY0B5J0Ef0m/Q+Y9OB++jtg37hPB5IWqV+40HkkbHqGiqps8y4wbXXEqGOvV/d6BbMUCu/ydBzE0g8vewHF7ypdvxzxKAs0DwKAZXj5hEYbHyJW0FeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wekBdG0pmGpk7mBzoPcnd1WJeOYaIZ9cLxz4ABYwSs=;
 b=tdUCUvlLerSoNGbZ7/5E/3XzH/Vrj1lThvWitNa2vjp1NHYJnZPTBSdKW2B6JAxgVaSsB9upHy1LGcHF1Jo7yrBtRESj6hDq4Iyc91Ex8Apt8vgQf4X3u6vk1hCqQH32EkiDuPY54hwHbxKB+MCQINBGRNWWzq9Em2baGRoxtls=
Received: from BN1PR13CA0001.namprd13.prod.outlook.com (2603:10b6:408:e2::6)
 by SA3PR12MB9158.namprd12.prod.outlook.com (2603:10b6:806:380::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 10:02:14 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:408:e2:cafe::f0) by BN1PR13CA0001.outlook.office365.com
 (2603:10b6:408:e2::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.4 via Frontend Transport; Wed,
 29 Oct 2025 10:02:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Wed, 29 Oct 2025 10:02:14 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 03:02:10 -0700
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, <yi.l.liu@intel.com>,
 <eric.auger@redhat.com>, <zhenzhong.duan@intel.com>, <cohuck@redhat.com>,
 <qemu-devel@nongnu.org>, <alejandro.j.jimenez@oracle.com>,
 <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
CC: Sairaj Kodilkar <sarunkod@amd.com>
Subject: [RFC PATCH 0/5] amd_iommu: support up to 2048 MSI vectors per IRT
Date: Wed, 29 Oct 2025 15:31:47 +0530
Message-ID: <20251029100152.4807-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|SA3PR12MB9158:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a8606c2-17fe-46a8-cdca-08de16d23c84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|36860700013|376014|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmNiUFdvYy85b3JmRVZWQ2tNZFRhQkI0SXAzWnZleHVvTVVMczNXMERrb0xx?=
 =?utf-8?B?OFJKQTM5TUszSU5nNjdvNTV6UnhzRFhDM0J6UXdMWERVODhwKzd3ckJULzdV?=
 =?utf-8?B?YkZyTzJBdEw4U01MNWt3dW5yZzFteGk4VDRZclNmc09XMjdHMEJDcERmanNP?=
 =?utf-8?B?VFpjTDFYTkRtREE5RjIzNUxzeWFPaXFnZUQzMUpuTS96aUpqTk5tY0ttU0xh?=
 =?utf-8?B?WFlFSTdyelZQcTRKZXdHUjBka3ByblBhU3VEOXlxalRVbWZYUmJONmF1RjUv?=
 =?utf-8?B?NWZuVDAzWmg3VjNBZGsvWlJaZ2p4ZHA3VElWN2J5azlqdXZNZ04vYlhQL1pE?=
 =?utf-8?B?UENpUUpCVDJiU1VyWTh0WXJiVEZYRENVZHNBbFpGY3pMeHhMS3d3bEVxczNi?=
 =?utf-8?B?bUl6VDJyNnl1SlF4Z2p3VVRnb1RXVGc4bjNncnU1YzB1Z2c2cUswa1h3ZDBn?=
 =?utf-8?B?NGZPNFdvcklEWWdXa09TNDJKQnJwSU5GME9qTWgwdFdORzBpZDZnNjREcHpQ?=
 =?utf-8?B?dlB6UVU1OXNrTjg2dHVpRG82WkFzeTlXTlBqaHdMQlNGMVZsaWtzZXZwVlkw?=
 =?utf-8?B?TzY0V2d1TjZnVjl3c3g0a0Zzbkh5NUVQQ2JqSnZCTTViTGJjaFo3VmdkeFdW?=
 =?utf-8?B?NHB5QzNtSjE1TGNsOXNPajJHWi9IOERpL01qYWdOSlVkMlhNN1ltVW5jUkJp?=
 =?utf-8?B?ejQvRGR5TThsbTVKd2xHcWlwbE52OW4vU2wwMEVoRXM3cHFhRFFLa3FNblcw?=
 =?utf-8?B?VndoU0Y0VTN1WXRMdVdDdEIyK1RvQWtPZjR3KzJIZTdpSC82Z0VIbm44Tm5l?=
 =?utf-8?B?K2lsNi96Snd0aWJJWUZiMWkrVHpFeU9UcFQ4eE9TeHUvOFVWYWVWUkx1cXhO?=
 =?utf-8?B?RkkvZWk4cFdXcVQ1YmpFT3RHZlBMZ3c4ck5PSm9oZG91T2ZKT3Rlek83Y1Na?=
 =?utf-8?B?UVFRMXV1MjY3bzRDZ3JYWm0zQWhHdDhocUF2QTVEU0ViRUY5RlhXS01qLzN4?=
 =?utf-8?B?dVBaNENrOVA0MXFhbUYxOXc1VlJhMEo2KzFRQk93RDd5RXI4TkQvVU9OS04z?=
 =?utf-8?B?NGpRMDZBMFFLMWh0azBPbzFNNHM2dFEyeERZQ1owMXV6ZEpDaStZS1V6eXRO?=
 =?utf-8?B?dVZZMnNtOTQ5ZnpLQzA1TWpMNmVKREVFdWVBTzdYMHhhWGdQM3FZNFdqNjBo?=
 =?utf-8?B?TTJZVzdyWUxWRzlJZmpMaVBWT2JPdzQvc29WWnJsYTE0OCs2ZHlhNEltWTVY?=
 =?utf-8?B?cEdmUzZEL0xEMHZyMUZ2SDNxbm0va21YY1VDMVlSZXR1d2s1NUwzUFV5T1NQ?=
 =?utf-8?B?bmdIVFRYR2VWYTBVanYvOStOemlXVDA3di9EY3lPTEthQS9OZ0FpSVArQWlP?=
 =?utf-8?B?YzV1VXN6bkttZDVHWDhnUXozeFduQlI5NHNJT1h3MDRYSEFRc0hzUUVXcFhh?=
 =?utf-8?B?S3UrUXZlQ1BCbXBIOXVrdmxOaXhvYzVtdGVKUFBzemV3b0gycXhIS3VyRkdK?=
 =?utf-8?B?R1g0OFFPY1A2VlFhak43ZUhJRmtXdmlSNWtodUQwSlhBb1JkQmk0WGhON2pL?=
 =?utf-8?B?Q01Fb2JxWndCeEdRTUs5U3JnMG56T2M1ZnBTcDYwODIzNWtsbEZ2QVhYcmhO?=
 =?utf-8?B?b1ZGaDlCNEJ6V0ovM0VneUxUbDRqdGxqVW90SmZzN1NxZGRBSlJ5b0xIWWw0?=
 =?utf-8?B?Y05aVEtudzRKVHJlM0psN1F6ck9lMko2RDRlT3VKRXNoTENCbUlJUnRWNlMx?=
 =?utf-8?B?c2ppUzdSZzF4L2JhejFtWThZTVNFL2dUS1dobDFkdmhYYTZtV1lESWJyaks5?=
 =?utf-8?B?dXVYRWxQMFpHS2NaZnQyTWd6Y1FlcWVKdWZVWEpVdFArTFlpeHNMeXRBYTJW?=
 =?utf-8?B?V2NCZlVvSS85czZsQlhDaGlaTlJ6QTcxVmd6UFc3YWxZSDF2NzVyUHEzUkc2?=
 =?utf-8?B?Nm1sQ1RYaUxXOTRnM3A5VndXMWhiZFF6RWlCSlZkdGNQK3h2eDBDM01VUjZC?=
 =?utf-8?B?RXBrdERFa2dqaWF4M24vdmFZR1RpaXhlL0Y5YkdKNXcyTUZBTnY0R05CRlJJ?=
 =?utf-8?B?M2l6TSsrT1VoUFZWOVVrT2QreXFvWElMZGswVDVBTS9aVmJJUDlBaWxtUFNh?=
 =?utf-8?Q?Qrk4yEDNbZHkSejzrcszbcoeF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(1800799024)(921020);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 10:02:14.7036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8606c2-17fe-46a8-cdca-08de16d23c84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9158
Received-SPF: permerror client-ip=52.101.56.24;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

AMD IOMMU can route upto 2048 MSI vectors through a single
Interrupt Remapping Table (IRT) entry. This series brings the same
capability to the emulated AMD IOMMU in QEMU.

Highlights
----------
* Sets bits [9:8] in Extended-Feature-Register-2 to advertise 2K MSI
  support to the guest.
* Uses bits [10:0] of the MSI data to select the IRTE when the guest
  programs MSIs in logical-destination mode.
* Introduces a new IOMMU device property:
        -device amd-iommu,...,numint2k=on

  The feature is **opt-in**; guests keep the 512-MSI behaviour unless
  `numint2k=on` is supplied.

Passthrough devices
-------------------
When a PCI function is passed through via iommufd the code checks the
host’s vendor capabilities.  If the host IOMMU has not enabled
2K-MSI support (bits [44:43] set in the control register) the guest
feature is disabled even if `numint2k=on` was requested.

The detection logic relies on the iommufd interface; with the legacy
VFIO container the guest always falls back to 512 MSIs.

Example
-------
qemu-system-x86_64 \
-enable-kvm -m 10G -smp cpus=8 \
-kernel /boot/vmlinuz \
-initrd /boot/initrd.img \
-append "console=ttyS0 earlyprintk=serial root=<DEVICE>" 
-device amd-iommu,dma-remap=on,numint2k=on \
-object iommufd,id=iommufd0 \
-device vfio-pci,host=<DEVID>,iommufd=iommufd0 \
-global kvm-pit.lost_tick_policy=discard \
-cpu host \
-machine q35,kernel_irqchip=split \
-nographic \
-smbios type=0,version=2.8 \
-blockdev node-name=drive0,driver=qcow2,file.driver=file,file.filename=<IMAGE> \
-device virtio-blk-pci,drive=drive0

Limitations
-----------
This approach works well for features queried after IOMMUFD
initialization but cannot handle features needed during early QEMU
setup, before IOMMUFD is available.

A key example is EFR2[HTRangeIgnore]. When this bit is set, the physical
IOMMU treats HyperTransport (HT) address ranges as regular memory
accesses rather than reserved regions. This has important implications
for memory layout:

* Without HTRangeIgnore: QEMU must relocate RAM above 4G to above 1T on
  AMD platforms to avoid HT conflicts
* With HTRangeIgnore: QEMU can safely place RAM immediately above 4G,
  improving memory utilization

Since RAM layout must be determined before IOMMUFD initialization, QEMU
cannot use hwinfo to query EFR2[HTRangeIgnore] feature bit.

Another limitation with using the control register is that, if BIOS enables
particular feature (e.g. ControlRegister[GCR3TRPMode) without kernel support
QEMU incorrectly assumes that host kernel supports that feature potentially
causing guest failure. 

Alternative considered
----------------------
We also explored alternate approach which uses KVM capability
"KVM_CAP_AMD_NUM_INT_2K_SUP", which user can query to know if host
kernel supports 2K MSIs. Similarly, this enables qemu to detect the
presence of EFR2[HTRangeIgnore] during RAM initialization.

Although current implementation allows 2K MSI support only with
iommufd, it keeps the logic inside the vfio/iommufd and avoids
modifying KVM ABI. I am happy to discuss advantages and drawbacks of
both approaches.

------------------------------------------------------------------------

The patches are based on top of bc831f37398b (qemu master). Additionally
it requires linux kernel with patches[1] which expose control register
via IOMMU_GET_HW_INFO ioctl.

[1] https://lore.kernel.org/linux-iommu/20251029095846.4486-1-sarunkod@amd.com/
------------------------------------------------------------------------

Sairaj Kodilkar (3):
  vfio/iommufd: Add amd specific hardware info struct to vendor
    capability
  amd_iommu: Add support for extended feature register 2
  amd_iommu: Add support for upto 2048 interrupts per IRT

Suravee Suthikulpanit (2):
  [DO NOT MERGE] linux-headers: Introduce struct iommu_hw_info_amd
  amd-iommu: Add support for set/unset IOMMU for VFIO PCI devices

 hw/i386/acpi-build.c               |   4 +-
 hw/i386/amd_iommu-stub.c           |   5 +
 hw/i386/amd_iommu.c                | 163 +++++++++++++++++++++++++++--
 hw/i386/amd_iommu.h                |  24 +++++
 include/system/host_iommu_device.h |   1 +
 linux-headers/linux/iommufd.h      |  20 ++++
 6 files changed, 207 insertions(+), 10 deletions(-)

-- 
2.34.1


