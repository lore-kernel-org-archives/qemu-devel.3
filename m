Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC608C3DA6D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFam8-0007Kf-6v; Thu, 15 May 2025 11:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFalP-0006BL-RR
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:44:56 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFalK-0006CV-EP
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:44:50 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F8GHeb021276;
 Thu, 15 May 2025 08:44:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=z2VXFeduDIUIMUtFpLP9ErTdTd4WNkw5pDScHzJjS
 mw=; b=yCxPhqWB60V2CXv9rSRU7H9qddR8pcjSsdhs2+DB7t/HsuiayqKtTonuv
 Kr+70wixXXECmBnqnhS7ub61T5WN88CYo0meSVHDYLWFV4XQcgfEY3kxdniVbyCy
 BVkcqcqn0D+wz783Ae5+dffxB2HmGn4PV0U8Q00EP48HQl1j74GN4DPq6OIg3fVH
 EXURpBgf627gqd/JqVfvAiEsEdH/VYhu1Rj/sq4e6La+ELzDSDCNRN1pFLpnq0LB
 9pqcrRvnB1wmqpkOHCR6uLjeUwqpV2GV87IHS6QiaLQvzMQnXBVN3X0J2S6NFs0W
 vUei6FsjFVxFfZeQRsRyi1Dz5zUGQ==
Received: from sj2pr03cu002.outbound.protection.outlook.com
 (mail-westusazlp17013076.outbound.protection.outlook.com [40.93.1.76])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46mbctngvk-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 08:44:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMCjx9Ap8Pkic9ZnW4jg4hvkq5LwQGhVRsxG0bBkjmTf9ylfZwPaAb8eFDYgDfTqOTM5ipvnNJ28dP9cSN0qKls+HSmG9uY7eWvNszSeAUxTo3yuIUmL8JbRhNBRSUGHw8UGuf/YQYMQira9U8vj2ARV32qqVR3YzRHycF/TAhCSZSVuEWWkLTP2d8QsYm+ESQmhq1vsauEhq0VfGdw76ABUq7wqirYykTNw6aDQ8ytuhV6ZAMhZBDoXPaoRWTwW8qY9yLzo3H+kA8xPAzqSk40GVz3FpFnlMqvSY3Rt5xpUJsSYwCWKm2uD4yPixk58Fjz3QgtBSkaTCeRtx6ru4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2VXFeduDIUIMUtFpLP9ErTdTd4WNkw5pDScHzJjSmw=;
 b=lTRbzVoFGVMLExFxwGMJHlCKYki/6emJ1eYiOsp+8sSN9IoDYhlScN5vL66ILYySKVgSCGE3SsOrJuB1Y0vD9b3b4Aalq3jAgapaTbe04G8je5YmjoCLBsgn2xeNZr6kOrk4G98B3kC7U3qgS/hJLR9D4hE15MrJzijvmeI48IGwb4VLXV66lPJdXUcDI9ZwL4aTzdaFE604c8jZ16+bJMloIsKo0C5WFhtvoqqsy6nrlSPEYfJPOc8cQgxm5SzzaYXZzwQaRf4OeQHps4/+NmJS4s4ezE3nyBShkCsYCatT3HUupt1DSUyjgRdOsp/Q/tAWjYzS41BfqN2JSbvjRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2VXFeduDIUIMUtFpLP9ErTdTd4WNkw5pDScHzJjSmw=;
 b=PB22JzMgpL8NqsI2ylwMkvMiRpaa9xA/LrHJX+e1cteHi72n3TUO7WMswNEa5ri3JjwrU5V1a7NBH4KLK4CKz5sQbkqU865jpgIDFu+invy9LTeB+SPgeffy6KbzcFSEWUwJ7DyEcUrQiijd5oNDVWXhyKYFGxwP+Y7+sBiR/gQeLBgNppj69qTlzWzSiiamR/1/n+QrUdey7qXD6R0urSrGIOZm1/F0j4F4M9xf7goELY87nBCZm5WcTUHXONKyK1fXmxHm3q39noKLPX4hfoWbpNVIDlNQgADJEv+laQOWeGV2x77oKvf38+Qgi72KNNDPwTfUAG3mqC6Q7SG7MA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8470.namprd02.prod.outlook.com (2603:10b6:510:10e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.17; Thu, 15 May
 2025 15:44:36 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8722.024; Thu, 15 May 2025
 15:44:36 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH 07/27] vfio: add per-region fd support
