Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506E6FD3770
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 16:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvHig-0003ke-Ho; Wed, 25 Feb 2026 11:26:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vvHie-0003kE-B8
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:26:36 -0500
Received: from mail-switzerlandwestazon11020092.outbound.protection.outlook.com
 ([52.101.188.92] helo=GVAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vvHia-0006qQ-Gw
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:26:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pq0gELZ+Hn3xVNdh4v1rlTAX/Eud+PU2eQKdgT/KGbS+ugVshiiCsMGXw0iru4BS5lpiXH79wO6F3TgKu2ouMHRto3sLoTKgbCZx6Vzgfavi7xxv3K6jTXiWWWPFmlyGKJHVw6ANR7KYHRF1m30Z36y9+vATSbg9yXyYwuij5AeOmc5hgpX2j40ng/y/6Ujm1qmUYBPt5agjvFFkvXntBnGqOQDVtRChpiadokZ6VXMZ8qsdtqG8z0cPNmYd4Ovf6fWctlNB+W8+R19+ENbXu66ZgLPQ/GXfn8IlECZpq57UPhDY74dZEdv7lEqZ7vks8OUt0Mn7TsaUYtdm1dvHNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3k7ndJX1TKuxh0J51YjLV6NvNHdHDt60dcMqHamEB4=;
 b=bjNaUV8W7nC61IK60feCb0NBGbUw+vWVz2h7BHdpHw/g4vvBgB2bXqr67uHMzb4Zbi7cswHGkSdCdikQbt9jal5L7W8Hv7R79b3o7LKP32kPGhCfwJbktkyR5TUTSQ0YP0ER93/cAYYTJGqwE5yRUOtOt37d42OzyuHOVwhmS4Kj3YmmR088hkH7VgPR36nFmTvMqc/Cac3oADPRX/PkbQm2GUi8OC9N1aO5+sI6PY0aJlDhBu4D9Kf7EEoh4G3XlFGEGU+PkZXJrY/1PgknZ0bjpf1uH31vzXNmchTpRdcFnl8fBXwodSTohPIPpBxarMESNDk+JZPtKjY5sv694w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3k7ndJX1TKuxh0J51YjLV6NvNHdHDt60dcMqHamEB4=;
 b=qI0po5S6UNHfPSo55/W3Vjjn15NM9fYqk9+sCOH3ysXoKb/j88fem8HqAayuF6IUx+aWu95zQAb9aB1KNJFpiNFUoeK6LhF5zMOpGTuxxxRb+4N27YeNe7wpEBdegQ7tmZslqrhD++JyEV8pgTLJ2FMfHRjIA11PHLknbOXHOO0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR1P278MB1410.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:98::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 16:21:25 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 16:21:25 +0000
Message-ID: <383fc3ee-20ed-45e7-bcbb-1c188256bfad@epfl.ch>
Date: Wed, 25 Feb 2026 17:21:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] tests/tcg: add test for qemu_plugin_set_pc API
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: alex.bennee@linaro.org, pierrick.bouvier@linaro.org
Cc: richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com, qemu-devel@nongnu.org
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <2ccc79ee-48ab-4097-a9cc-4d2b79ab9a8a@epfl.ch>
Content-Language: en-US
In-Reply-To: <2ccc79ee-48ab-4097-a9cc-4d2b79ab9a8a@epfl.ch>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="------------ms050308070404010805080304"
X-ClientProxiedBy: GVAP278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::20) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR1P278MB1410:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e127c40-53ef-4e51-55d0-08de7489ebe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|786006|366016|376014; 
X-Microsoft-Antispam-Message-Info: 9/bFRPl95YqwjlCeufQWm/p5d964P0u+6qHnH4E8Ne9hhTa+2VnHtBGw+L7X7HVXCXqnUHerV2/cIqwRO4+A4WVYm2oLHGhS9/+uD+pcVBnlic7/jdFB/HFpS6NdjKcIIXohHrkaxy2O9Cucqw1vHONP9B37est28sxGjsAUe8KpKiNpoI4Nx3K0B7arqDveA6hykA7n89siyP1FVNMty43iJ1bQ8lyReRuhad/nubbM/X5KuxPf8os2NYn9BJWm/EHPAGa+ubs0VOpGdOn+zUNGrqksk2xPU1+/M7T+qV7w0NxctOIjAwDTdCOgAq3adFj0nAhgyIn19if9ce6qFvA1RNt/2w5vQjOmuwD9oBjhOXvemvUb+aSzNOYU/McBfWTG1v4Z7bQ85pqDumcdmPVX+4IpRDmVH2BgEMekD5BbHh4D8HeCzCODtx1P4abR5eqtzmzIR6qrsEhBX4rNFEzQO/WfZf3+T7ZhRnVRsXZQr2r+Gq2F9+EiSYol3p4/s88G/L1k4ibjGNM4YmO5EEm+wTHUta4zElyB36udbWeoLsrtXT7F0HA62brGPuctqPyTU3hgo82DXmm5hDwNtp+3B3Ma+D7HNVD7iVpXFnpcjQAhJfxsGBUJaBJis8gJ05oPsIl/TbNwduv9rY9eLzApeh1xcs5ADio//QjzwcyiTZQToOFNlWn0a6AUjvcRiTZVgISt4WkpV0CkvTfxLxEYGrZVAZ5rz74Q4eTwVNk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(786006)(366016)(376014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T09PaFdyWUxlTHk0TzhOeDNIclcxTncwcWlBUWNLY1VaYUxNY1l0MDRSY05V?=
 =?utf-8?B?c1NFM2h0NTRHbDhGb3FFbENYbWdGZ2RIeEU3KzZvOUlESHE5Y0dmWGxMTGNp?=
 =?utf-8?B?OWNNQkVVWHhFcnRTRFMraGo2M1llWmp1YVlqZElnaFRYcm9EOHZIZ2crTVBu?=
 =?utf-8?B?ZjExaWZleCt4NG1MaVBtUkZtY2pXMGFBekFCUVJ5ZWsvVEQwZHNxYUNJWUUr?=
 =?utf-8?B?dGVzS3EvQUpQT1hPUU1CTUVHNXBOanM2QytRNUtTb1k3UFBaYXNxSWMrU1My?=
 =?utf-8?B?MEh2OXFPREtxcUNOUEVoM0ZaR0NHR1JsWHNPeStJSnhqL1hha1Nuc09lYmZt?=
 =?utf-8?B?ci9NdmNPOUVoeFFnUFVScVdja2RrbXpXTkIxTUx2REVkVGZHS3VLQnIrcVo1?=
 =?utf-8?B?d1QrSDdIUHYyQkg1anp5b2E1WTZJYW5FeGozaVVRYkRFUHd1SmRXaGcvUklG?=
 =?utf-8?B?Z21RZVplNHh4VWk4MEs4WHdIbUoxSVl6VzNpK2dqY1J0K1JSbENSV3ZSNXVp?=
 =?utf-8?B?ODFmVE00OGpDdkl3ZFBiYWMxMGFHMkNUM3hTZHVUeVBDMzdscmZMbEdEUkhT?=
 =?utf-8?B?VEwybzhNcDB0TFhqWGlIWXR3cGMxRkRYT2JweEJHS0VCL3g2Qllpb2loakpI?=
 =?utf-8?B?UXJMcTBSWnNndCtSMmRLOGNYRmpuc24vYzNVQkZxQTdMdUVNY0FCRnZLRzR2?=
 =?utf-8?B?WU1pL1BvZjhTQ1lWSzdCVUplUVRLbHV6RGpMeXRZeW1Bcnd0bWdSdCtBdVZ3?=
 =?utf-8?B?L24yaWlIR21hQjlWRXFqS2NJb29MeFRScW1HTEcvTVdYdEFtMjRBMlI2YkY0?=
 =?utf-8?B?bFkxdXl6dTR4b0hzY1VKQUVUdE5BYzNCR3hjRmZKYmtNU2trakRNNmFvVDl2?=
 =?utf-8?B?NUVyTW1zV2VQd2ZUekhBTGNzT09Vc1VTelByU2hQeGhRaWJZaFROSFpoNWlU?=
 =?utf-8?B?ZlFpdjBOMkh2UStKaDJabmZwWnpqcjA5dzFsUisrVHZXZTdEakZsQzYvQ0VQ?=
 =?utf-8?B?WDh6OU9sK3lkN1luaGtsb2R5MGVUYzltV3BhREUyN1N0d2ZGaDl1b2VTS1lC?=
 =?utf-8?B?M2RFL1ZzT1ByeURaR3dHcGRaY2dXOVZyT1Q4ZVRlajkreUlzWVppOHEydjNu?=
 =?utf-8?B?a1V6QkUzckpDQTgzVW5GWmNuV1lVNjcrdm83ZU56VjRUVGtNNGp5WUZMZ1ZC?=
 =?utf-8?B?SlhjcEpMRnhrNTlKTHgzbXI2YWdLeTc3ZVZiNXJ4Ukd0LzBXTTV3eDlkMGpD?=
 =?utf-8?B?SlZaRFJaUXhiRGY2RUFsTUhLU3BGeDREZ2RMejFwQ25qRkJYWVptVUxkQlJW?=
 =?utf-8?B?YkxmUEZ2V0ZFS3FwMndnV2NIOXNmYmZSUUZaRlVpb2RMSGNlR1I3dUFUNW9j?=
 =?utf-8?B?bWVBcllxcEgvdGRwcUVjTnFIZkNROEQ0RVJGeUtDUTBGOHV0SEx4OERTRUtY?=
 =?utf-8?B?WWc2RWRxZ1FscXQ3N2lXZFBNN3VYYU1zYUhZUkNTSUd2dHpoZnZSRGJaQTVa?=
 =?utf-8?B?VWQwVGFscWRLT3YraHQ5RUorNjl3RXVobEE5Z3M2Z2EydmlXT09FNGsyRjZB?=
 =?utf-8?B?VkpPcHlLd3JQMFNCRDZ5QU05UDR1cmprUE5VVEJVd1NCOW9jVnZxaklLdU8r?=
 =?utf-8?B?TCtZS3FBNGh1S3FZZFBZL2ZRb01LVDJYc1dQMVRJWmx0a0xqL084UkJhaHgz?=
 =?utf-8?B?MXYrcU9CUmdJWnpJbzNPNjIvejZvSDFlblZ2V3BicFFnRjFjcHhHMk5lMGpS?=
 =?utf-8?B?dUEzTnpHS3VXQytadTkrd1FsNkEwUjVWSWJFZ1BSVHVucldCdzVkQ01sMWM3?=
 =?utf-8?B?c2FjU25iUGNuK0kwVnVmTFF6TklaVWhpUnI0bUI5RVF6K2QrTmVBckFmZ282?=
 =?utf-8?B?bXNTdEQ5eTN0MzVaK1ZTVEg0RzJESlZ5ejZIeTRsZmJySWU1ZlR0akN2WDBH?=
 =?utf-8?B?WCtnZi9obDFrbk5SN2I4Y084aVd2TEI1cFBTNTl6VUJyQVdNOG9yazNXR3Jm?=
 =?utf-8?B?SGtEdzEyWllhbFdpTSt0K1g4YlRpM0ZVVlhVU2ZTN01YRnVUa0Z1aDZvTkpV?=
 =?utf-8?B?QlljNU1VS2MzQndVRjBTVnBnT0JPUS9hWVg4UW9maHZlVWRic0RjMk9OSGxY?=
 =?utf-8?B?bDV5VFFLQks3QUlqYStGWU9OYjk0QzdGWWQxY1BRbU1yWksvQUV3WCt6UXRZ?=
 =?utf-8?B?clRkUGhuVDFCaHVndUFoOE50WTYzd1huZjRYeUlvbWVwV2hjQVdWZlJrcDYv?=
 =?utf-8?B?SFc2OE1WanJMOUo0eUN6YVd5cmY2eUNPdHQ3U0FhMExEcHZUL0FUWXhHTXpW?=
 =?utf-8?B?VDMyT254TmRGMFFBd2lwSjhTKzZ3eTFOeVhCcGcrUWRkRlpRakYzUT09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e127c40-53ef-4e51-55d0-08de7489ebe0
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 16:21:25.1537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xuFcPlekFugaGuHSOwi4ooRYzWLzQzG8KKXNb8rbCJaYE0Gb5YyrBbnNZmbaZujA3us8btQK2M4pFX0tfHTim+7kno61VOTcQJZ8Lou5bXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1410
Received-SPF: pass client-ip=52.101.188.92;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=GVAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--------------ms050308070404010805080304
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 24/02/2026 16:52, Florian Hofhammer wrote:
> The test executes a non-existent syscall, which the syscall plugin
> intercepts and redirects to a clean exit.
> Due to architecture-specific quirks, the architecture-specific Makefile=
s
> require setting specific compiler and linker flags in some cases.
>=20
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
> ---
>  tests/tcg/arm/Makefile.target                 |  6 +++++
>  tests/tcg/hexagon/Makefile.target             |  7 +++++
>  tests/tcg/mips/Makefile.target                |  6 ++++-
>  tests/tcg/mips64/Makefile.target              | 15 +++++++++++
>  tests/tcg/mips64el/Makefile.target            | 15 +++++++++++
>  tests/tcg/mipsel/Makefile.target              | 15 +++++++++++
>  tests/tcg/multiarch/Makefile.target           | 22 ++++++++++++++--
>  .../{ =3D> plugin}/check-plugin-output.sh       |  0
>  .../{ =3D> plugin}/test-plugin-mem-access.c     |  0
>  .../plugin/test-plugin-skip-syscalls.c        | 26 +++++++++++++++++++=

