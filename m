Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EC1EEF30E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 07:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy2vN-0002jc-By; Thu, 05 Mar 2026 02:15:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vy2vI-0002f3-KU
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 02:15:04 -0500
Received: from
 mail-switzerlandnorthazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c213::] helo=ZRAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vy2vD-0001W8-P3
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 02:15:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMS7D3fAJHaHoLKdkpFzm7aE/9xGkM0KhLAE3BnL3jCiHpnBfLjf+CscbI74v8TuOWY1N0/2cRZwISMPl2Qdkd1Ld7mU/OtuhGsD3C1BWbJqGsLHm+9gqfZn73/hgMr77gG4S8n8m67WcU1KDo7DOxLaXqZlTM4jrVPxqeSz9jkGnAPB3eVZW/Syye00VZU1gHzbFCU3eciQ/jnoGWTD7hJUU3RX+6ZioT265UI9utnsfseJTrEtWhSnK99h9txM7abtB1LNW98CJ9f7o1KTKKMyUh6zUg3u6Bh0bUCLqre+AqrziNAOkDf1v90ijIlDGxPJ5Km0kKcjzvYA7LOWgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hREnMPuv4mu/HRE0Uqt2VMxv/fHyvx36nclV/php9E=;
 b=F142nIOSwGRh/5fulLK8GX/GVghP3cVIl5cKGryHhYSXc/RAfXFFJlG3NMhblyMVFgWluoLHYfr/oozmEJkdX7LBoB4K44wibEw/QbMPLt9zawVoEQGKyP+N+oeSTB1QxMc1bkhqfs/xEN7JcmkyeVEofypjXtXEyoVXGmjeCLaUOYx77ZMCs3SawRtkzy+GfiD8kqu5Si+eGtKuN96XkTT1aYgfqaCRue/ezgf7+l64Dg1wNAhC8sFP61y/u3zlmLNKZyQ9/pKEftzxcYUe8inB4YfYwGY/dwF4opF2cOd+h5zMSFkxSIY5kv/Xl3Gw7HfLxtRrquulsER97xz2/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hREnMPuv4mu/HRE0Uqt2VMxv/fHyvx36nclV/php9E=;
 b=BzcLNDRNWg3vKkOFKYpLzDIzYUFz/xJwh1sxK39VxnNpMdp8xBA/ymCwQ3O8RJg7aDVW6rQnZDVY9netzF/Y4Sazc9lr/9yn8EsE0nr9F6lMnIwk5X2tl/OQIU/J2hw/E2w5YNBLTxOCJiiEcFzzGP+2D6WnzhPSEmsqIAuP8sQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR0P278MB1091.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:54::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 07:14:54 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 07:14:54 +0000
Message-ID: <5bb69d54-4f76-4c18-b55d-321d870f7fd7@epfl.ch>
Date: Thu, 5 Mar 2026 08:14:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/7] tests/tcg: add tests for qemu_plugin_set_pc API
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, berrange@redhat.com,
 richard.henderson@linaro.org, imp@bsdimp.com
