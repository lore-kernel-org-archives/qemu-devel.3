Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0260EEF9002
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxow0-0000lC-VK; Wed, 04 Mar 2026 11:18:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vxow0-0000l2-4c
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:18:52 -0500
Received: from
 mail-switzerlandnorthazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c213::5] helo=ZR1P278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vxovw-0002kb-FR
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:18:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYFN34cRPqUP7Q0N6YipS48gU3nXb8eYEMAKcDI3z/pYO+j4FS/Arr/vJ+Ffkgsw23TqwmaJwcT9YOlCvktvIw+hfy0ZvHTm9C3erm8HXXx4ooZoqCrhF4Rp7vSFUsLEKQdBTUn215zfUg+4zHaYfmYDDunm0TxJCdIEwBMbCx9HDOz9RVHSWtpyLyuRi9yESbnAI4bnX+fha6loqLZm02+k6y0XYnab+HhhQOldnp5rUl3m6iWTLfOTqxoz/kWrp9qps+k4Vx6qlLSZODsiG6Y1mdAkDLCwPvBSk0lv8A0ZvkjBplB9aKADxxUfjJr2/YogltQHLgt/Kxr7u/mK9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnyxfrfMwn9lDURzq6yVG1INnOcL8WdpqKdoUOyVWD4=;
 b=kX1LuNDgqkaUf0MaHb1JMtR58QvOgrODBhYK8r0nApnyzVGzZgBU04Hsoq5jJ0NtupYGY1LGEwEymD6UX7YsfgaRod2GtApXUG6HbnRqvsEnyr5Wsq3LdhHFlpY4sMxmAveMPmTaPZW2jGNZlQM7WPTP13RNePTxr/4vgHgcaogxDSkW7vyAyx3VEfpyMriwr3Sl6c1YBmXZ6xGdqBvkhspcWigv5njTszVoWdHto1KRS6sXhBx+ijBE4iA1m9ydBHUPgmY9A1gImaaJnVrAak0CmfJEHGTcW9DnjGsygw+Eaz5rVhzpP7B7EhXgsyekN7dBv5BlY1giD0RJ+x7OWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnyxfrfMwn9lDURzq6yVG1INnOcL8WdpqKdoUOyVWD4=;
 b=aPEYAAfcna3wGvOI76zQ3uE9YjtYzl/6EKxz7+M+X4mTuC8OBNoCxjXE7smnP8opfoxKP2xCczkK4n8YviXOL9k3VIEAsfvZbBFMw8PC+UGafCrZVcKRMRtkh45o5Kt12TTFM3YjPllt4ZomdJC52tqIRvmRYru3ysjdSO1ecS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR3P278MB1656.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:8d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 16:18:42 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 16:18:42 +0000
Message-ID: <eb4a6f15-a63c-48aa-a7c0-832d123b98f5@epfl.ch>
Date: Wed, 4 Mar 2026 17:18:41 +0100
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
 <5a9a17dc-9781-418c-ae23-a183234e4a53@epfl.ch>
