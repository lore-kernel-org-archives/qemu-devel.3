Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D1CC79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 10:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4FfW-0000rp-Og; Wed, 09 Sep 2026 06:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x4FfU-0000rH-7B; Wed, 09 Sep 2026 06:36:40 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x4FfR-0001v2-MP; Wed, 09 Sep 2026 06:36:39 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688MgMSG353445; Wed, 9 Sep 2026 03:35:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=VHve9u6HbI1Ni2jt7CNTBSpjl8lnkQhIanW5xj/+7
 YA=; b=GqnvMKuUvuD5GJLa7Mt5cibQsitsIPUJ51+rJqKEayqA8sWjGjPNSF7Ae
 siQQXMejSIdIv7cvzECSyQun7eo1bJqB1DBr4Q0QOXHvsjfSz1SevN18YFrg2ERh
 TgyE8CCPpJYiHIvdP3g33dPMGex2y5+jCE/E+V2ek8vz7gYeOLpZ10CBlm2Ev+qi
 52Yj2wzN8ii2t4Q2vP70g508z0M5DsGJvuzSz3Ofb+IB8stl2KoTtOq7YUs8JXg4
 nVBBz5lth9oytskG0BrxQ0fhASg79nW6G3fbWvxNDr0Fy0Gp2Cselkxa3JOO+ZO0
 1I/OWbaOcz8CcSiAXm9fEykhc6W5g==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021087.outbound.protection.outlook.com [52.101.57.87])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gjnfpaae7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 09 Sep 2026 03:35:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SgoDjGBjLEid+p9zcWtApCzalFmgdAPyp1bjCHXIzEexPqcnjTi670OCUUiSYSBRUnrsKAC5O7zXtsImMrYnaO9PTK+oE598gdd8jBP9c5zLvB4gF3lhZsFZtRPtdsY/SZbIlCQS/tJqemHQXfzxWtCZ6cMws75qlaEpFmH+zg5vnsPzkyUA1hIT13cDm7xvQB3MeOLH910n8miVXtxJB/xRgdBJqvt7wDCka17PZj5ZMG0kroUBTTt3Ino9FQTgvj4V38mI5l13IXtaL7N3CuQP7Hr0mo3xTZw7w7q+cXtNBAvjOWCqjfPp0OHjuJtKc8zkl/NzAbPHcavs8DVCug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHve9u6HbI1Ni2jt7CNTBSpjl8lnkQhIanW5xj/+7YA=;
 b=JXE9n1PvTaKmniC5WVngg1bjgl14/s+vefd1nwBz4OoQI8wbSVaAyfPJBBixpGQ62dBzYOVR+8neHy5UA42kQEZ2aZxD89xSdzDChT5Tx9z5jWPAw2Zs41Il6C8/lAbOS9vUVI/6HxNGcnKFiUfF2FN86se78s63wSwGKgKQx0xJYIg5n1nEt3Fp4b8A9OSH9r0Tf3PSn+NxyXhmFI7UemdZxdi1Y05BeLrNH1/lzDck+KMpNEQS5TE1aUxxlOa8wnQtEXqdN3pPw4dO8D0KYI/oFOREb5NLDrK5/MDyX9eC2BoAuFJqc/mcZaDa64vYtcfRuUNwYHUNii2oVX8Srg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHve9u6HbI1Ni2jt7CNTBSpjl8lnkQhIanW5xj/+7YA=;
 b=fUt4wcxee0zSH/3/XfUHXNx/VGeUi4Qiy0Q61WshLKJRJeXhOwVd17TABAUg4V9LpwCQ4KjR32xFfnxM6YSrd+c5iQSJa6KY9tD+WJlXuPfK6x5Jg9SIyRGcmzW2V5cyM26H+cF3nl+3CQJMdPcaZ4KC15axNp/DgPtAIs+aZBqICmqzGC5MxwMFxXtrU7mpl7VkEmD6I2rNtmNVRZmgIYq2ZX5sjI/+ECiUmaqIW1YlSpBhXXxGlXsULrhAgpf5NZcwWlgHPRY/jzgVI3s0Kg2dXCB6MqbtElpsClxUAZOGXBwN4GijnrULN7/iKfP9erv4PmSiGcA/ca91Cdz8xQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO6PR02MB7556.namprd02.prod.outlook.com (2603:10b6:303:a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 10:35:50 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 10:35:50 +0000
Message-ID: <2f7465ed-9945-48e6-81dd-d7aaafd249ed@nutanix.com>
Date: Wed, 9 Sep 2026 11:35:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/arm: Add /machine/labels container for Aspeed
 machines
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, kane_chen@aspeedtech.com,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20260904050424.4049984-1-clg@redhat.com>
 <20260904050424.4049984-2-clg@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260904050424.4049984-2-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0291.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::8) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO6PR02MB7556:EE_
