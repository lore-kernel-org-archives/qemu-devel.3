Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7382FEB7EC0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 10:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxjas-0004xQ-K7; Wed, 04 Mar 2026 05:36:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vxjan-0004wm-1C
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:36:38 -0500
Received: from
 mail-switzerlandwestazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c214::1] helo=GVAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vxjah-0004yh-Vz
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:36:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7zRQjZ0NzLFyegreb/3Yx5MM9gjbJYMp27HFlZ3gN1bsAJEAfs4V5WEysLWQpwgQnRZsRnZyaWu1/amgLlKYo26TNzPzbS7E/HXwQ+7J5frgtbQAIebplupmVp7HxDgOV5PgnXHohlCZdiI6pG6INUPztUH4oeYyIboEzrF9zEbciQV1W/YhMq50kEzFeXTo/9X4oS+U1DnxrxpNscCjvWXn8gjH2nocT+7zuU4luQPs7P1KJGOoSJftSOWoGUX1xsrDbgvA5T4V5alfuo4fJDFsNaoRMcGAs80qvUzEkP6fDlwBEYXS3HJ3pL1JKYJcipI603sK8HYcOTkj6i+bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIakPCLP2KcqRZbqWst75xFmd/pLcqdPo5RYJqmTPZs=;
 b=FjUK9ldPFgllFKjKofyepvVq6oRRPQQtkwAp7lzt2KCddi79JFBrGagLvSoFerhTnykEotgP4Ztv+haIe25wTr5U19Qjr46XcOliIP94sBvybWUwH9x00eLtcit0NWhNzc13CPZpgky9A0d8OWH+ogzLaSEd77Is13PHW9hgzhJWtTJrDDNF125B8LZWkn5PfciBE2+UnFllVNDE+dHQWIkZv7mMcSksoP5jLtaDMKjOTEx9R5SA6zrakABH7Ouzli7t3XvFnxVwQfJO8Ig+/Y9caadF/T9q6S1IjS/0sq/ZX/6aS9De+8W9PxBTFYj0Grx2hJVZ4MnzFCk0EgogJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIakPCLP2KcqRZbqWst75xFmd/pLcqdPo5RYJqmTPZs=;
 b=ZfuXJ6dRPo9HQxtu/Exdmwq6nY7LpaR97c+Ik636sENfAMecImsG6LIBtIWi5+234Qbb17cTEss44HWx8NIds88jJtiPk2k6M5U9nif900ENgGUz4OnjYoFsX56EEktG4LMrkQNkuTb8L+ZRZHc1WRR/haspGF+Yj1VmjVsOqx4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR3P278MB1665.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:8d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 10:36:27 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 10:36:26 +0000
Message-ID: <a9b4cb93-24e7-41fb-bb72-bacd48216c1c@epfl.ch>
Date: Wed, 4 Mar 2026 11:36:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] Enable PC diversion via the plugin API
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, berrange@redhat.com,
 richard.henderson@linaro.org, imp@bsdimp.com