References: <20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch>
 <20260303-setpc-v5-v6-4-15c77cfe184e@epfl.ch>
 <430d1aa6-c36c-4399-8e5f-b38a9ae1bd35@linaro.org>
 <5b8bbc1e-cb8b-44ea-822b-0bdcb6ac225f@epfl.ch>
 <5a9a17dc-9781-418c-ae23-a183234e4a53@epfl.ch>
 <eb4a6f15-a63c-48aa-a7c0-832d123b98f5@epfl.ch>
 <9e830f45-840b-4e5a-8548-c618663f9500@linaro.org>
 <ba377425-cefb-4ae5-9b56-8c6c675f27c9@linaro.org>
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <ba377425-cefb-4ae5-9b56-8c6c675f27c9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0062.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2a::13) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR0P278MB1091:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b4bc78-eae8-4a61-d23c-08de7a86e655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|786006|1800799024|366016|376014|19092799006; 
X-Microsoft-Antispam-Message-Info: H+T5Jfl00LpAb8Hi2fie2jO64FCpX+PB+L/cD2+uqdI6e9IbA7YGTWHASC4h8ESHKASsX6qOJGMomOK147GXnu2Dk/yWI3TVuGLo65cOaH4dQLZ6RsIezjEeejhnTtwmpfs4yEFw/ubINiYWp3mlgZ6s9846p5EEHAouNOjKk2YJ3wWfKDTrdccNDLoo3UnwiuU3E2jZ0YTyW9kfm62Wwavm1AzqkU2t1PlWv3D9hqdmOfgxA4PoZPsNv8m0EDLK/T49/sWn5vPX1hibBeOdK8qU4SYKTSITxDk0VkvAYh3TZFndmBY4ubgMHmgHrHFIEkfgQsskd0zwFrPuT2V1ZwvZwJxNd4zVWhC5KiiE1szC9/7h/NapcoqxYxjxePti/OGGg14lKPf7ZSntCjrZPqwhE45ElH/8zY0Ygnx0IrnWqirM23lPF1b5rI8uTRX8A0GvaMR/K6kIGy5ywhKDOMwKMzsFzybRQflv6/v4Jvn//xv0L4sb10ICIhucf2a3NQTV50dVMhH/FWPlXRK3CVYFr86ePFRdFPY8lORp/lYvEsWQ+yvYN8BTiAWkAK+Onhg6VlSjDJXfsoxXvuU6ktAhpPMTnLmp8LIY/DMt1PjePKMDVYkG6xwoFybshKWz9fz3hQ6qDCGTR5zF46I9u2nKpJKQwWSXkxccC30+2b1iaGIbaK7wT6CqBfFNBQKCuXGnxXkrrpyv8NPgaZ36zBKjnLPxG9RZdRSWbCC9JDc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(786006)(1800799024)(366016)(376014)(19092799006); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VERjeFFBUVIxelFvR0paR2x5RE9HM253K1hrQTdxRnd6MVVEQnVkWXhHSGI3?=
 =?utf-8?B?aThqdUlFT1Q0Z1RSMkZDQVJIZWRrNUxvZEs5YWhRdTZhbzNMZ0ZKcGMya25J?=
 =?utf-8?B?VHBnZHhWTGZEdi9TNUQyTk9IQ3hkR3FiSUZNUWlzNlNGZ1dlQUNLV0IwN0xj?=
 =?utf-8?B?dWc3cEM5SDVhN2RJTmEyTC9UMk9DQmNXOGd1RmxuZGpmZzBkUUd0MEloc1dw?=
 =?utf-8?B?Umo1TkVUNHEwUVYrQ1A3VTVzSWRJdWJxKzlSVXlvM2hEem9uTy9weEMwRDFh?=
 =?utf-8?B?SWoyczNXVlFqMS9WUmFkKzlKSE9EMURrM3BncUF1cFV2cEV1SHVKUnBDSWxK?=
 =?utf-8?B?R0Fra0w5OTlhK0RDRFh0dEZxY2dyWVdnYm9DQnhXL3FCTVhWZ2lCeVJqb3Av?=
 =?utf-8?B?NVU5bEZJcGpRcmdERCttV0N0TnpTS1hRZjh1N243eDlzS1dxV1RodG9QVlhG?=
 =?utf-8?B?RWJiWlYwTld4TlhiZ1NVS2x4ZmllM21KZmQzSkRaeHgzemhNcDJhd21zSmZH?=
 =?utf-8?B?OVd0ZFFUdU5jZzgyaUN6RHMwdlN4ZmwzalNsbVNaUkRZM2xZOUoyUjRZODd6?=
 =?utf-8?B?bjRaaTMwRngzYUJjdkltVVMyc29mcGJKbGJXbG1FRk12c3hxNFQ3S2NtWlc4?=
 =?utf-8?B?bTlhaEV1OHRWZlFkUzRDMWUzKy9DUGZ3eTQvMXd1UzJlTkY1bnJOU01VQUlT?=
 =?utf-8?B?QUduN3ZQeGlxTU9wZzE2aWlNMkl2TGNxcmlObnBFS0xzak1paXVTSzE2YlFR?=
 =?utf-8?B?dDh2R1pSaXlxYW4wOTM1S1JYRW9GYWY0WlZHMVBjTTZhNUx6S2xiZE4ydnh2?=
 =?utf-8?B?VWFjM2w2NmFER3RHSXFSZUwvTGluNmdnbjB4NWYvWWlMT2RDNXAyUXk1cnZa?=
 =?utf-8?B?dmNncm03V24yeFJmTGY0Qlo1cy9DUVNJZkFqQkJxd1FzQks0VEZzeGtobXdi?=
 =?utf-8?B?eDE0UU1aN2hrUVFDSUpYNTZQK1BtZWdvc3dCbm1vNUgyL1dPaEk3aUd5M0VH?=
 =?utf-8?B?UGxJNXFpSk54WitCTkNya2dzMGpDWVNrU0ZzdzJOZHg3dW5FdEZWQWpXNUpv?=
 =?utf-8?B?NG9nSEJ3b2tkZFFLbDBBYTdINURDdXR6RURkUHlYY2lYMWpYSDlpUjg2aUpm?=
 =?utf-8?B?TlBuSFh6YWJnaWZOZmMvaVl3SE4wUjhkVXhacXlNbDJ1RzFXYy84eThvdDBF?=
 =?utf-8?B?YUpQenVBc3VKTnYxbkJNaXpzMHFQeklzbG1UMHNQZklkcmg5WUNyVkxrdStL?=
 =?utf-8?B?SWpwNnlHUlJOVjZUb09XOHZNeEttb1ZhVVpTMG5xc1FmYk42UDdWU2Q5R1pR?=
 =?utf-8?B?S3FBeVh0KzZkMDAvbmFIVE91MlNQcmMrbGpxWXpVbUU5M1Bzc2h0dXcrbkgv?=
 =?utf-8?B?N2xCVGNiUkV5dkc3QklxcFFsL1VBamd2SkRFT0YwY1d3ZCt4S1haZ2VnbVZO?=
 =?utf-8?B?TTZzN1o2M1hZRWVRMFdodFB4Q3NoVkg3VjBYMGVKZnFKV0hVNWFZNVFOOHZ6?=
 =?utf-8?B?NWhvSG0rb3dka09EU0xDS2NUUUY5bWZKRVNnWW9BZys4SXUyS0dzUlorcktu?=
 =?utf-8?B?OUJCK2JBeWNqd1A3bGhEU1pXSlpSenFPanpHbks0N2dzOFdqOHZTMk9DNkZP?=
 =?utf-8?B?SzZCUFJ1RndqY0NPajJTbFRsTnNTRVNFL2dubytTby9zcjJjNU9OZHkyanl6?=
 =?utf-8?B?RUNuNHowTWkxbFhrS2pUT2cvTVdYVGUxT2hDNnIzV2tyblcrb1NMUmtpSnJi?=
 =?utf-8?B?L3BscmkzWm9YcnM2K2xoQ3lLeStkRmUwb1lRYUVGcERNSG4yeUlMNXVWWDdw?=
 =?utf-8?B?MThEa09BU0ZNdktLS2l3cFlGeDNrRjNIUnBxUWJRWHRBbVJTZFhhM3hXVXNR?=
 =?utf-8?B?dEZNS0NzSThZNkhWNkJhbnZWRzhVYUw0bStneUd4czMrZFNoYTJROC9aalNS?=
 =?utf-8?B?TlJncHhDY05jSUNwMGpLQnJ1REx4Qm9MQmNVY0hDWDlFY09xNlRRSHNVeXdR?=
 =?utf-8?B?WGgwYU1XVFVtTUkzK0lzNEcxSGgzVGJLVnJreEwxakoxUnhWYXBLMlA1TnN6?=
 =?utf-8?B?YzlEMzdGcDdwK09sZkc2V0daTHJpTGpPVmJucGt2R3VhVVg5N2FHWkxKbUdw?=
 =?utf-8?B?R25ZWXZOQkthSDVJTE9VKzZoamtjQnVQS0hIZFYwVzlVZHF1RWprRjVFMWJw?=
 =?utf-8?B?c0M4OTdGcUlmSmI0ZXUxMzNwNkFCMHd4KzRHb1ZpZDNEYXVKR0s0YVI3eHRB?=
 =?utf-8?B?NVg2Mk9WR0o4Y241THEzZ2dvTUFaUHRiYlBvd2hrU0lnT2VGYXY2cjM3VHdZ?=
 =?utf-8?B?TGczaGVSYm1lVnVMelVpTDg5KzN3MHNJK010Yi8vZ0c1WGZIeU5OQT09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b4bc78-eae8-4a61-d23c-08de7a86e655
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 07:14:54.3217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KXWCrGMnXKHwcOscFXHHerya1b4wyzRdx3LMGvAgQYGzhXRzixugfvPEv+SCLQn+/EEVYmpMpQrKDLiypRnywqYMXLyLGH4RBcJ3vIKhkU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1091
Received-SPF: pass client-ip=2a01:111:f403:c213::;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZRAP278CU002.outbound.protection.outlook.com
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

