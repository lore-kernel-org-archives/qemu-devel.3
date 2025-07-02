Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A8BC83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 22:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX5ZP-0006dL-NX; Wed, 02 Jul 2025 18:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uX5ZH-0006Tt-CD; Wed, 02 Jul 2025 18:04:39 -0400
Received: from mail-dm6nam11on20605.outbound.protection.outlook.com
 ([2a01:111:f403:2415::605]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uX5ZB-0004ds-TK; Wed, 02 Jul 2025 18:04:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHsM4hu7Sx8AHgcQYtRNxXkdOK1/g8Q/8O3z/z7PYoNoglUc6Xf+NhHwe9O5r1uo/ExoiSnVrhFTVGw+MMdsyRhiXxP5Kzi1CZie8D2nXetKPvyqME9KBAQRZ58xrFnSgyT9VmhBiS+qFJX8Hub/vm7eumrdGVphLJQYI4gwuiIFnidUdexii5RsDIi2EbFG/mWYA1nJz8iS1eBATVN3L/mbq6+nnJIfoc5RqZFYcl6n0JV+/JkAb5O38kNvkm6Kuy6HzupJUig1FIpJR7HDWGgJGQp+r4JNe+bN0ntriKR73OiBN8HK7TikLdqDj8jJkZKDKpiXYpJ1oc/j0kMPOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cZ7I9miGdZ/87WTsuca9UmguwAQbWShBZECkgBqbFA=;
 b=L+OoVGdiD3bsCdny+7r32hvYuWxPT2l8LL3pv/vnqNFjjzTQMZ8CBqTJczEKwwbz6QSI4iw1w75uDQk1Nh1hE/h/gyf6whwZK5u2hHgkxTcjWxXYcbDAt9dcU/f89DK6ZLvbSHFjpQTO0M4Ym7+1HWi+qXwuGbAGmsfz2d7VkhAGf2GVuAk9gH/bolw/MSaaXu7Zklz5pc37+1UwQyb1l148fwRl6FpL5mvMFU80xGeodt4sE9gyh1yF6UPV5gPkJz6hoOJtU9JkLzKJjrrbMJL1EAOQ/o7LwSVgipBb7GErgT0nrKmw69mbnsmTUJSgfeHPzuvfsoLnPx5PmupjXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cZ7I9miGdZ/87WTsuca9UmguwAQbWShBZECkgBqbFA=;
 b=k5G8GGS8iHrV7dieuPR3uXYrRLL58Z/cHcs1aJ20g8UipHuQk5vtJ47JP3Sy5zWdKxQOUglhF5/ezuERDMTES6M+NrWKK2p4fbEtVhrUMqzkFImglfA4C9SbvsZzzhmWzb5z38t8Z/zwr96jnrEpilj8V0Fgi9a+mf2nCun9Cw/4iYHtgU5dYL7IP2bb/lTLuRLPgninxr1IIRFSv+XkMmiauCglG5NQ2u24LbQxbip0bucKMKznJIkgPYDeN7KcgqB3/FkPVv77smkWkmOC8pyuQzv4LYAzCPSSQ2KkSM2KRckk9nLv/1MWrQu4yb06VPRyIx4mkuD+9+ZEvOSivA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23)
 by LV2PR12MB5991.namprd12.prod.outlook.com (2603:10b6:408:14f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 22:04:28 +0000
Received: from CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787]) by CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787%4]) with mapi id 15.20.8880.021; Wed, 2 Jul 2025
 22:04:28 +0000
Date: Wed, 2 Jul 2025 15:04:26 -0700
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Joel Stanley <joel@jms.id.au>, Troy Lee <leetroy@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH 4/4] hw/arm/aspeed: Add GB200 BMC target
Message-ID: <aGWs6pCzR709wSvb@edtanousvm.nvidia.com>
References: <20250701203400.71677-1-etanous@nvidia.com>
 <20250701203400.71677-5-etanous@nvidia.com>
 <cd18291c-86b8-4b95-b587-5bc404a2cae2@kaod.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd18291c-86b8-4b95-b587-5bc404a2cae2@kaod.org>
