Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F699C5DF89
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxNFM-00072y-WD; Fri, 21 Aug 2026 07:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNF7-0006tU-B4; Fri, 21 Aug 2026 07:17:05 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNF5-0002N5-7q; Fri, 21 Aug 2026 07:17:01 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L9MfBa1901481; Fri, 21 Aug 2026 04:16:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=p0jEXNBP1QXcmCjVZ9p+dj4/raRJEHTYwtFW/piVM
 aw=; b=tJr5gdV32RBcTi969vrd4Rq7Wo4DOt9rnHScyw6vH0rN0OLoPqhWRs8eq
 du2aIToWwq1gGssLLmsFLoTM5SGnesKwIqOOfqdqIZ9BNoyQ3KvuYzLn5wqQgHpE
 vrimdET97Y/GSMr0Q1wtmNQZ5xbgh1POfLUVo7Z3ZQ91QYhe9Ja/TSFwUEvr3mQf
 C16yfDSA5LBqESS+/w1i/tWcEEylpNMXxG6x1UOsjEI3elYHsYygQtsi5H7W2735
 xx3OLpm1I0vKSZjZYljK9i4TSrsNvVkQaxitWYJ3RqDN2gcSXCAuu2EMY7CGy7yI
 0lV7MkB2Plx2kZzf0NxB7pkRsSang==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022110.outbound.protection.outlook.com [52.101.48.110])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g6cm1s0uj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 04:16:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NcfLCamgllgSIEITfHkQXaMepnlZzaik4h7oNgRcj1Du0253GAhdSWBKX6Vs3rriFxNX14k66Gf/d44MLGFFMJErJ5Q4mh8mwKKhe9Ebr64CTlkLAZ+zNluCgYRINQY2YkVxBjwNB2CV9wOh7cQHzHpddTPZffeTipbL6H3hZVX3O3abLpKfXbfmMWPq/1UWFNWvqElLxeMyL6CzM4UsGqj7/zM+7bCBhBDDO9erQ1mNWAalFszlq8NhPN7Wi1yvahc8fL+Wa6cs6jjfE/SgUYQ6P+0vlsqn0hOxZul/gcP6C1y8UEngldneFpA6ym2eaRwf1wkE+FdC6BZPRLghhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0jEXNBP1QXcmCjVZ9p+dj4/raRJEHTYwtFW/piVMaw=;
 b=QiZhF2Qw+n1cjaxKKVRWd+4dcCzBpmlpwIpM/rcCWRIiwSmjMcP6pVCGIX/Z9B47Qf0ZmcLoxWfYHqo+ouXNMuJovQj89zl7+y0THNbD7WWfQsyuwAjgwAg7k6gpU1c5emWLWa1dG/sMwbBsjF58qAB+dMyDXh2+yzYN/heFchB4Goq/4TjmcZqWyuxmM90J3qjbvL+m03za0Yux6ypeZMfYp5Wf5u4kxqiTfxWrw8fi22WBhFITLsNbbj6O2Ul5d7oMSlFK5uN4FJw/Urr6hFDy3C5eQlNejOQyjyapgBa6NryknhQTzZnyCxhkwjxIW5JIC0kZZ9rH98+OaKOW1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0jEXNBP1QXcmCjVZ9p+dj4/raRJEHTYwtFW/piVMaw=;
 b=GBk0O1SuIQns99apVCXXvi9gBvplcE6HgdKy2qmziQMXmEZeDB5C1rSPK5jk4uZGzTVPwbBjDPs2TvBwxX1S1KexUbiSO+xI+afPhxZDMmdHvsnMc4Ep5e0Xm1NGSqnBMSKarS0fmcxge95TsLwBmn/kEvnLazV06TBKC6YQAoDcq3nyhvxDLDiJGr5rMGf731eKnXT/AF1HzMm4vYzj7rVFRW4j+8nTKuWC5UJ3NkMcNDdytxX2lawVFBlhZj1U+FuJTi/8mH4TyKaTtxHmdoup9U81GQKFNaWc3EOgQGEWIrqvtDUov4GBTalj9tFHGFf4OrfMLbBXJOG42vCmQA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY8PR02MB9524.namprd02.prod.outlook.com (2603:10b6:930:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 11:16:45 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 11:16:45 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v4 14/16] hw/acpi/pcihp.c: convert ACPI_PCIHP_PROP_BSEL from
 object prop to class prop
