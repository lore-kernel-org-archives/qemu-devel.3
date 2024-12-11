Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEB2E7717F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 01:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLBWq-00085c-Hx; Tue, 10 Dec 2024 20:28:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tLBWo-00084w-41; Tue, 10 Dec 2024 20:28:38 -0500
Received: from mail-dm6nam04on20624.outbound.protection.outlook.com
 ([2a01:111:f403:2409::624]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tLBWm-0005hM-58; Tue, 10 Dec 2024 20:28:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ef1TIq8Dn/OIuVvX3jrmw9gKikkuRmdetUD34iO+iPZAVWEOE1CnSQrEPRCzx0cHiljdB/6aY8lnl7g6jw3Rv1pqqjtpoHNZ5F5oJ7Y/gshqDKUIV148OZIYY8JpVseNem2gwE7ATQveM62wKgezeSvoaqYBXLVLS55CWi9ZbzifvgxE9yX+dx+fHVdvMJOxCbArkD9nsNmkAlPMyBs4XssukDAKHZOULhaS6TzLlAUEel7oVkF5f5MTYQ/qeSHDzYUeTvKpm4toX51nXctc9ZL8h4vmq1fNXcCa3RJ1KuMyx3cOr+x/YY9WDUOVtyAPqhzvRtLXi5sQzn4ra3Doeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHs6YJQrRGlRXkWl5SSXDpG7tF+DYJQtjP+o33Bydd4=;
 b=NqVWdV3A3ze7VJbsfG9C7+yiFMerQ4o/TH2ecNDBKTYpcD9nGxGZ5meSqde2AadmNFopRw/jQ+47qqSBLcyg5iCg+1qqN9uS4SyHL2KT73Vyz1P56TCtp9YoLNmIDCBZWBAK/gvF1OOTywziKgWZ9w8+wbceEtj5PfftJNcxuFBiXr/fUeSPYXWkaO5MvE1FNr+fgom9cv+sAJmIgcnM/YgPFyxZrqMdkyUbn8yLQKc8/1Ew6JS+8Bc9xPpqzjBPImjG7htrMy6xCurOwyeuRW2C2POMtmB/r8KEKMx/5m30LFlJuukD/EBfbfabJ+DrrAnWhK7IVtSk6NGNjRp4Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHs6YJQrRGlRXkWl5SSXDpG7tF+DYJQtjP+o33Bydd4=;
 b=UaarenmaY9RbTvzltz8Oz8U8UWY7WotHhu4BdFdxG2UY2dyG6BTCPdXPGzUSxlSUy+C0hdxUcL3uiC7CEmnbDYwyGySXb/YMQrVliYGow5BN2t4SMoyIMn+Q3YR3mr5w+czmmPmk2t2j/pXLOy34teb+9D6I8m0+KF/8WijcCYn0z+zdqFjs/Mae246III/0EjV1HaWEKu5+UJDxuag+Z8IBgvT8ZOPepu6Fkio9QVzwG9xTcuPQZ67o2cwKAOpbayECZx7SIcUpx8H5embcLIyX02UVF5xbmCtDofESS0qkFTBlaHk74w9vVtxyktp8PkMJWh5At8uz63K4nfhg8g==
Received: from SA0PR11CA0193.namprd11.prod.outlook.com (2603:10b6:806:1bc::18)
 by CH3PR12MB9217.namprd12.prod.outlook.com (2603:10b6:610:195::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 01:28:28 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:806:1bc:cafe::b2) by SA0PR11CA0193.outlook.office365.com
 (2603:10b6:806:1bc::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Wed,
 11 Dec 2024 01:28:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 01:28:28 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Dec
 2024 17:28:19 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 10 Dec 2024 17:28:19 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 10 Dec 2024 17:28:18 -0800
Date: Tue, 10 Dec 2024 17:28:17 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <eric.auger@redhat.com>, <ddutile@redhat.com>, Shameer Kolothum
 <shameerali.kolothum.thodi@huawei.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>, <linuxarm@huawei.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH 5/5] hw/arm/virt-acpi-build: Add IORT RMR regions to
 handle MSI nested binding
Message-ID: <Z1jqsVTiMwW/Zk5z@Asurada-Nvidia>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-6-shameerali.kolothum.thodi@huawei.com>
 <Z1jIXHmFcBFIUeKn@Asurada-Nvidia>
 <20241211004821.GM2347147@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241211004821.GM2347147@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|CH3PR12MB9217:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ccc427a-281c-4802-564b-08dd19831d9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UgnmVd1CaxnOzDc/SNsIw8dIISqZwjy9yPLC0l6TJBzycjPtsBCDsLAChuUN?=
 =?us-ascii?Q?3q2mdzst3f5LCSNUvlm76qkmdzBoO6LLa/6JMPTp5XgrpREqwfljUDh0mPX0?=
 =?us-ascii?Q?PS2owJmTvS+YOUolYEHr53fYmc1Mc7YzYNJPywilTLu/ENJxkU1QElDbAZVp?=
 =?us-ascii?Q?nKRR/qq6o3v3prWQzWbfEzsCs06x6Tr6VIt/w2ZhOHyv5L4HUDBoPOnwwNhp?=
 =?us-ascii?Q?w7Vx3SKex9WLAQOG8OJglT5jftCeBN9z548fq2PkDzrnqg7LKBYHv2kjdfMZ?=
 =?us-ascii?Q?WkJoTvd0dcCJ+yhZkjJ0vXwOgd4lYqJtsRDWBNEF7KnPGj1cDeY1XHaT6zWo?=
 =?us-ascii?Q?HyFJ7ZR3ihvII7SsotIQowylyED9bkQJ9bb4Gu7kvkswMuYyz8WZSLcYCMlm?=
 =?us-ascii?Q?D7s1DdD4RYCrBbK5/tTKQ+sJq2MmenbktC8yzq94bIs5hk6iOlPz6ONuEOvF?=
 =?us-ascii?Q?ffN6o/6XHkWHxmadoftROCIAvljrmwzBzMDkMAi2DERJyFiS9gdWhjwaPKDg?=
 =?us-ascii?Q?C2yff7Q//GRTOfj25cHwtX0pN+3kfjzvRddaVoPKzdat3fjbUeHJBZdiZ1Fy?=
 =?us-ascii?Q?zPJ3b/2W9oUvE0UIp2R2WgTBehTVT+kqVsOGVosou3ysUGDHtdYufAIZ9+7+?=
 =?us-ascii?Q?OBkhvlhCGAaabnFtOUI/anLnyrXszqFG4dwOxQLIIjrq3sSYWrrZU0eB9KaL?=
 =?us-ascii?Q?kwGpRVuce07z91tdBee4ctknWScbOPXWhVn/jLRJRUp1NJ3+8P7KnOA4z1Fn?=
 =?us-ascii?Q?ZCBgwaSCziWGv3KM50GMIyBti3ZROftzlxGf4XAhgOfjohH32S9CHITUyiR1?=
 =?us-ascii?Q?w3YaU8kCJqj3TOVebHPuH9HxZh4iSH1+9XqVoqWmxTAkbkQXPn3yVpVfJqKF?=
 =?us-ascii?Q?z3t413bbqGRApi+ZRxEjCM8nzcRrKv4e2L8sM7bDG+nUgBjQX49E6lkgw4Y/?=
 =?us-ascii?Q?/YspZ722HqUiou1RRoO8jnKNKR72jGt31bgc/PnGCVcCL058hpLGm770Ryhb?=
 =?us-ascii?Q?cFbbE2SsmTxpUsoOiCwHevsf4vByAxNG3RelKzA0Rw4eeu6Z1byvq2ePPwwf?=
 =?us-ascii?Q?N673p4qwSYl0fFI39yhS58HMObuPUwZPINezc4AXqrW2lzW+buBFQx2QrepW?=
 =?us-ascii?Q?ujgRyKlUT4kRtA9Z0gkqxoaT0IRvJ/c0L1vq+AnKgzH3gZAwdvvBDcJHTZng?=
 =?us-ascii?Q?Ywp7ugjS13A2v8HN5amKyYr8nroafe3t8ajuCqosHxSb2qurTP5p4l9Vfauq?=
 =?us-ascii?Q?IKi6dqsWrDB6jcRVSbdedcal0/bqrGIE5rw8DxsT2nxGeJsibNkoSev8E3w5?=
 =?us-ascii?Q?KDGShi7mzEiDKBvNdc2oQV6atT9GSnuMUkUnpZ9ZgvHuRJYohqJL7MsfYoEC?=
 =?us-ascii?Q?MyjNGGnAH0e7IKHOJ2Yzh3iQaOJWYaojoyN2WgCCPRx7zNJh4v/4Cib8S18b?=
 =?us-ascii?Q?ic8ZN84+GOO3gyrJvMu8/zn9CQhzE+R+?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 01:28:28.3801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ccc427a-281c-4802-564b-08dd19831d9d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9217
Received-SPF: softfail client-ip=2a01:111:f403:2409::624;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
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

On Tue, Dec 10, 2024 at 08:48:21PM -0400, Jason Gunthorpe wrote:
> On Tue, Dec 10, 2024 at 03:01:48PM -0800, Nicolin Chen wrote:
> 
> > Yet, here we seem to be missing a pathway between VMM and kernel
> > to agree on the MSI window decided by the kernel, as this patch
> > does the hard coding for a [0x8000000, 0x8100000) range.
> 
> I would ideally turn it around and provide that range information to
> the kernel and totally ignore the SW_MSI reserved region once
> userspace provides it.

Hmm.. that sounds like a uAPI for vITS range..but yes..

> The SW_MSI range then becomes something just used "by default".
>
> Haven't thought about exactly which ioctl could do
> this.. SET_OPTION(SW_MSI) on the idevice perhaps?
> 
> It seems pretty simple to do?

That looks like a good interface, given that we are already
making sw_msi_list per ictx.

So, VMM can GET_OPTION(SW_MSI) for msi_base to extract the
info from kernel. Likely need a second call for its length?
Since IOMMU_OPTION only supports one val64 input or output.

> We will eventually need a way for userspace to disable SW_MSI entirely
> anyhow.

> > I have been going through the structures between QEMU's SMMU code
> > and virt/virt-acpi-build code, yet having a hard time to figure
> > out a way to forward the MSI window from the SMMU code to IORT,
> > especially after this series changes the "smmu" instance creation
> > from virt code to "-device" string. Any thought?
> 
> You probably have to solve this eventually because when the kernel
> supports a non-RMR path the IORT code will need to not create the RMR
> too.
> 
> Using RMR, or not, and the address to put the SW_MSI, is probably part
> of the global machine configuration in qemu.

Yes, either vITS or RMR range is in the global machine code.
So, likely it's not ideal to go with HWPTs.

Thanks!
Nicolin

