Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBB1EF8FF4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 15:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxoQY-0007Ec-J0; Wed, 04 Mar 2026 10:46:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vxoQS-0007E7-Kj
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:46:17 -0500
Received: from
 mail-switzerlandnorthazlp170110002.outbound.protection.outlook.com
 ([2a01:111:f403:c213::2] helo=ZRZP278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vxoQM-0004Bo-Eq
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:46:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHdWUgGL9OtPp0sK7+sJ4bPdwV9WLMBStWMk/GGrtdGkK0U1RbGwyUZQ7aNXcc9qyhpZHsnIFgxbcFZzVf+dw1VOh4yY01f11bkow7LVD2RlpIhqpXcwSc+h6y/NbLe0WrA71hLvLiOmskwibnGYj8MO66NXp2UcoPvcBT4ItMIOqj0z0FGryElTm2Wto48QuKvkqeFav+JQI0def2Z37BaGB+yfb35kJZbcZo9omKyz/3OXfU1Gk99vD9pDRia6n3RvVU167vEmC1Nz7KsLywvr70PBFdXO0hvDC9/AtFGS9+6dl2yH2PG7D7GdhHO+ugNm2Kplptj5lFrWgc8KfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHAFDPH6Rzlz3lpiYsk3MO3Z/QIi5zALH3WDrTgAvLM=;
 b=imYifeJD+B7wmlrdvFt2suTdcO8dKBMbaCthrzXIr5PB1MVxzBL7qNbvPm6U367l/e/addds8kPl7VR+0ygLVM8UEoRQEhY98rtWXQQv4YumhC/RXTCRyFla/9qgapdfXob3h8B2ucrdrMnnRDrWnHewr54slvMtwnbWv1Amj9QHD5jNwnUP70AK+FPMKd2hhSixnkY16UZLOKgVSZILlWd4pOLn8xx3XvWr8nEzAr7q6+de0XGo3asxHWnIR2EnxCt86MUcS0aZG2drHjrGMFPkrr4/7E7nvtJ1ImHwiaSWC1Omo5mMhzz8twBNw0WjvpMmhFaBxffoX0xVMqFMtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHAFDPH6Rzlz3lpiYsk3MO3Z/QIi5zALH3WDrTgAvLM=;
 b=C2N3imLIsPwBHmzDIMPXj7lv1/TCGZNAU/6XIaEW1lRh9GDZSuyTFpu7mlT/s5OUU3sRvvwl5eg+OziLQ2yBCybPQNG5LTj9qWQyerivV4hil+ubDYzHrffVm+82eHQFs47VSrUoQZA3d4EmXG7nXSsG2x9L/ImPKE96pvpQ9Wk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZRAP278MB0047.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:11::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 15:46:00 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 15:45:59 +0000
Message-ID: <5a9a17dc-9781-418c-ae23-a183234e4a53@epfl.ch>
Date: Wed, 4 Mar 2026 16:45:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/7] tests/tcg: add tests for qemu_plugin_set_pc API
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, berrange@redhat.com,
 richard.henderson@linaro.org, imp@bsdimp.com
References: <20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch>
 <20260303-setpc-v5-v6-4-15c77cfe184e@epfl.ch>
 <430d1aa6-c36c-4399-8e5f-b38a9ae1bd35@linaro.org>
 <5b8bbc1e-cb8b-44ea-822b-0bdcb6ac225f@epfl.ch>