X-ClientProxiedBy: PH7PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:510:33d::26) To CH2PR12MB4277.namprd12.prod.outlook.com
 (2603:10b6:610:ae::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4277:EE_|LV2PR12MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: d70cf683-9fac-469c-ebd9-08ddb9b469dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?sLMR+gH0xOruuzCcEWeWcc+7AHXRuH/Bzw8P53JlDLONaBvIADE6XSn2sU?=
 =?iso-8859-1?Q?1Zm54hwILowQpr0LbY+cnI8dzp91VeifdkqwYOz+SnSEsMaOxmTA2zZnWM?=
 =?iso-8859-1?Q?NBvicG0ugRRAvlFQvU2ooCx12wZldRwDN9uDi5pOstiF+LPmEyOaIJrHTE?=
 =?iso-8859-1?Q?ewZBXJ6B/HKorH+LXDbszUeZ0KArIlI4iLM4FnnfT9rLWCRQI74j5sjIU4?=
 =?iso-8859-1?Q?vbawQHeChQamVtdE4+nQY8JD0KGgKVsfQ7cSpL85eZqujFQUlldk9k0z/m?=
 =?iso-8859-1?Q?muJlE2tK2KNN5j4j36w1enQpi9Wm9RNiLmRCwHkg2W8qXdEMqcHORmlN06?=
 =?iso-8859-1?Q?vwZsDLaFDGCaGTrNb6uZCQZhJBqYOpqgSSKX7l17WQA9qxJ6Iq/sN6xqHR?=
 =?iso-8859-1?Q?PWjh05BZ/fqOy+t2NdL0jHGMp2pj3AthBbgO/Utin5FogKAPQ1+14bm1iN?=
 =?iso-8859-1?Q?50z5u0+V9ofMoVuibgxQVD77ml5g81ymZVm39Y9Kxr086RQ0/aFDCCvuJL?=
 =?iso-8859-1?Q?7GlL4iRY/CvwUkjaO82FBWdSwuHYYxb/NInBpmd8WhXW69I8g3O9BwKF5H?=
 =?iso-8859-1?Q?HCbJXWVFxkRjFINn/QZlvzII9RGTZuIpltLFFEYFmUAqlF34AoAhGDDxRT?=
 =?iso-8859-1?Q?UBmNJWt+Uk1Hzl7UoMA36PEYjKuRRLHqpcdHU/Nv+zKhVEFDLQt39KlWtW?=
 =?iso-8859-1?Q?mjk6mB4NhkdTXcfKIs6FZjZ2a+/k51dzRp/3MKnwqWIoHl7qrJgJgptb9g?=
 =?iso-8859-1?Q?oGxYj3BJrUsNENempGhrS5/9MEiDDmu7GIk2tc04VLPYh+OGAHvQPji3+4?=
 =?iso-8859-1?Q?/jzM84370Z/YqP1GZiN6uY+ikaXVj12sWUr/iyYETCJ2YSfUu8hzGPI/aI?=
 =?iso-8859-1?Q?JiSVz1ffquhRieGGmrj2vkmsHTroTNEy0ETwZBiJtAQUXi/s1qs1/1YeZ+?=
 =?iso-8859-1?Q?6atlb3d3wOpBSgcYnyrsN44piXI43dhfAarNcIkD2iO3sy59dC7+bHDisF?=
 =?iso-8859-1?Q?C8c4uQZFXLWeuPJfV8k82rnaLgEmCCyuE1N2Mt+CYMXqj5m1Nm7Ebi9aqi?=
 =?iso-8859-1?Q?DuUsPGQJ+nt7hCWXSsPjMN3paAZdSVaPcWqRWwKSQCBFgpd2A8ukm9DKX2?=
 =?iso-8859-1?Q?bjfa9pudTTYoHjdmQ5caMB3Cja0TcPM4xG/mqBW2dIPSMZuv0RHiZdx/ib?=
 =?iso-8859-1?Q?9BnTwZmpw/tbhSrx23HoWrmEnVARtWX9RHYqmfZ0aIQ7KUcdpjRmIz/0EA?=
 =?iso-8859-1?Q?pcUp0VCih4KZvsEXS8089x4vo+0RY0z9mJVorXLmBvYWuQIQYC9MQtBcws?=
 =?iso-8859-1?Q?TkesJq/FsbmfHlgOF/SMEB3XHmH74YxKPoBPQHc3sZLen0z/c6zvY3/yz+?=
 =?iso-8859-1?Q?p1v/NcvPsB6zom+p/ky2MvSyyk45kiBuYtMOT1U5QM5DY+hygzrqhdESrA?=
 =?iso-8859-1?Q?kZKogAsTWNIUp8Wjm3F6N49IFSNPNYPZDiUDHWbxi5NlJTLypMhb1LYnJ4?=
 =?iso-8859-1?Q?0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4277.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?dRz37tah9Cd8eNo/mv9tmckaheK2xnRromvDBloODJcXGdUcDodrzZKHz4?=
 =?iso-8859-1?Q?7rauwbrg7NVS7qP8Y3aS61FqhUCdI95MnxWw0JeRyNZzd3c6L41QZNcrup?=
 =?iso-8859-1?Q?3RWlbjX6aX7/61OppxHiqzRfRDtjtxcePNR30z/NOdPRBQjGZ0WxC2oMFS?=
 =?iso-8859-1?Q?efoVaQYDJKgXa9wl3TKyRcM5DUtn6kETKFhRaNkRrTXMwVzXv+V5yKk8wS?=
 =?iso-8859-1?Q?V1x+X4Qc207fJJuxC8sZUvh/Da5kAOcHis4fUJI+G+VA9+9eO1Eqe2cMkJ?=
 =?iso-8859-1?Q?o3BrpImWAM+ao8rvFyyGT99Q71P9PF7lYy9SHpdLzamIFu979bEChlyB1E?=
 =?iso-8859-1?Q?WxiqEfrQ2PQdLbelnKQVdmoAcN2KTcK6X8qIAlEZASN2JTDd99Cg3wveR8?=
 =?iso-8859-1?Q?n+P8kOtzNVbRRoGPGsb/7ktOeNTFrudrplfRKLB1SnYF/KU/BW5++oVw7u?=
 =?iso-8859-1?Q?M5KQEQ5gim2yl35BRVKcTEAIv5u3MaTsLl8RKHvhfOPD2fWqVxYhDlUaSN?=
 =?iso-8859-1?Q?1R3mjaMVP2CB5SUiJDuR2f7En/tOGp2Eh5AuAfpi2tZ8Mh6DVTOTBtr96P?=
 =?iso-8859-1?Q?6LkM89fusZc5hbC+Ao6FMnZuNN3zjNwGdclxcQJxGnNc6kXB5A0LP2OZf5?=
 =?iso-8859-1?Q?X3Z+GclnieJTTgBrXgoL4/PruHDHZCI4ozF6yq8ZvFYmdkG5ebl4HUsok/?=
 =?iso-8859-1?Q?iIUKQ99gC36aPRe6EZC4RvfuzYNr9gVy/npG716U2Nzelt72sJb6EPLRs5?=
 =?iso-8859-1?Q?/xiFa4k4xoPOylEkAhSBGgoh3mIL7zoGdC/iUdW9afwPnH2aQhkds79OO7?=
 =?iso-8859-1?Q?CgoE7cRoGl6gG7eEo69JQfY5FPcxYbjrbFyG+TR8Y/+06oChVZdV4p2p+y?=
 =?iso-8859-1?Q?f+F6NyZwMXlFK1PP7FnUwQeX73OyhjyavUHDk+yHWt5EqVnd7fY5LZtUtR?=
 =?iso-8859-1?Q?BQTILOLsPkFN+yh6M96IyvXH1iY1vRiDmk0enbG+qNOKT2GC95eaiO1DZL?=
 =?iso-8859-1?Q?N2GnU2NOEsprAmmOf2Sm7V24f4meqtu35vzUyq9pFwwOhpZr0RYTjjBVeJ?=
 =?iso-8859-1?Q?Rv/2GDberpFW/tLANOcFRFeH41Sljw82KE+e3YEZCkOCRvOjahIEjqixGr?=
 =?iso-8859-1?Q?Yi5iJWe1xdpOKXJ3vEtM+3yodtj7ngbvWqAr09vF5X5U+dJl811wbUDQCi?=
 =?iso-8859-1?Q?SLqVVVxEWQoiTjC9PUzOpNKHTKtV7QwsEuEB3XW49+2hSnyIPjXVPA4tBk?=
 =?iso-8859-1?Q?Ypk4t1iHJvTNOUapXjBE6IBlKRnOBs++Jap0Lp2oZR5DqcHJjK5txSUMOB?=
 =?iso-8859-1?Q?Wc9I1sIVBY7/1k7snVy290mpOjWz7MF22gDSI/c+2To5Xj54Ndng2E5Vlx?=
 =?iso-8859-1?Q?thjTPpLuUtNHQnpFq9bKpEsdsLFKvjYwB7YUfIo6SEcA3IrrTevCNLGn4+?=
 =?iso-8859-1?Q?8FGwyCwDyPX5eXZRkmCNLq+SOjIyr0Ve6mGZa2dhgiWvbZBG9K2JtsJGeG?=
 =?iso-8859-1?Q?wrR1D9nbEHi4dWKiw9Q5pEgQEAEelaeb7i/n5rOdCvp5rFywK1b1TiG59p?=
 =?iso-8859-1?Q?u0mdhDET/in2AHmm3hzMwGerkCLbA8wtHMlK6s8xo+WAJso1eTAHR62BOL?=
 =?iso-8859-1?Q?W/5o1gZiCnJ8+hZYYsyvOANRzccmqv/O5u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d70cf683-9fac-469c-ebd9-08ddb9b469dd
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 22:04:27.9558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0zby1UQk2kyPtCsv8RjezxqnxNqPfjsGRfLKReCNVvsmPCGyTJgWIAn+RnOSEykfbkVUR1Zh19crzLUB3phsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5991
Received-SPF: permerror client-ip=2a01:111:f403:2415::605;
 envelope-from=etanous@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FORGED_SPF_HELO=1, KHOP_HELO_FCRDNS=0.4, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
Reply-to:  Ed Tanous <etanous@nvidia.com>
From:  Ed Tanous via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jul 02, 2025 at 11:38:53PM +0200, Cédric Le Goater wrote:
> On 7/1/25 22:34, Ed Tanous wrote:
> > GB200nvl72 is a system for for accelerated compute.  This is a model for
> > the BMC target within the system.
> 
> Could you please add a comment saying it is based on DT :
> 
>   aspeed-bmc-nvidia-gb200nvl-bmc.dts
> 
> from
> 
>   https://github.com/openbmc/linux/blob/dev-6.6/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
> 

ACK.  Will add to the commit message in v2.

> 
> > Signed-off-by: Ed Tanous <etanous@nvidia.com>
> > ---
> >   hw/arm/aspeed.c        | 79 ++++++++++++++++++++++++++++++++++++++++++
> >   hw/arm/aspeed_eeprom.c | 21 +++++++++++
> >   hw/arm/aspeed_eeprom.h |  3 ++
> >   3 files changed, 103 insertions(+)
> > 
> > diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> > index 3ef7f6c5b2..98144ced86 100644
> > --- a/hw/arm/aspeed.c
> > +++ b/hw/arm/aspeed.c
> > @@ -19,6 +19,7 @@
> >   #include "hw/i2c/i2c_mux_pca954x.h"
> >   #include "hw/i2c/smbus_eeprom.h"
> >   #include "hw/gpio/pca9552.h"
> > +#include "hw/gpio/pca9554.h"
> >   #include "hw/nvram/eeprom_at24c.h"
> >   #include "hw/sensor/tmp105.h"
> >   #include "hw/misc/led.h"
> > @@ -201,6 +202,10 @@ struct AspeedMachineState {
> >   #define BLETCHLEY_BMC_HW_STRAP1 AST2600_EVB_HW_STRAP1
> >   #define BLETCHLEY_BMC_HW_STRAP2 AST2600_EVB_HW_STRAP2
> > +/* GB200NVL hardware value */
> > +#define GB200NVL_BMC_HW_STRAP1 AST2600_EVB_HW_STRAP1
> > +#define GB200NVL_BMC_HW_STRAP2 AST2600_EVB_HW_STRAP2
> > +
> >   /* Qualcomm DC-SCM hardware value */
> >   #define QCOM_DC_SCM_V1_BMC_HW_STRAP1  0x00000000
> >   #define QCOM_DC_SCM_V1_BMC_HW_STRAP2  0x00000041
> > @@ -647,6 +652,12 @@ static void create_pca9552(AspeedSoCState *soc, int bus_id, int addr)
> >                               TYPE_PCA9552, addr);
> >   }
> > +static I2CSlave *create_pca9554(AspeedSoCState *soc, int bus_id, int addr)
> > +{
> > +    return i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, bus_id),
> > +                            TYPE_PCA9554, addr);
> > +}
> > +
> >   static void sonorapass_bmc_i2c_init(AspeedMachineState *bmc)
> >   {
> >       AspeedSoCState *soc = bmc->soc;
> > @@ -1052,6 +1063,45 @@ static void bletchley_bmc_i2c_init(AspeedMachineState *bmc)
> >       i2c_slave_create_simple(i2c[12], TYPE_PCA9552, 0x67);
> >   }
> > +> +static void gb200nvl_bmc_i2c_init(AspeedMachineState *bmc)
> > +{
> > +    AspeedSoCState *soc = bmc->soc;
> > +    I2CBus *i2c[15] = {};
> > +    DeviceState *dev;
> > +    for (int i = 0; i < sizeof(i2c) / sizeof(i2c[0]); i++) {
> > +        if ((i == 11) || (i == 12) || (i == 13)) {
> > +            continue;
> > +        }
> > +        i2c[i] = aspeed_i2c_get_bus(&soc->i2c, i);
> > +    }
> > +
> > +    /* Bus 5 Expander */
> > +    create_pca9554(soc, 4, 0x21);
> > +
> > +    /* Mux I2c Expanders */
> > +    i2c_slave_create_simple(i2c[5], "pca9546", 0x71);
> > +    i2c_slave_create_simple(i2c[5], "pca9546", 0x72);
> > +    i2c_slave_create_simple(i2c[5], "pca9546", 0x73);
> > +    i2c_slave_create_simple(i2c[5], "pca9546", 0x75);
> > +    i2c_slave_create_simple(i2c[5], "pca9546", 0x76);
> > +    i2c_slave_create_simple(i2c[5], "pca9546", 0x77);
> > +
> > +    /* Bus 10 */
> > +    dev = DEVICE(create_pca9554(soc, 9, 0x20));
> > +
> > +    /* Set FPGA_READY */
> > +    object_property_set_str(OBJECT(dev), "pin1", "high", &error_fatal);
> > +
> > +    create_pca9554(soc, 9, 0x21);
> > +    at24c_eeprom_init(i2c[9], 0x50, 64 * KiB);
> > +    at24c_eeprom_init(i2c[9], 0x51, 64 * KiB);
> > +
> > +    /* Bus 11 */
> > +    at24c_eeprom_init_rom(i2c[10], 0x50, 256, gb200nvl_bmc_fruid,
> > +                          gb200nvl_bmc_fruid_len);
> > +}
> > +
> >   static void fby35_i2c_init(AspeedMachineState *bmc)
> >   {
> >       AspeedSoCState *soc = bmc->soc;
> > @@ -1587,6 +1637,31 @@ static void aspeed_machine_bletchley_class_init(ObjectClass *oc,
> >       aspeed_machine_class_init_cpus_defaults(mc);
> >   }
> > +#define GB200NVL_BMC_RAM_SIZE ASPEED_RAM_SIZE(1 * GiB)
> > +
> > +static void aspeed_machine_gb200nvl_class_init(ObjectClass *oc,
> > +                                               const void *data)
> > +{
> > +    MachineClass *mc = MACHINE_CLASS(oc);
> > +    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
> > +
> > +    mc->desc       = "Nvidia GB200NVL BMC (Cortex-A7)";
> > +    amc->soc_name  = "ast2600-a3";
> > +    amc->hw_strap1 = GB200NVL_BMC_HW_STRAP1;
> > +    amc->hw_strap2 = GB200NVL_BMC_HW_STRAP2;
> > +    amc->fmc_model = "mx66u51235f";
> > +    amc->spi_model = "mx66u51235f";
> > +    amc->num_cs    = 2;
> > +
> > +    amc->spi2_model = "mx66u51235f";
> > +    amc->num_cs2   = 1;
> > +    amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
> > +    amc->i2c_init  = gb200nvl_bmc_i2c_init;
> > +    mc->default_ram_size = GB200NVL_BMC_RAM_SIZE;
> > +    aspeed_machine_class_init_cpus_defaults(mc);
> > +    aspeed_machine_ast2600_class_emmc_init(oc);
> > +}
> > +
> >   static void fby35_reset(MachineState *state, ResetType type)
> >   {
> >       AspeedMachineState *bmc = ASPEED_MACHINE(state);
> > @@ -1879,6 +1954,10 @@ static const TypeInfo aspeed_machine_types[] = {
> >           .name          = MACHINE_TYPE_NAME("bletchley-bmc"),
> >           .parent        = TYPE_ASPEED_MACHINE,
> >           .class_init    = aspeed_machine_bletchley_class_init,
> > +    }, {
> > +        .name          = MACHINE_TYPE_NAME("gb200nvl-bmc"),
> > +        .parent        = TYPE_ASPEED_MACHINE,
> > +        .class_init    = aspeed_machine_gb200nvl_class_init,
> >       }, {
> >           .name          = MACHINE_TYPE_NAME("fby35-bmc"),
> >           .parent        = MACHINE_TYPE_NAME("ast2600-evb"),
> > diff --git a/hw/arm/aspeed_eeprom.c b/hw/arm/aspeed_eeprom.c
> > index daa3d329d1..8bbbdec834 100644
> > --- a/hw/arm/aspeed_eeprom.c
> > +++ b/hw/arm/aspeed_eeprom.c
> > @@ -162,6 +162,25 @@ const uint8_t rainier_bmc_fruid[] = {
> >       0x31, 0x50, 0x46, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00,
> >   };
> > +const uint8_t gb200nvl_bmc_fruid[] = {
> > +    0x01, 0x00, 0x00, 0x01, 0x0b, 0x00, 0x00, 0xf3, 0x01, 0x0a, 0x19, 0x1f,
> > +    0x0f, 0xe6, 0xc6, 0x4e, 0x56, 0x49, 0x44, 0x49, 0x41, 0xc5, 0x50, 0x33,
> > +    0x38, 0x30, 0x39, 0xcd, 0x31, 0x35, 0x38, 0x33, 0x33, 0x32, 0x34, 0x38,
> > +    0x30, 0x30, 0x31, 0x35, 0x30, 0xd2, 0x36, 0x39, 0x39, 0x2d, 0x31, 0x33,
> > +    0x38, 0x30, 0x39, 0x2d, 0x30, 0x34, 0x30, 0x34, 0x2d, 0x36, 0x30, 0x30,
> > +    0xc0, 0x01, 0x01, 0xd6, 0x4d, 0x41, 0x43, 0x3a, 0x20, 0x33, 0x43, 0x3a,
> > +    0x36, 0x44, 0x3a, 0x36, 0x36, 0x3a, 0x31, 0x34, 0x3a, 0x43, 0x38, 0x3a,
> > +    0x37, 0x41, 0xc1, 0x3b, 0x01, 0x09, 0x19, 0xc6, 0x4e, 0x56, 0x49, 0x44,
> > +    0x49, 0x41, 0xc9, 0x50, 0x33, 0x38, 0x30, 0x39, 0x2d, 0x42, 0x4d, 0x43,
> > +    0xd2, 0x36, 0x39, 0x39, 0x2d, 0x31, 0x33, 0x38, 0x30, 0x39, 0x2d, 0x30,
> > +    0x34, 0x30, 0x34, 0x2d, 0x36, 0x30, 0x30, 0xc4, 0x41, 0x45, 0x2e, 0x31,
> > +    0xcd, 0x31, 0x35, 0x38, 0x33, 0x33, 0x32, 0x34, 0x38, 0x30, 0x30, 0x31,
> > +    0x35, 0x30, 0xc0, 0xc4, 0x76, 0x30, 0x2e, 0x31, 0xc1, 0x00, 0x00, 0x00,
> > +    0x00, 0x00, 0x00, 0xb4, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> > +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
> > +
> > +};
> > +
> >   const size_t tiogapass_bmc_fruid_len = sizeof(tiogapass_bmc_fruid);
> >   const size_t fby35_nic_fruid_len = sizeof(fby35_nic_fruid);
> >   const size_t fby35_bb_fruid_len = sizeof(fby35_bb_fruid);
> > @@ -169,3 +188,5 @@ const size_t fby35_bmc_fruid_len = sizeof(fby35_bmc_fruid);
> >   const size_t yosemitev2_bmc_fruid_len = sizeof(yosemitev2_bmc_fruid);
> >   const size_t rainier_bb_fruid_len = sizeof(rainier_bb_fruid);
> >   const size_t rainier_bmc_fruid_len = sizeof(rainier_bmc_fruid);
> > +const size_t gb200nvl_bmc_fruid_len = sizeof(gb200nvl_bmc_fruid);
> > +
> > diff --git a/hw/arm/aspeed_eeprom.h b/hw/arm/aspeed_eeprom.h
> > index f08c16ef50..3ed9bc1d9a 100644
> > --- a/hw/arm/aspeed_eeprom.h
> > +++ b/hw/arm/aspeed_eeprom.h
> > @@ -26,4 +26,7 @@ extern const size_t rainier_bb_fruid_len;
> >   extern const uint8_t rainier_bmc_fruid[];
> >   extern const size_t rainier_bmc_fruid_len;
> > +extern const uint8_t gb200nvl_bmc_fruid[];
> > +extern const size_t gb200nvl_bmc_fruid_len;
> > +
> >   #endif
> 

