Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AB9C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 15:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzy8I-0002pj-C8; Fri, 28 Aug 2026 11:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzy7R-0002TX-HW
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:03:49 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzy7P-0008NA-JY
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:03:49 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SDTNLf2742375; Fri, 28 Aug 2026 08:03:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=aW/nC4zDpQcdr6eaGap2Cg9m1Sv3pIsqKmLl+1r3o
 eg=; b=baFUZq5j+TeuYy+FYXAXRlOuK94TPWqmGpB2VXybPlzwaa18tM0oNC8Tw
 EOgra/teMQP3NzXjbpLT0mGJhzkAq91BpgZkXB+GJ2+3v1n1k+nx2eX0FcUniVn1
 OpTZjhg4h1y+fyupUxJq0WsmWqZd/yCeJTI7OcRpFOHqlaHAPm9j5xZ1TdB/NsQz
 03f2i9t40zx3Hl8Cek987hbc3AOX1iy7XorZ0Lsk+gnUQ7nM2R0SbLwIkQ/k0f49
 xjlke3pMMPqjsIl7qNtqSi4ZeZQZziWwUf6vdfW/tYNk4E/BgaTL1XAD4QPaVGcu
 2+B7c8dM2E0XXtJLKGEsqIv/JJNhA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021109.outbound.protection.outlook.com
 [40.93.194.109])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gaq9uu6bh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 28 Aug 2026 08:03:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHhi+FYt+U1vKmifHYa45a/y2JMUmu69YPmCpFaCry1Ahx6j4L3B674AhRVR7ofb30D/lb7TzoUeBey3TcF/Yojk7PojmrTxseLcf33h9hfSYdv4kIbc9jzwLCNihEKww8hNx309z1OEILUKOOiwgv5GR9SADzSqyt8KukeA4a5V2WjXuiCF592cEWdJ4w3kdgQRXF3g8LVHqoHbADApCjKFlVSRZqjh6+Jm1xBYxhucZEXWI3LzdXxBQH9dYaog/uLYtdYYKKSqUQzTwrI8TrBdyjnEu9EOV1wQ8HDHrkgs45Na5kbSwX/wOVPt7KPHDQ02n4h1kbST4H3kc2WymA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aW/nC4zDpQcdr6eaGap2Cg9m1Sv3pIsqKmLl+1r3oeg=;
 b=KlMsvspI4uA+1ErS4IbSmG3D13sGl5DP7WjNf7xTCKb3zREQG+or1HBkm5SEWz7cb0UskBq04EETMMSAw7+9xNLipve1maL9kxuPOoiTcBhyQjNekTCAi4Ho/1mOJv28GYIHdQbsf4pVG14jF1jxcAW30WYseisL5BhnVwiT6RG+NveVW1kxHU6QWiRfwA0B65sQdCbm8cLLW2Btl88X2JVxEBXFYdQEySsnkAnBlIDglMeurzx0kFjLKNxgOQKxgqiHoaawrY0tQ9mqHKI+bn26IApLlCOz6ARIxnyVtfCwCjts/6+Hdt7Ds6LPJqqTQOhYPRMJySm6cps6qcjmEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aW/nC4zDpQcdr6eaGap2Cg9m1Sv3pIsqKmLl+1r3oeg=;
 b=G1RyzIJHZjPrC02EtoELY0rBbWBDtacAhzel99PtugmFDZbZAqPuWL2BfWz2iIqTmV8lPpKjJDkLCYSRfywbuk6Hv8E9a/ZrhsuxPqqTLi98W1q0dlt50rb0jDLh725Ebhr/6bCti5H8llMZ+NQTQUa8YD/TSNRRwxMWoQZPsx1NCvoQo1LSv2n5PPSvNpxMJiHPXZmojUiqV2F1VT6P07AFgNu88+NXjryf75DixoMFFJgQ8KO6BeHYfIyyP4D8CNSfgBcW0pmVPtMPIHQeT7f5d3bpHU//YxFmFzzzUFpRKHYIwEfHYNVnPpaSvxH0B8nn4jNiOXmoMhq4T0Uv8A==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DM4PR02MB8909.namprd02.prod.outlook.com (2603:10b6:8:b5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.9; Fri, 28 Aug
 2026 15:03:43 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 15:03:41 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 7/8] hw/i386/pc_sysfw.c: convert pflash0 and pflash1 object
 props to class props
