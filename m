Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D604CC83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 15:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXLpN-00047r-FY; Thu, 03 Jul 2025 11:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uXLov-0003xt-PV; Thu, 03 Jul 2025 11:25:59 -0400
Received: from mail-bn8nam11on2061b.outbound.protection.outlook.com
 ([2a01:111:f403:2414::61b]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uXLos-0000fU-FC; Thu, 03 Jul 2025 11:25:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVYyF3knbb9/JSu0PmyVC9Ih+XeISI8G/yqKlVPL8DZ8tS6eS1ThLzLk4WJVGJZ/WVWkgWhEp5o4dBr1kwd5IBD4QTPe3z/+sRNTZ3YTYow3wlGYjViHs2D4oTkyTwfIEElA+f9Eth2XYFLFGbmDDUjrVxoilxnSHNLZ7vQZJPB2qkG4cWaHqGtZpePwpifNt6vGG6w/jssdVnJ4+sQuIhT+RpW/Dfs7oYVujBCS7QzBnb1Ef4QMbLBEqt1fuTA3mHEvYMBGRLSt0yZE1eIEvCCbOXGzS6KcX5DOHXaqzF/ltOLq396nIdE2Gbea2MxLlj1PyW2BD5IPZ9YIofAanA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuvZx19ikDw2CaH/aADjiGUzuWr7WXg8uS3V6yWjOMs=;
 b=fxJerMgg32jG3x5ypX6GbhdzFZGxa2ppmJOdoXCOB6G0ugNOAFEe00KbkKTLYteO5xYc+7RpYwlesQEJfSSoUlrcM7EH/7zN3GHhQ0pwIFZ/mVF6uIdda1/1YobI+kJa8aJXIFhKSjWj7ynyuCr+WYqd1v6861dhxtDQ4rCC87hf+UJc8vzyXYpz/0JIOjC5zgwdVCs2/9TeMpNmYswbSK63QTk71NnPikeqKmKGvcl3mAbIeAWtAXI9iOa1Zwv9qE3HWgibwRgwEcNacF4fEF0Eazl3xHmKv/vgBKe5G06D0/naVzlvaH7oif58GrO5oeZuE6viXAASKTI+zqJPgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuvZx19ikDw2CaH/aADjiGUzuWr7WXg8uS3V6yWjOMs=;
 b=fYRYER8hDqdo32BjIZazP+sq9X/RrfvrMFpbBKszz3rHdm2vqdl+CkfbkziBJ7NVEvznCd5XLk5O0wAk38DBn64cPDw1o3IfIhAVgOHq8eBNa3THpMKEe8WAdV3zU1zZWnpVy1OPu1YVSCZeyba3/YMsFM9wHysPZNee6U4OOMAKCRR5a4CqvL3pktpj6Uh+n2SHwhiwGWKAQoz1RNmPdDAqv6vbAXy4sYmZIWrN1I+eX0mJXbBougSHE9GL8aAdzV0kORGZAWmeMOhjA12Kfe7ABv1IyraAtxEJQtDCp5V6WXFUr1tZehUMozy3itZShrvR9tB3M6dADzK5pub7FQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Thu, 3 Jul
 2025 15:25:43 +0000
Received: from CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787]) by CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787%4]) with mapi id 15.20.8880.021; Thu, 3 Jul 2025
 15:25:43 +0000
Date: Thu, 3 Jul 2025 08:25:41 -0700
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, Troy Lee <leetroy@gmail.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 0/4] Add support for gb200-bmc machine
Message-ID: <aGag9Q5utRg3HtLB@edtanousvm.nvidia.com>
References: <20250703144249.3348879-1-etanous@nvidia.com>
 <417686d0-bddc-40de-bbd8-631bb9cc4945@kaod.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <417686d0-bddc-40de-bbd8-631bb9cc4945@kaod.org>
