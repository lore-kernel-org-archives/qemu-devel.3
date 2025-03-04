Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97816C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 14:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpT6f-0005Oy-4k; Tue, 04 Mar 2025 09:18:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1tpT6b-0005OP-Es
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 09:18:45 -0500
Received: from mail-bn8nam11on20618.outbound.protection.outlook.com
 ([2a01:111:f403:2414::618]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1tpT6T-0003Qw-7p
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 09:18:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rK/P0HTpJNrnJkzecEhiM445W4jizONkpVUdVfzZ6j8QiSINl2hAZ0hjnHRieFIQX3meHcO+P7Hfacq2fzdHyJTNrgYDyC4T0dAIp+q9nJyHHw3FF9kv1hnXtWk//k4KdUCODpl044PxynAs9flnPDR397jP/AJZNxlXPsKYuZNkN1+oWhIr+yaBFj2DMsmuPxX98/2t8pebbksKV8T9uLrqikCjqUf/IQllzF2eKLoryaw/GCM298Tql2DKo4IFXL2iRCN1gC7t+6n8uZQyvFlhyt9qL76admGqGGkWmgs0F6mqATGI0lEyWA7RYMAix9StTs85JfSBiiilE1VVyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGsJ3nSXXtVI9XNLXlkFt7+rGWOC2QYyBnYpADSDxps=;
 b=sQ2TQLn/f3QzgwPPbjdF5o8cqJ4rfBZTa2DI+XZXYaVbTcK6IWnMqLwr40b55hF5NbeS0N87Kbq253YgWt3L7jcScK0s3plax3chMqzU3AYjsAKxVLpy+9Sb3OnhqEgih8AyPVfac2gPS0QQumwPZjcWqqqODwvqKAqnPnfv9b17O3m0DWSyXm8pddzSfVir0OhLsBUIHoB0dse0/O5GUtjARKs722odoroDCIaz3B+7I5nEb5W/crHq25ViWJhPIHPQeAXr0BPU4iFwNTxeHfH8gKAW9QeQe7pvZyNUqjFTtxMQVB5PxDobaznUl8xOok73E8sZCHFdW2T0nWfGBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGsJ3nSXXtVI9XNLXlkFt7+rGWOC2QYyBnYpADSDxps=;
 b=Ja42ldYYzofCAyVANs7nAD2Ilgs00aIdX9JMhv1gtTBZbh6b3ZGlsbhAmx91P5E5xZoXGkTuS03Fo0JN9vBTtJp8hAwpKGG8GV3mIQT9+gtuN3/2E85lkbaQuKn9x3TGutFyPm1J+a4wEt2MY3h/S06YnKuoa0AlT3gQATS4jHs=
Received: from CH2PR14CA0024.namprd14.prod.outlook.com (2603:10b6:610:60::34)
 by SJ0PR12MB8091.namprd12.prod.outlook.com (2603:10b6:a03:4d5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Tue, 4 Mar
 2025 14:18:28 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::36) by CH2PR14CA0024.outlook.office365.com
 (2603:10b6:610:60::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Tue,
 4 Mar 2025 14:18:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Tue, 4 Mar 2025 14:18:27 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 08:18:23 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
 <vasant.hegde@amd.com>, <Wei.Huang2@amd.com>, <bsd@redhat.com>,
 <berrange@redhat.com>, <joao.m.martins@oracle.com>,
 <alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 1/2] hw/i386/amd_iommu: Isolate AMDVI-PCI from amd-iommu
 device to allow full control over the PCI device creation
Date: Tue, 4 Mar 2025 14:17:15 +0000
Message-ID: <20250304141716.638880-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304141716.638880-1-suravee.suthikulpanit@amd.com>
References: <20250304141716.638880-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|SJ0PR12MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa0ed41-9416-409e-f237-08dd5b276ef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z1g2Y2RvV2VuVzY5SjBZT1VHREdNSk10SjZEMzlzaFpoV0JiUnZrNmVPMWZm?=
 =?utf-8?B?cHoyb1Q5Y1JVM05lbll4L3lXZ1psM1hlN3Z5T0RJWWJLdGt0K0dKN1dqN21J?=
 =?utf-8?B?bFpDVHNZcEIyV2t1NEx2MUdYdktKc3VFbm1FbXdVdDdheFdmRVg2RUhZMHFx?=
 =?utf-8?B?b2ZIbGFrOFU2Ujcrd2RFeXpDU3hnbDJEU0NCSENtdTdNcUd5RWUwRytSVFNF?=
 =?utf-8?B?SjhWL3hHNUlhQ1JIVHlNdHZ4ZmMrVFRXeVg2RHlqQjd5eURrMXRyaCsrYUcr?=
 =?utf-8?B?T2RvNHZhblhCb1E0MWFCMmdDeUVzeldPb1QvQTZDeW5XOUFkTDFYNVhIeVVI?=
 =?utf-8?B?SUhXMGd6ZVA4Z1gzM1krUk9Tcis1aW5QaTRVOWdCaEpYcUtqTVp4c2htQ0Rm?=
 =?utf-8?B?cVZodUo3QlBaSk5VTFk5QVZrbTlWT3JRQk0vNUhnZytOZ0hzN2JFMk4wTkxp?=
 =?utf-8?B?Um52YURYeGhZQjcrQXhJa2M3ZXFQMWdPSlUvZGpQcTF0TDg1Yjh3bkluSklz?=
 =?utf-8?B?UWhEN3MzeDNnS1NvTDdYNTRxaWowTEVJQzhYL1NEMm0rMjVDNHpHcXh6bDRY?=
 =?utf-8?B?MXFlR1ZFSDR3T0V0TzRNWjdObDI3YzNZbWtaR0FXajMxMVVacEdqd2dXenIy?=
 =?utf-8?B?SzE4U0g4b1pHVC9aeTFETFRERmQ2cHcwNWUwNVhucCszbzZOdzNjR3UvcFV4?=
 =?utf-8?B?T000OUdRczFTQWJzODZqN1JaRWg2QmZtV0pNMTg3eG05WmRGNVk1UVl3aG5i?=
 =?utf-8?B?aG9DbHpoc2M1aXJhRWRaTkh0Y210OHEwbUU2ajkxNjlEc1FsQlQ1dWZQdGZV?=
 =?utf-8?B?dVFuRjFwcFFTTFdadDJVay9aV3IvbmI2NmhJeGU5dndtUXo5M0FPOWE0MEw3?=
 =?utf-8?B?ODJaU0RuTk10UkdLNnVoby80aVZCOW01SSsrKzZMVmJMeVRDbVh4WW85VGU3?=
 =?utf-8?B?RE9FUWtBR0FnSmxoTGJwcTNXdzNadzYyVkRmanJjTStsMHh5L09XRE8vRHQ3?=
 =?utf-8?B?V0xNNTJuS2NKWXRBazRkeU1xZU0wVFJ3NG5HWmh1d0NSRUZ1R01lTkxiZ1pF?=
 =?utf-8?B?bE15SzZzRFR6RVMySEJRa0c4dWJEcHdiTTRJOCtQL2ZLcGdRV0tSc3RhdGVG?=
 =?utf-8?B?ZTIyc2ViNngyMjJ2cjl3WVRaa0VHTDNKd0VoZXQ0dFpyNVlkVVRjbWFrWklU?=
 =?utf-8?B?UCtlNHVRdklDejVmOXF0aU1Db0JuU0dtRzA3cVVvR3pML0JxNUhCWmxBSVlN?=
 =?utf-8?B?SkxvV3JiM2xnbGhzeGJlVWl1R3hxazVNUVR4K0FzeXE2cDdLQVBPTWkySkNz?=
 =?utf-8?B?YmdyWGlsL0h5QnhvVThVdlJnV08rMWtRZmhYVkE2NnhQR3FIdVcyK2lHQWZw?=
 =?utf-8?B?RmxmazROM2t3MWh3V1NRa3BYQmwweEhUYjU1V0I0bGxoaktQVjRSNW1raDR2?=
 =?utf-8?B?UDhpemRoMHFPOGpDM2ZHMm5TUlpZUThxdndUSUdUN0R3YW4rd3lwOFdMU3pr?=
 =?utf-8?B?RFAvaUhLcS9GcDVSb0JHOExsM1o5a2RBV0pWTkhsU1NkQ0hkM0JnSFQ5SG5O?=
 =?utf-8?B?Q0k0TitNQVRHUDNtN1NlemwxTHZsL1VCdGZENTJLU0VQQVozU2dkU1RxUE0r?=
 =?utf-8?B?cGVuc0hPR2hhcHhVLzNEbDF5ekJjK3UzaTJKZ2l4dkhoSHplK05JbXBUZUhQ?=
 =?utf-8?B?WjNscHdBK1E0Z1R1YUhmbVpHSGhmSU5TbmpRVXBDdll6NExmZlR1RjVRVUxt?=
 =?utf-8?B?TkpTem5NSXpwU05pMXhvNFBVT3RzUE9LQWR4K0pOeVN6ZmRnbVNZekhBeG1F?=
 =?utf-8?B?bUZ2Zzl3K09mY3l5aGlpTk5kYVg5UHl3RnFRN2RQZFhiTWNBUkwyQzZoaVhn?=
 =?utf-8?B?OExsRHh6Wjk0eEpTdERnZ3RHbjh4cS9VRDAxcElteWRMYVAvdTZKUXl4Q3ND?=
 =?utf-8?B?dnJCT2VabWd5QzkvRWpPWVBPZlVGeUFCYzMrNTBHSjJvKzRqcjlBUE10Zi9x?=
 =?utf-8?Q?1Na3sVkbCItXp3Vr1EpvxMTIeSBpAI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 14:18:27.9450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa0ed41-9416-409e-f237-08dd5b276ef7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8091
Received-SPF: permerror client-ip=2a01:111:f403:2414::618;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Therfore, decouple the AMDVI-PCI from amd-iommu device and introduce pci-id
parameter to link between the two devices.

For example:
  -device AMDVI-PCI,id=iommupci0,bus=pcie.0,addr=0x05 \
  -device amd-iommu,intremap=on,pt=on,xtsup=on,pci-id=iommupci0 \

For backward-compatibility, internally create the AMDVI-PCI device if not
specified on the CLI.

Co-developed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 hw/i386/acpi-build.c |  8 +++----
 hw/i386/amd_iommu.c  | 52 +++++++++++++++++++++++++++-----------------
 hw/i386/amd_iommu.h  |  3 ++-
 3 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 53b7306b43..e70eeaf577 100644
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
index 975a438631..4c8b2dbdf1 100644
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
@@ -1670,12 +1689,6 @@ static const VMStateDescription vmstate_amdvi_sysbus = {
     .unmigratable = 1
 };
 
-static void amdvi_sysbus_instance_init(Object *klass)
-{
-    AMDVIState *s = AMD_IOMMU_DEVICE(klass);
-
-    object_initialize(&s->pci, sizeof(s->pci), TYPE_AMD_IOMMU_PCI);
-}
 
 static void amdvi_sysbus_class_init(ObjectClass *klass, void *data)
 {
@@ -1698,7 +1711,6 @@ static const TypeInfo amdvi_sysbus = {
     .name = TYPE_AMD_IOMMU_DEVICE,
     .parent = TYPE_X86_IOMMU_DEVICE,
     .instance_size = sizeof(AMDVIState),
-    .instance_init = amdvi_sysbus_instance_init,
     .class_init = amdvi_sysbus_class_init
 };
 
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index e0dac4d9a9..ece71ff0b6 100644
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


