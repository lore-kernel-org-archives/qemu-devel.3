Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F89C61DC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyrRt-0003ue-EB; Tue, 25 Aug 2026 09:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRo-0003tU-Cs; Tue, 25 Aug 2026 09:44:16 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRm-0002XZ-M7; Tue, 25 Aug 2026 09:44:16 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PB1B6I1846124; Tue, 25 Aug 2026 06:44:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=nBUuwZqfKQKFJ8OczcnyLaKLFQuiiqiVzciQMuygT
 VI=; b=D5YAfh0F+HoIo0kps2XRanl2vBYD9YXqfvx3Nq7MMvpVcAB4BBtTT4xHt
 Ta2TTnWTgh/MqnMVHmSxP3WEjOzIqo87L00xxA12Il3bTpRQudCs0Pr9FHetthBI
 k7GLlXQL75RKh+lxPooGBpU8VZUtP4Gp6fKTi6w45t6oPXqcAcO+9LxmRSsLrE26
 B9mmdlM+vrt+ZV9ZflYlrppNmN88lHi5BJg1E+AwvEUUbKyTNZUKPL3upeo//QTU
 7IeSIGjAFlRugAQxcYmKnOQ/+WzVdnMmyHT+yChWUULZxMkXZUXM70i2lHuO1rw7
 AXBij4dQ+kxXTliAyvvuylbPDIoVQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022134.outbound.protection.outlook.com
 [40.93.195.134])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g7baved93-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 06:44:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBk1Q5HgGred3rsRmkJPSM6+M7YfyUEUHboN7cbAkGI8LssNWQv6pyWGsuO9NxFnuHJs8mnL0L5IB+haxl/6WB39fB4lcGWLpi+Oe9asRNTEhCMZ7R24fIG9mHevRvcElRQt4Zvps7rc+x9VsSitS/YGZiqEm2fZfi+ZJ3wwhGZ70Hpj/oFApdXqufBbVq6l8XYI7zIHvu9q5OEWMDfmho8aWk2zrAuRmJQpS6lH3LxUpgqzSseV+QZYbzHUZmavOO9jQ7EqYQPPrXZRevhpQM8ACyRr0D+iUw6rm4b2SF1mS9Z7I6yYg1GdD/stgMmWACQgCiAZOdP+gCFhr3r+aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBUuwZqfKQKFJ8OczcnyLaKLFQuiiqiVzciQMuygTVI=;
 b=wkglN4zZDraZbbW8OexaS2Yd/LbIEZQ7ybLzoMvULeQTteGunSzdfn74vvTYWYRXBZHcQt2DY2r8om73j1RonAD7ZRzFyVYjFb5kZvUnoZeW8HaLaLoXLLOWAQClJoUPI5WeOc8yrjvwA/WPwkyvsU5WLFu6xSKJmTV64jcqeN98tRAr4ZaI6Pqkv/TuxuLrInxQ5RULQ/FG/abdJQkVACQFvaJuhPuADGMFYfM5eTHRRLs+DlrROLWSyteCbn6GrmZO2J+VpyXGYVt4DQZMVDXtL8vQmtEvlCCjVlQBlORvQfPc06jDo3yZIYOTHXMYWl6atPZsxCqGwf6dj8TN1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBUuwZqfKQKFJ8OczcnyLaKLFQuiiqiVzciQMuygTVI=;
 b=tHn313UTcIfOZgvWpalwq0uJpl9xXExVNbSKllyYhH2KRs+n9N3rFNnFrI7PAzR+M7oarN6nRiz7Gbb09dAFBVcZSXtRzeuYl6kxJ3Omefa+ZEBw+SRyOGUuayfFukTibviqH/3Z/OfprzXZWHKusKbzljj+52G/wZkvorPsPB4iFvurfdziR4U6LTMtD5oasX1Pnrn35mhrE8SmM2URxD8Pt/hFlwQz9rOabAnnJjE4WlmSOs8EH+X7m9Dv7k982swab2DWkjcvLLe7j1McjobAHPuNCa3uDbG+EWXsO10C9RpA5F6wSQILsaSYr4Lcwix0hYtnBNN6L93Gwg3e7w==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB7557.namprd02.prod.outlook.com (2603:10b6:510:54::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 13:44:00 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 13:44:00 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v5 12/16] qom/object.c: add
 object_class_property_add_uint16_ptr()
