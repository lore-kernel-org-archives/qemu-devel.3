Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD71C88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 05:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4u8r-0000nD-Vj; Fri, 11 Sep 2026 01:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x4u8q-0000mf-ER; Fri, 11 Sep 2026 01:49:40 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x4u8n-0007X6-6x; Fri, 11 Sep 2026 01:49:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WT/iGfxvP7vpbgN4JbD6a1E8lrhh3BHonRdqyZkkB0ANoqPp9BZTEQJGtgoj71N6SbfwZP2ZudqT2j+T3M+LZ571IiImIzbsMmh1IUdjUikGUlIxkoURZuNsZXuiY8nFr9yT3LGJvMurX0942jX9rH3aMMtPyTrGz/yvWdXNudd5s06F1L6jYAuYF2673ajQUi1oAeD7gkisZOK+Lrj6tcLz0LpHK97clvuHMj+84OJ7wVYESDc50GUoRPI6Rx4NRqXuggSy+n1LKHnIEt+/O2QZfm00qWp16bJ6lDgl5c4/6JzN/0jUrNCiQ87r05eGEaNgg+674KDUHRkvMfuQDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxRTNYPoVUQ7l52tFQGiSnpSL9BZpXe9reOzXeH3IWQ=;
 b=LBG3crKjnAsXP7tRA3mAiUWnhSS8fNYCnn0e+QRN8k0E5KfYABszz7TC49ayN4mFwyuDRacw60QImjroN6FrQnoNouA23sR+STXMu0PgdCMJNr3BB3hkZCBkBMyl9LSH+rycyr06RT+7N3HlG6tJ02mFg39Yl6DuvbCfM7dUroUkDuTUltJ3fr38oUiW8FRB9H07/dSYCm+NRZcZzTBj0PJQZ0UAeNPpTOgYYixFqK1IZ8ZIc6ByL7W7bKJRORmCJawGX/ctVD9v42mLkqKYK3+O7xV+ezYZENquJYEvN+1tHy1u63hSy3WvkWweEFyp284PHxAUmI8jaglZMzsVvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxRTNYPoVUQ7l52tFQGiSnpSL9BZpXe9reOzXeH3IWQ=;
 b=penTdBXbSio5LAVt8mFQwi8qAPSMCzdj/VpRqhOlocyrZVdu1rQeMKesK5/qNAOqw5mw0hSOxC1Mmh4FXgMjnGMR8ASqkFP2uuzRmSi8ybWFRtOqfAfnNWsYwxH+gS4Ia1m+HltCuTgmHmkmqtTsBAApU7dPg0QJBw8k9ufU9s/KUNU9yxyiXKFujnknFc0PwaNWm2mn5Js6jHonNdrmlYa4xaCavwQyMNb60EqMaN4LCmXd7T4gZldqJYdYOziXIIgLjiJhdsrHGQ6HaTdTcTkFoCpPG2bBIHk+NbcIsVA7mijPcVuMkjPsl7/O+LP5LJyRUjRZCZoGzAJUORXC7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SEYPR02MB9063.apcprd02.prod.outlook.com (2603:1096:101:301::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 05:49:29 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 05:49:28 +0000
Date: Fri, 11 Sep 2026 13:49:23 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 richard.henderson@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 3/6] tests/tcg/riscv64: Add vector masked
 fault-only-first PMP test
Message-ID: <aqOSwMCX5UsGJA79@MacBook-Pro-4.local>
References: <20260909084154.223529-1-max.chou@sifive.com>
 <20260909084154.223529-4-max.chou@sifive.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909084154.223529-4-max.chou@sifive.com>
