Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84A7CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBpvW-0002qC-Bp; Wed, 30 Sep 2026 04:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBpvU-0002pY-UE
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:44:32 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBpvT-0001l7-6u
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:44:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xmd52oJbonOxaksBThiJAYErzrBj3R5CLukwOb/K3lnBeML5IzS9aboLW+KW0Nq87xsEbAQCrW2Ywipgpez2tlweoiY3lVRR6vo43nHEze9I2EBbYCAjJTvDwfw0duNE6idlcmB7e5NkAi78qy18TUkAVhqAwQhEM/v0FvDCbM0SLvUqcSI7D3JUJTNkA8NV7THwWl5ZeVroweNSa6W1Awq1BXIgvlneQh5xQiLV2ke4BJPejPrDsl+TB907Lb7FpO23ypnUMD4eoFgl8WndmTesC+NhUMug3u002okGNdSbj6rTJJutkE+5PS5P7Vw+7vXf2Frobd5yeis0GGjyuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2trPGz4SFHlupG+oPFqJRExakvKxNd634jn/Lk5oII=;
 b=ZF8kgCO4Vt6n3nICaTO6qMWSxvmucOeNbHPYvSgtfIVQ63azgon+HD0toMTBTog/cuhDCFHKD/cYVJcI/WRjz0OaOSjzoNws7gJvSp4wWvnw692DXO96apgYLm+rMXpXyOeiaYNWB043BbTZp8sz1zaawRpxLknHcJP+IigG7/kWPFLauNPFoWwR4tBNHOZRd+ftibZ45Rtg2L0jkDNuRIR/vKW6IM9NT57tbeR+JfFDFVn9jt70BQXJ+OHurLYRLNyAfXkO0Yjnvgsevwb7AamhZDhAGLsy2HS2KloCfxQFM2TCGb9B8XWQ0f0Py8ibIS3qxN9CHj9S7NwvBJom6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2trPGz4SFHlupG+oPFqJRExakvKxNd634jn/Lk5oII=;
 b=v57tg0No+tR5II+dxEUCCO9Xl/P4utG9URUS2c9bxmj/NOxHGlPKkjLVYRM74vNkootvdXZRZUSfhZ4bMa80N2+xAlYPxW0L+xd42ENluzidsUV9FgQwks8pk7XGnB51LVjxzAynuuflB9cqj13A8OsRGx772qAuYY7LeaKMxcwY3UgBao2RtdtCsHlXMyPNYRYtBsGMR4btfFSElbyZYB2lTNapGV5HXONnyfdqDSAo98b0+z3YKRWR8ZpzE//2r17cVIO4W4kXU1Osf55zSJxH0J22qru2HvO0mTQreEUYwFtx1DFuXp8fnk7r+kvBfQtxUw/FT6/S108/0I4QmA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GV1PR08MB8258.eurprd08.prod.outlook.com
 (2603:10a6:150:89::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Wed, 30 Sep
 2026 08:44:26 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Wed, 30 Sep 2026
 08:44:26 +0000
Message-ID: <250a1dd4-59d6-4419-a865-2626fbd33acc@virtuozzo.com>
Date: Wed, 30 Sep 2026 11:44:25 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/17] tests/qtest/migration: add test for snapshot
 rejection in CPR modes
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: mst@redhat.com, maciej.szmigiero@oracle.com, philmd@oss.qualcomm.com,
 clg@redhat.com, den@openvz.org, mark.kanda@oracle.com,
 vsementsov@yandex-team.ru, farosas@suse.de, peterx@redhat.com,
 sgarzare@redhat.com, bchaney@akamai.com, dongli.zhang@oracle.com
