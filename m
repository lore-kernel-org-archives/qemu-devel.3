Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60E7C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 11:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8cK9-0005fR-BB; Mon, 21 Sep 2026 07:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8cK3-0005d3-AO
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:36:35 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8cJz-0007sM-3Z
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:36:34 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LAfe5h774089; Mon, 21 Sep 2026 04:36:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=9oM+llgxg3umb
 YnE4016OyxcXvsoMEyZT+sWCktBmtE=; b=FePYhIaBk5pML8NyMJ78GT6tVI5nI
 NNHULRoFa5TdgRI8ER6+KMTo4eV7z2slZVfcOYvYS3mw4QvQv+sMXLhOnVvn743/
 9GS5ygmPh6mZPUlMQ7xl8mYfmCktBiGBvRH3X1rsZmZCDK3TSvaxAWQL7Q+Lq8ni
 2kPX1U4Jb0LD5NfLuLQXNQCqOYwp1Rpn/j3av11soT+oV6G70d4QtpmJ0OxeDIOs
 HWfh8ikmChvmXwEj0lzYVenJPimix2tnYN5BI+eiLHAL/0BbZeQP4givub/FVfTo
 WR09SrTHcntSd6AuTazcTmEwUzZmz0wNYPfj905ImlGy59MV25ZSVCglw==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020130.outbound.protection.outlook.com [52.101.201.130])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gsqx82xa9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 04:36:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXm4MrSnSg/zh5ikx5dCpCwAnFzjE0fR+4Qf0/UQZC4AVsYSy0e05ba77flDpwcIlY7lfYNpIrJnvfO02w52E8KrRUmaBBmcqOcROzuB/kCnIuLqUvsbM2cUrbgP5EeOMqTMiQYxteK/pnUBe3AT0nrHVCc8S0DqN2Roi3os87E89SgqNlCghhb+jlYJdaQDkALOLtW+6RMkXyRj4zfomJ2ASO4Z3t3KOaa0UQAsX4+TibVIEBX4pnyADOpTCrXrE6Z+GKbHHHP8ryr4wuyUnwohmfnxx07Bw6/QCrp2IJivyC04jaTTufa87BWZ/F/QPYdvvXP32sLzx5fGzXmlsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oM+llgxg3umbYnE4016OyxcXvsoMEyZT+sWCktBmtE=;
 b=XktoGfedLADZq/iCi/pPh1ou7AUPpLBcgzM/d6+4+uw596xVFQXW0FdnnveFVs9kxRIIrzo1OzsKk6Rc9HmpXqEYlBikXNvSpPKy3DMBOM5y0ydzSV1q2Qesf6iK7bZERH2z13IkPWTmxWFOx4MCytpEIGAdaUjqBMbVKoBRmz+jo1gv3g6oSlAfhkDO7gHlqe48tt6Y3ScK5Rl3dZkjuOJFMF671a/UcQp1Y679stkDnmv8AtxtmQh34Lnjvcwt/eGgh4/T8f+BMZH60FHqOrHym2DnKcqjxEpMYnV1EvlzcvZT0EHDMOO8j/qEuCUdXtEelEoD+4hyXDPWsMza/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oM+llgxg3umbYnE4016OyxcXvsoMEyZT+sWCktBmtE=;
 b=egQ2iaZpsPd6I7W0b50UW323ZFVrkAFfOgDlMOj64krKDdKV215J4d5MzxJfF59h25426tdlttm5GJy9M+ucN/EgfnpUEr8htM0yi9oiYPXpAET6JsTUzUHXZtITmnJpGJN4SCmoYOwfMRzhzNPQQxH7qUlWOqBp157M1ZeBZESQWt2UgSYemAxijSkZ9zlw2Ih5XWlzJ2IcBQzbOAEUfrXUDCLyWgQw6AmCd+PiKZbssaBvpGhSQ1mOJs9y3rttZxzVqJ2icimDWMENrJk4NK3A6vGR2z82sjfQeEdfagNYjS7fAd1eNt2Wnp27pyX+wBLBcgpbtQo2RahFI8W/OQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA2PR02MB7642.namprd02.prod.outlook.com (2603:10b6:806:149::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 11:36:03 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 11:36:03 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, marcandre.lureau@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH v4 0/9] hw/i386: convert object props to class props
