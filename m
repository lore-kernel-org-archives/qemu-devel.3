Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15961D2E01E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 08:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3WlG-0005vX-6c; Wed, 23 Oct 2024 04:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1t3WlB-0005vK-UA
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:30:30 -0400
Received: from mail-bn8nam11on20621.outbound.protection.outlook.com
 ([2a01:111:f403:2414::621]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1t3Wl9-0005VA-FZ
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:30:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbhHcxKXdm1v9abIxAVzclMe0Fdysr7IcSq5fiFsW3JF7+fLWFJJkorphGaiSn2rO9LjbHuXIVzVt7gcYm3T7Og+OCVNWeg22Xu9U0mhYljuVJlgqVSvW2k9llufB6NLZpuLBeFMl6QFX9BZgfNVQGWMnDHtdHwSGBa+LaaAUs4/SeCwPdKBPYRLznTLdtMynYM8te2lk1gCSAJyWQ3zbVtZJ3IcyZ5AK/9HUMn8Xy1mWILkLytBK7vrJmcQ8r/bdfwAMdGRwACJ3j+FG0kTeejwqzwERtGd9o6z/sQwSq/aH4InXLCql6mpqi7f9AzpKDXTcKi/l/R5TnPsY5Z4ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ag1Hc/vpuoBJc1rZ8HUPh9Q4y9siuTKFjPg5h2x3q+s=;
 b=wA4w+21sL3W80zUOSIcspBwyUqPKEUbwZM/hM/lE7eqqZc4Xk3Le+D1LwRH3fmKFgDfmDnD9N+4Zpxpi1e60BrWtZlVcZgk51NrG5U7ZhsmxMhfh3jK7+pd7J9tH6gbKlE2vgewRNL07jPtUSkORdjNpDLwvBXWciwxOGC/nskK5ElBOR5WLGE06j5mxB/TDYwXIQEtl7uQhuZQ8pW9tvsoxL4x70nMSLCtAuWM+aYeBDlYR27Mnm0CaAXkQREFFPJDpwCaaZwSKJxF4LhrVvWwL8t8mmAeWOQsAr+LzOVZq8EwtMoX8ZItZo+wFL+k/Scu8WyqoTZSCp9wlykGiQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ag1Hc/vpuoBJc1rZ8HUPh9Q4y9siuTKFjPg5h2x3q+s=;
 b=RfiNj0exjFJ61d0lh53PNO2u1wIpvnCr5Uiq1D2N/s833lthR64Cz60U91L6/QLYo+hRame9dblrvNRc1wD7g0nSnTQjvBcPFCb1UHVywpsGUeUdsH3HJuKMze24N4/7ASPnQLTEmun732n3hYr3jp4SElxvbl7gD2fonl9hYFPcP5KA4/aliDruU5txn8p0SMa33vigYt/HZVlpk4tvSdKCD6AXEHeSiZ4saFMpoVZ3fWudtw2fcrIpkv2dfRWwYzYYyAx7QiolDyD7mmBt7TuIbXsFqkodD4DZy02+7sArarUoX+4CpKUzRaHOWBLCkjDYr1M3cwkF8vaODypjsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by BL1PR12MB5779.namprd12.prod.outlook.com (2603:10b6:208:392::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Wed, 23 Oct
 2024 08:30:20 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 08:30:20 +0000
Message-ID: <0540c704-c2ce-41fc-bbb3-a2d84f0f2fc7@nvidia.com>
Date: Wed, 23 Oct 2024 11:30:14 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] migration: Make all helpers in misc.h safe to use
 without migration
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, "Dr . David Alan Gilbert" <dave@treblig.org>
References: <20241022160720.1013543-1-peterx@redhat.com>
 <20241022160720.1013543-2-peterx@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20241022160720.1013543-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0430.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::20) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|BL1PR12MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ba6a61-040f-4928-79d5-08dcf33cee0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHBaYUZBbmdqQmdEckg1UGlNaFFxM00yOEw0L2EvVk1NeHVnM2crZHZlcW9R?=
 =?utf-8?B?OUxNc3VoK2E5YVFIazZMRE03U2pocCtzSUtnTTNzVlRwamRkdlZxeDk2S1BP?=
 =?utf-8?B?TitybFJnQzU1TlVpaXJtUU5UYzdER0Q0aUdhWElPRE1FenJDVHdxYldhNEQz?=
 =?utf-8?B?eG9ON1ZIb3hzYmlKVlc4UE5SUmdnQ282L2ZMcjRCMVBmOFBIMHdraG1oOXVX?=
 =?utf-8?B?aisxdUsyV3gxcVV4WTc3ajRyY0ZNRitkY1Z1S1JpTFJRSGFaMElEeVdabzd6?=
 =?utf-8?B?K3BuTFpDSDI0andxYS95akhCV2lCZDhYYmFaT2VCS1hlWVBaaGI5aThGZEE2?=
 =?utf-8?B?a1ZWMmJ2WExkcmUzSFFpOUh3TS9FTlZuUjhLT1Y0R3d2U2lWQjlBbDJMbjI4?=
 =?utf-8?B?dHBKSGJ5a25WWUJjbVlNM3IwYU5RQTFSSi94WVB4YURFQzZ5b1V6MW0vWkpt?=
 =?utf-8?B?YVliUXYxZUFWZnc5TjFUbkc3QjFUUlFUU0dra3pSSWM0S1k4aEVNb1ZYNUNG?=
 =?utf-8?B?ZVd4cGtWVGRSaE1HYmx6K0cyM0ZhUG40WjR5M3FyWm1yZHhxT1EvUWNXQkQ1?=
 =?utf-8?B?YmtLQU50QTVyRUhzaTBNRnJVZTYwd045Ky9PRVdhUHgwbGVicUlJc3ZNbjN3?=
 =?utf-8?B?MUdmd3dtZHgwRzc0S083K3dvQUlQUHhhVE4zdjlUSE1Hd2VJd2hiaFRWU1E2?=
 =?utf-8?B?WWcyMTBRMVZFSDI3clVrZU9yUi9jZmcwMFBQZGtkY0liWE15R1RSRFp3T0Vn?=
 =?utf-8?B?OS9SQTRnUjdUOUdrM0ZPbU9pVFZtQjlpN0JUZUFob05DeVBsK1hDcVlQd0hK?=
 =?utf-8?B?cklhQ3dTSmNMc0IrSzlrUFdNTm50c3pqKzg0VlRFdXdjajJOVXlxVEs3ZXpi?=
 =?utf-8?B?cmZvTEE4cCs4SEtnNThsMGVacE8yQ0RNR0dnOGlNaDlJOUZ6RzRVNFVBd21q?=
 =?utf-8?B?TmZUU1ZKRHlZaE42NGJjQ2UvT1hrQys1YUdCNGQvTndaSW5MdmsxWXhVeVBz?=
 =?utf-8?B?V1k2RllpdFpGTzRMZndFS0FScEdJOU9UZE1NRi9UaitpaHNNSDluRllUTEVP?=
 =?utf-8?B?dGNwclk2U2NLeWM0WVV3THh6NlNkMEl6L3haVzdiZlVaWUQ3d1RzTXlCQm9l?=
 =?utf-8?B?S1UwZlFyYVNObHRVUUFLQ1ZoMW1DYUk4Y1k0bFZGMnBYdm5hb0tVTlpWQjNi?=
 =?utf-8?B?UjdXdHZmZnB1VXJML3Y0WG1QaFVCRjI5V2gxZ1dTdk95UnJCNEdqS3d6ays3?=
 =?utf-8?B?THRqTEhJOEh6bHJPWWk2MnhEenYySTJlb3g1QWhiMllBOVVnTkRvWTY4R0J4?=
 =?utf-8?B?a2pZNnZnSms4aDA5SDkwQWNnbytCRk5oa3E5Vk9oREFEV0JyaWRqRFc2V0lx?=
 =?utf-8?B?ZkpzdlhYVjgxNTZIN25lcUZFa1pXWnF6K3k3a1BCa3YrRjJick9tT3NqdWxi?=
 =?utf-8?B?RmtNNXRpRnRROGptMU53UndPQW5YWEN2UzNZNUlPUGxpKzhzcnJDZ2RHVll1?=
 =?utf-8?B?bHJJVzNxNStyeWNMRVVFN2N1L1RQK1JiUjk3MTczTXBuaW9ycml5VDZCQ0tl?=
 =?utf-8?B?amxRa2Q2algrM1BUMjZadk9QYXd5M1RpRVRwck81ZFcxZG9oNWc2L0RscXBp?=
 =?utf-8?B?eHNWZHU4V3VRenRlRHZ4TnROM2NxcEQvUmYwNkxhbFo4OS9HeTVLL01vWTV1?=
 =?utf-8?B?di8rNXF0VXROcGZIaTFyeWdqdmFMT3RaZkZPcmlyM3N0bWlNUzNBVUJXRFNk?=
 =?utf-8?Q?1MvSNSLYj96D/d+ZvlYs+yFJO35XqB0KxKNXIkZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVR5TGsyNjI2T0oxZ0ZwUDBBVVJ1N2k5cG1GOEI0dXdGdm5scmxaRDdieUtM?=
 =?utf-8?B?ekhXdGdWQ1hFL0VROFBpd3VnemN6Q01rUzhzYXhsa01NTnlEa0s3RzUwV3Vp?=
 =?utf-8?B?WGcyaFk0dUJsZnhIRHAxajBrU20yc0J1dnJZWnVhUjFSa04xd2c2eEsvZi9T?=
 =?utf-8?B?eTVmWVEzV2ZrU3VEckR6QTNLNmllbHVIeWd6TGliVnNNU0VaR21Fdjc2RmlM?=
 =?utf-8?B?SHhKYTdDc3JXbXIzckdGV29vOXc1REV2cmRvMnF0a0RlZyt2Z2xSMmd2YUFm?=
 =?utf-8?B?Z1FFWEs4SkhSTWsvajRSSEZwUnRLc3BVQ1VCdFVBS0JqeklQVlR6anYzaHZP?=
 =?utf-8?B?VEZERHdrSElmajNpWjVBcEY4RGwyYjdmRmp1RXVrbjE0ZFpJQjEraUJWOU5H?=
 =?utf-8?B?OHBRNmc3cFRaRjhRL09QeEZrR2k5TkFMb2NvZjlXa0ZmOTlSWmxidUlNQnJW?=
 =?utf-8?B?aG9rSm1ORzZoVkpNWUJCUHduQURFVWN0WlZWYW9iQkdrb2lvSE0vdmxtY1Rk?=
 =?utf-8?B?MHY4UVlaa240c05VL2crZ1pDd25qODMyNmozTkxWNlI2eXV4NEJVZE5rcno2?=
 =?utf-8?B?NWNsZUFsbGhnaG9DSnV1ZVI4RWVFS2hGR2Y2WWJTNmhqbHlZUEg2TFhRTFoy?=
 =?utf-8?B?OCtJbzFmTTZRdmpaMVFlWldkOEpWNXVZUmp1RklEVHE3MXBnR3B3M0RVVHd4?=
 =?utf-8?B?N0tsV2xXVVpobGVQOTh6L2xzR1FaTTZQNklSRDd3ZkVwTUVlSC8xV3VEYzVN?=
 =?utf-8?B?OXZ3V3RIMGMxcmptSHVvZklqNXFZN3dubWZZZVRneVh4VHZZaXJYMUdONlp3?=
 =?utf-8?B?blUyVVJ2V1ZMQThIcUlWRVFPbXVQMVhFNk9remNmYm9GWGlaVHRsU0dYZUN3?=
 =?utf-8?B?a0pXZ1doeVQ3b2lvQjBqeUEwSm5kY2RWc1JVQmczU09RT1Y3V3QzOEN5eXZR?=
 =?utf-8?B?TFp6WFIvSXRWZkMrbVJSWmhtc2NxNzAxdHZPVTVERU5oVFhEWURhODAvdk9t?=
 =?utf-8?B?dnpYL1JQYytwU0F0eCsySmhkUmhiUmkwL1JCSWJCS0FXYldCalNpQXptdVlO?=
 =?utf-8?B?ZjJmVnJmUEg4NUhwVnI3ZUVMNE9RRmt6UzBXamdDbHJhbGdtSHN1c3loSjVt?=
 =?utf-8?B?WU43MDQ5ZFI1WFhPalluUVdJZ2NsUkhqR1pJMFNnRHRkM1FWc3RIV0twVVVs?=
 =?utf-8?B?ZXNSTVR5S1BMSVJyZi9nN3VMdWpaOUJmb1UrVGJkOEF2enJCYXFGZjFWVHQy?=
 =?utf-8?B?V1pGNVR1K0xXN1ZnL0k1VnQ0Q3FSQkhGRExydFphWVVyNjRtazVPbzNrUFYr?=
 =?utf-8?B?c1BIbnZ6VlpIUzhiRXBMcVBzWkJVM2RKUU1Nd3BqbDNwdFRXV053VnBsM2ty?=
 =?utf-8?B?ME1jbFl3b2JyNW51d29lQTVkYWlVdHNKQnVmbVBqbHN4NUVDSDVOYVdzR1J4?=
 =?utf-8?B?eXo2NDdCSnlhR3UydnJza2loODVEZDljaFJqaUdYRFBCcldnNDRhM3cxaGIr?=
 =?utf-8?B?a1ZiNGl5WkVBZWlaWDJvNlN3MGRpcUNUR0swVGxoV2hZYUJ0NlFYUFZOVjhr?=
 =?utf-8?B?U0lKcWtPRWV3eXhFeXgyR3BwTHpiTFlCTXhDZXN4T01RbFJTUUhiWXY3WDg4?=
 =?utf-8?B?K2hScXhYNVhzU29GRFdVdUFJMXlPYzd5OHNBSUFuRnhVWnJBaUVQcndwa1Rr?=
 =?utf-8?B?SUloUVFucTVBcUlvT2tLYVdVdlNWSGkwVmNsM3VGaTZVOWZtQVhPTVovQVR6?=
 =?utf-8?B?ME9KTWJiOFFxRVovaTNmdEFqNHhSd3FHbGVWWjBGZzZxT1dIWXJ3TEd1dDhs?=
 =?utf-8?B?ME9wWEhSWUJzTlo5QzA5VThNRFcvT25mWFIwT2dQdnJidzltamdSVVZSekU1?=
 =?utf-8?B?WjUxbFl2OFc3Y0wwSzdzcVZNekpKTDkvNFE5SmtDTG5FSSs1b0s2blljYUZZ?=
 =?utf-8?B?Z3FOR0x6WDZXcVdqVnBPcm1scEhWaGpoK2g4clVKZ3BtOHBOdHRyWU43MXYr?=
 =?utf-8?B?eUFvekpUdmt3SFE3MlZEU1BSVGc3YmhJempGSG1aUU5BT2dmVjdaK2IwRHhH?=
 =?utf-8?B?TERzcUtSY1o4QmVxZUhSWm4vQU1abjRJMWVDT0wzWk9jdUdNL1NXeFU3TW9z?=
 =?utf-8?Q?hzwu6nc3N0FXS5wPQBoHhkSmA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ba6a61-040f-4928-79d5-08dcf33cee0c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 08:30:19.9588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZtzYG0XgbC/nOv5ti+ZZqMBAcpK5q/0qvxdXg+l9z065xHtlTD4b5twBuuaZP6TYR7wW1e9g942GY/aDu4pB+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5779