Date: Fri, 21 Aug 2026 12:14:26 +0100
Message-ID: <20260821111550.276011-15-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821111550.276011-1-mark.caveayland@nutanix.com>
References: <20260821111550.276011-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0156.namprd13.prod.outlook.com
 (2603:10b6:806:28::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY8PR02MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: cc385b1b-c170-470e-6b1c-08deff75af81
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|18002099003|10067099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: ERYPOz4zwo9HupL4u7MSx5eBNnwc2RPsGaohesYCuHfy6lMNC9fJSTx/nZ/CFAXgZlS5oYnbOD9Hxii+rDHjwO+Oz+GLAv/WEnwCenpfOuF3XDsiXvJ7WY734XBqocRJWtw8ZLOmQg1WduCMtei6/0YhUuuJ8ZbDpm0YCI9+G4nXcrgI/HR3X5PfZKzZQxa0hYv2anYRAY7EHKi2a4JJKXn6bkbCQ3lrhdzKijHmfIM1JF53za7x8MctLxwUhp7ocjL7MrlBSchC6nbidcMDt2vgWMPSJoJLYJKLlhdC+KtYQdLm4CHNpM7P7nGLafNLJ6tSdaTVCpJ8q6zlMiwogFlnio4FB7Xz6Rokktq+FYgcmeyggyWwVW+emw74mUtGfmJrMi2HH8HcIgsANqvq1KGDBemxLtJz4AOQthhiPX/3N1j1szol3LT76RhyOIzcr/F0GDO/UfPT7JRVnknlrS89Y0bGr/vWVc36vH3VdLcpecf8VydG8ypvuUSlc3YtdjUXs+B5xXsA/hH1Z9sZaxO2ZHzlmMO1/RVbNEJ+FqsNSssMi1RNp3nlxZaEOln/W7Qep22UU6c14Drn/7VKihqgaAZqqo/bvN1X2mPeiV7PDRZ9ZGNUllaSV+Wdv5cqi+dPp0IVkR/ToRv76DmYbxhVFOhPqaZwoCoLjUYU6W/m583W1g6cEwxbIbnth5PpXzYZ5Kz+kxne1pTWRY2jqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(18002099003)(10067099003)(22082099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2dJMmt3VU12aER5N1dlWE9lUEI0dTNpTk1CTVhpVU85SlVWZ29ibEpjR0JV?=
 =?utf-8?B?dS90MDZXWjJuSktJdm5adEV1YXd3WXFCbWJtRTE1V0JENXNQanVtTkQ2ZTdo?=
 =?utf-8?B?d1Zrc3NtZVlFTERudHBERElCNlZVOExWSnlUa3JaNlJhYVpkSzg3YnowaWlx?=
 =?utf-8?B?NDNkbFJiSGRaNW9IdUtCVzR0bTJRTlR1TWFDUjViQTVVand5RTRFY1RNc1JX?=
 =?utf-8?B?NG9iL0pQd1JCK1p4Sk1JaHY0eHpRY1J2MjZpMUkyM2pZL2dtQUJ6d1RnbHln?=
 =?utf-8?B?V2R5VTRQY2VuWDBrQlgrZC9QYTlrcERmanorTjZtcWhJYkIydlVhL0xQZEZY?=
 =?utf-8?B?TjdDVTdDVDFML2wzZWpqNURwVU9TbjV4NExFc0JLS1A1Rnc3TVVvUkYxRWJB?=
 =?utf-8?B?VThzUnY3L0RST3lqU0t6UXhoK1hHdU5naVhHd2dCRFdUOFZTTVJqeUxRV0FR?=
 =?utf-8?B?MVpiaDcyeTAyV01EK1d0QzBZakFOVW5TZXpNTjJWZmxrOUZpV1VUTTRCbFls?=
 =?utf-8?B?bXBCWkVFczByQWRyOUhZMjUra210VVdDU1VJMndURXV6cjdsTDhhcjlYVXJR?=
 =?utf-8?B?RkhtZ1NMZXZ6ckp6NTAyNDdNQStrSVJMWnQ2cUM1aHBHOFVKODNtU0Q5MUZC?=
 =?utf-8?B?NVJWWkhDWUJ0WGF1czBMYlo4cWR5UEd1WlBMeFVZdytFWEMzZEdRQ3QyUGh3?=
 =?utf-8?B?ekFSaTlla3hOUE1iSjdMTllkTWFRYlE0UTJORUdLYm4wQnlEOGtPYXpUT2E3?=
 =?utf-8?B?bmtiVE91RkttQ1dkeFltN2JlRlVHQTZXUnp1V2JqUWVSSXpQeU1qLzg3NnJl?=
 =?utf-8?B?SFBWU1NuM2VMb05OT2htbkpJVjJMSUhwSC85TVFqV2tWZHNnSzNKcUJweUFD?=
 =?utf-8?B?NGtTT2JEVm1aU0N1VEE2VE1CWSsxRjRZaWZhcFdoaHdWcUZ3aGlJTnIybGRk?=
 =?utf-8?B?QjFNSjROUXpGblFSSkF6TG8wU2trTTlGRjAzWlFQemtRS0VPZzhrVW02NU9Y?=
 =?utf-8?B?Mnl6dFF4SjZqYk9kek9OWEt4L09jSU5nd2ZKeTZKNWhVRGhkZVRKTlBXSWVQ?=
 =?utf-8?B?ckZaTkt3Q3ZrbG5lOWF2WkdKR2p6T3U5RUt5Sm94SG43ZWkyYTZ6dUFwb0sw?=
 =?utf-8?B?SWpyMWExMysvOFVZVUxHQTBPT0ZyYlM1ZmszQ1RvTHIwMmFqbHRwd0w5bkcx?=
 =?utf-8?B?UDE0a3RGR0tMNFhxTXZLc0dtazRxZVplS01heVgxb3pSaWphYmdaaHR3THlU?=
 =?utf-8?B?Z09GRnRRZlpTNVJsVVUwTjdjb2JURG10UzJseGNOZlV2bDZWdnNHZ0hGdGFh?=
 =?utf-8?B?TEpxYW0zb2ExTGZqL1lXYXplOTFZK3JlKzgrdnAzMVVwbmVGUWpkVW9vT1Fu?=
 =?utf-8?B?SldXUGNhclRQNm9OSFhFblRZLzRUVUZ1QzQ2Y2RXbUFIVzIxdWVCb3B2dEc3?=
 =?utf-8?B?SlplY21EWmpaeis1V2pVQW4xbmU1aHVIZElKTGZQWFBKRFlxTU1pSXNiMldQ?=
 =?utf-8?B?L3lGWVFYUEZaY3FaTDRGYjEvaGY4MDJQVnpNQWdDa2Yrd1ZhQnJQUUxGT3hZ?=
 =?utf-8?B?MjhPNHgwRTU1bTlydGhXRVBoZEJhU2kycW03em1UUWZLMC9qQzhFaDY3clUv?=
 =?utf-8?B?WWFrQ1diTitlaWNqTzNwRVhDN29MbjNnNm1mZEZYc3ZqZER1WFcxdGt4T3Bu?=
 =?utf-8?B?aGg0enBpZWQzRFBqQ1g5elozSFh0c0lYclYrKzlCYzZ3RW96aHh6NVVXTnpj?=
 =?utf-8?B?TlBDelRMVS9kYkRBMk5vL2FKbDNPcWZlWkZVcDNTRllTMFV3RmdaeThWU1hy?=
 =?utf-8?B?M3NRL092WWlSNXI1ZlBuTXJHUlUxdWRSUkNlaXlRWmQreEdsaks1Kzd4eWx6?=
 =?utf-8?B?eGJIVkVFZWpUV2hPcU1IK0YrcTFtdWZ4eTBvblJSSHVyNnR6aFJiNnNCaHc1?=
 =?utf-8?B?WHFPSG1GcWJKWW5mYzV3ckloaG5OTnQxWjVwR01MdUdWd2poNHVuamFJSkkv?=
 =?utf-8?B?VG5IL255ZzZLa0ppLzFRUzcwcmF6YUhHSTVTU1hNVDZ1enZEelZaZmZnVHdD?=
 =?utf-8?B?Qm5zeFpsSHhDbmFBUjhiazhzTWhmQld6S0xZdXRGSXFCQTRzazFyM0NsQ2l0?=
 =?utf-8?B?VFUzM1YzMytrdDl0bTFxb1I3YlhHWjlBeFF4YlRGeWtHRmJlaTFZRGVaMEFN?=
 =?utf-8?B?SkRpZUdLREc4NFdmNlBGa1RMa0lyWU4yZDY5ZWtVdmd4UjBwbGhNZ1M5RXpL?=
 =?utf-8?B?T212dlFkRzZva1RrTzQrcUt4dW5ZbDUvWURhNmZWMVZwK3R2dXU5VFpiMEZa?=
 =?utf-8?B?cnVIMXJvb0NwUWgzVzVSblBTOTV5RkZmcFBJbU9Zd3lXdEtQMGFuQ3FEN1lN?=
 =?utf-8?Q?nKwNzX5Wm0ZAu28s=3D?=
X-Exchange-RoutingPolicyChecked: Q5cZSMM/YyeHqL90Z+yaRiqhgDzHvbi/36ch6Ozx9yWInZGrurDWqQDrqBRS+HAUgBhR63kM02SIteaNV+R5ySEb63aQM+CyYpnGkAr+Spc47H0OQKcNPVP2E3udH6zNvp89pdzwVCuaW9sjcPtWriDAE89ZzrDvk9jpNgpVulAdudFLEAm7yOAb2fkeE41fcQ7FceKHLOkXmWCRncV6zlh4YVmYF25Qttda6oNGsk/1sIDliRjpmUt1tfoPiAYj5mfmn61l3Qp7hF4ZEjYzeYVtk9DiHHnBj3qy41n3V9bp+oZkpWqLjQ1OtQZMXDxsEarELSsRt2LIUly+ycLg4w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc385b1b-c170-470e-6b1c-08deff75af81
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:16:45.6367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXH0BtsylrvPs1ZAV0sjFmP9dprTBEtAq4OJra6hzoGE1p5IxcrVqJdBVkyjhiGnFVbJnn2fUvW4MJeT38rNCBRs/gmP9jhwl77Hwrqz8o8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9524
X-Proofpoint-GUID: d8NWz7088UnlFwaXpLYv90zbLYa3cXvT
X-Authority-Analysis: v=2.4 cv=J/qaKgnS c=1 sm=1 tr=0 ts=6a88339f cx=c_pps
 a=ylTaWg/OuTOBUQxDHB/KXw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=Yyzug1Ypeymz-iOESlgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: d8NWz7088UnlFwaXpLYv90zbLYa3cXvT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX7Gnij1oJ59re
 eoQw3Z40T3BG8L1aQdN1XqYUpXJV388bAUrJmHe+aSFxHX2c876s2d+n18Fis5f2MEVYmqGyjEZ
 pT1eTPVOcDYe2EYqqvezX5sOHJuacjexurVrehok/4Ti2ak/cPi5sd04eqALpl88VIbl5d0XVl+
 /cel5pbymAJh34cwYuCUVb2svJIJjh6xGOYlm9zBbtKEWKzVIPkmECSTPGnt2gZdVlKD35sOIN5
 +F3ZVFMBr+tSJ0mo+69c1wRFDakumFMw3opfi/Z1Pn92yFepV8Rn54mj3bFoZ5uGjxFqXIOp2bG
 ldzaSNg6JYu6z+Y5gXkCpwUA5iUUhD8ia4CDv15W+qf+YsgtGt+mJ3vM3+pVSN6+qzN/3pYIJt2
 d9eNb+uxSfOcT/8xgn9mOUmHoMCyOW8sLDUEtvT3sm/OZz/ZePxlnytcbJf/8q35J8NWdlAhhPB
 VVHZOEm19+S7rVKPo4A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX5Nu9oO1LIq1a
 B2TADvXTdpT/nz22kb83RLqIDHsvW/jynqPCAIvDdy+P6yuLz1V296ti8TeWhL9d9zmHhnVUOFQ
 EsrW+0FHOas05QBxoMVh6dHclhYBW+A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

Move the ACPI_PCIHP_PROP_BSEL property to the PCIBus object and update all
callers accordingly.

Since the existing logic checks for the existence of the ACPI_PCIHP_PROP_BSEL
property to enable the relevant ACPI changes, set the type of the underlying
variable to uint32_t with a default value of UINT32_MAX indicating that the
property has not been set.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/hw/pci/pci_bus.h |  2 ++
 hw/acpi/pci-bridge.c     |  9 ++++++++-
 hw/acpi/pcihp.c          | 30 ++++++++++++++----------------
 hw/arm/virt-acpi-build.c |  7 ++++++-
 hw/i386/acpi-build.c     |  7 ++++++-
 hw/pci/pci.c             |  7 +++++++
 6 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
index c738446788..7ecb23d13c 100644
--- a/include/hw/pci/pci_bus.h
+++ b/include/hw/pci/pci_bus.h
@@ -56,6 +56,8 @@ struct PCIBus {
     int *irq_count;
 
     Notifier machine_done;
+
+    uint32_t acpi_pcihp_bsel_val;
 };
 
 static inline bool pci_bus_is_cxl(PCIBus *bus)
diff --git a/hw/acpi/pci-bridge.c b/hw/acpi/pci-bridge.c
index 394a919479..1bfc5431f2 100644
--- a/hw/acpi/pci-bridge.c
+++ b/hw/acpi/pci-bridge.c
@@ -23,6 +23,8 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope)
 
     if (!DEVICE(br)->hotplugged) {
         PCIBus *sec_bus = pci_bridge_get_sec_bus(br);
+        Error *local_err = NULL;
+        uint32_t bsel;
 
         build_append_pci_bus_devices(scope, sec_bus);
 
@@ -30,9 +32,14 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope)
          * generate hotplug slots descriptors if
          * bridge has ACPI PCI hotplug attached,
          */
-        if (object_property_find(OBJECT(sec_bus), ACPI_PCIHP_PROP_BSEL)) {
+        bsel = object_property_get_uint(OBJECT(sec_bus), ACPI_PCIHP_PROP_BSEL,
+                                        &local_err);
+
+        if (local_err == NULL && bsel != UINT32_MAX) {
             build_append_pcihp_slots(scope, sec_bus);
         }
+
+        error_free(local_err);
     }
 }
 
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index a91f523c93..b26ddf0a26 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -58,7 +58,7 @@ typedef struct AcpiPciHpFind {
 static int acpi_pcihp_get_bsel(PCIBus *bus)
 {
     Error *local_err = NULL;
-    uint64_t bsel = object_property_get_uint(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
+    uint32_t bsel = object_property_get_uint(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
                                              &local_err);
 
     if (local_err || bsel >= ACPI_PCIHP_MAX_HOTPLUG_BUS) {
@@ -78,18 +78,14 @@ typedef struct {
 static void *acpi_set_bsel(PCIBus *bus, void *opaque)
 {
     BSELInfo *info = opaque;
-    unsigned *bus_bsel;
     DeviceState *br = bus->qbus.parent;
     bool is_bridge = IS_PCI_BRIDGE(br);
 
     /* hotplugged bridges can't be described in ACPI ignore them */
     if (qbus_is_hotpluggable(BUS(bus))) {
         if (!is_bridge || (!br->hotplugged && info->has_bridge_hotplug)) {
-            bus_bsel = g_malloc(sizeof *bus_bsel);
-
-            *bus_bsel = info->bsel_alloc++;
-            object_property_add_uint32_ptr(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
-                                           bus_bsel, OBJ_PROP_FLAG_READ);
+            object_property_set_uint(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
+                                     info->bsel_alloc++, NULL);
         }
     }
 
@@ -730,14 +726,16 @@ bool build_append_notification_callback(Aml *parent_scope, const PCIBus *bus)
     /* If bus supports hotplug select it and notify about local events */
     bsel = object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BSEL, NULL);
     if (bsel) {
-        uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
-
-        aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
-        aml_append(method, aml_call2("DVNT", aml_name("PCIU"),
-                                     aml_int(1))); /* Device Check */
-        aml_append(method, aml_call2("DVNT", aml_name("PCID"),
-                                     aml_int(3))); /* Eject Request */
-        nr_notifiers++;
+        uint32_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
+
+        if (bsel_val != UINT32_MAX) {
+            aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
+            aml_append(method, aml_call2("DVNT", aml_name("PCIU"),
+                                         aml_int(1))); /* Device Check */
+            aml_append(method, aml_call2("DVNT", aml_name("PCID"),
+                                         aml_int(3))); /* Eject Request */
+            nr_notifiers++;
+        }
     }
 
     /* Notify about child bus events in any case */
@@ -848,7 +846,7 @@ void build_append_pcihp_slots(Aml *parent_scope, PCIBus *bus)
     Aml *dev, *notify_method = NULL, *method;
     QObject *bsel = object_property_get_qobject(OBJECT(bus),
                         ACPI_PCIHP_PROP_BSEL, NULL);
-    uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
+    uint32_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
     qobject_unref(bsel);
 
     aml_append(parent_scope, aml_name_decl("BSEL", aml_int(bsel_val)));
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index f6386088b6..7ba7b38773 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -1207,6 +1207,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     AcpiTable table = { .sig = "DSDT", .rev = 2, .oem_id = vms->oem_id,
                         .oem_table_id = vms->oem_table_id };
     Aml *pci0_scope;
+    Error *local_err = NULL;
+    uint32_t bsel;
 
     acpi_table_begin(&table, table_data);
     dsdt = init_aml_allocator();
@@ -1269,9 +1271,12 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
     aml_append(pci0_scope, build_pci_bridge_edsm());
     build_append_pci_bus_devices(pci0_scope, vms->bus);
-    if (object_property_find(OBJECT(vms->bus), ACPI_PCIHP_PROP_BSEL)) {
+    bsel = object_property_get_uint(OBJECT(vms->bus), ACPI_PCIHP_PROP_BSEL,
+                                    &local_err);
+    if (local_err == NULL && bsel != UINT32_MAX) {
         build_append_pcihp_slots(pci0_scope, vms->bus);
     }
+    error_free(local_err);
 
     if (vms->acpi_dev) {
         bool acpi_pcihp;
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 8837b69687..cc0b6e5633 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1198,15 +1198,20 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     sb_scope = aml_scope("\\_SB");
     {
         Object *pci_host = acpi_get_i386_pci_host();
+        Error *local_err = NULL;
+        uint32_t bsel;
 
         if (pci_host) {
             PCIBus *pbus = PCI_HOST_BRIDGE(pci_host)->bus;
             Aml *ascope = aml_scope("PCI0");
             /* Scan all PCI buses. Generate tables to support hotplug. */
             build_append_pci_bus_devices(ascope, pbus);
-            if (object_property_find(OBJECT(pbus), ACPI_PCIHP_PROP_BSEL)) {
+            bsel = object_property_get_uint(OBJECT(pbus), ACPI_PCIHP_PROP_BSEL,
+                                            &local_err);
+            if (local_err == NULL && bsel != UINT32_MAX) {
                 build_append_pcihp_slots(ascope, pbus);
             }
+            error_free(local_err);
             aml_append(sb_scope, ascope);
         }
     }
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index d3191609e2..e8e8a3b767 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
 #include "qemu/units.h"
+#include "hw/acpi/pcihp.h"
 #include "hw/core/irq.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
@@ -187,6 +188,8 @@ static void pci_bus_realize(BusState *qbus, Error **errp)
     bus->machine_done.notify = pcibus_machine_done;
     qemu_add_machine_init_done_notifier(&bus->machine_done);
 
+    bus->acpi_pcihp_bsel_val = UINT32_MAX;
+
     vmstate_register_any(NULL, &vmstate_pcibus, bus);
 }
 
@@ -302,6 +305,10 @@ static void pci_bus_class_init(ObjectClass *klass, const void *data)
     pbc->numa_node = pcibus_numa_node;
 
     fwgc->get_data = pci_bus_fw_cfg_gen_data;
+
+    object_class_property_add_uint32_ptr(klass, ACPI_PCIHP_PROP_BSEL,
+                                         offsetof(PCIBus, acpi_pcihp_bsel_val),
+                                         OBJ_PROP_FLAG_READWRITE);
 }
 
 static const TypeInfo pci_bus_info = {
-- 
2.43.0


