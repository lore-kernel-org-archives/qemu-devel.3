Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA54CD6E5D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 10:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVSBj-0004lD-34; Fri, 05 Jun 2026 06:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wVSBh-0004k4-AR
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 06:54:05 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wVSBf-0008Af-97
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 06:54:05 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6556OkpZ853443; Fri, 5 Jun 2026 03:53:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=g6tMSaVOJ4xtCqkhJlARmxwNzwts/bEYylgedLE0D
 Ms=; b=KoNw1QE7QWnxNDs22nxhho6LdhVkKrvcczhrrNYlkPbu+vgyzmTyd8hXY
 RW2fhKkYXa4rRquecvAziaHY+lFI7xLBcM6WB4qYSA6JXLvXJNkIytjbIB7WdVYg
 +FpfwUNLgKDaE3V/H0kzZ0EqIBzLtDrWXK+8hOGf5uwYSnV1J5/qm5JejwVy8J1u
 Osrclcg9oMYq5q8+iV3YuamUm5BcMfnDj/9CLyJSguP1KdCfyEcwNlYO/bvtYHWV
 C26kWjVQesi19I04jJb6CfVsB3CLrJDROlhWGL3itUcp6yX3fIMTeJ8YXaBgV4/p
 C1KmnYYcFajFpaFF03LndgvA7i9dw==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021098.outbound.protection.outlook.com [52.101.57.98])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4eks0trukq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2026 03:53:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XF+abIL1KSk1dMXCA8mjzN/cXP6QkYArCE21N5MI66QcO98cS6VTsWGi1uRu1qpMi5qPjtT93isKw9EU3sd4LDi5Dcm1+6Ixx6bxs4Qr3hqRDurll8G/5wmVXojHtUesTi9WQMB2wekwSwICMm/8jpSOzx+fKNrthlcQjNe2sc9XMTVXXj2EoQRYn7/FfMzvtxttGg3POQIiIx0ztvBiNG0SjXJRmybz+RTujthC9dSQ0KFWZfp2PFl2vOtQs/VKyazqQW/XMLiSM8IygoYnsKuSEbfT3ob0Hl1acs2XYtc8e7JVwVhMTI3jQ0s4No/ULlev94n03NxAY6mKI/4NnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6tMSaVOJ4xtCqkhJlARmxwNzwts/bEYylgedLE0DMs=;
 b=oc3FG9vwLXV2V77TTjuwmj34y0MBHaken+FFti5CXi3jcciYmg5tS0o15uOyxDSgx4W+sfs5ZWKk3xbnsvT3ci9yb6H4XfizSVUlMqhgYxNrhC9AFYul927zz8MM9kRmNioNczDbpDEWlp58fFetPC9UTYATpvwyx91WXGN4RAO6yUpukfFsYiE7yFAFVet6/lQzwAyYoPLTKJo4gn81tzvioh6Gut5fJ44qTOUcgyE4EF/Xm9jX4y8Ujc6IskqkDliTIzXLI3SOKAw3xIAhL6eaoATL1nvdl+kXJTKedqR2AaMtHpOp2rzhcZ8kxU6cf46wtMIAZeJsolDGbRGSgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6tMSaVOJ4xtCqkhJlARmxwNzwts/bEYylgedLE0DMs=;
 b=j19/WMzHI7ASR4vm2Q/k9KMoePjOksVYIXzH+p8qS3e99LHdiqQXDFu0wkbHcz7kLUJRTlWQr8JgD0RiU7fX9df3EQ4LsUmGtn6BDGu0NnUnTOOFtADP4nPMik022yEdHJ8OYPZGmRNlg1xpAFrMU7l8ELF5trxYuLOeZPRTruKyA486daEmtwtHw2RNwfsa10RyBJrLr0BIMcpw3tZO27N/DDU3ykc8UmV9BBZ+0Ui8WQlc5fQzgPIcopaLB1HYeHnN1XTeBhObSKR9rNq/YvKorZggmWxgxdEtlQb+J0APDx9W+An5dXQXhZEWOaXPPDJHt+GAS3q7c7yaY03lMA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by LV2PR02MB11279.namprd02.prod.outlook.com (2603:10b6:408:351::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 10:53:54 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 10:53:54 +0000
Message-ID: <d1eca677-1769-4a48-bce0-3bcbd9d88b7e@nutanix.com>
Date: Fri, 5 Jun 2026 11:53:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] qdev: Pave way for exporting Property to be used in
 non-qdev
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Sana Sharma <sansshar@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
References: <20260604231118.1584889-1-peterx@redhat.com>
 <20260604231118.1584889-2-peterx@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260604231118.1584889-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0279.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|LV2PR02MB11279:EE_