Content-Language: en-US
In-Reply-To: <5a9a17dc-9781-418c-ae23-a183234e4a53@epfl.ch>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="------------ms040005070403060408040504"
X-ClientProxiedBy: GV0P278CA0023.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::10) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR3P278MB1656:EE_
X-MS-Office365-Filtering-Correlation-Id: cd1eac5a-7e37-415a-75f3-08de7a09b3c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|786006|19092799006|376014|366016; 
X-Microsoft-Antispam-Message-Info: SjACznX9g0socsuLiUW7IeiHmZiR2QIueMwBzxjN6iyPimEtPuq+cM6RfKIdl2aNf0bAY6CW3O2iE9k2Ljj2Vnc4bLUT+48EFWyhXBrtWcg3AVlOhe1nzsqyPND1Gc23kY/wLLQtlijGvkX+faqkkCCQEDDrvVFM3yEPUa0tQnuJ8v+sjDEMf1DHvcGdj1We08gKZLyR2yPCeTaPqspdJBaLHCYah8OK/axxkFsD6rp69hm98sPo1hwuA9h0KCU5p2lZiCDTsaDvCFCy/tlVS+XMHDw0XyCAc5pKC0aI9VmWP1Q3EjgI6KTyEm5P0EdSsXbM5LkwZZ7YRJaxbDI6P8sKhYf5DpLbpjRbASPzryawYHEXFRRP1aHkC1aehO9F79XLMqUrxe/oFTB43rDFpqkbO52eywNGRq71hlYfbVcU0Gy7Ev/n1A8L40bGeOZ7RjL59ts5s9pzRI1hn1Hfc80Elmsh5S1hgfQNYrieRQnDJNjQ5vY9umydTzA5vJyh977iuu4TW7miK9c46nyu2Pi5JW3zw+Ol+h7juq1hrwKXmbXnRd0VjYwjiviBZ6Pj97IIXYdiiQns0oGqQaVlne2OD6UJlRxycWRwwW8s38Dz2jeEP4TRrNN2wm/JUDUs5UAVb+Z0B3oshGpjm9jMCoGekfCMR7N2uS7927mPu3W3Yb4QAbHFAInKm1LpRbvyY3KXycWrp0kr55MkAxHf0nM7rBibH+AXw00pVApdRoE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(786006)(19092799006)(376014)(366016); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akpaMlFyWXBuMlpUUFdrRE0vaDFUOWllaXBPLy91NitNVENPdGd2WGZrTXBS?=
 =?utf-8?B?dmlUWkZRRkRQVjFWM0h0S1R5QkxHZWIrUktPOTNUU1Uwei9CcGcrSmQ0MUpq?=
 =?utf-8?B?cDNMcTErMGI4d1RPMndGUm9ITWlHYUcwZUhUSFZXaEIwNHIrc0JHNStCSnEw?=
 =?utf-8?B?WkVadTRZbnJlTENvbVdPTmx3cTBYOUJiN1RWV05DcUhoaGQ5Smd3dWlJbmtC?=
 =?utf-8?B?Z3ozWXRZSUp3MXROVWEwK3IyaVozS2NNZ1gydk85Q0RDb29rd0s3b1k3cmZi?=
 =?utf-8?B?UHZKNlVNcUZQWmhRb0kwRU5MbUplbUllWTNGTGl1SzYveHV2Rit3dVVTbGdS?=
 =?utf-8?B?aUxBR3NkU1pRMHp3ZjNLS1NyZGdITFNKT2Q4R1dHLzhFUFphZTBLUjQzeGcy?=
 =?utf-8?B?ZUxKa3BNbVJUdnN4eUVCaE0wTTV5Ynh0SEVpN011T1JWU2FVVERvUzhYUlR1?=
 =?utf-8?B?ZzZtOEozZ3BKc0ljNmF0dk0raDV2a0pJamtrRTFqZ3J4OUh4c3dmNlhaV2t1?=
 =?utf-8?B?emhTcURub001UU9FN3NWK2hIUHlBNmhFQktTbHdIMnExK3BzTWxFak9QSEQ0?=
 =?utf-8?B?Vk1Vb0lGeS9URmlrWUFPM011WCtZbWtuWnlXcFArbUtVeWdHYkpqMGhFSktJ?=
 =?utf-8?B?NVRybGdmbExQWU5RbFJ2ajAvWHo1R0xDVWxQMEVnKzhVZHlRQzlrWUloeTR4?=
 =?utf-8?B?bmpUOG1oaGx4TDRkMjVjOWRXQU52WVp6MEg2SGgyME5sSk5KaW8weVQzVnd5?=
 =?utf-8?B?ajkxZzhhcHc5a0RXS1pnM2RWN01GODZZQ1RrNWxtS1FreWR6RjRuM05oeGxs?=
 =?utf-8?B?THVpZ1RRVEVDZlBMTlpFMFpzRGYxSEZkRTZNZWxHemQwTUdzc3ZaLzgvYU5X?=
 =?utf-8?B?ZG5jVWV0dmZqck1kQ3UxNG8xdmlvWU5TemZNWVZnWk82TnJNV09HS1pkVk1x?=
 =?utf-8?B?eFEwVWluc2c2ZG02K2ZieDBaWVpGeXh0d3I3c3VTenBLbkF2YWIrdDZaRzVD?=
 =?utf-8?B?OHpvM2g4d3JrRGJ5dUhMUWdIVTA0c1ZGSUUwUmxnNXlVVll6QnNlclZ2Y29D?=
 =?utf-8?B?OGVPZUpGY05GK1FDMURVVkthUmpkM3hkcHRCT2Z1YS9GVm91QmNKOVVzaElE?=
 =?utf-8?B?VGtnTDlBR2RzNXFic04xUFJjakx2TnI3RW9UWTEvWHRmS2dJaTdMck1PZ1gy?=
 =?utf-8?B?djRvQlZsQ3lENlhYUUFFaXdIWTJVbUZXRmJvYmpadHkwMzlncnhnVzEvdWZu?=
 =?utf-8?B?eXBMNGZ3SVl3L1hFbE84dXR5LzhEK01rbGIyaElkam16RE1YZ1JaRlAzQ3RM?=
 =?utf-8?B?bXpyQURWZU9CNGordE5pV2o4b1ZBTG1BcGxZRnJ6bU9hTWZkQ1dXM0NpSVda?=
 =?utf-8?B?bjF6ald1NWZCcmhBQ0NhZzVuNDNzQmxvcXBHTGwyY3NiZnNnbEZyc1VHVG5u?=
 =?utf-8?B?NWs3Zm91TVZnWWg4QlYrdGxWWmkwVkpyS3NQZHNQYUxVeXVjWk5IZDdkY0Z4?=
 =?utf-8?B?cnFuZFdZazkwOFpFcTlKOXZQSktJYmZMV2d2V2tmemh4Y3hIMytLMExpZEgv?=
 =?utf-8?B?VFRUdzFkTlFPQ3ZFeTJQZHVjVkdwVHdZV1Y0dWNtbm5rQmVqOFYvWXc5NkJm?=
 =?utf-8?B?aHFNQ3B5aGpqcTRkY040MzAveTIzRzRKM3JVbEE1dUplOWR6b2ZiZUwrY2tl?=
 =?utf-8?B?QUxuRC8xc244ZTlvcFFPRFROSkU4SjdVYmJhRDhhMDdNM2J3TVZLTUM4eGZm?=
 =?utf-8?B?WW5LL3ZraTIvNFAvT1N6MkkyQTlBTGMwVUpxRlR5RUNIS1dIUDBOeFd3ZnZX?=
 =?utf-8?B?U1ZxczBmTVlFd2tQNWxFek5MMGV6TmFqWmtTanJyVEFpR3dCNndvUzFRZGRo?=
 =?utf-8?B?aDNTYjRpbVh6S2Y0dDVrQ0NpQ0NtL1RKVktzbGtkVUM5Qmx2SnJPMG1iZlRV?=
 =?utf-8?B?SUtLcmdYTzVNeHMrM0w4R2ExLzR1QXJGdG9aVlBjc2Z2Z2wxSXR6YWJGMERI?=
 =?utf-8?B?bWxXRWVyYTNlR1NVSE5FQlQ4eEM0cGtzd3dSYUg0NWg3ZHl6SEhrM3E3dGRU?=
 =?utf-8?B?Y0tWSE9JcmZSaEJUbHV4Z3VNdE5panZRa2RPTTlrZks2R3ViVkdLYy9FQ3gy?=
 =?utf-8?B?VTFWV2FzN0UwTDJyWDdrYUdwcjdBdXZUL0NseFdwK0l3ZUZndG1qVmFmYnFi?=
 =?utf-8?B?Tko0QlJuSmVZSDQ2bDBHZ2hOQm5STkRNK09FMWhVU09PRy9YZ3lvbHRVSm5R?=
 =?utf-8?B?RW1XdHRKWUhKK1A1SEZjcVp3clBMS3hTY0NFVHVxejRMN3VwdlZJZGN1NHBB?=
 =?utf-8?B?aFI5RTA2aytrQ1I3eFhPS1lldlNrZXNQc3NDcDlmVFN3cHp6LzRsZz09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1eac5a-7e37-415a-75f3-08de7a09b3c2
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 16:18:42.5477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rcq58keswgFNvuXN1xOVDW7+APHypEA44nf1rMwSzLzzBwskIDemy4PO38e8kOibCL9OVf0zp877YxkHld9xqoaGLPv8CdbYONmyLPdsFqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1656
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

