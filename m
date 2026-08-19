Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE71BC5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwgVf-0000zh-Cn; Wed, 19 Aug 2026 09:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgVU-0000rY-1R; Wed, 19 Aug 2026 09:39:08 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgVR-0000kH-5e; Wed, 19 Aug 2026 09:39:03 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JCmMSB394589; Wed, 19 Aug 2026 06:38:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=PJv2huWn2zHlH0Oz/DzRhy5vzAjgbLQetnhcxkmxs
 HU=; b=Vuaav9EarykgxhYXVDJIJrrVTJRa0L2dxaWrnPRegQr+aGsIfNjMRNW7l
 TY8q5OCcuPMNlZ3vB1B49NOAV/LmQjb8dH7UL+usO1pkZMcXvXqjLjfOdk7pBXua
 qrvG3d4gAtQZAWT8HAfp4TJTH2o2RdoAtZ9GTZUqe9Uuh1B/S9ThQFz+crP9o84G
 /Q5Tg3X2ly5PC+gSm7THCgwdbZ7JBeNOD0+H/2il1VsAu4ehNOg5YvDHivOjoBk3
 TrkgzK8rNK7mCJOPwI30k6TOFBXXnqwyGJwzVHiGWDRxEnrJ2bfNjNThka7HWRGn
 ztk5Qes3R36GL9qwxjAWF2wNRSGjw==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021110.outbound.protection.outlook.com
 [40.93.194.110])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g4xnxa6jc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 06:38:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4yfMwHRdxyASUSleq9CEJiIvcFHVIJOL3BwjrrieVse72ziy0s9X1LYVQYPIYZZrCTKsVj3jpJsgHqWvhThZOgORwVx4QDIubFjGKS+SpWL/BWWI69s6HDn94WC/tmjfX6xQr4qIp3xc72mR+itDSCYENvc/L6DH7Pa075CDjO1iim/Y1JwpgbkOqtf3f0B0D0MW99YTn/7NrOFFfY7HPgMH8ARTzgg5dpzoxiO6nh3a0+o7yHm5WA+LNhp2zkvJrcXa2TQ2VlGAd4UzUfmuJV1gVtMd64nycRZejwoo1RNxot1NDH28xu+4RfoG/+aBzu+p0WvWQtcO6bCVqz+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJv2huWn2zHlH0Oz/DzRhy5vzAjgbLQetnhcxkmxsHU=;
 b=DHlqGfCSq1JadSertuCRFN11lnkVPWInFCOB34IhKHErsEqpiaaUH9pTmToAre4wsV60X7YJxNuEMmF9pHolhC3TdoBFf/eloTiYv+Pqaw0Ap/D852O6+k5gKvVCZcXdB0RthFFxj78kdAitF71mtI5sBGDW91Q2bTvKuJVc/SmEcC2qr8S+uIWNFkl3Iy1mkCOp9tY/Z/JRLxbPMCep1yt3Hqf2Sd47lcYhpTuQOnGyq4u595y0HEkmxKlG1bMCMoz+JZ39Oj6lExi0BF4EjdWPRI4r3lFsfcUZq8hPGoZVUM+1389Y9KBB1eK+33R38WSjFTCOcoi58WJwnz49sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJv2huWn2zHlH0Oz/DzRhy5vzAjgbLQetnhcxkmxsHU=;
 b=h/OerCBbmTurgaO3tqniDvWuiY+VeEjBx+pONzWHvd/+aJrn51IWinYtGkYtU83YKKjZMCYrMpVn0BdhKmWvSU5oLZlXZBGvP299MYZtO1grh8RHrNZbKwmvELOej6kTrs+i2y3VrjVH6x3mqydOkUISnexIdMiMcp4Ts+QhWtsd9e2TTSEamYFTWA7bfMiolYUvNRMfgrCBW7u7mK+id+aKJrPHaXhq7RbHTzya8swbmwdj8cT4JgDKmugpzhDLoDJ3FzDeJdiRvcROL4kNH52t/LATqm345fWtesUKDBMTnhouuRmj1EF0jS7MUb+aaks5y2vVBiDBKC/49uzmzw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB7336.namprd02.prod.outlook.com (2603:10b6:510:d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 13:38:49 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 13:38:49 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v3 08/15] hw/acpi/ich9.c: convert ACPI_PM_PROP_GPE0_BLK_LEN to
 a static class property
