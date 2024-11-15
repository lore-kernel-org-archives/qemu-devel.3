Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5D5D68BC6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 15:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBxol-0004gW-JQ; Fri, 15 Nov 2024 10:01:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michal.simek@amd.com>)
 id 1tBxoh-0004fS-Rp; Fri, 15 Nov 2024 10:01:01 -0500
Received: from mail-dm6nam11on20606.outbound.protection.outlook.com
 ([2a01:111:f403:2415::606]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michal.simek@amd.com>)
 id 1tBxoU-000783-P6; Fri, 15 Nov 2024 10:00:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOZGoY9OkxPpAZ4rMV6fv9oyPAvMlTvkiQCU1BaEWABiytaAAePkUJ76FyQ+4gIUEYVWaHXzlQhxMCp89ziVEc74bxQHYvcXg1p5WzxTGko/A1iTKM6HM8Ezv5MziTZzXicinaPYGOktihBsaHEHOMnNQ+1Sd9u6SeIg2Z0jbIkbnquYH1ZOlORhQBak3H/AzfKRXH86/Y9Z2cynuZqhZTWM8rMb+0xKp3qCSWVGUbOzlbjoJe7+4bgB+S3eo1Sh3z19/dZ6Tj075YKtKX/quM/n792nb9mSkkfRwb8L3D4PVF8vSJae3xsjTX4Fm+yKQYmcHdjfk/Tb22G5zVMYIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7XlwUnYjgcACGts5pCQt6CNzcBFqzcv3zRV+WFqhYM=;
 b=Pr4dBKquYgdqTnD4XvsovPg67Ky5c2+vRboAu1YfqX6nud5YERn7IDiAJnwJyG9Up8mHrXjIDzsZhOOGJlJ/NBiEZFwJSO9BEtRReCV/7Rc6FzAFfDryKtmtSCw4NqNFRyK3l80HZFiAW7cNrcWj2fdgU1kxQrTE7LZoLIdY5fZSbfzRePD+aCThmmTEVH54x50nvK65ByHDX7/WN/rrqB3dc8a0WVaUps0p2vo/9aNYUx2krI5HYRpfS4GwMjI8cIF1oPAmMpg90j+0JuEol/TVYBwdetW5+AIWiP5FhmvFQsuuEz2v9V58TOmKuRfJgt9FD5JbygnlHx9Cg9w5Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7XlwUnYjgcACGts5pCQt6CNzcBFqzcv3zRV+WFqhYM=;
 b=SuGhQfKZ9dL33gjA7T2iNDAM1GT4WCprBd1IIc7UsG14i7PCMsFsd2+KfJahxEUpF2y9MMb3PX35HzNY74oDAk6b4r4IdG9YS9hGVNXp36U3CwSD82/iK/kZFNhYCFIml+/E4jkgWuWXSVVs7RjtRmW51NU3pcqNpk93J00D1Gs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA3PR12MB7784.namprd12.prod.outlook.com (2603:10b6:806:317::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Fri, 15 Nov
 2024 15:00:35 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 15:00:35 +0000
Message-ID: <d3346a55-584b-427b-8c87-32f7411a9290@amd.com>
Date: Fri, 15 Nov 2024 16:00:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/19] hw/intc/xilinx_intc: Only expect big-endian accesses
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Luc Michel <luc@lmichel.fr>
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-10-philmd@linaro.org> <ZyqletOJvt3nD_L4@zapote>
 <1625bc6b-8951-414c-88c0-62061289fdb5@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <1625bc6b-8951-414c-88c0-62061289fdb5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P190CA0051.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::10) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA3PR12MB7784:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dedf1b3-337e-4d96-f8b6-08dd05864222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VG9DRDVkYjFNZXdOUjc4WlNaUGRaTUlHbHVIZUZnWUNmNWMzQngvZlF0ZStt?=
 =?utf-8?B?eldLUS92MFVtMTI5OENUOEZVYytZY3BNY3hVYlVVWlZEMXViMmlXSFhKSFZG?=
 =?utf-8?B?K1JOR3llZ2pUSVdSVEU0eDdtT2RtSFZNNWNWZzJrdEdsVDdHRE9RSVk2Ykt6?=
 =?utf-8?B?NG9aVEJNU21zZUhyTFZpa1pMQTVWTUJMMS85OStVZ2UwVG9CZndWMFd0MGdn?=
 =?utf-8?B?SzZnUDlQRXpCSDFEcGFjNEJtRGs3R1lPZk5PdWs3YUJNekNVNndEUjFPR09G?=
 =?utf-8?B?N1FpeEh2clMzSkhoNW5HTHRCM3lqcHZzdWVaU1ZCOExTZVlpdEdjckdxdnRl?=
 =?utf-8?B?OG14S3FxZU40cTBCSUQ2dzJ5dUhSeFpWRkVjL3JrOHpkRTJnOTRjZWJDS1FS?=
 =?utf-8?B?TzBiV0JpVklMMGs4amgwa0tqNVpScTR2SnVTeDhmZXpvK295aDdhNEUrR1Yy?=
 =?utf-8?B?RThaanBPMlovaS9RdE8rRzh0YjN6MmFzT2VjZjFVMVNvZVNtNUNMYzNqbHVx?=
 =?utf-8?B?dlJ2TytuRXN3a0RZcWwwODRFZHRuTjRNUEtKN2tCTDh2UXVwa0ZPRkFBd0xL?=
 =?utf-8?B?NVprdzhlR2orREVyQk5zVUtsZlhKRkFyZFZGeDZ0TWdRakJiYitYNnZuRTFT?=
 =?utf-8?B?Q3BDdjZ0d0tjMHM5NjNKeE1ra2RPaUYvaHFrTEswR3dOUlhOYVZRc2tCb2dl?=
 =?utf-8?B?eVJKaURiNC8yOFJWV1BqUXhJekcvaWhpM1ZmL3dQSk1nRFdkazRzM1JTZzVM?=
 =?utf-8?B?RVJyTFlCZk53YXpCRFo3dTdPUklFTE9McmZ6R0loSVhTRnhNaDdiQ0ZZb3I4?=
 =?utf-8?B?c3ZWa3FCYUJ5R1c5WTBQNHc5alpJSG9EQWhHbkNPU2FsdUdYNTBycjRCMXMz?=
 =?utf-8?B?UU1HOUd5a1BmNVN4VVVrMUN6bUtXVVQzNXp4QmxhaFBGRzdUMzBsYU42UmhE?=
 =?utf-8?B?NHJid1JuNWIzOEhOWHlQSVdjbGlvditHVDdrYkxOMEt1Z3hxdE4rMmZTampR?=
 =?utf-8?B?OU1QQW5sMHRYQTVRTDArZ1RMSit3VHR1RjduZkV6TzJRMW55U1ZLVVpyNU1N?=
 =?utf-8?B?czlVN0Z1QWI2bnp2bWVLcldmcjJCZHFua1pvajg1S3NOVTNLS2JNT3VkSWdi?=
 =?utf-8?B?emZUTXhCWlpFT01qWFNSNTRLRXBZTFE3RVAzdEhONEtvNE5SWk4rSnNOY0pZ?=
 =?utf-8?B?VmlNam9tSWpHVms5RGcvUTRzYWEvNm1XTjZXcThYbUEzVGw0cDhmb281QU8v?=
 =?utf-8?B?OEE5dXVhNStCWEZ3allNYUpvbzZPTStsczlDK1V3MHVxbzJuUXRqWXJOQ050?=
 =?utf-8?B?SGZHVk5sbldDOWxXUG9FSVVvakk3N3RjRGMxdmpBd0JNdnNIVU50S2I4RzVp?=
 =?utf-8?B?WklOK2N0b0M2d1JoSUgwcGUvd1RQbGdPNXdTR1pMcTFXTzQ0NURzaG9BdUJY?=
 =?utf-8?B?T2FQWTRjdDdsaWhVQ1ZEa0VkQ3NQOHRPU0hCanpYMEtXcUEvOThiZDVpT3U2?=
 =?utf-8?B?eVhQZlZnNzRaLzl4cU4yanh6ZHg0MGxtUStxNlhKZStvcWoyWHZ2SWN3aDZn?=
 =?utf-8?B?MElHenFmNlFQS1NXOWdORk5VWDdHTWJCSmNLd1FLVFptS3kyUjd5WHVZSHV6?=
 =?utf-8?B?QVFqeW9ZVE9qUml2akRmR2JJcjlaenROdHJhSFFmOUI4dEN4MVpiM20zZHZ6?=
 =?utf-8?B?RmQyQ2VCSTZ0RHdaNDFPUTNZWTFLVGVyTWFOWUZUY0l0OXBWRXJNR2xZb1I4?=
 =?utf-8?Q?SrJJty3ip9XIuyqpM9Iu6Sl1ApJ78nuxLxKYqRK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1NkZk1sUnNBcDV6SFdjbjlyclpvby9zRWpwaTA2Vk9YdEQrYzEwQ0s1WkFW?=
 =?utf-8?B?U1l0Tk1TVEs5bG9wV29ra29Oa0ROanNYV0JnSWo0UnlRb1dLVGxkREUrdWt6?=
 =?utf-8?B?V0RWNEJSU1EycnlzbFU4dG9FYThCYnBmOWVySk1sVzh5MGdSbnFYZnoraC9S?=
 =?utf-8?B?ZHN2KzJUNjYyQ1lWZUFGaVNMTW5aanBITzhEZVhhUktHajI0MHVOK3gwOXVy?=
 =?utf-8?B?WXpHZmh4ZGZyK1cvd2ZEUXAxNEQ3K0RpNVJWMnozRmhqTEZoRWNEZDR0ZFY4?=
 =?utf-8?B?MjNMTHBqdGx0YmY0SE1qRUwxcjVQTUNDVGRUNVpyVXBCeXI0SmFQYmJPdVJw?=
 =?utf-8?B?NUFEUDdIVTVYWjdSeWx3eXcwTDVYT3pYSE5zSHZzYlFId1hIdnRlRnNybU5Y?=
 =?utf-8?B?RTlLaVJmTkpnMEc5bmlHZ2NRenpiNmcyUjBneVkzZzIvcGNJNFB4QzV0N011?=
 =?utf-8?B?Z25XekRyVHdHWFJENG1lTE9ROFJNNjlPclVlWVo1TkRnMVIveEV5STNYREtE?=
 =?utf-8?B?aWliUnphTHIwQklwVVEzK3RXMGFTdlVHU2FIdk1oL2ttbVhyS1JJblhxWHVp?=
 =?utf-8?B?d0U4YVNEQUJ2bitkTFJLSVJvYnowU3hqWnBjYXJuTHNvcDVXLytUN2pQZzFO?=
 =?utf-8?B?NndOUzltb0xuS01zaEIwQnVIQmlxVUtRU1BzUXV0azJYUjBCTjJWVEN1OVZE?=
 =?utf-8?B?V2p2K3IxcnFSRU9UemJhL2RQU1NKeHZ2a0tvd1o2N291ZFdCNldmWlJEbVE2?=
 =?utf-8?B?V2VnbU1JSHJlbHZWT3NBUFV3Nm9icjZNUU5pSHN0NUZ4dkF4enoyY1NlNUtI?=
 =?utf-8?B?dVk3VWJJUzRCK0dRVFV4dXFRRGllR0ZVT0I2dFBGNlNPQU9oRXIyODZPM0p1?=
 =?utf-8?B?NTJWWVZ1MEV6c2xFRXJ6T1hKdExnbGFrMTVuSlZMWGxNTDJXOWNUdVVBVHov?=
 =?utf-8?B?L0JwMHZrd1hhaC83QlIwNkxHNmRNUDdTQzZPaXU5Z2Z5alYvR0lMbkZkQUhX?=
 =?utf-8?B?b0pNZlZWZEZuRTVUQ3ZlN2k0RWdqUjM5Q0U2d3FTNHZPeDZJeTJ2VnJ1ZDI2?=
 =?utf-8?B?WWJRcnN5V1BaNm56Zmd3N3lMa2xNMVROMkRGV2RIT2dqNEg5eHpZdWV5Mnph?=
 =?utf-8?B?YzNWNnNQZkNhakZjcjJvTzNYY0JDRklvTzZ0Qnc2UlpsNDZiTVZicHlWQ0pO?=
 =?utf-8?B?a2JhSUFpTUFzdTFDTTZtdm5sa1k0a2EvY0lkbVFWSGJBWStMM1VZVXRqdkVK?=
 =?utf-8?B?d05HM0s2SjZDOVRHd0E5UjhYSlNrekhqMTFzZ0VKcjNmNUsyWjhOUEZhalB4?=
 =?utf-8?B?SkFJQXRrSk1ISXQ0SkV6RVFQRWowWWQ2QTl6cG1FYWRJa0lHVVE5OVVZc2lo?=
 =?utf-8?B?K3BkNnc4cDkxT0t6WGRnZ0ZVdDVJcWhCd2JQeU9kSk9rSUJyK2lkVml1U0NN?=
 =?utf-8?B?WWRoc2pNejJCME5HYW5YUCtsdTFta0JqYjhkb1ZzM1Z3MDZMWWh3YlVCQW5E?=
 =?utf-8?B?cEpBRWRMRzBzaDNUMTNjVzIxdnhOR1AvRXcrVk16VWJ3YWhMaWhXdFM0UjlZ?=
 =?utf-8?B?bGZTd1Vja3lXblZWeWlNSFV1TXFNNzJYSE9hZGlyakpQaVlocmY1RXQ4SjNo?=
 =?utf-8?B?K2JCOWlzMWJNZUhJM1RTSGplU1hCNFo3bWdqWUprU0l2MG9LMDJrMSsxRGp5?=
 =?utf-8?B?czhaQklGY0ltdWZFRmdjbUo4Y2d1blNvalp6eEM5Tzd0V29IdkN4L0RybjF6?=
 =?utf-8?B?Y25ZUGZWb0YxSU5YQlRiWVZ0MHhtNHB0UDFFRVk3K0tIeXNQanZCZXRZbzdl?=
 =?utf-8?B?SlB5WE9MNHJZWWNLdTZUTGRJTWxFajUyNndxM1FUM0JzWGJ4NXNoL1ZXTHBv?=
 =?utf-8?B?MXkzbEtXcmNrS1JzTEdKc0FScFNqN3YvbTNTYVB2b0I0Z3NkR21RRXJ5T2dx?=
 =?utf-8?B?clZ3V0VKc2hZSTY1K2ZnRnF4U0tFY2JPM2k4NWRnRkxKUHZEbk5YZXZ2YlNZ?=
 =?utf-8?B?R3VLZDZDYlpQNHVHMFA5dFljTXdnWDByam9aaTk5eEREOHRVTHBkZ0UyM2Rx?=
 =?utf-8?B?UGo5R0RvNTMwZGZuYnNHclRLMnJtSTcvMzFqUHlLOWF4elRieUw1Zy9kTWNC?=
 =?utf-8?Q?AEsHBVozxlHhUk48/Z+oD0Ss1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dedf1b3-337e-4d96-f8b6-08dd05864222
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 15:00:35.0858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ey6GDyWHWIIVN6pNbn+ZQUzYm6UwNrT+aF/70antYhVwsDn+Pvvg5yzsRqrItUPT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7784
Received-SPF: permerror client-ip=2a01:111:f403:2415::606;
 envelope-from=michal.simek@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
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



