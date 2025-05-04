Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA4DC369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 17:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBcle-0006ua-1B; Sun, 04 May 2025 13:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1uBclb-0006uK-VD
 for qemu-devel@nongnu.org; Sun, 04 May 2025 13:04:40 -0400
Received: from mail-mw2nam12on20618.outbound.protection.outlook.com
 ([2a01:111:f403:200a::618]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1uBclY-0005J3-IY
 for qemu-devel@nongnu.org; Sun, 04 May 2025 13:04:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2SUEOSzINTlnraavjgI9EYsAsIzUw7EKGUtejz/vhyaAoYm+HrHI2lI0WeOYz0rACxHb7DxQ4KYmoO7z2o2ZFFVcNNbBaHei6XyoOe3suDTwNBtUZGGZUw/1++jnv4mWJkP3jOD9Sboz7QuU2xGbwdBw0Jqblfk8UkvyFNAvbOd4RjKfywLpXJ//V8zJho7DaL9fup0Od28YDHirFd9rxzOn4/j+yM9JrBbbNB7UKH+qX/C+x0sSILy+vWsthmObCDIZVZUuY+XfSqJeUnJDtSbkLObpxCRnhsgcTi7lZ4Q+82tZEomi1LaIC+O7XpMQHfo0hacT7qRSp+EqpAcaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faeeR9DI+ZtFWM1r0S0GdUcjt+ZOS5muH8LQAJ3fSPg=;
 b=Vzlw+5Xn4gnAPeFafJkO8anKYW2rKKiXhrHzAxrM1L78yXkbPHG76gvXLg1tr+7MHgtcYk4/XZYceQ/RqQP51nqZ/QbZ+G7RcGwog3FvOLjG2wvBSNXLstbmTbs3UXopLTSeLrBV28zPn0VHAlPmO2ylKHVdMghin/82avHPTIcvQbGF6uTpP/NDglvyaWClQq8dQPeGxDhSkLyeiQQUcfTfh4Rq/1rs7u1rmD+5lI8T2ybDcxg030ieE2wnVeLw+hXpy6MyJsiHjLPZ2n0vbiftAnQJXoqPhA/dukbp9dw4+RZh/bK/6KMb5YWDyQQiT2e5s9cxTKk3My4FZfgFXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faeeR9DI+ZtFWM1r0S0GdUcjt+ZOS5muH8LQAJ3fSPg=;
 b=LvqFV5xx7LZkAXTPoRR3QgrZsGpHzPqSMElzVtyLxcF84ZZsu9xEM0yrVBQWcYNeB3GlPwjWr4iEz0BH6UyHdwh2w9hptPToyZrwph4lb5rcqjlizJ7a6FgkptiGxB7i3hLaOSk5gZJ4xponSRdRlhSfJr92I1sMUa0aL27XsVs=
Received: from CH2PR10CA0019.namprd10.prod.outlook.com (2603:10b6:610:4c::29)
 by SA1PR12MB6920.namprd12.prod.outlook.com (2603:10b6:806:258::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Sun, 4 May
 2025 17:04:28 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::34) by CH2PR10CA0019.outlook.office365.com
 (2603:10b6:610:4c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.43 via Frontend Transport; Sun,
 4 May 2025 17:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Sun, 4 May 2025 17:04:28 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 4 May
 2025 12:04:24 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
 <vasant.hegde@amd.com>, <Wei.Huang2@amd.com>, <bsd@redhat.com>,
 <berrange@redhat.com>, <joao.m.martins@oracle.com>,
 <alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 1/2] hw/i386/amd_iommu: Isolate AMDVI-PCI from amd-iommu
 device to allow full control over the PCI device creation
Date: Sun, 4 May 2025 17:04:04 +0000
Message-ID: <20250504170405.12623-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250504170405.12623-1-suravee.suthikulpanit@amd.com>
References: <20250504170405.12623-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|SA1PR12MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e2e482-d17b-4c93-41ee-08dd8b2dbb0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmlNTnBQbitRS1NPVlBvMjRYbnRlbytRU3kxM0VpU2F4dElIWVdvN2E1dVNz?=
 =?utf-8?B?TjZRdFp2T081WDJwcjgxL1ExOVdjZkVoQTgvVzIwQkVCbUw4NnpBUDBXa3o5?=
 =?utf-8?B?OTZONjR4NmNzNXVydFlqL2hwM0tlSXFGamNOazc1R2Q2cUR5bWhLSVkwSks2?=
 =?utf-8?B?L2M4ZXR4MzdtNkg2Sm1HY2t4ZFdwTThhQTJ5a3pQZ3ZCLzgvdy9uNWszNGpS?=
 =?utf-8?B?MTQzSlcxeVRnaFNEd3BFd2ZQYXZZb09VM0E2YXoyaWFlQVlQM0ErM3kveWVx?=
 =?utf-8?B?Mm5Nb1BPQmE3eEJ5MW4rUTFVR00rb0RxUWlUaWl6bjN5WkNFR2M0cmxBY1B6?=
 =?utf-8?B?RzZmYUJvUVJJditJQ2NCVlJHRGpCak9TeDF5WCtlZTVTUThhMmVEQkZuZENO?=
 =?utf-8?B?Z0FoZjRXWjNQRk82ZUpDbDBvRWlEdDc4bW9VWHFZZmFURWptN1BSejU5eHU0?=
 =?utf-8?B?SzB3TGt4KzByOXI2QXVzZHpjU09IVjMwd0luUHJGcWhwU0RxK0FwVkdtb1I2?=
 =?utf-8?B?WGNZMDlxSEZDdk0wQnlNcDUzRWFDQVNRWjFoaGdhSUZYTFFBUFhLMmVxVWoz?=
 =?utf-8?B?VmFOTWpjanpkNkp5SG9QZ0RQNEVpenhFR214K0RReG40TkVtbkQ0aU8vc01C?=
 =?utf-8?B?MGdMM25hV20xNGFhQWFCVStqVWdBMTZja29EQ3FSbnBiNGM2bjlMRkc3Vkhr?=
 =?utf-8?B?U0RwWTVGYzcyZTcxWEtEbjdJWE9RcW84a05WMGVTWmhWRUJjNmZyMGthTCs0?=
 =?utf-8?B?SVVLbW5yWENLY09vQzJxcWVzNG9Sc1JyaUZpS2ZhUGhCaWdaeHlGVnBiVDNm?=
 =?utf-8?B?WDUwRVl3c1dLY2dScDU0ZXZ3cm1obWRiWWREQmVTUURYRkNyN2xNM2lPZmFI?=
 =?utf-8?B?UmJJaGZTRklDR0plMGMrV0FsNHFUdklleVpnbSsrcStqSGtmS0QrcTFBUEto?=
 =?utf-8?B?YjdvREZZWXZDTURyNUZUY1lNWEtQeUtLSUZIT1FaWHI5TVR5ZzBzeENuY1RL?=
 =?utf-8?B?NmtuZDBlYWdPZFBoYmZlSXJwNlFuRTJlTzl1Nk95RVdGTUFzbW1nNmNyNmN4?=
 =?utf-8?B?dGRpVEdOeDU1MDdzUldBN0Z5aVNnczZXbVhPN0x3YnNDUVpiN0Ztakp2Vkt3?=
 =?utf-8?B?akVTUlErbHBVQTBZQ1dKUFhnM1VyZ3R0S1BCa3JXWjJrMUM5MHQrOTJBWXIr?=
 =?utf-8?B?M2h4cEdtZDVFcDZMV041NkFuWDlGc2xKd3JaaHZVM1VZZHlZMnBCYjZhaGRi?=
 =?utf-8?B?UUtkaE1saWpWaVhSOUxIY251L0xvVDRzWFF1dzJoVWFVVzFzM2V1SDE1Yitm?=
 =?utf-8?B?UmJzNWEvMlAzWGc4eWZVN3N3QTluZVZ2K0NWSzNiNlZsSkEyd3VEYnRDVTNM?=
 =?utf-8?B?aURrL2VkZHdwblN0eW0rcWdsU0d3WEZpMWdjVk5lR2ZLRXZUWHBNeEh3OWJ3?=
 =?utf-8?B?bVlMWUJqY3MzYmZ0Nkl5UTU1SXk2RHdWVDNHeERYdEsvSnlmdkgxYjRyTU9Q?=
 =?utf-8?B?TERtNnFEZmhBcTFDbjN5L3BOaVE1anNxQXA4U1ZpblRMMWs0bmNiM0xTWFRr?=
 =?utf-8?B?bTQ1YWpXazNBcnBYZGQ2bkx2U0pYdzl1OEZhZm5uS1RaanF2dW9JSzEyQnkr?=
 =?utf-8?B?cWxKQk52UjFrcEhTbzBHMHdkbHhnQkZZK3BSMStKL0NJQXVpQWl0eE5CV3pv?=
 =?utf-8?B?REM4azZFc2NyU0RQUUhhVGtOb3I4VU1JMUk1dUo5RlhxVHEza3YyTnNaRDNq?=
 =?utf-8?B?UW1EVnZMcEdoZE0vdUxYS3h3R29xbWdDc0J5L1pjU25ZS0p0aFFoNkhxbFlr?=
 =?utf-8?B?Q0VTc2pybE53em9YakdIS00wUDBjQUZObVBMOUE4N0E1c3pQVGNrckRqVnlX?=
 =?utf-8?B?VjYzOFlmMFhNZkJMYTNQV1JVT2V0cTE1VGhZNkt6M2haajd5SWg2QWk2T0Iw?=
 =?utf-8?B?MVl0Z1VyRlcvSEFmc1ZqSC9LbE9CQTZ4ZXFhNTN2aUdFcnVBT3FLYktId1R2?=
 =?utf-8?B?aGo4L0x6L1UvLyt0eng2eFY3NWR2UHlheHBDS3B3V1lFYVlGbWJHUThJUDN0?=
 =?utf-8?Q?puzd8i?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 17:04:28.3888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e2e482-d17b-4c93-41ee-08dd8b2dbb0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6920
Received-SPF: permerror client-ip=2a01:111:f403:200a::618;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Current amd-iommu model internally creates an AMDVI-PCI device. Here is
a snippet from info qtree:

  bus: main-system-bus
    type System
    dev: amd-iommu, id ""
      xtsup = false
      pci-id = ""
      intremap = "on"
      device-iotlb = false
      pt = true
    ...
    dev: q35-pcihost, id ""
      MCFG = -1 (0xffffffffffffffff)
      pci-hole64-size = 34359738368 (32 GiB)
      below-4g-mem-size = 134217728 (128 MiB)
      above-4g-mem-size = 0 (0 B)
      smm-ranges = true
      x-pci-hole64-fix = true
      x-config-reg-migration-enabled = true
      bypass-iommu = false
      bus: pcie.0
        type PCIE
        dev: AMDVI-PCI, id ""
          addr = 01.0
          romfile = ""
          romsize = 4294967295 (0xffffffff)
          rombar = -1 (0xffffffffffffffff)
          multifunction = false
          x-pcie-lnksta-dllla = true
          x-pcie-extcap-init = true
          failover_pair_id = ""
          acpi-index = 0 (0x0)
          x-pcie-err-unc-mask = true
          x-pcie-ari-nextfn-1 = false
          x-max-bounce-buffer-size = 4096 (4 KiB)
          x-pcie-ext-tag = true
          busnr = 0 (0x0)
          class Class 0806, addr 00:01.0, pci id 1022:0000 (sub 1af4:1100)
    ...

This prohibits users from specifying the PCI topology for the amd-iommu device,
which becomes a problem when trying to support VM migration since it does not
guarantee the same enumeration of AMD IOMMU device.

Therefore, allow the 'AMDVI-PCI' device to optionally be pre-created and
associated with a 'amd-iommu' device via a new 'pci-id' parameter on the
latter.

For example:
  -device AMDVI-PCI,id=iommupci0,bus=pcie.0,addr=0x05 \
  -device amd-iommu,intremap=on,pt=on,xtsup=on,pci-id=iommupci0 \

For backward-compatibility, internally create the AMDVI-PCI device if not
specified on the CLI.

Co-developed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 hw/i386/acpi-build.c |  8 +++----
 hw/i386/amd_iommu.c  | 53 ++++++++++++++++++++++++++------------------
 hw/i386/amd_iommu.h  |  3 ++-
 3 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 3fffa4a332..f4b65701a4 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2333,10 +2333,10 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
     build_append_int_noprefix(table_data, ivhd_blob->len + 24, 2);
     /* DeviceID */
     build_append_int_noprefix(table_data,
-                              object_property_get_int(OBJECT(&s->pci), "addr",
+                              object_property_get_int(OBJECT(s->pci), "addr",
                                                       &error_abort), 2);
     /* Capability offset */
-    build_append_int_noprefix(table_data, s->pci.capab_offset, 2);
+    build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
     /* IOMMU base address */
     build_append_int_noprefix(table_data, s->mr_mmio.addr, 8);
     /* PCI Segment Group */
@@ -2368,10 +2368,10 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
     build_append_int_noprefix(table_data, ivhd_blob->len + 40, 2);
     /* DeviceID */
     build_append_int_noprefix(table_data,
-                              object_property_get_int(OBJECT(&s->pci), "addr",
+                              object_property_get_int(OBJECT(s->pci), "addr",
                                                       &error_abort), 2);
     /* Capability offset */
-    build_append_int_noprefix(table_data, s->pci.capab_offset, 2);
+    build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
     /* IOMMU base address */
     build_append_int_noprefix(table_data, s->mr_mmio.addr, 8);
     /* PCI Segment Group */
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 2cf7e24a21..f5466fdc98 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -167,11 +167,11 @@ static void amdvi_generate_msi_interrupt(AMDVIState *s)
 {
     MSIMessage msg = {};
     MemTxAttrs attrs = {
-        .requester_id = pci_requester_id(&s->pci.dev)
+        .requester_id = pci_requester_id(&s->pci->dev)
     };
 
-    if (msi_enabled(&s->pci.dev)) {
-        msg = msi_get_message(&s->pci.dev, 0);
+    if (msi_enabled(&s->pci->dev)) {
+        msg = msi_get_message(&s->pci->dev, 0);
         address_space_stl_le(&address_space_memory, msg.address, msg.data,
                              attrs, NULL);
     }
@@ -239,7 +239,7 @@ static void amdvi_page_fault(AMDVIState *s, uint16_t devid,
     info |= AMDVI_EVENT_IOPF_I | AMDVI_EVENT_IOPF;
     amdvi_encode_event(evt, devid, addr, info);
     amdvi_log_event(s, evt);
-    pci_word_test_and_set_mask(s->pci.dev.config + PCI_STATUS,
+    pci_word_test_and_set_mask(s->pci->dev.config + PCI_STATUS,
             PCI_STATUS_SIG_TARGET_ABORT);
 }
 /*
@@ -256,7 +256,7 @@ static void amdvi_log_devtab_error(AMDVIState *s, uint16_t devid,
 
     amdvi_encode_event(evt, devid, devtab, info);
     amdvi_log_event(s, evt);
-    pci_word_test_and_set_mask(s->pci.dev.config + PCI_STATUS,
+    pci_word_test_and_set_mask(s->pci->dev.config + PCI_STATUS,
             PCI_STATUS_SIG_TARGET_ABORT);
 }
 /* log an event trying to access command buffer
@@ -269,7 +269,7 @@ static void amdvi_log_command_error(AMDVIState *s, hwaddr addr)
 
     amdvi_encode_event(evt, 0, addr, info);
     amdvi_log_event(s, evt);
-    pci_word_test_and_set_mask(s->pci.dev.config + PCI_STATUS,
+    pci_word_test_and_set_mask(s->pci->dev.config + PCI_STATUS,
             PCI_STATUS_SIG_TARGET_ABORT);
 }
 /* log an illegal command event
@@ -310,7 +310,7 @@ static void amdvi_log_pagetab_error(AMDVIState *s, uint16_t devid,
     info |= AMDVI_EVENT_PAGE_TAB_HW_ERROR;
     amdvi_encode_event(evt, devid, addr, info);
     amdvi_log_event(s, evt);
-    pci_word_test_and_set_mask(s->pci.dev.config + PCI_STATUS,
+    pci_word_test_and_set_mask(s->pci->dev.config + PCI_STATUS,
              PCI_STATUS_SIG_TARGET_ABORT);
 }
 
@@ -1607,7 +1607,7 @@ static void amdvi_sysbus_reset(DeviceState *dev)
 {
     AMDVIState *s = AMD_IOMMU_DEVICE(dev);
 
-    msi_reset(&s->pci.dev);
+    msi_reset(&s->pci->dev);
     amdvi_init(s);
 }
 
@@ -1619,14 +1619,32 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     X86MachineState *x86ms = X86_MACHINE(ms);
     PCIBus *bus = pcms->pcibus;
 
-    s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
-                                     amdvi_uint64_equal, g_free, g_free);
+    if (s->pci_id) {
+        PCIDevice *pdev = NULL;
+        int ret = pci_qdev_find_device(s->pci_id, &pdev);
 
-    /* This device should take care of IOMMU PCI properties */
-    if (!qdev_realize(DEVICE(&s->pci), &bus->qbus, errp)) {
-        return;
+        if (ret) {
+            error_report("Cannot find PCI device '%s'", s->pci_id);
+            return;
+        }
+
+        if (!object_dynamic_cast(OBJECT(pdev), TYPE_AMD_IOMMU_PCI)) {
+            error_report("Device '%s' must be an AMDVI-PCI device type", s->pci_id);
+            return;
+        }
+
+        s->pci = AMD_IOMMU_PCI(pdev);
+    } else {
+        s->pci = AMD_IOMMU_PCI(object_new(TYPE_AMD_IOMMU_PCI));
+        /* This device should take care of IOMMU PCI properties */
+        if (!qdev_realize(DEVICE(s->pci), &bus->qbus, errp)) {
+            return;
+        }
     }
 
+    s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
+                                     amdvi_uint64_equal, g_free, g_free);
+
     /* Pseudo address space under root PCI bus. */
     x86ms->ioapic_as = amdvi_host_dma_iommu(bus, s, AMDVI_IOAPIC_SB_DEVID);
 
@@ -1663,6 +1681,7 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
 
 static const Property amdvi_properties[] = {
     DEFINE_PROP_BOOL("xtsup", AMDVIState, xtsup, false),
+    DEFINE_PROP_STRING("pci-id", AMDVIState, pci_id),
 };
 
 static const VMStateDescription vmstate_amdvi_sysbus = {
@@ -1670,13 +1689,6 @@ static const VMStateDescription vmstate_amdvi_sysbus = {
     .unmigratable = 1
 };
 
-static void amdvi_sysbus_instance_init(Object *klass)
-{
-    AMDVIState *s = AMD_IOMMU_DEVICE(klass);
-
-    object_initialize(&s->pci, sizeof(s->pci), TYPE_AMD_IOMMU_PCI);
-}
-
 static void amdvi_sysbus_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1696,7 +1708,6 @@ static const TypeInfo amdvi_sysbus = {
     .name = TYPE_AMD_IOMMU_DEVICE,
     .parent = TYPE_X86_IOMMU_DEVICE,
     .instance_size = sizeof(AMDVIState),
-    .instance_init = amdvi_sysbus_instance_init,
     .class_init = amdvi_sysbus_class_init
 };
 
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 28125130c6..7a28181d9c 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -315,7 +315,8 @@ struct AMDVIPCIState {
 
 struct AMDVIState {
     X86IOMMUState iommu;        /* IOMMU bus device             */
-    AMDVIPCIState pci;          /* IOMMU PCI device             */
+    AMDVIPCIState *pci;         /* IOMMU PCI device             */
+    char *pci_id;               /* ID of AMDVI-PCI device, if user created */
 
     uint32_t version;
 
-- 
2.34.1