X-MS-Office365-Filtering-Correlation-Id: 659ef59b-e5e7-4b4a-83f1-08dec2f0bc2e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|6133799003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: deCBV8ju5ouFXmTPx5J/MJfjiH43QEDZXmZjrfOdMZPMgP1aKv6PISFe0bCrH5vCIoRwxVJT6ye9aFyitMeuS7FSdzGKMDbZ5eUJSgY4u3UpFxgsCnyTlXCon+LrWZIQ0Hfs7dWp56DOoQlpUTkyg+CKLDGfjXQh9nsPJMGv5HWcfOoIg+KTmHih0SE1De8gKrlke7MoxGnHqnT4FX5W/p3wuiF7W2ct5xeU96PsEzsEd7taKdcN53UzoVXSOds90/QbC0oHEoVhpnyIRAqO479dm1xh/KBOgw1QEi5kARTzRYkiUTtwgC5IC0RkAtg3R4z7ppjEL68Y7o4i2j9Ip3vDykR5NZ88DxVMqDVL5j8VdPuCN53DcT7qcfbqNnuxltT6CGNgpcSxiV5i8KQnxpxF0NliW5UXmBmR3eECIZNmysM974B4yrpeqPNdsvP0kZIigDQafRPPPvwh6eZ7u6T7Abk3vd9+cxBYl1jJvN+6XHhzbNm+a0QhWxgFSFq1Aw6bofGJyEKznR5GXaBz3Ud0xtbra6UVFTat7sye6/yTa4xy93V3lYJlNYlXL2PHCm1Ndv7aHlEhSa97vp5ZsuVLKO3XYjELMLztpHr7DRlm9mizN8rGGrhm4uD/EcyA2q7SEcp9f4mXMrf2Upvc6iua0zH1ZBCBqQagkOpFEJKle+aSRbDh2FCcdA0FD3Fz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(6133799003)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1FEaGxpMWJ2cFU1T0VQWlNuQVViZFFCNnZMaDZkemkxaTVTdWJUSzVaVzFD?=
 =?utf-8?B?T296UStnOWZIVVo0dEMwK1dPRDFZMFhFUkRKUWxSR0crTXBrVzJxSmcyU1RZ?=
 =?utf-8?B?WDdpTVc1R3BxTkxxZnArNW0yVGhSeEZYeXNiRVQ3Vi9YWjIzcUovaXJWM3pX?=
 =?utf-8?B?THhVSjdCN3BIbExXVWFjOE9Xb0crck10MFNoQ2VrSmtheXNyR0RGbjFxNDVL?=
 =?utf-8?B?NW5zTDlJZFZUcVZTWDBiNXZpZ1VhcU1JTkRKZmR5ZzNFbDl3ZHQvbS9HK1NX?=
 =?utf-8?B?T2o2SjNCSHZpMVNnRmJzaitPVWVGWWVIbXVnSzdQVTh0QmR4bVJsTnJPZGVR?=
 =?utf-8?B?eGZ2ckVsbFdXMmRld2VEQ042QlNzTmxLcUpiekpZY2FZeCtIaFVNTEFwN3Js?=
 =?utf-8?B?L1BFbnZkQlBWNWRwVGZzNXFKQzlVUEdBWUJ3WWhvWGNlT3poRlVDR3hwQ0t1?=
 =?utf-8?B?TGR6S1ZHZHI4c0RDRE9RdTJqd2dBS3pZdlZiNHZ0bG5yU0E5RHUzYVFPRU0v?=
 =?utf-8?B?VDU1K2trUlJmdE1md0s1UnhPMDRhU0gyME5OcWFVMEVDK3FMaEh5akdaeXBa?=
 =?utf-8?B?aHE1dnllcjNDS1phRFVqRXZ2akplN0dmUDIzRFpQRWR2VHNxaU5IN3F0WGcv?=
 =?utf-8?B?YmtQb3FTRGdEL20vd05LRUQ3alI4S29JOGh5bVdpMDcrRUVSNHRLcWpSaEZ5?=
 =?utf-8?B?T3hFVXJEdnk1Q3g0NHJXeFVDdU05eFZ1ZzZ0QmQ5S2NQandFMG95MlJFVjdR?=
 =?utf-8?B?MkYyYXpUOTg5NHR2NzQ5UmxINjU3M2dCY0FOcUhVbCttdnN3SVpkSnYxNUox?=
 =?utf-8?B?MmxESXlPcVVsRzFudkIrNTRIdTNEREtiY1ptVWdMYUVJTll5NTU5WXZseThN?=
 =?utf-8?B?ZWZKemZ5dzB4NG5DcFRxV0phUnpJMXRjQTFzdTJRK25FMFFaZ0UvekJnM2I2?=
 =?utf-8?B?QmxUSnlwZGJvQVZxVGkxMGVWNFNjV1lyWWVUMi9HS09yRGhsMVU3aCtIelV0?=
 =?utf-8?B?aExDNUVRb1d3cHFIQjRhVGdQT1ZRNXk2NGpWcGVyZ21td1hMRjAvZDk5RVpI?=
 =?utf-8?B?dGJHWlJOdlZBeHQzUXNKZW5YcjhlYVlkb1R6TzRrUU9MZEZGRi9MWEFMVzhl?=
 =?utf-8?B?UFRPbmg4Qk9sYlVrbi9vdHAwbm9qRjRTVUNoQnVoUkFHVFFQVFVqSHdUUEhm?=
 =?utf-8?B?Y0Y1S1VmandMSlNzY09jWDZHY0RyTWxaMGRXV0xnM0psNlhzc1hBbmQ0OXRk?=
 =?utf-8?B?K0hxYnpZdmRKWHphdHpjUFJ3QTdUWnlPbGpPRkcvbklDZ3p1b3JNZGZ4ZzBF?=
 =?utf-8?B?NTZrYlJ1N25CTlpvUkthVGZCUHIrMEl4MzAyWjhPeUxLRzZrZkt4cE1qVFVv?=
 =?utf-8?B?VjJWRllIUk1nNGV3emRnYXRMNmN5REdUZG9yYy9VdlFybWtCQ2dVNXB6d1pj?=
 =?utf-8?B?Qk80Z0JvMDlaaU1FZnduVTJoUFZBWnFQVDRuMnQvYXZwa3NJQUl2MXNsRHdw?=
 =?utf-8?B?TnJBOW9LL3lPNlBjZElRc0NFY1o2N2FoYTU2aTZ2YlhOZ1NZSnhJVGJ5OG1G?=
 =?utf-8?B?Y2Nlc1BwcEhaLy9WUkZtUER3bXYweEdFMGoxREV3WVJ6Y1huaUp0TzMwdU40?=
 =?utf-8?B?akR6aGV2dFNIUDJQczNOaHFKNTd3L0htbHU5NUkzWUwxdGVzbGphc1J5NTRQ?=
 =?utf-8?B?UzAxcFo0M1lrd1VoaDh0bUdXS04wYmJXdmY1N3owb09JUEJmTUVJdy9ib0hq?=
 =?utf-8?B?S1FObUNmQlAwK0xvaXNSWTl0VUY2dFpOcnk5UGM2R2wvYUZrZTB3MUpUQmxh?=
 =?utf-8?B?UVRqNnpiWWFBT2hGbkgyYnhZZk4xZ3VyMVF6eG1jdGVFMXVvTU1tQ3k4NzlV?=
 =?utf-8?B?Qk9rUlBFbHRrVU5zMklLVnRlRmtEWkQ1NHE2OFhtTDZPbG9lb1RXeDhxWEUw?=
 =?utf-8?B?eVVVZS9TN25DR0dnZTloRlBxL1c0WCsyVlFveEZpTkl3UXBpSWJtUEVuQk5T?=
 =?utf-8?B?VzcyeThUM1oxM0xXbWh6d3RCSHlSZGpqTVF5cEZxenVYVzdIbGNFczVZdVc3?=
 =?utf-8?B?cHNwWFo1ODBLY0dMcVdZbThaR01DMDNPVXpYc0hnMWtNR0t3N3FOSEhwZ2lC?=
 =?utf-8?B?T3FVTVlpY2ZqWlBEcWlZU2liM3FXM05Nd1RFVTQwMVV1SkVtc2pjMGFxa05J?=
 =?utf-8?B?em9mekMxeGtjZ0V4Z0JPR1pxQS9EK05vU1o3UUM5OXJ6Y010TVlJUkNFa3By?=
 =?utf-8?B?eWlLenk2RmVaVDFmNTk5L1o0U21WNXNFNDRhWTBudTBQWExlMnpENC9xUFR1?=
 =?utf-8?B?UHZCVkFJTzFSMTZrMmhxMFF2MkN2MXdsVGliMkZ3N2RZdWNVUWlsSGwwTXMy?=
 =?utf-8?Q?/adRh/Mq7XaVnSM8=3D?=
