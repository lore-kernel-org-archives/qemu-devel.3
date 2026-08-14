Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C37DC5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 11:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuq8J-0002Cu-DN; Fri, 14 Aug 2026 07:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wuq8H-0002CF-NI
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 07:31:29 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wuq8F-0006hX-IT
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 07:31:29 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67EAdTAA1547207; Fri, 14 Aug 2026 04:31:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=JscWcajTGo2rEAPaBGWzZO14m3igdU3CIU/IBbWhb
 Wk=; b=LkdRAVBKRv+rUJw8HodNMgk8NObi7KWE2ZCF8++dmSRIWYp1i5SQJUIRu
 caEl+IgX4GE5woRYL/FLYw+4Q09KRgWykXs0pDmpWdjaGcSHQL9+SO1t3SvaLZm7
 POERjMnuJQJv6rcg1BYcETdT8+4iKfl8LWYLepBoGfhaM3Dhj/QE5YQ2dG1FqdwD
 4gJGGt4RyVwoHVRjZSSDnpOzWFEMTQKbQY1RpBdI0zpXtfx5yNpAPy8DTo/j6Jzk
 QDlBAViJI1Bh2UqZwvr68Zl1552eOaYl1RBeJavUvHHZeDyJOTOb+7xdZJUxPt0l
 OKBAOxvULqwjrgMNi60pu3o8b0Mtw==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021089.outbound.protection.outlook.com [52.101.57.89])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g1p1d1dx1-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 04:31:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmMJV+7SZuH5BcK7d8tSG0GakbYD9AsoCEage3aL0GgpS0a6Dzh9ERxkL7iP54DlFCQkErflPTvM9TYJKxFo6lcJISXfVmRhoIFCvfmubHMbHNCK6/xTbKPCzE9TUgfuIB+9C8vd58qmnEKTyGhzk84WvtFG+h12znV8vcS2SvfdaVFwk97AQXDJN0ldWGG17vkj1VOJxS2zCJcrfYmzbnTIBG03keef6lG0DFRYeZGEErH4mJ2CnObQ07cLJn0eccLw36qrgQ/M6gq4OhQreeiq0foeN1m01JFbPaCagalp9TqKqjUl0djbqlY9dL8WV18zSs6i0Tsf0/wZRPF21g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JscWcajTGo2rEAPaBGWzZO14m3igdU3CIU/IBbWhbWk=;
 b=PzfiWv8kXurQ5s7ofr3Zr4mC4p9HUT407POm9U+R4xvpAn5uXTC4HiYrVsENDLuYpUf7TO4kuSGgR8Tz3Es5xR17l7cznBN9Na3MsncQ5jgSk/auQnb90QLwq78bYDMYsqvVPpbikkwoLhwFqNajHHO7gXXiz9p1yo4SCOZ/et87xNcBBDnumDgQXCwwKzA5ye3AF3eSuh8ZizlJ8w8mv/8+k5EDmPEVsPC2nI7ogbb34vZWzrlpqEzqwB96rTNUTOViOgykR7EKg+UPvkCJF1MvK1o8z7sZkKfM1a6iCTUybSxQUAjC+2lWkDhj1S0m4CBjJ3JSBs0cjUsGRzzJ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JscWcajTGo2rEAPaBGWzZO14m3igdU3CIU/IBbWhbWk=;
 b=wHwUKO5ikTPgvWywaAJjsuenmMt33MY0+GXPhEfyDYwrT0HpMgdiIdYpZMy73JaW000pgWNHIifbmiPo5MkUwEUUGQ/xwqU5IHiOFMyqk4mhYg++8iPFYol94CMoypddozBhg+jumB46vXuZBwd7cb6IRAX3d96f/yqjBicPD0mx/6VrjhJprMvkAQ85nQw19HxfVrPKwYIa1QOhnaMS/VrVf9ZQ7dpBkpQ2ruPgLoi8YMzQBVniLMsaYdDVVS191s9mNDRq2GZ+cTxL3pH8ueJZ1O04ows8BPi3Ldv6TZccVAA0P2azYUPupKIBj1SQPXyIQVHK4Z17WTkpiKql0Q==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA3PR02MB11199.namprd02.prod.outlook.com (2603:10b6:208:542::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 11:31:20 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 11:31:20 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 2/6] qom/object.c: introduce
 OBJECT_PROPERTY_SCALAR_SETTER(type) macro