References: <20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch>
 <acd9b835-ae52-42aa-87f8-9fedccd79d04@linaro.org>
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
In-Reply-To: <acd9b835-ae52-42aa-87f8-9fedccd79d04@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="------------ms070708060403040400060306"
X-ClientProxiedBy: GV0P278CA0084.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::17) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR3P278MB1665:EE_
X-MS-Office365-Filtering-Correlation-Id: ac5af0c2-2322-4a89-d2bc-08de79d9e377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|19092799006|786006|1800799024; 
X-Microsoft-Antispam-Message-Info: BSbH1WlSkt7kw36Hb9CtPqdID8CqlqSK++/iqE/FD2CF5wtskzSirg8EycOvSeqVbwn6LxODE1vf8yZQP+WJNLor+9iW7OpJ5zFXUPvasQYlA5QOcaDduf9Pp6J4YrdwrYhm0EXhqTBlHUssY/il/q6nQQnS2hxVGul7cyjIVOtunSaBdoVkpKX4HRwxwvNiMsNy0Cq4bi5kU/mGPnYzn3YZDNJlWNYzbvE0HL8MTKY8xmqrC2DvHaiTep9OropZ/SOQ+nM2VUUzT1qrwiyhZ12YUfAGMLNB0ZG9kXrhupuzBWeLWl8eTkF4vEuTALf/JYYiO3JDMGKnmUfq7M9gF9cWhjXSYIrx/9lS69ttZBNCBHCHyIWB+MG0EX6T5XjG43//Qurk+xS//FMxzhUOM6ZI0JiapP8Wm7pPal9FGYPRWPzQ7+ovScfO425+Z2OEwQ8Sp+JVA8BkGwjr9m5wHTs2ueMwwCtz1hydYN14jPZTjtkBhs0QNg7B2kKjYwUVaYf8d2Uo8c1pnzRAIpyPDWWimQ0ao9UCphnmHzfkB8j8uq8GbFjQQwBvQAQhGCZ8xluB6qUZH4m9phyPFHgpIy8Wujl9/8F+biK8v2bPNg3yeWDNKm8/AbMyorgJU65ciTV3rzk1Ieu2FxfnLDjat70DbvVtgXNW5347g7nshr2rSLy0GdN4ZDxUs4A1aTtmYZJOI3gnYoLhEE1N2askvYzkLS23s9zn3WclOxTrT96vz98ZHf1pSm2tAm3Ktp1V
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(19092799006)(786006)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2g1aGdUTXF0djZxUHB0V0ZnVHR4M3ZiVDhkOXZ5dUhVWTV1SDAzdzZFRkcx?=
 =?utf-8?B?RnVyM0k0aFlBcHl5bUt0a1Q1UE1JblpNQ3ZyMEdUTnhQNVI3RVZjNEttczlP?=
 =?utf-8?B?cFN4YUNaQ0s5WWR4UytMdFp2VkxTWkFmTC9sOEUzZHVweXVFZ0toTWlGS244?=
 =?utf-8?B?NFZZR2Q1UGQxemNqSnFja3hsYUxCbTVoQ2NHKzhVOGN6RGs2YkVFSnpzc3VC?=
 =?utf-8?B?cndvS2IyTldnUzdDdzRQL2RXLy82ZE9lVElGb3lGZ29Jd2U5MXNKVFp0WFZW?=
 =?utf-8?B?M05uY2VQb0F2akdTeDd5ZWhDZlBjTUdxeFhSbzFuS2VQT0hIUFN5anAvd0c5?=
 =?utf-8?B?dDVSQUY3ZnJuOEJ5TkYzaFdKZHFjMklnR1ZzT2dNcElCU0tCVVdCM1lxWTlJ?=
 =?utf-8?B?c3IzSHlpVUdXN1pUeDV3aElNdTdsZGN1d1AxU3YyN1lXaFZtenJyOXhQUmlD?=
 =?utf-8?B?RHBhb01kNHN4ZHhoSTZpbSt4OURwK3JhNEFjYUVKR2dQejJOdE4zNmwwMW01?=
 =?utf-8?B?VDJiNDNIY0tmbXBsM0wxQnRrOFNRblE2TzljbUV3dFZpWWRPZUxlOUQ3TEVu?=
 =?utf-8?B?dm96MThFeTBaeUdSbkZtWndxUkxtdUthZjVrU1VSdW1jTzQwRGZaSEIxYUph?=
 =?utf-8?B?ank4MjFZYzEvT0hCT05yb0pVdVdzb2o2MEpxc0o2ZllzalpFUzc4SURsMURu?=
 =?utf-8?B?Q0N0bityendYMTZCUnlwTjJTVW1Oc1FYUG96UHh5dm1QSitDY25yRVhnOFBS?=
 =?utf-8?B?T3BFNnVaY2Z0MmJFMFVrbjQzR0FkZnVVMHhJakhRQ01oWXh4WWF3LzF1WllB?=
 =?utf-8?B?LzMxak1EUlFrRXpQT2dGREJXaUhyN3VWYW5YQXZYWnBuYjlOWS84MEhhRzlH?=
 =?utf-8?B?enY4MVRKSVRncStVRVc2bzFoMkVibjZaOC93eGdRci9kWk5oK3JacVRyaWdD?=
 =?utf-8?B?aTR0cko5dHRGcnI4UzFXOW1vSVJOOFZRSjg5V29lY0pFcXE4bTdodWRzY1lQ?=
 =?utf-8?B?N0ZOQWdSTlYvZWg3VUU0dFRmeFMvS1dtREtEeFNWekFVdEpaaUh1RFFIYkV4?=
 =?utf-8?B?MVF0S0M1UTVuMnQ5cUxPa2RjNzRHRnZDWW11ZFdVaTdGaFFhWlhxcTluYkdp?=
 =?utf-8?B?aytWMEtZMTVwN1NYTFR6WVVsd3ZIMk8vcVMwNHhoUkRxeitkSHk0MWYxbTRN?=
 =?utf-8?B?OEsrNmFENEZNU203OVBWUDdZQVVrMG1zc2Zxd0RHL2NjVnpQQU0vZUZ6SDFR?=
 =?utf-8?B?K1UyL25CUXNtSElPbmUybU9OZEZobHI1cmpjdlcxelhiWStQbHdPUEROd0s0?=
 =?utf-8?B?UHdqS0pla2RkQndpVlp3UlN0N2MwY3JINjFaMms2bUwyalpNMnhabk90UzNH?=
 =?utf-8?B?QkYvZmFtR3Z2bCtWallzb0xZbUFTQm5hMlFaQVFEellJVEhDejhDRG9aaGdk?=
 =?utf-8?B?WWcvOHZBeTIrek00NzB5end1czhPTG4xTnVaMVp5KytiUnJOczBnTTFreUNn?=
 =?utf-8?B?bHBaYnhHZjZpM0pxK2NLdVk4Umt0dExxUEVPU1RNSGxYR1puU24yUjJDZXZl?=
 =?utf-8?B?WWVlcEptTU4wcHp5eWxubGlIQ05GdHdkYWpMMldaRkRZQStRMXdmREJ6RmVl?=
 =?utf-8?B?Y2xnQXpITFNxeVhUNDB0Z0VLNDg1MzJtN0VtdmU2S2lYaFM5alZENklJVFNQ?=
 =?utf-8?B?ZXJ0Y0lLYWd4Z3Nqb1c1YUlHWENVa0dGN29lVGp0aCtmVWdQZzZaa08vbGV0?=
 =?utf-8?B?dGJqTjAwRkxTb2NXSktRL2grWjRZY0Rjc0pETGhWbThuOHgvc3ZSTGhIc0Rh?=
 =?utf-8?B?TDVsK01EVkxwdHBERm9ZclExU3N2VzJ3dm4yWGl5SG5NVEhTTGlxdzBjTjBo?=
 =?utf-8?B?bHlvbmh0Y0JVY0ZxSU8rbTNWTWQ4V0N1WllQQXFhdXlFeFVSTURrS3MxUy9z?=
 =?utf-8?B?bkgzeHlYb0xjU3hOUnVVSzVKVlRRNlVBK3NRL0VmWkFKWWNnTG5hN0ROU3JN?=
 =?utf-8?B?amp4djl5MjV6NE9vNjZXYm9TcXlkUk1pTk5Nbkc0RXJ4ekxEMWxvanlMaEZy?=
 =?utf-8?B?YzFjZHdKbkEyeWhPMnB0cW1KeWNyNzNIMk84dk44Qk41UWt4SXFyVUJ5MkFz?=
 =?utf-8?B?U1docGdCYlpQNndXcEFGQWF1VUFBY3hsVlZkNlFoMjNHcSswNUxsU2UySFNH?=
 =?utf-8?B?K0pLc0tKQ2J3OEFEVDRLVHBibUNrSHZLWm8zQ0QrbnRqVFhWNmpLdnpZRDNn?=
 =?utf-8?B?bEhoL01jYVhNTzJOL1FXUDlIYWprc2lXVUNpcHAvQ1VHUkgxVE5JZlNtNHN1?=
 =?utf-8?B?S0k0cXJRMUJlSmJqcVpPU1NQNGh1MDNTU3BxVGpYSFYvSUZZbnNwdz09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5af0c2-2322-4a89-d2bc-08de79d9e377
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 10:36:26.6630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XxhDHqOOODV4z0fpGXB8GeFAZrcDVRaiARiKnSKwJHVmDv0Dhu2q71hfjl+amWUcPrygrcsjXRxtBqQG5jg1oWrNOOUVIHTstb6zyoFTGfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1665
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