X-Exchange-RoutingPolicyChecked: J7DtxHyqNHfdHMIawPBjhn4g/sWaCe2UskCpRXtU5WB8vbNEYRFflq8PcmKv9HRWPRwCg8DkyEcsO/OXZ9kYrAInRSsLvARpNsHLSQ6GmYlP7+gUihzOey+XII73qnoC031J9LJ3oPYUfXRB55jRdGAACl5alHfzbGCAlyDwry4BApU+MuIKAjwlWhMlk6Te0tiGefILr5j12CONgJ526YyXkWNwJQydfWdMfXpbB3pssKGkvzuM6bt5GTg+HxlgINEnS/GXgHWEIDxa2tF/+eZz7QcqS7tk4QUvi570az85Ie8jdFkzGItEX8G+aMKdLzYJYPC8zVr8vSq6SWm3Vg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 659ef59b-e5e7-4b4a-83f1-08dec2f0bc2e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 10:53:53.9576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPtOjYiV8wrxjEF/QI/DZBdhwPjjGCIWKqPbbOnyrG0scxXR1c778q8jwr7n9gvWWycbFnmC0u/xF0Yqn6TfJDuCUEWo3ZL0gH7qUkp7d2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR02MB11279
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDEwNiBTYWx0ZWRfX5i+cjyvfFMkK
 X3BpzmS3js5pTslqMIaYVJ9GokycUl3KtPATHFATvYiJ5JljQLJJBSXHg5MX+F52d6Dm+uF2Fll
 JGeyBQ1Ge2AjHf3PnRFbfvA6gPZhpHnoY/IB35T/Kn44moXhIcyqQ79hZTZTldXGNJHVoWEcumJ
 toX5BKK/2A3uT4fyqlknLtkQYDq6dxEFOPDhoyw6ywpHPJvCoJKrISx+QsdkORm77hY9IPQ8HOt
 Dr8vQTyKi4A+zTs08ZFeNS1TYE/5fg8DSKhem1t1YQs6qjvz8DKQrkajqlY5F9XuLwYHhVEvRW6
 zrMxREE6Nw81cS9pC+4Fm5MEuEsfCVQ+nk9bUGXdKQVDRBFNaVPW+aTOaAsuzJnfNMlSBFjD14A
 c5ENQ6xh8wirCszSU6tMak3XWMGyfp5wAMWgBRDX4mHHWDs4LGYhogSiH3H1Ixg8y6xz+nNdEx4
 CZ54PNPLV7TTg+c3rJQ==
