Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6496AF3C9A9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 16:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuuqM-0000WW-8y; Tue, 24 Feb 2026 11:01:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vuuqG-0000VZ-PQ
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:01:00 -0500
Received: from
 mail-switzerlandwestazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c214::1] helo=GVAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vuuqD-0001WE-Av
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:00:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhIc8oSU7bmKwsNyalZ1SCx3A7OfbEC69QtThPPAEQKJMpJjmBl+IZrdlC5VZxiG4EfSaG0BUPA6ED7jHA1CzPCJcTFzOLGgPpMe+zNWGHwWuI+UpKdC/nnuUrDbePXW4sGo3jtLP0PjXcqsVSVFJxwtJ7RZatWGGunwZyZznTqJKPzySYlwqK+cKAKvQyZ8Zt90mtqPmDGOhbPVEn1RdKtSFRcetPm5ISVbD+Uq973KjpeCVyiTLgqi/Hw9TT7Ztf8jdXQ5jjYpiRM3iuhysXkqqZRnqY9I2x/9a8G893sntn25oFFLzsUl67JaHRZSGnqV+gNZWxjxIZ8Tj3aEww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSxsCx7NP9O7q1S87jGOWq+PJ6RvRwmFhMlL2qAmGhA=;
 b=ijadDabVxNDaV99jBrUcqnHeArGhWVVR/UKPVl5vDEGhpHwyk6ppAXtRG2TZNZG17iuVVHsT/JEQd78pTLIyqIlHy6kon/CjkUbkwo/3AyIqUTciSGC8vvh/NoKiPbOPGHyYxBLjFZ/6Cm1ZuEKbLf3wNMtaa0FzKPV5TBs1+9DP2ECdEoinh5eyt7kh9Ly7GY/xk/bBV7Hz7x5aV3WB4/K4T0qjaRps72hmRezX4HP4s00TtgWMVPGOyTWrLSWXHQgVjbh60ugQAxS/fHBI9YNlUwnlUJloebMVNidTZIxw2DzQCXKTogz2e7/Gk6xrbe3/HBd01E6oaL147uVJKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSxsCx7NP9O7q1S87jGOWq+PJ6RvRwmFhMlL2qAmGhA=;
 b=Rl0yCviR6yURcJ3FqS2F4uaVSerux/uE3XsMA4kzfaEzp3/eFDA/h5doPFnQfNndG/56OPGuDBLcDPHI8QfdBq1PPQZaJ3r7hg39OG6K0A+PwrZMwOau/nv4D4NgVHKpr6V8D4IAAQ2ljytlqm8mnyYKD5Mg17tF38NvbJy1XRg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR3P278MB1305.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 16:00:34 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 16:00:34 +0000
