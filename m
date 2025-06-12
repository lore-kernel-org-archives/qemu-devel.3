Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E762C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 14:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPimg-0003Of-Fc; Thu, 12 Jun 2025 10:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uPimb-0003N3-KG
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 10:19:57 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uPimY-0006BG-2T
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 10:19:56 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C81k3E019665;
 Thu, 12 Jun 2025 07:19:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=IV1pWaxOF75IiThWLxrZhZxp7H3QJH3xVZIfYUQIP
 Bw=; b=FpHx/rigefegsTOE6epfhaWrMy4beYKjIjRCtFoFYX2X09jG2GbH3pK4v
 GGua7crr8/F391MVxpUbGsH7M2yhFAALQALJ9Mu3eRMyfATDiW3IN40GEBB4qRJ2
 sQEQofBaDm16XkYK9aUwuVlqwDfZf3CnpepRKp2ebGdzkslQiO7OkTRGx1RA55Z6
 5tm3ovNJjBuoECqVGSLjaEA5vylHwitAOuuxDVcR37Xes7bpLA9wNcuniXJ/oAT0
 E2+gpt/thKbS0lgPgRm3PGQFxgj6n7AjyV6HHVMg7glr9dNkrfAf6diOTEHDkpC+
 xM5/9YgDZewCFko/L23QfiSKUvZzQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2120.outbound.protection.outlook.com [40.107.93.120])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 476e1sxkm5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Jun 2025 07:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HlNL2ZQiLnO6xxhHSk0XFq43OwgNQVJzFsICZc55Kjda3QoE8HANH/k3BLyIXsQdmnnU9+/nc1pSU/8HuOYp9Y3BByhcNTO/kFub5XGsv5urIE2gDEZUeE7d3kPWd+uVr59wJMOYKgqi8UF9tNnVGgK4fB0gK8rEw3SCxsNWvsLKXgja1V01EBN+Ih7Kuxlj3qx3wxI0SbkNpKL+0wRkrSNF1HNPJmeyYWBHJEd+I/zOe81DvFbdbEAsisAf4Pg7G2JoYD60N9+tQdMmOrvObo+K6a+GrjWqZBsqULS45rJzv9db/XlEVn3QjttfFMuPPuJYVGxQRK2OMHnijDeUKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnhpGdD++vzy+FC1in5hg/uELydOpXlOaZxGJqOdte8=;
 b=UMEU3h/mx8QMf9iCE/sZBslN1jDG5+gTR/UMwzrxkbBGUHJ6cyQQ2iVpiWmDP6R3ERsjxcGm2ERwdRrtPIkwGwpWuawdtOwK8AWreqwEsE6jL+V5ffijIUnnPi6IG2o0g33Mz1aosLtGzlMFhMwjNYTtPjU7NgDytBYCKjDdpBR95t+Egf7mzAyFUHfRiKowlwPfCPuS4iIZS2p/F4HkoaHUrjazg3UcnIs/FYMdChET5L2IrMjalFEP449+f68MCPHJUc4agBo29n9BlcPuN+xykJykjBg6kbAx+15qkEg2pxlCQ4L7P5LoN0Qoa19rio4day7Z/GwdATLLwn3IcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnhpGdD++vzy+FC1in5hg/uELydOpXlOaZxGJqOdte8=;
 b=II0ukZCwJiQgiKW8k+bHq2mri07DH31OrSN4Fiw4xTCwfClpCa7YeoBx15l508VjkpkcJdwwmgrdshL3aS44l23RX+m1JvSFBVs3B2P87qSc7MrjloVWJy9v+HFrtgPdx9c7aMAlu8Wf/7Ovlp0W2l3/kt2wAsCWaX7Hf201BIto5gOwVhUjcirnKnmZTudhbNEMFixf7pf5pJFduK560rtdbj8AbKFBYYAJjAasTrHtdTsvqfnXmfk18qPhPK2EJw3iqJIIXDmTMd+EvSp+vHwiQPAnw871G8UK8YWiSUCTzrpq9aSCYJSt7GFzSY+z0OcpBlg8g+6CI1B4s4RmxA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7838.namprd02.prod.outlook.com (2603:10b6:a03:322::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Thu, 12 Jun
 2025 14:19:43 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 14:19:43 +0000
Date: Thu, 12 Jun 2025 07:19:38 -0700
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v3 00/23] vfio-user client
Message-ID: <aErh-v3SfFo-2Br0@lent>
References: <20250607001056.335310-1-john.levon@nutanix.com>
 <b6be1ca0-0ba0-4691-8a2c-f7d3ddc2f85e@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6be1ca0-0ba0-4691-8a2c-f7d3ddc2f85e@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM0PR02CA0200.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::7) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d282b2-adc9-4ae7-2b94-08dda9bc2ceb
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?uOUPVHD4mJh/2ko+s5wdNm5h+2jHx/+xeI+CZqlWu7UQn4MneZLG/yJkzg?=
 =?iso-8859-1?Q?t7Hgq67JaFabeKps6FGjDAejrz0htHk99bLebg3GLLIe5+ytdVSOwdol97?=
 =?iso-8859-1?Q?0vmWsek3t0x7qeBR/K5azOFxRB3M1GTIUQfLJkmMI9Jjb5NpYRQYFeaQxS?=
 =?iso-8859-1?Q?C01vc6b1RFXTY5pt+lDnpuI2VbTA+akNnco9Xbm08aCHLlctxdFOkZ6JG9?=
 =?iso-8859-1?Q?XLqDQeiEppVkSrNrrOEkXA0MYeF2uOmBnklDQ9Mc3cLTKf/BH5BUZtBxsf?=
 =?iso-8859-1?Q?ot7Lce4cBUYrdXRX0IChy7iM/jGrxzjFAr6vvvkd9xjNzAnhfsuDU1fTdI?=
 =?iso-8859-1?Q?SEMhdG6Fe69ImJkuL564yE/7utIoDqPcKT68+6r0CpoZjWlYDTSlAzj4wP?=
 =?iso-8859-1?Q?uu+RL8ewzD40SM1wno8focFIVvDpVuQesKVC2rYIJn/jJ0jef3eh2a0Vso?=
 =?iso-8859-1?Q?Um4n7yJ4vwYbZiF82/qMDSaHJ5bqx0Ish8lC0hEsLbTZHRNbBBh2FNJ1sx?=
 =?iso-8859-1?Q?Os6/Jan/MFP8phoQa1txcVhuM/BsLikC7EcCP/CA91Hf3olQzMLkQ+umcN?=
 =?iso-8859-1?Q?8OutrT2t8sf9rAsKUBDyNuMiDgzbWf3MqFa0SL3/2o0niscTd6nl7j1esN?=
 =?iso-8859-1?Q?kcT467xWfT3KoEANdE8xR2pbR9V17fszyJZxSxFaCWNI+kYVHEk32bHAoI?=
 =?iso-8859-1?Q?Mnqx5FQQ+QJjcRbSTe6RmPfmWlbIcU6DLqsKT9OfxzpZo12DOxKp9ECX5h?=
 =?iso-8859-1?Q?aC5nWRcuEiA9vaSoTO5e8NWbe8i2t0wZo5eUqZ5osw5q5Kpyx25vFHS9sO?=
 =?iso-8859-1?Q?WEpG1rezo9v4Uj8RvNu1BiunjPZ/HisZvqfTLxPgVxR18WyNfn43KA44ds?=
 =?iso-8859-1?Q?/CmcoY4EeakscC8M+CqRMeXna9qbbKhHdM/CWbKZssjKfU1JZOmEdByf7R?=
 =?iso-8859-1?Q?1GsvQeH1YE/csi3oeN8l3PtjCL3GudLMerdFy61aMVIXHKuaVT5i5UPVHx?=
 =?iso-8859-1?Q?NeXbN4169rApQoWoqfoOmmP0dU5eZ+a9O9/+NF/zjUjK/tz4s15j+8fdwD?=
 =?iso-8859-1?Q?xTYRUSd9kgivsw9PIoid2jKJ83NIVeucYKf9+iHmw6p79f3sdWyVhXTBsX?=
 =?iso-8859-1?Q?npCraJEBhKaydkWHWv1yhUbXOcpCvVzE1TTpAHYqdTbQRdocg6zEGBPODl?=
 =?iso-8859-1?Q?60q01pQjtIFPNdJxcFu+RjaX+KK6KcKFusW1jfhBu7UuiYMGQERLBcvlQj?=
 =?iso-8859-1?Q?5CiQ7YNHCrUvbUnlfx8QGcxzHYWKYCtCZhHFO9EWac2JuF29JOMLqsM5Wc?=
 =?iso-8859-1?Q?k7gn7zH7egEohvUhPGxsyuqTahdnjXM8MFitO5/iUb95JIMUS1eCyHGAUb?=
 =?iso-8859-1?Q?ZIDG42LbuzJ1cp08rnjrB8hQ5Vyl0q8AeY9m0kfj9g0R1BKjg4mmtUJyFC?=
 =?iso-8859-1?Q?/dyB85x0RuY6OaTzv3XU0Q53oz1Iu5VVH0XrT0PaYgQdl1w6pwBoaXizUw?=
 =?iso-8859-1?Q?E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?XDd5PVaQTQZ+JaMhSXnJXtjIYDiorsQX2I+7P03ZRhCiv37PjyrNQxYDyu?=
 =?iso-8859-1?Q?1N3ww/FLhunchA4XKnNBlQoOazpw2u4SHi6BnBHg8x0cNW3llULgynUNme?=
 =?iso-8859-1?Q?RyZP/5CgyNP+uLe6mE9LWNqtsobFxxKJZVAdrdk+bUIiteKKf+jESSMFF5?=
 =?iso-8859-1?Q?UzV2XxlmMbPFfCAD56ZYCWh5+g+WCcBi8+kHRNppZebqENTyUleXGCdgBs?=
 =?iso-8859-1?Q?+YqQFz4F5NFbZNIyr9s55hT5nlcjqq7zkUX9LzD+otoKVsQOHhiuAEmrGO?=
 =?iso-8859-1?Q?ojdmmCue9XdvABAO+U9+t7L0NNHxiEdzyWeBJb+w3E9dxUsLOQ7jV2PgMV?=
 =?iso-8859-1?Q?bj8LB5wshTBD9jvMVZ1fktzuee5lKjghq4lH9o6ZSyDEH9C2YRr3SWjeKR?=
 =?iso-8859-1?Q?7QL+jRghDwQJWF1/VZgkaLTC/leYW1maGwcAjwnp/RPTP7tb6JymeJNICs?=
 =?iso-8859-1?Q?0tAr2W1prDAvm7yfcEtmZq40E2FAL0wL7p30XMzasQQy9UCQ0sw3Tbl1gM?=
 =?iso-8859-1?Q?b4aNk6DMr4jftsO+c4PCZ7CK6SyjHq4Ru0kPvTk7bzsJeWhdXVnhpeOAz5?=
 =?iso-8859-1?Q?XpLgchi+eiArCEDXi48XUoImjX2a/dutPSyscQNoxqD0oCrT2zSfQ09Ahy?=
 =?iso-8859-1?Q?jF6UfgxglFeculH2QuWdz+kFtlSyBzaOY3zmqVOSKbomdJn32ehAt413Ey?=
 =?iso-8859-1?Q?ikct3dlVPmy7Vl16H16ZYeJYoobqigpUjotSQGtRFKFzZzOb2IEMF0mQY/?=
 =?iso-8859-1?Q?Y1orNhBgmalYsEqRz+Ig7r99XWlau9tvFW/TznAqBn+SNgxa50jBnQ1CPb?=
 =?iso-8859-1?Q?QkJn22vItA798MkVAOTNJLLUIBaJ6tJxvVAg3x8McuhYObsDFNTAwm42gr?=
 =?iso-8859-1?Q?jZ+6wz5YfhBGlUSfq53YspeCJMqC+ThNKWuqx032nt5twc6kcQME/50u/O?=
 =?iso-8859-1?Q?JjgiVTcn5kAbwrgK5joqFBTcQByChYthCZAJM4YjYTWZA6yIsZdreuYq+U?=
 =?iso-8859-1?Q?FBe1yQ5uMnKWZFuIkQLooYjTHwthZ8rzvm+QOFB9ID6xd3fWJ1ipe7oeta?=
 =?iso-8859-1?Q?Tm+M4RxtPQOj24tCk1ERLuJbSZ0CCqWSVQAIegx7UueZqKYBrmbh0IqeZC?=
 =?iso-8859-1?Q?5ppwg7P6lxaz0DpUIiU9YWYHgzA/ImIK3/OhCdOHtTbqkTNDhWMDxi9Gm6?=
 =?iso-8859-1?Q?dCkwKMHjQfFdpfPJrbKGnu3KIUT2Yrq+c28vrJoCexEz252ptl7PiyDmlk?=
 =?iso-8859-1?Q?/x84fz6Og1obutoAW5aG3yimTHAoJahizKYPpyOWhP11H5GXuqkPLJoow3?=
 =?iso-8859-1?Q?zCvVhkBsu/8x7u1GO+U7F6cFrn9hx6Qa5GGSKbHKDJ/B/getazoiy1XCam?=
 =?iso-8859-1?Q?mcHxEaiHlmmkcxUVh/2upsjLWDOBnpNgUpPPOk99dlK3F5S3yZ5WbGi/Bo?=
 =?iso-8859-1?Q?FVdKW6Sws/cg2x+79fyGbIz9Ifcizsh/ILqF+H5kIVPx6C1+WJ4dvXc66n?=
 =?iso-8859-1?Q?l9K/L6U6TPevtDhHppPmrGyg0qi3zFblYpaDl9YUTCb4MvwAPAhGli5Iqu?=
 =?iso-8859-1?Q?wTUoimgoy5xHY7Jjh5xbMuHIyMMZQxah+cL1HzLhsAHaP9j6q9wiSeLu4A?=
 =?iso-8859-1?Q?G0sPhlHtChGsQ1b4qQxIWLEhgoR//JzOq3?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d282b2-adc9-4ae7-2b94-08dda9bc2ceb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 14:19:43.0899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5qCoZrr4cdB2dPqA7jf6Emto5QrH7W6LzIAyoSYetOET9xBemmPP5J5axGAkvWQzkddCf3MWe27nMoDwFeuDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7838
