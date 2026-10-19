Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D5CCCF2E3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 11:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIlIH-0007iW-Em; Mon, 19 Oct 2026 07:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIlIC-0007i6-Qj
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 07:12:36 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIlIA-00069T-L4
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 07:12:36 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8QAsv3008534; Mon, 19 Oct 2026 04:12:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=aNlUrMr9q1rOFXLFDeaeQlVWwE1CMuX+2uDxxeomG
 uY=; b=OkNTFklttXeuuc5Y3B/pfAAJ8rBl6WsChImyx7mW3yoOmXGUXi0Hj2F4b
 tlwe5ztGgvKOW5ozWGHqrBlGlGsfVv1U49g4ChaYPBjAIkOUqzHDUR0TaPxrpHuT
 0xo9PSZ5NydcNovjZXcVCPO0Z7SKhHbT1hpbA8NXD2CR3+WTX9vurI4NkU7etp+b
 pWbdWAeDBAEljt/Gf/LWxlms5J7ikorOOCdMcLHUNpCqiMiwkQ2xJfn19qvW8Csf
 zYxw7nfDXq99uNiT849o9usJ3RNxmS0H9kS0qihj2U+1JLNvKVS+kRB/y4TDAOyi
 /s8J7UmzLfqHYl/Eoyx6WeR1sk1oQ==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020120.outbound.protection.outlook.com [52.101.46.120])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hc5bpuhn1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 04:12:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhIxYVOUyWmsNfUj2QcXtA2PoMW428UVdgF2cPgkyWoUO7CUN9qQ8/K/XNdE9i6MwZHE8N8alNhBntw5K5w6h+3cvvXjD41nSMBuZ/1HITS4V+jklvgHq9V/mPfWWArEL+Mngv5bAt5D++xNXTyyKAdVoXicOQ/2ok84h7DV+zV7fi8XyscMZxg6ChE0pkBjxjKWwwUXkRPNVVU36kEEtbrFAG+9yUY1R45gsg3Fo3VXP+KLpEuMMXt4puujuYlCvGEksuVYCs29rBMZbsSNz5ASHFwPX22F6X/OVraW7CisgbOvsOOwNEecPNGZ7evwgYbO/wnhB8VTY7epGE83MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNlUrMr9q1rOFXLFDeaeQlVWwE1CMuX+2uDxxeomGuY=;
 b=mktz/oc4Ya+F8qeu3AMyR6Eqs29NXe4+y50NiVk3I0xl60e/XxKG+9X1GgL3Dhx9wgSzeO9dUZ9v0EWJMjdL0LfzSyPab37DCBO+thBVx/1CKqYzne9yG9CUqOtz8WGcoxsPRguFyoCm5BU8mO8y5rCJPmqFUl4D+l1v8ElkrrAwIRBCP1jM6eO73AtkL+H0QAQWO4oes6skxuZ4J9a3iIhy9+3G7l1ilIiMY7oqguCWlDneCw8ERC1iOC8Edcv9snciBiuvbjpSZ1uQ5yi6DIOC5Z/N1P3MPZBERC3iFJIDgMT0ExeUuhxX6ebv/byML0CXGHPp4rB8YghmQpcSDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNlUrMr9q1rOFXLFDeaeQlVWwE1CMuX+2uDxxeomGuY=;
 b=Jv2A32mmAYC8WpP/hGm3PtQp/GMkqIyGRhOmDDy91pRKl0MU2KPnpjqVmT3ybehGwbqk65MGCDfdV2WKSYYg+UiS/KEfVG609xSkk467vNHGVHN25yh9CFAWyAvJsJOjPaZSd+BzuUIQM0ea8pQXJV5ssiY4aSxvokig2g/ytOoimmgVYtnm3ALqLmAyQ8wi0lxLRA73DRh3lrYPW1UUs9Sohs64dIB25SLtyr05+/zoeOkPPVF/5Oo4HMo9Wdj8lvcXBUhbb8l5ukcWzCI+9/dMyVSbQfHbmKyktAQO8ss9eC+44hxtHLDlkc+Ang6FH12wXk0QOeOytkiOEd1dGw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DM8PR02MB8005.namprd02.prod.outlook.com (2603:10b6:8:16::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 11:12:25 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 11:12:25 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v3 01/28] i8259_internal.h: rename PIC_COMMON to I8259_COMMON