Date: Tue, 25 Aug 2026 14:41:33 +0100
Message-ID: <20260825134320.1039012-13-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
References: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:806:21::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 61592a60-cd3a-43d1-1067-08df02aeeaf2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|22082099003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info: j4Nx15aXfXi9Lr1EmV2yUhGlrNdavyjpRKILKD31QrnyabFt+p6aTOq0/lRIwJO7ROp/MlKbvg9kdIU8GnKrlfkVoZX8HOGlCa01wCG3cdPZj0N7UqKnK4jg9k4i2uWpxAaaP0wiHTZy++sUEIbg2LHJHY+9HzLHMKKM6HNFOm4yQ6aNZgmOAANqATQzlxAOQJoqTgUAR1zwWLFhZAkmHe+hyVxoVXFYYkwHAC5fxPu2trjivJ+YguGoSMxxXQe+HwaKQHe3IazseQkWpROX26xKO1Aqcl3barqCYJaXqNhy9OwK/moXIJNs1Y19nsNdzv1fTb4ux/wEpvnxqfqVEPA6ePAvm6M69zr1TQQXcdCDKn274nYT/MuIWYrOIS8Vfy19YauVtQ7S7k6aWvHjGa14OQu3ffBNw5lUEhpeFJ5PXzccxGxAN9VVmu6OXB4QtiFj4TuYmK3n8hE9Uw+lhJSuRx3nRUuYcyQe8QAAm8D+HIkVwXsx4aaAAsdU+zm75NVPoLHMUjADDr/8/kdg7+j7CxN4exikz8bYTJ2MEREgbBpG3IQsaJvG1cR++auTQlxDcxbhyQWVnvGB/uEqP4kaawyBEwXFuym4+F1fByWJGo0zY46U9k4sS3NcY2oKMWcMX3VUqNjSQAf9CTCUOND7DutvcqT2lNktdVp+rHMX4dQomLQGKFG3Rpx3vvzMAK+vbimIbHRDDn7/hLS+dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTRNQkJLMlEzLytMcVVqTXRLNVVhbk9BazZTK3RUcVVBa2FWT0lzSmZxb0FF?=
 =?utf-8?B?S1kzQjg1dEtETCsvU1labVBYUDNmem9PRjFXamdraDE0WlhYNVU5ZDRoUFFq?=
 =?utf-8?B?Z1BLSmZockdOKzZzS3hYektIM3JodzdSS1FWaXhuNUtFb0hvOW9LOENwNVEr?=
 =?utf-8?B?dmFXYlJERkt2b0d1SHBVVFBZSjlLbUZiUEpKWGNHY092dkNYWEJ1Ti9PamFk?=
 =?utf-8?B?d0wwbGZaaXNPb0NZRU5FVlZVWGMxdHFYTTVEMjRHM290UFpwT3FjOXVtR2Fx?=
 =?utf-8?B?eHMxWjZMWWxabG9xZkN4TC9xaEVvNDdEclpKRGROeFh4aElub2puK3NkeVVX?=
 =?utf-8?B?RTNSWnVRTzQ3ckVObms0Q1lGR2tvbDdEdVBXUUtTc0Npa2xEbE5yQzNLSVRH?=
 =?utf-8?B?dU1kQ0NCTTU5SGpiVUZNd3Bsei9EczBtMG1QWmRna1A3TWs2RjgyNzZ6cDFQ?=
 =?utf-8?B?SGtsUm1vcjdkRWppK3pIQnRqTmovNVJRYTlZZit5bytEVk5wWW1RREo1NUt3?=
 =?utf-8?B?YXQxbW9Ud1RxUCtWdk5QekM1SGgxZEpFZEVMRS9rTkVOT1JIUHFId003MjB3?=
 =?utf-8?B?V2JSU25sVytHN1MxZUVnMWJYSVRHSngxMURFODl6bGVoNExEcDdwcUFIUmx3?=
 =?utf-8?B?WDJnUWQvaHAxZGZVR0EwVXVqTXJQa1hGZHNqNmNlUFRSU05TWXhSaS83L0xy?=
 =?utf-8?B?bU9RVjB5Tm5ucTQ5d1UzM1pPY0tSemFCbDRLYnhCSHQ5NlRYc1BoVFhkRVhz?=
 =?utf-8?B?eE5qVUduZkRJdzhXcGI2V01pQlJhSFZaNnZQK204dmxEV1JiZ2xtb243Rm0w?=
 =?utf-8?B?S2lTRnVWQ2dYQWI4UHdtNUcrVE1zd29nK05pWmpISnlUQmtXT0hORG1STmRo?=
 =?utf-8?B?SzgxV1ovWnVEZTdJa2NhWTB5cEo1S0hXVEZzUURpaE55anBLOHcxU3lZaXpj?=
 =?utf-8?B?ZEZuZkV2SkJnNCsvejcrR0Vid1FlaXplcGVSM1JaMXppUkUrdmVXbVQrNzBT?=
 =?utf-8?B?ZXlNK21mcVI3VVNxWVRDaWd1R3FoTERMaW5MaklDeU1TM28vU3N3VjZPUTZN?=
 =?utf-8?B?bFlQTVA0dmZhTjhVSVp1WmZxaXlseUMvSGJrZ3FkdEZabmR1UXNiYnFOeDJJ?=
 =?utf-8?B?V0VneG9tTUxDQkxUenlCemZNZytEcXNHeFB6SWxBWFlCSlRrRE5EWlRkejJR?=
 =?utf-8?B?bTJEQ1M4VjJvNFRSd1A5cVR4blRIektUaFZrMWljTWhGaVRGMEVSN3hFTHQ3?=
 =?utf-8?B?eDlQa2djaE9vblhBMUpsblVVcUl6dmwzcU1zNmdFMkpjMGdPeDE1TytyUGpl?=
 =?utf-8?B?ekFqUW1uOVZSSzBJVGJTNjQxRkZOaWhMR29JUm9XTS94L1FpQlIwTW4xdVpw?=
 =?utf-8?B?TGxpaUVFMzFOalR5TXMxZGtXL3QzVVVCVFV0QWluanBqbzF4L0JySHluYkNL?=
 =?utf-8?B?eGFod2VJWHgxUkl4WUUwMmtmQ3pZMDRtcnpKM1lIRDNYK1oyNTl3VGlKdEg5?=
 =?utf-8?B?NDBuSVd2UnpJaXh1Tk51Z2p3dndPQ0lZZ2hydmw0Q1VjaE9Pek9mWnNUTjVo?=
 =?utf-8?B?UEJVdWRGenJLbmxSb09IOHZuLzJONGtGQ3RRWWgwWmNJQkVCcGppQXhTRXVV?=
 =?utf-8?B?R2diTWtBOG16N09DZHk5VTE4ZkJPVzgyTnB5SXFHa3I0MENnMVNxbncxc2Mr?=
 =?utf-8?B?L1dUWEYrYTQ0MjBDc2dhZWc2U2sxK05CUUlmVHl4dFd1YUJ3S0cza3NJa3V0?=
 =?utf-8?B?U0J2N2FVQkJGM3pYRk14RXAyUlA4ZUJ4UkZhUElBcGd6cnFicmtoZUV0S2FX?=
 =?utf-8?B?WC9VT1ZuYy9nS1BoeGVKQ3Vhb0dPcXBoYys3ZWlPTkRnYjhxNU5mb2xNd0VY?=
 =?utf-8?B?ckhGeGcwc214STZ2ZkVKWlliV0dzVkZlcENZM1h0MUdzQUxDVld5bzNpSDRq?=
 =?utf-8?B?RlhqMW1qQWY0dnZZMVplMGQ4YkFRMnFMRlhZSGFQUjdiRGZKM0xoT3d2cU9h?=
 =?utf-8?B?ejlDKzQ1WjZEWUpLSVI3T0l2Y1o3eFVnWm5Ca2FSbFVWbFhKb3FGTjZjdXVB?=
 =?utf-8?B?cUJGQWhXSGpYRmN2MHc5US9qUnYxWnJXckdQaFBvcytrencwTW9sUHMwZ1NK?=
 =?utf-8?B?MTlBQU9EdW82d0lLMVkrVVRCbWVCRk5HWGJlOUdnSmUxNUdaT3R3WitnVGls?=
 =?utf-8?B?R2lEM2NRSmt6dndqT1BIbUIyd3ltMGExZWxuZ0Z5MmxKMjlqOGp0dGJFMXEx?=
 =?utf-8?B?YnlKTkhoMEdWT2NwWGNOVXo2UytydG9qYWdFdHBkK2ljaFdpSUNLbnpzWk1w?=
 =?utf-8?B?TjlTRkM5YkF1T2x6WGFqSE0ySk9LaG9HSXZMSHgrVlRjLzZWankyajFPazNi?=
 =?utf-8?Q?DdPX1s7Hp/cj2jSE=3D?=
