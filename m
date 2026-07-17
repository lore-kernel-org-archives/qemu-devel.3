Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD40C44514
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkgcg-0002h0-9H; Fri, 17 Jul 2026 07:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wkgce-0002gn-P4; Fri, 17 Jul 2026 07:20:52 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wkgcc-0008B5-5p; Fri, 17 Jul 2026 07:20:52 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HBHFHS3782335; Fri, 17 Jul 2026 04:20:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=hqChcMUc7I/9PEy5RBcQDxoyDejwTIA+xJG+5fZPD
 hY=; b=H2tvhfiRRJiBM823eBXHKK510eEn353R4NYvK6mY489GgHsnvLh6qToVE
 2Run1YVr8RGcf1wR9Yml3fDIlFTOkkytKyFXxgvw6V2iV7+7WyhwSAiV8rl0/Jz0
 TSbwvJQqGKvSXlfaoikOC8OCiIy9AkTJ+3FvgOQgoFPp+1rEpL0M4prbn14PTAGY
 6DHEmyFcVgpG/LaP7uMwTcGTUhcZuZ7Mb4oShGQVJhd4iGUlhTpM4XgkewxL/lyZ
 wplb/iO18ypKT3yeFCN7nqnMWy8SJx8oduonATRgPTtippUE5E5dtZgabIDEEWbQ
 HhE2GbrPBVYaFcNf7ZkaccufCKQ0A==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023116.outbound.protection.outlook.com
 [40.93.201.116])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ffkcx806w-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 04:20:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=By0PUJiQ3cgX7WoDuNGjyCDwNnMQIH8LbaXKsOvXIQ7JT45cO2NSzvWGO7ZzV9U1+PpU4+W9/5ql7qT2aj+YlvcpYuFLiTMiwtGW50Pprtx8uzZjYnT1+gtLcmoFyQUI8DKPxvTNP13+vCk0ZHTCqlhL/fCekOPvIpo2UDxpKfcf5aEIdkZegTiIuLgxk6jjkXfYsjOjrIKY1LMGxOxTEJW6db71bpOdiiEjN4S31pp4Cr36WcjH22mflkM+o0vwDVHY6XD8kFAQm7xvvwRDlMcPRWP21sqcIhcbeSgJbN7+rmY5g4ZSasoTjgYvQrKWUi5JyRQPgdD+5cQ7A2UyjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqChcMUc7I/9PEy5RBcQDxoyDejwTIA+xJG+5fZPDhY=;
 b=etLvFQajyuhjn+166gWRpIYhybwVJPxZQV6g8S6WhpYsOJhBOlCJLBnG0MtSmVf/BLducRr9N7l3vwhp8GWsaQDuJGFtIFuwwV4ckd1LZ+Bbwj2LdMS+zWLG943GiiZOIy4Ldb8Aw5KLz7NY6GpncY17RW/LHlU7OScCLrnQxO1QpXIahtwNQTzfXZIf256N5w4P2Y8QC1zZ4HkLaMaqqmt4stUPvRXCtx12mg/qxBUHVD0wmpzkpaNaJoJYhQeHISPm48gN/aKqgPMZiPi6Ubs2CO4ltA7bhFuVYRjN7+NvKhPjJl9uShTqHxr1hAlXzcFERWEJByJ5yhrm4Bf3tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqChcMUc7I/9PEy5RBcQDxoyDejwTIA+xJG+5fZPDhY=;
 b=k7IyUvfPKgW9yg2uwA2ok9hHbaSSzyZC71RcajmqOZ652sxfgSUkTubP7dTOze5+1lOstXn1oGJlmJ8cUj3tDWt3lUs7bocYhP1/iQscly6li7adQx9rOs9VkVT2ml6sHVGRcZt1iD0UbOUKEXYn17cuLbDdkVmRfLBrhDmcqFodabkA5MfqYVVCc4T2nXgGVBL0qoSJ5dpLyRtrKAn1LvLACKPsddkkAjFEARDGJGMNN6s4EqcweEeMq0L1apU+yNvsNFwXslawZLDRN7NaUOyRo71Jez8XhwaZkw3rWIjb+pzTZuD6kId19xiMPJxcTrzD4WG/+0qjarA0JCpIvQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7503.namprd02.prod.outlook.com (2603:10b6:a03:299::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 11:20:43 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 11:20:43 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, pbonzini@redhat.com, berrange@redhat.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 5/5] qom/object.c: rename object_class_property_uint*_ptr() to
 object_class_static_property_uint*_ptr()
