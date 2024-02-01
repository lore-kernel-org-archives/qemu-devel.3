Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDA0C48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 17:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVau0-0008Pd-60; Thu, 01 Feb 2024 12:31:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregory.price@memverge.com>)
 id 1rVati-0008FX-Lg
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 12:31:00 -0500
Received: from mail-bn8nam11on20700.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::700]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregory.price@memverge.com>)
 id 1rVatg-0000WV-1c
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 12:30:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJa+B/B1iPsIpUhRvEJQQQoIswpZBu/tNNwmVjWCMGQn0/tomXCp7O9jYmmK20beb+HEamcjCem4hleHxNRCBGvYr39hAkBz4iHu2i8DSIC4KJSype1ryLs/uYdCrYjwLy9x3y81yLuMTRcRLW8y6t8AjTsrWK2C/t+P/upJRQxF1IDMCcBF29cErynQEneabp4Ps9chEttDjNUf1cF1NF2zcBk6XNZ7P4WqE2SQaDPPWtbpWSUWopPtBk0RA4nZm7Kp+8AMyjJ6Dr+nPujYs3xALykX9V/btHC+YC4W3OKEntkkewFgl/dEJ716+JiHek08pPCJMnGuHWzAwWRnSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6brdlZmgUd6r4kA/Bgzd5ZhGelTsoxnrOOI4EOn6um0=;
 b=lFQu/E+ErBKQoGfJRkdSCC8NzwPFUcsjww39bVtEBVH10s8xzGPrmlHf9ttp2N/4KivthjEqG9ZjK9TcyhOaWgRJwcAA5GiP/dCAyoSYuMSjljqFy4W3CFCdkkqzkBEhP64q8HxP4wTq7D1BajikIgSiBRxSCEY1fQx9HGDZ92xIv0oINhhBytA/UDUfSJZmSsqUEk+FigsFHIEf7gZOs2iDQ4MqMKLHM1qMoeHgFHwQWBMPmIZf1mEukbb6bKDr6MhpsnPPwUCDxLSEpQbKMmyDqwTdurUERpTXNq+0kT/Ers8FYU0RtxmRzorswd9i/BmpsLsEPcYIz0m86NXpYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6brdlZmgUd6r4kA/Bgzd5ZhGelTsoxnrOOI4EOn6um0=;
 b=YOGLtWPSAYGEUFapphe+50ZvaH40MpHFP194vPjIwxckkzDSiPq++wLwYtmKxClmjM01nPvxZBxsVvAwz8WAVsvcPnYbGELLkB7TEniBl5hChdx/4KBhToL15Z/Plc+613YterGloF6CTsJo5OGnBV0E0YdlCfXCnPW3wEwazu0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SJ0PR17MB4792.namprd17.prod.outlook.com (2603:10b6:a03:37d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Thu, 1 Feb
 2024 17:30:38 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7249.025; Thu, 1 Feb 2024
 17:30:37 +0000
Date: Thu, 1 Feb 2024 12:29:43 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sajjan Rao <sajjanr@gmail.com>,
 Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>,
 linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 richard.henderson@linaro.org
Subject: Re: Crash with CXL + TCG on 8.2: Was Re: qemu cxl memory expander
 shows numa_node -1
Message-ID: <ZbvVB4J+AHkLNuE2@memverge.com>
References: <20240201130438.00001384@Huawei.com>
 <CAFEAcA-rgFmaE4Ea7hZ-On4uyaqjWoo-OwwfNrUOdp=+Q5ckXA@mail.gmail.com>
 <20240201140100.000016ce@huawei.com>
 <CAFEAcA9DW8AuMwDr_qyDXPWJcLsvD773XTr1stwuagHWc6p72g@mail.gmail.com>
 <87msskkyce.fsf@draig.linaro.org>
 <CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com>
 <20240201162150.000022cf@huawei.com>
 <87h6iskuad.fsf@draig.linaro.org> <ZbvPGV0a3xOMsAMG@memverge.com>
 <CAFEAcA8oLkpSsAabYNxXQTEuJvG93xJoP3yxv0JqJfH4udmNbw@mail.gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA8oLkpSsAabYNxXQTEuJvG93xJoP3yxv0JqJfH4udmNbw@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0256.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::21) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SJ0PR17MB4792:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec08e55-784c-496a-f80e-08dc234b8124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GfsI9yQDmzmK+Q/nRyYWBqDuDo3VYTnkKbh0Fypk64j52rOeGuNrIupod6PRdk56CTBp9TJlpfyCqvj1ukvPTYOB6+uHlN/IRWUOuj0/WQ5261Y7fCi7IABPBjKQFdcZ9y3cvLA+tjBDOz0aoEYtxf9nuh38shxoKiznfQtkGMgI5h2OILCEHItFnVcL2eSWIf+G/4oVSANCUINyonJzeUgIDFNI7QodD7iF4wHuy9TKJDKHIhYccLvhrWMHCqTptQ89l4a5MQue3rQfMALNg0pcYNHunqbFQITQ+ajNC/Of+OWuiHHqSc5O4b4aA1xyaJNNrwt6wIC2rrXHVOlGI0OTRZ1pNKZGQ1hTtb3qoHkMeJG0S8+OKkL+hHS6i82yx3cd3zHuRaus0R4ex94BpYE8ANV+LZoCnA9TWrK1VDKHJcG5lPXnrcUzfEGp4dG5YVN2Wi0rtg/E+9MQJiPKsKTi2wSu9gzHqIpCq+TghJ64eMT2nuPoG+vdmb4UKAMroMU2sFXPaSPYAcKNi93eoD3/fw3/cknjZAAq08xxUmcPQwUU//u52LeLKBO0d1FCq8Dd63W5yCwUwT598wuAekf1CrNO1/Areg/GnToBssY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR17MB5512.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(136003)(39850400004)(396003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(66476007)(66556008)(66946007)(54906003)(316002)(6916009)(4326008)(8676002)(8936002)(6486002)(478600001)(86362001)(4744005)(2906002)(36756003)(41300700001)(5660300002)(44832011)(83380400001)(26005)(2616005)(38100700002)(6506007)(6512007)(6666004)(67856001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?y1jpJS85OxPUZdxvRpeNOgBxPxEmjs7gnCQM1ee6+SQFKSZyPBWTT/YL7J?=
 =?iso-8859-1?Q?GHmcEtcpgcBHaHSvpWCepnDrNnn3K/sOstvPrWy4lqyGGV+oP/LptBDu+Y?=
 =?iso-8859-1?Q?e65IAbvk1KwOH2fHwHQXMaSOiJeqVOhwbiu0w2QOlvHcYBkZz3uWH06ujr?=
 =?iso-8859-1?Q?YZJiqSIkaJkwX3lTgP7nM5R9gFkqbxYCbzG7ttG5YRGIyH0mBikh7dyCK2?=
 =?iso-8859-1?Q?/mJyP+jXl8jBos4QeZU83dCmJJ6oRGkEsM3bvroh+h54fUtvwoeAq3jE/s?=
 =?iso-8859-1?Q?lEgRzbLAaznXdywKTgnVCqAv2687VOsGMkQE1U/Bxm6XkdBj4Ex2kL4c85?=
 =?iso-8859-1?Q?n9Nkl2ObU6wjmeHYRpeEHHWpDkCDDjDNiNOVs8MMjq6YiTG86gOApp0wPs?=
 =?iso-8859-1?Q?H7xRkFHUTHb5u7R5Qko3dGVxJv7LgBRrwCbmNgtsjynDz6NUrtRXKtosEt?=
 =?iso-8859-1?Q?Owr3k5E5M5vXrsECK1pkhYOSeyy6EKQP1C6k7GxaLNxLOPVBrIuS8oST/a?=
 =?iso-8859-1?Q?c+VeGVSbTi/v3v1aTTmX8jpEgx4po9GpxQvnKEr6L9SRoX4U2I3CqHu3kj?=
 =?iso-8859-1?Q?e+hYRrMUmjvo959vHjY21Uwjq58e5FcilD8YhLy2w31jV/0eDLFsGMJ476?=
 =?iso-8859-1?Q?xZ5P/XS9btzmwot7kJbUiA5laGdHOTlHiQVcbVHxFX+tT2PDK5X0r8ATtl?=
 =?iso-8859-1?Q?dD10xAkhIjWW3MjF94PuWoeN4V0iAKAGAzBQUqSBQWqBqQpEyoE0ohwDR5?=
 =?iso-8859-1?Q?EphlbwBCU1XAjx1G19bBVh7T73rW6Fqb97KHOTSkQVle9fsbx8Hew5sHtX?=
 =?iso-8859-1?Q?bq6Vii67pfqvcvGAuGHY9mI+4XbXqjl3z5oUkHJp9jdfnD7fEzR2JhiTg6?=
 =?iso-8859-1?Q?kSkOXYcngGUS8cxYBMZATCWXfb3QsiFHV1wL5m7Wb7/ErketyjdS/V7CGH?=
 =?iso-8859-1?Q?N/JvO+jcJz98N8Nn6kj6v0w5tLqya51PJMZwRjbaSPtighpKs18b/jEE7Z?=
 =?iso-8859-1?Q?gMZY39U0E1z45g5J4GyuFxzg9kdJiwkiHB0+QPwvWsZAerCvylp0T8K7a8?=
 =?iso-8859-1?Q?egFH6DlKSwwxinyJ+MNoe5RqyGSuFLF6ctcKuPv2HPHukAtsNgDi6RNrip?=
 =?iso-8859-1?Q?J8MaOx0Xwp3yLeem7ggQTxecmFs6SVf1EWesQfgX20XMGHs86qp7cCjkMz?=
 =?iso-8859-1?Q?tbSCU//G7BBGVA3EQ6MtYPKFI91wGSa+ZWEbSDl7IQKEcIO+e4TVC0RWkI?=
 =?iso-8859-1?Q?EgY+KOkuPe1QqtxYwB3HQRX5YcJyqy9tTp00OJgwEmB1J9Mlo87+nLuRMs?=
 =?iso-8859-1?Q?YQbRcSrQZShBj3IVQZnkg8Pm4vQPmuU5d7EaWonuHcX/AxY1E9UZ8/lSWp?=
 =?iso-8859-1?Q?MHJY4YYPFkPQKyJ33FUSlk5Rkx3oT3wBFpDpkz9nKVx6550JxXgeQxyfPP?=
 =?iso-8859-1?Q?kkrhjnivD04x8GKXdqJ6wQp8/xnx8xHLt+8UgtrsdEfAdHFj/VmxPvCEvC?=
 =?iso-8859-1?Q?B9BTxtBW5FWF9OKi/vJMR9vBlHvt6/CS8bZQNIniwdYgNOEWukYbfGHPlc?=
 =?iso-8859-1?Q?dxrWnj9a14A3NeE+Kp+rnjPdezpjFuZF//3K/DnvlUOJ819sdU5B3iO0dj?=
 =?iso-8859-1?Q?q6KMbCVYHiaM4USHcEz36VuZOkfJObNWinyIQ1DSLKqGrPcb1MDvX1Zw?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec08e55-784c-496a-f80e-08dc234b8124
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 17:30:37.6908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vx1bQ7nP5gJOZS5s6iA2pOcp6pUmEp9u6PCnpPXTdJLslr2Fy/Jl6PdG/PMqYRYNaKfGjc1cqSi+QziGo6SL67LPlj7pb4v0uZMAOzc55gA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB4792
Received-SPF: pass client-ip=2a01:111:f400:7eae::700;
 envelope-from=gregory.price@memverge.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, Feb 01, 2024 at 05:07:31PM +0000, Peter Maydell wrote:
> On Thu, 1 Feb 2024 at 17:04, Gregory Price <gregory.price@memverge.com> wrote:
> >
> > On Thu, Feb 01, 2024 at 04:45:30PM +0000, Alex Bennée wrote:
> 
> > > No thats different - we are actually writing to the MMIO region here.
> > > But the fact we hit cpu_abort because we can't find the TB we are
> > > executing is a little problematic.
> > >
> > > Does ra properly point to the code buffer here?
> > >
> >
> > What if the code block is ALSO in CXL (MMIO)? :D
> 
> In that case the TB is supposed to be a single insn,
> so the insn will by definition be the last one in its
> TB, and IO should be OK for it -- so can_do_io ought
> to be true and we shouldn't get into the io_recompile.
> 
> -- PMM

We saw a bug early on in CXL emulation with instructions hosted on CXL
that split a page boundary (e.g. 0xEB|0xFE)..  I'm wondering about a
code block that splits a page boundary and whether there's a similar
corner case.

~Gregory