>  tests/tcg/plugins/syscall.c                   |  6 +++++
>  tests/tcg/sparc64/Makefile.target             | 16 ++++++++++++
>  12 files changed, 131 insertions(+), 3 deletions(-)
>  create mode 100644 tests/tcg/mips64/Makefile.target
>  create mode 100644 tests/tcg/mips64el/Makefile.target
>  create mode 100644 tests/tcg/mipsel/Makefile.target
>  rename tests/tcg/multiarch/{ =3D> plugin}/check-plugin-output.sh (100%=
)
>  rename tests/tcg/multiarch/{ =3D> plugin}/test-plugin-mem-access.c (10=
0%)
>  create mode 100644 tests/tcg/multiarch/plugin/test-plugin-skip-syscall=
s.c
>  create mode 100644 tests/tcg/sparc64/Makefile.target
>=20
> diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.tar=
get
> index 6189d7a0e2..0d8be9cd80 100644
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
> +test-plugin-skip-syscalls: CFLAGS+=3D-marm
> +endif
> +
>  TESTS +=3D $(ARM_TESTS)
> diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Make=
file.target
> index f86f02bb31..111dc405fa 100644
> --- a/tests/tcg/hexagon/Makefile.target
> +++ b/tests/tcg/hexagon/Makefile.target
> @@ -126,3 +126,10 @@ v73_scalar: CFLAGS +=3D -Wno-unused-function
> =20
>  hvx_histogram: hvx_histogram.c hvx_histogram_row.S
>  	$(CC) $(CFLAGS) $(CROSS_CC_GUEST_CFLAGS) $^ -o $@ $(LDFLAGS)
> +
> +ifeq ($(CONFIG_PLUGIN),y)
> +# hexagon uses clang/lld which does not support -Ttext-segment but GNU=
 ld does