Content-Language: en-US
In-Reply-To: <5b8bbc1e-cb8b-44ea-822b-0bdcb6ac225f@epfl.ch>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="------------ms000303020502040008090402"
X-ClientProxiedBy: GVAP278CA0006.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::16) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZRAP278MB0047:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d541333-ded5-4066-05f4-08de7a052202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|786006|1800799024|376014|366016|19092799006; 
X-Microsoft-Antispam-Message-Info: 4lY6Mm0tVdSSZlP+5FwOXrQOd+4DcYakNmUNZ8LdLhh72YLEcFrHlBeNyzcWGgm1kORkeanOALmiHDQVG9kSljDypSPidYRuqEn6dVE3Flin14LraiEm4aHcLNYhGnocw0Eu0PSKR1RawVthUDGvFXP6yyrpM9YlwcAn+MUvCJ6coMB+wza/yOJB6ggqmDCsDvTtGloZtnPKM04u2IruLz+/UhAEcfdr+f1/LRu2HGAJpG8e902MvZXKJKAsQ5oLypMh/3pbvoslJSH8PMTw2fnT8uEWxd2MYRS9lRXir6HCK3ASu9KcUUyeVHSabl9ZXx6aFNO8JFy71AAypeKZfhun4nsIuA1eYWI6Nw3VhiZyvprIQB2VWsUfOqx6F913MYbWxFhqaX7M5i7Ob3xE0TQY332py1syu05siukq/Y1Lx17Divs/MOy/rD+KqSdq/JKkuKbXOUCj5Yjy44lgJPR3xlz1XTzLf7D1cK+plX/fAFVktMX6QJ6IW56E3i01M+tDjqd2Fx2KtsXEHegX0gJ0JXWfnOGLoHZtB2fAHTMU3klFFa/8BQYkyPCbxfymLI44+6k/I7ARcbgG1rC0X78MomX4gnl4yM5CN2MZjyiMZaiIwA4PZBvzCRgMdTtUKa3IuZfaR2cFO7vBDvlFBfNHF/Nhxc/s+C+EndZBhHE0aAswVSmrvkOCndX5QDY0+22Cc8kX0JkImtNzvV5og4GtRLP3LJStG2VuRFJwPiA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(786006)(1800799024)(376014)(366016)(19092799006); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUpBVUJVNytQUFJWWmt5ZVBaV1Zzcjg4VDJCSCtvaFNVSzExU016T09mZFZq?=
 =?utf-8?B?em1lR2tkY1JpTXRWM0dJOUtVTWdSeHE1eWloMU5UUWdtVU92ME5lUmg2UGZJ?=
 =?utf-8?B?Sit4b2pGVTNpaytHM3lEN2ZiY2tBS3o1TWlIeUd5dmNWenlqdWJKYTJXNTh2?=
 =?utf-8?B?VFY1ZWdCNklXblUrZ1ErelZWN2JrMFI5YURIM25RNmp1UlgwOGRWeTZYVW0x?=
 =?utf-8?B?RGhRVlJFQjFLbzlqUzlCdzhUTzZZUWx3MnpDNVF0djhob0l6R21qblVHbkx3?=
 =?utf-8?B?ZUtpZEF5N2k3OFBZUzBNUzJJc1lPM0pxWGV5VUgvRWVlWWxzM2Irc3NJcEdh?=
 =?utf-8?B?ZzlDY1psZ0N3NEQ0OTJiV1p3MnhCdW1vVzRLZUkvK0dsTWhCZ3dRNVVUTjV3?=
 =?utf-8?B?MHFxd25lYktocDBRemV6QzRmeW5nZGxiRnlMc29JVzVRTWE2aTJyclR5M1Bt?=
 =?utf-8?B?NFUrMndWZDlGQm5oS2prbE5DK2pVMEtybllSU1kzL2NmQ0MzZTFnMHNjRTE5?=
 =?utf-8?B?c3NNTDYzVFJnR3dacFY0SDdNa0tqNWMzSXUzY3l5QU9iMWdhTkcvMmU1ei8y?=
 =?utf-8?B?V1YzS1VURVBTUE9oNU1jUEZFZWttZ2MrRGRXNTl6UDkxRnVmVzlJY3NOazdJ?=
 =?utf-8?B?czRIbFdzR3RYclIwRjVKZE5QWFZneSsrRjE5eStQY2FlTG1ZbzBKTjMrL1No?=
 =?utf-8?B?VHhjaGZ1aVJ6U0JmT2dIcVRtM2ZRaGtqN3pwQ2lrdFFCUzBZaHpQMVIyN0F4?=
 =?utf-8?B?dEhHT2pEczdaWXBSNFFtbnRIbXpWd3ZwdEI4Y2tOMnV6THJsSTJoRFQvT3RI?=
 =?utf-8?B?RjBPeUdQZUJhMG54SDNaZnFDMlJvTVRHdGVkRE5NQitvd1Z0YjI2TEdIbm1Z?=
 =?utf-8?B?RDV4VlIyYVpTVlNROFU5OWN5bG5Sc1VMRkpMdXdWM1BncUVRcFlEMFBHWHE5?=
 =?utf-8?B?ZGhRcFBXVmRJcTRnWnJ2Z2NwUkx3V3VpTWI5UmxzSkJLSlg0ZDdPK3B2M1o4?=
 =?utf-8?B?aFRMUHpsQ0h5ditiTTllanVDMlhZRlNKc2dUcHUwSVJ4ZHhNcHFZRTg1K2Q1?=
 =?utf-8?B?MkZPVHZ1OStBbUpXcVpleCsyc0RWMmNTaWtzc3A5cTlOaXE2MU1makJpMkRr?=
 =?utf-8?B?OFlrWVh2V0JRR2xSYUFIWkx5UEYvZFFCOS9QOFp5dGJycXA2ZTc4K2dKZGNw?=
 =?utf-8?B?enE5akEwa0U2cm1LWjBoK1JhdzVmSTgxNEp3Y2g5dWc1TnJHNDJyeTBJTnNi?=
 =?utf-8?B?QnB4bHVQU0t2UlRGUzcvUDZuQTlCZ2VnZjA1ZFFKY2hvTFZvY1VhRDFwS0RZ?=
 =?utf-8?B?enQ5RWRKRUJ0djd4cVMwUUFaQ1ZDNnc0QlFMMkQxN3VZUldEb2M3OUp6c3M5?=
 =?utf-8?B?WnoxZmpNY0JWVmJLVXFVcGRVK3NGUkpNR1NxRWIvT0E1andrVjA3TmxlNXFq?=
 =?utf-8?B?aEtPdy9qM2NsTGY5aDNDQ0J6NE14cFc1dVZuRnllOG94bWxKU2dSdUJhdVZV?=
 =?utf-8?B?c2VESHVnc2VldTZHaFNobGc2ZGpCa0dieExnbkNYY0E0bU1yQWRvQXVzZnB6?=
 =?utf-8?B?L1J2QXZpL0JDYWorS2hXdEFDSW9nTWdKLzk0bzRucFZCRi9xN2FBV1dlVlZ4?=
 =?utf-8?B?NVBjcnlESk0rRWprWUoxbTFtTmwvL0JPQ2JUOXNaWnZmUUIzNlJSZzlSNFEy?=
 =?utf-8?B?N21vVk45MExSc1hhbzJYY3EvOTFJaGZKVFd1VWdLUVROeHNwT1dKbkhWa2tF?=
 =?utf-8?B?UGltMDNEeXBpb3RKVFBxL1Q4MXNNejlQSTVCd1VlWjFjMnBVdWUrbnFscWdW?=
 =?utf-8?B?anptdXFITld0L2E4U0JhUW1DUTBNYXduWWxlR3ZYL2k2SUNGV1lDWnJlQ0Vi?=
 =?utf-8?B?bFRqSTd2TFN0OGlJKzhDZ0duRU5meWZOVURxNlpDNG4zU0RCUm5OcEQ1NmhL?=
 =?utf-8?B?TFpIREE1M3RBZXFaNHE4RmE4MW9VT2tKZlJqRHorYzVPc2xhYjQ5SFZvaHBD?=
 =?utf-8?B?YjZjYUs0eVpjR2RkVHNVZVl4U3RzWGJ4RE1TSlAvZmNMbFBRZENkL002bzdx?=
 =?utf-8?B?dm4yaEoyYU5KaG54cys3am1jTWhqRG82bXI5TTc4QkNPR2VLajU3T0ZnSE5m?=
 =?utf-8?B?ZCtRNE1mUG9rKzFQMGtCY2ZqSmI5eVNTbzhrREYranZYdDdrR3V4Vml5dmZs?=
 =?utf-8?B?OXNWdjVYdEs0ZEIwRy9maUUzWGF5MktrSERQVlAyTUVPMDF2S0Y5eWxCQU9u?=
 =?utf-8?B?d0JteXFtQ2VjVDlmUWtwMDRqWDlBdTJ2YUR6VFNDajhRL01aYWlQVnhkVGVy?=
 =?utf-8?B?MGZCdlc5eWlFVGE0M1V1S2E5ZFY5bWZSNEYzcFdaS3A2emdIRGlRUT09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d541333-ded5-4066-05f4-08de7a052202
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 15:45:59.9141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AqkTZl7rMrG09Tq5FKF/1DXbpdQ6wjZGnZ+JmS7KXSe26pjY5kE9SojIQoV4Hnil9jk1ie4WXG1v/DsWouhtqvo3LL1iaR6DoSsEv98XEdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0047
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

