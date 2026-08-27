Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4ACFC61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzXQk-00033k-3j; Thu, 27 Aug 2026 06:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wzXQi-00033U-K5; Thu, 27 Aug 2026 06:33:56 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wzXQg-000601-Rw; Thu, 27 Aug 2026 06:33:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y0gYx7iZJuezmZoHXJupJMamSdHe/hQN4RFGcKYPRcYdVdSldx+OvZIv8CIRGFWyIOh2/iiGXtevfuIxV3ZBzKSaqGZKApepETMdJ0LoVmCqLoB/f5rfIdu1LPDfW+gpIkdCFBRQazlGUmzV39CVH6101E2VqNWq5A9lhP0TTmF9fopZ0y+NqO6TqD4dB2rrUpB+25dt/99OqYIMsXaoJSIYlDO7GHIQx3U/uPVRwLgqTP4ttQwbPbVMCn5patDkjZP2uID+KoJLu6p1AnOa6bPnfo79Cu9eq3mwwUWpR/VbmBPxJo2SBN0NUAt/6rAu05XV6mk4Y/Mmr9z1jXqjEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1r0RZFNGZdZOzXAKuBBkwW3DVC0jHRMcgjWiIC3UfKw=;
 b=rk2HPorzKFuAWVtPbA0g7eHckYSnWT6i1A0BLLC2tX++uLqenLvZ6EXx4bqTcgWAxNU6D0m5ONq3YmEuD2pMNfg7xLXMOJpeK28dWY5Mb12481hyyLhteVN1eWWcT5hvbsyrtIyeFN6WH9qN8aGwG02ne7SyjxkAAtYEgqxzn17Q27SM+o2gMNbxOUmffDsYaxU2vA5axgTZ0WObFYuEzYrzdu51OaOGG/K7VE3IQOaVm4YqBY7cHFmV8V8AyT6O+NxL0IBc/PrbSrhhW+Uz7vwTWdcgkxm7IPzvZW5kgkuloACs/orgTdCZ/KbBj4T02wAGNBU5juYsurrthUaRwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1r0RZFNGZdZOzXAKuBBkwW3DVC0jHRMcgjWiIC3UfKw=;
 b=U6BjTGisXOdhCT7hZ3zdfNfp33N0ANc5VOseXCIOTmcoiVc7bH/tviZ9AXfz9O/FFPksw9LBiwAD2SVdluMUGpkg3JcAvhSRSmfcDz+g6jIj7eeG/B4vyeg6N/4Qargv2lsB+pr87nTJryGYKLTPE7aZYluqfhvLqx38Zp5inn7YN2bh2GGn/Ifkp8yT0W+AGdH5hZiMErQh/wiVcgY7jO3baR/695gQbLt+qOWCwVABZWAOTW4jO6x8wXR9Gnv8wxpjmQjtZdioG6rdtnaAn0VSq40OwH5Ejl/u23IAttvTF0p+TZoXWtmxobYPlFFza1Od/sh2ViosdR43YMihuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by DM6PR18MB3570.namprd18.prod.outlook.com (2603:10b6:5:2ab::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.9; Thu, 27 Aug
 2026 10:33:49 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 10:33:49 +0000
Message-ID: <9ba5f4fb-2a78-4864-a0a9-7c5a803df8fc@axiado.com>
Date: Thu, 27 Aug 2026 18:33:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] Add Axiado SoC AX3005 and EVB
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 163wangjack@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260826074635.2850931-1-kchiu@axiado.com>
 <a665849f-3b20-4ad3-a35b-02259e882628@oss.qualcomm.com>
 <c15422ab-6a58-45b8-8df6-b2f54e0620cf@axiado.com>
 <CAFEAcA_2GiDUY36TAEk3OhJfJLLDkQja-A=x9UTFGeHAP86t7g@mail.gmail.com>
