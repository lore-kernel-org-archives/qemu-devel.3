Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E6DEC048C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 10:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxMgK-0001e1-C3; Tue, 03 Mar 2026 05:08:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vxMgI-0001dJ-7M
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:08:46 -0500
Received: from
 mail-switzerlandnorthazlp170110002.outbound.protection.outlook.com
 ([2a01:111:f403:c213::2] helo=ZRZP278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vxMgF-0005F5-S1
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:08:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqmWqOAMLBW10QYb1yaQHfqwy9xDtpsPfPWjcwyjIQ1CWVQ7RcoBTO4gTdbm9XUNiFqozkIvbhStKaKF7Mgtcuzaws0ii95xldXpLbzuR27tJYS8/rUnd20/3QXTcPsAPOoNGD5faKzTWeOuiqhaVjxU8NPQfJFoMpEkUaYRaLFKBEiPRVNco5Ixtns45sUdByLdieo3LoG4Sg/Aats0m058+6KhAdcPywhHVKmeEPvdCR8m18RqwIJccH0p4YLgjm4PDa34FFaBllERyojCFYms8QT5k2Cf+qOXgrHQbDPvRB+NkntpgAw5np5GA272kuHRzqJCi/WWcG+J01PRWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4X54Gr+rILBiVZFDBIA7CKkQVZsYj5xxo2KdQ5zfLLE=;
 b=EHDSxqfbrs2RyAHprGRFNTe1LSxLUKjRMWM0eV/tN710HgxqaGbN4umH1Acqoxjrokaqiv8ntmgLoVJRmOVJPCrzZdf1QHXSN5p83b0VthGZI3DIVfJ7yuQpOGDoF/w2RIgDo339YjkbYmpLAehici3aPKiwfQarRiohLLpYNRsH6PdidJitSBxWWWOwa+8jomZ74Lx8OViqr55xjgGYjmQSEGK1Kn3Mq9lHkG0ioGzTGYmneRjabp2/Z1JaJ6Z/UvOMbfTGtfKyIcFnYRdAi15NAPFf7DLF0H+1FK6KI2ZNgwki0vH00ZoWzvV9c3046xiD7hj8R/gCNXnkzESPsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4X54Gr+rILBiVZFDBIA7CKkQVZsYj5xxo2KdQ5zfLLE=;
 b=VeSLl/FI5nDhdfgptKU5J/7OKAID1W6ia0pTLKDHtWErr2BtQqUjRP1Ykv/Cq2CLKNY5xoKzuyLHnZGc4UZvKBJ3rS5sInwDEAjiXe6iSaIO79Jp7Q23gp6h+FyYTSNsJpy7QdUnwYGjJqW8Hvl18H/3NzWZ1lrWW77SVA5EpfY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::2a0)
 by ZR4P278MB1902.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 10:08:40 +0000
