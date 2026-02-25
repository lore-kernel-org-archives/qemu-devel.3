Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F02FD3762
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 14:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvGM6-0000oE-9x; Wed, 25 Feb 2026 09:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vvGM0-0000nP-UK
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 09:59:08 -0500
Received: from
 mail-switzerlandnorthazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c213::5] helo=ZR1P278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vvGLu-0008Nl-Ny
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 09:59:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6205CuOGQL+Wjwri7QNwDotECsBLaM4Ce/i8QM3xGBOMwZxo3/7i7rirsQAMeHi8M4L/xZs2Pt5XrBBfR2ej2NBpeu1cj3pjfXIqLM42Z6t3MN/RAownOHXXok3Jl+nPdgjk8MsChPGfacVVFN5RrPXAdCPWB9HwsFoz77boCkc7W17zXMUZ/KnXBPkSuInvshorF2xojeSDfaxCxeOeaeErYXta2XeKDSq6Hbds2wmOeaYrfih1lspdSthCMlOjQxPyyLj41hZkKn1V03CSNv7icE/k7Ozoo4rJNRf09fNK4BKGnxOHi4p4m3Bw/U563+D2WEnNl6k7syKNEm9bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DECuUcXL8PtuZrxth/NeACM4yRZxEWOFj3miFZfcYQA=;
 b=Dusx25EpZf4GvbUfzgTO0C1O6fQ1lB2Fu5lRSdL+p1A4evwGLue9C9koCAy2AuuvqY5p/vb9T9IAIyQHtFi8BoHWb0f2E2t8svjgebQJqDr0cMYT13+yV/OnQEyk6bblsE7J3eRhKntOtgzXeWh8nD1Xu9n5s9WIj+BRISFF78jORTjRD6kXIzUFJrPPfrzvMen6JY5JvvoP1gJREHXhHSuIDEYGeD9F23zwYDsCksGZ6lya9k7ovwGDHN/Tw4eFkCCagLm5U80d7ZybJGSSfM9o6DPrn1C4sgLGbxA1wDJcvnV6nao8JJf+O07N2N5BRBmS/2VO/KzgnEDZdJ6mQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DECuUcXL8PtuZrxth/NeACM4yRZxEWOFj3miFZfcYQA=;
 b=IbaUj+J5v/69MDCpgLZ407GQ54YuF4xYNaxpwSlz2VwO5ymIG03KeaY51x9wbdeugVVlzcjTuvD61xsW2Az50T+3PHQW+NUQe2J96B0AURKubxlmkjkp/j8h33z+5DnfRKzivPPL9173BbX/pCtuJUl/wooVfxwdgOOB0YZEMRk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by GV0P278MB2075.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:70::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 14:58:55 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 14:58:54 +0000
