Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D101ECE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 06:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKsRC-0006NW-Nc; Mon, 17 Nov 2025 01:10:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vKsRA-0006Lv-1i; Mon, 17 Nov 2025 01:10:04 -0500
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vKsR8-0000CU-1x; Mon, 17 Nov 2025 01:10:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHTjUUnhNMPqm8oLHwvBeKehqXwNEPrXHajaKYCKnHTn8DvmMhS27n6dYeFGuhGbZot+uXmch6L4v2GsjKlGRCVp9XE5mdRPmW/mls+2Wvtd65aEyAD8EITDv4mZ3BUg0t4spj1cYm0ZH6fTI/tcD7P1/We3TAacHCTlcb39kLGkOI+rWvv/ZkfaGq28n8fSP0dFLe3iNC/Porlb+uB8k4e41W1vsku87nizfYcrAas3HT/VXcqc6fRortCHhlI1XNWi0aqieDa/WyBxs9pWPpCJk8TKNFDv1sNfhLGhLF9XfoPjaYYgIXowMsG7EZufMj6Y/ijUyQwsnOWrj/bYIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mf5KoV+oED9unsgbWnjDi4QSPKRIoCLNV6YgLSmwQ8=;
 b=jJlFU5kACFOLIMmMdvWI1vJb0x5F5KNVCIGH+Ka/VwhmpVtLgQ3XtStqc4XhwAffjqspSb7oOmMXL6anIAPrp1TwJFftbFTSdVBZiNQhgwA39HgLo8vh41H8j3pP3xRk7ehLXkFMH9cg43LUVBkFtw7FzpQTZsd27fuHXE2GwClcs1fjG3m6SG+VgBRsxuOsT6+halH8TUdIS76q9iIh79ZeDWyJzG+50nGTAQSxmRjo+mX7XnHqrTNXREf+Pe5UXanNAN/PqajdMUVhFg9poq2GuLl1W7A3HFgA/52LSpzG50N3Vmg6LeCLvWLlG9SzSHElz5wOq6tiENwRaANuxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mf5KoV+oED9unsgbWnjDi4QSPKRIoCLNV6YgLSmwQ8=;
 b=sLbkVHO0+ZWxEIOwPxUyDauuO2w10WnBK5rims509o4/ZyivDyEYtZD/FO6D65rw97sf3YU3P4Z8/HIU1YOW0aSz6EPyPocQEd1LxvwRoNJNWiPIWXOffrfmuCjBovo5cixRSWrNei1zu+KQa8GyxuBw73JlS0gfvBXKFP4p8npJ83hdhKu+5GZgjyaQ3LfTdFpimk9Yt+83QdCxriIWgXg1J2vRsgGmi0dSil922aAD/EI33ICHeA+v8V4gcaoN7q5arHWoj7v3M6L0BYX/YDUmpe48WUABLomQOj/QG6Su4lWy0XEk91/Uj+jWn6vWtithsPIPpSHXzkJUcIMQyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AMBPR10MB9527.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:737::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 06:09:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 06:09:57 +0000
Message-ID: <99d516b4-28f0-4605-8e14-fbf3d282890e@siemens.com>
Date: Mon, 17 Nov 2025 07:09:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/sdcard: Avoid confusing address calculation in
 rpmb_calc_hmac
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, GuoHan Zhao <zhaoguohan@kylinos.cn>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Bin Meng <bmeng.cn@gmail.com>
References: <4f7e1952-ecbd-4484-b128-9d02de3a7935@siemens.com>
 <663acd8d-5c39-4f1c-b5b1-569e36e4ff95@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <663acd8d-5c39-4f1c-b5b1-569e36e4ff95@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0329.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AMBPR10MB9527:EE_
