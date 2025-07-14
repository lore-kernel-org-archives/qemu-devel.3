Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D78AC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 21:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubR0q-0001Ea-IH; Mon, 14 Jul 2025 17:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubPPV-00054q-9a; Mon, 14 Jul 2025 16:04:28 -0400
Received: from mail-dm6nam11on20617.outbound.protection.outlook.com
 ([2a01:111:f403:2415::617]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubPPS-0005YK-H4; Mon, 14 Jul 2025 16:04:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4WJyrg9s4kusRE3r2QziixllPAJFQ/4oEJwrrO+Q+TxZmpOpyTBxI4Pb2Ni6sOJkwZLKGAhliG0w+2+0Xsjqn9l/w999wgsRuSE7EDbO16YqwTsqrg4GNYMx+itdTE3Z3AZWApb+mdyDpU972Mr1yCas+9HrmciRsUTXJ9mhJLizzlOeVdjHK6uXwsm+iFdSgDWFyi/R6jnQagGy1eTu00LXV31C+Sow5HsHySxpS0fkJgHMo6r15c24qBOWp7sZqHL0xnbB9b1s997p9PoeTMH4PVhvwUew3G8suCl6/XAZmQuJlGXx2wXHgNgfLWlcFIgWz2owDBnFDaWubJL/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwwkF17CGkJ5sgDsBylfOsxCM7auyWXCFkH0FdKj//k=;
 b=fZJHPA8dd8K0s9bKGQlnJR2B/iOAdgXCcVbP343ZD/YpsWlb9ct83jBKkJ2X0vsejNMVrO7P1tse5xpeUQ0OmmTuTgMIe5sdJfy+sazeZvZsuKCyCeA6AUtOdprW9Zerq2Z2UiUwfv5fWUxv3xU4UeNLUxYrVMMrI8Aapo5k2BlhLxCtdpnNCN5LeXjIMji/5KkuonNG3jk/TJCpG/ZEX7YAX2UjDgRbDFvcGYVF8AFkrjYGvfhkuc0rLCbcakyJOVAKq2HM4W4AstWvtpK8bFW32MLbBy+d/bU7Vp7iw5OIIb+caLoVZAsN3g23uIDNH7Yet2/q6hlnGZa5MtpCHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwwkF17CGkJ5sgDsBylfOsxCM7auyWXCFkH0FdKj//k=;
 b=LjyjbP/wfvjXoBtqAK6e9Djwc+bvoeA9IpoZFSUu7DG6vcNDJFHrnmV3Nh/aAmvQN2Gbjw2WzNTQQnEWjBsrS9aizR6pn9jfwsVynaa56aF6oYCMl/DTmZpFQjl+DQIC+Idf2Xgu2PO8K41WoqA4qgrG8qqS9uu8ICQNMNyFslwL8G+kg+SA6+4z6Y14GOLjrX8xkGKH5304/RpsApljUoXxeP8Gp7s2BLcdYgLc03D1xoRBXnMs0S8BFbD/k9FK10iP9+CrlW1TMkZqHVoaJNSIDrmwTtrxsSBH+RMnYlZo6WsClmGlBc8Q1H2GoX1rUvfupYWNlSFx05evu39iHQ==
Received: from MN2PR16CA0048.namprd16.prod.outlook.com (2603:10b6:208:234::17)
 by SJ5PPFDDE56F72B.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Mon, 14 Jul
 2025 20:04:14 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:208:234:cafe::d2) by MN2PR16CA0048.outlook.office365.com
 (2603:10b6:208:234::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Mon,
 14 Jul 2025 20:04:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.1 via Frontend Transport; Mon, 14 Jul 2025 20:04:13 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Jul
 2025 13:04:03 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 14 Jul 2025 13:04:02 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Jul 2025 13:04:01 -0700
Date: Mon, 14 Jul 2025 13:04:00 -0700
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>,
 <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 14/15] Read and validate host SMMUv3 feature bits
