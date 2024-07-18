Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2EFC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 19:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUX5S-0007gb-R5; Thu, 18 Jul 2024 15:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1sUX5Q-0007dn-EX; Thu, 18 Jul 2024 15:46:44 -0400
Received: from mail-db8eur05on20714.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::714]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1sUX5N-00052A-TD; Thu, 18 Jul 2024 15:46:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYpWSPM/rlEKMmV9KydIBQ4UQOtoJ9rtWWNMrS1irN7u7REPmIg+BRAzfqRLi6HLV+cl78GNTPLXgVg3eXUXVewfOG2HHC74HV3O3tNchKF+Fb16l5JxCcOM6C75Iwl2hjPrY/waInuIflFJ0yo4UVJasqcFgw8wPHiSKO/lv/U9q2UOm4IPTzkkQ7uXlhjrl27tZ0wkJgnMdoTkOAt+SKwgpJ657GW89BcSM89P87vtD8hBsNasvyOtPsXS5jn1edhv9nPDPO2++RX5k6AyhEggcPJrQ7xfn4Acf4BTH+KZjzYIn3112dNp+uzSHKmYVFaT2acldCmas+y8vydrhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRdM/SFfyfaJoEKShrKxaYhP9DtxvvvoRxoT1JmeyO0=;
 b=Zzax4OVeb7OBfNAb5L7bsdZJUpVtxigC79pb1Xo6rR7YBwbAvvcMnNDVDV060nVCuur7xCe4fyM90N2cGUHyPgcYhgZgzwdbZy84rTQmFO1W1DZRMmjLr8F6Ese3RHKxGpa+CnR9hgBKtI0ZSEHYI25Z2HJnQWGi7f2fNGIYuaz9LJOwZfVMwZUixWwLSOJBliAnOf7d0evCWCh4FJ06vlJC2h0hVNNQMJearMt18vKxgrI89KAp1iGX/7TC7dxQFjHyMGIZha4YOLAqHHacj5IFZ9onBdiFyVhMTGdCdvfu9U1PT4cc11a33kxtGHDyUYRFbzalmMfI8P8oKorgZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRdM/SFfyfaJoEKShrKxaYhP9DtxvvvoRxoT1JmeyO0=;
 b=qQ2K4lfFAkpFUh9Hh8aWpp+OrbaxYZpr8uYGxNcvMEmOnyXD5GM8LKXXNer0jvBVEnJKWWH5fYHQECzATM3j77/1w5xDQnlJvZeyXfUTI5Xv6Y2lnNvF3KIzBzuj1QmTUcffNHP620hXEGKRhjxB53psxTzFCX13gwHXfdQjCVUqCxkTYruzYX9sXgOy3knO01DIwOGCqvFBI59NfDpEz+bBWl+iP2yjbxllbssapf/2X7ATPethyLuoYavadGxxgSZuwn/1vgqSnm57Jck08dj6fdVwIzJD0CZyPsYvEkK7hnbTsBngg+r0fCkGYwALEXGWzAurbNSjZHk81yPCnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DB4PR08MB7935.eurprd08.prod.outlook.com (2603:10a6:10:379::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 18 Jul
 2024 19:46:36 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1%4]) with mapi id 15.20.7762.020; Thu, 18 Jul 2024
 19:46:35 +0000
Message-ID: <03492477-fe98-4a3d-a892-7c6a143ee048@virtuozzo.com>
Date: Thu, 18 Jul 2024 21:46:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] block: zero data data corruption using
 prealloc-filter
To: Kevin Wolf <kwolf@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 vsementsov@yandex-team.ru, pbonzini@redhat.com, eesposit@redhat.com
References: <20240716144123.651476-1-andrey.drobyshev@virtuozzo.com>
 <20240716144123.651476-2-andrey.drobyshev@virtuozzo.com>
 <Zpk5-GDaqmD4c-EF@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <Zpk5-GDaqmD4c-EF@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0220.eurprd08.prod.outlook.com
 (2603:10a6:802:15::29) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DB4PR08MB7935:EE_