X-MS-Office365-Filtering-Correlation-Id: a2ddf5f2-694e-49a7-cc70-08df0e5e1ddc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|10067099003|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: sJ0Zouj7OeB8G7w4K9z8aVfQuUUxAgPDpb458xnk6R4Xc9Jm/o8PxHQeakHe5O4bH9kR0ZPwgedv2lD7qZ+bMQ9XwsZbD3LTqmh5RuDDp/usP5W361GD1KJbclQmB5RI1TueJpE4oBTX7CJkh3i6fwqbfLA2FoyYfRNwU5vGDCsqOzxOqXdOphDZKX1oroC1McoaGAVK6yIV06bFLZ8nfnkCaNSXkrdlzQBVihpiJ5rsgSNmjgcN1CeIalk2SfanH/Uw+MdqTOZy1VKEu9KlY950GeszuYJzicGa9P2iWjMnfmXC4dUfhnkizc8rKjCpwNdpv7k8bC66RKM3Xy7C6MwlQNrur1c1MQ3KwwOpHNDpvvPbbwJgrtALb3VAMUT4d3wXxZ/Fi2RkXdeEARKmaOT2Mu2lGYWTHMcCWfasv/LnD2KQfei+FzpCHnlbxyQbQzJlEkQt5vz7z4Ga+z/o3gFtZoXFinbvjgYG6CZUs01nm97LHzn+sTFS7CjXYaa9RpKd/hgd/4qGzsb1X4zJZXz2kj6piEvdaGAAv3/gvNT7Uqp08Drz/cQepQuizBXTv0q4obokffJz6/ioFC8JMbywtXH0iJaSniBgsfldMI2vuQglczbAaj/6hsPJ6Fkx7BhkqKl9BQR9wSax0HhDvOsDyhaCDJg6PQe+s355Sxg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(18002099003)(22082099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHRXZnVydjRaQzBkcEZ0V0VYV0lQU1RqWFhsQzFmbGZUUysrUysxR20vSVFF?=
 =?utf-8?B?VzlRcVgwc0ordHJPVVZtUG45WVZPQVhrc1k5Nzg4TCtCdWlaSC9pYk1sMTV0?=
 =?utf-8?B?c2lNcnVrUTRrZDRZWmhENW5nYUlWYTF5T1lBdytJQURpNGtPR24zYzJvTnA4?=
 =?utf-8?B?RU0rKzF5RmxKN2daWm5GTVo3cnNYb1g5a012cDBFQllpQWh0UGVjT2ZKWUNp?=
 =?utf-8?B?Z05PemkvaENubThndGJPcFFyd29KU0hHcnl2clNNdDR3UndtSC9GaGVzN3h0?=
 =?utf-8?B?Rml3YlFSeTZ6MXQrZVFRSTN5bVlycmRSZ055eEZVTU5kRUdHaGxrMFhYTzNV?=
 =?utf-8?B?L2NrNEdpRmJROHdEemo5ZlpIaDQ2OHg5aFp1eTQzdmh4aWhsS2VXbEhDNUVa?=
 =?utf-8?B?SlhDdkczZng2NEtFcjdLaThWVGFNOXluZ0VpVzU2VjdTWlZYMXRFWFFtc3A5?=
 =?utf-8?B?Ly9yazJ3NE1mMkxQNHEyV3E0SWdrVW5BdVNJZHhLTlFUTWJCNDdsZzgySnls?=
 =?utf-8?B?V0V4akpGZXNSOWoxZ1hBczh2a2pWZ2RkOTBoeXdWLzU4bFc5Y2dldGcwdnNE?=
 =?utf-8?B?cWgvaEJCaStrT0VUNEdwS2FJNTQ1S2xDTmVUOExzL0tjYXdvMXI1YnVxVXRS?=
 =?utf-8?B?RW5LTWJNSkhYMk0vOHlTL1c3K2IwMTArcWxQcWlLa2VUbFEyNm1ZRlRqZHdZ?=
 =?utf-8?B?cDAzajlnazN3R1hFVFpZV1A0M29oSG9KQzhhT293bm9DZ1ZPbXZRUFRyeXVH?=
 =?utf-8?B?b1RTK2FHK0xpRlFZWmVubzd6U3ZCTjd1UDZWdFk3dEVjY3RTMU1CcmVqeTgv?=
 =?utf-8?B?NnRiTU5BY3VaV3R6d2NxckhiUThhaXowMFFTVUt2TEU1WHhIL09YVnQ3anhk?=
 =?utf-8?B?QWxkZnhzNjJnKzV0Zi9BenlmbHorbVF4QlFlVlEyZk5iNjJ4M1NnTDE0Wnpi?=
 =?utf-8?B?a2Z6WEVzbUZvWWVWTXZQQjgrQ2tUQlptTjlPQlpvY2U4elpZNjZ6MUdIYlYv?=
 =?utf-8?B?ellqMzlNeUp1czNFVWl2OWZITmR0a2w3c2l6UjMzMjBrbk1BdEIwNnN2a2o2?=
 =?utf-8?B?S05oYlR0bkdXMTJZWnd6dHU4MldYSUprL21leUd2TTI0SXAwLzNCQ1l4ZWZ5?=
 =?utf-8?B?MjBod0QxWWJzbkU1MjdBbkRURGZkWTNtT3pnSjFld0N5ME1tZm4vK01lYkxL?=
 =?utf-8?B?OFEzMlRxSi9KZzgrbGVaZ2FCQUhnVmI5b0ZTNVFJbHFMRWZtZk1tdmVNd1pW?=
 =?utf-8?B?R2hmVC9yb25jQXFRZ1FpcndDNmplbk5NbXB6RTFleWltUjU0cVdTaUpqbEpl?=
 =?utf-8?B?c2Jza0dFaGt1V1Q3bFlBZG1IRDVWK3BQZ25hMzUxcDBaNWVHOExHeWR4Q1Jq?=
 =?utf-8?B?aEdTdkNYNG9ONXU2QmJVSWpkT1NJcXNLT1lWUk1lWUtBL1FkVUJzU2tiUDc3?=
 =?utf-8?B?N29HSkdySmtIOVVHN3BUb0hvaG81eFQvVmpscEpZQ1BQa083TGFCdDBtdjVU?=
 =?utf-8?B?Uyt6bktnRy9pZ3dJUDJzOVh4VG15YUM3MW1YK1hUb0tDSUhpV0daVXFkckFI?=
 =?utf-8?B?M2c2SGNsQTNIL2dvcXZDS0NjNkNJWTd6M211WVFMS2c2S3RsaVRGZ1NuL3Z4?=
 =?utf-8?B?WTNESjRLUnNkVDF6bXZKYXZ6RkwvTHNLTytMYll4RlJqODFqdGk2dEtnNE1I?=
 =?utf-8?B?cU50UmJWTUFMcG1ZYlVMODNCcmFjK1AwWEgxb2E0bDIwZmNyaU8vb2xGNW94?=
 =?utf-8?B?U2lMbHNTL0tZSWZUcVdSM1p6ZWU2U0ZZenZrQlZJSnBweDFUdkJlc0diZ3Ur?=
 =?utf-8?B?U1NVamk4WUZndC9wYy9YNHBJVHpLbDZKSnJ4QVhRQ2dNQkJ1WXpuUU1EWWt4?=
 =?utf-8?B?a05KWXg5WjFCV2todU92bC9oUkFIVzhHeVo4QkQwKzdBbnk2R2tpNjBDbWhn?=
 =?utf-8?B?U0VQLzdNdjdTM28zcHp5K2VtcU5VQlRaY25yV2xzREVydldJQURrWWEvQUdr?=
 =?utf-8?B?MGVCamE2NS82UmZVSTFUWStDc2pRaFBFMEJ3TUlQRGFHYVJhWTZXYllMT0Vu?=
 =?utf-8?B?RG5EYWVwUkVabE1ua3JIV3lmZytLb3ZGbXM3c1BVNmRkNU1EQ21wN2VKZ3hL?=
 =?utf-8?B?ZDVGaDd6UGFqMk00bStNTVlrVTJRb2ZUZlh3ZEVTVURXTHJGekZIemlUZjM3?=
 =?utf-8?B?L1piNFkrNVVKYXZlM1JTV2dNOUNYVUR4eGtjQUZqaHJlamdCcFlXc1FNWWRj?=
 =?utf-8?B?S2FUUG4zOVkzcE5EMzBZTlFjZVdiTTJKWWl3T2c1aktRNk82Z1huN0pSQzdM?=
 =?utf-8?B?MjdRWmtEWHFNdHFKQ3JMTHJuamJ6Z0creTQ4aG9wU3hjNVVNTUpnK3pxT2VV?=
 =?utf-8?Q?IasDkub9WY2YXues=3D?=
X-Exchange-RoutingPolicyChecked: ZhJPKhNl6RAx8ZnwgmKGrluqfbI1dO1wq2r9rVDFZlaqvcZEnzsU33Z9pvNrZitqJHYijui+L88dLh8ZyBCghHA+po00DBSk9xXEh3sD8vmW0+YRbyzl/1EkKhVGEhWxieIwMQEvWqR2t/aXmItXE5Ml2NBkPa/YkMM9hQQTceuRGLzWjnEmcuaZNq7zHr7i/9w8iPDER3I68ogNl8EINbLw92Kus461OfLSzWKNZR81WLKdvZaG5Nlr7NH/nnkpZ5Nh3wmv/hoaRMweR82j01GDK22JJGuGyLVfmq0ZHfgmZr2WYPuHuYGiAokTBK2BccFgnnADJvyUwHNLJyTqSA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ddf5f2-694e-49a7-cc70-08df0e5e1ddc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:35:50.2915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+Pul9G/GiELZiQPvpjPo8FaB5XDeS6yfLsqPC8qI0jPDy/x2ZjOd8CShjwwjqWo6LR2JOYSS4UKY4At+sC5s56jhnLi/owlwGafT6HjnjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7556
X-Proofpoint-ORIG-GUID: 9Zo76J9kRRa5kemV1uzW6YHRlWeg8BIB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDExNyBTYWx0ZWRfX3ZDL/DpyEzkV
 sLe/jZ1HmZD+iNouJYk0T+GPuX/LZMaDrYnPlwA/ezXdU+oz1npjJt95dXIyv7dKWYNiy+C5IV2
 eWUODW8i65A05AWnU2j9xoKGmNCsjvw=
X-Proofpoint-GUID: 9Zo76J9kRRa5kemV1uzW6YHRlWeg8BIB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDExNyBTYWx0ZWRfX6Sc5L4KNcDte
 zXltw6B5sneZ6XHErFaTGhYtL86jlmaDnUyMRyPiL0V5YmxfbXDGGJXWCZY9J/gf2le22nQRwUi
 nrHuA96W9lXZ5tIaL2bnsrLjG9SLKjoa2wi1Rqgl9YIvfzCXZsMWzOQOkNz4DKttyRZbY6APckh
 /EaOeyyrCp7OjFtL9dX2UlejRtW7wqH2LVAtnnWKEqJ4tmhH1qK3Jc1Oc+V3eCixQ0SqkjNyPJg
 kUaMZx+68BZWINRmS6lflzqUsgpIQyfyg1JBYbTS8eiKXGScAS5MSqrFKYAZ23H6o0jTYYWEI7Q
 YHPBLCnaxev5uUENSScy2tJI2E9/BZuEvV9ieU2rD7WJ4bG8o+xwp7H+6WCkqNej4KopChkwQHN
 t7GqnacCw4X6t7QhjUYn0SytVHq7sBguP7cQb0PjdZqOdygPCN1i0cMOY2CSZiL8YTn6TLOyzzD
 4xBHbR85HSmGQsSyQPg==
X-Authority-Analysis: v=2.4 cv=TM11jVla c=1 sm=1 tr=0 ts=6aa13689 cx=c_pps
 a=PDMYrpmLcA1CqgnwcVHdMQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=aow-egSQAAAA:8 a=sGitHjhIiN7uzqAYdhwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
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

On 04/09/2026 06:04, Cédric Le Goater wrote:

> Add a DT-style alias container /machine/labels where board code registers
> link<> properties pointing to well-known devices. Tests can then resolve
> a device with a single QMP call (qom-get /machine/labels/<name>) instead
> of walking the bus hierarchy.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   include/hw/arm/aspeed.h | 12 ++++++++++++
>   hw/arm/aspeed.c         | 10 ++++++++++
>   2 files changed, 22 insertions(+)
> 
> diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
> index 245d02e5f757..0b8b40262767 100644
> --- a/include/hw/arm/aspeed.h
> +++ b/include/hw/arm/aspeed.h
> @@ -128,4 +128,16 @@ void aspeed_machine_ast2600_class_emmc_init(ObjectClass *oc);
>    */
>   void aspeed_connect_serial_hds_to_uarts(AspeedMachineState *bmc);
>   
> +/*
> + * aspeed_machine_add_label:
> + * @bmc: pointer to the #AspeedMachineState.
> + * @label: the label name for the device.
> + * @target: the device object to register.
> + *
> + * Register a well-known device under /machine/labels/<label> as a
> + * read-only link.  Aborts on duplicate label names.
> + */
> +void aspeed_machine_add_label(AspeedMachineState *bmc, const char *label,
> +                              Object *target);
> +
>   #endif
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 1f8d5d3e132d..79b8d55d66da 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -127,6 +127,14 @@ void aspeed_connect_serial_hds_to_uarts(AspeedMachineState *bmc)
>       }
>   }
>   
> +void aspeed_machine_add_label(AspeedMachineState *bmc, const char *label,
> +                              Object *target)
> +{
> +    Object *labels = object_resolve_path_component(OBJECT(bmc), "labels");
> +
> +    object_property_add_const_link(labels, label, target);
> +}
> +
>   static void aspeed_machine_init(MachineState *machine)
>   {
>       AspeedMachineState *bmc = ASPEED_MACHINE(machine);
> @@ -137,6 +145,8 @@ static void aspeed_machine_init(MachineState *machine)
>       DriveInfo *emmc0 = NULL;
>       bool boot_emmc;
>   
> +    object_property_add_new_container(OBJECT(machine), "labels");
> +
>       bmc->soc = ASPEED_SOC(object_new(amc->soc_name));
>       object_property_add_child(OBJECT(machine), "soc", OBJECT(bmc->soc));
>       object_unref(OBJECT(bmc->soc));

Thanks for the proposal, Cédric! A few comments from me below:

1) Is there any reason it should be called labels as opposed to aliases? 
The aliases name as used in Open Firmware feels more intuitive to me.