Received: from ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6830:19f2:4a5b:749e]) by ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6830:19f2:4a5b:749e%2]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 10:08:40 +0000
Message-ID: <e706ebac-e1ac-42f8-a1c0-3a0124afcd54@epfl.ch>
Date: Tue, 3 Mar 2026 11:08:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] Enable PC diversion via the plugin API
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
References: <1739da2c-2ea6-4bc7-be6f-981f8658ce3f@epfl.ch>
Content-Language: en-US
In-Reply-To: <1739da2c-2ea6-4bc7-be6f-981f8658ce3f@epfl.ch>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="------------ms050006050604060409080005"
X-ClientProxiedBy: GV0P278CA0073.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::6) To ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::2a0)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PPF9AC83A6B5:EE_|ZR4P278MB1902:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b8ea8d-625f-4ffb-1b9b-08de790cd7d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|786006|366016|19092799006|1800799024; 
X-Microsoft-Antispam-Message-Info: kBhPyR52GlVUbmdNeopFR0yZ+OYPp0eTd29mtJ0KYOcxZoH5HXRy8L+oKcpmezZdV8PVW9ohCrwOle5Jq0GjqFKVNMyWdvlDnUEbfNpnJHk0f1QyC4dgMSm/1AQXF5CLGckXgpb/HkW9UKe1iPT2HW4TIAfjxNwWf3GZspQJ3yHU0G10Qj0mpb+CiZCrxUiW6W7rQ46q+FgoQzuf3SgcKrKOibFNhKmHRZkCgbMU34xPepEXGV/nyKYkuh0q89aDfxBILbAjgBc2+x3bKha3SDtyZuSuLdn4t7px9y6AOL9157gwQXktaGIid1aeNJ2KMQyb1tHOj6JDJkG8O7sO5uX/AGoZ4whCUkmM5b2X06sU7MVHGNEynnofCIldPeFICCCpIZKbnnCNc4V4N0rB+hExWgxSrtiu5PL0uBl8xH1BdDbONPpQBTi0nXOMuOszaup5qlkMLMLNI6x7UoIX7ZbEJex///eNCwtJejS8qLClI/et/3bLQbXL31lUvshh3J9gTAfTvWUS0xFwjVq96eD+POBChJKgYm7UBDI8C1d0N5Y92YkRA5JeX4M5DOU7GR7Kdtpf3Rsd5LQzkoc0Nv3X2IfTqxuMEbLxjENAtSR83oitL3tyhWXxZOB3jeCGgaEKAiKwTuoHAcJwBhiBE2YoJRDHTVjdMbSD6pE4p05jTX93tusa/kidBETpcSCjbM62qFQHQC+vqrg8R0iJ8mJtV+3fG5w0dHseNa1CxT8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(786006)(366016)(19092799006)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RExSNFFUQVlNYk54cHZIRHh3MEdIRXpjdHRzWDlPM2cxc0NQeXBOcE8zTFM1?=
 =?utf-8?B?SWNXbVFiQnZQTi9MWWZESW5FaXNKYzlOR2hmaGwvdHUyRVlHUlN4NGcrbFMz?=
 =?utf-8?B?K2k2RUZaVnhHWno5MXJUK0xlOWFGUlR0THdhTzJJVEpkcXpUVGdLaUgwZUY1?=
 =?utf-8?B?ajQ1OGZHNGk0WGFVOXNFVTljL1JiMzdKNCsyNU54WG4wNGQzUGoyWmNKajdO?=
 =?utf-8?B?dTJZZzV0Vm1rNm1ZeW5sMHBCMXhnT3VsN25FZnFzcmxrYndXclVpLytYdE5a?=
 =?utf-8?B?SFZrenc0S3NDdXF6dndBNVNJcEc0NS9vTDZ4UzNFS1dkc05HUkdzNU1KeFE2?=
 =?utf-8?B?M28yUHVPdFlrWHJBSlJXRGtteUhBOUtIWTF6NXZiTnI4Y2FBbGFXalpWVFI5?=
 =?utf-8?B?b1NFZUUzd1NraXZ5cFI2c2FWd3ZicWJ2SElabUYwUVYvT2FzNlpIZjFMSVRW?=
 =?utf-8?B?bThhK0x0cm5MQThtLzdGUFJPSVplelBXczdaOTlpT0VCZnI5Si9kLzUrWFEz?=
 =?utf-8?B?SEFkU3E2TkxyTVgwMXo4aDBjc01iZzVIRyt5azJNODdrQmk2ZEliMVRBYXJv?=
 =?utf-8?B?L0Q4cEUxZ0VmeHYzd09mRXI4NjZPSXp2SWxIclFwcXlpbzJWZ3FXT3RkZ1Nk?=
 =?utf-8?B?bTFtc2FJcjlNOVl6WXl2Qm05OGE3OHhjSXZyTEZGSzVxeDdaVkMvcSthUnRs?=
 =?utf-8?B?c2Zyb2I1dFh5dHovS2VFV1FCa09nS0ZHVEltU09salJtenVuTXRYcTJBbU9k?=
 =?utf-8?B?VWlycVR2SDdYNVpLc2U5Z0pPc1ZSeXkwTEdqZWtRUUk3STNObXZXaUVWL1Aw?=
 =?utf-8?B?V0tDVE9mV0NvNHpzRVpydVJENzFxME9scHltQWpUSm1nelh4MzJZZUZOT2hO?=
 =?utf-8?B?RnFnM3hZYmNOVGR0QXoyZWZZZmY2eVlOZzRBVkZZMGI4c0pkTUMreVBqcEkr?=
 =?utf-8?B?aE1manRLVFV2c05VdUQ3aXNJVlJpbm1mS3F6UDViZEFNQ2xBMTVQNGQ3aEZY?=
 =?utf-8?B?K0pacGdSNGNOZnI3RG8zZlpkWk5oYnFBU1FZb0FDYXd2d0lJNHU5UUFzajNz?=
 =?utf-8?B?UlJGYWZhT2xtZEFkL1gzSEtyeUFYbTNpYmwrZG1WaVhxZjVCbS9LVGFlUTN1?=
 =?utf-8?B?UkIwd1JpS0kwSi9GanFXSmt0cTRZY0xRWkNxRGI0Uzhud0loY0M3Ylo5TURp?=
 =?utf-8?B?N2p2ZUhmRHAwclBmaHlHaG0yVjcxaEhoWTdoME5xdzY1cVUyWjhLYitFaFVl?=
 =?utf-8?B?YmpsaFBBSFoyWWs1ODZob1hELzNXTDRpVFFzeE9Bc2QvRU1uNnd5bUFDbEFh?=
 =?utf-8?B?cmJmcWhGYy9PcVY5cW5sZnJDOHhLaUtxZHlLTmFWVkoxS3VLZHFMa3VzeTFa?=
 =?utf-8?B?dEdvaVBzVDFTT21FUlFIR3lvN3l0L09pZC9NTUFuRVl4dUtmUkh0NUJmOURn?=
 =?utf-8?B?UFE2NUlIcVJmVm13NjhIclJ2a3pPejRHZUNzRDF4b2p6bUdlWUk3L3VxNkNh?=
 =?utf-8?B?UmFvaUUvSVc3SGdhS3hHT3R3WEpYdnFLNERsTnBmT0xEVU94aS9xQW5CSVFu?=
 =?utf-8?B?WDNtanZ5VjFUWUFmbjltdUR3Z3ZuN1AwZlRTUUJRWlZhdERaNTR5ajQvd1FP?=
 =?utf-8?B?L0YyT0RDYWZDL3dWNUlMbGUxWWtTSTBoVTltWW53MURYNTh3RXQyOHhleU5D?=
 =?utf-8?B?elBqekpnVXZpSE1hSmttMHU4RDBiR1ZqNkF4K3lzanQ2UmNTc0U2T3hWRmVO?=
 =?utf-8?B?Sk9EMkl4UWwvVVg0eE5xWFV5WVlYeVpwQnExNzVJS0NjbEJiSXBTWnI0QlpZ?=
 =?utf-8?B?RTZBNFBKVzhvanNVRVFHMkdjMFpid2JWQVk3cUJVc3dvRzdqZjhoQ2NnVEdW?=
 =?utf-8?B?NVZkMFQ3cEpFQms3eUFSMm0zMnEzL0JpcGhXWFQ2TmVuamI1R0tpM2N5d3kr?=
 =?utf-8?B?N3U1dWNwMzE4Nk1PSkQwcUJnVnJRSFpDNjZJYUtPVVplY0QraUliQWc1YThZ?=
 =?utf-8?B?L1B6eTMyQWtIT3JWV2Y5cEJzUytZWUtjeC9wOXJ5d08xdGxERUtpN054Z08w?=
 =?utf-8?B?YjFQM2xOVFRQbVdtdnpIY1RVYjVFR3QvSVd2c1B3NngxamRzT0IwQTdzK01w?=
 =?utf-8?B?SWp5ekZkVWNIQlFCcytKaS80TlpNYzhZdGpCT2Z4YXB5aG5DMnRrYmcxSUR1?=
 =?utf-8?B?blV4Q25Qa1lJM3JKa2FFcS9hZEJKL3BFbnQxNUVTNnhiYXQ2RkdWNGhmTGY5?=
 =?utf-8?B?SmQvUnZVNFNRZlhoVTR0d3g5ZUJ3WkhwNHVkT2diVCtURmY0emFmQlEyNkU5?=
 =?utf-8?B?MHJWenRSdjFOL25VZDdjbGkxT1ZicFFIeGZicGpkV1ZuMUlNWWNSQT09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b8ea8d-625f-4ffb-1b9b-08de790cd7d7