--------------ms040005070403060408040504
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/03/2026 16:45, Florian Hofhammer wrote:
> On 04/03/2026 16:35, Florian Hofhammer wrote:
>> On 03/03/2026 20:46, Pierrick Bouvier wrote:
>>> On 3/3/26 5:07 AM, Florian Hofhammer wrote:
>>>> The test plugin intercepts execution in different contexts. Without =
the
>>>> plugin, any of the implemented test functions would trigger an asser=
t
>>>> and fail. With the plugin, control flow is redirected to skip the as=
sert
>>>> and return cleanly via the qemu_plugin_set_pc() API.
>>>>
>>>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>>>> ---
>>>>   MAINTAINERS                                        |   1 +
>>>>   tests/tcg/arm/Makefile.target                      |   6 +
>>>>   tests/tcg/multiarch/Makefile.target                |  17 ++-
>>>>   .../multiarch/{ =3D> plugin}/check-plugin-output.sh  |   0
>>>>   .../{ =3D> plugin}/test-plugin-mem-access.c          |   0
>>>>   tests/tcg/multiarch/plugin/test-plugin-set-pc.c    | 140 +++++++++=
++++++++++++
>>>>   tests/tcg/plugins/meson.build                      |   1 +
>>>>   tests/tcg/plugins/setpc.c                          | 120 +++++++++=
+++++++++
>>>>   8 files changed, 282 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 6698e5ff69..63c0af4d86 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -4104,6 +4104,7 @@ S: Maintained
>>>>   F: docs/devel/tcg-plugins.rst
>>>>   F: plugins/
>>>>   F: tests/tcg/plugins/
>>>> +F: tests/tcg/multiarch/plugin/
>>>>   F: tests/functional/aarch64/test_tcg_plugins.py
>>>>   F: contrib/plugins/
>>>>   F: scripts/qemu-plugin-symbols.py
>>>> diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.=
target
>>>> index 6189d7a0e2..613bbf0939 100644
>>>> --- a/tests/tcg/arm/Makefile.target
>>>> +++ b/tests/tcg/arm/Makefile.target
>>>> @@ -78,4 +78,10 @@ sha512-vector: sha512.c
>>>>     ARM_TESTS +=3D sha512-vector
>>>>   +ifeq ($(CONFIG_PLUGIN),y)
>>>> +# Require emitting arm32 instructions, otherwise the vCPU might acc=
identally
>>>> +# try to execute Thumb instructions in arm32 mode after qemu_plugin=
_set_pc()
>>>> +test-plugin-set-pc: CFLAGS+=3D-marm
>>>> +endif
>>>> +
>>>
>>> Is that still needed?
>>
>> Yes, unfortunately. The compiler emits Thumb2 instructions where it
>> deems it appropriate but the addresses of functions/labels are still a=
t
>> least 2-byte aligned and therefore don't have the bottom bit set.
>> Setting the PC to an even address therefore makes the vCPU think the
>> target is in arm32 mode, and it tries to execute the Thumb2 instructio=
ns
>> in arm32 mode. I'd either need to ensure that the targets are always i=
n
>> Thumb2 mode and set the bottom bit myself, or ensure that everything i=
s
>> in arm32 mode from the start.
>>
>>>>   TESTS +=3D $(ARM_TESTS)
>>>> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiar=
ch/Makefile.target
>>>> index 07d0b27bdd..a347efbadf 100644
>>>> --- a/tests/tcg/multiarch/Makefile.target
>>>> +++ b/tests/tcg/multiarch/Makefile.target
>>>> @@ -14,6 +14,10 @@ ifeq ($(filter %-linux-user, $(TARGET)),$(TARGET)=
)
>>>>   VPATH            +=3D $(MULTIARCH_SRC)/linux
>>>>   MULTIARCH_SRCS +=3D $(notdir $(wildcard $(MULTIARCH_SRC)/linux/*.c=
))
>>>>   endif
>>>> +ifeq ($(CONFIG_PLUGIN),y)
>>>> +VPATH            +=3D $(MULTIARCH_SRC)/plugin
>>>> +MULTIARCH_SRCS +=3D $(notdir $(wildcard $(MULTIARCH_SRC)/plugin/*.c=
))
>>>> +endif
>>>>   MULTIARCH_TESTS =3D $(MULTIARCH_SRCS:.c=3D)
>>>>     #
>>>> @@ -200,13 +204,20 @@ run-plugin-test-plugin-mem-access-with-libmem.=
so: \
>>>>       PLUGIN_ARGS=3D$(COMMA)print-accesses=3Dtrue
>>>>   run-plugin-test-plugin-mem-access-with-libmem.so: \
>>>>       CHECK_PLUGIN_OUTPUT_COMMAND=3D \
>>>> -    $(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
>>>> +    $(SRC_PATH)/tests/tcg/multiarch/plugin/check-plugin-output.sh \=

>>>>       $(QEMU) $<
>>>>   run-plugin-test-plugin-syscall-filter-with-libsyscall.so:
>>>> +run-plugin-test-plugin-set-pc-with-libsetpc.so:
>>>>     EXTRA_RUNS_WITH_PLUGIN +=3D run-plugin-test-plugin-mem-access-wi=
th-libmem.so \
>>>> -              run-plugin-test-plugin-syscall-filter-with-libsyscall=
=2Eso
>>>> -else
>>>> +              run-plugin-test-plugin-syscall-filter-with-libsyscall=
=2Eso \
>>>> +              run-plugin-test-plugin-set-pc-with-libsetpc.so
>>>> +
>>>> +else # CONFIG_PLUGIN=3Dn
>>>> +# Do not build the syscall skipping test if it's not tested with th=
e setpc
>>>> +# plugin because it will simply fail the test.
>>>> +MULTIARCH_TESTS :=3D $(filter-out test-plugin-set-pc, $(MULTIARCH_T=
ESTS))
>>>> +
>>>>   # test-plugin-syscall-filter needs syscall plugin to succeed
>>>>   test-plugin-syscall-filter: CFLAGS+=3D-DSKIP
>>>>   endif
>>>> diff --git a/tests/tcg/multiarch/check-plugin-output.sh b/tests/tcg/=
multiarch/plugin/check-plugin-output.sh
>>>> similarity index 100%
>>>> rename from tests/tcg/multiarch/check-plugin-output.sh
>>>> rename to tests/tcg/multiarch/plugin/check-plugin-output.sh
>>>> diff --git a/tests/tcg/multiarch/test-plugin-mem-access.c b/tests/tc=
g/multiarch/plugin/test-plugin-mem-access.c
>>>> similarity index 100%
>>>> rename from tests/tcg/multiarch/test-plugin-mem-access.c
>>>> rename to tests/tcg/multiarch/plugin/test-plugin-mem-access.c
>>>> diff --git a/tests/tcg/multiarch/plugin/test-plugin-set-pc.c b/tests=
/tcg/multiarch/plugin/test-plugin-set-pc.c
>>>> new file mode 100644
>>>> index 0000000000..40d9a9e8f0
>>>> --- /dev/null
>>>> +++ b/tests/tcg/multiarch/plugin/test-plugin-set-pc.c
>>>> @@ -0,0 +1,140 @@
>>>> +/*
>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>> + *
>>>> + * Copyright (C) 2026, Florian Hofhammer <florian.hofhammer@epfl.ch=
>
>>>> + *
>>>> + * This test set exercises the qemu_plugin_set_pc() function in fou=
r different
>>>> + * contexts:
>>>> + * 1. in a syscall callback,
>>>> + * 2. in an instruction callback during normal execution,
>>>> + * 3. in an instruction callback during signal handling,
>>>> + * 4. in a memory access callback.
>>>> + * Note: using the volatile guards is necessary to prevent the comp=
iler from
>>>> + * doing dead code elimination even on -O0, which would cause every=
thing after
>>>> + * the asserts and thus also the target labels to be optimized away=
=2E
>>>> + */
>>>> +#include <assert.h>
>>>> +#include <signal.h>
>>>> +#include <stdint.h>
>>>> +#include <stdlib.h>
>>>> +#include <stdio.h>
>>>> +#include <unistd.h>
>>>> +#include <setjmp.h>
>>>> +
>>>> +#define NOINLINE __attribute__((noinline))
>>>
>>> Test being compiled in O0, it should not need any noinline attribute.=

>>
>> Ack, removed.
>>
>>>> +#define NORETURN __attribute__((noreturn))
>>>
>>> It's used in a single place, simply move the the attribute there, no =
need for another define.
>>
>> Ditto.
>>
>>>> +
>>>> +static int signal_handled;
>>>> +/*
>>>> + * The volatile variable is used as a guard to prevent the compiler=
 from
>>>> + * optimizing away "unreachable" labels.
>>>> + */
>>>> +static volatile uint32_t guard =3D 1;
>>>> +
>>>
>>> As mentioned on v4, you can simply use an external function for faili=
ng the test, which won't be tainted with noreturn attribute.
>>> This way, you don't need any guard at all or assert(0), and resulting=
 code is linear and easier to read.
>>> It test completes, it all worked. If it crashes, something was wrong.=

>>>
>>> void panic(void)
>>> {
>>>      g_assert_not_reached();
>>> }
>>>
>>> void test_...() {
>>> ...
>>> on_panic:
>>>      panic();
>>> after_panic:
>>>      printf("Hello World\n");
>>> }
>>
>> I've reworked it to look similar to this (without g_assert_not_reached=
()
>> though, because glib is not available in the test itself). Still
>> required some shuffling of stuff to make sure the compiler doesn't
>> optimize things away then :) Especially on hexagon, which is the only
>> target (by default) built with clang instead of gcc. Clang/LLVM seems =
to
>> be way more aggressive even at -O0 to do deadcode elimination and
>> inlining, so I had to add extra CFLAGS for the hexagon target.
>>
>>>> + * This test executes a magic syscall which communicates two addres=
ses to the
>>>> + * plugin via the syscall arguments. Whenever we reach the "bad" in=
struction
>>>> + * during normal execution, the plugin should redirect control flow=
 to the
