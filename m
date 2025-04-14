Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA84C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 09:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4GS7-0008Mz-4K; Mon, 14 Apr 2025 05:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1u4GRY-0008Ed-BJ; Mon, 14 Apr 2025 05:49:33 -0400
Received: from mail-westeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c201::5] helo=AS8PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1u4GRV-000173-Ak; Mon, 14 Apr 2025 05:49:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=joE+FALMGMsdrWzbkjXwiw3WromZbNvjzc6UDeRVWp/l1m1OVedWE7Eut63b3QQcWOgKORUN5Pv/sPg2WgA3l9ikUmslPy/fhvmITxLEgP2GPnkvW+WiCn9mUas1in4hmWeaVwRLeayASeaS7m4EfcC8dyQNs7W8WD8Z01AAIV95Gnh+53VxxiJ3ryie/o6TIyut4b76auPeSqUUlF334iZOX9OltYWXv8gUpy4lyEQxvYrXGMTcvXn5mN65ZBIuijxDZb9CiAcMCfLYqOV+ucrj2rs7ZBeCAZmYvrv1bVexlhiYr7xAKUVET6z3Fs8IaauyqqqvuYywh+6MYOgkuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUbEY/asJe+10s9SbdwfpP8LoQ1yhVcY6iCzqabcabw=;
 b=Xrn6WbUf3FRRfwaASpmTlByDaeBGaKMr2Eovil4q+JfXUOD51CZyuqs2B8oTKFGAuLOc8Woh8yBPTUqFYjjubFzF2wT9UCwE4K0UuDKtMCe21wn/7dR6EpAkeqCb+T9ojtWGUTzS5aK1TaAmOQhBSUy2BQdqJ4eiBYg2OCMy9tZyMPWNg0Y1fMtVL5jAfIHBzxtDNRS0ZklOG6iVwiT/L2uvA7CbG1HDoSihyuDtcmpRiep3HZHHvkcTa3LES/sQVNJfHrSs92r9sbJh2hEdoUG03/+GIHUAP7w4KDmB3brOzC/QwMS5C+52xvQiXrrIlWpwZHRW/8Y1XZx8+L4etQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUbEY/asJe+10s9SbdwfpP8LoQ1yhVcY6iCzqabcabw=;
 b=dVL23m/5Hcr725hFepZcsJcqiYQfDYqftUwjJE5ugnSkatV+/6r7H4k0RS+YuSv9uo3RUcxwxyemt2SBA9430XcyUvTPAaBenI4U3FN3h1tq2CWuBnf/rXl49M3b35ByF2n/E+qTX7rnS0rg8/BVgd/oiXwlAbBjPOr5K4wnPByqdFOv2JTeM4bHQ6eNAhlZ+cPblGanS1czrCyjN26wKg6Owql3KMyyFzx8KemQqHLDMo+VLsdYXPFCgvDeZlWtdtli86UiUTi3GS/qiOHbC+5NI58kqetLmfp4ULtApiv2kj/d036K9E3zbYAIS+2scr7D7uBOByVPGChAvgMZNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB9065.eurprd08.prod.outlook.com
 (2603:10a6:102:332::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 09:49:20 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%5]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 09:49:20 +0000
Message-ID: <6ff6a752-20ca-40ef-b4f1-e44c8b2185c4@virtuozzo.com>
Date: Mon, 14 Apr 2025 12:47:59 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] iotests/common.rc: add disk_usage function
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, stefanha@redhat.com, berto@igalia.com, den@virtuozzo.com
References: <20240913163942.423050-1-andrey.drobyshev@virtuozzo.com>
 <20240913163942.423050-6-andrey.drobyshev@virtuozzo.com>
 <v4yhrtllsena44jkk2qffsqf6gd4zlyxrhfjzsgva6jwazvkgv@t3xb7futfgpo>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <v4yhrtllsena44jkk2qffsqf6gd4zlyxrhfjzsgva6jwazvkgv@t3xb7futfgpo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::11) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAWPR08MB9065:EE_