Date: Fri, 28 Aug 2026 16:02:03 +0100
Message-ID: <20260828150313.1883999-8-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828150313.1883999-1-mark.caveayland@nutanix.com>
References: <20260828150313.1883999-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0053.namprd13.prod.outlook.com
 (2603:10b6:806:22::28) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DM4PR02MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: 9333d895-daa8-4cb1-3e8b-08df05158bca
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zl9Nja+w/a6cZvEtJ+/2J9X2x2GXFpKPJlBHsOzioT3Cg6dqjrfwxkaUkob1FX6A+wzBJEZRGTtpLY9tREudodHAIgU+AWg8Oev9z7x/NKWwaKS6U5EKmHTHiggQTJ1wUkTJxYr2QbsaHJU2tyf68fZmTnWYv5AOExjAFs4g/vOG521KWitO411MTnRpxXt78Gx2gDfTH7Qezy6ePoZ7KJrcys1Trydorrd6NiCFLipcnDuf41F6TeiEvKDRKTqYG9T5lPjqWT4F2WHnGOpmubWSEbWY8Qa3nVuCLDHlJW62S9Ori7YZM0vzsheu8xpFujtorVHE30PrAlDnA34BFYJZgK1pLa/fXaDz9cuMpb/NITjFDId2P5z1bvmM685HvPGWbA3YAbc8Oi8iyM2T52QCannvhSs5ZWvoWKqPLD5xgtOtlqG4CeOUzChqgXapc0z3HE+5sQjwDAITKnKd2nHXlI3H4zD6SQtohUWZ7S+aMQb+MFhwk4YXoUOZWcgXcKsqN+dSYwwvgtu+p7nW2ILRjJkZup4WLJQi1ucobE8qPYU0fGm+/Zpq4SnR54Q9LzisqBQ5GBubWyiDr5YtXqptVb680tpS9NzsQ6ROtTdBoFO+8XWCFg1OvieDQZrNaZYIYNqcIfxtg2RQL0zY1Q8vpmRt4fpuOqhZ/Jg2qXE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QXAgwt0R7xyTvBTTQs477bdWnBohQE9TPTjhi1vDtgbehl0YNW7Ez0JUxJqt?=
 =?us-ascii?Q?R++bH4eJi0PtjPa2Jv+t/QmbkRVDaS2dGGRB+P83GJGCYh5MuUtlPqMq5yqi?=
 =?us-ascii?Q?3KYvyBkrCg/djFsSZjq6kfaHMf3akUtj957NHe4g4+BU8pZBeTpFc3+X3A1e?=
 =?us-ascii?Q?z4E5nwcJLAGz9rDezbl53NZk8+kv8uksiIV629XnbT6Ba9Yy2w/05/xbt2uv?=
 =?us-ascii?Q?xCrvd5A4wj1Ipc96TOMc5bEi3XLTPTvtd9ddl3EWOvCspXoiTXBXkwc7117y?=
 =?us-ascii?Q?PMVsJbp1tot9Is4E6nnCbOJCd2j/CNSWe2P2Smv2nu4VkvHcST1KNq62NRMx?=
 =?us-ascii?Q?buePtlcy69pyhmKlEwo0L13xzPfntiGGZUhQSoaGR16iF682avBvUXVAyph9?=
 =?us-ascii?Q?n5ruCO+5/OA8L7pnN0NEy5ZOWzISB1i1CRjfrhpvyJn+OhDb69nvv0P5W78d?=
 =?us-ascii?Q?EClPU8eGKq8Q69QAlPUv8X2khJc0NIxpeL7LXhXS+K+rAxrXE10+hn1H+18i?=
 =?us-ascii?Q?kA12aWW8jzooK/M6I5WmZxN9dULJmJe03UzDRKs1wj5yGMhTZFVRKQlBC54q?=
 =?us-ascii?Q?zvEpVOC2OyHALBU5YltSX8m6soCKD14P9ccdcPbrIfhrlnvdr2Lv64Y6dQhr?=
 =?us-ascii?Q?2XfcPCVmK3JH7beH9xFwY3QffC22IJawbnvSf7+jjvaTKCFjbFW26W8VJtt8?=
 =?us-ascii?Q?HiklEq+qlM8cTFhMWzsKZrm1qhRaOIzv72rdqXck1q4lS83ymmqG4V8bmh53?=
 =?us-ascii?Q?pZilsEv80bbmg/X34sf3QoZuGiels1K9buuLRMaJZY86mSyK506yfs3xpzSM?=
 =?us-ascii?Q?87yEfjwftaceBCzgFONzWLvQNz0h1PEYJGJEfPv/r7jJUllNKB8VI/l73LhP?=
 =?us-ascii?Q?l0PvcMAZC8VWZqPJipDzY02HUyfBXc7UYsgPwjEJZq8tj4A9k7ir/8Qgb9kd?=
 =?us-ascii?Q?y6GBEfybxZcnAj3M2Q+48lJa2SMiPwq37n8o9tXtXPhtMuxVlpc3MFQFhT4T?=
 =?us-ascii?Q?BwPRIjmXpVQh/103m5P6zBnpZaZpaT9cGj9TlHYHL7a0xL5fSrlC6bk1o7oe?=
 =?us-ascii?Q?zEDBjpQDMpVI09T/zpt0Etioehe1sC11xi2RimS/d9XFYvAZYioC5I3hxwdk?=
 =?us-ascii?Q?Khq3qQEO71DrSTR9BINXUvgg0Xrf5NVaH1792ib4KOKzoxDBslHPmbNLsJgO?=
 =?us-ascii?Q?/N7U0EHY3Ps6lor50SsONjBIdFZJgCtH2FVz0U715g2RAVPmAiVVAFCp3XhZ?=
 =?us-ascii?Q?PrY3qEdDKxJ7lUZhoe0UZPsTR9TdI3dvv7EqhKCif5UIHhxNIg/QEGNku9/W?=
 =?us-ascii?Q?Njr84RfXyetUwW6EIDqfHvBG98PXxaFPH68LpwDpE/JVzdx2R2okDZGLlkSP?=
 =?us-ascii?Q?d7VIhaK0Deoq8udZVpp/uW7Aq4sJ03fg8HQGC+tZCwwTJjRZIlSv1PO7TRST?=
 =?us-ascii?Q?9R1tn9LT67/6GSQ5xM5Y7CE+APIy8dKirGSRmyVQcSw84cJ09g17TWP6JQ2R?=
 =?us-ascii?Q?9tpETHTd53DwH1EGJL3DaJtqpUxSAqcUpNfEingaoak/+1kDZlKMnxiYEizA?=
 =?us-ascii?Q?a775Rksj/j/lXpoYBqZmoR/dkkMAE/Gp5gRbF3vC/Eai4swohJ/qypC+aiAp?=
 =?us-ascii?Q?2KFTjYKV84QO7pmTnX9Gg8A+yvXo1u9EEerDrH7Djsjcz7bbXbBQ0oKaezLg?=
 =?us-ascii?Q?Ni94hDd39Jv8ZOGz4LTb+AarPYa2MRdAFxyIxiQ0ZtUvrLTPwNqbcUqxM/bK?=
 =?us-ascii?Q?EJ9A7mJXmKk69V+r7ZYz04ZKpAq62pE=3D?=
