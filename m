Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63060C982E1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 11:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8cKI-0005iM-B7; Mon, 21 Sep 2026 07:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8cKE-0005gq-KJ
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:36:46 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8cK7-000813-5t
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:36:46 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LAfYB9685504; Mon, 21 Sep 2026 04:36:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ttdcexMC44C4E/iPMZF4ffCMEZHtLkmBjRba6BS0a
 hI=; b=ykE/1/mBu2U25xBSsnyiuDMSd6k15BqCaHTeYGDoBKCst1skQb+TDTKbl
 Wqg2JYi3mrciSiVRH1Q5sQhRDHGteGiHugSfIVOrTqGUl3F3cTaxbsVXdB97a7bG
 i25CEYCCwkrs0m1KBoTTCGy5YKUkXfU209AkwOCmB3oQHDFkk9lxMqfDDcO6iI3u
 WOjhhdPNxbkPobRsANsSrrLmKUOTt8b1QlIWAx5HxWnPjHiI+bC811rV5YdFzM4q
 30viTcZ3Q7COFm8xcJrMU1Ln38XIfzY3ATkNnw0d2k3Ck2L8fAlXdPs0vgoKHmIL
 xAzmnOMBGI6+5APnhYj77GO88l1xQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022119.outbound.protection.outlook.com
 [40.93.195.119])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gsswvtud3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 04:36:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fB13xz5lMJzSSd8VYMFpeR8c9lPXaBsuogqLUsE8FxXPcU/hYkeWuKePT+EpMr0ZkjZI25kjZ5Ax1UoJJOk3zxG1f0XpkaT96jvvkxH/AG2rNKUAj1YfcJToxmp34XvnxwZLccsPxLi9i9bPAIG576goPWEkcGX9bqQLjv+cyFkJNKuQLlZn6AY6q7coCnRoZ969D+3fQuDpK2lYrf2Z8oSinFlcoAgCjMr8m5upYay8qvhy8Gu8d6x5gjS6n6A3fH92Sn+upj6t7bP1pz51RtkWJ7AZe/08NJqEmSCEN/2RY7Yh3MdddLe/YEY+ZxSmeFuQV95mK1FBkq774Jln3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttdcexMC44C4E/iPMZF4ffCMEZHtLkmBjRba6BS0ahI=;
 b=OeWSKFGqReRQK8NqYk5T7LjhAXbtq81v4wLMEWDfp1bCmu9dFUfC3sf6uCrkpVHT0/+wkIr8bYTJD9VW9HD9jOchqnh0nxWkw2hwRCHDzHD/irzkedPA7WmdIVXz9ryUlL+Xv/0yN5CYfYbA0EIq4XIC908XtrVGLBVEbjqgC8ydN5tmaz2gTlwqzCPUQSzoh/nPg2zpBCkDPa6gPyJeY+Ra5l3EY3fmd1v+VTx8KmmHgv/irn87AY7BCKJZWU+thZg7CpLLC43iAY5W2bXTwIuw+F9/MVgINbC/lDMRPrOYnxO0syU9f6G+aIQnprqm7k7SU5TK/tCQTqvHvpvFcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttdcexMC44C4E/iPMZF4ffCMEZHtLkmBjRba6BS0ahI=;
 b=b9pf7RzYgLdJfa30DDW71TuIjYGGPzPYyZFVl2edq41f5HfyJZnFY9je99ktzvOihaTiZUcxMCyxZrYLvw8x8C2okwRC2pbs7r7QycpM3BX43PImDJKab++pWJr+hDN06vj9qNLzE6tLsHEmNXOcjZyeuKN7wWplenlvsPBe+dAph/+4VX9sivTi6EU3R3af4eckj2QWv4nQ9l9mv2kB+RSQHi35saBgW9rBADTR5FAS3CULFi28KxJb+Ukf6JpFAKnYTCnA4uraTgdpwWCR18cpCaicGjdDKi8QzCcsOhdWLjSNgFjtgom5T4DdviEhAZdjRC7MXmXn3M2gbeKKnQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ2PR02MB9416.namprd02.prod.outlook.com (2603:10b6:a03:4c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 11:36:35 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 11:36:35 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, marcandre.lureau@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH v4 9/9] hw/i386/sgx-epc.c: convert SGX_EPC_SIZE_PROP object
 prop to class prop