Date: Fri, 14 Aug 2026 12:30:20 +0100
Message-ID: <20260814113044.2416794-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814113044.2416794-1-mark.caveayland@nutanix.com>
References: <20260814113044.2416794-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0655.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::9) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA3PR02MB11199:EE_
X-MS-Office365-Filtering-Correlation-Id: f9ca364e-67ed-426c-22e8-08def9f78fec
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XBqcByCIrKzVxxVporAvQZnXZemgpS0LAsmc3NhyG6xmUqlzS/qVTcOsfXm4HU6rDRsAV3m+Ln5L6LFMW/dUttEoIc64olkeqrLyfiHX7t3HNbb8RtpV4KiWPIIC0DyoeaJs2C5ihJjvjgGEIP1CD0vp5tBF+HNZ3jsOaRvosxDRZF6ELatV22M/tUQ7QXvqdGwH4ArtAASxtmHqqOm2SvRcPBDwOQaFhmK+XaL4gBRYkaBfnj7YgoClV06ebJWjK3jjhSSYNWRmzZHtkux2DxS7y82T7C9TfiRWaxpeTbQYI2PIVLon/XSjaGhAePxGKghgpblwqArPzlyP8ae5wB9C7F7stZPpT0pq4tUwW4Szjey0pPzGUKxxFRrGoBVkpbbMv+RryOcIQ5rp3NIUahp9rk/m1kK9E/vf3av90XhKeUi1RAzRienI4qalSB4U7TsoqjVkryaDriw54DoxHO3rnVBiiyeJrWJez6PRC0z1iuWuO7dEzYGXHuWaEwj7bObe2CEZu+rnhUs5BDo93glOTA9PfDO/dDhtUVFla4qyqB8lnOQb4Mbvw3UGijgna/GvT7HMLHFPP8om4n+9W7t0bEtvc7BLDrTlMp3YLvw6gr3a19SKEQ/mjSo1F7aEe4wuVWIeqwXTCRs4RdCC03fktFuQq320UIA1I5BrijM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTNwNFZzMGVWN2ViR3hMWndjakp4U3BQc3cwVFV0MDNScUw0M1BxbWlZMHlp?=
 =?utf-8?B?enJhVFcveHMxZ3Z2eC9McGJqWWc3YVVoQXhVTHRtS2tRR0cyOVVzNU8wU21Q?=
 =?utf-8?B?VHBnR0pySDh0djM0Y3YrNVFZRTJ3U05wTjc3RzdVQXVhbUVJenJTZkxMQU5C?=
 =?utf-8?B?cGkrdjE5aWZ5VmNPVW5iclVlTlJiM2pnZ3FoSEVoKzBmTkZ0d1pQME91cmFx?=
 =?utf-8?B?SFBJMEFaUnltMW5uNytPc3IrQmVFUmlrT09rTlhIanFTMjRDcW91QWh1MTA3?=
 =?utf-8?B?T3NLZkNkS0RZcUM1ZktBdXc5ZE15S1R2L0tQUS9kNk9IQU91dXU0d2VmbGkx?=
 =?utf-8?B?SDJvUEFhYTF4MXp1aWZnclhsTHRqU0FXMnhlVFZVcmV3WFNvbldRTHcrWDV3?=
 =?utf-8?B?enpmMHRuc2NNZE8zb2Z3Z1pxK0tNMUhKb1ZZWWJ2TzRpMkR5cnJsQjcrWmVy?=
 =?utf-8?B?Wm1FTHh6Rm5rbSt1OG5BdGc5SjREdDUzMzllOWM4OEpZcU4wYnpOQ2tQblV0?=
 =?utf-8?B?a2xsYXlEWDlRTjVzeWY3ejB1MVp3SlllNlRZSUlZTVYzQ3VUeHJBNEY1b3Nl?=
 =?utf-8?B?Q3lMZDFIK09JWnVTTlZBRG5XSnlmZy9abnNxbE4rbytFOS95ODRMTHlnTUcz?=
 =?utf-8?B?N1RLYzNZLzVWYzVhRUkyN3VtYmRxbmY1bXMyRGQ1MHBpNmsrL0wyaWFyaVIy?=
 =?utf-8?B?NGpwL2lTOFlxY2cxMFFsYXI4eU5kS0FXMS9Nd1QyUkk5WSt3VU1wOHZ4dTdr?=
 =?utf-8?B?Z3NZR2lYbkprcEYrWXlJQWpYWUZzY1loZC9ncVluVUg1MUsvOU5CTVNEb3lC?=
 =?utf-8?B?VHJNb3pZeUJNWStjQk9ZcnNITVhiS3pJRTZtZXZPRUVVZnd2SW5YYmp2V1BY?=
 =?utf-8?B?Y1F0QjhlZEJ6SGxjdjVsdXR6NUhnQjd2NnhyNkJKcXFxN1ZyYXJsUUpZT0FP?=
 =?utf-8?B?OUZPbWZKTXVCb0JFbndpejkxYk8xYWw1YjlHU1RBRlNicWFZYW9nM3NwY3Vl?=
 =?utf-8?B?ZTNYTXVXSkpRdVR3Rzc1azlLRkhYSUdacTZzOWVFVS94VkpmMElxMGVlUW9j?=
 =?utf-8?B?T2dUWjZYRFRqSmt1RmRFWjBnYTM5b3pmZGc4d0t2MWJRbm1RS2hhOGEvUG53?=
 =?utf-8?B?NlRLTjYzeU5mWlp5QVh0bi8xbXdlSDRtc3hjS1YxUWQvQk9GTWl4SVpBS25y?=
 =?utf-8?B?UWgzQ0lDNllpNFRweW1XdEdIMGlzaWZVVHc5b2hIMmFraHI3N2c2dFN0NXNZ?=
 =?utf-8?B?QURnbFFrZG5DSTByNWNUZCtjNGIrWlNJdTlybUtWdTl2YmNDR2p5ZU03SlBU?=
 =?utf-8?B?L1hwM2NrYU1tbE1zcm1WamhkU3ZyRmM5SnhCWTZQa1dpbzN6YmFqWjlsRlZx?=
 =?utf-8?B?NkpQTnhaaUdUVFZaUjZqWTFRVHo2NXVqVVMyU05vbzBWZTNUeUhMTVlOaWFy?=
 =?utf-8?B?YWs3REhPcHNWYjVBbXBuMXZoaVhtaFduNUdXQk1ZZmFoeHRnU2U5QlkySmRI?=
 =?utf-8?B?a2l6N3dNUUhsTkE2QmZBUFBaZWttZVlhbW56ZTIrUXFRRmdrZWowMHFzUlJx?=
 =?utf-8?B?KzBZZFhFN1l0Qmp6N2l1ZWxWQmYwaS9Gdk5MbkE2bVNKamc5K3hSaEZNekll?=
 =?utf-8?B?ejJPUmsvTjFScFhZamkydXRLZDd4QWVYYXVxMmVxeHJkM3U4UmJDenJBNTB4?=
 =?utf-8?B?KytqbTNOWHhSVUFzMkZzUmRRRm9EdHNIbGpQSkRaeDcvSytpcEVIR2kxVk11?=
 =?utf-8?B?bFdMU1pjNmhvTnhzdndDMTlvK0pLdFYyZng1eUEwUXltOW5wKzRmRzdQczZn?=
 =?utf-8?B?a2p2ckdoVUU4YmpZVGhNMHNqdm5PZ0Via2RpRU01NHdGTDFPZVZlbWlPbnYx?=
 =?utf-8?B?bE9DTUNlRmpUOGFUVkVtWjYrS1pTK1hFcnM3LzQ5amhOdk81SDErTWdHdEhX?=
 =?utf-8?B?Q20zMDRyN0VqQUFNU2QrQ3dNaXhxaHIvVFNVam8xdUQ3QVdWWUc2cnNVcE5m?=
 =?utf-8?B?dms0YW1SR0dkb3RHRnhnUjZWZ05md1ZyNm51S3g2cmZieTVvRjVOSzVSYk1C?=
 =?utf-8?B?SXBHdGxNWVNBbGtRZ1lwWElLNFFyMWhiYUFldkYvQlE0cVYrdDBoaUhCK3lT?=
 =?utf-8?B?WXlUa3c3VU9Vb3lqQXFVaEVHRWRRaEN6WHdnMkgwTWpnOEIvUVBCaDFYUkpY?=
 =?utf-8?B?emxxcTA3ZkJwNmNxNUg0UGlKeVMzYWRpS3VMVWFBNkVSeXZKQ1I5MVFOT2lw?=
 =?utf-8?B?UFJ4RFNVS0w1SEgrZ2M4dkVzRHR4d1FDYzVXY3pkaHNXWWRIbUhJN0hCT0M5?=
 =?utf-8?B?UmdDUEpxRnE5c2xyZ2hjdE5qUElsdVBXcXZVcnRjdUphUHJBOWt3elpGMUw1?=
 =?utf-8?Q?fqPOGqAXzDRJ7bHo=3D?=