>>>> + * "good" instruction instead.
>>>> + */
>>>> +NOINLINE void test_insn(void)
>>>> +{
>>>> +    long ret =3D syscall(4095, &&bad_insn, &&good_insn, NULL);
>>>> +    assert(ret =3D=3D 0 && "Syscall filter did not return expected =
value");
>>>> +    if (guard) {
>>>> +bad_insn:
>>>> +        assert(0 && "PC redirection in instruction callback failed"=
);
>>>> +    } else {
>>>> +good_insn:
>>>> +        return;
>>>> +    }
>>>> +}
>>>> +
>>>> +/*
>>>> + * This signal handler communicates a "bad" and a "good" address to=
 the plugin
>>>> + * similar to the previous test, and skips to the "good" address wh=
en the "bad"
>>>> + * one is reached. This serves to test whether PC redirection via
>>>> + * qemu_plugin_set_pc() also works properly in a signal handler con=
text.
>>>> + */
>>>> +NOINLINE void usr1_handler(int signum)
>>>> +{
>>>> +    long ret =3D syscall(4095, &&bad_signal, &&good_signal, NULL);
>>>> +    assert(ret =3D=3D 0 && "Syscall filter did not return expected =
value");
>>>> +    if (guard) {
>>>> +bad_signal:
>>>> +        assert(0 && "PC redirection in instruction callback failed"=
);
>>>> +    } else {
>>>> +good_signal:
>>>> +        signal_handled =3D 1;
>>>> +        return;
>>>> +    }
>>>> +}
>>>> +
>>>> +/*
>>>> + * This test sends a signal to the process, which should trigger th=
e above
>>>> + * signal handler. The signal handler should then exercise the PC r=
edirection
>>>> + * functionality in the context of a signal handler, which behaves =
a bit
>>>> + * differently from normal execution.
>>>> + */
>>>> +NOINLINE void test_sighandler(void)
>>>> +{
>>>> +    struct sigaction sa =3D {0};
>>>> +    sa.sa_handler =3D usr1_handler;
>>>> +    sigaction(SIGUSR1, &sa, NULL);
>>>> +    pid_t pid =3D getpid();
>>>> +    kill(pid, SIGUSR1);
>>>> +    assert(signal_handled =3D=3D 1 && "Signal handler was not execu=
ted properly");
>>>> +}
>>>> +
>>>> +/*
>>>> + * This test communicates a "good" address and the address of a loc=
al variable
>>>> + * to the plugin. Upon accessing the local variable, the plugin sho=
uld then
>>>> + * redirect control flow to the "good" address via qemu_plugin_set_=
pc().
>>>> + */
>>>> +NOINLINE void test_mem(void)
>>>> +{
>>>> +    long ret =3D syscall(4095, NULL, &&good_mem, &guard);
>>>
>>> Since you use two different syscall numbers, it's worth adding two de=
fines, that you will duplicate in test and plugin.
>>> Alternatively, you can use the first parameter of syscall to identify=
 which kind of "service" you want from plugin, with defines duplicated be=
tween test and plugin again.
>>> Feel free to pick the solution you prefer.
>>>
>>> Reading 4095 the first time here felt like it was a typo mistake.
>>
>> Ack, reworked this to be clearer.
>>
>>>
>>>> +    assert(ret =3D=3D 0 && "Syscall filter did not return expected =
value");
>>>> +    if (guard) {
>>>> +        assert(0 && "PC redirection in memory access callback faile=
d");
>>>> +    } else {
>>>> +good_mem:
>>>> +        return;
>>>> +    }
>>>> +}
>>>> +
>>>> +/*
>>>> + * This test executes a magic syscall which is intercepted and its =
actual
>>>> + * execution skipped via the qemu_plugin_set_pc() API. In a proper =
plugin,
>>>> + * syscall skipping would rather be implemented via the syscall fil=
tering
>>>> + * callback, but we want to make sure qemu_plugin_set_pc() works in=
 different
>>>> + * contexts.
>>>> + */
>>>> +NOINLINE NORETURN
>>>> +void test_syscall(void)
>>>> +{
>>>> +    syscall(4096, &&good_syscall);
>>>> +    if (guard) {
>>>> +        assert(0 && "PC redirection in syscall callback failed");
>>>> +    } else {
>>>> +good_syscall:
>>>> +        /*
>>>> +         * Note: we execute this test last and exit straight from h=
ere because
>>>> +         * when the plugin redirects control flow upon syscall, the=
 stack frame
>>>> +         * for the syscall function (and potential other functions =
in the call
>>>> +         * chain in libc) is still live and the stack is not unwoun=
d properly.
>>>> +         * Thus, returning from here is risky and breaks on some ar=
chitectures,
>>>> +         * so we just exit directly from this test.
>>>> +         */
>>>> +        _exit(EXIT_SUCCESS);
>>>> +    }
>>>> +}
>>>> +
>>>> +
>>>> +int main(int argc, char *argv[])
>>>> +{
>>>> +    test_insn();
>>>> +    test_sighandler();
>>>> +    test_mem();
>>>> +    test_syscall();
>>>> +}
>>>> diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson=
=2Ebuild
>>>> index c5e49753fd..b3e3a9a6d0 100644
>>>> --- a/tests/tcg/plugins/meson.build
>>>> +++ b/tests/tcg/plugins/meson.build
>>>> @@ -7,6 +7,7 @@ test_plugins =3D [
>>>>   'mem.c',
>>>>   'patch.c',
>>>>   'reset.c',
>>>> +'setpc.c',
>>>>   'syscall.c',
>>>>   ]
>>>>   diff --git a/tests/tcg/plugins/setpc.c b/tests/tcg/plugins/setpc.c=

>>>> new file mode 100644
>>>> index 0000000000..72ae31a0ef
>>>> --- /dev/null
>>>> +++ b/tests/tcg/plugins/setpc.c
>>>> @@ -0,0 +1,120 @@
>>>> +/*
>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>> + *
>>>> + * Copyright (C) 2026, Florian Hofhammer <florian.hofhammer@epfl.ch=
>
>>>> + */
>>>> +#include <assert.h>
>>>> +#include <glib.h>
>>>> +#include <inttypes.h>
>>>> +#include <unistd.h>
>>>> +
>>>> +#include <qemu-plugin.h>
>>>> +
>>>> +QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;=

>>>> +
>>>> +static uint64_t source_pc;
>>>> +static uint64_t target_pc;
>>>> +static uint64_t target_vaddr;
>>>> +
>>>> +static void vcpu_syscall(qemu_plugin_id_t id, unsigned int vcpu_ind=
ex,
>>>> +                         int64_t num, uint64_t a1, uint64_t a2,
>>>> +                         uint64_t a3, uint64_t a4, uint64_t a5,
>>>> +                         uint64_t a6, uint64_t a7, uint64_t a8)
>>>> +{
>>>> +    if (num =3D=3D 4096) {
>>>> +        qemu_plugin_outs("Marker syscall detected, jump to clean re=
turn\n");
>>>> +        qemu_plugin_set_pc(a1);
>>>> +    }
>>>> +}
>>>> +
>>>> +static bool vcpu_syscall_filter(qemu_plugin_id_t id, unsigned int v=
cpu_index,
>>>> +                                int64_t num, uint64_t a1, uint64_t =
a2,
>>>> +                                uint64_t a3, uint64_t a4, uint64_t =
a5,
>>>> +                                uint64_t a6, uint64_t a7, uint64_t =
a8,
>>>> +                                uint64_t *sysret)
>>>> +{
>>>> +    if (num =3D=3D 4095) {
>>>> +        qemu_plugin_outs("Communication syscall detected, set targe=
t_pc / "
>>>> +                         "target_vaddr\n");
>>>> +        source_pc =3D a1;
>>>> +        target_pc =3D a2;
>>>> +        target_vaddr =3D a3;
>>>> +        if (source_pc >> 63 || target_pc >> 63 || target_vaddr >> 6=
3) {
>>>> +            /*
>>>> +             * Some architectures (e.g., m68k) use 32-bit addresses=
 with the
>>>> +             * top bit set, which causes them to get sign-extended =
somewhere in
>>>> +             * the chain to this callback. We mask the top bits off=
 here to get
>>>> +             * the actual addresses.
>>>> +             */
>>>
>>> This looks like an actual bug. Using a backtrace here, can you find w=
hich function extended it?
>>> Parameter should be treated as unsigned everywhere, else something is=
 really going wrong.
>>
>> tl;dr: register values are considered signed in the syscall handling
>> code, which seems incorrect to me. Details below.
>>
>> This seems to be a bigger issue in the syscall handling code and I'm
>> surprised this never surfaced before. Generally, the CPUArchState stru=
ct
>> in target/*/cpu.h defines the registers as unsigned types. When a
>> syscall is encountered, the main cpu loop calls do_syscall() from
>> linux-user/syscall.c, which takes and returns abi_long values. abi_lon=
g
>> is defined as either int32_t or target_long in include/user/abitypes.h=

>> and therefore a signed type, so the register values get converted from=

>> unsigned to signed types here. do_syscall() passes those abi_long valu=
es
>> on, e.g., to record_syscall_start() and send_through_syscall_filters()=
,
>> which still take the register values in as abi_long. Those in turn
>> however pass the values on to qemu_plugin_vcpu_syscall() and
>> qemu_plugin_vcpu_syscall_filter(), respectively. Those two functions n=
ow
>> take uint64_t values for the arguments, so for 32-bit architectures th=
e
>> conversion chain is uint32_t (CPUArchState) -> int32_t (do_syscall) ->=

>> uint64_t (callbacks).
>>
>> This seems to be some bigger refactoring changing all those abi_longs =
to
>> abi_ulongs. Would you like me to prepare a separate patch series for
>> this?
>=20
> As a follow-up on this, changing this seems to be a bit more complicate=
d
> than I initially thought. The arguments could be simply made unsigned,
> but the return value (which is also just a register content and should
> therefore be unsigned if I understand correctly) can't easily be made
> unsigned. The per-target main loop relies on the return value of
> do_syscall() to be signed to determine whether one of the QEMU-specific=

> errors (e.g., QEMU_ERESTARTSYS) was returned.

Note: some architectures already define the return value as unsigned in
the main cpu loop and implicitly cast the return value of do_syscall().
Given that in theory, a syscall's return value could always coincide
with the values of QEMU's special errors, I'm wondering whether it would
make sense to make do_syscall()'s return value unsigned and signal those
special error codes out-of-band instead of in the syscall return value,
e.g., either via a separate pointer argument to do_syscall() or by
making do_syscall() return a struct containing both the return value and
a potential error code.

But maybe I'm getting ahead of myself here, please let me know what you
think!

>=20
>>>
>>>> +            qemu_plugin_outs("High bit in addresses detected: possi=
ble sign "
>>>> +                             "extension in syscall, masking off top=
 bits\n");
>>>> +            source_pc &=3D UINT32_MAX;
>>>> +            target_pc &=3D UINT32_MAX;
>>>> +            target_vaddr &=3D UINT32_MAX;
>>>> +        }
>>>> +        *sysret =3D 0;
>>>> +        return true;
>>>> +    }
>>>> +    return false;
>>>> +}
>>>> +
>>>> +static void vcpu_insn_exec(unsigned int vcpu_index, void *userdata)=

>>>> +{
>>>> +    uint64_t vaddr =3D (uint64_t)userdata;
>>>> +    if (vaddr =3D=3D source_pc) {
>>>> +        g_assert(target_pc !=3D 0);
>>>> +        g_assert(target_vaddr =3D=3D 0);
>>>> +
>>>> +        qemu_plugin_outs("Marker instruction detected, jump to clea=
n return\n");
>>>> +        qemu_plugin_set_pc(target_pc);
>>>> +    }
>>>> +}
>>>> +
>>>> +static void vcpu_mem_access(unsigned int vcpu_index,
>>>> +                            qemu_plugin_meminfo_t info,
>>>> +                            uint64_t vaddr, void *userdata)
>>>> +{
>>>> +    if (vaddr !=3D 0 && vaddr =3D=3D target_vaddr) {
>>>> +        g_assert(source_pc =3D=3D 0);
>>>> +        g_assert(target_pc !=3D 0);
>>>> +        qemu_plugin_mem_value val =3D qemu_plugin_mem_get_value(inf=
o);
>>>> +        /* target_vaddr points to our volatile guard =3D=3D> should=
 always be 1 */
>>>> +        g_assert(val.type =3D=3D QEMU_PLUGIN_MEM_VALUE_U32);
>>>> +        g_assert(val.data.u32 =3D=3D 1);
>>>> +
>>>> +        qemu_plugin_outs("Marker mem access detected, jump to clean=
 return\n");
>>>> +        qemu_plugin_set_pc(target_pc);
>>>> +    }
>>>
>>> Thanks for adding this case also!
>>> So you'll definitely need a read for this precise test, to be able to=
 keep a load. If it would work with a local variable, that's good, else, =
try with a local static (eventually marked volatile if it helps), and in =
last case, use a global variable.
>>
>> Works fine with a local variable!
>>
>>>
>>>> +}
>>>> +
>>>> +static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_t=
b *tb)
>>>> +{
>>>> +    size_t insns =3D qemu_plugin_tb_n_insns(tb);
>>>> +    for (size_t i =3D 0; i < insns; i++) {
>>>> +        struct qemu_plugin_insn *insn =3D qemu_plugin_tb_get_insn(t=
b, i);
>>>> +        uint64_t insn_vaddr =3D qemu_plugin_insn_vaddr(insn);
>>>> +        /*
>>>> +         * Note: we cannot only register the callbacks if the instr=
uction is
>>>> +         * in one of the functions of interest, because symbol look=
up for
>>>> +         * filtering does not work for all architectures (e.g., ppc=
64).
>>>> +         */
>>>
>>> Too sad :)
>>> It's not a problem to instrument all instructions though.
>>>
>>>> +        qemu_plugin_register_vcpu_insn_exec_cb(insn, vcpu_insn_exec=
,
>>>> +                                               QEMU_PLUGIN_CB_RW_RE=
GS_PC,
>>>> +                                               (void *)insn_vaddr);=

>>>> +        qemu_plugin_register_vcpu_mem_cb(insn, vcpu_mem_access,
>>>> +                                         QEMU_PLUGIN_CB_RW_REGS_PC,=

>>>> +                                         QEMU_PLUGIN_MEM_R, NULL);
>>>> +    }
>>>> +}
>>>> +
>>>> +
>>>> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>>>> +                                           const qemu_info_t *info,=

>>>> +                                           int argc, char **argv)
>>>> +{
>>>> +
>>>> +    qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall);
>>>> +    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_fi=
lter);
>>>> +    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>>>> +    return 0;
>>>> +}
>>>>
>>>
>>> Thanks for the update.
>>> Test looks good, and minus the style nits reported, it looks quite re=
ady.
>>> It would be nice if we could sort the signed parameter extension also=
 to avoid a hack on this.
>>>
>>> Regards,
>>> Pierrick
>>
>> Best regards,
>> Florian

--------------ms040005070403060408040504
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
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDMwNDE2MTg0MVowLwYJKoZI
hvcNAQkEMSIEIHkuDN6hbPwb+xvdRWCwz27sLmo+0NDhvI2z1btctbcEMIGFBgkrBgEEAYI3
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
gQQBDgIwCAYGK4EEAQ4DMA0GCSqGSIb3DQEBAQUABIIBAG8W0zEYwAMzHUNCbRtcT1D3NHMS
KUWinEa26J4kgdmDkrIHPAcqFNQAshAWQAqA2m4T5+PO5EefMGHBGnkBsE8V1eBLJLV8WAhb
R6iQyWvqpxoDYr2DPqw0gkOE1SV7trKMfv8JMHTJDQ2FabJow2q/1j+FTpIHTx9z13CtrS0U
fgG9bRpP0DKM+kvHj1AgT8jrLAkk/iMTpk225hpezwJ+k6H3B/sdkvHWUq4oCo28IMc0A3XC
Cp8Jogr6C2h0g+iH6lQ6qHJGQ1fXQkOSVBdh2ebMnbhPT5aW5RCMdhww+8Cu+5DA/Wxmr+1T
sjL/bm6cz1Ch9iYBf2YtmkVuiE8AAAAAAAA=

--------------ms040005070403060408040504--