Message-ID: <2ccc79ee-48ab-4097-a9cc-4d2b79ab9a8a@epfl.ch>
Date: Tue, 24 Feb 2026 16:52:18 +0100
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 4/7] tests/tcg: add test for qemu_plugin_set_pc API
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
Content-Language: en-US
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:26::26) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR3P278MB1305:EE_
X-MS-Office365-Filtering-Correlation-Id: 706d7196-299e-47bc-797c-08de73bdd619
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|786006|19092799006|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0c2SmVjUU80NXZOTC9ISlBnRXBmR3FGaitZL0RlR0xjclp2bmRGZHF4M2R5?=
 =?utf-8?B?UXZhWVQ3MW5QS3FDT204ZDg1R05vOHh1M1NBYnZVRHE3Y0xTcXFIMHF1L2tZ?=
 =?utf-8?B?c2hyeERqNTdyWFhXMjhDSTMwY2svRnk0c1Y3djJtSmltYmlmYXNsZ3B1Nm5q?=
 =?utf-8?B?NzFGM1RwQ09VcmR0K1krRU5CYXJndnBGak84ZEVjOXBMSmF5VWdMN3dUY3Ni?=
 =?utf-8?B?WURLNHUvNy9hdnhkUVViUnVZUUxVcHBpbVVxWS9aM3ZCQjlXQ0ptUVI1Qit2?=
 =?utf-8?B?VFpRelRYcmhpQU1SdUpIbGZYZ1dWR1ZRNGZ2blpjQ1dVUmhqT1ZWblhKU1Rs?=
 =?utf-8?B?NkswT3lrMWluOStqbzA5b0g3MnJrMXQwSUd6RzVjVFZoUkZQc1laQitSVWhM?=
 =?utf-8?B?NU8zRjVDcnJPbjh5Y1NKUHZOd3ErMmxoTXBMN1hZK2lYTGFFNmZ1VWl1TG1Y?=
 =?utf-8?B?OEdEbk1uTks4QVh5RjdCaXVybHZET1J4NExlUnptdUFObGpNSkxWZERxb00w?=
 =?utf-8?B?WGJOOGxYMVpmMXBveEF6WmtOakY5S2hkZGVrdVJ3c1Z6ZlU0dGlIZGo4MVc1?=
 =?utf-8?B?YmlXb1h6V2s5T09TUlhtakNDMHl3OFdQZk84bjRieFZHczFYNndvK0hlYmRw?=
 =?utf-8?B?c2Y3Wk4xT2F5ZmxOYkJWVEVzYUt1Ylp3aFQ1d0VGZ1h2S3d0NW9YZjB4ZzJt?=
 =?utf-8?B?Sm80ejlQa0V2bXRrS0x2dzE4dFY2VkYvZVA2UW5aV1BLVG8rY1RaNStmaEo2?=
 =?utf-8?B?Q29xd244NmhjOE56M0dUK2ZiUGxjY2pkd2lmQjFydDhKUFh0b3JJL1hsSkhk?=
 =?utf-8?B?WWdYV2NKREZuYW5wT21tMWh0eDcvbXN1UzJsNzJhNlpTZThYdTNJQi9qSXhk?=
 =?utf-8?B?bkRFd2lwb1NkYmRuZmgwck5TWWxjSC9hWmNpbmdHZGNpOFkzR3RRbmxWUnpK?=
 =?utf-8?B?RzdlUk12aktiYmRsUWhiSGN6ZTNXblJpNmhwaWRnM3BUZ3NZa0RQQmZ0c2lE?=
 =?utf-8?B?N3F2Qk1nS2xLOTlseFZtUllvUHhvdXRhTDRyUkt1S2Z1OUdyUTR1UnRhK1Bz?=
 =?utf-8?B?TVpNRVpmaHJNZGNyTUFibUl1bUVaOHJzQXRZSkVUQU9Hbi85QVlYZ1RPR3JR?=
 =?utf-8?B?NXNJVVBqWlVmMEVqdXN4QmdMVkZZaWJRVG4zNTZIbVd4dlgrVFRlQjhlSkpC?=
 =?utf-8?B?c0tySFFBR2NVTnZqM0I0UzNQbnZOYlcvSHZycC9BeVg2L1lGTHhicWovaTN2?=
 =?utf-8?B?Z3RId1ArcVI3TXZwdG9nRk9pckRFS1c1N1RHVEFsY2Z2UVBZK255MDlyUjA4?=
 =?utf-8?B?bFppdElqL09WQVNOSkp0UUNZNkJZYWZ0bFR5YVRDekhrVmVWNU52aTdqWEYz?=
 =?utf-8?B?R2pqdVc3S0UrcFBNd1A2N2hMTitLY1ZuM2QwY0h0K0tTUkltZGlCQzVJZVhu?=
 =?utf-8?B?dGNycTNLc1QycWxnTmc5bE8vcnpQSWE1UnJ3OTJEakRLQnNqdjdXUW1uNVF4?=
 =?utf-8?B?MXFBMlJpTGY3K0J5d0ZJRGljYTcwY1RDYUtSYzV3dFZQemE5NDRYbDlPZ3V5?=
 =?utf-8?B?OEV5T2F5YXc1b1E3Tkx1ODIwVVV2QUxWVlVyczBGUnhNeWZJY3I4T0wwYmZM?=
 =?utf-8?B?blUydDMwNHpycXBoTHhRWm0yQXFXcnRLd2lML3NmQmYzUTUxRzE1Zzd0MGlK?=
 =?utf-8?B?Nlk1VEhNN0JPYUtlR0l0ckdITEZtaVpwVDM5WW5CK1NDQy9xRDMzUWFwajBv?=
 =?utf-8?B?RlY5b2RBdUpzQU9EcFpSV1hUKzNDZHZsNXdLcGJBenRDUjd4a1RjRHRXSXVI?=
 =?utf-8?B?RzJBdnZhdmg0eFNVR1UwOXdJSjNJYi9ON0oybTVWMEhBdUhkaFg0Q1BsdkdG?=
 =?utf-8?B?WVpHQ3pENkJxeDhMbjc3YVc4VFhmREtZRFEyWVJUNWl0bW9xd1dQVUJodlZP?=
 =?utf-8?B?aDk3aGQvWXNtQkpDdDhMeDN3eURRNnRPWllYSDcwUU0vbU55NlZqRVhvWmVy?=
 =?utf-8?B?N2ltL1JueC9Qamcwd0NNdTJVV1N4bDFwM09CU1RycmhPUUk5QTQxUTFOYmRK?=
 =?utf-8?B?aktjWktNNks2M3cyemVuQklEbDkwZ1Fpb3Z4ZCtwQ0hLV0Y4VGJSQzZBY3pq?=
 =?utf-8?Q?UCbo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(786006)(19092799006)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3g4WFp5RjRpQ25CaldJcFlVY0NLUzZPWDQxdEtwVjdNSndTUnpyTStacXFt?=
 =?utf-8?B?R1FUbUI5dVpjZEpFV0toU01qYWF6cmVLdjVmeW04M01NNXdIaExQMmJ4UjBi?=
 =?utf-8?B?RU51TFU3aVFRUUc1ZTdMSnNxRC85dUpPd2krejAyU1ZHSnVhakxrcXYySVZD?=
 =?utf-8?B?QVlHRmtpZnI4UTc5L3dwbERVN25Bc3lOWm1PeEs1d2UvNXJVWXNnendDODBK?=
 =?utf-8?B?endjTkpDTFc2QjN5a09lOVBhc1Uwa1FOaFZOd0VuMDhkVnhCblFITnRkanJm?=
 =?utf-8?B?Nm9nUU1CdDZ2THFKb1NtZDNGTzNYZjdIOFhwUFkrS3lPdE4vT3RMWXF5QnIr?=
 =?utf-8?B?SWZaUmZvNkpDUTdpSzZZdnNrNDM2eUVQYkRKWWtSK0EzbVhRSVBnN0J4LzND?=
 =?utf-8?B?eG9nTC9aTWc0ZnpqM2tEWTgwb2E5UnNVcnJ2aElMNmJIb3lpUGZKVGhQbWJj?=
 =?utf-8?B?WmNDdmVmVzJzZnUvL1VCVVhMU1VWVzczVVk5alBxNWN2dUNQRTJSWnVRYm9X?=
 =?utf-8?B?ZWJUWVovNjBQTEczNXdpVEdnVXRKd3hHU1kyUXg0M0pER0ovSEU1QjkxWUFj?=
 =?utf-8?B?U0FLNU9LNlozZnppeUF3Yk9ickp4c3pKK3F2c2djVHJvSU1YdEtVSVJRQWVp?=
 =?utf-8?B?RjFsSXByckJoZlhQMkQwM0s5NmgzVUVRSTRzU3RsKzVNT1REejVqYnBlOFBN?=
 =?utf-8?B?Qy82azB3S1g1Umw1YmRYUmZIZm00YUlpTHpJMWsveXZnT2VKNmFIREEyRUJO?=
 =?utf-8?B?RENzVERRbWU5OG9IZ2hVOFBYKzlQaDVydWtiNkQ1MjFHTm5NbnEwUE05eXIz?=
 =?utf-8?B?QWtNZ0pkTEtlemFJRHQ4MlBoRUFYUEZpNkFZWTltVFdVMi9zcDVTaHFtcldP?=
 =?utf-8?B?eTZWOGI4dWdGQjFNVUZmMTV4U0xRUmtXQWVaZmVQVDVUUWQyQWxFK29OK1JY?=
 =?utf-8?B?cStOdVJjU2QzNVR6RFdGUGkxN0pVS0NhcldoWDdiVStUakphV3ZCaHFGNnNj?=
 =?utf-8?B?TjV5MGg3YVYrd09WclVZOG1KMHZ1Y1FhMFNWWDRyakt1ckN1TnI5ZGVCUjJQ?=
 =?utf-8?B?SnU5VTFCWmRYOVhqV3hPdVc1aGhrdzdvajlwVWxnR0p6MmVoMW5uRXlGZG8y?=
 =?utf-8?B?dkoxZDFzMENFL2JTYkZQNFhjL2wxVjZub1F3Z3B0VzVzQUdjR0JXUjNwc3Z3?=
 =?utf-8?B?dmlHTitRdjUzMVNmZ1dFRGhwdFdjVmxIYkFvdS9mdlNtV2dEbDZNdDJBTUVY?=
 =?utf-8?B?cHl4azh6ZzMxRjVQZFNLVHlOYUhpd3pCMGNnMjd4TlZ0bm1IT3Qrc0VQcDJs?=
 =?utf-8?B?WlJraDZubXJhT0g3L2RDaG5wQmxxYUUzVnRnRHAzMkV5cXQ2akFCaHdaNmRH?=
 =?utf-8?B?OHJvMHZLeTl3UEdBWWtPNnprUVFKYmZCMGdzWWRoZlp6QUc2VzBDS3c1NTY3?=
 =?utf-8?B?OHdOTmc0R0RVTUNiTjZDMlhvM1h1MXJrbzFvZi9NSlBDR2x6NGU0R09jM3Vj?=
 =?utf-8?B?a2p5eG5nN0hHRWZnKytObElFQUllWlByT3pra0E4UHNUZFQvRElZN1g2VmNM?=
 =?utf-8?B?WlBXZ3NSaWpWMmVKSDVic1d2ZlhjWHhlVDhrQXg2azE1Q0dmYkk5bHhqZkFW?=
 =?utf-8?B?WUMxaHB5czRHSFZoZmhXTEpCU3ozcUpIK1FrZGZBM00zMVFzc29XRDlQWWto?=
 =?utf-8?B?TGIrdVZFMnhiTmNzN1pOdCtqMFVFdTFZVEZYaGdjZGg2a1hHbElRQ1BNbkh0?=
 =?utf-8?B?cWNIdmR4Q1d0clUrNk83TTdYcXF2NUxTMERPVklrT2lkaDhyNjBKaWRSSWFS?=
 =?utf-8?B?djBPOFB6VDNGaVBTcmFXRHpONlVFSHNDbUtFL0ZmK0R2NVZwMFZsYW9vblc1?=
 =?utf-8?B?cjJTYU42bU4xeVhlbERVd0dEM0tOK0FRdTNmUzZSQTNqeXArZmtSckJJdXVy?=
 =?utf-8?B?MXBkdWw0YkZUK3pVSVZmZGQ3WkEwd2ZEdDNzcmZsNHZnMXkyd2YrWUw5NWc5?=
 =?utf-8?B?dTk1MzdwcDJHOXhUMmtmYVFtN0thbzFGQmUwS09LWitiUjdkdlo0ZkNVUDNQ?=
 =?utf-8?B?eElJeVN3TVh1N29TOVBQZE9zdVJ2c1AvSXdDMW4wdC9iTkNvZzBsTHc1QlVk?=
 =?utf-8?B?Z291UnRqbVo3anBwRURnUTQxL3hJSEFQR2NEcXA0SmlsaGlDYXJlQ0ZSWU9H?=
 =?utf-8?B?a2pzamdxaG9VVFd2cFRYc011TDdhc1V5eW9WNXlGdDhhVGtYbmYvNXVEem1B?=
 =?utf-8?B?VHgxRDJpVStPb0k3U2Z3OVphNHNQaUdJdzB3a1JnbWNSejY5RzkyYS93UTJK?=
 =?utf-8?B?S1YySFIvbkdYemlldWd3a0RtY2VYS1B1bFE1eFJ5YmVaTzdRdloydz09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 706d7196-299e-47bc-797c-08de73bdd619
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 16:00:31.2597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYEq8/iu1UP5KlewwIXzCGbVJ98uhnm7eFT/IrxZ/JGri+hhQhbw8sDLt+JYDpIlx8DigQDLr7rgYSplp+JoreRlANX6siq8JPehuq8wU0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1305
Received-SPF: pass client-ip=2a01:111:f403:c214::1;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=GVAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The test executes a non-existent syscall, which the syscall plugin
intercepts and redirects to a clean exit.
Due to architecture-specific quirks, the architecture-specific Makefiles
require setting specific compiler and linker flags in some cases.

Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 tests/tcg/arm/Makefile.target                 |  6 +++++
 tests/tcg/hexagon/Makefile.target             |  7 +++++
 tests/tcg/mips/Makefile.target                |  6 ++++-
 tests/tcg/mips64/Makefile.target              | 15 +++++++++++
 tests/tcg/mips64el/Makefile.target            | 15 +++++++++++
 tests/tcg/mipsel/Makefile.target              | 15 +++++++++++
 tests/tcg/multiarch/Makefile.target           | 22 ++++++++++++++--
 .../{ => plugin}/check-plugin-output.sh       |  0
 .../{ => plugin}/test-plugin-mem-access.c     |  0
 .../plugin/test-plugin-skip-syscalls.c        | 26 +++++++++++++++++++
 tests/tcg/plugins/syscall.c                   |  6 +++++
 tests/tcg/sparc64/Makefile.target             | 16 ++++++++++++
 12 files changed, 131 insertions(+), 3 deletions(-)
 create mode 100644 tests/tcg/mips64/Makefile.target
 create mode 100644 tests/tcg/mips64el/Makefile.target
 create mode 100644 tests/tcg/mipsel/Makefile.target
 rename tests/tcg/multiarch/{ => plugin}/check-plugin-output.sh (100%)
 rename tests/tcg/multiarch/{ => plugin}/test-plugin-mem-access.c (100%)
 create mode 100644 tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c
 create mode 100644 tests/tcg/sparc64/Makefile.target

diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 6189d7a0e2..0d8be9cd80 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -78,4 +78,10 @@ sha512-vector: sha512.c
 
 ARM_TESTS += sha512-vector
 
+ifeq ($(CONFIG_PLUGIN),y)
+# Require emitting arm32 instructions, otherwise the vCPU might accidentally
+# try to execute Thumb instructions in arm32 mode after qemu_plugin_set_pc()
+test-plugin-skip-syscalls: CFLAGS+=-marm
+endif
+
 TESTS += $(ARM_TESTS)
diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
index f86f02bb31..111dc405fa 100644
--- a/tests/tcg/hexagon/Makefile.target
+++ b/tests/tcg/hexagon/Makefile.target
@@ -126,3 +126,10 @@ v73_scalar: CFLAGS += -Wno-unused-function
 
 hvx_histogram: hvx_histogram.c hvx_histogram_row.S
 	$(CC) $(CFLAGS) $(CROSS_CC_GUEST_CFLAGS) $^ -o $@ $(LDFLAGS)
+
+ifeq ($(CONFIG_PLUGIN),y)
+# hexagon uses clang/lld which does not support -Ttext-segment but GNU ld does
+# not generally support --image-base. Therefore, the multiarch Makefile uses
+# the GNU ld flag and we special-case here for hexagon.
+override LDFLAG_TEXT_BASE = -Wl,--image-base=0x40000
+endif
diff --git a/tests/tcg/mips/Makefile.target b/tests/tcg/mips/Makefile.target
index 5d17c1706e..d08138f17b 100644
--- a/tests/tcg/mips/Makefile.target
+++ b/tests/tcg/mips/Makefile.target
@@ -9,11 +9,15 @@ MIPS_SRC=$(SRC_PATH)/tests/tcg/mips
 VPATH 		+= $(MIPS_SRC)
 
 # hello-mips is 32 bit only