X-Exchange-RoutingPolicyChecked: 0XixBiucCuCjuMKh51qgZ8geEYeOKbQ5/RPpJbouGZci094+KddEiDDOHB4MxXp5mwDLj8u99wFCXMN+AiTvrGgHAPpYQN4MEm4tnkOzclqHFyvs4NCrYAwS1g8YYUfD5ZWunF33yvO8L5BMb40W4luXff4zPK43lroatXjpAI28fSQKwh8xbNdVep4yOUQiX2YOx1GDGtwI/SFCNgCERwE3qFZ6SkGqTbVuibJDhvt1TRQbkALrii68yQA2k2H0uLAUCbv37Wq/XFnBwt8kawqe7RqZnoQEYU5ngDp3pd5z0S/h6WUeAjKIkPkJlzfkjrJ5e/X2SeBs8B1Uw8W5Yg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61592a60-cd3a-43d1-1067-08df02aeeaf2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 13:44:00.1213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S21hTIyMaWSy9suW2jJKi/vYxgTrp9qLe8UCMJ+p0ZEYwzoCCkRPUh3uAyl/ngnrq7AI0v/t4ED4znoqt2btXTp7viDSHlQdvb2sgPfLjQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7557
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfX+2xfXLvs/1N7
 RvvBQzNdZTISow6TgD0vfbcNIA5wC3Gt2Uk8KHaiLTecFlyddY273G8iZgmQ/3iv2o+0Iy1iT3X
 V/aFglBCnb1eDf6OLg5WjIIjDTfmoJ0=