X-MS-Office365-Filtering-Correlation-Id: 89628325-d2f6-4768-fe61-08de259feed7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0tPbVFHMG5kaTg1Z3BFVlBSTnBRWFFkMmNSbmFKOHIwVEF1UGRhQTBoWVFn?=
 =?utf-8?B?aG9nKzJxVDBOZ29mOVl3K24xRUpuSERwQXBsWEpTT2NCOWtYZW1JVE1uMGg1?=
 =?utf-8?B?bFBGTlg1emYwZmFZRkY4RVh0MHNxaWF0Z1JXR3VWMjhIRktBd0Uvc3IxeE5T?=
 =?utf-8?B?QktJQ1ZBVkdlTHpKUUpkdHJuVSszU00yY3VwOFMzWE81Zy9LMXc2SUE1TnRm?=
 =?utf-8?B?OUdWR0N5Z2sycmJCRmZPMGVxVkxYMkhmTllRRFI5MDZia2RnZEgrbGI2a0Er?=
 =?utf-8?B?YmY0azFyWlAyeFpDSzQ2Y1liZjRVUVlxTllRdWovSnRGeDBsRE5UdVZoSzZB?=
 =?utf-8?B?QVhnS0p4RE9vNjVlOGZqaWFtWGxNZXJHU0dJQVgwcVdjeS9pUkpmZW9CTGky?=
 =?utf-8?B?S1kyTnk0dEM1MXBBUFVkRGNEUFRiV1dBalQ5bFZ0bkhJejhIUnlab0s0Nkxt?=
 =?utf-8?B?SXQrUHR4QkZkSTRkU1I3L2FjQ2k2Y1Q4dVRnVzNIWHhkUEZ0c2tnemVzbXNv?=
 =?utf-8?B?V1A5V1RsUWlnZUMzWS9vU1hTMmE3SnU4OVpMb3FKVzZPWnB3elFpM0lweTB5?=
 =?utf-8?B?Z1U0ZWdIeUtkQXBsdnIyNnpnVnVqM1pUVnJBVVhGWWhZWVNBbk9SWHpXUWUr?=
 =?utf-8?B?d2c3WWNDNFBRcjNUR3FjbnliVkN2cU50U2xnUk9EOS9vVmtBN3owd0JKd3Ru?=
 =?utf-8?B?elBRREhwS0h5cUxWNW5HYUxPR21xVWcyRHBFK2wzQ29jQkxORTJmandUSTY3?=
 =?utf-8?B?NStLaHdiOHI3dDFqbWdLaXk4Q0ZTRVBOSThKekZuVGlIVno5V1kvSlh2aTNE?=
 =?utf-8?B?UUpkRXJiQ0E1b1dPUzAyMkh1ZC9VTUxZanRZSmRWcHc5ZHZWY3lZdTVGSjBP?=
 =?utf-8?B?ZVpXMHlBQlA2QzhTKzZzYktoLzJSYWVmZzAzQkNrUDZDY0J0SGhGZ2Zmd2ZK?=
 =?utf-8?B?czZtRmF6WTZFelAxZDZYRWpiRUVyV01UenV6R1VxQnVzM1Z5MVJ6S0RiMDZ2?=
 =?utf-8?B?dGpMYVovTUxFRWNwd0IvWlcxTkdxWUpnYnJ5cTdWQzhJemFUS3kxeFBLQTQ5?=
 =?utf-8?B?M2Nta0t3MG85bzUranJGUXpwY1BDV3ZSVUFuVmFtS1BpYlRwTkhKVVkvbjZY?=
 =?utf-8?B?aUFoV3hGUHFzZlhUZVpaV01ZcnBUbFJ6V2E3Uk93dGdVVlRnUGV3bUNWSDdR?=
 =?utf-8?B?VTZ2WXdWRXZNaVZITTFRbGNDK2VjN0toQUEzdWRURTBnSEtwSkExL2ttanlh?=
 =?utf-8?B?U2pUMUt0TVZuZlUrNkhTQmNrL2h1QjdiRkppL09zK0VsRXNabDJ6MDZjQ3ZP?=
 =?utf-8?B?cUlWbjkwU2JmcU1nYlhEZEUvNWdaUUNjUmM1MTlOV2o2T0dJQlNIQ0lQdGNw?=
 =?utf-8?B?ektFUWxva2F3NnVvNXFjcW4zcTU3dU1yc1pFYlpVUitwRFEzL0hTNkN3S3Yr?=
 =?utf-8?B?SVd5Q3ZLSjZpV3NpOWZhVzdjOW5uK1lqMTg0dVg3TWt3WTFmbGdUdXJzaGdW?=
 =?utf-8?B?enZmd1ZzM3lucVlqYUpSNVBqeUhKVVJVNjBRNkp6ZDFDemxkS1lZclRMdXdj?=
 =?utf-8?B?RUJBUU80UGNxbC9aRXk4dGVrL2t1RVhwRU0wK2dYbm1GSFZhVlRiVDA1QUkv?=
 =?utf-8?B?UUgvU3FBRnNaTWxLRTVHRFhTM3ZrSWVXQTNaOHcrTUI0ekhrWkdjRjB2WTNJ?=
 =?utf-8?B?cTVzR3RUUS9JeUhSaWJZOFo5eTJFdDdCdVo1MWx6YU9UQmxVck1TSlVsYUJJ?=
 =?utf-8?B?VWRoUVoweFdkUEx2SFdoQVJLSUlRU1dWK3B6ZU13dUp5bXBoRkw4SURCME9l?=
 =?utf-8?B?Szd4a0RKTmhScDlLV0lkQkI4eksrVnp5TUpteTlzcFhVQms1clQ3SHJWb1Y5?=
 =?utf-8?B?Z0hLNnNJWmFIYkRwNE9Hd0hDbFgvVXhwYXhQaXhFVlJlOStJVjZYQjFPU1h2?=
 =?utf-8?Q?jnG/KoyZUdfSCfzWq7yPpk6hfHlWRg2i?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm9lU01vcHdlVWZhOXlWd0xRV1lUdC9MalIrS1lEdkkrUzVYV0QyRWpyckI2?=
 =?utf-8?B?QjFsNGZiU3BNb2E2RmlnSWM5WWZaOWVDbWUzRDc1RHdKaktCZXFMUVNQd2c4?=
 =?utf-8?B?V1dPUEwwcHB0Ync1N0plbG1qSlQ3Q2k5cGJnZ0x5TlNlS2czM3YzdVpOWStC?=
 =?utf-8?B?RU5sNGFHZ3U4UHAyNUJQeXRRNUNZTXdQWUVvWmlzOEU2TWpqRlB2SDlmUUF2?=
 =?utf-8?B?Zit0UzVHK1RsMHVOQ0RqQXlzRFkveVM2clFQcEkwWVhhVnVlQWhvTGV4QWRD?=
 =?utf-8?B?MkJkb0ZlUWg1cnN5NTlENHg4eFQxa1pBV2lvZExGbmI3NGlVbUZhbDNVMDJn?=
 =?utf-8?B?Q0NoQkw4RXhrVmR5T3NKaXkrTUxEMEdMdkd5QXVZcG14TWlJZ1pZZUJucTBX?=
 =?utf-8?B?QUFGeVRrajNiQ1pzRUNDN1FBaTRKNHdGNHptUVBTS3dOU2lQNGh0UkovMFV4?=
 =?utf-8?B?cStsZElaOHd3TE5kWUZXNEJ6ZnM2QjRlbXhtMG9CSm1UY2h5S2NjakVGdjRM?=
 =?utf-8?B?c01vOFFxcVQ2c3RHZ0JDK2NtWHNEUU1NdjM3ek13WllQeWZBTnV3YUtxZXRm?=
 =?utf-8?B?a21tck1IL0RFQnJ3a1NrOEtPTmQyd2I4ZURVcWVSZmhsamtSZC8yN2duanhT?=
 =?utf-8?B?d2wzUWwvNzh3Q3J3djVPYWpEUkNzcUhIMGw4S0NzUjNnejVXZ2IzNCtqdDdT?=
 =?utf-8?B?M0laLzdZaWd6aVVtVXQ1U2hBYXRnZG9EeldXcWVuTnJaM2R4ZjhWbHZOTnAr?=
 =?utf-8?B?L1Q3TVkvTG5SR3dUem5raFQ2T2cwRFRxUTZNK3dncVZtZkpsWHU5QWZjaG8r?=
 =?utf-8?B?TkJrS2hUYldENVI3L2RrbGgzN1g0VXhPMWdpM2c1OWVwckdmcHluSXExRmZJ?=
 =?utf-8?B?ZDNxOUYzaTdGMUwzdW41cU0zdUhES2dLS2dXd0plTm5YWXZnK3o4eGRoZ3B5?=
 =?utf-8?B?cUcwZ01XU1A4NkErS2V0dnpmNDJRNmpTSjgyN2kvVCtiU3IwRGhZckZodVkx?=
 =?utf-8?B?dXUxZ0htS0xlU3ZLcFE2Y3NTU0FzclNxdzdZV2Z4N2NPMGQzSC9yc2dyVlJz?=
 =?utf-8?B?bUgwdnc2Tkc2YmV2Q1JjSG81TDVpR3Yybmg4MTlBNFJUTnVoOWM2dWY0SS9i?=
 =?utf-8?B?OE9jTGVOa1Q4RFJUdXV4UW9SZjNwVVVSQ1lUUGJ0K3NwRU5BVlJCNjUzbGdK?=
 =?utf-8?B?cXZRRVIvbEhTeWJVak0xSnpicmRxeWIyN2xaQm56Z1ZRQXFkT0krUDMvT1ov?=
 =?utf-8?B?YU92RFVOczZoT2hSREwzZmFFU3M5aGllcjdQWTYzZDJWaHFkTVRmaG11Z3Fk?=
 =?utf-8?B?V2ZrWE5ueGVYWlYwZWFiNWVhcm1GUFpQYUpzUG02L05nUnJQaTVXSWV6OU4x?=
 =?utf-8?B?S2ptbStsNDlGZWpRY3FNSitCVmtyY3VQRVNpWlFNTW94SmhLbi9peDVPNUlz?=
 =?utf-8?B?bmdJUEpqQ0UwQ0NtNWdrRU9NdDIzamRRVjlEMkVYSXNoTnllK0pvVGZQdEJt?=
 =?utf-8?B?Nmx4alhHcGwwR1NaZmNGdzJYQlZJeTNwQTdUdUt5RmZES1VEZEJlTzZzSnds?=
 =?utf-8?B?QnNwTmhydHdRQnNoRk42ZENqTjh4YXRJWDFVNGlpOVoyOE9jd3NrSVdpanpD?=
 =?utf-8?B?TStldWU1Wm55bnVzeVBtN3RxOWc1N2JIQzlUWUU5Zm1aVXBIN3dXSWFKNTBY?=
 =?utf-8?B?eXFXU0tZaFdPYkxUQlFqWHQzTVUzTWVCWFVCbWNGQmFJaHFDSU9Pc1YzVGRw?=
 =?utf-8?B?akxTbCtHUDFjR1NDZTYzU1F4VnhzS0NJL0FpMjk3TVFFbGhtRnFBeEVVUUtG?=
 =?utf-8?B?SGdtVVRVVUtLNURZUDBRaENTVE9DTXZxSnRNQ245WU5oUjF0cjNxQWEvUG1U?=
 =?utf-8?B?RlpCVFhYcUdGRkxNZEFzU0FldW9kV0o5WEVHb3BKWHdHNkNPTk9lcHpEZTRj?=
 =?utf-8?B?UTVWcDhrY2JzRFNHUXhVby93MG15TFVHaXFCTnpPNDdPUE5UbGR3S1ExWnR0?=
 =?utf-8?B?Q2dBeVY4RGtxaUJOdHd4VktZN2pXWkw2V3RFUTJ3WldJUTV6SVdDNnFNU3M1?=
 =?utf-8?B?cUQwekx5Q1cySnVnT2FhUDJEUDdxdFR6eGhwZXhEL1lMVWJKMGVGYXZnbkZ1?=
 =?utf-8?Q?V8lV4x8LPzIAanq1qpQ5YI6vO?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89628325-d2f6-4768-fe61-08de259feed7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 06:09:57.1913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLs3Cagr8x80zgs5ZqeLe0ZercVmXhE8+6Oqy4lqs3WpfzVeXGK9c0zezMG2+H8seeqT0pw9C4SA1VnAT88XVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9527
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=jan.kiszka@siemens.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 16.11.25 18:43, Philippe Mathieu-Daudé wrote:
> Hi Jan,
> 
> On 14/11/25 22:27, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>>  From the source frame, we initially need to copy out all fields after
>> data, thus starting from nonce on. Avoid expressing this indirectly by
>> pointing to the end of the data field - which also raised the attention
>> of Coverity (out-of-bound read /wrt data).
>>
> 
> Resolves: CID 1642869
> Fixes: 3acf956ea1a ("hw/sd/sdcard: Handle RPMB MAC field")
> 