X-Exchange-RoutingPolicyChecked: hlqN0pDSW3NsFNjVh0bmj4Unm/g/Zn9ZdhzU43Ifr9z5meDFR9awRrq+dBxqfH0QteUqdAIp3hiBZU3dUvS6hRcB9oOBm/5VqOX2M0ceCSQQg5OUpy71Or3rm1e1uzmuXhr6fWdFHZ9MuZ+3JX+F7WJYUVFjuypBOjMCQ4Kbzc0Xf7xylgv/VjGl78tlNQO8wNOUp+UZuYPnX8WL6rLxYzsiM1/9zHLWztJ73bT82BtfHB3t9Z171KS2DKLmfgqpukX24pXoU4qM1rxHLLoMY4IaLZ6WEjT9iGNDGheSgQRdwba0v86xcvvnxDgSMOluVD8nz7D+NYRXVcepq5t8oA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9333d895-daa8-4cb1-3e8b-08df05158bca
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 15:03:41.1229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hpMSzPkW56No+ibp+UsguSrytHc4JtJxemyPMq2c4mbRioObQbn/Fa2o+SVXNNYmPExbwd3CqB6rRKt9DTDCI6xMDGTXaZru1uJ1w5XOFKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB8909
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzMSBTYWx0ZWRfX3FX29omUufuJ
 UtLJHsYHJD0EQsGTlUvUQ0cWU01CigvZbRpnTHFmakndUxOrruQ1X0V5LVFwU7B+3DTKzY7tFVm
 63AuS4agcU4IvC46DaXWKaKXB50LNfBrlK25B4jlh6k5FZRWCUp+QIz60oC/I6NRn+FCuJNyPMN
 05w64IzeR66+sK2wSrxcogs4EkR/a8kMbDX28wHmRYAT2FzFV+VBFCQEATB4Api7C2yw24rfMsQ
 RHGoLSr8J1qe7czoI/mwJAwxDtSCw/Tdz7lLIILUnp3pCW9NkuMdwpYEOSJ8L88tr8/2pakPDUq
 n/exPfTuoiBoa1Uha+twNCi6Iy070bj36MOCLfDsIh+lAr1h68694CFPFASnYo6j0h+zC5GY4gL
 wDF0aS/JmaZGtt0ODuG3nBsXaUsZmRHva4ScCtWNAiRTQvFmZ/z5LUpw6MNmhaDQvo1kSpwJFoQ
 pCHnj6kp5m17HkAiE5A==
