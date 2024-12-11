Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA45E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 13:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLMVL-0008U3-Or; Wed, 11 Dec 2024 08:11:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tLMUv-0008Mn-S4; Wed, 11 Dec 2024 08:11:30 -0500
Received: from mail-co1nam11on20606.outbound.protection.outlook.com
 ([2a01:111:f403:2416::606]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tLMUs-0004ul-JD; Wed, 11 Dec 2024 08:11:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECNDE2wtRUqHj28Wm92XUWVpiTwVYMvqf+Ucz5rKke+StgN9pIcqXYMKDhoBi67320c8Uo9mD9Ie8NwaOYDAF54zjphqZtxWDuzDTkKl0dLXHptagnsD6btIm0p3GdJq1Msu9+NIAgBR4j4z+e88zDm4+VM5PWs7jqdycN4lh/3Ky6ROznq31XxPi78uhGrdvkYrAy4WNXKS8VnUMidhxSBUJNo9oxpkAxCWMP/14GcePbtrbZatb7OLYcCTH6z2q3kyLlk1b3jpzQ75W/+OObadeDdP7d0/PyCvUZQMkwkRR/wuVZYVnajCQM2QCzF6u+/YBeby1arux7gALov49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vE/1oclTw5ayXQyltRXYh6+8t4sE6qwaypTiBEOtje8=;
 b=qmvEwr+Eh2gYK9Vg8WYhRSlJJGER35EPoLVPxtzK4i7TIMZN+C5/HoGqnFBHZyPdW1tPp00rewwwvnFvIMGKFvamqeNWjHEY6xFWX0ttyJA7W6x56wuu2fcY5WX1TftdOWkcNJNtU0v7XsY/4YWkIriG8PZBPFfr/2+njFp1sZsVcdQq45YxFvN56tLxa42f9dY6gKQdJHIVqmsCVGxwYhpJXnfQIBe/7vtrUIU9UjtA855YLG5nnQmjeGsQgwP6/uesunwH/gaVMlqte2q2iYAVnn47GsQ7J6gFieTxWzKy7ShsqLUM2N3z7B1Aye2q7RARI92BQBmijastF6ySLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vE/1oclTw5ayXQyltRXYh6+8t4sE6qwaypTiBEOtje8=;
 b=UwKPlQ+tQrO7MoAWCkcgYZtdn6h4+JnqNGYgyuMUfahJA6Yxf0K8ieCDiuH458iomBdXFOWhAyBl+pWj4MFGGQvBw75CqMlG7KZnzETdvxN7NDa4110IMXjsHv/WZvaF8BPVYRTpWFroREYMRpteT6pObI3j9AgPRXscFeKK5biiw889LIhnIPI5kzdoUtRb5ePbfMYqNrt5vGtpQymhmZC5WxnqHggHFHApwUzI0GQgRWTiT4zN7+TCMPdUTefmek7e850J5hg8SPky1eSVgqIFmk+45dBEOB8z6CB9fSC15FBH1z56YnukjTAUA/FvjXFDUh+QeV3xoVTbHCz0PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB8060.namprd12.prod.outlook.com (2603:10b6:806:343::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 13:11:14 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 13:11:13 +0000
Date: Wed, 11 Dec 2024 09:11:12 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: eric.auger@redhat.com, ddutile@redhat.com,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
Subject: Re: [RFC PATCH 5/5] hw/arm/virt-acpi-build: Add IORT RMR regions to
 handle MSI nested binding
Message-ID: <20241211131112.GN2347147@nvidia.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-6-shameerali.kolothum.thodi@huawei.com>
 <Z1jIXHmFcBFIUeKn@Asurada-Nvidia>
 <20241211004821.GM2347147@nvidia.com>
 <Z1jqsVTiMwW/Zk5z@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1jqsVTiMwW/Zk5z@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:208:256::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: 11a75e8a-3717-4ba4-86c3-08dd19e54a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0kiGtOT4lmJEMZpmpVlE2yvNlUcaUtWtTkjZVpuNcSOvnIR/CcAGDQqmpXIg?=
 =?us-ascii?Q?2u96tAFVM2GC3keTJSj2ZIfI/PXiDv0Ft14Sk0tCkQWLVPDGBCPNrlRkGW4V?=
 =?us-ascii?Q?UBrjgbRz3Xf5U1skikQmaCP19+W7hzmx/yyrf4NLPEf09HUDFCREmoFycSip?=
 =?us-ascii?Q?/j2yRm/ycrI34pZbUNhtmHdu0vFEKdCNzb3NAyO98kwdyu37cEFoFc8oqOV/?=
 =?us-ascii?Q?Rez7IyvPR/hgnu9zpTrN7fHRWRbMursy2i1dfD0nSNe5Bz9EyXZ/tdzZJGmK?=
 =?us-ascii?Q?pdt+EgjxA3QjcSD5/pfvFidEku9Vstvxwc+c62V3JYSgnp9ol1SyWSDLrOZe?=
 =?us-ascii?Q?5Xmt5jmLbX5yGqpmJttn5Nh1bvcrPcGptRpaR6O+WUf6yqaa2+1SuXVeEMF5?=
 =?us-ascii?Q?n8MmHJwNSxyp1VuoEkhlR/ggGygJJ9HN0jyGjcmWCiDIss7kmVcPhcISW7f0?=
 =?us-ascii?Q?h7hjya6v0zRkUcjwVYdXIE1hdznMCUSfiZk3FnKqWHrbXOopPSy2UqvKO19J?=
 =?us-ascii?Q?6i7cwE9gmxXNWqnjMBKwmbdrSdIzAmSwGWWALx1WK8MpS4pRyZMLzgStaQ7M?=
 =?us-ascii?Q?OIdFWVhcdkr+oT1WDswZV1+sjN7pH67NGK8LzjulGdEzJFxAPKNtPxwhEkpa?=
 =?us-ascii?Q?ul3FXZrYZ9BaqwAGi3b15/uE3VnUpojC0kMAYRGaOoYNHDsmrTcOkVjpYFb2?=
 =?us-ascii?Q?aEhj9sgOWcOLsqN84entDSjRY5kfq5w/N3S9UCUv74Z3xJwCfw6n3NfWHGxP?=
 =?us-ascii?Q?4Fb7zEKrYXOmvD1uIY8EJ+nDOALD9/8l2TG897V4PhdE2jF+zr2LelglJcvD?=
 =?us-ascii?Q?diNN7hrALL3vG6Pvk5tm/NlNyIKdi1lgJtGFf+PsPlZG4vvi6faT9k3mOrnp?=
 =?us-ascii?Q?h8CrY0vEtrFMqv9oJmE55y2eORONjFfklyFYbz8qNr9QKW862coY96P4OenJ?=
 =?us-ascii?Q?9Sc1MWRUrjzkTtNcZH/BO9y+XVwYzSlwvHMc1kqjDIf9jdFzq+Z4jytmmyDH?=
 =?us-ascii?Q?58WEixRyZy5YQzDcMZ+lHSuxi0Zg/WFAHBOQzITFXML8RKKXsuWgA+Gufchv?=
 =?us-ascii?Q?gIUEAnAgD+JU0W+ZbtWKf44mRnEuQhRupJTzrLoaFDFzLRVD6vq9ao4sHu0u?=
 =?us-ascii?Q?JybY5xExi/RmxU/i+1QRdk5x0b/YjpQyUGoPA1iWLB7NSipbGWJlZZbNkRfo?=
 =?us-ascii?Q?u+9PLEnavpmmFnVa8W6naYIqNZWCL5XCIi0AShbsZdA27ImgtJbh1yRHAcDa?=
 =?us-ascii?Q?ZMUZgOqx5TMMdM7b5Qkx8BDUhuwDPObfFpHOqy6ThMeZgb5TNZ8o66/9j/gI?=
 =?us-ascii?Q?8Xvc++AhaROvP3nkaPFx8DxZSSRN5ND0/DjGCL7Li4wLWQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8lL31vgXvOMvjeJhsqNwMj59wr9jMOFifJnMYGohx5+a9xn7eZvmOifFIQCX?=
 =?us-ascii?Q?6IqpZ9IszyH2Zs6chRun/AE3+di9NwMEnlM59Hb7l2bSbg6m55n24/miFVSF?=
 =?us-ascii?Q?hKLvMhzSoTQNtJZHnQhJsJp88W4MHiyZ4sXVY1xv+XgS+RjvUByqrSvPV3ke?=
 =?us-ascii?Q?FPcc5orcB4ZDO5g5vlflZdUyJjDm5/cOGvLpuYgYYkNA6SqsipK1BSb0RCXN?=
 =?us-ascii?Q?BEbKxWb10uPiKhhWNZzgo9stBS+fvHeQ4D/ahprpcCuJUMz2I7HNIFIai6kQ?=
 =?us-ascii?Q?rxBMcTy2teI3/S0ik9L3K6hOonbfZz2mw4sKpkj4nOrDZSZ4/ZxjqlWsAIkz?=
 =?us-ascii?Q?aW6LyDS2893+2WpGZV5bUNFxvm0tLCbcVup/O+rXwpTdUaf/PKsQPvpP3OMA?=
 =?us-ascii?Q?4XoMYPy3WVSZXS+Lp5HUlDRx04fXNwokFU8gSn8PlGfW1TXxYfdn2qxksjLF?=
 =?us-ascii?Q?fyUUHrCgRPjxZzkI3+MjPOqKCfky5Rg0Ax7VXmy6j6z2dhg3VYD5ngMI4RKk?=
 =?us-ascii?Q?KjbnnTdFdda49iL1nYV+HhsaijRgwCHeRc5daiAZG/a4aIviJIEswJr2w1RA?=
 =?us-ascii?Q?ce1KDh5ZhW3wPQa2de0QOTnTtcHZshdmfhD7Vj0BPIy2PMju1H80jM+cCEVo?=
 =?us-ascii?Q?PTErsc5lc9EoURF17aVtN8HRcu93vHYA3DQnUExlizr39DrS41y4FbvW0EJh?=
 =?us-ascii?Q?l1QvaNHeC3qSmekUhi9NWCZpbkRe2/Pd0KZFI98pJ0eYWbWd42IdLfTh/UAO?=
 =?us-ascii?Q?Z4972oFksSwTkZeOZbu3PKfj4yITOVIj+pUd4Jg/oQHmoH70le/+dqCPJrAA?=
 =?us-ascii?Q?1HMqbFs5R7LNGf6azVrGuMOsZdYNm23lRSniNPJnXOTOxKtysNsQIgWCHuRU?=
 =?us-ascii?Q?2xwmDjBAKI+LYfdsKg4uEJZYWxZwYMW/23WitIbSlJ6QuH243ULtHxK62+Ab?=
 =?us-ascii?Q?yOXRjWpoXSAy2ZZJRA5db5ORqpDB0vb3gcYZ3E5/51OxPMgZMhtJawe9zlD1?=
 =?us-ascii?Q?ESxVGk5bqyQZaobitcjVFtVUt23kKGVHyrlmwZAcnRYt3dh5KG/Ow/qcKAyz?=
 =?us-ascii?Q?J/aiPaM6XvAQeQgrpEMKGUxDss/3/8Xw/E1dlZt3+scAZP8PVxykKgNoI1fZ?=
 =?us-ascii?Q?Zobi7wt0jaVTk2kpK648BvLraAauF+2/xd97wJ80aBOKF3zC/BMTBgpKD681?=
 =?us-ascii?Q?HdAmMa8v6XnPkUOQaalPbIYnCMftI/q0v2xh44aR5DD3ll4M1/HHjbhziCtW?=
 =?us-ascii?Q?17vuNXbiKKHZXhlBkjyvNmP/rYbdktrIw4KdXNAQv3GVvONS33cBBFivVIJJ?=
 =?us-ascii?Q?MrXHCMQvYMLk7UpZGxkzvI6CTjcNZtyLSh1dEiXPbmhoPW9948jDMrSbnR3h?=
 =?us-ascii?Q?BWNXkJ5r/5BW4cEGDdlLGLKQYQ+P23YRRa6rCno2Sq3w4ze0NVY9ZUqMtKqT?=
 =?us-ascii?Q?4KpPq2ngvhqINg9Peb3icrLO3tpoFj3GfDlzlF5ez2GqC8FBQBBslDpu9u/f?=
 =?us-ascii?Q?vMyOLsiv1NQBe3nHvCtWZ/yoyQyg/gJ03wD/D8B13auLnn6IL0Mex9JfH66n?=
 =?us-ascii?Q?Cvtxl/N39rmgVg/wZeqqHhX8L5I9s7WlptAwdw2S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a75e8a-3717-4ba4-86c3-08dd19e54a0f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 13:11:13.9335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vA1VAsvCbpMJrpd8mPiYAzG0Cke+1g0VJ0qGEqrqwn8bIThoUV70bigA/G5NiyH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8060
Received-SPF: softfail client-ip=2a01:111:f403:2416::606;
 envelope-from=jgg@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
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

On Tue, Dec 10, 2024 at 05:28:17PM -0800, Nicolin Chen wrote:
> > I would ideally turn it around and provide that range information to
> > the kernel and totally ignore the SW_MSI reserved region once
> > userspace provides it.
> 
> Hmm.. that sounds like a uAPI for vITS range..but yes..

It controls the window that the kernel uses to dynamically map the ITS
pages.

> So, VMM can GET_OPTION(SW_MSI) for msi_base to extract the
> info from kernel. Likely need a second call for its length?
> Since IOMMU_OPTION only supports one val64 input or output.

No, just forget about the kernel's SW_MSI region. The VMM uses this
API and overrides it and iommufd completely ignores SW_MSI.

There is nothing special about the range hard coded into the smmu
driver.

Jason

