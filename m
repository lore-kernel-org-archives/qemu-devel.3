Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD51CC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 14:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubgzy-0005mr-QB; Tue, 15 Jul 2025 10:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubgRn-0003BF-Te; Tue, 15 Jul 2025 10:16:03 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubgRg-0001zf-MF; Tue, 15 Jul 2025 10:15:55 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F959DJ014031;
 Tue, 15 Jul 2025 07:15:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=Hu2yBg7PQlSuNXQ
 r+5zVR4QtrJYuBQDjYi20WbRmDV4=; b=JfNagDufN/xm9rmSMZf6VKP1tpKdZoa
 dhryPOPwpEnwVUd0MmbchOjBovmP3eciGfq0cuKjyePid293QM1FVqRnhKZEC5AE
 +vXpxrx19cF4wcEuMfgWCds0BdS7Q7m3D7AuSyhaIRLmduq3yvU99gi7cwxk/3x7
 qHe5fhR3k9Az0Ba9Ry5J//OYyVVimOdwCO8kz1IxecrLhSO4d/PIFcho/rKKzCkC
 Uq8sgGq7khPVFYcThlkssEm+F9YK4SYgKiCruefvd4nAaJCaDw7M9HfZtPoK3c4M
 31pbzIGK9Li7OT/7hfFeXMq25MAtLyNhZ6+9lmLFbRUw1BtCKmAC7lQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022093.outbound.protection.outlook.com [52.101.43.93])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47wm1s8rj3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 07:15:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7tw9hqN2ik+iI7Lszb1d3fCKHSKB+equTqqldfNu+np29ZIfasObGzQXopGoVZs7nncg4PX0CG+2kC7Wpo3B8ajBydbIl1wZRoznsvxadTY3eJE2CfU4/1M78j+5I2bU3LhrxHZoU1UEl4mUxGBOCtn2HMdb+Oa9A0v1xcw0YKrLrEWjDH6d7ieKNXruaRCc1SipVbyPI+YQV2WgAruLgzb5JwqD6n5bWDZdZ7O0CdSnB0J+pc52pkGlx1ah1fTan96Oz8zPaHUDSMudoHNogXCEnjPelvSLgp6mldmGzxRjU+TNb1Ct8wMzHh4SuFzZvsx/rigJzGoP1+GZDjT8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hu2yBg7PQlSuNXQr+5zVR4QtrJYuBQDjYi20WbRmDV4=;
 b=VGfrL0Kaw5LfwCTZ3yWrABUEJ99y6OZ9bd1ZTkuZYpC8H3NbZsl39FtSoxEKkfHF03fT2EdQRbRrbuWHIOCnAXphTmrZVZKwxfMghhrNWI4CfElCNi50TZiY5ixlCK34DuNMoW/03weBcRwhI8xC62ZmnU1eYd9OlYXsh2WtMlqhHTDFWai0Mg029exauaV/SXi44pO4ONVoBO64A0iAfpxjf59cCLwi8XGTt/C8UVHOKjymKKkKcBxjx/shtP6Mv9cw9RpKMEjNRfUksnC5LlEBoDwZSAlpA5KHwPZ9/UUiri3cpySsS0baYf/PwLYYC9YMX/fGZ9z+3JvdbllOuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hu2yBg7PQlSuNXQr+5zVR4QtrJYuBQDjYi20WbRmDV4=;
 b=O+5LrwcLKx/7bdis0oX7XjIjQtNc3txmV9OgeiCv95uOOhuEtu+Cu1v88hRdglFwpIGFFMM52IH2dYm/C8rSyL1e0WTM5p4lCgBzhdZpiNKTnvEY8XoJYFbzkMSc+E/divk/tS+GLo2TZ/zw2sW3z/7q8esEf6QWTBfOCinETWMl3SRvgWk7Dt1CDIuUTm11YtFjEd3OP20RakzX4NpdXYMSeDk1OW8ZEilCwL/G0LsNX/x8IbUw9FsUqFtB3j/p845E9EkAWJ4vkNS092xLbqr6PicCRbdwW9mXxOSeyDCLE12MYv1ssD1mjNEFidkQrkjjAxSse5kUapZWdMJnpw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DS0PR02MB10760.namprd02.prod.outlook.com (2603:10b6:8:1fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Tue, 15 Jul
 2025 14:15:37 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 14:15:37 +0000
Date: Tue, 15 Jul 2025 16:15:31 +0200
From: John Levon <john.levon@nutanix.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 thanos.makatos@nutanix.com, alex.williamson@redhat.com, clg@redhat.com,
 steven.sistare@oracle.com, tomitamoeko@gmail.com, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 12/22] vfio-user/pci.c: use QOM casts where appropriate
