Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85C6C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 04:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEKYE-0004Q9-3f; Mon, 12 May 2025 00:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uEKRt-0003qY-LR
 for qemu-devel@nongnu.org; Mon, 12 May 2025 00:07:29 -0400
Received: from mail-dm6nam11on20613.outbound.protection.outlook.com
 ([2a01:111:f403:2415::613]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uEKRp-00048W-E9
 for qemu-devel@nongnu.org; Mon, 12 May 2025 00:07:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYvvIIDcXxFXqmiZDNz2pu+LyUp98xZTRnxSPo4ZgZIAaRu/1/XXopmHnWAHrllJsxtQiwr0JGzhj6bh6fevoSoIw6JrWcWgwxrLGpIP8bAY36qT3Gfb3x2dUKVXmqPvAgTGVQaH8M4XwinL3rBhaq/XQ+gteJ3eRgOeEI+DOtPWfXnWZwPiDwyxa+3Fbw0matkHfwfLkKTaZdV2MnXo1rfdwdTk2Ro+NtqUPH9xPTwR6v0w2EgTu+z2CfjI+Q6qanPyHwuYwQ6vpiW1xAeEqYOPBJobFCApaORhSX1KzMnERV4bvMATTIlQiX/ZS45B9UU67Fxih7S9tx+cIq8sqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71mpFFfwlPnc1mmT8EfmmI66Fjjm5MjN4vq8AgswJss=;
 b=UqN7NzQiM8oAxyrCOH1ybupTxDQonbZHscC1b5yncOFkDDjRftobYmwwV7k0z6AU9VMKoTcXvf946N5q8VPuHCDu2yAdyN1wiy/YhJ/9r96WY9IsF3LyRE9kmNZg3XArtphS9SlY/TVdSzqKMEfDReY2jdd5OOKJ/bJFxOSZqM/pe8D4daV3mt2Sbxa+gPWuAQlsJ/QzD1JCQDpFJQd5A4/Dgd3FuSPkTXTrWPOcjrkafIkHjiyj8UYxNIxsvHK19GpqmBDAQfLFgNkWIarsiL9KJ5W4CGNUg8pFmzLwwJcEdijF/IJmjE6wkoPiLXS6RXQmXjqbb+BDygYrhCONtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71mpFFfwlPnc1mmT8EfmmI66Fjjm5MjN4vq8AgswJss=;
 b=H4tUna410v/NMB0gc62tqlonDUwa2MyWAyjo/MLbdVaUvpFjInWa6VHDpW839Sgg31EW9IDi2nJ7aXWLX976B28o3UaH3CsCSKp/Krvtk0cVeJ0pzmOIu7ooeqVWffpNU3rr3h4iMw1AlKEwzqDD+OxEH0sOs2jWwcLudMrbi98=
Received: from BN8PR03CA0032.namprd03.prod.outlook.com (2603:10b6:408:94::45)
 by IA1PR12MB6257.namprd12.prod.outlook.com (2603:10b6:208:3e7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Mon, 12 May
 2025 04:07:08 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:408:94:cafe::44) by BN8PR03CA0032.outlook.office365.com
 (2603:10b6:408:94::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.25 via Frontend Transport; Mon,
 12 May 2025 04:07:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 04:07:07 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 11 May
 2025 23:07:04 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>,
 <suravee.suthikulpanit@amd.com>, <alejandro.j.jimenez@oracle.com>,
 <joao.m.martins@oracle.com>, <sarunkod@amd.com>
Subject: [PATCH v2 2/2] hw/i386/amd_iommu: Fix xtsup when vcpus < 255
Date: Mon, 12 May 2025 09:36:51 +0530
Message-ID: <20250512040651.15590-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250512040537.15557-1-sarunkod@amd.com>
References: <20250512040537.15557-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|IA1PR12MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: b3be58a0-d6bc-427b-ff95-08dd910a7678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3B0T1BjVDVsK1ltQVFOZ3VnQlBxb3g4cURWclpRVkNlcHBSQkJ5OU5hbnhL?=
 =?utf-8?B?N1JvYXpZV2UxOFBjLzlkU0JPaXZQZ0Vrayt1bUIxQ0NmNEVOeHBwdEVuNHR0?=
 =?utf-8?B?ZmVEZ2wrWEJGNEhjNDdHTC95UnhKTmIwNGJlekVFb3dYSzRzbStCMEI3NTZ6?=
 =?utf-8?B?SEZ1YzNpRE5Ha0lwWGNXQVdpNjRoNm5oOTIvUXcvQkFQd3dnS25sNjU5OGlk?=
 =?utf-8?B?ZVRQMnhwSlJUbUs2elZBY3RWRFhkNkRVdHk4b05ybVp4TDR6Y1diNmh6MTZE?=
 =?utf-8?B?eldDUUI5aUlMcmQrRTNSbmtEWHpUbVlwdGpKVytoWXRzOVZUOTN2L2FqOEgr?=
 =?utf-8?B?MUhRd1lXYTl3eGM5UUlLaVJhbWFaMjdkWjBJYkl5TDgxL2lWMldWc1p4d3Vp?=
 =?utf-8?B?UTBzWXRLeDJPN25YcTZNamY0c3VLaEl2ZWNkRDNhMUJQV3NqNGVwelVtRWdG?=
 =?utf-8?B?MkV6Wkg2UkJ0dml6ZndYNlk0SkdRNUhFeXdPeXdjcm04bTJWVEtKemI0anVt?=
 =?utf-8?B?d2x0YTFENzJYR3A3bmxKcThrLytWVjBMYzFNanpHcU8yWDZteGpuek1wQVQ3?=
 =?utf-8?B?eFlyWmI4MXpkWVhRWE9mOGJEVFJmVTlwT2JxN3ltV1cvK2ljTzZOTG1aUHgr?=
 =?utf-8?B?eXArQmxsdktwZHBQVFdoK0VrVExzVXBHTjR4NjFUdytHY2ZVTmk0akR3WGhJ?=
 =?utf-8?B?ZVY5M2RrY3JrdHR2VUU5U3FLTC9nemZyaWFqVGRtY01iSUNxaGhPc1FQWXhn?=
 =?utf-8?B?Y09iSG94R2FaWCtpYjM2TGZBeUdDSUZlOWlVNHhvWFZRMmhrYldoZEluczNC?=
 =?utf-8?B?dFJiWmVDd0lWYUs4YWhMS0EwNWRoblpaYXB5M2Z0ck9QT0g4VjBtR3pRQXNx?=
 =?utf-8?B?c2lVZ3NQQis1OGk3cDFRUkVHVEpZSGk5Q2wydzZIS080eDR4ZStVYTRnSFIr?=
 =?utf-8?B?QmptSHkwRVFhbk9aYURxSjdPK2p5YkRIdmdnQUFIRWw2cjgxU3IyVVF0aVJK?=
 =?utf-8?B?NWNRVm55a2puUnN1RlJTbG04M29hZ3lrUUV4ZHcxL3pTWmU5c0E5OWdEWFJ1?=
 =?utf-8?B?cUR4T3I4ZmpURjZScmhEU1JJUW1HM2tqYWNncjViSksyVDlQdkJrcERRVE91?=
 =?utf-8?B?Mlpsd1kzQU0yYUJ5akJWNkZ5bE1nM01QVUZtM0lDUmtGRExhMWo0b1JvVU1I?=
 =?utf-8?B?RldkbUUybGgyZFNpQ0k0a1luUDF5NjdvTTlWRlA0V0d2SUlXUU9JeXBKaFgv?=
 =?utf-8?B?Vk5BdkZqcjZtTmdLM1hwUi9STm1jWENrRW5PUUdvWWtBbjNyNVk1Tng3SVJJ?=
 =?utf-8?B?NCtDMWRPVklwSVJHeXdhc3dUSXRXbDN2OGpiYXJXSU5NZ2ljVThHemlXcVZj?=
 =?utf-8?B?UFFiL2dnYllFL09zOFM2TTBTMk1jbHhqZDNobHJpN2F3Yk1NQ3c1UjN0Q085?=
 =?utf-8?B?ejJvT1FndWEzWmpNeUExMWNYWlJIT2J6eXREWmJ1bk9OVzdnNmVOOTV3ZWVi?=
 =?utf-8?B?OENOckZ0b3NsQXVVZmRWNHE0eHBqQUxMK2FibExaUVJ3NHFjOUZ1MllnZ1Ny?=
 =?utf-8?B?SkE1QndIczZzK3dSTDcvcktkTmJzRXprWnB2SlJRMXZXank1c0loNkZWTkhQ?=
 =?utf-8?B?NXFlZkZOdTA1Vm95UDV6RVVpakVuVDFIM2oreXJ3aTNMT04vUVF4ZlVaeTdM?=
 =?utf-8?B?ZVB3TTlRVEhvWHllKzFBTXV5cldMWUQ3alBxaXBKVnI1UFl6cHNTYU9mdHg4?=
 =?utf-8?B?cHg0SGtQaHdUOW9acUZNb3htSjNWd3BjRVpXU0tCYm50UVM0bVhVcnhJLzhQ?=
 =?utf-8?B?d3JpMlRBYzB6MFRFa0M0TzJoeVkvMjM4enVYRWlNdjZweXNhRnV0UmtYTzlJ?=
 =?utf-8?B?VzNUVnNQdjErakZMVklvRFFhczNNRDlXQU9aNFNDZ1BIMTBqV0wrV0ZwSFF4?=
 =?utf-8?B?SlpjemVnOXh4YXRuYUEveFZpMThsd2czSE1kMzlxTkI4THZmdE9rYjVSZVA0?=
 =?utf-8?B?Z1dIZUNCMHhnUlJ1ZjRPSEtvUUFMOUxsenRiWS8xbUROcnZWRndHd2dhZjdV?=
 =?utf-8?Q?tFWwj0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 04:07:07.9381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3be58a0-d6bc-427b-ff95-08dd910a7678
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6257
Received-SPF: permerror client-ip=2a01:111:f403:2415::613;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
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

From: Vasant Hegde <vasant.hegde@amd.com>

If vCPUs > 255 then x86 common code (x86_cpus_init()) call kvm_enable_x2apic().
But if vCPUs <= 255 then it won't call kvm_enable_x2apic().

Booting guest in x2apic mode, amd-iommu,xtsup=on and <= 255 vCPUs is
broken as it fails to call kvm_enable_x2apic().

Fix this by adding back kvm_enable_x2apic() call when xtsup=on.

Fixes: 8c6619f3e692 ("hw/i386/amd_iommu: Simplify non-KVM checks on XTSup feature")
Reported-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
---
 hw/i386/amd_iommu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index df8ba5d39ada..af85706b8a0d 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1649,6 +1649,14 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
         exit(EXIT_FAILURE);
     }
 
+    if (s->xtsup) {
+        if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
+            error_report("AMD IOMMU xtsup=on requires x2APIC support on "
+                          "the KVM side");
+            exit(EXIT_FAILURE);
+        }
+    }
+
     pci_setup_iommu(bus, &amdvi_iommu_ops, s);
     amdvi_init(s);
 }
-- 
2.34.1


