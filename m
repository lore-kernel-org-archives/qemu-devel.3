Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3941AC5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 11:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuq8O-0002F9-OR; Fri, 14 Aug 2026 07:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wuq8N-0002Et-AB
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 07:31:35 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wuq8L-0006ik-O8
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 07:31:35 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67EAdvN71366913; Fri, 14 Aug 2026 04:31:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=UQh4Lk7ovVHF440nsl/rYrOFDucHph8Ypj++DonEy
 ho=; b=wZwiCx3PESx4WlfGbNVWENSv9DTIKHj3fHJE8NJsPTOhV8JdLwdnwvhdu
 g8N+MJFS2/lTjIqmK7oN+Ey0yxjX5D8pX7Uq37TLzIlbsBHl4fCVqh3zlh0wSS0B
 /vMUu+bmqJxYhxlq9Vv4xsxHZbTHXgycNmmeFXcl9tTbjkeguca0bLeV8RmqCrF+
 zjy0fyNY17gAzW9Sj59F3PhEluZY7w/8nvXmccaprQtQYu06jRq1J02rGT5YuZ4x
 /6zeb90pFb7WipckN9uIC5p0m36IKn618Oyet066o+OGQ8rUjZqP2Wu2rME15wmr
 HmqB5VdW5DXsc7I2pxuYttpDZBXMA==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021111.outbound.protection.outlook.com [52.101.57.111])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g1p0ehe0m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 04:31:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xo6o3BJUMOviy+d5kWq4R2P8/LkJdG6oXavCSWz32qzNvW24jmIZ7hpCSSO0AmG91fbRYfSnHj2C0cXphiP3KqmXjN0acz0GHoJs95pRZ+AVga8B2/5x0e4r8ykAolHBuydfb5KhD3SSAKVHVxPkmwtK8TRRCxc1EHNLvbsGlk/aoRd05/xUFuIgnWg5c5dsR3p3HtAFg0nFa+gi8dDNCdi1a5z5oNwyhNozzD75pGKoy4Q4ZQ6f4QQ6swvWhgEhyN42VYeRb11YbJWb0zie75UbjvQgqv2UhX2nI6ixr/PCyw0aEKtzzSTYw5/zAFQ8AlFP6WZyFBO1V6dPeTOgxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQh4Lk7ovVHF440nsl/rYrOFDucHph8Ypj++DonEyho=;
 b=OQLLKJY4TWdVC6n5A/pSFhhqBjyEkfJFZ2LFNfv9y0E6Iz9jTPNwdko+brkOYPeHGjvs9WDqHtUtWncJNT5dIgVrWj4eN0RhLGegxfCLCkqR1aVyD1YtgiIvUz6TYZPvzpHUzHOo8ut0LBsgZzxZrgRm1dxDPbJpv0KH0E9pp7KblD55Kx9ao3Jh0o9YedDUwj9awMEoALHgzPci27PIpoIK8HLaDV6WWuv/ayj6GuKm+9f9SpAl2RjdZJWNR2SEmgq0OJiWtOuRL3IPuZyCkn3N1rBqDnKnJ/bkFIHOLHPsjjwRBFTSriuFrc9ieaMSjtOjIf3x0ZOEEu8zFUTfHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQh4Lk7ovVHF440nsl/rYrOFDucHph8Ypj++DonEyho=;
 b=SNhZ2lYjDZ8Lecozdo+meeDJYLVPMYRudXvSbATeppM/5J6GnpnjA53HbLBk3APTiPfeJiRRDUjLdqVhh4xDf++sPhoNfkk1NuVDGnGAxNekdTJwlZXfs6/7ZhcDFRPIhrEf10BxrW7x8f1euMbIN9B4YLWtuBWU/l+w3wQCDbhQU7z1jACPGTnIJWGhq2r4Mc5C/WRlm+eYP1mo6AndUaklgUhDD4DzPBGiK9pfijprvZya+Ib8C1tgEZtmP/jVEI/jgyfQcY3dqaCskKT4aUerlzmw86YYOCZzG7yVp9YdtqNBlVIEQX3gH0dZANQhpSD0P9G+X5gvdAWRJqY0hQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA3PR02MB11199.namprd02.prod.outlook.com (2603:10b6:208:542::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 11:31:29 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 11:31:29 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 4/6] qom/object.h: rename @child to @targetp in
 object_property_add_link() documentation
