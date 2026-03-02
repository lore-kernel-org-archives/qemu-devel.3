Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D40AEA4E11
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 14:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx4jn-0002vN-PN; Mon, 02 Mar 2026 09:59:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vx4jV-0002m9-Mj
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 09:58:54 -0500
Received: from
 mail-switzerlandnorthazlp170110002.outbound.protection.outlook.com
 ([2a01:111:f403:c213::2] helo=ZRZP278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vx4jE-0003cG-Dm
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 09:58:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmQu392V0MR1rbO7VxPHyV5/6VZJeCQOs1H7CJ7UszBHDfEzNZ5aAQsSA7bHCKhBiSJV0Xs8O8X6yrEYO8kyhZGAtfIbSiMm82WB0eQpfHlBi9CTeDIcQ2WBPuJi9wi9Z+UlJTjNXv04Vc0aAx3j8ntsLkx54E1nDBCSNt8e73yD1JGnbJi5B5x2wzZkyEtxdYmnUFWctzFyeJAJowopcMrIiaf54Mv2a5Q58YL+fPBepXEwUnvMJamnGXCdLLGF4XN1iRkvOuLwzrju+wxKyKAS89WQ9u3bXcQbM5lbfCI9k8Y+OGk6Dk5lziI1Ed0Z+cBGRSpwciMcxdvzDKfL8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQR5T8JDWrTjJKa5Z39py/Vobx9dZFmpp+AeQ4ky4ko=;
 b=GHIPUHRhRR6/DaujBM0ZX6eVWEroAEpAZ6LuGNecid0ZOCJOJmw4Y7GYQ89Uaq787ZtDN6qakHIP1d0quFefIm5g3lIlcwTLYAsSo4tky8vEz0SXsN9OMtqPU6fUlIzAgAP+EG8ikIiEyWmfyG1J7OuHoBEhUuBV0yAHax/yRgFIsUZIjh+ZWmlM6NVxyCbV8JboTPF12439MtHAgaQIdqNxt46muz44eYnak0pzWhx7yiHTPIwCZC8D/qfQ8Mw3KboqrYBtVmduAMk5kqrYPZYjC9KicwXqLuBs7g0D/N17W6183Sz963DkmHQgiLwoF9+3w2M6UJLKAaiOsQ4w6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQR5T8JDWrTjJKa5Z39py/Vobx9dZFmpp+AeQ4ky4ko=;
 b=o7oaC3jojuKcSCQbfuVJHJYMeyNOD3FcRNzKOFQmj7+Z2C47iojp44IN6cplmiaTJxCOS2uMK3hBMFfTA+Ejolm4AhHjGt5BC2iyeY239HTynrqdIAZoewIXK59CpKZdiQ0i0fZo5XTNQUSz7sKh+YjUeRGX5MBSdfBGegf7A9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR3P278MB1634.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:91::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 14:58:31 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 14:58:31 +0000
Message-ID: <b88345b8-5561-4b09-b42d-dafafd798217@epfl.ch>
Date: Mon, 2 Mar 2026 15:58:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] tests/tcg: add test for qemu_plugin_set_pc API
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
References: <1739da2c-2ea6-4bc7-be6f-981f8658ce3f@epfl.ch>
 <11fbe855-37cb-4703-b143-66563b881a4e@epfl.ch>
