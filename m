Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9D2EEF30C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 07:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy2uc-0002DC-8j; Thu, 05 Mar 2026 02:14:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vy2uY-0002Bu-LL
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 02:14:18 -0500
Received: from
 mail-switzerlandnorthazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c213::] helo=ZRAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vy2uU-0001TH-05
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 02:14:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICXON2sg22LSiyhryqw8iTn25Ecc37ny6s/W9mA2KBPyFWIhUoy97Py0/sB7fx4CkxkAYPjIqazBkZ4/S7gCdARCkeCgOF79B9cukkozp0adop2FELS5dwD8I8cWVOIOyh8Xa1Zqdc75v9TAOoxP7icUc2r3QmWD/lkXYwnOpf7MvhikEA5z7G38h5zglFrXebnwPDRz9yNc91wwbSam1o4v6DW4cul/yjr4+lKX+egZ/pyCKiXH16E4XhhsKcGFGlnIIK3rBHuduuOLmoEVqK9AySxR6pCy1MUg0jAyKoC1Nt7w8XGJzo97Ac4b0ffq1kIyW12FxZ2aeyYJsh4k6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qSEv/e+DfHB+HdC4giCJL3dhp09LuT7SfYHOrI+1xs=;
 b=nwFBiTvOUb5eoKs2KaUM3KMeEcsrfIUSZmuqegG8/7txjttf18HXyaL/SWHWhpANQTbeVOtdNBhfsgagbwT6QT2eYuPFEN9La+eMKia0vjuMWSvGpx4zUuFt+uufVck16rMr5WMxu8rzhaftuc7DbxBzFonzZa7ZWzt5GgThKsDwsZykGLXv7LHqvh5ZpES6QEleAWqMJvHNHE/2ZNDefdz7EuDKT3IQ9C0LDKsQVmkYQDKmnVM2HYGC0M2asX44DlGi8vromZTxc1h8RNhClL/tjKjUOFI2vExBNZwllbNTCYlkHAlFMcp/eVuqmpAZM+C1KO6ewn2Z1QntIWD2sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qSEv/e+DfHB+HdC4giCJL3dhp09LuT7SfYHOrI+1xs=;
 b=mkaCEfx7uqrfpVEsTPhgaCt2D+7uoqVWJlmykABs0Id6H0fsIGlkjhvJ6y3p4re2UyKR6BRLrkIA0e0xvDsb+vCon2nQfekLfRInDyqKM7Xyjjoq5rmWjZgA+3QOWTekwGlyOQtTvLkiLn4drTkGEGBWNAArqhyrbiy8Vm7kFH0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR0P278MB1091.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:54::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 07:14:02 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 07:14:02 +0000
Message-ID: <cf6dd907-0818-45c2-b5ff-f8b60e106e86@epfl.ch>
Date: Thu, 5 Mar 2026 08:14:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] Enable PC diversion via the plugin API
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, berrange@redhat.com,
 richard.henderson@linaro.org, imp@bsdimp.com
