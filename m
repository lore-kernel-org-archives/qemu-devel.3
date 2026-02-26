Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6ADFC5908
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 08:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvWQG-0005FN-2N; Thu, 26 Feb 2026 03:08:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vvWQE-0005FD-TJ
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 03:08:34 -0500
Received: from
 mail-switzerlandnorthazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c213::] helo=ZRAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vvWQC-0007Dz-GZ
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 03:08:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNgmkg2DA3arugH5wmfJ6cPnMN7F404QU4MMPAAu6iB/GOwuzN/L8wKXm4gjio6tBH9P9SnoMbD/i58fL3Ejc61uXZwxhalEUeGqeGd/rTAKssHTeRE9P54q13N1MhRop7/7VscOeiVV0dW6/kpoLdcX2KA8wbaz7CioYWQ3yrq9+jzMt8g66Sd11UMPpNWAB6hliT3DuSt7yUCoas0fpi+jYtyZzQ1AlEB3i+pTI3qzPkZdi9Sx7oMNTxmqCvje3ETNDisf9TAOaRhqFhzVgpFtLwR2h3wxjflyVQCivEJbSaZ5N7QHCQxTLO6Y0HceqS80Vz0b+GwkOmrxVnBy/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiEhU/S4H85/EGx3J6I9+X1aTcnVF3g/C9rCG57lktI=;
 b=YG4v/JsbkLnCoW7DHUAFVzE4BODuFPw3xoErT/Btmp6oI6675vhVluM+O2SUK3hplSwi7PuafqgIHqunopOMkbsmxeZ24K4pea2d+SD/eyYxfwSyyaMdrXdQe8qz8oaiZPwOi8cLNlb2cZnpTeDK62ibpiqGD5OqI5cB8hvrt4LGix9bcC6+ZxR3lSTrbJ+9+sWGKvi47Ukyv5eMJP72OJ3U1C+lJ7dea/utZzviNQjttmMFTzNgirlfrlzRbrP38lTWoOiQoM9bScsqAKF3pe+ZXfvgXlMm37VFhaUFoH1f+3cDhr2st4FAT1ZyIzURhIfPbqErAv94xIYaGWixQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiEhU/S4H85/EGx3J6I9+X1aTcnVF3g/C9rCG57lktI=;
 b=kflxjDyElaDCnqWClllwXmzmKPg2j3KgW8KhMTGm/nE7yiZQKzU/DY+BLpgsmiLMg4Iw3Bgkar29wqT6Wbe3kcPJ55F+Xkyw+SF4V6xfULkPZviQ2mWXXcIsbwq8Nblumfl+LwcsmpTj7ofFqbqtG1jvn1NiPLR9Q4euypVJtk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZRH2PF91651CA80.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::21b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 08:08:26 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 08:08:25 +0000
