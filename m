Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C188C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzbBx-0008Gs-8s; Thu, 27 Aug 2026 10:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbBv-0008G7-L2
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:34:55 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbBt-00021w-Oc
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:34:55 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67REB4FP4101189
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:34:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=eFbKjEeCaRowT+eEg0L30Ma1UbGRnABxFyfYHYPkL
 pY=; b=2gmrEFBDgS9qA/WB9rCev2OcMYTyo5hSIZSzpxAsskQIebOq1bGwSpHKB
 FqoCE4GS8SU/t3i4EigVNbndlSK2xXzADCUrCFha2qyhWhbjVUr354d9WhiLY/1F
 TEu0YRbN1zU+vHBAbKAsY8I3oTP1oC+qMbGua0w+FcEuq+5XB5CjCV2Wr1IbXw6i
 rB/4SsE9EXWnZxQXlb1ReZwIFoYmDS4mjmfs+ou6P/2KnN6sDlFzm2um/BtulNu+
 o4IAmaAsvvmx27XhrkEfxR2cGkrkrS17wrxftOzpJnjKE3bM+6ZDa2B9Gn8SEE3l
 Bnc6tcd4U14wETtFELsJaloshWFPA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021099.outbound.protection.outlook.com
 [40.93.194.99])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ga8xmsuf5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:34:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWkLojBygodkxMR279FBYEcrjflbeC77ebOMrdhvQursxWr2FuRxdN5l5iGFRp8KI0x/ZNGGKcyMvIs+Bva6HlxYIcHZHf9jO3IY61Me3/hT4Zk/0R6cYBthiD6eWtgBpow5mV6/bcvkKsZT5fizrPLm9Z5PxYi32DbZ7vcHXRKpx7YFXuOzipri9FmqqbKX8VQpjrf4wJHxNlSs4KjkhjEAXrHyaCDE3zh+sd/vmoDkju+mxUVmD9KUT7vULMR6LwYCIxuRTJbdZ/RZXwci6YvUHPEpL0oHXfKcNnD8o85aYBVwIgcDyDkR3J9FtFmF0G/8FISSqjwu2j8Bra2Evw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFbKjEeCaRowT+eEg0L30Ma1UbGRnABxFyfYHYPkLpY=;
 b=dLOF7lzFaCqfbScU1/U8KJcdsYOpQirWlk83u68NvR3v6aZvlDVo1nvl0Obe18S7u8r61F8vQ5KdCSDX5ZNg1gUHi8PSyYOArSx9aoxCh19xDH3jWXIX74x3lm0VYUKTBBf6BWpA1q9oV9Tamp8RgmffujZN0K8m/RgEwhNJRS5fSlvFnHJH0EZWZGuS6aumTcKl7tq38rEuu4ngDWaa4FwYYiKD3IZa6UxE4l912TipJnpNMeXJ7JTver7AXNU9oKUksIDGKFR2ONYGhg4e+ZdcQcqmhFUCJIJM43BZW+b+GUD86lOq0+xsrwd+dzwIfPzL9eQbnHLW/pSE98W0oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFbKjEeCaRowT+eEg0L30Ma1UbGRnABxFyfYHYPkLpY=;
 b=TBC3CZVxlNNMKs/3CpNtN4CdBmtuNQ2muHXE6Efs6PxCDH64gSm7mSIXjYET8xaAvOD6i7BwpHa8tAO4wcndhcG5uz6d+P9qBhRtrkJU32i2wxMWDoxqCy+LeX5quZL4qoeCG3JOx2KX3UAS6MoQ+HCSNSlc0oTIWqSVOnsGhqU1mRjOzexaIqXRGmopeAEwoMGn3FALilcYpoAykpkachjQR0j2/C4XSAoUQmDjF5Dx60d0E3dOCZXKxSoDoB1IXnmP9w7mI/TAfwO5ExM0oOvY5xUHV5SsR/uJM4udgeiFsPIFO/FVU28pOv3HG1sa/+mHDl8wiYA3jC1RNWWaFw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL3PR02MB8114.namprd02.prod.outlook.com (2603:10b6:208:35d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 14:34:50 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:34:49 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/16] qom/object.c: add object_class_property_add_uint16_ptr()