X-Proofpoint-ORIG-GUID: ezLPrrTxwbBEms9-3v5b5h-2cow1uvX4
X-Proofpoint-GUID: ezLPrrTxwbBEms9-3v5b5h-2cow1uvX4
X-Authority-Analysis: v=2.4 cv=W9U4VQWk c=1 sm=1 tr=0 ts=684ae202 cx=c_pps
 a=PsOhEHIbdWRcI6bSkVfraw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=HSO5QlMFI41uAs1y8MAA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDExMCBTYWx0ZWRfX1A+hv39+xKy0
 eRLrZttusoCn0Qka475eZBRKL5f234auN5mUrcV2G7gVdwM8XBhupVqCV937yLSnRyVA2s2sRu4
 dLwQ1QcznHSoNjUli9nJnfx/CjCNjHX3tt+LKCupBdJopMmEbWcPDtEKxd0XI6lfcqVQh/Or0Lv
 CakV5skUvd98o9cZl7Q1zQIT2H+FJME+FK12iMqj3HZeOZK68OJmWphfS6bBd6wkjQilaOGWK5n
 sq7JT8wnpecyDhOAlMEjmkCeL62B+DgzqWjuG6idAuwMl4v99S0rFVhgwisouM7VuilAVfySS9H
 yUTdkSWZsdiXWulpiPMns+p+4LJhVpy4Xq2ye3kcdfY3gaYIGsVzLbEkgMKBm++Avxq+QaC4BiV
 WDkjBeOZrpN2DtdUWUehXMSj0Fuyjb2E2zX8rWhikWB1Fmx0kjphYGzWMt0NbbgFMm7KDvzH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_09,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Jun 12, 2025 at 08:57:54AM +0200, Cédric Le Goater wrote:

> On 6/7/25 02:10, John Levon wrote:
> > The series contains an implement of a vfio-user client in QEMU, along with a few
> > more preparatory patches.
> > 
> > The vfio-user protocol allows for implementing (PCI) devices in another
> > userspace process; SPDK is one example, which includes a virtual NVMe
> > implementation.
> > 
> > The vfio-user framework consists of 3 parts:
> >   1) The VFIO user protocol specification.
> >   2) A client - the VFIO device in QEMU that encapsulates VFIO messages
> >      and sends them to the server.
> >   3) A server - a remote process that emulates a device.
> > 
> > This patchset implements parts 1 and 2.
> > 
> > It has been tested against libvfio-user test servers as well as SPDK.
> 
> Is libvfio-user a server-only library ?

Yes.

>It seems a bit odd not to use it on the client side.

I wasn't around for any original discussion here, so don't have context, but
there are two clients I know of today: qemu and cloud-hypervisor. The latter is
in Rust, and the former is opinionated enough that I'm not sure the message
handling part (the only useful bit of the library here) would be a good match.

Also I rather like having more than one implementation of a protocol, anyway.

> I *really* would prefer if we had functional tests although I don't how

I agree it makes sense to have a working functional test before merging.

In the meantime, I would like to continue with review of the main chunk - as you
said, there's a lot of code. I've not made substantial changes since v3 (only
the comments so far), so I'm happy to continue with v3 review, or if you prefer,
I can send out v4 against master. Please let me know.

regards
john

