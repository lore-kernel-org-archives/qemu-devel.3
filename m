Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FF6C83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX31G-0000T5-9O; Wed, 02 Jul 2025 15:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uX319-0000N0-Jv; Wed, 02 Jul 2025 15:21:15 -0400
Received: from mail-co1nam11on2061a.outbound.protection.outlook.com
 ([2a01:111:f403:2416::61a]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uX310-0008Aj-2Z; Wed, 02 Jul 2025 15:21:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QttQdPm85bLPZt8EeuNyw75ZwDbaryHrZnjO6yhXp2YdNLgx9e9B2UMN+FA9jlmOpPItMz71VYqpI49nm233VbpE9EaEo2BrcFn5fH50hNbwuLpfatBl/RWjWohUEtB2Wi0dgHJp9TsqMDrAX6WaxTzmpTamBNbgt661GG22VJcy1blEgwcle5AYzyTbWIjgNSdbwnOTT+LAlQ5XJzzvu+t0+hIDNrkDLmJmhf1zO8f3nIlz1iwaS7i7MIi5s7UAkmN9aqv+AQbCAcp3UrrfKRJWOLLgFcbKfuwJzMbNVeyMdOHgNTxLQfpRgN0XyW/V2SxOx1LyfGgUlrrZRRDcyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e93q2DBGrxHhH+UwmI1sgI+8gDeDgY4TRvmt7zeuEz8=;
 b=pn255iZogJOnFLiQQZs6rVIHrxkHLEDUMTADKhpdGI4dn+vFZWMQ328PUmM7smFsHgqRSQ6JxB+cGPwoSEEdFv7wex3/zu4uSl1a+u1UCPUQrkna3WAczFenWNVwnaszJDTDxonAmNay/b9YC59GWDJ7RERBIOQTie5WFHwpZAawg7io989kOotRQXxmgNynWw+io0ysCxvOG3lDV55ivown0zdlGyAT+jkl/4QZ7dIyswpwuCwZvFsmWGlfIsMa7k12mPUZc6M/01UQ65LsX4EhSnPqFnhrWeERKA92aA7R+iauOlRawPc8sDquV/qY7QesS507ChbnsvSzL0BYgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e93q2DBGrxHhH+UwmI1sgI+8gDeDgY4TRvmt7zeuEz8=;
 b=ETham/jkgq8UHVnS5p9xKkjkjvXxNiY5mHSnuNO5SmJnY5eJ9cHsxlSXW6BIebmI6+IPxo/KznjvmorQ1Wc67yDX3t+yoZjG+Qgo6wfhMRW37gU0aQ5ogAClIoyASwM5S8p+OLagtvX35i7G9BWWer/UUPUlbCZtc4gQaEmRqt7LN4zgfqOSWnTAMnDLmJ2+hQUecg6vLByec8JXxw/l6czmz1ld/tR3ztCIC4Ie60mNVjEtwSqAifXZpyOq0o5JvDzkLF5K8jv+WFt3Z5NMwLMUnF02xG6SG96sxOFFCC2O94bAIIAauZpkcMAebb1TKNl8tZPOJqNtQdVg3BjeQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23)
 by SJ0PR12MB6928.namprd12.prod.outlook.com (2603:10b6:a03:47a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Wed, 2 Jul
 2025 19:20:57 +0000
Received: from CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787]) by CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787%4]) with mapi id 15.20.8880.021; Wed, 2 Jul 2025
 19:20:57 +0000
Date: Wed, 2 Jul 2025 12:20:55 -0700
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Joel Stanley <joel@jms.id.au>, Troy Lee <leetroy@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Ed Tanous <ed@tanous.net>, Patrick Williams <patrick@stwcx.xyz>
Subject: Re: [PATCH 1/4] hw/arm: Add PCA9554 to ARM target
Message-ID: <aGWGl-9v4Nt9e2O1@edtanousvm.nvidia.com>
References: <20250701203400.71677-1-etanous@nvidia.com>
 <20250701203400.71677-2-etanous@nvidia.com>
 <f7e9fcba-e844-42e3-8e4c-9cc67a3069e7@kaod.org>
 <e273f8c9-6479-4ae7-95a4-5f3a3053ad76@linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e273f8c9-6479-4ae7-95a4-5f3a3053ad76@linaro.org>
