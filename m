Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348BAC44501
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 11:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viWCQ-0006Un-6t; Wed, 21 Jan 2026 06:16:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1viWC5-0006Be-Us
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:16:14 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1viWC4-0004SS-AF
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:16:13 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60L33R2E431317; Wed, 21 Jan 2026 03:16:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=+Oa+TFzcoCq3TGy
 8eikM7J7dMHK2xDlHWL8aL2n9aSM=; b=W5+pazSjpUXU/ripb/GTUZMXBA9MjQ1
 ScRoE4nQpWqSLNF2YUwU/7iYibIUZCNuxT7BBxwZ3pyp/quJ21ZJrQ5vjklERN8G
 zWm4y95fUWVSuTAGzTnq+XQzAZ9m7cmTVMiDzcWc/Y7aVYc4slVV7K8F0WORznCT
 S5tRawbs/Cb+qtKyFnEDJipJoeuHRXcNic9HZKP6rml2x2q10bosiICVqLFjaKxc
 L1roz5kLmPISTvkX9S1BHZFsyG5ZgRI8DfvCgPYRHoQ5pBoxWBpbMxraJAB/Ia8I
 3t11SomV7XnSK6vTKxAxrTLUOWD7ohe9JO7Mq5j0tcaKq77vuDfc+5Q==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023129.outbound.protection.outlook.com
 [40.107.201.129])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4btde62dvm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 21 Jan 2026 03:16:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJAyj3NzFvumuO4Sf9yukTZYcMJ1gKd/NMfMxwN0Y6ms6/+Pmt2yPyzF9My9UdZzI1ewMSI3YtBkXv2E4O8fTv35o0/91G3Jreyg2CEt0MDvCgVkLZvfYq7DpmxK4ebE7gndDRux4w0yRvs0MiMAPFyXHMiOWjeFR3AjumWEs9eerAt0VEW7gNemUNM9O2LJR/ydWc/fGkS1B/AYwRP4uzCy6r5omaTEaIRtk089FapI7QTAKmYpvmrDpmq53SNOmxMhoFkV/EvJNtlrcRVCvEuq6AMoRuRl50cR2t0eP3z6JlyAWJxeZVJgq1/P/Luqhw5XIFjijxzmLYdR5qs6pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Oa+TFzcoCq3TGy8eikM7J7dMHK2xDlHWL8aL2n9aSM=;
 b=QBkSPDc/9drTIJOeJSveSYG+9+W0lVY6cJvzfgIavT+Y2SqC6rm/FWHJIRtv0DaEASpexAPod0XHIlrYphKGHdWWlx2nYJ5cHEpPeaid9OehGGDBzaMoykpkBEi+pHGEDNrut3cLbH5rROYmR6qAWKNJHsizyo0dpZQRKgzAAwjlUF1LLFqFXE3m/SOVir0ag0kU/Z53ROfEd8yze7VLH+aZywbrEqFWT5BqeqltXey674dWZee1Vn2QWG5GE3ZNpANm6J3mzdoOttbSxoTdQ6Y8EwRZFLWExOArzkwhvXg3ew3g42jEYhZI/UKJ83Z6IBww6s8PTEEvXHgfUR/rLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Oa+TFzcoCq3TGy8eikM7J7dMHK2xDlHWL8aL2n9aSM=;
 b=S4ECgfEeyYoVFaZBztJ+a2a0VEcGUEmWWGAnZXiKijHe2o4bPy8r5PbU0k+jY3Zt0+Ba6bKOb3I7HutJts/xqOjnFZz4BmiLtK+62nrkhEDDk1/moGaj94UGcK8ZlZAth/HA21I9tO9Lau9uFP0Wz3UyKaTATDbrbaG297t+ZbLckEoHHGbcjF3yZSrSY5ekngfp1SmQ0SzVuex3/gcCpoAPyt5b8S735FOEZ0VwzPEkkBpfdKLW/hJmckLbNPSbv6uTvf8Pa18CK2fsYEZ0of751knGnDFFDS2acbijquztsEYMKSNwf1oysytkt8t/sOIqbyF8Ijkp1pF7ppGXXQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DS0PR02MB9369.namprd02.prod.outlook.com (2603:10b6:8:14b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 11:16:07 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887%6]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 11:16:07 +0000