On 04/03/2026 20:38, Pierrick Bouvier wrote:
> On 3/4/26 9:56 AM, Pierrick Bouvier wrote:
>> On 3/4/26 8:18 AM, Florian Hofhammer wrote:
>>>>>>> +static bool vcpu_syscall_filter(qemu_plugin_id_t id, unsigned int vcpu_index,
>>>>>>> +                                int64_t num, uint64_t a1, uint64_t a2,
>>>>>>> +                                uint64_t a3, uint64_t a4, uint64_t a5,
>>>>>>> +                                uint64_t a6, uint64_t a7, uint64_t a8,
>>>>>>> +                                uint64_t *sysret)
>>>>>>> +{
>>>>>>> +    if (num == 4095) {
>>>>>>> +        qemu_plugin_outs("Communication syscall detected, set target_pc / "
>>>>>>> +                         "target_vaddr\n");
>>>>>>> +        source_pc = a1;
>>>>>>> +        target_pc = a2;
>>>>>>> +        target_vaddr = a3;
>>>>>>> +        if (source_pc >> 63 || target_pc >> 63 || target_vaddr >> 63) {
>>>>>>> +            /*
>>>>>>> +             * Some architectures (e.g., m68k) use 32-bit addresses with the
>>>>>>> +             * top bit set, which causes them to get sign-extended somewhere in
>>>>>>> +             * the chain to this callback. We mask the top bits off here to get
>>>>>>> +             * the actual addresses.
>>>>>>> +             */
>>>>>>
>>>>>> This looks like an actual bug. Using a backtrace here, can you find which function extended it?
>>>>>> Parameter should be treated as unsigned everywhere, else something is really going wrong.
>>>>>
>>>>> tl;dr: register values are considered signed in the syscall handling
>>>>> code, which seems incorrect to me. Details below.
>>>>>
>>>>> This seems to be a bigger issue in the syscall handling code and I'm
>>>>> surprised this never surfaced before. Generally, the CPUArchState struct
>>>>> in target/*/cpu.h defines the registers as unsigned types. When a
>>>>> syscall is encountered, the main cpu loop calls do_syscall() from
>>>>> linux-user/syscall.c, which takes and returns abi_long values. abi_long
>>>>> is defined as either int32_t or target_long in include/user/abitypes.h
>>>>> and therefore a signed type, so the register values get converted from
>>>>> unsigned to signed types here. do_syscall() passes those abi_long values
>>>>> on, e.g., to record_syscall_start() and send_through_syscall_filters(),
>>>>> which still take the register values in as abi_long. Those in turn
>>>>> however pass the values on to qemu_plugin_vcpu_syscall() and
>>>>> qemu_plugin_vcpu_syscall_filter(), respectively. Those two functions now
>>>>> take uint64_t values for the arguments, so for 32-bit architectures the
>>>>> conversion chain is uint32_t (CPUArchState) -> int32_t (do_syscall) ->
>>>>> uint64_t (callbacks).
>>>>>
>>>>> This seems to be some bigger refactoring changing all those abi_longs to
>>>>> abi_ulongs. Would you like me to prepare a separate patch series for
>>>>> this?
>>>>
>>
>> Indeed, they are signed in linux-user, so maybe my original assumption
>> that it *should* be unsigned is wrong. Let me take a look to see what
>> should be the correct semantic here.
>>
>>>> As a follow-up on this, changing this seems to be a bit more complicated
>>>> than I initially thought. The arguments could be simply made unsigned,
>>>> but the return value (which is also just a register content and should
>>>> therefore be unsigned if I understand correctly) can't easily be made
>>>> unsigned. The per-target main loop relies on the return value of
>>>> do_syscall() to be signed to determine whether one of the QEMU-specific
>>>> errors (e.g., QEMU_ERESTARTSYS) was returned.
>>>
>>> Note: some architectures already define the return value as unsigned in
>>> the main cpu loop and implicitly cast the return value of do_syscall().
>>> Given that in theory, a syscall's return value could always coincide
>>> with the values of QEMU's special errors, I'm wondering whether it would
>>> make sense to make do_syscall()'s return value unsigned and signal those
>>> special error codes out-of-band instead of in the syscall return value,
>>> e.g., either via a separate pointer argument to do_syscall() or by
>>> making do_syscall() return a struct containing both the return value and
>>> a potential error code.
>>>
>>
>> It could be a solution. I'm just a little bit relunctant to make such a
>> change now because we have limited time (soft freeze is coming next
>> week), so not the right time to make such deep changes and... it has
>> been working like that for long time.
>>
>>> But maybe I'm getting ahead of myself here, please let me know what you
>>> think!
>>>
>> Thanks for your very good analysis. I'll come back once I have more
>> information about what should be the correct fix.
>>
>> Meanwhile, and because we are close from softfreeze, just keep the
>> current hack in the test. This way, we can focus on sending your series
>> and the additional comment patch you sent.
>>
>> Thanks,
>> Pierrick
> 
> The attached patch fixes the problem by clamping syscall arguments for 32-bit targets. Return type has to be signed anyway, so no change is needed on this side.
> 
> You can add it as the first patch on your next version, and remove the hack checking the highest bit in this test, now that the problem is solved.
> 
> Regards,
> Pierrick

Ack, thanks for the patch!

Best regards,
Florian