X-Proofpoint-ORIG-GUID: e-hUNgjKhQDloiUcn5P33xM-SA_U5_jS
X-Proofpoint-GUID: e-hUNgjKhQDloiUcn5P33xM-SA_U5_jS
X-Authority-Analysis: v=2.4 cv=M7d97Sws c=1 sm=1 tr=0 ts=6a22aac4 cx=c_pps
 a=zHc5ipMoJZhVMviFMUShKw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=C3qZkb8Sg0XxwxKT:21 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22
 a=_-M8LpHI31CeLmyZm6wg:22 a=20KFwNOVAAAA:8 a=AVGpOPo7-WZ3x01ghGUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

On 05/06/2026 00:11, Peter Xu wrote:

> Property itself is a well defined interface to either support smooth
> conversions to Object's properties, or supports global properties.  However
> currently it's tied to DeviceClass, aka, qdev. So non-qdev cannot use
> Property list.

That's indeed because Property is a qdev-only concept.

> My current observation shows Property is almost ready to be used as a
> separated exported interface, except two small things that may need touch
> up internally:
> 
>          qdev_prop_allow_set
>          qdev_prop_check_globals
> 
> The 1st one currently checks against realize state (which is part of qdev
> attributes only).  The 2nd one checks for all global property being used in
> all non-pluggable qdevs.
> 
> We can loose the check in both spots, keep the check if the driver is a
> qdev, otherwise we can safely whitelist non-qdev use cases of Property.