Date: Wed, 21 Jan 2026 11:16:03 +0000
From: John Levon <john.levon@nutanix.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: clg@redhat.com, thanos.makatos@nutanix.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] vfio-user: fix VFIO_PROXY_USE_MULTI constant value
Message-ID: <aXC1c7ff7Otv8yke@lent>
References: <20260121110055.2333711-1-mark.caveayland@nutanix.com>
 <20260121110055.2333711-2-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121110055.2333711-2-mark.caveayland@nutanix.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM0PR02CA0180.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::17) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DS0PR02MB9369:EE_
X-MS-Office365-Filtering-Correlation-Id: aeee82b9-6aad-4ab4-88ce-08de58de78fe
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A7MiBilsk9hLkJ3pW8DuwFqzz8OqhayALZydU0kK9ZD2KeCIuoTjS3C2ISWE?=
 =?us-ascii?Q?4k/eQcBMZd0hREdceumNy0OzUgTKExMRnx1fZJlIpWbqgPkpf9HRAwnXgp20?=
 =?us-ascii?Q?4N198J+ihqo+kzvVCbrb/4wiwKXCTVSf/os31gq7q73fC65VFPPMhRRfSqXO?=
 =?us-ascii?Q?JOdgnLZnbBpigB9T2bHiOba4+jkPbuR9IfXkPL5dx31ZCQxm5dSg58nhXP8Y?=
 =?us-ascii?Q?mei0M4oqAu0eCSKhfU0BkxM7Th7T9uxmq/3EZxI6D6otgetcNvlZ7sBv640z?=
 =?us-ascii?Q?uURh0lHAUgKpKtcf3L5gBkKlcc/KzCxQ5nifeHcEZ4LCXLuRtXqo6sI69cRn?=
 =?us-ascii?Q?b4mF/16vZ7MWpclKWJ96qG8bADrLEO1B3fT1EUuDbtqcX4yzhcswuUGdsJDH?=
 =?us-ascii?Q?c3xsg0OnyDcuCoRbWmZM5Y5IoQtZNXWQidnyygRnjOgZp+Bas0FrMAnCRUSQ?=
 =?us-ascii?Q?NSW9kzibzgXpt8+9WO5GUTODLgi6Bh+zwUPzZer1NanWTbOJuVX62P2gxa14?=
 =?us-ascii?Q?3zI01fq0s2Wp1b9vPgcqwu/qc2Klde+sHDCSE39vov5VlafpdxH949fx92YK?=
 =?us-ascii?Q?6zCZQhGXyj3MWAvXZjoTigFu+aXgyo7WFz6O+Ga54OOgw7x5A75xzdRv8+ie?=
 =?us-ascii?Q?12h2ucZj82QhI40m2tprg1Y9OOgzUy3lV9vQPyiFz0ZdUTsUB8x2E1DtnCg3?=
 =?us-ascii?Q?Fy6PaHOKT+hJ8T49mXf2YA9Rkgn0WAu/wei9A3Zr80OVQ1Hb2G/Mp/h/8nFa?=
 =?us-ascii?Q?PnwdD94pWsWQCrizqp1hQpKb6xXKiHWuw4rJJhMWvvZmCFxmFiJgI8v3CucJ?=
 =?us-ascii?Q?ZYfq+XdeDUfMc4gH/ZYwMYkyQybA+Z7yryQtSX+j3FvZ74JxNyp+i5wP6Lqx?=
 =?us-ascii?Q?clUq+Pr5TowrZtqU9uFu8EgONOMMhXa3sA5iWc3FQhRQIbSv5yCQklkMOW7B?=
 =?us-ascii?Q?1Bs32mc6iZEys0Uwp4b6TPDeYx77TrzUFQyjeHjFAv23BbuBC1tEbUCm0P7B?=
 =?us-ascii?Q?NgWzk2USqbBf+1k7E/P4ywNSA4cvCichw+aNkvzTebNHzkyBlhNj/+6HGNES?=
 =?us-ascii?Q?ofObeI+4EEbgmnOJd/QrrIY43et0s6fATMD3bBK3vTWJaeCqw55yGaxygzeG?=
 =?us-ascii?Q?5YlfEwQzsd2AkCxekaOXu4yNSZb88BBmTTrqij4AWQfxcAyypopvPngCpRoV?=
 =?us-ascii?Q?3/pFIIlWwwUPxsG6sbRRdQBvN9YrXQKo+bRoog6NGYLAUrgNVHnWMjL5aqdF?=
 =?us-ascii?Q?7ys5HLjLyox2JyGgbIERhdMHgaff7BeA/6p83i9xWytae6Tj66+NdNeQpVkj?=
 =?us-ascii?Q?FBqRCqEHD4eIoB1oEoM87IwFJ6ztPoxgjSM/YmquYYt+sdhGtSOfkCIPp8EZ?=
 =?us-ascii?Q?sbd2rC4r4RK+0tqfp4RLex9atDnDJUcWMQZtLfBcTVXCt0RRrFFxb/2rchMh?=
 =?us-ascii?Q?X2/JTyoxz33TjdkYxmKTG513msHVLKC7+pCQtYQVC13MGTSisIouBOPRf7jX?=
 =?us-ascii?Q?5ydMpoiiWIerLCSKl5h0yzKHtsJ6QsL9SV8mYOO16FHC7th3h0BAlwSZgV1N?=
 =?us-ascii?Q?AWp4KDkIsz+SdXFaKjI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6govKqe+lUwwoAHbybQpEPnQhm00NYQmC7qp05vYNU4ts8Ly24pqXU0Okchl?=
 =?us-ascii?Q?7yUjQQdDZSloiwvpxSzUCnBuzROYUtQWKALudBonRlx3zywHt1F7ThrrVgsE?=
 =?us-ascii?Q?GfHoGYDR8feIF1unpuljnlkhxMRfwZMkhskTxQunmV/NMizfzuXjuQeLckO4?=
 =?us-ascii?Q?8Q0sgyQbr9jpxndkgnYRxbUTMDp+55fzK4lhXitUItC+Jim1HktmttTESZWZ?=
 =?us-ascii?Q?59qDu3K+7gSCaYa14xOPaK9nOThrl4+c4tqfUDORXRQO28s8VchBWH07dcPX?=
 =?us-ascii?Q?jqwbcjH6Ha10u9iI1g+20vClFjztLna4TxPkHPWcdIf5eE1/jZq6fZkM1+mB?=
 =?us-ascii?Q?ADgfo5mVN6sLM1zCGvJj2xhjCQw75BHLLh3yI/DKYB7mpBMtfjKb8SkaiiRL?=
 =?us-ascii?Q?MlKF58/3byrfVC7TqwidoBwszgz4NG5P+tqlWTwCmlVHXAgkHEBy1yyytU9Y?=
 =?us-ascii?Q?8+E4szdU2jahlrYGP96TyXD0ZLXH0HyzH43QtopxeX7QUCiE/1U/y5RdCt6o?=
 =?us-ascii?Q?ig1TZhtSn1wT6A/VWbmp/fKaGxqvFiP4NsoyetOQjicPVC5BZEltvPDBRKsv?=
 =?us-ascii?Q?cpqBBWpqyBMjqBLuwJSLBc6he8K8wDbguwzCW9JgLDIPV34Dx927SubIQXiG?=
 =?us-ascii?Q?nxmP35NKguvsWbHgHSl5htK7D3mYzn4jaffuvsdZare97Ekiw9vR3/GrTHQG?=
 =?us-ascii?Q?fC5tDG3nR5umiY4X2+C+2s6/4yB9uUe4uhD2mDoG4ma4gPJ9nZ3aXnkc6nlG?=
 =?us-ascii?Q?n+1H2ANWd2vNPdPe8yya682OOhbrxKxH1NbDI1r1oSzGVGPv/yRWC/WyHSM0?=
 =?us-ascii?Q?AvYiICe1fxkFIoTYDUj2ag0a9EXQb72EiF4g1RenMqDOP6aQ/aMbrTSeWgdJ?=
 =?us-ascii?Q?Ju9OZfSnTV7eTlRrwZw6q0ym/9oQzfP37EwU4BNoM0jpVFYogABrxtAYsfzd?=
 =?us-ascii?Q?901+1WAOWg0wSMsZml4lTYyWlVuVR7p40jf6jN994qVZA5iBRGpXvb6Fjp+T?=
 =?us-ascii?Q?lf5uVbwZnR8VJR0kx9KYUfE+kJCpIhRybgTQX0ceqFa1YQBLroY7a2JTgSYB?=
 =?us-ascii?Q?Qhl4hPVeHYc7VYP/jla3r6dwDCU4jlHsDevQuwv/XptfVFIOvgD53firYydl?=
 =?us-ascii?Q?BCfvNeG6CobrYLUu19CyUD01EjvDwqQKl6N6C3MXfunXQdyszNLE52vh1tIS?=
 =?us-ascii?Q?zwJ9lXZyglbseLRsbtCi+1n9Dg4u/2KyiVuI6iQC+cylBUhANYU1694dqJM9?=
 =?us-ascii?Q?OSGaQZKnBfOWyDhteQoP+vBwyjYb2gsVjTj1SxW1cczDMqeU7yjt7pHPU5Pk?=
 =?us-ascii?Q?bnkV8f8PptErUpbDTFWQik0bEv16wg2gqMs2HH/npB5f1Pju52Hdtz4DDA0h?=
 =?us-ascii?Q?WqRM/93jUjQOVrG4Q5b/La50u+gKoKG2gaQ3JZyNQiw64Mh5Ut3Vesr0WgqO?=
 =?us-ascii?Q?vLsS3K7ViO0Q5If9nA403pfjFFIt0RV+bBH683PyCuTyUTONekwYHM8iIr8i?=
 =?us-ascii?Q?lVR3LRh8prmLlHUImWbKWygajTwqLzXTTwBAYgPcKhh/VRVQlkkMasbaVt4R?=
 =?us-ascii?Q?ffynfYWRPK+YKjIDWiYcLowuayWwk7dICBceYuy9MAFVY50ZIc6fN/GP+Kce?=
 =?us-ascii?Q?r9xKnILdcafL8A6hzytXnqdtdNBxV3ownyUTb6K35X5nMqzvDdqC9tjbbAJz?=
 =?us-ascii?Q?/ueXpoU3sLUV75+nwos/DcefyrZ/kMAbVuenoAEeXLFOuqrczcTQBvjEbQMV?=
 =?us-ascii?Q?PM04x3awHA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeee82b9-6aad-4ab4-88ce-08de58de78fe
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 11:16:07.3021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqfMSIM1gYi7YJJnFXNT4mXeKrYDGG1u2t2YmKxeRMeJ5vzzzH6lO5FNFCDQfiL6BCTaWXcpA1WOMcUkV0YjJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9369
X-Authority-Analysis: v=2.4 cv=fNc0HJae c=1 sm=1 tr=0 ts=6970b57a cx=c_pps
 a=roYWoV4TocsuA6t8t8h9Ow==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=FaM6rFO3zl8dvMblsCkA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 1K9RCWZiMGc1PwUDI5Z28gqgyEHHt_1R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA5NCBTYWx0ZWRfX22Ad5Ksc3EiH
 HLBwtrBz5z5/zBU0pWxLpSvW9UCx5lDFZRT7eQJ6ij7OfCEty791vVsdglq61MyXuvJtqtYrmrK
 nZg4bfJpfO9/trmZsSzTl3NJuYXqN3iisd3pR6AunjRG8j+oa7h7QuRxZn+PInqkOV4DJw+ctij
 ydpOa6pe42m86IB/g2XdvfLjV0K8j95QvFer5s6+k1YiTJbtxImDcS5+05OsIAp6ZtufdEuVOVF
 mKKv3IU2uUVsXoI6ZhAypLvBgZ3ccEiOjcza7KlI+NyrWD0VgeZBXVEwYeih500GpUz3g0N/w8O
 BE1z/UILmcAuP7v9TkkN29t0lxyK+GkpkKqyuFVD2n4YlkvMsaxmMshsx+8SMFhlfucdcVCSO8T
 /HPtA3+awRVyPC4bKq6FjYjCO7dNO+vdRi2Q6xTC39EZyryAJc7r29zXEgA/lFbGjOTz9RN619Z
 JGI/0PZZp33yMWtn+Gw==
X-Proofpoint-GUID: 1K9RCWZiMGc1PwUDI5Z28gqgyEHHt_1R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, Jan 21, 2026 at 10:59:45AM +0000, Mark Cave-Ayland wrote:

> The constant value should represent the next bit in the VFIOProxy flags which
> is 0x10 and not 0x16.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/vfio-user/proxy.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
> index 61e64a0020..b09fd886f1 100644
> --- a/hw/vfio-user/proxy.h
> +++ b/hw/vfio-user/proxy.h
> @@ -94,7 +94,7 @@ typedef struct VFIOUserProxy {
>  #define VFIO_PROXY_CLIENT        0x1
>  #define VFIO_PROXY_FORCE_QUEUED  0x4
>  #define VFIO_PROXY_NO_POST       0x8
> -#define VFIO_PROXY_USE_MULTI     0x16
> +#define VFIO_PROXY_USE_MULTI     0x10
>  
>  /* coalescing high and low water marks for VFIOProxy num_outgoing */
>  #define VFIO_USER_OUT_HIGH       1024

In case anyone is wondering, this never bit us because the MULTI support is not
yet merged into libvfio-user

regards
john