Date: Mon, 21 Sep 2026 12:35:15 +0100
Message-ID: <20260921113559.1299740-10-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921113559.1299740-1-mark.caveayland@nutanix.com>
References: <20260921113559.1299740-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:a03:331::21) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ2PR02MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ac33cf7-06d9-433c-da98-08df17d49799
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4JVXbuUJBTXh1vAulJ7gShF20B1MQUVS6vLfb8bjPkrSt+0ve5KM65RYrWn3vFdFK3UCUoDHYWfX5UY34VDYqVFa2LiT5uXnawH/X/MT3y32si3UUkCVcR4t75mHWWuQo4s1Dm64DYERVP3n+LBdRvn0o3boGMDIB69voWfq2Vm5uRO36G2uSskc5LVGsaZNFJdzB5iHmJZ2/rOvFyRvntVStLOg8hZkC8GydX3aEQNrBCRjqICz1uhnUhuVkF7J039GBJUPUp0NLdeyz0oIxdisvTcHXcIgm3V4tz3rQ8MDEHaDaZxBKlOVUWOYw/2OwntqkPnSKv+qyY0CpPkn8SUP7cPFV/0kSskEDUODRVCUWSAhzfK+2jmvTGo65vkOdapJCQUILA8YjwgPInPhm8IbgMotniqoT40nPYhs2Yv7vYQBRYyFnKBmr879h0YpjGoEB5j7JDXiNsZjrSxCk9qcuayNdqRuhOT6yUPsxNO4//taDHzK8p7z36ZhJroH5JTIOofptvTK3x7Ll12lclaTCi6uYFa1HJvb54HjJXULDfQTouAwaLGxBPqJdWFVuGa7JcsYD+TeYmeX2PiualzJjEv4/1VcHM7fxgOqnVSLekyL9f3noQlbjjnhigKUtw6K6nL0iDaJMvNHWUR6UMDyL8Y5s23qgm8kaAo9Y+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzU2blJRbFVuRXdkS2xMdUtXSkRXSGl0b0JGV1d1QVhneGRSSjZacEVJUDRC?=
 =?utf-8?B?STJFMXFYQTdBNnZ4ZjNZMnVmSENwTnF3a1IzUEtOb3VEMkUrMGFFWGFWaXkv?=
 =?utf-8?B?RnF6MTB5TWtiTWhUd1pTcEJKK1B0dllXSy9wVW1yUzFQNk9KVFlTU1lTSld4?=
 =?utf-8?B?T2t3ZWpOUXlJZFduS1JrQVJIL0l1ZGNRc1VzcElxaFdIOElnMXlyWE90UUxR?=
 =?utf-8?B?RnBMS1FDbml0NGtsSlVBeXkrRkFrKzd4YWtZNGYvZlBmajhuN0hhRzArRkZ1?=
 =?utf-8?B?QktrbS9GdjhWQWxFZ0UzK2tPRCtubEFkWW5iL0dxNTdOSnpDMVJCSkhERWh6?=
 =?utf-8?B?MTd0NFpncVJwc212QStVUEVIT0dwZyt2TDFXZE4rZlluOEtsRllTSjJZeUZp?=
 =?utf-8?B?OGlhazROZ3o5VTk5Y0M0V3lFQVhISDFUWTVtbjFqRHpabDBOOUJwREozV2pk?=
 =?utf-8?B?a3NxcmxRdXJ3Skc5S0haWjNVK0U3WTRpNTlJTHVBbzFadkpnR3F4NFhhbkVD?=
 =?utf-8?B?K2ZDblVEdk5Jb3ZQZHBaZE5yamtPd3ZXTnVJdU9NZVZIT1NKeGpDZUJxaDht?=
 =?utf-8?B?R0d1cUVaMlNlYVZ6RmtEdXRwdUhFTlRtUkE0WWd2cVNEdHBtS2JTNlBHRDdp?=
 =?utf-8?B?UFkwLzBkeFFyRFNQRHpRaWlnS3pQNkJBQU5WbTg4R3ByRmhzYllvY2VNRnlo?=
 =?utf-8?B?TUxqWG5FV1JzV1h5WTFyVlFxUVNCLzI3Nzk2dkE1V0h1V29kTEZlQnA0NXBx?=
 =?utf-8?B?WFpyRVJkdEJwMDNPRTlrNGFjS3dWM1lyUUVQdjRnRS9BcFVWL2hiSU1TaitY?=
 =?utf-8?B?c0VQVWxkZWgraWo1Vi9ROGtCN3k0QWx4anRTV2ZTU2NPNVNjbUdLS3ZXTG9r?=
 =?utf-8?B?U2RqbjVoNFRidzEydFVnczFUWVRyTlR4WmhUU2wvcGxiK1JQL0hOdWZoMDhj?=
 =?utf-8?B?V2Z1ZXZMaWFzclRMUUNUYStuQ0gyL2VrUUhmaUhjRTdzQm1Zc1MrM045U05q?=
 =?utf-8?B?QzBxazRLRktBQkpLV2lZVnl6RTBNN1R6TDluWEV0Q3g0UVVmOWowc2c2ak91?=
 =?utf-8?B?VXBuYnlMM3craTlPVnZMTVdIRk1TS01FWW8zTzVhOVRjcTJBRDR4SFQyWHIr?=
 =?utf-8?B?WmlBNSt4ZnhyRVd4cmRyaEVMb20rNzdHbmpVdWR4Nm1CRy9ac1I2YnZOV1ZF?=
 =?utf-8?B?ZHBNcjhNa0MyU20wbmVuTDNpYmh4anUxeUhmcUdnZ0UzWUxzUEtHSUpXZVNp?=
 =?utf-8?B?RE03TnNaWXFBQlp3K0U4ejFGZXhHY2lSUnM3djZmZGRWV0JFZjVGVnRUWldh?=
 =?utf-8?B?SFJhYlhNV2JkZ3lWdnV0RXJCclFaVEk1RTh1VE9CZmhCL1g0Z2V2SjRtcTU4?=
 =?utf-8?B?a1U0Y29LZU9wSEx0aXJwTDU0enZEYUdEQndFek1IdzdncGJWQ2ZiQWdBR0k5?=
 =?utf-8?B?cnF6SkVaMHdrd1hCY0Y0cENmbEF5Y0JacDVReStMZFRlVWNuUWw0WkJYWUhy?=
 =?utf-8?B?ZzRjVkJDVmpVMTJxRFdWMjdBbU1oY0JjRG12aGJveklTaHBFVEh2VFZHZ056?=
 =?utf-8?B?NER5N0NBdnVqRkdqaytPWUdDOFQrdzd4MkMxZVF1YWZMK2pPY3Y0SUlmYlFq?=
 =?utf-8?B?cVRNeXJFR0pwMkg5NUZydytMYWtJN0hNUkRESUtlN0xLWXVIblYvWFBxQ3JK?=
 =?utf-8?B?QyszbVZrZldvY1ROYjBzM3p4aDJHRkROZW95czZGSGxTTjFRdjl5a1Evdmpi?=
 =?utf-8?B?bkZyRlFkbW5sNUNKYjhmV3RMLzFzVEh2SUVMb21Fb2tCRk1ZRk5TOER5MFIv?=
 =?utf-8?B?eEdnTTNOZXdONXVUS0dobVlCUFp1VlJVbHNtdHE0QjNJd1BVQ21qak1lN2xD?=
 =?utf-8?B?ejVxRTlmRnJpSzRBaUFTOTlnTUt4SndxRnBWOVFTK095Z3RNTnI5eWZKdk9t?=
 =?utf-8?B?MGJJdUhNL2JVNW9UbUdOaXZCdk4raUlKdVVqK01BV2JIY1NRNEJlY01zakdk?=
 =?utf-8?B?emFXbFY3ZEduQTVPZitTaXA0V3lzVXowM3pzT3NVU1JYT3NnYnIwTXN5eTdk?=
 =?utf-8?B?dzE3d0k3dkt0UEFwamVsc1lMa1VINnczWDlTdDJ0cWpLMENlMFcrZjZMeHBZ?=
 =?utf-8?B?SUhKVzRUdnp1ZFdOQW9qQTNIajgzWFkyaW1xYjFCTzlyS2ExNzIzRUNQOGF2?=
 =?utf-8?B?M0I2TFRKdk56MEJja1I2bjZicWNZOGJkVTExNWZVeGVrTXN4NUZ6OER3MVIr?=
 =?utf-8?B?Q0JneHhpQ2NDRi9ybnd1ckFUMHRSY2xHZFBuNEExSFJPVGpzZ2dQMUQ3VUQ3?=
 =?utf-8?B?b0hSVzVPMzlkNFV5ZjlIdHU4QWZ1cExwakNtbXVKQ1ZNSHA3ZjNudDBVQjJ4?=
 =?utf-8?Q?uw4kR31trcX0aKCE=3D?=
