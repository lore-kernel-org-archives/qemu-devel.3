Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63B3C36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 02:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twtrn-0007Qv-Fm; Mon, 24 Mar 2025 22:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1twtrk-0007Qa-1q
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 22:18:08 -0400
Received: from mail-bn8nam12on2089.outbound.protection.outlook.com
 ([40.107.237.89] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1twtrh-0003WE-BA
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 22:18:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sl8uFtLSy7q9+8AjsW/EVPu2IqHPxvoeMEeowhj+m7VhZK/FAqhKbL3X8qedMAo1KR5z5Es3McRI2QPGCosQLWxQlVFqVQgaLFXlO0urtSvMK/iNERME2OcwrMt76KV2hWH61shs+nwerU+DnFuw4kGj+oc4DzyO6xIkeooNpK7hkX3aUi5HFg5+eWU/PObnMpIBes2Y463gXPEWMdH3KQ7kL73fZz3SmiPZj+9+OZNZSoTqzALsn9sx/xAb7AXKH6TJzetZT9r237zELSp1+B4l9CVaUMUoNa4fB+OvoA5H8K/eCCFd8x5OwX+exsiriAo1xlqN/cCdGZPvaeJ8Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dm3IKU2iI1d7YpOwBTi0o92/1oVKgh+dmX6N9nZhMYE=;
 b=DEVWStUTis8qcsp+Kiw2nVeTrgHcnFP2UIOHnzR8TwsvRNtwMwZn1+WSCewfyHRFQUBzKTtfBKc23Ud6oU9unwruG+XM8ImlnGt7yNwDMnxNqoEyijPmqCDAaEq82ON8HLvFo1RCkfZaTWb05xvrRlXptdtmz75gJBuDXLYfFe19kXI/W/C9FH4h3JsMsm8zJLWzpqFhSDD/WVg/S3rmIhaIQ9sfbjwML1vOURMFjy2sT9sacEj/BK5qgSYz70xr3s4O79ozGn/92eIn6H9vw6f3nj6vf2/KewdNCJa44czsbuM/4ToCuamGJSWz/CVK10ZGSBtA2Sg3G3cGIWSVTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dm3IKU2iI1d7YpOwBTi0o92/1oVKgh+dmX6N9nZhMYE=;
 b=aZh1OFuVaNKysSOvWiseqDCX87BDPNiGRnWOO8vpIdOECCL9c9N/e/PAwLU61yEedNxeI9wlEG2lsOnmJUIZHA32bKd7wHmKxwQvobpleFhrYtH35dCYW60Mh7vZ8mb13h4laD5XdpZtxmhf0veTMa5V+o+Wv2zG5cjy22uhPJM=
Received: from CH2PR03CA0025.namprd03.prod.outlook.com (2603:10b6:610:59::35)
 by PH8PR12MB6819.namprd12.prod.outlook.com (2603:10b6:510:1ca::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 25 Mar
 2025 02:12:54 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::e0) by CH2PR03CA0025.outlook.office365.com
 (2603:10b6:610:59::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 02:12:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 02:12:53 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 21:12:47 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
 <vasant.hegde@amd.com>, <Wei.Huang2@amd.com>, <kraxel@redhat.com>,
 <bsd@redhat.com>, <berrange@redhat.com>, <ddutile@redhat.com>,
 <yvugenfi@redhat.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2] hw/i386/amd_iommu: Assign pci-id 0x1419 for the AMD IOMMU
 device
Date: Tue, 25 Mar 2025 02:11:40 +0000
Message-ID: <20250325021140.5676-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|PH8PR12MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c30ab13-9579-43bc-1811-08dd6b428d5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sKa/zRENc9sJbpdTjio/fabsEY96qTzVJcN/i8ZcyywdxRMDh1cz637Esc72?=
 =?us-ascii?Q?H50ibn16EaoGLYCkjVlu/xQ0veezhRlMTDSTSrRDX15tjzastGuq6giLx7x9?=
 =?us-ascii?Q?jfbEivDvf7CPiTqzH90C6RAm3jsGvzvr22J3N4iyw+OWX1x+C04A8dUpMPqO?=
 =?us-ascii?Q?bT6lE6rGWFFPCixA3qlW0+EPmv7vwNlF01ZBdY9SSsNjvn1cGZRsafUSGI8F?=
 =?us-ascii?Q?8zYVyL8e7A6e0qnEj7Iht1VPURo21c0ocM5CVo6qUDipN4qVCKckQD1EhT1i?=
 =?us-ascii?Q?tF3vRqZoN6P/N+A7FGtSEw3KE99BUMqgswmu5cE5tC9K1EH5mPHkR48qdhLX?=
 =?us-ascii?Q?83/3EMRyisUs/Xi3GZlQ++RGo+viwrc3d2Ptd2bia4N2yP/1Xt3tbRxchu+N?=
 =?us-ascii?Q?9DjIqsSIaP9qTKyS8dO0x8zA7ZLg60F64vskOE3pX3RFuJLLr8sgrU2CHL/U?=
 =?us-ascii?Q?bJQA5c/KwDDI+TjEHw/z1CuJF6z85Gw4iedp7FAY4X8EZBuUFbQHhrqsj5OY?=
 =?us-ascii?Q?PLth3WpfVsH5C56HVHYlALF5IxrhVE/R9Skwj2EqZNNaMhLb5lJSM9cFYeDN?=
 =?us-ascii?Q?PLjxsPubkM87tnXkaAacwvOjwbjw45VQ5ryiwF+lq0shHjqfxnQlIDk3EZLl?=
 =?us-ascii?Q?mLRXCnQBvBssikOJWGwx0tcjVOS7yme7l5J6obBranJwtOfNXf6tj63zNxeH?=
 =?us-ascii?Q?nRjgavnlDzTlmrl5tKIZYGTFCUxqbGm6y8vBEH/Yz2qo5s282gOW5f4tAlHK?=
 =?us-ascii?Q?2N9hAaZHtaEdjJMkmrIyO0UTVvISHJ0J3J4IcYu0EduvOKzMFXKfZWyPpmOU?=
 =?us-ascii?Q?hgNI91fgXXkSVLi3YNoWfxhkVz4C5NAIKKwk9QfPHBbkL7THeNR59kV2De16?=
 =?us-ascii?Q?EZ2ec+1H//THcdEWGRSOJyaFLmMpsXWOt4FXqCfP5QdteiH6BYXJMxe/BcEi?=
 =?us-ascii?Q?JaqmhWWRwB+LZU7XOLtanz+0sqk2h9ka2gAj/tYkoB/gaHxkBIm576u11J/o?=
 =?us-ascii?Q?F9ykB2GVKBvKlP0R7Ym1iyZYrdbkZLOmC89QX0K/Cz5R001n+NEcPzhYa3Gz?=
 =?us-ascii?Q?aUXWQzidXFLvaK3BPyISmuRxzEm+Q6+y3HzqrOAD5zxMJeqSbUkzRCZv2CBc?=
 =?us-ascii?Q?KsqYalw447PrxmamlPO3aZ/K8B+7UVCJOwxlehd5nr8Boh8KGwaonbY2tOjj?=
 =?us-ascii?Q?YfMjsHdP7GOtAJMUPLU5fAseS6+KKZohZszjDvKvxZo8MMMaFAuzkor9BXR0?=
 =?us-ascii?Q?HDHUN8LiOooU44njlvaq8DgmkZ2qCFPeadV/E+cx6JtqZgEjBX4IybJc+nMz?=
 =?us-ascii?Q?mpvI2d7h7GLNicHvZQx1/aWW6mFJvjtHqw7CtWeLU6JmFwinBkD8JiMcwtdL?=
 =?us-ascii?Q?eoTE5qBNvJQp7x/o30B02N2pFN/DWkLnrs9LDiK9uH/VUHVv287CX5FqyeEP?=
 =?us-ascii?Q?xtfnLNLNhFqks/gE0mh9ET5OTqBmcUO1rL4XogSiMH0n4FCMbsigEFpKsm++?=
 =?us-ascii?Q?OLQe55SkF2BJcJk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 02:12:53.9489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c30ab13-9579-43bc-1811-08dd6b428d5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6819
Received-SPF: permerror client-ip=40.107.237.89;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

Currently, the QEMU-emulated AMD IOMMU device use PCI vendor id 0x1022
(AMD) with device id zero (undefined). Eventhough this does not cause any
functional issue for AMD IOMMU driver since it normally uses information
in the ACPI IVRS table to probe and initialize the device per
recommendation in the AMD IOMMU specification, the device id zero causes
the Windows Device Manager utility to show the device as an unknown device.

Since Windows only recognizes AMD IOMMU device with device id 0x1419 as
listed in the machine.inf file, modify the QEMU AMD IOMMU model to use
the id 0x1419 to avoid the issue. This advertise the IOMMU as the AMD
IOMMU device for Family 15h (Models 10h-1fh).

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
Changes from v1 (https://lore.kernel.org/all/20250304183747.639382-1-suravee.suthikulpanit@amd.com/)
* Use the existing device id 0x1419 instead of the proposed new id.

 hw/i386/amd_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index dda1a5781f..b006ead804 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1767,6 +1767,7 @@ static void amdvi_pci_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->vendor_id = PCI_VENDOR_ID_AMD;
+    k->device_id = 0x1419;
     k->class_id = 0x0806;
     k->realize = amdvi_pci_realize;
 
-- 
2.34.1


