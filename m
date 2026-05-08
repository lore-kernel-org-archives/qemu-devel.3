Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7B3CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 19:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLQSx-0006qu-LT; Fri, 08 May 2026 15:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wLQSu-0006qP-Nz; Fri, 08 May 2026 15:02:25 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wLQSs-00017e-Jl; Fri, 08 May 2026 15:02:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pEuyTkOmW9yhX91E/Pd5i48OJh3lKRCM9oh0xZdKoomNcqQhX3Jt2JMlfGtx+5IqCSCj0HEyVcCPO/B6JQtAelIK0nkgco+W4XVnP64YIUpin1CFKyWX2iBefrl2F5U3bhtOxk5S2a6fMasOzaCCwvYW6LuJ2Du082k/FmwnmTy/vwqfovmrSDIpgPa+NcwqHJkuhRFvClGY94Dhdcbw/zzZcd86aE3IdSCVmIPX6+4iFsX6BMz/lbMKuw98jLAChtTxNGw1NCii5yNrhGv/UxRa0gAmlC1nQO9g5iCN+4yYb4nqE8IDAobm7GZIwLek/j2VnKzHhZMHGT3/PPK5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eey7wHf/KRuPLqhlbZakh3b8sxTzhOabA8w1jyIY0FY=;
 b=fpOeP8a3RcDImz0PBcS9V+RtZC/sZYpCug9WLobK/Q6CNTHDWCxxU9ggsMdN00dsmKOBIvHjaVbvA8wq8F77mwpcbsQ76OgKTmCWPXWuXR/12KVxFZQQSr9qTQrBhzFVjIqWPkp/VBBueoPct5Zx2/ix0OuWUPXf+F2OfHBmXwsQLqxVHLstb8TMhCt3uPPqmoL2FW7umrXM2OdEh/4fWbAPl8haVOsZmD32LwZJUKyocspTM8FqwAO6xuwTXjfDsX8iDoAZiyyvofcEpsb/ailFcFn/yLnwL5moGOjL7KSWl5uU12AyXwJyvecfPFWVO9NiS5jX7xDVxag8utp6gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eey7wHf/KRuPLqhlbZakh3b8sxTzhOabA8w1jyIY0FY=;
 b=clMnrMwlVtOWFPg8CAnubYEUqP1sxWuUDhjaNeRiT77q8srQHKklmoEP/Z66RW3k7GQ4sm0zvhjd92+PUArZk6S4kYqCUaT5KIPqH4Yluc2wZlHBtzulqpJ9VD5hgcw7GCNrJK49/kKz5iofPBydFTgriX2pIe0RJCz5kZld6PZyM9vtBWhPdAq7cStclZ9+5C7svfFbgWkcrTELJhmaeCzkwI0yyBf/F6hiENqPOScr2pjgsbYeLOrM7NbUDg0e88LZyM3hIldHlivAmC8gB3KDW+4/dP3Fgnuy7vdq4oYCoaaMA2NjyGRH3g1HIOu7EEzQvsehENgz5uH6XZu/8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 by IA1PR12MB7519.namprd12.prod.outlook.com (2603:10b6:208:418::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 19:02:16 +0000
Received: from BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325]) by BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325%4]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 19:02:15 +0000
From: Tushar Dave <tdave@nvidia.com>
To: devel@edk2.groups.io
Cc: qemu-devel@nongnu.org, alwilliamson@nvidia.com, jgg@nvidia.com,
 skolothumtho@nvidia.com, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 mst@redhat.com, marcel.apfelbaum@gmail.com