Date: Mon, 21 Sep 2026 12:35:06 +0100
Message-ID: <20260921113559.1299740-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY1P220CA0040.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::16) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA2PR02MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: e014378a-4524-46b6-e750-08df17d48403
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|56012099006|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 5wBm4jVqpCXunBWA/gciqlODgYJquEjRydpqNRRepKXmrIYvamHZIrvFlbSUjtE4yS93PvQkCw1P1IHuDDwwpeHnFkTuFDRYtSdT3IbRk9dM1r3N6R++yBl/jaAR9p0qxUCHsDicMIrwVBzignrs9Kv7nk1FBST+J25noJ36WzFcBk5czEVsA8uXELy967xi021XIUF5pUbIWt9UE6/ft+WPBegawWuWZZLDGVYwML/AbLWmdr2085E1QlOR6CMrG1kQGqYz0G1SLbU26uGkqzLOp/Ola8VsTlA3DXkciHw88rrLnakCZv6UUxGhaUpkfV2z2bDrN4maujx98ZDHsU0IhqnFw74H+CDh5rUyvDVQuTfJFBB8vqb9cMRCMOonZplS6eBi92i1HQ5hJjkxqiOQzxrhZIG6KcSXKoBgNKK34m6GyjmZ0MXnoZeH3OpiOgOZml3crt3sibC0Fpt2WAk1ImAOK9hJay8tm+oKf5Hl90USZeGax/90qAfiAer0FJJL0Npvk1JCuvgxhFR81JycJPCq/VPLtRQ2Uql7q/Ur93TAHpxGWdKVWedSev1NkL51fIxrWfs6tyQ/jnXA0xoJBLblKZhObu7XeP03pSekpXZ+xmP282JPqJB9P7Ud14ozEhpvLFIkDsvLHkD8Yi5GygKYX9tkLVzVMZMmaLs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2ErakNPaDZ6M0hUanRDMFpxUTFzVE9DR1hIVE52R0x0NWR2RjJrLzdRcnVq?=
 =?utf-8?B?YzZDSmJ3d3JISmhQa1M1TzJQaVlRNGhRVHFTdTRSTzZsQlhrZTJySnM1a21B?=
 =?utf-8?B?czNSUkxBK0J6UnJabFdyWnpuUHhzY0YyZ2R4T3llbjhnTWI0Y0lBT1owY3dJ?=
 =?utf-8?B?WE9NMUlqWlorOTBPTUhpNGdBSmN6R2F5NVBKWTdIRm1uK0o5OUZpR09TL25X?=
 =?utf-8?B?MW9JMWZTMjNQbWc2Q01JaTRBVW83K2kzb3BpQnVMWXQrbDZsbVBWWGh5Q3ZJ?=
 =?utf-8?B?Qk1OWjZFR2EzbFhPaG0veUxOcW1LK0J0Yi94Nmdpb3N0TTFuM08zNEJZMitF?=
 =?utf-8?B?Q3RHUnc5b2NWRDNid0cwaFJ1KzY2ak9yck50SnBQa2RZYkV3VTU5RnRwVXVa?=
 =?utf-8?B?dzJ2RFdhcHVMdmptQWg0SzBqQStVZHU1QVdHaGhWUXhHWVhEK0tTR1F0d3dz?=
 =?utf-8?B?dk9ZdVg1dzBYTjFidjErc1F4WDRYYmlzK2t2d0ZHQkdNSTdzUStJSTN0THRT?=
 =?utf-8?B?by9OSjMxdnhBL2Q4UlVRT0g4Y1R6V0NXaXovTWo4dDBJZFpwbmZyczdITU9v?=
 =?utf-8?B?b3c3WGhmeWF5VUxva0c2V1FDdEJpWXZyeVY5WkZjOU1WS1Bub0RoTGtERnJT?=
 =?utf-8?B?N3NON2EzM0hxeldsY0t5UHNJRGxZYjM2bVlaRjlDcGVraTdhYnk5YWJGZUl1?=
 =?utf-8?B?K3preGNsdlVQYWcybGV1WjYzdktCUk1PbE9LKzdwenduOGM2K1lWMFpBdlpC?=
 =?utf-8?B?eEtvU0VtbHp6NWtJcUVDczgrQU5UMUhDTDB5K3FieEVJNUhRUE05bFVGMjRl?=
 =?utf-8?B?a2VUYk9yeWFqTlp3eTZSQWNkRkwrditTRzVteC9KbnMwNytQUGVWTkQreEF6?=
 =?utf-8?B?a0VxbXJGNWNITVhHSmhwaVlYSG5pa3BveFRpZWVVWCtsbjlYMEVzUFVFaXp6?=
 =?utf-8?B?b2grY3hFeU4vY3YwdWRHZVVVTmF6bTdPamVjNER1R0wyS3QyeWtJcXJRU0tL?=
 =?utf-8?B?V3c4Mi80OWVvSFdxVXJ2RVJZZkRFTHJsT2FydURrVnh0cm1hV1dIczltbDNi?=
 =?utf-8?B?aWxmcmdvZWFGT21CNjc1Z2plL0JVL0luLzdyVlk3Sk1PcEtzVzZlcTQ4L2FV?=
 =?utf-8?B?Q1VFKzNsd2xLbXk2R3dPcFZpS05ZQXo4VDM3d2tPNGpSYjgwbzBjb0ZqZkxW?=
 =?utf-8?B?S0xkckdaSFdtUzYrVllrdHYvckROekRHSTYrUm81N1hKQWJUc2VBSzAzSGxT?=
 =?utf-8?B?Q2o1S1U2bEdTdVZ6SnFvQVVTYXVWazVhQ0FTb3FZVlFmMXVYdHVrTjJoNlQw?=
 =?utf-8?B?WXdvTUgxWENsZndzbWFPMzVJWHdjci8rbGhIaEdhUVc2ODNuaGc1UHpnc3RU?=
 =?utf-8?B?VmU0ZDBqbTFpZ2hvTko1OXFkSXpZYmtZaWZCTnhRWU9sRmJCTWZhNzFJVkti?=
 =?utf-8?B?Szc4QnpEejUwclBsa2xxS0QvLytCTjNXVE9pbnlYcDBxczBXUVozbVNLby9a?=
 =?utf-8?B?SlhHNDU2Uk00OU1FRzBsRzJMRHBFb3g1SnNqSzV3TE12SU9hSkZpMXVyRDBn?=
 =?utf-8?B?ODY1RG1jSXlsaDB3b2VxdlJTaC9wY3pLa3lFYWJ2bEJidDdWZENybVZjMGtX?=
 =?utf-8?B?anROSSt0MDJxZnFCYnJVQmhQa1UzUlNUaVZXTWZVTEtpUWxCRTkzRHZGaStD?=
 =?utf-8?B?a0pKZHpaUXdscjBoNnJvRTFiUmlzQ2pXRmkwKzNRS25PdFYwS21IZTM5SE5H?=
 =?utf-8?B?bEFmSDFDaTJ4L2d5R2RuNG9uR2NSSXZuUHZCeEttQmRMKytER0FVbnJId1o5?=
 =?utf-8?B?VE1RQXByM0U4M1dyRDJ5SnMvTUJOTUt3eGgvK0VKVk41Q2JkQlFUa3dBeDJW?=
 =?utf-8?B?RC9tVUl6cUloYjZZMi9sdEJLMkpTVVM2ZUEvSDhiVjVTRDFjY1p2Zm5KSVUx?=
 =?utf-8?B?cncyM2NKNFpKQ2RtaUlMWkIrb0hNTUc5TU9PTmt0cTlhYjNhOXczcU0ybGds?=
 =?utf-8?B?SkF1Si9kS2pBWTh6ZkZkU2w4K1oxOEREUENORFhlbUQ3cmtVV0FNN09FZ2hV?=
 =?utf-8?B?a2JhbWthU2F4NkN5QlBiNzFqdldHR2E0ZHJ0SHNuRlJlL2VvaHYxbmEyMXNC?=
 =?utf-8?B?ZW9PQ05tY25TWUtzZDE3VE9INzlzSTgrbzl1UEZ1TGYxRTR0WnZWWmZvYjM5?=
 =?utf-8?B?cmhmbVdHK1Rlbm9QcEZXT25seTZHS21naVRmWTBJalpaeFZ5aFUveHBNT0NL?=
 =?utf-8?B?U3ZySGtCKzVrMmdMMmEwbmYySTV5UmlmV2lDVGNrbGdWekIvYUlXWThHS04w?=
 =?utf-8?B?VGYyeFA5RFQ5QW8xbEZnazFTTEdVT21SdS9wOUNiTmZIT1d3dUt6QjhGRjZ0?=
 =?utf-8?Q?xqiZI3V4lMuiRyBE=3D?=