X-ClientProxiedBy: PH7PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:510:339::8) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SEYPR02MB9063:EE_
X-MS-Office365-Filtering-Correlation-Id: 88973151-3d12-4859-5759-08df0fc8719e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|6133799003|18002099003|22082099003|56012099006|3023799007|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: 3lHRLpEjo0J/rhla/XtBORDhHTEciJM37cHrN6tdN4qQm7iGZ178NPEKwoGo4Cph/Sc/ZpGnwEM9oCgr9MsSodvTKSGnHLyY47e7ZtWepZ4dlm7ToUplVrCBW9sbW26xcQSSWFKKyE8Y2QsoYhsYu6I6K7svGbJca9NjV20j2wbbAulvQP6vebHBu0OooESSCJ4uBJEFrtIijBvC7sMVl0jFgDWs1Jwo/QKFMt7ulN80yP61rdvEPydEDEMvYMf9YVYsLthWARX68pTLA1cdvv1zg28KiXth8NxJ8XwsGfmYU+FQs33DbYemqkMMUjh+tqjiWW7vRiGS3p/60pbxIyMj7utabll+5k4duNEV+qHfr3+L5GjFT7C4Dm6tOoHA715gUFSRrVUhsnugmOoyH7fNSu0+4s2qkD1qXwps3hZbOeOX1E5L5eotDRrSyAc8M4RYQu+oZgX6yqdeYlpUrU8XOh2PxbFmps7zXM8RaQu9HK7JtXz80FjR7kttI2twzaB+Ezz2K1oALCVxXvZEswVXn6IaKA+a0qfou2FA3D20LoytOQra8Jf5c6PjnFaxpbDZeOVVgyVvDYYbOhOw35j7Bg0B43R1Weje6rKN24PlJldsU1U0MNnbfNZFnrJMjR2zp9HF3NGIqschzdHGFbk1RGzbBIzR2qINuRhzr94=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(18002099003)(22082099003)(56012099006)(3023799007)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MY4Z4ZbFGWIfrgVmtjoZlptsSjbJ9qNZf8vJIXDKwPghCgdmY2urEQ7krqnu?=
 =?us-ascii?Q?BQrYhkLzkIaBlyNHbSJIwNrHuV0EctDn4JHiYlyGLlKwLfz7C4RZjedtOTGU?=
 =?us-ascii?Q?TfrP0XUMwII//67LfW43DZrY54IoMayHwcx9OpMnU/iWFoyM3VwixYsCnn8H?=
 =?us-ascii?Q?jYTIW0pFFyo63MRlLvCshSjOgkzV9Phw4Yod5IAKlt4k9IkUiOL8OUAyghHD?=
 =?us-ascii?Q?u4sbE48Yzp3DgeV8xvMrDKbQSNaCN2qQF9vqDHQW0/IsGncg6xSKlo76YxOO?=
 =?us-ascii?Q?Q5kfIXpm1TCeFphYpo2Tx8Z9vA3ki61UCvmS9oAmdQWPmV201rJVYJvnv+2K?=
 =?us-ascii?Q?P8mu1MR2DbNcLT4013WJ6piyNpo90uP2uFOEqGYvYcXAhwsszBVgxzlmpcFo?=
 =?us-ascii?Q?K5Yh/BxMBB/idroasJVMRosAl0ePjU7YbCd2yOvObmVG4u8RB2DkeCRBqeUN?=
 =?us-ascii?Q?+Rzbcjys7LP14QCLNiqFBCUFf3qR7I9Q8Gwqoo6T90UF7WBZjPDYRBK2FDp1?=
 =?us-ascii?Q?udgMzVt+pywRriQ9ukZQsfdxDtXaKJHiV0I8UAdUUyn4nproug09nj5+qpr2?=
 =?us-ascii?Q?JvbXOtBbssm9yP+Hd5NDMIX5Wlm2mG2flMa/DITQRiT/JfEqskZqBTc8AWE8?=
 =?us-ascii?Q?SyrCCFWpyeqBH3MOCaZ9Nfeidjc3PXLiP+5wQROz9VZTi4w+G+AcvEmt9a3E?=
 =?us-ascii?Q?NHBH2xAo6bmOjn++H7+FRBOh7PxReO+G/EbJtX77Hub7wk3RoxSlzzFFh/oR?=
 =?us-ascii?Q?NQMOhVojClBsEi4jmnotxNn1OH4yMb/e/e2RRvE7mIyb5cfchjR97qdR5OdR?=
 =?us-ascii?Q?dkYw6w5l4x0RVd+wkhzkxXy3WstfAQUp3dj46Fo0WPyVRitPUxZtE2eauQFX?=
 =?us-ascii?Q?qgXvA7vuadXLNW1O0eYNTX0WqngWbk3QnQgDvBQ30HLrXmWFxPKgzZG2nwlt?=
 =?us-ascii?Q?8q0lMRomdO/pFOuEjIw+IEqg1GNLrKSzCDL9/Akpakjdo/4oC/QRvKNySo6N?=
 =?us-ascii?Q?nVq+VLvtuZQtuHRBOgR5t5ioqh0GVcrkkqJPuWJuCy4x+MHdPxBOxtKdGuVO?=
 =?us-ascii?Q?wkqIRysNUv1LtIWSxpxOBUMiTyg9oKhMzfH5krl/o9X4aMWCCLVpan42lN9M?=
 =?us-ascii?Q?/FgPnhnoVqbM5qlEAfEjlrD+wsSki4hleKp5PuF1dv0IL/ZMhDJmzxlf5qrh?=
 =?us-ascii?Q?Ri5jKT9D/MgoXaPY2lLqMtBnt0OM39aF0UO1swL2Sn45d+vE7x/3Zb28A4EA?=
 =?us-ascii?Q?hmp2NcB8DlYv8GyQikpMg9lMIbhtIClILyPicXZydzv99nFcJTjVxjT/oSWg?=
 =?us-ascii?Q?S9gDpV13k7Jq0Fm6kw10yf0Nq+83TwPJBQ9xUM/LmeN08xKTg2y1N4ZOCjy+?=
 =?us-ascii?Q?G7Q4EBv7TeDk7+CSL6PsGR+MtOXJnORPCluRW2+z4Y9ad9OTNDOH5E1CkVRn?=
 =?us-ascii?Q?YZEmN3DmZUczUCPxdHIveITDh80DbcIe8A2xkq3CC5tXM8znuf5Wz6y18LNv?=
 =?us-ascii?Q?ru4LmRdB4xfCORGPSHFeXzuQJPfkiMDWusLxjJHJ4S7FO9wYUIGD21DFQvn8?=
 =?us-ascii?Q?M9L5QpX9lGJmEOCAvvDvfUByqQ7UBqpi0wTe2hOX1frAimLQLHPe+9gO6veM?=
 =?us-ascii?Q?V0DzIr3INM95OG4njof/7JJFgkTT8A5G5UxTE/jf2RQumPMnPkSYWGjbnxi3?=
 =?us-ascii?Q?rbEo7f8dt2lL+0b2V0ixwQlIMs62/3j9p1Sj1WsSZV1UT/UAbKLNpilj+5LR?=
 =?us-ascii?Q?iHPpzOkc0qKCzQpk1y9CHRJfl6tK1BU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88973151-3d12-4859-5759-08df0fc8719e
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 05:49:28.5990 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kS09Sr+OtU7WZJjNKrgmes8Jw39l3fxnWS/L7EDoArtBklDLRS5WmmtSjNJbOljVu7tLDgUVHwZEyCf2BtGfKucFqAkR13l8HABGtUsInrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB9063
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=chao.liu@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Hi Max,

