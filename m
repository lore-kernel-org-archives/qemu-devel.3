Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C1BC88E7F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 19:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6vFI-0004bT-7V; Wed, 16 Sep 2026 15:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1x6vF8-0004aF-Mz
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 15:24:32 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1x6vF6-0005fg-1f
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 15:24:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fcig+Dc1/sazGumeRjBqccvHDH/3MYNcl3iQoVmgyDXXkEtjIxkf7Mt6J1Hs3qHan9hi1dtcgoXOL1mHtPDzwx3wfKDBKDL8rHJ+9wWCJS3Gf8hf/icnKvsK9PF3sv8PBB6iEANUD+HMpurMA7LEeQmIJAHAFl3lABqwF8Hyk2C4OdHnZ5bpj/C7SnnTSBLENRPugbpSBxY5AGHhSpWI2hsILa7feVVpkjvzz2cKeTh60axof+ehgH5Xs9vQ4QhJsIBoVibJ1gJp+CJACbBXFdmgO2rvhQ4Q5bTMm4FvjDia8+TPDvzvuw42DwLZzQo2gjysCxFqW+sKdzGmVOF7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVjGNgzZu2/AY9mFbmBd00R2d7GS52g/oDXLHRVsqyI=;
 b=ZgMJyzUOUt06JI2Zq/DRb3z3t6R8jbrw6QBn6hAuPV0WgAydjdjPv8/92BDfGB1v1Scjq0YOvalFfsLJQJ2RbtjIGJLGzhVDIVdazwKOTSy1R01LM/KNHjoG8SzQYUIKDfirq+6cj95AtDR96T13N/TV1BzbIAyKtLCYpIGP36L+RSmqrrJYSxH/bX201R5yPH0JF8uwoTLMGZyRd5HYCwIUj5THkl2McjFhwmVnE5xdqm2Wv0cK4Xj5pG8gnqoe+XBbKeyU/PlkMaeBleKnIvejauSAugdx1eOjIERqkLkMFn8nOgTvTm8nkQBGKftmKnJXEhopoWeZjXwHRN9wOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVjGNgzZu2/AY9mFbmBd00R2d7GS52g/oDXLHRVsqyI=;
 b=OwhY5JA4H6NarKusd56Kd9hEVf75LhjTbjg0jDykF8/9KbhlamK/mzRx5Mg9JtMuK95U/WFG3R8dn72mgTM7ivGWTVY6eA149reVAXfu/UQMf2eVmKBBGHKvlJp19+p0QY29xvpaqfHHO6MzoPjZzzOWf//flRgsOqAo/IyTUzwFh/fitOwyzot3oPf5BkqFrQ5zmetrWsQPiPAWEfmqwF/CcRLbxuxWFBzE8J13+v53TOJcvIfTw9Tu2WmPMb1Pzm62mV92aGdLJXvJoOXCELbsQH1cYyon4dti1h3a05b6FPtgoM7YSHBxI1HY+huhttGJvK61juwr3g+pCMqbjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by MW4PR12MB7213.namprd12.prod.outlook.com
 (2603:10b6:303:22a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 19:24:20 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 19:24:20 +0000
From: Tushar Dave <tdave@nvidia.com>
To: devel@edk2.groups.io
Cc: gaoliming@byosoft.com.cn, ardb+tianocore@kernel.org, sami.mujawar@arm.com,
 jiewen.yao@intel.com, kraxel@redhat.com, qemu-devel@nongnu.org,
 alwilliamson@nvidia.com, jgg@nvidia.com, skolothumtho@nvidia.com
Subject: [PATCH 3/3] MdeModulePkg/PciBusDxe: size and program bridge windows
 for fixed BARs
Date: Wed, 16 Sep 2026 14:24:08 -0500
Message-Id: <20260916192408.928411-4-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916192408.928411-1-tdave@nvidia.com>
References: <20260916192408.928411-1-tdave@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::10) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|MW4PR12MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a785daf-0fce-442f-c716-08df14281b83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|3023799007|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: UehSJn+BUrv/e3m5tAF7gkzcjPDaE6hRkRCQyL6iT1z1OH6/WDgn7se+24QhawO7G2kThFGR/9fh8HVftFVgmuTluSQOuzg2GevHgqhkyjIG14p1XuaEKV3GkDLVN28+yyahBYgCzDTRlLyF4lsDdEPPqXIsLNWeL2MtJH/zNUgCT+3fp4JolLV74gDpB80VbjVqiEtg7inxrrCxqtGQzHJY5lCRkoLlqFKkv1rX8xC6znVMAjKlN9j1/UESthiqh/Jy6ZCgq2yBkS7sQcerV1sC2MnjZrwdyDHTVFXW1seQSnxtvoO8O4ReUWdo+Epfl03u1gLzHs4jGqztfDpdsksMraC6aeU0AGbpv1RNaQffItrFIYQ35nZKzdssLDNMl1ihCizVJ3i1UhpQYJ7XNJMMkpmAYHhLoyF7Q5ZYGQhoRZ/t/Zl7xPqg9B6q/VquIh536W7SpJxPeKx06bu+17EI8eFbo/0dw63aHe8denYfFHz2b3CxVKRzmPMGo24uGxgGi+uKZmMcabr6W7VHfnyKcOwVCyR84XVXrlmCvZ+sB7BDMXxJ90UWAc4Tjan7yGR/BTvIDcCal1BP38tm7PPfaNyxLeSPyCU7tXswQO2/beC0/1LcX2A06VuyLWKfBcIqZz5eOzlYb4yqGNwVlNNEBF/J579tF0u+OV52y/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(3023799007)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eGBMH9x5nl3fg0tmjeJjZ1qvzz+yJyyeSh7IM5tm06ARsjqpertSWMqu16xL?=
 =?us-ascii?Q?karPwb4wDxfbmPKiCHf8qVzzx4NDeNFwVvRwTO3JYJkK2+psrXRk156iY8aF?=
 =?us-ascii?Q?C5TJpVbTAW2OcerYfDqJsBhpczQhauKQFR6WGKkFLOE5D9whsSG9QoKBoI1P?=
 =?us-ascii?Q?1J5X+kK04r+Q+UpODuZOkwAtto/HXLQ8ftyuC8e7gKgJLiChJU/4q69/m8ed?=
 =?us-ascii?Q?YLhCy0SG5O1LOi8WU1DFIXhbFrnjyv3fuzgtFB59e04dVGeQog/bEwVQlHx5?=
 =?us-ascii?Q?V0tNzc4wf1XEyseyN4aSPfDKHNiw5LCi+voDjiARcUjkToyqOb0HnEXbg0Z1?=
 =?us-ascii?Q?tySTS8w60WeL93FeA5xb04DNdtzP3pYvCQ6jZznDKbrnu5hFAhxK+w3j0yEy?=
 =?us-ascii?Q?Cgm/GSiqxCirGAfmLQZxttCQIQUHCYQ9jNNs90YG0LC9i5v+NT3dpRwytMaV?=
 =?us-ascii?Q?qXw/1FZx35nJ4WeovhoGjTodaeV7z7/cLNtx+HERCj+sHBNBjHAzliZ0Kvut?=
 =?us-ascii?Q?b+9KFPCufCBagSTSW8ThwrGHbT3Z7mCi6kZcW6drLNHXIinXhYJv9D04R6PW?=
 =?us-ascii?Q?w0vrZOy3KcF0CQ4FYI7rA7vYplt2zJI2aUtEbVYWDBKp4r04psX8pEsjqsF3?=
 =?us-ascii?Q?OJZWNTPObdVPX7S2JNKJME6I/AqU7KmAeLGgGh+3E7b42wzZ6HAoGDXsePx9?=
 =?us-ascii?Q?K1Njt7oD5n4iPSP48oyz38poi5Nbc/9b+1QsvifS+vo3LIMtkBiqvaZ/3Al4?=
 =?us-ascii?Q?7ve73tQRye9VyONYxEpn+Att7D2b3knXQNwCsLcBkxZryTCE1ch0CaqvzBt0?=
 =?us-ascii?Q?tzGazVMj6dcS2ndF8xiIs2sTEIZvDvg75vGkHK8D95Apx9EhcrqpG107hwhb?=
 =?us-ascii?Q?DmuaULCYRD2e322Q9e6npvuSKiIHLOOwujjYfW9223lqnJ4/JtKAUxFG7XuP?=
 =?us-ascii?Q?/5l5KTL8FCvsMd99UkRlY7r+beTY439apeS29d0kSWj06V/7x+Pbmps2SHkS?=
 =?us-ascii?Q?7927+B71ARgxJ1KIiHFjdEVbqQ1oA6R2hXNKSF00l1BnpGlh8p9TS7qANm8a?=
 =?us-ascii?Q?LBlFH7G1iEWtsThaWR/Rh5DA7Mu2vwf5rDd1QaspziZyCU5oLrVIh5Wg8bVA?=
 =?us-ascii?Q?2ENHAz5TAOL5dv5vgy7oVwdo2JPGU5mfIRts6FyPNHLSZNAiyTkPeYKkvb5Y?=
 =?us-ascii?Q?/QMxYTcc1UQxxlfX7o1IZUyvMJ6LcDHVn482ZPgOxivHtrja78pj5sXAcCpD?=
 =?us-ascii?Q?bNR1eJ6oPrgiNHhHsvyTKQ8tLJ1GvbHJPF0kJ8Z4P2HX15gIGDChF/s2Zhev?=
 =?us-ascii?Q?CBWTtBmi/VwIIuDnjAo2U21TyMbH8L0cVjSWi9LOBZi/Q420+mebCmMJBJ9s?=
 =?us-ascii?Q?s4amlHIOiDBBWQhN3zeu2wSC+I6L8AN/ej2RMv7ttBl2h31R1YYF/95ukDRT?=
 =?us-ascii?Q?oAZcer/aZcDXyV8gV5vC4vi3j2MLahwpKgVp1Fqk5yC1Y6aBXRiFlogdr9vf?=
 =?us-ascii?Q?VzeexUpga5NyMgrkK2MMiApiUUX8Yg3OEfiJMsJkqLSHsz8h1xgTL2EY0xhW?=
 =?us-ascii?Q?Aw+zjDzEMbeCCB7oH0jUYguqkxF606rRCoT3XO5+wTDrPVsY9rN6g2HIt1WX?=
 =?us-ascii?Q?Af4mt+NaFrlaOCcrU3fpyRtunQq/Slz8b9s6kPnePWPerFhePeOnoeG7zPeb?=
 =?us-ascii?Q?ueXotKTwi2bE9xL0vY1fnNW7nSFVighMh2nihh0ihoPQnTRj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a785daf-0fce-442f-c716-08df14281b83
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 19:24:20.3264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+xW7pTHiZoFP/xPy1T37U0V/EputmayoIi0yFMK4icqNowenG0fnrRJzeUdMn8bs+nTVWpQ5pXTZDqWFwnl0g==
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

