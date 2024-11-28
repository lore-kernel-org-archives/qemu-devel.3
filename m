Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7F3D3B9BD
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 04:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGWOw-0003rA-QK; Wed, 27 Nov 2024 23:45:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tGWOv-0003qO-3U; Wed, 27 Nov 2024 23:45:13 -0500
Received: from mail-mw2nam10on20612.outbound.protection.outlook.com
 ([2a01:111:f403:2412::612]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tGWOt-0004Sa-9P; Wed, 27 Nov 2024 23:45:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWN4Ke2Mxa5Sewn3BnLwKTeyuuuysglEPKQSXBCPH3JPuwYsRgETox1EAFdUpH4adBqQLVDb8IJ/X1nnzIBBzDVsiaAkoA93BCQ28oRS7znqFeqkOQBoGL4CFLNECmuek5I5CIidu70Q/AyKsyMw/8e3/IoyZ2F0AaPfx+1GrgknBKNtBwFIXhlL68MT17tJO05b2+jnHKILTvrxpkIBc8qIz4SMWVgnflwEModiBw+vvr18VR/L4WCmsm6GmPq2aeh1CCX528JHz5LS/hVrWopxY4p3FIytqrLF4rALMZ3QeWA6H8UiFA4Hk0ZtJIDW90C7SXedjfHkUtM2jApmtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24CnnwibTqkFzsMTAhCYYzYkRFfzYLM494as2uUvg/U=;
 b=WFmU5k0fylCayd4UxT33lXFRixgE/9L9inKUbdFPcLtTcrlKyYtQl84xPNoVbrT769e4HxFdjcY1c+53NI7lsUhzsRK4YPPVU0dXTF2MHOKTczapkpxp5F+qvhNhQ9MQ+gLl3hpEQ+bawVaqBS6mGRHkbncSkZ65IXo9aEF+IWV9EQPR2Wk+b3jj9PbejlD3sk49k+8kqoXk4rSTe+Zo0sOC9hiCsd0I5qItsxGTFb99KIHdNcTknHY2wZ/gGt+VNEkyVEyArPJqXNNO9tWV4Mu6d0IqUIPYBNtOvEhG1Zn3N+EFpKgs/0rdVMfcFKQHpVNjuNcMKgRySV8AVQJAhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24CnnwibTqkFzsMTAhCYYzYkRFfzYLM494as2uUvg/U=;
 b=Xp+EYpatRwQGwIczFbhylyVWKbMcbKFmPtNpe8yQmOXyu7kqxyUugDsEIodIj/coNNBgFK07NTdE9o+UfRY04TOam07UteELdCfahlzWZAWGlp3SyO5JRJUVaK5VO7uhm3rD6rzP7Oo5qzKvoNYfyVutooTC5ED3XDdkYVA+KL7bHDVt+EhAep8JMPWSNoGJkoCNLpBnLue6RkUQKxkPLOAF3V7miiGNyKjQct2JAwQSLpy7wGw4hFkBkKvL5Pf5rFj9+3ls20FHpYjrh0/EGoG2/p22KA3uwng5jW/1yEtvSSANhGWeroMXfbNFEkFphBPwJwbh2P85ANi/V6Ixzw==
Received: from CH0P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::20)
 by DS0PR12MB6654.namprd12.prod.outlook.com (2603:10b6:8:d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Thu, 28 Nov
 2024 04:44:59 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::9) by CH0P221CA0024.outlook.office365.com
 (2603:10b6:610:11c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12 via Frontend Transport; Thu,
 28 Nov 2024 04:44:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.12 via Frontend Transport; Thu, 28 Nov 2024 04:44:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 27 Nov
 2024 20:44:50 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 27 Nov
 2024 20:44:49 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 27 Nov 2024 20:44:48 -0800
Date: Wed, 27 Nov 2024 20:44:47 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Donald Dutile <ddutile@redhat.com>
CC: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, "Eric
 Auger" <eric.auger@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "jgg@nvidia.com" <jgg@nvidia.com>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH 2/5] hw/arm/smmuv3: Add initial support for SMMUv3
 Nested device
Message-ID: <Z0f1P/Tie2Yhe1dv@Asurada-Nvidia>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-3-shameerali.kolothum.thodi@huawei.com>
 <00e8a5d6-c926-44bb-8d11-dab4ddc4820d@redhat.com>
 <ZzTqXCFKV9s++C2N@Asurada-Nvidia>
 <cfe8864c-f830-4b39-b4d5-f219f5a42eea@redhat.com>
 <d8fbaa677771425dac985438b4b1db59@huawei.com>
 <04c73d87-35ce-4e11-a906-17c1e2961387@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <04c73d87-35ce-4e11-a906-17c1e2961387@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|DS0PR12MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 8561447f-a3f5-4203-2935-08dd0f676a63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/CH/vfNCcJUiVd58rzBGYyBgXL4FOQdivjTRlPn3tHM8G6pmfQN6aCSuq27Y?=
 =?us-ascii?Q?1xOP0tnAq92GqXv9+/sHsmPWerd4uS0+4/CTY94cvKpvEetoevvHz081Wie1?=
 =?us-ascii?Q?rTJfNPtNtUy2kKwo7VoKtSJklSsJq8WU7nic/i8pMIb5EpmeiND0TDhr544S?=
 =?us-ascii?Q?QaVoz22NWdH6mkPuZmJSpacCsqqx8G1LHXHgGSNhau/DeFCKnGT9UlIaR1u+?=
 =?us-ascii?Q?D1ovitVhCkdiuBHYC4WnFTYBObLHdvb4OVShUO5/oOwgc8tUrY2r+56Bv7kV?=
 =?us-ascii?Q?XwmSh0MqIc/I8gDpaMf2SnU38p43Plue1lL5xHlzPgn77zeLspdQqK8I4cn/?=
 =?us-ascii?Q?aKKdwCr5tw4cn2Dy2ne4LTJ1Eus5Sd5X3zr+yKNed0RTD52E8TazJ72omH8j?=
 =?us-ascii?Q?7D/9SbXhZOYqjxnENNlwM0E7NxTPUk2HCrpi4stmkbhmLU/pbhR1pqXAOOE8?=
 =?us-ascii?Q?lk56dRZg2qPY8ARdkff+2GoIKqYP+jKNejhKTzSLEoCAoCzJk9MUruw2shPq?=
 =?us-ascii?Q?EPUa6C8ZKY1LqKJjNXQP82mewenkUqxrMUAZmFKYVV1wHSHhWCVMh3Z2N946?=
 =?us-ascii?Q?Q5nYXmasjErTMtMlBkU1UiI1GkoFrRYLJEYEG42C+u8hLmwxCOILaZP0ieRc?=
 =?us-ascii?Q?r28SMDmybP5cofZuMbNQnlgFVxnZQg9A7UimqjE9YwEkq46JDbGWXtMXkmcQ?=
 =?us-ascii?Q?u/IhgnI/y+A1hf9p94woGBfQPxBAZD99oNs1BteCD+kj0FjD1dB4UNfT1KjE?=
 =?us-ascii?Q?DyKuQlIAdbeF/AaSP7CMEyXWhd28j26T8nLnU6+XNKHkGAdtjeU7Go57t4kZ?=
 =?us-ascii?Q?/87ph37pA3nNzQO4p2ntRQ0OeaVfluVdGoemi59hbt50wm/crLPJfndbLXPZ?=
 =?us-ascii?Q?N2GuQBZDy91hJDhY1B6B70i4C3hfDEGE6B8fYLRdwki7p6FQo2X+M5JkFFVD?=
 =?us-ascii?Q?0gG2sbom514PzQcf739f1S22/2UIuIeL+5ulBeiBeFYEkZP4vUhFmlYbaBnb?=
 =?us-ascii?Q?hXK78Kg0RVQGqMt3+Oimv4YM0Ql0TRRk4C+LPxUrv8f0nXdM1nEeopvE2zXk?=
 =?us-ascii?Q?aABliWmvaugoQT1HATg9a/VhCq2MYS1cE//vuRsFnIPfa+rzXTYfTiomc6DT?=
 =?us-ascii?Q?AVp5mcIq0xPLWLGNgq9L/XKwveCkwNNlAa/5paJ68zLH5LP6wQ9j30hcbRIQ?=
 =?us-ascii?Q?LuR4phYWjG+pLybw5srXqCzKbAkLPQz0O6Ahbp4eLWEm3ZQCKKBXMNOU3uX8?=
 =?us-ascii?Q?BRy32tHovG6tSPwBsm9E/taEFt98XDxLHcs2VGcjvZxF9jZfYoGRIDUW12W6?=
 =?us-ascii?Q?moSo932bWgQ+S7bs0kMVrMIxO3M5JLoN+EcDTuPyb1hIDC4Nk5Ibzp+mDFep?=
 =?us-ascii?Q?/XlrO32NaPFiVuO/UTHCIUflksJB21qsu5w4gMzAdFYgTWNcAHDIm0SwsZeT?=
 =?us-ascii?Q?tHGIIBuGCZz+go6nnH3+LlhWAnVelEa9?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 04:44:59.5691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8561447f-a3f5-4203-2935-08dd0f676a63
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6654
Received-SPF: softfail client-ip=2a01:111:f403:2412::612;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

On Wed, Nov 27, 2024 at 11:29:06PM -0500, Donald Dutile wrote:
> On 11/27/24 5:21 AM, Shameerali Kolothum Thodi wrote:
> > > > W.r.t naming, maybe something related to "hardware-accelerated"?
> > > > 
> > > Given that 'accel' has been used for hw-acceleration elsewhere, that seems
> > > like a reasonable 'mode'.
> > > But, it needs a paramater to state was is being accelerated.
> > > i.e., the more global 'accel=kvm' has 'kvm'.
> > 
> > I was thinking more like calling this hw accelerated nested SMMUv3 emulation
> > as 'smmuv3-accel'.  This avoids confusion with the already existing
> > 'iommu=smmuv3' that also has a nested emulation support.
> > 
> > ie,
> > -device arm-smmuv3-accel,id=smmuv1,bus=pcie.1 \
> > 
..
> I -think- you are saying below, that we have to think a bit more about this
> device tagging.  I'm thinking more like
>  - device arm-smmuv3,accel=<vcmdq>,id=smmu1,bus=pcie.1 \

I wonder if we really need a "vcmdq" enabling/disabling option?

Jason's suggested approach for a vIOMMU allocation is to retry-
on-failure, so my draft patches allocate a TEGRA241_CMDQV type
of vIOMMU first, and then fall back to a regular SMMUV3 type if
it fails. So, a host that doesn't have a VCMDQ capability could
still work with the fallback/default pathway.

Otherwise, we'd need to expose some sysfs node as you mentioned
in the other reply, for libvirt to set or hide a "vcmdq" option.

Thanks
Nicolin

