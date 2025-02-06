Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE51AC02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 21:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg99j-0002sN-6A; Thu, 06 Feb 2025 16:11:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tg99h-0002rY-Ne; Thu, 06 Feb 2025 16:11:25 -0500
Received: from mail-dm6nam12on2062b.outbound.protection.outlook.com
 ([2a01:111:f403:2417::62b]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tg99f-0001Ur-N0; Thu, 06 Feb 2025 16:11:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVkPGpfdXSgvFmBOtkpx91kR+N0RD2YWEraJ0h1lHFB/eWokqQEQp+aTc9g4TsnrkQejAnZxLZeO4ZJiohKQpBDwjCa7RG6moL8bFwdEgiX3ScyrGoHIju0MrmJAAX8VIYOmQkll0DE5pE38iWzDTorZigiV6dTVHJIlbG9s+9k9qr1hsxxooQSiek4grezuhlgdb+x11J1TkcFjogONhuvBt1qHJg4lJVxf/6jo1Z6XccWXiX/LMFvn/tNhJwZ62ioBsafFTZv4pssij6TGqOMcvWb36ceI9iR7dt+y7nuXkbXXyXrr+K1NSg68L6/gFFhA/Rc13f/sOGPXorQwyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjm+brYRgImuRK+H4hvyLSLocjfin0w+0EjGcgS8iJI=;
 b=WykP0Mnsiq4ka2hvhksTwUF5lJLroQkSQbA/W6UPG4PV3Us+bTzvISYJKyrWCBTzfkZ/4pUPDQHffahJoBH8L3jzm1kjCo6XL8qis116JS3sJvlF/U41S7qfvT3h1JX3ptvYL4pnpXKnwp/SVIICB34QWfCwvgEi8tOX0QJgJlCInqd8p2rowW8l+tycM7bz5grj6tHEHJOCF6I63oND3W2QWUSRGo4ccT64kMzmg3iO2MpfsgGsegphsscVqwadX7r31EbLwL9nMOy/RR43BrAvQbBwhq757VkmjEdeG8jhtJzGhD+Z9KSoZ320PPw+n3Q1SX4QTdQX1dGFbbOGAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjm+brYRgImuRK+H4hvyLSLocjfin0w+0EjGcgS8iJI=;
 b=uetVwDfzp7lNxkyPvMAO6IBtxV0//6h1OhGjR4l/xbrUu4J9fYAuz4b9KvrEK1icDKcmzVKqBxJUyRM2Kyq5f4grmmFR7HjhzG6n26g3iboyvZeKcb5X6s6EXkI9lS45jQ5n+sx6y59hUXCzrTD4EG/re43TvV/QH/fz0BF/Pbht1RIA9dZm+DAywJWKulyhUPZJCeSlgIOB+4szzsdIixfkhbJm0zNju6aYkg7jkH+vH5qFseorPqVfiAvrbmQwsC3WPODzhQaE/3tksRMKboebOaYU+R173xeblmRKqiLWAh3ccmnOYLzPRBQILzaYKHMZ5BAHbfQIxZ/+KMXPqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB7120.namprd12.prod.outlook.com (2603:10b6:303:222::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Thu, 6 Feb
 2025 21:11:15 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 21:11:15 +0000
Date: Thu, 6 Feb 2025 17:11:13 -0400
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
Message-ID: <20250206211113.GN2960738@nvidia.com>
References: <20250206174647.GA3480821@nvidia.com> <Z6T3cX_fM-aeYbMI@redhat.com>
 <20250206175843.GI2960738@nvidia.com>
 <13b1d8b97a314cb28b87563fa9b45299@huawei.com>
 <20250206181306.GK2960738@nvidia.com>
 <02a0080a4a1642d69b7f5dd4707a5b3d@huawei.com>
 <20250206182201.GL2960738@nvidia.com>
 <Z6Ucj/u3wt9muakb@Asurada-Nvidia>
 <20250206203855.GM2960738@nvidia.com>
 <Z6UgKHfGD34K3Rcs@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6UgKHfGD34K3Rcs@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0322.namprd03.prod.outlook.com
 (2603:10b6:408:112::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: fab59344-2b9d-4b92-b964-08dd46f2ca65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lKVCM90NXcW7ftvfvZ1ZomCnIfeX/9nAvHr/apEgxFvXn+btqRznJW6hi2hj?=
 =?us-ascii?Q?gpVp0yzGPhNQbKK2X/h6IIr4o3QfPjIgRgcn40EoMRIYHuz9aEEqcOaYk3Pi?=
 =?us-ascii?Q?SwQlueR1zYHGnChKV8cElfcXoJ69Dq+dzF+Vsf1SqDdSZBDl4UsJCnakspoD?=
 =?us-ascii?Q?Zf2c246Swh1FqX7cV/SVEwByELN+IUkgxi09b2Mtirsb9WW+y1yrtSK+sVix?=
 =?us-ascii?Q?irLPNq3uEyfFcovv+1UvVFV15Q1Nl/zTbBcSzkXc3cdJr9Smb0cgqApuvB89?=
 =?us-ascii?Q?ZAAMcvSyag+dn4JP4REXC0iQLcdukMwk/eaZ1skNh/dIf2bhcv6Gg5q3INpG?=
 =?us-ascii?Q?sEEtz0jRIof+YuRJLlk8llJq6uTbd14e2mNy9/qDdsKBWjy543bjN1gQ5E1I?=
 =?us-ascii?Q?Kg0KHU5j5nrQgJ+opzutsYHMbC8Um9/rCNV81uWdAfg5kvEYSWeBnluVbQds?=
 =?us-ascii?Q?0GuixPpj0P5Q+kvMCOWIfPehbsaxLOJElJ75dycoOda5Oq97bgA3ZI9WPlPi?=
 =?us-ascii?Q?vel7hfZpIGhtn5zcaFz+fVADx0D6Bc63IqcWzWwOBPxQlZmK3AS/EJG7lhB3?=
 =?us-ascii?Q?HBQffLcDb0JGc1IGQaHIG9Dj5vA691uzpXa8f7BhtnMibNTKTEH7evuCb+2i?=
 =?us-ascii?Q?ySDQ11tfeDI82ExlKp9Rfd/E05SHVfRofQ1cSXPirDoulanKraozt9Z8GNhu?=
 =?us-ascii?Q?1wl5wXKdMHab7b2wL1RUaoM7BkOyQojw/bZIRnPbwNeTP6WSIVzTmULt6wu/?=
 =?us-ascii?Q?QqijbHYsaBD/kuY4fLmnHeaC8e5a5tFjC/GylKf0bohi0LbUcbnhM9SoQ3Ly?=
 =?us-ascii?Q?hVjw0fchEr+fztqjuMlj93K+uHdm7UN7CtR8u/AStW8ECusGfwpXSYB808WP?=
 =?us-ascii?Q?X1m+uORepIgzF1XRebW62Yyu9wsSbdQkSKDIbkdwmwyMfzVAuPGAkKYpCgue?=
 =?us-ascii?Q?QeK8rHvVcGbQKPlu2htkYIJuVpzfLWkYCoLFSISJUJRIeMxiOrJFyCvLuxrU?=
 =?us-ascii?Q?z+NorWDbHvJo0XQc7CTqang6AZMi/gea7DEzVeFREsMiur6nz4hyoGaKNEOj?=
 =?us-ascii?Q?xiHn1iaO29fvXtQzeoTcO9rRvU42HJjeo+8ECpKckjy1jEcxj1tzAGeJibjU?=
 =?us-ascii?Q?b5Z9AmAhZqjR7kwcDoBlSeXjX0S1Qs5eFUjtMBxKQdvCSeWpOVA42/pLidan?=
 =?us-ascii?Q?DNEyVTbZO+dM0LIlfLmMxvQdUTxo2ibUBN0LBaAlG23flzq6aNMKEJxMwrmh?=
 =?us-ascii?Q?zA+EwtJIHsAgfodrLkEnpDjwIU9csZb0ElYUbRkconCXgTNOATsSafgf55Ik?=
 =?us-ascii?Q?KogS8nlO6xgc1j0hjUUOZni6uZLlDJ18yIY8rGjoDp6cWP7HI+DXLPMm5vtZ?=
 =?us-ascii?Q?hVAgF2PHUjAC4Eoz+kGz+/9r+wBr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?celPVHehgChHtGYBBHP99bmZ6RLQF2UB2TnnoGadLmwL8mIhuf4/YjBUcIrI?=
 =?us-ascii?Q?3dQC+IaDuvpZru7CE5QLxNfHX6b2UYEwI3CLz3IZWBl6V+hwp/7dClZLZVCI?=
 =?us-ascii?Q?cBa0iOYFsSoxMPgdXV3uHkzul6M27LWilANRGtCp8iYAG3mCLXZg633yM/oJ?=
 =?us-ascii?Q?QlNYXZUuuEO57pSzQJwUohUfgE9CMbXgdv9rRQJF9bEHraqu+3Y0nQHgAYld?=
 =?us-ascii?Q?/RFK7GzhONiD+M+m/S4qly//3tBkDVQwTJ/sO21l30ePmqfhSm6vaPNqu01o?=
 =?us-ascii?Q?BSPUtY6RQUkD680NL2H7kSNDZnCkzvA54+IxVPtu9x7Hwfpq4VmNrl/nuJmG?=
 =?us-ascii?Q?PJrUdePS+J01pPCW6Wm3tMcISIX2/ry75ZFtPHeWQqzdBJLNGLmekUjjxA4E?=
 =?us-ascii?Q?2dSkwHITiFj7R9S1/ek7Pgg3lfXwOEyhbOnz8Nb5cbV+wwDhQqMpEjiFMf+r?=
 =?us-ascii?Q?pOQ81sxM8kPGHOlaiKYRzKJXbR7txN2N/GwEqENJwvUKNIe6ABy+7StU+vNm?=
 =?us-ascii?Q?BBQED6lQ7m29TtKgUJAe87zn2E9zAbv5y5FJ/tqkTqui8PAOK8pkLhdpPi+J?=
 =?us-ascii?Q?8MP2/BR7qrAAZvoqmfPB8Cq53F9+K0nARXrUFwnDCxBkNClNBXr+a0tvlx3+?=
 =?us-ascii?Q?/4o0mh5Ux2PaYiiZ9aOh29/1O3OqZ52RGfoytN/rLQqx6m0bbNY3OXJ/2ZRY?=
 =?us-ascii?Q?BTr4ve+bbLEMlQ7SwZV1cdT7k3LIOCwSBv/O5lpyKzsqtGkZgj8RjgYLwi5M?=
 =?us-ascii?Q?tytUj2OvwcR3eYJSSIMVVSG2VO34UZvw/1GK5tNKTuYN/SRchykFxckb1zJy?=
 =?us-ascii?Q?Bs3MXm6t8W2vNobIwWE93zyWvBNFUr5fzgm17hmcwTtRloJzpafN9y3zPTFJ?=
 =?us-ascii?Q?0Mg10sS07QfIHpVf+q2CsF+OMwEgsi9RH1C0XaANJA0c6Q0Q9aupXzv/5Ncx?=
 =?us-ascii?Q?yFDeS80C2Rocw/k6dZu0jkPAkNQhHzvB+m0c3FDayyxfLjjfGUL/cworyM79?=
 =?us-ascii?Q?XKZKSWJx4w0xXzmGEEJO5nACarzGAMGQ2Pb95s8d+hHTglvfozV7XspaQq19?=
 =?us-ascii?Q?fC5L9h2uEtME3ljAZ28ivd9rAd0EEUDY4YawxpPNK0mpddQZGR1HROVMZH22?=
 =?us-ascii?Q?ThWekJnrF5DnWb86Pvzq8xKrey9C61t/9KH2aF7pWZZ8fsMIhOhwkyQrmnyH?=
 =?us-ascii?Q?Qrx6cTShjczM7xdd4KxiQMai+Hbx5KUbvZ6KOgShwNjkchw0w8Y/MsgWngFy?=
 =?us-ascii?Q?echypL70RsAD018ooaSeWug4tUjjxXyYCb9bh1eThZoEpEpDHKaOj8jTiPwv?=
 =?us-ascii?Q?0E6Ug8lUqRVmHxYVVTvbddUkLoYtcaFcWXrvvLPBWpJEG+35DI3tM7L+dhcV?=
 =?us-ascii?Q?HAuknPKwzywOXCL2v+MVf7NAsdQ/QdJjB1omT2mMvdM8ft0LpGhNAkFBkK6Y?=
 =?us-ascii?Q?HKlc1fM9arux5GoD/duYifUQ58umCoWhRKtqlrwIOi5TK7fku7KXs9cIQgDf?=
 =?us-ascii?Q?ml0Aa0ay/tpDyuvwLSzIlw02tms/lDdx74m2iDlSFMjjuUZ80MFV+c4HE1s/?=
 =?us-ascii?Q?65FhOtKZ1T3G6brMiyxR+fMEFt7H+w4r0LmBKjG+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab59344-2b9d-4b92-b964-08dd46f2ca65
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 21:11:15.0310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eX0JOktidNrthYQccwkzLqZRJhibglbY1iVMPiNXK1dIkJpwN4Aflyf7XCWF0Q0D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7120
Received-SPF: softfail client-ip=2a01:111:f403:2417::62b;
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

On Thu, Feb 06, 2025 at 12:48:40PM -0800, Nicolin Chen wrote:
> On Thu, Feb 06, 2025 at 04:38:55PM -0400, Jason Gunthorpe wrote:
> > On Thu, Feb 06, 2025 at 12:33:19PM -0800, Nicolin Chen wrote:
> > > On Thu, Feb 06, 2025 at 02:22:01PM -0400, Jason Gunthorpe wrote:
> > > > On Thu, Feb 06, 2025 at 06:18:14PM +0000, Shameerali Kolothum Thodi wrote:
> > > > 
> > > > > > So even if you invent an iommu ID we cannot accept it as a handle to
> > > > > > create viommu in iommufd.
> > > > > 
> > > > > Creating the vIOMMU only happens when the user does a  cold/hot plug of
> > > > > a VFIO device. At that time Qemu checks whether the assigned id matches
> > > > > with whatever the kernel tell it. 
> > > > 
> > > > This is not hard up until the guest is started. If you boot a guest
> > > > without a backing viommu iommufd object then there will be some more
> > > > complexities.
> > > 
> > > Yea, I imagined that things would be complicated with hotplugs..
> > > 
> > > On one hand, I got the part that we need some fixed link forehand
> > > to ease migration/hotplugs.
> > > 
> > > On the other hand, all IOMMUFD ioctls need a VFIO device FD, which
> > > brings the immediate attention that we cannot even decide vSMMU's
> > > capabilities being reflected in its IDR/IIDR registers, without a
> > > coldplug device
> > 
> > As Daniel was saying this all has to be specifiable on the command
> > line.
> > 
> > IMHO if the vSMMU is not fully specified by the time the boot happens
> > (either explicity via command line or implicitly by querying the live
> > HW) then it qemu should fail.
> 
> Though that makes sense, that would assume we could only support
> the case where a VM has at least one cold plug device per vSMMU?
> 
> Otherwise, even if we specify vSMMU to which pSMMU via a command
> line, we can't get access to the pSMMU via IOMMU_GET_HW_INFO..

You'd use the command line information and wouldn't need GET_HW_INFO,
it would be complicated

Jason