X-Exchange-RoutingPolicyChecked: TU/MeDZFsK6xwF2TvAgTaPFMbmfRUvAWufBZH0KZ1YYKnFAG+sXeQ3E2GBE1Et20czMTTujT79GQPtlxN2SFlFNoLzCb+7djccvfIR39EWCGR4YICoWzT1D532qA12eTk011jCbll0TiicRmY95zI8gKZefs297AmMRG/834xEQDtSNAx2YoXndgUkbZvbFokvup2LGVNgR7APWdXOqKtit/853HmbDomPjai03/2z0gPD+ovDPyKiorr+6+BjGdB9HBVOVFovxh22pktGAKXxQulZlhMUZ0dF1AMTAHvis5QUTlS9Ok59WlhS4lyE6gybDlWyl4j17Sv3AiZA99nw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e014378a-4524-46b6-e750-08df17d48403
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 11:36:03.0196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MRqgalUv681TW+fsFCOHVq3cnuoI8GeGb02jRlN4RBoxniaUW+vloljU0pMRi3Gxfn8NXz71Slao9wsVYABWidwqo6AwZoFXeeUri/GMU8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7642
X-Authority-Analysis: v=2.4 cv=KInPn1Fo c=1 sm=1 tr=0 ts=6ab116a5 cx=c_pps
 a=pt2/1SnMKDLj9q/aNz1zKA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=3DywOP5MjKrXQ6y1SsQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Ua9ZAgzVbmwCuDjaCJywS0fwaKnGvM9w
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE2OCBTYWx0ZWRfXwUnGyrEAWgla
 M2Szw5YmuZwrpf+AAbl/VDgE+Z+xK24fD0/ZRlo5NWRDA+46PZfwAG4oBXUF51ABAQNpmLOFz23
 INhnycWwEmSHuetE8vg0agJKWUjee3g=