Date: Thu, 15 May 2025 16:43:52 +0100
Message-ID: <20250515154413.210315-8-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515154413.210315-1-john.levon@nutanix.com>
References: <20250515154413.210315-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d65b1f3-43a8-4c4c-8386-08dd93c7654d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f5V50R+zmQCHd1JcpQ6yXGrohG+ArFY4Uwd/YLZprt1NdIaLGDwIqWCyP4Ko?=
 =?us-ascii?Q?Lz2siHKMoWkAw831P6L0oFtdC5HOamgHREEFTlL8kT71pK6d+afDJsv6kBLN?=
 =?us-ascii?Q?IwWxTZ/xeltXf0cb8duUsPzWEsRRV96GaUMQP3z4pz/EAxtu6q7b4GUYWrrg?=
 =?us-ascii?Q?GvO7iLMFe9MZdMRBRzPcCxv4Yt9it2p6pYjmWgRzUfnneLBXXGO5lLRGCYNe?=
 =?us-ascii?Q?HGTXqaMVQDb4dXLAIPcbBDnHt0svPFGNFDK6jNCsXIlySDo9uxMtX/KCpDYE?=
 =?us-ascii?Q?+wVL0YNGG/4K438oreRHRir9d9JXmEgkkdwcugyWVTmeZz6mCZIvacKKgcyE?=
 =?us-ascii?Q?OcBqGUwpwxuOvqFt6qD3KyohGVpY/hp6uiI9Rr2LHl/0Ndv+qxfOK2hzE1wX?=
 =?us-ascii?Q?1DjcwKD6HYiHbSOM8k/2zfNZi117M5NfiRgBuvhWKuf41ebEkd3JSULdn6j7?=
 =?us-ascii?Q?CitLXAg4T0BJEg+B9y3Eyo4luqgZgNRYRhIYA4PzdXofqZqKbUyFUERDfe66?=
 =?us-ascii?Q?Yol+XvLesx1wdoRxMl4n3NCVxERofLia0FWfiehIEao80i53rHt5+H97cWCd?=
 =?us-ascii?Q?k6e7et5eHJxeXEfMrxylPN+nN1XbX6JEFVZ8c8yIkZX6/ckDozFxbfI6GXKR?=
 =?us-ascii?Q?p85R+uec1eQRxi61tQKKM8vfmUlmalybSUVAmsXh2q3HV7gbVber4RKK+whb?=
 =?us-ascii?Q?6K0kb4ootTwo2bW8+sELE68sKybdsaTNfEIqV2fMwJV04CmkKPRMKumfBetf?=
 =?us-ascii?Q?/BW2brqGru986L0Vdr//UU2wlBFYC4WQDvHNvJJ3kKKPlH0vrF24LxaLW5ld?=
 =?us-ascii?Q?Hokqyorz+UAmw2qdUGppjno8ozOMIUiv3Iv8XjJdhbV2/iXdqO/L8OGtr39l?=
 =?us-ascii?Q?KBLn9YsL2BCtPwnOwMRzenrFNQHLm2Ab3eL3eJI2WQ1C1/gNITlBJWk4/TY7?=
 =?us-ascii?Q?uzylIBfHUB9cJivEN7vxbDLbQb8rtz+mq/ER0zXFoRJtAafRHhJhVh4gfaS+?=
 =?us-ascii?Q?Vbj4RgcwOtUEtbJ8A4JLnM+BBVYO9iGdUaZ2mGkOB40BLKMIXh3meOJynzGy?=
 =?us-ascii?Q?pGTsC3HiIOWJjWujTYytwHwWu6dKWhsYfVSiDe4wxCy7NCBQBJLmTznxfMG4?=
 =?us-ascii?Q?ghxUEGuZh3WTi3mkVZsdsqoLQTXU86AiLeq8d/so0x4whV+d5L1yJu4KQ+H4?=
 =?us-ascii?Q?W+PqCOivgiEIxpv2vWAN5zZIs88m4hj5T5yl2e/wLIuHCMXBnTRYZoYcvjTX?=
 =?us-ascii?Q?P0JsFkz7OP7uRbfWcPuBZI6ohE59g+E5VhJOIAmjStBjOmeZ9WpsE46j+gJN?=
 =?us-ascii?Q?ShPU4GZp1o+op3ywieI7MCwWOFEeSSngHjLTJkC6O1AGPeCbB5HAYioUi6N/?=
 =?us-ascii?Q?aZLbxPpvXic1xGJiUW6GGH0MWHVLGWJWHrjV0RTQmmL8yvhxL2ejAaGUWY8s?=
 =?us-ascii?Q?t9gz/v90yWE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cCLFP+pRLbrdy+DjfWa34MMQjZ8OwkPC2EXJgIzyr9iVKHQXg+Ek4ggtI64t?=
 =?us-ascii?Q?jBVWiu6MAYDi368J5GNi32zFpEpfO0oT61LNWJ5AuH2LIQnWElylEjGPcYKl?=
 =?us-ascii?Q?Vyi845i+HoFIXRJ/fZU/1fYilPDCOrLxUfkxqjBK0397ql9AYGimOMgq9IIl?=
 =?us-ascii?Q?xQekFHNCGo5n9+Vcqfg36Rw92tvCwk3fm2r9eHM58pu8UBYnFylRe+F1zIkT?=
 =?us-ascii?Q?hx9q7A6sp8EaBc6cLN62NvdgMQdBJyoCkhRSDDnXju9dMc7T8nihAsthpk05?=
 =?us-ascii?Q?J7kPsL63nsyLmk6joMMlYQoexuTEUN91/eIQF2zWgjozCpHm1DlxkvTJkKy5?=
 =?us-ascii?Q?TXKPLiXuAECUdJ3KUJCFIAELmQhJXzQXrSD7VNHG06fytuwS1K5/5tvHCim9?=
 =?us-ascii?Q?40U6rFvjHwj+t+omj2Pe9AJ2JxEzcuEuo58Bmt+bV3Y11pJ+nNOURDptv++1?=
 =?us-ascii?Q?bzsbQM2PZEM4Mm5lO0wS7oSirravxXejIBedlh70DiyvstTGKrTKccSSa6w0?=
 =?us-ascii?Q?0ZI64P8zOUPzIHgcmbfpQ335DXtscM1fjyz6a6i9MtRshWs+EMI6sgf8tkf9?=
 =?us-ascii?Q?2pKWvYQLhsnMWaRAXiVQUtbvQFindbi1FRwO8BX5ITnLwzvyi9ZRpt7+TfMh?=
 =?us-ascii?Q?GAZI84ZKeaA3bOrDq5H8X6A5L/NzW29VFCZAG+cktHtAl1e7tTMr1puyk9IM?=
 =?us-ascii?Q?9Xl53GLoHt1Xr8Fv4bHlb83ihB4kpFNqsivBeIGR7qEGMaxcbZ1YzGaO5aFv?=
 =?us-ascii?Q?xnU4nV769lpBxhn5uHwU7IxEI/Q0o0Q0+egS+xFudpsZGk1rfSgDgEekqrwh?=
 =?us-ascii?Q?Dazdbjcjlsx9pqcOZ/PE4Bhs9RGriz4xq2geBXkdGTptOgRdMEZLzp3t1lJa?=
 =?us-ascii?Q?VRLt4w1RvxmHcHueQqAm+rJ8xBX0X9xqaS4ya+aYHTIPJ3aIMNirQT7IHSAx?=
 =?us-ascii?Q?/vss+N7AAECFcOFdkrECsESP8OgQjvUUxD/fwIkxI4GXwb4g7fAi9UNOLP63?=
 =?us-ascii?Q?ERftM6NK0facNcEfR4e7p4hAuZ0UaNV7ibLqLgCRNEUa858+YEDoWhjeD/Qu?=
 =?us-ascii?Q?2lviB7H9kWfypbAvHOqeHHI3ABo1m8wBrQ5LI2KZ+a8Co26saSpEhVlYrqJX?=
 =?us-ascii?Q?oULPpXYepz23oV6+EGF5sDt4kyVMcRJyohA0QU5yftWTviFNTeu8OrYzFFpz?=
 =?us-ascii?Q?V7dp9V16t88xItH6X6O0NsqDQdTtKeKpdrzedlNtAw3uzZg3wRGC8Gip+HQe?=
 =?us-ascii?Q?hW+qYEgaaHQjLqmq3AIszrM1X7Z/HqxJb5fyCBlj+uvTjcpyGYi6gQW1ZXs9?=
 =?us-ascii?Q?b9w3rIfjxgWrV4BWdk8ki5fRzuYzyAPJUQSrS06QAfuWIKsMZ1c0bAMNGS0t?=
 =?us-ascii?Q?fOAjDV5LYBTinf4kLQ6qcEv07X1SeJPD6pRYs+SV3LkYwe3zQSt6FScvc8El?=
 =?us-ascii?Q?Xu4ANr2UbUcKNqp/YWvJyA+IRcg8asGsSpzNbcvmu/GMrJTH7dayjOfd9KKX?=
 =?us-ascii?Q?TsUmqisRQK7QZ/ySaW7NsH6tD9HIyBtJMN2clrKD503usGJGmovp1meJDZqn?=
 =?us-ascii?Q?WpX6SOSU8yDt1+/0kYmu4c4Pkv9cPISvC6xHqS5Q?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d65b1f3-43a8-4c4c-8386-08dd93c7654d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:44:36.5064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+fXWH/CUSx3lOsblH5qn+D/9U0tDrnwfC2LIINeD4ONOgNIOTcYfT+xsKpHdMNV9o+X7iVu+jJ9AaEA4c/Agw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8470