X-Exchange-RoutingPolicyChecked: 1H9YsS8oqKuXie7EHoBJen8HtLOaPFynYtJO+id6okh2GwChIK+mcQKSb706pHM1p9as7uU6Z4g+MpeYxEWfxOs1wT+OZ+Ok2Jz2PjdvRcJ0LhrIS607nlOqS57Z4Y8072mkWygj70lNjSIqyoTrIoTAEcCUhoxgux0NzzMCI3sY7QjAn/GdwUT1I88MuJXy4V/OoS8cEHDYzCxGG9aW1w8nXWTTXgC9ypF4AkNNcmFUpWbOnR9U5RHVX+78nYOHsIo8KIQtKkPInke/Yjmoenxl/q7lk0Wo+hErzNtGctue8xKTIBoLUWMqpm405p+9nxnVYgeStLOfr6jVNqbO9g==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac33cf7-06d9-433c-da98-08df17d49799
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 11:36:35.6210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oyfLz1d8HNi4X7ZuTF6m4NXUuq8JMIvooZuTQmi8EFkkd30Qury1J74q453Xv3fK8o65xkVh20Tns1awbvdTOKkGfX/i11ZmilEdL+LYk0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9416
X-Proofpoint-GUID: 6Pcmm8LJyFbFecOMUbKL_hvL_j4krcXX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE2OCBTYWx0ZWRfX7J4r0wMt3iR9
 jnJ/90gvZtPFbKnXiy6FTVg/y8eegDHKu6uCbBiD9BvBBJA56Zhh9dhKrDgdOyp6D0/214gOWp2
 9ZPUDV2zfZEo38OfEfEgywgtPgfTrCjqgkzJwl7x8WSq+xKZoJzLdME512MpFCmRlkt6om09BbV
 zHkfgPc3bJqeWuNz60ytLvifLO8VGYDfxDjVLNTkxWxJe/W9R9mK5lDBENuWuCu2C6OLgCAvFTH
 xsy1cXdBxHL4CLGTgpRF2V9icOxLIzakWUTVXmKf17zftfXqH3b6lNtqa385MGA8m0U0onEjAK9
 dcEoKhGX2GbrtnrLRqaXHRGidQ9sCBdFO/13W+3ds7I/uS/ZQaV9ypUZjvJFOCi1lM5O0cDp6/2
 r2o+YI3d1aJ8RehFf+Dxxxj7rHQpz48v8ocXju+kisQmemUoaUWxSv/xypxvxzAovBygzQ8ZDke
 XBThyeNs/4PLo6qJFVw==
