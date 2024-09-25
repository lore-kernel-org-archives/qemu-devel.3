Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD8FCCF9ED
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 19:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stXqz-0001Ob-A6; Wed, 25 Sep 2024 15:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kinsey.moore@oarcorp.com>)
 id 1stXqv-0001N9-HM
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 15:39:10 -0400
Received: from mail-mw2nam04on2105.outbound.protection.outlook.com
 ([40.107.101.105] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kinsey.moore@oarcorp.com>)
 id 1stXqu-00065v-17
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 15:39:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAfYlhttOKmVj8e+VQfHTS8uex09fLn+W8jQ9tcGrfwl70sAh5/ULSF7K3Yj/oCirXKI7KOX2kZsugtTP7fwaC/byguY4eaofTEWYgkS1dt6e1ETTQpAgU9gIihQ7RMiD9Tqxlpc7LvBDrZQibxfkrn5lf5YUdWXaJwJkxku7NnVA0sZ6KATOC0dAJycTgjAn1G/Xuyc3cSwG32CsWyp/kWthuD7c5CQLPA4xk8ApZToQwFcYLyXGTlc6d2AXfhJ7XWzoaOewYjRNp87mIWH+M6kin6pOMhAAFtnZWyp6kIEmq5touRJBP5VfnobLZTW1aycJDzEnFMx1G52otdJYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sG1E0g3AzYci7upXkys2I2RrxRHA+fNWWFr8Zynrp08=;
 b=Yq/vQjemTQPmB8xZGeHYZWEG9C5VC9RrBVq/25BKsyeu3xBHkZDIdicLC4GJLO4lzlxKsOT1mitbNiYti5A6sBogWs1VVPWYHqP57YOiFQ1WwTFjqHQWjJzguKovqBIQMbMmNa5UktNcvRa3hdC5aets4OGJsminh26a4NN7G3cLSL5B2YW5/tVeSjAOjeILCDRFshTLiMdBLO82mpw+bske9ZSJLoj5AVhVLSiD6B2uNNBX6sW7lk8cOW4FWXodpB3HAVhVaQKCZrJ7xYE3sIV+j6wnOqyHw8njjPSQ2CNMyeIhuXDNQty2Rg9FH6RYVm9gXs5vThT14HsW2Swidw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oarcorp.com; dmarc=pass action=none header.from=oarcorp.com;
 dkim=pass header.d=oarcorp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oarcorp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sG1E0g3AzYci7upXkys2I2RrxRHA+fNWWFr8Zynrp08=;
 b=IDlVQvjgPB/2mSSfpOy7oSWkET0hquuPgSMvlbRGe47aD205L2/K+/UFsaByiMpzipzZBZoY0I/oJeLRk+n/t72Zkb78t9TEe7PEz3u4F3nKp7UZR1MNGFUyRzXh7SYDxBfsTArBObjDkbE/9m0tUYb02PC+b4UsZMOGrUzGzhs=