Subject: [PATCH 1/1] OvmfPkg/Fdt: Honor pci-enum-done for pre-enumerated PCI
Date: Fri,  8 May 2026 14:01:50 -0500
Message-Id: <20260508190150.203200-1-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0145.namprd03.prod.outlook.com
 (2603:10b6:208:32e::30) To BY5PR12MB4179.namprd12.prod.outlook.com
 (2603:10b6:a03:211::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4179:EE_|IA1PR12MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: b0ebc7f4-b270-4220-ffe0-08dead3451ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|3023799003|18002099003; 
X-Microsoft-Antispam-Message-Info: 6ydn6UhfTf+mWXeiUF9F8CaF3mmCSM9zaenRzP9rQvOF/1+U0WIs1cSx6DRNVQXMJg4NxfmFp5KiG+KZyXYYx1M+/Kt0Vhzl3tA8wnWFhnZjzkndQc3BwvD69KeRKmIjcrzpPOCCTrikRioxC9xQOYR3FFPYD/fcwMTndJtr+X97T3s3Pf3mX081zTKscGMpQuqd55gKWrl1CoQQdRyfOhaHBtuDdCf85Fzpqg+NWTN0tWkglodPx9MpqM42kr2a9AYlixdCS5+n0BbfEjgf79pIA83Dk3RkfS1iCFsFUTCUW7WQf3O9waOhWjrHV3Wd+HBIexC5aIbqSNCyAxSufBMkcXwWVEgVar0k+qml8aFyxt7tlMLKzN4Z+Bxx3EMNLSEzQwlVKapGrsC8YCfdyVNZ3WhbfjkKofHPR7gygmrDkt9VZ33sL03A63qpv2+Y3bP3xllKWOMzZycwKqdkJpFWk+SFuSE5K07KsgnQEo9BSpXCaovjemGEU5FPbZYoIZmqfRmblkKpJ7c2MFju/l7OpScRjh6Y+QvZasgbZ6qe26V1T0wd18Bjv3yoqnoxxbgi1Bm0Vn2J6J3Y1pDjrPDn+EecQhtn7VEXmhAX89uLS95G9zoh3LzGec9MZgV0mUF+VoLuchbKkjSODo/wFG3+BXFJSlTJ3XaLToWw1ggBGgRTOrrE3hNjoiME4XiswQML0R3Voxmi8NTr2BWJzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4179.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(3023799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2/hEy/xh0G93DjsWj9JItsw1pGELf+pgphdlJ8c5kt3GpkBCp0t/wmkvrHmA?=
 =?us-ascii?Q?2d7OHSQ8zAcSsWo2U49w7sziRruBsAlurDRzPvOvMLTp1mer/oAKdTLJWAL1?=
 =?us-ascii?Q?+mXmm5F9GHc+XJ7qrnvZOVcqXPdmWrJOVlvJYDWt8L/PD3vER/zBJcaXwHjm?=
 =?us-ascii?Q?H6VG7KLiBKA7Fbrn+lBjo3lJRq9SyOhdAU20vDOkEphD6BcH3vWOkoQg4ATM?=
 =?us-ascii?Q?C9p3M7qPV1zNB57MI78iwNL0m4Yzo2pqeoXC9d5vpqNRave9z6V/DlVn4PAj?=
 =?us-ascii?Q?w5J+kpuUZ9wA0txvgNm4hhoKjhopm+OzNLYbBH+fTE9otiDjNC09a2c/ZDhO?=
 =?us-ascii?Q?S0/mrqMPoYPtHYMR2fIoKNI9ETdITPSrmbaf5GJajwB4UAwHrNrwSLUO50Qt?=
 =?us-ascii?Q?dYjQgPwsPOjlewkL6Aw9A5I/LgUtWnIRzu5gjhN8URZMgP3aCwoxGZ/gzYV4?=
 =?us-ascii?Q?IMIfQsSd82UtQyqufa/fyo+Uadtc5vA3C49fXExJVOwq91VFIZiKCuHrusjV?=
 =?us-ascii?Q?KqY+LK6so/4GJGzfL6eapBpcYkelgfmX3+hyiZOsgTh60pLrdDOdu3b3NGIG?=
 =?us-ascii?Q?RouxXxcXnGcTtEH0Uh7grHbXrytFvsBWT7NazqLWvexfkAbHOO1Q+B6SOkOe?=
 =?us-ascii?Q?PEiXHdl+AZ415VBTPJSStCKQ5iF6RzAh7GZ/2QW24xfgKUCP7LhvTqc6hH3r?=
 =?us-ascii?Q?XsKzB/iKknFknlT5StUF1Rxs7oZC1PqBtuWKkYtQXBF2nceB6DJxXKrWZfNJ?=
 =?us-ascii?Q?G3mLbetFKSwUo/6u1j6cl1MmzqVaWbjECoyb3lovc02zglQMIcXv3lxAhFYB?=
 =?us-ascii?Q?6VUwaZD+k7WnbFOHTVMvrsq7Z5eKr1SwA9zOXBR5mMObKX4bPfTc/Q+9hxER?=
 =?us-ascii?Q?/AToPyfXy5Us9xVwbYyG32pKhJRgfV6kfS8wTgJiqqV/FpHvgMnHaXuIWAEY?=
 =?us-ascii?Q?w82pRbGY8ZWes+uIgYB5MmDjicp96jSI8PZI9JOt64YoV2Aza3kw+mSABPTr?=
 =?us-ascii?Q?M0rRpf/b/VRVHOK5OUkP6+uAPfZ1CulZGwAVg1D7DGKl+m+8+aYP/ZdFH7RY?=
 =?us-ascii?Q?2Zwm2e8o4ODNVwhO1kl8GeuAuAGrpiU0ESt+vJS226n34GAyPl7lYPgnsvIM?=
 =?us-ascii?Q?Utk7Xfh+d5oNdUyVdwr8xFboO0gDN82Ys3RDn6jhGwgNAqm/O0C4c83JoWFU?=
 =?us-ascii?Q?aEFY8GV0mVM9Ing37sZ8sVX94dOi7FYP9dQk6ZBAeu6OPaYmHVh34NInvgiI?=
 =?us-ascii?Q?7IAFryRjNaeFQOy38aZyKnyYm2/QZI98Lh24DDmYeqkDsqbVFdxGAzFF7xyt?=
 =?us-ascii?Q?q/9VTs8Em0/EMtIWq7MHe3BE+AUnit6UnxVlMLse0fwWxT7Wsnca48E0/fEN?=
 =?us-ascii?Q?GMXYL8m4VokXQRgmV2sNlpktbX6apOn/qPN1szqAMn8KTrLd+lj6eceEfveq?=
 =?us-ascii?Q?3KjQQhUiwTfrRdstdu9Rbk43W6D3rAaxabmzW5Cn8YATFUSXNTd8Oqz+UzEI?=
 =?us-ascii?Q?Ki530Eqk0LAvfnqrjfXsnn2baJPuDot49EqNZY2zwbIhHk+Zd8W14Oj0RSAa?=
 =?us-ascii?Q?gLbYaoRwt0sSzGTKHCE6GBvnd23/zR4+iYbcjVjZcYoy10ZVGuq3GDz64XZF?=
 =?us-ascii?Q?2L2NJVarSUaypzDI4QEDPCdmaYuF0YE/2NCvoKqkvfNl7ceGIDIitwE9lzaV?=
 =?us-ascii?Q?vMFJy4mOsfg6sifxYP4LxAd2W42BvwSdmAJhRH/kA88jkM295xUaHIZera3b?=
 =?us-ascii?Q?Z/+IRbTI5Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ebc7f4-b270-4220-ffe0-08dead3451ec
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 19:02:15.8965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KCPDQHsm9eagKGE94NELo1WsMQt+0k/nEcSVvUcVtRaL25mg+/WWtqCHrx8QhKJmcm9qrlvdH290Y4VzE2f8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7519
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=tdave@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The ARM FDT PCI producer path does not preserve the platform
PcdPciDisableBusEnumeration value. After parsing the PCI host node
from the device tree, it always sets that PCD to FALSE. This is
reasonable when firmware must discover and assign PCI resources
itself.

However, there are setups where the hypervisor (e.g. QEMU with
pre-enumeration) has already performed PCI bus enumeration and BAR
programming and expects firmware to preserve that configuration.
Always forcing the PCD to FALSE on this path removes that option,
so EDK2 will re-enumerate the bus regardless of hypervisor intent.

If the FDT PCI node contains "pci-enum-done", set
PcdPciDisableBusEnumeration to TRUE so EDK2 can treat the topology
as pre-configured. When absent, set it to FALSE and retain the
previous behavior (full firmware enumeration).

Also, mark the root bridges with ResourceAssigned based on the
PCD in FdtPciHostBridgeLib so the PCI bus driver does not
re-enumerate the bus.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
This patch accompanies the QEMU RFC series "hw/arm/virt, hw/pci:
PCI pre-enumeration and fixed BAR allocation" posted to qemu-devel:
https://lore.kernel.org/qemu-devel/20260508183717.193630-1-tdave@nvidia.com/

 .../FdtPciHostBridgeLib/FdtPciHostBridgeLib.c |  8 ++++-
 .../FdtPciHostBridgeLib.inf                   |  1 +
 .../FdtPciPcdProducerLib.c                    | 30 ++++++++++++++++++-
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/OvmfPkg/Fdt/FdtPciHostBridgeLib/FdtPciHostBridgeLib.c b/OvmfPk=
g/Fdt/FdtPciHostBridgeLib/FdtPciHostBridgeLib.c
index 9af8c21a21..d84d15617d 100644
--- a/OvmfPkg/Fdt/FdtPciHostBridgeLib/FdtPciHostBridgeLib.c
+++ b/OvmfPkg/Fdt/FdtPciHostBridgeLib/FdtPciHostBridgeLib.c
@@ -444,7 +444,7 @@ PciHostBridgeGetRootBridges (
   PMemAbove4G.Base  =3D MAX_UINT64;=0D
   PMemAbove4G.Limit =3D 0;=0D
 =0D
-  return PciHostBridgeUtilityGetRootBridges (=0D
+  PCI_ROOT_BRIDGE  *Bridges =3D PciHostBridgeUtilityGetRootBridges (=0D
            Count,=0D
            Attributes,=0D
            AllocationAttributes,=0D
@@ -458,6 +458,12 @@ PciHostBridgeGetRootBridges (
            &PMem,=0D
            &PMemAbove4G=0D
            );=0D
+  if (Bridges !=3D NULL) {=0D
+    for (UINTN Index =3D 0; Index < *Count; Index++) {=0D
+      Bridges[Index].ResourceAssigned =3D PcdGetBool (PcdPciDisableBusEnum=
eration);=0D
+    }=0D
+  }=0D
+  return Bridges;=0D
 }=0D
 =0D
 /**=0D
diff --git a/OvmfPkg/Fdt/FdtPciHostBridgeLib/FdtPciHostBridgeLib.inf b/Ovmf=
Pkg/Fdt/FdtPciHostBridgeLib/FdtPciHostBridgeLib.inf
index 26b38b5966..636871866a 100644
--- a/OvmfPkg/Fdt/FdtPciHostBridgeLib/FdtPciHostBridgeLib.inf
+++ b/OvmfPkg/Fdt/FdtPciHostBridgeLib/FdtPciHostBridgeLib.inf
@@ -41,6 +41,7 @@
 [Pcd]=0D
   gEfiMdePkgTokenSpaceGuid.PcdPciIoTranslation=0D
   gEfiMdePkgTokenSpaceGuid.PcdPciExpressBaseAddress=0D
+  gEfiMdeModulePkgTokenSpaceGuid.PcdPciDisableBusEnumeration=0D
 =0D
 [Depex]=0D
   gFdtClientProtocolGuid=0D
diff --git a/OvmfPkg/Fdt/FdtPciPcdProducerLib/FdtPciPcdProducerLib.c b/Ovmf=
Pkg/Fdt/FdtPciPcdProducerLib/FdtPciPcdProducerLib.c
index a3b09e547f..f5e30d8852 100644
--- a/OvmfPkg/Fdt/FdtPciPcdProducerLib/FdtPciPcdProducerLib.c
+++ b/OvmfPkg/Fdt/FdtPciPcdProducerLib/FdtPciPcdProducerLib.c
@@ -96,6 +96,9 @@ FdtPciPcdProducerLibConstructor (
   RETURN_STATUS        RetStatus;=0D
   UINT64               IoTranslation;=0D
   RETURN_STATUS        PcdStatus;=0D
+  CONST VOID           *PropertyPtr;=0D
+  UINT32               TempLen;=0D
+  BOOLEAN              DisableBusEnumeration;=0D
 =0D
   PciExpressBaseAddress =3D PcdGet64 (PcdPciExpressBaseAddress);=0D
   if (PciExpressBaseAddress !=3D MAX_UINT64) {=0D
@@ -135,7 +138,32 @@ FdtPciPcdProducerLibConstructor (
     if (!EFI_ERROR (Status) && (RegSize =3D=3D 2 * sizeof (UINT64))) {=0D
       PciExpressBaseAddress =3D SwapBytes64 (*Reg);=0D
 =0D
-      PcdStatus =3D PcdSetBoolS (PcdPciDisableBusEnumeration, FALSE);=0D
+      //=0D
+      // If the FDT node has "pci-enum-done", the host (e.g. QEMU) has alr=
eady=0D
+      // run PCI enumeration and BAR allocation; allow PcdPciDisableBusEnu=
meration=0D
+      // to remain as set by the platform. Otherwise force it to FALSE so =
EDK2=0D
+      // performs full PCI enumeration.=0D
+      //=0D
+      PropertyPtr =3D NULL;=0D
+      TempLen     =3D 0;=0D
+      Status      =3D FdtClient->GetNodeProperty (=0D
+                      FdtClient,=0D
+                      Node,=0D
+                      "pci-enum-done",=0D
+                      &PropertyPtr,=0D
+                      &TempLen=0D
+                      );=0D
+=0D
+      DisableBusEnumeration =3D FALSE;=0D
+      if (!EFI_ERROR (Status) && (TempLen > 0)) {=0D
+        DisableBusEnumeration =3D TRUE;=0D
+        DEBUG ((=0D
+          DEBUG_INFO,=0D
+          "  Found pci-enum-done property, disabling full PCI bus enumerat=
ion\n"=0D
+          ));=0D
+      }=0D
+=0D
+      PcdStatus =3D PcdSetBoolS (PcdPciDisableBusEnumeration, DisableBusEn=
umeration);=0D
       ASSERT_RETURN_ERROR (PcdStatus);=0D
 =0D
       IoTranslation =3D 0;=0D
--=20
2.34.1