Message-ID: <aHZigwzEPy9W8A2v@lent>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-13-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715093110.107317-13-mark.caveayland@nutanix.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM0PR04CA0093.eurprd04.prod.outlook.com
 (2603:10a6:208:be::34) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DS0PR02MB10760:EE_
X-MS-Office365-Filtering-Correlation-Id: c773e82d-0c37-477f-e31e-08ddc3aa121c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Bp6TArh4y/IPLIKwz8uFyHIUbWybc9YUL7YmVAMP9vr+3ltFomqhHmo7vBpZ?=
 =?us-ascii?Q?Oa/0AUHrrQ4gjczPSlOHg+QXSEw+BgBW6lj/Mo7H20W7VOkGTbeQvO+oD4b1?=
 =?us-ascii?Q?V65reUMokHFL3LZqa57mgnvYqNnhJWgYuGuVU/7Eqromj7l7yBHnMcXH2TnK?=
 =?us-ascii?Q?WiTKSM1IOFjl8CsysFADThtz2YACFPPGMNKKdFoJfnfmr9b35QF2a7V4BOk9?=
 =?us-ascii?Q?hGNBKbFoH4bu/VrQdaAcpBsxA4kM1hhqVLn9XEyVKMIJDL34VJwDrExEdjki?=
 =?us-ascii?Q?13hlghf3NYgmINMjrjaiKeexRrHOz2TtSKOq5m29ncWOTmd94zMugUcWPLZI?=
 =?us-ascii?Q?CbSO/6NampjuH99zcjT53h+1TYWr5wlj/NuAwdLd44W2aJ635V6E9SPkCjBH?=
 =?us-ascii?Q?XbDw8+P/w4rxOOJE9Rzntt5EC6uZOZ9r0NgfD5ZihsStV215Q+M3EM8cU4KD?=
 =?us-ascii?Q?P3YCCYy+wCG9BcKWX8q6G/k9t9Cb6xzhCA6yeVmobBp2rAcS5QBsJzJM8cXF?=
 =?us-ascii?Q?h2PEzh9Cunp1SvQ/evHENkvjE2myanKHw6Ep7sxVsujAWGP2l21SkIL8OaYM?=
 =?us-ascii?Q?nl3UQ30xmtWNqpDkIE13fluLkazJorVbWqVR5KbghPavOXUQhyqn8iM4OYMM?=
 =?us-ascii?Q?w9Khy7atDH9cTsjyRKkG8UF3U4TLsWm1KziGMYnmSvga5vvMw+xHAVdo5f+q?=
 =?us-ascii?Q?3S2b7P64/EG2ft2ECZyCEAHfpp7zYveyQyo8gBAMY5kMPXZ4dWqmfkT3N7hJ?=
 =?us-ascii?Q?RDr6LvAE9z6kv79RTeCy2t9+6BauIQKmCI8Vdr2RTuN5IpihElYYBLnEGjwg?=
 =?us-ascii?Q?ig9phvqGQyO7WtBFeg2ncgPMvaysvQLt2F+RATtbXDrsYvqEQ586BpSsa3lA?=
 =?us-ascii?Q?CT2LzaOn5fr0GNewh6zXFm1B51ouNtBOfYmAV4FOxhy3dEErEJnrqasrk5lJ?=
 =?us-ascii?Q?VJp1IkyPl0lMBuKBwi5LqX/LZ2aakkt5gc1CMI2tXYuBzJZU8Qbbz56K3Fjm?=
 =?us-ascii?Q?0AsWRw1cpvNn+nKLaWKSdUVL4IHMs29dIvVXQH+SU83G55ycaUHc99TDyWLL?=
 =?us-ascii?Q?Gy1xRwQ/fSMdHW9922rhuQYhVPGNIciV3pTRl62JXWcCM14uHGkEGIzgS2A/?=
 =?us-ascii?Q?LfSKICkpckdzHzQMe6TQXyofx0e/wvIB2K4sGXsXq3jdlYe54OOKpiFY1CCN?=
 =?us-ascii?Q?6H5ZvBn8mU1CaNArZPnfb47JarQROLNK+ztft5AY0R3jHeLF3Q8AcYHaErAQ?=
 =?us-ascii?Q?QicskP4UfB2uP5/qAb6K0KFP/IUNB3AudaDSPYUr8GTOscodkTUKVoFl3vFM?=
 =?us-ascii?Q?PA885FsGfKGAUpUMDzPCcmUqiig2dJ55i+5vY8dQRjienNMdr6TI3lb2SeyW?=
 =?us-ascii?Q?whQTsz5n/vP0RuR/5BxdRTKbKuzRzUacNVwnCDH10uiGUnOImukVdOX4QwMw?=
 =?us-ascii?Q?ijwg7HnD/+Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?re3/7lf0Hq9huSuZGv21Lp6eNfmJPDU82RHyUmqwj/Nj0srhO18Pl63zdFOB?=
 =?us-ascii?Q?BKpNHQBhVQuORZf+rUNYK83vwIz7vrRWmbmXj1FNlLY5XhzdE0mGKeSYgLng?=
 =?us-ascii?Q?k5pT/kKkXKKd2+Zvf62EH60SrxLAHKXswKsdD6XA0uT8UHn8VmMmLmYnih6h?=
 =?us-ascii?Q?NJasXF/Zn5zNB83WxnVLx7QpqwL2t2hYmh3zISLyLL54k+KoL2vxKpHs7TRV?=
 =?us-ascii?Q?oNQWSlSF1ozD13Qch+88mCh4SI7imDuzjSriFA3MsqWGN/BNVJKCvHFH+Nkf?=
 =?us-ascii?Q?iyycE6LKyKKdXq3Ujpcj6Vw93roSmQvnLqfQq71CcGn+cPcnVYvWuWDgQY7m?=
 =?us-ascii?Q?Pz+Ya5WeD81IzGyJJFxS4PQ12+yNuA6/w2m4bmkMvs42901aDPZ93Di4sUKV?=
 =?us-ascii?Q?IERBUQt7wYRi6lqT/LtCI3x67rx9WW1V84vOfnH//ji4hQ8cvemLXKoOjlHE?=
 =?us-ascii?Q?h/Phps6jZDt6Jljzc1gTZbtE2pL70FNcWCnuh6Y12V10vEqbSU58qL5KD+VH?=
 =?us-ascii?Q?jxYq1NTjTOS/8w8y2Eh+XOp1hhpT2ZXrNp26YZQy7SDCKQB7NswtspaD3mSr?=
 =?us-ascii?Q?KNVXlL6enPzfwHC87FE7d/GfTJrOrI2SNW/7z+kDIxptImWQbW3d0R5U8YBT?=
 =?us-ascii?Q?oJyW9uXW7D6oioN1BlQohjT2RxLhSW4JEck1tKTEq+vpPnzgBFfPRxbBMMBn?=
 =?us-ascii?Q?8OteskWVphhM50Kmr/OnDtAA8Ubqm5QUIHXjh5mSSHcUQLKTZkCrMc7R8k2w?=
 =?us-ascii?Q?S45L4E+3Bs6Wou3ppf19FDSS7ZysbQDeWDQsORigJmnHDPXVCadtXHcfLIAA?=
 =?us-ascii?Q?E9MHJZaDeHeoXwC6Ra3ucocO+W33iWhSA4rhyV2Lq3k7AFIEB011uF/eI86w?=
 =?us-ascii?Q?f3vvGdK4gnu3aGc6NS1uTyAp88ziVSsCbOdfjbmMKBoLAlWLyE9uduiT8i+0?=
 =?us-ascii?Q?TWaD6P6jdPCDFIj3k30RRQc+GJ+geIyRxHX4H5ZtxXLJrJ2Bx7ESZQxUxJZb?=
 =?us-ascii?Q?9xX7YskRUwtTxyu1hKbiPS4MOAX31BnRignx4+4pIvv8DDCu1WI3T5JS0zXP?=
 =?us-ascii?Q?l0wcyjCwzzvNURUZEurzDfGERmN+xZx4airU4Li6McvdAEJzMn+4SQFx+MpS?=
 =?us-ascii?Q?xH91tY2/rJDBeJUlUTUgGxR64g7jL90mG7PC1wpFplzooMZeeTyumWUBnDTV?=
 =?us-ascii?Q?pEuNOlmXpAEIrOvYMIfB3MP7ACzRvnAcgNTkYVHfxgbrmCzNS1/kWtO0u7eG?=
 =?us-ascii?Q?7BoeooS2FDxCgbcuDaZp5VkLY3VFWRfNEWfcz0kyK/8AfYkkqbBS5aptChio?=
 =?us-ascii?Q?bhiT9Y4vIkgXBz4p9r9KUaSmlPhKpLvEQVDmM1+WEBjzKkwEEYwZnYhn8hmM?=
 =?us-ascii?Q?BoWwQefR4NpmqYHynvI+xtwmMOmgmYFQfqOYkPxTOMtSeFkrqOTPx9Iv2595?=
 =?us-ascii?Q?W7tvlkt4kokOXnh7KyAfzSeDAPOSsEb/MlGzkDYoSuOjj5AyLjsIGOoVzRU+?=
 =?us-ascii?Q?/vK8WAXrQX7p6Mn+lENBOt4wRnaBRzU2nfe4R4H23ItegO4y2v2X8FbmM0b7?=
 =?us-ascii?Q?nYcESqcuRT+EupH/LCmAL6kZfDKekLntIdsShX+mQsmoeoNZrPGey2/AWIqb?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c773e82d-0c37-477f-e31e-08ddc3aa121c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 14:15:37.3814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zpyIfQjHeHLifsovsIO03HLwsl6HBNfRnT+hPZgjWh8wZETBByW6IzA+uos/RKIDTvSjrJUiPRlga8pNvNQW8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10760
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEzMCBTYWx0ZWRfX0AyzuIdx0LdN
 EwHpZ1A72zN2uU94WFpg1K6LeqkkT628VvcrZ42tj58o4APbPoSssn3V444XxOIozv2BGtF+HaZ
 yPFETeb+aMMRQnw57eT8+Y0D+C0fk0pbcmqIWWCi/GbT4nzGAsI/4eVPVWRDjNJ3wEVZ8pBSxMa
 ul+uAb8fd3cnGwn8d5LFKgPq0qwNZrgIdurZbin8wtviayDCMALzGuFMjt2i21PCPIHyAGqpBkN
 GkBmZSOVEKLWdWYyNxDpouc/ezR2QKJGyRDgC+WqqF2vyrkSUa1+Ts9woULSN6ZbcPDmk6Xe8rt
 xpXdUy8EYvwqjum8GG3WdptogbCD3p2uoGwClQBcY38o2m1FB6o4B20s68kZodH6BoePGlOBUdB
 AZk4MypsdQTVxGhu5dpsl49mSrQPQ8pFMlAolOaD+DrLoA9yMKDZ9dafotkFdaCW9KqWaOn4