X-Exchange-RoutingPolicyChecked: nXiujsrVCoNjinDhlgToQqk0l8Wy67YuL2RCIjlwL3M+jrTeEYV9Kd6JtF3rOXDKptUyZSR1vrFliX9Ws7Yk6RADpBcE1bNqmN2DBlg4XgKXITbaCljuF5zCQYbg29smjE4lq2HuGyKeTKt8yjgJc1GB6ZiCPvvtuRyoLp87tBaEmTnUz2Hn9wkEbnBDZiMonr+ShczlkO802cYntuoWtic/kefmLSzuUMLAPF7lxtbnV8O5XwPXrNxlVl96E6WtM/g25lIXdKLLdlVxkxLNVzIZJV3kmnnB0jObb4FXeHmKha7F1htYKzaD4nCNT2j96KnRUIeG5gczP7Obk36hfg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ca364e-67ed-426c-22e8-08def9f78fec
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 11:31:20.2097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MV+lT+s3wWd2E4fnYJW4UGDBze2cmh19LpVKpaf8cvekFoWyeoh/9btsC6PFSp3Ytzp47MWTF66ZKXgrF6UFXg3+MATQRIohMMSVdDsfS6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB11199
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA4NyBTYWx0ZWRfXzIjrN+ROwpY9
 6a9Ad02GFOTzEI3u/MGTMwtawJ6azaiMs/+LWTlem3JdoY6/htSJHIkdS/uakPPC094KX+xY6iG
 C/1uxi3vZ49PAXg5Y+VhoILdGKIegAspDXhKZbKoo7BDZ1kj+wYcJaExq886Np8/Ij0RpHwI2ac
 zPmsAb7bR1WNp0FIdaa8FvHKAFG0GejZ3wbidIGzardRTQXGniyf50n3U/AHv7A7G35wAzJKurw
 DGV9eQFwFdr/19PaXPy1Fi8ncaRaZC6DiEfYsTM1+LDaekK+eQQE9n5JCmfiZ8dt2VIpxoIjY/A
 /vnqgEVM+HO7EJ9y927RKTBjp1ac38mE0O+uemdM8oWWVaErAAaVpp627MJYh/+aIjgKcWTOCDT
 rKX74u6jhyJ4VeaCGz3i0A0eORyeQTSmUb2s0yPPSh1ZSWeUQR6+fNp8KlAukL+anHJDR7tn0kX
 T4Q89iBHAnnqw5rukWw==