Received: from LV3PR19MB8278.namprd19.prod.outlook.com (2603:10b6:408:1a5::17)
 by SA3PR19MB8195.namprd19.prod.outlook.com (2603:10b6:806:381::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 19:34:02 +0000
Received: from LV3PR19MB8278.namprd19.prod.outlook.com
 ([fe80::5dc:f2fa:e0cf:9b38]) by LV3PR19MB8278.namprd19.prod.outlook.com
 ([fe80::5dc:f2fa:e0cf:9b38%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 19:34:02 +0000
From: Kinsey Moore <kinsey.moore@oarcorp.com>
To: Francisco Iglesias <frasse.iglesias@gmail.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "philmd@linaro.org"
 <philmd@linaro.org>
Subject: RE: [PATCH v2] hw/arm/xlnx: Connect secondary CGEM IRQs
Thread-Topic: [PATCH v2] hw/arm/xlnx: Connect secondary CGEM IRQs
Thread-Index: AQHZoGAwP9LGbfXnJEiNArWf/R9l+6+Pm4+AgCOUEICCuJLNMA==
Date: Wed, 25 Sep 2024 19:34:02 +0000
Message-ID: <LV3PR19MB82782241F7CFA4A66D762D5D90692@LV3PR19MB8278.namprd19.prod.outlook.com>
References: <20230616143803.73926-1-kinsey.moore@oarcorp.com>
 <e36a681f-53e2-8379-078e-25e43fc3966e@linaro.org>
 <20230710140948.GJ6984@fralle-msi>
In-Reply-To: <20230710140948.GJ6984@fralle-msi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oarcorp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR19MB8278:EE_|SA3PR19MB8195:EE_
x-ms-office365-filtering-correlation-id: 661fbe7f-c228-4b8f-fec9-08dcdd990298
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?flO0NnUD7n4vw9UqPGu2KaN9JiG7w2eDn48GhprkyiDYVhn8GuDaMa+8zN?=
 =?iso-8859-1?Q?m1ba9381Wjd4azx7FVECmdIPi33EoU6QqFFAvhsf38mVfWb9lfrJXkAwqG?=
 =?iso-8859-1?Q?7RmoHDd8WZ+gI8yIbc1covGra9kXv6/RZ1OjJ+KuDrrUsAFrqEVaAYefpa?=
 =?iso-8859-1?Q?N2pCQuSobqnI4HSUGgmByR5txZpVoe3Kay3S9kHqpQrCJl/LUQE8rdcyZS?=
 =?iso-8859-1?Q?mTGaTt8luqEQ7EOsmXzLDbpFm4Qx2qIk08Gl12y4J3CNRCd4FWGak9PrWu?=
 =?iso-8859-1?Q?wwWMCBJ3beAOWvLag/J3Tur2SiFy4R8veRfIzXj61ERoGyo/eDnAIsK8kR?=
 =?iso-8859-1?Q?4BIQS0/GiXsYj1fj6WpA0yPnxLFgWZ9VPP7fLsVnC8bz+RefhX7MmwlMiY?=
 =?iso-8859-1?Q?6ONPrqarz+jBbhZ3bDL3OJUbRQ+vjP3K+iMFb04/NXwOBAFanbxfM5wO1E?=
 =?iso-8859-1?Q?eviIqTb2ydDqGTdmn6gpHAiK3EXswYCv1aN54uZBOoSQ28sBWx9saRXqdH?=
 =?iso-8859-1?Q?VYxryCbrWGcItOzPIRJHJWPEH0SwA34yv2mJo/EImOftFw1zuN5swBfKXo?=
 =?iso-8859-1?Q?kUjyIe89nMdxMaW+zvh09RkA+5Rv3RX+zAyuWHN6DF1a7v5b9NsoCKmrkt?=
 =?iso-8859-1?Q?unuYdz/DrL7gduo/uA8JSKaiBU0A8c78XnlL4F5KqwhmkXIHhFxTSCIDUP?=
 =?iso-8859-1?Q?ALc5FHYop6YM4GHtL/4o86YIA7mixvtaDqK8L1D14kLz+suFPlvdOQ7vuV?=
 =?iso-8859-1?Q?dwiR5H+VEx2qrZr62fUPCLxls8LJ2uYrjkj3xnu2XpsrhUrN1FEqLo17VL?=
 =?iso-8859-1?Q?dH8FAsjmxPF/KVk65+BxTgiAVQU5lLJjvYhectVXfxrsvYrtgSVXvMMf7v?=
 =?iso-8859-1?Q?4KXhq1IEBSwLAX7I3TXGdSOwYbfg6QFvmsC9w/fWQm1zfOiQzDBG1CYzp3?=
 =?iso-8859-1?Q?QWm9ul+ThqIhDSaruK23QGr5SGy6rGdxk3JPVyKxindbfjkJ6eBmND3B6c?=
 =?iso-8859-1?Q?TJ2fGLXK+HZPInHYi34J6iEPSV5U5Oozf+CxRDcHXSuEGUi3sC1CpzP+n/?=
 =?iso-8859-1?Q?flPjPBYH8ct6ET9PCx3i/DuMUg6KmdgGdcm8UJUxu7Bzz2FRI94896qjR7?=
 =?iso-8859-1?Q?F17OVSAzMv6vOn7Nz1nu5VLc63b5I5384tv3AKxbwhALOGjw1hdK07hC5R?=
 =?iso-8859-1?Q?PbaYSqdDoYI0Cnx9ZH5FadhqeTSe5RhFwHTqRZs5Pu1triqXRFSyPqqQBp?=
 =?iso-8859-1?Q?SKRV/cnCAOR5BrHFdWioxNNuEQC7JXiPs82v+h/oTr4vZ0ItxhCCQ9R8w8?=
 =?iso-8859-1?Q?07Tu1UtAG28ZasymsDbqFucwX7MiBOMZ9ZxCm7FJZ5J2Fl6vfKTZIQlAr/?=
 =?iso-8859-1?Q?3NJD3Mi/O1QlA7kZrFHQTMcDSptT2RlnXyb9msDpGzXMvYmugvGO1tbnPf?=
 =?iso-8859-1?Q?uVKS3laBBDqOfvZQyupML7skALh9Ozkav2jb1g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR19MB8278.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rToyVxFxmes7MuU4dsYJukZgqSMj1WBM6WG6h4hYWDIU8MCn3fCmJ4snx0?=
 =?iso-8859-1?Q?D8X6BBcr2a/sctr0dwVlcqg87UkZ/FTCiq61lJk03K/AjlwMcRMck3c+7R?=
 =?iso-8859-1?Q?napPjb7NXuTxI9yH5XBN3h+7Tf1+BCCyzui6nYwREbp9wDtgzA0ULrO+e0?=
 =?iso-8859-1?Q?fvDHLswTb5/563cueePm0epUsVo2hO0lsKqMs/W/V6BCjfHLfdjfOXt+45?=
 =?iso-8859-1?Q?cEHNmNeU5985iWxhnYFGMNUNeFZ73S0fLm+5i/w85LZM/9a6VWSzye/2a6?=
 =?iso-8859-1?Q?up4QuXoqlwVAsxgqHnRX0XBF2H4OlJiCjGat92lyM8/q5/PK+pK3SARgV6?=
 =?iso-8859-1?Q?EwqYjS/BkzAb1pAT8Z/ys+NanbyjWl5X79qqi+/UtNF5iL++3RucMmFPvh?=
 =?iso-8859-1?Q?8hQBoLprjLwHG3ywk5w2L8EE1WHm7ABRO9QKI9L3qzlS/SPehfYnKhIGbm?=
 =?iso-8859-1?Q?YECP+UJdrY0eAYmIY4bFOOOp3fbjeuqcaxjXxf0jAVdIwy0Qmk7cVVheqX?=
 =?iso-8859-1?Q?Fh0DHGA2BdQndVFc/y4r2b14/2rca5MgrGglpGeqjXJLT+sGxQCMdD1bnl?=
 =?iso-8859-1?Q?nsZ9GhFvVmK3nxFfhNBvh5LNE2xZVJIEqhhbWzSWbizzf1bHAwI9UhfWY/?=
 =?iso-8859-1?Q?/qLOEF08J1sB618IfqSGlRd7lc2jKi0LLEjNRoKb37BWzBTHAMMWFXEbzx?=
 =?iso-8859-1?Q?AWH2zE3UwnGcUoB7bW2ktUW72u/IJpTlj8DItKcY+lzUj+dklKw3jxFNim?=
 =?iso-8859-1?Q?J58ui2Mff3mpKwoA3campLfR1aKPKHXb3A+2+3ucyDNe5qmIZp36NFsEpI?=
 =?iso-8859-1?Q?EHKGvH7rNCocpnq6RbxspCJPbpMuuP7rXTeY1wb+Y7x/0iUHdT0SpyKTl3?=
 =?iso-8859-1?Q?GroiEJkUi15m0CtJ6fWaFaIh7AL4AHeAv6oqNKC8jAKL7tmW0ZFqUCSztP?=
 =?iso-8859-1?Q?NVXm8MwRyaNhPcZWZn3nDL+wK1kydm/bLynZEuo9uqRChxSJK/3apKxcZm?=
 =?iso-8859-1?Q?zVeuA5mES/btqgv8iCXPZM2yldHkKN8Gos4YQ1UeGfCUjsPGUri0yjRV0M?=
 =?iso-8859-1?Q?HIByJqhoFJTYHWg5QvCW9wRzEm1TZ7w7FlyKP0v5WttOceDHl1vceQqs68?=
 =?iso-8859-1?Q?WYUyUpyIF68oPzX+vFaTVzoCqBCWw+3M0oKD29XS7ITswBmAnpQXgzmqG6?=
 =?iso-8859-1?Q?maj3ac1cjd4d8KahZBkJct76kXNJuATdh0j5YAk5pdtn+77DrcmI0lX6Bh?=
 =?iso-8859-1?Q?7m1FwAhW5yPvu+D5dVjHwR4Wx+L4nlI86olmEvs8MxlJIya6lViYOD4lsg?=
 =?iso-8859-1?Q?eoro7Zwfb+Ri8EDPP7sG1yPTC+1h9rp3hOu+hacjzly5AFTpB5okRJ9pWW?=
 =?iso-8859-1?Q?EbOft/Uie+79Yrrh2Cy9FMBKpjDQjHnEdHhtCPWhCSzeX0RoZxdzcDfdiG?=
 =?iso-8859-1?Q?QlpurJY9OeFO2dWA6BclCvPMR+28Ud+c7Vtu1/HE8+M0ix85GZ9ztbj2/0?=
 =?iso-8859-1?Q?RiUSDoPZW3QJ2z8gm0R1FD3NbIgcxykTTS8HQYUlvF+U/IxHB5VyzuQAju?=
 =?iso-8859-1?Q?p/cU00tBMwYo87mdSJOiafNk+2CW3Nq0jj8pIQIzs/STmv8sEn8TpD+6Gy?=
 =?iso-8859-1?Q?bm20WJtGelGMzEn+/QZK8j3F9sMlVVHI/+SbhUltKLfSgOEl2fuMPpgWg2?=
 =?iso-8859-1?Q?Zj039YTbTGSMtTn4BpI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oarcorp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR19MB8278.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 661fbe7f-c228-4b8f-fec9-08dcdd990298
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 19:34:02.2735 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7bdf32a6-03de-4c70-a71b-8665ba1294e3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4aYUewaBdAzFJ6b2qpStxrbUGLedAExyLcekVbPAAKICekDJV2M2Hq42gTNYlUoN+MLHIpvqaJoiPN8+qQJpGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR19MB8195
Received-SPF: pass client-ip=40.107.101.105;
 envelope-from=kinsey.moore@oarcorp.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.828, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hey,
I just wanted to check on the status of this patch since it's been sitting =
for a bit now and I noticed it hasn't gone into any branches. Is this waiti=
ng on something from me?

Thanks,
Kinsey

-----Original Message-----
From: Francisco Iglesias <frasse.iglesias@gmail.com>=20
Sent: Monday, July 10, 2023 09:10
To: peter.maydell@linaro.org
Cc: Kinsey Moore <kinsey.moore@oarcorp.com>; qemu-devel@nongnu.org; philmd@=
linaro.org
Subject: Re: [PATCH v2] hw/arm/xlnx: Connect secondary CGEM IRQs


+PMM (I think this one might have fallen throught the cracks)

Best regards,
Francisco Iglesias

On [2023 Jun 18] Sun 00:50:47, Philippe Mathieu-Daud=E9 wrote:
> On 16/6/23 16:38, Kinsey Moore wrote:
> > The Cadence GEM peripherals as configured for Zynq MPSoC and Versal
> > platforms have two priority queues with separate interrupt sources for
> > each. If the interrupt source for the second priority queue is not
> > connected, they work in polling mode only. This change connects the
> > second interrupt source for platforms where it is available. This patch
> > has been tested using the lwIP stack with a Xilinx-supplied driver from
> > their embeddedsw repository.
> >=20
> > Signed-off-by: Kinsey Moore <kinsey.moore@oarcorp.com>
> > ---
> >   hw/arm/xlnx-versal.c         | 12 +++++++++++-
> >   hw/arm/xlnx-zynqmp.c         | 11 ++++++++++-
> >   include/hw/arm/xlnx-versal.h |  1 +
> >   include/hw/arm/xlnx-zynqmp.h |  1 +
> >   4 files changed, 23 insertions(+), 2 deletions(-)
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
>=20
>=20