Date: Mon, 19 Oct 2026 12:10:01 +0100
Message-ID: <20261019111218.1429468-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019111218.1429468-1-mark.caveayland@nutanix.com>
References: <20261019111218.1429468-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:a03:254::13) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DM8PR02MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e104730-3a7c-4b3d-d9e7-08df2dd1da86
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|261009223027099003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fjOvrM3uD4lgt2ekU8sd+i39c0WSIRWqcSB82ChxRZwkY79dOt0ARb6/B6Te0iAclomYQ5flo41LXiTeI043Gjad0vO8+pZvGENdi38X4GyuVPUSWsI4NZabNvM33ABiuQTicwPKcp1It6UCzke0cTAKv3I6/eSAC73pRYxtsWqNiQG0yHcfZZJNGvoqzSLMpibYfKyISeGu75RYdSIXEAntDqms6PTvG+WE3djksAi93JmQctezlmS5iRw1gIetPlqkPMDp48X1EVIFKftmi9s99ROfH2vrqID8tgvALsFE7Pc4CaF66YKzWt3dYjEKtU47pJlqii2X97Xk1XMVp5+/MJchkN3HUHKvfQqDDxQDAcxpVyY88A69KEso6YZyavFuGigqYCi+Y5GAklAuewkMdbajAZ+QlHNAy2y7eKcr4MEIrcI6Rdra2HBUrw4rtN9prBbnxVtolcQsfYJrmlNaFMhJREZOGpqc7pRl1ScY4YFxjvzsQ7QSWz5BGIuLo9OItbwaKUWs5pxuyYpZB+MWyYLWgqzdNMC1pMBhw5eHy2Ya1pQXwqOkyzkS+o8DaEtRE/XaP8KszQPPif0lHUHsZM8TXG8NvOnJj3LF+lXe0hCRFToXPM6ziJRT2iiKiFwTz8T9hdFwsef5vkjvw/DC/BE/ZWsKU5CyXCJmew0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261009223027099003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tCzj4PDvdbryf88u1ZufpJjCVeV9XmHyOeK+3EAhxRBe6M33bO0oLbKOifz5?=
 =?us-ascii?Q?dZwYr9rhpxWCUD5QEiRkKWuG8Zm2djlqYin7fbQGpAgHbDkLuLCBMzs7HjRU?=
 =?us-ascii?Q?p1xwjyNalENx7LBIURxo7rTltuY5nvDztAmYu953Edi3k8sNcwxSqNBUYSHL?=
 =?us-ascii?Q?22ebeazcGCavzwuojAYgJUOatm93b73qAuL9NgUpACWK6j6c+j6r7X7Rj6rq?=
 =?us-ascii?Q?4QdLZEPjj/4ceTKZ19G9FkHEXbSQRUatnvyFhJnljwl5gk3kZaXikjdfGjvN?=
 =?us-ascii?Q?vfyVdgprChxJ+DzJQh5rDQULVncBEKiwcFc3El+44LBM3N6z9mgRXDY1B84A?=
 =?us-ascii?Q?GRLPJmVdLd1x+ovON3k4A2cyHTd3Tjt8OP6Gc1h76JkT4KAQdI4yBv8qJCm6?=
 =?us-ascii?Q?hudTree9PU0GfVKgpGPVYMVJy/e2UvvHA1PQoObGZBfYC4v9/Gt0pkOt0UHq?=
 =?us-ascii?Q?NQNDfG1LYkvn4V+c+m1leYcQoyFUvzi2sCNWKKt0nVxdvVWzjgfQo1zu58Xu?=
 =?us-ascii?Q?2NWFdtfeHYteBuK/IXnDhK8HZ+Z77Oc2vvSZ83XwsndPC691HM5sVh1y5Mgx?=
 =?us-ascii?Q?Gp8kBtMXNerB3+GSR3vfRCKpYkRTTv1qCt3tJYTEeDTZZeoubEbVH8JwMCHH?=
 =?us-ascii?Q?wwKRiVMklsqTj4YfpN3/gzSLC6YLFaHmHuOhUOD5VmRLUce1t6Ek1CtdSFJB?=
 =?us-ascii?Q?KGFinO3w9rzD4eOn4oXeajWTFSO5SUOsKCTHV7uPPOnjC1oOmlaTpckBO4tu?=
 =?us-ascii?Q?bXS4XvAl303kraUkXJuZe4UrVrF/0w5wYaphChO7mX/kGpn6SM1Nbxw77gQ6?=
 =?us-ascii?Q?q2VLGLtXR68Ra/e4fFRJ/VbnR8sL6Li46t3timbKLiRYmeFMcQRdVhMEma6T?=
 =?us-ascii?Q?HKksvybCF3yM4rIuID0FW1GMhz+ns3PCSWxld3ojDxV632zmBeVqeeuxi9sF?=
 =?us-ascii?Q?NJ16+ZM3oLm8Wg37BAR+8JMDyzXZpmYJ0s06Fc/oCegUqED3DA5Fu9nZYyKM?=
 =?us-ascii?Q?hkP2g2voQgKcjNAr3wTcsysrWtY/hqz9nQOe2+Qm1/X9O04Vzs63G8/UT9uy?=
 =?us-ascii?Q?Nhpf7TzZbefPclGhXV9PRw1lUD+Pupxqfcf2lDpZjpyQEwvAA3ISOlHi1u3F?=
 =?us-ascii?Q?T6ZN+oAh1XGLGwajBecaY7Kv3xgBDMM7bTkgB6GzQO+XjNxYBeZA+fRyXAPg?=
 =?us-ascii?Q?Q5b6e9giPQqvZ2iXQO/ZIaDIpRIrhj0rYbcV1JNqrhtDh8hrfDaqtw3AEbI8?=
 =?us-ascii?Q?2/ItTQyzAWAptBRoXbp258Idp8H7ONX8B+zbrAr/0Np8jsSFYKaYoW5P1n1W?=
 =?us-ascii?Q?6mqkeaYoyUgSXfgSrRFHCQ/AT9FFHcN8itGJyo5QfaqVDblcU2goJ0o3WBOu?=
 =?us-ascii?Q?T6sTTyNq67SxQN9s1RuVWPVyxMZ7T3HTjTDONCtt3ckSmZ9GuD0gNzPaJdiZ?=
 =?us-ascii?Q?wdV+oipFzj2Xt8ivsxM+mbfOQGoMJkDwL6UlfDxj4YzQIy4UaspcUYjC0/pz?=
 =?us-ascii?Q?Q+gScE/oxvN3Wjww9jcKpb9RPTwIGpXiANuUJb9CSxFjOHl1u8Ojb8K01PRU?=
 =?us-ascii?Q?nWJ5FwTp+QD7XGy7FonjnAfT6PZynje5JG1wZabP7AfpjsPI7HWkYmQhNUy/?=
 =?us-ascii?Q?wUaxWfGv3Vx3744o2Na9AhrlgXK/F2f4uBe/1SK38JTOycOMEYeuxqLnxDo6?=
 =?us-ascii?Q?Ikifg/XlJibwcdFdyxe4MALUuNv2ObJwBZP7oyTIyO9KvlbNvpauJWLopvy/?=
 =?us-ascii?Q?YzBwbR7EFDLT9sHELj//Z2fhXkrkoGU=3D?=
