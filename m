Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A035DC3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 12:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEoiQ-0005go-DG; Tue, 13 May 2025 08:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Rajasekar.P@netapp.com>)
 id 1uEoiN-0005gb-Qo
 for qemu-devel@nongnu.org; Tue, 13 May 2025 08:26:33 -0400
Received: from mx0b-003fbd02.pphosted.com ([67.231.157.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Rajasekar.P@netapp.com>)
 id 1uEoiF-0006sU-FS
 for qemu-devel@nongnu.org; Tue, 13 May 2025 08:26:31 -0400
Received: from pps.filterd (m0412385.ppops.net [127.0.0.1])
 by mx0b-003fbd02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DBepCA020789
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 12:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pps1; bh=NdeDbhbhsyO2+Ln2hd8FFGV7fssT3
 rnPR1NLBUmp9Ps=; b=CdInPqoDJTqSWUelIpCvm88Hvqq6tWRf/oCUIzQ6n3LqU
 DBk9fzAWLiMnipAiD2Dd8Ivn8QTyjVI0QvaZim+HjpxnPr+uwVQb8BtzVAfW2fSP
 sOY7hekxIcIR8d+AAqdATGR2Ox7NEqEOc8iqeUMT8xmXVCkrS2E17DrM+dWWzK+Z
 oyvg2JrWdOHsZNDTSwltA1kv/2Q3zNaeONCTAdzeFjdN4VtAhAEpN3Q92Wf41FMA
 oQ3gVNJQ7mJLGglUyy5xpxVDUcT3qMoUUcaIhuZwkbNCgkgSoB6pDBGdKrZu42fT
 c3gpT4ovf5CJe3Aj8G+oMVJnim+rFYiFpOha89zhQ==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
 by mx0b-003fbd02.pphosted.com (PPS) with ESMTPS id 46m5dyg4ae-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 12:26:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l73Jr2uc55kqZmCaz0Llf8TRcAsiGKF3XNNhXARy1pBA43nqTG6LQtVYj3CWTXkoBdb39vjGGFyKg0e8VYCDRxWHEDg39YC6+KvMomSwpymxj6wOiK59TLmxAFdZRWuhrvrCRd64B/m+Qg1NO1B2/VyP0XBo7TbrgR4oPdX9oQj98qyepKqrkaKjM2gEgb2yMCeeA/bwryiukmh8Q3XDv9ddS2cM7z9f7TvM2FMzbB66EGrLdJyB/XHF5QG5pWblSHgf1lfPS37zXUm+wNwqF7RjdP2NR9csMULz+SC2nsrLaXFQFBz9o6PvxMVHp0MD2MqhGLuvWJmi16ozBIv0sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdeDbhbhsyO2+Ln2hd8FFGV7fssT3rnPR1NLBUmp9Ps=;
 b=ZoAwaC3W8SzuQymbYVBEhej7SBbgWPMKG2xpqA089/fq5ROJyyWOpbrtTH0KL4hvm1U8TxWCaHEzutfIw1Z/HaY26uot2GSOsVfdGl9QQYhGoy7i/PBtDrwJgtjtDzexyUjBuK/hKgJ/W8PHoGpGjDqiZxjXfLeVFZTSk92cIARxvGJRWM6XJFM3rJXEC2XrrYJjDoBTa+smZf88udEsh6nioR15OQB1HbfN7EnWv+bIA6auX6X5TjJoz8my5NZmB63MMoOBywLDatKXbhYybv8Z39jjnoLPksQF0w45wS7JmnmRqttnYBaZXNcExPAM/YZXJJ9ye9bEL9UR21ipBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdeDbhbhsyO2+Ln2hd8FFGV7fssT3rnPR1NLBUmp9Ps=;
 b=UC6CLT7JsmvQKBv6yyPKasJ6MaR3OQCIcORMtN8lnYTUdKqfqvAMDbzM4PTyE2hhWx6ueLMVV9kWPz0DLm7ac7jj6ymjBAoVLYRdB3OZbb0c4GVIa09AWYLJ3LeccTHzihR9n0fk5rPc0libVEUFozMYlAcgGBo8N4vimgBAYu0DX5KO0POSGXiT4RDPujkIIm1tmUE7P0cYZM7UG8DdWlVsjlbP7lLXNBS6lusp2C64gSEfd5KqXL+jG7Y0YxpRyRfC1qr5ghbq0C+M3ypl66MPpIV5t6IAfd8rBwN+DEeqcYEVLUWk14t3a00slQmPLtMGfZ5cV8MRMe2VEts0Tw==
Received: from DS0PR06MB9231.namprd06.prod.outlook.com (2603:10b6:8:129::17)
 by DM8PR06MB7816.namprd06.prod.outlook.com (2603:10b6:8:3c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.30; Tue, 13 May 2025 12:26:15 +0000
Received: from DS0PR06MB9231.namprd06.prod.outlook.com
 ([fe80::2f5c:9cd3:216d:ab71]) by DS0PR06MB9231.namprd06.prod.outlook.com
 ([fe80::2f5c:9cd3:216d:ab71%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 12:26:15 +0000
From: "P, Rajasekar" <Rajasekar.P@netapp.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "Bethur, Mohan" <Mohan.Bethur@netapp.com>
Subject: RE: Query Regarding VM Consistent Snapshot Approaches and Impact of
 QEMU Guest Agent Freeze
Thread-Topic: Query Regarding VM Consistent Snapshot Approaches and Impact of
 QEMU Guest Agent Freeze
Thread-Index: AdvC+nSpreafgdNgQJSVemOIVfAz3wBB5qAg
Date: Tue, 13 May 2025 12:26:15 +0000
Message-ID: <DS0PR06MB9231940E75477F7198B3540B8396A@DS0PR06MB9231.namprd06.prod.outlook.com>
References: <DS0PR06MB9231E15CAD02D2566513ECAA8397A@DS0PR06MB9231.namprd06.prod.outlook.com>
In-Reply-To: <DS0PR06MB9231E15CAD02D2566513ECAA8397A@DS0PR06MB9231.namprd06.prod.outlook.com>
Accept-Language: en-GB, en-IN, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.10.300.143
dlp-reaction: no-action
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR06MB9231:EE_|DM8PR06MB7816:EE_
x-ms-office365-filtering-correlation-id: 256ffd09-3f30-4688-ec17-08dd92195ae2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?1SaLZBnmoGN7yrR5wbOMLYoT5XSi8Gbur2ZH1rD82c/M+oTKcmSnGuFiFwaX?=
 =?us-ascii?Q?GagENMQfbUONHKrpb2JkaO04KUfRv0qrHWYuwjHTR1OubbrzIREEw2FIcqP9?=
 =?us-ascii?Q?4R+XfOG8UotA/bR/iIMD3IngEW8SPNZ4KqXbK2Wp0V9vGzqG1kYPGHm3Sdpv?=
 =?us-ascii?Q?5mzWiuo2t9Jp6Jr8As0S0vh7PjlOlGMPyU9eUQQ1uOPAUdyQHQcAHJcHjEhA?=
 =?us-ascii?Q?DvHLqaV8XpHp31Pgr/dAuMDzo3MltU/zn+R6QX4BgNvTkTVJWhYUt602ZCWL?=
 =?us-ascii?Q?vwrEsi0VZPDLhRjJDYhMy9GdSxm+LxzxKvwbmrob/EVks28IUM6iqVDuU0bf?=
 =?us-ascii?Q?AIdE/nzUhNeULPOYD94nm2ZhASPKuc0/mVXdJiJXvGEm4aHEzJLtW7doJhzu?=
 =?us-ascii?Q?JFKye8QiJ/1jwZHW7uvFHUl2zITfKVa2DLVWTD+78HgdLWM9CK1G5Vqdx0uv?=
 =?us-ascii?Q?QDfeAo+VSAacvJVDInj/jf+bkjNdtou2GY6b4LJ1wo6y8BhIi4qqGhv0PKwP?=
 =?us-ascii?Q?5Db/dKGDSH/6BFZa3NiHS8dLbbQ1velua4A0VF7nc6Ut5B+FV+gv6BEPLku0?=
 =?us-ascii?Q?kufU34BYl7L9NwYoZp7byEsyO5ABrC7PM5FmP4MQ+isKPrVLNPNGTIPa4F01?=
 =?us-ascii?Q?ePsWfx9JzrMUQQdU7pA2Gnfsr847LIGaCCHROMz+h/ED+eWRZDlh6FC7zO1e?=
 =?us-ascii?Q?/l1pTChTZ98keKPmcpeQo+b+uPtWIc1c8oFuzbuyvEfAOY+QdM+R2rEJuu2k?=
 =?us-ascii?Q?1nMpN2VBwiz0fa/eM/62wNmEo4HDmlzlW7yl03LKionv08aviYIx2qrBe5dW?=
 =?us-ascii?Q?vA8jI5+jPEXBxzH4rzBlQZIxrylnXSm7OIjwOF/CRhTx1UJJgdTLSMlzx8ER?=
 =?us-ascii?Q?ilgvW1NQYgSAoI02mllEuzrGHHCyy/R6UB69r1xY1APxBrtMulvOahhtkE2n?=
 =?us-ascii?Q?seR/MiAm+rSm4dZq8cnB3Vi9pjZWeEigzfGVQv23EqV4TmaWqXCO9SBwwD7O?=
 =?us-ascii?Q?eoP+QGXHIGfH4IY9O7+tPavkpxWQvrSX/SpnCegCd05HI9GY4qTITIYNZGy0?=
 =?us-ascii?Q?XJz9SRw2uzIq7T6zUHLVIHnCZZOgbeuSs88/ZntGiLcZYq8tM+h/3W5eZIR2?=
 =?us-ascii?Q?WnRURkWS6sXGDeK1nfVpVKNwJmwJ5ZZmJsA17AqEidJKKP1584q7h8IxyIwu?=
 =?us-ascii?Q?H/RoUfpYKK/DuVTL1ZMNSX04w8aQ1qTW78BR/ZP9XVvsy4+/cDjKLmoUfXoE?=
 =?us-ascii?Q?ic81I3H5gLVAHbJhTcErwkddz01AUUUcIaKYSXUx16wjL8EYNWfh151THdsb?=
 =?us-ascii?Q?y01YdeLlJ8mxiy6rS7JCHkT/FQ+9F4jAVXMIer6O9Oi2HbxKh2Ig2h+Iitkg?=
 =?us-ascii?Q?Hsozhn77IQ9skMioscXKmHXgnaOs00Lo266eTruKe8dH9OCk6DZhSpCP+Xee?=
 =?us-ascii?Q?qBsYNh+1FeL2HDQTKsy8VtMcHN0F9nBOS1Zc7Anc6Ujh74aUTReOP8SjxjRn?=
 =?us-ascii?Q?1DBDJt+pvuSzvWs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR06MB9231.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HlfZAuNoEstCpsH8plo7ZjIisEwfRIP0kRv+HcZxkHxGNJDWaz7yohRZKA7A?=
 =?us-ascii?Q?DSxkuu+GA3NW5HziTRTh1BqEIHBfldiP+d9rIxH9pdQdsZ8tEahNUQ7RJ8+8?=
 =?us-ascii?Q?/vJfe5F0YPo8LLEmuXjA/3bVtTvINqBT8BiexVS+om8et5dqXu7XypPFTxHP?=
 =?us-ascii?Q?ZD9QBx8L8DC52FH0xpW1N7Nm0Ri8KTuPNRldKVQq0NbHEPVy4k7oXIAV6zyh?=
 =?us-ascii?Q?E6Vnbg1iU4G1eHePQ+9KJSYeUHs9YGRIlOq8lOlxHiKMu6vZjyueGxwBXa+o?=
 =?us-ascii?Q?6OX0JPffs+R1XpGDrDneyYhPSTBSL3YgRaf+2i6SYQhvSUgRY3PwI7i1L55/?=
 =?us-ascii?Q?LiyaFSHfB1SFh7neI+NpQ3XMEXJAaYopTIlkEAjBxYpPKon3OmTnm1ExMm40?=
 =?us-ascii?Q?d5FxuFP8KGzurxQMu59TEXckGhExvflWV1GUyR227uNVymGR8Zr4GFPTC98Z?=
 =?us-ascii?Q?UT2A3b1TA4a+Gi6Ud1bKKuMohnIH9jqf+mOCBX4PFbRoFqsl29oXl11m2yia?=
 =?us-ascii?Q?6jvurObpfXhQsNHoiHQ1ZnLCnNI4pFiI5dGyF3dligDDTC34n2wbNC5O011T?=
 =?us-ascii?Q?X2beQSUbscGdrZu96h0PITesf7/PDM7VdZjw4UZmrYqrGixWy7QdbFD8thNk?=
 =?us-ascii?Q?12dYkrF1Lg5S+Kj235BExOVIAyvXQf8SdkP5Sv+hUzjTI/pwdnFB20/Wyps9?=
 =?us-ascii?Q?/XOz1YPTafdnK/gVlk2cv1NTkf6Tyi5eVcwEccS8iaFwn6ZoVSS99CkYn66P?=
 =?us-ascii?Q?0E+EyszXuS2DlIAE1dBXmUQsQfEct4+8ijLMSXIb5ZRpFSHBwOqzFD0Eaa+k?=
 =?us-ascii?Q?Tdl1uVLtYyhiQhLM4q5lDUffH+kS+x/1AvmnnlzERskS7lrQ5M791E3nsel2?=
 =?us-ascii?Q?LeK9h9RxwqeyyEXXBsV+R9EH4qW6G26tBxkN5adknc2842GfyqefMz60UM4q?=
 =?us-ascii?Q?I2GbC32fdivw03XBlaLr+WOjj/LbmgWbtvnIG0oPVDkMd0BEPQQ/mXy1m0ec?=
 =?us-ascii?Q?OG3DCaELzwzwxXzXRRXwmCj28TAS7CDOg54abcZRgjWMigNLz/ef6K//iFor?=
 =?us-ascii?Q?QBojAI0zd/RUP9HCQflHPdJcz6pw9P2m5/ED33Qjh/n/TMOK5IXhNQd1eKON?=
 =?us-ascii?Q?GzQ0GluB9AFmtqglHCpylzKyuZiLlgWJnYkNt5CJZP1ej7oa1CADhmbreMgQ?=
 =?us-ascii?Q?NEnKfY+Net0coaYwoQ8mglj8q3ju6fN+Et/F047ue1oxY6wnzyR9eynn7S5k?=
 =?us-ascii?Q?5dkMVtmmN4dAzNKLCHbAYrIn+qiznAIx1k8VpJ7d1lDdO/bsGdzW4KaWWlEz?=
 =?us-ascii?Q?KYfROgUyQfUgi4qex9cBmv2pqXXm2/aNI4x5uvPUhwI8aarMJZO2RLGGS5Ns?=
 =?us-ascii?Q?fU85kIbgsjQj9KviDBVL0mfnKCAZmJUUY6GhZg5zLt8+SVHW3XAblmW19IIl?=
 =?us-ascii?Q?dbC9UccdgzFzYt2qYCqTlSM6uU1r+opIEBXVeuBZEn7Iva8BYSQaQzclXrnI?=
 =?us-ascii?Q?IEF8BODs++wNWxd594mPCNmjZciWb5bsdRK/2uz9uZcZFA6+O+d6HAQPa4ch?=
 =?us-ascii?Q?GieMgBmzE3mgRZon25k=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR06MB9231940E75477F7198B3540B8396ADS0PR06MB9231namp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: T+AX2IeUWHO1l31ufY6Z70g7NmJ5b9gfZ+KmgOSh/YbUXpCByNwMBITlSlYiUAy6Vt2kWEfHvdmfh54q8TD+LsVJohlw02CnPUQVe4l/Ox5OhAe5DCHpidg3uZcCuvvuvFwNapBmrsR1fIZpUMxsAJT3qBwZv4MiV1v26Ih1DkZud+LPSC79oQ2HpcrujBayLzRoV6Mb2A6/XIgGHEbAb2/SC1ARMYOb13GQB+MiUKZRCprC7hdZTt4j95poL+YK7/r8HxPcAtgJfPC2y74E9aAw+HveoBf7Fc+N/+8CbqykI0aYlVXw5UgcaN23BlWjAse2VchJ/jM9qxb8rrM8pA6SupysuOLOmjLo8/pijQvxK52KGYheBXWwssx2pRMZbqu2nXne2jmigOJRRqtKz3GM4gt/PTTdxLZBetR4MF+i/ujCoQhGCDIenzCV51fmQAQr+7f33KN/UST1AjdT/GWQZo1dEmhawXnRtf8QhRJmMVzM4wf3Hq9DlwBxQzqDcMejEExzQG8vDWh8lPJrU5sWjnCFrQwVFm6AWxGWqclbBEFQy6jFDulyUGhX4AWkRxSqIwPztsd+ZG+KXLQcGzNqizcVrULo+6iRnKE57nx7iFUSFvpUC1nDzHBjZNIP
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR06MB9231.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256ffd09-3f30-4688-ec17-08dd92195ae2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 12:26:15.3092 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mB2Ncfmr2k3LVbzj4tiqBRplkCTpiLvoKiAoM1W0zcvwYkdtjZ79NOF7deiSYNgGEN8XDsvRDHsAKcDI8biLgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR06MB7816
X-Authority-Analysis: v=2.4 cv=eOITjGp1 c=1 sm=1 tr=0 ts=68233a6a cx=c_pps
 a=AuG0SFjpmAmqNFFXyzUckA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=GWG4Yq0kndkA:10 a=69wJf7TsAAAA:8 a=JDjsHSkAAAAA:8 a=HWjYhTaYjTQZV7UZ7PMA:9
 a=CjuIK1q_8ugA:10 a=yMhMjlubAAAA:8 a=SSmOFEACAAAA:8 a=-1allSIA7qxZgmD9-vwA:9
 a=ntt4jmG39GUWtbqg:21 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10
 a=frz4AuCg-hUA:10
 a=Fg1AiH1G6rFz08G2ETeA:22 a=dseMxAR1CDlncBZeV_se:22
X-Proofpoint-GUID: aGbHq5Khl0utk14txL_VCAERopU31P0W
X-Proofpoint-ORIG-GUID: aGbHq5Khl0utk14txL_VCAERopU31P0W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDExOCBTYWx0ZWRfX6xx4024J2K+F
 PDAOyzr+SaeDcrWnjIdrDsKETGTwkNhjYuIBx5ar6s2OkoX2SXXRGrunOvV3lzlZXAzqChKDwh8
 OE2onwytHhzDvUeia5z+m3owV3iN/QszwsBZR5JYZSmgsVBtbC+YCH9BKTp43PYlmtk6EGX53Yt
 jXoGSaXXqJtEH5nj4lD6ryeEsPbXIE8lsbDteCKzCHFwqPGTM40GPtbEwAbgkATpbuE2+E95P1D
 VxxGwGSwZ8e3lHlbyO+eck7Msg1AgIYPPPDqJRNdMzDf0aA8Lx9Iq8Be+wktbLx+57Uq4P4CvOd
 ScLHKxoJYxGsUyP4HGfYIKLJTTyL1Zr+ViSQSdS1hFmRAzkNAvEqmq9BuqZQE5wFJnrxPPaBBSV
 HHgfcdBJVraVOweB8/59eGNE1CILQqriWBxxHYMrBHpBUlCa2umOqDrFjKSNjL/AdTkjf1uk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505130118
Received-SPF: pass client-ip=67.231.157.221;
 envelope-from=Rajasekar.P@netapp.com; helo=mx0b-003fbd02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_DS0PR06MB9231940E75477F7198B3540B8396ADS0PR06MB9231namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dear KVM Team,

I look forwards to your valuable feedback, on the below approach for the VM=
-consistent snapshots.

Regards,
Raj.

From: P, Rajasekar
Sent: 12 May 2025 10:34
To: qemu-devel@nongnu.org
Cc: Bethur, Mohan <Mohan.Bethur@netapp.com>; Prabhu, Vasantha <Vasantha.Pra=
bhu@netapp.com>; Kaplingat, Nikhil <Nikhil.Kaplingat@netapp.com>; Karinta, =
Vineeth <Vineeth.Karinta@netapp.com>
Subject: Query Regarding VM Consistent Snapshot Approaches and Impact of QE=
MU Guest Agent Freeze

Dear KVM Team,

I am currently evaluating different approaches to achieve VM-consistent sna=
pshots and would appreciate your insights on the matter.

My analysis has identified two main approaches for quiescing a VM:


  1.  Quiescing by pausing (or suspending) the entire VM - as currently imp=
lemented using the
virsh suspend
This is a disruptive option as it halts the VM's execution.


  1.  Quiescing by freezing the file system inside the VM - typically perfo=
rmed via the QEMU guest agent using the
domfsfreeze / domfsthaw
                This option is non-disruptive because it allows the VM to c=
ontinue running while ensuring file system consistency.

Technically, the second option appears preferable. However, its implementat=
ion hinges on the following considerations:


  *   The QEMU guest agent must be installed and running within the guest O=
S. While this is often the case by default, it may not be present in all Li=
nux Flavors. Ensuring its availability is therefore a prerequisite.
  *   In Windows environments, the QEMU guest agent freeze leverages VSS (V=
olume Shadow Copy Service), and in Linux, it uses fsfreeze. Since fsfreeze =
freezes I/O, I would like to understand if this temporary freeze might impa=
ct user operations. Additionally, are there any alternative mechanisms to a=
chieve a consistent backup without relying solely on the QEMU guest agent?

Could you please clarify:


  *   The potential impact on user operations during the fsfreeze operation=
 in Linux environments.
  *   Whether there are alternative methods or improvements on the existing=
 approach to obtain VM-consistent backups without significant disruption or=
 reliance on the QEMU guest agent.

Thank you for your assistance. I look forward to your valuable feedback.

Best regards,
Raj.


--_000_DS0PR06MB9231940E75477F7198B3540B8396ADS0PR06MB9231namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cordia New";
	panose-1:2 11 3 4 2 2 2 2 2 4;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:181284272;
	mso-list-template-ids:183114520;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:"Courier New";
	mso-bidi-font-family:"Times New Roman";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l1
	{mso-list-id:637495773;
	mso-list-template-ids:958310362;}
@list l1:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:"Courier New";
	mso-bidi-font-family:"Times New Roman";}
@list l1:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l1:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l1:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l1:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l1:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l1:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l1:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l2
	{mso-list-id:1303923238;
	mso-list-template-ids:-1100320400;}
@list l2:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3
	{mso-list-id:1536649699;
	mso-list-template-ids:79345318;}
@list l3:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l3:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l4
	{mso-list-id:1952786176;
	mso-list-template-ids:-1343068674;}
@list l4:level1
	{mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l4:level2
	{mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l4:level3
	{mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l4:level4
	{mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l4:level5
	{mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l4:level6
	{mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l4:level7
	{mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l4:level8
	{mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l4:level9
	{mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l5
	{mso-list-id:2014870520;
	mso-list-template-ids:1716163176;}
@list l6
	{mso-list-id:2112436004;
	mso-list-template-ids:1300114196;}
@list l6:level1
	{mso-level-start-at:2;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IN" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Dear KVM Team,<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">I look forwards to =
your valuable feedback, on the below approach for the VM-consistent snapsho=
ts.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Regards,<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Raj.<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm;font-size:pt">
<p class=3D"MsoNormal"><b><span lang=3D"EN-GB" style=3D"font-family:&quot;C=
alibri&quot;,sans-serif;mso-ligatures:none">From:</span></b><span lang=3D"E=
N-GB" style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:non=
e"> P, Rajasekar
<br>
<b>Sent:</b> 12 May 2025 10:34<br>
<b>To:</b> qemu-devel@nongnu.org<br>
<b>Cc:</b> Bethur, Mohan &lt;Mohan.Bethur@netapp.com&gt;; Prabhu, Vasantha =
&lt;Vasantha.Prabhu@netapp.com&gt;; Kaplingat, Nikhil &lt;Nikhil.Kaplingat@=
netapp.com&gt;; Karinta, Vineeth &lt;Vineeth.Karinta@netapp.com&gt;<br>
<b>Subject:</b> Query Regarding VM Consistent Snapshot Approaches and Impac=
t of QEMU Guest Agent Freeze<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Dear KVM Team,<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">I am currently eval=
uating different approaches to achieve VM-consistent snapshots and would ap=
preciate your insights on the matter.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">My analysis has ide=
ntified two main approaches for quiescing a VM:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<ol style=3D"margin-top:0cm" start=3D"1" type=3D"1">
<li class=3D"MsoNormal" style=3D"mso-list:l4 level1 lfo3"><span style=3D"fo=
nt-size:11.0pt">Quiescing by pausing (or suspending) the entire VM &#8211; =
as currently implemented using the<o:p></o:p></span></li></ol>
<p class=3D"MsoNormal" style=3D"margin-left:36.0pt;text-indent:36.0pt"><b><=
i><span style=3D"font-size:11.0pt">virsh suspend<o:p></o:p></span></i></b><=
/p>
<p class=3D"MsoNormal" style=3D"text-indent:36.0pt"><span style=3D"font-siz=
e:11.0pt">This is a disruptive option as it halts the VM's execution.<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:36.0pt"><span style=3D"font-siz=
e:11.0pt"><o:p>&nbsp;</o:p></span></p>
<ol style=3D"margin-top:0cm" start=3D"2" type=3D"1">
<li class=3D"MsoNormal" style=3D"mso-list:l4 level1 lfo3"><span style=3D"fo=
nt-size:11.0pt">Quiescing by freezing the file system inside the VM &#8211;=
 typically performed via the QEMU guest agent using the<o:p></o:p></span></=
li></ol>
<p class=3D"MsoNormal" style=3D"margin-left:72.0pt"><b><i><span style=3D"fo=
nt-size:11.0pt">domfsfreeze / domfsthaw<o:p></o:p></span></i></b></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thi=
s option is non-disruptive because it allows the VM to continue running whi=
le ensuring file system consistency.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Technically, the se=
cond option appears preferable. However, its implementation hinges on the f=
ollowing considerations:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<ul style=3D"margin-top:0cm" type=3D"disc">
<li class=3D"MsoNormal" style=3D"mso-list:l1 level1 lfo7"><span style=3D"fo=
nt-size:11.0pt">The QEMU guest agent must be installed and running within t=
he guest OS. While this is often the case by default, it may not be present=
 in all Linux Flavors. Ensuring its availability
 is therefore a prerequisite.<o:p></o:p></span></li><li class=3D"MsoNormal"=
 style=3D"mso-list:l1 level1 lfo7"><span style=3D"font-size:11.0pt">In Wind=
ows environments, the QEMU guest agent freeze leverages VSS (Volume Shadow =
Copy Service), and in Linux, it uses fsfreeze. Since fsfreeze freezes I/O, =
I would like to
 understand if this temporary freeze might impact user operations. Addition=
ally, are there any alternative mechanisms to achieve a consistent backup w=
ithout relying solely on the QEMU guest agent?<o:p></o:p></span></li></ul>
<p class=3D"MsoNormal" style=3D"margin-left:36.0pt"><span style=3D"font-siz=
e:11.0pt"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Could you please cl=
arify:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<ul style=3D"margin-top:0cm" type=3D"disc">
<li class=3D"MsoNormal" style=3D"mso-list:l0 level1 lfo10"><span style=3D"f=
ont-size:11.0pt">The potential impact on user operations during the fsfreez=
e operation in Linux environments.<o:p></o:p></span></li><li class=3D"MsoNo=
rmal" style=3D"mso-list:l0 level1 lfo10"><span style=3D"font-size:11.0pt">W=
hether there are alternative methods or improvements on the existing approa=
ch to obtain VM-consistent backups without significant disruption or relian=
ce on the QEMU guest
 agent.<o:p></o:p></span></li></ul>
<p class=3D"MsoNormal" style=3D"margin-left:36.0pt"><span style=3D"font-siz=
e:11.0pt"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Thank you for your =
assistance. I look forward to your valuable feedback.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Best regards,<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Raj.<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
</div>
</body>
</html>

--_000_DS0PR06MB9231940E75477F7198B3540B8396ADS0PR06MB9231namp_--