X-Authority-Analysis: v=2.4 cv=euLfzppX c=1 sm=1 tr=0 ts=68260be9 cx=c_pps
 a=OVSnam+0waiSP26xbJD4Ig==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=5dvBy8a1CCwUYuo3VioA:9
X-Proofpoint-ORIG-GUID: nPdZ18jnQGtCZ3isxXi4OItWv7yOGgES
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NiBTYWx0ZWRfX2bjVrAA3Fmub
 cLlbvtMcXZezsSwH0YXExXL4P32lhOunYql9LhYLFpuTE3iVwZNKIGdYucmxj+9CohzdxBKYJbM
 o77+m0tBG1vYUtKZSTjBmHvzYMiLUDzGFF+QO1TPyLfcSJPeoBLatm1H5rDwrh0i0WLKfcq5dDE
 c4suvWGaTvFW+GwZYM9l65PgYBjplqYwknzdRuKQaRUb5pEDoZ0gjD7GXtThzDUc8+Vqx/+hOyf
 qG0mGZ6ns/CJ9+liXycpHJ6dgMJD07IazuYjBlujZGNj6yNQLwoRhs4TlDz4UqOubEU6yAfbsFx
 MpssfsuGP/kSpus56lRG7XSvmzfzOfq8ECLeq6+9WhWHkixwmN6BeiiDoSPBwKjrBsRmcfw8iGR
 I8nWhR8rh1yvlcHwYDPiIfVFIlrBl70wz1kE8xUHB2p09sIUg/Xg27IS4g9JEzm+mPvSVrVE