Date: Fri, 17 Jul 2026 12:19:12 +0100
Message-ID: <20260717112022.444367-6-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717112022.444367-1-mark.caveayland@nutanix.com>
References: <20260717112022.444367-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5P221CA0128.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:1f::22) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: db5823a6-f225-4c61-2844-08dee3f57093
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|921020|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MLYHuQxBrZJa0Fcod0POHRTCXJzq84ih4iu0Svdw5pJjlC1p0y5N83cVyoUhXA5uyeekiNezsx+iazvpeG4pb1rISKB9Kyhk8DIDi4UYI/+ls7a3avZzX0ORs0/7mAtIH2wdSGkNOzyuuQBJ1WpROYaWmLS/GELeoUYJdn1+xiwXFz8AXcQY/3s/CJBaTz171nEuyVMFyf7POmueYr4vZraaRkACbDqfbhQwjnCNd/xnk0kGVmvzsLba9FJ24CCoMZiFbQ85qHIPN9wKAZ+1OnTY8xXgW76yi9pIAsI2FwJStHWr9utLOFWjreboMdWZ+PRSjLGvgGoBJujqGiFxJscNMO/GaFTK7BPYdvemy47EbtfccE2Z3ITEZSIx1LZ4zM59SaFGu05PilGoxqm1mrSRYjZLK/f8SWZ82hxJdHHXTz68zf7TSWaninHgAj7JQ3D0uD4noEWXKfRAGa0Cc17F3BEFOB4kJQbi6p0xPv0OUIsfSN1CfqbvFcermnN9wILn/7pl+yKd8C37iy8qull7UOr7qb0cgou2MS5YVfQv5gzHapAruSY7cr2HDHLXMIZsokyJUkCBuzyOsSJMkPALsrmvq/VGRRhDHCAAo4R1C2by4bK7Dr0JYjl8nd0fW4PNPwe2DIfdbnLOvYxocGFeO26+ZQlQgqdrLOknPJ8jexCuFXNcm1/CgpkCGCE+EHkFhhp771OrSlXz4SnSFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(921020)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gdwuPqctu2OVq0zEuvy8zFz6PxxT/QIGhj4oENv8RAkLoTufq45iXEuZPiVK?=
 =?us-ascii?Q?lCvFmZBoyWpMfBEiI7DjTUsspj2CIe6orB84mgO16PT47T9855ElSgb0jUHX?=
 =?us-ascii?Q?t1n+2nRi4T6gLiNRzIX+6GEF6aeErE21fGJDvV+vupChBNVjOZ+UD6NoDDYH?=
 =?us-ascii?Q?aEIuN5yIVIY9gCq3SzoL+g4umHT+V5uFTKzsZVmOlzc3+ap0JMWSIEwyFrFl?=
 =?us-ascii?Q?R+G4Ssd1S2zB04KKjZR5jGUNeLoBjxOZJnjeqWPXs8PVFCrIQv7EOQDsSvVu?=
 =?us-ascii?Q?LYzo5UamRtNyAtBT4WNUi7W+jMIxclY1VEfSybh9Esc0DQDCy5lwm18ZFHH9?=
 =?us-ascii?Q?QDNwMi4689r7/GnXw/hFi2YxTkzuSCrWmCAsdRHFNMkBXgH4qcPy6tZxh0nm?=
 =?us-ascii?Q?dQ+ZX4z4x7E0ORLHzj8WqbIBAmWfVmQ2/EZq0p6NAP0/qR4CSt/brm83PuqI?=
 =?us-ascii?Q?kNM12qfIfDDsk1qlp89PCLlMmSujMJgGYrmGCKNUU+PNvwaTzyuNIC/TipUy?=
 =?us-ascii?Q?TDKNDsQTdunjiFq5zcxhUSVkuIRI3Yf8XuPziQ1DVBWum0SCe3yVtaCyKgUe?=
 =?us-ascii?Q?Tn2mt4/fxI9q0yAkOGLq+qOaFC1PJROqew3h1ptSOBeFegFOQrwmkAMhQTjD?=
 =?us-ascii?Q?VHEqHJ9Q80bcRcw+olh8Hb9YQBFlJORpWDnAGeKBxrCmbNjKEZS14ZSJ/bOo?=
 =?us-ascii?Q?6ydxMQ1EA1n4aB3CUPwyJ3AILgJFAg/yonrWRw2SwyWprdlb0NNYwW3YNbFF?=
 =?us-ascii?Q?KA/RHvF644xty1l7/qduNjEyVoOtNzxqyfuBYNNwO5frx65edIFZtNqg3lGw?=
 =?us-ascii?Q?VoGTFEOUqk/hYVfydtCo/JvmOZQ3kwaZrXACBLwJDIU5drTRRKbMfQIXYxy2?=
 =?us-ascii?Q?1xGZ01kYw+Vqkx2o13LiPtOk6Bl0p3pJg1xm0bltfq6CKer49DWMmO80hpBG?=
 =?us-ascii?Q?keDePQJm3cWHyKEHVXvAHMRmRybuao8atAlf6U4EApb3EmqJgxt+Bvd9sL55?=
 =?us-ascii?Q?PPbnotXxTCXK/FR2djdke7ccZABPvqWcOLezkQg1OFQoMBBrm1G7sxYPe9UH?=
 =?us-ascii?Q?rMDiK4z/CnhyCDRDe3DqyDqNX+87McE6AxknirRrcPzTe0kzeHKWEOMd1xvN?=
 =?us-ascii?Q?cASobxt/sPvxvxzqG8LOAGsCJEaoUyGUpD86IT0xt1SmS5KvhGMdhI9gfeLN?=
 =?us-ascii?Q?GtdD/1grghg1ngnEESbiLHGbTjFS/PX55aXKVOspNl3rFfm+n+5WPJg7HL1J?=
 =?us-ascii?Q?2IysKIwrUv4a9Lcys2G1h9v8PeFdwPWtIT5Jx5YCLLzaDf9jFAYpupFSmOTM?=
 =?us-ascii?Q?G9BjzKcy7tkhDn/RbgyiowfOVoya8+WFrQxPfV71fu5cXC4ZkEOwvSBmRX/4?=
 =?us-ascii?Q?Gd1lVdaqcRk5XNGsZyd2JKpknzgKdpKYCS0NaOiOGtLdXeW0MJ+fPNzn15VG?=
 =?us-ascii?Q?n43Mgj54vOpjeC1L37axIK5VLyQQQtH9ay3iy7YuFVCP5rGJP1V3xnqQRSdg?=
 =?us-ascii?Q?xr9Hu9ly1j1pDuWW34NQ+HzD4pWhxZvdgto/0nRkcIPxjFN/XTOj9FjkWr9v?=
 =?us-ascii?Q?OR0tHExerdpl0MnKmY0LpEIk3tmdJv1WWlkK962yAAq6LrbPkuKg35Kv/+nN?=
 =?us-ascii?Q?gGxN0y69gt4FtU/dANtX6UMapBXKnB9esdlARVKkrLX/J0VFdArExrKAgRlc?=
 =?us-ascii?Q?hKQ6pEqKwvoYitevmStlF6oQYZI2f2plM1nPQo2inXEBVXHDKxNSL1ANo5a0?=
 =?us-ascii?Q?CYT7zTHMCJBdH4hR+YjQaGJ3xT5NYvM=3D?=