I'm really not sure this is the right approach: surely you would want to 
flip this on its head so that -global makes use of the underlying QOM 
APIs instead of qdev APIs?

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/core/qdev-properties.c           | 24 ++++++++++++++++++++----
>   tests/unit/test-qdev-global-props.c |  6 +++++-
>   2 files changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 34d7b26a73..8f870c85fc 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -31,8 +31,14 @@ void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
>   static bool qdev_prop_allow_set(Object *obj, const char *name,
>                                   const PropertyInfo *info, Error **errp)
>   {
> -    DeviceState *dev = DEVICE(obj);
> +    DeviceState *dev;
> +
> +    if (!object_dynamic_cast(obj, TYPE_DEVICE)) {
> +        /* Currently, non-qdev can always set Property anytime */
> +        return true;
> +    }
>   
> +    dev = DEVICE(obj);
>       if (dev->realized && !info->realized_set_allowed) {
>           qdev_prop_set_after_realize(dev, name, errp);
>           return false;
> @@ -997,6 +1003,7 @@ int qdev_prop_check_globals(void)
>   
>       for (i = 0; i < global_props()->len; i++) {
>           GlobalProperty *prop;
> +        bool hotpluggable;
>           ObjectClass *oc;
>           DeviceClass *dc;
>   
> @@ -1005,15 +1012,24 @@ int qdev_prop_check_globals(void)
>               continue;
>           }
>           oc = object_class_by_name(prop->driver);
> -        oc = object_class_dynamic_cast(oc, TYPE_DEVICE);
>           if (!oc) {
>               warn_report("global %s.%s has invalid class name",
>                           prop->driver, prop->property);
>               ret = 1;
>               continue;
>           }
> -        dc = DEVICE_CLASS(oc);
> -        if (!dc->hotpluggable && !prop->used) {
> +        oc = object_class_dynamic_cast(oc, TYPE_DEVICE);
> +        if (oc) {
> +            dc = DEVICE_CLASS(oc);
> +            hotpluggable = dc->hotpluggable;
> +        } else {
> +            /*
> +             * Currently, to be strict to assume all non-qdev are not
> +             * hotpluggable (whoever will use -global).
> +             */
> +            hotpluggable = false;
> +        }
> +        if (!hotpluggable && !prop->used) {
>               warn_report("global %s.%s=%s not used",
>                           prop->driver, prop->property, prop->value);
>               ret = 1;
> diff --git a/tests/unit/test-qdev-global-props.c b/tests/unit/test-qdev-global-props.c
> index 8ea362cbb9..86bb1458d9 100644
> --- a/tests/unit/test-qdev-global-props.c
> +++ b/tests/unit/test-qdev-global-props.c
> @@ -275,8 +275,12 @@ static void test_dynamic_globalprop(void)
>       g_test_trap_assert_stderr_unmatched("*prop4*");
>       g_test_trap_assert_stderr(
>           "*warning: global nohotplug-type.prop5=105 not used*");
> +    /*
> +     * TYPE_OBJECT can opt-in for global properties, so the error is "not
> +     * used" too for nondevice-type.
> +     */
>       g_test_trap_assert_stderr(
> -        "*warning: global nondevice-type.prop6 has invalid class name*");
> +        "*warning: global nondevice-type.prop6=106 not used*");
>       g_test_trap_assert_stdout("");
>   }


ATB,

Mark.


