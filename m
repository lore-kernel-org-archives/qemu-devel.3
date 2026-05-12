Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EBBCD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 19:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMsu8-0004eB-RV; Tue, 12 May 2026 15:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wMstu-0004bz-8L; Tue, 12 May 2026 15:36:18 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wMstq-0005nm-JJ; Tue, 12 May 2026 15:36:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CU8E3dC8T41oDabdmDPFjHXmudJ+KYVClMg5XV3s3Cs8BFkmuu8W3OkFPpKr1SIYgRw4YBV9GPnuY+CVrrP1nB4e2EF63O2Kz3ki6nEKhsm4vpTEcN4uqKftqRnzhSQa/519rcDPCMVOlDQy30EJsw+bln+4bLDfiUEIJn/T1Jpp9J6FOVTN8URf0ANEY8+IXLndKv3fMxrDvAQcCwIFKwnivakvNa5CqyOF834AceqYsQ1hxKuTdxegC0C6yB2Xkx0e3d5zJdOe1lpglHnnolkaT3GIDdvTcxTlmaTwQ1vCDie9j/3cmeo6bTOsO50bBmF9qpTElPJ1zXjZ7rjhhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGxbxabj2Jly4mv/AmoyzXxYv89Sk3O+crHoQQ32ew4=;
 b=Tva5GLiOI6KOZk4bkYeYEpQAlBRZQ11+zXLYdeqacTROtnEN+J9ppABv2mCB9lWMMj2SirJXVORlLQYU+9hzDBplPG3il0tlJIZgOl6MavZ+BFTKAu06KXMAjy56Rf/edvJCx0LYBRZrOO6kTDUaGeq4tbV4/mcAExakiN7AsB4nd/J1b+nVXxx7MVZDzHpqHRn4P7JRA3Y+W0HkKg4hswlroqz5rDSto0Q216g9bToIWSpQ5obxEaPrTMx3zsyrION337ZJRX4ZC2WwX6mBzotjDKPqjQ0ziMCaeOOg8Fssnt/MAeE3cW1HUiVk2Ra6Em1Cqne6E8+ZbbkFbBla8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGxbxabj2Jly4mv/AmoyzXxYv89Sk3O+crHoQQ32ew4=;
 b=UePxnA8LdtxWNcj6ycUKAmIq0UPIxtytt6HHPDUertLx6+BRyr5SeTnio0q0jOV1T/DPvL+L1xHhb5BSiqk/lWppWYHvyIrh3tI3wigswxsBO8JfLmpuNkmAqlA/Cdu7oRARDJLR5TF9J8kYF/F+zQMiHIdGtzoPuAE2oViZXU383BRB78ENLbxNvYb/u70aXCNX/o0pMns2KsRlj+yXrcZWUgJkR33jHO+VjwtdGc6NeioS8jzLD7kw5/8IjYc6ry3iBMXAuQ2F5+eQMd9f0+MLTgxkKTLzFmVKWkfdP0+PnMaybWPFDB+0XozTlZpxokFzNThDlTSc2vTY5f/B9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.23; Tue, 12 May 2026 19:35:54 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 19:35:54 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v3 7/7] qemu-options.hx: Support "auto" for accel SMMUv3
 properties