X-MS-Exchange-CrossTenant-AuthSource: ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 10:08:40.2572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Bz0vGWW5Eg0SuwgSki7jeK2gEOY6jZImHtbIa6el4g88BmJpJLjWLwmvYc3WYRrTYzQTByWEe/PJ/7ecLEwbsyBngHlMPpv+5NHLtGUSTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR4P278MB1902
Received-SPF: pass client-ip=2a01:111:f403:c213::2;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZRZP278CU001.outbound.protection.outlook.com
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

--------------ms050006050604060409080005
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/03/2026 14:53, Florian Hofhammer wrote:
> Hi,
>=20
> This patch series builds on top of the discussion from the thread at
> https://lore.kernel.org/qemu-devel/e9bcd7c7-2d67-469e-b2f3-d1a68e456b2b=
@epfl.ch/
> and adds a plugin API function to set the program counter of the guest,=

> as just writing to it via qemu_plugin_write_register() has no direct
> effect.
>=20
> This version v5 of the patch series addresses the requested changes fro=
m
> the previous v4 submission (details below).
> Note: checkpatch.pl still reports a warning about line length violation=
s
> in patch nr. 6/7 but I did not fix this, as the line was already > 80
> characters long previously, the change added only a single character,
> and I think the readability of the code is better as it is now. Please
> let me know if you disagree and would like me to fix this!
>=20
> Best regards,
> Florian=20
>=20
> Changes:
> v5:
> - make QEMU abort via asserts instead of just returning an error from
>   the plugin API if preconditions are violated
> - extend tests for qemu_plugin_set_pc() to different contexts
> - fix issues highlighted by checkpatch.pl
> v4:
> - switch strcmp out in favor of g_strcmp0=20
> - split the patch introducing the qemu_plugin_set_pc() API into three
>   patches, two for preparing the plugin infrastructure and the syscall
>   handling code and a third introducing the actual plugin API
> v3:
> - make PC registers read-only across architectures
> - add tests for read-only registers
> - adjust test structure for qemu_plugin_set_pc() by moving
>    architecture-specific tests into corresponding directories
> v2:
> - add setjmp() in syscall handling path to allow PC redirection from
>    syscall callbacks (via longjmp(), the cpu_loop()'s setjmp() for
>    exiting a TB would not be live anymore in syscall handlers)
> - add flags to ensure the qemu_plugin_set_pc() API is only called from
>    contexts where the CPU is live
> - add test for qemu_plugin_set_pc() API
> v1:
> - initial version=20
>=20
>=20
> Florian Hofhammer (7):
>   plugins: add flag to specify whether PC is rw
>   linux-user: make syscall emulation interruptible
>   plugins: add PC diversion API function
>   tests/tcg: add test for qemu_plugin_set_pc API
>   plugins: add read-only property for registers
>   plugins: prohibit writing to read-only registers
>   tests/tcg/plugins: test register accesses
>=20
>  MAINTAINERS                                   |   1 +
>  include/plugins/qemu-plugin.h                 |  19 +++
>  linux-user/aarch64/cpu_loop.c                 |   2 +-
>  linux-user/alpha/cpu_loop.c                   |   2 +-
>  linux-user/arm/cpu_loop.c                     |   2 +-
>  linux-user/hexagon/cpu_loop.c                 |   2 +-
>  linux-user/hppa/cpu_loop.c                    |   1 +
>  linux-user/i386/cpu_loop.c                    |   8 +-
>  linux-user/include/special-errno.h            |   8 +
>  linux-user/loongarch64/cpu_loop.c             |   5 +-
>  linux-user/m68k/cpu_loop.c                    |   2 +-
>  linux-user/microblaze/cpu_loop.c              |   2 +-
>  linux-user/mips/cpu_loop.c                    |   9 +-
>  linux-user/or1k/cpu_loop.c                    |   2 +-
>  linux-user/ppc/cpu_loop.c                     |  10 +-
>  linux-user/riscv/cpu_loop.c                   |   2 +-
>  linux-user/s390x/cpu_loop.c                   |   2 +-
>  linux-user/sh4/cpu_loop.c                     |   2 +-
>  linux-user/sparc/cpu_loop.c                   |   4 +-
>  linux-user/syscall.c                          |  16 ++
>  linux-user/xtensa/cpu_loop.c                  |   1 +
>  plugins/api.c                                 |  42 +++++-
>  plugins/core.c                                |  29 ++--
>  tests/tcg/arm/Makefile.target                 |   6 +
>  tests/tcg/multiarch/Makefile.target           |  17 ++-
>  .../{ =3D> plugin}/check-plugin-output.sh       |   0
>  .../{ =3D> plugin}/test-plugin-mem-access.c     |   0
>  .../tcg/multiarch/plugin/test-plugin-set-pc.c | 140 ++++++++++++++++++=