X-Proofpoint-ORIG-GUID: 2p1tbGroq_UuRRX_UOCvM4vbXq2odJ9J
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA4NyBTYWx0ZWRfX5X0KINRmN5dr
 45meLOm9jq3vR5L+Z/s9Jm7NzW1fVBONJQr0YZEqRZMGSEjVJeY4ZzWBK3ACQo6XHy6GlO4uDvJ
 yJzF7WB4elxCx+qZW1X43mNj8XzjHg8=
X-Authority-Analysis: v=2.4 cv=ApbeGu9P c=1 sm=1 tr=0 ts=6a7efc8a cx=c_pps
 a=Sq/50nUKxlEOOe6u8VXKPA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=fKZFoM0pQB3ZjpgBshEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2p1tbGroq_UuRRX_UOCvM4vbXq2odJ9J
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

This macro can be used to generate the boilerplate property_set_type_ptr()
QOM set function for the specified scalar type. Replace the existing scaler set
functions with the new macro.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20260717135254.508701-3-mark.caveayland@nutanix.com>
---
 qom/object.c | 72 ++++++++++++++++------------------------------------
 1 file changed, 22 insertions(+), 50 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 34aef7ca9f..8a1f80f613 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2671,62 +2671,34 @@ static char *object_get_type(Object *obj, Error **errp)
         visit_type_##type(v, name, &value, errp); \
     }
 
