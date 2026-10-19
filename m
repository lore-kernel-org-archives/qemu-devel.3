Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAADCCF2D6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIm8P-0000rY-Sd; Mon, 19 Oct 2026 08:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm8L-0000lG-Az
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:29 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm8J-00048U-2i
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:29 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8Ouhl3282357; Mon, 19 Oct 2026 05:06:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=vZDjPjvAeuhaiIHbETR1s+dP4jG+860Y1G05PguIu
 kA=; b=U/F+OK+VS+9RrVXtW/yKT1GpKRS5H4/vabjezLObYo9rsjrHeHSaUlzo8
 sRO2ePdA/tIsAWnc3cnktNxODdJ6J8mJhvftOs/wc2yTAaNo8MMdE0tgbqpULYHs
 ktwrLkSVPDWldtx9Gtc5sUVR2d5Yc6dKthFV7aX/PsPYZvcxRu1UFOdWfit+tBkk
 kVE0XW/FrS5rDOYf9vmzl2fqINwaYG1eTg34yQ6TMbMFWWzNHDmdzih/JYGfz0ug
 qmeaQvWSVle6SQn9jvB+ZHgQv8ovD3Rz2BTQLhdnHrCiNCNMiGe1UNe+LLQvoupu
 auNGMSNL85kO4+ssombshpDNS3fJg==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021075.outbound.protection.outlook.com [52.101.52.75])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hc74ekjfc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:06:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVM7tdqPfNu1pmRReCH3It6gbGz8d1xlZx+dvMBqFNHPEkD/rrFE2tsOYdu7Nd/8GmQmvrFWqA/PioWWmtT3f73YkvWCFzksCia+vLnWBRpTZKr4CL5hmJUK2HXRKt1BDCWqAXPBsF23SRSJC92z7rTyXTKp0s0Ih6h6CSgILbwTXlmvwNo9qm+Vs5tzws87N0SbUJ/Uz5b5MJkTcAheNbMlZaxL94KixromJ09ITVrPplBhJgO3+Q2ZAImroMDqy8m7msNmgkT2DJwUHv5zsxt21O99sVjjcrq0il66NK8CSeXH1n6HGaBIQSo/x3VquEDS/73N8W1gaq49kjuyLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZDjPjvAeuhaiIHbETR1s+dP4jG+860Y1G05PguIukA=;
 b=SyCp20Wd7WY6r09OAxs4XTzajzEUN3BGen44mn1D9R9RlP/0NPCnbqiDFKiJqC/8BWGB4esvq6kRcaDRGa6N5YRYs/ddkTuhIKYT3kIYHaq6yfUbovcMejxNCOXyQxCHq9aRNvXvxDf2MlRrWwvqIovEmMYPJByX0KZjJ1OJGARSjm3MfKm3oX5TalW70mAbCy/z7TidHyn5Y1CjdI8tGvGbLjsBgkpkOxBclnVnV61Vf0BThDf1RKifNPTi672pVcUmh19BinttYea+TAa88sa4BHRLC/jtiWnVq03qGNs+Qlia1CCezpT9G5PJcUfD/5Dei/lV8G+sBZusWhCE2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZDjPjvAeuhaiIHbETR1s+dP4jG+860Y1G05PguIukA=;
 b=NmOzPORV1yIXjQgXlgSOAGCvkFmmeCcW14CuUAEsOzQGemJGKT7SQwV8nmDhKHKLGPjYHMu5bGl3PUvAl6Pv1ZqK6bDHm0ZNawyr/NGYKpXhbY+DVE6M/WMj3rMdaaqpyWFt/9FixHa0pspEvlV+P0d4NuBfrn4LtPIrFh96IPyHWezhX5UhIfjyzf8Ahsp9I3BQIIPCI/wbggvUGCoDDVavvxCHGYW9U1k4fGZSjfCJpl5txeoqY+dPA31tUJX54pNZ1xBlVyTq9egTB6+Z21ISFjuA++clFmsXW7zubik33tdFQPwi9kIcomlTh1HQCR00AMFC13GsKnzN1Ox4ag==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MWHPR02MB11820.namprd02.prod.outlook.com (2603:10b6:303:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 12:06:19 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 12:06:19 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v3 18/28] isa-bus.c: introduce isa_realize() function