Message-ID: <1ad5fcfa-4a4f-4b82-bcf9-7c388fd38a52@epfl.ch>
Date: Thu, 26 Feb 2026 09:08:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] tests/tcg: add test for qemu_plugin_set_pc API
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org, laurent@vivier.eu,
 imp@bsdimp.com, berrange@redhat.com
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <2ccc79ee-48ab-4097-a9cc-4d2b79ab9a8a@epfl.ch>
 <7615cede-426b-4547-8878-c57ec08e8ba1@linaro.org>
 <a3233b9f-0200-4e76-83a0-9c9852a85348@epfl.ch>
 <6484080a-4570-478c-ab48-dce2ca054f1a@linaro.org>
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
In-Reply-To: <6484080a-4570-478c-ab48-dce2ca054f1a@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="------------ms050300040502060208030102"
X-ClientProxiedBy: GV0P278CA0059.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2a::10) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZRH2PF91651CA80:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e70a639-bdd6-4603-59ed-08de750e3791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|786006|1800799024|366016|376014|19092799006; 
X-Microsoft-Antispam-Message-Info: 4o8eb4OqiNRa6tgg3px5QhNcSJrVUdGzas60OlHdMnluDgWC0G/rHnQcoDpWarQ2pG2s68WXtq7v/+AuWZwAPuoHG/t7zO1hs6ACPGNy4sg6H2yrSGMmdISrmIA3nSUUVvCTBV+GHjVU549oDlAhW0JPTS8cNRfsN++jfaw9lcd5SS4hnbnJXW8uRWKZo8HyW3LRcU0gG46BKZX2+CmfUQvGZqOoMDDADlsYqg1UvJyPjSuGyIH0I1EVaRXsdWYOC6l+Ud8/naCAO9z/0gTiq5hILIQCIOZ7jgls3R+HTtzskoA+gN2keeKJGRegY2WqKh4KUsMiCaRo9NyYYr65h69wff/90wNSH2Wc3vXMANM6HP9luFaEdZ0yXa25JEe5+QDOPrvB2FHlzQP+KllruirajjSORpFpe9vv/zRGe71bbIXYwqgFz5MwNs9CbkC8gLynxhM8QY5kU185js5dts1mpiW33nDqm5LHbatxOXEIGBbf+a4/RAtb751mXih7wmu+c73ENyFN4dvJ/vk6M4uYaU4qJMMKBH78jkjH+phpzGC5XiIq7cZr2mTMqY8bUJpu8wWh4NUcOjcnRT7PVCTROpsj8FrsxhUQxWkdn857pZMmC4r3Fa8WlmKtAvgWt34t6uoWWj4W5uu1xgTIAvV/8xA7qejwVwrW7iYHLuUjTbGZrc8H6ZzZuMv4PyuqA+1GuJBu0Ldalg74bCwXVvsv0gmot8j4T6n0nQ+9I1Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(786006)(1800799024)(366016)(376014)(19092799006); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGltWFM5VDNKRitxUy9QN3ovVHQ2bmpyTnFGcG5WZEErTU51bDBKeDQ5c05Q?=
 =?utf-8?B?Lzg3YTJBS2R2czMxaDZ6QjZNN1NXQkdBS3U5U2VqY3M0SDUvR0FBMEtIb0lM?=
 =?utf-8?B?VnRrSnFFTjNKR01EVDI3TjdrTUFtQzdYOHpiejh2UW9zWU9lVE9QdzlYbnV5?=
 =?utf-8?B?RVBScXcxdm5ySE9RRmpIVzVkdnNSY3YxZkQ2VUZENXl2WFpLZUpkSk5rc3ls?=
 =?utf-8?B?dFU0T0JKN25RdFRFTDNCbkRWcE1MRmlic2VhUjQxaEIxcDNERlFNSzNLckxr?=
 =?utf-8?B?TWtoMjJxZkh2RU5pMEg5ek1MczNiM01Hb0NEdWtCd3RLSnJUT2pHSjhsWWRm?=
 =?utf-8?B?cXpwQ3cyMldXSXFFdzdHMWlka2hiNk1RQzRpTkludUl0bm01a2hXdE5nWWZV?=
 =?utf-8?B?ZUtvbWQ5clpNd2xFK0RRN1pCVVl0U1h5OGMzZStnVDFkdWZ4SWc1ekorQXJm?=
 =?utf-8?B?VE9UKzlKN3dJZkluYXpwbXJranF3VDhBMkhMVWFuR2hKektSVnlZNGx6Q1hn?=
 =?utf-8?B?SHp4L2FJeWRqSHpmc1hTMDZrYVYxZlhrVVhGUXU5cCtnSnhoVTBHMkVhbkV1?=
 =?utf-8?B?SGxicEdWMzlnd0JyL0tvNkRXTVZ3ZkhHVDZhMFdtMjFOcUdSdEY3c2ZrMklX?=
 =?utf-8?B?dUFQTzc1MWJNc1ZUQ2xXcG51dy84bWpVZFk4RXRSdzNpbitrZDh6aEJ5YUVM?=
 =?utf-8?B?ZStCTEV2MWtVOW9sM2VsWEE0ZzQ5aFpyZnZURDBwWHZKUmhnTU5YUzQ4QjB0?=
 =?utf-8?B?ZitpNHZVZzNtQlppSTY1SzB6ZUp4bGVTOE5DSGlEUjJQT2lQNnl3MXE1L2Y0?=
 =?utf-8?B?K0piR3pOZCtadWgrYTdNOG95TmNmRGpLOEJEeHdISGFmNHpMYjFscjQvcEtB?=
 =?utf-8?B?RkptdGU5TFFrV1hwdEpCSW84bWpTeUYrT2NwbVhvVHJHMmdnSFZhaTMxVW5Y?=
 =?utf-8?B?M0F1ZkRrdGFGVmNXRWtCZndCVzJ1RzVQWjNCbDNHZHZrNWJnNmtjMDBpS2JH?=
 =?utf-8?B?MW1GYjZURFNraFNOSnFoRzgzVllBOHE0U1pzNVJ5RXRkOFE4M01IWTRkVGJH?=
 =?utf-8?B?a2ZGTUM0ZitiOXU4TkVBVE1Fd3l6VEhzUnVpK1dHSEYxOCtBenZ4ZmdJNVhr?=
 =?utf-8?B?cDF3V09WbnBDSEk1KzdzSk5GQVkvSFJLR0trMjRURUk4dG1lV2xxakxPZ1RU?=
 =?utf-8?B?cE5mcThYaldERk13Nk43MVpEenlScG9wYktnOGY0RkFEc1oyYU1xbHJLakov?=
 =?utf-8?B?SkVlZk0xY2xSM3o1enFURlBxNmVPZjg1aW9kczJKSXlZWjFMMUZ3cnYxNVBa?=
 =?utf-8?B?VXo5eFR2Z3huU1h1WjRSckNaYVh4TXJOM3Rzcnd0aEVtN3B2dHFEOE9BWUw4?=
 =?utf-8?B?bTRuVnAxTmEvNXZNV2RYR0MzMExYbitOQmlDL2xmZzl1Y3BQMzhhbExIYlNS?=
 =?utf-8?B?RDUyclFkdCsyNkQ2SkJubGdxdVcrNVpGSmJ3V2lPVkdySlZBTlNrVzMvZVM1?=
 =?utf-8?B?WWxMTmJYUFRJUWdOTHZkdVUxUkdnVVh6aHNkSExrdUp6N245WkdvcDlPZk5P?=
 =?utf-8?B?YTRWaHU4RkFYWkV4R1ExOEpuQnV2RTdOWTNrVkxkWFErTVhsTzFYYnRpZlE0?=
 =?utf-8?B?N0sxcG1Cei9TR1o2WGlDM09hdFNiR0o1dEFCalI4K1hMbGR0Wm9za0Jpa3dS?=
 =?utf-8?B?VDNxeGVoVjF4ZVlFbnJnZmpTWEFhWU1oWEFlNzhGR0g3Tm90YXJSN1EwY0RD?=
 =?utf-8?B?MzU1VEJCK1pCODV6Qk12VTlUT0RINDYrL3E3UzdTcEYzbzJkVXZkekR6RG11?=
 =?utf-8?B?Vm43TVprUWY3S2VKODVkaUJiNlk0ZGRvNTFSWWRTNVptdEdpaG1JelFjY3pa?=
 =?utf-8?B?ajI3aGZDSUJKb0ZpWTZmcjhJL2ZCd1gwVmM1TEM2TCsrNGxhWjBmT1B0TVln?=
 =?utf-8?B?NGI0TmNCc3RQc2xLQmxaVlpiR1R0alZLKzJ2SG0wRTdtclMxSGxNaFNHblNj?=
 =?utf-8?B?THpDSWFmUzB1aXBQd00yRWxIRkk3Y29sRThVcUQ1dFlXdWEwNDR4QTRIczVO?=
 =?utf-8?B?RHI1RmRZNXhWTnlleWtXYUJHQXUveFFIOUM0aVVBeEVWTjg1bDI2Q0dpRVZ1?=
 =?utf-8?B?R3ZWcTdvNTN1a1B0VHZTUENJNUxSL2pTdzlHNkNYUWtOSlZoaGxOTURmUmhI?=
 =?utf-8?B?eXJkR2tiRXBYdCtMaGhLTG8xVVZyb0Ywc0xqYU5FU2tKZVNPaFlLcndyNlc3?=
 =?utf-8?B?YzEvbW9GZHhBZjAwQ3JVRTFydCs0THBGNUNSV0lnUytqQkJPRE1FampZcHZL?=
 =?utf-8?B?bzQxTzdGRCtCSGpSWXBkejB2QXpsdWRTWWduZk5QUHdYSzFIR2orQT09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e70a639-bdd6-4603-59ed-08de750e3791
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 08:08:25.8145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AbAHcNlmpoodqCvIQyBKR2r05Mt6g5Noz3EaKkW8Cl6sUMGEXArrJyn8IWCmFASzu6HlySSMyfWRn0z7eBqkFGqkDYHXaQdeXUuKJgXWJ1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRH2PF91651CA80
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