X-Proofpoint-ORIG-GUID: 6Pcmm8LJyFbFecOMUbKL_hvL_j4krcXX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE2OCBTYWx0ZWRfX1xHIZCVpe3+F
 kG4tak+d7FYLnst6ZPyc2vMPKKTR7aHYpiSoPbDesD9ERjx4Zz4LZ9PiLSs503OciY60dVLJQNv
 6CdOSyaBNrLaFmSs6vrvFl3583Jfq5M=
X-Authority-Analysis: v=2.4 cv=J8g/fwnS c=1 sm=1 tr=0 ts=6ab116c4 cx=c_pps
 a=c7K7qtXczKOKsP5Tyt1v3A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=tlSEsSRgIMY7PNDPInsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
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

Remove sgx_epc_init() since it is no longer required.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/i386/sgx-epc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/i386/sgx-epc.c b/hw/i386/sgx-epc.c
index d3fe10028c..29cda843c9 100644
--- a/hw/i386/sgx-epc.c
+++ b/hw/i386/sgx-epc.c
@@ -41,12 +41,6 @@ static void sgx_epc_get_size(Object *obj, Visitor *v, const char *name,
     visit_type_uint64(v, name, &value, errp);
 }
 
-static void sgx_epc_init(Object *obj)
-{
-    object_property_add(obj, SGX_EPC_SIZE_PROP, "uint64", sgx_epc_get_size,
-                        NULL, NULL, NULL);
-}
-
 static void sgx_epc_realize(DeviceState *dev, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
@@ -164,13 +158,17 @@ static void sgx_epc_class_init(ObjectClass *oc, const void *data)
     mdc->get_plugged_size = sgx_epc_md_get_plugged_size;
     mdc->get_memory_region = sgx_epc_md_get_memory_region;
     mdc->fill_device_info = sgx_epc_md_fill_device_info;
+
+    object_class_property_add(oc, SGX_EPC_SIZE_PROP, "uint64",
+                              sgx_epc_get_size,
+                              NULL,
+                              NULL, NULL);
 }
 
 static const TypeInfo sgx_epc_info = {
     .name          = TYPE_SGX_EPC,
     .parent        = TYPE_DEVICE,
     .instance_size = sizeof(SGXEPCDevice),
-    .instance_init = sgx_epc_init,
     .class_init    = sgx_epc_class_init,
     .class_size    = sizeof(DeviceClass),
     .interfaces = (const InterfaceInfo[]) {
-- 
2.43.0