-ifeq ($(findstring 64,$(TARGET_NAME)),)
 MIPS_TESTS=hello-mips
 
 TESTS += $(MIPS_TESTS)
 
 hello-mips: CFLAGS+=-mno-abicalls -fno-PIC -fno-stack-protector -mabi=32
 hello-mips: LDFLAGS+=-nostdlib
+
+ifeq ($(CONFIG_PLUGIN),y)
+# qemu-mips(el) returns ENOSYS without triggering syscall plugin callbacks
+run-plugin-test-plugin-skip-syscalls-with-libsyscall.so:
+	$(call skip-test, $<, "qemu-mips does not execute invalid syscalls")
 endif
diff --git a/tests/tcg/mips64/Makefile.target b/tests/tcg/mips64/Makefile.target
new file mode 100644
index 0000000000..5386855efc
--- /dev/null
+++ b/tests/tcg/mips64/Makefile.target
@@ -0,0 +1,15 @@
+# -*- Mode: makefile -*-
+#
+# MIPS64 - included from tests/tcg/Makefile.target
+#
+
+MIPS64_SRC=$(SRC_PATH)/tests/tcg/mips64
+
+# Set search path for all sources
+VPATH += $(MIPS64_SRC)
+
+ifeq ($(CONFIG_PLUGIN),y)
+# Require no ABI calls to avoid $t9-relative .got address calculation on MIPS64
+test-plugin-skip-syscalls: CFLAGS+=-mno-abicalls -fno-pie
+test-plugin-skip-syscalls: LDFLAGS+=-no-pie
+endif
diff --git a/tests/tcg/mips64el/Makefile.target b/tests/tcg/mips64el/Makefile.target
new file mode 100644
index 0000000000..77ac8815fe
--- /dev/null
+++ b/tests/tcg/mips64el/Makefile.target
@@ -0,0 +1,15 @@
+# -*- Mode: makefile -*-
+#
+# MIPS64EL - included from tests/tcg/Makefile.target
+#
+
+MIPS64EL_SRC=$(SRC_PATH)/tests/tcg/mips64el
+
+# Set search path for all sources
+VPATH += $(MIPS64EL_SRC)
+
+ifeq ($(CONFIG_PLUGIN),y)
+# Require no ABI calls to avoid $t9-relative .got address calculation on MIPS64
+test-plugin-skip-syscalls: CFLAGS+=-mno-abicalls -fno-pie
+test-plugin-skip-syscalls: LDFLAGS+=-no-pie
+endif
diff --git a/tests/tcg/mipsel/Makefile.target b/tests/tcg/mipsel/Makefile.target
new file mode 100644
index 0000000000..bf1bdb56b3
--- /dev/null
+++ b/tests/tcg/mipsel/Makefile.target
@@ -0,0 +1,15 @@
+# -*- Mode: makefile -*-
+#
+# MIPSEL - included from tests/tcg/Makefile.target
+#
+
+MIPSEL_SRC=$(SRC_PATH)/tests/tcg/mipsel
+
+# Set search path for all sources
+VPATH += $(MIPSEL_SRC)
+
+ifeq ($(CONFIG_PLUGIN),y)
+# qemu-mips(el) returns ENOSYS without triggering syscall plugin callbacks
+run-plugin-test-plugin-skip-syscalls-with-libsyscall.so:
+	$(call skip-test, $<, "qemu-mipsel does not execute invalid syscalls")
+endif
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 07d0b27bdd..2e2dcda425 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -14,6 +14,10 @@ ifeq ($(filter %-linux-user, $(TARGET)),$(TARGET))
 VPATH 	       += $(MULTIARCH_SRC)/linux
 MULTIARCH_SRCS += $(notdir $(wildcard $(MULTIARCH_SRC)/linux/*.c))
 endif
+ifeq ($(CONFIG_PLUGIN),y)
+VPATH 	       += $(MULTIARCH_SRC)/plugin
+MULTIARCH_SRCS += $(notdir $(wildcard $(MULTIARCH_SRC)/plugin/*.c))
+endif
 MULTIARCH_TESTS = $(MULTIARCH_SRCS:.c=)
 
 #
@@ -200,13 +204,27 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
 	PLUGIN_ARGS=$(COMMA)print-accesses=true
 run-plugin-test-plugin-mem-access-with-libmem.so: \
 	CHECK_PLUGIN_OUTPUT_COMMAND= \
-	$(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
+	$(SRC_PATH)/tests/tcg/multiarch/plugin/check-plugin-output.sh \
 	$(QEMU) $<
 run-plugin-test-plugin-syscall-filter-with-libsyscall.so:
 
 EXTRA_RUNS_WITH_PLUGIN += run-plugin-test-plugin-mem-access-with-libmem.so \
 			  run-plugin-test-plugin-syscall-filter-with-libsyscall.so
-else
+
+# Test plugin control flow redirection by skipping system calls
+# (similar functionality to syscall filter but different mechanism)
+LDFLAG_TEXT_BASE = -Wl,-Ttext-segment=0x40000
+test-plugin-skip-syscalls: LDFLAGS += $(LDFLAG_TEXT_BASE)
+test-plugin-skip-syscalls: LDFLAGS += -Wl,--section-start,.redirect=0x20000
+run-plugin-test-plugin-skip-syscalls-with-libsyscall.so:
+
+EXTRA_RUNS_WITH_PLUGIN += run-plugin-test-plugin-skip-syscalls-with-libsyscall.so
+
+else # CONFIG_PLUGIN=n
+# Do not build the syscall skipping test if it's not tested with a plugin
+# because it will simply return an error and fail the test.
+MULTIARCH_TESTS := $(filter-out test-plugin-skip-syscalls, $(MULTIARCH_TESTS))
+
 # test-plugin-syscall-filter needs syscall plugin to succeed
 test-plugin-syscall-filter: CFLAGS+=-DSKIP
 endif
diff --git a/tests/tcg/multiarch/check-plugin-output.sh b/tests/tcg/multiarch/plugin/check-plugin-output.sh
similarity index 100%
rename from tests/tcg/multiarch/check-plugin-output.sh
rename to tests/tcg/multiarch/plugin/check-plugin-output.sh
diff --git a/tests/tcg/multiarch/test-plugin-mem-access.c b/tests/tcg/multiarch/plugin/test-plugin-mem-access.c
similarity index 100%
rename from tests/tcg/multiarch/test-plugin-mem-access.c
rename to tests/tcg/multiarch/plugin/test-plugin-mem-access.c
diff --git a/tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c b/tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c
new file mode 100644
index 0000000000..1f5cbc3851
--- /dev/null
+++ b/tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c
@@ -0,0 +1,26 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This test attempts to execute an invalid syscall. The syscall test plugin
+ * should intercept this.
+ */
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+void exit_success(void) __attribute__((section(".redirect"), noinline,
+                                       noreturn, used));
+
+void exit_success(void) {
+    _exit(EXIT_SUCCESS);
+}
+
+int main(int argc, char *argv[]) {
+    long ret = syscall(0xc0deUL);
+    if (ret != 0L) {
+        perror("");
+    }
+    /* We should never get here */
+    return EXIT_FAILURE;
+}
diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index 5658f83087..b68e3cadf4 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -148,6 +148,12 @@ static void vcpu_syscall(qemu_plugin_id_t id, unsigned int vcpu_index,
             fprintf(stderr, "Error reading memory from vaddr %"PRIu64"\n", a2);
         }
     }
+
+    if (num == 0xc0deUL) {
+        /* Special syscall to test the control flow redirection functionality. */
+        qemu_plugin_outs("Marker syscall detected, jump to clean exit\n");
+        qemu_plugin_set_pc(0x20000);
+    }
 }
 
 static void vcpu_syscall_ret(qemu_plugin_id_t id, unsigned int vcpu_idx,
diff --git a/tests/tcg/sparc64/Makefile.target b/tests/tcg/sparc64/Makefile.target
new file mode 100644
index 0000000000..516927a3fc
--- /dev/null
+++ b/tests/tcg/sparc64/Makefile.target
@@ -0,0 +1,16 @@
+# -*- Mode: makefile -*-
+#
+# Sparc64 - included from tests/tcg/Makefile.target
+#
+
+SPARC64_SRC=$(SRC_PATH)/tests/tcg/sparc64
+
+# Set search path for all sources
+VPATH += $(SPARC64_SRC)
+
+ifeq ($(CONFIG_PLUGIN),y)
+# The defined addresses for the binary are not aligned correctly for sparc64
+# but adjusting them breaks other architectures, so just skip it on sparc64.
+run-plugin-test-plugin-skip-syscalls-with-libsyscall.so:
+	$(call skip-test, $<, "qemu-sparc64 does not allow mapping at our given fixed address")
+endif
-- 
2.53.0