--------------ms050300040502060208030102
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 25/02/2026 18:04, Pierrick Bouvier wrote:
> On 2/25/26 6:58 AM, Florian Hofhammer wrote:
>> On 24/02/2026 21:24, Pierrick Bouvier wrote:
>>> On 2/24/26 7:52 AM, Florian Hofhammer wrote:
>>>> The test executes a non-existent syscall, which the syscall plugin
>>>> intercepts and redirects to a clean exit.
>>>> Due to architecture-specific quirks, the architecture-specific Makef=
iles
>>>> require setting specific compiler and linker flags in some cases.
>>>>
>>>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>>>> ---
>>>>    tests/tcg/arm/Makefile.target                 |  6 +++++
>>>>    tests/tcg/hexagon/Makefile.target             |  7 +++++
>>>>    tests/tcg/mips/Makefile.target                |  6 ++++-
>>>>    tests/tcg/mips64/Makefile.target              | 15 +++++++++++
>>>>    tests/tcg/mips64el/Makefile.target            | 15 +++++++++++
>>>>    tests/tcg/mipsel/Makefile.target              | 15 +++++++++++
>>>>    tests/tcg/multiarch/Makefile.target           | 22 ++++++++++++++=
--
>>>>    .../{ =3D> plugin}/check-plugin-output.sh       |  0
>>>>    .../{ =3D> plugin}/test-plugin-mem-access.c     |  0
>>>>    .../plugin/test-plugin-skip-syscalls.c        | 26 ++++++++++++++=
+++++
>>>>    tests/tcg/plugins/syscall.c                   |  6 +++++
>>>>    tests/tcg/sparc64/Makefile.target             | 16 ++++++++++++
>>>>    12 files changed, 131 insertions(+), 3 deletions(-)
>>>>    create mode 100644 tests/tcg/mips64/Makefile.target
>>>>    create mode 100644 tests/tcg/mips64el/Makefile.target
>>>>    create mode 100644 tests/tcg/mipsel/Makefile.target
>>>>    rename tests/tcg/multiarch/{ =3D> plugin}/check-plugin-output.sh =
(100%)
>>>>    rename tests/tcg/multiarch/{ =3D> plugin}/test-plugin-mem-access.=
c (100%)
>>>>    create mode 100644 tests/tcg/multiarch/plugin/test-plugin-skip-sy=
scalls.c
>>>>    create mode 100644 tests/tcg/sparc64/Makefile.target
>>>>
>>>> diff --git a/tests/tcg/mips/Makefile.target b/tests/tcg/mips/Makefil=
e.target
>>>> index 5d17c1706e..d08138f17b 100644
>>>> --- a/tests/tcg/mips/Makefile.target
>>>> +++ b/tests/tcg/mips/Makefile.target
>>>> @@ -9,11 +9,15 @@ MIPS_SRC=3D$(SRC_PATH)/tests/tcg/mips
>>>>    VPATH         +=3D $(MIPS_SRC)
>>>>      # hello-mips is 32 bit only
>>>> -ifeq ($(findstring 64,$(TARGET_NAME)),)
>>>>    MIPS_TESTS=3Dhello-mips
>>>>      TESTS +=3D $(MIPS_TESTS)
>>>>      hello-mips: CFLAGS+=3D-mno-abicalls -fno-PIC -fno-stack-protect=
or -mabi=3D32
>>>>    hello-mips: LDFLAGS+=3D-nostdlib
>>>> +
>>>> +ifeq ($(CONFIG_PLUGIN),y)
>>>> +# qemu-mips(el) returns ENOSYS without triggering syscall plugin ca=
llbacks
>>>> +run-plugin-test-plugin-skip-syscalls-with-libsyscall.so:
>>>> +    $(call skip-test, $<, "qemu-mips does not execute invalid sysca=
lls")
>>>
>>> I ran into this while pulling syscall filter API recently, and found =
4096 as syscall number, which seems to make all architectures happy.
>>>
>>> See 948ffdd79b78702239aace2d32d4f581913299b3 for more details.
>>
>> Please correct me if I'm wrong, but is this really sane? The comment i=
n
>> the referenced commit says that 4096 isn't used in any ISA, but on the=

>> MIPS O32 ABI, syscall numbers start at 4000. 4096 therefore correspond=
s
>> to getpriority, which would be shadowed by using this syscall number.
>=20
> I would definitely not recommend using this value in a general purpose =
plugin to implement "hypercalls", it would not be sane.
>=20
> That said, for the current limited test context where we now this sysca=
ll is not called, I would say it's ok. And if it should get broken in the=
 future, we would catch it and could find another magic number.

Fair, I suppose I was overcomplicating this unnecessarily. :)