> +# not generally support --image-base. Therefore, the multiarch Makefil=
e uses
> +# the GNU ld flag and we special-case here for hexagon.
> +override LDFLAG_TEXT_BASE =3D -Wl,--image-base=3D0x40000
> +endif
> diff --git a/tests/tcg/mips/Makefile.target b/tests/tcg/mips/Makefile.t=
arget
> index 5d17c1706e..d08138f17b 100644
> --- a/tests/tcg/mips/Makefile.target
> +++ b/tests/tcg/mips/Makefile.target
> @@ -9,11 +9,15 @@ MIPS_SRC=3D$(SRC_PATH)/tests/tcg/mips
>  VPATH 		+=3D $(MIPS_SRC)
> =20
>  # hello-mips is 32 bit only
> -ifeq ($(findstring 64,$(TARGET_NAME)),)
>  MIPS_TESTS=3Dhello-mips
> =20
>  TESTS +=3D $(MIPS_TESTS)
> =20
>  hello-mips: CFLAGS+=3D-mno-abicalls -fno-PIC -fno-stack-protector -mab=
i=3D32
>  hello-mips: LDFLAGS+=3D-nostdlib
> +
> +ifeq ($(CONFIG_PLUGIN),y)
> +# qemu-mips(el) returns ENOSYS without triggering syscall plugin callb=
acks
> +run-plugin-test-plugin-skip-syscalls-with-libsyscall.so:
> +	$(call skip-test, $<, "qemu-mips does not execute invalid syscalls")
>  endif
> diff --git a/tests/tcg/mips64/Makefile.target b/tests/tcg/mips64/Makefi=
le.target
> new file mode 100644
> index 0000000000..5386855efc
> --- /dev/null
> +++ b/tests/tcg/mips64/Makefile.target
> @@ -0,0 +1,15 @@
> +# -*- Mode: makefile -*-
> +#
> +# MIPS64 - included from tests/tcg/Makefile.target
> +#
> +
> +MIPS64_SRC=3D$(SRC_PATH)/tests/tcg/mips64
> +
> +# Set search path for all sources
> +VPATH +=3D $(MIPS64_SRC)
> +
> +ifeq ($(CONFIG_PLUGIN),y)
> +# Require no ABI calls to avoid $t9-relative .got address calculation =
on MIPS64
> +test-plugin-skip-syscalls: CFLAGS+=3D-mno-abicalls -fno-pie
> +test-plugin-skip-syscalls: LDFLAGS+=3D-no-pie
> +endif
> diff --git a/tests/tcg/mips64el/Makefile.target b/tests/tcg/mips64el/Ma=
kefile.target
> new file mode 100644
> index 0000000000..77ac8815fe
> --- /dev/null
> +++ b/tests/tcg/mips64el/Makefile.target
> @@ -0,0 +1,15 @@
> +# -*- Mode: makefile -*-
> +#
> +# MIPS64EL - included from tests/tcg/Makefile.target
> +#
> +
> +MIPS64EL_SRC=3D$(SRC_PATH)/tests/tcg/mips64el
> +
> +# Set search path for all sources
> +VPATH +=3D $(MIPS64EL_SRC)
> +
> +ifeq ($(CONFIG_PLUGIN),y)
> +# Require no ABI calls to avoid $t9-relative .got address calculation =
on MIPS64
> +test-plugin-skip-syscalls: CFLAGS+=3D-mno-abicalls -fno-pie
> +test-plugin-skip-syscalls: LDFLAGS+=3D-no-pie
> +endif
> diff --git a/tests/tcg/mipsel/Makefile.target b/tests/tcg/mipsel/Makefi=
le.target
> new file mode 100644
> index 0000000000..bf1bdb56b3
> --- /dev/null
> +++ b/tests/tcg/mipsel/Makefile.target
> @@ -0,0 +1,15 @@
> +# -*- Mode: makefile -*-
> +#
> +# MIPSEL - included from tests/tcg/Makefile.target
> +#
> +
> +MIPSEL_SRC=3D$(SRC_PATH)/tests/tcg/mipsel
> +
> +# Set search path for all sources
> +VPATH +=3D $(MIPSEL_SRC)
> +
> +ifeq ($(CONFIG_PLUGIN),y)
> +# qemu-mips(el) returns ENOSYS without triggering syscall plugin callb=
acks
> +run-plugin-test-plugin-skip-syscalls-with-libsyscall.so:
> +	$(call skip-test, $<, "qemu-mipsel does not execute invalid syscalls"=
)
> +endif
> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/=
Makefile.target
> index 07d0b27bdd..2e2dcda425 100644
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
> @@ -200,13 +204,27 @@ run-plugin-test-plugin-mem-access-with-libmem.so:=
 \