Received-SPF: softfail client-ip=2a01:111:f403:2414::621;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


On 22/10/2024 19:07, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> Migration object can be freed before some other device codes run, while we
> do have a bunch of migration helpers exported in migration/misc.h that
> logically can be invoked at any time of QEMU, even during destruction of a
> VM.
>
> Make all these functions safe to be called, especially, not crashing after
> the migration object is freed.
>
> Add a rich comment in the header explaining how to guarantee thread safe on
> using these functions, and we choose BQL because fundamentally that's how
> it's working now.  We can move to other things (e.g. RCU) whenever
> necessary in the future but it's an overkill if we have BQL anyway in
> most/all existing callers.
>
> When at it, update some comments, e.g. migrate_announce_params() is
> exported from options.c now.
>
> Cc: Cédric Le Goater <clg@redhat.com>
> Cc: Avihai Horon <avihaih@nvidia.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/migration/misc.h | 33 ++++++++++++++++++++++++++++-----
>   migration/migration.c    | 22 +++++++++++++++++++++-
>   2 files changed, 49 insertions(+), 6 deletions(-)
>
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index bfadc5613b..8d6812b8c7 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -19,8 +19,26 @@
>   #include "qapi/qapi-types-net.h"
>   #include "migration/client-options.h"
>
> -/* migration/ram.c */
> +/*
> + * Misc migration functions exported to be used in QEMU generic system
> + * code outside migration/.
> + *
> + * By default, BQL is required to use below functions to avoid race
> + * conditions (e.g. concurrent free of the migration object).  It's
> + * caller's responsibility to make sure it's thread safe otherwise when
> + * below helpers are used without BQL held.
> + *
> + * One example of the special case is migration_thread(), who will take a
> + * refcount of the migration object.  The refcount will make sure the
> + * migration object will not be freed concurrently when accessing through
> + * below helpers.
> + *
> + * When unsure, always take BQL first before using the helpers.
> + */
>
> +/*
> + * migration/ram.c
> + */
>   typedef enum PrecopyNotifyReason {
>       PRECOPY_NOTIFY_SETUP = 0,
>       PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC = 1,
> @@ -43,14 +61,19 @@ void ram_mig_init(void);
>   void qemu_guest_free_page_hint(void *addr, size_t len);
>   bool migrate_ram_is_ignored(RAMBlock *block);
>
> -/* migration/block.c */
> -
> +/*
> + * migration/options.c
> + */
>   AnnounceParameters *migrate_announce_params(void);
> -/* migration/savevm.c */
>
> +/*
> + * migration/savevm.c
> + */
>   void dump_vmstate_json_to_file(FILE *out_fp);
>
> -/* migration/migration.c */
> +/*
> + * migration/migration.c
> + */
>   void migration_object_init(void);
>   void migration_shutdown(void);
>   bool migration_is_idle(void);
> diff --git a/migration/migration.c b/migration/migration.c
> index bcb735869b..27341eed50 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1121,6 +1121,10 @@ bool migration_is_setup_or_active(void)
>   {
>       MigrationState *s = current_migration;
>
> +    if (!s) {
> +        return false;
> +    }
> +
>       switch (s->state) {
>       case MIGRATION_STATUS_ACTIVE:
>       case MIGRATION_STATUS_POSTCOPY_ACTIVE:
> @@ -1136,7 +1140,6 @@ bool migration_is_setup_or_active(void)
>
>       default:
>           return false;
> -
>       }
>   }
>
> @@ -1685,6 +1688,10 @@ bool migration_is_active(void)
>   {
>       MigrationState *s = current_migration;
>
> +    if (!s) {
> +        return false;
> +    }
> +
>       return (s->state == MIGRATION_STATUS_ACTIVE ||
>               s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
>   }
> @@ -1693,6 +1700,10 @@ bool migration_is_device(void)
>   {
>       MigrationState *s = current_migration;
>
> +    if (!s) {
> +        return false;
> +    }
> +
>       return s->state == MIGRATION_STATUS_DEVICE;
>   }
>
> @@ -1700,6 +1711,11 @@ bool migration_thread_is_self(void)
>   {
>       MigrationState *s = current_migration;
>
> +    /* If no migration object, must not be the migration thread */
> +    if (!s) {
> +        return false;
> +    }
> +
>       return qemu_thread_is_self(&s->thread);
>   }
>
> @@ -3077,6 +3093,10 @@ void migration_file_set_error(int ret, Error *err)
>   {
>       MigrationState *s = current_migration;
>
> +    if (!s) {
> +        return;
> +    }
> +

I think this is not enough because current_migration is never set to 
NULL after it's destroyed.

Can we add "current_migration = NULL;" to migration_instance_finalize()?

Thanks.

>       WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
>           if (s->to_dst_file) {
>               qemu_file_set_error_obj(s->to_dst_file, ret, err);
> --
> 2.45.0
>