Date: Mon, 19 Oct 2026 13:04:50 +0100
Message-ID: <20261019120517.1448687-19-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:217::22) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MWHPR02MB11820:EE_
X-MS-Office365-Filtering-Correlation-Id: af66f567-2a32-489c-933d-08df2dd96270
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|10067099003|18002099003|22082099003|10063799003;
X-Microsoft-Antispam-Message-Info: s+8D1IFV5TV/TLdN4BilfhH04mgcy+F8wITtLToLTWAnAcHT+neBxxFv6isuwopPcYzqwHs69WlcvLzJJRkrn8V4VT5jLzPc21QJxKsbe8N/Xr2GWUsUA/VgdKC5MZJ+wLHtnedI2S8LnMpwomqBj9r4VfkyHYfZU/LLQP90EpRF9lzzp3vkH1RmSHlsRIJVVGUDgQ8Mvyc6AckqfrsyH+GjtGQwlWnEetQ8qqQIYt3ISkTiYJWGx4bHHXWW3nLw6wmvd6Ac6yjFi8Zw2LFw/rVvs5SmHK4K/ynW7RBlwApJC3x2oIgonTouAdxkpe/+NxwptZz5hWoq02AmrlhE5U5ykqXU2vH1K4FOK4Gg1/9H97vLppJTtbZZKzGYXqR0Aetrtfzg9+0FkzG8tbe3kQyz34Ono1AZRKRUTf5VMLy3NAEIrz4FTljyuWgAR2Wm6DlIJiqiidfyLKSLz4v9owN9QqrsRF9jMyu1ZKnMsQSRhTAD6E6ZjlbEVk/L5/CONNF/DfSG4LwX0McbdEP36MteS39tQDn7uwT0rWyRe8x2MoJ4hswoB8+fEyrXwjeWRhitPbp2/rPharNbQX7kWq2E9i6tESVE0rAxjMiwbX/EwzE8WXYr1jm05rHDb5xKCfmiddYWAYzaSSqWJO3GrWxh+tdKdI+c38wiEaM4J8M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(10067099003)(18002099003)(22082099003)(10063799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?idhpI24EUjQEHwPKSWoS+8se1CCaqvSmavQeWSDXvcwAqRRQILbDGDJNwTfs?=
 =?us-ascii?Q?VMMU4DLx7KwOOgibR37HpXcQndL8NgWW2JhRo6/Fl3xzgI4DuCzzKXsnRjUY?=
 =?us-ascii?Q?Jrv4BW6R1Rv8tUtt/E80JozHgn1m6yMN7e9+EaAHtzgU1gY7YGGoLEGuSz4D?=
 =?us-ascii?Q?nB9JTYAPHAVw+gCRKQbMoM8E0c/mG4efXUDF8gxErN+9LdC6m8P0eOFqx3YT?=
 =?us-ascii?Q?IU84jsZpuj7kL4nGtT3XiRauIqytbuJSTdC8VLc3mN7YV+v5EYVX0bQAZpxu?=
 =?us-ascii?Q?iHZeQOBw9MQ8t9S+/Pn2JDWs/2pYpRBcb0zIUD27BuvShyI5HbDXW9eW1HQW?=
 =?us-ascii?Q?dWPpRv1Wxi+vRqJHLc1gUbtB9QGgjpkhfATPiyv48XTGm2EUERNwnCtToYeQ?=
 =?us-ascii?Q?O7EDVvyazYV/2zePVQCchAtHOkG5EyZogpdVppPG1Ci8KYj32Y9Pd86kp9l+?=
 =?us-ascii?Q?zJcmAlFfUHwfahqt/89CR1xpqf51e3rApG2Kt+CG7iqtNALydUY5vJdnHfME?=
 =?us-ascii?Q?FGqCEKfdACsPgULMjUYaPF1BnaC7VgxPCdV7FCMzztiUtmWzL1SDDJCtl5pQ?=
 =?us-ascii?Q?eVsew5W+qVAJIlUArthxXMJACHznv5gI5ehaSYJx/4kJ030wZu1N1vbhomvh?=
 =?us-ascii?Q?o3uZkYjdb9zHphQBz/tgdOM+lihrAQK1B83dr1PXTKnKg9mGsRypAk1LbTkN?=
 =?us-ascii?Q?zA9O4WseHo4I6mAhWM/yNKdbO3V/YnD0t73R5xUeSkQRQPgTnBAZo8MBpgg+?=
 =?us-ascii?Q?lsQ35NS6KCQUQ4YayHECdqPy4dgIjRRBCT8tBLhiTTUhQb5K+7rFJ1C4Srjw?=
 =?us-ascii?Q?Lqk4PeiT1MBM4KF/fq2GRFSLNgrWGVVepLQ62Z2ZSpmjI1zeHGnmVKpostzI?=
 =?us-ascii?Q?op3wZ8ZYfuoqlnyH+oWDxlvrSOOIcEr5Wd2MZ7GObGyTTDRvbUBu0198E3Zv?=
 =?us-ascii?Q?LxlBEDJRvQQxswvXi12xv1WSt7y2WDrKazvAXIh82BZxxw5ws8DFuK1LzEB5?=
 =?us-ascii?Q?V3Ti7dwzst7DRxdcRwAQJ9hp7knowWfxZ9CvWNST4nLzXcJcMY993eg6p9mN?=
 =?us-ascii?Q?z7Rw6oed0FfyfwPK+qD9FolIwO8AmK/QVj5cxP6lgyTcQwCfZ/ci1g2qptr3?=
 =?us-ascii?Q?1azTwN4tqJBw+HiV+UTb33QR5OiU/ceEP1u6FOqWPvKmJZQ6QUD9U3WhP+y1?=
 =?us-ascii?Q?bkVUqw/4NUZoBl2Fz4BP8AcPvPOQT+WUmA5HURzfg+EqxcZlURW9ISAkZTao?=
 =?us-ascii?Q?uvvOuRSUn48HIeWuDb0bUHSpbqaAMn+hwxIvwTH4m6jp1Y0cGweM3DKsqAmn?=
 =?us-ascii?Q?vapML4RiyZ85Q2eXnUPEnJOMXGXH0IdsuMgbfXPQ4eGm7Q8gEDEVhUnrtJIB?=
 =?us-ascii?Q?UPvdrMki0ac9e0coLgsknnZZ9wgCI+iYZMQyBpoghWg1lVY/5/IgaYLLvHgQ?=
 =?us-ascii?Q?8VGOjG+xKcKwH4Y3ZReSWj+ozo2ji2L0m74aLTtw2GzIH9gBC3XWnpSOGSlP?=
 =?us-ascii?Q?4usrZZXs8Z3+7ubCJz8qVi9KhNNDOs1zQV6Y/mQeRhDD6gGqeL6koB44eZWx?=
 =?us-ascii?Q?l1/u0rhmTeY9zE85TJJV5GQSOU1om0WPCu/iSJwJqOSXuBD1dph6/Ah5CO47?=
 =?us-ascii?Q?u37XSTa0vuyG8XpeEQ3shz8WI35SxFEzdoBPKSakMBp/MVQIFV2P85C/9NI0?=
 =?us-ascii?Q?gORT0gIvs3/5hbcYOgzndZ5H1qs0hj9/gF1BwmazMzc7ocCc2Je3i2kYIm8J?=
 =?us-ascii?Q?58gl0c37C0AZo3Qw2NLjiMP+mL6QZhE=3D?=
X-Exchange-RoutingPolicyChecked: VZjceDUODmABJreCh7haIR/J6QyiSxJlMJBaxhCCTZkPtHwIGMGSSgJQEbT90MHYCTndX4nOIkBBGuFQaYScwOqDTmBZ5tgEyyPcizw3ABspfzT2q5e6tTDbmhDFAGGseO3rcDNxfpOVDID6YfmkMWAgWnMI6tlFUWykaYp0py2t/cDwHjDi/5EE0KmulV2mlvRYgLWjlDPQB8OzGHBgthQBVhTFg71/TJv3Baj188TwqjL7k8OzCFr6N83CJrOnIIN6QqpqkYlhssOjsljvNpufxiaynL2NpNa96XX67B0M0rNQT7Pv74/Q8yaTDX8/F7IK8dzC41oySOWRe7U6ZQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af66f567-2a32-489c-933d-08df2dd96270
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 12:06:19.3262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVcuKOYI3JMhaElhyO54MLI2I0xzvcgiOWAMqOcCQqD4X+9EAwYRWGKwAp9ilaWiIxuUX8CwYr8mh1llfuJ9sKbd+Qn4oT5aiToG0Ejie/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB11820
X-Proofpoint-ORIG-GUID: ruPj8cio3ZtN4r86KudUZ4k8QiuVp5YS
X-Authority-Analysis: v=2.4 cv=HYGB3SE8 c=1 sm=1 tr=0 ts=6ad607bd cx=c_pps
 a=+Ua/q5Qdf9RbITHm97vdGw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=E42jAAAtX2bsQao6xnwA:9
X-Proofpoint-GUID: ruPj8cio3ZtN4r86KudUZ4k8QiuVp5YS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX09ajS1fHTcIE
 Sg3yDl9jyw8/0crTTuH1JxBIl2hJG3AAmSAahoP3jf9dBWWbQjHpZdc43mtwW9nG1J5zDRHTLii
 fjlFSwA/8pE8K65mEELuQtRNc4XOw24=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX5PW+LQClQFyI
 cJRP25Z2EDP5Ga4Y6Uef5s2pRWdw8TbvFXxADMiSzxRFzU21BqXOsDOCSis6LEwHBl8hx+yPcXB
 aRZq8TMbSpwQg9QSC5iYtsuqaepliQTfLZGFnO0qkSwCdRkmm+tP+RpgnwIolJNNIxX/gk0WLSG
 myb8pfzLDtU1eB+/MCEWkiVE6iHM9h0rrcKkBiUfm0pZTcyaAoATBpxFs0vdXozZzJqtrWR9vwP
 ErBSi9OlgcYZPHVRmQqWpH4rwuA1He4jK+HT9ovgmNH7GNXLqDx4nclmTZ5/YMyc9VpFtRwxgeR
 jyv77DEVfq71nkFncCzZYZMyiK51gO48xmHE+ZWMabkhqfzObjrxnVwHD4Ymn0aQxdlv9K1qPmb
 wdHXpK3dCoz0SzjzQRXsDVkXlglg2lck16tKYhr2zB2jrP9GJ/msASYQphE9QET2rki04egG6pn
 CTb/1xh6Bk/4zkGCOIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
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

This is required for implementing a container device containing one or more ISA
devices to ensure that the refcount is handled correctly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/isa/isa.h | 1 +
 hw/isa/isa-bus.c     | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index 94bff33fcc..a3d54110fd 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -82,6 +82,7 @@ IsaDma *isa_bus_get_dma(ISABus *bus, int nchan);
 qemu_irq isa_bus_get_irq(ISABus *bus, unsigned irqnum);
 ISADevice *isa_new(const char *name);
 ISADevice *isa_try_new(const char *name);
+bool isa_realize(ISADevice *dev, ISABus *bus, Error **errp);
 bool isa_realize_and_unref(ISADevice *dev, ISABus *bus, Error **errp);
 ISADevice *isa_create_simple(ISABus *bus, const char *name);
 
diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 7e6d2ce5a9..102f4a0e0d 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -172,6 +172,11 @@ ISADevice *isa_create_simple(ISABus *bus, const char *name)
     return dev;
 }
 
+bool isa_realize(ISADevice *dev, ISABus *bus, Error **errp)
+{
+    return qdev_realize(&dev->parent_obj, &bus->parent_obj, errp);
+}
+
 bool isa_realize_and_unref(ISADevice *dev, ISABus *bus, Error **errp)
 {
     return qdev_realize_and_unref(&dev->parent_obj, &bus->parent_obj, errp);
-- 
2.43.0