Date: Tue, 12 May 2026 12:35:20 -0700
Message-ID: <20260512193520.3109172-8-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512193520.3109172-1-nathanc@nvidia.com>
References: <20260512193520.3109172-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::30) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 909289b1-e915-4bb7-e2b3-08deb05dae7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799003|3023799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZNJMXi8RDlI9QM0eojs2XGCpgv5GhIEPQRaU/QOdA/3qJJSbyyYMdaEy5uo6ySjxlddyLxdtxHwXoqYfF16RXyj8XtLFQQDwTftYRFimszhf9Ow9GzQUhiJnC1KxS3v5njqKE/MzjsjvjOILgq3mpKTKlM2/ST5+J1dIFiRFUe4PORphsW6xFwYcNBIxQP1vSb07PUeGf74yRa6r76ioEkL33NNnoLVM35zZd14I7pR4mdMqUDSKe8DQNkwnuiKTw0CvfkQVEY5a3xnw6D3D797wif22x983U5b9xwVVZ6GrHz/jsPWH6Fzm78kM9e0kq9KG0VmhRz5Jc3GRfLIcU16biQ5O6oJvEy13kFN93mCNyXWAHblaX9Y93U2se1UWPaZ2ho5SK2w5runAM8ALPrdjA1n+UsYN76KEEuIZk1p7zjfeCn1KMHo4RqaIpyhbTlJEnGdTgWF6HfoM4wehG1OBOpEaqa+IJGMMQ1opNPntreOmONX8Lzdw/EZROP2IjataDLw+9ch0HV7amrXOS7wEJIbbWtZUpbIFVbJ/7eLbTrzXl7XjH4PGtn6ZInwMlkdSMFSrzh8rwhEXNV9muv1aGcDDeoDB81rm9AGAY+j7NZ3VHm8ELplMFmtmgNfub407bJgHNhDqU3+xfPZkJ4i6dcIC3IFFq4L3xG/Oad6hM6hHh9/K07MlwtdzoSEh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799003)(3023799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bSASpjXtMyrKZGMjR55u6w4p6I8eNZu0WHBGBFPtNJ3pTUoyppFyF7y2ukgH?=
 =?us-ascii?Q?Xb1ouvWu1E2lTZBnR5hWj4e8fA6CN6wFSkJpyCJFYObEsGPdyu9D2twRdcHg?=
 =?us-ascii?Q?0B4XMV9NOU4d3uhLTzIsPGghhpJ5sF/fWndlivas5CebWmfp4FXiXvzmdwN7?=
 =?us-ascii?Q?qZDubtuY9Q7y/IDaT2f6p12/oYQmLqJvH8TSsxZ9oX2JAsf5aV0dANlnqkcD?=
 =?us-ascii?Q?OMHJ0dO8Cvo5/Krfvt5j7SUmEHyKH06IWJ7o3EObP7RNLtLz9CguKH8vV9dr?=
 =?us-ascii?Q?az9Uota9nsjA0kYva6MDho1ShqmlZoPp7/HD30Fi4O41RWUu+YvTnNliRBKL?=
 =?us-ascii?Q?yqgdF6xCkLudJmSaS7K9yTM+2UqJAkxFMzdtsA+a5JFwOQxAoWe4zTfjps74?=
 =?us-ascii?Q?nZ+22ZuUhzqtRHaMQNftLOomX0Gc4cZTbeasN1uigFyYFjahNhPb6e2TF9+o?=
 =?us-ascii?Q?+ngTVfQ6YscVk9KHvBTWEqF6/TahkqSCv6t55+8jB/wY9AUZ3hjR8DNaJ/cD?=
 =?us-ascii?Q?9VwyuPpY0rbf/rTThFOC8ziSA+hH7mQUlIPMZtTBwt8A+jTFNYNLBk8Xu7ef?=
 =?us-ascii?Q?pnrE0A2LMbRJJzqjg1NguusFbz8K9GOTigBJCX/6BsXia9qfSVtZEqkCpuhT?=
 =?us-ascii?Q?0LBMNgfiurh8u+YtjCOqgUs+g9nAIXZaLyb5JW4l7VJvygmJOiYFamp9MO02?=
 =?us-ascii?Q?KBEBsUiwG1lgxBKcEqJk8clgjLLivqJ6l029zaV2rlkUVMQYkO/qcbZLrP81?=
 =?us-ascii?Q?p4ZcTDRTbCd+6+qE8eZwWmECssLvWJwUnAAhpVJOK7XvsXndIFfBKQRVhayM?=
 =?us-ascii?Q?rcKhPF6h9nxjZFlId+rr4oeEBWfCrgZ/I5MRpL+CNIm6SdXaBewNX06+Yr8W?=
 =?us-ascii?Q?YVWZkQCehYiSOjD94mQTONSnv6dnyC30qz5PdJU3QuNa95h0VtmS3NzLlIsZ?=
 =?us-ascii?Q?BwJANKfhQ+/kMVLkPewkECT4nyNZSwocxlTliCO0Y4DdtKG3vc99vhPLvhYv?=
 =?us-ascii?Q?bbFxE1HgPgrOUZggwGwpOTTmUIuO+4MbbQw/mtMpxypqNyTxUuzsVNGkt1dY?=
 =?us-ascii?Q?J9cwBeazmWsB0YA8ML5/kIDLssZ3y5ziPz4Bww3qiJa87RbPtL6H6RVaEjsU?=
 =?us-ascii?Q?coQufrTduy6gn3P2Y2JFBir3ekGjJL9T3zgaSvHVjlc1TN3+talN/Ge1Vw9v?=
 =?us-ascii?Q?rN/c5anXK91bfRQveFgVO4CyspM0XL1aMUmRPJ2lIpQwLvKb5ZX24jj2NX7X?=
 =?us-ascii?Q?D9XDf4Hht9NvQd6kLq/8jmrDE+7n+bVaQJo6eoKau/QAM/Y1WRX8QepG4r8H?=
 =?us-ascii?Q?ejZwAjAht7KboTj6USTacH5/ohwYzip10Fk6ckyj9GVp1RhDBfNu4JN+Y4bO?=
 =?us-ascii?Q?I4K4xAb1yZpDwxuxvxx8QrSaQa1rVbISFx6gfziK0OecCwBkRUCm1x/npf0V?=
 =?us-ascii?Q?8x1aq/uaJS57V47P01U1HliR8MzPeWz5VD/ErYf6pbGjLML0OAkiW6uQqTz+?=
 =?us-ascii?Q?ctf2HGQamvdAfujPX8l5Yn805WxSJqeGUe/kAfR9RiX1ztcWo3tp2UYG0EII?=
 =?us-ascii?Q?+wJiTcbrRs9GChjrTGAapE4PWf6OM/Uhy0ePb/vv0PNePtdRkMoWG5ytV7j9?=
 =?us-ascii?Q?IbirTA4MUv0CBneNK4ZwnFoyKdxG4FcI0qeDJATO+IBkz94zcuv3a9gdfP9P?=
 =?us-ascii?Q?lfl1RheGn27qPsOT5xp+/fHrnbEmq/j/4yNFNMltvDe9Yodm2/XvsCae6/fI?=
 =?us-ascii?Q?ZtiwsRSo1w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 909289b1-e915-4bb7-e2b3-08deb05dae7f
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 19:35:54.0656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCK4NCfgOkHG/s9o1tZq57uF8h9HhARv8k1y/uuODK/pYzwZDBeXZZ2FpXtPU70FW1a13QbU3sVNpLPtk53u3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=nathanc@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Nathan Chen <nathanc@nvidia.com>

Update documentation now that "auto" is supported for accelerated SMMUv3
properties.

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 qemu-options.hx | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 96ae41f787..46b02a1bb3 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1291,30 +1291,43 @@ SRST
         Enabling accel configures the host SMMUv3 in nested mode to support
         vfio-pci passthrough.
 
-     The following options are available when accel=on.
-     Note: 'auto' mode is not currently supported.
+     The following options will be set to auto by default if not manually
+     set. When accel=on and these properties are set to auto, the value is
+     derived from the host SMMUv3 capabilities via IOMMU_GET_HW_INFO. With
+     accel=on, this requires at least one cold-plugged vfio-pci device; if
+     none is present at machine init, QEMU will abort.
 
-    ``ril=on|off`` (default: on)
+     If accel=off, auto values resolve to the non-accel defaults given below.
+
+    ``ril=on|off|auto`` (default: auto)
         Support for Range Invalidation, which allows the SMMUv3 driver to
         invalidate TLB entries for a range of IOVAs at once instead of issuing
         separate commands to invalidate each page. Must match with host SMMUv3
         Range Invalidation support.
+        - With accel=on, auto means the value is automatically derived from the host SMMU.
+        - With accel=off, auto is resolved to 'on'.
 
-    ``ats=on|off`` (default: off)
+    ``ats=on|off|auto`` (default: auto)
         Support for Address Translation Services, which enables PCIe devices to
         cache address translations in their local TLB and reduce latency. Host
         SMMUv3 must support ATS in order to enable this feature for the vIOMMU.
+        - With accel=on, auto means the value is automatically derived from the host SMMU.
+        - With accel=off, auto is resolved to 'off'.
 
-    ``oas=val`` (supported values are 44 and 48. default: 44)
+    ``oas=val|auto`` (supported values are 44 and 48. default: auto)
         Sets the Output Address Size in bits. The value set here must be less
         than or equal to the host SMMUv3's supported OAS, so that the
         intermediate physical addresses (IPA) consumed by host SMMU for stage-2
         translation do not exceed the host's max supported IPA size.
+        - With accel=on, auto means the value is automatically derived from the host SMMU.
+        - With accel=off, auto is resolved to 44.
 
-    ``ssidsize=val`` (val between 0 and 20. default: 0)
+    ``ssidsize=val|auto`` (val between 0 and 20. default: auto)
         Sets the Substream ID size in bits. When set to a non-zero value,
         PASID capability is advertised to the vIOMMU and accelerated use cases
         such as Shared Virtual Addressing (SVA) are supported.
+        - With accel=on, auto means the value is automatically derived from the host SMMU.
+        - With accel=off, auto is resolved to 0.
 
 ``-device amd-iommu[,option=...]``
     Enables emulation of an AMD-Vi I/O Memory Management Unit (IOMMU).
-- 
2.43.0