X-MS-Office365-Filtering-Correlation-Id: 45e4569a-a37a-4aa0-d977-08dd7b39a0c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHJvVmROVTc5ZmJNVHhHK3MySGpuZmpoa2lEUC9uVFJIbnFSZDM3TU93Uita?=
 =?utf-8?B?RUFmRDdNSnZUQTc5aUFqVEt5ZERIU2NNaXlsbUtKTGljNFpseDNDVWhaUytU?=
 =?utf-8?B?bkpZU0Z1Q3VIT1lYQUgyWEEwTEdCYlVMN0ZlZGdjV0pqUnpiTkdCM2MvbDZZ?=
 =?utf-8?B?OUx1cHZCOEpEQ0orejE3MDc4Q1Y2aVlNQW43N0NEQnNEeHdIM2w1TGZMbUc0?=
 =?utf-8?B?bjJHbUlyenRYaWFOZWp2clAyZVV3NnZLeHdpamQzZlo2NEpCTVp6L2Y1NFZi?=
 =?utf-8?B?VHI1cnhHTEhneTBCRVg3ekZxdDRoTEtwSDJKcGUyNTY1YlJGUloyV3RJL0d0?=
 =?utf-8?B?UWVOcExyME5EL0NxVTcxOXR5eXc4WHdZcWlIcDF4dmg3SnhGQmRqN3BKMUFG?=
 =?utf-8?B?TUdlQnJsTDg3a0RyTCtIWkcyczJWeXJXQTB1bklqcTRIZlBzTlo1OEJWc2Z5?=
 =?utf-8?B?K1pWalJpaDJqWHNDdzNGY0J6VlFKaVZjbjdBbVhFQmt4OVAzQjYxUS9GZkRZ?=
 =?utf-8?B?SVpVVjNsbmFKWlVmQTBSOExseGNuTHdnVllqekdHbTRUeVR1QnhzcWVwRlpE?=
 =?utf-8?B?ZFhwOTRCS0lwMUNFVlVrOHhnQytUNmpqemozazVPR1hESVBpOEhrbThmMGtX?=
 =?utf-8?B?NDZwTlBtd2VFc2h0L2NFenk3NWxZUmFYZnNUMDZRR1JQK0t4T0ZUajIySW1X?=
 =?utf-8?B?ZllYS3lJaWJSLytwRWQ4Njl0QlNXNGVQYTZGQ0toMkRoQWhWdnNuK0VLeXN3?=
 =?utf-8?B?dGFnamRQdksvS2lRVGZldkRFbGM2T2dsVi9GbGxrSENaOUg1VHFUZHJkRE9j?=
 =?utf-8?B?QTljTU1Mamp5U1ZwamJwbE1QeXExR3VYQVlVS0c5eEhONXZPRWNZQXhIN2JF?=
 =?utf-8?B?anVoQU1XYXNRODlFZmR0ZjdJcFUyb0xqN2RXMzM4VkVZcExVM3UreWVqbmtG?=
 =?utf-8?B?ejNNYWFJWDRDY2dOS04vVFBxbGMrYjBiUml6YkdxSjlGTEUrNFRxdzJ6V0No?=
 =?utf-8?B?SWJBdGQ3VUNCNGRxcEdRdUlnRjZwSmU1YlJJRVphQ3NBc2xCSTQ1cFcxekFK?=
 =?utf-8?B?c3M3T3pqOVFRejIxeHpCTGlKbzhRK0QxZFErTlpubWVGQ3dyOUtiUkRUalhN?=
 =?utf-8?B?K0JOS05zK2RHNUE0ZnBtczRzUkhTNzF6dHl2NWNjL2JOejFhNGN0NFZ1cnlu?=
 =?utf-8?B?SGNTVUNhOTdFdFRWMUZ0UVo0eHV5bjdBZGZITzRqam9sL0RlVktPbVpLMC9j?=
 =?utf-8?B?ZkpLYjVoYTlNR0ZJWlJvdTJJUFpvMnhlL1VqYlI5T0hCVE1pWFNDRzNiNFpG?=
 =?utf-8?B?R0JQbHRWZFNkYmtibUlnME5EcStXYmFDckVTS3Z1bDRRZm5kN2t4M3pwRnFE?=
 =?utf-8?B?a0RkNEE3cTBlaGhCOE9yWlZjNTA0R3R3OFRRbUoyM3JjSlJyOWtHWjRzRjZ0?=
 =?utf-8?B?K3c5UndlMGF0UDRlT2U3MkxPdUpWVDllZ2ordDFmNjRIeGtGZGZGUWxCVjRn?=
 =?utf-8?B?KyszZHJYWElaOGxqTmJ1bjJEVEhwblJqd1pjdEpKSkQ1UGRDa3hYM2x6cXN3?=
 =?utf-8?B?b3J3aVg1NUdQcm1MbEpZUWRnYnQ5ZFpqcExNZ01oUjVnaTczTEY1eU9RWHlm?=
 =?utf-8?B?dGNpclNmdEhZZ0g2dGdEVGk5SXJ4YW1pdWxaQUJhSGc3WlJmcFNBTEZaQXdU?=
 =?utf-8?B?azRSZUpOT2dpbTFGZ2xpclNOQ1piZDlxQVR5bG4xVEUzUE5kbEtDdDM3NSsy?=
 =?utf-8?B?akJWdWV2MFZQWmRiTGxzeEp4MUtXcHNVN043bGRySGkyN1NuM1d0RkdYdzVN?=
 =?utf-8?B?MXFmeFByMkZwOE14NVJwNGZjMXdRdGlvNzRzd0s4blJMSTVWVFo2RDdKR3Q4?=
 =?utf-8?B?YU0zREpmYnpoUy9QMDYzeVg3UE5ybDkxWFIwc1ZMNk03ak1uL1FZckN1VXNQ?=
 =?utf-8?Q?VgoGVSL1jkg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MURyZUJIOGVYbnpQMEZLNndPeGI1TnFkR2lzWjRIZVJQQWRtL0cwbGZCU0Zo?=
 =?utf-8?B?bWIwcFNNUFdzdmUySzlpRzBkSkxlZnJtQmFXNk16NmZuWWxiQzhUZ1JXZHRu?=
 =?utf-8?B?aGpiN083MmtXWlIzQWl6azRRbFRiK25hSUVoOXNNc2ZjK2Jack1SeTFCbGVa?=
 =?utf-8?B?UlZKZkRFMXMrK3c5NWxXcWRkSTAvR3ozVXRRUFF2NTR1WGRDQjAyc08rTWJk?=
 =?utf-8?B?MERjNHEzTGtnZ1FHMFhscGh3dzloV0tzUnhCN3NBL2IyRnhQYXVsZ0FvYVVI?=
 =?utf-8?B?MDY4RDFRZDRibkFMbCtxcm92aGtWMU9IYTg4bTRFT2NmV3V3dEJHQlFldjdV?=
 =?utf-8?B?aCtJUlVtWnZIdmkvb05qSitFUmhVOGpDaWlBYUtzdktSOTJZRUVGSnQ4YVhD?=
 =?utf-8?B?VytUMENIWVI0TDFnVjY5aksxNTlXMXBZaTF5M2d1d1k5V3IxQk5pS2IyNlpp?=
 =?utf-8?B?WU9IVTJQK081MlAzNFhWendFeTdGb0RCVzdjNitaS29nZXhObTNpUlRDby9i?=
 =?utf-8?B?VGFoVTJLcTNXMzM1UEgvc3gxVkQrb3I3Y1RDeWRpYzU1MC9WUEV5MC9LMjdi?=
 =?utf-8?B?TGI2STlXY1lEdnBqZGZxS1BGTklCd2RIaFAzL1JKaTRVYmo2Z1IrVjNtakdM?=
 =?utf-8?B?UWt5S3N4ampzekxVdXI1ZlJsMEZjeDBpQTU5NDhCYi9JZ1BYc3I1UjF0ZE83?=
 =?utf-8?B?REhUMjc1bWUyTmdsNC9Na0RBejlwUUE2MTA4NktVY2l5TGZlTWgrbXA2aXJs?=
 =?utf-8?B?R2h0ODF0VVo2SlIvL3ZrS3NILytnMkNiUTQzNG54OS9ZenF2YUNORGhjcGN2?=
 =?utf-8?B?QXJIUmZjSEU4bDRYT2E5ci8vaUFFT1FsL3lTR3g4Ykl6ODExMEFzUW1HbWs4?=
 =?utf-8?B?ZlJTQnFTZzY0bm9pY3dTejdVS0M3aGoxbVFZOW5HMTNHcVBGQ3VtNm00L1lG?=
 =?utf-8?B?cTVhcnBLTzFucTdPMG5ESE1sdmdnWlJxZ3VsZXVQcTJoTEFZV3JPbTdDUU0w?=
 =?utf-8?B?cjdpYXV6d0pWVGNvUzdkTHE5dzZ4Ym5lUGhwelRhcXFFVE9Fd2IzTXhVRmU2?=
 =?utf-8?B?S1ZFaHhJRUVTbUVOYUtTa3Z0bFRoY0IyYmo0MjJ3TGxMVWlmUENpZlo1SFN5?=
 =?utf-8?B?bXB6aUdNaE1HNEg0U3o4VDk1SW5sVHlBc2hPM2RVVUhzZ1VmZnRudDBzaUo4?=
 =?utf-8?B?RDJEdTZpcEFVRWcyR2ovQmU3R1BWdm5sRCtUZUpuRFJ0RkhDbUlCTUNndUdj?=
 =?utf-8?B?QVJTM3o5b1Z2LzkrMjlUZHg4VHpHb0ZmT0k5aVhFS0habDBSWmFGQ2EzUHpK?=
 =?utf-8?B?NFpJdVRSMXRkajZaK1pRN2ZiMllrSkQxY3M4N0VJSGJVbEtNU0NuL1Y3cXYz?=
 =?utf-8?B?VzkvWExTQ2g1VjN1NnljeVdIRGRUVVFNMTJCaWM4M3BhSDh6RHh4c2lQSW1Q?=
 =?utf-8?B?WkVnaW1wZm9XM3FFQ0JWc2dWV1FBYWFqUEtQSytLdXJ3a2xTN2xidmxML2lz?=
 =?utf-8?B?NUd0cm11enFxTHlhS0dwRnlMR2QyT0V2a3BQMzRTYUF1TUdUUWl4b01FOVZP?=
 =?utf-8?B?c2RUVFkrb2NtdlFDUUR0NGIzYWtVZ0RQcjRlKzQ5clg3SFYxdFJCYnhMeUly?=
 =?utf-8?B?Y0NhVmhYdXR1SUhkT3ArMDZFRU1rekZzRFZSSDVOa0l5OXV5b2JNL2pBTDRn?=
 =?utf-8?B?bm14RFRmdk5neDVCNUlsZGRQUEVjbU5LdGVVVXRtSENPaUllTU1oYVhPekxo?=
 =?utf-8?B?dXRjV3lsUG5aS1k0bkJqU0xTY3VieDUrTGJ3UUNkR0VuemhGVG5nQVR1bThk?=
 =?utf-8?B?Qk1OL3grS1pYN3ptZmY4ZGlnR3pIUld2TXN6QWFVV1JZUlVNSUtyL0tONzRH?=
 =?utf-8?B?c2dHdWg3MnJvdmVnem5sR1lsbmRBNzZMaC96L25nSlpRWjFGRmlQUzE1aWlo?=
 =?utf-8?B?WDk5aUNkOVY3RUxmcmpSdTFqYkhqbUlwMlhjc2IrbW1HLzVCWmRWNHNpa3Fs?=
 =?utf-8?B?bk5OR2xDZ2o2NW9kZUdyNzFJV1ptWmhpVFppbzB6bmdwanQ0Qi9NWlRHOENX?=
 =?utf-8?B?N0VCb05KeS9hcmhwdTdwNGZsQm9IREVaSUtKa1VvUEd4SVhBUTNzSTNjRE9T?=
 =?utf-8?B?UTNtbUdwSTR1d2FhNnVFalpzTHdIQnNHa3Z0RXpvOEF5dC9vVi9waXNKQXk3?=
 =?utf-8?B?VXc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e4569a-a37a-4aa0-d977-08dd7b39a0c3
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 09:49:19.9263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNBn+TBfdRkCQl/kz1Wyx6ZHh9GE1YniLGa+vr8ncZPz4C8IiGP70gdba2ZPxwsyfloMeLXlisJvnGE1d3Oe0Jh4ZHUIvRrkJOzsYLGcFwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9065
Received-SPF: pass client-ip=2a01:111:f403:c201::5;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AS8PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/11/25 8:48 PM, Eric Blake wrote:
> On Fri, Sep 13, 2024 at 07:39:35PM +0300, Andrey Drobyshev wrote:
>> Move the definition from iotests/250 to common.rc.  This is used to
>> detect real disk usage of sparse files.  In particular, we want to use
>> it for checking subclusters-based discards.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>> ---
>>  tests/qemu-iotests/250       | 5 -----
>>  tests/qemu-iotests/common.rc | 6 ++++++
>>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> Hmm - I should probably refactor my recent blockdev-mirror sparse test
> to take advantage of this as well.
> https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg01799.html
> 

Sure, though it'd apparently be easier to use when this series gets
finally merged :)

It's been hanging out there for quite a while now, and it's been neither
rejected, nor fully reviewed:

v1:
https://lore.kernel.org/all/20231020215622.789260-1-andrey.drobyshev@virtuozzo.com/
v2:
https://lore.kernel.org/all/20240513063203.113911-1-andrey.drobyshev@virtuozzo.com/
v3:
https://lore.kernel.org/all/20240913163942.423050-1-andrey.drobyshev@virtuozzo.com/

Could somebody please take yet another look at this?  Maybe
@Hanna, @Kevin, @Alberto?  Of course I might need to rebase it to the
latest master.

Andrey