X-Authority-Analysis: v=2.4 cv=aJvAb79m c=1 sm=1 tr=0 ts=6a8d9c21 cx=c_pps
 a=rUfGOIOvJ/MBLZtbMVSs1A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=4QfE8SPBBHYfMhEiUa4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 3jgi-Y1fpWcXu6gAmgTa3jJfkq2Goe6z
X-Proofpoint-ORIG-GUID: 3jgi-Y1fpWcXu6gAmgTa3jJfkq2Goe6z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfXznCX5pP88sE7
 rFgxZXy1g9crHEVX3emkeJ3wOBCu/Vr1IEtf0qsqqdnFT73VmB98cQxadmL3/1mnCPpFURw3G1t
 ClxreiYtkzuFs4pwMrt08aoPJcXpyJP/+cUKzGTpM8CwWB1N6lC7rTvxcKDV2wr9Ij2J2hF8DWq
 tZX0AmsVgPEi/GRIqoq3gfoFg/f9qeFrPi2eeyaNKRu5Xn49z3BShzsSpSTpOtnlhK6Fs1qsHTD
 vnH/XPLNqwU0e4oeV+U+QTUURF4sxh4M4II03R7Nxfv5cVAy4GIkAFQh/LZbmI+zPfnK1/5A81a
 1HIXpmL27eBHPvwfuT1vcLF8WHb2AOuAn8rkzsOX3PpnSVjq7VY38c1e7JGk8EkE3S/XQXLCP3J
 DyzmVzTQCdYztv62OmRZcukRycIA1wWCioZygnsc0aJQ1W026pGHr7gR4sRy4jO127dmB9mIY5j
 JgC9HSAJYN0Et0VFxrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
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