--------------ms070708060403040400060306
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/03/2026 20:20, Pierrick Bouvier wrote:
> On 3/3/26 5:07 AM, Florian Hofhammer wrote:
>> Hi,
>>
>> This patch series builds on top of the discussion from the thread at
>> https://lore.kernel.org/qemu-devel/e9bcd7c7-2d67-469e-b2f3-d1a68e456b2=
b@epfl.ch/
>> and adds a plugin API function to set the program counter of the guest=
,
>> as just writing to it via qemu_plugin_write_register() has no direct
>> effect.
>>
>> This version v6 of the patch series addresses the requested changes fr=
om
>> the previous v4 submission and an incorrect commit message from v5
>> (details below).
>> Note: checkpatch.pl still reports a warning about line length violatio=
ns
>> in patch nr. 6/7 but I did not fix this, as the line was already > 80
>> characters long previously, the change added only a single character,
>> and I think the readability of the code is better as it is now. Please=

>> let me know if you disagree and would like me to fix this!
>>
>> Best regards,
>> Florian
>>
>> Changes:
>> v6:
>> - update commit message for patch 4/7
>> v5:
>> - make QEMU abort via asserts instead of just returning an error from
>>    the plugin API if preconditions are violated
>> - extend tests for qemu_plugin_set_pc() to different contexts
>> - fix issues highlighted by checkpatch.pl
>> v4:
>> - switch strcmp out in favor of g_strcmp0
>> - split the patch introducing the qemu_plugin_set_pc() API into three
>>    patches, two for preparing the plugin infrastructure and the syscal=
l
>>    handling code and a third introducing the actual plugin API
>> v3:
>> - make PC registers read-only across architectures
>> - add tests for read-only registers
>> - adjust test structure for qemu_plugin_set_pc() by moving
>>     architecture-specific tests into corresponding directories
>> v2:
>> - add setjmp() in syscall handling path to allow PC redirection from
>>     syscall callbacks (via longjmp(), the cpu_loop()'s setjmp() for
>>     exiting a TB would not be live anymore in syscall handlers)
>> - add flags to ensure the qemu_plugin_set_pc() API is only called from=