>  	PLUGIN_ARGS=3D$(COMMA)print-accesses=3Dtrue
>  run-plugin-test-plugin-mem-access-with-libmem.so: \
>  	CHECK_PLUGIN_OUTPUT_COMMAND=3D \
> -	$(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
> +	$(SRC_PATH)/tests/tcg/multiarch/plugin/check-plugin-output.sh \
>  	$(QEMU) $<
>  run-plugin-test-plugin-syscall-filter-with-libsyscall.so:
> =20
>  EXTRA_RUNS_WITH_PLUGIN +=3D run-plugin-test-plugin-mem-access-with-lib=
mem.so \
>  			  run-plugin-test-plugin-syscall-filter-with-libsyscall.so
> -else
> +
> +# Test plugin control flow redirection by skipping system calls
> +# (similar functionality to syscall filter but different mechanism)
> +LDFLAG_TEXT_BASE =3D -Wl,-Ttext-segment=3D0x40000
> +test-plugin-skip-syscalls: LDFLAGS +=3D $(LDFLAG_TEXT_BASE)
> +test-plugin-skip-syscalls: LDFLAGS +=3D -Wl,--section-start,.redirect=3D=
0x20000
> +run-plugin-test-plugin-skip-syscalls-with-libsyscall.so:
> +
> +EXTRA_RUNS_WITH_PLUGIN +=3D run-plugin-test-plugin-skip-syscalls-with-=
libsyscall.so
> +
> +else # CONFIG_PLUGIN=3Dn
> +# Do not build the syscall skipping test if it's not tested with a plu=
gin
> +# because it will simply return an error and fail the test.
> +MULTIARCH_TESTS :=3D $(filter-out test-plugin-skip-syscalls, $(MULTIAR=
CH_TESTS))
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
> diff --git a/tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c b/t=
ests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c
> new file mode 100644
> index 0000000000..1f5cbc3851
> --- /dev/null
> +++ b/tests/tcg/multiarch/plugin/test-plugin-skip-syscalls.c
> @@ -0,0 +1,26 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This test attempts to execute an invalid syscall. The syscall test =
plugin
> + * should intercept this.
> + */
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +void exit_success(void) __attribute__((section(".redirect"), noinline,=

> +                                       noreturn, used));
> +
> +void exit_success(void) {
> +    _exit(EXIT_SUCCESS);
> +}
> +
> +int main(int argc, char *argv[]) {
> +    long ret =3D syscall(0xc0deUL);
> +    if (ret !=3D 0L) {
> +        perror("");
> +    }
> +    /* We should never get here */
> +    return EXIT_FAILURE;
> +}

I'm running into an issue for all four variants of MIPS if I don't
hardcode the section but pass the function address as a syscall argument
and then use that as jump target in the plugin: according to the ABI,
the t9 register has to contain the address of the function being called.
The function prologue then calculates the gp register value (global
pointer / context pointer) based on t9, and derives the new values of t9
for any callees from gp again. As I'm currently just updating the pc
with the new API function, t9 is out of sync with the code after control
flow redirection and the binary crashes.

I think it is fair to expect a user of the API to be aware of such
pitfalls (or we can document it), but I'd of course still like to make
the tests pass. The simplest solution (theoretically) is to also set the
t9 register in the plugin callback before calling qemu_plugin_set_pc.
However, the MIPS targets do not actually expose any registers to
plugins, i.e., qemu_plugin_get_registers returns an empty GArray.

Given this behavior, I see two solutions:
1) skipping the test on MIPS, or
2) making the test code a bit more contrived to use labels within the
   same function while preventing the compiler from optimizing the
   labels away (which it does even with -O0). I've got a prototype for
   this, but the test code looks a bit contrived then:

   int main(int argc, char *argv[]) {
       int retvals[] =3D {EXIT_SUCCESS, EXIT_FAILURE};
       int retval_idx =3D 1;

       long ret =3D syscall(0xc0deUL, &&good);
       if (ret < 0) {
           perror("");
           goto bad;
       } else if (ret =3D=3D 0xdeadbeefUL) {
           /*
            * Should never arrive here but we need this nevertheless to p=
revent
            * the compiler from optimizing away the label. Otherwise, the=
 compiler
            * silently rewrites the label value used in the syscall to an=
other
            * address (typically pointing to right after the function pro=
logue).
            */
           printf("Check what's wrong, we should never arrive here!");
           assert(((uintptr_t)&&good =3D=3D (uintptr_t)ret));
           /* We should absolutely never arrive here, the assert should t=
rigger */
           goto good;
       }

   bad:
       retval_idx =3D 1;
       goto exit;
   good:
       retval_idx =3D 0;
   exit:
       return retvals[retval_idx];
   }

