Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF488C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyqfW-0000pi-Qp; Tue, 25 Aug 2026 08:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyqfS-0000p1-Cl; Tue, 25 Aug 2026 08:54:18 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyqfP-0002cr-2i; Tue, 25 Aug 2026 08:54:17 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PAwHjh1711925; Tue, 25 Aug 2026 05:53:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Zt/pD2tyF0YM5VLXYFwm9lYEpCPF3Zbeno7zZnGug
 /I=; b=lwmBuErE8N3xX3jbtKJqmNrECBwlN7/sOQlT5sgV7QIM899MGwNcFZqkO
 Eri0g+Z9GpmhfzIXj32WCAoPxPgziLErknxGSLIz2sRJb5I8lb1nQwHDZO2rWlsF
 +WOxgpfDK04+Nn3XKJoNWa1aeFWPa3egSFOjreM5Usw4wMccQoTaA+Nyv9v16nZU
 dyMxi4VkBfhVEhH/xsk1fuN4caPbcqHF2hk+aJHMaCKNkPaekzYQr2UY6IYvX3P3
 OMnbL6XlunhtXmLqSgsGpXVuAUjo7BCLZJfc8rmf/5zPvqJ4YNpuq7fUT/6tv3ag
 TKo8dZaka3roNUUJySyt/a7I7WKFQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020094.outbound.protection.outlook.com [52.101.61.94])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g7b9y6815-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 05:53:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wi+by3pQMMxGKl4BTbz3ytlU4uMt0yffo3lOS/NnKdNF+LWjMtMzeGXCDTDVFgUlC2onpm8BoGL1yxUdb/kIyXHcH1GLYlPCGmjbE7ACIuYgH6sT4oaRLdeQF4/tnwK0fTTujg3mryuxUDFq1QkUhhiDSeKEKgsLw4SbLpF7oXTqaxarNVa7akneG4LXVR7fVLSeYhRElHlIihiSTcrZBuiS5hwOPFC9gGprtpc6fJOFgc/pUBKhljyAmQZ01cPiVUe9iaWFmszzryCP0iMs5qrKhRMRzQvRnwSxHrudpcrAzFNEylRR5cedbt5T7DO85H8HKbTQrhHXJl47oXdUhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zt/pD2tyF0YM5VLXYFwm9lYEpCPF3Zbeno7zZnGug/I=;
 b=C9J1V7X9YYipBDBjvwHtE4trLpk150xLbs6JEWMvQsW5EqTS14OLp6h3FcT+ct+afttsL1E3h5hImzT97uFXqZ+Fy5ijvgE+hA19jVMj8RUGObNwH1imntLYKqIl9INcTzytRPFx+93/Gn1KhGf2sj6S4siSo738jq0njAd3Jvtoxr/9v+UXLK9T4EXX6VlYBPIJfqgKuGPzrarPcrWEz9H0t8U+PiR70pZQXHjkny82MQ2agJ9LavZiAKGcKoHQiN81Zy1aAith7RVVBcqiVdatnhbXnP/mFdcOUShT2sRLbmtK2XrMpXgI7z7tnkbv5a9kT1fkJZyTBsf8EYQG5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zt/pD2tyF0YM5VLXYFwm9lYEpCPF3Zbeno7zZnGug/I=;
 b=GaaDkjxUsh3v9DWrI2oX25bznZArFuWdL+ODN7EwLpY9ZX6Wa4i7Lt+X5hO6ABVV5jRDBtX4/3m0njPXrmlvUqRiVXE71uXwXwMXydYHi9b3ex93ZOm9BvJc/qGDTOT1hZDf/slwxHV0z1RN6GXHvmI1GM/fX4PvGiRvAPEjmW5A4wq36ue5VZeyAe2uLtr9btH4igMBaDzgq7BgvPEowDXgiQNrmYnvhDsUBqU2d4qrRp07RQP4s2sluBdXvPeiuElCfr33GhGIBhwp3h/Ek4mzdgmitrCbu7LR7krfNwxl7M/4Cnquk8xFWbkwKuismIodWcnX0yzUMU85kEyMWg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB12066.namprd02.prod.outlook.com (2603:10b6:510:43a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 12:53:39 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 12:53:39 +0000
Message-ID: <277163fc-e50b-4b56-b3a9-79db32313c33@nutanix.com>
Date: Tue, 25 Aug 2026 13:53:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/16] hw/acpi/pcihp.c: convert ACPI_PCIHP_PROP_BSEL
 from object prop to class prop
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 philmd@mailo.com, aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260821111550.276011-1-mark.caveayland@nutanix.com>
 <20260821111550.276011-15-mark.caveayland@nutanix.com>
 <aoxBd0tGArc8rwdf@redhat.com>
 <1fd9946e-1d2a-462a-93e3-238f2c67a1b6@nutanix.com>
 <87fr02pt27.fsf@pond.sub.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <87fr02pt27.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0140.namprd13.prod.outlook.com
 (2603:10b6:806:27::25) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB12066:EE_