Content-Language: en-US
In-Reply-To: <11fbe855-37cb-4703-b143-66563b881a4e@epfl.ch>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="------------ms040703040608050109020005"
X-ClientProxiedBy: GV0P278CA0023.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::10) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR3P278MB1634:EE_
X-MS-Office365-Filtering-Correlation-Id: 079fd3fe-bdc7-4d0b-5bd7-08de786c2b57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|786006|19092799006|1800799024|366016; 
X-Microsoft-Antispam-Message-Info: wsrMtOImEMf/L+Kp1bmO8sqg0WbKJS6Alj6mR5q5oMAkDf3dNi8ew4NkP6ig3Jx+NlzFzTRmrX7x6VEyW+A6UGyb4WuVwg18ESlqHvX7uj+JZRLbpjEyUlibvEKrBzEKscYg+gAY05ymiVkhdfsShmL8Des99B2QDIrKt5ZM9KwWwDNuKRIwQ3iY8QLCptlGV2E83xY2q6Ky/cAcpSX0oM9FeAlwfQVi+y5ouPA7m0UYCckM61a0AzoQyYYLNPSgES86O0yVCHs3g4+E0C6MHpCJw0MMP9q5/RWN8/dHG7NmWeRjwBHhpfpk7Sc5Yxc78elr4UjDcZ9d023iGddqjRkh2rL16sAk4gVqG+NAo34gGkiP4DtkFMMEufxEqU/r73hMDlUEgOKZ0PyhzkxbtWTdH/5DVKwgV1bOR/OCJ4D3oj7Rgu5cPqu3jnr5SarRCqL+mWGnPj3zeLRhybJiONjraXBnwtAZIcWO39xYAC94kB/7ute9wWXhu7dtICtb0/ol09XHWOzvpFa8ylZcC5vyjaGwxmH9gX6vljN8JBUieKrDBagoQxQc2nndEZe8Yu0NU2suQ5sd5a0yALQzZkqEAmmHOXDta04uP8eSklDP2vGt8VdFzjNPgjokLltv74eW9p46XZzpALz5UN2u5Q1oyE2kp6F/vx6BWn9+v9hUcdI0p7E069Tj8oe6tlRraXL7y1WozSMESrJB0lrWAJRll76ykvslSdxJgIHjXr4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(786006)(19092799006)(1800799024)(366016); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlFDNm9kT1crMy9HdjNxT0tndFRKaVJadFZ6LzVVOVZuUE1IQWh3QVFuRDVr?=
 =?utf-8?B?anY2NUJuU1FDNHJlSlJNUVhkOFN6QVhJSGNIUmlQK0NyZTU0aFZtZDRHRTkv?=
 =?utf-8?B?RTZCcXlPQUNtQnBGVWZPakNZNlAyOWdEMGFqcy9pdVlPYUZleHFvWTN2WDlh?=
 =?utf-8?B?QUt5ZTJ5dXlxcXBENEVGbGtPbENGL2paOWMyOXRYRXRhUkhvWHE3bXh2T3d6?=
 =?utf-8?B?VzRrVDRGR3VrWXd2bmpYWG8xU0NPQmF2VmthNVZZVTg4bk1MOS9JVmhWMzFM?=
 =?utf-8?B?THM2WnZUSityYkIySmxaemZkYVBWRlBWQlU1U2Mxc0NaOElsSEVrdUNCeHBw?=
 =?utf-8?B?Z2RzWkx3VW9zMVdOU0RyNzEwbi9uK1hnWC9GMTZKaGpreEVOZC9LZXBHaGlj?=
 =?utf-8?B?dnVUcnZYMGJXdzE4VUxzWkxtUUgrUDB6NURmYjNZZG5ZYTRzVURvMitzUWcw?=
 =?utf-8?B?TnJlb2lyWVEyVDlmUUZCdFN3OHpYQlFiMFFoTTNsamhoTWF3YnUrU2ppajZy?=
 =?utf-8?B?UmZUaHl0Zm1mUkdLQ29wc1lxOE9vRDErVTVMRFNFNnpyTjJVcTJZODlNb1pw?=
 =?utf-8?B?UU5KYk0zczNtdmVUc3dQZE9sYTlZQ1UzYXJrMFRic3l3UldnUW0xcnVtRjVn?=
 =?utf-8?B?ajM3WGtLWklFYTV3ZjdSK2pHRytGQTZNaG95U2YrKzREaUk2bDAzNDYwTHJq?=
 =?utf-8?B?TVkyKzZrK0JRR0ZIWFNqMElVR05aeFhhZnJ4aGdDNkJrd01ERGJyTVpwY0Rw?=
 =?utf-8?B?ZDkxQnYzZjNQZy9MaDNyMUsrVm9ITjdKTE1MZ1ZIRFNjNStZSkpvZ2NoS1V3?=
 =?utf-8?B?QjdYakhvRENic1Q1Rjh1TGdYbjU5TlVGam4wdDFrekJUdTI3aFFwUFdpemov?=
 =?utf-8?B?MzA4TlZ6dzBjRlhxVmlKaXNIVnpBY0QrU1RJTkpLd0NzMkNyc3kyeUp0dlhP?=
 =?utf-8?B?aGowLytjRXBaWG9iMVpQdE96WFRaaWtYNEFINzY0TWlxTmJCT20wSjJXcjMw?=
 =?utf-8?B?RWpMM2ZkMVhXcTF3aFVkYkdraHZ2UjhsL09ocWwyWlI1ZTJyN0trTERucnUx?=
 =?utf-8?B?ZGxLZWxyWWlmYjRBZ1dNdjFOMlFNOE1oTEllaGJ0WWthRFdDSzAvZEJpSjBD?=
 =?utf-8?B?R2VWZ3F6Ym5qaXJrdXdhN1NMcWJ0eTZEWmNCQytmU3cwSERnZTBuSVdya2xW?=
 =?utf-8?B?a2p6ajFLWXhpUUd5K1puaDA2OXNhVTdlRTlXTXhSMUticCt6MW1qNHROUm8v?=
 =?utf-8?B?cVp5NUtJYWFtSHZMbnFxeWtkUzhpRFpPWU04bzRRQ1ZtTzB6ajE3anV3dmZ5?=
 =?utf-8?B?RWsxQlFZaUw4N2NJVWh6VGQvSEtNalFYb3FicjhrcTlUM29HRXorcXBNWDd5?=
 =?utf-8?B?Y3NqZnBHUEYva0pWK3dOUHM1bjBSay85QnVYeHd1ZktpYmVveUt0Q0wwc0dI?=
 =?utf-8?B?RHJxLzl1R01tWEljY2pXNUZmVDB3bVU1Vnh4NjhZck90N0lqbVZZL251SFhV?=
 =?utf-8?B?MjdzNnYvWmFGNU5mcktycmR6QWpNdG81RXN6cDJqRUR2aFpBdjcraTFWZkh2?=
 =?utf-8?B?bUhpV0tBdXRzRFF6MkFoeTZwUWIzSWV0Zk01QjZKMWVnczAzMnFxYUxGcHBM?=
 =?utf-8?B?SEpURWJ3aVNIcGgxVG8vSy8yNFBBSTR1bzFjREJsZ3pSQjRXMGVmTkIrNStJ?=
 =?utf-8?B?dFpZRUEyVHNPZjJ3eTcwd1RldjNaUkZJNWJZT3dDOUtJNWV0MUttQ3VTeTNv?=
 =?utf-8?B?c3BtTVo0UFJ3Vi9FMGtZdm5sMmx5aHdRZUJQem9lQWt3bTNOb1BvajhkcG13?=
 =?utf-8?B?NVdqcEVIVWVRbHNtc2xnU1ZXUHB2bkxXb0RPN2JYTTE3VmVibldMSlYyY0Yv?=
 =?utf-8?B?WjFEY0ZNN3o2SnltaG9jREtwSE9yVU81R0EvRDk4bHFlNWN2SmNwRlBIS3FC?=
 =?utf-8?B?MDNFZzlwVnk2NXJ1R0ZYT3ZVK0YzV05HazEycW5TMHBXbXQzRG9JSEhiYldQ?=
 =?utf-8?B?QjV2UzNjNFUxYlBFbklmWmpxN0NjeVpIT0lsb1VQaG13SFlwZkg4MldzR2pV?=
 =?utf-8?B?YjEwemtSZE9hdzV2UmpuYTlOdnBWU2ZKMUhHaHFjWFJlVGtKZWR1U0RFa210?=
 =?utf-8?B?UGtUeFRyWDFjbjc4U2dqMmlVZit0T28vRFdadjZJbVJzdWtkVEdGVmh6WEZs?=
 =?utf-8?B?TE92b3FXSXF0SEQzSkhENytQVTk4SWZCVjVtNFNNZ2xBL1c4N2EzcmdCVGNO?=
 =?utf-8?B?OXNNbm5xUWRoQnMxQWZ1dy9CU201QU9TeUpSWnFKTTl0T2RyV0dEekNiTDRH?=
 =?utf-8?B?UmM4VTNZTEFpSzVNdW1xa1ppV3BFa2N2MCtzanVIN2ViRFV2UVQ2Zz09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 079fd3fe-bdc7-4d0b-5bd7-08de786c2b57
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 14:58:31.4064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFwK1EidpyLpF4HQRDn9Kuml6OaqNNCrDow+b3uxZYMjjvVh6YbcZJN3FltzZtaU4UeNpDdzqI3YL6PzFE0Lp5c5nEHyV13doRQYrd6L4c8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1634
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