Message-ID: <a3233b9f-0200-4e76-83a0-9c9852a85348@epfl.ch>
Date: Wed, 25 Feb 2026 15:58:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] tests/tcg: add test for qemu_plugin_set_pc API
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org, laurent@vivier.eu,
 imp@bsdimp.com, berrange@redhat.com
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <2ccc79ee-48ab-4097-a9cc-4d2b79ab9a8a@epfl.ch>
 <7615cede-426b-4547-8878-c57ec08e8ba1@linaro.org>
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <7615cede-426b-4547-8878-c57ec08e8ba1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: GV0P278CA0026.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::13) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|GV0P278MB2075:EE_
X-MS-Office365-Filtering-Correlation-Id: e200a235-3933-4189-5682-08de747e6552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|786006|376014|366016|1800799024|19092799006; 
X-Microsoft-Antispam-Message-Info: +RvcBIepEYmhvH+w6zqSEcqCNmpygJJMtGQ73Pgu7htebG1xeQ4XkHbOniJbQCCUebb2FNrvCTVNoyY32CpxIGJdulezBawYMv9ox2o2drmIoa5FY9Xx0IWWBYcfXV8lTPBgZOAGYiJecHxehW8wmw2m11tjTbp0G6vUJGsUi16Q7iAdQp2D2Bdelp0KXv/1Y3CybnZ1zWrndadyJoe1+g51KcAMAqygAdxQLxRpe9N6KtjKw9Zqnc/aIYLZj66ck62UHssmlEW4fVPhOPWmFIAsVt2cefZBIj6uRoC/JJdzLdQAeAoRjTaE1oRZ42JPQj66RkqQyQGKy5R6A22zv63No2627Pk9TKvg6jcZwrac9A1SBIx5273J9eyIVOM/cT0kYRFc37r/hnURbMCPaWZNrbrSX983pkDJcK7glQBIm4EUyu+9ULCVNo/p7vIDVS1B2FKfw9mLqNtZPl5DWYuwTa5Xiz6mK5G8wzStEs/P1Yd+dKaI1rohjf3t1mtj+qe4Xh87iRwDq6UfunrAdZ97dcC1TVJTvh/DO7Iq/c0p8KW5wX6Pbp54OEp/w9K7uMs0oSLh3vtKY5byz6xt7xBzQ4hdBDXWB5fVBLo5/RtMIq5FxOGthBTZYPcrjdeh3Eqp5T0vt/Sod0M0pX0dQNTbSYotNVn3ygdxacKLVZragmgKjhqNJGDHZ9S6ZuxJtepS3AAiU5Ypqrp5F9bLuaImdauZOKr0/U2TYzlbhKY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(786006)(376014)(366016)(1800799024)(19092799006); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUF0MWpSeUx1RnNtdjg0dnBBaEFGbTd2eWQ0WXh6QzFBdVVaZE9hKytTYWZO?=
 =?utf-8?B?TTYwMnVYOVdPSG02SWpveW5pOUlRc3d2YlFqa29saktZczdjaTFGVlJQU2NL?=
 =?utf-8?B?bHYxYlEyVThyYlNkM2ZwaXhlZitPbTB2Z1BGeHFlekJmR3lQVTRSR3NPSHFL?=
 =?utf-8?B?M3dZTkVnM1diVGl2WXA0RDB3T28zaDFSajZpNUdmbXNmcjhFd250VGNrdndS?=
 =?utf-8?B?eUZtaTlKbnM1aHpuM01XdGhmTGlBektGeTBxZ2pxM2RuMUpVMDMvY3d4UWRC?=
 =?utf-8?B?N3UyNmZJN1REMHFrV1JzVUI4ZUpNZWphQThSc3FWWmU1Wmk1dGxpZTJCbmNo?=
 =?utf-8?B?WUZCSkdRZVRtZW1HOE9yb0w5b3Y0blFTdjJNU2hQcTV5VWpLRjNjOERXZ3dy?=
 =?utf-8?B?WWVIaXV5SkNBdXducUMvbTRvN0xUY0tFMlYzaHlpaFFCYm9FWWk3QVZTOWVH?=
 =?utf-8?B?QkZuMEZmUnc0ZkVlbHIwRHkwZ1RlRE1vT2xiNXJLNnFjVnN5YkdUSzRPeCtw?=
 =?utf-8?B?MGNBM01nNU5TUCs1MXVnR3c4NVI4bnBQRDdBdEhNYUVWR2MwTjZRM2V4ZUFO?=
 =?utf-8?B?SHlnekRDQTVrbmZ1Smc2bzgrUHZubnpxV3pJbGFqMm5MS3p0U05SNXgvZnJC?=
 =?utf-8?B?Q3UvWnd5MEg1cm0zWkxvTXNhV1FaNjNOd21ObmJkQjc5NHFDZ2NKVEQvakh1?=
 =?utf-8?B?d2tjS05tTVIrZC9vRmpiZWFSRk1oVUJXV2NlSW0vSSthTkx2NjZlUkhuVWFE?=
 =?utf-8?B?OUsrblQwOHlINUxqekZNTGErRkRGTElOblNlc013NFZkTlhqK3BMcVR2eUUz?=
 =?utf-8?B?QmV5c0dEeU51TEtGNmRsK281a1VCWk1GeUhRNm1YeU8xUnRlOG11RVEvSHMz?=
 =?utf-8?B?UElJdGlaTGxHMmNYYitCZFZLWElSSTIzSXRONE93UFdnTysxT21abEg1Snhx?=
 =?utf-8?B?T0FEZVVlakphRjBRWGo5dzJPc0FaRHFGbWttRFg4M00ydUtNU3VEQ0lDSEts?=
 =?utf-8?B?L3RCZzUvRzUrdStjS2VrczFIYk1uV2EzZUpVT1ZqNEd3Z2tqR3dpMUlCWmpE?=
 =?utf-8?B?S2VZcFpPS2dzSzlqaCsvY2p6Zjkxb0NzNGF2ek1hRllGR2tBczY0Y2d6TFd1?=
 =?utf-8?B?WmlrNTRuSjd4aFFtaCtsQ0dNSmtSR0NXK1I2UGJzd2xrZFF0QkVhSjZhY1Vn?=
 =?utf-8?B?cUJtS0R2SjJYZU5LTUcreHVKcmFveEJ3aDl5SUNoTDgxTm5WMENKRHNqbUY0?=
 =?utf-8?B?dzZhcGRLRkdlamJ1T2tuT0EwUnA0elVSWEhLRGNTZ3YwVGVReFM2L2Nsbm5n?=
 =?utf-8?B?N2x3NGhhdDlTbFdDSGVLZzl0eHVLYXNVNDJLTng4R1NWeUhCTG9NV0JVT2Zh?=
 =?utf-8?B?aHVNMTB3TlRyTnpBc1hlNG02SmJIekJUcHlrdnJpTnhFRGVtTDMwN3VudkVi?=
 =?utf-8?B?MWJCRG40SHdmR3ZTZnpDZUg2eUo0c0hHdjcyY003OFQ3Vm1hTXJ0U29UUmF1?=
 =?utf-8?B?MFNWY0NOR2RoRnZjSVBNNkRvbTNwU2FLMzJSNmJoVTc5MlkybFBzRmZKdU15?=
 =?utf-8?B?cWRLb3FLbDJWLzcwUFg0QTBXNFpnZzBBNytrNXU1WVAvQU1tcCs0SDVtL0M0?=
 =?utf-8?B?UTNmR0RUS01HUVhIdHdCTXo4QWFEV2VkYVdaeG5YR004WC95K2JUaG9WK0pT?=
 =?utf-8?B?cjR3aU40OEJIKzlqK3BBUmM2VExIVGpiQU85cHVmd0FpQ0xWRFBoNGcxTWtp?=
 =?utf-8?B?OXZFUGgrb08xOFFRTXYvOTNqcWF6a1h1T0wyRkVjZmRDOHlMM2JISFB4UnVa?=
 =?utf-8?B?YkZ0Q3c3STVOeHJSSHVBdGxXdHdhNTZOaVNjV2dBdmo4TFQwWkJIQXdJd0kw?=
 =?utf-8?B?aEtwdFZzZTJLQ0EvbkdSaEs3SHI0aElZNVZqTmVyb3lER0hPTXJRNDdmcDBx?=
 =?utf-8?B?Q21idWNSS2FWcVNHN1lsdGFLSXhReXBNVVJxd3Y4SGQ4aDVBNEhMaFgxazRC?=
 =?utf-8?B?UHF3OURsTjhzdmlZeEhLQXRWUWdnd3NpMWR2ZWdoanUvdml6K00zVkVZSDMx?=
 =?utf-8?B?b2pXQU1qdDNvbVl5NUQ0Uzd3bWlHaE84NGtZR2tncDlNSjEvRVFkSFNNRTVw?=
 =?utf-8?B?cVJoK1VJLzRYanFEVWVaOGlFcUhBR0ZzQVdJeDcwZkMzcUJiWWY1Tm9Bc3pT?=
 =?utf-8?B?VFgvem9mOUpybWhjc1ViZkR4Nk1vOWhBL21HTVhvSGo0c2V1a1dFMkJqeGdm?=
 =?utf-8?B?UkVHa0ZsV1B3WnUvZnFTWldPcjRNazVtSmRMcnhqbWNocEVsOE1MaWQwd2NK?=
 =?utf-8?B?Yng3aG52aEZha3pvc2tHRmxGeXFENUZjUVNvVXM5bS8zb1hzeGc4UT09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: e200a235-3933-4189-5682-08de747e6552
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 14:58:54.8887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bY/C2kAeoGfcnpnE4Iu24HaAwOu+79FeKObhE6R29oEgoG0xpc8u4TrEBzNOGIZxiojWA9gI5K6uoWa/6aWeg3KCo1WiMLi8kwJXvu2ogA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB2075
Received-SPF: pass client-ip=2a01:111:f403:c213::5;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZR1P278CU001.outbound.protection.outlook.com
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