Feel free to add it. But not that it is not really a bug fix IMHO. It is
a code clarification, output is identical.

>> Reported-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> Tested, not causing any regression. Please check again if Coverity is
>> happy as well. Thanks!
>>
>>   hw/sd/sd.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index 9c86c016cc..7fdb9195e0 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -1161,7 +1161,8 @@ static bool rpmb_calc_hmac(SDState *sd, const
>> RPMBDataFrame *frame,
>>             assert(RPMB_HASH_LEN <= sizeof(sd->data));
>>   -        memcpy((uint8_t *)buf + RPMB_DATA_LEN, &frame-
>> >data[RPMB_DATA_LEN],
>> +        memcpy((uint8_t *)buf + RPMB_DATA_LEN,
>> +               (uint8_t *)frame + offsetof(RPMBDataFrame, nonce),
>>                  RPMB_HASH_LEN - RPMB_DATA_LEN);
> 
> Having:
> 
> #define RPMB_HASH_LEN       (RPMB_DATA_LEN + RPMB_NONCE_LEN)
> 
> then
> 
> RPMB_HASH_LEN - RPMB_DATA_LEN = RPMB_NONCE_LEN.

This is not correct: 284 - 256 != 16

We hash 284 bytes, that is everything from data field to the end of
RPMBDataFrame.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