X-Proofpoint-GUID: nPdZ18jnQGtCZ3isxXi4OItWv7yOGgES
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

For vfio-user, each region has its own fd rather than sharing
vbasedev's. Add the necessary plumbing to support this. For vfio
backends with a shared fd, initialize region->fd to the shared one.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 include/hw/vfio/vfio-device.h |  7 +++++--
 include/hw/vfio/vfio-region.h |  1 +
 hw/vfio/device.c              | 28 ++++++++++++++++++++++++++--
 hw/vfio/region.c              |  7 ++++++-
 4 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 923f9cd116..5cb817fd6a 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -66,6 +66,7 @@ typedef struct VFIODevice {
     OnOffAuto enable_migration;
     OnOffAuto migration_multifd_transfer;
     bool migration_events;
+    bool use_region_fds;
     VFIODeviceOps *ops;
     VFIODeviceIOOps *io_ops;
     unsigned int num_irqs;
@@ -84,6 +85,7 @@ typedef struct VFIODevice {
     VFIOIOASHwpt *hwpt;
     QLIST_ENTRY(VFIODevice) hwpt_next;
     struct vfio_region_info **reginfo;
+    int *region_fds;
 } VFIODevice;
 
 struct VFIODeviceOps {
@@ -172,10 +174,11 @@ struct VFIODeviceIOOps {
     /**
      * @get_region_info
      *
-     * Fill in @info with information on the region given by @info->index.
+     * Fill in @info (and optionally @fd) with information on the region given
+     * by @info->index.
      */
     int (*get_region_info)(VFIODevice *vdev,
-                           struct vfio_region_info *info);
+                           struct vfio_region_info *info, int *fd);
 
     /**
      * @get_irq_info
diff --git a/include/hw/vfio/vfio-region.h b/include/hw/vfio/vfio-region.h
index cbffb26962..80e83b23fd 100644
--- a/include/hw/vfio/vfio-region.h
+++ b/include/hw/vfio/vfio-region.h
@@ -29,6 +29,7 @@ typedef struct VFIORegion {
     uint32_t nr_mmaps;
     VFIOMmap *mmaps;
     uint8_t nr; /* cache the region number for debug */
+    int fd; /* fd to mmap() region */
 } VFIORegion;
 
 
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index d0068086ae..41db403992 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -226,6 +226,7 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info)
 {
     size_t argsz = sizeof(struct vfio_region_info);
+    int fd = -1;
     int ret;
 
     /* check cache */
@@ -240,7 +241,7 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
 retry:
     (*info)->argsz = argsz;
 
-    ret = vbasedev->io_ops->get_region_info(vbasedev, *info);
+    ret = vbasedev->io_ops->get_region_info(vbasedev, *info, &fd);
     if (ret != 0) {
         g_free(*info);
         *info = NULL;
@@ -251,11 +252,19 @@ retry:
         argsz = (*info)->argsz;
         *info = g_realloc(*info, argsz);
 
+        if (fd != -1) {
+            close(fd);
+            fd = -1;
+        }
+
         goto retry;
     }
 
     /* fill cache */
     vbasedev->reginfo[index] = *info;
+    if (vbasedev->region_fds != NULL) {
+        vbasedev->region_fds[index] = fd;
+    }
 
     return 0;
 }