References: <20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch>
 <acd9b835-ae52-42aa-87f8-9fedccd79d04@linaro.org>
 <a9b4cb93-24e7-41fb-bb72-bacd48216c1c@epfl.ch>
 <dcafbd00-66a5-4e69-81ba-567c141a26a6@linaro.org>
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <dcafbd00-66a5-4e69-81ba-567c141a26a6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0058.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2a::9) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR0P278MB1091:EE_
X-MS-Office365-Filtering-Correlation-Id: e63e643f-511a-4065-2521-08de7a86c775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|786006|1800799024|366016|376014|19092799006; 
X-Microsoft-Antispam-Message-Info: ckfzih5cIrpwRilDP5uTZ29VuzcyxQgQwbxL//EveI7uokLdl97UKavbQiP7u07e8ubwOYVE+DPf3+JGnkSfVm+j3+HK5Run6671MYga0Gwnlf4u6gVLXo1RmhUTkMNavCD7QXvEVur8lLIZykLjrnLhvou7etAhMXcMzaeGuholXgMfTSxFJrlUHXOTfvpRdvDMaAEHWWw21X45IOFCdjnCR31JP9f2J1auFE8+ogFxfln8cOYUK7u10E+Yv2L0HgCyBIoWHNS+cNmkdfLBDzJdgAi7b0rVVJeT/4kauZIgly0hWtUBDDRe9eOr8Wd3dYIuAsPe7gjoETXkeffoOREkXd3ijdcQKWh/RN2jETRRtSECtJR6jW5r3+JmNn+eh12m8z/JtF4XiHTcODNE+x2EQtAlIn5fNrBGwY79e/VlYCymjdlNO2HQNFpoNDlCJQjIyyVO/CenIyc3PVKnhx0sTcm7+WDOUUes9TMkXXBIdaOWh6eOFquigy+iWFT2c3wtJWmR6o/+Ta8JIZ40eYhl9tt78PDavryLdCGd1pUZIijDLSZOSyu7fhvKMPYHYz5VR3CQb0nHrAjHq5nLeqNrO/9CSbaWrryi+AKQ7JHZxssmHxFRFA1ZgdVx8rgEeY0CkJIq8tMs56AIoRdCXir2wRS81yUwgYr4aIiakLHPsQsAIYuHThBW9ozfIjrRUSFiQ2m8SvMhqPvbTIoYPy3y2qRot1t9X7dp8AJDx94=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(786006)(1800799024)(366016)(376014)(19092799006); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDJhc2s5bFRVL2tURm1VMjJoUzdncDl5Q0FNNTRFc0x3ZDcvVXA3WTlyemlD?=
 =?utf-8?B?UGxEc0dYb0lVemZUcFBGclNDQ0Q3NnZqdzVzZjF5MjF5OHlVQzF2YTBZeE1y?=
 =?utf-8?B?UU1XeW15a0IzZCtRK1lrZ3FGdUMvaS8vWEl4VXFWOXdHSXJYWm5sTjhiZWo3?=
 =?utf-8?B?bkVUUzF5VU4xUnZnSFYvQzQ5UzU1eUU5MGx3VnVSbTliN1JnSlV3UGx2QjNS?=
 =?utf-8?B?M3FseDMzOHluMGdIbGhuZ2ZSKzJVS0gxTzQvQ1NCbmNxb2xDU1FJQmtNaDBq?=
 =?utf-8?B?WmpaM1k0U3MvRU4wRUxvc1lCZEpNOFlRblg0S09yVlJWRXpUVjNCSFIzeVhH?=
 =?utf-8?B?b1ZsenEvdnN2ZkVUcXNwZE5FWnRydWkyNzV1T2thRHcrdXFkV0lQbU1LU2dr?=
 =?utf-8?B?UDFpbUZXSjBZSU8wUEFGL2xvdC9seDRVUnBiOGhVdk5hVFZ4TTJqYXpWMDFm?=
 =?utf-8?B?OUR6Qkp1cFBJczQ4eWd1SGhLTDN5aS9RblkyOUxON2ZqSm1XRkF0dklDNGhW?=
 =?utf-8?B?cTZTVFlvZWRoWXRKaFl3U0M1Qk9vdVlVR05CTjVrL1NveEpwb0svNXoyNjFo?=
 =?utf-8?B?cWRVM3k4UTdSUEVZdDVXWnRmcDVKRUNybnJlTVNXUXkza05FZExxUG5EdFNX?=
 =?utf-8?B?czFKbllyOG9UNFhKR08rOTRlYS9HUjgzcUJMYU9PNlNzTkkrLzFPbGdPUE12?=
 =?utf-8?B?a0FDVDRWTGpQWi9KSjBWWG96dkF3YXAyNGRkWjZZSk9JTExLWFZNLzJWNTNU?=
 =?utf-8?B?dlVVNlJMYjRzUlJXcDNZUUhYWHlTM3Q1VGQ5cWREdTlJTGZQYmhxcWZOWWls?=
 =?utf-8?B?dW5SK1VzaHRERVc0S0ZvcVFZclBUN1N1a2Q4WXh4SkVMcmJMWGU2VUZGR0ty?=
 =?utf-8?B?dHJNL3VDUmNFT3ZVOXJMNzJBNC92Z0w5ektRdUxUSnkreGo3cTJwTzl4RmhP?=
 =?utf-8?B?eFI5eDlsYjdkQVJBQnVFTERFdHArdk1HY1FjMzNXZzc2VDV6cWhkZ1BXTmJI?=
 =?utf-8?B?eGV0MXAvcERGelFjRkllUTl6Q05KV2JESWxOaEhWVkhxbWNlM0l1algyUlox?=
 =?utf-8?B?V1FMZGU0Njk0NjhyVTlnbWRIZ1JDMHcxSzZlRVV4ejFlTEpSanNVcnNpKzBE?=
 =?utf-8?B?ZnFlZ2QweWlaSFJOT1gvU2RZaFVxL2ZhanFlY3RmMHVtR0JOVU9GUWtwWTZI?=
 =?utf-8?B?RmkyK1V3c01zZkhBQ2p2cUJFdmlPWDBGVis4UldLYlVsVEdmc2tWbmJWZC9u?=
 =?utf-8?B?dGpNTkxoUFFWWVI0VStLS2hGS2VlZGNEU2gxeFE2a0s0WGRaSCs0ZE42R2V0?=
 =?utf-8?B?RGl6YlN4VldMVTljYkg0djFkQ2x0cGZJaXNEbE02d0w4Y2dtQjdrNG8yK1gy?=
 =?utf-8?B?RFREdmtvU1Nra2JtdTJ6NjJuSW92SzBJRWJHWUt4SHBMYkExdDNTdnFwcVZr?=
 =?utf-8?B?dFRLMjdFUlMvM0VNdEc2b1MzeGRUN2V0UGdqQ1ltSW9zR25wdUlTVi9aRFZH?=
 =?utf-8?B?b25VNjVCSE43clUrTnNlQ0lvTGNRN3kxemV2NVlRek5OOVZ1djk4TzdKTjlM?=
 =?utf-8?B?ZTdVOWR5SkVkOHh0Rit2a3ZveUpBVnNielI2eVVDVC9xcVM2a2xXSWVmTXR6?=
 =?utf-8?B?ODRvM1oycUpzeHJkM2NwUVQ0Ykt4NUlQMDNVeWNhTkk4MUNEaTdyS1ZhQldP?=
 =?utf-8?B?dlp1MFV6SDlEeitCaFFtdzBpcS9qTkhzTDlNTnJvcGd0d1ZlN3RqS0tTSjI4?=
 =?utf-8?B?NWNldlIzbFdGbjQ1N1dwZlhyR3FSeHhYaW03N2VSRkI4UG5WYjcrL3VvT0FC?=
 =?utf-8?B?YVptQ2tOSjBDK3M3alpEZkNkOXdKOHFLNG5iekNZemFZQkVXNS9UT3JOM3Zr?=
 =?utf-8?B?Y09uZDRYVFpyUS9nYk55aFVWTEFwRDluZ3c4ZDBua2tJUmVQZlNvdHVldHZJ?=
 =?utf-8?B?TnBncVdNRGJ5blZnN0ZGTU1qRTc2cW45bE5TVHRPSURTTmxrYUZkVHdhSDRu?=
 =?utf-8?B?Zm1FeHBreUxQRjdpNWdyZ01xdUJqVDNrOGxHeXUzNGNnbm5QMXltckNZcFlv?=
 =?utf-8?B?OG03emxCckNoaFg3Q1FzaEFLWG1LVk0wd25hbzdBd0gxbUFaS3hTRDBUd1Bs?=
 =?utf-8?B?bWZRb0FQK010SHRaemdvelFLaUFETnowNmZ0cDFsMCt2b3UydGhKc3IvTkZE?=
 =?utf-8?B?R3A5eFBkQ0dIc1RoS2tEQytrRDJKYmg4bmtaSGU1SDF0emxSelpSVGFwd0Ny?=
 =?utf-8?B?S3E0MitiTGVoQ1NTVnZLVGJQT1VSSHFtenNGNjZxM1FPdWJ0My9naVVlMU1D?=
 =?utf-8?B?ZzY1R0xlTjBpWTRJYVBjWGxKN3FYNE45WkZhTTA1RnNCUTZSSGhQQT09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: e63e643f-511a-4065-2521-08de7a86c775
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 07:14:02.6479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7OGzzZ95sMFQPwMoyosAF443vbO1ywwh3ukw44GBKB9N4RZ0S5yE+T9DLUmg26zMPCvmCEr3sDPka6W7Q1+FhiAOFAwgpJyIEwYah1ojR+Y=
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