Date: Thu, 27 Aug 2026 15:33:33 +0100
Message-ID: <20260827143404.1393166-13-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
References: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0007.namprd21.prod.outlook.com
 (2603:10b6:805:106::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL3PR02MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad46823-965f-4f8e-1d62-08df0448581a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: k8qh+AR3n62+kuZ+ac6Yc91RcecMqq5uKIpmuEQdHmQkjk3T/2Cg+EYZq2jLNrAidnm2LomWPHaUplxYG+tvRBBsvqotGELStJNtTJC7INpbN0fE/tahkIS/Z0RwoJthN9CzWkYsSOTODehUkq7N/aYJwMADgUkAedA3XNEce1KoZ7dyio0Wik0RClNp8H1KmgggsZdXuvkFKZ0/LQXVEyoZBfX6VFTfM94U+2uHprQRBBmBc98Z8URn7PB/P1Km/gUx/X6WEZ+OSwxg9HfAVgHp6do6u6B2M1d01L4SUXr34km0xtnJmUC2/qgq7eH6KZj+Hl9/TOtR9MK+VwlCqEsEsW0Y+3W9vIqiwMOi3hbXtbRWtY1tQDluXa3A/jfOZKkFMl45bFiIj5FN7ASTyag+X7mxd60EWJUlhkcNGjyN8czNyfgWzL1jK1h0Is+lWHS6HftRFKSTjHkBARs9M170BHUmphzrGQXD4w29IZV/+mSpYa6HWQE5db6349B4RqayHFn0EKEglvgHDhuinkq++PtAv5f/MCLKLwxUC+ZooAUEASsvmkdIfinyZVRg86D9dOm9Y8TscEnIPzdP5uVnZ5NFTmCo4SeSMQFVM3nf48jgv5cPXK+UikhADocdnvwY8dcCDHNNxnnpS74JqsTr2P4PqNyARCZKz+hPBho=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUtUeXJBYm5iS3czbnBqMys0aEhvTkkvNUEzbU4xVy9PRTRXYWEveW1CSlJh?=
 =?utf-8?B?K3RWSzliaDFiSTVJUWJ5Ui9xODR5dzR2eStDRzdoa1hhdy9GWkE3eG1lK0hl?=
 =?utf-8?B?T2RIakdSaWhQakI0QWR3ZmsyTWdqYXkyZTJWdndrZDJKc0ExWkZXa3FoM29R?=
 =?utf-8?B?RDB1WDhpbUV2L0R6TWo1K2F0MnlDeXJ5L2Uyc1BreHBZMi9lU25jRnVkTXpV?=
 =?utf-8?B?aCtWbzJNQXNodGlKQk5nbGQvR1UyMW5qc2ZFMExPbVJwU0RQZVloYnpPdHVB?=
 =?utf-8?B?djB1NEEvSzZtSHpSbitaWFNOTVp4cWZtYzNVQkswR1h6Qk0xK0dqd1ZkcHN1?=
 =?utf-8?B?a0xaSVI3Vlh2VExwamR3bmVFU2lROGVwZmJwRlZXb2RhMUxLc2NVcnFRTnQ4?=
 =?utf-8?B?dWJUZWh1aCtIelRSREdMUElENG80aU5CUW9FQVVkRFMycTQrL2dkai9HYVgy?=
 =?utf-8?B?eFBEbzlUdTl2dW4xNFlJVE44SE5BMVZxK2hKa2Z5ZWJ0clNxN1daYWRPMjVL?=
 =?utf-8?B?MTZ3eElVME5raWVUcjhGcW5TZEZzUE9EaGJPNTBtVno2eTVVNU5ORWkwSnU4?=
 =?utf-8?B?bWNLOFRlRGc5MCsrYTFESk1pSUxrNGdkbFFxdWcxQWN6NXBaS0J3MGhzTFdr?=
 =?utf-8?B?blBya0praXd3K3Rnbm1VTXJiek1ZRGt4bVFrb3dWSjJpT0JFUjJERHhhb2FN?=
 =?utf-8?B?TWlCK1JwRVQ4NEJUejBsc2ZrTE1FTXBCc2hLZndqOEdmRkRyVklzeUtyUWht?=
 =?utf-8?B?dExKb2g2R3RicTF5dHhpMXNham9NdGpocU5MZzBIMzZQNG52Wit3bm5Pa1RZ?=
 =?utf-8?B?TFN6LzljK1BaTUh6RVFtUERwVFA1UUFUdGdVbitBZjhUeXpUS21RQWc0WDNj?=
 =?utf-8?B?YXNlSzkzZ29jREU0bnhVV1R3QVNUUkNjbDl1SVlEWmVBU1NJK1JZOXJacWZp?=
 =?utf-8?B?WkYvaVNLbWNCMklNS0JERVpLZ0hRRXpLRHJvNldEQjRlY2x1WGhpakY2TG1l?=
 =?utf-8?B?MlZEM28xUndPTmVtMVlvUnl2b3I2WE05WkZmNDg0L2JWWG5yUlR3aW9TT2xC?=
 =?utf-8?B?NG16REVmdGlLdnVnR3A1UWN0cnBEc3AwdUs4cWprNksyZzE2cGdESTF1eith?=
 =?utf-8?B?MFlYWmk4ODBlamFlU3NmV1RTcG1rTTFqays5L1hzREpUVUlRUDFtc09YbFBU?=
 =?utf-8?B?SlArNEcwT2ZBT1VaWDR4MnJRYXBFbFJpM3lhLzI5VDVUVCsvOWhGRkY5UVM1?=
 =?utf-8?B?ZUVWT2J4cHJ0SnFaSTFDT0c5ZkM1d095M1FQQnV6cFhkMWNlUUdkejFjcjZ0?=
 =?utf-8?B?VXNoclB4UStCenRvU1hId3ppZFFnVnZyVUwwNlJIN2NESklWWGg2QnJsY2pT?=
 =?utf-8?B?amdXb2hyWjhQa0MwZ21tUHBBaVJidXU3VVFQZStMbk9nN1FBUXUwU0x0bG1l?=
 =?utf-8?B?QUxpTkhmenVzanR1eGFLeDFGOU5raDEwSmVDTW1zQVpjUGhNNG80M1NRak5j?=
 =?utf-8?B?NHRDSUlrYTFQdTIyaUhwaVk0bmw2bklCMEZoeEM3aU03MUQ0N0xNTktsV0Mr?=
 =?utf-8?B?ZVlEcFNKY2Y4bGpNMEd1aHQwUngvb2RhUVR2NHRrNzQ3N3BVd2xjUjR2eTl0?=
 =?utf-8?B?bEdXOERqMjNZZU13NWFiU1FURkQ0MkRIemZLWHZGa3hYaTFzcEJPMmd5cHBQ?=
 =?utf-8?B?SWtmM09qME90VXcxNXIyT3dZVDIxd3RTZjdzNDI3VytJRkI0LzBSeHc1TXNl?=
 =?utf-8?B?dTlTYnZva2tObmQzRm5RR2hzR3FHU1RkalJjV1RSdWVNcjZGYWI2d1VIQy8y?=
 =?utf-8?B?M2xxY0d3UUxWMWFVcVFxNkxqTGVzcHh6aWpYcUNtTG9ydFBZV1dLS2Yyd09x?=
 =?utf-8?B?bnJQeUJwbWJheTluUHZ4Z1NRakRtVHR1b0t3MG1RY0dvY1VLZm8xOHBTQ0Ey?=
 =?utf-8?B?WHREOS9vUWJwZC9VL3lxRnF0VzBXZWtGTWNPcWtoVkNRUHF4bnNncVQ3NGs2?=
 =?utf-8?B?alEwa1VFWk9CSnRBc2dpZjlYbmQ5SGVBb3FybjdVbXVKWndZZVBFU0twaDdT?=
 =?utf-8?B?RjRtdHVHZi93QmpXcVMrU3NlZ29Dc3dSOGtFanZRRnBFMXBBSjdBcmJ2Zk42?=
 =?utf-8?B?b0VvOVA2VmxURDRWQUZjalZ5d2gyN1BuR3JUNUt2VG9ZS1ZCc3Q2blV4dzU0?=
 =?utf-8?B?Q1Nsek9kMUFuWm8wbXlOUE1tTTZwZWZsS2ZCbGtwa1FhVFRUbmZMWEhrdGdn?=
 =?utf-8?B?eHdHY3FYTVJqNnJSYk40YytYTG5rMzUrUDMrWUpuSnVXL1RkN2xWSXJIOUcx?=
 =?utf-8?B?aTFhSTluVzNmWFg5MEhzay95K3k2bStYU2hxOVJTU2c1ZlhrS2FTN1l4WkJa?=
 =?utf-8?Q?vd1IpEc8cjV5ZII8=3D?=
X-Exchange-RoutingPolicyChecked: Th8kupRH4o5rwNPzGM25g/zGNO1PUN75mA0PTDRRubs0npybCTLj0Ey9B7LtzjCDRSJwRubJiMD/rGY+WvZX/rQ/U+JcZVlmDuHoWPcKMe1bi5GdUjcctuA1RVN/cpmOFIfnoo4CNdz4f+BzdXZRZzI1ZK/ugfe62iXx/5DOKI6Xx9GmvpjheJLO/zn3XKhlfe8CTJeeasCrN+U+ve6MalE+9tk4wL/kVvJMP06phU+sB5uUKng4p/OOXSsnE1paTh1oxvhI6qu/SzRwNcUB+Yh+ypz++xDe53WoHpIuwlEeOIfmj0pSW8PsXLc/dy+be7cQagukzCbI2ckx7wmh5w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad46823-965f-4f8e-1d62-08df0448581a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:34:49.7742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +SL2y1dkgflI5WvyxdA0oogvlrBHjLVQ+ZYu2+3BKieKhl2d3YmJLKc80gJr3EsUMQ7tsXqTPumpQ7WOPjL03XzOyWAw9ycalqbbQK82onU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8114
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfX3g4tdO49UrVF
 yyxbP1siZSGsPA/89ZXg82MZL8PZSGLTSOr2kPgewwzTgbKLbJa8T3X8kB/bVz2cWCHXMdHXlq7
 +XRkyiWSHCpZhe+DKMgcp0Lfoa/q5rA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfX6qfP1whOn/R1
 FQ1AcKMxWOyY6L0AnOIy1zHQYDzkOYMaQV9VDGQ+hW/sPsFmWUK5zRbpJltb4xQg8zTvylWSsdr
 SXg0EF0FixCD5Ksa6ZMCXEv+1Jr3Ah2RrXwjN49bKD0a/dzF4m5BNBjEa4dJcEAGZomBQyTlEfJ
 E3LDIeAOWFWK7Vnv8y9JpXUAb3b3zr3EL0rRWoZNg3hOc21DlhnT7aTqN+CzPfzuFt34gYIWMcN
 QP/pjM12WBd9DpPbYUdvItGfytZpQUqzmSE4I0N2nCcnBJANJW8Rpfmsy++XbdR84PF6NVfil/y
 39D9dX6P5ZUKf4nT2NIFKWjD0ZonX1723K8rrspCUxPBhFMUTKtqrcdvuj1Gx0ZIPriBTTt/ZAE
 QJX2tT3K15ZA0APYa960QDjstWjbg5+py0LbngsK1Scu1lyg9pbi9mpKfIAQ0GfrVGnaPog9mdK
 Zsf7RPLhX4w2PqX+c5Q==
X-Proofpoint-ORIG-GUID: DpL7xb7BFDKMp6BYe_9S50B13386SzfK
X-Authority-Analysis: v=2.4 cv=Z9vc2nRA c=1 sm=1 tr=0 ts=6a904b0c cx=c_pps
 a=MAB4nyKqAzWELJb2TLvteg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=4QfE8SPBBHYfMhEiUa4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: DpL7xb7BFDKMp6BYe_9S50B13386SzfK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-27_01,2025-10-01_01
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

This adds a class property that references a uint16_t within the object instance
and is intended to be a replacement for object_property_add_uint16_ptr().

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20260825134320.1039012-13-mark.caveayland@nutanix.com>
---
 include/qom/object.h | 18 ++++++++++++++++++
 qom/object.c         | 21 +++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index de37016ba8..e24f0a2b2d 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2108,6 +2108,24 @@ ObjectProperty *object_property_add_uint16_ptr(Object *obj, const char *name,
                                     const uint16_t *v,
                                     ObjectPropertyFlags flags);
 
+/**
+ * object_class_property_add_uint16_ptr:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @offset: the offset from the object instance where the uint16 value is
+ *   stored
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an integer property in memory.  This function will add a
+ * property of type 'uint16'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
+                                         const char *name,
+                                         ptrdiff_t offset,
+                                         ObjectPropertyFlags flags);
+
 /**
  * object_class_static_property_add_uint16_ptr:
  * @klass: the object class to add a static property to
diff --git a/qom/object.c b/qom/object.c
index 635eeeac77..85bbd7f9fe 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2742,6 +2742,7 @@ static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
     OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type)
 
 DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint8)
+DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint16)
 DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint32)
 DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint64)
 
@@ -2874,6 +2875,26 @@ object_property_add_uint16_ptr(Object *obj, const char *name,
                                getter, setter, NULL, (void *)v);
 }
 
+ObjectProperty *
+object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
+                                     ptrdiff_t offset,
+                                     ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_class_get_uint16_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_class_set_uint16_ptr;
+    }
+
+    return object_class_property_add(klass, name, "uint16",
+                                     getter, setter, NULL, (void *)offset);
+}
+
 ObjectProperty *
 object_class_static_property_add_uint16_ptr(ObjectClass *klass,
                                             const char *name,
-- 
2.43.0