Content-Language: en-US
From: Kuan-Jui Chiu <kchiu@axiado.com>
In-Reply-To: <CAFEAcA_2GiDUY36TAEk3OhJfJLLDkQja-A=x9UTFGeHAP86t7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0010.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::19) To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|DM6PR18MB3570:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f48550-9f1e-4c32-f90b-08df0426ae31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|4143699003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: WapNMGRv7J5KqMkjjWzMEUjDxATtg/vtgYddRuUwZ4oxdzwe9kjebK0ss/MGyKZW1HJurmYVgXIOS5DsOtXLJyhs3QClaBfbqlwuALjP5I8nLdnqPZqTBvM/JF1TxhLHr5gbRJ/pD+xaRVyLpqFGZbsia0EA+YtclIQTkIUokk22HeJ+sHB7q7fvQSY0RYA2Fm/UoIHyXbFelxSB8E6Kjcr9gtKPddTMBa99qqGcJjhMkkI+bxczEJ5571pBfMWARoTKQP0CkK4JqLADiHFXXtjk+QX7/Qsrk1Ot1oh0EQC6KnJYZWGiTt9SdQ933qPZDla/oBWfbAMfnrWRUWeubGHamQac5V+YkvZPUhqd/HOZjUOb8sz+7fs2/qg527j4Ae84TkU1rR3q0z+a4Fsx3cMFICNRbW5s2XmGjlSRaUEMa5SnJYyOgLS+rDgWu3QVgGvF5nONh6ObEBQPBTnf4UXsWDXuuCTBT4fvKyotQp2GB/1CxZ6BOBADFxJ2Kk4B4Mp/SIPL1xmVnJ47BVQhIXVc+EwxCz8dHjgJ5cCcKcPl2JTbtd2U3ckzqUEZJuBzASmo4lZcEbhYHx6Xd3T9uCcJWVwhMeuFngdumRRIJ79Z6b2PUZILyrBWqYp6Vyai0Mh0igMxdFWuWwtVn2qaZdjTQpdKAd6HFY+q3HnyPGU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(4143699003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enV5S2dIY3NlMExTb2o2VmdQK3pyZ0JzR3ltKzltRVhNTGhMZ3dMdG5sTVRm?=
 =?utf-8?B?Q0pGVlN6VTZlRUJBTndESzZHb3QvV2hCS21EOVhJVXJkWnl4aVVtc0hVVE90?=
 =?utf-8?B?bUVDRnpJQ0lpOGExTjIwRWJBUkw0NzF4V1FVZDJ4TEJmYkZmQS9PSFJ0WGhI?=
 =?utf-8?B?MXRkNTBSZUI5YWNkVkN5QXhuVWxhQTFkMEliWnJpSGlzS1BxdFB6TzV6Z0Nx?=
 =?utf-8?B?R2kvTWs3K3Y4L0tEN2pHaDZGUXYyenVFL0k2MzJ4bVhUcXk3TC9lbUxGZ0hL?=
 =?utf-8?B?ZzJuWXZ4UnhiT09hcXRQaVlTTGpKV1R6TEFJeU5tSWFzMUJVVE5aSUJGNHNI?=
 =?utf-8?B?QXVTU3NZd1JpaU51aXJ0TmR5c3o1Tk9ZWDlHWDAxUTM2YlNVS0oxUzQwZmxa?=
 =?utf-8?B?K3pMc3VtVHBoU1hBVXptLzZELzE3OUJYd2hsMTVsODdyd0dBS0FSZHZGUWph?=
 =?utf-8?B?K1cyb01LQ0U0T256M2ROVG5maHQvVmFuQmZJMXZYQlB0RnBVVFNZMWFkZW5h?=
 =?utf-8?B?ZVhDZFg4RldzUDh1VHB4NEZNL1UxOTg3bU1NTzdHVmNnd3I0UEJTN0FNbWJ2?=
 =?utf-8?B?Um4zMjc5dmFJV1craHl2UXg1dUtPeXNYZUNYVEZDU2sxOFFlUERyaVN3Ry9Y?=
 =?utf-8?B?V2hoRS9vWmMvNWxqN1hMYU5VbkswWG1XeG1tc0h6MERzYjBEYVozekZWRkxK?=
 =?utf-8?B?YmdjOTF2eTJUdU1uai9hRWcvYjVnZmhGVkxqcTQ4ZXlIUWtsQ0NZbnRHOGZV?=
 =?utf-8?B?dVNleHl3TWl2R1pBQUNMRy9NV2Q2TXJQMDRqUlIrV1VCbEkrWHNkRU5HeGRG?=
 =?utf-8?B?NVhMdUZEVWxRNXhOSnR0N0tWdUllYkZraDBDcWh3RGo0aTZlU3RqcTA5ZzVQ?=
 =?utf-8?B?dkE0cWsxUnV6Kzh0MHFwbzlhdEpqa0M5VGdDQjFnaDl0VGM0Sm14Vk52R0JJ?=
 =?utf-8?B?eVRtUEdNVlZQU1dsbWNnNEVsQzk5Y05DZlF2UEJoQ3NtT1VrRm1kRmVYM0hk?=
 =?utf-8?B?U1RDQXF1U1BNOTBReVVDRDZTOHZzcXVZZ1BEV3YxOUlCVThsVUZjSUdpWUJl?=
 =?utf-8?B?S1hkeFlOa2w3VWdGSDlXZDkxUTQ1RXhIV0xsQ2hpS0Z2TnQxQW1kM085QWJK?=
 =?utf-8?B?aGF4bFQ5cndCT2hQWWJsYW4xbzZOZVRhSVV3Q3NVTmVuY2d6cUF0TGc3RFhz?=
 =?utf-8?B?MGI3QkUxbkRYMVg3b1NKNTRRWXVNbndOWVZ6bC9sN3FhdmlnUitRem9iR1BT?=
 =?utf-8?B?ekdFcHVkSm1TSkdsM2ZlYS8yRzZIT2JlOG9XN2hVV0dzUDZBRmplWmxmcHlT?=
 =?utf-8?B?SDZkVTBScGNHZHgyZk1xdHNFUTNnRkowZitZMzNnNUVpS0JQRDNBTmF4TE52?=
 =?utf-8?B?Y2gxbUgwN01ZZUQrRFNZWi9JT1dqUVpIZ0dtMWhIbVJyN1NoL09oNURhT0ZN?=
 =?utf-8?B?QXYzQ0cySlVabHIzT2g4SEtIT0I5amlkODdsNnlGTEpxNUZsMTNDMW5Kdk5s?=
 =?utf-8?B?cjVYaUFvYTJTSERla0FRcmMwaVUxL1l3TFJGM1BTWmt1NTluSnFFenhGaEYy?=
 =?utf-8?B?alptdXhOb1R4bUc1VHR3eWNlSWJ3RHUyejd0Z2pVYm92QVBHcVVzSG1TVlV6?=
 =?utf-8?B?b0tVWWdnd3kxbFNoZXR5MStDazVMSlJvVTJDZ1RSKzRYdUJjUmFKUGVaMlRx?=
 =?utf-8?B?WkRXY0pGKzJkMkI3R3BlV3RVMTk2bk9XNW1KZXFzMVc3bWErMkJvaGUraDdZ?=
 =?utf-8?B?eFh6R1l6b1dKWGtPOVk2Zm84QmdPeUhsNXphU2tHdzh4L0JqZTNzNDZTQWk3?=
 =?utf-8?B?am5ieGQyRjRGNi91OFk4QXFJRTQ3aFVSWWgxMTdBSklYeEpZMGdweGZpd1Jp?=
 =?utf-8?B?VUxDT1NUZG5MK2lBZU1uR2lUam9MMTc4QUQzWTN3eXVoVHhtdnZTaTNHTVB6?=
 =?utf-8?B?NDE3RXBVVHBIMUFQUVdLMGRUUHlOVzJiNVdiOEYwa2g0WDU4TWV4Sm95QnYw?=
 =?utf-8?B?VmVDT0Z6am92ZjN1a1gyRmovckhjN2cvVkE2TVZlTTM3a3lwOS8zeENJRjNF?=
 =?utf-8?B?bjFTTWJVK0lSYlVSVTlVUmZKb1Fhc0kzSzVjQy9LZEpaYWpxYit1R1c4QmRs?=
 =?utf-8?B?UlAxTkRvRUM5YWovVVllQUpCeUVkcFpjSUtNcUthT3FXNjdKWnpEQklpWk4w?=
 =?utf-8?B?OXcwdDZwaU55NE1mb2NnWi8rK1JaeHVPYXVKRW5rOFhoWFJvNERBeEZZNEV0?=
 =?utf-8?B?REs5QnMwTFRvTFFxWFRha2pJdVBjTENJTllUZlIwUnNtMndRS1F5Wm5pTWZR?=
 =?utf-8?B?WDMxNTB5cmsvTlh3eDRVVlR5djJTM3QvN29sYVJiOW9XNlhQeXZrQT09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f48550-9f1e-4c32-f90b-08df0426ae31
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 10:33:49.0780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3OdMibO4jShU40SRy4ufbgLb4ijlBgcf/kQLrsdqxbr1kZcryiZNmwLm1Zg56QDSQ9Nl/pPbwTumR7TOnJ8TsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3570
Received-SPF: pass client-ip=2a01:111:f403:c111::5;
 envelope-from=kchiu@axiado.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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


Peter Maydell 於 2026/8/27 下午 04:43 寫道:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> On Thu, 27 Aug 2026 at 07:39, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>> Hi
>>
>> Philippe Mathieu-Daudé 於 2026/8/26 下午 04:18 寫道:
>>> Could you add a functional test? See:
>>>
>>> $ git grep -l obmc tests
>>> tests/functional/arm/test_aspeed_anacapa.py
>>> tests/functional/arm/test_aspeed_ast2500_sdk.py
>>> tests/functional/arm/test_aspeed_ast2500_sdk_515.py
>>> tests/functional/arm/test_aspeed_bletchley.py
>>> tests/functional/arm/test_aspeed_catalina.py
>>> tests/functional/arm/test_aspeed_gb200nvl_bmc.py
>>> tests/functional/arm/test_aspeed_palmetto.py
>>> tests/functional/arm/test_aspeed_romulus.py
>>> tests/functional/arm/test_aspeed_witherspoon.py
>>> tests/functional/arm/test_quanta_gsj.py
>>>
>> Please allow me to add functional test cases in another patch set
>> because we did not release firmware package on our Github for
>> downloading yet.
> Can we get a functional test for the machine model you've
> already landed before we add more machines in this family, please?
>
> -- PMM

Let me try to release a firmware package for QEMU first then I can 
create a functional test for Ax3000/Ax3005 machines with it

B.R.

Howard