X-MS-Office365-Filtering-Correlation-Id: db966f91-175a-4357-140a-08df02a7e2b9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|23010399003|4143699003|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: eiE5KlMYqVsE/6XcloOql6kIcumTR2bu2ogZjxOT6pnvnWU/vxVXBqnteyuqNT0bh/IEi4RFiS5aozqeoHKBcOhNFU/hBjhzZlSlLIuhlcK76Uaa8Bt7NlXi5P6HvCxPzot8lWjDk2QXt9GBdLc0gc5GOuskys/GcD1Owor02JvzJ39/AP0/KVT864zcJ2u8iUJk8t8I/HSC26DH4v/8ogwha6GZsmHlntu1Nv0epkkcgJ2ORf3DQSTGLxgWyGBzoVVDPXI70f6z8vrS6l8zaUm/+UKS6IR0TICqb9FAhekmXUo5Xoex1PC9QTMDp88AJ6YRmbO2wfZJB/r9kuQr7hQKji2Z9WQLzfhQrlDamvxvuABHoDmTuQU3p+ekaUNwGFcoNkKZfhyyZVNjTwCPvcS5UjT97xlejWMBeupJ4FtBDNb66NDrJFavdja/BU6wHpaPYB+O6FkwpnKrTMDl6U5CFEHfRfgmXlIn3mzEd+m2wfI2weXyQZxf00NlevDdqi6uwfCQD2LDN5lHWuQIcFWO2iR8UUFY0woMYXqW6Ohs1JN1NjZEESCapk1ql8nf4dcNC5HpIPn4GzKnUzkV5mSoXRuT5WJewPQfc1eVlfv3ooSoGSS2HG8QhK1keRoBDt9ArnHzMD1Vq1+4pzg86jzvZ5CwsperSjh0jIeCT8Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(4143699003)(22082099003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHdYZVBBQWxLYXVIYm9KQ2YyUkV5enA4eXJiMnIzRDRsYk9zL1lPK2hjMW50?=
 =?utf-8?B?UVpocHM3SHZQK3V5Y0lBdndtcm8rRkhoM3FRTXZnUEZLNkRJL2NQRC92Tith?=
 =?utf-8?B?eUNqM3J6Z0pPc1VuQXN0NzNPZDRBZUhKVTJJK2xxM1hIQyt2R0lGMjRVS0xh?=
 =?utf-8?B?Z3Q4SGJ6b01uTFFRQVVLSnNvdnRMaGhiQVlKSkZjWUtNZFp5OFR1RU5JNk9z?=
 =?utf-8?B?K2Z6VEFLc0UrMm9lUDFVY05sQ1Y5bCtkTnNQajhJN2EwN05WME1hOGJSeWNi?=
 =?utf-8?B?bEV1KzNwWEY1WnFyMXJHNmZRUkRuLzJ6NGlLWVhoMUpXazlmOGNOc3haNFRq?=
 =?utf-8?B?RzZHdFdlVUxobWNZVVFGRzVjWjlqQlhReGI5OGI0UG1MKy9Pa0lPQkdQSXJS?=
 =?utf-8?B?aE1aZFFnMGI4dEEvaHJacEFhY1puMWp5WUIxT0hRa3FkWDdkbnZUdFNCaHRy?=
 =?utf-8?B?QWlSeVdyR2thcDIzUUdUVW4xQ3FrK3ZvMlg0Wmk4OWJsQk00NTRCcVJXellF?=
 =?utf-8?B?OXpPUjdDYU5vQVBQaXJTZlJ2ZHU0cFJOTG5uMm41WlFtakwyZ29Yc3dnc1N3?=
 =?utf-8?B?NVVYWitiRWVjTHoyYWZ4OFJXaXVEUGdpODFYNnVBN2YxaU15VmsvcnIrWGtS?=
 =?utf-8?B?NE9lVDNVcm56SVVmeG1GODQrSE8xVlVibFlTc0tWWkp3QVE5TG9pQnR3QjR5?=
 =?utf-8?B?TzVWbG1MV3R3WnRCUStIcEVUeUZTbUN5TkdqbWtXVlp5VS9vNHBSeWZ1TEJs?=
 =?utf-8?B?OE9oTlZTaHRFY3dhbVhlRmtuWWhBNnM4TVRVRjlIU3JDdEx1WEg3cFpKQ0NE?=
 =?utf-8?B?NmFBWFRSeTI1eThjbUNaWVEwMkRFRVg2bVB0ZzVEd1crcmlScWRzTUU4S2Yr?=
 =?utf-8?B?WGRzNGtyZ1RFZ0RHdGhrYVFjVU1vSkthVkUwRUdDSkQ3MjBBbEpnTDdhOVhn?=
 =?utf-8?B?TnF1Z2dxQ3FMUXBUV0VMY2RNWmVBMkd2Z3Jkako2alU3MnpiS2hnZGZackoy?=
 =?utf-8?B?ZlF5Nzg1c1hlQS9xTDhIanN3NjBuQXB5bUUxbFlFaTFUU2dhKzIybXhYd2d2?=
 =?utf-8?B?ajdteU1GS2VHM0h0QmFtL1BLb1JOL2lpNllabGs4Rk42Q2o4cWFlTmNPekdz?=
 =?utf-8?B?YTlabGtSZ1NnT0lLOGlWYnVQZEdha3EzZGpXSU0yMHk1TWhtTUlJcjRRMW5w?=
 =?utf-8?B?dlNoWGF5RFd4cUZEZ1k5R2Q2WVE4Nml3ODdQVTRmNVFSb05iUkRHeVBCcE9I?=
 =?utf-8?B?Q3ZFbTZid0ZjQVN3ZElpUjJnL0IrWUsvSlRKek1uSTdyNyt0eDkzSFVNV2tz?=
 =?utf-8?B?TUkvMmZHeVdEZk1yUm5tdWJZWWNZQkRPZ3BIbTl5a05BWmFFUlRzZ0lVVDRo?=
 =?utf-8?B?SmltdUxqV3dEcksvY0ZMbGd3QkM3eWZnWk53alo1TEN3SlVvLy8rTFM0SXhU?=
 =?utf-8?B?N3JnUENsRmFYYUM5ZlZKRzRPM2ZiQXlwamZJWCtZZHdQSWsrWThYR29XVGhH?=
 =?utf-8?B?SWFyYXlza2drZ1doZFd6UndMUDRmSkVKZDhMbWIvcVNodHZLbGdQaEQwYUdq?=
 =?utf-8?B?RVArUDhuTS9FaFpEUEZOQ3VidHMvdWRBcXM1MmdGbUtBTG0yZUVqOHAwNnA1?=
 =?utf-8?B?THJ3dUR0eVRocmY4UFcxS2tna3Y3MndBTS9NcEh6VUFFeUViTGFkZm5HOUFu?=
 =?utf-8?B?ZGF1MGJTSytycjBseTkyYU5HOWhlZ0doQm9tSFhNbHVPTzVLQ3pXaHNqaTFt?=
 =?utf-8?B?WmlZSjNIakdDOGdDV2hnRGxvYkpUTEZ4T2tkck55L0hzYVBzakNhdFYxYTJY?=
 =?utf-8?B?VFE0VmQ5SVlLdnh6SnZENU4zRW5iV1gxckh3V1FSU1JEa05nTGNncHBjM2Rq?=
 =?utf-8?B?SnN2MkpBYjZYMXNvL0xLUlFjU3BaZjh5QWpuaHJiSnZpZ3YvN1lIQWc1eWVN?=
 =?utf-8?B?VmV6bTE5KzdrUjRKM1p0Z0VZcDRoQ0RINUFQY3BEUDVib3d5RkkrakxPTW9K?=
 =?utf-8?B?MjJmRW9Rd1pOMWhzZnE0RXV1TThtMlNrZXZkTWh0ZlkwS0ptZHFZSXMxa2RO?=
 =?utf-8?B?QUU5d2lxMlVZU0dmdG9IWmhISE9INHA4TWJHdUhWTHovZUJZcExRUjZUNXJB?=
 =?utf-8?B?clJNY0VyZjNJSE1HMGlHeHQxMmNMTEp0Y3NNMEFNaVBnekYrMjFwT2FXZ21B?=
 =?utf-8?B?UjBiRmREVUlwb0xSKzQxVHMrS3JZSXk1aUxxUk1vWndlWFJoQkpSbW1pS2tj?=
 =?utf-8?B?YVhyc3RxcXpITUFEbVdlOFhPMkRwTjF0S3BjYjdBNEc1djZpTHBYRnFDdnJO?=
 =?utf-8?B?eVZmY2kvOXdwUlVjSDgxMldERGdaczhNcm02Z0VmNmVnS2g4ZmlGV0E5bUpW?=
 =?utf-8?Q?m0L3jylvYMjwRAOI=3D?=
X-Exchange-RoutingPolicyChecked: bmOXI/zC6z/aWi6Ru7G8fqI2TdzMH4f/97eqHGGztWFmJLq5f9zM4DTVpw4pG82OQ+ztwXwwvuGJYlH93G9dQ6Wkcvb7FDGbLFlubzThUgra4rPkuQti8qmJWZ0cOMnvCHs47kAwkfiiQ1O5EaCjAjury7M1eSMGIwifjY3Z85lDK4ge/oqcLIWKMLp3cDO/ped7WT6HEphoMMzYMrKHxNhAGgyjdzVhUOr1gN1nMW4WDOSqMq/GXMUcubRPNG2XLJb/1j15Er9/aiDBtVKU78Hb3dnE111uZIbWhGH2VmG93OM3QKQTFiWHz/QHUFyg3bHxkJYRweAT+G/eNRvVQQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db966f91-175a-4357-140a-08df02a7e2b9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 12:53:39.8009 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/dLEsoZPFsVQI0GBsriprE4c+XtGML+SzU88XkPiTVjz7QnBKXNl8uKpqtbR5TQ9jcoFL5H4nee0Ks6F/aTOb4PrEjorDkQjheTQQMmjgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB12066
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEwOSBTYWx0ZWRfX6DXAStJKJtg2
 RrEAaYueu9KQE3y6eyTcvmn35FZMgDgXINPsOveVB2wXmTkcu5/xKnFUduotBHgJmcHewum+O0Z
 H79QW4qO+FLtZCdcDzn78nVD0gbXFOl7alarRBpZSuTXbKM3mT2FXnD3OftoXUYo2j1IHgBqL/X
 DAZh8O8gs5XvNsOLHMcw2IJG5x/tiDXaaX/8ZyUfNRgXHyd8gLhmFJzLrO5SHivNXiZg9BSWphQ
 DpzejBo9TzkWHojzGZqH/cZdjnqaNgaPzL+tCGJa5wnhARfT9uoaZm+NQj72ia2crGPRXDrSmzI
 IOjVGwi3hHzQmcmGFPXpy+6WhktyyCyJ1o3TWi7nrvfrEXmIqTHZK8dpwFkcWQurYGzzWNvJkqj
 E+JKXwTLUEvF5gNCbA5FAy1jKSsEr4u1RqsGQ8ze/V5cN35RYDjZQ2o7KcJJBaNNekPxdJjoyz4
 2TplG3zMUgQI5Mwu50w==
X-Proofpoint-ORIG-GUID: aJuLBmO9yuash207us9zVIUDMFAKYt4z
X-Authority-Analysis: v=2.4 cv=YrI/gYYX c=1 sm=1 tr=0 ts=6a8d9055 cx=c_pps
 a=gT821fuiKW6V8kp6mfQTHg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=EZWLq1VV_q5wdR_XaywA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: aJuLBmO9yuash207us9zVIUDMFAKYt4z
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEwOSBTYWx0ZWRfXy4FSpP9EGikq
 mRSCIEuun2EWjImoKy9cH9iUubXnM5oifrErsWz7wOZOXd04US2M9BgqpuU2ZC28uaZRYLNtS89
 Jl5sjba2NxEClRIL3Bv7SR/ygY52Qk0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
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

On 25/08/2026 08:17, Markus Armbruster wrote:

> Mark Cave-Ayland <mark.caveayland@nutanix.com> writes:
> 
>> On 24/08/2026 14:04, Daniel P. Berrangé wrote:
>>
>>> On Fri, Aug 21, 2026 at 12:14:26PM +0100, Mark Cave-Ayland wrote:
>>>> Move the ACPI_PCIHP_PROP_BSEL property to the PCIBus object and update all
>>>> callers accordingly.
>>>>
>>>> Since the existing logic checks for the existence of the ACPI_PCIHP_PROP_BSEL
>>>> property to enable the relevant ACPI changes, set the type of the underlying
>>>> variable to uint32_t with a default value of UINT32_MAX indicating that the
>>>> property has not been set.
>>>>
>>>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>> ---
>>>>    include/hw/pci/pci_bus.h |  2 ++
>>>>    hw/acpi/pci-bridge.c     |  9 ++++++++-
>>>>    hw/acpi/pcihp.c          | 30 ++++++++++++++----------------
>>>>    hw/arm/virt-acpi-build.c |  7 ++++++-
>>>>    hw/i386/acpi-build.c     |  7 ++++++-
>>>>    hw/pci/pci.c             |  7 +++++++
>>>>    6 files changed, 43 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
>>>> index c738446788..7ecb23d13c 100644
>>>> --- a/include/hw/pci/pci_bus.h
>>>> +++ b/include/hw/pci/pci_bus.h
>>>> @@ -56,6 +56,8 @@ struct PCIBus {
>>>>        int *irq_count;
>>>>          Notifier machine_done;
>>>> +
>>>> +    uint32_t acpi_pcihp_bsel_val;
>>>>    };
>>>>      static inline bool pci_bus_is_cxl(PCIBus *bus)
>>>> diff --git a/hw/acpi/pci-bridge.c b/hw/acpi/pci-bridge.c
>>>> index 394a919479..1bfc5431f2 100644
>>>> --- a/hw/acpi/pci-bridge.c
>>>> +++ b/hw/acpi/pci-bridge.c
>>>> @@ -23,6 +23,8 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope)
>>>> @@ -23,6 +23,8 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope)
>>>>   
>>>>       if (!DEVICE(br)->hotplugged) {
>>>>           PCIBus *sec_bus = pci_bridge_get_sec_bus(br);
>>>> +        Error *local_err = NULL;
>>>> +        uint32_t bsel;
>>>>   
>>>>           build_append_pci_bus_devices(scope, sec_bus);
>>>>   
>>>> @@ -30,9 +32,14 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope)
>>>>            * generate hotplug slots descriptors if
>>>>            * bridge has ACPI PCI hotplug attached,
>>>>            */
>>>> -        if (object_property_find(OBJECT(sec_bus), ACPI_PCIHP_PROP_BSEL)) {
>>>> +        bsel = object_property_get_uint(OBJECT(sec_bus), ACPI_PCIHP_PROP_BSEL,
>>>> +                                        &local_err);
>>>> +
>>>> +        if (local_err == NULL && bsel != UINT32_MAX) {
>>>>               build_append_pcihp_slots(scope, sec_bus);
>>>>           }
>>>> +
>>>> +        error_free(local_err);
>>> IIUC, in this new approach the property should always exist and so I'd
>>> expect object_property_get_uint to always succeed.
>>> IOW, is something stopping us using &error_abort and merely checking
>>>     if (bsel != UINT32_MAX)
>>> ?
>>
>> I think that would work, although in the back of my mind I have a memory that we should try avoiding error_abort where at all possible.
>>
>> Markus, any thoughts/comments on error_abort usage?
> 
> &error_abort is an assertion, just like assert().
> 
> Assertions are strictly for programming errors.  When the program
> detects such an error, it is defective and needs fixing.
> 
> Commonly, the program is in an invalid state then, and continuing
> execution is unsafe.  Aborting it is the only sane option.
> 
> Assertions conveniently combine the error check and the abort, and also
> scream "this is a a programming error" both to readers of the code and
> unfortunate users tripping them.  Good!
> 
> I particularly dislike the pattern
> 
>      if (programming error detected) {
>          error recovery that should never be reached
>      }
> 
> where the code doesn't actually *tell* me it's a programming error.
> This matters!  The error recovery needs to be treated with extreme
> suspicion then, because it's not testable and almost certainly unsafe.
> 
> The pattern can also make me go "huh, I wonder how this error can
> happen, let me figure that out", wasting my time.
> 
> Another gripe of mine: we often pass NULL where we should pass
> &error_abort.
> 
> Questions?
Always :)  Seriously though, for this particular case I think 
error_abort is reasonable since if you've managed to get a non-PCIBus 
from pci_bridge_get_sec_bus() then things are generally looking pretty bad.

Thanks for the pointers as it's something else to add to my set of notes 
as to how we should best model these things in QEMU. I wonder if there 
is a suitable place in the documentation we could add this?


ATB,

Mark.


