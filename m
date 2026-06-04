Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F29BCD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 10:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV4sO-00022n-Cz; Thu, 04 Jun 2026 06:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wV4sM-00022I-RG
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:00:34 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wV4sJ-0007IH-L9
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:00:34 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65496dEV3215548; Thu, 4 Jun 2026 03:00:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=KWtXn8teWB710UP9uAZp1uw1Fmcicr70laK/nITh/
 zY=; b=TslTGW1kym9lpRDIoriULGj/K5bsDk+wmaeLAwuFpGcalsSF6KTZ8dmXB
 qTtLuVQwPBqwElwPbsfGlaCmc3vv0T8Cst4y9UNwv3OgGP9wW++Ms6I8WU9bcXiP
 DDyOw4axCTtBW/XSBWHjIagGMkHey0lcxAz3IW2pGYgaM6S9FgLjL2q0tN1VWLf3
 BN4E5lCnSuNBmm/U6HvqNzUU4EC8pE922NDyu3YRIEMhjxbux0UFSUTnLa5ih6eY
 1qCw8nHQDCKwJemPQKtudZUv7RRUSY0wSgQ9tGEUfJxIp8aXA4DQcjfIg/owMxQ2
 ikWVI2O7fhjg5zBEkAaxPGOTRYefQ==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021133.outbound.protection.outlook.com [40.107.208.133])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ej8sgccky-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 04 Jun 2026 03:00:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sy+QPRRwZWMUzBzF8S8HRNiYOQ5jc8RZqA6ttybkQ63i/6mmU5wL9gLZ2NAagW1JpS2FHlArm0FeSqQzYAZIPUOif7Eb33rj0/3uM0Za/WPEFh6QSwmu4RfSVcubvX9qqPfFQxM33u6olT+S/X7hxC62vLHT6ZpKzLlkHHULbBQnu96OAfd9EM0OUnWAZe7nXP9KWWmwFjWtKCg9D9VyJ5wxwS/O03CpkEpoRhMOFQ8KrKyj7wrse9NOsU7+eiQF0klOADOM/syzbowEkGC63WciP+dvvhNEVHvmbSEijbp0XI7c7vl4QI6xHDO4sxmmJPwahPkdOTn5sVHTZBxQSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWtXn8teWB710UP9uAZp1uw1Fmcicr70laK/nITh/zY=;
 b=WD4GbulmuJnkyBILRaY05wWxCU9xoqUhe1gJMaEgokr8gwvFTMo+AZMlN5ojxwuz9kXFh0dOef/PtnQjYRV29k2rXCJzOpzQgpUn7CGNJFjmqRHlwxsO9ZAX7ZWeiSJpg/HofL8MTiIYI7R5q6TGoJ3yECEaIwtZ8F2QCB7ve2ktq7H6aprQpFM3/8YsmzUp5iEEKmYJKKxxQSUVbNQiPfDIF/j1i6WVB5FkDWRURoMIF00A9Nhgs72GXPkD2McKCwb8ruA3y9Vskdn/+oMSu/+b2VBDpJNgkEzycpp3GbOEnsckh+R7qOFXFqA1K0ch1cIP0/cltrhMPGkEbEfofw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWtXn8teWB710UP9uAZp1uw1Fmcicr70laK/nITh/zY=;
 b=D676RVD9OCF/FYl58hcmNM6I8pdmszPcmRwMvLnLkqg2Dxhm0C2Fzaa8xNciSFSKxQcjgXf1d9ZPw9/nHwZZ5M+nj+5GNZlssbi3pS5skXru/1D23FBSYyB8+nragKjqpN5XKH2zCQnd9ldukgWDEr1xHeUOojlzNUbvzIWrp7RiuuUFg0ELtNI18P0rpTfzujjWM3rLfMd7aKGZM7d3aIoZDeSIDIPNShox4DmfaHOpDsbwMw4iGctkrtQloxUb6oe23fMUpNGxltGxf/0RMaDWUPf3KtWOtQ6hBdLHSGaKZY/3uHoz145r6EjDOOWWdsSeOUy/TaSWL4APDPiQTA==