X-Exchange-RoutingPolicyChecked: DhmtnLQ6KmcR4f82TzC1WxtSXOQo/k7lAIBc3Z2qNFHQnBKG/U6rexYFf6HrVMcR6DaB6dYl15g+crzng3rNLcXWhdJ9Qx7mVKbOKxWwCjXI4P4aSvK+oMOu++OcWHlq7DXevy/mSc/6PYeueCl2cVti5LJcX1MdNyEO0u69s28OZUhDDSwxWg7j9d5w2KyFU82SyF2kUS873zLPABnpqMFmgilU7o1gDb1VWU9cDOtPUtvJmTuQiH4AXLH55Zby4mGblDTPCZ66HFEJhftySbDVfAgE+Fv/3rCGQCtcPgXx2EXrHTb1bevN8TdP9Md7HTGiaXSOEDL28m5pTXpmhg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db5823a6-f225-4c61-2844-08dee3f57093
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 11:20:43.0826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/fpJn3wZZMUKQTnXYzRO0dEmW9l2yA3+hPuoABNU3d+6y3ryOdtGhd673xd9oP1oHvQkvmwzIik1SBMUocG524m93xe6GpL4zvc/JXJTK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7503
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDExNCBTYWx0ZWRfX0BUDrA4cNBcH
 xPFfao6+hyb9CDs1/lZxSjPhB/lnsa9ZLAFsS9Cbk2fbN+ACNfzuyI7cVUCTgwGejNMugfjPFNh
 uBFcRrITAIw7nTzk8p1kgBufVsTd2+I/oOqQV9CG98DymCYXzx0wvtbZdW8GK3WBab/Vq8oXnWp
 NVjgRG/joLKO5vs69tOxNDQG8kq7OO/La3dk0joW16/W5+SyKbmqk+fSfgiXMSatuqQ0lCLRM8S
 SGJ2/WR3Uuol6iQp76+zKkRqw0RRVm5RIztx2H+/OatitWyiCEfQlra5kbeHW6xeDvJ7k3fbQSb
 5c957MkDeZuYnXu57TpZZ/2uAEZVum1E4w9B78npsqw8H8p2HU6IwVcw+dsYqWyLU3sX3qJWlnt
 HZ1HvmgD82VarxHUIHpGtQX5VGUnDXmzyOJzeSE3Ldgfc2H42z8bkfRPdqBFUSjngiJvJu7r6us
 kGLmlNweip4Jm2zGQ+g==
