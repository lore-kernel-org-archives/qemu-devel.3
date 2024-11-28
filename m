Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B45D69104
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 12:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGe2f-0002io-BW; Thu, 28 Nov 2024 07:54:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tGe2V-0002et-4d; Thu, 28 Nov 2024 07:54:35 -0500
Received: from mail-sn1nam02on2062f.outbound.protection.outlook.com
 ([2a01:111:f403:2406::62f]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tGe2R-0006sD-RD; Thu, 28 Nov 2024 07:54:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4gLi3t9ycgfhOkzkmm0krFoHxHGN0FqNUVTwKezAvaKOp849RxlMfIljbVLGDdolG9jF11RDWg+UHou+PiB/Qk656bSKkqYbVpCfHSfwUlBkagPdhDQpOhxFnhe/lUIfpPL0UAf3aU04nuqldybCu/8F3X74tTKpMO47Q/1Bla9JjBSF5nFLbeYgcAAaOwrNsn1OEhhM2grLZQEijlTVW+t6vlOPtw7u6FlWzNOiMvZYul1M7zlEhvP5AH6VXAL5simMKfHaiP+DIBQqNmC7+GScYYp2kBPgE3FfzBrtq2awD6pohupOoubKyl1GcSAS8AgVLsp5reSvtuL3E++Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/J3rg/KZgiKFlTmLXYRqfi37IL0w2o6RTBZewb6cUs=;
 b=xpkH5cpf93qoUoFiJbFUeCEqpdSxvqTHDhrRxdHV/e5LVbFsn3lSQq9fbbgfOZVACZn3TWvmvg+jtBgAKfKD9TaFfyX1Hra2JW/cL222Z8ynDK4f3k/WCMYpkgxaIhHC8b2a5Oi9qkEFmtrggNJMR+2t4xZRxAnu5MHGn3QjeBGt/twb7azfGg6QA73PAcv157VpedjldffhpfEIjpfEmpRWiy7lGxADLC1fcSK64c1p2TgVP3VcKzEYMVGCa+rnEepT4MocspqIk+fOW4FD75PtSTBNeIQ9fjc3NwZzo78T1ZI5oS+CBCcYo9YwKzniS36ZTabH8A3SvGn5zY4oKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/J3rg/KZgiKFlTmLXYRqfi37IL0w2o6RTBZewb6cUs=;
 b=mFTzIBZSz7BTzHAFDnFjAQNCTPzNO4nbuET1dsPeYycQ3fMpx8aFUyhyQE5ioT/5ea4e6nad2OaUVAItLu73TBerZCHi9y/7Nff0xoktvd4BGnTQ4PdE2Ig0klwuM/uyum2cxdV8nh1RLr6UTE9uecEfsrbvJskFovX47YkPLovIQy9SNItvn2/SJdIoi9jVSfWCSRyKh4YLk/OxtJH2jUy/Kk0tZHjayV8drDiY1L0DygTvkJkl01jwvw/R12sxrvpskGR3Iiq0fI/fn+Sh1NSkSBnZXKXJ18qm/SIRXrSJDP9AMgNdjlc5o/5RKaGIU2+NKnXc2fgDobCo3IL5+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV3PR12MB9141.namprd12.prod.outlook.com (2603:10b6:408:1a7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.23; Thu, 28 Nov
 2024 12:54:27 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 12:54:27 +0000
Date: Thu, 28 Nov 2024 08:54:26 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Donald Dutile <ddutile@redhat.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Eric Auger <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH 2/5] hw/arm/smmuv3: Add initial support for SMMUv3
 Nested device
Message-ID: <20241128125426.GD1253388@nvidia.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-3-shameerali.kolothum.thodi@huawei.com>
 <00e8a5d6-c926-44bb-8d11-dab4ddc4820d@redhat.com>
 <ZzTqXCFKV9s++C2N@Asurada-Nvidia>
 <cfe8864c-f830-4b39-b4d5-f219f5a42eea@redhat.com>
 <d8fbaa677771425dac985438b4b1db59@huawei.com>
 <04c73d87-35ce-4e11-a906-17c1e2961387@redhat.com>
 <Z0f1P/Tie2Yhe1dv@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0f1P/Tie2Yhe1dv@Asurada-Nvidia>
X-ClientProxiedBy: BL1P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV3PR12MB9141:EE_
X-MS-Office365-Filtering-Correlation-Id: a8277a96-2280-4bf7-24f5-08dd0fabcacc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XXwXQaOXR7eq3lRVr97+hVOdWowtxWR5buL6Y8LeeTWgB5vKw9nFoGuVe9iI?=
 =?us-ascii?Q?6/S/wG19rIJlf0xREi5UqgRb1kWOnRr6QcOYEGm+nwq4YDRmx0rXmOHLRCxj?=
 =?us-ascii?Q?ccvy4KAddIP9jwoziTf/D9oqHX3fQu6vuzFFNKTUxlsy1NiF3/okfWmeGE16?=
 =?us-ascii?Q?LkyFyihM9gxoOpTuS4tsKpZ5FwfQWpaxGJzvkvemwvwFLEJfMPejk0cYRHnH?=
 =?us-ascii?Q?6/MzuolgOnOD9i0WDeIDfE8ykaRUhdJZTSpLzGvT/mtJxRHbDn9b9e8s4zn1?=
 =?us-ascii?Q?bdxuscWTgtGYz0wAwEIFTpMMe1I7/FFAq/4FCwm4+KkJDbupeGSOqwEl/R4A?=
 =?us-ascii?Q?2D5tmSYce5C5fCZow9XejvzGGkSDVdq5aoZ36fQexkXXJOxnfXwzSxvR+miv?=
 =?us-ascii?Q?tDdZKFNIPTOD4MCYm6jaVE1wN2fAxLM3dDG6x+Dly3bHUdX2ZYu8u/kDvSQT?=
 =?us-ascii?Q?8Nf1mx0X/OXjM6sJpiyijUQTG6eVyFrfPmpVMC5h+grSw2mpLVa/rEDay7Re?=
 =?us-ascii?Q?Nr9AzmQ7wq9sN85Fzshuid6jm9nICb9WIOIaquROP4UrMAWxRnd0e3ubzPxh?=
 =?us-ascii?Q?yHpJRkXyarNqjnsfnmEkhn/luW10InfCyGuLeaQ0anO6U/89HlAIbym50hN+?=
 =?us-ascii?Q?QzqdIFDhXqboUI+JVDbKhBH5dLpQARovYXgMl5MEN3hA3cEU1BLT8AQFXETG?=
 =?us-ascii?Q?pW+tE63PMIivDca4QQYKjHb0onygWBBsYoPS4FinViwFefO/gWaPYRnSWwGA?=
 =?us-ascii?Q?6flOVf2nL4OzjzYE8aMerVL493DlkUL0qZuDyhQs7uWgbjLu8uTJ9N2Pe0sJ?=
 =?us-ascii?Q?FFzNq/r3nc+7XKs/kQ0DA4PE+PK23pXWSfc2lQpa8DY9UgrlFwDRKqAsBV6a?=
 =?us-ascii?Q?I0jFW7i5xYl7m7MQKZVjeJNk3gTzhvIuF8cpdaE26Gx2j1dug2M88nZnpqfA?=
 =?us-ascii?Q?xgK7bNVhuLvkVHSGDKiUsYmKNQ/zU+QHu4G2voc9qzBVWbweMC2lEdTxZbzB?=
 =?us-ascii?Q?mjrEd1LbpxM6xLlE6X9f45/wAPwdxdmhAuvtnYK0sfxWMmKnP9CEhbdRuHK2?=
 =?us-ascii?Q?X3KpcY/aUOePzkvaMDwWWf0BXWJQ8Wxdg0PrHSLkra/Gr0TK7U6ccmSspNiZ?=
 =?us-ascii?Q?Gy1dbx7pTvX+9zYhCzhI6cAp3Bgawp6wLTaRzeqnunifn1U2AyOwjjOMMUjs?=
 =?us-ascii?Q?c54ohCqMHvdCEJNr3/0MAmj1W9xbHxgtPVuEoN0b5sETRw/heGWTsl8+9G9Q?=
 =?us-ascii?Q?LGvhaNFopQ7aFVhtS0Wtu0L3Y3VyWJSQ2N7Bome0RlYWWsa7YGkVg9o3vUrk?=
 =?us-ascii?Q?BoBI0hxWwMF5YwZt0TSJuNRJU424jYq/6rlJjbGAYcGpXA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+gazq8gJ8OqnmCYiVHX3kkSi4jTi3V5Pvw98IUomlxitYY+Yg+tePs3r1rpA?=
 =?us-ascii?Q?ORCPVgmOhSQLXh/Cw/LqraUl84T3DiOF0we2CiIjnxLFVs03HucLQiH9ZPNs?=
 =?us-ascii?Q?d71HXF6vYA4pFfvLMH55lIgohsLyJFhBG+e4Jlpvbi0/Y1/IkMSPeG2OJJJb?=
 =?us-ascii?Q?0GsOfFBKzJujW2urOtsndZb0Q+sipO3k0RGNK9j+UQmCC/ky7xx5Y3DpEsel?=
 =?us-ascii?Q?5uq6Y+eX7o27dQqbQoqJlqAxScjWIOTbshygsqzmq+TzhJls67lwtL226pay?=
 =?us-ascii?Q?VOvkeGewH1ORHhkY3CTbzNvhS9yLnykf3K5yRFZvaC0SX3FTnfwBQLS9wr+h?=
 =?us-ascii?Q?hvTkOd6VbBdf5joxqgyjRQQUu40DSYfym+XokOSqEA9rLGYlbuiQjuhnlVRQ?=
 =?us-ascii?Q?85FY6XfwCBjbMZXSC87ezCFMiF7KtDy1mW5GoAzyPhqvraypvIUcVPosacge?=
 =?us-ascii?Q?Do5d65R8cRQOTi1c0yCHI0memvombJOqI2tyHCQiEXBZGtDPdcFE1pXyleBf?=
 =?us-ascii?Q?o7RyY9/Q3+bX4uCIWsrGQtNlpjvcyHyw/wn9a8iSK9t/uv0AxUz8fgCfW+pK?=
 =?us-ascii?Q?wB7udgVo6zbod5XMMxtT+usfaoJXkuO+d7UUEaOFb0C8/4nxYzb72EZhv6tk?=
 =?us-ascii?Q?cmdehucm1R3KSgpgMNV9R/pa7ZCHU6ghdOnonEWRu8J26tu49TDr5SkHfBFw?=
 =?us-ascii?Q?+KeZQ/VQksCWcPTVajVPcG5+5UiUT9RgnLKBPrBZ6nJtK2jLc8f/lgDQrCwW?=
 =?us-ascii?Q?RcDX2alFYofqL6iIO9iOnF9Yt7c6RfFAPJRzqzRO4CWJ3mTzxJ/eY5zcInR7?=
 =?us-ascii?Q?44v9rpIX0yGkYjYr9nAsO08fK3bZiVXrHI4sbkaO4bIi0dtOohGd6yqNpQX/?=
 =?us-ascii?Q?aFixWSGThBkFafDWc1N9AmzyUGR5hyFEc80CZL0UgttSsiJKbElRo61AwxB9?=
 =?us-ascii?Q?gRVM/v5/GXHpWh8nUROPp8rTeQPwXZFGT8pDaPo/9MQ75IjMGVmah1MGT+zO?=
 =?us-ascii?Q?VjCij8IIm5s/A1zIHoAH86p4+mZ+s9mkaNS1oBuu4kVRF3WbOxoBSKIq2v2b?=
 =?us-ascii?Q?kzV/9RMbO/MZx2XZw8fOWfaexaRTbLN5DOUd7nU/UBRPPMo7s8dVEEtAGLql?=
 =?us-ascii?Q?YNVehqvU8NZJYdc5ugWd/q0P0pTBpCzej25MkZ+HlSJsV9HiCzhJiKUK4Oso?=
 =?us-ascii?Q?MptCCjRVdLXdkNED/XNfitTepagzx0PI6tQZHcVRuFe41tJlruFp624u6m6M?=
 =?us-ascii?Q?k7rLL46uMQiufeSsjjO4e9AYM43docXwvFRGmcBD0JX+jd4d8iF72qbmctCb?=
 =?us-ascii?Q?EQK1/ZplqcpEXV5q/tA86yPPhpasiUaKfjBC4Brdeloz0RETH90FohYnnC+Q?=
 =?us-ascii?Q?YkcUUCl1BoUCuRcBx2iPtbJRtQ47W1hEZGk2nXNboQFsMzjUJ+A09UMN4slH?=
 =?us-ascii?Q?GVxcjN7Am4SQr8yU2OP2L/hTJP4w3joG/wRi/AinKriQ43TU7/ox1Iwq2hA7?=
 =?us-ascii?Q?DyYjOdQExtQPAj2FMnU2OkQVy/OiMJAX+vjXokOsX5vHQ1IzbBcoJLsSRkQm?=
 =?us-ascii?Q?mRlZTO9teVWLCEmZSYvKDDwJqpfYIEtDYQChDsGL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8277a96-2280-4bf7-24f5-08dd0fabcacc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 12:54:27.3957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r207Z58hYgqGaxeGmroT7jeliwXSwEj9U3ODv/yiflD7CbbQkENzrby6n1r1ks8m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9141
Received-SPF: softfail client-ip=2a01:111:f403:2406::62f;
 envelope-from=jgg@nvidia.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
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

On Wed, Nov 27, 2024 at 08:44:47PM -0800, Nicolin Chen wrote:
> On Wed, Nov 27, 2024 at 11:29:06PM -0500, Donald Dutile wrote:
> > On 11/27/24 5:21 AM, Shameerali Kolothum Thodi wrote:
> > > > > W.r.t naming, maybe something related to "hardware-accelerated"?
> > > > > 
> > > > Given that 'accel' has been used for hw-acceleration elsewhere, that seems
> > > > like a reasonable 'mode'.
> > > > But, it needs a paramater to state was is being accelerated.
> > > > i.e., the more global 'accel=kvm' has 'kvm'.
> > > 
> > > I was thinking more like calling this hw accelerated nested SMMUv3 emulation
> > > as 'smmuv3-accel'.  This avoids confusion with the already existing
> > > 'iommu=smmuv3' that also has a nested emulation support.
> > > 
> > > ie,
> > > -device arm-smmuv3-accel,id=smmuv1,bus=pcie.1 \
> > > 
> ..
> > I -think- you are saying below, that we have to think a bit more about this
> > device tagging.  I'm thinking more like
> >  - device arm-smmuv3,accel=<vcmdq>,id=smmu1,bus=pcie.1 \
> 
> I wonder if we really need a "vcmdq" enabling/disabling option?
> 
> Jason's suggested approach for a vIOMMU allocation is to retry-
> on-failure, so my draft patches allocate a TEGRA241_CMDQV type
> of vIOMMU first, and then fall back to a regular SMMUV3 type if
> it fails. So, a host that doesn't have a VCMDQ capability could
> still work with the fallback/default pathway.

It needs to be configurable so the VM can be configured in a
consistent way across nodes

autodetection of host features is nice for experimenting but scale
deployments should precisely specify every detail about the VM and not
rely on host detection. Otherwise the VM instance type will be ill
defined..

Jason

