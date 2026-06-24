Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8527ACDE001
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 15:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcPbj-0006LD-L3; Wed, 24 Jun 2026 11:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wcPbh-0006KQ-OI; Wed, 24 Jun 2026 11:33:41 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wcPbf-0005yv-TT; Wed, 24 Jun 2026 11:33:41 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OEfIcf3352447; Wed, 24 Jun 2026 08:33:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=67c2J/MYYVnSXYyaCcNixeWz59se0zxgBm4/0/sXf
 lQ=; b=m0YaxAx+hkLoLQjukEQqnsFh1YA8BIT86wjhErI6k4uoFl3Y94if4Y8Kq
 imbQDB/CQQVXc3YRslbTRQvnl7sSOUZZrfh31bZZkk4yOl5PwTISmMCOtQnzbl5d
 B/c3BIZCDieObVxeHURdKbAs823hfNLvT8FJAw7Sh3IuZ/bWcsSRbUt5UlnSxHpU
 3PNC7dxsAoN5ZzipmugoEPBVL67KHZux541gSOXor0pndqvgNteSIyQ6DeHcOc2s
 vvAQeeFUCiFXhXCDqnD/bCObPFSXDMpYr5FpfASV2fGx01PrWbMNHAw7rKasaavi
 lAa34OeHNqcnvDaH6k2kUYXE84NNQ==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021099.outbound.protection.outlook.com [40.107.208.99])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4f00gx2ca6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 08:33:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaQFb0QuG+xGBG/zvSrgpfWkkhFzpq0XhNKzkJZ37bRNZU4DxXj1k/TZdB898QzfLvTLg/Vw5VhhLZyEjH//nw6EmYRLVCs5GE3lvCXaWRwXTjz+L1ZVWFORi3zcPQJwUquCO3QX2mMO8o5IYnsZCwv3L2ivfn8/79n0y7HPadHWMnFckpeGRezP40Vysv07za7V8RMQxddFcZI0O9F0shmXKtv2YPlrxxNvFAfIIswFqckrMfYQWsBAOFwHsmhAeGIgjyKkGvcsiNiNz7VjI4SPzl/5ZWX49V5mS3s/WMbSNUBGm0Fw+RRKern+lSHqc1Pzz80/kcmCnsweEXeFJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67c2J/MYYVnSXYyaCcNixeWz59se0zxgBm4/0/sXflQ=;
 b=cDBoEoeRL3kNSqbhf2mX7rwbDg6VLaZc0xVlPcxzRI0SeFHhk+c5dhb6TS95xn9CklSsQv7M9CgZWGDNgn5I7EQi8xwUFF6OFIABVgqmCXdB+LGB2+SLME7pkoLo2YyyWYOINmzzo+hAMQHWQkOLTSve+wQ9az3ImZ4eBoGJN9uALbSum8b4LC7UBlYUdywbqhvpaE3qLB61B/ycyr1s9xorHPB6SSYX2+1R/rbfFBrSCsQLp6WOT9hGCc6eCsdCoLBw3MBaaft56SsJlCyVke25QW1WCNcAZ3k2TVhXgyGsGEGYFKurACcKUvjQOpqSsRJ2MZTb9bOlGeBc3i6qZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67c2J/MYYVnSXYyaCcNixeWz59se0zxgBm4/0/sXflQ=;
 b=CoMozl83H/5zcxVGlXeK65uFRq+0MJVsoRLW9cDPrpXyMZa/64qeSjgCaOBPKA861nPKj9D7aSwxNhRH+6c68djJ7wA/0Y591x9xcFgZfbQgI1SS8iXkYoWCrrrBxEi9HiLTBETB179Iw6sgEPe1LrDhuaqfPQwHwa0rXSE0N6M6AkEf16oxL3PtCXuz45XmZCNiZ1dtPJxDq9k0SnAIu9aZjTb5TnbbTLxqbQQTvSLZv54aTDob6hNJOBEKKYLTmYGEc/4CMawzq1kdbUCX8tnvH7BERDh3i0P65l0Ss7eQNiSUy82cGKq7dMfaK2Cg3oYx3XQePrpwMZ42mCM+pg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MWHPR02MB10474.namprd02.prod.outlook.com (2603:10b6:303:284::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 15:33:29 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0159.015; Wed, 24 Jun 2026
 15:33:29 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: alistair@alistair23.me, peter.maydell@linaro.org, kfting@nuvoton.com,
 wuhaotsh@google.com, pbonzini@redhat.com, berrange@redhat.com,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 1/2] qom: add support for array class properties
