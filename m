Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A15C282D9
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 18:39:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpXAL-0002ii-TU; Tue, 04 Mar 2025 13:38:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1tpX9w-0002as-Su
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 13:38:30 -0500
Received: from mail-dm6nam04on20617.outbound.protection.outlook.com
 ([2a01:111:f403:2409::617]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1tpX9n-0000Q5-HJ
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 13:38:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYddqTQd3oTmLkpNPnhi/z5aDJIFRTELJSAhT/ybKoO04yNDy64C7OOXp186aWf//A47UAf3Q9J3dVdw2PWbsf519COA99Ii9Dq4vsJFCkqMc+IZF4q1Ykx3yUlLpY8ZiDGUGNw6Y5qwlv4soqSJCT3Rmgqe/ABMKD5aSRgJid3e+ttwE/DDl3v4RcHSRAUth2cm23nP5JoeXsHBYFjl9QN8MTllHU/nDvSwCEu1AmEswSULMw0v50Lq7V4WJRTQd7ao6iY9Yf+Rsec0KNNikUR9YyM7Pk0At18SfCVmcnJuGu8oeiPs0m4QMcz242ql4cyt8QulcIxJVW7muS3hlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8FPjlOvctqWp2thzZOfbJuMReZNdoWR7m43bCEADIM=;
 b=fyIqzMnlF+m7j5IGnV2VDjZ5BRR2WcpNFdx0m2HUKX3vaHCXVjKxhj5zQxRHnZumueqc33Nst5Uuh8Y+v2EOoMQKN/KheRo68eSjVr2E/3ZIW4tik7ADTzz2XvCY/KMVHqCHP2UXIo4RRzKwIkkN0rc0vo5MoSTvOR4NOhjQbIzNxbYbyYIHY4LzzRoSKDODalFfE9tsUI53E1VRjDBJ801BCCTRUGShi/fWTeH/o7vdDAx07x3yoBkSLac5r21Dk6dr9KwqeWKwvqmTi6EiwXJPob4g7ZsIdOzwnNXZUrnHf4mLHCrFHqjZfClx5esmWXA/verFx/8oklY5Kd96Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8FPjlOvctqWp2thzZOfbJuMReZNdoWR7m43bCEADIM=;
 b=xoKjyCNPi6vwEypm2PdfDc4EndlMsCkaMv7Tinx7U8m6AvcxlRbA9ix4o5WS28ugjZoAhA4MgY7uBxuNghdL2cNNBLwrNDD1ZSdnTHRpcNp39gLqiK6n2tuM/TyvTlR0Gh39e4OABtgawCOq9tgiK3S6bzFv5p39Arowt1aMpoE=
Received: from BL1PR13CA0025.namprd13.prod.outlook.com (2603:10b6:208:256::30)
 by CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Tue, 4 Mar
 2025 18:38:06 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:256:cafe::3) by BL1PR13CA0025.outlook.office365.com
 (2603:10b6:208:256::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15 via Frontend Transport; Tue,
 4 Mar 2025 18:38:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.4 via Frontend Transport; Tue, 4 Mar 2025 18:38:06 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 12:38:00 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
 <vasant.hegde@amd.com>, <Wei.Huang2@amd.com>, <kraxel@redhat.com>,
 <bsd@redhat.com>, <berrange@redhat.com>, <ddutile@redhat.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>
Subject: [PATCH] pci-ids.rst: Add Red Hat pci-id for AMD IOMMU device
Date: Tue, 4 Mar 2025 18:37:47 +0000
Message-ID: <20250304183747.639382-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|CY5PR12MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: ba2eb8c4-0d57-470b-9b36-08dd5b4bb471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?snhuEbSPrKJBzswiwsYSNZLfl6/nHpBl+HeAN9KwxYx2AlY7vgpfJpOC/sX2?=
 =?us-ascii?Q?YpQsKwIN75AhtQZdemTqoLmLfqoc4c8uidA4M0Un4pqx1uYi4/alWlal0XmZ?=
 =?us-ascii?Q?Xvmye2dER7AclGmuNA+t+YTaOaeZeET846Sc/gMPvbM6rqS0TESpkJhwPKmi?=
 =?us-ascii?Q?5uaUHQ8LLNrW3Q00iTJdtZRKEpgfUX+Ly73mcFnYDzawIXdeguyYBkfbCUzT?=
 =?us-ascii?Q?8MpxGsLwu/U55pumXwqFRXZI1mTiHE+UPvQZs5fYBK5pl5d133Mu+h2sDW2h?=
 =?us-ascii?Q?ZUh2Boic/WtcD/JJXouLT98r4IoE6K9tN/x+CQe4IRBRopNTgZjNSicHhsMq?=
 =?us-ascii?Q?FJ1lNUh6MJ090orYt4skWQ23df16RFkTpObics4Hdjs1YK+ykvueMGWofY5b?=
 =?us-ascii?Q?v9ARNQZ6y6QIcMhNVgySsNkt5GOU/VlNRsIqf/byV4UOX6CPWzwRwfCiAnOB?=
 =?us-ascii?Q?Ec69VAfjs5G8PuZzuTxHPt3qRZeoaXbKh1PMJnqsPalg2psVeYu7qljBQssc?=
 =?us-ascii?Q?6/Sr9Wl21QyxyDh2P0a5F4b+kym6HAUQS+ja79pdzyi9q2m2MJApAaWFclK0?=
 =?us-ascii?Q?zdYKOVWnNA75QpnKyIC6MyPnqLclyENDFbPKXOMLgwYTaEAnbjqMjoQy09xz?=
 =?us-ascii?Q?IN0uIWpGW783wDCqh7wevDIsPcnMsBzYCjpg9nIgeJWAHXuUk8NKE8sVdQA3?=
 =?us-ascii?Q?74yg4PGWqp+N0ZIK8cD1P5Al8Y9bUz3ckQEzqYsbzsunapHdCTxWX4m71zp6?=
 =?us-ascii?Q?ri3Td/uYNynZrYG0mL/1ElG2ufhlkcR+TgJ2X64nSmKs7t9WPLAoAfYWg3L9?=
 =?us-ascii?Q?0MYczupQx+zX0xCwQwIV7HrRR1IDCdrIFXug2guqlzC6spKLbPERkXq3RSYR?=
 =?us-ascii?Q?/k0UPRGmr2ggkBdsgYkTA5iMLekyHTz2sKMXOj9CB5yIoIoqNud5w4Slz/AP?=
 =?us-ascii?Q?ekqXsyRzJUFOni1y1Pn8APECni30vXabnhhS9nz3+CMmPBOW2Vn/oxlENbly?=
 =?us-ascii?Q?cPejVz+fmZOPm/tnBhMQXpm4W1Y9v9kTS7VKp9wP39wPmx5/AA+VTpB3aXD0?=
 =?us-ascii?Q?1ac2bvCAxs6VZ9IMvb1HGs7riwXlaqy8GoI3uJNu/2/0Sh+IwYpxhqwFhLgF?=
 =?us-ascii?Q?QFiGCgO44DQzoC5ZN3sF9GxHYNwO0SITLaPuMkFh7T9KSuCdDSb3S0u87rTL?=
 =?us-ascii?Q?qVe3PGnMOcbrFnANEfO+kHRhpNDbLW3OGfvVgXnYikmSuwIGldI2roGidxFj?=
 =?us-ascii?Q?QaRmvgbq9kd6VOCBOZ8S1+xg1YEvUN/mU1GIm0ML7td/i54Pgk3wDn5xtQGc?=
 =?us-ascii?Q?1XfW4Uuv11SBdKcxiRzsQjb1q80Mphc1sQMjfnQl3FiWZU6l88dQra1Im6k7?=
 =?us-ascii?Q?dtc4ZUca/fKPZyK5ehQo4+DtNGCRUtQmFHrNLtMZyPphTEFDDJGapIWvoFEc?=
 =?us-ascii?Q?4v3Y1jHb4z/GXHU2lmcfK2+VAVD3UVO2kOkx6MLRqe+4Dx9/YEkcSK47q4HW?=
 =?us-ascii?Q?jDIhf+41vuXa+A8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 18:38:06.4028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2eb8c4-0d57-470b-9b36-08dd5b4bb471
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6369
Received-SPF: permerror client-ip=2a01:111:f403:2409::617;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The QEMU-emulated AMD IOMMU PCI device is implemented based on the AMD I/O
Virtualization Technology (IOMMU) Specification [1]. The PCI id for this
device is platform-specific.

Currently, the QEMU-emulated AMD IOMMU device is using AMD vendor id and
undefined device id.

Therefore, change the vendor id to Red Hat and request a new QEMU-specific
device id.

[1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf

Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 docs/specs/pci-ids.rst | 2 ++
 hw/i386/amd_iommu.c    | 3 ++-
 include/hw/pci/pci.h   | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
index 261b0f359f..2416a70a2d 100644
--- a/docs/specs/pci-ids.rst
+++ b/docs/specs/pci-ids.rst
@@ -100,6 +100,8 @@ PCI devices (other than virtio):
   PCI UFS device (``-device ufs``)
 1b36:0014
   PCI RISC-V IOMMU device
+1b36:0015
+  PCI AMD IOMMU device (``-device amd-iommu``)
 
 All these devices are documented in :doc:`index`.
 
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index dda1a5781f..4d8564249c 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1766,7 +1766,8 @@ static void amdvi_pci_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    k->vendor_id = PCI_VENDOR_ID_AMD;
+    k->vendor_id = PCI_VENDOR_ID_REDHAT;
+    k->device_id = PCI_DEVICE_ID_REDHAT_AMD_IOMMU;
     k->class_id = 0x0806;
     k->realize = amdvi_pci_realize;
 
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 4002bbeebd..da44e6673d 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -117,6 +117,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_REDHAT_ACPI_ERST   0x0012
 #define PCI_DEVICE_ID_REDHAT_UFS         0x0013
 #define PCI_DEVICE_ID_REDHAT_RISCV_IOMMU 0x0014
+#define PCI_DEVICE_ID_REDHAT_AMD_IOMMU   0x0015
 #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
 
 #define FMT_PCIBUS                      PRIx64
-- 
2.34.1