On 04/03/2026 18:39, Pierrick Bouvier wrote:
> On 3/4/26 2:36 AM, Florian Hofhammer wrote:
>> On 03/03/2026 20:20, Pierrick Bouvier wrote:
>>> On 3/3/26 5:07 AM, Florian Hofhammer wrote:
>>>> Hi,
>>>>
>>>> This patch series builds on top of the discussion from the thread at
>>>> https://lore.kernel.org/qemu-devel/e9bcd7c7-2d67-469e-b2f3-d1a68e456b2b@epfl.ch/
>>>> and adds a plugin API function to set the program counter of the guest,
>>>> as just writing to it via qemu_plugin_write_register() has no direct
>>>> effect.
>>>>
>>>> This version v6 of the patch series addresses the requested changes from
>>>> the previous v4 submission and an incorrect commit message from v5
>>>> (details below).
>>>> Note: checkpatch.pl still reports a warning about line length violations
>>>> in patch nr. 6/7 but I did not fix this, as the line was already > 80
>>>> characters long previously, the change added only a single character,
>>>> and I think the readability of the code is better as it is now. Please
>>>> let me know if you disagree and would like me to fix this!
>>>>
>>>> Best regards,
>>>> Florian
>>>>
>>>> Changes:
>>>> v6:
>>>> - update commit message for patch 4/7
>>>> v5:
>>>> - make QEMU abort via asserts instead of just returning an error from
>>>>     the plugin API if preconditions are violated
>>>> - extend tests for qemu_plugin_set_pc() to different contexts
>>>> - fix issues highlighted by checkpatch.pl
>>>> v4:
>>>> - switch strcmp out in favor of g_strcmp0
>>>> - split the patch introducing the qemu_plugin_set_pc() API into three
>>>>     patches, two for preparing the plugin infrastructure and the syscall
>>>>     handling code and a third introducing the actual plugin API
>>>> v3:
>>>> - make PC registers read-only across architectures
>>>> - add tests for read-only registers
>>>> - adjust test structure for qemu_plugin_set_pc() by moving
>>>>      architecture-specific tests into corresponding directories
>>>> v2:
>>>> - add setjmp() in syscall handling path to allow PC redirection from
>>>>      syscall callbacks (via longjmp(), the cpu_loop()'s setjmp() for
>>>>      exiting a TB would not be live anymore in syscall handlers)
>>>> - add flags to ensure the qemu_plugin_set_pc() API is only called from
>>>>      contexts where the CPU is live
>>>> - add test for qemu_plugin_set_pc() API
>>>> v1:
>>>> - initial version
>>>>
>>>> ---
>>>> Florian Hofhammer (7):
>>>>         plugins: add flag to specify whether PC is rw
>>>>         linux-user: make syscall emulation interruptible
>>>>         plugins: add PC diversion API function
>>>>         tests/tcg: add tests for qemu_plugin_set_pc API
>>>>         plugins: add read-only property for registers
>>>>         plugins: prohibit writing to read-only registers
>>>>         tests/tcg/plugins: test register accesses
>>>>
>>>>    MAINTAINERS                                        |   1 +
>>>>    include/plugins/qemu-plugin.h                      |  19 +++
>>>>    linux-user/aarch64/cpu_loop.c                      |   2 +-
>>>>    linux-user/alpha/cpu_loop.c                        |   2 +-
>>>>    linux-user/arm/cpu_loop.c                          |   2 +-
>>>>    linux-user/hexagon/cpu_loop.c                      |   2 +-
>>>>    linux-user/hppa/cpu_loop.c                         |   1 +
>>>>    linux-user/i386/cpu_loop.c                         |   8 +-
>>>>    linux-user/include/special-errno.h                 |   8 ++
>>>>    linux-user/loongarch64/cpu_loop.c                  |   5 +-
>>>>    linux-user/m68k/cpu_loop.c                         |   2 +-
>>>>    linux-user/microblaze/cpu_loop.c                   |   2 +-
>>>>    linux-user/mips/cpu_loop.c                         |   9 +-
>>>>    linux-user/or1k/cpu_loop.c                         |   2 +-
>>>>    linux-user/ppc/cpu_loop.c                          |  10 +-
>>>>    linux-user/riscv/cpu_loop.c                        |   2 +-
>>>>    linux-user/s390x/cpu_loop.c                        |   2 +-
>>>>    linux-user/sh4/cpu_loop.c                          |   2 +-
>>>>    linux-user/sparc/cpu_loop.c                        |   4 +-
>>>>    linux-user/syscall.c                               |  16 +++
>>>>    linux-user/xtensa/cpu_loop.c                       |   1 +
>>>>    plugins/api.c                                      |  42 ++++++-
>>>>    plugins/core.c                                     |  29 +++--
>>>>    tests/tcg/arm/Makefile.target                      |   6 +
>>>>    tests/tcg/multiarch/Makefile.target                |  17 ++-
>>>>    .../multiarch/{ => plugin}/check-plugin-output.sh  |   0
>>>>    .../{ => plugin}/test-plugin-mem-access.c          |   0
>>>>    tests/tcg/multiarch/plugin/test-plugin-set-pc.c    | 140 +++++++++++++++++++++
>>>>    tests/tcg/plugins/meson.build                      |   2 +
>>>>    tests/tcg/plugins/registers.c                      |  79 ++++++++++++
>>>>    tests/tcg/plugins/setpc.c                          | 120 ++++++++++++++++++
>>>>    31 files changed, 495 insertions(+), 42 deletions(-)
>>>> ---
>>>> base-commit: 3fb456e9a0e9eef6a71d9b49bfff596a0f0046e9
>>>> change-id: 20260303-setpc-v5-c1df30bad07f
>>>
>>> Hi Florian,
>>>
>>> it seems like there is a small issue building documentation with this series, which should be trivial to fix.
>>> https://github.com/p-b-o/qemu-ci/actions/runs/22632339221
>>
>> Sorry, I didn't catch this one before. I didn't have sphinx installed
>> locally and built without the docs.
>>
> 
> No worries, it's hard to guess all the things that you *might* miss, and it's a common mistake even for regular contributors, including myself.
> 
>> It seems as if the issue is coming from the declaration of the new API
>> as "QEMU_PLUGIN_API G_NORETURN void ..." and sphinx is tripping over the
>> "G_NORETURN" macro. To fix this, I could either change the sphinx config
>> to accept the macro, or remove the attribute from the declaration. I'd
>> personally prefer the former but I'd be happy to get your opinion on
>> this.
>>
> 
> Simply move the attribute after prototype, it's the same semantic.
> 
> diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
> index 791d223df40..0825bc9279d 100644
> --- a/include/plugins/qemu-plugin.h
> +++ b/include/plugins/qemu-plugin.h
> @@ -1055,8 +1055,7 @@ bool qemu_plugin_write_register(struct qemu_plugin_register *handle,
>   * resumes execution at that address. This function does not return.
>   */
>  QEMU_PLUGIN_API
> -G_NORETURN
> -void qemu_plugin_set_pc(uint64_t vaddr);
> +void qemu_plugin_set_pc(uint64_t vaddr) G_NORETURN;

Unfortunately, this only works if there's no C++ compiler present.
Otherwise, glib's G_NORETURN is defined as [[noreturn]] (it checks
whether the compiler supports C++11's [[noreturn]] and prioritizes this
attribute style), which cannot be placed after the function prototype.

> 
>  /**
>   * qemu_plugin_read_memory_vaddr() - read from memory using a virtual address
> 
> Regards,
> Pierrick

Best regards,
Florian