Date: Wed, 19 Aug 2026 14:35:47 +0100
Message-ID: <20260819133816.3497033-9-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
References: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::28) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: ee7b0796-0126-436a-0e34-08defdf7332c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|23010399003|921020|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5eMrHXyIw0HlXKtrWcCUfQSqgYG78bvOSseMJY9o06BUJCjyxMleRJAClCkCTdpY00VW7P1ruYeyqIxHkl1OPZBR4vf7zp7WkngzXwU+Xw+LzYr0zMlzD2p6u7PUnwXDr7ryKAEE7Fb9vmCVFmBqyr4Rspxl3nEUqHcoknf/N29lbLKFFjD+8NWgdgEL5BuNUU+y+OHlmsTZVkRg+O/1Q5PgCnz0JDufmF5dRarukk7xVDC8CGdajuYuXlLSnikmk3ZZfl5D88dh/jl8J/bZC9BitGAfh2R6B0Y5ewyBgT8K4OH/hHO17MYnSSPbDEKI+JwLSKFYgsPrfjXntK8PnbzeXjYjZtc8EDbK8l9FgYDi7F+7bAbV/P1nnX9Ks234fKZeRvdcPTu2gpqxXzejBOuNVzHx7Objal9fK8YFSKLU4jxJMCrd7mHyNXcv9v5Qbh/0/LvhJ+WVjTVm9dzNm+jtAeqT+zzIQ3BXlZM2mU5FlEpUlyP/5Il1pyP0xjcV5OvH6kRT2TnC41XYdLw3nDAPkBYBy3SyUQjcBPq6GfPLF/I2uWbagGbyHWjM5mxGJV5rTCF/RCRRJw3lrJVjdeie9h3JBVvzzoHys+wYMjQeLlPqvqFWf5cgOE5aCbqO0ILMEFAAXqh4CqSXVQI55xGVvwQsJ0Tz2LivXX5SWwgY6T/Pt2J2I9FpRnZ4G4efRhrq5vQ5F4zHXSkIyCLkEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(921020)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wlc3Wk9tMjg1WEFWQ1d6MlFBU204c2RCMlhpMGwxOU9xNGZMU3UyMnZQdDlH?=
 =?utf-8?B?T3h2UFpXSHo3ZGpCUUdFWTMyYjFlZkU5djQwMTQvTjc2YVRwYlFMdU1PejZL?=
 =?utf-8?B?WmhwRGUzUXZkd2JGWU5vQk01Vms0bVpZQ2FRVGdmUCs3ZEtqYTVLdXRnTjlY?=
 =?utf-8?B?VlZtN3BrN2tqZjUzRTJtUW1NTCtCZW5lck0zTjBPQ3BXSFp2OVFmZjlVWVFQ?=
 =?utf-8?B?QlNQVC9TNUVHYVh0TkNnZW56WmpXeDBQdnFMZVFPZ3VMY1h4U2xFV25XM0d5?=
 =?utf-8?B?U3Fqektsd1dBOWlOMVFUS3BMR3hUSkVwK3A3bUFadE4zVi8yaEIremJ5MkEx?=
 =?utf-8?B?cFVwZnVLdkxIL0IxNlB1d05qUG1aQXk1MGU3YkMzYU9LRjlMZ2lmcEZ5NHJq?=
 =?utf-8?B?RGg4dlhVT2dBNWZVTkNtUjdwMGlMVUtEaU5BUHhXQ01lNDlKTjU4S200SHo2?=
 =?utf-8?B?RFRkVmMrTmlWUTZhZitKeHY2ZTBRRjFtM0d0aVdHS0NoMzhzWWJCUHJWbzVO?=
 =?utf-8?B?ZU9tV3V2enZxV1lIdGo0RFU5MmxxbFFJd0ZPOTBDcTVqVnhzSHQ3dGNxcVd2?=
 =?utf-8?B?Rjd4OWZMMDRFWmF4NEZZK1FCeGtZdUQ0VTlweHh2Q2dvZzZSbHVnTVErRW1w?=
 =?utf-8?B?d0dwM092YzI0S2xrZHZIbmg2YTNQUDhxb1A5dzRlOHRnOXpobDJabER1L2tX?=
 =?utf-8?B?NEJDSitIMlprZFNTWFlhK2ZYVmJiT3V3dnptcEpFcjluWEsvcDIxMDlKS3pE?=
 =?utf-8?B?MDdIYytIMEszVnFJTkNPczFsRVZ3aURUZ2lpOGpjNmVRMVRIUUlESk1wUHdB?=
 =?utf-8?B?eEQ1Sm1USWEvMTBMNS9wQkdrdmp5NWU5WGEvZTdJM3RHOE1UcGVzc1BNRGVp?=
 =?utf-8?B?ZzdaNWNSTHZNd0ZEUHhkSnNWWGZ6d3FWNWtreVdCSW5ETjBzRGFGemlnNC9k?=
 =?utf-8?B?eStpNmF5Tit5eFZud1ZlZEk4alVBY2crWGhxUnhPWkUvVExjbHVtaTNWank0?=
 =?utf-8?B?eXdKVFgwQlMyaGxxK2o0a2lReVU0RUgvZWFJUFI1bUNwRXZmVUlYTVM1NlhU?=
 =?utf-8?B?VDJucGJVZEJNLzN0ZE5ONll3cjhRRVFmUlp6dzdycnVXcWNQWmdGMDJ2NXU2?=
 =?utf-8?B?czlBSkIrSnMzWnV6c0o4cVpDcGxxUWhDTm9sK1FzSjNDNkkrUE9wYXRYdkY2?=
 =?utf-8?B?aDYvMFVjU2ptZk52U1N6WklHNStadmlCck52ajlqTkw0TWwrd2RTbVlHYWg0?=
 =?utf-8?B?OXljQThEbng2K2ltM3hSVkpnL0VIVFBXR2NyR1o0TzZkMFZwbWR3Wk1NZzAz?=
 =?utf-8?B?QmFoK29hTUVHMnhMUm5pUjNvYXFHbVR3RVhwa2U4dkVXV21LeXBGdFE0QTdF?=
 =?utf-8?B?SEhveW45QjlUbldLc25xM3lEVG5EaW5ha3FVdWgvNm9TZmNvendSYlFlMHJW?=
 =?utf-8?B?aHRRYjhSeHE1RGlKTTgvZ0cxZnNad1lxdWFqN1RiT2xoTXBLUGhYOWhXc1FF?=
 =?utf-8?B?dHBqMnRSTEtYU0VpVFZrRjBhdXpZc20zRDJrWkM1ZmpuYTU0ekNwYjAxYnlP?=
 =?utf-8?B?MDVLOWIrYjQxamhodk1uK21CMzZXMHNqY2hPOEtnRm5UYnh0TGEveVhRZllr?=
 =?utf-8?B?NFlkVDcxM0ROZHBFRFV6aFlBQTRiejFPd2U2MlRyK0ZOYkRzbXhCY2Zhc0xW?=
 =?utf-8?B?R0FGZTl4VGtRYkVUUlRRMWtYRUdvM0VxVFQ0SGlLQzFTV0duUDd5ZU1lUHU5?=
 =?utf-8?B?TEFhL25TSXpVQmdzaWVaQk1GbEI3WnpBZCtQVmJwTXYxTmxqc3ArWVVuY0tp?=
 =?utf-8?B?Y0RhWlplanFPdUcyZnBnY0hhR1dPTUhHRnk0bkpsOFFPOVhqTEtOb2lTeCtl?=
 =?utf-8?B?d00zYVJYL1I3MDRxTWtQZ0toTzB0RU1JZTNKa1VHSUd6d052SUF0bzhYbGli?=
 =?utf-8?B?Y3ZBRDBwZjRWOXB6S0g5Si9TVmFDL1RpRjdCa2FNSUVRSEpINDFhYkM0UC85?=
 =?utf-8?B?aC9IcXc4QWl2Um5UWkNZMW5YMjVhenVLNlhHWm90dlY0L0s1Yk5ENkplUUFF?=
 =?utf-8?B?TWFIY1V6Z0lCVjBKUFphL2RjNDVRVW0zdk1DeXVma0UyVzBsbEhSMGo3c3Jl?=
 =?utf-8?B?VUlqVFYwVWJHM29GamdCSWJacmQxSDRVWDNqTEh1NG14TERQMHA5eXc2RUI4?=
 =?utf-8?B?SHk3MXJ6bGVpR1Q4NTNtM0RSTnd4dDdvSVNBMHdqeU5MRnU5YTNMdU5tbDM5?=
 =?utf-8?B?TkxaU0J1S200TFVRbFp2dkx3Vm5vZmpFNTZ1bVpyMkJEZ2FyZGd6VXBISUpX?=
 =?utf-8?B?ampnUUtvUEE4MTdrOWw0d3gzaU5kbk1IUWVHMnZVL2ZTREJMa0ZFa3pqa0ZY?=
 =?utf-8?Q?jp/dXkaWileRolE0=3D?=