2) If there is agreement in this approach, is there any reason why we 
shouldn't create /machine/labels (or equivalent) for all QOM trees? I 
certainly think it would be a useful addition going forward.

3) Is there any reason why we need to provide the machine object 
directly to the aspeed_machine_add_label() function? If possible I think 
it makes sense to avoid the direct machine reference, in case the 
underlying implementation changes i.e.


   void machine_add_alias(const char *alias, Object *target)
   {
      Object *aliases = object_resolve_path("/machine/aliases",  NULL);

      object_property_add_const_link(aliases, alias, target);
   }


Even better perhaps we should also generate an error if the alias 
already exists to ensure they are always unique i.e.


   bool machine_add_alias(const char *alias, Object *target,
                          Error **errp)
   {
      Object *aliases = object_resolve_path("/machine/aliases",  NULL);

      if (object_resolve_path_component(aliases, alias)) {
          error_setg(errp, "machine alias '%s' already exists");
          return false;
      }

      return (object_property_add_const_link(aliases, alias, target) !=
              NULL);
   }


4) Should we create a page in the documentation explaining which 
devices/objects should be included in the alias list, which ones are 
added automatically, and what naming conventions should be used for 
devices e.g. serial0, net0 for a network device etc.?

5) What should happen to aliases for devices that are 
hot-plugged/hot-unplugged?


ATB,

Mark.