On Wed, Sep 09, 2026 at 04:41:50PM +0800, Max Chou wrote:
> Add a bare-metal test for masked vector fault-only-first loads across
> locked NA4 PMP regions inside one page. The test covers masked-off
> elements, a faulting active element 0, and later active faults that
> shorten vl.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  tests/tcg/riscv64/Makefile.softmmu-target |  13 ++
>  tests/tcg/riscv64/rvv-ldst.inc            |  91 ++++++++
>  tests/tcg/riscv64/test-rvv-ldst-ff-pmp.S  | 259 ++++++++++++++++++++++
>  3 files changed, 363 insertions(+)
>  create mode 100644 tests/tcg/riscv64/rvv-ldst.inc
>  create mode 100644 tests/tcg/riscv64/test-rvv-ldst-ff-pmp.S
> 
> diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
> index f2c75abd57a..0fdf242f735 100644
> --- a/tests/tcg/riscv64/Makefile.softmmu-target
> +++ b/tests/tcg/riscv64/Makefile.softmmu-target
> @@ -85,5 +85,18 @@ run-test-vle32ff: test-vle32ff
>  	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true $(QEMU_OPTS)$<)
>  test-vle32ff: CFLAGS += -march=rv64gcv
>  
> +RVV_LDST_MARCH = -march=rv64gcv
> +RVV_LDST_TESTS = test-rvv-ldst-ff-pmp
> +CLEANFILES += $(RVV_LDST_TESTS)
> +
> +$(RVV_LDST_TESTS): %: %.S rvv-ldst.inc $(LINK_SCRIPT)
> +	$(CC) $(CFLAGS) $(RVV_LDST_MARCH) $< -Wa,--noexecstack -c -o $@.o
> +	$(LD) $(LDFLAGS) $@.o -o $@
> +
> +EXTRA_RUNS += run-test-rvv-ldst-ff-pmp
> +
> +run-test-rvv-ldst-ff-pmp: test-rvv-ldst-ff-pmp
> +	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true$(comma)vlen=128$(comma)elen=64$(comma)vext_spec=v1.0$(comma)rvv_ta_all_1s=true$(comma)rvv_ma_all_1s=true $(QEMU_OPTS)$<)
> +
Just a heads-up, TCG tests are moving to Meson build, so this needs to be
based on:

https://lore.kernel.org/qemu-devel/20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com/

Thanks,
Chao

>  # We don't currently support the multiarch system tests
>  undefine MULTIARCH_TESTS
> diff --git a/tests/tcg/riscv64/rvv-ldst.inc b/tests/tcg/riscv64/rvv-ldst.inc
> new file mode 100644
> index 00000000000..061f330abef
> --- /dev/null
> +++ b/tests/tcg/riscv64/rvv-ldst.inc
> @@ -0,0 +1,91 @@
> +/*
> + * Common support for bare-metal RVV load/store regressions
> + *
> + * Register contract: these macros use t0, t1, t5 and t6 as scratch and
> + * keep the current case number in s11.  ASSERT_EQ and CHECK_VELEM hold
> + * their expected value in t6 across a branch, so a trap handler that can
> + * run in between must leave t6 alone; use t5 and s5 for that instead.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +    .option    norelax
> +    .option    norvc
> +
> +    .macro          RVV_ENABLE
> +    li              t0, 0x6600
> +    csrs            mstatus, t0
> +    csrw            vcsr, zero
> +    .endm
> +
> +    .macro          ASSERT_EQ actual, expected
> +    li              t6, \expected
> +    bne             \actual, t6, fail
> +    .endm
> +
> +    .macro          CASE number
> +    li              s11, \number
> +    .endm
> +
> +    .macro          SEMI_EXIT
> +    lla             a1, semiargs
> +    li              t0, 0x20026
> +    sd              t0, 0(a1)
> +    sd              a0, 8(a1)
> +    li              a0, 0x20
> +    .balign         16
> +    slli            zero, zero, 0x1f
> +    ebreak
> +    srai            zero, zero, 0x7
> +    j    .
> +    .endm
> +
> +    .macro          FAIL
> +fail:
> +    mv              a0, s11
> +    bnez            a0, 1f
> +    li              a0, 1
> +1:
> +    j               exit
> +    .endm
> +
> +    /* Pre-fill selected registers with a sentinel neither data nor 1s. */
> +    .macro          PREFILL vd=, vl=4, sew=e32, value=0x05050505
> +    vsetivli        zero, \vl, \sew, m1, ta, ma
> +    li              t0, \value
> +    .ifb            \vd
> +    vmv.v.x         v2, t0
> +    vmv.v.x         v3, t0
> +    .else
> +    vmv.v.x         \vd, t0
> +    .endif
> +    .endm
> +
> +    /* Set the low mask bits of v0 to \val. */
> +    .macro          SET_MASK val
> +    vsetivli        zero, 1, e8, m1, ta, ma
> +    li              t0, \val
> +    vmv.s.x         v0, t0
> +    .endm
> +
> +    /* Assert element \idx of \vsrc (e32) equals \expected. */
> +    .macro          CHECK_VELEM vsrc, idx, expected
> +    vsetivli        zero, 4, e32, m1, ta, ma
> +    vslidedown.vi   v8, \vsrc, \idx
> +    vmv.x.s         t0, v8
> +    li              t6, \expected
> +    bne             t0, t6, fail
> +    .endm
> +
> +    /* Assert that no trap has been taken since the last check. */
> +    .macro          CHECK_NO_TRAP
> +    bne             s2, s4, fail
> +    .endm
> +
> +    /* Assert that exactly one expected trap has been taken. */
> +    .macro          CHECK_TRAP
> +    addi            s4, s4, 1
> +    bne             s2, s4, fail
> +    li              s0, 0
> +    li              s1, 0
> +    .endm
> diff --git a/tests/tcg/riscv64/test-rvv-ldst-ff-pmp.S b/tests/tcg/riscv64/test-rvv-ldst-ff-pmp.S
> new file mode 100644
> index 00000000000..80b48965625
> --- /dev/null
> +++ b/tests/tcg/riscv64/test-rvv-ldst-ff-pmp.S
> @@ -0,0 +1,259 @@
> +/*
> + * RISC-V vector masked fault-only-first with PMP tests
> + *
> + * PMP permissions may change at NA4 (4-byte) granularity inside one
> + * target page, matching one e32 element exactly. A masked-off body
> + * element performs no memory access, so a read-denied PMP region under
> + * a masked-off element must not fault.
> + *
> + * Runs with rvv_ta_all_1s=true and rvv_ma_all_1s=true so that with a
> + * "ta, ma" vtype every masked-off and tail element must read back as
> + * all-1s, distinct from the 0x05050505 sentinel and the loaded data.
> + *
> + * PMP layout (locked entries, lowest number wins; everything outside
> + * the test page is unmatched and so fully accessible from M-mode):
> + *   pmp0: NA4   buf_a+4,   L, ---   deny element 1 of buf_a
> + *   pmp1: NA4   buf_b+0,   L, ---   deny element 0 of buf_b
> + *   pmp2: NA4   buf_c+8,   L, ---   deny element 2 of buf_c
> + *   pmp3: NAPOT test page, L, R     lower-priority page allow
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +    #include "rvv-ldst.inc"
> +
> +    .text
> +    .global _start
> +_start:
> +    RVV_ENABLE
> +    lla     t0, trap_handler
> +    csrw    mtvec, t0
> +
> +    /*
> +     * Trap handler protocol:
> +     *   s0: expected mcause (0: no trap expected)
> +     *   s1: expected mtval (-1 accepts any value)
> +     *   s2: traps taken
> +     *   s3: vstart seen at last trap
> +     *   s4: traps expected
> +     *   s5: mtval seen at last trap
> +     */
> +    li      s0, 0
> +    li      s1, 0
> +    li      s2, 0
> +    li      s3, -1
> +    li      s4, 0
> +
> +    /* Program the locked PMP entries; single locking cfg write last. */
> +    lla     t0, buf_a + 4
> +    srli    t0, t0, 2
> +    csrw    pmpaddr0, t0
> +    lla     t0, buf_b
> +    srli    t0, t0, 2
> +    csrw    pmpaddr1, t0
> +    lla     t0, buf_c + 8
> +    srli    t0, t0, 2
> +    csrw    pmpaddr2, t0
> +    lla     t0, pmp_page
> +    srli    t0, t0, 2
> +    ori     t0, t0, 0x1ff
> +    csrw    pmpaddr3, t0
> +    li      t0, 0x99909090
> +    csrw    pmpcfg0, t0
> +
> +    /*
> +     * Case 1: sanity: the NA4 deny is in effect for a scalar load.
> +     */
> +    CASE    1
> +    li              s0, 5
> +    li              s1, -1
> +    lla             t1, buf_a
> +    lw              t0, 4(t1)
> +    CHECK_TRAP
> +
> +    /*
> +     * Case 2: denied bytes lie only under masked-off element 1: no trap.
> +     * QEMU retains vl at 3 for this successful access.
> +     */
> +    CASE    2
> +    PREFILL
> +    SET_MASK        0b101
> +    vsetivli        zero, 3, e32, m1, ta, ma
> +    lla             a0, buf_a
> +    vle32ff.v       v2, (a0), v0.t
> +    CHECK_NO_TRAP
> +    csrr            t0, vl
> +    ASSERT_EQ       t0, 3
> +    csrr            t0, vstart
> +    bnez            t0, fail
> +    CHECK_VELEM     v2, 0, 0x00aa0000
> +    CHECK_VELEM     v2, 1, -1
> +    CHECK_VELEM     v2, 2, 0x00aa0002
> +    CHECK_VELEM     v2, 3, -1
> +
> +    /*
> +     * Case 3: active element 0 denied: trap, vstart 0.
> +     */
> +    CASE    3
> +    PREFILL
> +    li              s0, 5
> +    li              s1, -1
> +    vsetivli        zero, 3, e32, m1, ta, ma
> +    lla             a0, buf_b
> +    vle32ff.v       v2, (a0)
> +    CHECK_TRAP
> +    bnez            s3, fail
> +
> +    /*
> +     * Case 4: masked-off element 0 over denied bytes: no trap.
> +     * retains vl at 3 and loads elements 1 and 2.
> +     */
> +    CASE    4
> +    PREFILL
> +    SET_MASK        0b110
> +    vsetivli        zero, 3, e32, m1, ta, ma
> +    lla             a0, buf_b
> +    vle32ff.v       v2, (a0), v0.t
> +    CHECK_NO_TRAP
> +    csrr            t0, vl
> +    ASSERT_EQ       t0, 3
> +    CHECK_VELEM     v2, 0, -1
> +    CHECK_VELEM     v2, 1, 0x00bb0001
> +    CHECK_VELEM     v2, 2, 0x00bb0002
> +    CHECK_VELEM     v2, 3, -1
> +
> +    /*
> +     * Case 5: active element 2 denied, unmasked: no trap, vl 2.
> +     */
> +    CASE    5
> +    PREFILL
> +    vsetivli        zero, 3, e32, m1, ta, ma
> +    lla             a0, buf_c
> +    vle32ff.v       v2, (a0)
> +    CHECK_NO_TRAP
> +    csrr            t0, vl
> +    ASSERT_EQ       t0, 2
> +    CHECK_VELEM     v2, 0, 0x00cc0000
> +    CHECK_VELEM     v2, 1, 0x00cc0001
> +    CHECK_VELEM     v2, 2, -1
> +    CHECK_VELEM     v2, 3, -1
> +
> +    /*
> +     * Case 6: masked-off element 0, active element 2 denied: vl 2.
> +     */
> +    CASE    6
> +    PREFILL
> +    SET_MASK        0b110
> +    vsetivli        zero, 3, e32, m1, ta, ma
> +    lla             a0, buf_c
> +    vle32ff.v       v2, (a0), v0.t
> +    CHECK_NO_TRAP
> +    csrr            t0, vl
> +    ASSERT_EQ       t0, 2
> +    CHECK_VELEM     v2, 0, -1
> +    CHECK_VELEM     v2, 1, 0x00cc0001
> +    CHECK_VELEM     v2, 2, -1
> +    CHECK_VELEM     v2, 3, -1
> +
> +    /*
> +     * Case 7: nf=2 segments, masked-off segment 0 covers the denied bytes at
> +     * buf_b: no trap. retains vl at 3 and loads segments 1 and 2.
> +     */
> +    CASE    7
> +    PREFILL
> +    SET_MASK        0b110
> +    vsetivli        zero, 3, e32, m1, ta, ma
> +    lla             a0, buf_b
> +    vlseg2e32ff.v   v2, (a0), v0.t
> +    CHECK_NO_TRAP
> +    csrr            t0, vl
> +    ASSERT_EQ       t0, 3
> +    CHECK_VELEM     v2, 0, -1
> +    CHECK_VELEM     v3, 0, -1
> +    CHECK_VELEM     v2, 1, 0x00bb0002
> +    CHECK_VELEM     v3, 1, 0x00bb0003
> +    CHECK_VELEM     v2, 2, 0x00bb0004
> +    CHECK_VELEM     v3, 2, 0x00bb0005
> +    CHECK_VELEM     v2, 3, -1
> +    CHECK_VELEM     v3, 3, -1
> +
> +    /*
> +     * Case 8: nf=2 segments, unmasked, field 0 of segment 1 denied
> +     * at buf_c+8: no trap, vl truncates to 1, segment 0 loaded.
> +     */
> +    CASE    8
> +    PREFILL
> +    vsetivli        zero, 3, e32, m1, ta, ma
> +    lla             a0, buf_c
> +    vlseg2e32ff.v   v2, (a0)
> +    CHECK_NO_TRAP
> +    csrr            t0, vl
> +    ASSERT_EQ       t0, 1
> +    CHECK_VELEM     v2, 0, 0x00cc0000
> +    CHECK_VELEM     v3, 0, 0x00cc0001
> +    CHECK_VELEM     v2, 1, -1
> +    CHECK_VELEM     v3, 1, -1
> +    CHECK_VELEM     v2, 2, -1
> +    CHECK_VELEM     v3, 2, -1
> +    CHECK_VELEM     v2, 3, -1
> +    CHECK_VELEM     v3, 3, -1
> +
> +    /*
> +     * Case 9: the denied masked-off element is the last element of the
> +     * accessed range, so a range probe cannot miss it as an interior
> +     * region: no trap. retains vl at 2.
> +     */
> +    CASE    9
> +    PREFILL
> +    SET_MASK        0b01
> +    vsetivli        zero, 2, e32, m1, ta, ma
> +    lla             a0, buf_a
> +    vle32ff.v       v2, (a0), v0.t
> +    CHECK_NO_TRAP
> +    csrr            t0, vl
> +    ASSERT_EQ       t0, 2
> +    CHECK_VELEM     v2, 0, 0x00aa0000
> +    CHECK_VELEM     v2, 1, -1
> +    CHECK_VELEM     v2, 2, -1
> +    CHECK_VELEM     v2, 3, -1
> +
> +    li    a0, 0
> +exit:
> +    SEMI_EXIT
> +    FAIL
> +
> +    .balign    4
> +trap_handler:
> +    csrr   t5, mcause
> +    bne    t5, s0, fail
> +    csrr   s5, mtval
> +    li     t5, -1
> +    beq    s1, t5, 1f
> +    bne    s5, s1, fail
> +1:
> +    csrr    s3, vstart
> +    addi    s2, s2, 1
> +    csrw    vstart, zero
> +    csrr    t5, mepc
> +    addi    t5, t5, 4
> +    csrw    mepc, t5
> +    mret
> +
> +    .data
> +    .balign    16
> +semiargs: .space 16
> +
> +    /* One dedicated page; the locked NAPOT entry grants R only. */
> +    .balign    4096
> +pmp_page:
> +buf_a:
> +    .word    0x00aa0000, 0x00aa0001, 0x00aa0002, 0x00aa0003
> +    .word    0x00aa0004, 0x00aa0005
> +    .skip    40
> +buf_b:
> +    .word    0x00bb0000, 0x00bb0001, 0x00bb0002, 0x00bb0003
> +    .word    0x00bb0004, 0x00bb0005
> +    .skip    40
> +buf_c:
> +    .word    0x00cc0000, 0x00cc0001, 0x00cc0002, 0x00cc0003
> +    .word    0x00cc0004, 0x00cc0005
> +    .skip    3944
> -- 
> 2.43.0
> 