X-Authority-Analysis: v=2.4 cv=ONQXGyaB c=1 sm=1 tr=0 ts=6a91a351 cx=c_pps
 a=mU+v3NmKB8T18PSzrq+lTA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=S-zgNAOA6Wav9BD39pcA:9
X-Proofpoint-GUID: DjPNvcBsLiSeGxwt6fZMcAF2CW0olMTU
X-Proofpoint-ORIG-GUID: DjPNvcBsLiSeGxwt6fZMcAF2CW0olMTU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzMSBTYWx0ZWRfX0PDcp3zNqhu3
 6jauDShwq+1XPi9ta80glKvcdi2hKf6W6vDGtl5gQwy6QIC1zgBuOyaJp1SWhQdOd60I0v950rx
 8JmA0DCgRgK7/jSeGj2Px/rL992oC+g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now that the pflash0 and pflash1 machine properties are class properties, if
they are unspecified then QOM returns an empty string as opposed to returning
a property not found error.

Before this patch:

$ ./build/qemu-system-x86_64 -M q35 -monitor stdio
QEMU 11.1.50 monitor - type 'help' for more information
(qemu) qom-get /machine pflash0
Error: Property 'pc-q35-11.1-machine.pflash0' not found

After this patch:

$ ./build/qemu-system-x86_64 -M q35 -monitor stdio
QEMU 11.1.50 monitor - type 'help' for more information
(qemu) qom-get /machine pflash0
""

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/i386/pc.h | 2 ++
 hw/i386/pc.c         | 8 ++++++++
 hw/i386/pc_sysfw.c   | 7 +------
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 0b925ccd8f..8369263691 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -40,6 +40,8 @@ typedef struct PCMachineState {
 
     Object *alias_pcspk;
     Object *alias_rtc_time;
+    Object *alias_pflash0;
+    Object *alias_pflash1;
 
     /* Configuration options: */
     uint64_t max_ram_below_4g;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 876ebaadb8..ddb75a2ec0 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1800,6 +1800,14 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
                                    offsetof(X86MachineState, acpi_dev),
                                    object_property_allow_set_link,
                                    OBJ_PROP_LINK_STRONG);
+    object_class_property_add_alias(oc, "pflash0",
+                                    offsetof(PCMachineState, alias_pflash0),
+                                    TYPE_PFLASH_CFI01,
+                                    "drive");
+    object_class_property_add_alias(oc, "pflash1",
+                                    offsetof(PCMachineState, alias_pflash1),
+                                    TYPE_PFLASH_CFI01,
+                                    "drive");
 }
 
 static const TypeInfo pc_machine_info = {
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 1a41a5972b..441e777191 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -85,8 +85,7 @@ static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
     qdev_prop_set_uint8(dev, "width", 1);
     qdev_prop_set_string(dev, "name", name);
     object_property_add_child(OBJECT(pcms), name, OBJECT(dev));
-    object_property_add_alias(OBJECT(pcms), alias_prop_name,
-                              OBJECT(dev), "drive");
+    object_property_set_alias(OBJECT(pcms), alias_prop_name, OBJECT(dev));
     /*
      * The returned reference is tied to the child property and
      * will be removed with object_unparent.
@@ -109,16 +108,12 @@ void pc_system_flash_create(PCMachineState *pcms)
 
 void pc_system_flash_cleanup_unused(PCMachineState *pcms)
 {
-    char *prop_name;
     int i;
 
     assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled);
 
     for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
         if (!qdev_is_realized(DEVICE(pcms->flash[i]))) {
-            prop_name = g_strdup_printf("pflash%d", i);
-            object_property_del(OBJECT(pcms), prop_name);
-            g_free(prop_name);
             object_unparent(OBJECT(pcms->flash[i]));
             pcms->flash[i] = NULL;
         }
-- 
2.43.0