X-ClientProxiedBy: SJ0PR05CA0166.namprd05.prod.outlook.com
 (2603:10b6:a03:339::21) To CH2PR12MB4277.namprd12.prod.outlook.com
 (2603:10b6:610:ae::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4277:EE_|SJ0PR12MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c46ffec-79e4-4772-5f16-08ddb99d9269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?tI9x2zq9Pz94MF26o6hIsyhBJ24S+7yRuv8mY7zmvhVMPs0NnZE14ihOk0?=
 =?iso-8859-1?Q?jYWiqib8A5NqsOQVcgzwIhLyrJRfsBEpRthm6Ng/KUpXv57P0rJpZ9RPIo?=
 =?iso-8859-1?Q?Qv60hzCmIz7pz17W+kz89LvTdsq9eGCF9dVpS97f93Gctb/fhhfBc+8WGQ?=
 =?iso-8859-1?Q?xthuh0zuPui+JO3wYjrMecex1GjI6w4wC905OCgmUC97Mxmz1HDaBW/Bco?=
 =?iso-8859-1?Q?smb0MjuKRjzzR1o2ypiHiJwUlkDyGdaeOIU3k+WWyDfnsr9oKzLaGQwChL?=
 =?iso-8859-1?Q?OuL+Qcibh45zBZC73N2Km+Jjqq2vkOjw4iYNH9OY03HzFSw4zM5cnWMZ2S?=
 =?iso-8859-1?Q?vQpTizQvOsZUkd8TJ/FQ2UOnswb/pI13s7/MUsqDcegVrL7AZSUJzxpo8P?=
 =?iso-8859-1?Q?eYXOgWKUqy5T2g9r+aUG4uTKfloxP+3u5aKeoUQVTZmQo97JPqjDxTMaZr?=
 =?iso-8859-1?Q?PDqCN5zNqWDDO2gZLzLgkjM48xe0LzZiYX/gYeFTBJLJ1z8Jr578xlHI8g?=
 =?iso-8859-1?Q?umw2LW6lnMyGnDHZtU8ZLeEyNJJ0FtZnJM11KSNb76e1SKI8NwExXAh9Mo?=
 =?iso-8859-1?Q?eNlZcQziTOruAU0ln7Cg1Qhy+0g6kyxrCKJZAorgKZUNZX1SBWBt/YxudI?=
 =?iso-8859-1?Q?hk+rWuWw/0VKJVuSXai6Ob5rcxfBsSCyJYIlGM3Pe0DoL9i8Vhbmhl/0oB?=
 =?iso-8859-1?Q?yMwgOui4UYn7hagIlpOxCZNK0ymZukBNKBIFE05F8qtqgVcs3KKsZ6oCsa?=
 =?iso-8859-1?Q?nM4snNBq1/o6k3llWXzOpLZbRzqxPf+la343hG8NkiqWiWztzcRiENjmGx?=
 =?iso-8859-1?Q?8+++aR3p6hBfO+wqgWAoS0c3M8gy9bsKkSjX9QZadvJISjoWlwPEPysZVs?=
 =?iso-8859-1?Q?aBXgKnP/rd2uO7m18pUtEHgSXJYxpxst6O2MMG7ik+/3gfGt03lVU9gZP+?=
 =?iso-8859-1?Q?FCOG1bV3ESxvor+Ou6zxPkJ6jeA3XeR+VTt86wfS50v8klDRHL5AEuHLvZ?=
 =?iso-8859-1?Q?o+0x7IjLLMDRcubBMwEJpWgKtJyx/t5gqlZpQtn+gDaY5v492EDk5PSlyB?=
 =?iso-8859-1?Q?YcuyE6bjmFdWKtvHLp1EPVu3hsgRLe7lDNwFyjTlAIJhyc2BEwV6uq1QxG?=
 =?iso-8859-1?Q?mZuSII1uj68MTxUsrPdzIAau0N1T26RDfRMqp9ttVzfF+RDcsEpAmWmR7l?=
 =?iso-8859-1?Q?Nby9OPzM8NBvkP4/MyuZ7Pbj/R+TOIlqqE8puYhV6U3GU1Qr7POgHSJBk8?=
 =?iso-8859-1?Q?t0QGVRxKHj91MrvskDvPXsIyY6YBpwsBc5nyGhCXj/p6e3c+jU2+lil0hH?=
 =?iso-8859-1?Q?voOolD5f9iu73YG+NHWsgoijNVdUV2ZeJNSiQYU8XIe7CxGc2WbIA0a639?=
 =?iso-8859-1?Q?ZS/dPEHH+tF5buysrVhhGMfvlcHKr0yitH8e6PS+3rc8qVSc8BypdpAcye?=
 =?iso-8859-1?Q?h1cHKl7ofX9QMBYdrWwHaa9My2/t6wDUAyp+4Poh7+29QLP0LVTlb0Qtpi?=
 =?iso-8859-1?Q?A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4277.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?GR1DzHIven9Ufs7mY49w2mezmv4Z5CYho7/H11PBfSxMw9Bji3EuoF+nRt?=
 =?iso-8859-1?Q?wL7rb2vzZ/YL+vbj40+LQ/3u/MGb1SJOuuNn9tRH+JLvr2a1Kx4vkbKl2K?=
 =?iso-8859-1?Q?+cuFn4KhXEJnxYNw7SLQddLoJkKCOs2/Rnu9jfYIpXcBYHJpFz8BQKwCwX?=
 =?iso-8859-1?Q?EwXEAzUnblUDRMkiFutuWU/v1fs0Ovz3MVLIIq5zQLtONBm1+FSX/EpEt2?=
 =?iso-8859-1?Q?bgYIfuoUUZbC8XPOn7zMsKBg9xgHeEJYsBlmQ/zI4bhKrWUv4EARjIcSJo?=
 =?iso-8859-1?Q?Q3Opc6ptFFUjf8wVJgt5kyUn4POdhed+7sAPQMDjhU5V3c+157TRJ2aNHH?=
 =?iso-8859-1?Q?vl8ELpeQK0sGprAdp+3wyFal/e2fswVjGkBUyW5n0PO7Sp22OPEhWDwBAS?=
 =?iso-8859-1?Q?EKWfo3puZvZDzMXXqcsgbi48yqHIz4DrIstrjfcGXWdsXbK47uS6V5A9MM?=
 =?iso-8859-1?Q?NGMk4fWj90v2W5G0poQJtT/+OQFKAyP7wfGz16RB2smWwvx0T/GCjN4wCp?=
 =?iso-8859-1?Q?RwMq3eCFfEkOYL3Sp7afISzqUZSJA3WQnCU5ZDDzMygliw7uAZgv3y4e/n?=
 =?iso-8859-1?Q?VwciM7Zd0GFHFmrx/0YP1J6jy6ew57cM++OqQw8XSEh3j4BYfhiIeTgvNp?=
 =?iso-8859-1?Q?AuwodbwoA8dT75ZbvRggAs4k8DnrSqkKnK3XjnUgU4GMKdl1rb+Uv5lxKV?=
 =?iso-8859-1?Q?QU1HXDfJVfTs8KY9BeStjvip+JiiHldLaysKO8e8EzFx2yEym2PK3MUOau?=
 =?iso-8859-1?Q?fdzWfhWjNGPzNSl76eRpApyrzfoprkXa/t7pKff9HYAGxEklsXUQBerbUo?=
 =?iso-8859-1?Q?Pb4Odxk/FKOrtwMgUANNoplBbmE8euQMwDNCdFgshdKX18yaRL7LLD1IIi?=
 =?iso-8859-1?Q?Nt7XwP8m8ta+1U1Nsp1p6T2mTAcV1NIOWgeM8VtmBHLFg9VhKD/pxE1uZI?=
 =?iso-8859-1?Q?IRoQEf4r1CDi3cBD6ETbeJeUuK2JZM/55vzGo3QgQQ+SMICmg3ej+dw+Q+?=
 =?iso-8859-1?Q?QoJw+EEsdk/2fOeKnWiMDQGvSdthaLCkUu5U8J5hVlswdC4dO/Wn/NVJHo?=
 =?iso-8859-1?Q?okq+h2E2QQevcEhHY5/wTZGhdQ3TXxcqOXjS8ZklkU09iVGBX6Pk6Wau/j?=
 =?iso-8859-1?Q?na2kNbD/gZFftlV0o7di76OwLs5rjkKEZg1bTvpDu3Q10x4IHce8JIO5rn?=
 =?iso-8859-1?Q?Yzj6oNoVw1x7t8EihCq+jM6VhYx7xQR9iOGZ7bej0MhlnQUzRm9nyeOAi8?=
 =?iso-8859-1?Q?Pd+9EYAIexjvm0Y7enSy5L1tQ6nS3K8Uu525jWYniQhkpcuwU+U3L4Cr12?=
 =?iso-8859-1?Q?Mpjz1OxYmed+cr578bCN2apg+fx8GCal6o9W6icTOpA/E6cu2RUxLlj9An?=
 =?iso-8859-1?Q?LdLb2n7yvjQV8b39oNFEwvRbbcR5fZYtmv9pJeR0fsL4jT/XA0maE2s+pl?=
 =?iso-8859-1?Q?QmIQ/KSupOWOazgPrqHIOBDMQoeSM7eZEBinO/18hGmXuCxkUMPfacDQuz?=
 =?iso-8859-1?Q?wRZGqx9TCu3PR46GIeXkWoT50mUv5z2eiKDbTcBJO0Dpu2q407Gm2HpBlX?=
 =?iso-8859-1?Q?mtEshY9EDcCS0fc1CEn7X+V8ZBo+mCH0OjydMs2iUpXGq23xeCNK8lbC9D?=
 =?iso-8859-1?Q?aXUFCbXUhE9XXGnT9ouo4D1pW7gWcgdUls?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c46ffec-79e4-4772-5f16-08ddb99d9269
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 19:20:57.5238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BxQihVF6uLYkce30SSKHKGN0hiOmW3yCdgwRBDlrhIHUd+labMOKqOLXhHu+1GNj2HpAJbyFeQWvnGb+KRpvmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6928
Received-SPF: permerror client-ip=2a01:111:f403:2416::61a;
 envelope-from=etanous@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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
Reply-to:  etanous <etanous@nvidia.com>
From:  etanous via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jul 02, 2025 at 09:04:25AM +0200, Philippe Mathieu-Daudé wrote:
> 
> Hi,
> 
> On 2/7/25 08:47, Cédric Le Goater wrote:
> > Hello Ed,
> > 
> > On 7/1/25 22:33, Ed Tanous wrote:
> > > From: Ed Tanous <ed@tanous.net>
> > > 
> > > There are arm targets that are connected to this io expander,
> > > specifically some varieties of Aspeed 2600 BMCs.  Add it to Kconfig to
> > > allow use.
> > > 
> > > Signed-off-by: Ed Tanous <etanous@nvidia.com>
> > > ---
> > >   hw/arm/Kconfig | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> > > index f543d944c3..6ea86534d5 100644
> > > --- a/hw/arm/Kconfig
> > > +++ b/hw/arm/Kconfig
> > > @@ -532,6 +532,7 @@ config ASPEED_SOC
> > >       select I2C
> > >       select DPS310
> > >       select PCA9552
> > > +    select PCA9554
> 
> Note, these i2c devices 1/ aren't part of the SoC, but boards/machines,
> 2/ nor are they required to have a functional machine (i.e. a i2c link
> could get cut or an i2c device ending dead).
> 
> I'd prefer 1/ add a ASPEED_MACHINE layer selecting ASPEED_SOC and the
> external devices, and 2/ use "imply" statement instead of "select" for
> devices, as per docs/devel/kconfig.rst:
> 
>   Boards specify their constituent devices using ``imply`` and
>   ``select`` directives.  A device should be listed under ``select``
>   if the board cannot be started at all without it.  It should be
>   listed under ``imply`` if (depending on the QEMU command line)
>   the board may or may not be started without it.  Boards default to
>   true, but also have a ``depends on`` clause to limit them to the
>   appropriate targets.
>   For some targets, not all boards may be supported by hardware
>   virtualization, in which case they also depend on the ``TCG``
>   symbol, other symbols that are commonly used as dependencies for
>   boards include libraries (such as ``FDT``) or ``TARGET_BIG_ENDIAN``
>   (possibly negated).
> 

ACK, seems reasonable.  I tried to follow the pattern that was there,
but agreed, it was odd that "board" level things were added at the ARM
layer.

> My 2 cents.
> 
> Regards,
> 
> Phil.