X-Proofpoint-GUID: Ua9ZAgzVbmwCuDjaCJywS0fwaKnGvM9w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE2OCBTYWx0ZWRfX153syAlYhVlA
 XcXh46kDtctk2t/ACHarstasaWv2FU5N8PicUWr7dG1L4TlZKANm0Liz2MMPpkJhKLqWFlAVb4W
 oNyZafnC+A2EvfyGD+1So9dbdqz33x3s4l3gCXtYdS+go+uZjWE3Y4PzO9a6wWa5f9o7lSws1XO
 ewo4c/2jGPW7QCDnxZxjFpRSH5y3fvyhNKLz4kBahhqfrQiHUwdcKkYQ6pYSytOD1/Nsri4NF+o
 Teoo4K/Q47Q6yIQXxEeAOMG8VD74RdPamQx5toqtZ6dSg/HRQyeHpG7RqlJ066WpX2g2GwI95Fh
 etg0sX3QCsI6LUaDMfshPEGyr9htwBK9TBR+90QxOjh2Zs/Faco7lIzOQEKJbyADDwwNB46+Rm/
 VFzGI8oU+Pi7eRdiBKBaGQPZ+kEBS+90EphdvN3OF4G2asI06I58XitYQj9EHkwDljfS36JGGVX
 bX9HF0BTvxgegRLmFpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