X-Proofpoint-ORIG-GUID: SMJvpLth0mCLlgjCEQny1DS9opq7jzBF
X-Authority-Analysis: v=2.4 cv=fZity1QF c=1 sm=1 tr=0 ts=6876628d cx=c_pps
 a=+CKpLqsC5QamL8vULJ+FWg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=UJq3_xYJeEv8mAHxOrAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: SMJvpLth0mCLlgjCEQny1DS9opq7jzBF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Jul 15, 2025 at 10:25:52AM +0100, Mark Cave-Ayland wrote:

> Use QOM casts to convert between VFIOUserPCIDevice and VFIOPCIDevice instead
> of accessing device directly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/vfio-user/pci.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
> index da6fe51809..e23a941605 100644
> --- a/hw/vfio-user/pci.c
> +++ b/hw/vfio-user/pci.c
> @@ -214,8 +214,9 @@ static void vfio_user_compute_needs_reset(VFIODevice *vbasedev)
>  
>  static Object *vfio_user_pci_get_object(VFIODevice *vbasedev)
>  {
> -    VFIOUserPCIDevice *vdev = container_of(vbasedev, VFIOUserPCIDevice,
> -                                           device.vbasedev);
> +    VFIOUserPCIDevice *vdev = VFIO_USER_PCI(container_of(vbasedev,
> +                                                         VFIOPCIDevice,
> +                                                         vbasedev));
>  
>      return OBJECT(vdev);
>  }
> @@ -418,7 +419,7 @@ static void vfio_user_pci_set_socket(Object *obj, Visitor *v, const char *name,
>      VFIOUserPCIDevice *udev = VFIO_USER_PCI(obj);
>      bool success;
>  
> -    if (udev->device.vbasedev.proxy) {
> +    if (VFIO_PCI_BASE(udev)->vbasedev.proxy) {
>          error_setg(errp, "Proxy is connected");
>          return;
>      }

Reviewed-by: John Levon <john.levon@nutanix.com>

