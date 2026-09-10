Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E905DC88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4aJw-0006Bd-CL; Thu, 10 Sep 2026 04:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x4aJu-0006B3-G3; Thu, 10 Sep 2026 04:39:46 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x4aJs-0006fy-6B; Thu, 10 Sep 2026 04:39:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=no+9+VjVRNdboXeVdCALgzZTXFnDe4aeKR+spGL2lyljsohNzEjfHAb4YJgAdD1T1z5qxyhnY1g/8bgPUodSmIKwZc/mewESSMYKMvd4yYld9se7fgWko3RA0sjZgW5cr5LQzzj5COFwxZhZ1CSbsxHQfgzb11G+WQjjWwVow4yw948Omlh+gFRU43FUTfv1aPWMQwA7bzU6NlqiUZGs176v8Xvn1jsNDWmvhnf4QXyXytzkhEMQrL9hqygxNmh1XykWK9JR6fTMgeYYjsJh/rRP249Ah/l94cXt8Pi33obcMFuBN8mDzNpsFGNLcQ4Hy+2/vNnq0FhooTnyrXut9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYoBk8Sb4bdYh/XnIeF/4Zu9HQ233UgEUXErMj4MgxU=;
 b=pvtlszFFghEsUI+ZyhgNVTTI0dQ90KSRVphDXyOM4qSIZshzhBFXpSWm8+MhLkQMDaGt1dZdqmD4lxbS7N9LYP7pNy5qZyF16QblMWp4E7WIPumIy3T3qKtLPYengv+b9WUXRS3NdEzTZzqsM6cO3Nu+55F1g5sRuo4aIi7wEdetGpMYCzqqnWuCyYfwzN2GxmnWPReqwX4eTX1AP5v5ia9DfMbmpj7nA1nKH6hmygLKmXydio05x3JUuYxLBjex3IBnkJCbiTiFjNTm3RzkoiR9FELkv1eYY1bL9cNVg8lHg90S0NRoJZNVSiQmHoUNdYR0prK+1ofPjrG85YaopA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYoBk8Sb4bdYh/XnIeF/4Zu9HQ233UgEUXErMj4MgxU=;
 b=X037YHHKj/0HM4P7NwUOsbXc8/GkpJPvKUX0tguL6DcoonNZXEZh6hok9P6y75BBQxnqCREADvxUDr2zZlC/9YT7FM6BZDTVg8yAy0w8JI4D9lT7mroQHESgWZoUPb+HGTXgYCYQtJu1uWXg6Jf72xpmzIoqOYqk6bQKDPJllfDWBCLouVHW18Tkdu9xrWdYEJZ0lPQwLVoGPir2erOj+oDiqnyWWAIkeyTUIM+sl2ArZLhc7wZUap/8Air3BHxbCOIxJOQTEKj4/wsjmjTxZfRjeu2TC6ed6LxkbVuZCNihJ8/sd19hl1/wsepkcxGuHqwUslhDbfNkzjvhx7RycA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DB9PR08MB7582.eurprd08.prod.outlook.com (2603:10a6:10:306::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 08:39:33 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%6]) with mapi id 15.21.0428.004; Thu, 10 Sep 2026
 08:39:33 +0000
Message-ID: <9adc681f-f20c-4ef7-8e04-2da290827a28@virtuozzo.com>
Date: Thu, 10 Sep 2026 10:39:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tests/qtest/ahci: fix a racy deadlock in the engine
 stop test