@@ -360,6 +369,7 @@ void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
     vbasedev->io_ops = &vfio_device_io_ops_ioctl;
     vbasedev->dev = dev;
     vbasedev->fd = -1;
+    vbasedev->use_region_fds = false;
 
     vbasedev->ram_block_discard_allowed = ram_discard;
 }
@@ -470,6 +480,9 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
 
     vbasedev->reginfo = g_new0(struct vfio_region_info *,
                                vbasedev->num_regions);
+    if (vbasedev->use_region_fds) {
+        vbasedev->region_fds = g_new0(int, vbasedev->num_regions);
+    }
 }
 
 void vfio_device_unprepare(VFIODevice *vbasedev)
@@ -478,9 +491,17 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
 
     for (i = 0; i < vbasedev->num_regions; i++) {
         g_free(vbasedev->reginfo[i]);
+        if (vbasedev->region_fds != NULL && vbasedev->region_fds[i] != -1) {
+            close(vbasedev->region_fds[i]);
+        }
+
     }
     g_free(vbasedev->reginfo);
     vbasedev->reginfo = NULL;
+    if (vbasedev->region_fds != NULL) {
+        g_free(vbasedev->region_fds);
+        vbasedev->region_fds = NULL;
+    }
 
     QLIST_REMOVE(vbasedev, container_next);
     QLIST_REMOVE(vbasedev, global_next);
@@ -502,10 +523,13 @@ static int vfio_device_io_device_feature(VFIODevice *vbasedev,
 }
 
 static int vfio_device_io_get_region_info(VFIODevice *vbasedev,
-                                          struct vfio_region_info *info)
+                                          struct vfio_region_info *info,
+                                          int *fd)
 {
     int ret;
 
+    *fd = -1;
+
     ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, info);
 
     return ret < 0 ? -errno : ret;
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 34752c3f65..3c93da91d8 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -200,6 +200,11 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
     region->size = info->size;
     region->fd_offset = info->offset;
     region->nr = index;
+    if (vbasedev->region_fds != NULL) {
+        region->fd = vbasedev->region_fds[index];
+    } else {
+        region->fd = vbasedev->fd;
+    }
 
     if (region->size) {
         region->mem = g_new0(MemoryRegion, 1);
@@ -278,7 +283,7 @@ int vfio_region_mmap(VFIORegion *region)
 
         region->mmaps[i].mmap = mmap(map_align, region->mmaps[i].size, prot,
                                      MAP_SHARED | MAP_FIXED,
-                                     region->vbasedev->fd,
+                                     region->fd,
                                      region->fd_offset +
                                      region->mmaps[i].offset);
         if (region->mmaps[i].mmap == MAP_FAILED) {
-- 
2.43.0