Date: Fri, 14 Aug 2026 12:30:22 +0100
Message-ID: <20260814113044.2416794-5-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814113044.2416794-1-mark.caveayland@nutanix.com>
References: <20260814113044.2416794-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0240.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:372::17) To MW4PR02MB7153.namprd02.prod.outlook.com
 (2603:10b6:303:65::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA3PR02MB11199:EE_
X-MS-Office365-Filtering-Correlation-Id: 941ddcd9-7e0b-41e9-3e94-08def9f794bb
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wRFoxFeR3wPOhzHxAKNPN8IWuB3+0NmwMIbMIIsy0y8MOAeM54qEEMr+Htj21wH5qxy83ldb423YfTNFiaJZ9NifRURX+F79ACxcEXz6hfsA65cW82ZixYMU1inbm4FzZ4snrP+6HvJzOtJu6SIVJEDAxvHLqtCJm5bdRMfx0/TLcbuABrnddshwJRTmKXBWAkoYvPbA1G08zVfhvj2BUrek5OMBONczw+Ex2PyZCpLoVbHLpHXUDZTrdRSf7p2/AoZtWRDVrN1Gcqm+tPmvrZ4Cm1mtyy0qgDd+g2e5hFzj4zbGz6BSQyf1sEA2Luu1RPLOp1IUzdpSiCjZAtx6Ly8LPRywQJ9D7oAJ5oXqwgeo5WwDTiSt9jmBXgx4BN58KG1tVwLqTKERkJlkXuq38PtY08znNnHGldLaSEdBSR/R1UE141jqQ1BNPtEtdxmR5QqMKAceZ0bam3Alc28L9ybJE/VEyYYNbHWhFCthey+z4tGBkC8A3VI1Yzhlq9sdbagEI4murB8D98PMkJmVHB6iVpEy8JD8cWouY5TMPbFHJNkN2r+X2yM3rI9NyRmVJUtPjH5eCrXxqPVEz/qFFEWfy2B575rlJ50wrHk2YHTpxTHZ8L/aIG4qTaSz2X4XyAE12NoYZzlgi4OjT3w5lWDqBUxcWWnjSKqDqGtNiB8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFppOFVjTXZGSFQvVkMyY0doU3R1d3hTSHFiV2NNQ1FySUMrY0RNUEN0V0dL?=
 =?utf-8?B?UmpGYy9vdWJJRk52cjJ6M1dzTk9HZ3JPTkYzQU83eTlyOEdxLytZb293VnVr?=
 =?utf-8?B?eS9qaU9OaGRtWndKNEtPNEtNdmhOaWFoa2RzbUl0WWhreWIxWi9RanI0QWhF?=
 =?utf-8?B?dzYrTFpNZDZYZThreC8wQ1R4c2l1WVNHWk1pZHJVdE9zZ3JVNDJNUklIN0VF?=
 =?utf-8?B?VVk5MlJGNHpvNFBmemFPQ3BFS2pPL09Cbkg2OGFILzhha01xRjNYK2h6aE9r?=
 =?utf-8?B?amdkT1F6UUhWMkhIdGdNSjRqY2o3bXNOUXJueHZ5R1dVQXo5dGdqS0tlQmVL?=
 =?utf-8?B?THJEUWhyZ2dyS21oRGZRV015c3NwNlJJWnlDYkR4cjVqZ0dRM1RzZHdvK1l3?=
 =?utf-8?B?ZitESFc1c3dDRTgrcTd5U2NGOEJTMnNBSjJwMzJ2Sm5pZG1MenFzV0xrL2Rj?=
 =?utf-8?B?cTRyUFRtZU9RZHlDSk5WdlczVnlybVR0V2J2Tm9OYnNKcUR2VmNWaEQ5TC96?=
 =?utf-8?B?SDkxVndQZ3N3NHRNcFVRN1NJMzRRRWhjSlBxdDZFbVNPL0VaQnNzYkg5R05l?=
 =?utf-8?B?cFp0czg3bnhtbkxIVjNobGJnNGpUanVQeU1Lb1lRVnQ3Y1Bya0tzeWZOTEVB?=
 =?utf-8?B?TnNiYkZndGlWdkg5eWVrSnVZNm52RjYwOWgrdmY3c08vRVp2VTZ5dUVQaUdq?=
 =?utf-8?B?Yk5NN1JZRUlBb1ZZMnNiRmRxZXlESGE4L2hJR0xiWDMwcDB1MDBJaHUxTmFS?=
 =?utf-8?B?Vno4M1oxZGtnWGd3dGdaNXp0RW1tV3grWjBScUFKZTJZTURybUpmRU0xMzdL?=
 =?utf-8?B?TzB6WXVJQ3RkSTR1T1orOEVNL1dDYk9FYXNLeVNxL1craDdNZkp2UjBLNEcv?=
 =?utf-8?B?V1BYUjZyT3liM0t5ZzlDTjRMalhnRCtxTTFZMEp0c0M2TmFaYlZRZDVhcnVJ?=
 =?utf-8?B?VmFqL0hjMmdqdWl3SVl0T1V1Z3hPeDZnajQwZTlDa2NNSEtDQXJabDI1ZDVP?=
 =?utf-8?B?N1FYUTgrMTgzMVcveUtPWmI5ejQxZ05PbkdaSkxRYlJmL24vMllEMy9WbjNz?=
 =?utf-8?B?RlNCRHZTbGdhYmlVNlhxNVRMVGFMRGZsemtQNDdsUVNyRVloaTk3QXkzUTcy?=
 =?utf-8?B?ZHAyYU4vR2Vuc0h3TUtxRGIxQVMyTjhRNWpKMFN6RkVtSk1acUR0U0hFZFQ3?=
 =?utf-8?B?SUx0QkQ1bGNxWHF1U1ZNeThaYnpLWXZORXJnRUppdisreWNrMG9SbzVwSHNB?=
 =?utf-8?B?OTNlUXFqTVNrd2FJR1lQQnE0RkZmV0hwMzhlTVQyYkNwWDJkM2QxVkZHR0pB?=
 =?utf-8?B?Z1drckw1QVprcFRXOU92dklPc3N0QXppeW1kaDd1UGs2VjcySitJWVFXLzdJ?=
 =?utf-8?B?RW1jOGNrSG9neVYvWmJrOFBIUENYWUQwOWUrdzY5S0xzenkzV29POXF6amZ0?=
 =?utf-8?B?TXpKUmIwSWJQNkd4SVZkTlVVSmRHTmhlbGxMUVRNeEowam5JY2VmY1ExbzV3?=
 =?utf-8?B?NzNnUGtvMi94UGpJQWRkdW9idWRrazhWVWx0bUV1aHpZOGpodUlHVmNuNG5J?=
 =?utf-8?B?VWw4dXVPRnNUdnF3QU1rVFoySHdxdk9maWM4UDJyNWVTTDBYcWtnWTZnTU1v?=
 =?utf-8?B?b1RKVHF5R1oyakI1akZyMzNJMU1vbkp6Z3g3aXlVYjRFWEh6M0g3WWY5S0Ir?=
 =?utf-8?B?VWJiRkV1S3NnNGM0bmJSVXdIUkZxRStjakVQOW1UQlRJL2Jzd1lsSjNGN01t?=
 =?utf-8?B?allhZFBZTkovTzBMaUJRMDB3aFFMR1lieUJjZEJudk5ieXJBOWJ5S0x3c2VJ?=
 =?utf-8?B?d3Y0ZFVheHgybm5OR2g5S3BZTEIyNmJwTlZ3R0lPSWNyVmsvby9MSGd5TUdh?=
 =?utf-8?B?akhJNTRJRjdJaEJiMldsYU9FT0Q4RDhQdVJvOXhnVktNd0FGNzhxbXN2eEQ4?=
 =?utf-8?B?L1RFd05NTW5EZmdsczUzU1lZQm9qY1grcnkzYWpWbjhNSVNxWkJPRTdNNTVu?=
 =?utf-8?B?Y0pIUThDcUVObTZUWjhsYnloajhpeG5ZNWpNNHVObWNxa3JkRU04T0hmUFJR?=
 =?utf-8?B?MENTbmFoVWxGK3lVbW1INyt2cTV1Qnc3ZHpYS1R4dFlvczJ3aE5ZYXkwa0Na?=
 =?utf-8?B?QnNqYmRONEk3Mk55bG1JdU1pSWlJcDB1SHpUMEVNaWltOEM2OVZ2a0NFK1Mw?=
 =?utf-8?B?QVhXWVpvV3B3OURsemNmcWY4d3h1aktHcjI2SWFkQWdpMm5paCtrOGROYWpi?=
 =?utf-8?B?U240bGpFc0d2UENXR2ZycE15NlhPb3Jjcmx6Vm1PMy9LRUNsbkJ1VUVFVEhn?=
 =?utf-8?B?ZldXdDlqSG9idi9kK0Q2SC9Wd3dYMjZGeVp0N0NSSC9aVzF5K1NMV0pSb0NP?=
 =?utf-8?Q?3F5sA5o8o1CnDjZk=3D?=
X-Exchange-RoutingPolicyChecked: aOLgUqKDKG5wFS+kXV7SGTt7Qdo8Z0LPiLIkpMyLYbkhwI4XbJf1LcSAVA/eSL42YfvbL0KJ4H2XyhcQO9tR9QJU4V6ESn1f2tE0vG/8KoMSFeF4/HG9q0i7KF6l9VmcfWHbvj6A2KGbvfXuAb6zDFwbBtYiuAhGDSQg8dy4DmtQfTZxjI7KWlZ7Za1fZxwvRz2NqhwjmheqC+67rec1Bf1ZDpIMGfdfrWXuXgpXsrNTrBlR+QnHL52kb3kFFUx+V9ul8UTzY3ZZdIMW9SF+cHc9jJlQCeMsTDEC7bi43Kp5LvFU4SlZvMrGAzL4albCZc/F3pdTqQ3zP4vkeHcbfg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 941ddcd9-7e0b-41e9-3e94-08def9f794bb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7153.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 11:31:29.0579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zo+dgtdxxUe8I9oQSTQskATLHcoRRjm/w2HAuSArSGRvfoTqGcizIb1a8uUUMsUngc5C6aycToOT01TSXFmU6atbM86fKZGDVMTJx8Z6zwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB11199
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA4NiBTYWx0ZWRfX1HY6CHw1B096
 VeoTShJeWw8dcHKW9DZkxcK8tNoz+2VadHQzKmCHmI6/yt6JEwf11SMtSlknwcNxYSv84rOkCya
 CImSYG7Rd0jAYwWmIFioT7l/lmk9GAL36ZnOuQIpQY7UrAKr4ZUeEA7x/0am8MDK6FEmZFS/LkM
 /KGR4b0KaBxTLIShSNvWwt7zzidZcxnNiiyXrXX1S4F+QitjbRQjibr8rbjcXGCb5UCSt3PXbF0
 tSU52Jsyv2X2SWgItnQ2NgAlyn2zSDP07Q562GeZBHdqhfo2SFvyO4KECQnBk1DhiJHMr/l5Nkj
 QoMFsdw4xoi6h3uUjEcUU20vj9X1CJBl5dnf9E0N1HI3N7KMqZM0WwCXxOWEWIsXaysll/AX993
 98XKivr/1OS1TaZX+pD6ZXoCWv/sA+6jLC8fnmzt5SufMUQ8oGgsMA8FN4hgS/AG7zz0Qjl11e7
 +d0U0AcVavFKzIL0R3w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA4NiBTYWx0ZWRfXz5KIwKl2sGPx
 w9VPp03q4FLcai14j5193xNWRQnANueLcVR2qj3ztUqgyNZa8BUep/tCk2IQohiqlDtvrqXXS7A
 1gYs5eQdasRevbcduC5viYkQ3II3T6M=
X-Proofpoint-GUID: rK74uUAaZr77LsCGfzlQWCDlXSljP-0D
X-Proofpoint-ORIG-GUID: rK74uUAaZr77LsCGfzlQWCDlXSljP-0D
X-Authority-Analysis: v=2.4 cv=Eeb4hvmC c=1 sm=1 tr=0 ts=6a7efc93 cx=c_pps
 a=tCAl8lrDRzME13Kae+DQfw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=pqCvvIL9VGPUZBSA2hUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.751,
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

This was missed when updating the parameter name in commit 36854207f0 ("object:
rename link "child" to "target"").

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Fixes: 36854207f0 ("object: rename link "child" to "target"")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20260717135254.508701-5-mark.caveayland@nutanix.com>
---
 include/qom/object.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 11f55613fc..4e7fe2af7c 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1802,8 +1802,8 @@ void object_property_allow_set_link(const Object *obj, const char *name,
  * property is read-only and cannot be set. Care must be taken to handle NULL
  * values for @val.
  *
- * Ownership of the pointer that @child points to is transferred to the
- * link property.  The reference count for *@child is
+ * Ownership of the pointer that @targetp points to is transferred to the
+ * link property.  The reference count for *@targetp is
  * managed by the property from after the function returns till the
  * property is deleted with object_property_del().  If the
  * @flags %OBJ_PROP_LINK_STRONG bit is set,
-- 
2.43.0


