Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0C9C5DF97
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 00:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzOFk-0000Y3-8X; Wed, 26 Aug 2026 20:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1wzOFi-0000Xb-3m
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 20:45:58 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1wzOFg-00059H-Ju
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 20:45:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jw1SsVJ/8XMhlg571RdG0dDxX3VTF5i4QvczuVx/66KS3dkely6FS4i/oxWvPqCoEbxSPPnA227a4KyAe14ZewDc++nZWF/jluKsQMFFvi+fX6JFaZQOWdOdkJiPB47sJU2JWpClpZ03RZwI6Fy0v1rXVBUd/lGr7L9zqqJijoxqqcQdAH+8tqb9YRAu9oDJQbSinsR+Ec7hy2EbCG3m7cs+/WwdYOME5lHN3ffxDS48N4i7C3DRSE/mkVNrWjtM+ATq8vO3xLITWSnykxmoRMqBnibrii+05AYAZ4f1zGNnuJuvWgXsag1yhZ3xolXmQ1MrDq4d4F6AUzsbtuXmLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrhNdxCcpDjZfs3LXn3N9nS+SmKyHB+Jx+7uRpjzNBA=;
 b=f7QiQJrplonCLltkLCeDJF8rFCRHLXtFBThObNs0+K4hSxJmh1okmNgPVjYy5TKuwVKbULQ+tZxnk3ASBl5rKrYmrgt2StIuh5QQ8y9QOLkZ3nqIYNtyLN5qIIt1haYuySYFo6h9/Hgo6koE78J55x3y8xzy7UdwKprW5VtyK61HVfvNf6QRY/wtnYn/qUhzWY4jYhAnb1f7i1GHO0F9JSdt4NOLe+4qG+/4qxQwzXnmhtAnGQJh2Glm0mzF86GD0B4iRCNUDNzy7MuQjY+oXROAjSdx0tLhPMbzafpW+nsnH937n9ewTtMFOZHXxdJ4p43PCwwyZHfwuz4tbkbgeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrhNdxCcpDjZfs3LXn3N9nS+SmKyHB+Jx+7uRpjzNBA=;
 b=JrLJ9sR6JqiClyMv9F6hXhLdvuPXn3lAhPkCoofa9VJqwmb4vrl7OlP7J+L7Kgy1WaUj9XHfrWXk/Sba5LnkM5zqRvIrN4wkPs71L5MweLnZAYpzIL7EQIEe9z3WhfJwTy+XPcUV89fULCAuHr802NM3MN+0KDbrfE5fIjxsjchc1mYBCqCS1vH6kibX/pRbivnzZWEhHVPONeCD8XH7Xx763mkooZ4ov6QJhEN6yvQQAWtO2M6dExEAgRUTIpNHtxXl1ziS68P5LI5mS/m5uPR2Q367Lww9gwbnMVSjsJRhbviIuOYRdv0CAz3btPipEecWX83nke5UdexyXCsNTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB9736.namprd12.prod.outlook.com (2603:10b6:8:225::9) by
 MN2PR12MB4221.namprd12.prod.outlook.com (2603:10b6:208:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 00:45:50 +0000
Received: from DM4PR12MB9736.namprd12.prod.outlook.com
 ([fe80::ed33:f342:886b:dc8e]) by DM4PR12MB9736.namprd12.prod.outlook.com
 ([fe80::ed33:f342:886b:dc8e%6]) with mapi id 15.21.0360.006; Thu, 27 Aug 2026
 00:45:50 +0000
From: Tushar Dave <tdave@nvidia.com>
To: devel@edk2.groups.io
Cc: gaoliming@byosoft.com.cn, ardb+tianocore@kernel.org, sami.mujawar@arm.com,
 jiewen.yao@intel.com, kraxel@redhat.com, qemu-devel@nongnu.org,
 alwilliamson@nvidia.com, jgg@nvidia.com, skolothumtho@nvidia.com
Subject: [RFC PATCH v2 1/2] MdeModulePkg/PciBusDxe: honor fixed BAR addresses
 from IncompatiblePci
Date: Wed, 26 Aug 2026 19:45:29 -0500
Message-Id: <20260827004530.600410-2-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827004530.600410-1-tdave@nvidia.com>
References: <20260827004530.600410-1-tdave@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0043.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::11) To DM4PR12MB9736.namprd12.prod.outlook.com
 (2603:10b6:8:225::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB9736:EE_|MN2PR12MB4221:EE_
X-MS-Office365-Filtering-Correlation-Id: 7899b77d-d40b-4641-2563-08df03d48ad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|56012099006|10067099003|3023799007|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: MDDDruRbiWvBX6mtxqmD6gpw2xi5l6pkuRfeCJ2aPNWBWrxH0PPI2qaKM+0Shr2pCCVBLKJYJ5f4ke+NDjdSGVWHAOKy/pZEUhQZ5aS3UtYXwqah/EAc0mVqO1wR6PSGX4K1rhgzWa9Xt1E83GNHRnLbbzbXYaTUXTkewAKgrnpIMpA7a3TpD3/7se/Qs/RGDYZ5Je+7q5euIJJ+IGzxin8kHd6aphK09vimGnCQwL4kxFhOTx7tXRpNjCqO+IIsjykAsCroKgvXk4GyG1351Y8JtCvZdejt5LK8aB0IkntV8Kf26y9j1PvOYbbYu9ifI+k+jgmVC26qHM4O65pbGnSPahbepb/L6Wck425aIPjZ9hxLthpNQ781HttkzKECX+/LDCZlMRfCU0RheefbKWvUcftoTTg18FQwU+Br9BwM9R3cKTFXyTijobvJyrNFxybTOljuwq6dM+HDJrqNNA/zFYihdtOrd13TL8gP+PIdSbjWHhI/2HhbfeBVcbEX/VUcqY/gsLKxxAk0Grqf4/cQ0qiZ1rQMNsLqTz+36HBTjW3Yc4Ik/AnipbAbRHZ7pFYG5P46v3bb2A0CgQar0midGDCCbN3OAvvfvEt7RtrXvWMZXelUjNMtr6uAwxC78Ej6C9ln2Qsxuti0E0cC2kdNtIjJ1ci89lV9O7L2vDk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB9736.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(10067099003)(3023799007)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O3tK1iRr9UNN+836bsfgK0swP0oK7QRuTeGDx3ospcj+UtJpB26L0eXIJDhX?=
 =?us-ascii?Q?Weh2fNX7CriZgRMQ35PfbwtS/CR6XwlmS+svSMIS3CDm3f3hDsJhfswKX8h8?=
 =?us-ascii?Q?D/yArGXhIqf8G3UAedxEeetD1J0uo+nnAgqXHybDwnP/tphCjVyjAGcSbEFc?=
 =?us-ascii?Q?lV6QNVlKGlelmlubpv61ngaIdVB6mdVCI7Keuc6aRMOw+hupA8fylEuRWQV7?=
 =?us-ascii?Q?YC4M5MGqu2c3y5BmGBbkpXpJ8woAjwsF4rGL7Tya3ARli3fNq+hRIEZ29gxd?=
 =?us-ascii?Q?oDN1Scof9VFH2CY5NT7rFvZBQs1R8xiWBiWcAa6ofKJFnXh5vWfMPs8j1riM?=
 =?us-ascii?Q?xww+xxNGWmfSx3Bw9WV5gJ3P7E4K/W3j9S693dC+xzWo7a8dG2+imR6weaK7?=
 =?us-ascii?Q?FnWiy5tiZV9dp18EakGStqFVlxIAWT1bVBVAZNKLRi09lGqHOzGlrzufdSPD?=
 =?us-ascii?Q?xM8Ps2uJT9BobKviCQa/hrRoLdqwsoEEtlxU8MsGyui8dPg3+FZhEDDMfxIa?=
 =?us-ascii?Q?uIS+uYwkfjwPickRjin1mSBuqjSqcCFMgc2cWwOmk5Nz9i2/ZELKppAsYiro?=
 =?us-ascii?Q?pw4UJuUJCU/NdzZRHbtv05z0XmGcS1bnaoGK61fP6+j39PfW025Wt6MPTNpa?=
 =?us-ascii?Q?OkTZ5U+Cg+AHuEV8xYyOq/ruR5h1j44CepICDhxcfZccUa/SF+2m/1qGiZfD?=
 =?us-ascii?Q?srbbiv5rx85yVD73wceNSI3JbnH1qz3XlAkAuye4ovIyFHDJtEjjUycEd8bA?=
 =?us-ascii?Q?JpFj2AfXfJKBsyfmOloG3Hy+yUEhl9/5f4cEYJ/d5PPT3tCNoxzdNQr9FLs2?=
 =?us-ascii?Q?rA52fLP5Yn/6NtIDgqkjzFwPU/ngjIktU2AyMndn/yH0pavdZNqDzHDohY1S?=
 =?us-ascii?Q?PBvL0LwF8cxveYhHcYT2lwZL6WmCCTU7zff1J2Id+/6akGmd8k1zsxhgYE+V?=
 =?us-ascii?Q?NibvdzgSvX5h9LI72bShlGOQqK56nf3wLPXxlAuoMZNuKC2Zea57jpILu5m4?=
 =?us-ascii?Q?xUBUDzkbSsiLWC1k7b5dEtJR+D7Gbz3nn9Ok8pRZNRrCyqU7EM4OR88Ar0TZ?=
 =?us-ascii?Q?a3ZA4Ehyb/FcUjwknSQdjvK+YxySdpTjHmDaVe/JJWG4LQgjUfVXtTwOqEJh?=
 =?us-ascii?Q?RyALuc5mLuXL41JjX75kTG76d6E0AYFNImWYYb9gpKnYkXd/VAANM4McQZ/+?=
 =?us-ascii?Q?I9KPbW1y4GgwKTEGDDRanNP/RhPyuOdkumF9QleewXxfG7qYLS4BiGbplrSY?=
 =?us-ascii?Q?faKWBkOx4HGSojNz2uHsRz5u+S5rBfa8zDQHLZ2cVg8ONNP7emCF64bQJF8H?=
 =?us-ascii?Q?EL7afc3tWMnrGQ5/TPSm9NJ/dwbkLwXICiKxDGlEHgmkZhOvajXpZ5ElIGIw?=
 =?us-ascii?Q?HUpuWyKNwdU9VVvvjBWKsegknwRRtb8J5LNM0lGLkQ5z90HeukSX3BMPWMr4?=
 =?us-ascii?Q?JUWqWJxpMkb8f8QrF6n19WVrdr+bU1tMiNXIAcFWv4Xa8zduLMKPzFBDuI9v?=
 =?us-ascii?Q?yKtd8kndbaX1+OPWBRbT1O/vbNpdY4tCl+ZN4HyfCVOim7oVWK0wl89sJjdd?=
 =?us-ascii?Q?vtc/OOlWoACOsA72EhTPthHxZXhuTZpaYJjVEV62YZ8V8ub4jPk9KVKFbYK6?=
 =?us-ascii?Q?PSdxyakDS3PrKYLVbx4FBPiTFmC9sxMXGGrhMlLPTXoQGpNn4TWJiidQbpJ5?=
 =?us-ascii?Q?9XCeP7TABML1aqir00I5FQ59WjJJ8GjhaKpEJkHRi8fwwqKi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7899b77d-d40b-4641-2563-08df03d48ad2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 00:45:50.7845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7JKBEb64r7aeIPPDfGhx38lPbEgzgVNLykMwZsgFB3SQPtMkwCFjwTKfhVIUVWzuk/LBsFOqHFCiBp7EyrfAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=tdave@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL returns ACPI address
descriptors describing PCI resource requirements. When both _MIF (BIT2)
and _MAF (BIT3) are set in the descriptor's GenFlag, the descriptor
represents a fixed address range.

Extend PCI_BAR with FixedBaseAddress and update the PCI bus driver to
preserve and use this information:

  * UpdatePciInfo() detects _MIF|_MAF, records AddrRangeMin as
    FixedBaseAddress, and marks the BAR as fixed.

  * ProgramBar() programs FixedBaseAddress into the BAR register instead
    of the resource allocator selected address for fixed BARs.

No functional change occurs unless a platform driver supplies fixed BAR
descriptors through EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 MdeModulePkg/Bus/Pci/PciBusDxe/PciBus.h             |  1 +
 .../Bus/Pci/PciBusDxe/PciEnumeratorSupport.c        | 12 ++++++++++++
 MdeModulePkg/Bus/Pci/PciBusDxe/PciResourceSupport.c | 13 +++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/MdeModulePkg/Bus/Pci/PciBusDxe/PciBus.h b/MdeModulePkg/Bus/Pci=
/PciBusDxe/PciBus.h
index 01bce28b1b..4edf45119f 100644
--- a/MdeModulePkg/Bus/Pci/PciBusDxe/PciBus.h
+++ b/MdeModulePkg/Bus/Pci/PciBusDxe/PciBus.h
@@ -96,6 +96,7 @@ struct _PCI_BAR {
   UINT64          Alignment;=0D
   PCI_BAR_TYPE    BarType;=0D
   BOOLEAN         BarTypeFixed;=0D
+  UINT64          FixedBaseAddress;=0D
   UINT16          Offset;=0D
 };=0D
 =0D
diff --git a/MdeModulePkg/Bus/Pci/PciBusDxe/PciEnumeratorSupport.c b/MdeMod=
ulePkg/Bus/Pci/PciBusDxe/PciEnumeratorSupport.c
index ae94462f60..da16355d9f 100644
--- a/MdeModulePkg/Bus/Pci/PciBusDxe/PciEnumeratorSupport.c
+++ b/MdeModulePkg/Bus/Pci/PciBusDxe/PciEnumeratorSupport.c
@@ -1638,6 +1638,18 @@ UpdatePciInfo (
         if (Ptr->AddrLen !=3D 0) {=0D
           PciIoDevice->PciBar[BarIndex].Length =3D Ptr->AddrLen;=0D
         }=0D
+=0D
+        //=0D
+        // When both _MIF (BIT2) and _MAF (BIT3) are set in GenFlag the=0D
+        // descriptor carries a fixed base address in AddrRangeMin.=0D
+        //=0D
+        if ((Ptr->GenFlag & (BIT2 | BIT3)) =3D=3D (BIT2 | BIT3)) {=0D
+          PciIoDevice->PciBar[BarIndex].BarTypeFixed     =3D TRUE;=0D
+          PciIoDevice->PciBar[BarIndex].FixedBaseAddress =3D Ptr->AddrRang=
eMin;=0D
+          DEBUG ((DEBUG_INFO,=0D
+                  "PciBus: UpdatePciInfo BAR[%u] fixed address=3D0x%016Lx\=
n",=0D
+                  (UINT32)BarIndex, Ptr->AddrRangeMin));=0D
+        }=0D
       }=0D
     }=0D
 =0D
