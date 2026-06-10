Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E662CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 15:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXKoO-0003Dq-Li; Wed, 10 Jun 2026 11:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wXKoM-00039Y-BK; Wed, 10 Jun 2026 11:25:46 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wXKoJ-0004ft-Lc; Wed, 10 Jun 2026 11:25:45 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AC75JW1101830; Wed, 10 Jun 2026 08:25:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=LG2LOU1mFYk7qxM0FOWscXGiVA4VeWLVZ1bX0PtLn
 ic=; b=sVNkEj5vS6lAmpL+MvWE+DqaDM//tYedMSy99cbgCwTdPPYTU3StO8C5S
 rF0rKXKKL1uhiMVFdlCvXcBSzPrmkAmoHr47N9yIf7+BV0DRJf+WouOi3SwE5OCm
 khn4QCmCzCBjWA360eTfwORA/aJMOagHacJnZ9wY8cQeorTCGxM36zCQc/KntrSk
 Ea9SZcfP18lZjVnTYT34JGHa2LWFynlqnw54vlZPPaBeYjLBWWl9dMNC6R44u22S
 sV5HcP7UNZCuXAG8y3XsiSTiZmkqUVUIuoxC6qo8bXcxpvZB1cNunFba9TPIf6Jw
 YgAsqq7qGHy+QlziXHS8H0h9eOELw==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021079.outbound.protection.outlook.com
 [40.93.194.79])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4epsspakg0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2026 08:25:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvdS0TBjDnKBdNYuxgFm4+rtLrw2JfM1c7wy+RYT8Ntmro7M58bWTg6ZYkt81ykhAYVV+2nGuXZlBnBm7XcAm3SJZJVB0OTcQESJGqTyrO2kxI5Q5Q7UxDiLw2PrnwDzqNAPHBAjtSU0dtn6QeFmDd57Opm+w+r+0EzUKI3OCuzKtOcDkOJl4L1Do/IP1UZOabTzn8DIFLD8BDmhKsKfRtste5y/yR/65GtJDbePJCVvHpmkr2Y9bXsznbHG4kcG7lRIMFRtQcO/AizQafHREIetUQuyFxkSMngS098YgcbjvYe8t7NEgl1olSgONa08g0e1dXAvCa432vzFvVXRJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LG2LOU1mFYk7qxM0FOWscXGiVA4VeWLVZ1bX0PtLnic=;
 b=jGGXB239aIxoEzEhfn9Z6t+w77lmmbxYT0eoV0IOAN1fvxce8SnlUdiqomgFXvTq9+WR6S7QqjfWv9fqhmeC9n/SiILGpdGqh2W/z6CgZIHyUEUeIkXms/cjG9XidxVt5LFxHMYXt2KOQiiWehK+W7mEwB5adk74ugg43y9EdqmAAK2qnzHeDHbycfK7GV3f+PFKBCV/Pn2kH81RMuskWotDFsu6DzNQIH8McJbVZvhYS20Z8ObVc+snxeDww3I4pMQRgW+z91hPuIzoR9KFo6aHwUXUZUGv+IPW5qD/8BSQkQecw0tkQKn7NHoW0Nuwf1nXsWmT2PCXX2pOnvEUJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LG2LOU1mFYk7qxM0FOWscXGiVA4VeWLVZ1bX0PtLnic=;
 b=N8o+FNIb3XP4Rtyeo/sfvlBEVrZK5OpZIleTDeBt2J9pUwSAXFaiKb3PDnzHhU8WjFCecAUajYAXiazRGfPTjBqwssO6MWnPZzOQ8HXzBOBQEijVRAZdGmkF+6UHUoHgCia61N8cK5J5ohd6CYwB6z9Bhy+CkNk21l2q344mLK0jHwsshOVdeemhJ3QkhUNHFPkCxtsgWyhpAJ3W55okONboneeHfD9XeK38d+s5iEAypUxc4A9PR/n3CsUIHhOlrsosl6NTO2Gy7Xanfv3+gj/82wD8n7PoQ3CNDh16+5nxYctwERwCCpakvNo17efrr4zWi5vfaAcAiTPnYkb7wA==