X-ClientProxiedBy: SJ2PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:a03:505::7) To CH2PR12MB4277.namprd12.prod.outlook.com
 (2603:10b6:610:ae::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4277:EE_|SN7PR12MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc4436a-6f28-459c-2b9c-08ddba45dfe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?K0iaUipCILfubhNazBZi53ZdDEB+BhKCmaJps+76qEX3wZYjHXMJ9mMPAI?=
 =?iso-8859-1?Q?z0Ac0ZE+7vHj7yQU8j090cdPav3WdRPUG/nxVhlpsG9/9Np7uGM3miRawW?=
 =?iso-8859-1?Q?rjZq8dYjHp2qlF4YAwQ0otNyV/NaGbnAB5gsW2m0ubDDDcu8+U9gVTmIIP?=
 =?iso-8859-1?Q?jVUqOr2jFY8ezv0QTBfPNnihzjsZ/y3hNjBr8Dw2hf7K7CAsMTREG1tz1M?=
 =?iso-8859-1?Q?YShCR5omCxf5cI4+rY8YmC61Gcntp8miPpUxIVStSkLSxc5G63clnUAYbX?=
 =?iso-8859-1?Q?LbvDhQQlhzKEemGYdWFvBX/xUhXFSoZkKL7PmjYXuk9Ct+/WWb8Hr1EqU5?=
 =?iso-8859-1?Q?OdUODbQy5XagpDR1vS957m2zfKsMOmB1VWLPG9HmErv76KdaPB/Pdjovjd?=
 =?iso-8859-1?Q?dJUTk40PfDMhTkTUcV8qhaozVxgEanocxNqn1YHDwX8qcbK4ASm3AUN5N5?=
 =?iso-8859-1?Q?m+459qrn8gUPqdE+c1j4A0bIZBPdinzTqHVOA/aqGVD0G/u84yYFu6ok4u?=
 =?iso-8859-1?Q?Pj2z1EN7l3S/mRDEu0zS/kiT7k5IGdcTr5491HfkRW3IXDha0Qi0+FPdvH?=
 =?iso-8859-1?Q?q+SeOvVrr8QYIiHBr2aESTQtVZZ4plDo8fDKI11lWp2NZ4Nj0YHzHDsC5M?=
 =?iso-8859-1?Q?ofA1ZNFUjgRcSXGxhtLiN3nz+p8Q4WCgdsRvBChcunOoevJdwOjL3dcUGh?=
 =?iso-8859-1?Q?h28mNjrbq/Rf1lYYcUVRmL6hMYs0+NfBudaPZLYODaSVxkprna/YygrVus?=
 =?iso-8859-1?Q?Ctg3/wOE+wOY7zUGY4StOMYoucMaRPvYq18KdYYKfOTBWcHUtt96Wp2/CQ?=
 =?iso-8859-1?Q?T4dCXxb1tsz+4JSA5UHvgWhw63d8p/dIwD3HZu2ioLcMquEcOmNNg8ulk2?=
 =?iso-8859-1?Q?UmhwHGyEjEGSk1tHaIgT9+iptFrYtfcjt/VSKOJ7fxbCo+fErGVneijlgq?=
 =?iso-8859-1?Q?vysk+yvidwZ/QyJqntYaZXXaGQYEZdK3Roj1efg0sprgnJl4drhlaE4YBJ?=
 =?iso-8859-1?Q?OrMbVPKxsh5zu9MwAmwReDTmxkQU/KvUobySaXxoN1C8DB+4pL8eC+f99D?=
 =?iso-8859-1?Q?Mira18eY0mbUh9YNtsUDYaIPalR/vc6ua6jnK1GKYfUVA4aKepj+QgNP/K?=
 =?iso-8859-1?Q?9CV8aw6QdNk72W9u04GROK3F56HxC2yohn3Njvvs1X2JD66ZWR+LG/w8tx?=
 =?iso-8859-1?Q?Jo/GwM2IxB7sAmr3O9NI6EpIKDbOpCdBA5JMMJ5bHlBv5VSxYfR+WqGlHJ?=
 =?iso-8859-1?Q?XDKYsEavEZX6mXR3uOHs+x5h2RtCWEd8hp8rBuxJfLS9WH+/VUgFd7Ii2P?=
 =?iso-8859-1?Q?5jjjSRf9QSs4auL0d5v2Dh/JoMR/gk38PXG0SSYVUNnDPZRRcA/GXSkJrB?=
 =?iso-8859-1?Q?37xSlaErn6nSqMx9JN5CHyYAMfHa1Jl6hn5yxCLnFP6TvlZAzbaFs9ICUl?=
 =?iso-8859-1?Q?cGrKTbrwHoprbk+LVYoOCsfy1GNzkxa9SM2Nbn0rKZnun55ayY7qv4r/sW?=
 =?iso-8859-1?Q?0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4277.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?1w8dA5ld3uZvkm7zN1ilIpGolPFGp1JaQQG5we685v+QtRZnJTdX0ghZkP?=
 =?iso-8859-1?Q?OKObew2EsuaF2q3tLljhfbo/U+piePcNMdhpdUaq2Iww3c8U+P4E4XIB5G?=
 =?iso-8859-1?Q?qGBaGH8HRkfdfpnxF2pl/a4c90JhcBtWjQz+DvELs9LYf7TGkJz/Zq1aoj?=
 =?iso-8859-1?Q?OgHRly41UfkJfRpkUQ5kMK5Hm0r2crfaHsBB4tYZA28vTwsQjuiFYwfLrI?=
 =?iso-8859-1?Q?HdkDSB+1tNwa9jHv2dyDbegJ2203klbYoO2bfyGAYrCaZOj6X5kPNzbd3o?=
 =?iso-8859-1?Q?TK5CpFlFPF+8PUCjqohGe0sgcr7AKrAtwDs3HSjCdTw9kvaMRgl8XnHV32?=
 =?iso-8859-1?Q?SU0eDOi7Lfb+iOVQsQyc08sCGsd5jXJBRa4VK/oxcglFFbOHE/eoySpipk?=
 =?iso-8859-1?Q?vpEb3iDaIAhFW03gY7r1lSQhd78D8rclxrvNxsPRrHnm/zya/a2fL8HIU8?=
 =?iso-8859-1?Q?i9NyJUn+VXZzdc76SK4kVE0Uq6AEOr2JrrdKx6kZkXwaeFqRSCnefjVz2K?=
 =?iso-8859-1?Q?pg6Aib2M0mC/zE9V05SS3WpFACXEkQbF9PZc3YRO1igPT9NzqK+VplTLvs?=
 =?iso-8859-1?Q?0smE5jteD3DqAENz3unGaBqoXP82tFifZaw2nvMH1dXhSMd6K3KV13JX/l?=
 =?iso-8859-1?Q?Luda74qQamDDwWmCEeLXbs/GTRzowmU4UjBA4TSyxORaiz1OjBggTlgQyf?=
 =?iso-8859-1?Q?yIMTvDut0FBYWbsDut6UJ5GtpDurvO8htNLOSQ8WSXgvvKQ1j1L9IK7zSu?=
 =?iso-8859-1?Q?9Dz7ObrGYacoxyw646/kHZfac19/0GM2spwk9ZTxbVerFlartwIsKBywZC?=
 =?iso-8859-1?Q?T7x2N/cXpN0ZUwu8rVPjVqWSPGIN3ECIfCIJUMj17UV0X7IQE3glqtTtPb?=
 =?iso-8859-1?Q?mOulVW3MDDwtRlhYut9D2l08TX6DiYsaIFqzq10cUM4PH4IhX0oC1ql51s?=
 =?iso-8859-1?Q?2nBq+nlUfOXwCQ76IGC+zdeJmDegWQu6VDgTOBp2OB7a7CuAwH3huZyU3A?=
 =?iso-8859-1?Q?ZqW5ktHDFX+MNKDTuj3YpZvrqAYPIJdCf6zo5t3dP05PVh/67W7MWXLRGV?=
 =?iso-8859-1?Q?fK1zB4sWYU+F6jiR7jDrheUGB1dZ6uZPFHkv2mcg1nOK0XBsfevN6+YjqF?=
 =?iso-8859-1?Q?yPa4T2i+7J7iGrWF3nCdpo92KWEBRZSrUjgrRPOLXc9IpvfSRHCIxy6cgJ?=
 =?iso-8859-1?Q?PSliICvAYJqMarMEdpaFJx4NzRAfSwqTYWdKYO6VBI2MPsakN2ucNMWhKx?=
 =?iso-8859-1?Q?ztDgduvt9lDXvHttBNZi19pfzB3yA6lBgSUidEacsbjPDOWCl7m3VRjCGT?=
 =?iso-8859-1?Q?ooFNjKMbZGVWrLh3Y9kC3w1DJ6kTxnin5JkLK0ET73w1cYQ9SrYe1uGaaO?=
 =?iso-8859-1?Q?vni80roopQgOvqAwK3XskBxzdNsIQ/SsLnPBOIzIrgYkSVg2jTN7IK13E6?=
 =?iso-8859-1?Q?tEYC+a67+cCF/Qr0L4NSZns18fZGrU4F0OyfkPJx3RC5uuKcu2PLY316vC?=
 =?iso-8859-1?Q?XmJ5GE9NP93zCscDwR6MXhbc4D1wDTmf4NkSGBK2U1N0xyz6XOUS1iNZR3?=
 =?iso-8859-1?Q?10BuQPyv+Np+uw8JaeLKi705u0EVSxm3BQZUHN8yIFCI3PX42Am+iNLhts?=
 =?iso-8859-1?Q?7FrfcV/y0/6WeyHX8eDpx59djd8mXLbFk3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc4436a-6f28-459c-2b9c-08ddba45dfe6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 15:25:43.0518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1A0zbQWhSn78voKOy+ok61U7+oe0Pqw13nMrMs66jB6UspQUXgtxRiE2mi1Ai+rVpxx1Rth+ZmVNMlQtWyZasQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
Received-SPF: permerror client-ip=2a01:111:f403:2414::61b;
 envelope-from=etanous@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Jul 03, 2025 at 05:18:56PM +0200, Cédric Le Goater wrote:
> On 7/3/25 16:42, Ed Tanous wrote:
> > This patch series adds support for gb200-bmc, a baseboard management controller
> > module based on an Aspeed 2600 SOC.
> > 
> > v2:
> > - Rebase on master
> > - Drop duplicated patch for enabling PCA954X
> > - Updated commit message with source information
> > - Added functional tests and example openbmc image
> 
> 
> Please try to collect the Reviewed-by trailers of the previous
> series when you resend.

ACK.  Can do in the next series.  I had erroneously thought that
git-publish pulled that from the thread.

> 
> 
> Thanks,
> 
> C.
> 
> 
> > 
> > Ed Tanous (4):
> >    hw/arm/aspeed: Add second SPI chip to Aspeed model
> >    docs: add support for gb200-bmc
> >    hw/arm/aspeed: Add GB200 BMC target
> >    tests/functional: Add gb200 tests
> > 
> >   docs/system/arm/aspeed.rst                    |  4 +-
> >   hw/arm/aspeed.c                               | 81 +++++++++++++++++++
> >   hw/arm/aspeed_eeprom.c                        | 21 +++++
> >   hw/arm/aspeed_eeprom.h                        |  3 +
> >   include/hw/arm/aspeed.h                       |  2 +
> >   tests/functional/aspeed.py                    |  9 ++-
> >   tests/functional/meson.build                  |  2 +
> >   .../test_arm_aspeed_gb200nvl_bmc.py           | 26 ++++++
> >   8 files changed, 144 insertions(+), 4 deletions(-)
> >   create mode 100755 tests/functional/test_arm_aspeed_gb200nvl_bmc.py
> > 
> 

