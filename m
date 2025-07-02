Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1732C83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:33:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX3BZ-00067q-7t; Wed, 02 Jul 2025 15:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uX3BX-00066S-50; Wed, 02 Jul 2025 15:31:59 -0400
Received: from mail-dm6nam10on20616.outbound.protection.outlook.com
 ([2a01:111:f403:2413::616]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uX3BO-0002a8-SA; Wed, 02 Jul 2025 15:31:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKGx2ZiUSJp7ss0y4tK/D9gf2PgtFCjOQFg2WubvHhJGDSEs5llJGtDw6MYSIsfQu8IO7rcOfFTVq6bFuA3pCoxeepb8QcN0PfMxggpnOoiwVBiLM1lVoUPon32kZAUq1yj1DfmRgtRQaz6l3c9Y5N9Yuohl3Cs1vgj1GkaX0ABBUQhpGz+PWlOCf8/FJLO+Rv1fac46n5G0+2ufG+tqjHH0UrmZGEH1AiVEarboTIC9BUkzzZdK6IUwNtw3kcM1ynOkC2ylJgUB54ofooXHddatog+9tpwEZNYBcPjazQuw5nCtjBG9Q3jIJI1KWmjLWpPAvRgyIuTGuJF0UmWs0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ztEijExMSzUJcxFmhJnCvouHB9woAcb+gIR1nn05Sw=;
 b=L8QAaFLPzTDFARNsHtrl5lXorMzg4R5HA9U0Q7cNXE4zVTMB03aS09nbpSQbMjYQOalOAGeHVpcztKa3DwTLnR71kK4LvuBHAdhcKtgLKcRoHOmy7XNYzerx9WsKdmPI/ESPX78JVBCOk0booGPuxDA04LHw3SvjcY47lya4W7WBJq8XMfXTHVnsVSKJLCUBoAAnxU1e5aJaOJrwD9/yI1F0H86FtnRKA1Qk340jMgUjguPr9IiAfBvBXg3oE50jdLK2GRAWA7e/qa/nGFn1KqpQnGZUaUNXYr+71DjUg9+GOJvgvD+B+ySBaCcoXkRjDQRQPgRqIlZNVzSKJ7yhWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ztEijExMSzUJcxFmhJnCvouHB9woAcb+gIR1nn05Sw=;
 b=mAAMntCkMm3HlKteJRPGMoFY6Y6NKqAlitQO2EoFOrSxAqd2tRmy7xSdOESj4brsgv0gar+G//pOofYvVYjA/5MNnMDXczWv3rLuJEWpSLERqfXWRX5W9RVovbgt250H2Il6BfJ5uMNdpgVAirXVUbA2r0+Oara0KragAnG8kzUN9WC+f4d86yvhTRpIxD6PlyrPnjIE1wNZPK/yGNB5bCW2leMug0Im4V+raF2Bu0qeJRJfXNUImBGqJ28+dU+lt88HLm4RY3p9JrE1hpMeLn9gaOGUXwp/k7t5BQOwzLKaXtkL4MSlfWeJubfWxCVGe1GgTLfokO9V+dodUhat8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23)
 by SA1PR12MB7174.namprd12.prod.outlook.com (2603:10b6:806:2b1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Wed, 2 Jul
 2025 19:31:41 +0000
Received: from CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787]) by CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787%4]) with mapi id 15.20.8880.021; Wed, 2 Jul 2025
 19:31:41 +0000
Date: Wed, 2 Jul 2025 12:31:39 -0700
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Joel Stanley <joel@jms.id.au>, Troy Lee <leetroy@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH 0/4] Add support for gb200-bmc machine
Message-ID: <aGWJG1fO0vmL_RyU@edtanousvm.nvidia.com>
References: <20250701203400.71677-1-etanous@nvidia.com>
 <b70dbdb3-0d1e-4976-b696-78065bd09640@kaod.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b70dbdb3-0d1e-4976-b696-78065bd09640@kaod.org>