X-Exchange-RoutingPolicyChecked: k11yPN0vA4bDcsI3sHajRhjwz0JM0KQA6+ZEO+c57MengslHgdUP72OL+GC3QgNtYENeFufOdoMFs6NBpWxxVPXv9SIyI1K8YTnPwHvFLLQnY0oK2ymti/+hdPrvWfFTJS4OFYzxgaHcrVTBMUmUkh82Auom5WVTF0gilFvBYzrn76HCH1eNkq1JxQrj+YKJxRkoVl3iojvSptJVSPLpdJU6EuN5z18F9ZZvTIyeSiSB2wtX5Ks96LYrWqq5oC1nz4HzDMm39xSgU5SeN+RsNPB+nVUajDGOwMWIxVAMW97SJ6/h9TyW5PeHR5uXy/GUuL5rrka5HjjT70HIoLVIVQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e104730-3a7c-4b3d-d9e7-08df2dd1da86
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 11:12:25.0398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDfRR1XvReOd5pKhNbNCaN1/oiP7TW3NUzJlBmEtE1AWqdnIkV94vrCIU28ovB5lTrTCYr/nJTMMq2ddPt/REWeooiJ170zJ6an9saOyEx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8005
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NCBTYWx0ZWRfX7EVwYBLXynPQ
 JDpDYSBOon1LpEeW+siqYO7/YePrIt0KFX190tds0ILmfVYz37dg4iQluhIBwJh69470yE3sQNi
 6KhT7gfQ3wo8JoNBBCsbKszePMFt5oeP7FW5ETaeVq8hEDQql2GFqJjqIKm5z6Sbn1Y75iUJHnT
 hqMLSZJz341VYaEZ97E0F1JI5PoIBKA1ahyEahckVFVe7p9A1AITFsegmPrhDjmp4SFvWuAe8Cn
 9xFiU8b1uEzWr2C9BT7f3z80bBNpxlEmzm1htFq1PUVTeGM9bxtUFmAQbc4V9bYnavv0ER8zref
 WfVeDWFpQlr5rT+5URcR0JdyUb7xNxil3L+ls33j8Rw+OoqnHkpAP6NMkwqLagWzroIZ59jq/a3
 AP5FeZmgFYcjYz1mC6o5IG0+7THh/HULrxgri0XTSlEdTnu0n/Z113d9tz3f7xXT85TeClxpIB9
 QbJiieWkLaVycXWlFkw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NCBTYWx0ZWRfX9KTNKqiSc3K0
 XeD3IedQLdpEB0yJH8b4WWdb8lepdudj7yTCOJ28TQ/wIiPiCHEwZ+UJ2o6xXMRpLIst5c2Umke
 YPyBjO4V+rqcSbpyKqfx2twAmp1SFIc=