CalculateResourceAperture() sizes a PCI bridge's resource window from
its children's Length and Alignment, without accounting for a fixed
base address assigned to a child BAR by
EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL. As a result, the bridge
window does not cover the fixed BAR, and ProgramPpbApperture()
programs the resource allocator's base instead of the fixed base.

Track Fixed and FixedBase in PCI_RESOURCE_NODE and add
ResourceNodeIsFixed() to identify fixed BARs and bridge windows
inherited from fixed children.

When a bridge has fixed children, CalculateResourceAperture() now
sizes and places the bridge window to cover the union of their fixed
address ranges. Bridges without fixed children retain the existing
behavior.

ProgramPpbApperture() also honors FixedBase when programming the
bridge window, consistent with ProgramBar() for fixed BARs.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 .../Bus/Pci/PciBusDxe/PciResourceSupport.c    | 110 ++++++++++++++++++
 .../Bus/Pci/PciBusDxe/PciResourceSupport.h    |   7 ++
 2 files changed, 117 insertions(+)

diff --git a/MdeModulePkg/Bus/Pci/PciBusDxe/PciResourceSupport.c b/MdeModul=
ePkg/Bus/Pci/PciBusDxe/PciResourceSupport.c
index 169011e647..0aa3465636 100644
--- a/MdeModulePkg/Bus/Pci/PciBusDxe/PciResourceSupport.c
+++ b/MdeModulePkg/Bus/Pci/PciBusDxe/PciResourceSupport.c
@@ -324,6 +324,35 @@ CalculateApertureIo16 (
   Bridge->Length =3D MAX (Bridge->Length, PaddingAperture);=0D
 }=0D
 =0D