References: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
 <20260929-up-vsock-vhost-v5-v8-5-12bcf1c0b84a@virtuozzo.com>
 <b1c2dfb8-8e5d-4677-a97c-62e8f9e3164f@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <b1c2dfb8-8e5d-4677-a97c-62e8f9e3164f@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0013.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::23)
 To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GV1PR08MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a9338f5-0313-4fd6-a797-08df1ecf08ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|7416014|366016|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: N8mpNKD/C7lA/w8adqIKSHaB9pQmB0ZkgwvWdJ+Se0PNlRdeTAA/m6mMglgCwjSEYjVwr3MZYDpaDEX0RiNxTs6N0zqAz/KaKjzgIgIL5UvYxK2gTqSpaORlfcqYiU1MLztaAF7w2CPgNBiDS32RoQpoZNGaDnD0qGFNBYhS0uRmbZFwDMjOAiaXF+0Qh7iOmfKhugZbhwbgCCxGzW1g8wbc75pHUjalYZT7qrhmCvn7bemfi54Gf/a0oz8lzRu78KU2R5dABnReePBVzDFTOBDHT/31iyxLMvEWuUsOuQP49lAeXXxiDyStarnAt1B0e2YKF0SL4IBq95EB94gB9nwtyE1b02qyFkc0kN0aXyNdi8DBU76qr7EmXRSLaEcZLFLn8yqwwQScYWqBSTfAYCdqsf4vIpaPPKS0DjRjA4VGRs2x9/wiGtNxhhqRA+7/vdvTNiBnghMMQxAQAALG7i4QWBynFxlg+WXt+NSQ+mPYpN5rRIapv3DH6O1I75xppcheTc8pvd2jwZI4OhrKeXX2Dme82HZhVhh5kETmitqWZPT2xOdGp03lMKnlYiKyQ+xd9pcu/CtrbgqVgVMW87zyGZC7QulzqwTpWKZzZ1LXZ0zo4vze513A5cJYVP6mvys2meYQWVxBrLSeFzCPiKA/5B6pav8RsIOW7ZPcxrY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(7416014)(366016)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZktDZFBwbkdVZnJxcS9CVzVTM0w4TjVTQlZvd1ZBTDZ0amQ4QTJKU3dCd21U?=
 =?utf-8?B?Mmx0V2RZdUJhL1Bjc0oxTlRxTG1iMVdlK3JaQjY3WjNuT01rYlRENHlpemFj?=
 =?utf-8?B?aXZ2ckVJMVBmc3FQb3N2ZEdjSzdXMTRIUklRWHVmOEU1bTlqQ0dsZ1FONzBq?=
 =?utf-8?B?amJVcFdkbXViVk9kZlBZcmJJcHgwcTgwREF2WkhiamFTN2xjaHAxZlJEcC9o?=
 =?utf-8?B?Y2lmS0o1Qm5jY3IrR1pvVUlMVW5keXFnRFVFR0hYV1I2R0JHdXhBMU1DOUVF?=
 =?utf-8?B?NFkyblZNcExnRmJVS1JVMGpsVVVvd216K2YrRHNheHgwZmRhdnVCS3dwWEVZ?=
 =?utf-8?B?S0FFZzliNTJMU3dlc0dKQ0ZPSWdPdXY2Z2N6cU8rV2dsZk92MkFFS3RPbklW?=
 =?utf-8?B?OGxpNVQ3RDBOZFJWc2UvazZ1cnhUQS9uRVNuTlpxSGtBQ0Q2akw4Z0dnRUpz?=
 =?utf-8?B?SnJueE1ocXYxOStkT1ljYUN3MnNWWXE4djJ5c3ZabWxOMG9NWkdqR1FqZzYx?=
 =?utf-8?B?b0VlcTdwNUcxMTVmc3FrQUdoNE9Pc0ZqYnJ4M2t5b05ZOG9uTElFV0hnb3Az?=
 =?utf-8?B?M2pZdFZ6OUlpOEJnamtIRTkvTndZL0xxUFgrS2dtZU5OVFVaeWVTMFpsQ0tz?=
 =?utf-8?B?SFJmdlhEQm9id0NEck0rT2IzYlF0enp1QjQzMmorY3dMWmJuK09wRVkrbHcr?=
 =?utf-8?B?UTdYbjRtVEx3V3B6WjJ1RUVHZVNSenZicGgxOTQ0SkVCVW9OOGFtK24vMDFt?=
 =?utf-8?B?SHlYdUF0cnQ1amVVd21MVG9acW5DdUV2QzQzdCs3a09rYkxXbEVoQWdMY2dT?=
 =?utf-8?B?OWNxbE5hdDBTNEZjRHJTbHhTZDRvaFBOMzBrQlk2aXhvUzdRdXo5MlZFL1JB?=
 =?utf-8?B?cmFsV3p0NEdzbEg4ZjErbGdQb3BINDg1b0d6OURVYlMwSUFrSENwYkt5RFV2?=
 =?utf-8?B?c0RlWDJudFdZSFdjOGdOVFNQT0NFT3RyQkxScEJ3T0tMWm5xVmpSclpLdFVy?=
 =?utf-8?B?Ymo4dDcxTnlvSEFmRW9tYUlEN3ZwV0UwTkE0b2phcTBMaExSODg1di9aZFBY?=
 =?utf-8?B?Rzc0eGxBaWttSVE1c3ROWWxhWTNaL2hYdWJxSUJDOC9oekJwckNJUGI4ZFYz?=
 =?utf-8?B?RUE4UVpFZlhXYnFsbFBTVUIreWFLUWZCM094OTJ4WHNsdVVSYmY2SGU4ZXBx?=
 =?utf-8?B?M3lJTnFzR0dEanFzeXV3S0NGNDQrNkVsdjE2S2lVWndQZy9nS2tRUUJSbXEv?=
 =?utf-8?B?d0lNbGFYYjZhYkR5bHFtVTEybEhxUWExbnJYSENkRlpTMmt1eklvb2hTQWRO?=
 =?utf-8?B?Q1h2VCtlRC9FMzdRM0p4OTA4VkQ0V0FOdUhqM3FhMEZibUc5dWV1TXFydUFO?=
 =?utf-8?B?dnZVbFRLdEsyeUtRYnVZaWVPVnlWcXVaQkM2UC90d0hnSFE5eUxocVJqblps?=
 =?utf-8?B?eXJ5eUdxL2FkRzRTOHRaak5WdFpadkd4ZDVHajVSN25BUWtzMXdZNjR5VG4z?=
 =?utf-8?B?R0xmSWx4VUg1TG1FTHh2VXlqRUdUbUQ1OUhPSkpJNzJTcVcyUkxkUjM3VFpI?=
 =?utf-8?B?WDFManM2OEJ3QWJ6WGU5d0tWRlRlV0dySm1wM2d5OEhZWFllcXB3cjFsZHNr?=
 =?utf-8?B?bjY0ZTJrYnRiU2tSZ0pDY2Vka3NFdm02WDVtOFIvVWllaXdkbExnQXQ5eVMw?=
 =?utf-8?B?OWtmQXNlKzAxNWZwQ2luSXZzdmlqNDg3V1JiQ3Bqb1pvbjBQV1UvMFdxcmtN?=
 =?utf-8?B?TlcwMXhUK2NYTjBDNFRubzZraFpzM3pSUTJPTUIxWTYreFJObWI1VUdrRFVj?=
 =?utf-8?B?WkdFdThXdTBMTzI2c09GQzUrYVhTdWhQb3FGM1QvUjBTRHc3UUhhV3krSThk?=
 =?utf-8?B?NUs0T1ZvWnZTTzF6S1EwQWRaNHFCeFpNZGlLQWF6ZkxSeCs1WDdyaUJLeURG?=
 =?utf-8?B?YlJ5eHZaMGNHNXZPcDB6UnZQa3RaaWJZYnUwKy9RQW03UUhTMWVNZFdNZDJR?=
 =?utf-8?B?VFpVcnV1Wm5KRGNWVTRIUlRxSXJSRW9hOGFLMmorWmxsemt6ajlTUTg3TXRO?=
 =?utf-8?B?MkhmeUJXRnRGeWk4N0RCU2ZSMG1kQWJiT2U1M05rY0dqWnJKWVN5OEJpaktt?=
 =?utf-8?B?N2RhcXhDZzhhZFdEOGVwdGNycWl3U3JkVzRMQVQrZmRpYkU4b0RjOU9zTWlX?=
 =?utf-8?B?RGM3WitHSXN4ZmEvM0NEM05JQXk5U1dkT2RuVlRmRWRiL0hnYlpaNXRTdTlB?=
 =?utf-8?B?NlVMYkpiRXUvZElSb0daMGZIYTh1MGRFQjRnTU9oVzgyaC9tZ1ZQV0UyOFl3?=
 =?utf-8?B?WWtSTS9Zd2N6eldtcnBXUFhvOEhCUkhEellYS0pUOGJzZHcwZ0pRZytYYVlI?=
 =?utf-8?Q?oDzFnzZYrfXVAz2s=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9338f5-0313-4fd6-a797-08df1ecf08ae
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 08:44:26.3975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpSH5MzFtayAZtn6i+DoiwqdKfHnGMog169D2xyPmS7m2ZvLsZBq51GfDsgQz6Bj7rYMhWbfQqJblzHstF25Yli96p4LFlUKCn8YeCZ2WWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8258
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
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