Date: Wed, 24 Jun 2026 16:32:29 +0100
Message-ID: <20260624153322.1470576-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624153322.1470576-1-mark.caveayland@nutanix.com>
References: <20260624153322.1470576-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P223CA0016.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::29) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MWHPR02MB10474:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d46feb9-b8f8-4d0f-a914-08ded205f0db
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: H8UDg+aAj1mBBRKw/cmgj/+kMhEuilyZqF7Rir6FcPcmCKiS7W7fB6ePbZMPtIu9J5KXPPz86CDJJTSGajHnJttRsLMTrpVdJfeMJr0tbjfQtJLwZjgVkawc6KHee3CVrD1L96CfKmk6hmL/YKlW97ap3VGfaVzXZZIEuoUhkahbK1oxJpCnyXnzfCv2GI9qmDfl5N5YPJ/ra6pvi4I9ZL/SnJxp76iFM34WC69RTkunq+3GhTxjimdiSVJyjm7w2IaDtR1hVeO4dfXC5HK6+5oAC4kzbQ8P+sByFFDVtK3V3rGoC2nUpYkvCjfkDH7NmX2MZdB8TIyGbPWr/LsxD0NqFsI2GCYDFeY6XrXiXP+fQWoh7AW/qkr0OwCCFftgvb1YV34vKukxLBgsR49EVIm57M3M/rlO8Av9S9k/MPxW40DqG2L1OmnpqhafBn2OQDviGVZU292Mbl0XCwCM4WCNdYmJz6Zd3r01WHgN3QUHTyiwcsjPfVd3Z2dS3l38WKtdQuTSa23Sr1EEu7DGdOLZMZdWL7fICTz3mOXaP2h5UyBANFq+ywVtvp7NRB0ZpH8HvVxiO7/4yR4/V/JhFEueJp4oZe4w9vgH3dIxvBB3QB5L8td3Ze9J3fwn6O3vfijO2CFxEC3eiEQm2IHMYGrLWTJsNpeFTJNvED/O3wI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9G9vIGbyHUSgFjEFalDJGGtdoziUytcLWsA1uzU/flh66bI+Ig+wTjtUNsM8?=
 =?us-ascii?Q?dJqcZHdbZEyhtfhb6JrFb/uhKewjl5WchOWqL3SdT8Eif30/QTEprRODy0KO?=
 =?us-ascii?Q?fLGryEe91LgqBEwybVhQMN5Xwqzm0AZwkut/oOdxOeaHkgX7JZDT+2PiQTsG?=
 =?us-ascii?Q?XZpuoSLRcmX5qA98Nrhju+JHvqT7wQm2BtAWS0k09yBrc0zRzi23QNEFKa5e?=
 =?us-ascii?Q?hfAMPYnKBlz+dFhiLSect/9LIHWoJ1HksvzqDl5rGfTwrRrxuN6Ak9oksZCr?=
 =?us-ascii?Q?UY8Sy8xLdiv+QISJFAgb/3hw0Yh9UHN+ZNpQwjsg+dlCcwCDdwBQZEripdQJ?=
 =?us-ascii?Q?FDKIyZEOSKjdnx0lf4pQiJN5kODjNzKCK9wryUyJHGmTudm05W2KGsJPRkyq?=
 =?us-ascii?Q?hOBFtLBPJcY5DRUo+MICH3869VT/fcMNEc0hrDD8xExmSEDAJCiou1zQh20y?=
 =?us-ascii?Q?AWfJKkNeOGGeLcMVgmrA1ggrKilY3dBPmQSMZNF7ZleSXP9X07idvjuwOJLA?=
 =?us-ascii?Q?/u1gRoKt8UMQ5tqFomF4mP3/qKzv+hOSGfmBn6DQBHX+06yBBZHRjm2SOTNt?=
 =?us-ascii?Q?Tvk1c7Rl+yyZWsVzuLnF82D16l1hfxtiHH9b4WoEOEtRq379mc9wxdRTy5ox?=
 =?us-ascii?Q?GX7B/9zvxGmhPHDxIdv9KCYMvbUUAEy+OF4H5KNc/uP+2jN8LOwKGnME8dqa?=
 =?us-ascii?Q?FKwJ4dO/9PWjG4C1cRzNtPL02UmOGNVFtLy3HIq+98gSkG+jMeREhj/VE2sx?=
 =?us-ascii?Q?78Gl3h8uEKN8hk7Wr5ivPx1vHqgnRkgg7M5rqx9sdb08fQDGYuIfo4DjzZcA?=
 =?us-ascii?Q?YQOome/XEFSDWlfF4/FZ/1mKtA9c/4/7SkGZc8oMOhEpicOu85zm31RS+MIF?=
 =?us-ascii?Q?gBNDDpTv7VYdHi/yz6SAMQZkAJmicxPGJuxeC+idmjiO0GF+sdf9wMaSuNq5?=
 =?us-ascii?Q?pKubqKeEQpOHZ2/CIV6pZEOhwb8vSWAE9PiTUENGM2MVPhyQE3mK1hGsw/8a?=
 =?us-ascii?Q?IyR2jlSpFmb6TKq4FsGcDLa3/VNbxSX9ZYZlFG/mzvKZw8+wwwXcecVGNmbs?=
 =?us-ascii?Q?sUS5OFqMaGO1qJOSae5sj/nYKxNSwKvFYOC9DNbmfA/EauFklKQhgTwUprZy?=
 =?us-ascii?Q?LnLuhqdXRHufvqxslhJkTvjEzpeT1AqMYAgFWvf5yPVI7QA3QqvUy//xchsT?=
 =?us-ascii?Q?B/IjWlMNBZfSBLV6deFaqvn/UnYKpzRZJDOBRe3yuf0NNK9+s1RekEN4AvJi?=
 =?us-ascii?Q?sx1EQfEdi4mQs5xtdvPj7GJhLWZH8lbe+sQdHj2fVrYfqehki3YQNzh5obV5?=
 =?us-ascii?Q?7U7lGi+Hn+ZQkqgWsGzHRvgxHJE9iGAVS9kkrHy5FmDufgBhqFRqI7AbmRLD?=
 =?us-ascii?Q?J/ymHP3dCSmqWuI54gRC271dEwFC0YNJ6ta9Y2NChxx4pe+y2bTM+a3bP3N2?=
 =?us-ascii?Q?AL3ilgf3jN8OVk8ANuo6TGz/psCYQEdfnGYCTrNjveQv7KeHB0cl5I1JZlN0?=
 =?us-ascii?Q?LytHCaZHIIq4UIljwrnja+pR9fQGc1cpU5t3eA5qUUw2NjZ9g3t3P0XJQvzY?=
 =?us-ascii?Q?Y8XAK6vUAZsfxrrCSJxBbSvC7+bhpRif3vwFafixRsCE5qlLtk4+xZqkSyXR?=
 =?us-ascii?Q?1x9S5RpPGHKUnL77Dp8Kk/PK3IjDK/8hdb9Tm9hg0E2p7R3QXGcnF+haMaI/?=
 =?us-ascii?Q?oHZCV4OWtoUVAWBSJWzCyI7CtnXmVVtg91In48afxY6JoPqZpjsUgKkFkvJu?=
 =?us-ascii?Q?d0TENLZ/LyiJ2B2dhzr9cTsz+56tuKs=3D?=