+/**=0D
+  Return TRUE, with the fixed base address, if Node must be placed at a=0D
+  specific address instead of anywhere satisfying Length/Alignment. Node i=
s=0D
+  either a BAR marked fixed by IncompatiblePciDeviceSupport, or a=0D
+  child bridge whose own window was already determined to be fixed.=0D
+=0D
+  @param Node        Resource node to check.=0D
+  @param FixedBase   Fixed base address of Node.=0D
+=0D
+  @retval TRUE   Node requires a fixed base address.=0D
+  @retval FALSE  Node has no fixed base address requirement.=0D
+=0D
+**/=0D
+STATIC=0D
+BOOLEAN=0D
+ResourceNodeIsFixed (=0D
+  IN  PCI_RESOURCE_NODE  *Node,=0D
+  OUT UINT64             *FixedBase=0D
+  )=0D
+{=0D
+  if (IS_PCI_BRIDGE (&Node->PciDev->Pci)) {=0D
+    *FixedBase =3D Node->FixedBase;=0D
+    return Node->Fixed;=0D
+  }=0D
+=0D
+  *FixedBase =3D Node->PciDev->PciBar[Node->Bar].FixedBaseAddress;=0D
+  return Node->PciDev->PciBar[Node->Bar].HasFixedBaseAddress;=0D
+}=0D
+=0D
 /**=0D
   This function is used to calculate the resource aperture=0D
   for a given bridge device.=0D
@@ -339,6 +368,10 @@ CalculateResourceAperture (
   UINT64             Aperture[2];=0D
   LIST_ENTRY         *CurrentLink;=0D
   PCI_RESOURCE_NODE  *Node;=0D
+  UINT64             ChildFixedBase;=0D
+  UINT64             FixedMin;=0D
+  UINT64             FixedMax;=0D
+  UINT64             NextFreeAddr;=0D
 =0D
   if (Bridge =3D=3D NULL) {=0D
     return;=0D
@@ -349,6 +382,71 @@ CalculateResourceAperture (
     return;=0D
   }=0D
 =0D
+  //=0D
+  // If at least one child requires a fixed base address, size and place=0D
+  // this bridge's window as the exact union of those addresses instead of=
=0D
+  // packing children by size and alignment alone.=0D
+  //=0D
+  FixedMin =3D MAX_UINT64;=0D
+  FixedMax =3D 0;=0D
+  for ( CurrentLink =3D GetFirstNode (&Bridge->ChildList)=0D
+        ; !IsNull (&Bridge->ChildList, CurrentLink)=0D
+        ; CurrentLink =3D GetNextNode (&Bridge->ChildList, CurrentLink)=0D
+        )=0D
+  {=0D
+    Node =3D RESOURCE_NODE_FROM_LINK (CurrentLink);=0D
+=0D
+    if (ResourceNodeIsFixed (Node, &ChildFixedBase)) {=0D
+      FixedMin =3D MIN (FixedMin, ChildFixedBase);=0D
+      FixedMax =3D MAX (FixedMax, ChildFixedBase + Node->Length);=0D
+    }=0D
+  }=0D
+=0D
+  if (FixedMin < FixedMax) {=0D
+    Bridge->Fixed     =3D TRUE;=0D
+    Bridge->FixedBase =3D FixedMin & ~Bridge->Alignment;=0D
+    NextFreeAddr      =3D FixedMax;=0D
+=0D
+    for ( CurrentLink =3D GetFirstNode (&Bridge->ChildList)=0D
+          ; !IsNull (&Bridge->ChildList, CurrentLink)=0D
+          ; CurrentLink =3D GetNextNode (&Bridge->ChildList, CurrentLink)=
=0D
+          )=0D
+    {=0D
+      Node =3D RESOURCE_NODE_FROM_LINK (CurrentLink);=0D
+=0D
+      if (ResourceNodeIsFixed (Node, &ChildFixedBase)) {=0D
+        Node->Offset =3D ChildFixedBase - Bridge->FixedBase;=0D
+        FixedMax     =3D MAX (FixedMax, Node->Offset + Node->Length + Brid=
ge->FixedBase);=0D
+=0D
+        DEBUG ((DEBUG_INFO,=0D
+                "PciBus: bridge %02x:%02x.%x child %02x:%02x.%x BAR[%d] fi=
xed at 0x%016Lx, length 0x%Lx\n",=0D
+                Bridge->PciDev->BusNumber, Bridge->PciDev->DeviceNumber, B=
ridge->PciDev->FunctionNumber,=0D
+                Node->PciDev->BusNumber, Node->PciDev->DeviceNumber, Node-=
>PciDev->FunctionNumber,=0D
+                Node->Bar, ChildFixedBase, Node->Length));=0D
+      } else {=0D
+        Node->Offset  =3D ALIGN_VALUE (NextFreeAddr - Bridge->FixedBase, N=
ode->Alignment + 1);=0D
+        NextFreeAddr  =3D Bridge->FixedBase + Node->Offset + Node->Length;=
=0D
+      }=0D
+    }=0D
+=0D
+    Bridge->Length =3D ALIGN_VALUE (MAX (FixedMax, NextFreeAddr) - Bridge-=
>FixedBase, Bridge->Alignment + 1);=0D
+=0D
+    DEBUG ((DEBUG_INFO,=0D
+            "PciBus: bridge %02x:%02x.%x fixed window [0x%016Lx, 0x%016Lx]=
\n",=0D
+            Bridge->PciDev->BusNumber, Bridge->PciDev->DeviceNumber, Bridg=
e->PciDev->FunctionNumber,=0D
+            Bridge->FixedBase, Bridge->FixedBase + Bridge->Length - 1));=0D
+=0D
+    CurrentLink =3D Bridge->ChildList.ForwardLink;=0D
+    if (CurrentLink !=3D &Bridge->ChildList) {=0D
+      Node =3D RESOURCE_NODE_FROM_LINK (CurrentLink);=0D
+      if (Node->Alignment > Bridge->Alignment) {=0D
+        Bridge->Alignment =3D Node->Alignment;=0D
+      }=0D
+    }=0D
+=0D
+    return;=0D
+  }=0D
+=0D
   Aperture[PciResUsageTypical] =3D 0;=0D
   Aperture[PciResUsagePadding] =3D 0;=0D
   //=0D
@@ -1468,6 +1566,18 @@ ProgramPpbApperture (
   PciIo   =3D &(Node->PciDev->PciIo);=0D
   Address =3D Base + Node->Offset;=0D
 =0D
+  //=0D
+  // If CalculateResourceAperture() determined this window must cover a=0D
+  // fixed BAR, use its base directly.=0D
+  //=0D
+  if (Node->Fixed) {=0D
+    Address =3D Node->FixedBase;=0D
+    DEBUG ((DEBUG_INFO,=0D
+            "PciBus: bridge %02x:%02x.%x fixed window base 0x%016Lx (GCD 0=
x%016Lx)\n",=0D
+            Node->PciDev->BusNumber, Node->PciDev->DeviceNumber, Node->Pci=
Dev->FunctionNumber,=0D
+            Address, Base + Node->Offset));=0D
+  }=0D
+=0D
   //=0D
   // Indicate the PPB resource has been allocated=0D
   //=0D
diff --git a/MdeModulePkg/Bus/Pci/PciBusDxe/PciResourceSupport.h b/MdeModul=
ePkg/Bus/Pci/PciBusDxe/PciResourceSupport.h
index 148d9503c8..0682237d74 100644
--- a/MdeModulePkg/Bus/Pci/PciBusDxe/PciResourceSupport.h
+++ b/MdeModulePkg/Bus/Pci/PciBusDxe/PciResourceSupport.h
@@ -28,6 +28,13 @@ typedef struct {
   BOOLEAN               Reserved;=0D
   PCI_RESOURCE_USAGE    ResourceUsage;=0D
   BOOLEAN               Virtual;=0D
+=0D
+  //=0D
+  // TRUE if this bridge's aggregate window must be placed at=0D
+  // FixedBase, because it has at least one fixed descendant.=0D
+  //=0D
+  BOOLEAN               Fixed;=0D
+  UINT64                FixedBase;=0D
 } PCI_RESOURCE_NODE;=0D
 =0D
 #define RESOURCE_NODE_FROM_LINK(a) \=0D
--=20
2.34.1


