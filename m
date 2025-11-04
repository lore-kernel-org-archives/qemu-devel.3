Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA9FCCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 18:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGMDP-00048s-Hw; Tue, 04 Nov 2025 13:57:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vGMDF-00047y-JP; Tue, 04 Nov 2025 13:57:02 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vGMDE-0000ed-42; Tue, 04 Nov 2025 13:57:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXWi50SEdRrJTjr3wOmrUnzTMUopGyckeLFHf07W1eQkSH4h5WgPTONRz0GkhSe/aixwPkTTufNjsL4/nAxWBwb42mAh/mi+pLTLr1pW0BjOXB+MnmsUNDaoznPadkni3uxH65rOFmFGPGAzxw1OG6IyalvnPxUh1jfV7f7EvUy6j/XYnX4AaZISx625cGISGKmlD/tsuwA5bleExchNo7kqClTyRk1fnCmY3ZXgNxjVNHjFMrApeKkUmd2s8rvTRe6cWcGK95A/xFt4wjF23unbvkzfBtJZIluOviv94LyRskyb48gCAItgwkq08ha8M6bU+r9lMLTlvvvXRPr09w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyeulWxhdYBFFXRqMr38eZUtG00856DiJOqzBeQcQoA=;
 b=uRhrZL31zKgczlBXeULYWZY2VNUtCOUBMSSKc+aiQIVpC0t7Jr10tBz7nPQij0zF2l7F/R5Am2LHf+GeAo3L4g9uolOqjOm4tR+zbopz8DVUttcpGesf/3lsGwK4mXmnyVpPppTdx3YgQp+0/k0g1iFd0hyoV6aXi5gq3eQutWtMEFJ64m7j0BgfPH4Jj13s59/X9586pLAMufeBhZu6yPzTNoUWBefUrxZq6hU4CFaXOzRkRzGmv6a3/y8exoUCvwxgX+9RbNXj2yAS9WuNesrY43VCCFEEmnKHaFqiaHW63TSaJgv/3UoLOUYIK8ube8IcTq9StjmriR6YsrvJZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyeulWxhdYBFFXRqMr38eZUtG00856DiJOqzBeQcQoA=;
 b=X8aJ6yxbXwPQT/INTjeLEguAsaCRoXnzUWLJdyOJU3MwexYu0JJhMdaRShiEbwg+ldklSmXSsBrxArqTXgIYFq+YU88VGnC+17T2e2+QVbxZQLHxcsEkhI48TC2aHqUA0g6inSeVmtypMj8KqoL0rzVf3Qfzu4AEKEiAuX7/mnA2vTnECevluDordvR6qidI6pho60WzGsEcx3GkN3ryUhW/nfO7pYkP+/L331Xh3jb7y4ewZpBPfcFaSBw7wPf3+H9JsUPaQELJzXtj7Kihn+Qs2BM2amEPMDMTyGN56eVy+90HK1ggtu9DcTkBIzGMSc4wJeG/mGZuHLp34heCyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DS0PR12MB7536.namprd12.prod.outlook.com (2603:10b6:8:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 18:56:52 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 18:56:52 +0000
Date: Tue, 4 Nov 2025 14:56:51 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Shameer Kolothum <skolothumtho@nvidia.com>,
 Eric Auger <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Message-ID: <20251104185651.GL1537560@nvidia.com>
References: <20251104145157.GF1537560@nvidia.com>
 <CH3PR12MB7548379E64E7A12904B5BF7AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20251104151234.GG1537560@nvidia.com>
 <CH3PR12MB754877D400D19E57AFB16D0BABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20251104153535.GH1537560@nvidia.com>
 <aQoz2+bLMJWNoVwx@Asurada-Nvidia>
 <20251104174152.GI1537560@nvidia.com>
 <aQo+oT0GvhDqtTuT@Asurada-Nvidia>
 <20251104180928.GK1537560@nvidia.com>
 <aQpJi37XslsYV+Ez@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQpJi37XslsYV+Ez@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0640.namprd03.prod.outlook.com
 (2603:10b6:408:13b::15) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DS0PR12MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: b174d617-a9d1-4e0b-e371-08de1bd3eadd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vS+gJ5mgnPO3vJJy0l0Vd9e3nOV2JkZ1Gu+lSSloeG1ka3zczT5+pA5Rwu/J?=
 =?us-ascii?Q?5LRR9dr1enuNrm9Od1Yx0goprAeJLJg20KjNqGfpuQGN5U1IZvWh+yCKxcyV?=
 =?us-ascii?Q?oghG9OURR08E7jbs9DWQMGz9NfQ2m8w2+QL64HZpV7VehculdeVTVhkJXYiz?=
 =?us-ascii?Q?QNDN6JMhK+BW+di/vnsIEMw6dO+ABuCZVcAI9p2hGwPHDz6LKI/enWUJ6yOJ?=
 =?us-ascii?Q?yDA4eqtK9Hhn80l6eBe/TOZboont+hbl9HSaEtkPZt3J451iFZ4tmEyAH0aD?=
 =?us-ascii?Q?nCYCd3SoEsKsF1YRjsWEEnPckZzN8torVZ0FNsBId+V+4PtcGObCsRalTJug?=
 =?us-ascii?Q?yTiYtlEkq94Y+IgCN2haMl1GecGth8EANcme13CPl7UmHJMLTaesDnxHbld3?=
 =?us-ascii?Q?E25RJpSQMaiPaiphJBqAPFlPffcD/R6NXtyGb/oOCuMtO8qZuBcS8fAZzEdO?=
 =?us-ascii?Q?ZE/pc+Ei5mu5XUmMcxVQzPyEBLljbApstM3TxNJ6C8+Y0n7hasVUStjD7mcI?=
 =?us-ascii?Q?nlIuca7WiWyNVwyiB1K1Yzp8dd0EpseYao1QRf3rqhqN5kda5CoyGaRQgKVS?=
 =?us-ascii?Q?48v9AW6jcfkpNxWaPGSDtFmOUPmrMf6kH3NKKYWWNBWUEaMdwjkjnFwIVcGA?=
 =?us-ascii?Q?fv/w9jY5t377Rc6PqHipFsq2U1bc6y/mvXSpbD2uFVxjESWfaO2+un9JCn7T?=
 =?us-ascii?Q?7M2w2qPsq1eYXGw2xGk8zWrFxjlbqnlFdcJUJWqZgpryInl/PsztgoP5MWVP?=
 =?us-ascii?Q?ajdQGEJJLNcamUjhTv3CoqOA9//PVMmI4zSo+rP39hUWd5bBm1sBy/6eeqRA?=
 =?us-ascii?Q?Gj0fPRueeLGBe0EDbLGl7tMSEqrThk+1osoZ6Ry4570vjEBptSo5No6InONq?=
 =?us-ascii?Q?48JPhvr/pKkMuK/zcqVPoTKj/mu9pcz7+fvlYMqFNNf7M1jD5Mzrqpf2VU2B?=
 =?us-ascii?Q?PIhHsdSwcE+V9wYX4dmuiNGkHQ9l64IM/9wCDfwLzqtplhXgJM3WAQPHtXvZ?=
 =?us-ascii?Q?f27oE587PfRhVkMNE0os24Eg+87RvbcA5zCpG8d7u1qj7eO2diXsA+MyU3q6?=
 =?us-ascii?Q?pVkmntKic12J0Uw8FXMBg3APvHBiuFaNnmQj6NvJu1Ma1wb3WLI5/uZ40quq?=
 =?us-ascii?Q?wMn45bOb2WmBWt3UGyoF0fkrWc31PlrVBzqJGk8BKwQ+rDUYJnRMdgEoth8u?=
 =?us-ascii?Q?8pPXZP6oG6RhvIAkpreSzLJKovF//AoovdpoYucIQgoPkEgMewRaSwtoI7/w?=
 =?us-ascii?Q?1u/W0x0UVaQJi0Kd8IWEKUx1AacPdzzaP3BeTvuvXTmWde3jK0rWWnVLmm6/?=
 =?us-ascii?Q?MaSGcvPcSr0DUFlRnQ+c7j9lKWj4NIrJPoPQt0ZFHdVFEndJw9Gd5kM95wzf?=
 =?us-ascii?Q?bpyy8zI5aCGd7qSGmwpVxA0U1ccobCC5f6cvWD44IwwWebYWR1zYrHwL+bXa?=
 =?us-ascii?Q?CcwzDdU20kRscyJlslSlGsaFKKlou2c2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3613.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Ylli9emIenmOCruLPeOempvq/ei7e13xRuXavRFoNIvx694Mdzbzml3wS54?=
 =?us-ascii?Q?p0TuwYtoyrLHdimViL3mwGqh57QGsriiqH0bEl7rsR+ZtZ43jWrlaE0seSeb?=
 =?us-ascii?Q?kgN1u0h0tx/c+jXKQuel3afzqlrXc690IG/u1V+9AUebwsFIg638ly1IFnFS?=
 =?us-ascii?Q?rx/kgRg2Xv2YLwVH3GK4Zny7lFxEZ2bxXixkn3KgJdZyatsWPBVTOdwDD4Un?=
 =?us-ascii?Q?LhsrsulCVuL/Wp41ek9BAuj+WCzlM9T6fLbRo2yo/uTG6rqoU0yEmmTPP4vy?=
 =?us-ascii?Q?tI3qfFXnJvJzcY30IFlxFP4yt4QcGoUt11l9shzMj73sIbxGQbOhjUsH/S7w?=
 =?us-ascii?Q?dCYz6N0ei8L3MuBIoodcVd5m9N8otKDyC946oTZCVHLRt+PJ2OuwoIGMqfYf?=
 =?us-ascii?Q?BDvwzsjXD6wrD0rjuGUl/Wc3eLbO7QWbxEv+ABWdQ2ok6FhGNSpa7sPLdHv5?=
 =?us-ascii?Q?tVEKlAx4R6LmeOdWEDqc3/TL2c1gBh+aMRvINSszhCYFDAEH8o+2vtczPZ5w?=
 =?us-ascii?Q?XGNymZ7mswrgaxACneBxkGJjTmq1uh8me4MGP4rLCpn+ql6Q8sWIbiEnIWQa?=
 =?us-ascii?Q?Tn0rWNS6Mt8v+sMHoh4jM9ncw0B0PgT41IYwNWKNEZLiYywjrZMIefnIIUOe?=
 =?us-ascii?Q?3wtyXYGQcmGo97ly4gCp5tkBHbh9NYyM5rU6iA3Lj1CFbrkdaPLua4Qvs0TM?=
 =?us-ascii?Q?1szztFVl9Af6UAmhcr5wcY1IGPHPamaZhCFUmSyvojZ01e3rffmr9Fpuqyn+?=
 =?us-ascii?Q?wTXfQWc62IoLy2jYroKRVkIdtFHVPENeYRUgcTsoYu8D0VNJNavaAErRLViL?=
 =?us-ascii?Q?+rJnH1IL/QhlxcoY7xtZntcs2NEMhoQxMHJYl3fnoGYRzwFOikfoHvGKBD7b?=
 =?us-ascii?Q?G20Zmxm4IZdQAX/RHVcV8tgjYsPvB2h5g6+O4r7n/YoYHD2sxJHgMU5I809J?=
 =?us-ascii?Q?P5fk3NRlttAQFpsGA7Vu5YF28DbnHq49nYxs/XW9JBY0VqsT/9xXO5SL62i7?=
 =?us-ascii?Q?ilMvLxDNv8UyQlZjYVBkTuu7U4Bl1cIOjyuWwBWW5s3yDamKB+m2jTz2hhsQ?=
 =?us-ascii?Q?gb9W9mqQKbSlPDO8zxQXoO9MXA6k/nhKziRI43gmadK4HxP9sV+NsbhWCFkA?=
 =?us-ascii?Q?Tja/17T6mxfpnesQdpbXUd4iFBf5O/TiUUZTCsPTOiwSASe82Q+uKSF6QU8k?=
 =?us-ascii?Q?3cU10Rk5loalcRgh0h2ptoaRRALRMwrK1MeOueCpXAAzRPYGdQVbmLC9Ede4?=
 =?us-ascii?Q?XGXFuYyHzJV9OdXGQL3j7UMAUtF/3x9g9kU/7yiqS9kshSvIPPMycoky/05Q?=
 =?us-ascii?Q?qqDMTWe/7sdB2d5uBpizqto2en9bpI30XvXoC8/C/0W6N9XWcFHQOB4vI+nc?=
 =?us-ascii?Q?N7eSQg9GQ4w6/rRZsbDb79HF8i9CDhu9IPgFw9vZKX766BvE07ugBsIWlL8d?=
 =?us-ascii?Q?cvM9FAeUfN4scDnFgmjsV/P3CKwhVR4oQHyZjGEZdD2L3f1o4m/saYbd5K4w?=
 =?us-ascii?Q?W4BaJiZn3BVGQoCo0FnYGG4Vl+/d3pLIbC6WP0HOytpBZALvpXrKU3pATvlO?=
 =?us-ascii?Q?BbRGZwduu5oen7LtI5M=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b174d617-a9d1-4e0b-e371-08de1bd3eadd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 18:56:52.6874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xkicUyPs0HzbqkRtYenE4xBdqYinGJam4OHuKVNdiCdvWpjp71P0DgnwMC1KZdp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7536
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=jgg@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 04, 2025 at 10:44:27AM -0800, Nicolin Chen wrote:
> The hardware path is programmed with a RMR-ed sw_msi in the host
> via VFIO's PCI IRQ, ignoring the gIOVA and vITS in the guest VM,
> even if the vPCI is programmed with a wrong gIOVA that could not
> be translated.

Yes
 
> KVM would always get the IRQ from HW, since the HW is programmed
> correctly. But if gIOVA->vITS is not mapped, i.e. gIOVA is given
> incorrectly, it can't inject the IRQ.

But this is a software interrupt, and I think it should still just
ignore vMSI's address and assume it is mapped to a legal ITS
page. There is just no way to validate it.

Even SW MSI shouldn't fail because the vMSI has some weird IOVA in it
that isn't mapped in the S2. That's wrong and is something the guest
is permitted to do.

Jason