X-MS-Office365-Filtering-Correlation-Id: ec9dcacd-3e3c-4fb4-1faa-08dca762552a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YU5YQ3dYb2ViZ2JaQjMyZkdUenBWdGdyM2pDN1NVSUFYQUc0OTdqWThFVGtB?=
 =?utf-8?B?YzF5b0tkYmFQY1NUWDQyTFBkc1lTM1pkOGgwL0tEczczTUtRQTZ6RHNFVWxT?=
 =?utf-8?B?elNhVG05YWZRWFhrLzVoeFRnZi9DRlRNRWFiYno4VnR5M0RWQmZ5K2NFMHBv?=
 =?utf-8?B?TzU1R3lWY1R6bUhlamhaaVdwanhkbGpMOWpsOVVSSzdWVk13Tzl2MDZFclUz?=
 =?utf-8?B?SXlIUGZ1dXorRkx4NGdwbVozMTFaeCtvZ0xMck9pMHNUQUM3UW9zYnUwY2NC?=
 =?utf-8?B?MEtEWXdOcmhpTXNQcFNsRGJoMGtkc1dtZ3BRRG4weFhyYVdBcGkvZ3hqYmk5?=
 =?utf-8?B?NXJyemF4a1BPYTNVZ25JWTlvWVdEbHRybEM2TS91MlJXR2VUVmp5UjdEWXBo?=
 =?utf-8?B?MFd5UTkxeUh3S2U0MFZILy8vTk9IMm13d0RQYVpVVXk2R1FVNVpERjNsdDI2?=
 =?utf-8?B?UElHbWlnSC9wN01WNWZnYjVwVEhxQ0hjVkQvalJ6Z29FQ2ovbU9pKzRMSnM3?=
 =?utf-8?B?MjgwcmN2ajliMDFGWWh2OHR4aW81WGNUS0wyVzF1eGlhTDVZNXA5SjhUOHRj?=
 =?utf-8?B?WitYOSt5dEFPRXc2STd1N2drSHhOVXMvM0RUSzdETHdtR2ZndE9RWVpvZG1M?=
 =?utf-8?B?TTdBUTM4WTJvcTZKemRRb0xFZHBHTnFwSmgxUjMwQ1cxNDJuU3RSc3lQb2t1?=
 =?utf-8?B?MXU1Z00wNmZKYkIvY2twMTBTdlNhYmlyUEJQYW9kZ09QNkV6aHlQK0lPL0g4?=
 =?utf-8?B?YW1wQ1I2cmFhL0ZzaEh0TnhqbVJ5dnh0NGY0OVhLNCtTSVRRQTI1VjJ3THE2?=
 =?utf-8?B?V204LzRzTHBYazVzYUpJK3hES3dVT0Y4UmozU3QxQUkrT3hSeHQ5YlptZm1B?=
 =?utf-8?B?RkdDZmZkQ2xaMHdXbkw5N0MwMUk0UTZKNGdzOHVnSTlVVzBWV2JRY2YzRDU1?=
 =?utf-8?B?T2hhU3orNi90QlczTFhMT0E4QTZoTVNJdDhaMHVrSTNWZi9wRmM3bDFGYTdu?=
 =?utf-8?B?NDY2ZnR1L1BraFJJRWcyeGFHM0ZBSndwOVRPOVhQK2pLYWlvMFR6T3BYSDN5?=
 =?utf-8?B?b3pYK3ZBU0p6bGprWW03NzNaakxuN1BGaHFEdkxWTUZBT2M2akE2RFF4QWJY?=
 =?utf-8?B?bERVTk1Ta2ovWHRDMnkwcDh4MjFYL3Y2TzJNUEs4elkzMWZ2dWUyZjRqS0c3?=
 =?utf-8?B?dHFwaHY4S3Y0K0FzR0lmWEs4cGhvc2JWRDhHWjZFd1YrOEtlWnl3ZVl0Kzh0?=
 =?utf-8?B?ajE3NXZZUU5ZTUloWWw0enV1RTJDUTNCNi9PWVVaMCtBbk1rQ3VrU2VDSWQz?=
 =?utf-8?B?aWlNd05qc0VyQmVyZ2NVTFFVdmw2a0tJakVYZ2NCYlFZWHBYdFdkUlgxbURS?=
 =?utf-8?B?Z3kxQmt1K2lPanQvbjVNMjd4ZGJOTXBlMUw3UWgxU05wQlI1bmdaZHdmcVcv?=
 =?utf-8?B?aUNobEF2SDJSb0tpa2FZUk43UU5PUVd6SU42RlJNemc1V21YTUNTejcyWENE?=
 =?utf-8?B?UVNNNzErQVBWczJkMS9ESFRmWnNla2xiaWYxLzJhNTA0NnJ4Zy9sQTFXZGRT?=
 =?utf-8?B?Mm9ZSnd5bzlKNXBmcm0wb1AvaENkR3U1eFRiS095WXdPOWtVRG5VRmhjaDFs?=
 =?utf-8?B?MGRYTlhqcENZdEVETDBNUHJjS1dpQXNzZHJnbkhzaU9zcVdkcjd5K2wzWU5V?=
 =?utf-8?B?VXpFckNWekZ0eFVtbFVrNGVvOVJBRTVveWwzZU01TWQvaUJSYjVsTTJQVkdp?=
 =?utf-8?B?a1dLV0ZJZjdhUFlZOWxLSFdZRlBHRnA5Z1ZXMTdUOTd3WTlJb1c1Z002Ylpj?=
 =?utf-8?B?U2FwSlZTV1RCR2dQb1c3Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGpLbTRhZGhIQklmL1k5cC9PZE4vMndWY1plK2VYUWNHRmY0VVU1bFZTU2dI?=
 =?utf-8?B?eGpDV0pFYmFyaE1CMkprcXVETlcyN2syMXZ5ZHg1WXVCTDBidlB2V3hCTGFj?=
 =?utf-8?B?UnBuRGVVL1VRcUh5V2N0bmxzTGRraTFML1NZdXBqbmxyVlRObEtveUZUNUhU?=
 =?utf-8?B?NDY3UFduVEh3Wm45SmU4ckhSUnI5UXNOek9ySkUwYmZFMDRVQkNkam1aM2dQ?=
 =?utf-8?B?WDl6TGhGb0pEVHZnTk40aDRHT1VlS1JrRGg5WCtrd2N3SkJWSEg4ZjhGRlI5?=
 =?utf-8?B?emVIOTlCN21JdElyV0NLMHhxL1plU2FPMXR2TG5abkttM2hIYXlPTGNCR1dD?=
 =?utf-8?B?SFdmeGtFZEVKSmw3bEVzQmtsenNCUm12Yllzb0VaWk1SSStMeTdzeVZyTmhJ?=
 =?utf-8?B?SW16RmhMYUgzRTRjTHVtNnlQeG9EYXRFS0x6aTh2Z1BOVW5qaWlGM1R2N296?=
 =?utf-8?B?ZjE2ZnZWdEw1ek85Z3JHbjZaQTB3MHB3emk1NkJhSWxad0xYaXpSU0VBa0RF?=
 =?utf-8?B?Q0tBT1hpMHVkWnJiSmlqcUtSVzNvcWp5dkExYjJXMXR0a2VoVjBJUU9uQ2Zy?=
 =?utf-8?B?ZHFCRGk5TjZtaG1QLzdsSHljU1ptcjliZ1ROZkQvMUhSbW9wS3FMUVRBL3BT?=
 =?utf-8?B?WGpCUWl0Z25Pb0E1Ym5VUENTNExkVHl4eXNFbzNXVmxIVG9ydDVmR2czeTNx?=
 =?utf-8?B?WHpKTktVbTZYaEdKbXU4aGtYOWRLV09yVXFrUWVHVWJucndHcUc1ME1Dc1Fy?=
 =?utf-8?B?cmdvM0Z1L1BVN3RsY2pEZkhaMWlVT1ROcHM3Zmc4elBCRXFSM1pEditlTUVJ?=
 =?utf-8?B?RlhWZW1oMjgvc2dudGZvbldMZnVlZ3c1UkdCMDFITVl3dlJXUk43c3dMalB4?=
 =?utf-8?B?WXQ3WlJmWVBhYUovcno1cHV6ZFFMd1FzdnlpWngvMFNhOHBCS3A5WXd4d1Q1?=
 =?utf-8?B?Q1oxejNydEloU2VkWmRaVVVkemVzL1owaVcvMDV6S3hiK1V1aUwvc3hXeTB6?=
 =?utf-8?B?SGVDbHpwL1Z2VFh6R2U2dkcyVitVTWZ1SWRGOTB4TVBZZ2t5dFhtRlB5cEZ2?=
 =?utf-8?B?ckREQzd2U21ZOFdMY0N2VUM0bXUvWFJ0bnJUNTl1TXNmanYzb3plNE1tMSsv?=
 =?utf-8?B?RW5yOEErZG5tTDVxUUk2K05lN2wzVjJDWEdKQ2NKVGVlbzJYWGVtVDdlbkxw?=
 =?utf-8?B?dFBOU04reUdtMC9mZHlBUTFoOEk0RjhYYVQrMi9IODhBK1hNNFlScFNUV0k3?=
 =?utf-8?B?OUpwa3NEbk5zY0U5Q3ZyeUJaeUJFaGY0SVVNMDU0Z05aU3Q2R1NhbjdqeFRp?=
 =?utf-8?B?VXpQUVZnU2VoNDJXcnhDNDg2a3h3UGkvUzYzWWZZaWNFaTk1NG1IbUlOclQ4?=
 =?utf-8?B?T2hQMlRGNXkyNG9hMjlWQXlRR1M2U1BBZTR0NGhJejlrem1ycW1WVnBmQW5m?=
 =?utf-8?B?bG93UHd5S1pzZW1KMlhZa3c5WnlwWGtscXhmVlJzM1RwKzNGT1hrSFphSXg0?=
 =?utf-8?B?MFBIRDF6Y3AvL3g0Q0dWaWYrbXVZUDNYRS9aRFhOMVp5bXczZ2ZqNFZscERO?=
 =?utf-8?B?alNlTVBCTHNPUXZZeU1qU2RNUFNxcGdHRVVMOW53bmRHV24wWVdWU0tJUitY?=
 =?utf-8?B?Q3dBVUhaSHFoR0tSRGZxMzZPay9kdVA3WkJzeWhtTjNjMWhxRHZaYWdodTl6?=
 =?utf-8?B?QXByaXpDdWhwa2NRZWVWMnZTZ3EzQjgycU1EeW5kN3RhS2ZJdk5nRFZGVzJN?=
 =?utf-8?B?cFpETEwxM3Y1a3JweWJYUmJldTlzSDhnd2NWVFhCREp1MXhzWnhucU9EckYr?=
 =?utf-8?B?L1dEK1AyU2hraWtuL3BiTE5FUG1OTXpCYzQ3RGh5WDJkOGMwZ1NyS3l4SEVI?=
 =?utf-8?B?OHRXQ0E4Um0xbUZBMG5tV1NWc0J1S0RJV05VNWxZNnlkdlpleFl0RkhtMHhk?=
 =?utf-8?B?ay9UQ09OV2hPMEFZc2VCU3Arc1Z4UnZ6elFyaFV2MGs5SklhSldvd3dURzhR?=
 =?utf-8?B?d05WYUlSdXVHbzAxZ3BLSnVNTFRBLzJaV0VSeXlacmNnUTJkQ3FtUWEwbGhi?=
 =?utf-8?B?NVpjbVRCcE1iRm13K1l1RUVqN0FhNHJwTTZlOGdPem53bVBZcEJhdUxKa3Vz?=
 =?utf-8?Q?AdLrtGWFh/i9tkJOV/OH0zv7k?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9dcacd-3e3c-4fb4-1faa-08dca762552a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 19:46:35.8666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fuH/nEyQzNwcJRn2DFqg951Ee+UU8lIlp9xYKpEQ4+VAw4G5wV6bDWBVdWgZ20vj2wwELorz0lXaNXmE3SKXRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB7935