--------------ms040703040608050109020005
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/03/2026 14:59, Florian Hofhammer wrote:
> The test executes a non-existent syscall, which the syscall plugin
> intercepts and redirects to a clean exit.
> Due to architecture-specific quirks, the architecture-specific Makefile=
s
> require setting specific compiler and linker flags in some cases.

Please disregard this patch and use the other version I just sent, I
forgot to update the commit message for this one. My apologies for that!

>=20
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
> ---
>  MAINTAINERS                                   |   1 +
>  tests/tcg/arm/Makefile.target                 |   6 +
>  tests/tcg/multiarch/Makefile.target           |  17 ++-
>  .../{ =3D> plugin}/check-plugin-output.sh       |   0
>  .../{ =3D> plugin}/test-plugin-mem-access.c     |   0
>  .../tcg/multiarch/plugin/test-plugin-set-pc.c | 140 ++++++++++++++++++=

>  tests/tcg/plugins/meson.build                 |   1 +
>  tests/tcg/plugins/setpc.c                     | 120 +++++++++++++++
>  8 files changed, 282 insertions(+), 3 deletions(-)
>  rename tests/tcg/multiarch/{ =3D> plugin}/check-plugin-output.sh (100%=
)
>  rename tests/tcg/multiarch/{ =3D> plugin}/test-plugin-mem-access.c (10=
0%)
>  create mode 100644 tests/tcg/multiarch/plugin/test-plugin-set-pc.c
>  create mode 100644 tests/tcg/plugins/setpc.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 606b16762c..2746ec9a0b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4083,6 +4083,7 @@ S: Maintained
>  F: docs/devel/tcg-plugins.rst
>  F: plugins/
>  F: tests/tcg/plugins/
> +F: tests/tcg/multiarch/plugin/
>  F: tests/functional/aarch64/test_tcg_plugins.py
>  F: contrib/plugins/
>  F: scripts/qemu-plugin-symbols.py
> diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.tar=
get
> index 6189d7a0e2..613bbf0939 100644
> --- a/tests/tcg/arm/Makefile.target
> +++ b/tests/tcg/arm/Makefile.target
> @@ -78,4 +78,10 @@ sha512-vector: sha512.c
> =20
>  ARM_TESTS +=3D sha512-vector
> =20
> +ifeq ($(CONFIG_PLUGIN),y)
> +# Require emitting arm32 instructions, otherwise the vCPU might accide=
ntally
> +# try to execute Thumb instructions in arm32 mode after qemu_plugin_se=
t_pc()
> +test-plugin-set-pc: CFLAGS+=3D-marm
> +endif
> +
>  TESTS +=3D $(ARM_TESTS)
> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/=
Makefile.target
> index 07d0b27bdd..a347efbadf 100644
> --- a/tests/tcg/multiarch/Makefile.target
> +++ b/tests/tcg/multiarch/Makefile.target
> @@ -14,6 +14,10 @@ ifeq ($(filter %-linux-user, $(TARGET)),$(TARGET))
>  VPATH 	       +=3D $(MULTIARCH_SRC)/linux
>  MULTIARCH_SRCS +=3D $(notdir $(wildcard $(MULTIARCH_SRC)/linux/*.c))
>  endif
> +ifeq ($(CONFIG_PLUGIN),y)
> +VPATH 	       +=3D $(MULTIARCH_SRC)/plugin
> +MULTIARCH_SRCS +=3D $(notdir $(wildcard $(MULTIARCH_SRC)/plugin/*.c))
> +endif
>  MULTIARCH_TESTS =3D $(MULTIARCH_SRCS:.c=3D)
> =20
>  #
> @@ -200,13 +204,20 @@ run-plugin-test-plugin-mem-access-with-libmem.so:=
 \
>  	PLUGIN_ARGS=3D$(COMMA)print-accesses=3Dtrue
>  run-plugin-test-plugin-mem-access-with-libmem.so: \
>  	CHECK_PLUGIN_OUTPUT_COMMAND=3D \
> -	$(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
> +	$(SRC_PATH)/tests/tcg/multiarch/plugin/check-plugin-output.sh \
>  	$(QEMU) $<
>  run-plugin-test-plugin-syscall-filter-with-libsyscall.so:
> +run-plugin-test-plugin-set-pc-with-libsetpc.so:
> =20
>  EXTRA_RUNS_WITH_PLUGIN +=3D run-plugin-test-plugin-mem-access-with-lib=
mem.so \
> -			  run-plugin-test-plugin-syscall-filter-with-libsyscall.so
> -else
> +			  run-plugin-test-plugin-syscall-filter-with-libsyscall.so \
> +			  run-plugin-test-plugin-set-pc-with-libsetpc.so
> +
> +else # CONFIG_PLUGIN=3Dn
> +# Do not build the syscall skipping test if it's not tested with the s=
etpc
> +# plugin because it will simply fail the test.
> +MULTIARCH_TESTS :=3D $(filter-out test-plugin-set-pc, $(MULTIARCH_TEST=
S))
> +
>  # test-plugin-syscall-filter needs syscall plugin to succeed
>  test-plugin-syscall-filter: CFLAGS+=3D-DSKIP
>  endif
> diff --git a/tests/tcg/multiarch/check-plugin-output.sh b/tests/tcg/mul=
tiarch/plugin/check-plugin-output.sh
> similarity index 100%
> rename from tests/tcg/multiarch/check-plugin-output.sh
> rename to tests/tcg/multiarch/plugin/check-plugin-output.sh
> diff --git a/tests/tcg/multiarch/test-plugin-mem-access.c b/tests/tcg/m=
ultiarch/plugin/test-plugin-mem-access.c
> similarity index 100%
> rename from tests/tcg/multiarch/test-plugin-mem-access.c
> rename to tests/tcg/multiarch/plugin/test-plugin-mem-access.c
> diff --git a/tests/tcg/multiarch/plugin/test-plugin-set-pc.c b/tests/tc=
g/multiarch/plugin/test-plugin-set-pc.c
> new file mode 100644
> index 0000000000..40d9a9e8f0
> --- /dev/null
> +++ b/tests/tcg/multiarch/plugin/test-plugin-set-pc.c
> @@ -0,0 +1,140 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright (C) 2026, Florian Hofhammer <florian.hofhammer@epfl.ch>
> + *
> + * This test set exercises the qemu_plugin_set_pc() function in four d=
ifferent
> + * contexts:
> + * 1. in a syscall callback,
> + * 2. in an instruction callback during normal execution,
> + * 3. in an instruction callback during signal handling,
> + * 4. in a memory access callback.
> + * Note: using the volatile guards is necessary to prevent the compile=
r from
> + * doing dead code elimination even on -O0, which would cause everythi=
ng after
> + * the asserts and thus also the target labels to be optimized away.
> + */
> +#include <assert.h>
> +#include <signal.h>
> +#include <stdint.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <setjmp.h>
> +
> +#define NOINLINE __attribute__((noinline))
> +#define NORETURN __attribute__((noreturn))
> +
> +static int signal_handled;
> +/*
> + * The volatile variable is used as a guard to prevent the compiler fr=
om
> + * optimizing away "unreachable" labels.
> + */
> +static volatile uint32_t guard =3D 1;
> +
> +/*
> + * This test executes a magic syscall which communicates two addresses=
 to the
> + * plugin via the syscall arguments. Whenever we reach the "bad" instr=
uction
> + * during normal execution, the plugin should redirect control flow to=
 the
> + * "good" instruction instead.
> + */
> +NOINLINE void test_insn(void)
> +{
> +    long ret =3D syscall(4095, &&bad_insn, &&good_insn, NULL);
> +    assert(ret =3D=3D 0 && "Syscall filter did not return expected val=
ue");
> +    if (guard) {
> +bad_insn:
> +        assert(0 && "PC redirection in instruction callback failed");
> +    } else {
> +good_insn:
> +        return;
> +    }
> +}
> +
> +/*
> + * This signal handler communicates a "bad" and a "good" address to th=
e plugin
> + * similar to the previous test, and skips to the "good" address when =
the "bad"
> + * one is reached. This serves to test whether PC redirection via
> + * qemu_plugin_set_pc() also works properly in a signal handler contex=
t.
> + */
> +NOINLINE void usr1_handler(int signum)
> +{
> +    long ret =3D syscall(4095, &&bad_signal, &&good_signal, NULL);
> +    assert(ret =3D=3D 0 && "Syscall filter did not return expected val=
ue");
> +    if (guard) {
> +bad_signal:
> +        assert(0 && "PC redirection in instruction callback failed");
> +    } else {
> +good_signal:
> +        signal_handled =3D 1;
> +        return;
> +    }
> +}
> +
> +/*
> + * This test sends a signal to the process, which should trigger the a=
bove
> + * signal handler. The signal handler should then exercise the PC redi=
rection
> + * functionality in the context of a signal handler, which behaves a b=
it
> + * differently from normal execution.
> + */
> +NOINLINE void test_sighandler(void)
> +{
> +    struct sigaction sa =3D {0};
> +    sa.sa_handler =3D usr1_handler;
> +    sigaction(SIGUSR1, &sa, NULL);
> +    pid_t pid =3D getpid();
> +    kill(pid, SIGUSR1);
> +    assert(signal_handled =3D=3D 1 && "Signal handler was not executed=
 properly");
> +}
> +
> +/*
> + * This test communicates a "good" address and the address of a local =
variable
> + * to the plugin. Upon accessing the local variable, the plugin should=
 then
> + * redirect control flow to the "good" address via qemu_plugin_set_pc(=
).
> + */
> +NOINLINE void test_mem(void)
> +{
> +    long ret =3D syscall(4095, NULL, &&good_mem, &guard);
> +    assert(ret =3D=3D 0 && "Syscall filter did not return expected val=
ue");
> +    if (guard) {
> +        assert(0 && "PC redirection in memory access callback failed")=
;
> +    } else {
> +good_mem:
> +        return;
> +    }
> +}
> +
> +/*
> + * This test executes a magic syscall which is intercepted and its act=
ual
> + * execution skipped via the qemu_plugin_set_pc() API. In a proper plu=
gin,
> + * syscall skipping would rather be implemented via the syscall filter=
ing
> + * callback, but we want to make sure qemu_plugin_set_pc() works in di=
fferent
> + * contexts.
> + */
> +NOINLINE NORETURN
> +void test_syscall(void)
> +{
> +    syscall(4096, &&good_syscall);
> +    if (guard) {
> +        assert(0 && "PC redirection in syscall callback failed");
> +    } else {
> +good_syscall:
> +        /*
> +         * Note: we execute this test last and exit straight from here=
 because
> +         * when the plugin redirects control flow upon syscall, the st=
ack frame
> +         * for the syscall function (and potential other functions in =
the call
> +         * chain in libc) is still live and the stack is not unwound p=
roperly.
> +         * Thus, returning from here is risky and breaks on some archi=
tectures,
> +         * so we just exit directly from this test.
> +         */
> +        _exit(EXIT_SUCCESS);
> +    }
> +}
> +
> +
> +int main(int argc, char *argv[])
> +{
> +    test_insn();
> +    test_sighandler();
> +    test_mem();
> +    test_syscall();
> +}
> diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.bu=
ild
> index c5e49753fd..b3e3a9a6d0 100644
> --- a/tests/tcg/plugins/meson.build
> +++ b/tests/tcg/plugins/meson.build
> @@ -7,6 +7,7 @@ test_plugins =3D [
>  'mem.c',
>  'patch.c',
>  'reset.c',
> +'setpc.c',
>  'syscall.c',
>  ]
> =20
> diff --git a/tests/tcg/plugins/setpc.c b/tests/tcg/plugins/setpc.c
> new file mode 100644
> index 0000000000..72ae31a0ef
> --- /dev/null
> +++ b/tests/tcg/plugins/setpc.c
> @@ -0,0 +1,120 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright (C) 2026, Florian Hofhammer <florian.hofhammer@epfl.ch>
> + */
> +#include <assert.h>
> +#include <glib.h>
> +#include <inttypes.h>
> +#include <unistd.h>
> +
> +#include <qemu-plugin.h>
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
> +
> +static uint64_t source_pc;
> +static uint64_t target_pc;
> +static uint64_t target_vaddr;
> +
> +static void vcpu_syscall(qemu_plugin_id_t id, unsigned int vcpu_index,=

> +                         int64_t num, uint64_t a1, uint64_t a2,
> +                         uint64_t a3, uint64_t a4, uint64_t a5,
> +                         uint64_t a6, uint64_t a7, uint64_t a8)
> +{
> +    if (num =3D=3D 4096) {
> +        qemu_plugin_outs("Marker syscall detected, jump to clean retur=
n\n");
> +        qemu_plugin_set_pc(a1);
> +    }
> +}
> +
> +static bool vcpu_syscall_filter(qemu_plugin_id_t id, unsigned int vcpu=
_index,
> +                                int64_t num, uint64_t a1, uint64_t a2,=

> +                                uint64_t a3, uint64_t a4, uint64_t a5,=

> +                                uint64_t a6, uint64_t a7, uint64_t a8,=

> +                                uint64_t *sysret)
> +{
> +    if (num =3D=3D 4095) {
> +        qemu_plugin_outs("Communication syscall detected, set target_p=
c / "
> +                         "target_vaddr\n");
> +        source_pc =3D a1;
> +        target_pc =3D a2;
> +        target_vaddr =3D a3;
> +        if (source_pc >> 63 || target_pc >> 63 || target_vaddr >> 63) =
{
> +            /*
> +             * Some architectures (e.g., m68k) use 32-bit addresses wi=
th the
> +             * top bit set, which causes them to get sign-extended som=
ewhere in
> +             * the chain to this callback. We mask the top bits off he=
re to get
> +             * the actual addresses.
> +             */
> +            qemu_plugin_outs("High bit in addresses detected: possible=
 sign "
> +                             "extension in syscall, masking off top bi=
ts\n");
> +            source_pc &=3D UINT32_MAX;
> +            target_pc &=3D UINT32_MAX;
> +            target_vaddr &=3D UINT32_MAX;
> +        }
> +        *sysret =3D 0;
> +        return true;
> +    }
> +    return false;
> +}
> +
> +static void vcpu_insn_exec(unsigned int vcpu_index, void *userdata)
> +{
> +    uint64_t vaddr =3D (uint64_t)userdata;
> +    if (vaddr =3D=3D source_pc) {
> +        g_assert(target_pc !=3D 0);
> +        g_assert(target_vaddr =3D=3D 0);
> +
> +        qemu_plugin_outs("Marker instruction detected, jump to clean r=
eturn\n");
> +        qemu_plugin_set_pc(target_pc);
> +    }
> +}
> +
> +static void vcpu_mem_access(unsigned int vcpu_index,
> +                            qemu_plugin_meminfo_t info,
> +                            uint64_t vaddr, void *userdata)
> +{
> +    if (vaddr !=3D 0 && vaddr =3D=3D target_vaddr) {
> +        g_assert(source_pc =3D=3D 0);
> +        g_assert(target_pc !=3D 0);
> +        qemu_plugin_mem_value val =3D qemu_plugin_mem_get_value(info);=

> +        /* target_vaddr points to our volatile guard =3D=3D> should al=
ways be 1 */
> +        g_assert(val.type =3D=3D QEMU_PLUGIN_MEM_VALUE_U32);
> +        g_assert(val.data.u32 =3D=3D 1);
> +
> +        qemu_plugin_outs("Marker mem access detected, jump to clean re=
turn\n");
> +        qemu_plugin_set_pc(target_pc);
> +    }
> +}
> +
> +static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *=
tb)
> +{
> +    size_t insns =3D qemu_plugin_tb_n_insns(tb);
> +    for (size_t i =3D 0; i < insns; i++) {
> +        struct qemu_plugin_insn *insn =3D qemu_plugin_tb_get_insn(tb, =
i);
> +        uint64_t insn_vaddr =3D qemu_plugin_insn_vaddr(insn);
> +        /*
> +         * Note: we cannot only register the callbacks if the instruct=
ion is
> +         * in one of the functions of interest, because symbol lookup =
for
> +         * filtering does not work for all architectures (e.g., ppc64)=
=2E
> +         */
> +        qemu_plugin_register_vcpu_insn_exec_cb(insn, vcpu_insn_exec,
> +                                               QEMU_PLUGIN_CB_RW_REGS_=
PC,
> +                                               (void *)insn_vaddr);
> +        qemu_plugin_register_vcpu_mem_cb(insn, vcpu_mem_access,
> +                                         QEMU_PLUGIN_CB_RW_REGS_PC,
> +                                         QEMU_PLUGIN_MEM_R, NULL);
> +    }
> +}
> +
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> +                                           const qemu_info_t *info,
> +                                           int argc, char **argv)
> +{
> +
> +    qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall);
> +    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filte=
r);
> +    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
> +    return 0;
> +}

--------------ms040703040608050109020005
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
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDMwMjE0NTgzMFowLwYJKoZI
hvcNAQkEMSIEINSHF7vBTgoQI4Qp4LiX4OalKQROM8NENh83LD4yqZhSMIGFBgkrBgEEAYI3
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
gQQBDgIwCAYGK4EEAQ4DMA0GCSqGSIb3DQEBAQUABIIBAFaNEiv+0IlRiKb8lfD5sZlDAUlq
bVwRPyXNgBdi/yfHqxU3JiqhBaavrfIbnATWVN51RSMPP2oC14uhr0lRYUO+5fQmqSzu7IY+
RETENGo9anAFOA03lBqBxnsh3cbwF1+lzgsiluzh7Ez7+cpE3a51Ct8yniz9dy2zNkIjfg/i
Z1aR47XAcSKyWsJNvNHnsExmWkVPnNZwAmhg+LoWCE3J71U2vE17K7c/4UtI2Ano/FfTGg1x
IuzHrAeVIGkVfsjZhlOZadLR5f4xYTI//t4F8+ZVuLs3vZOjyX0kPsVh8MeRMfauXdtyo5Gz
WjVpd8uN6cXRgg5+plPu0M0R6uMAAAAAAAA=

--------------ms040703040608050109020005--