Received: from MW4PR02MB7153.namprd02.prod.outlook.com (2603:10b6:303:65::11)
 by MWHPR02MB10449.namprd02.prod.outlook.com (2603:10b6:303:289::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 10:00:24 +0000
Received: from MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd]) by MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd%5]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 10:00:24 +0000
Message-ID: <256f5918-0e33-4904-bdc9-8c0412fddd04@nutanix.com>
Date: Thu, 4 Jun 2026 11:00:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] migration/vl: new -incoming config:* for early
 migration parameters
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Mark Kanda <mark.kanda@oracle.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20260528212947.368132-1-peterx@redhat.com>
 <87se7btcq9.fsf@suse.de> <ahmfh2s7CLFLoZKN@x1.local>
 <283f85de-92b0-4c62-94ed-631221b62c07@nutanix.com>
 <aiBPakzg8080IOfo@x1.local>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <aiBPakzg8080IOfo@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0015.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2d3::19) To MW4PR02MB7153.namprd02.prod.outlook.com
 (2603:10b6:303:65::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR02MB7153:EE_|MWHPR02MB10449:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2fbec4-f9d1-4d84-24a7-08dec22017ef
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|3023799007|6133799003|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: PEl3CuDeX3h/pmsXYJFX77tYb5yVmZeHT0+4bz+GDuNNlvF1nmDA9mum8Zxz1Vz+bLuWBVrTktZ+O7a0YkkTr9blNDlXPhsCa9+4uwEDKlpkpUR7SvdDQFhObryHNYhRIwUgBv8gh7fO1crLt9JEpHXZG3rGG+fEErA9DYAhCezrebgeJ0eM6QkaFK4+LqhoiytQd3AVpxSuF8gT9YOeuirGzyP5GGg9qN4XX2jt/jk1UjZAY1y0lcbpLoqE/rP6LuTcuv1AuHg8jA3OlGMuBLeGWUS32qt57GZFtYWRjnF5kxN3ZgVDqbEGhx2/YEo0ug5D4Y01Mg/TQwUGu50fFQTifSbTHY2+l1gxyyzwajcH6F1xxmywxzzRabmoJeS0YREqGWqDahdDM3Py9FB1f0vdczdYMYhP50oeIv6qH2pwb3ulp8ChOtLIemql0l3obgERRZxbMQd3dYlM4bkHku9tV9K1/q/cBhlYElRJ+W+RPsM3AV3O+sM1f92Ch4gh7/7gGZJFdAwsRJIYWXTCR7paSfTqUqhbEXydrKy4NyCwSKth8ZQRF3nN7BKfLbTw6fOC99ileqiSI8/VTKJM3LjdRMw5YprJbv0qtE0CR3ENTziTsgMOtY3jC5xygP/tiR4QZdFQ1zDlxSsEBbiYYcA3kJf9Nfrld8+IO86Evh6eyc3VdtNKq5bn0WINTs0N
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR02MB7153.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajhzVlNoTnRhVE9hMEU1S1pGQXN0OHFaYmEwZVZ4TFgxZUltTlphQzRRZ09y?=
 =?utf-8?B?UEhlVVF2bEtKQUdaanRubkR3bU9TU2FqZ2toRUZUNDByc0ZHL0lZQ2hxN3Z1?=
 =?utf-8?B?cjF3REhVL1RqYXBHTnJyanNhQ2RIZ0xpcElBSEdqY05LTjRSMDBaaFl1OHlo?=
 =?utf-8?B?cHdMQUNlUThTMjI3NEtmcTdZYmNjbHhxclNwdWFPYnNuVTVYemNTdHVOczZu?=
 =?utf-8?B?WVI4YXUrdEdmZVIwcnBxRzlzUTU2UDA0VTRiazdmWXY4WjVIZ3puSkphOEVm?=
 =?utf-8?B?MFNPNVlJemUveWY2TU0yMitkTGg1aE82VzV6STVlUGlPSDRqdU9kdi9iZjJE?=
 =?utf-8?B?OFVBMFE1cXI0SUtXZmphVkZZV2c1djd1TXlJV3R0NUplcjc1aS9RS1M2bVVj?=
 =?utf-8?B?RVc3blpDTi9lNjB0cTF4NnB4aHlFZjBUTkVadld6UWk5NC83Tmd4Z2cwSjJS?=
 =?utf-8?B?Wm9SNngzbkZNOXN6SE4zUmdZRUdXRlUrbUdCbThQR3NkUjYxa1VHWXhjVlFa?=
 =?utf-8?B?OXAzZUVlNFcrY1llb0dSdUdTOHR1TzRLTE5RRFZHdXl1c1o3YVpTcXRuVDFu?=
 =?utf-8?B?UDVWSHVIbGgzcmJEdUNhK0FlSHdOaExKWnByTnFnR3NIYmZVQmllY2pLb2Iy?=
 =?utf-8?B?VkN4Zi95b21hRFgvMDAyYnlycDdxcXQ1RDBXdG8vbHVnZHZxbW54bjJhVG9o?=
 =?utf-8?B?bTFJa053ZHk5WVpFUmZMbHp6M0JVMWNoL3JFSllNcHVyUmJjc2VFYVhwMTR2?=
 =?utf-8?B?Z1VLdEZudXNDRUxua2FnUmtSRWNqLzR5RW04SjZOMTMvV3ZPRlZzenF2TXBN?=
 =?utf-8?B?V2Yyb2l3aGF4SUJIRzdqOURjS3BPcUdnbHVPZXRKVFVSRmJ5WkhSNzNJMzhD?=
 =?utf-8?B?S1J5OFFpN2psUVNxT011M0ZhQmo0ZGliTUZMMWtuQWVYNkxIV21FamNmcmxO?=
 =?utf-8?B?WC9rbnFMM2ZXMUhCZmVaSUd1a2IzWnluVEszcE9RL0cxUnFYb0l4SW9iRnRQ?=
 =?utf-8?B?RnhWWXJ2THdmWEk5U3pkeVcrOS9vUGRqcUxRaHVHTXlST0hEYWd6MTVnMFYz?=
 =?utf-8?B?eDB4K05NRUFNU25wVytNaFZ0ajl3THVUTW0yV0ZZN21iYVE0aFF6eFRybExP?=
 =?utf-8?B?RUJiVzR3cWY4aWhKeTgyUkMxZUFZY3hXOXlUWkxSNThDUmZGdFNFa3hvN0JD?=
 =?utf-8?B?VU93cm5oYUNXV2w0MUJGa3ZRbGlqQXJ1OWZxTnhhM1VvWUhYcDNicTJPMzhP?=
 =?utf-8?B?TWpMd0t4ZzVURThpcGswYWlsaFVYL3RJRDBZcXc0K0crVitGbzUweG1EUzlW?=
 =?utf-8?B?cnZpd3dnd2dDTStZQnlrUXRrWUhUWE5XNnkraGtjWDRkdUVvb1loVGJiN2Z5?=
 =?utf-8?B?dXhsUGF3SmhWVWY4RzN3eXFHMVBteWRNVkdpQkJnYmFPSE9tQ04xN2w1T3RH?=
 =?utf-8?B?OUlpY2FSSnJEclZ1bDRtODBhRlozKzVDNXc1dnNCNmt6NGVJY1ZFRU9NMmFD?=
 =?utf-8?B?a2FzYlVFSHFyeXRzdHhVLzJWc0taZVRkSkdZZnN2eUxybTIzajJRd2crQ3hF?=
 =?utf-8?B?b2ZpbWxCak8wK2hkeWh2Y0YybnNxRjFCeHhNRUJGS21qcWQxVWFnalFVQi9W?=
 =?utf-8?B?SkFWcS9HQUlHQnE3cTdJSmJkajl0OXlIRktXMy9Xbk5HNytYb3FZY0FaZEdr?=
 =?utf-8?B?QUxRR3J0dUtFQ3kyN1R3QTk5Z0NLUDhnQzk1YUdkTm9DMEV5bmJZaU1zUDhH?=
 =?utf-8?B?U3pvclA1bDVVNy8xcUNMdjVDUWtwUkZMSkJpQldBT2Vkall4TVJFbUxWbzlz?=
 =?utf-8?B?a1ZyYStYTWtnQXFnUkJHRzJhay9PSG8wUCtNOElyTHg3aFhoWXF3ZzZtY0ZO?=
 =?utf-8?B?MGYyb1FOTXVjMXExQkxjd0xMSDVDMVV3MjhCTUp1M0RCZEhkYjU0b29qeDk3?=
 =?utf-8?B?VDdsSkgzcDdBeEExWUs4TjByRlEza1ZLVGVpanhKWE1YT1Y0MmtWNFBWMk9H?=
 =?utf-8?B?YmllU1Q5dXZlOTJTMkpKaVZtMTJPcElwSkFyTkQxWkxJY2grM3ZtRWJ0YjQz?=
 =?utf-8?B?d0FKZk0wbk4ycEovYVdndE9mTGdxbzJrQ2lxTTNuUlBFc1ZWcmxZZ0VYb01q?=
 =?utf-8?B?b0YxMVczcTJJdmViZGZBSmdkVS9GZHZaOXR2WkJHYUsyNHk5L0NIaG1tMFo3?=
 =?utf-8?B?S2J0cVBPblZIWUQyY3FSVG5UbC9XYUhpdlZZN2UwNGJ2NUtpdzh2YlNPYUt3?=
 =?utf-8?B?UDJyWlNEbk10WitOZkxTSVlKaGdTRmtkb29uaW1yRUlyUzJ5dnZyajgyeFBH?=
 =?utf-8?B?dmRyVE1aelRaQ21nbFBBMTFlYVJWMVpyZVQvT3R5VXNBUDJwbzR5eVBKTmhR?=
 =?utf-8?Q?mCIm7lVYeKrR8khQ=3D?=
X-Exchange-RoutingPolicyChecked: LyBX3mJndI/c+387kcSr4DvLNeJfvrTtTPBq7yGbH/fQ9u2NEDbxNaZFajw5z9IG/47Zdfx3fMFPt0aGmGGsI3rw5jl7t17VEdCpcv/P6wXzi3P/1VdMdoWVtUcQpIINnHQWic8LAbdi3BucnLFHXVJTCz33BMqNpHC/ieL33hcfcK6lBGsI94nCQmFxLfYDqmCOcAupWyHWU8VDZwtwKQ/+OGx5XwwTLItUt+GQzDxi897S8FCJ0QQ47asoHMWAj3JkD/4tlQVdNiwrIxmbbf6ucoALlme4D96+B6j48SYqEICpiv1NWTQcrHU22e3h5/+aZ89GzYVvj6qMjQBVog==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2fbec4-f9d1-4d84-24a7-08dec22017ef
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7153.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 10:00:24.1253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4zoyBF+uyWnFukCJppUuXR94jKE6qElD0ozRYgxzYdHe1XXwzT0GM8TQ0j9uuOtKwF3ryFD9cm41kysHvRZL2S/Rj5wq8ZajdXEkCHzh+Yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10449
X-Authority-Analysis: v=2.4 cv=NJrlPU6g c=1 sm=1 tr=0 ts=6a214cba cx=c_pps
 a=oB12z6Vl+/cAOQgROE5n3g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=SHIQ-oU-_PKzyGKrWjQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5NSBTYWx0ZWRfX28AVBuENB3i6
 +eus79VjhTMGZyjbi3+g1w/iicr6xjX8hxGDWzeU/3AH26VbrtCoEC9lClHFB3LYvQCGu9sPNCC
 o5sHkjwEpFRui6RSAzZ+2unvDhdcVqHZv93ohow3mJL4EME/HBGs5nkrZ/0204wFx8gPk20wAjg
 LeWUBdZU3rrSCAKMHyOfN59FAYukG4VTzgVCiDH8wSeQwAxI6tuZ7THrEVd3SQrpFQOmYG3Ugdf
 d/+KJxxnKThf38trAed9PKv33QqLGnhUvsBtlsZ70hYZ5Z6jReNmp/QMRhrh60QxoHdeTspLxan
 SUSTGSiysU5fRdI/v3Pfiy9e41A7bwYrk9fVbKm5qEEfKf0b0LQSt02HZmRFLRoGy/P6LSt2yQt
 Q1p1HZbZeJRLXG0mZPdwMLeUc/EH1JwH3KAYeV3wu/v0nwviIiDbZTDKmlF4IsBKbcfhy8r/GtC
 LtxSPvr7uFiR32C7buQ==
X-Proofpoint-GUID: eShvE7LnLikn38RIclPRm_Y2p4LbOZRB
X-Proofpoint-ORIG-GUID: eShvE7LnLikn38RIclPRm_Y2p4LbOZRB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
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

On 03/06/2026 16:59, Peter Xu wrote:

>> Is this part of the same problem in that the migration object needs to be
>> created much earlier than it is currently? And could doing this
>> potentially remove the need for a separate CPR channel?
> 
> The problem is the migration object can't yet be created too early, due to
> the fact it needs to apply compat properties.  That's why this series used
> another approach to have a temporary early MigrationParameters object to
> keep things until migration object is initialized (during which the temp
> object will be destroyed).

If the MigrationParameters are needed earlier, then presumably devices 
can only depend upon the value of migration capabilities, and not the 
value of migration compat props?

In that case could you not just build the migration compat props with 
.realized_set_allowed = true in a similar way to e.g. hw/nvram/xlnx-bbram.c?


ATB,

Mark.