X-ClientProxiedBy: SJ0PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:a03:331::24) To CH2PR12MB4277.namprd12.prod.outlook.com
 (2603:10b6:610:ae::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4277:EE_|SA1PR12MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: c860c9d3-2d33-4727-8dec-08ddb99f11dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?b6S215EYon8GJhzkZJ0Q0BXd4wSBb8wCiEzldkequHlx8poMYqJKkGwmY9?=
 =?iso-8859-1?Q?gyd6RcTHiaUZzIBefRrL1NV3Dw5B2CwzYiKEpcMYMX1F2MJzj41MzL1b5y?=
 =?iso-8859-1?Q?kPcbDP262HBSXdYznQeCeMkxOdLK7OUgWBPeu0C6dfdW0l6A+by5NM+MoF?=
 =?iso-8859-1?Q?eNXb2NsDb9GCt6006iqeAljnGdokDALTA/EaE87GVme4hTmaO1/a1L/cVA?=
 =?iso-8859-1?Q?iHTTOTvyrstFsebl3vAghrPce/QO17bBR5i6/FBF6Ak1PM+yWagoo2HM9v?=
 =?iso-8859-1?Q?93luzeZ2NspN18ANiBvoF15EVHU9Bl6IrJIAt5hSRqIYxUd9UkNpU2a21L?=
 =?iso-8859-1?Q?bV8dnc7p1wujGgXQMARv33WQFkyOxZYKVQwct1TGvQLeVse36U8sx82Xww?=
 =?iso-8859-1?Q?bTU/I3fn1MQOvBjU5WodNQMTMa2kVta47ETdpTwYgrx2yLleOtZKrx8xP7?=
 =?iso-8859-1?Q?KAWSI/8aA55ZrCmCPoUEx/ukQr8GzgMxhSA06WwtoSZWC77wWBRJGTEp6g?=
 =?iso-8859-1?Q?xBoU9KAN9cscg3zzeP6PT9E84Qh8EKhX668iDo7fD5tpJ+zN4XfC11Jt5i?=
 =?iso-8859-1?Q?I+l+TUoTKr//iOu/seMthWtXnG6EIczUski27Be2r4EdLvPzRh2TiGJ1by?=
 =?iso-8859-1?Q?lyAZ9gWfOyUbu7GIqhRBup7jxyB/NaWIdkfjYwJqHHHxrFJD0FzPhyKSBX?=
 =?iso-8859-1?Q?mmB0KoG+PywIeWIdgzE3keY4sVvVr/0dsUtuKoaDEEWBUfUbiDs2SPtBqg?=
 =?iso-8859-1?Q?3193abeCtQINKC19hwc13AldndIoieqsDfiWaU7JPFXmHySOgzfC/RGZnt?=
 =?iso-8859-1?Q?YzeapT4Efxnbd6vn17h8UIaOoFsCWF4KjdJZPaYCtV7bAxvkE3KJdFi60g?=
 =?iso-8859-1?Q?AP7vyeJvoP9QUoMSLaREsMjGsPSusOrFUXYuPOj+hiIxGLZuQPvPup2mjz?=
 =?iso-8859-1?Q?JL5Ju0OTwYfp0aftR0Yn6aRX0i4cc/oa2WgXTKCExJ7oFPgPy4AlfvaR6q?=
 =?iso-8859-1?Q?l02q7Dy7NWkS9G2pj4fboq2W/grXGE4wPwELhDpeK8LaaehD2kSUBS/Num?=
 =?iso-8859-1?Q?b6GYMJUzlWOwHZKvUcCJFZT9HhuGT8fAaU3xlqV+ag6dSa4paYzEAiQUFh?=
 =?iso-8859-1?Q?kMnn3haMhECUTG8Fno4NEb8p0yVIjo/qqIexyW7ww2vUkd4G1r8Ghx0nF4?=
 =?iso-8859-1?Q?CIoOtnR/xSkjk8qg4MUwwnuX/hQTRoqvs55+E4smAY+PwOugO9oj7IA/oA?=
 =?iso-8859-1?Q?HSZasVwurxn6oLfGA4bEItkZJrrMxEqibQkY3j0tfGXMvRnzBG4/88ycPn?=
 =?iso-8859-1?Q?6/WFE/oRGqTcLo60uZiLwAdemGqwMt3pzMSSFUZQjPL5Uj+++skWHj+Znc?=
 =?iso-8859-1?Q?jCarCJxrc1skxDrxuEvArv9BcMSFq/PzT1y4kZTKPQv2UfwjDi55yqg6UN?=
 =?iso-8859-1?Q?jxGClST7PKb31JHFT14mw2Dq2YwmxZde+yWYJV8SezOW/VZB/M2wz2sEmi?=
 =?iso-8859-1?Q?o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4277.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?SIw6hSgaEBEnGjIKxP9LuxmbDxpVAF0hNWGIsZSxsZZavZ2xjWDBEnBPiM?=
 =?iso-8859-1?Q?Mlu6iYUzYumn5eK1Bfp4qMyeHF3K1ImYNkPV02AT7Fsh/9LW65xPIYV/MR?=
 =?iso-8859-1?Q?rUJrSS9glqP0E8Jm4lJsUF7pOYHUyzy8o8eZC0Arnm4LONqov3HuybSSCE?=
 =?iso-8859-1?Q?ThcYKQAdKniunW/8+1129SEGxe48SIAlKEG4XvIHMDrGsQm+zaMxhFw7S9?=
 =?iso-8859-1?Q?Tx7WD8IoWrwizAGoIeNYpuKiF+kHLHeF7A/PBac8leQ3JIuH8gi/NeE9mr?=
 =?iso-8859-1?Q?zl/12R5i7+Fk/azPmBPd/FpY0yNwPVuu+LKceOtuy/oPnRoGV1l/G1rKW9?=
 =?iso-8859-1?Q?1GvdRZTj08rya3il3Q0svopPMAMpSShoYGle5S10z49aBQg1fkVLpg8sEL?=
 =?iso-8859-1?Q?3AThApv0MbPda8BuK+hccbNn22oMvjOcTkKr5y9rMcVrEtVxd+sphQf11M?=
 =?iso-8859-1?Q?IFNhOyPXzMncrOhYgmIUMCTHTJ+jH2bM96CnTnfHraJsMwNseDb3sTWfsL?=
 =?iso-8859-1?Q?xHmU9VnZdF3k6xuCB6e8F/rO/2FZ0Qpn5penj7IdA6k2wcz5mIvjoqC1vd?=
 =?iso-8859-1?Q?7HCe1vJITeCYi8raPJnmTrHRphJUQFgJy6Sr4Kf4RtviAuwxbpO1dMTnqe?=
 =?iso-8859-1?Q?fqTlAI4b0IZB+cPG6gaRYGVcNh3Tz8fvkU7eL3WQaip7oXlOB7CDQgzblk?=
 =?iso-8859-1?Q?a+CaY85PinUyYTq8KJyXFxFZfJbkihKIffkjdkmRAJ27OANGkjUppkWV0n?=
 =?iso-8859-1?Q?pKb3gaHAmnG8DhZc6JUf2XKrh0fS5yXWCVD/d01m47bripFxth6W08SRje?=
 =?iso-8859-1?Q?UzCABEw51bKggrmIYEIOkW2ZTLSOKSDL9CUm+RotudXBW0y+TpBNg7Mkdt?=
 =?iso-8859-1?Q?1BWSOEmLgzHuIy3Y8JZXecs2GwDbRKShKcdggshJnNEC0hEVCjqhLE8R82?=
 =?iso-8859-1?Q?FIirIzK9PKqK0it/0JHhjH09/D+V7dTWkXlejCOCwMX0swl1BnqMC+gmka?=
 =?iso-8859-1?Q?47Frf25AqEAarIqLRMD+aZShKywwiVCO5jqACE9urrGDv/TckNOzfnxO3K?=
 =?iso-8859-1?Q?h/XGMhqe648OUhuPh5WNv4Z7e3HitOrggh/JWH+EL6Aofo8DkCHymn54KS?=
 =?iso-8859-1?Q?QLa8OOge5v+b0o0xure9yAyhQLXV860c7O/uQnEeUQALzMY4d+20CXthoi?=
 =?iso-8859-1?Q?uMIOKLT1J2UxkWYq7/853ljhnWk/tTtgZ0AKq/oO5/W//oy+bzwkDLZ5xw?=
 =?iso-8859-1?Q?uGmI1f3ppVq4GMv1RbUe5mhnXzpKNMKVXoEwVIciRoEA00XEMqJSA5bf4+?=
 =?iso-8859-1?Q?8Y1MlVF58Q4EFcuvbcsB4fqShKEoU+qNp2UqKMBfdl4MTd1gjWRlWAGk5J?=
 =?iso-8859-1?Q?xZ/fsiKlJl46aguySB65GfxYXEjvkw4wdKHc5bNqlbvfhOOMkenSkMpdPQ?=
 =?iso-8859-1?Q?BnAd+BLJ2MnaUE6fHvBE9fwYNZCKIr9bjfJNnmJ76ygYByMq5SYu1ZnjmU?=
 =?iso-8859-1?Q?RUjBE0JLJdVHBiL7YIxSIzsBe2a95vxAD/G2GMFNmawUf6ov7ROanrR7Wx?=
 =?iso-8859-1?Q?fC99NIkVrEqMQEgZ9Y896SeLr4CsVhX3RWr/6nx4n33EEo+qi/l2raayYg?=
 =?iso-8859-1?Q?OHho83iIxJ3CbffGpsDM5EzktLrOA64NcX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c860c9d3-2d33-4727-8dec-08ddb99f11dd
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 19:31:40.9595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0W3Pw3/+m4RuEDQQRyPCwyH+dX8zNx4i1SZRv9/DFu9/T9nvJWgKe3De/hBlPWAUe1SPgNJweues/h5zFELWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7174
Received-SPF: permerror client-ip=2a01:111:f403:2413::616;
 envelope-from=etanous@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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

On Wed, Jul 02, 2025 at 09:00:53AM +0200, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 7/1/25 22:33, Ed Tanous wrote:
> > This patch series adds support for gb200-bmc, a baseboard management controller
> > module based on an Aspeed 2600 SOC.
> > 
> > Ed Tanous (4):
> >    hw/arm: Add PCA9554 to ARM target
> >    hw/arm/aspeed: Add second SPI chip to Aspeed model
> >    docs: add support for gb200-bmc
> >    hw/arm/aspeed: Add GB200 BMC target
> > 
> >   docs/system/arm/aspeed.rst |  4 +-
> >   hw/arm/Kconfig             |  1 +
> >   hw/arm/aspeed.c            | 81 ++++++++++++++++++++++++++++++++++++++
> >   hw/arm/aspeed_eeprom.c     | 21 ++++++++++
> >   hw/arm/aspeed_eeprom.h     |  3 ++
> >   include/hw/arm/aspeed.h    |  2 +
> >   6 files changed, 110 insertions(+), 2 deletions(-)
> > 
> 
> Could you provide a functional test for the gb200nvl-bmc machine too ?
> See tests/functional/test_*aspeed* files.
> 

Can do.  It looks like images are pushed to
https://github.com/legoater/qemu-aspeed-boot and accepted via Github PR?
Will open PR shortly.

> Thanks,
> 
> C.
> 
> 