Maybe I'm just missing something obvious, I'd be happy to get some
feedback on this. Thanks in advance!

> diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
> index 5658f83087..b68e3cadf4 100644
> --- a/tests/tcg/plugins/syscall.c
> +++ b/tests/tcg/plugins/syscall.c
> @@ -148,6 +148,12 @@ static void vcpu_syscall(qemu_plugin_id_t id, unsi=
gned int vcpu_index,
>              fprintf(stderr, "Error reading memory from vaddr %"PRIu64"=
\n", a2);
>          }
>      }
> +
> +    if (num =3D=3D 0xc0deUL) {
> +        /* Special syscall to test the control flow redirection functi=
onality. */
> +        qemu_plugin_outs("Marker syscall detected, jump to clean exit\=
n");
> +        qemu_plugin_set_pc(0x20000);
> +    }
>  }
> =20
>  static void vcpu_syscall_ret(qemu_plugin_id_t id, unsigned int vcpu_id=
x,
> diff --git a/tests/tcg/sparc64/Makefile.target b/tests/tcg/sparc64/Make=
file.target
> new file mode 100644
> index 0000000000..516927a3fc
> --- /dev/null
> +++ b/tests/tcg/sparc64/Makefile.target
> @@ -0,0 +1,16 @@
> +# -*- Mode: makefile -*-
> +#
> +# Sparc64 - included from tests/tcg/Makefile.target
> +#
> +
> +SPARC64_SRC=3D$(SRC_PATH)/tests/tcg/sparc64
> +
> +# Set search path for all sources
> +VPATH +=3D $(SPARC64_SRC)
> +
> +ifeq ($(CONFIG_PLUGIN),y)
> +# The defined addresses for the binary are not aligned correctly for s=
parc64
> +# but adjusting them breaks other architectures, so just skip it on sp=
arc64.
> +run-plugin-test-plugin-skip-syscalls-with-libsyscall.so:
> +	$(call skip-test, $<, "qemu-sparc64 does not allow mapping at our giv=
en fixed address")
> +endif

Best regards,
Florian

--------------ms050308070404010805080304
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
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDIyNTE2MjEwMlowLwYJKoZI
hvcNAQkEMSIEIGXM8S9iC2vCVPfSBUGL8yru3+pQSbcddhyMqL6kuFiaMIGFBgkrBgEEAYI3
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
gQQBDgIwCAYGK4EEAQ4DMA0GCSqGSIb3DQEBAQUABIIBANN9FYI4IHOUOg5r7uRs7LCc3qBw
msLYGFq5pvyou4fPphWco9FGk44cBiTh/WmO2MPmK+rLbDJGPIZUxQaHYdW3gVOoovmK/PBr
fANm0TIVcsgoNSfWeCwK1ayl+erbyt62HkN7i0oWH/+jjcjb2CX3Vk0lMffx9LsYm/bxS+yZ
jT6jJfQnkKfllb3SVrgzjrpFjNuidzyaXxPq8dwKOwQqvITJzfWrPm8TiJugS995d08WpNip
D5XN+tpqIsGULG6mDPQ0TbGDmXeiwZ89LlQFd5pxBt3brx+04FAkYEqn6eZmDh8kSXaxyezm
zfF0HepQbIicrhrIaaFUrnIpZ28AAAAAAAA=

--------------ms050308070404010805080304--