X-Authority-Analysis: v=2.4 cv=GecnWwXL c=1 sm=1 tr=0 ts=6a5a100c cx=c_pps
 a=0c6nIVSIW9eNWsIgvcvAAQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=LvQkBZahQPeEm8uYs5gA:9
X-Proofpoint-GUID: uglGiyLuZBnYTa9GT4oT2qaLofMlmIRF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDExNCBTYWx0ZWRfX+TJ4MyukPLHS
 cfOGrERPPx/OMHbZjVoPdoeQScGaYOlmbxaPeUgnBLZjUFTEx08jkjVwVFBVmff3qkF6WTkahL1
 BBHGtU4rEPocgvTuM1PNV34Jad3FyQ4=
X-Proofpoint-ORIG-GUID: uglGiyLuZBnYTa9GT4oT2qaLofMlmIRF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This more accurately reflects that these properties are held within the class and
not the object.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/qom/object.h | 32 ++++++++++++++++----------------
 hw/riscv/spike.c     |  5 +++--
 qom/object.c         | 28 ++++++++++++++++------------
 3 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 95fdf01e30..9df02de93b 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2038,18 +2038,18 @@ ObjectProperty *object_property_add_uint8_ptr(Object *obj, const char *name,
                                               ObjectPropertyFlags flags);
 
 /**
- * object_class_property_add_uint8_ptr:
- * @klass: the object class to add a property to
+ * object_class_static_property_add_uint8_ptr:
+ * @klass: the object class to add a static property to
  * @name: the name of the property
  * @v: pointer to value
  * @flags: bitwise-or'd ObjectPropertyFlags
  *
- * Add an integer property in memory.  This function will add a
+ * Add a static integer property in memory.  This function will add a
  * property of type 'uint8'.
  *
  * Returns: The newly added property on success, or %NULL on failure.
  */
-ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
+ObjectProperty *object_class_static_property_add_uint8_ptr(ObjectClass *klass,
                                          const char *name,
                                          const uint8_t *v,
                                          ObjectPropertyFlags flags);
@@ -2071,18 +2071,18 @@ ObjectProperty *object_property_add_uint16_ptr(Object *obj, const char *name,
                                     ObjectPropertyFlags flags);
 
 /**
- * object_class_property_add_uint16_ptr:
- * @klass: the object class to add a property to
+ * object_class_static_property_add_uint16_ptr:
+ * @klass: the object class to add a static property to
  * @name: the name of the property
  * @v: pointer to value
  * @flags: bitwise-or'd ObjectPropertyFlags
  *
- * Add an integer property in memory.  This function will add a
+ * Add a static integer property in memory.  This function will add a
  * property of type 'uint16'.
  *
  * Returns: The newly added property on success, or %NULL on failure.
  */
-ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
+ObjectProperty *object_class_static_property_add_uint16_ptr(ObjectClass *klass,
                                           const char *name,
                                           const uint16_t *v,
                                           ObjectPropertyFlags flags);
@@ -2104,18 +2104,18 @@ ObjectProperty *object_property_add_uint32_ptr(Object *obj, const char *name,
                                     ObjectPropertyFlags flags);
 
 /**
- * object_class_property_add_uint32_ptr:
- * @klass: the object class to add a property to
+ * object_class_static_property_add_uint32_ptr:
+ * @klass: the object class to add a static property to
  * @name: the name of the property
  * @v: pointer to value
  * @flags: bitwise-or'd ObjectPropertyFlags
  *
- * Add an integer property in memory.  This function will add a
+ * Add a static integer property in memory.  This function will add a
  * property of type 'uint32'.
  *
  * Returns: The newly added property on success, or %NULL on failure.
  */
-ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
+ObjectProperty *object_class_static_property_add_uint32_ptr(ObjectClass *klass,
                                           const char *name,
                                           const uint32_t *v,
                                           ObjectPropertyFlags flags);
@@ -2137,18 +2137,18 @@ ObjectProperty *object_property_add_uint64_ptr(Object *obj, const char *name,
                                     ObjectPropertyFlags flags);
 
 /**
- * object_class_property_add_uint64_ptr:
- * @klass: the object class to add a property to
+ * object_class_static_property_add_uint64_ptr:
+ * @klass: the object class to add a static property to
  * @name: the name of the property
  * @v: pointer to value
  * @flags: bitwise-or'd ObjectPropertyFlags
  *
- * Add an integer property in memory.  This function will add a
+ * Add a static integer property in memory.  This function will add a
  * property of type 'uint64'.
  *
  * Returns: The newly added property on success, or %NULL on failure.
  */
-ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
+ObjectProperty *object_class_static_property_add_uint64_ptr(ObjectClass *klass,
                                           const char *name,
                                           const uint64_t *v,
                                           ObjectPropertyFlags flags);
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 9fde0faf39..630b65f569 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -278,8 +278,9 @@ static void spike_machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_str(oc, "signature", NULL, spike_set_signature);
     object_class_property_set_description(oc, "signature",
                                           "File to write ACT test signature");
-    object_class_property_add_uint8_ptr(oc, "signature-granularity",
-                                        &line_size, OBJ_PROP_FLAG_WRITE);
+    object_class_static_property_add_uint8_ptr(oc, "signature-granularity",
+                                               &line_size,
+                                               OBJ_PROP_FLAG_WRITE);
     object_class_property_set_description(oc, "signature-granularity",
                                           "Size of each line in ACT signature "
                                           "file");
diff --git a/qom/object.c b/qom/object.c
index 622840f9f8..47977b1f44 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2724,9 +2724,10 @@ object_property_add_uint8_ptr(Object *obj, const char *name,
 }
 
 ObjectProperty *
-object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
-                                    const uint8_t *v,
-                                    ObjectPropertyFlags flags)
+object_class_static_property_add_uint8_ptr(ObjectClass *klass,
+                                           const char *name,
+                                           const uint8_t *v,
+                                           ObjectPropertyFlags flags)
 {
     ObjectPropertyAccessor *getter = NULL;
     ObjectPropertyAccessor *setter = NULL;
@@ -2764,9 +2765,10 @@ object_property_add_uint16_ptr(Object *obj, const char *name,
 }
 
 ObjectProperty *
-object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
-                                     const uint16_t *v,
-                                     ObjectPropertyFlags flags)
+object_class_static_property_add_uint16_ptr(ObjectClass *klass,
+                                            const char *name,
+                                            const uint16_t *v,
+                                            ObjectPropertyFlags flags)
 {
     ObjectPropertyAccessor *getter = NULL;
     ObjectPropertyAccessor *setter = NULL;
@@ -2804,9 +2806,10 @@ object_property_add_uint32_ptr(Object *obj, const char *name,
 }
 
 ObjectProperty *
-object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
-                                     const uint32_t *v,
-                                     ObjectPropertyFlags flags)
+object_class_static_property_add_uint32_ptr(ObjectClass *klass,
+                                            const char *name,
+                                            const uint32_t *v,
+                                            ObjectPropertyFlags flags)
 {
     ObjectPropertyAccessor *getter = NULL;
     ObjectPropertyAccessor *setter = NULL;
@@ -2844,9 +2847,10 @@ object_property_add_uint64_ptr(Object *obj, const char *name,
 }
 
 ObjectProperty *
-object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
-                                     const uint64_t *v,
-                                     ObjectPropertyFlags flags)
+object_class_static_property_add_uint64_ptr(ObjectClass *klass,
+                                            const char *name,
+                                            const uint64_t *v,
+                                            ObjectPropertyFlags flags)
 {
     ObjectPropertyAccessor *getter = NULL;
     ObjectPropertyAccessor *setter = NULL;
-- 
2.43.0