> Of course, if you have a better idea of syscall number, I would be very=
 happy to follow another rationale, as mine was mostly try and error. :)
>=20
> Regards,
> Pierrick

Best regards,
Florian

--------------ms050300040502060208030102
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
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDIyNjA4MDgxMVowLwYJKoZI
hvcNAQkEMSIEIBBwSP9+6VGloUf/r0ygvpKECIYQqO7kQz+qhXxui1ZZMIGFBgkrBgEEAYI3
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
gQQBDgIwCAYGK4EEAQ4DMA0GCSqGSIb3DQEBAQUABIIBAJWNjOOQgdmGzOqCKM7TUJLt7naB
mJ8fa9fp6/FoKqvuDsRPwPg1OlhxANPQdp7h8ChNR7yLS4z7kmMP18Z+ecR4Bf+2zz5HelPc
BrDg2P0RW8IMoElhsqA7JVEawi7QY+Q1xmYJHJ+wP/5zOKr28JNc80R0Hx0mbMEgbI6KKqBQ
Q+/Y69XZajxnr9SzmpjV1TLO+cpkVFDhXli2oekca/T87E+aC6haw16VBnuseie5JCwagAf/
fFudWefDrT1jGz3y6pnH22seUj8+5pEEvlIaw7uMoG4ytmNVo05mgKNJ3Jg+k0gzvJ8I+TsH
73yrSP06A5dyey5nyXBTdeh8LPUAAAAAAAA=

--------------ms050300040502060208030102--