--------------ms000303020502040008090402
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/03/2026 16:35, Florian Hofhammer wrote:
> On 03/03/2026 20:46, Pierrick Bouvier wrote:
>> On 3/3/26 5:07 AM, Florian Hofhammer wrote:
>>> The test plugin intercepts execution in different contexts. Without t=
he
>>> plugin, any of the implemented test functions would trigger an assert=

>>> and fail. With the plugin, control flow is redirected to skip the ass=
ert
>>> and return cleanly via the qemu_plugin_set_pc() API.
>>>
>>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>>> ---
>>>   MAINTAINERS                                        |   1 +
>>>   tests/tcg/arm/Makefile.target                      |   6 +
>>>   tests/tcg/multiarch/Makefile.target                |  17 ++-
>>>   .../multiarch/{ =3D> plugin}/check-plugin-output.sh  |   0
>>>   .../{ =3D> plugin}/test-plugin-mem-access.c          |   0
>>>   tests/tcg/multiarch/plugin/test-plugin-set-pc.c    | 140 ++++++++++=
+++++++++++
>>>   tests/tcg/plugins/meson.build                      |   1 +
>>>   tests/tcg/plugins/setpc.c                          | 120 ++++++++++=
++++++++
>>>   8 files changed, 282 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 6698e5ff69..63c0af4d86 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -4104,6 +4104,7 @@ S: Maintained
>>>   F: docs/devel/tcg-plugins.rst
>>>   F: plugins/
>>>   F: tests/tcg/plugins/
>>> +F: tests/tcg/multiarch/plugin/
>>>   F: tests/functional/aarch64/test_tcg_plugins.py
>>>   F: contrib/plugins/
>>>   F: scripts/qemu-plugin-symbols.py
>>> diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.t=
arget
>>> index 6189d7a0e2..613bbf0939 100644
>>> --- a/tests/tcg/arm/Makefile.target
>>> +++ b/tests/tcg/arm/Makefile.target
>>> @@ -78,4 +78,10 @@ sha512-vector: sha512.c
>>>     ARM_TESTS +=3D sha512-vector
>>>   +ifeq ($(CONFIG_PLUGIN),y)
>>> +# Require emitting arm32 instructions, otherwise the vCPU might acci=
dentally
>>> +# try to execute Thumb instructions in arm32 mode after qemu_plugin_=
set_pc()
>>> +test-plugin-set-pc: CFLAGS+=3D-marm
>>> +endif
>>> +
>>
>> Is that still needed?
>=20
> Yes, unfortunately. The compiler emits Thumb2 instructions where it
> deems it appropriate but the addresses of functions/labels are still at=