Message-ID: <aHVisDScCht0sW8B@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-15-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250714155941.22176-15-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|SJ5PPFDDE56F72B:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb28c24-f472-472f-7612-08ddc3119aeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|7416014|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?pQURFiEoSrAqN5GZ6HiPxI8iggZ2+IUnuKrZjblqwTeXy3xaFREzXdCjm3?=
 =?iso-8859-1?Q?NPJA1UcHZeurP8zktkDdL/N0xFY2JyycPF1GGRdUfYuEH3OVsaE8/PWdo7?=
 =?iso-8859-1?Q?7kI2SGpCgUgSl+jVuqSyC2S+oz+FaO6umhgr4NTEPalCkWPKhT2A4fEC3o?=
 =?iso-8859-1?Q?ZOVoXqGqudLXkwjg9CKIfPc3cPQIshx9ZfeLKh2yBglwNzm8El5vUkjiOq?=
 =?iso-8859-1?Q?4YRjbymNuSXIcayE3zp78kQUQ6y0KRGOpDDrZ3v4IUBPC1iccfTgXircTE?=
 =?iso-8859-1?Q?JYF+mTxndha8f4GEpFirwlcm0fsEgyhufQGadLNisLABt9Ef6FYaBo+/5G?=
 =?iso-8859-1?Q?bM/VvXRSCsP8FGbt2M6lizeJUO94m6nsqymt9pI7TZowRV1IIivICiIp9e?=
 =?iso-8859-1?Q?ucxSVAgdeTUjYt7lGzS5dfom56zMqqQ9CWTquH8vRqqDXmnvDhEIboSuHu?=
 =?iso-8859-1?Q?igFFWn7SRhsaOi1oBifkuVH92A60mBJwd/rPUws8QHR2YJFyTLuUV7INbV?=
 =?iso-8859-1?Q?y/RaySumb1duqaYTum7wX2jGqHZheCq02K5DAzmxm5APRadQwz0LpLBw0n?=
 =?iso-8859-1?Q?DNEG8phOl031uWOhP82E6w23KXYo/vk3mCddWBR1giXZNpDZi52DTa1jKe?=
 =?iso-8859-1?Q?RwBpcES2Liu45iB/SO++KyW1xfD9wqUgVDHZ4gGkB8/8hkL2pa5bclG7P1?=
 =?iso-8859-1?Q?kZDM40uOsBYJ255pd49beBCR3vmE9O+OSgBb2GccsTOuXfxhFOAeUvjpiY?=
 =?iso-8859-1?Q?JDk+nmMG8L2+k+zOSz5Me2sXwmkeUv+IsDqvlCjLpR3/LmM2I90dDlDAAq?=
 =?iso-8859-1?Q?aQzAub8ZxV7S+Y3hGdPy/rI4Ez60VZdlWCBELSH5XidXZuBVTKgyrLWt2k?=
 =?iso-8859-1?Q?RJE46sZ8vPoWlMv+6jyOEX8gbnZqmPk0YugQfVMEX40+XXzcLSuASP39ge?=
 =?iso-8859-1?Q?5B0TJbz9ImyMcGFERUt9Dmelr4R624a7Eh3Gr+IedmxPyK0R/hJX2hH8+x?=
 =?iso-8859-1?Q?1y710FuQx7zValX83zbyzQ9Hisq++v7/3MEPHnimu97DfJZyz5JjaSFbqP?=
 =?iso-8859-1?Q?972Fjd6uW1LhMBUdmCpke74sf2S7gHvISHwWTEWOrGw7avqKwCxuzG92+S?=
 =?iso-8859-1?Q?mZipWC1lgweHQ4VneDCxbaq8Lh3uW8bqnw2lvE31Tts97KQy34NGYkWmev?=
 =?iso-8859-1?Q?BRiYnZVtpxS3DTpVzYn2qFCgp0s6xNa9hNVl7JnHZJD5o0fF2H86eBetcB?=
 =?iso-8859-1?Q?DGrLKS5Cx0dsucEdxizBaBlImWTYnqe/ckRcd5kyAljH0KtdMUUhwWY+Fx?=
 =?iso-8859-1?Q?T5dHaqv9Gc/VkwHC9xRSZB6jCoMtXoLcE6BKtdK3ZI1WQqPqfvX4K7GpJI?=
 =?iso-8859-1?Q?eXq4JS5E1i/9UI2tD6w8CeDr9WM094pFILNhhPKDCQemByQjhnB08HLJjR?=
 =?iso-8859-1?Q?0in2zQP3mD+Idqvp?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 20:04:13.5792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb28c24-f472-472f-7612-08ddc3119aeb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDDE56F72B
Received-SPF: permerror client-ip=2a01:111:f403:2415::617;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Nicolin Chen <nicolinc@nvidia.com>
From:  Nicolin Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jul 14, 2025 at 04:59:40PM +0100, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> Not all fields in the SMMU IDR registers are meaningful for userspace.
> Only the following fields can be used:
> 
>   - IDR0: ST_LEVEL, TERM_MODEL, STALL_MODEL, TTENDIAN, CD2L, ASID16, TTF  
>   - IDR1: SIDSIZE, SSIDSIZE  
>   - IDR3: BBML, RIL  
>   - IDR5: VAX, GRAN64K, GRAN16K, GRAN4K
> 
> Use the relevant fields from these to check whether the host and emulated
> SMMUv3 features are sufficiently aligned to enable accelerated SMMUv3
> support.
> 
> To retrieve this information from the host, at least one vfio-pci device
> must be assigned with "arm-smmuv3,accel=on" usage. Add a check to enforce
> this.
> 
> Note:
> 
> ATS, PASID, and PRI features are currently not supported. Only devices
> that do not require or make use of these features are expected to work.

Can we support ATS/PASID at least? I need to double check intel's
series, but I somehow recall that there is a PASID cap support in
the VFIO level, so VM could actually report ATS/PASID caps?

The invalidation part could forward ATC_INV command too, as kernel
supports that.

Thanks
Nicolin