On 11/14/24 23:43, Philippe Mathieu-Daudé wrote:
> +Michal for Linux driver
> 
> On 5/11/24 23:08, Edgar E. Iglesias wrote:
>> On Tue, Nov 05, 2024 at 02:04:21PM +0100, Philippe Mathieu-Daudé wrote:
>>> Per the datasheet (reference added in file header, p.9)
>>> 'Programming Model' -> 'Register Data Types and Organization':
>>>
>>>      "The XPS INTC registers are read as big-endian data"
>>
>> Hi Phil,
>>
>> Some of these devices exist in both big and little endian versions.
>> So far we've reused the same model by using DEVICE_NATIVE_ENDIAN.
>>
>> Here's the little endian version:
>> https://docs.amd.com/v/u/en-US/ds747_axi_intc
> 
> This model is specified as:
> 
> - https://docs.amd.com/v/u/en-US/xps_intc
>    LogiCORE IP XPS Interrupt Controller (v2.01a)
>    DS572 April 19, 2010
> 
> Spec is from 2010, you added it in 2009:
> 
>    commit 17628bc642260df3a07b9df8b8a9ca7da2e7e87c
>    Author: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>    Date:   Wed May 20 20:11:30 2009 +0200
> 
>        xilinx: Add interrupt controller.
> 
> The spec is explicit:
> 
>    "The XPS INTC registers are read as big-endian data"
> 
> 
> The other model you mention is:
> 
> - https://docs.amd.com/v/u/en-US/ds747_axi_intc
>    LogiCORE IP AXI INTC (v1.04a)
>    DS747 June 19, 2013
> 
> The spec is more recent than your addition, and contains
> the Interrupt Vector Address Register (IVAR) which is not
> present in our model.
> 
> 
> Indeed the latter seems to extend the former, but they are
> not the same and we need some work to model the latter.
> 
> The endianness explicit for each model (and is not listed
> in the "IP Configurable Design Parameters" tables).
> 
> 
> That said, let's look at Linux use. Driver was added in:
> 
>    commit eedbdab99fffb8ed71cac75a722088b8ace2583c
>    Author: Michal Simek <monstr@monstr.eu>
>    Date:   Fri Mar 27 14:25:49 2009 +0100
> 
>        microblaze_v8: Interrupt handling and timer support
> 
> Using explicit big-endian API:
> 
>    +void __init init_IRQ(void)
>    +{
>    ...
>    +       /*
>    +        * Disable all external interrupts until they are
>    +        * explicity requested.
>    +        */
>    +       out_be32(intc_baseaddr + IER, 0);
>    +
>    +       /* Acknowledge any pending interrupts just in case. */
>    +       out_be32(intc_baseaddr + IAR, 0xffffffff);
>    +
>    +       /* Turn on the Master Enable. */
>    +       out_be32(intc_baseaddr + MER, MER_HIE | MER_ME);
> 
> Then the driver became clever in:
> 
>    commit 1aa1243c339d4c902c0f9c1ced45742729a86e6a
>    Author: Michal Simek <michal.simek@amd.com>
>    Date:   Mon Feb 24 14:56:32 2014 +0100
> 
>        microblaze: Make intc driver endian aware
> 
>        Detect endianess directly on the hardware and use
>        ioread/iowrite functions.
> 
>    +static void intc_write32(u32 val, void __iomem *addr)
>    +{
>    +       iowrite32(val, addr);
>    +}
>    +
>    +static void intc_write32_be(u32 val, void __iomem *addr)
>    +{
>    +       iowrite32be(val, addr);
>    +}
> 
> @@ -140,17 +163,25 @@ static int __init xilinx_intc_of_init(struct device_node 
> *intc,
> 
>    +       write_fn = intc_write32;
>    +       read_fn = intc_read32;
>    +
>            /*
>             * Disable all external interrupts until they are
>             * explicity requested.
>             */
>    -       out_be32(intc_baseaddr + IER, 0);
>    +       write_fn(0, intc_baseaddr + IER);
> 
>            /* Acknowledge any pending interrupts just in case. */
>    -       out_be32(intc_baseaddr + IAR, 0xffffffff);
>    +       write_fn(0xffffffff, intc_baseaddr + IAR);
> 
>            /* Turn on the Master Enable. */
>    -       out_be32(intc_baseaddr + MER, MER_HIE | MER_ME);
>    +       write_fn(MER_HIE | MER_ME, intc_baseaddr + MER);
>    +       if (!(read_fn(intc_baseaddr + MER) & (MER_HIE | MER_ME))) {
>    +               write_fn = intc_write32_be;
>    +               read_fn = intc_read32_be;
>    +               write_fn(MER_HIE | MER_ME, intc_baseaddr + MER);
>    +       }
> 
> Interestingly little endianness became the default, although
> the driver detect it on init.
> 
> This is from 2014, maybe to work with the "LogiCORE IP AXI INTC"
> you mentioned, which spec date is 2013.
> 
> Indeed when forcing different endianness [*], the Linux kernel used
> in our tests (tests/functional/test_microblaze*) does the check
> and ends up using the correct INTC endianness:
> 
> LE CPU, LE INTC model
> pic_write addr=8 val=0
> pic_write addr=c val=ffffffff
> pic_write addr=1c val=3           <- LE
> pic_read 1c=3
> pic_write addr=c val=1
> pic_write addr=10 val=1
> pic_read 18=0
> 
> LE CPU, BE INTC model
> pic_write addr=8 val=0
> pic_write addr=c val=ffffffff
> pic_write addr=1c val=3000000     <- LE test
> pic_read 1c=0
> pic_write addr=1c val=3           <- BE
> pic_write addr=c val=1
> pic_write addr=10 val=1
> pic_read 18=0
> 
> BE CPU, BE INTC model
> pic_write addr=8 val=0
> pic_write addr=c val=ffffffff
> pic_write addr=1c val=3000000     <- LE test
> pic_read 1c=0
> pic_write addr=1c val=3           <- BE
> pic_write addr=c val=1
> pic_write addr=10 val=1
> pic_read 18=0
> 
> BE CPU, LE INTC model
> pic_write addr=8 val=0
> pic_write addr=c val=ffffffff
> pic_write addr=1c val=3           <- LE
> pic_read 1c=3
> pic_write addr=c val=1
> pic_write addr=10 val=1
> pic_read 18=0
> 
> 
> IMHO this patch behavior is correct. Besides, I don't expect
> firmwares to be as clever as Linux.
> 
>> Can we have add property to select the endianess?
>> For the Xilinx use-cases I think it may be a good idea to default it
>> to little endian and have the big-endian machines explicitly set it.
> 
> What you suggested is implemented in v3:
> https://lore.kernel.org/qemu-devel/20241108154317.12129-4-philmd@linaro.org/
> but after the analysis, I wonder if it isn't safer to not
> make the endianness configurable, but expose as 2 models:
> - xlnx,xps_intc (2010) in BE
> - xlnx,axi_intc (2013) in LE

It is a little bit more complicated.
In past everything started as big endian on OPB bus. Then PLB bus still big 
endian and then AXI came and things have been moved to little endian.
That's from bus perspective.

 From CPU perspective itself till AXI microblaze was big endian only. With AXI 
cpu started to be by default little endian but still today you can still 
configured cpu to be big endian (C_ENDIANNESS config) with using AXI bus.

Truth is that I am not aware about anybody configuring MB to big endian and we 
are on AXI for quite a long time. There is still code in Linux kernel for it but 
I can't see any reason to keep it around. I don't think that make sense to keep 
big endian configurations alive at all.

Thanks,
Michal