To: Fabiano Rosas <farosas@suse.de>, "Denis V. Lunev" <den@openvz.org>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
References: <20260830183534.104435-1-den@openvz.org> <87fqzi6nxz.fsf@suse.de>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <87fqzi6nxz.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIUP296CA0052.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34b::10) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DB9PR08MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: d967fa32-e788-4a95-2515-08df0f1708d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|23010399003|366016|10067099003|56012099006|5023799004|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4wvQc2BOWB0P8JyK1ii1jq5dl28u41ZR7efB1tt0+DqQ/SDxcTkfR2KaYWsIpDYtiP9FgviQcRj/rvqzaZtkmPzdBo7Oyy34SgGNaXOzNX7Povd7HWHpaBWy3kffV6MgDWs3SmB+D1uAu/rA+IyelxFk/RWBiPpcwSw2xUs0eCCyFMK66rxXm0AkEpPn3W8pvvhO9UVWch2qQ8tpEBnYBfHvY5iLlE+Owk7OhMG9/D4UUwVGdfoOvmObo3gKOjQYwrr91cYDt7gWa/BSwh5usHxt0XABaVQVcp0MUEOIl6a/Dmk04FohTFZwjw5ad+GPtZR5yrxNuJbYjOL13l9zrq4ts175bdIcsM3RC3aMfJQf9RkcQSNEjQiYJebHLdUCHzl39ZWzb2a0NIB/Tou+OyC5lrrWeHBuTL+25yNLwPmXGnbvSsZdCHXmp0EiVydGJmm56p+7hHmknMPL+NeVRIZsEP9viEUOqIY4TZYHt+L8R2IgLV1DhW6VKx/ZZNX/PeASY4Jr6IaXItlj7wThqkgS4HAv35jkMp/KU2YlgGcuyZuICZ/VVRBiCCWJ7sY3LlXeuKfEujVW11h/oAsk5v5ewxpblh8MmEBDL+WoPCdJ5SXS0f1eBDa2qMxElvjgrqgEusKACAQMf9LHlB6E57KFPERFAnsR37gXqwf2rRs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(23010399003)(366016)(10067099003)(56012099006)(5023799004)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk5sREI2R3BQTTBxL09BRURJVzFDZEgvNlY3TkxqM2FTOWNLTkZHYmxnTjQ5?=
 =?utf-8?B?YXpkekFsVjZTbUw4Z3FtZ3dPY0RMeW43MFJMdnNBWXp1YnJvYW0rM3craG9H?=
 =?utf-8?B?WEdlK2ZudW1NTWs0eTFEb0c3LytVdzc1VGw1R3FWSVlUSURSOWdCUE9YVFAy?=
 =?utf-8?B?L0hxK05LR1lQb05GTXJsVXlEWVNtZHd2Z1BOcW1XWjJZYnFiTy9CL0ZqVXA2?=
 =?utf-8?B?a3AvaHpGeC9Od2t5UkRubU83bHFHUm1zcTNqUk1ZeGpCMllYMWF4bFFHUndL?=
 =?utf-8?B?YUNTUU1vSkp3N3dFVVVLcURtK3U3dklyZks2VXZIMHNUZGJYN2RjUG5YOE5V?=
 =?utf-8?B?VCs5SnpLTkwwVTN4SitCR2Q4eWxtclpsbUI2ZUIvSnpoZ3lCd2RrUWRFZjFk?=
 =?utf-8?B?Um51azFIRDl5dGFWUVlYcjZjdXVGRFV1eklKL3ZUenpmWEZJM0tXWU15Vmda?=
 =?utf-8?B?OHhWUEZyZlJXT2V0c21UMmNqSU1XMTlNQWVVdm9MaE5DSEVYTU5ScFVPZmNy?=
 =?utf-8?B?b1FPSWVjZHpEb0xicTd2YTI1V3VtSnVqYTE2VCtYQkRib2FnelZRWktxSktn?=
 =?utf-8?B?NklIb0R3NWhUdEtqcVk3SENXc3BwMVlRdGp5L3JKdWIrd3k5OHFxbUpSb3A4?=
 =?utf-8?B?U2JDZ00wcWI1ZnM4QU12WGdVVnlVckIxRDhvR3JaTUNoVFNxZVlPRXFYL1pF?=
 =?utf-8?B?UnYzMjJ0UkVmN1Voem0wY2VDQXFaRHA3NkFIMzNoaGxaT3R6NmE3Y1VzUGZT?=
 =?utf-8?B?T2ZxbEFFS3h2a0xnZDNLUk1PdllRMWlYdWRLTXZGZE9KUHc4OHhJV1F4Z3dz?=
 =?utf-8?B?RzBqNGx2b2RRTTVDU3c5L2JHV1EwMXJmQmhSSW9NVHpsSnNqVXdSODFrUzFY?=
 =?utf-8?B?b1l6bkdUOVRuUTIvemkyeGxjQmoxR2NmcHhaSlhsRENWZWU1ZHhOekZZZUxy?=
 =?utf-8?B?VEpudlF5d1RTNlZjQzZBTExkUHMrTzFNSDJMZnhnalBidDZSQjg0Q1QvZlY1?=
 =?utf-8?B?dEh4Q0hwcS9qTjY3WGNrclYyUmh3a05mT1ZOcHNTYytjLzhOczJiS29oNmth?=
 =?utf-8?B?ZVM5VEhhcHE1ZlZBWTI1Y3NYWXR1aTdEVGRnVU1kbGhGU0RCbjRLblhYTmYy?=
 =?utf-8?B?RmJDc1M2cEdRWkh0ZUYyVjBBeTlKa3lMem1kYTRNQWVTK093YkszTGR5V2NL?=
 =?utf-8?B?Ym9LcTZMY2ZGSWZQcHNwVnd2SitvVG1tRHgrMHNVVk1GMkJCWUJCRkFNWFJX?=
 =?utf-8?B?K0dYdENRdUJTaDBjU0tOQlZkREx2NURleEdsR0xPN2g1TUxzTVd1aEMxK09Q?=
 =?utf-8?B?UFBRa3RVQmtKTlZJOUVuZGs4K0FVRk56WVIxNDROWVdiUlNDYk1kWjN0MU9v?=
 =?utf-8?B?dVVhT3lhcDNOWSs2NTA2V2hESGZoK1ZncFdWaXQ2RmU3bzVVbjVOWVAvTkVk?=
 =?utf-8?B?K3llQndZaUFKZ3A5U0p5M1FpckZkSXBYWkFSN1EyN1lxY1NxMVpGeUpHZWRV?=
 =?utf-8?B?b3dRQXdoMjdicFlVLzlzYW9iYS9LMHUrVHkzcGlyck1LV2tUaUpLcUt2MzNw?=
 =?utf-8?B?ZkNwTGJ1d3F6Y3cxcEVjZWtjNDVPaGZpSXFtNEZaa1ZYOFVjbEdud2VEVUZW?=
 =?utf-8?B?L0JreThuTS8wQkF2V3J2MWg2RStLc1hzSVA2SlNzK2hDd05PVitUckJmcUVt?=
 =?utf-8?B?T1lTVEpjZkgxaUo4RXRCVDF4ZDlLWTNJaVQ4NStLZk1aOGU2WkNtam9rY3Rh?=
 =?utf-8?B?a3oxYTdRZ0h3TjVBeU9obnYzY1FiNmxvWG95U0hwdDFWZFpSUGFzbVpnYVh4?=
 =?utf-8?B?TDYzMUZxdjd6ZmFjMmZaY3huRXVKOUNwTUlwbHJ2NTZCK2RqZjlQTC9ySnlV?=
 =?utf-8?B?RUt0QS94RGRNVWhJazBQa3hmcTNsSWZzRmhUUnI2NUxGNGJnZnM2UXpOSndV?=
 =?utf-8?B?MkkrQUJjQnhlRVUxL1ZyYVNTVHpicjU3cW5KRjJIL21zZFNWZUhLUk5nM0Zu?=
 =?utf-8?B?TE1KYWNrRk9OdjdBS0tRSUo0RWZPUnBPb1Y1KyswTHpQODI2Qk9TMEc5RFhi?=
 =?utf-8?B?ZVBPclU3SmFMRnlCaFJpWG5BQmNHT2VWdDBEVm4rSlY3SDNtSTdFcGdTVTdt?=
 =?utf-8?B?YlJOVW9CUlZKMWRneUF6UmIrYU52aHN4MVZwV0Fwcklwc0NzTzhTV013SmIw?=
 =?utf-8?B?NFhaM0RYYXVPcjFJaGVHc0VLSXdjalcza2R5cUp1YnBvRTU2K1JqbzZ4d0Q5?=
 =?utf-8?B?VDZvRUVMMTdhbTc0MFI0c2xqY1NOVjRKSmJUalhvSERPZXRrQVdyV3E3RFB5?=
 =?utf-8?B?WUJkQVdKaEVPK3ViNVl5eHNKUXh4Vis1MndQb3NvdU92cDBkdEliYXQxNGx0?=
 =?utf-8?Q?bbHYdtCanS/en/ZzmYSZk8AnArcHqtrhAQQnR8D972dQn?=