diff --git a/MdeModulePkg/Bus/Pci/PciBusDxe/PciResourceSupport.c b/MdeModul=
ePkg/Bus/Pci/PciBusDxe/PciResourceSupport.c
index 8f3cff3eaa..5cc3ae797d 100644
--- a/MdeModulePkg/Bus/Pci/PciBusDxe/PciResourceSupport.c
+++ b/MdeModulePkg/Bus/Pci/PciBusDxe/PciResourceSupport.c
@@ -1276,6 +1276,19 @@ ProgramBar (
 =0D
   Address =3D Base + Node->Offset;=0D
 =0D
+  //=0D
+  // If EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL supplied a fixed=0D
+  // base address (_MIF|_MAF in the ACPI descriptor), use it directly.=0D
+  //=0D
+  if (Node->PciDev->PciBar[Node->Bar].BarTypeFixed &&=0D
+      (Node->PciDev->PciBar[Node->Bar].FixedBaseAddress !=3D 0))=0D
+  {=0D
+    Address =3D Node->PciDev->PciBar[Node->Bar].FixedBaseAddress;=0D
+    DEBUG ((DEBUG_INFO,=0D
+            "PciBus: BAR[%d] fixed address 0x%016Lx (GCD 0x%016Lx)\n",=0D
+            Node->Bar, Address, Base + Node->Offset));=0D
+  }=0D
+=0D
   //=0D
   // Indicate pci bus driver has allocated=0D
   // resource for this device=0D
--=20
2.34.1