+
+#define OBJECT_PROPERTY_SCALAR_SETTER(type) \
+    static void property_set_##type##_ptr(Object *obj, Visitor *v, \
+                                          const char *name, \
+                                          void *opaque, Error **errp) \
+    { \
+        type##_t *field = opaque; \
+        type##_t value; \
+        \
+        if (!visit_type_##type(v, name, &value, errp)) { \
+            return; \
+        } \
+        \
+        *field = value; \
+    }
+
 OBJECT_PROPERTY_SCALAR_GETTER(uint8)
+OBJECT_PROPERTY_SCALAR_SETTER(uint8)
 OBJECT_PROPERTY_SCALAR_GETTER(uint16)
+OBJECT_PROPERTY_SCALAR_SETTER(uint16)
 OBJECT_PROPERTY_SCALAR_GETTER(uint32)
+OBJECT_PROPERTY_SCALAR_SETTER(uint32)
 OBJECT_PROPERTY_SCALAR_GETTER(uint64)
+OBJECT_PROPERTY_SCALAR_SETTER(uint64)
 
-static void property_set_uint8_ptr(Object *obj, Visitor *v, const char *name,
-                                   void *opaque, Error **errp)
-{
-    uint8_t *field = opaque;
-    uint8_t value;
-
-    if (!visit_type_uint8(v, name, &value, errp)) {
-        return;
-    }
-
-    *field = value;
-}
-
-static void property_set_uint16_ptr(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
-{
-    uint16_t *field = opaque;
-    uint16_t value;
-
-    if (!visit_type_uint16(v, name, &value, errp)) {
-        return;
-    }
-
-    *field = value;
-}
-
-static void property_set_uint32_ptr(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
-{
-    uint32_t *field = opaque;
-    uint32_t value;
-
-    if (!visit_type_uint32(v, name, &value, errp)) {
-        return;
-    }
-
-    *field = value;
-}
-
-static void property_set_uint64_ptr(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
-{
-    uint64_t *field = opaque;
-    uint64_t value;
-
-    if (!visit_type_uint64(v, name, &value, errp)) {
-        return;
-    }
+#undef OBJECT_PROPERTY_SCALAR_GETTER
+#undef OBJECT_PROPERTY_SCALAR_SETTER
 
-    *field = value;
-}
 
 ObjectProperty *
 object_property_add_uint8_ptr(Object *obj, const char *name,
-- 
2.43.0


