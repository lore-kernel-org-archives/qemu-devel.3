Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E361C5B572
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 19:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuxT4-0006tF-Bi; Fri, 14 Aug 2026 15:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Mikail.Sadic@ibm.com>)
 id 1wuxT2-0006sx-HP; Fri, 14 Aug 2026 15:21:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Mikail.Sadic@ibm.com>)
 id 1wuxSz-00049B-OH; Fri, 14 Aug 2026 15:21:24 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67EH1aG0608496; Fri, 14 Aug 2026 19:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=koYMkr
 hh21xFfW18P1sJrMmLnGfgaGtNO5mzXTJA03o=; b=gmK70roXUa2rzit9pjGu3X
 ry+FOkJS1TKTCeLPO0S0DWcUytdAem6ftcvSKwvUra22iZZYWxHFLKBcpX3L160v
 zIP2wrOmTWbXQHEIdGQGoQ64sRkEkdcx8Jv+k4S7kNwxDmb8GMElHtnQCFN2l1Tl
 SFqJh/H7uD9HoKNmlzI5CfhjLJqe4xlIatOVFblix42qfviz82toFbgBncoAaQV+
 1MEm3IgGYT577nAGys3K8V0gvJnc/esfcQW8uwkJe8KnauTSEuCVA9xpOrl703Op
 0UOZgf5wGPd3GpFcLNiA08Cu+Esia8YDYcIgfMXvsUNjFzmeaekUkYrF60ATcRrA
 ==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013066.outbound.protection.outlook.com
 [40.107.201.66])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb246kfk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 19:20:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qv/uUv27lKjYI+1MyqM+cWgP4q/t1SR1tyUzbf+ZJkkkXM/0DGQzJA8rC09KWF5Iqpf7uB59wx02bUjKfPN6mX1SA/NTtqG7LG7UDh0+2bBoLzgjd+TeTsTPQa4OfQu22DGNLImF/eZqm5KCzKNlqkBWcA/8mfDcpV7QSU6UfJvWycrDrCQdvdHH2lZ4sqNFTjriCEpnd8JH0F0cSor+ecqe7QTb8EYEn9lXZpajyzvl81xgugmi/SFaXvmbctDBewKriAaidQLHHF8Wybbjhwv+ruMNVKk1jiNOKaGNn1G/Xh9ikd614t8eQxu2VFuTq+QOfmDxBrnZiSu6Pz1wsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koYMkrhh21xFfW18P1sJrMmLnGfgaGtNO5mzXTJA03o=;
 b=qaO6QH5Kz3YzV2d4ci5kZicc0u3+XhHHh9n6H5Dei//yVXKFf+6MPM6JMEEhwQzEONslZ8ix2t1dwj4w/T7C9lkt9y4lWw8fuxhftRjA37vDEOFSv7zTRxx+rrvKmbkofbySt2GcQiWdA4mDFyZ3Z8/rZCfuE8KcPBuH9J8gMyR+eKVOVFF2wc/VU30aY/aT8joAo7xY47x9fNEmql4vvnEd1GtTFMRVT5FVzkbAU9EXEalPMC/Dy/fqYAncoQxl5IU5Td+upidvZLfudJvepmvEYfmDorkRsgb6YJ1x1gjXw9hhWTFY8riCoIHYVfWLLm2Fts8ykq1QHVJOfxf6DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SN7PR15MB6138.namprd15.prod.outlook.com (2603:10b6:806:2ee::19)
 by CH3PR15MB5976.namprd15.prod.outlook.com (2603:10b6:610:158::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 19:20:43 +0000
Received: from SN7PR15MB6138.namprd15.prod.outlook.com
 ([fe80::9ad4:d1d3:3b3b:e4c4]) by SN7PR15MB6138.namprd15.prod.outlook.com
 ([fe80::9ad4:d1d3:3b3b:e4c4%5]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 19:20:42 +0000
From: Mikail Sadic <Mikail.Sadic@ibm.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1] hw/i2c/aspeed_i2c: Latch first received byte for SMBus
 block reads
Thread-Topic: [PATCH v1] hw/i2c/aspeed_i2c: Latch first received byte for
 SMBus block reads
Thread-Index: AQHdKwJqkWkcyoBADkCDJjjo6H+Egbabrw9ggABuHACAALCYQIABHyEQ
Date: Fri, 14 Aug 2026 19:20:42 +0000
Message-ID: <SN7PR15MB61380FAD7D6AEA6C2062192B8ADA2@SN7PR15MB6138.namprd15.prod.outlook.com>
References: <20260813090205.853307-1-jamin_lin@aspeedtech.com>
 <TYZPR06MB49802BFC78FDFB21489FEE83FCDB2@TYZPR06MB4980.apcprd06.prod.outlook.com>
 <SN7PR15MB6138B5314F2E7D110245815E8ADB2@SN7PR15MB6138.namprd15.prod.outlook.com>
 <TYZPR06MB4980A0D671A8CBDFBAEF0DBAFCDA2@TYZPR06MB4980.apcprd06.prod.outlook.com>
In-Reply-To: <TYZPR06MB4980A0D671A8CBDFBAEF0DBAFCDA2@TYZPR06MB4980.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB6138:EE_|CH3PR15MB5976:EE_
x-ms-office365-filtering-correlation-id: f02cd47e-0654-4e54-620b-08defa392249
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|921020|6133799003|22082099003|18002099003|4143699003|11063799006|38070700021|4133799003|10067099003|56012099006;
x-microsoft-antispam-message-info: 4kKraByb1kf2hXyxn9vL8InHH1/7Gn37Rwg+q3F+18fAa2edpdcINm0PqlzcJB6nb/qIPX0OWN4PR83CSRzoW4TtrGbQkMtcDMzo1/qkIIg17f/sf/er5rhCvSQJo4UX3MU4z2P3yeH0/9R3U3auh13cFJ43FhuFofs5UUVqV6ozL9Bkc20tv9FcoFWzgknBKrGDuTO2GEr0Tm1R6l74y+LhNPV1+JosCHE/uiG3ITx43fP79sTefM2jZqizknZEVzlfXHwWqkT/JbmadwobxoGFecpmUBx+0LAkH/RdDBbXpSTbljF5rRaB8XkrCxQft5X9s3WNUoYjfAkRxfspEIV6P8BZ4abmdt8hJYaLrbu32PDihhJq3tp6vfmNWg04R0Q1Z/UtX4rsUWp4aAjEgpy09oBOPI2pvLoJLPiKJK44fZ0FqwM2cH4SobUHkd/OfI52GQUKCbAV9SvQuzEmPL1gxnYNhHoamvgpan8Vj2Xf9WbKyqzGqmQtxpbhQJxaiT+GETsuMCImnkPWFABAfQaOWhfzrvF8/DwXHhlpGA3OqaBEWS6LfATrDjtpl9WzNnYg3lYTRXrylaHhjtVP8mOhJXbdz2AFsAspsRpPgqByAqSv8tR2sqZ1ocquse9Ku8Yu5yzNJcjUXTR08MeBm9vvFnlEPnLscGIuBlUjD6pa7NpxrbKoNKl6RAa0j/yE9cJVVPipaJL5eiajlxJneMBz9ew2x2Ge5W08xxyuivBoejBNWTlxE84qXtAJmt6H
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR15MB6138.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(921020)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(38070700021)(4133799003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aLicqFAiwdcY6lV5qI+xPkfQPbPkFuMtd+ddJT24SezwfvHvbNGWU3URgN?=
 =?iso-8859-1?Q?7b1j99nXI2VvSRxd1Wg6gu7aGE8GyFQSnTN2vf3laI3ZTo43SzgKDCxuy1?=
 =?iso-8859-1?Q?W3qV7RynEsAoTCLOCA28m2fNtIZGyP+GDtK3kobt5/3kiYktryEHnbHAum?=
 =?iso-8859-1?Q?9SXnO19+7XxFVlWzeYW4mU4uffuJpiaT3m/UP69lD5lvhk7tKnjEwYs39I?=
 =?iso-8859-1?Q?b+Jpy8+OWW/zr6cYSx8PR7amHfCf+dLS1l7XmvW1d5bGFbTaX7tKP9/DhF?=
 =?iso-8859-1?Q?FcD3VwjMVxTzyC7XG0YjhF3/BMxdSd7JC4EO3C6LbU1z4BVynAZmJ/TeaC?=
 =?iso-8859-1?Q?rW2EABSLNdGIpXOwAlA8cxesBOr4E1JveiphM9QSsMTWLFxMXsp5IJmhLA?=
 =?iso-8859-1?Q?IeCEMjeTN5oCNW0fmoj/6eQjGbr1EsFcSAeRNRgY1tPigvuQ83ty+Pbhoc?=
 =?iso-8859-1?Q?rMm2/N32tGRVn6O16B5WuELZ3W/oaTiE6Bzeac/7vGMaNdiaZde/jN0Khm?=
 =?iso-8859-1?Q?W53jwlxPhl6msVIKT2bZWOArFPioUME5s9dsg0C837PyzzM9RxR3bnjj18?=
 =?iso-8859-1?Q?0u03pe7IkYbsG7NcdNuBl/iMxNH159JZ6YPYe1GkP68jexIjdi8Yz/Lxyq?=
 =?iso-8859-1?Q?t5ZtdpqWXuc0xoMOP8GNRor0bezIZdnGqb259NGs5SHXzZDxhZXstnHbkX?=
 =?iso-8859-1?Q?WJuPQ2/hC7r0NKju9eybYhepcD0cVkaMexYEHuiEK0VHZSe+BpHXELBzLp?=
 =?iso-8859-1?Q?a6CA/vzkICGX7Yl6g9ooVZl9hYdByRjujS6h9LyGKW2XwGmW/ynY1u6AOr?=
 =?iso-8859-1?Q?oszh7Eo/eGGZZhengvmvFYB1epYvZPkD645qy3+rYqjjtVZqunYU6bYGeM?=
 =?iso-8859-1?Q?M3F8SqPvjq/JWbHtLLQhUw3ZteTLKG69sFBXGQ505Nr416+58juYInFFuk?=
 =?iso-8859-1?Q?/KwwnN/dyMjyPATzd+J2D1j4FctLLhznc2RSxUwW7ZQpf9A8tb4T7KA20D?=
 =?iso-8859-1?Q?MiLN4+8O4RXGhP3ynrj3yU+rOdKhQtEh6C1/M2LOKDjsxEADak7gzSckLj?=
 =?iso-8859-1?Q?HsqeWwVHjj2o8Q5PC/q4JtkjJwKDGfMPTcBMe99S7pdqLBo4yBcAXi7PnP?=
 =?iso-8859-1?Q?sZZIhM3oVMDv2Vx3D0OrxYQuugPSvLflrVrYfvgpAuM9NwBk5Arp8tijrB?=
 =?iso-8859-1?Q?9Scao/CbwYEU8xRCtzvvABfWyKSX3/gkEBsbKEfrFsa7QUGg5hYnMn+mYw?=
 =?iso-8859-1?Q?w2UYIXJXFsCUIu+IJO6Mh6glDHWnj8E1NP5101hoEMl5S6Nigx56alxfHf?=
 =?iso-8859-1?Q?zgQ/mNv0HNZAmd7q42dxXV3YDNPsG/vPhQ69pDYeSroDH+FSDxtmbNgcla?=
 =?iso-8859-1?Q?syDxUEBu+pgrPma9NFKtgWv9SqdVLF5W6VypJDr5eYSSHPRcNoQtxBThzG?=
 =?iso-8859-1?Q?XtpZ3nhNzkm0DFAaeiZc3tJZKkHg9VjxMqGz6JtQyE6DasRVr7C6UPCZ5r?=
 =?iso-8859-1?Q?UeDenrKsICJHO1cTTCJXsMuYhGN/zvuFiB14MT3vOsCpG7W069e+x206it?=
 =?iso-8859-1?Q?h9thY8m8h81QSFrWGMZuLGhgCaiYZ1HnsTW4IieIm9TMhovYwhABxt4TO+?=
 =?iso-8859-1?Q?cVaE/WDRNPVA1Y235gE1/xQdYE310S3jLefGiJHNylTUD36QD1OrvjkL3N?=
 =?iso-8859-1?Q?9EPt7Az7H4Y9pIeoG3KuutyQZ1RVUHrkSDgAsu1cI8j8gp6DmyThMrJypl?=
 =?iso-8859-1?Q?Q1p0QHZXCb/ptK0vMXWiV0TGnVVklwcczD+f7U1IHJ2pew?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Z65Y09GrJkbRdqxqpKc1/aT7QTlAgx6GyS646gjXmlHqDosFFQQAdt6ruVl62vsL4aCLr+b5pDqETWNJU0GtnemlbZTyFyFOglZ1NpHNlnBzxxGyU5+tEkwzw7eAVgLPRg68OXFEkpsGPtlhJHwrfOVzmfQES8C7MumAHaO8cU3RoA1M1M6dYCN3sO90Q6AQXclOz9PK4w8um8p421cl/r04INOU2dpzn+8nqyZnn6ISwq43q7Rq4WOXoXKXD4rn9DV4d4AsmgbAoejx6X869VW4SLbuSnJJQl6mrvjNWseFQ2N5zQ1TxzwD9ds8k/LAZtmmDLzeDeTID3StCD9H+A==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB6138.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f02cd47e-0654-4e54-620b-08defa392249
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 19:20:42.8226 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V2Lx4scvd7xQ86PO3ybSvQAlas3vFeZB3xSWR6nRBIE/e6EstfmrdCenRTt02ptqQJRqsUmv4YIzcOIhk/Ko4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB5976
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7f6a8e cx=c_pps
 a=2KosHvP3s5kmPOqSYQ0Nog==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=V2NxCb60AAAA:8 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=7KBfExy5AAAA:8
 a=69wJf7TsAAAA:8 a=1lxAQt7xqVLMHmU52qoA:9 a=wPNLvfGTeEIA:10
 a=3L6qF29SlnrayQqPM2jZ:22 a=gFNbaldVC-z-bsjSTzMo:22 a=cvBusfyB2V15izCimMoJ:22
 a=eL7OMsOqQ-6kYQPn45L1:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDE0NiBTYWx0ZWRfXx9Y9z3WJLLkI
 AAbwh/TUXOeSSebPIYZLFwt+YXNe58XgNrlPCA19xo/RXjo+ZFb7lrswCyrLacWaW+u1fRuk225
 abx8HalqugLZjZpIGqi0fLPm/+X95qAcGKZ7GUbf7C3xzntN9FTh+NYUs9Tag7c0PvvI2ImsUSu
 sw7cl+xbYatl9KeseXn4Ful9PU9x9e54P9LEnj3D0aQ8oBsVoVIl1n45NWEFbR1j0MSX3Bso84T
 Q0r2JTf3LjCd/8LG80bouH1+EI4aFlMaqRl4i12sBM2WllnEDJ6lLCo9Toq19b8wOVxuZ2FFM6i
 XDm8k/ChA61dJQjc+gfR6Eqa+Gk90leYzix5A4O4hG+eTfoi7YyzpDKJX64CHhNXCGqpsrzKJZj
 AZ16++d9VxVy36VZK4CTJVkdgS2YodpPMeWp1MIarvf1l7WODt1sZckTna67QN2Ekw+dEdaJCqQ
 IjcR9TvsGGV5I/6lWTg==
X-Proofpoint-ORIG-GUID: VieTuXlixrXyTdCv4ZqxCVWfNd4-Vzwf
X-Proofpoint-GUID: cYaqGkRlb1NpVmUi-PzBy0Y4CCv1TRMJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDE0NiBTYWx0ZWRfX2ZTUmToPLqpb
 2/QQspA4WxuEt6m2wblZKbHejBV/DSmQpgedsDHP23jsDTfu7zOXSEJlPCewa3pm1SsIBde+CaW
 iaR8qlocuzlyjdD3JDnAhlBlg2FQmCc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140146
Received-SPF: pass client-ip=148.163.158.5; envelope-from=Mikail.Sadic@ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Jamin,

Tested-by: Mikail Sadic <mikail.sadic@ibm.com>

I checked it over and verified it all works, I'm glad my suggestions were h=
elpful.

Thank you,
Mikail Sadic

-----Original Message-----
From: Jamin Lin <jamin_lin@aspeedtech.com>=20
Sent: Thursday, August 13, 2026 9:20 PM
To: Mikail Sadic <Mikail.Sadic@ibm.com>; C=E9dric Le Goater <clg@kaod.org>;=
 Peter Maydell <peter.maydell@linaro.org>; Steven Lee <steven_lee@aspeedtec=
h.com>; Troy Lee <leetroy@gmail.com>; Kane Chen <kane_chen@aspeedtech.com>;=
 Andrew Jeffery <andrew@codeconstruct.com.au>; Joel Stanley <joel@jms.id.au=
>; open list:ASPEED BMCs <qemu-arm@nongnu.org>; open list:All patches CC he=
re <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
Subject: [EXTERNAL] RE: [PATCH v1] hw/i2c/aspeed_i2c: Latch first received =
byte for SMBus block reads

> Subject: RE: [PATCH v1] hw/i2c/aspeed_i2c: Latch first received byte=20
> for SMBus block reads
>=20
> Hi Jamin,
>=20
> Tested-by: Mikail Sadic <mikail.sadic@ibm.com>
>=20
> I verified that this (along with the AST2700 buffer mode patch and the=20
> kernel fix you referenced) works with the UCD9000 driver, thank you for t=
he help!
> I am dropping my patch and depending on yours.
>=20
>=20
> I just have two things I'd like to ask about (not blocking for my=20
> purposes, may be worth to check):
>=20
> 1. Byte mode is not latched. I think the else branch of=20
> aspeed_i2c_bus_recv() still only writes the receive byte buffer, so=20
> 0x84 goes stale there. This may cause problems down the line, specificall=
y for AST1040?
>=20
> 2. I believe dma_buf_en reads like the FUNC_CFG_DMA_EN bit, but the=20
> DMA-to-pool call passes true while that bit is clear, clearing it is=20
> what selects the pool. Getting it from RX_DMA_EN inside the helper may=20
> stop someone from accidentally "fixing" it to match the name and=20
> breaking the AST2600 case.
>=20
Hi Mikail,

Thanks for the suggestion.

Both points are addressed in v2:

1. Byte mode now latches as well.
2. dma_buf_en is gone; the helper reads RX_DMA_EN directly, as you suggeste=
d.

I resend v2 here,
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__patchwork.kernel.org=
_project_qemu-2Ddevel_patch_20260814020836.3119613-2D1-2Djamin-5Flin-40aspe=
edtech.com_&d=3DDwIFAw&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3DMwxPIV78QTTKBsiQ-TUBA=
px4-_ZEUlleOhDjygCqcOU&m=3D35Of371QTEER-fuhBTEDrGMw9Sq8K3JtKRL1wWPYs-2MBuvW=
hn-KM-eI6qd9O20W&s=3D1-a288_BxQVvouXeqT7tnvlD1j9C0HLzGbuFEIl2DxI&e=3D=20

Thanks,
Jamin
>=20
> Thanks again for picking this up and catching the original problem.
>=20
> - Mikail Sadic
>=20
>=20
> -----Original Message-----
> From: Jamin Lin <jamin_lin@aspeedtech.com>
> Sent: Thursday, August 13, 2026 4:08 AM
> To: C=E9dric Le Goater <clg@kaod.org>; Peter Maydell=20
> <peter.maydell@linaro.org>; Steven Lee <steven_lee@aspeedtech.com>;=20
> Troy Lee <leetroy@gmail.com>; Kane Chen <kane_chen@aspeedtech.com>;=20
> Andrew Jeffery <andrew@codeconstruct.com.au>; Joel Stanley=20
> <joel@jms.id.au>; open list:ASPEED BMCs <qemu-arm@nongnu.org>; open=20
> list:All patches CC here <qemu-devel@nongnu.org>
> Cc: Troy Lee <troy_lee@aspeedtech.com>; Mikail Sadic=20
> <Mikail.Sadic@ibm.com>
> Subject: [EXTERNAL] RE: [PATCH v1] hw/i2c/aspeed_i2c: Latch first=20
> received byte for SMBus block reads
>=20
> Hi Mikail,
>=20
> Could you please review this patch and verify that it works with the=20
> UCD9000 driver?
>=20
> Thanks,
> Jamin
>=20
> > -----Original Message-----
> > From: Jamin Lin <jamin_lin@aspeedtech.com>
> > Sent: Thursday, August 13, 2026 5:02 PM
> > To: C=E9dric Le Goater <clg@kaod.org>; Peter Maydell=20
> > <peter.maydell@linaro.org>; Steven Lee <steven_lee@aspeedtech.com>;=20
> > Troy Lee <leetroy@gmail.com>; Kane Chen <kane_chen@aspeedtech.com>;=20
> > Andrew Jeffery <andrew@codeconstruct.com.au>; Joel Stanley=20
> > <joel@jms.id.au>; open list:ASPEED BMCs <qemu-arm@nongnu.org>; open=20
> > list:All patches CC here <qemu-devel@nongnu.org>
> > Cc: Jamin Lin <jamin_lin@aspeedtech.com>; Troy Lee=20
> > <troy_lee@aspeedtech.com>; Mikail.Sadic@ibm.com
> > Subject: [PATCH v1] hw/i2c/aspeed_i2c: Latch first received byte for=20
> > SMBus block reads
> >
> > An SMBus block read takes the block length from the first byte of=20
> > the transfer, and firmware reads that byte back from a register=20
> > rather than from the transfer buffer. The receive paths never=20
> > updated those registers, so block reads reported a bogus length.
> >
> > On AST2600 the driver reads the length from the receive byte buffer,=20
> > I2CC_MS_TXRX_BYTE_BUF[15:8]. The datasheet documents that field as=20
> > valid while the DMA buffer is not enabled. The byte mode receive=20
> > path already updated it, but the pool buffer path did not, and the=20
> > driver selects buffer mode by default.
> >
> > On AST2700 the driver reads the length from offset 0x84 instead.
> >
> > Add I2CC_BYTE_DATA_LOG at 0x84. Latch the first received byte from=20
> > the three receive paths: the pool buffer path, the DMA-to-pool path=20
> > and the DMA-to-DRAM path. Each latch updates the byte data log, and=20
> > updates the receive byte buffer as well while the DMA buffer is not=20
> > enabled. The byte data log is outside the register window of the=20
> > earlier SoCs, so it is only visible on AST2700/AST1040.
> >
> > Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> > ---
> >  hw/i2c/aspeed_i2c.c         | 31 ++++++++++++++++++++++++++++++-
> >  include/hw/i2c/aspeed_i2c.h |  2 ++
> >  2 files changed, 32 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c index
> > 68bdcd0e25..e6d0eee816 100644
> > --- a/hw/i2c/aspeed_i2c.c
> > +++ b/hw/i2c/aspeed_i2c.c
> > @@ -159,6 +159,7 @@ static uint64_t
> > aspeed_i2c_bus_new_read(AspeedI2CBus *bus, hwaddr offset,
> >      case A_I2CS_INTR_CTRL:
> >      case A_I2CS_DMA_LEN_STS:
> >      case A_I2CS_INTR_STS:
> > +    case A_I2CC_BYTE_DATA_LOG:
> >      case A_I2CC_VERSION_CTRL:
> >          value =3D bus->regs[offset / sizeof(*bus->regs)];
> >          break;
> > @@ -334,6 +335,24 @@ static int
> > aspeed_i2c_bus_send_dma_pool(AspeedI2CBus *bus)
> >      return ret;
> >  }
> >
> > +/*
> > + * Latch the first received byte, which firmware reads back as the=20
> > +SMBus block
> > + * length. AST2600 reads it from the receive byte buffer, only=20
> > +valid while the
> > + * DMA buffer is disabled; AST2700 reads it from the byte data log,=20
> > +a register
> > + * the earlier SoCs do not expose.
> > + */
> > +static void aspeed_i2c_bus_latch_rx_len(AspeedI2CBus *bus, bool
> > dma_buf_en,
> > +                                        uint8_t data) {
> > +    uint32_t reg_byte_buf =3D aspeed_i2c_bus_byte_buf_offset(bus);
> > +
> > +    ARRAY_FIELD_DP32(bus->regs, I2CC_BYTE_DATA_LOG, RX_BUF, data);
> > +
> > +    if (!dma_buf_en) {
> > +        SHARED_ARRAY_FIELD_DP32(bus->regs, reg_byte_buf, RX_BUF,
> > data);
> > +    }
> > +}
> > +
> >  static void aspeed_i2c_bus_recv_dma_pool(AspeedI2CBus *bus)  {
> >      AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(bus->controller);
> > @@ -349,6 +368,9 @@ static void
> > aspeed_i2c_bus_recv_dma_pool(AspeedI2CBus *bus)
> >          pool_base[offset + i] =3D i2c_recv(bus->bus);
> >          trace_aspeed_i2c_bus_recv("BUFF", i + 1,
> bus->regs[reg_dma_len],
> >                                    pool_base[offset + i]);
> > +        if (i =3D=3D 0) {
> > +            aspeed_i2c_bus_latch_rx_len(bus, true, pool_base[offset]);
> > +        }
> >          bus->regs[reg_dma_len]--;
> >          ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, RX_LEN, i +
> 1);
> >      }
> > @@ -443,6 +465,9 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
> >              pool_base[i] =3D i2c_recv(bus->bus);
> >              trace_aspeed_i2c_bus_recv("BUF", i + 1, pool_rx_count,
> >                                        pool_base[i]);
> > +            if (i =3D=3D 0) {
> > +                aspeed_i2c_bus_latch_rx_len(bus, false, pool_base[0]);
> > +            }
> >          }
> >
> >          /* Update RX count */
> > @@ -460,7 +485,7 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
> >          }
> >
> >          aspeed_i2c_set_rx_dma_dram_offset(bus);
> > -        while (bus->regs[reg_dma_len]) {
> > +        for (i =3D 0; bus->regs[reg_dma_len]; i++) {
> >              MemTxResult result;
> >
> >              data =3D i2c_recv(bus->bus); @@ -476,6 +501,10 @@ static=20
> > void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
> >                  return;
> >              }
> >
> > +            if (i =3D=3D 0) {
> > +                aspeed_i2c_bus_latch_rx_len(bus, true, data);
> > +            }
> > +
> >              bus->dma_dram_offset++;
> >              bus->regs[reg_dma_len]--;
> >              /* In new mode, keep track of how many bytes we RXed */=20
> > diff --git a/include/hw/i2c/aspeed_i2c.h=20
> > b/include/hw/i2c/aspeed_i2c.h index 05937a7a0b..c8e6ea54ad 100644
> > --- a/include/hw/i2c/aspeed_i2c.h
> > +++ b/include/hw/i2c/aspeed_i2c.h
> > @@ -231,6 +231,8 @@ REG32(I2CS_DMA_TX_ADDR_HI, 0x68)
> >      FIELD(I2CS_DMA_TX_ADDR_HI, ADDR_HI, 0, 7)=20
> > REG32(I2CS_DMA_RX_ADDR_HI, 0x6c)
> >      FIELD(I2CS_DMA_RX_ADDR_HI, ADDR_HI, 0, 7)
> > +REG32(I2CC_BYTE_DATA_LOG, 0x84)
> > +    FIELD(I2CC_BYTE_DATA_LOG, RX_BUF, 0, 8)
> >  REG32(I2CC_VERSION_CTRL, 0x94)
> >      FIELD(I2CC_VERSION_CTRL, FUNC_CFG_DMA_EN, 2, 1)
> >
> > --
> > 2.53.0