X-Exchange-RoutingPolicyChecked: ibYDBmLkAmZAUXaKxo6H11ihjpdAZygnD26WJS4Sc/Cfredi5NGUs8YT0Wr1VIk1qE68pV/hH+k4Z48OCUcPzNtMPAmtxuvU2ODKkZJOhGEvFd+rmUCCzzayyEsKnurr7gN2F3Szios6nfH5VeE3nazaS3TgOg008ZsiGwtDaUg/yY1HLnmuHmLBGzvhyVOGHtD2NKMtU4peAM/aBDvrvl3zh4FY6cq3/N5WVMQM4TXTjDGqw7hofmwesg+u6loc7ZehY6osyCxGzF/tNb3KaeO056ei5wBgZp4q2dp9cO3hwuS+YXq9SG3Ane3bvIKsbi11G/rs9fHMXBFlLQJAfw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d46feb9-b8f8-4d0f-a914-08ded205f0db
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 15:33:29.1420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8DlI0CPbEGxrnbbWFYJneR1USur3MyaZUWKLXwZUFmITPD28ihV6ZpuuUGnSZYA5hYnlF9tsEjszKwpZbpzk0DLOCjGdlm3pZl/z7Aet0Pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10474
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDEzMCBTYWx0ZWRfX14AKR054Yhd0
 KjB9BkKcZlwK3zZmI/BXtONUYqOjHjmP0oOvbtbRIGQbrXWlEwnekdEPJH9w1VZmmx4RzmG2MzE
 nM0H1cMFntohzMD1uOV11ILpQ7B+euU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDEzMCBTYWx0ZWRfX8VvYYQOZ8VaV
 9V/dWVYuUUim/tMXAjAimVASfbL5LUeDDKerzDrO+Ir0HewkSFm/7vLHr39uuRxbX+LudY4kwZq
 1qIZnlr0pkoCUXIb74A/iA8mdyCd4Cyq2sjyL7rjS+Da9ZVjKVdVAFN8z1lu9Q0JsOP5UvB4f1W
 S9dwolhEcgr8XgicY1mp9nZ4b0qJ3aJEcghVEdby8wVBKd6QeD+wWgnOCZDJ4xvPR6Lv25rlfoI
 enzCgBJW/mlpmDrnlyVw02k57GWp7R/ShC48W5e3FwUAfAVpU57QUsvzgQk5/bc1q3uZk57zq8A
 ckw8RPHKI5sMHHFMnta0pQb6nu29RSD+oDnqf+h78/kQxY3tRbNwA1y9rTKm+PgQn7mC4SisGkr
 kKVQePncF+y+jnFXHs6b8HPqMkQCbN071189p3f29exhfuBMr6v9OOJDI26G56rHmjuCJOyOQuS
 qCyNjkiIT8GBbb11paQ==