X-MS-Exchange-AntiSpam-MessageData-1: CWbc54CYIwsECA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d967fa32-e788-4a95-2515-08df0f1708d5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 08:39:33.0888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6XN6CMh0SmLTKcw3G1d9TKstUZrdjkuGdQEBWC+eg0KYdbZzeObnXToAwGyVMNqx+5N48GiQU5T/JRozQ9b55A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7582
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=den@virtuozzo.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
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

On 9/10/26 00:48, Fabiano Rosas wrote:
> "Denis V. Lunev" <den@openvz.org> writes:
>
>> From: Denis V. Lunev <den@openvz.org>
>>
>> test_write_engine_stop_in_flight() resumes the suspended backend write
>> and goes straight on to restart the command engine and read the second
>> sector back. Whether the write has retired by then is a race. While it
>> is still outstanding the drive is busy, and handle_cmd() drops a
>> command that arrives in that state instead of queueing it. Nothing
>> retries the drop, so the PxCI slot stays set and no D2H FIS is posted.
>> ahci_command_wait() polls both with no timeout, so the test deadlocks
>> until the harness kills it.
>>
>> Drain the port before issuing the read, so the abandoned write has
>> retired and the engine is idle. Host load stretches the gap between the
>> resume and the write completing, which is why the deadlock only shows
>> up on a loaded machine.
>>
>> Fixes: d05ae87e7a6a ("tests/qtest/ahci: regression test for a PIO write vs. engine stop")
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> ---
>>  tests/qtest/ahci-test.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
>> index b143862ce7..2552fa39f1 100644
>> --- a/tests/qtest/ahci-test.c
>> +++ b/tests/qtest/ahci-test.c
>> @@ -1914,6 +1914,12 @@ static void test_write_engine_stop_in_flight(void)
>>  
>>      g_free(qtest_hmp(ahci->parent->qts, "qemu-io drive0 \"resume wr\""));
>>  
>> +    /*
>> +     * Retire the abandoned write. handle_cmd() drops a command that arrives
>> +     * while the drive is still busy and nothing retries it.
>> +     */
>> +    g_free(qtest_hmp(ahci->parent->qts, "qemu-io drive0 \"aio_flush\""));
>> +
>>      /* Round-trip through the device to confirm qemu is still alive. */
>>      ahci_px_rreg(ahci, port, AHCI_PX_TFD);
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
Hi, Fabiano!

Would you mind to get this patch through test tree?
I do not have enough IDE material except this patch
for now.

Thank you in advance,
    Den