> least 2-byte aligned and therefore don't have the bottom bit set.
> Setting the PC to an even address therefore makes the vCPU think the
> target is in arm32 mode, and it tries to execute the Thumb2 instruction=
s
> in arm32 mode. I'd either need to ensure that the targets are always in=

> Thumb2 mode and set the bottom bit myself, or ensure that everything is=

> in arm32 mode from the start.
>=20
>>>   TESTS +=3D $(ARM_TESTS)
>>> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarc=
h/Makefile.target
>>> index 07d0b27bdd..a347efbadf 100644
>>> --- a/tests/tcg/multiarch/Makefile.target
>>> +++ b/tests/tcg/multiarch/Makefile.target
>>> @@ -14,6 +14,10 @@ ifeq ($(filter %-linux-user, $(TARGET)),$(TARGET))=

>>>   VPATH            +=3D $(MULTIARCH_SRC)/linux
>>>   MULTIARCH_SRCS +=3D $(notdir $(wildcard $(MULTIARCH_SRC)/linux/*.c)=
)
>>>   endif
>>> +ifeq ($(CONFIG_PLUGIN),y)
>>> +VPATH            +=3D $(MULTIARCH_SRC)/plugin
>>> +MULTIARCH_SRCS +=3D $(notdir $(wildcard $(MULTIARCH_SRC)/plugin/*.c)=
)
>>> +endif
>>>   MULTIARCH_TESTS =3D $(MULTIARCH_SRCS:.c=3D)
>>>     #
>>> @@ -200,13 +204,20 @@ run-plugin-test-plugin-mem-access-with-libmem.s=
o: \
>>>       PLUGIN_ARGS=3D$(COMMA)print-accesses=3Dtrue
>>>   run-plugin-test-plugin-mem-access-with-libmem.so: \
>>>       CHECK_PLUGIN_OUTPUT_COMMAND=3D \
>>> -    $(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
>>> +    $(SRC_PATH)/tests/tcg/multiarch/plugin/check-plugin-output.sh \
>>>       $(QEMU) $<
>>>   run-plugin-test-plugin-syscall-filter-with-libsyscall.so:
>>> +run-plugin-test-plugin-set-pc-with-libsetpc.so:
>>>     EXTRA_RUNS_WITH_PLUGIN +=3D run-plugin-test-plugin-mem-access-wit=
h-libmem.so \
>>> -              run-plugin-test-plugin-syscall-filter-with-libsyscall.=
so
>>> -else
>>> +              run-plugin-test-plugin-syscall-filter-with-libsyscall.=
so \
>>> +              run-plugin-test-plugin-set-pc-with-libsetpc.so
>>> +
>>> +else # CONFIG_PLUGIN=3Dn
>>> +# Do not build the syscall skipping test if it's not tested with the=
 setpc
>>> +# plugin because it will simply fail the test.
>>> +MULTIARCH_TESTS :=3D $(filter-out test-plugin-set-pc, $(MULTIARCH_TE=
STS))
>>> +
>>>   # test-plugin-syscall-filter needs syscall plugin to succeed
>>>   test-plugin-syscall-filter: CFLAGS+=3D-DSKIP
>>>   endif
>>> diff --git a/tests/tcg/multiarch/check-plugin-output.sh b/tests/tcg/m=
ultiarch/plugin/check-plugin-output.sh
>>> similarity index 100%
>>> rename from tests/tcg/multiarch/check-plugin-output.sh
>>> rename to tests/tcg/multiarch/plugin/check-plugin-output.sh
>>> diff --git a/tests/tcg/multiarch/test-plugin-mem-access.c b/tests/tcg=
/multiarch/plugin/test-plugin-mem-access.c
>>> similarity index 100%
>>> rename from tests/tcg/multiarch/test-plugin-mem-access.c
>>> rename to tests/tcg/multiarch/plugin/test-plugin-mem-access.c
>>> diff --git a/tests/tcg/multiarch/plugin/test-plugin-set-pc.c b/tests/=
tcg/multiarch/plugin/test-plugin-set-pc.c
>>> new file mode 100644
>>> index 0000000000..40d9a9e8f0
>>> --- /dev/null
>>> +++ b/tests/tcg/multiarch/plugin/test-plugin-set-pc.c
>>> @@ -0,0 +1,140 @@
>>> +/*
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + *
>>> + * Copyright (C) 2026, Florian Hofhammer <florian.hofhammer@epfl.ch>=

>>> + *
>>> + * This test set exercises the qemu_plugin_set_pc() function in four=
 different
>>> + * contexts:
>>> + * 1. in a syscall callback,
>>> + * 2. in an instruction callback during normal execution,
>>> + * 3. in an instruction callback during signal handling,
>>> + * 4. in a memory access callback.
>>> + * Note: using the volatile guards is necessary to prevent the compi=
ler from
>>> + * doing dead code elimination even on -O0, which would cause everyt=
hing after
>>> + * the asserts and thus also the target labels to be optimized away.=

>>> + */
>>> +#include <assert.h>
>>> +#include <signal.h>
>>> +#include <stdint.h>
>>> +#include <stdlib.h>
>>> +#include <stdio.h>
>>> +#include <unistd.h>
>>> +#include <setjmp.h>
>>> +
>>> +#define NOINLINE __attribute__((noinline))
>>
>> Test being compiled in O0, it should not need any noinline attribute.
>=20
> Ack, removed.
>=20
>>> +#define NORETURN __attribute__((noreturn))
>>
>> It's used in a single place, simply move the the attribute there, no n=
eed for another define.
>=20
> Ditto.
>=20
>>> +
>>> +static int signal_handled;
>>> +/*
>>> + * The volatile variable is used as a guard to prevent the compiler =
from
>>> + * optimizing away "unreachable" labels.
>>> + */
>>> +static volatile uint32_t guard =3D 1;
>>> +
>>
>> As mentioned on v4, you can simply use an external function for failin=
g the test, which won't be tainted with noreturn attribute.
>> This way, you don't need any guard at all or assert(0), and resulting =
code is linear and easier to read.
>> It test completes, it all worked. If it crashes, something was wrong.
>>
>> void panic(void)
>> {
>>      g_assert_not_reached();
>> }
>>
>> void test_...() {
>> ...
>> on_panic:
>>      panic();
>> after_panic:
>>      printf("Hello World\n");
>> }
>=20
> I've reworked it to look similar to this (without g_assert_not_reached(=
)
> though, because glib is not available in the test itself). Still
> required some shuffling of stuff to make sure the compiler doesn't
> optimize things away then :) Especially on hexagon, which is the only
> target (by default) built with clang instead of gcc. Clang/LLVM seems t=
o
> be way more aggressive even at -O0 to do deadcode elimination and
> inlining, so I had to add extra CFLAGS for the hexagon target.
>=20
>>> + * This test executes a magic syscall which communicates two address=
es to the
>>> + * plugin via the syscall arguments. Whenever we reach the "bad" ins=
truction
>>> + * during normal execution, the plugin should redirect control flow =
to the
>>> + * "good" instruction instead.
>>> + */
>>> +NOINLINE void test_insn(void)
>>> +{
>>> +    long ret =3D syscall(4095, &&bad_insn, &&good_insn, NULL);
>>> +    assert(ret =3D=3D 0 && "Syscall filter did not return expected v=
alue");
>>> +    if (guard) {
>>> +bad_insn:
>>> +        assert(0 && "PC redirection in instruction callback failed")=
;
>>> +    } else {
>>> +good_insn:
>>> +        return;
>>> +    }
>>> +}
>>> +
>>> +/*
>>> + * This signal handler communicates a "bad" and a "good" address to =
the plugin
>>> + * similar to the previous test, and skips to the "good" address whe=
n the "bad"
>>> + * one is reached. This serves to test whether PC redirection via
>>> + * qemu_plugin_set_pc() also works properly in a signal handler cont=
ext.
>>> + */
>>> +NOINLINE void usr1_handler(int signum)
>>> +{
>>> +    long ret =3D syscall(4095, &&bad_signal, &&good_signal, NULL);
>>> +    assert(ret =3D=3D 0 && "Syscall filter did not return expected v=
alue");
>>> +    if (guard) {
>>> +bad_signal:
>>> +        assert(0 && "PC redirection in instruction callback failed")=
;
>>> +    } else {
>>> +good_signal:
>>> +        signal_handled =3D 1;
>>> +        return;
>>> +    }
>>> +}
>>> +
>>> +/*
>>> + * This test sends a signal to the process, which should trigger the=
 above
>>> + * signal handler. The signal handler should then exercise the PC re=
direction
>>> + * functionality in the context of a signal handler, which behaves a=
 bit
>>> + * differently from normal execution.
>>> + */
>>> +NOINLINE void test_sighandler(void)
>>> +{
>>> +    struct sigaction sa =3D {0};
>>> +    sa.sa_handler =3D usr1_handler;
>>> +    sigaction(SIGUSR1, &sa, NULL);
>>> +    pid_t pid =3D getpid();
>>> +    kill(pid, SIGUSR1);
>>> +    assert(signal_handled =3D=3D 1 && "Signal handler was not execut=
ed properly");
>>> +}
>>> +
>>> +/*
>>> + * This test communicates a "good" address and the address of a loca=
l variable
>>> + * to the plugin. Upon accessing the local variable, the plugin shou=
ld then
>>> + * redirect control flow to the "good" address via qemu_plugin_set_p=
c().
>>> + */
>>> +NOINLINE void test_mem(void)
>>> +{
>>> +    long ret =3D syscall(4095, NULL, &&good_mem, &guard);
>>
>> Since you use two different syscall numbers, it's worth adding two def=
ines, that you will duplicate in test and plugin.
>> Alternatively, you can use the first parameter of syscall to identify =
which kind of "service" you want from plugin, with defines duplicated bet=
ween test and plugin again.
>> Feel free to pick the solution you prefer.
>>
>> Reading 4095 the first time here felt like it was a typo mistake.
>=20
> Ack, reworked this to be clearer.
>=20
>>
>>> +    assert(ret =3D=3D 0 && "Syscall filter did not return expected v=
alue");
>>> +    if (guard) {
>>> +        assert(0 && "PC redirection in memory access callback failed=
");
>>> +    } else {
>>> +good_mem:
>>> +        return;
>>> +    }
>>> +}
>>> +
>>> +/*
>>> + * This test executes a magic syscall which is intercepted and its a=
ctual
>>> + * execution skipped via the qemu_plugin_set_pc() API. In a proper p=
lugin,
>>> + * syscall skipping would rather be implemented via the syscall filt=
ering
>>> + * callback, but we want to make sure qemu_plugin_set_pc() works in =
different
>>> + * contexts.
>>> + */
>>> +NOINLINE NORETURN
>>> +void test_syscall(void)
>>> +{
>>> +    syscall(4096, &&good_syscall);
>>> +    if (guard) {
>>> +        assert(0 && "PC redirection in syscall callback failed");
>>> +    } else {
>>> +good_syscall:
>>> +        /*
>>> +         * Note: we execute this test last and exit straight from he=
re because
>>> +         * when the plugin redirects control flow upon syscall, the =
stack frame
>>> +         * for the syscall function (and potential other functions i=
n the call
>>> +         * chain in libc) is still live and the stack is not unwound=
 properly.
>>> +         * Thus, returning from here is risky and breaks on some arc=
hitectures,
>>> +         * so we just exit directly from this test.
>>> +         */
>>> +        _exit(EXIT_SUCCESS);
>>> +    }
>>> +}
>>> +
>>> +
>>> +int main(int argc, char *argv[])
>>> +{
>>> +    test_insn();
>>> +    test_sighandler();
>>> +    test_mem();
>>> +    test_syscall();
>>> +}
>>> diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.=
build
>>> index c5e49753fd..b3e3a9a6d0 100644
>>> --- a/tests/tcg/plugins/meson.build
>>> +++ b/tests/tcg/plugins/meson.build
>>> @@ -7,6 +7,7 @@ test_plugins =3D [
>>>   'mem.c',
>>>   'patch.c',
>>>   'reset.c',
>>> +'setpc.c',
>>>   'syscall.c',
>>>   ]
>>>   diff --git a/tests/tcg/plugins/setpc.c b/tests/tcg/plugins/setpc.c
>>> new file mode 100644
>>> index 0000000000..72ae31a0ef
>>> --- /dev/null
>>> +++ b/tests/tcg/plugins/setpc.c
>>> @@ -0,0 +1,120 @@
>>> +/*
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + *
>>> + * Copyright (C) 2026, Florian Hofhammer <florian.hofhammer@epfl.ch>=

>>> + */
>>> +#include <assert.h>
>>> +#include <glib.h>
>>> +#include <inttypes.h>
>>> +#include <unistd.h>
>>> +
>>> +#include <qemu-plugin.h>
>>> +
>>> +QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
>>> +
>>> +static uint64_t source_pc;
>>> +static uint64_t target_pc;
>>> +static uint64_t target_vaddr;
>>> +
>>> +static void vcpu_syscall(qemu_plugin_id_t id, unsigned int vcpu_inde=
x,
>>> +                         int64_t num, uint64_t a1, uint64_t a2,
>>> +                         uint64_t a3, uint64_t a4, uint64_t a5,
>>> +                         uint64_t a6, uint64_t a7, uint64_t a8)
>>> +{
>>> +    if (num =3D=3D 4096) {
>>> +        qemu_plugin_outs("Marker syscall detected, jump to clean ret=
urn\n");
>>> +        qemu_plugin_set_pc(a1);
>>> +    }
>>> +}
>>> +
>>> +static bool vcpu_syscall_filter(qemu_plugin_id_t id, unsigned int vc=
pu_index,
>>> +                                int64_t num, uint64_t a1, uint64_t a=
2,
>>> +                                uint64_t a3, uint64_t a4, uint64_t a=
5,
>>> +                                uint64_t a6, uint64_t a7, uint64_t a=
8,
>>> +                                uint64_t *sysret)
>>> +{
>>> +    if (num =3D=3D 4095) {
>>> +        qemu_plugin_outs("Communication syscall detected, set target=
_pc / "
>>> +                         "target_vaddr\n");
>>> +        source_pc =3D a1;
>>> +        target_pc =3D a2;
>>> +        target_vaddr =3D a3;
>>> +        if (source_pc >> 63 || target_pc >> 63 || target_vaddr >> 63=
) {
>>> +            /*
>>> +             * Some architectures (e.g., m68k) use 32-bit addresses =
with the
>>> +             * top bit set, which causes them to get sign-extended s=
omewhere in
>>> +             * the chain to this callback. We mask the top bits off =
here to get
>>> +             * the actual addresses.
>>> +             */
>>
>> This looks like an actual bug. Using a backtrace here, can you find wh=
ich function extended it?
>> Parameter should be treated as unsigned everywhere, else something is =
really going wrong.
>=20
> tl;dr: register values are considered signed in the syscall handling
> code, which seems incorrect to me. Details below.
>=20
> This seems to be a bigger issue in the syscall handling code and I'm
> surprised this never surfaced before. Generally, the CPUArchState struc=
t
> in target/*/cpu.h defines the registers as unsigned types. When a
> syscall is encountered, the main cpu loop calls do_syscall() from
> linux-user/syscall.c, which takes and returns abi_long values. abi_long=

> is defined as either int32_t or target_long in include/user/abitypes.h
> and therefore a signed type, so the register values get converted from
> unsigned to signed types here. do_syscall() passes those abi_long value=
s
> on, e.g., to record_syscall_start() and send_through_syscall_filters(),=

> which still take the register values in as abi_long. Those in turn
> however pass the values on to qemu_plugin_vcpu_syscall() and
> qemu_plugin_vcpu_syscall_filter(), respectively. Those two functions no=
w
> take uint64_t values for the arguments, so for 32-bit architectures the=

> conversion chain is uint32_t (CPUArchState) -> int32_t (do_syscall) ->
> uint64_t (callbacks).
>=20
> This seems to be some bigger refactoring changing all those abi_longs t=
o
> abi_ulongs. Would you like me to prepare a separate patch series for
> this?

As a follow-up on this, changing this seems to be a bit more complicated
than I initially thought. The arguments could be simply made unsigned,
but the return value (which is also just a register content and should
therefore be unsigned if I understand correctly) can't easily be made
unsigned. The per-target main loop relies on the return value of
do_syscall() to be signed to determine whether one of the QEMU-specific
errors (e.g., QEMU_ERESTARTSYS) was returned.

>>
>>> +            qemu_plugin_outs("High bit in addresses detected: possib=
le sign "
>>> +                             "extension in syscall, masking off top =
bits\n");
>>> +            source_pc &=3D UINT32_MAX;
>>> +            target_pc &=3D UINT32_MAX;
>>> +            target_vaddr &=3D UINT32_MAX;
>>> +        }
>>> +        *sysret =3D 0;
>>> +        return true;
>>> +    }
>>> +    return false;
>>> +}
>>> +
>>> +static void vcpu_insn_exec(unsigned int vcpu_index, void *userdata)
>>> +{
>>> +    uint64_t vaddr =3D (uint64_t)userdata;
>>> +    if (vaddr =3D=3D source_pc) {
>>> +        g_assert(target_pc !=3D 0);
>>> +        g_assert(target_vaddr =3D=3D 0);
>>> +
>>> +        qemu_plugin_outs("Marker instruction detected, jump to clean=
 return\n");
>>> +        qemu_plugin_set_pc(target_pc);
>>> +    }
>>> +}
>>> +
>>> +static void vcpu_mem_access(unsigned int vcpu_index,
>>> +                            qemu_plugin_meminfo_t info,
>>> +                            uint64_t vaddr, void *userdata)
>>> +{
>>> +    if (vaddr !=3D 0 && vaddr =3D=3D target_vaddr) {
>>> +        g_assert(source_pc =3D=3D 0);
>>> +        g_assert(target_pc !=3D 0);
>>> +        qemu_plugin_mem_value val =3D qemu_plugin_mem_get_value(info=
);
>>> +        /* target_vaddr points to our volatile guard =3D=3D> should =
always be 1 */
>>> +        g_assert(val.type =3D=3D QEMU_PLUGIN_MEM_VALUE_U32);
>>> +        g_assert(val.data.u32 =3D=3D 1);
>>> +
>>> +        qemu_plugin_outs("Marker mem access detected, jump to clean =
return\n");
>>> +        qemu_plugin_set_pc(target_pc);
>>> +    }
>>
>> Thanks for adding this case also!
>> So you'll definitely need a read for this precise test, to be able to =
keep a load. If it would work with a local variable, that's good, else, t=
ry with a local static (eventually marked volatile if it helps), and in l=
ast case, use a global variable.
>=20
> Works fine with a local variable!
>=20
>>
>>> +}
>>> +
>>> +static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb=
 *tb)
>>> +{
>>> +    size_t insns =3D qemu_plugin_tb_n_insns(tb);
>>> +    for (size_t i =3D 0; i < insns; i++) {
>>> +        struct qemu_plugin_insn *insn =3D qemu_plugin_tb_get_insn(tb=
, i);
>>> +        uint64_t insn_vaddr =3D qemu_plugin_insn_vaddr(insn);
>>> +        /*
>>> +         * Note: we cannot only register the callbacks if the instru=
ction is
>>> +         * in one of the functions of interest, because symbol looku=
p for
>>> +         * filtering does not work for all architectures (e.g., ppc6=
4).
>>> +         */
>>
>> Too sad :)
>> It's not a problem to instrument all instructions though.
>>
>>> +        qemu_plugin_register_vcpu_insn_exec_cb(insn, vcpu_insn_exec,=

>>> +                                               QEMU_PLUGIN_CB_RW_REG=
S_PC,
>>> +                                               (void *)insn_vaddr);
>>> +        qemu_plugin_register_vcpu_mem_cb(insn, vcpu_mem_access,
>>> +                                         QEMU_PLUGIN_CB_RW_REGS_PC,
>>> +                                         QEMU_PLUGIN_MEM_R, NULL);
>>> +    }
>>> +}
>>> +
>>> +
>>> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>>> +                                           const qemu_info_t *info,
>>> +                                           int argc, char **argv)
>>> +{
>>> +
>>> +    qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall);
>>> +    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_fil=
ter);
>>> +    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>>> +    return 0;
>>> +}
>>>
>>
>> Thanks for the update.
>> Test looks good, and minus the style nits reported, it looks quite rea=
dy.
>> It would be nice if we could sort the signed parameter extension also =
to avoid a hack on this.
>>
>> Regards,
>> Pierrick
>=20
> Best regards,
> Florian

--------------ms000303020502040008090402
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
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDMwNDE1NDU1OFowLwYJKoZI
hvcNAQkEMSIEIMbzof2cFvMFLVgjIRuvdqzYw4+dVEewM2YZeFAITyOcMIGFBgkrBgEEAYI3
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
gQQBDgIwCAYGK4EEAQ4DMA0GCSqGSIb3DQEBAQUABIIBAHYPfPjjHCsIE6fkhhJxaIAxb8nK
lVDl7vmuNQaU8Exq+vM37KbB5sUnrIm6ptDvMJWGm9YhMFPpY1PDQtFvD75gPaxGrK2KgV86
t5INQQsXdgt4IGHrOFdaeObnp5Wwa4AGAaoRUyi4F2un+jVABJ2mSJL4S4dEtwARMNg1Ca0U
mnAqlc2u6lYIZ02rTU78DV3TROEUv+kxvKs1T/m8t/nnEOIpnJv69Sey6YhGxqRIC5NY53D+
ENNfRrNiG2eW+KjaH41+x9ZtWGYydA1w6syXd0nl/Fnye7bMwgPDBN5jVPLAqbNM/BQAkfZO
hrHaw+iJ+NAGlnOrEWMYb9tMsS0AAAAAAAA=

--------------ms000303020502040008090402--