>>     contexts where the CPU is live
>> - add test for qemu_plugin_set_pc() API
>> v1:
>> - initial version
>>
>> ---
>> Florian Hofhammer (7):
>>        plugins: add flag to specify whether PC is rw
>>        linux-user: make syscall emulation interruptible
>>        plugins: add PC diversion API function
>>        tests/tcg: add tests for qemu_plugin_set_pc API
>>        plugins: add read-only property for registers
>>        plugins: prohibit writing to read-only registers
>>        tests/tcg/plugins: test register accesses
>>
>>   MAINTAINERS                                        |   1 +
>>   include/plugins/qemu-plugin.h                      |  19 +++
>>   linux-user/aarch64/cpu_loop.c                      |   2 +-
>>   linux-user/alpha/cpu_loop.c                        |   2 +-
>>   linux-user/arm/cpu_loop.c                          |   2 +-
>>   linux-user/hexagon/cpu_loop.c                      |   2 +-
>>   linux-user/hppa/cpu_loop.c                         |   1 +
>>   linux-user/i386/cpu_loop.c                         |   8 +-
>>   linux-user/include/special-errno.h                 |   8 ++
>>   linux-user/loongarch64/cpu_loop.c                  |   5 +-
>>   linux-user/m68k/cpu_loop.c                         |   2 +-
>>   linux-user/microblaze/cpu_loop.c                   |   2 +-
>>   linux-user/mips/cpu_loop.c                         |   9 +-
>>   linux-user/or1k/cpu_loop.c                         |   2 +-
>>   linux-user/ppc/cpu_loop.c                          |  10 +-
>>   linux-user/riscv/cpu_loop.c                        |   2 +-
>>   linux-user/s390x/cpu_loop.c                        |   2 +-
>>   linux-user/sh4/cpu_loop.c                          |   2 +-
>>   linux-user/sparc/cpu_loop.c                        |   4 +-
>>   linux-user/syscall.c                               |  16 +++
>>   linux-user/xtensa/cpu_loop.c                       |   1 +
>>   plugins/api.c                                      |  42 ++++++-
>>   plugins/core.c                                     |  29 +++--
>>   tests/tcg/arm/Makefile.target                      |   6 +
>>   tests/tcg/multiarch/Makefile.target                |  17 ++-
>>   .../multiarch/{ =3D> plugin}/check-plugin-output.sh  |   0
>>   .../{ =3D> plugin}/test-plugin-mem-access.c          |   0
>>   tests/tcg/multiarch/plugin/test-plugin-set-pc.c    | 140 +++++++++++=
++++++++++
>>   tests/tcg/plugins/meson.build                      |   2 +
>>   tests/tcg/plugins/registers.c                      |  79 +++++++++++=
+
>>   tests/tcg/plugins/setpc.c                          | 120 +++++++++++=
+++++++
>>   31 files changed, 495 insertions(+), 42 deletions(-)
>> ---
>> base-commit: 3fb456e9a0e9eef6a71d9b49bfff596a0f0046e9
>> change-id: 20260303-setpc-v5-c1df30bad07f
>=20
> Hi Florian,
>=20
> it seems like there is a small issue building documentation with this s=
eries, which should be trivial to fix.
> https://github.com/p-b-o/qemu-ci/actions/runs/22632339221