X-Exchange-RoutingPolicyChecked: fUm94ljyUR5Rk8F9jfO3eRe2pWr6K/buGUzXwivJd4P11a3gfhq7sFB+Za7vAY5RgCtkKpR1WKslSxSEftxWNSwILEhif8cAV12fc1V4HEKSXUFbnvaXB6GlLN6zBgidRVoNok/pWD/8byxuuB1Ug/OU9As6sAyXQXri/o6Tjhsh5eKqflrApyt7KfmwSEajOWRmgDuAw9dQ4qNw8MX/EorIvTc/6Zi/FDl7cAd0gORj24NzmyiIgoobXtLAtDb+E7/Iq/lCgs8GI2G3h5Gekrs3U2UMXTPXt9zIucv3sDbVAqs4k+2s4IWLb3iZe2QJwEvl57yo6zYgKB5CRmikUg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7b0796-0126-436a-0e34-08defdf7332c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 13:38:49.2506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lB7y2TMxbRHT809/hbvigD1qJXdLw9ddyyi+oVON6lTqvYZdA7/9w/3wWfWNNyO5eb3No6C5gHyYSKOttvlD4/4xr+uYv+mg1KVrG9Z9McU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7336
X-Proofpoint-ORIG-GUID: DFQVLJuRiaQNtUsKU2Sm1UOXs_kCkJeb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfXxUxTJAfEDAZi
 ukbOdxh+/Pn2yNASxhpMTLd8BHgLdOAwEneYP3vVeq8rHC8Hvt/kRXela0EcPHuNHJCdysmMvho
 AXWBbtKlFVhQzLdXA0LyRJq1IH1nfoRw2u6Lvi2KtW3h7w4a+mZ+JSftSjo3o2bEi2d+aQ+PCJB
 Y2LtUImY7k/5ayHWvo2PEX5+912ybYdCOQ9C6/lCMpllOZYj4fFucNzDKB6TQU0h8uEubG2Dhuz
 yirCjOV4Uf3YdNWhuwNOI9pBdyaAGvw81caz/EaYXyMAIh5f7RIo97sgOhcUdZxctC6drzXGcYu
 6/3zohPInFMX/2YOzsKkdNcN62B97ffQmDc0mh8vQQLrgeujshRpD3ZRKnxzxGDTCU6xjiAy+kG
 jFTBWApOf/bZD45Z+7BzydN5ncGp8bKzmWxMRcRGld8MG91669MdeeMds3OiqhnvXnRm+pPgcdO
 5fXBGK4pCuASL9s6T3Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfX0zBX5rtXtGlV
 FLGW+30FmMr4Sajbh+jZdCxPnZPujSqrNSPfA57Z8+P/kBYZXeTjUpvXzaMcTDYHafCuU6UrCg8
 FuUqDIlJ2u8caZR62jTRzF9X6UkECLE=