X-Proofpoint-ORIG-GUID: N41GtVKNklzCsrbOtlmAMjv7LBVvMx7O
X-Proofpoint-GUID: N41GtVKNklzCsrbOtlmAMjv7LBVvMx7O
X-Authority-Analysis: v=2.4 cv=EKeTQFZC c=1 sm=1 tr=0 ts=6ad5fb1a cx=c_pps
 a=8oFNIrebv7KdPcC3sjE6Hg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=XF9Y1ugsmyLceZbb4BIA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

This is to emphasise that child types of PIC_COMMON are all instances of an
an 8259 PIC.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/isa/i8259_internal.h |  4 ++--
 hw/i386/kvm/i8259.c             |  8 ++++----
 hw/intc/i8259.c                 | 10 +++++-----
 hw/intc/i8259_common.c          | 14 +++++++-------
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index f9dcc4163e..54dc9036cf 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -31,8 +31,8 @@
 #include "qom/object.h"
 
 
-#define TYPE_PIC_COMMON "pic-common"
-OBJECT_DECLARE_TYPE(PICCommonState, PICCommonClass, PIC_COMMON)
+#define TYPE_I8259_COMMON "pic-common"
+OBJECT_DECLARE_TYPE(PICCommonState, PICCommonClass, I8259_COMMON)
 
 struct PICCommonClass {
     DeviceClass parent_class;
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 66f37e1303..14029783e5 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -103,7 +103,7 @@ static void kvm_pic_put(PICCommonState *s)
 
 static void kvm_pic_reset(DeviceState *dev)
 {
-    PICCommonState *s = PIC_COMMON(dev);
+    PICCommonState *s = I8259_COMMON(dev);
 
     s->elcr = 0;
     pic_reset_common(s);
@@ -122,7 +122,7 @@ static void kvm_pic_set_irq(void *opaque, int irq, int level)
 
 static void kvm_pic_realize(DeviceState *dev, Error **errp)
 {
-    PICCommonState *s = PIC_COMMON(dev);
+    PICCommonState *s = I8259_COMMON(dev);
     KVMPICClass *kpc = KVM_PIC_GET_CLASS(dev);
 
     memory_region_init_io(&s->base_io, OBJECT(dev), NULL, NULL, "kvm-pic", 2);
@@ -142,7 +142,7 @@ qemu_irq *kvm_i8259_init(ISABus *bus)
 static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
 {
     KVMPICClass *kpc = KVM_PIC_CLASS(klass);
-    PICCommonClass *k = PIC_COMMON_CLASS(klass);
+    PICCommonClass *k = I8259_COMMON_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_legacy_reset(dc, kvm_pic_reset);
@@ -153,7 +153,7 @@ static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
 
 static const TypeInfo kvm_i8259_info = {
     .name = TYPE_KVM_I8259,
-    .parent = TYPE_PIC_COMMON,
+    .parent = TYPE_I8259_COMMON,
     .instance_size = sizeof(PICCommonState),
     .class_init = kvm_i8259_class_init,
     .class_size = sizeof(KVMPICClass),
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 8f2aa1f0fb..52e24d333e 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -218,7 +218,7 @@ static void pic_init_reset(PICCommonState *s)
 
 static void pic_reset(DeviceState *dev)
 {
-    PICCommonState *s = PIC_COMMON(dev);
+    PICCommonState *s = I8259_COMMON(dev);
 
     s->elcr = 0;
     s->ltim = 0;
@@ -387,7 +387,7 @@ static const MemoryRegionOps pic_elcr_ioport_ops = {
 
 static void pic_realize(DeviceState *dev, Error **errp)
 {
-    PICCommonState *s = PIC_COMMON(dev);
+    PICCommonState *s = I8259_COMMON(dev);
     PICClass *pc = PIC_GET_CLASS(dev);
 
     memory_region_init_io(&s->base_io, OBJECT(s), &pic_base_ioport_ops, s,
@@ -418,7 +418,7 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
         irq_set[i] = qdev_get_gpio_in(dev, i);
     }
 
-    isa_pic = PIC_COMMON(dev);
+    isa_pic = I8259_COMMON(dev);
 
     isadev = i8259_init_chip(TYPE_I8259, bus, false);
     dev = DEVICE(isadev);
@@ -428,7 +428,7 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
         irq_set[i + 8] = qdev_get_gpio_in(dev, i);
     }
 
-    slave_pic = PIC_COMMON(dev);
+    slave_pic = I8259_COMMON(dev);
 
     return irq_set;
 }
@@ -445,7 +445,7 @@ static void i8259_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo i8259_info = {
     .name       = TYPE_I8259,
     .instance_size = sizeof(PICCommonState),
-    .parent     = TYPE_PIC_COMMON,
+    .parent     = TYPE_I8259_COMMON,
     .class_init = i8259_class_init,
     .class_size = sizeof(PICClass),
 };
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index 8ceb5841b9..e2f997e161 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -56,7 +56,7 @@ void pic_reset_common(PICCommonState *s)
 static int pic_dispatch_pre_save(void *opaque)
 {
     PICCommonState *s = opaque;
-    PICCommonClass *info = PIC_COMMON_GET_CLASS(s);
+    PICCommonClass *info = I8259_COMMON_GET_CLASS(s);
 
     if (info->pre_save) {
         info->pre_save(s);
@@ -68,7 +68,7 @@ static int pic_dispatch_pre_save(void *opaque)
 static int pic_dispatch_post_load(void *opaque, int version_id)
 {
     PICCommonState *s = opaque;
-    PICCommonClass *info = PIC_COMMON_GET_CLASS(s);
+    PICCommonClass *info = I8259_COMMON_GET_CLASS(s);
 
     if (info->post_load) {
         info->post_load(s);
@@ -78,7 +78,7 @@ static int pic_dispatch_post_load(void *opaque, int version_id)
 
 static void pic_common_realize(DeviceState *dev, Error **errp)
 {
-    PICCommonState *s = PIC_COMMON(dev);
+    PICCommonState *s = I8259_COMMON(dev);
     ISADevice *isa = ISA_DEVICE(dev);
 
     isa_register_ioport(isa, &s->base_io, s->iobase);
@@ -118,7 +118,7 @@ void pic_stat_update_irq(int irq, int level)
 static bool pic_get_statistics(InterruptStatsProvider *obj,
                                uint64_t **irq_counts, unsigned int *nb_irqs)
 {
-    PICCommonState *s = PIC_COMMON(obj);
+    PICCommonState *s = I8259_COMMON(obj);
 
     if (s->master) {
         *irq_counts = irq_count;
@@ -133,7 +133,7 @@ static bool pic_get_statistics(InterruptStatsProvider *obj,
 
 static void pic_print_info(InterruptStatsProvider *obj, GString *buf)
 {
-    PICCommonState *s = PIC_COMMON(obj);
+    PICCommonState *s = I8259_COMMON(obj);
 
     pic_dispatch_pre_save(s);
     g_string_append_printf(buf, "pic%d: irr=%02x imr=%02x isr=%02x hprio=%d "
@@ -146,7 +146,7 @@ static void pic_print_info(InterruptStatsProvider *obj, GString *buf)
 
 static bool ltim_state_needed(void *opaque)
 {
-    PICCommonState *s = PIC_COMMON(opaque);
+    PICCommonState *s = I8259_COMMON(opaque);
 
     return !!s->ltim;
 }
@@ -220,7 +220,7 @@ static void pic_common_class_init(ObjectClass *klass, const void *data)
 }
 
 static const TypeInfo pic_common_type = {
-    .name = TYPE_PIC_COMMON,
+    .name = TYPE_I8259_COMMON,
     .parent = TYPE_ISA_DEVICE,
     .instance_size = sizeof(PICCommonState),
     .class_size = sizeof(PICCommonClass),
-- 
2.43.0


