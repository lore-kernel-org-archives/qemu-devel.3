Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8C0C88E7F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 19:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6vFM-0004c3-83; Wed, 16 Sep 2026 15:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1x6vFB-0004ab-SS
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 15:24:34 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1x6vF9-0005fg-0c
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 15:24:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzcsoItVRaZ+Ab4y1yU+Y1UK2MgIe3hK5hfE2fc5mcz2nzNOEbXrxKw8fqHg1KrpfnO83zTjG2AmIM2bsm3Xh0jTNenPYmp0nUv+6z0osCu50DQNktpevkQVuXxycV53OAXxKmbloroWwow8dm9OeKSLmWrAf/5DbMqkGBoVCnkigsjYS0Kw1TSChnJ2HA7n0b6/KZTIBB4t45DstIV2bXJn89RFIggqpRa7fUGOXOZ9YNLZMbXShCa2FtUBUFRvvJcCeEIqy+f2JjNAy3tWUPuDrfV/ka5URKaQd/sfKvANNWmGFubKm1eo/PFuvDBWyJvhpnOyAg3voWqcJTzbCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2Rd6cqOvqEE6s/u4L00l3iYfYSInsCL3RVv2aoVQNA=;
 b=H2KU8vX4+BMUg6Y7H8qKCaPt1I6SmZyFP/yGElY6tgboCzfOesK37bloK9ZlxyIU9wlL+j7lqzhU/1rKbWCI5QsJVFsneKW6mEzHB4HGqeFbjnrl5Yip67fr0Q9QqBDvQKqntENHqtaH4bRPl3hTUq8yHJZbPJtVIZSrbakptZL40kZYVbqN+Niu/QhlRwpItf6N4Q0oKr2XWgfXKCxe5eXmjA5MvBP7vILwC9RnM/6BSWLmJzHZ1BBvNQYjC3vqn9ZBNhwYREQ38Q6N68y03gn4egRlNwQSJObvjqrQwWe1EfPfI6Yjf9sRqUlg8Xx0yjH217eHe2Yr21NNRBFLiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2Rd6cqOvqEE6s/u4L00l3iYfYSInsCL3RVv2aoVQNA=;
 b=URl+5j+8SNEU0V6Wz/cadCzR/aE7BJ7l5AFLQAYySk3p1Ee0mOFCVLUtkwOzOE7yD208czDzMpUxOS/F6fl2u9cpHu+HpZCxKsVPqRje9RbP+ZxuYlewKnsKs8GRzW0EKOL2oWk2yECRBaEJK8onuLXi4/rAtwae21Voeeo6SXr3xAZHMPiCLEzG8ORJZvqnAxPTfc/xqz5yms0fLo5mTMESlQTTEAdR884D3k9/GDFgE+641pcSh8x50zC5ZevdqWfJ3Axpbi7Z8TYChx4RG2s9OLqHkoiubH/NPY47lRgEEj40CL8NyWhvMiXneEnJiiGyBuPzoqVko0okkP/HDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by MW4PR12MB7213.namprd12.prod.outlook.com
 (2603:10b6:303:22a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 19:24:19 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 19:24:18 +0000
To: devel@edk2.groups.io
Cc: gaoliming@byosoft.com.cn, ardb+tianocore@kernel.org, sami.mujawar@arm.com,
 jiewen.yao@intel.com, kraxel@redhat.com, qemu-devel@nongnu.org,
 alwilliamson@nvidia.com, jgg@nvidia.com, skolothumtho@nvidia.com
Subject: [PATCH 2/3] ArmVirtPkg,
 OvmfPkg: fold fixed BAR placement into IncompatiblePci
Date: Wed, 16 Sep 2026 14:24:07 -0500
Message-Id: <20260916192408.928411-3-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916192408.928411-1-tdave@nvidia.com>
References: <20260916192408.928411-1-tdave@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::26) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|MW4PR12MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: 168aeb78-d05b-4c6a-348c-08df14281a2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|6133799003|22082099003|18002099003|3023799007|10067099003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: ErsV8RGEkXg40dbpoN7Z+j5LVd7aOvjRz6jkvy5+aBdcpCUu1xNm4ERJw0vbsHZfmqOS0wHbNEV2nv4QfsS5XG/yM089ImX7b9ICiOcL6pggWXx70oxgxDfTL/AoQTiknjwqEl9d7JnwrlJXhYRPhOTY1dpEBi/nCosfgTZ9Hh03TcylSaDaFbJ9KPH2eVAOIvjdq4HSFDPD/bG5wOTwRIJ+xKFpMhXweaaPl5lp2U7YCDtXe13L34PIUA16miok9Rk5XNSbiGpz/o9I5G2Vd2l2ufCGIfkYUWQMsx9/fkes0juG3wX9H3t5hxDM+YzwmcAgC5wDC78KwdEqnl5M5AAMahK3bwytpyX+LI1r/ySI4FNihugNPxgT8rxhcDouGqC/kM31R5FZGvyZafGoKuLgpvA/odUy5NjzGh0Q94u38z7OIqatT5SSB5rOGDNlZqLUkd+rChLsQssNC6H4Ge54a75ICLb+aNKeIrDMuXj09R5Nj3vqrE83K2gyz5ZJLIidlDKc69bjzrGdKUr4M652gXt2NkVQ8uf2/WGcd6xnU/yTEUVbYO9XgFDmxyV/9yHrDaHVU3Ao9l9BKGwX44oxW+5GU7r9g1bbMOP62urLguCkhE926c1ocF1+M7vzqTXlTGVPN9CoB/ir08GTtsiJu8B+jkwAd0phKbdVtZs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(22082099003)(18002099003)(3023799007)(10067099003)(11063799006)(56012099006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzVUOWYxRDRhL0VsOExRSEU5UVhnaHhTRlNaUTdFSkZHRDdmTE5rWFArZ3pp?=
 =?utf-8?B?NU1RM1ZSKzhPbHoxdGRsRWIrNjFhN3JXUlBrc2hwek5hQ1h4am5DR1JCWVZw?=
 =?utf-8?B?RGR0YnRjWmRaY0E4MzRjNGsxaVNya3dybUtCdHBIZ0ZlZlNVdFUzalBjSWNr?=
 =?utf-8?B?RkhINTRVSWZ5VGJSSTdyT0Z4Y0lrRHJzUVBoMzVyMG5ScHBuR0NJK0piNlBU?=
 =?utf-8?B?TjUrZGw5TVQ0TnczYzZsVGNTbkxVdWlWbFZrK21yN1JoTU5xaStvMGE0S1BC?=
 =?utf-8?B?UXV5aVk4ZVhNeXpMYnNFRENEcmFYM2N5UkllYmxQRThpeU55WUhVa2xJNzhs?=
 =?utf-8?B?SUJUa0lCVVlHSGRjbWs1UWJQVUFETUloSUYwRllLbE9zbUd0NDNjMUUxRjRG?=
 =?utf-8?B?MHZydVZLdGZtQ2YzbENRcWI2S0ZJUEV5R1lmVWhPYnZBWlM5YjFVTGR6cHZV?=
 =?utf-8?B?UW1ZZXlaTXVSTFRUV1JrRmkxMXp2NWd3d0NaR1dBdnkvWVFndHBlc09SZ0cy?=
 =?utf-8?B?WnAwMDNhTTBCaTArWUszbkVaZ3ppSVlma3RxMGFEeWV6eXVkZWc5cUt4ZzUv?=
 =?utf-8?B?aEo2MFZGSSs2N3Q1clRtM1RQendYK2dRVWU4cytod3FlTnNZcTYwTk05QlZI?=
 =?utf-8?B?V1RnM1RWcGhScFBqeVRWR0VpUllzRmVGNjJWUzBjVzdwYkFvOUFoSjUxWDJN?=
 =?utf-8?B?Q3BWQXR3cDhsbGtBMlNNY3k4dVpxZFUvWWs4R0RneFBhd01LdVk4Q1RST2s4?=
 =?utf-8?B?bFhjaTQ2U1hFcSt3TjdPd2M0NlFINXI4V0J4dlAzVlpNNk56ak9FMTBaR0tV?=
 =?utf-8?B?bEZqMFRjWEx3Nm54MlBkTWRZY3I0QXBVMmxSWklXZFhudktEYkNpU1p2cGhL?=
 =?utf-8?B?cUQ4b1BoV3p6dnIvTGpveW5iK0J1YkwvTE5tYS9uZHRJS1VmMW8xaG9HQ3or?=
 =?utf-8?B?TldWZ0F3S3NZYzJSQ1NTanZINFk2ODdXZEZXY2p2RjhERkY2YTF2ZEcvV2RZ?=
 =?utf-8?B?MWoyN1Q3bmxsMjdHSEZxWjZNTjFBZU1FdDZlek5icFZzY3A4VUhOYjZpM0dF?=
 =?utf-8?B?ZUJFUHBucE9FbUcwUytrbHVOSnZZZG1sak85a21GOTNjTEZ2M2drc2NJdnJS?=
 =?utf-8?B?em9iNXZBbFBYNWpxcFU1cnFTTmRqUlFPVzBPbGRRREtIcUp6dU16bjB1VElq?=
 =?utf-8?B?VWRjNktRNVY2aGRLY3A4MmlwSDU4Q1A5cElIdDdHd1p5Qko2TUpTZVB1Zm8y?=
 =?utf-8?B?b3NoSkhyUTFoQ1FETGFLWGRjS0xRTEVFeUtLb1JNMDh3SFpPNFVsYlFGV3pJ?=
 =?utf-8?B?RlZrcXE0WHVwMWcwOEFaREpBU2VSc1gvcWVaTGdpLzFpS2QxbmdvWXphcDUy?=
 =?utf-8?B?UENrVGppaVRWb1NQRGkrR0MwY2pvQ3h5NmE4U2JDWXhWZkFmMG9JSnBqSC8y?=
 =?utf-8?B?bUtWZHJ0WEJpY3pNQjdza2dhRWpVS1lrMUpPL2szR2tKNEU4MktjdFloYVZ5?=
 =?utf-8?B?a2V6eEtGYytkOEpkeXQ0OFZGdmx6NlU5djFLelBTbncrd1Jka0ppM0pSRi8z?=
 =?utf-8?B?Y09PNkFMVGNKZWIvNDIrdVJjVDByVTZBTjB3ckdqclhGcHNZTHc3OHRrUnJu?=
 =?utf-8?B?UXhRL2tWNy9LNDl1MWdlRmptaUoyVXdwN1VGZHRWN2F2ejMvbFZEbUhtTTFa?=
 =?utf-8?B?clJKWHFHTnNMSERBTTFmYXVNUnZEcjM0Ni9DQm5NbHpxcnhWdGZ1WnI2TWJ2?=
 =?utf-8?B?ZnEvOGp5OG9PRlV0Q05sc1ppSVhOQlhSZ3dETGI0Y1ZSamxZNFpvMmVqMzhP?=
 =?utf-8?B?MVppajJRaDFNekI4ODRhZzBraWFPT1gzZ1dpUk5iTjRFVHdPaVR4YnV2YmlI?=
 =?utf-8?B?TXlmM08wZkgrMFZSSFZXUDZaT28yMm1iVlhja1BhSkpPeXZkS1NINHBYOWtt?=
 =?utf-8?B?ZkozMHpuR3FGR1QzQnFkZHoxbVVSZFpmbHQrQUVBLzZ3RnMramQ4bTRkL1Js?=
 =?utf-8?B?bHJaNG5EVWFTMnFROTBIcXRPdmlZc2tBWWNuRXFOejZDbVdPdXdzTytTbHZM?=
 =?utf-8?B?cFN2elEzUW1rV0RheDlJMk9ySSszejlnVUpmbGxZc1JrZGFPeXlJRHplZzN2?=
 =?utf-8?B?NUhwejlzQk1RTEtoUmtQd2FzcFlaYk5RdXFHa1JQQnBNNnd5MUx5WGZWOVQ2?=
 =?utf-8?B?OERBL0FqZjZoc3JmR3JPMFJLRDVmcEdkT0ZvTDdlVTN0dDJXM2V3WTYrQWhC?=
 =?utf-8?B?bFIwZ3p1bXJYRHJlV1JtQXUydHJsLzQwQ2lyV0xRbUdIS3NHMzI1ZUJjVnJG?=
 =?utf-8?Q?WoB0WZFqG1ktNqbxxg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168aeb78-d05b-4c6a-348c-08df14281a2c
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 19:24:18.1505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1r32EDFr0qOOpX0oNaKXGyc3Xc4GZZz8WnpA6HMP7ZhYzNfKrFIl46flz6I9V3HRlKv4mO+UOFBfG9eOF38AdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7213
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=tdave@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Reply-to:  Tushar Dave <tdave@nvidia.com>
From:  Tushar Dave via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Extend the existing IncompatiblePciDeviceSupportDxe driver to support
explicit PCI BAR placement. CheckDevice() checks for a fixed-bars entry
first, then falls back to the existing 64-bit-MMIO-preference descriptor.

Add FixedBars.c/.h to encapsulate fixed-BAR handling. Parse QEMU's
etc/fixed-bars fw_cfg blob, reserve the specified PCI BAR address
ranges in the GCD memory space map before PCI enumeration, provide fixed
BAR descriptors to PciBusDxe during device discovery.

Also, IncompatiblePciDeviceSupportDxe's CcProbe() call has no CcProbeLib
resolution on ArmVirtQemu, which causes the build to fail. This patch
adds a CcProbeLib resolution for ArmVirtQemu.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 ArmVirtPkg/ArmVirtQemu.dsc                    |   2 +
 ArmVirtPkg/ArmVirtQemuFvMain.fdf.inc          |   1 +
 .../FixedBars.c                               | 413 ++++++++++++++++++
 .../FixedBars.h                               |  63 +++
 .../IncompatiblePciDeviceSupport.c            | 114 +++--
 .../IncompatiblePciDeviceSupport.inf          |   8 +-
 6 files changed, 570 insertions(+), 31 deletions(-)
 create mode 100644 OvmfPkg/IncompatiblePciDeviceSupportDxe/FixedBars.c
 create mode 100644 OvmfPkg/IncompatiblePciDeviceSupportDxe/FixedBars.h

diff --git a/ArmVirtPkg/ArmVirtQemu.dsc b/ArmVirtPkg/ArmVirtQemu.dsc
index a3f8a2d0ac..d331a3a9bd 100644
--- a/ArmVirtPkg/ArmVirtQemu.dsc
+++ b/ArmVirtPkg/ArmVirtQemu.dsc
@@ -67,6 +67,7 @@
 !include ArmVirtPkg/ArmVirt.dsc.inc=0D
 =0D
 [LibraryClasses.common]=0D
+  CcProbeLib|MdePkg/Library/CcProbeLibNull/CcProbeLibNull.inf=0D
   ArmTransferListLib|ArmPkg/Library/ArmTransferListLib/ArmTransferListLib.=
inf=0D
 =0D
   QemuFwCfgLib|OvmfPkg/Library/QemuFwCfgLib/QemuFwCfgMmioDxeLib.inf=0D
@@ -392,6 +393,7 @@
   #=0D
   # PCI support=0D
   #=0D
+  OvmfPkg/IncompatiblePciDeviceSupportDxe/IncompatiblePciDeviceSupport.inf=
=0D
   MdeModulePkg/Bus/Pci/PciHostBridgeDxe/PciHostBridgeDxe.inf=0D
 =0D
   #=0D
diff --git a/ArmVirtPkg/ArmVirtQemuFvMain.fdf.inc b/ArmVirtPkg/ArmVirtQemuF=
vMain.fdf.inc
index 3fb6a1da9d..3f0b00b2e7 100644
--- a/ArmVirtPkg/ArmVirtQemuFvMain.fdf.inc
+++ b/ArmVirtPkg/ArmVirtQemuFvMain.fdf.inc
@@ -159,6 +159,7 @@ READ_LOCK_STATUS   =3D TRUE
   # PCI support=0D
   #=0D
   INF UefiCpuPkg/CpuMmio2Dxe/CpuMmio2Dxe.inf=0D
+  INF OvmfPkg/IncompatiblePciDeviceSupportDxe/IncompatiblePciDeviceSupport=
.inf=0D
   INF MdeModulePkg/Bus/Pci/PciHostBridgeDxe/PciHostBridgeDxe.inf=0D
   INF MdeModulePkg/Bus/Pci/PciBusDxe/PciBusDxe.inf=0D
   INF OvmfPkg/PciHotPlugInitDxe/PciHotPlugInit.inf=0D
diff --git a/OvmfPkg/IncompatiblePciDeviceSupportDxe/FixedBars.c b/OvmfPkg/=
IncompatiblePciDeviceSupportDxe/FixedBars.c
new file mode 100644
index 0000000000..f307fb285c
--- /dev/null
+++ b/OvmfPkg/IncompatiblePciDeviceSupportDxe/FixedBars.c
@@ -0,0 +1,413 @@
+/** @file=0D
+  Fixed PCI BAR placement using metadata provided by QEMU through the=0D
+  "etc/fixed-bars" fw_cfg blob.=0D
+=0D
+  Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved=
.<BR>=0D
+=0D
+  SPDX-License-Identifier: BSD-2-Clause-Patent=0D
+**/=0D
+=0D
+#include <PiDxe.h>=0D
+#include <IndustryStandard/Acpi.h>=0D
+#include <Library/BaseMemoryLib.h>=0D
+#include <Library/DebugLib.h>=0D
+#include <Library/DxeServicesTableLib.h>=0D
+#include <Library/MemoryAllocationLib.h>=0D
+#include <Library/QemuFwCfgLib.h>=0D
+#include <Library/UefiBootServicesTableLib.h>=0D
+=0D
+#include "FixedBars.h"=0D
+=0D
+/* byte-for-byte identical to QEMU's structs in hw/pci/pci-fixed-bar.h */=
=0D
+#pragma pack (1)=0D
+=0D
+typedef struct {=0D
+  UINT32    Version;=0D
+  UINT32    NumDevices;=0D
+} QEMU_FIXED_BARS_HDR;                       /* 8 bytes */=0D
+=0D
+typedef struct {=0D
+  UINT16    VendorId;=0D
+  UINT16    DeviceId;=0D
+  UINT8     DevFlags;=0D
+  UINT8     RpBus;=0D
+  UINT8     NumBars;=0D
+  UINT8     Reserved;=0D
+  CHAR8     FwPath[128];                     /* qdev_get_fw_dev_path(), un=
used here */=0D
+} QEMU_FIXED_BARS_DEVICE;                    /* 136 bytes */=0D
+=0D
+typedef struct {=0D
+  UINT8     Bar;=0D
+  UINT8     Reserved[3];=0D
+  UINT32    Flags;=0D
+  UINT64    Address;=0D
+  UINT64    Size;=0D
+} QEMU_FIXED_BARS_BAR;                       /* 24 bytes */=0D
+=0D
+#pragma pack ()=0D
+=0D
+#define QEMU_FIXED_BARS_VERSION      1=0D
+#define QEMU_FIXED_BAR_F_MEM64       BIT0=0D
+#define QEMU_FIXED_BAR_F_PREF        BIT1=0D
+#define QEMU_FIXED_BARS_DEV_F_FIXED  BIT0=0D
+=0D
+/*=0D
+ * ACPI general-flag bits (ACPI 6.x 6.4.3.5.1):=0D
+ *   BIT2 =3D _MIF (minimum address fixed)=0D
+ *   BIT3 =3D _MAF (maximum address fixed)=0D
+ * Both set means AddrRangeMin carries the exact required base address.=0D
+ */=0D
+#define ACPI_ADDR_FLAG_FIXED  (BIT2 | BIT3)=0D
+=0D
+/* Raw blob kept in memory; device entries point into it. */=0D
+STATIC UINT8              *mBlobData;=0D
+STATIC QEMU_FIXED_BARS_HDR mHdr;=0D
+=0D
+/* Pre-parsed per-device index built from the blob at startup. */=0D
+typedef struct {=0D
+  UINT16                VendorId;=0D
+  UINT16                DeviceId;=0D
+  UINT8                 DevFlags;=0D
+  UINT8                 RpBus;    /* primary bus of the root port */=0D
+  UINT8                 NumBars;=0D
+  QEMU_FIXED_BARS_BAR  *Bars;    /* pointer into mBlobData */=0D
+} QFBD_DEVICE;=0D
+=0D
+/*=0D
+ * Per-(VendorId, DeviceId) class. FixedBarsCheckDevice() is called once p=
er=0D
+ * PCI function and once per scan pass. Different VID:DID classes must=0D
+ * advance their counters independently so that one class cannot disturb=
=0D
+ * the position of another across scan passes.=0D
+ *=0D
+ * Assumptions:=0D
+ *   - QEMU emits blob entries in the same order PciBusDxe discovers devic=
es.=0D
+ *   - For identical VID:DID devices, discovery order is stable across pas=
ses.=0D
+ *   - The counter is maintained per VID:DID class, not globally.=0D
+ */=0D
+typedef struct {=0D
+  UINT16    VendorId;=0D
+  UINT16    DeviceId;=0D
+  UINTN     Count;       /* number of devices with this VID:DID in the blo=
b */=0D
+  UINTN     CurrentIdx;  /* next entry to serve; wraps at Count */=0D
+} QFBD_DEVICE_CLASS;=0D
+=0D
+STATIC QFBD_DEVICE        *mDevices;=0D
+STATIC UINTN               mNumDevices;=0D
+STATIC QFBD_DEVICE_CLASS  *mClasses;   /* heap-allocated; mNumDevices entr=
ies max */=0D
+STATIC UINTN               mNumClasses;=0D
+=0D
+STATIC VOID=0D
+ReserveFixedBarRanges (=0D
+  VOID=0D
+  )=0D
+{=0D
+  UINTN       DevIdx;=0D
+  UINTN       BarIdx;=0D
+  UINT64      Min64;=0D
+  UINT64      Max64;=0D
+  UINT64      Min32;=0D
+  UINT64      Max32;=0D
+  UINT64      Gran;=0D
+  UINT64      Base;=0D
+  UINT64      Size;=0D
+  EFI_STATUS  Status;=0D
+=0D
+  Min64 =3D MAX_UINT64;=0D
+  Max64 =3D 0;=0D
+  Min32 =3D MAX_UINT64;=0D
+  Max32 =3D 0;=0D
+  Gran  =3D SIZE_1MB;=0D
+=0D
+  for (DevIdx =3D 0; DevIdx < mNumDevices; DevIdx++) {=0D
+    QFBD_DEVICE  *Dev =3D &mDevices[DevIdx];=0D
+=0D
+    if (!(Dev->DevFlags & QEMU_FIXED_BARS_DEV_F_FIXED)) {=0D
+      continue;=0D
+    }=0D
+    for (BarIdx =3D 0; BarIdx < Dev->NumBars; BarIdx++) {=0D
+      QEMU_FIXED_BARS_BAR  *Bar =3D &Dev->Bars[BarIdx];=0D
+=0D
+      if (Bar->Flags & QEMU_FIXED_BAR_F_MEM64) {=0D
+        if (Bar->Address < Min64) {=0D
+          Min64 =3D Bar->Address;=0D
+        }=0D
+        if (Bar->Address + Bar->Size > Max64) {=0D
+          Max64 =3D Bar->Address + Bar->Size;=0D
+        }=0D
+      } else {=0D
+        if (Bar->Address < Min32) {=0D
+          Min32 =3D Bar->Address;=0D
+        }=0D
+        if (Bar->Address + Bar->Size > Max32) {=0D
+          Max32 =3D Bar->Address + Bar->Size;=0D
+        }=0D
+      }=0D
+    }=0D
+  }=0D
+=0D
+  if (Min64 < Max64) {=0D
+    Base   =3D Min64 & ~(Gran - 1);=0D
+    Size   =3D ALIGN_VALUE (Max64 - Base, Gran);=0D
+    Status =3D gDS->AllocateMemorySpace (=0D
+                    EfiGcdAllocateAddress,=0D
+                    EfiGcdMemoryTypeMemoryMappedIo,=0D
+                    0, Size, &Base, gImageHandle, NULL=0D
+                    );=0D
+    DEBUG ((EFI_ERROR (Status) ? DEBUG_ERROR : DEBUG_INFO,=0D
+            "QFBD: reserve 64-bit 0x%016Lx+0x%016Lx: %r\n",=0D
+            Base, Size, Status));=0D
+  }=0D
+=0D
+  if (Min32 < Max32) {=0D
+    Base   =3D Min32 & ~(Gran - 1);=0D
+    Size   =3D ALIGN_VALUE (Max32 - Base, Gran);=0D
+    Status =3D gDS->AllocateMemorySpace (=0D
+                    EfiGcdAllocateAddress,=0D
+                    EfiGcdMemoryTypeMemoryMappedIo,=0D
+                    0, Size, &Base, gImageHandle, NULL=0D
+                    );=0D
+    DEBUG ((EFI_ERROR (Status) ? DEBUG_ERROR : DEBUG_INFO,=0D
+            "QFBD: reserve 32-bit 0x%016Lx+0x%016Lx: %r\n",=0D
+            Base, Size, Status));=0D
+  }=0D
+}=0D
+=0D
+/* Walk the blob once, build the mDevices[] index and the mClasses[] table=
. */=0D
+STATIC VOID=0D
+InitDevices (=0D
+  IN UINTN  BlobSize=0D
+  )=0D
+{=0D
+  UINT8  *Ptr =3D mBlobData + sizeof (QEMU_FIXED_BARS_HDR);=0D
+  UINT8  *End =3D mBlobData + BlobSize;=0D
+  UINTN   DevIdx, ClassIdx;=0D
+=0D
+  for (DevIdx =3D 0; DevIdx < mHdr.NumDevices; DevIdx++) {=0D
+    QEMU_FIXED_BARS_DEVICE  *Dev;=0D
+    UINT8                   *Next;=0D
+=0D
+    if (Ptr + sizeof (QEMU_FIXED_BARS_DEVICE) > End) {=0D
+      DEBUG ((DEBUG_ERROR, "QFBD: blob truncated at device %u\n", (UINT32)=
DevIdx));=0D
+      break;=0D
+    }=0D
+=0D
+    Dev  =3D (QEMU_FIXED_BARS_DEVICE *)Ptr;=0D
+    Next =3D Ptr=0D
+         + sizeof (QEMU_FIXED_BARS_DEVICE)=0D
+         + Dev->NumBars * sizeof (QEMU_FIXED_BARS_BAR);=0D
+=0D
+    if (Next > End) {=0D
+      DEBUG ((DEBUG_ERROR, "QFBD: blob truncated at device %u\n", (UINT32)=
DevIdx));=0D
+      break;=0D
+    }=0D
+=0D
+    mDevices[mNumDevices].VendorId  =3D Dev->VendorId;=0D
+    mDevices[mNumDevices].DeviceId  =3D Dev->DeviceId;=0D
+    mDevices[mNumDevices].DevFlags  =3D Dev->DevFlags;=0D
+    mDevices[mNumDevices].RpBus     =3D Dev->RpBus;=0D
+    mDevices[mNumDevices].NumBars   =3D Dev->NumBars;=0D
+    mDevices[mNumDevices].Bars      =3D (QEMU_FIXED_BARS_BAR *)(=0D
+      Ptr + sizeof (QEMU_FIXED_BARS_DEVICE)=0D
+      );=0D
+    mNumDevices++;=0D
+=0D
+    /* Find or create the class entry for this VID:DID. */=0D
+    for (ClassIdx =3D 0; ClassIdx < mNumClasses; ClassIdx++) {=0D
+      if (mClasses[ClassIdx].VendorId =3D=3D Dev->VendorId &&=0D
+          mClasses[ClassIdx].DeviceId =3D=3D Dev->DeviceId)=0D
+      {=0D
+        mClasses[ClassIdx].Count++;=0D
+        break;=0D
+      }=0D
+    }=0D
+    if (ClassIdx =3D=3D mNumClasses) {=0D
+      mClasses[mNumClasses].VendorId   =3D Dev->VendorId;=0D
+      mClasses[mNumClasses].DeviceId   =3D Dev->DeviceId;=0D
+      mClasses[mNumClasses].Count      =3D 1;=0D
+      mClasses[mNumClasses].CurrentIdx =3D 0;=0D
+      mNumClasses++;=0D
+    }=0D
+=0D
+    DEBUG ((DEBUG_INFO,=0D
+            "QFBD: device %04x:%04x num_bars=3D%u\n",=0D
+            Dev->VendorId, Dev->DeviceId, Dev->NumBars));=0D
+=0D
+    Ptr =3D Next;=0D
+  }=0D
+=0D
+  for (ClassIdx =3D 0; ClassIdx < mNumClasses; ClassIdx++) {=0D
+    DEBUG ((DEBUG_INFO,=0D
+            "QFBD: class %04x:%04x count=3D%u\n",=0D
+            mClasses[ClassIdx].VendorId, mClasses[ClassIdx].DeviceId,=0D
+            (UINT32)mClasses[ClassIdx].Count));=0D
+  }=0D
+}=0D
+=0D
+EFI_STATUS=0D
+FixedBarsCheckDevice (=0D
+  IN  UINTN  VendorId,=0D
+  IN  UINTN  DeviceId,=0D
+  OUT VOID   **Descriptors,=0D
+  OUT UINTN  *DescriptorsSize=0D
+  )=0D
+{=0D
+  QFBD_DEVICE_CLASS                  *Class;=0D
+  QFBD_DEVICE                        *Dev;=0D
+  UINTN                               BarIdx, DevIdx, MatchCount, ClassIdx=
;=0D
+  EFI_ACPI_ADDRESS_SPACE_DESCRIPTOR  *Desc;=0D
+=0D
+  *Descriptors     =3D NULL;=0D
+  *DescriptorsSize =3D 0;=0D
+=0D
+  if (mNumClasses =3D=3D 0) {=0D
+    return EFI_SUCCESS;=0D
+  }=0D
+=0D
+  /* Look up the per-VID:DID class. */=0D
+  Class =3D NULL;=0D
+  for (ClassIdx =3D 0; ClassIdx < mNumClasses; ClassIdx++) {=0D
+    if (mClasses[ClassIdx].VendorId =3D=3D (UINT16)VendorId &&=0D
+        mClasses[ClassIdx].DeviceId =3D=3D (UINT16)DeviceId)=0D
+    {=0D
+      Class =3D &mClasses[ClassIdx];=0D
+      break;=0D
+    }=0D
+  }=0D
+  if (Class =3D=3D NULL) {=0D
+    return EFI_SUCCESS;  /* not a fixed-bar device */=0D
+  }=0D
+=0D
+  /* Find the CurrentIdx-th device in mDevices[] matching this VID:DID. */=
=0D
+  Dev        =3D NULL;=0D
+  MatchCount =3D 0;=0D
+  for (DevIdx =3D 0; DevIdx < mNumDevices; DevIdx++) {=0D
+    if (mDevices[DevIdx].VendorId =3D=3D (UINT16)VendorId &&=0D
+        mDevices[DevIdx].DeviceId =3D=3D (UINT16)DeviceId)=0D
+    {=0D
+      if (MatchCount =3D=3D Class->CurrentIdx) {=0D
+        Dev =3D &mDevices[DevIdx];=0D
+        break;=0D
+      }=0D
+      MatchCount++;=0D
+    }=0D
+  }=0D
+  if (Dev =3D=3D NULL) {=0D
+    return EFI_SUCCESS;=0D
+  }=0D
+=0D
+  /* Always advance the counter so ordering stays in sync with the blob. *=
/=0D
+  Class->CurrentIdx++;=0D
+  if (Class->CurrentIdx >=3D Class->Count) {=0D
+    Class->CurrentIdx =3D 0;=0D
+  }=0D
+=0D
+  if (!(Dev->DevFlags & QEMU_FIXED_BARS_DEV_F_FIXED)) {=0D
+    return EFI_SUCCESS;=0D
+  }=0D
+=0D
+  Desc =3D AllocateZeroPool (Dev->NumBars * sizeof (*Desc));=0D
+  if (Desc =3D=3D NULL) {=0D
+    return EFI_OUT_OF_RESOURCES;=0D
+  }=0D
+=0D
+  *Descriptors     =3D Desc;=0D
+  *DescriptorsSize =3D Dev->NumBars * sizeof (*Desc);=0D
+=0D
+  for (BarIdx =3D 0; BarIdx < Dev->NumBars; BarIdx++) {=0D
+    QEMU_FIXED_BARS_BAR  *Bar =3D &Dev->Bars[BarIdx];=0D
+=0D
+    Desc->Desc                   =3D ACPI_ADDRESS_SPACE_DESCRIPTOR;=0D
+    Desc->Len                    =3D (UINT16)(sizeof (*Desc) - 3);=0D
+    Desc->ResType                =3D ACPI_ADDRESS_SPACE_TYPE_MEM;=0D
+    Desc->GenFlag                =3D ACPI_ADDR_FLAG_FIXED;=0D
+    Desc->SpecificFlag           =3D 0;=0D
+    Desc->AddrSpaceGranularity   =3D (Bar->Flags & QEMU_FIXED_BAR_F_MEM64)=
 ? 64 : 32;=0D
+    Desc->AddrRangeMin           =3D Bar->Address;=0D
+    Desc->AddrRangeMax           =3D Bar->Size - 1;=0D
+    Desc->AddrTranslationOffset  =3D BarIdx;=0D
+    Desc->AddrLen                =3D Bar->Size;=0D
+=0D
+    DEBUG ((DEBUG_INFO,=0D
+            "QFBD: %04x:%04x BAR%u -> 0x%016Lx size 0x%016Lx\n",=0D
+            Dev->VendorId, Dev->DeviceId,=0D
+            (UINT32)Bar->Bar, Bar->Address, Bar->Size));=0D
+=0D
+    Desc++;=0D
+  }=0D
+=0D
+  return EFI_SUCCESS;=0D
+}=0D
+=0D
+EFI_STATUS=0D
+FixedBarsInit (=0D
+  OUT BOOLEAN  *HasFixedBarsDevices=0D
+  )=0D
+{=0D
+  FIRMWARE_CONFIG_ITEM  FwCfgItem;=0D
+  UINTN                 FwCfgSize;=0D
+  EFI_STATUS            Status;=0D
+=0D
+  *HasFixedBarsDevices =3D FALSE;=0D
+=0D
+  Status =3D QemuFwCfgFindFile ("etc/fixed-bars", &FwCfgItem, &FwCfgSize);=
=0D
+  if (EFI_ERROR (Status)) {=0D
+    DEBUG ((DEBUG_INFO, "QFBD: etc/fixed-bars absent, nothing to do\n"));=
=0D
+    return EFI_SUCCESS;=0D
+  }=0D
+=0D
+  if (FwCfgSize < sizeof (mHdr)) {=0D
+    DEBUG ((DEBUG_ERROR, "QFBD: blob too small (%Lu bytes)\n",=0D
+            (UINT64)FwCfgSize));=0D
+    return EFI_UNSUPPORTED;=0D
+  }=0D
+=0D
+  QemuFwCfgSelectItem (FwCfgItem);=0D
+  QemuFwCfgReadBytes (sizeof (mHdr), &mHdr);=0D
+=0D
+  if (mHdr.Version !=3D QEMU_FIXED_BARS_VERSION) {=0D
+    DEBUG ((DEBUG_ERROR,=0D
+            "QFBD: unsupported blob version %u (expected %u)\n",=0D
+            mHdr.Version, QEMU_FIXED_BARS_VERSION));=0D
+    return EFI_UNSUPPORTED;=0D
+  }=0D
+=0D
+  if (mHdr.NumDevices =3D=3D 0) {=0D
+    DEBUG ((DEBUG_INFO, "QFBD: zero devices, nothing to do\n"));=0D
+    return EFI_SUCCESS;=0D
+  }=0D
+=0D
+  /* Read the full blob into a persistent buffer; device entries point int=
o it. */=0D
+  mBlobData =3D AllocatePool (FwCfgSize);=0D
+  if (mBlobData =3D=3D NULL) {=0D
+    return EFI_OUT_OF_RESOURCES;=0D
+  }=0D
+=0D
+  QemuFwCfgSelectItem (FwCfgItem);=0D
+  QemuFwCfgReadBytes (FwCfgSize, mBlobData);=0D
+  CopyMem (&mHdr, mBlobData, sizeof (mHdr));=0D
+=0D
+  mDevices =3D AllocateZeroPool (mHdr.NumDevices * sizeof (QFBD_DEVICE));=
=0D
+  if (mDevices =3D=3D NULL) {=0D
+    FreePool (mBlobData);=0D
+    return EFI_OUT_OF_RESOURCES;=0D
+  }=0D
+=0D
+  /* Worst case: every device has a unique VID:DID =E2=80=94 allocate mNum=
Devices slots. */=0D
+  mClasses =3D AllocateZeroPool (mHdr.NumDevices * sizeof (QFBD_DEVICE_CLA=
SS));=0D
+  if (mClasses =3D=3D NULL) {=0D
+    FreePool (mDevices);=0D
+    FreePool (mBlobData);=0D
+    return EFI_OUT_OF_RESOURCES;=0D
+  }=0D
+=0D
+  DEBUG ((DEBUG_INFO, "QFBD: %u device(s)\n", mHdr.NumDevices));=0D
+=0D
+  mNumDevices =3D 0;=0D
+  mNumClasses =3D 0;=0D
+  InitDevices (FwCfgSize);=0D
+  ReserveFixedBarRanges ();=0D
+=0D
+  *HasFixedBarsDevices =3D TRUE;=0D
+=0D
+  return EFI_SUCCESS;=0D
+}=0D
diff --git a/OvmfPkg/IncompatiblePciDeviceSupportDxe/FixedBars.h b/OvmfPkg/=
IncompatiblePciDeviceSupportDxe/FixedBars.h
new file mode 100644
index 0000000000..837399986e
--- /dev/null
+++ b/OvmfPkg/IncompatiblePciDeviceSupportDxe/FixedBars.h
@@ -0,0 +1,63 @@
+/** @file=0D
+  Public interface for FixedBars.c -- fixed PCI BAR placement using=0D
+  metadata provided by QEMU through the "etc/fixed-bars" fw_cfg blob.=0D
+=0D
+  Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved=
.<BR>=0D
+=0D
+  SPDX-License-Identifier: BSD-2-Clause-Patent=0D
+**/=0D
+=0D
+#ifndef FIXED_BARS_H_=0D
+#define FIXED_BARS_H_=0D
+=0D
+#include <Uefi.h>=0D
+=0D
+/**=0D
+  Read and parse the "etc/fixed-bars" fw_cfg blob (if present), and reserv=
e=0D
+  the fixed BAR address ranges it describes in the GCD memory space map.=
=0D
+=0D
+  Must be called once, from the owning driver's entry point, before that=
=0D
+  driver installs EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL.=0D
+=0D
+  @param[out] HasFixedBarsDevices  TRUE if the blob was present and=0D
+                                    described at least one fixed-BAR devic=
e;=0D
+                                    FALSE otherwise (nothing else in this=
=0D
+                                    file has any effect in that case).=0D
+=0D
+  @retval EFI_SUCCESS           Blob absent, empty, or successfully parsed=
.=0D
+  @retval EFI_UNSUPPORTED       Blob present but malformed/wrong version.=
=0D
+  @retval EFI_OUT_OF_RESOURCES  Memory allocation failure.=0D
+**/=0D
+EFI_STATUS=0D
+FixedBarsInit (=0D
+  OUT BOOLEAN  *HasFixedBarsDevices=0D
+  );=0D
+=0D
+/**=0D
+  Return the fixed-BAR ACPI address-space descriptors for one PCI function=
,=0D
+  if it has a matching entry in the "etc/fixed-bars" blob. Returns=0D
+  *Descriptors =3D=3D NULL, with *DescriptorsSize =3D=3D 0, when the devic=
e is not=0D
+  a fixed-BAR device.=0D
+=0D
+  @param[in]  VendorId        Device's PCI Vendor ID.=0D
+  @param[in]  DeviceId        Device's PCI Device ID.=0D
+  @param[out] Descriptors     Heap-allocated array of=0D
+                              EFI_ACPI_ADDRESS_SPACE_DESCRIPTOR, one per=
=0D
+                              fixed BAR; caller takes ownership. NULL if n=
o=0D
+                              match.=0D
+  @param[out] DescriptorsSize Size in bytes of *Descriptors.=0D
+=0D
+  @retval EFI_SUCCESS           Always, on non-allocation-failure paths=0D
+                                (matches EFI_INCOMPATIBLE_PCI_DEVICE_SUPPO=
RT_=0D
+                                PROTOCOL.CheckDevice()'s own contract).=0D
+  @retval EFI_OUT_OF_RESOURCES  Memory allocation failure.=0D
+**/=0D
+EFI_STATUS=0D
+FixedBarsCheckDevice (=0D
+  IN  UINTN  VendorId,=0D
+  IN  UINTN  DeviceId,=0D
+  OUT VOID   **Descriptors,=0D
+  OUT UINTN  *DescriptorsSize=0D
+  );=0D
+=0D
+#endif=0D
diff --git a/OvmfPkg/IncompatiblePciDeviceSupportDxe/IncompatiblePciDeviceS=
upport.c b/OvmfPkg/IncompatiblePciDeviceSupportDxe/IncompatiblePciDeviceSup=
port.c
index ebf73d97db..5e40936f81 100644
--- a/OvmfPkg/IncompatiblePciDeviceSupportDxe/IncompatiblePciDeviceSupport.=
c
+++ b/OvmfPkg/IncompatiblePciDeviceSupportDxe/IncompatiblePciDeviceSupport.=
c
@@ -22,6 +22,8 @@
 =0D
 #include <Protocol/IncompatiblePciDeviceSupport.h>=0D
 =0D
+#include "FixedBars.h"=0D
+=0D
 //=0D
 // The protocol interface this driver produces.=0D
 //=0D
@@ -165,6 +167,57 @@ STATIC CONST EFI_ACPI_END_TAG_DESCRIPTOR  mEndDesc =3D=
 {
 =0D
   @retval EFI_SUCCESS   The function always returns EFI_SUCCESS.=0D
 **/=0D
+/**=0D
+  This function copies Buffer into Configuration, then appends the=0D
+  confidential-VM option ROM descriptor if applicable, and finally=0D
+  appends the terminating End Tag.=0D
+=0D
+  @param[in]  Buffer        Descriptor bytes.=0D
+  @param[in]  BufferSize    Size in bytes of Buffer.=0D
+  @param[out] Configuration As in CheckDevice().=0D
+=0D
+  @retval EFI_SUCCESS           Configuration built and returned.=0D
+  @retval EFI_OUT_OF_RESOURCES  Memory allocation failure.=0D
+**/=0D
+STATIC=0D
+EFI_STATUS=0D
+BuildConfiguration (=0D
+  IN  CONST VOID  *Buffer,=0D
+  IN  UINTN       BufferSize,=0D
+  OUT VOID        **Configuration=0D
+  )=0D
+{=0D
+  UINTN  Length;=0D
+  UINT8  *Ptr;=0D
+=0D
+  Length =3D BufferSize + sizeof mEndDesc;=0D
+=0D
+  //=0D
+  // In Td guest OptionRom is not allowed.=0D
+  //=0D
+  if (CcProbe ()) {=0D
+    Length +=3D sizeof mOptionRomConfiguration;=0D
+  }=0D
+=0D
+  *Configuration =3D AllocateZeroPool (Length);=0D
+  if (*Configuration =3D=3D NULL) {=0D
+    return EFI_OUT_OF_RESOURCES;=0D
+  }=0D
+=0D
+  Ptr =3D (UINT8 *)(UINTN)*Configuration;=0D
+  CopyMem (Ptr, Buffer, BufferSize);=0D
+  Length =3D BufferSize;=0D
+=0D
+  if (CcProbe ()) {=0D
+    CopyMem (Ptr + Length, &mOptionRomConfiguration, sizeof mOptionRomConf=
iguration);=0D
+    Length +=3D sizeof mOptionRomConfiguration;=0D
+  }=0D
+=0D
+  CopyMem (Ptr + Length, &mEndDesc, sizeof mEndDesc);=0D
+=0D
+  return EFI_SUCCESS;=0D
+}=0D
+=0D
 STATIC=0D
 EFI_STATUS=0D
 EFIAPI=0D
@@ -178,8 +231,25 @@ CheckDevice (
   OUT VOID                                          **Configuration=0D
   )=0D
 {=0D
-  UINTN  Length;=0D
-  UINT8  *Ptr;=0D
+  EFI_STATUS  Status;=0D
+  VOID        *FixedBarsDescs;=0D
+  UINTN       FixedBarsDescsSize;=0D
+=0D
+  //=0D
+  // Dispatch hook: if this device has an entry in the "etc/fixed-bars"=0D
+  // fw_cfg blob, use that instead of the hardcoded 64-bit-MMIO-preference=
=0D
+  // descriptor below.=0D
+  //=0D
+  Status =3D FixedBarsCheckDevice (VendorId, DeviceId, &FixedBarsDescs, &F=
ixedBarsDescsSize);=0D
+  if (EFI_ERROR (Status)) {=0D
+    return Status;=0D
+  }=0D
+=0D
+  if (FixedBarsDescs !=3D NULL) {=0D
+    Status =3D BuildConfiguration (FixedBarsDescs, FixedBarsDescsSize, Con=
figuration);=0D
+    FreePool (FixedBarsDescs);=0D
+    return Status;=0D
+  }=0D
 =0D
   //=0D
   // Unlike the general description of this protocol member suggests, ther=
e is=0D
@@ -200,18 +270,8 @@ CheckDevice (
   // the edk2 PCI Bus UEFI_DRIVER actually handles error codes; see the=0D
   // UpdatePciInfo() function.=0D
   //=0D
-  Length =3D sizeof mMmio64Configuration + sizeof mEndDesc;=0D
-=0D
-  //=0D
-  // In Td guest OptionRom is not allowed.=0D
-  //=0D
-  if (CcProbe ()) {=0D
-    Length +=3D sizeof mOptionRomConfiguration;=0D
-  }=0D
-=0D
-  *Configuration =3D AllocateZeroPool (Length);=0D
-=0D
-  if (*Configuration =3D=3D NULL) {=0D
+  Status =3D BuildConfiguration (&mMmio64Configuration, sizeof mMmio64Conf=
iguration, Configuration);=0D
+  if (EFI_ERROR (Status)) {=0D
     DEBUG ((=0D
       DEBUG_WARN,=0D
       "%a: 64-bit MMIO BARs may be degraded for PCI 0x%04x:0x%04x (rev %d)=
\n",=0D
@@ -220,21 +280,9 @@ CheckDevice (
       (UINT32)DeviceId,=0D
       (UINT8)RevisionId=0D
       ));=0D
-    return EFI_OUT_OF_RESOURCES;=0D
   }=0D
 =0D
-  Ptr =3D (UINT8 *)(UINTN)*Configuration;=0D
-  CopyMem (Ptr, &mMmio64Configuration, sizeof mMmio64Configuration);=0D
-  Length =3D sizeof mMmio64Configuration;=0D
-=0D
-  if (CcProbe ()) {=0D
-    CopyMem (Ptr + Length, &mOptionRomConfiguration, sizeof mOptionRomConf=
iguration);=0D
-    Length +=3D sizeof mOptionRomConfiguration;=0D
-  }=0D
-=0D
-  CopyMem (Ptr + Length, &mEndDesc, sizeof mEndDesc);=0D
-=0D
-  return EFI_SUCCESS;=0D
+  return Status;=0D
 }=0D
 =0D
 /**=0D
@@ -257,12 +305,18 @@ DriverInitialize (
   )=0D
 {=0D
   EFI_STATUS  Status;=0D
+  BOOLEAN     HasFixedBarsDevices;=0D
+=0D
+  Status =3D FixedBarsInit (&HasFixedBarsDevices);=0D
+  if (EFI_ERROR (Status)) {=0D
+    return Status;=0D
+  }=0D
 =0D
   //=0D
-  // If there is no 64-bit PCI MMIO aperture, then 64-bit MMIO BARs have t=
o be=0D
-  // allocated under 4 GB unconditionally.=0D
+  // If there is no 64-bit PCI MMIO aperture and no fixed-bars devices to=
=0D
+  // place, do not install the protocol.=0D
   //=0D
-  if (PcdGet64 (PcdPciMmio64Size) =3D=3D 0) {=0D
+  if ((PcdGet64 (PcdPciMmio64Size) =3D=3D 0) && !HasFixedBarsDevices) {=0D
     return EFI_UNSUPPORTED;=0D
   }=0D
 =0D
diff --git a/OvmfPkg/IncompatiblePciDeviceSupportDxe/IncompatiblePciDeviceS=
upport.inf b/OvmfPkg/IncompatiblePciDeviceSupportDxe/IncompatiblePciDeviceS=
upport.inf
index b92662d0bb..b51f51c25e 100644
--- a/OvmfPkg/IncompatiblePciDeviceSupportDxe/IncompatiblePciDeviceSupport.=
inf
+++ b/OvmfPkg/IncompatiblePciDeviceSupportDxe/IncompatiblePciDeviceSupport.=
inf
@@ -18,21 +18,27 @@
 =0D
 [Sources]=0D
   IncompatiblePciDeviceSupport.c=0D
+  FixedBars.c=0D
+  FixedBars.h=0D
 =0D
 [Packages]=0D
   MdePkg/MdePkg.dec=0D
+  MdeModulePkg/MdeModulePkg.dec=0D
   OvmfPkg/OvmfPkg.dec=0D
 =0D
 [LibraryClasses]=0D
+  BaseMemoryLib=0D
   CcProbeLib=0D
   DebugLib=0D
+  DxeServicesTableLib=0D
   MemoryAllocationLib=0D
   PcdLib=0D
+  QemuFwCfgLib=0D
   UefiBootServicesTableLib=0D
   UefiDriverEntryPoint=0D
 =0D
 [Protocols]=0D
-  gEfiIncompatiblePciDeviceSupportProtocolGuid ## SOMETIMES_PRODUCES=0D
+  gEfiIncompatiblePciDeviceSupportProtocolGuid       ## SOMETIMES_PRODUCES=
=0D
 =0D
 [Pcd]=0D
   gUefiOvmfPkgTokenSpaceGuid.PcdPciMmio64Size                ## CONSUMES=
=0D
--=20
2.34.1


