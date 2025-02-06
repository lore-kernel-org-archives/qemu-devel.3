Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C1AC02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg8eU-00053e-Ki; Thu, 06 Feb 2025 15:39:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tg8eO-000522-NI; Thu, 06 Feb 2025 15:39:04 -0500
Received: from mail-dm6nam12on20619.outbound.protection.outlook.com
 ([2a01:111:f403:2417::619]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tg8eM-0001hZ-Bu; Thu, 06 Feb 2025 15:39:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dG2eFnX6pEjlwM6ODJ9VhlYQmyE6PVH7chMRTTmfhFuRXdquEQx9Q+j2xOuG/sffvLNbNrp+hf9VjCS6DqMsGNS+RZha9iP7H6D8YOYQrlfbAAEvD+/rb5Su9XFkHsXyo7oVFslVg6rC8oGPx7hUk6Xsf5qhZPr+3ThVyrQVT69hY8ZKUMt4+Mqt9jtRv+xbw7t6NSF4MaQrnCDCPvog7p/kwoSliOevDVhsTXyk+m2katxmhktnbTLkvAfM+xIj7pGu+J+sBxYRAiVu7cOvEgVaecqHbzmES8LyUWlEVhS9D3sNPbjTCzRhEhIa8eCe6EoGLvGIIGTU6VK+XwTC0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGnwPEgzw869xxEGJDsCLv45GChP9Gq3NQNYkoLMYss=;
 b=QMz+R69p+M6brrTUskh4r2wSmKM6z1F14srjpnWtBTnZS1ea/bx/PTsuzAVk/4dBoG4GBFljjmePVJev4hw8DIXDrkZ1avwXdaQ3W69BT7Nj6nF9tsMIhjXi5TE/ylH+hUUiO5SPGcph6JV8Gm73rNTi/75DbN+xp9EU1qp6eTOJ/xRfdjeVsH+f9x6ksQjFU2Ntx/c7RRpo/ZJ1tMOMSc1VmKP0FU2t7TWWtF88bTtokPNdQ4rn9uFjjOVVYIPXZjvGE3nJjcFauGFiJ97lrI5b+XWTIl4TJztw1B64u3uGmARZo+3Xokt8PrqW/fJIqAQIczoeGWYE8SzKP6iAVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGnwPEgzw869xxEGJDsCLv45GChP9Gq3NQNYkoLMYss=;
 b=MZkhtt5S3GdE20BvBZlpzD2A9Qje9nlz7Gn9XICEL+jiaOTb+DbXlzzoyHaKEiuyLf2TqaB9efBbagHy/QzUDUioEBe5ewI7VxdvDLwHAcCwHbnves3YvWtY7JSFWbM7KhNbAOb6O7rlSEEgFLPWrGEVAAi4E1PLQH6vT/r1hHBxn+uj8qpkLyA/JHrbsGTx5cTqSH586Iu4jBefSCtGQrZeWoONN69AZ2dZN73kufsDCBKklP4lQft7B2AzZkgsCTJDoylnM93fRL7DovQyFS0l2719poJwW9yEXOAmj8SIQX1z3TNjh2r7t46jEjD4acoBvtIRJ5RGZ1WiU+/spg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB5767.namprd12.prod.outlook.com (2603:10b6:8:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 20:38:56 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 20:38:56 +0000
Date: Thu, 6 Feb 2025 16:38:55 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ddutile@redhat.com" <ddutile@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Message-ID: <20250206203855.GM2960738@nvidia.com>
References: <20250206170238.GG2960738@nvidia.com> <Z6TtCLQ35UI12T77@redhat.com>
 <20250206174647.GA3480821@nvidia.com> <Z6T3cX_fM-aeYbMI@redhat.com>
 <20250206175843.GI2960738@nvidia.com>
 <13b1d8b97a314cb28b87563fa9b45299@huawei.com>
 <20250206181306.GK2960738@nvidia.com>
 <02a0080a4a1642d69b7f5dd4707a5b3d@huawei.com>
 <20250206182201.GL2960738@nvidia.com>
 <Z6Ucj/u3wt9muakb@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6Ucj/u3wt9muakb@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0971.namprd03.prod.outlook.com
 (2603:10b6:408:109::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d10dd4b-e7cb-4193-6f89-08dd46ee46e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ye4MVNZr83fTYo6OCe3bJjnB3ZACZXJdhoQbdWp2iDPVCY8YgjXfJcbIIpJ8?=
 =?us-ascii?Q?PEsNAbvx4B6RlPTp+e2rJzPb7rpN0h7SXi5pflC4fD4tRaMyLRUfPBh7on1a?=
 =?us-ascii?Q?j/yfzdlbYrvsny2gHUKfxDz0b/BHXUvXTeHhGKq+yTIJbTNymDq5pxbL+qgb?=
 =?us-ascii?Q?ZGLpmBtsWqfrtzR0SZD2T9nnuufTy4Z3ls+jwWDzy5/sDKLapsr2QZatjDY9?=
 =?us-ascii?Q?PWplaUy8sqh6iyPSF6ISUVa8IAnX/g2jO2fdXZfrFmPzP/8D4B+uAoiyp9tL?=
 =?us-ascii?Q?nx1fik62Y054im1/ZcnGStNTGSrCQXp/0yJIUlYNO1tY5iAYxTyVz4XSAvTY?=
 =?us-ascii?Q?P+HpfPZ3SbzLrzHb7E5N0a+PhXNfhmMN51+cY4g3/3P/Lwt0JRNxaz2aVY3r?=
 =?us-ascii?Q?XhWc5H0L2rfTFT6gbBljGflLw3HiNoe+Ba36MDeIk+RBkpNOFcR2re2rYaGO?=
 =?us-ascii?Q?EiL77R4ehWbWh9QcQNIsw58hOi3W+ifKfJWWpDgvL+OZ6iznH02R1+Xw3OMO?=
 =?us-ascii?Q?2cm0Gf4oS8pAk8ICOHqVNCQq4noSQop+ADEJyatNvgUaqrSwHAS16iVXeE2Z?=
 =?us-ascii?Q?Df4g+j+WbgWYkI1yw+YTnbY4F4YgYSmwSXcDp/ewO1HeYgc17GtIyYVM275k?=
 =?us-ascii?Q?VBRnLOcLJSgHoa7vcZhLHwPqtkoMk0s74xff/O0bjUAdwL1TiWOotvWtqBSZ?=
 =?us-ascii?Q?GHTLhrDOJqfdTGolymYRPXN2FOqJfCTuINH+uRWVyJLjd2az9q2NfPKYWKy8?=
 =?us-ascii?Q?HVUiDz4Ia2eskCwbhkGEuXSKgmuYOHaTe6SqaHDDMjEgBGZZzAgFfOTkjG13?=
 =?us-ascii?Q?tHQNQdG7O7kYBadCk1LmN4Dbi5yZm2uVW9Fh/5znH88eQ9+5vEtUxOFHDovq?=
 =?us-ascii?Q?PgbvXg6NUmSsj7nrDFcja0DoYcN9WKUoYz0I/MZWk0LYLl1/o6URT4cMeTC0?=
 =?us-ascii?Q?J5huKB99opr6w9AjsW/X/ueN4O81B3YHjZhwdkjMSW9AKMBaKp4WNdsOMyAj?=
 =?us-ascii?Q?Ifi53kgmIjcCraz2DPnYTkkeAJuDSU4+96cM2lRWNfPzsrKR/WwHzqQHkByP?=
 =?us-ascii?Q?On8pR76TNPdDoK/047YVv67TZjkNJXt6UyCGZmOSYrJnRkqgALWhmUaTJ4ND?=
 =?us-ascii?Q?Tk/jguJCJ9kjc/zzliK0YEd7U3BbE+HtyXSaZJObxsQ2cP+gUKarDnZlNORp?=
 =?us-ascii?Q?pq3nh8skM+jXuyKrsgovap3lj4kw6UfwQ+JXBKzSCOcL4cbrAJQ/9u14F9G8?=
 =?us-ascii?Q?SwiadeaxgFTLmwnVLpubZRQjhA7l/K0QJzwX7QfzXoEgF7EFVBtwcoMjRa1c?=
 =?us-ascii?Q?ddVHkY5CWUPYTt/UZx76LfJmgRY/F6I6VXXO9cJqC7p/vM7L/AeKb9KsBk2C?=
 =?us-ascii?Q?XUtii0WxAYwJ3LQHS1aT2nDnc3tP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PJnFFhXKwtP7N37ARPnroSAjxEUI7+5SS6vXAPGEhdwfTQWLAEHumWmFsbKn?=
 =?us-ascii?Q?yy9sDNlpYrFZz4jwxAs3bIWHdIYDtUujyE87UscPO718t1izS2iW5IvaOHj7?=
 =?us-ascii?Q?6wyxv+6syj9Rb9usxZhPBBNhkquE26KB3XHveOMuff9JnhkoSBOom7ui+6q+?=
 =?us-ascii?Q?mv40gtCwvF5HyCfcq4K3m2t4gYrQmynChYPjEIkIllSHjTv18IevjaLUZvkn?=
 =?us-ascii?Q?PMIrJGVDiF1DXiOfKcMSo79zKcoU9QxkySSJKEwa6OXfwOGJ/hTUPX/wnIBG?=
 =?us-ascii?Q?mEzx5YqdkJ+KsCUnUVLDZIqRjDxyBgYIiRGWiVCPW/g5w2RBrvxIuyZBba2U?=
 =?us-ascii?Q?7x7V1Jtf2Q17mLYIFVjhoLTsL5oa/GqSu/IfI+1mi8gjco8J7n4nxH7Evml3?=
 =?us-ascii?Q?DmhZJ6FNt4QaZ+DBcyvdCh4v2oDSGaPWtocDLI99ENEjpeiNVRdbve4oaQWu?=
 =?us-ascii?Q?Hub5f/PwJBa1HsVzZEkKjlQypQEMgfvowOSq9UiXyxNv3mm1SUl55BnFE6Bo?=
 =?us-ascii?Q?QMq3FmBAhuC7kwe17hpRiyt1GsXPn8mHOYpuzRnp08SROOHFw7LG8z6y6H0l?=
 =?us-ascii?Q?0qZNitMDmIyrOz+/CH92mEZfHb9E5yYYw/2BMEMrbCNgoP6NzpJy8L+js7fe?=
 =?us-ascii?Q?Oc4VXJGCbvycYwNed4Q3uOaSU3m5FxRpAEtYwfg2JKeWAD0emp+2MgZrygAD?=
 =?us-ascii?Q?BiYwKRhj8LgfH6Wb7f4LCYgX9exjsgcPekyBkzz3nbamNpowfPmreUsXbL7M?=
 =?us-ascii?Q?cCN3IhyN3oycn84YJ/j7eQR0nAcJj9CGDqKYVo+zBgT5aBCthikxr4Q3PA4k?=
 =?us-ascii?Q?ZiwkIiPmagoF+MjLwwbhUZZplsKoe0T180RbWGcHVM7eqVA00tiKMNtnmzF/?=
 =?us-ascii?Q?27wA74z/gnTV7rd0r8GYfe49PWXcwndiJkKTioVyRa80RQFOVJMhjQbo6WJF?=
 =?us-ascii?Q?mYbsRFfElsznOZTY+b6CauRKKNB2gCzmR/TrYlGFjWIV+09glmYs6HPSc2vG?=
 =?us-ascii?Q?tT2s5hBbt0VmcINt7zyJuyT4LELUa3rI0gqRbzKZwJQZKqjBK1kl5sp2/WDO?=
 =?us-ascii?Q?hS6pmVeKd80ki601RBFacS+QZqkuVK4VGO5DRAc3Y8v7c2gsQRsBnxzcCtHF?=
 =?us-ascii?Q?v14A59XA+qPurpXzZq0H+v4LMRlRAA84/5vkxcBkUEk1bFyjsX97V3fXzIII?=
 =?us-ascii?Q?3TX2mVi7mkeMbfs/SnRbFjxZETKIdtQog6p9F9V9wLpcd7Tt+63Ja5b1LlCj?=
 =?us-ascii?Q?vLpeSwR5dVYjMLpjr4Pkby6y+mJ0bHrHgSvs/9xp7nyuO/dZHzqe0SwZi3OX?=
 =?us-ascii?Q?Jus5js5vDbiLM8qhexasIHDRpCj6HP9ZFVjjG+Ln3G6Z/0rh0DkIu6vmf+aH?=
 =?us-ascii?Q?m4vD1zn+Bnli4L1+Qeo25IiPMeht6lutSVkD8u0BU1E5YHW9x0sqGefMyfaL?=
 =?us-ascii?Q?MjJ9XafESOCLklsnbKwcPKeju++WvpZw5Fvj1+W6usTrSQGxNTAcpdL1Hth1?=
 =?us-ascii?Q?xgq3AAcawSb9YSFJNr51idpMcBC3Tr6aw3Bn6MYDzRihAoqx7AXnurcDIkZj?=
 =?us-ascii?Q?EtoyKvi0IHHl2PaEJvI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d10dd4b-e7cb-4193-6f89-08dd46ee46e3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 20:38:56.3912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11X4GLhShLX1E0bWRHJb4vCinAVfqs03EDqYQGBNXkZmMiWAD/sCsumgeyKvpWgN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5767
Received-SPF: softfail client-ip=2a01:111:f403:2417::619;
 envelope-from=jgg@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Feb 06, 2025 at 12:33:19PM -0800, Nicolin Chen wrote:
> On Thu, Feb 06, 2025 at 02:22:01PM -0400, Jason Gunthorpe wrote:
> > On Thu, Feb 06, 2025 at 06:18:14PM +0000, Shameerali Kolothum Thodi wrote:
> > 
> > > > So even if you invent an iommu ID we cannot accept it as a handle to
> > > > create viommu in iommufd.
> > > 
> > > Creating the vIOMMU only happens when the user does a  cold/hot plug of
> > > a VFIO device. At that time Qemu checks whether the assigned id matches
> > > with whatever the kernel tell it. 
> > 
> > This is not hard up until the guest is started. If you boot a guest
> > without a backing viommu iommufd object then there will be some more
> > complexities.
> 
> Yea, I imagined that things would be complicated with hotplugs..
> 
> On one hand, I got the part that we need some fixed link forehand
> to ease migration/hotplugs.
> 
> On the other hand, all IOMMUFD ioctls need a VFIO device FD, which
> brings the immediate attention that we cannot even decide vSMMU's
> capabilities being reflected in its IDR/IIDR registers, without a
> coldplug device

As Daniel was saying this all has to be specifiable on the command
line.

IMHO if the vSMMU is not fully specified by the time the boot happens
(either explicity via command line or implicitly by querying the live
HW) then it qemu should fail.

Jason