On 24/02/2026 21:24, Pierrick Bouvier wrote:
> On 2/24/26 7:52 AM, Florian Hofhammer wrote:
>> The test executes a non-existent syscall, which the syscall plugin
>> intercepts and redirects to a clean exit.
>> Due to architecture-specific quirks, the architecture-specific Makefiles
>> require setting specific compiler and linker flags in some cases.
>>
>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>> ---
>>   tests/tcg/arm/Makefile.target                 |  6 +++++
>>   tests/tcg/hexagon/Makefile.target             |  7 +++++
>>   tests/tcg/mips/Makefile.target                |  6 ++++-
>>   tests/tcg/mips64/Makefile.target              | 15 +++++++++++
>>   tests/tcg/mips64el/Makefile.target            | 15 +++++++++++
>>   tests/tcg/mipsel/Makefile.target              | 15 +++++++++++
>>   tests/tcg/multiarch/Makefile.target           | 22 ++++++++++++++--
>>   .../{ =3D> plugin}/check-plugin-output.sh       |  0
>>   .../{ =3D> plugin}/test-plugin-mem-access.c     |  0
>>   .../plugin/test-plugin-skip-syscalls.c        | 26 +++++++++++++++++++
>>   tests/tcg/plugins/syscall.c                   |  6 +++++
>>   tests/tcg/sparc64/Makefile.target             | 16 ++++++++++++
>>   12 files changed, 131 insertions(+), 3 deletions(-)
>>   create mode 100644 tests/tcg/mips64/Makefile.target
>>   create mode 100644 tests/tcg/mips64el/Makefile.target
>>   create mode 100644 tests/tcg/mipsel/Makefile.target
>>   rename tests/tcg/multiarch/{ =3D> plugin}/check-plugin-output.sh (100%=
)
>>   rename tests/tcg/multiarch/{ =3D> plugin}/test-plugin-mem-access.c (10=
0%)
>>   create mode 100644 tests/tcg/multiarch/plugin/test-plugin-skip-syscall=
s.c
>>   create mode 100644 tests/tcg/sparc64/Makefile.target
>>
>> diff --git a/tests/tcg/mips/Makefile.target b/tests/tcg/mips/Makefile.ta=
rget
>> index 5d17c1706e..d08138f17b 100644
>> --- a/tests/tcg/mips/Makefile.target
>> +++ b/tests/tcg/mips/Makefile.target
>> @@ -9,11 +9,15 @@ MIPS_SRC=3D$(SRC_PATH)/tests/tcg/mips
>>   VPATH         +=3D $(MIPS_SRC)
>>     # hello-mips is 32 bit only
>> -ifeq ($(findstring 64,$(TARGET_NAME)),)
>>   MIPS_TESTS=3Dhello-mips
>>     TESTS +=3D $(MIPS_TESTS)
>>     hello-mips: CFLAGS+=3D-mno-abicalls -fno-PIC -fno-stack-protector -m=
abi=3D32
>>   hello-mips: LDFLAGS+=3D-nostdlib
>> +
>> +ifeq ($(CONFIG_PLUGIN),y)
>> +# qemu-mips(el) returns ENOSYS without triggering syscall plugin callba=
cks
>> +run-plugin-test-plugin-skip-syscalls-with-libsyscall.so:
>> +    $(call skip-test, $<, "qemu-mips does not execute invalid syscalls"=
)
>=20
> I ran into this while pulling syscall filter API recently, and found 4096=
 as syscall number, which seems to make all architectures happy.
>=20
> See 948ffdd79b78702239aace2d32d4f581913299b3 for more details.

Please correct me if I'm wrong, but is this really sane? The comment in
the referenced commit says that 4096 isn't used in any ISA, but on the
MIPS O32 ABI, syscall numbers start at 4000. 4096 therefore corresponds
to getpriority, which would be shadowed by using this syscall number.

