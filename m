Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBB6CD4F24
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 11:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN7u3-0001Tw-8c; Wed, 13 May 2026 07:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1wN7tY-0001Oo-NP; Wed, 13 May 2026 07:37:00 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1wN7tW-0005HV-Nq; Wed, 13 May 2026 07:36:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e53jCUf/g7CR/ir4jySFOcKcZHNfhlU9KFcEtGgM1dXiR+t8Q58eQ+hvlkpFXq3stsD5d7VFOPLD07j6K3EVJlyUjEGEvVau8C0t0Ylvicjpp8L8kfJREGoB6hV8vP/Ba5CwkPZ8Urk6weyzOFj3QXsaskoY7DnKE1rihMzADTigANKp+BfstWzZdJYOXOY9xVoYkSu/oFlYxlCq0+DgFJvz0NWz09DAcc8IYhiWKarHccCRYeGENEf2E9QUCge8D4tWlB2d+W+/aQxpGC86Nua6MJ1l1lXsyMPOhuB85I7EL798VKQZB12JRDnofW05MUftTBQt1vhEkWJV8+ukGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPYRnbL5Qwc6rldSIrB2QPaJTyupM39YJBQiYdIvOpg=;
 b=m3gePp+f7RXopFE7Xe5vQYye27ibyYkzpBhOulpvO9jTjPeMzrWYabSK2Ffsc2ybx6CKFNgENJT2DVLLH9EQCXRSzE1M70XqVQgyNtFIfa8puWhgPbT8E2hbetgvp/eCDhxO4eJpo43CBF70ovyi2H45JDgrddf8QJ/2lH5mXNkEgPetLJoydzakgJXsZxTRyYzGm4LQ6jUepNMJbHltZczJhiLznylWlx8LH3BDTYHuykXc7s6IZVux0Q0OCptEDmj1/RjWH8Jkhq7qwibfpCBwe4WPbAT1L0VIq4njhLZ4oOzOTWy145OwLE9/ZOrXYRd97mQCYBSrbuoNxhS/7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPYRnbL5Qwc6rldSIrB2QPaJTyupM39YJBQiYdIvOpg=;
 b=jftK39CxvlI+wV3XvgWwsve8Du6wwIsig7P/f5GXr6h6ftL0xDNBi+fKoTvL6Ox019y3MmbvRaKzkO4cX2PuGaBE2NdJ9aw7JEPcUjr2tx+wkeIfyolO8zXbzt9g0MzmLjSSbd3WGYRc14aDw3EBTHfcsJwmbkM0PN57H09Dx+9+NUGSXkz3hy2CfnCnv4avRh9o/CmTr1rR8NJgfjJKa7NIFWJ68hm0ieDmrgYsSwLjWBZJXnOqs5ZJOul9eM9VzE3AH5yDu9eemMYWy5nU516RaNAcUvQ3tBJ4saQoE2liu/kC9thjYjuvaKu/O6f7txXX5BDhk5ChUf8SFk5lHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB8072.namprd12.prod.outlook.com (2603:10b6:8:dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 11:36:43 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 11:36:42 +0000
Date: Wed, 13 May 2026 08:36:41 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex@shazbot.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@nvidia.com>,
 Tushar Dave <tdave@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Ard Biesheuvel <ardb@kernel.org>,
 "devel@edk2.groups.io" <devel@edk2.groups.io>,
 qemu-devel@nongnu.org, Shameer Kolothum <skolothumtho@nvidia.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 marcel.apfelbaum@gmail.com
Subject: Re: [edk2-devel] [RFC PATCH 0/8] hw/arm/virt, hw/pci: PCI
 pre-enumeration and fixed BAR allocation
Message-ID: <20260513113641.GD7655@nvidia.com>
References: <20260508183717.193630-1-tdave@nvidia.com>
 <22cf37c2-b2b1-40db-b8b7-393b6c36a921@app.fastmail.com>
 <db604efd-9c1f-44e0-9921-71e4d97a81b3@nvidia.com>
 <20260512170650.4551c9f6@nvidia.com>
 <20260512191140-mutt-send-email-mst@kernel.org>
 <382877be-edad-4eca-a646-a75e1654747f@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <382877be-edad-4eca-a646-a75e1654747f@app.fastmail.com>
X-ClientProxiedBy: YT4PR01CA0403.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: bc46fd39-c23c-4f88-f4cf-08deb0e3e7c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: kHEKR0Wak9jT02RjraM+O8Z5u2gq2hujYOQE8hYrxzM+hsZOjO6dFOZ/AqTgrBDoZ6wTt5OVO4nPfiud7JfaYoh//qTyXBj8TNSOkdMbE3xANrLLYd1pT1dNtPium47eIfCdTDWGoFI3B0ossqLxHySM2kSYVlhrNUx8IBY0F4HeV6sSai8rkkIKjZ7QtF6qMnIxpBBL3BIe1cecbO1S+YgfjD16VEbnIg3ux33pjH2ML1yFTACui4DChoU6vm0IoFpBvBZB1N545k0ksiaeJtfLQU07D7ZXby34oc839POJl8iFGo6hQVb1AwHU3rkvjck41F/F9HmE7v5AkEN+BOZjQ5IAqPW5S+IuOxerObP90kmpAIs42TWDeTuG8GN6oYphA0DU6CjR5giXVTHoTIqGgL57SIxWCL5WOupT2jrc+XGqI3f1IAhRxx9x6BiEEbFjuxcyKOEwT3NTRh+/3yXPVbsBoFEYxEW75lpEIPmvANcs08Cd6C4Bv3tWVH9lN7ixJENlC3eG8OxjrhJgk2tjRyDNRYjY+sVll95Q/6wSdiUkMV0d+3TNFLXYeTgN/ImdAU75iJ3CPWW6Ez8ELJFFjrjLqQhEL99ZaDiJgxJAod6GT5/OsHInyUuHnYeGqCGLNiJfR31Yy5MdOcHpnooPQ5F5IACWzR64FcrUtC1lmep487z9zUR4ukUWGGyc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1UnObaJQKdmMmSlEFDVIOCJ0A6017LHVAYI9fmyCBTAVE9G8DpKmdqvoK0Ag?=
 =?us-ascii?Q?SSaJ9XV7u6j4L0jby5B/vScdSmvYDoDmT7dG9+XxZkFxHKmmtVcUh7mxU5QA?=
 =?us-ascii?Q?sN3irqZx7l+Ad1xMfrgwaV32n20EMsMFn7/AyVliwHG1CAH2WdfaL2ZjKKLW?=
 =?us-ascii?Q?XJ2xjmhZNx+/c41hlc/QwKXOsjE/XPi6f+ZCAwjWnanwKNVU02FZpxyZmHL7?=
 =?us-ascii?Q?c6di+1241N+01AJDL1WPxgDHUo5tXm+qL5N4gHy9zOvL5QEomuCuqB5avpKJ?=
 =?us-ascii?Q?pQjcDcxughI3rqhAnC5WWWwADmNVO9J9GsBqrGBVO65iki61UkeOug/9spyn?=
 =?us-ascii?Q?AYEYP9E8gi9kH+gBY+SHNf2DTsA55ad3dwyfpyL+WN/nNDl6lttsLcd0C2Wl?=
 =?us-ascii?Q?OLu9aFpV9BYsElgK3hUJQ4tj4/woC4viBVgUMcuRZi7XJX3sxNyu3R8ymf/p?=
 =?us-ascii?Q?gmRzxmPRD26Xj2rybmCKk/UAJsurzJieQHj4qs1IxMjk5oERNG3j65ABaeU/?=
 =?us-ascii?Q?44+S/s0a1gRpLx/MORkfdiIBUxCJ5pctTq2oLSRnitSUtos8vDm8M+b5Q1DF?=
 =?us-ascii?Q?JK5zJLAjlyi/J5MtvaRAJCtuqVZcB9xHVKiDXJHTBPYEAG2D4Aed51hBkFEU?=
 =?us-ascii?Q?iQyU/b/q7gnWB5p00hHazF5mnV31VuMvysImYGOJ/s0179n40vBE3Ucr6Ai+?=
 =?us-ascii?Q?I9OU3cZuEHQinZ9djBj+VYdFvFwzdIkqQ3hB0dDJSroEicIjU8Q2Hjf/ihtd?=
 =?us-ascii?Q?QBSaXEfwDwMfXErTKy8ZtVGWjzC0ZKi6OlwQgYJDhTRX6mfib2U6egr5ejzV?=
 =?us-ascii?Q?ADCSeW6LGMgER78KAmWd7WrYSH/QRBJ3WA2dvzWZGdfiy6FpDnTvfVh9NY98?=
 =?us-ascii?Q?cXUXW2+BI7fwWt4ESBO+9I6Udtwk7wA+IImg0MKMaoi+E8xwW68hfDmGGU7f?=
 =?us-ascii?Q?oLmuDVeEhYP09k/qLab4dPZlk4ZV/trzzvbxX+zI7eNGf+AN/nPdVngKd2rh?=
 =?us-ascii?Q?FSOBmqsbYOKkmy1C0f1uPhBGsmDtez70S0Wv+gEJyyo8AKemaItSGBYwl4wU?=
 =?us-ascii?Q?5oYoSyACc+wc1m9CkuN30qVfuud1ru9WFxl9vXy2mdHsBn4SKXQdjBlcbrU/?=
 =?us-ascii?Q?mBsaWhN/xhX03zY81lK0zHTZRWpIRmmc+fjK/2GNr0bobyexjj4R6ozcocU3?=
 =?us-ascii?Q?+AwRbbREbJ21JnmakhK0SCPbNjAjH5hsaLcipkYM6qPVQ8fgpjOX/D/ugTw7?=
 =?us-ascii?Q?5WIE9MW/iVHiLpzmo7wUlTJJTNhrCTBsoAdZ2C9sQQJhT7oa/DvfUhuzLmSc?=
 =?us-ascii?Q?7Q/ByBzM6d5r21JQroyve2wlrM28QxVSEGqifmT4fDzVTE/ZW45d/BsFg1DL?=
 =?us-ascii?Q?UMjdSo0KKd/yqQB6GvtJlVQbdUx5nps7xR96TbJoiQo2yzu9seWwUkazU3ne?=
 =?us-ascii?Q?d39rnPfyJzlothDxcAD1mXldFAjKkLQ9FA5CgIS/3jZuJVgG1zpylrYngAhg?=
 =?us-ascii?Q?s7/2LBGwXLOnGxh0h90S2i8QDrktgxbUOYMwKXaSXi4/vklWlSLoZJy0+YLJ?=
 =?us-ascii?Q?PZuu2sKrT4SpGCGOlkSKYXHcwJldAV3Q1+xvG0VilMsNe4fmpRT/uARnjt6q?=
 =?us-ascii?Q?08VbaqUTk5RGMNzpsu7Oef4kNonAz3ly+QX9mVEC883gLIbp8R2EhjylD3R1?=
 =?us-ascii?Q?CTa3HiXAZlNq2H+kk7tIGdA25HcZq7VPdl4wrxk/rLwXnm7b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc46fd39-c23c-4f88-f4cf-08deb0e3e7c8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 11:36:42.7840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dSa3U81dF1KVfXegh0S+qqVm2yqe5AwtgbXGWLUoQ+oI+gUtY8iFREf6n/13RGo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8072
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=jgg@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, May 12, 2026 at 05:57:19PM -0600, Alex Williamson wrote:
> On Tue, May 12, 2026, at 5:12 PM, Michael S. Tsirkin wrote:
> > On Tue, May 12, 2026 at 05:06:50PM -0600, Alex Williamson wrote:
> >> If we agree that homogeneous hierarchies (no mixing of EA and
> >> programmable BARs) is a reasonable constraint, and possibly extend that
> >> to homogeneous per host bridge to simplify the CRS mapping, we have the
> >> following work items:
> >> 
> >>  * Extend Linux EA support to program bridge apertures for subordinate
> >>    homogeneous EA hierarchies.
> >> 
> >>  * Develop options to virtualize programmable BARs as EA for vfio-pci
> >>    devices, if not generically for the benefit of testing.
> >> 
> >>  * Implement a way to poke holes in the VM address space and plumb
> >>    through to account for addresses used by EA devices.
> >> 
> >>  * Provide those same ranges to the guest via CRS (but not via DT to
> >>    EDK2), or alternatively expose them through additional PXB host
> >>    bridges.
> >> 
> >> Does that shape roughly seem accurate?  Are there additional gaps I've
> >> missed?  Thanks,
> >
> > just one question why not do it in firmware so windows
> > is thinkably also handled?
> 
> I suppose someone could chime in if they have a similar requirement
> for Windows guests.  Otherwise, the incremental effort to extend
> Linux EA support seems smaller, though I also don't know what, if
> any support Windows has for EA to bother.  Regardless, improving
> Linux EA support might help elsewhere and doesn't preclude edk2
> support in the future.  Thanks,

I think there are specific already deployed distros that need to work
under qemu though - so I would discount anything that needs kernel
changes to work

Jason

