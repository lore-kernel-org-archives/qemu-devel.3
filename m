Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EBEC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 12:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9jlt-0006y1-6W; Tue, 29 Apr 2025 08:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1u9jlq-0006xo-1J
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:09:06 -0400
Received: from mail-am6eur05on2112.outbound.protection.outlook.com
 ([40.107.22.112] helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1u9jln-0006yd-7R
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:09:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BX8hLMIwiUXWoH/gyAWWO5lohbpBC3VU3CpDPUg5XgiXQEOrCm1CHifXVcnSaxHbct12scWWvCIwz//YC4lYKqYjun4rtYkVfLSkI4rTp4bHzyFp0fEF/FI4c+CpR1eG1jHylxATR2GNvqW/2lOHkIPH6ywmIRAf6FTo9gOFfEl3sU4130G7LwnD2MGjTkAqVKwjjqkEcNb8t4hn6f7z90HfD+Cl90BeMiQ9+o1OBLwWRXSS1+QcuDI9sA8aEFTVar8L1RkfW+a/Tpi8+9DZX18GAFRNcbLS5Fv2V4nqGZBioQq8BsmXyZ21lCm5BcrkSTFXRzA3FXkbps8Hsi5PCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mHLEWMe/E6vKh2tJHp32Ig9tRz/xBQSkD0C14MQfIg=;
 b=iSWUgnHbdVR7ob9E/4Mt54Md/E2hb3v/UZDskyiFknPiZLnpIyHAm1NP6Vv/yDcO4yxcKZYuwfhg3yVW4k69VNsgmwAuU2KZ11Kr6WosII9FC8bW0+27T3uHF5EIClEOcaGxcP+E2dZ5g+dlJhHtbyeybAxfQlWnPWVX/xvWbEt2eZneY737LlfuZJPDtpKUdP/J7eKKJMBf4fI24hnD4UG61Chj5sCVLrE1conFlXRx7pPWk0owWV+maKHB57yxwSLLCxe5nduSgtJR41dz7O2cR5BcuIk8RghP1EKlrgwWxgd1G4pALcTuLVWzoDxpnOnWWh75m+pUZsAQs7p7WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mHLEWMe/E6vKh2tJHp32Ig9tRz/xBQSkD0C14MQfIg=;
 b=pXSuG7Lm0/U5OXeR2X9ApJPOvzYuRj898xLwSO94SgVU9uCSOR+VY4kYZIvJ4sqoAl5U0+bKVLPqQxK2dhrEdBBXj2L4Q/lueQFUnYJ+zhoWe/hP7MLm+CCDwRzNG5tvQrUuT4awlRsH+7Uf2jVM9Uxso8npO666Ttk1J92dfV0cM/gSrv4Rmo7VwgCtCz19SSeunIk2LWEP0PKh0ViSqygE90vdTueYt7AMs0vCbThu7sSntmEHt/DCe0SaO1jj/2QdHIVv9qTgubckC+WPByWN5X6jiqPw5KpCrfC48NlxRtvP5miPs0V5l7dhYE68nK+Z9aKD64RdHXJW7/Z+cQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS8PR08MB8734.eurprd08.prod.outlook.com (2603:10a6:20b:564::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 12:03:51 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1%7]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 12:03:51 +0000
Message-ID: <c06ca536-1ad6-49ac-9202-334536526ac7@virtuozzo.com>
Date: Tue, 29 Apr 2025 14:03:50 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
In-Reply-To: <20250428185246.492388-6-eblake@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>
From: "Denis V. Lunev" <den@virtuozzo.com>
Subject: Re: [RFC PATCH v2 0/4] Revival of patches to implement NBD client
 multi-conn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0044.eurprd03.prod.outlook.com
 (2603:10a6:803:118::33) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS8PR08MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: b9dfb1a0-b011-4fcc-85e9-08dd8715e7e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFM1R1JIVUR1bzZQaDVhSFREeGptOElVUUNadjhFTHpuUkV0Um5EM0R2WnJY?=
 =?utf-8?B?YWtkMzQrcFZPR0xlUFdrOURJd3BKVWxtZitkNUxGYUJPK1N6UUM4RHlVTjgr?=
 =?utf-8?B?WE9YdzJ3NllwSHZVYzlTWUVCSmMrNFE2RW9FV2Z4MFF0TU9YQW9kLzk2MG9i?=
 =?utf-8?B?R2JTeDNDVGlPbDlYV2dYRGxScnpmMDdSNENIZmJYYUZNdXRYN0Vnd0plNlBZ?=
 =?utf-8?B?OEpLeHR4S041Z25LZHQxdVhTUnljZWpBaXJRTVpXVjJ5MGJMNE4xdlE1dlhj?=
 =?utf-8?B?OFZvZ3RITjhRMGhwbEVNdGdoaFpha0xyNUhvZ1hIMTl6eXBmKzhFcUZseEtL?=
 =?utf-8?B?eUJzbTF2QlV5SGVYTTV3TCtlb3N6SFRVYXA5QkJKK241blNnbHRld2FVWWI2?=
 =?utf-8?B?UzJQWTFxOEUyV29DWjl5K1NaT0JmMkNWOXhHY0JXbkVqRkJMWVB1RHlrS3Bv?=
 =?utf-8?B?QXo5SkRFWTJYcVArTWptUnA5U090d21GK3dEY2JNN0RGTS9pRkt4Zk9FU2kw?=
 =?utf-8?B?KzhYTGU1K3lRRDVnNUYvbk5YQWFtbXhjQjZpVStEZ1VlU0tKSkQvSFJPeUM3?=
 =?utf-8?B?RGVGTGhac0pNdm85cnlUODgvUlRMWjhSMVhlR2JpWHVWM3Z2QTdHaktwaTVw?=
 =?utf-8?B?OGhrcW40eVZ6bmRXNmJsZWlGdTZFQnAyMjFvMEZTSmdXN0dXb2s5eXp4L0l1?=
 =?utf-8?B?bGx3aTd4NURHTDJCQ3RCZlZwR2NOZTBDQ3o2akh6UmdPdUJ4VWNQWnhtbEk3?=
 =?utf-8?B?Y2t2c2hFdVFMV0xwczI5Vnk5bkV5WFVFeXd1bFczUkZzendTZUd3cFZKeVZn?=
 =?utf-8?B?QXAvbDAzMzkyMEpZZHVBK3dkeFJaUEY2eTlYNUljOXJXLyttUytyWEliVVVp?=
 =?utf-8?B?NXdhSjcybkJkalpFdXdNcXZKMmFvSWhvU2pVa3NBRFVRd0dsa1EyOU5RQ2tQ?=
 =?utf-8?B?N0V3VzRxa253dnNlZ2RaY2JZRHFobFd0bnNOb3lXbXZuMWdTdGVqenNTa2l1?=
 =?utf-8?B?aS9XZDZDRDluSnBuSU5mdktXWjZoNDljNVdZR1JDOXVOdXpJUXRjcTFPR2c1?=
 =?utf-8?B?N3lqOFhhcG45SDRiT1Y2a3lkQndiZWkvY3dXN0VyL1JXd3dKU2tsbEV2d3Z6?=
 =?utf-8?B?SjdHZEhsUDF3SXlZb2wzWW1YdE0rdVNoa2ZzN2hDa3lzMXJNUHNvamFyV1dt?=
 =?utf-8?B?eEJWcDA3ajlWUHR0OTJkeFB3MGFFaWxBQ0txbDZtNVVWMlkzTW5ibHN4T3ls?=
 =?utf-8?B?bkk3VERLZXZSeFpacHBLTHJxalVWenlEOE5FelUvRzNoSm9CZU1SZS81cUc1?=
 =?utf-8?B?Q01HQlJYRUcyeDBKdkpsWHNkV3E0M2dhVW1KOW54dkZSYW96OW1udGQ4a2V0?=
 =?utf-8?B?MjdLbUN1Ri9iL0cyUGE1eEp6ZzcvR2pLMmZ0UERxbVI0WjBtU0xBSjl1ZVRJ?=
 =?utf-8?B?TkF6bVdkUTN6Z09UOTZkUzFkTlBzN21LTDIvQmw1YzdmOElCU2hsQ2dXbWts?=
 =?utf-8?B?YUFUbWZSeXZ0cVphR21qMk1TS0hybExVV3BXNHhHTE5nS05mUEtidzlPaTZk?=
 =?utf-8?B?RkM0NkFaWUI5UVNRKzBCZEJRTWg4QU5VYzFQdFZZNlZmcTZ3VEZsdDZzeTZn?=
 =?utf-8?B?WVpGUjNBYnFMeWF3WTk4ZjF1SFNCOWZWalM3byt1UmZ2MkRodDZDNFJ1bmp6?=
 =?utf-8?B?RnFqUXNEMFB4M0VJeUkyb2N1RHl3b3B0T0pvZ2tCSDhxT29uZkpDMDk5VnFY?=
 =?utf-8?B?UUhPRVhKandsbXhXV0lqLzFvNWdTTTVGbVlHYWV0WDBJVDB0aXVkRnhIMk1S?=
 =?utf-8?B?VWdSY3lxTThNNkFBOEc2SVJRWGQ5R0twTkU1NFdidHd4VGM2MFJ0eTdKaks2?=
 =?utf-8?B?dGc0L2tBMEFzcnpSblRMMFRqbnBxVjd3K0IzSGFtZlNMMXF2ZnZVNWtQcUY5?=
 =?utf-8?Q?xFuKoVcuzfQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3Q4L1htaHJZK0lESnAwK0ZkcHE1R1cxdHJyZTZjbGxSSE9oN3JEbE5ObUJo?=
 =?utf-8?B?Wm9xZlB5RHVUcDU0WjQrSGdjL2tHQnZJUGhWQTQvY29xYVlqZ0xSOFVHVWFw?=
 =?utf-8?B?SXk1MHc0bW1XMmJGd2EzdE9hMUhpVDh1eE82ZXZUcDYrZjM0bzZXbDJkUkJv?=
 =?utf-8?B?TUJCNXp1T0ZKeXRXam41anZwQzdDNEs5MVZ0N1Myc2FETUdvbkcvcDRWakNY?=
 =?utf-8?B?ZElXVDZVbFErUlkxZjhFbU1ncU5PQmpKL1c3NXIyZ3dEcGFEZXVrdjdrTDNG?=
 =?utf-8?B?ZE5DU0dtZUZHWU5INUM2UVVLU0UvT3A5M3hhL0tEeWVjN2g3aHdkK1hGT1VO?=
 =?utf-8?B?YXRzYjQ1cllBRWVEY1JNbHZucXNtb2g4RldNbU5WZjV3WWxTT2tWNktpWllq?=
 =?utf-8?B?Y29rQjBnZUFtM01yRFplcW13dHhwdzdTVTltK3d1Rzl6RGV1UHlYZHFnUVFO?=
 =?utf-8?B?QzJFY1pSVytKd3FRU2VwZkNvVU5vTmhjelpPV1MwNGtnVWZMQkRhRWFGMUNz?=
 =?utf-8?B?RGZqMytQcVl6K0tndFhjRUd0c0Z3OFU4T2lvaVp5UTFKM3RsQ0M1MGh3R0R0?=
 =?utf-8?B?MUEwUDBXd3N3VnJmTUtGZFB4b1Y3UW45d2g0MEFpVFBBcVhxeE5JQWNXdDhM?=
 =?utf-8?B?WlIxanJOTTg5UlhPMXBmV1dIMEovMkU3TUZLU2sxNFFmOWsycUJSZ3FFN1hi?=
 =?utf-8?B?dzJOcTZNTmRDOVBJRzB5dDMzL05FdG9YQk5BVkx6Z0RGL29oQ3FyaUVsVXJy?=
 =?utf-8?B?b2pUWnc5UTd2SHZSY2R3dXBrUjVva1FhcUlGcmlua2N4UG9CaUpUa3dDM3ZZ?=
 =?utf-8?B?OFNhaG1sQTBRRloxMkUwSWRvTTV0RVI3U0FDaTZwRGp2WjFmVDhVZzV4bW52?=
 =?utf-8?B?N0hpdmNKY1ZvRlZxVk9DdzVxREhkeW0rc2NzR2U2RjJSOU5OSnJ3WWZmWDBS?=
 =?utf-8?B?SHd5d29PaGgzRkxWSlBieTdvcHpTYmFLb1dlL3ZDSk45dHZBYzkrTXd3S1pv?=
 =?utf-8?B?c1lxeW5nZ2EydUhwR1JTeDhEVHBaNkdmaDRGejYxT3NLT0REWXJZcWp1ajJa?=
 =?utf-8?B?cks5QVd1S1ZUVlk2ZjQvVDNTL0pOUmdYK0xERGIydmJOSDN6Vjg0c3d2eU9K?=
 =?utf-8?B?VDg4TUtmUkdWc2VkcXFZb2lTb1dHQjNjeFZiUDB0TkRSWmNpdk9PaXBSZDVH?=
 =?utf-8?B?b2hpeGFYbmZHajFKLzg4enprRm1hNTg2QnNQMTFPKzJpZmlGenRjUTZDcEVt?=
 =?utf-8?B?cXVrTWt3NERWSkppVVVXTUpUM2E5a0FtK1FEZjQwSExnYzROeTdiQTdNV3ZJ?=
 =?utf-8?B?Q3JYM241eXNES3VqK3JWQTQ1UVExRG1kQUVnbWF0NVlkcTkvaDUvelJ1WXRK?=
 =?utf-8?B?R1ExN1ZXQnZ4WkN6MXFna3E2clR1S3owWGNablEweUd1U3RnK0Q5Zkw3SFpW?=
 =?utf-8?B?TkVIYTVneTk1eWJSMUNPSDBuZmx6ZTBYNnk5STVrdWgvK3JxWGRQQXkyOUdQ?=
 =?utf-8?B?L01NNitpdnpmWWFpWEo3UEtPWWNOSHA5a24xUzk4Q1A1SnZvMzVZbzFuTmNK?=
 =?utf-8?B?MUpoVnNETUJhMTRaQkFYbFB3bnI2QjRCNTMxVVFKUm9uNVQzSXF6STR2NFpE?=
 =?utf-8?B?Q1RQOE44eFhjd0h5eUdqNHdxbmxyM0ZhRGRQYVJUOTdtSmZOeTRrMy90bUdi?=
 =?utf-8?B?S00vUW5qcEU2WWZKUlNySVhaYlBNUjJ0bitBY2ZJd2VXOVh3VTNOSW5ucU9t?=
 =?utf-8?B?OGh5QStDdXZLZW9PT09pMVBCdE1DVnBiREp0anZDWG1rVzFJMEpzZDFBYlov?=
 =?utf-8?B?ZGp4T2ZCTWI5d1kxZW9raUpPemNCSjZ2by96am9GUitNZXdUZWRPaHQ3RnVo?=
 =?utf-8?B?OW9EdHZQaDlwSW5rV1hLYk85MkEzYTNiQkdlZmQwNlYvVTBKcEZ4TzNXeFNE?=
 =?utf-8?B?OGgxcFNUZlJNM0lzcDVKVEdNSUtpOXJZOEZmR1pkRmYyc3Fqc0tndi82WHdH?=
 =?utf-8?B?eWxrYmF2cUprWDJkNzlZQUN0UnV0OTNqdHp3WFIzU3AxQjNibHZOZ0ZmZk5q?=
 =?utf-8?B?VWE5OENmYlJQdkVPZHV5SlZVeUxEMmZReWxuMDNWQUtXaXdTV2xYQXVJR3V3?=
 =?utf-8?Q?QxOyIDxPFQx7TuhJJQRL74Fbl?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9dfb1a0-b011-4fcc-85e9-08dd8715e7e5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 12:03:51.3579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5GQGZICkbFBMpG3oT233V+xTGFKXOS3hka3r/XPSCfIPGVEOlN3npe0Dv8nQ/qqxOjHAyVlgSufmpM6kASmKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8734
Received-SPF: pass client-ip=40.107.22.112; envelope-from=den@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> This is a rebase of patches that Rich Jones first posted in 2023:
 > https://lists.gnu.org/archive/html/qemu-devel/2023-03/msg03320.html
>
> I'm still leaving the series in an RFC state while I'm trying to
> improve the code to better play with all of the multi-queue changes in
> the block layer in the meantime.  In my own testing, the patches as
> presented here are not making any noticeable difference in qemu-img
> convert to a local destination file (multi-conn=1 was not much
> different than multi-conn=4, although I did validate that multiple
> sockets were in use and the round robin code was working).  Other
> benchmarks did show improvements, such as qemu convert targeting an
> nbdkit server on a curl backend getting a 20% boost when I ramped
> multi-conn from 1 to 4.
>
> I have more patches on top of these to post to the list once I can get
> benchmark numbers that make more sense.
> 
> Richard W.M. Jones (4):
>   nbd: Add multi-conn option
>   nbd: Split out block device state from underlying NBD connections
>   nbd: Open multiple NBD connections if multi-conn is set
>   nbd: Enable multi-conn using round-robin
> 
>  qapi/block-core.json |   8 +-
>  block/coroutines.h   |   5 +-
>  block/nbd.c          | 796 +++++++++++++++++++++++++------------------
>  3 files changed, 479 insertions(+), 330 deletions(-)

This series makes my day.

I have a request from our partners to implement exactly this feature
to improve the backup restoration performance in their scenario.
The case is the following
+---------+  +----------+              +----------+  +------+
| Storage |->|IPsec gate|...Internet...|IPsec gate|->|Target|
+---------+  +----------+              +----------+  +------+
In this case the performance could be limited not by the Internet
of something else, but with the raw CPU performance in VMs which
are doing encryption/decryption.

I was specifically requested to implement multi-conn inside QEMU
client, which was used to run the system from the backup while
restoration is performed.

This makes a lot of sense for me even if there is no direct benefit
without bottleneck in the middle.

Thank you in advance,
	Den