Received: from MW4PR02MB7153.namprd02.prod.outlook.com (2603:10b6:303:65::11)
 by MW4PR02MB7123.namprd02.prod.outlook.com (2603:10b6:303:77::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 15:25:32 +0000
Received: from MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd]) by MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd%5]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 15:25:32 +0000
Message-ID: <c17c7fcc-850a-4c3b-b859-fc4c618a0e28@nutanix.com>
Date: Wed, 10 Jun 2026 16:25:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] qdev: Introduce DEFINE_PROP_*_NODEFAULT for
 bool/uint32
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, Eric Blake
 <eblake@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Sana Sharma <sansshar@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20260609172514.2037645-1-peterx@redhat.com>
 <20260609172514.2037645-4-peterx@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260609172514.2037645-4-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR15CA0178.namprd15.prod.outlook.com
 (2603:10b6:930:81::21) To MW4PR02MB7153.namprd02.prod.outlook.com
 (2603:10b6:303:65::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR02MB7153:EE_|MW4PR02MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: cf00f185-1c23-4e87-95fc-08dec70482e1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: i8YlDW2MuXj/NRmMY7azClfSrvoX0KbFA41jpb/28lBejNebKTBzRZz+rZkfoQQotw1OoHESuWqY7YMHGVW8/tjE49HESobh2pMLd7oDSYUxV7QSe5jo22jaGl5fJGl/nhj5vsAdmKc3ouzyEDkokKJFdItGAV21R89Dk22GHeyrsLaVJ3hkwsg4eGZ8Uzl6dWpLQWBDFfGpiwlMSsgN5C+/gXakPClbaNqd34c71CHivDIsPTU92k9ucoh5WphxwVxvSif5swJoiUoMdHqoOARBjyPaIbRQjFqwb1KHJSUwqP/TCXUzB8A28GkH+SmzsO8/+sgL6X7LhVQuzExVls4xkTmlpOLWW0J/8H9TO4oRN7vpZmhibwuzvjSk2CWYkayaA5kZ5VBApuhlj4wyg+WGKBKQlKPxnb/8el6t0NHxKmDMycsrlUJqiju08JFaaTzOptu/yQZFG7ukl3uVP6LEBeu0Ya4mZl+uBXYxIkZ7DJkp5UyWpY74mAqgr7H7H78zV0/CZbyEnsTYCt/RN/AaAPtgNMkQrc1hCyuWBIwTeY6BThiUWwa0zVF9rfWnaTyxl6YzVSVlAYFLAASU9teGSmMBvxI6ogUvmtA6IpshG04QeKtClZCrvLky/1YRE1s9wMn9vgar6NQi0hiFT4P5Z9BacjOv7TBOsIBm7jwi2QkxhMUml67LWa2sxv2O
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR02MB7153.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHRrQzRQeEp6Y21uelhSWjJCZUxzRHRnVHB5ZmNpZ0lDdVhKUEVaY0FaR2tY?=
 =?utf-8?B?YU03NDFQemNZL3hxMGdYZFF4eVhMOE5kemc4WFhqTUF6RUV1cmV3LzlHMzVo?=
 =?utf-8?B?Z0NkMCtDcnB0ZS9ORnBLZXJuN3dlMkw4R3JhQ29XTzAzTGVWdkNiMEhpLytH?=
 =?utf-8?B?c0NQT2hnV29sQU1Bb3JOc0tjcXE0VXZXci9GVjF2bGhKNm5XWENScG11bitT?=
 =?utf-8?B?c0tpbHVSM1N0NHZzS2FocFE1djFEbXFaRkNJWlVWWWhFMDVzTWNnMHJiUEx4?=
 =?utf-8?B?dVI3bGVjc3pEM2lUWGxlNjFWQnR5UnU5ZkRhMUoxMlJQSXVSMS9saVk5S1Ro?=
 =?utf-8?B?QU5UNnBTMDlmWUU5dWh2MnBkZWk4NVQ5c1Y0QjBwSDBzdFAwZ0V6RDQ0dlZy?=
 =?utf-8?B?cVRhcjNzb05CR00zUG0xemJkRmZoQ0QvbVJxcGRtcXBNekRqV2o4cWpzblB6?=
 =?utf-8?B?S1krK1VSczJhaFZCTTkyRnBRa2REd1J6dmFYeDBIcXIxUlZEcmxKY1NYR3Zk?=
 =?utf-8?B?Yy9xZlJBYndjOUh2TWJNUUVZMmNmaHhTSjN3MS9UZVcyaGFERnNwbWZiUzln?=
 =?utf-8?B?SGVxME5TQTJHOVVHaWk5cWpNNTAyVG5hbTIwVTVBdnNscUxOOGEwbkJjbjNL?=
 =?utf-8?B?MGVZcXJBTEREVmJOd0F6WUw1OFM5bmxUUkhEL1AyQ3dFWkh3WFozWXVtNUhC?=
 =?utf-8?B?blFoNmNvV242NzhSQjQ0MVYyNmtYUTJtaEJ4enRWei9zQnhxT09pYi8vMCsw?=
 =?utf-8?B?WnJTcFhseHYxR0FZclhZdUFEMHVnVGNCTU9uL2Z6ZWVhRm9YeEZXUmF4d1hT?=
 =?utf-8?B?MlF3N1J4SDlpMGhmdXBWYiszcFNPOWhmbzI4aGZoS0hYNVU0RENEb05POERB?=
 =?utf-8?B?elR1YXZsME9DeW45OTFNWVhxS2pMV2NPMVU2N1FYNVlMSHUxN3dpemZtQnJE?=
 =?utf-8?B?WFVYZjZ1c2VSOHpGc2VabjgrRmdEUDNTVXVlTGxVVlIzU2VTaEptRWxncjhF?=
 =?utf-8?B?RnF1YjQ3QjdjL01IY25SbWtsOFFJRGNoTzR2empxVzJRNnBIR3NsOFN3Z1lL?=
 =?utf-8?B?Mjd6K3R2cFltRnZDSXgzUk9qQjlPcVgyQUk5bUZOMmlIUHFWMWtzQ3ozeC9a?=
 =?utf-8?B?UGdhcTRwSERkck9aRldMOEJkdHZpeUpEK2Q1ZE1zdzdQQ2lPUGJlK040cDFB?=
 =?utf-8?B?aHk5MmVaR1NtVTF1NXAvRUZMQWk1VzkyMmQxYTVBekNzYW1WSEordXlUZ1JV?=
 =?utf-8?B?U1M0aWxvdUYyTDFiZ0xPdEhMSXF5UkZqbllIdFl6Zjl3c0hYNHRPeWdtRmxs?=
 =?utf-8?B?cFNqMTZxdVgxc1Fzbkc0Y1ZsOG1vYWs4UVladVFjRVI5VWxKdEx2ZTlJalh4?=
 =?utf-8?B?dW9TSkw4QmRXUkg5Y0dtNnA4Um8xZGVNOS9uaDhHclBZTUlwYmNBanpiWDBR?=
 =?utf-8?B?TWR4QlpWaXZYbzlieEwrdDBwa3FVdWI3ZmMzOWxGNWxRd1poU2tuWlhRRDJr?=
 =?utf-8?B?MHl1WnNkWDhPQ3VaMmlqT3VUT1NPM01ZMXRjM0JnL0xxZTA4aG9hMWtFYmRP?=
 =?utf-8?B?cVA4WUZueHdyWnZPeUNoZTgwNkxxSmgxY1YrMVJPdmhEOUFVVmpLdkZOYVVr?=
 =?utf-8?B?bSsybE0zZVk0bkJFOTNzM1oweldMc3UrcTFHYlZDeGh6SGFBWDlvcTAzVnB1?=
 =?utf-8?B?YWxEbWhwQUFKbWJ4S2x3QUYyTUVrL3NWa3RWd3llb01XTGFkRXdqNVA3VXBM?=
 =?utf-8?B?SWJCYlhRamZGWHBVdFZ4amNuWVordWVYZWgzRGh4WTZqUjFmRzFnRFlNbi9I?=
 =?utf-8?B?elRMSkU4ZFFyS211OWRwQ3lJWXUrbiszUnozeG04dms4TE9pZjJ2azVkOEwy?=
 =?utf-8?B?N2VTWFJxTldFMnNDT3F2OHF6c1cxMHBHSWhxUjVHYjJ0OEFBTzQzb0E5YmdM?=
 =?utf-8?B?d3VkcUM2WWZiWGtFeUd6aVNYSkMxUDUzakhPNXcySktrMTdxY3FWaXZ1ZS96?=
 =?utf-8?B?LzkvRjJYTEozV3VJVUdRbit4ekY2RVZCOUU5czVHUXFxZU84dzJhUDgwVnVF?=
 =?utf-8?B?YmFNTFplVGxQd0JzU2NHNWFNMnJ0dFA0Q3ZsRzNIOU9tN1Nid2lKT1cwc2J1?=
 =?utf-8?B?Y1E1TnQ0NHZzT1F0czZHalFuenB6KzRyODZqM3F2MjViTzFQOTZUNnU3MVZR?=
 =?utf-8?B?dXZDV3VHeUdrRzV5Wmp5MmxHM1Q2aVd1NFZjY0NVRDZLUDJnTjhSZ293bkN2?=
 =?utf-8?B?N2ZYNUpoOEtySy9jbHZjWGRQUmh1TU9UZlhtNDZrSkM5SEZubUNxMkdmQ0ZV?=
 =?utf-8?B?d3ROVkVQdTh4US9Sc21uQlByWmpBQVdma2YvOU5VajRaQXdtd0NuWlk2RUpP?=
 =?utf-8?Q?2jU3BW0GYqpCd0zw=3D?=
X-Exchange-RoutingPolicyChecked: cGNG6gzd7VxiEEQlpvjsHEVy0p097KlyOYx9r06one9p6cdnwl/N6iFsxcJpjQOIApAaKZM4x4RzJjkwX1q3YPcLA9TsOGF8T2vVRGxl75NyN8lBvBXOhNfa7qrVP2FY+dLUmDjhgGJXkG+qulVHxrFdyRSilrIMEc+BK9uK7S7CKLlrlgR3XpucRu0Jk8HaQtximF0fohcBSJ3dIpDG1/zm0oZDS2zhKLlNJQVcTc9CKsOKVUwRWMsVzxeYe53YYOaM7JdvLHh9wQzcDuIvcIslRScOEwZKyoMU+ElVoxekAnA77qel68efZjQE75jDYi7t6axgvowsEIpeVNh7Ew==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf00f185-1c23-4e87-95fc-08dec70482e1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7153.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 15:25:32.3590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9pdTkZ0l4T421MgrcJbUYgRhPpV4fWBuZb24Xo4xV9pcatTT7V3ZxHofIlJlvfJjGCO8CIASf/7NI58eY+J2QG4nzSfOo3sGGwz65mwlog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7123
X-Proofpoint-ORIG-GUID: mXmLyn9041MWZXlIP3rL4qoQMsQcZBBJ
X-Authority-Analysis: v=2.4 cv=Yf+NIQRf c=1 sm=1 tr=0 ts=6a2981f0 cx=c_pps
 a=ic/V0UXtXsqqvJ1es2EIKg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=py1tUsydRiK2NoZmFDQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mXmLyn9041MWZXlIP3rL4qoQMsQcZBBJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE0NiBTYWx0ZWRfX2+z42gkzZ8Mr
 Sj9F476M/0ed3eRP7sJCZuO8FkQ6VRnB7Zxc3JMEaqpyV40qOkwx36gqmQoNn4tetNPMEEY/9UK
 u9IqL+gB9VgIvjRhHpoZFCtsmETtlOtqU9hYELIhwNB5+kAEAF18qxoQNM/O3g2+Se8XKsjUjAA
 grICA/ma2asj7PwRSV8vT/510Vu7ihoa7iZdL1FwgPMQ1NTJ2ZkfHpYpfQFjWPHsone7VRW9CT4
 M+nKptQBWyef5f7LO+tezFYzOk3wpkk7ICpnCJi073pp9LOYxYNwPX0whXHQ4w3pqNW+0WWi/2+
 S7hiOm9Jnq7a+ocmsmYurO1Vb44HCyUmm6IEfNnfxOu6cInY1Ox72Qd2ECdWEMSrXYJCHyOjSAA
 xXHHGVzadP07PrOeenOz7wNX1Z7lMVdu4h+s0aKgOL55o0mRwBR3nGa3lboqRXL1JoaxTnuvHaQ
 Hrs4YGRKarzSIT9CHUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
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

On 09/06/2026 18:25, Peter Xu wrote:

> Introduce two macros that will be used in follow up patch to create qdev
> bool or uint32 properties without a default value.  Do not introduce the
> rest until they can be used.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/hw/core/qdev-properties.h | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
> index 248bbcbba7..43878d1f9e 100644
> --- a/include/hw/core/qdev-properties.h
> +++ b/include/hw/core/qdev-properties.h
> @@ -124,6 +124,9 @@ extern const PropertyInfo qdev_prop_link;
>                   .set_default = true,                         \
>                   .defval.u    = (bool)_defval)
>   
> +#define DEFINE_PROP_BOOL_NODEFAULT(_name, _state, _field)     \
> +    DEFINE_PROP(_name, _state, _field, qdev_prop_bool, bool)
> +
>   /**
>    * The DEFINE_PROP_UINT64_CHECKMASK macro checks a user-supplied value
>    * against corresponding bitmask, rejects the value if it violates.
> @@ -201,6 +204,8 @@ extern const PropertyInfo qdev_prop_link;
>       DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint16, uint16_t)
>   #define DEFINE_PROP_UINT32(_n, _s, _f, _d)                      \
>       DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint32, uint32_t)
> +#define DEFINE_PROP_UINT32_NODEFAULT(_n, _s, _f)                        \
> +    DEFINE_PROP_UNSIGNED_NODEFAULT(_n, _s, _f, qdev_prop_uint32, uint32_t)
>   #define DEFINE_PROP_INT32(_n, _s, _f, _d)                      \
>       DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_int32, int32_t)
>   #define DEFINE_PROP_UINT64(_n, _s, _f, _d)                      \

I think it's worth mentioning in the commit message that this extends 
the existing set of _NODEFAULT() macros, since I had to go and check to 
see if this was something completely new being introduced by the patch 
(it's not something I was familiar with, and we don't appear to mention 
them in our docs!).

Anyhow it seems correct, so:

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