On 9/30/26 8:07 AM, Akihiko Odaki wrote:
> On 2026/09/30 2:23, Andrey Drobyshev wrote:
>> Snapshots are refused whenever a CPR migration mode is set.  Add a test
>> which sets each of the CPR modes in turn and checks that 'savevm' and
>> 'loadvm' fail with the corresponding error, then switches back to
>> 'normal' mode and checks that the error is gone.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>   tests/qtest/migration/cpr-tests.c | 36 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>
>> diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
>> index 0bec753b4ab..2be0fc8c07e 100644
>> --- a/tests/qtest/migration/cpr-tests.c
>> +++ b/tests/qtest/migration/cpr-tests.c
>> @@ -290,6 +290,40 @@ static void test_mode_exec(char *name, MigrateCommon *args)
>>       test_cpr_exec(args);
>>   }
>>   
>> +/* Snapshots must be refused while a CPR migration mode is set */
>> +static void test_mode_no_snapshot(char *name, MigrateCommon *args)
>> +{
>> +    static const char *const modes[] = {
>> +        "cpr-reboot", "cpr-transfer", "cpr-exec",
>> +    };
>> +    QTestState *vm = qtest_init("-nodefaults");
> 
> This omits -machine and fails on e.g., AArch64: QEMU exits with “No 
> machine specified”, then qtest aborts waiting for its connection.
> 
> Regards,
> Akihiko Odaki
Thanks for noticing this.  I suppose providing '-machine none' should
help here.  I'll add this.

Andrey