X-Proofpoint-ORIG-GUID: IZ710MDnllzBf9dtHUfGe4n_NkpH_DmD
X-Authority-Analysis: v=2.4 cv=EMQ2FVZC c=1 sm=1 tr=0 ts=6a3bf8cb cx=c_pps
 a=gvdBbcfKwwW3/oSCzHqKfA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=NyHBrXykyrDvTx_2r8EA:9
X-Proofpoint-GUID: IZ710MDnllzBf9dtHUfGe4n_NkpH_DmD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

These will be required for the upcoming conversions of object properties to
class properties.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 qom/object.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/qom/object.c b/qom/object.c
index 0ac201de4c..204871cb53 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1411,6 +1411,33 @@ object_class_property_add(ObjectClass *klass,
                           void *opaque)
 {
     ObjectProperty *prop;
+    size_t name_len = strlen(name);
+
+    if (name_len >= 3 && !memcmp(name + name_len - 3, "[*]", 4)) {
+        int i;
+        ObjectProperty *ret = NULL;
+        char *name_no_array = g_strdup(name);
+
+        name_no_array[name_len - 3] = '\0';
+        for (i = 0; i < INT16_MAX; ++i) {
+            char *full_name = g_strdup_printf("%s[%d]", name_no_array, i);
+
+            if (object_class_property_find(klass, full_name)) {
+                g_free(full_name);
+                continue;
+            }
+
+            ret = object_class_property_add(klass, full_name, type, get, set,
+                                            release, opaque);
+            g_free(full_name);
+            if (ret) {
+                break;
+            }
+        }
+        g_free(name_no_array);
+        assert(ret);
+        return ret;
+    }
 
     assert(!object_class_property_find(klass, name));
 
-- 
2.43.0