Sorry, I didn't catch this one before. I didn't have sphinx installed
locally and built without the docs.

It seems as if the issue is coming from the declaration of the new API
as "QEMU_PLUGIN_API G_NORETURN void ..." and sphinx is tripping over the
"G_NORETURN" macro. To fix this, I could either change the sphinx config
to accept the macro, or remove the attribute from the declaration. I'd
personally prefer the former but I'd be happy to get your opinion on
this.

Best regards,
Florian

> For v7, you can run this by yourself before sending the series. It's ea=
sy, quick and instructions are here:
> https://github.com/p-b-o/qemu-ci?tab=3Dreadme-ov-file#qemu-ci
>=20
> It simply saves time by making sure we don't need to pull, build and ru=
n any test by ourselves. If any failure is left when making a pull reques=
t on GitLab, it will be our personal responsibility to fix it.
>=20
> Regards,
> Pierrick

--------------ms070708060403040400060306
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DD0wggWvMIIEl6ADAgECAhANkOKMSmGXhF5eMl0rsRhvMA0GCSqGSIb3DQEBDAUAMGUxCzAJ
BgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2Vy
dC5jb20xJDAiBgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBHMjAeFw0yNDAzMTMw
MDAwMDBaFw0zNDAzMTIyMzU5NTlaMGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2Vy
dCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNI
QTM4NCAyMDI0IENBMTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOfSIeC0vv1x
PQ+dgSxbIIrkaru6skAWJYaGFzmvq4Kq+2wU2jxhcWlJg/JeP5jEkq/LM3pn5aaLao79j+XR
mS7J1ZpJKUODJVoM4s9MQJhTMvo4qS5ZS64g6QR7Obkz3I1Lr3aWeSBmDDEyzue+NKtuWZ1C
xy3RdXo/w5HgRc3l2AercOM3Gt1XonTzEtTbZ/Hwc0Sn9Gz8RmGRK6Ka4hVDl8q/2l110KaV
233Kh5etP0csXS8MIMdVRfRu3sc5hp13DG7lCKzK72a2GEpI8Wpl26G6I1/LMzz/98T+FqjT
qxsdquk7Cj7m2vKGLW1BorpQH7WFGPdJQXJe1hfbfiZACcVdCtl4nAacFacmsiArZBfX7AQG
L7isvHUwwYFEtcApyGW4p2Lt+t8nvU0CANA6BHOpOz1xOP8WmAESbUriIjyuTUf3fJ9oDNCu
rVqhASMJCDaWI3lYX/QAoiAzt6akqbbZxo2ujW7mGGqc0KxqE2csh2T79v7pC8aUtHBfwNrT
R19GnZVxE0eQ7ViIQhR6mpSaUQFA9sG+cmD2G8TnCgYsLa0q8De6F61aCBevQGHNzrbZ3JAM
neveYg/Jy1XxQHDRcvrMfWKe0jjcWbdKYlaGVPm5V1ILwYz7Yv5ewo3NUrxIGJiywe9qPhuJ
SDZs7VehTuI0FxGIsgKzVjgbAgMBAAGjggFcMIIBWDASBgNVHRMBAf8ECDAGAQH/AgEAMB0G
A1UdDgQWBBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAfBgNVHSMEGDAWgBTOw0q5mVXyuNtgv6l+
vVa1lzan1jAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MHkGCCsGAQUFBwEBBG0wazAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEMGCCsGAQUFBzAChjdodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1
cmVkSURSb290RzIuY3J0MEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0
LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RHMi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0G
CSqGSIb3DQEBDAUAA4IBAQA+b8Uw53sDspdZgukU+qzLyyHkcjlxGGhHlP+zrmDLKm1wEFvC
RS2pili3Hy67i8N4N5NUvw5Rg6kv3lxb9S9Rktxk43k+tvm68pl7OxQE55ZjVY87P0lUPGwE
qOOwLLyH02ZQcsfq5p5LrOH90JvmvZ1yy73HS+VpDAqOlytE0NSvTIRqFFkKQGQwfjvtql9Y
flujuNNvJztjBaHKYZsnNSg+J38ojYq4TP3pSg3UdVH0PncVjPQyqxC9xef5Xae92Kbkzol3
x7Nel3A1bwAkalrDMspvTHvey6LfiBksFIqviTnoy7fgjaRAJgHS+RXx/cmuRd3rUAclSVVr
Yu8RMIIGhjCCBG6gAwIBAgIQAggtinx6OJLKM4FVztNyWTANBgkqhkiG9w0BAQsFADBiMQsw
CQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQsIEluYy4xOjA4BgNVBAMTMURpZ2lDZXJ0
IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQgMjAyNCBDQTEwHhcNMjUwNTI4MDAw
MDAwWhcNMjgwNTMwMjM1OTU5WjCBrDEOMAwGA1UEYRMFR09WQ0gxCzAJBgNVBAYTAkNIMREw
DwYDVQQHEwhMYXVzYW5uZTE0MDIGA1UECgwrw4ljb2xlIHBvbHl0ZWNobmlxdWUgZsOpZMOp
cmFsZSBkZSBMYXVzYW5uZTEaMBgGA1UEAxMRRmxvcmlhbiBIb2ZoYW1tZXIxKDAmBgkqhkiG
9w0BCQEWGWZsb3JpYW4uaG9maGFtbWVyQGVwZmwuY2gwggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQDZkbG07NgfFKDNM3VI4qQdU1fVIGUQnN6BO2zeqoUdytNIzxOX6n7HxM+o
CLa01AnxaL59DXwFTXIg0OVq5ETAoLshUwnkYeWhKZH4Ysoq74QGVFihjrrs41d+8o+ymG2F
cZBMzQ/RO4KzFhmlaZ/E+1d2F7/O3x8LohaFxxBsN0+qonMreRQGx+ialMmbARFJkVuinuB4
3hZ8eRVmXy8A4R8ywakunaCNm15+eIQtptCs3IH5UqPEEOn16ANekWr7z5mZJh3ApxreflA/
iwJKWd/Ljga90TJXjTFc7sNA0RgA78Edqw7BE+D2VUcPMshdhKYNB1BVHZS81anGL7RFAgMB
AAGjggHrMIIB5zAfBgNVHSMEGDAWgBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAdBgNVHQ4EFgQU
ogXJJmzPazWg0eBlf1DbolocD3gwJAYDVR0RBB0wG4EZZmxvcmlhbi5ob2ZoYW1tZXJAZXBm
bC5jaDAUBgNVHSAEDTALMAkGB2eBDAEFAwEwDgYDVR0PAQH/BAQDAgWgMB0GA1UdJQQWMBQG
CCsGAQUFBwMCBggrBgEFBQcDBDCBqQYDVR0fBIGhMIGeME2gS6BJhkdodHRwOi8vY3JsMy5k
aWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZTSEEzODQyMDI0Q0Ex
LmNybDBNoEugSYZHaHR0cDovL2NybDQuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcy
U01JTUVSU0E0MDk2U0hBMzg0MjAyNENBMS5jcmwwgY0GCCsGAQUFBwEBBIGAMH4wJAYIKwYB
BQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBWBggrBgEFBQcwAoZKaHR0cDovL2Nh
Y2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcyU01JTUVSU0E0MDk2U0hBMzg0
MjAyNENBMS5jcnQwDQYJKoZIhvcNAQELBQADggIBAD3Ne2mHg2ctxRIflrx/T2yBDnQunFhe
SRwBnFIaOvCG05KE9iit2I2sazC5xqdp292spCoP9Qa4MOJg22BFmTnN9XnOjcEv9KFPSMaA
ITLu8CXyewPb0xLET8WqdEe5AravlneZ9/H0ve9Ufhk3wbJPKK5yijcKYmEYH21JBtZ1pnjs
fVEXAETdKkp9LC5sVeYeFk67BbUTPrFl37pha3TynPwJAiXDJFR2uI2JVGESQFyWkeO/bY5T
DCf6VIp3d1p++XoOTVseFE8OqaHZYGN+DgSK4ejT19c/GgjQqoWVK+xSvHEEsoLfOADKcYFN
M0ptGrFYpdRWJO0CKukBUAk8fpriJ/OjhSVQltCpN3pK1DPXnPrXTROXGacb3PNSUyeDlP2/
y0FqpEY7GjwMZMdu+U/rHhMGbDmv/ZBLGwiGzQVmld5je+d8nvZTamE1iBA8Nhmuz6wg6yN1
qx9b7Jn/9yQebxvHddnvz6jw6FDnw2bhq7z88eH3mYZYZ48Fhr8J87horGotEDKTDNHkF1Oe
FSxhIx0a7yoe1I66R5tapkRlNgI5EX53e/npP4ruND5bQFWDI7JGkKrLlAjQR/dNahXXX/Ry
rCfngiHZcAQakPkQrlrZCxMhlIKvDMunATaICyjnHizEC+1qzJsdvJgSC8sOzLxiEjlx3MRe
CswFMYIEezCCBHcCAQEwdjBiMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQsIElu
Yy4xOjA4BgNVBAMTMURpZ2lDZXJ0IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQg
MjAyNCBDQTECEAIILYp8ejiSyjOBVc7TclkwDQYJYIZIAWUDBAIBBQCgggLWMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDMwNDEwMzYyNVowLwYJKoZI
hvcNAQkEMSIEILhlscwqoZAxDN1alestIlm/UnOp1/3tGKl2mtsCrrQDMIGFBgkrBgEEAYI3
EAQxeDB2MGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UE
AxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMQIQ
Aggtinx6OJLKM4FVztNyWTCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYTAlVTMRcw
FQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBT
TUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMQIQAggtinx6OJLKM4FVztNyWTCCAVcGCSqG
SIb3DQEJDzGCAUgwggFEMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcw
DQYIKoZIhvcNAwICAQUwDQYIKoZIhvcNAwICAQUwBwYFKw4DAgcwDQYIKoZIhvcNAwICAQUw
BwYFKw4DAhowCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgMwCwYJYIZI
AWUDBAIEMAsGCWCGSAFlAwQCBzALBglghkgBZQMEAggwCwYJYIZIAWUDBAIJMAsGCWCGSAFl
AwQCCjALBgkqhkiG9w0BAQEwCwYJK4EFEIZIPwACMAgGBiuBBAELADAIBgYrgQQBCwEwCAYG
K4EEAQsCMAgGBiuBBAELAzALBgkrgQUQhkg/AAMwCAYGK4EEAQ4AMAgGBiuBBAEOATAIBgYr
gQQBDgIwCAYGK4EEAQ4DMA0GCSqGSIb3DQEBAQUABIIBADY06MJSg8NX3S017gc2tkd+pm14
6vvg0TcQ9f2e7r+29eHldr1P0bRyYoDYDVkm61mFeBPNdAso7LCELNXWROG3Td2WMcEaQYcC
8w6JXsYyx3fGX9gG0SdF2nZkxQjWRctlq/8oC7dxuLME6xoxLXuhcxeDkQYa5sbD+/dEljn5
z2ZSqbGXXcTQshMBq0S+HGYAGJbMrbT+iHbchmVPTLFUJjVemwi0gt8+HZQl/GKy79OmM/aJ
H/38vxgFm5CoCPL7d9dO7M2gJO72sCPh4r9Sv37z1ZXJ1d+4r4DRmVFm0753wwGcVwQ+UADH
Yz4sV4GiLhkUnAU5psND02ehSnAAAAAAAAA=

--------------ms070708060403040400060306--