Since the use of object props is effectively deprecated, here is an attempt
to convert all use of object props in hw/i386 to class props. The eventual
aim is to continue working through the codebase, removing all remaining uses
of object props.

In order to facilitate the conversion of alias properties, this series
introduces a couple of new QOM functions: object_class_property_add_alias()
and object_property_set_alias() to declare the property and to set it within
an instance accordingly. This implementation is hugely inspired by the
existing link class property code: many thanks to Marc-André for doing this
initial work.

The series is lightly tested: it passes "make check", GitLab CI and some
simple local tests. I'm mostly interested for feedback on the conversion
strategy, and to get a feel for the best way to merge this series since once
the basic conversion patterns are in place, the same patterns can be applied
elsewhere and it would be good to minimise the merge window for such changes.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

(Patches still needing review: 1-4)

v4:
- Rebase onto master

- Add patch 1 to make it clearer to developers that they have introduced a duplicate
  class property as suggested by Daniel

- Remove extra semi-colon from property_get_alias() in patch 3 as reported by
  Marc-André

- Return an error instead of a null visitor from property_set_alias() in patch 4 if
  we are unable to resolve a target object as reported by Marc-André

- Add R-B tag from Phil for patch 5


v3:
- Rebase onto master

- Add R-B tags from Phil

- Add kernel-doc to patch 2 for the object_class_property_add_alias() function

- Update refcounting for alias class properties according to the description
  in the kernel-doc for object_property_set_alias() which is taken from
  the existing object_property_add_alias() kernel-doc


v2:
- Rebase onto master

- Add R-B tags from Daniel

- Update comment on patch 7 to explicitly describe the change in behaviour
  of the pflash0 and pflash1 PC machine properties


Mark Cave-Ayland (9):
  qom/object.c: improve duplicate class property detection assert()
  qom/object.c: introduce object_alias_get_targetp() lookup function
  qom/object.c: introduce object_class_property_add_alias()
  qom/object.c: introduce object_property_set_alias() function
  hw/i386/pc.c: convert pcspk-audiodev object prop to a class prop
  hw/i386/pc.c: convert rtc-time object prop to a class prop
  hw/i386/pc.c: convert PC_MACHINE_ACPI_DEVICE_PROP from object prop to
    class prop
  hw/i386/pc_sysfw.c: convert pflash0 and pflash1 object props to class
    props
  hw/i386/sgx-epc.c: convert SGX_EPC_SIZE_PROP object prop to class prop

 include/hw/i386/pc.h |   5 ++
 include/qom/object.h |  42 +++++++++++++
 hw/i386/pc.c         |  29 +++++++--
 hw/i386/pc_piix.c    |   5 --
 hw/i386/pc_q35.c     |   5 --
 hw/i386/pc_sysfw.c   |   7 +--
 hw/i386/sgx-epc.c    |  12 ++--
 qom/object.c         | 146 +++++++++++++++++++++++++++++++++++++++----
 8 files changed, 212 insertions(+), 39 deletions(-)

-- 
2.43.0