Received-SPF: pass client-ip=2a01:111:f400:7e1a::714;
 envelope-from=den@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
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

On 7/18/24 17:51, Kevin Wolf wrote:
> Am 16.07.2024 um 16:41 hat Andrey Drobyshev geschrieben:
>> From: "Denis V. Lunev" <den@openvz.org>
>>
>> We have observed that some clusters in the QCOW2 files are zeroed
>> while preallocation filter is used.
>>
>> We are able to trace down the following sequence when prealloc-filter
>> is used:
>>      co=0x55e7cbed7680 qcow2_co_pwritev_task()
>>      co=0x55e7cbed7680 preallocate_co_pwritev_part()
>>      co=0x55e7cbed7680 handle_write()
>>      co=0x55e7cbed7680 bdrv_co_do_pwrite_zeroes()
>>      co=0x55e7cbed7680 raw_do_pwrite_zeroes()
>>      co=0x7f9edb7fe500 do_fallocate()
>>
>> Here coroutine 0x55e7cbed7680 is being blocked waiting while coroutine
>> 0x7f9edb7fe500 will finish with fallocate of the file area. OK. It is
>> time to handle next coroutine, which
>>      co=0x55e7cbee91b0 qcow2_co_pwritev_task()
>>      co=0x55e7cbee91b0 preallocate_co_pwritev_part()
>>      co=0x55e7cbee91b0 handle_write()
>>      co=0x55e7cbee91b0 bdrv_co_do_pwrite_zeroes()
>>      co=0x55e7cbee91b0 raw_do_pwrite_zeroes()
>>      co=0x7f9edb7deb00 do_fallocate()
>>
>> The trouble comes here. Coroutine 0x55e7cbed7680 has not advanced
>> file_end yet and coroutine 0x55e7cbee91b0 will start fallocate() for
>> the same area. This means that if (once fallocate is started inside
>> 0x7f9edb7deb00) original fallocate could end and the real write will
>> be executed. In that case write() request is handled at the same time
>> as fallocate().
>>
>> The patch moves s->file_lock assignment before fallocate and that is
> s/file_lock/file_end/?
>
>> crucial. The idea is that all subsequent requests into the area
>> being preallocation will be issued as just writes without fallocate
>> to this area and they will not proceed thanks to overlapping
>> requests mechanics. If preallocation will fail, we will just switch
>> to the normal expand-by-write behavior and that is not a problem
>> except performance.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> Tested-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>   block/preallocate.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/preallocate.c b/block/preallocate.c
>> index d215bc5d6d..ecf0aa4baa 100644
>> --- a/block/preallocate.c
>> +++ b/block/preallocate.c
>> @@ -383,6 +383,13 @@ handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
>>   
>>       want_merge_zero = want_merge_zero && (prealloc_start <= offset);
>>   
>> +    /*
>> +     * Assign file_end before making actual preallocation. This will ensure
>> +     * that next request performed while preallocation is in progress will
>> +     * be passed without preallocation.
>> +     */
>> +    s->file_end = prealloc_end;
>> +
>>       ret = bdrv_co_pwrite_zeroes(
>>               bs->file, prealloc_start, prealloc_end - prealloc_start,
>>               BDRV_REQ_NO_FALLBACK | BDRV_REQ_SERIALISING | BDRV_REQ_NO_WAIT);
>> @@ -391,7 +398,6 @@ handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
>>           return false;
>>       }
>>   
>> -    s->file_end = prealloc_end;
>>       return want_merge_zero;
>>   }
> Until bdrv_co_pwrite_zeroes() completes successfully, the file size is
> unchanged. In other words, if anything calls preallocate_co_getlength()
> in the meantime, don't we run into...
>
>      ret = bdrv_co_getlength(bs->file->bs);
>
>      if (has_prealloc_perms(bs)) {
>          s->file_end = s->zero_start = s->data_end = ret;
>      }
>
> ...and reset s->file_end back to the old value, re-enabling the bug
> you're trying to fix here?
>
> Or do we know that no such code path can be called concurrently for some
> reason?
>
> Kevin
>
After more detailed thinking I tend to disagree.
Normally we would not hit the problem. Though
this was not obvious at the beginning :)

The point in handle_write() where we move
file_end assignment is reachable only if the
following code has been executed

     if (s->data_end < 0) {
         s->data_end = bdrv_co_getlength(bs->file->bs);
         if (s->data_end < 0) {
             return false;
         }

         if (s->file_end < 0) {
             s->file_end = s->data_end;
         }
     }

     if (end <= s->data_end) {
         return false;
     }

which means that s->data_end > 0.

Thus

static int64_t coroutine_fn GRAPH_RDLOCK
preallocate_co_getlength(BlockDriverState *bs)
{
     int64_t ret;
     BDRVPreallocateState *s = bs->opaque;

     if (s->data_end >= 0) {
         return s->data_end; <--- we will return here
     }

     ret = bdrv_co_getlength(bs->file->bs);

     if (has_prealloc_perms(bs)) {
         s->file_end = s->zero_start = s->data_end = ret;
     }

     return ret;
}

Den