>  tests/tcg/plugins/meson.build                 |   2 +
>  tests/tcg/plugins/registers.c                 |  79 ++++++++++
>  tests/tcg/plugins/setpc.c                     | 120 +++++++++++++++
>  31 files changed, 495 insertions(+), 42 deletions(-)
>  rename tests/tcg/multiarch/{ =3D> plugin}/check-plugin-output.sh (100%=
)
>  rename tests/tcg/multiarch/{ =3D> plugin}/test-plugin-mem-access.c (10=
0%)
>  create mode 100644 tests/tcg/multiarch/plugin/test-plugin-set-pc.c
>  create mode 100644 tests/tcg/plugins/registers.c
>  create mode 100644 tests/tcg/plugins/setpc.c
>=20
>=20
> base-commit: ffcf1a7981793973ffbd8100a7c3c6042d02ae23

Please ignore this patch series, I will send a v6 version soon.
Sorry for the inconvenience and thanks for your understanding!

Best regards,
Florian

--------------ms050006050604060409080005
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
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDMwMzEwMDgzOVowLwYJKoZI
hvcNAQkEMSIEIHmPLtej9CDBQT7zsg2jb2g5Is4e6Nutc3z0Sz3auAHiMIGFBgkrBgEEAYI3
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
gQQBDgIwCAYGK4EEAQ4DMA0GCSqGSIb3DQEBAQUABIIBAE2f96w8wfETt06X7sfpBsD45noz
o/Bl1WCsm+TnXPnU51P6wHsv0YTe9FHsqqoauLlDOWYpztjdCmRVZsb9bHTQK5SGCbxsYUWL
alIOAr03QGaUgjUSXloOPw2aqJuLWVdAVfgXTCJXNLeBpr2uxqIjx1JcyvcIOa8WDGxcmgD3
KMmSJUoF6K2df5depxVn5H3hOK7S1eW2BmhTNDKwlDsqG9U4IAK4xkyWVRoz9Tm4hCYJrMk1
LmxQWVuBz6VK5NF4DV6iFv4jfNEEgOP5oeIB27WBD0ps1l37XGGSwrDUIerkRrZtVRin2Hwt
nOJ+acaBWrHq3yuXBntmDd+dXq4AAAAAAAA=

--------------ms050006050604060409080005--