X-Authority-Analysis: v=2.4 cv=TfqmcxQh c=1 sm=1 tr=0 ts=6a85b1ea cx=c_pps
 a=is1TPszdXRKtgCc8Qn4wPQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=EUspDBNiAAAA:8 a=_dIhvDIfpQVvNhxktcwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: DFQVLJuRiaQNtUsKU2Sm1UOXs_kCkJeb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
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

The ACPI_PM_PROP_GPE0_BLK_LEN property is assigned to a static variable and so
can be converted to a static class property. Introduce
ich9_pm_add_class_properties() to hold the ACPI_PM_PROP_GPE0_BLK_LEN property
and soon all other class props after they have been converted from object props.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/acpi/ich9.h |  1 +
 hw/acpi/ich9.c         | 14 ++++++++++----
 hw/isa/lpc_ich9.c      |  2 ++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 30990fcef5..3fb993bb9e 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -84,6 +84,7 @@ extern const VMStateDescription vmstate_ich9_pm;
 void ich9_pm_reset_properties(ICH9LPCPMRegs *pm);
 
 void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm);
+void ich9_pm_add_class_properties(ObjectClass *oc);
 
 void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                                 Error **errp);
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index ac3f452dc3..774b34195f 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -402,8 +402,6 @@ void ich9_pm_reset_properties(ICH9LPCPMRegs *pm)
 
 void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
 {
-    static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
-
     object_property_add_uint32_ptr(obj, ACPI_PM_PROP_PM_IO_BASE,
                                    &pm->pm_io_base, OBJ_PROP_FLAG_READ);
     object_property_add_link(obj, "bus", TYPE_PCI_BUS,
@@ -413,8 +411,6 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
     object_property_add(obj, ACPI_PM_PROP_GPE0_BLK, "uint32",
                         ich9_pm_get_gpe0_blk,
                         NULL, NULL, NULL);
-    object_property_add_uint32_ptr(obj, ACPI_PM_PROP_GPE0_BLK_LEN,
-                                   &gpe0_len, OBJ_PROP_FLAG_READ);
     object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S3_DISABLED,
                                   &pm->disable_s3, OBJ_PROP_FLAG_READWRITE);
     object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_DISABLED,
@@ -432,6 +428,16 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
                              ich9_pm_set_keep_pci_slot_hpc);
 }
 
+void ich9_pm_add_class_properties(ObjectClass *oc)
+{
+    static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
+
+    object_class_static_property_add_uint32_ptr(oc,
+                                                ACPI_PM_PROP_GPE0_BLK_LEN,
+                                                &gpe0_len,
+                                                OBJ_PROP_FLAG_READ);
+}
+
 void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                                 Error **errp)
 {
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 8925cd4387..c968f4444e 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -916,6 +916,8 @@ static void ich9_lpc_class_init(ObjectClass *klass, const void *data)
                                                ACPI_PM_PROP_ACPI_DISABLE_CMD,
                                                &acpi_disable_cmd,
                                                OBJ_PROP_FLAG_READ);
+
+    ich9_pm_add_class_properties(klass);
 }
 
 static const TypeInfo ich9_lpc_info = {
-- 
2.43.0


