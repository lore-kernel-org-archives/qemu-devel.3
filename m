Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA67C282EC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 00:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuhLq-0002mJ-FT; Tue, 18 Mar 2025 20:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tuhLV-0002dc-GY; Tue, 18 Mar 2025 20:31:53 -0400
Received: from mail-mw2nam10on20628.outbound.protection.outlook.com
 ([2a01:111:f403:2412::628]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tuhLT-0003fF-AO; Tue, 18 Mar 2025 20:31:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u876jxPR+pLori/aa3g+ZELXCra2cEjjGIuwPdgJarb2f+hk3ONsMHWWRyH/ocQ+NpwHgH1DLz+iJjFehU585grkAYJv31SuWGH5+nuF6n3Q6YrauYqkHQHNDrlB2Pe41xMyls7AA7yMqIVq8He9eg3j2IsC7agcCDvZQJCgqC82V+KjSWfC96j118oN8Ojpy/yhkkTLJLez/6zLlIWdCSYLj9zMJjVplG7nU9TMyfLe7cUpRc5cdTsv/hHfJ5uny7WNPPkmGSP5LIO24fT5S6mDkQ6oGMf6OPifrAr3aMhhK90S3pvUu8IlXBKXYcxISrBWdV45Kb08Nxk5pNNqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/EepoUQBPqkfp/Rq2CDWHEd5AYjR7Wqb4HYXdEz9cI=;
 b=yVnONT9pDN5m8UAsOK76lHa5hWETRxk/I+FKWQ38I7vGLqMzx7v0Ah8tJzCqH91OBu/0fKt3xU3lftq+ikebrVmreB49WJvA14D4OsQ5r+G+dom0H+fnupk8XYTIOkhqIZkBNQx7tRtUzwXGbsIoc9kJB3l4/T3Zw76qTp64uk/cAuRoRiCJghSq9HRO5BgnMWiR1HX0H+WgJuS47eIQLwi/NeIuwxPm2BdNdMyYEhLZKJYMYPwMtX8HkZpoSESIx+W4tmH7OmaofJxuSka0p9Hsn67+6lnUMrntcfyY4PNDOv+ntaKf1iIDgfJEUU+qNT9PlTc6pjltvLKxXlPDnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/EepoUQBPqkfp/Rq2CDWHEd5AYjR7Wqb4HYXdEz9cI=;
 b=mLkCEEkEp3Q6Bxh4U+1GHQYVt2MD/aT0R9YmYrbVcHGBZeWZ2k5vlrT7XWyYqydbadiPugDnJc5xsSuiVFnhTbaEC+t+Tb7hiSNJ+i5XDnPbfMparlHGjXax1jea3kWgC8/jAFkt+WLzMOonLUIGXR/172fQIUR14p4ixs7VBeGmgLeKo8df3X4wvwmmdnQOpj0N/sWxdsNo9YNYGZgmMlYTDYF6FKeM5GINDi7PiH2mjYzNMj01mH+ry0NQzwJNcgK9b7zzDUq2vuRUOxvc9z/q6bJGXXZJYW9EU2+6zxoBMvcrLGpjblAHxh2zLngcTqZEgOzgZ+g1QUyi/CCzPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB5950.namprd12.prod.outlook.com (2603:10b6:510:1d9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 00:31:37 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 00:31:36 +0000
Date: Tue, 18 Mar 2025 21:31:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, ddutile@redhat.com, berrange@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org
Subject: Re: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
 infrastructure for smmuv3-accel device
Message-ID: <20250319003135.GH9311@nvidia.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com>
 <d75feb00-72d3-4d79-a7ac-2548eadb6a77@redhat.com>
 <Z9hh8MIAQNQcvNlG@Asurada-Nvidia>
 <71b73212-3d8f-4c9d-93a4-bf07c0f169e3@redhat.com>
 <Z9hzmzHfWw18OyGO@Asurada-Nvidia>
 <20250317192453.GR9311@nvidia.com>
 <Z9iDxSvZVsgtasGj@Asurada-Nvidia>
 <6cb391a4-d150-4692-b62e-a509448a1034@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cb391a4-d150-4692-b62e-a509448a1034@redhat.com>
X-ClientProxiedBy: BL1PR13CA0303.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB5950:EE_
X-MS-Office365-Filtering-Correlation-Id: db27e1c7-5d27-413c-7307-08dd667d6879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xqdr72tV+CXA+O8llKoPW+SEMv/oba5Yd2k3DofHtCeqhO8od/3VuZrPfQnl?=
 =?us-ascii?Q?HwZVoudz74kkdJmvOEgMm5D1lZ/jJBre60TP/DhxCOq3jRHvUqzRIw4JSep3?=
 =?us-ascii?Q?aNfx6D9MkfyN0XkWmsJGr2EldWGVlNrNkobL7HGoTjNmlzhv+s2E9fF9kevY?=
 =?us-ascii?Q?O4Bys5P8j9Y1KLrlxKkZNbxYNke3XHAg1QkKuQK2IoyAOm8EprfoKT9TemOV?=
 =?us-ascii?Q?TpmA2XWsGL0v3b0XjnDfZU0ApkB/ygog4jZjpiDRQg8hOmrHXcKIckeq8GMP?=
 =?us-ascii?Q?mA231+R8MB8f3A+xc1arizwqZdiywWK7AZ9vKklod5zmIh6TLZSRyLmbcB4I?=
 =?us-ascii?Q?W9tYkRdwSDMP1ZzTFnOwJn40tvldOxkVtPD6g654mIwoJxYYOzum6f/rJiwN?=
 =?us-ascii?Q?eGdXHX4pWeG0w/uLqW66kFG7WHZ+zzVNlPRbKFItlUrsktvlUzAl0dsASSpj?=
 =?us-ascii?Q?Xm25eQ5gGk4/CUKici2I4hwNPud49HFUF4oWbZDQbzJzXDFjVVR7eflQogOV?=
 =?us-ascii?Q?NJbsFr+xIE5XxPQ83V5uqEhE4xNE/O37Zx9cPSrqzg/T0nSBd7U1oo2jfqoL?=
 =?us-ascii?Q?Xh7HdlDVDwBph6EgtbI+euaAQahq7BUHRDbtF0sceNsPLb+9Mjq4DGmO9DxX?=
 =?us-ascii?Q?tE8Z8xClWhw9Q2xezdCzSpruElX2EK+ZROIOqYI2iBv0mwa6TVJJMZiiWgMu?=
 =?us-ascii?Q?PdWpxlchxJW0nTCgRIHBYWz4AJi384kVLEiNaiOPCk7TloH4UvDk0TO7jxcs?=
 =?us-ascii?Q?hvwyxt3CCmuRul6/wNZyLriaqFqZ7YV9bqp+vgimltubPgG0DS29+fxMIQbT?=
 =?us-ascii?Q?DYtY0cYHKh6WQ1y7DjK48HTefySoryOOGpKwWuptqPtf+Uyiu2xWwYVvCYYP?=
 =?us-ascii?Q?40CFPpMOI++8txqW7eAQrFGhDJT81yceKU0jvb9MgRm3Wpq5JMxT7Wziixd+?=
 =?us-ascii?Q?IU+V5FZ+JcB7BuLj6SJ9KT400ezlId1q/JZDHc6uT5yY2PyxEYYdhYy1u+pj?=
 =?us-ascii?Q?Gyk5RD8XLwCDErGQTt+mDQ24lT2dFbsupV4QGcDi8GBH9ZeaHJiXJr7twTMA?=
 =?us-ascii?Q?VmnCzpuz3pKh4KGHFWnc8ewdAMKt4ujMTYx6NQQwkBb0Qr46lVYind5qMPYE?=
 =?us-ascii?Q?S6EbMwoxkB9DG4j6Io8s68fLiQY3W4MqE5s8VbvnvkE8AeuiaTU/0njApxX3?=
 =?us-ascii?Q?pIpyNwTTkmjFd1d3olunU4eLTOQ6GWq5vScRNdsozqfiSA88BGskoRKwdIzq?=
 =?us-ascii?Q?eJk/T7p25ObU6TBLKsOgPOBgjaGtwGuR6qoHosKzkh1xbnQKPZ88uFVgZe60?=
 =?us-ascii?Q?xjUo7kZykOK50sDVVL4/zWvOYw2qDAFOvuRMwwPPeAUjTmWthOZeztwHHSWk?=
 =?us-ascii?Q?0CTxSPwG+qf9Mfcea5ZI1EOL1Y7n?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/Nw8AipfCzQMgs/hBOygQDMSe0SrGw+9XMhAcZPpIzJJ3i4wurCBqmCOaRKR?=
 =?us-ascii?Q?/2K43szcxe7hsq0sqUyo+xCVF5mgekURDdQWX7X+/cQiI9cwFDr6BHzW26Fc?=
 =?us-ascii?Q?P2D8qrzWorrU+3vNbBXDIovHoiISet48F20lKApR4yMW146OfUhxW4lALilF?=
 =?us-ascii?Q?eEfDzAy/3P64dFcn6GZ4+necs6tKTzwcWwwExAcSTPSW8qsyoyp5aTSaEnFW?=
 =?us-ascii?Q?TnY1yddY8JnfOkJLAYj5Ofh0ET2W6Zvg0IcarC9R+suHmDX5DInKmmFAKOkI?=
 =?us-ascii?Q?/smPffuKFPLk9kjKURFf0e6Cn4ny290uDpnF4qAox0GX7shJExIwC+I2QBm9?=
 =?us-ascii?Q?AGgSKJ6a/y1A7fqiRgrQtjkb1DnGsQ8U8E0SAijuH9BFTGODgkue5km5HNWs?=
 =?us-ascii?Q?dgsG5fD1Vo67/dunzUmuWe+AmhY+zjZkAUXfC6AlRG80F8UZbQA/wXRLu0uA?=
 =?us-ascii?Q?Dz17L0Q8Xad3N48JWU+aZfvZ6K0XCJELrT6Sxtt+hdAsU0B9Xuw8yYPK2i6L?=
 =?us-ascii?Q?nK6dayiolzpP4fX5rQb7h04X86RUff6A6t7VXTnVUdmem3z45L+Bi9C+bCZI?=
 =?us-ascii?Q?g37kHVRpkz7SD6CYD+DfbYDjc0U3EwcgeTCGcrTgu5lgXrD2KHFWeK+7g8BQ?=
 =?us-ascii?Q?8dp4Qp0cUArXZPkE348EpGTYahApPxp4mXnSRCXRmotlrGfgqSQESNQbj3io?=
 =?us-ascii?Q?/awK/V484zeKNz3Q12lj81isXNySWuYEEsZSHuLmPdMZq1wVdBwCJJYv1Lub?=
 =?us-ascii?Q?Bsq382szDmXIk04vshETlAix15jl8GANXDcbLnqPMaGvGFWrRhorsDeWjMXq?=
 =?us-ascii?Q?FeHmxbwP2lN2SjZrCFmOMpzyqr3lciZqH7b6ICeeL9vQgjT0dTeTd1DHz7nF?=
 =?us-ascii?Q?N0opDj4d49gREuyHDGBqtb4UHD998qnzsCaz2dJJ5mrk6bgwQIMzkA47tf3Z?=
 =?us-ascii?Q?ILDl7sNKokbLKOx0xC2+N4fPvtEyRMJ6MBAw+89+fOPCkqyEg/ZuYJIsP/qc?=
 =?us-ascii?Q?0RkXPSWd6eFACEqInkw8ljqfSvnIY1nA3301B3vsRZYSHmgUptG5n8xyHQHG?=
 =?us-ascii?Q?D3ULBreJbyq35qem5SMVXvFfOzjlbZ8CCR+nDm/dUq+kH5A2CIEgxrS5QVDu?=
 =?us-ascii?Q?e5BGOEUKOFkYepvjFc2TRtKheFej9EB+iZV3lwJj2/bqrRwNXkdoxxjeaEyL?=
 =?us-ascii?Q?fH0626q9GcD1mL4xlhQ0T1REHCd5rc41RW6Da3vNL8hW1TGT3IAExYRLwR8e?=
 =?us-ascii?Q?w0N5Uc7foRPgMex+LLF8fh3wP9KEiaPL4oOwSD+TSfvqUqRA+X9K02L5o3yn?=
 =?us-ascii?Q?O/wLYeryHuGQ+vBKDptneJiZ9HgtQ2GCY6Vbp/a0LTJZNV9N4cHqvQ8Dy+Vf?=
 =?us-ascii?Q?W6yC30sRg3USnvMzxKQv1qsd0TgK8Qdt5AZqswCK6ymLFPKhddgMJqrRUdOQ?=
 =?us-ascii?Q?2MJbT6v6cUru+LnvFuWIcOABFpSHjVvfGD7dcuToKpz1YYISm4/yXiJzxAht?=
 =?us-ascii?Q?NdQs60HViTGEY7greB/ly0B4z8gkAZjtUWW/VjwejazR0uR4osONdCSNRfM0?=
 =?us-ascii?Q?7EoNGMo4pR0zfyP0N/uT7pZ/ceYVJ46hmT8SvVQJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db27e1c7-5d27-413c-7307-08dd667d6879
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 00:31:36.8142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CP3ewm7ASjI1+1lqNxFY7G/heAH5zTylw0ldKF9/hm2o4/3eu/iB3FP/lxmuwYVF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5950
Received-SPF: permerror client-ip=2a01:111:f403:2412::628;
 envelope-from=jgg@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

On Tue, Mar 18, 2025 at 07:31:36PM +0100, Eric Auger wrote:
> Nevertheless I don't think anything prevents the acceleration granted
> device from also working with virtio/vhost devices for instance unless
> you unplug the existing infra.

If the accel mode is using something like vcmdq then it is not
possible to work since the invalidations won't even be trapped.

Even in the case where we trap the invalidations it sure is
complicated.. invalidation is done by ASID which is not obviously
related to any specific device. An ASID could be hidden inside a CD
table that is being HW accessed and also inside a CD table that is SW
accessed. The VMM has no way to know what is going on so you'd end up
forced to replicate all the ASID invalidations. :\

It just doesn't seem worthwhile to try to make it all work.

I'd suggest arranging to share some of the SMMUv3 emulation code,
maybe with a library/headerfile or something, but I think it does make
sense they would be different implementations given how completely
different they should be.

Jason

