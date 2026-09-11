Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5B3C88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 04:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4t8B-0001Q6-If; Fri, 11 Sep 2026 00:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x4t89-0001Pu-Ug; Fri, 11 Sep 2026 00:44:53 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x4t87-00059K-8v; Fri, 11 Sep 2026 00:44:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9a1MVQWXs579jn5lyKPUzLKQICp8ivqDGOZLxU/4C2FHh6GKliNyXNsjzlOaqGktRDkzt656F/GlET/JdfP0AGxSLX1xGkBfQu3l/jMNmDOgi4jaRR7Up8haVo2q8Nz8OVPf8MB6XKcSq9c9Abvrd7oSFyCbwS1gqel15V4GU6S1wE3ELuGdaB9XInPf80ILdtjz6iCeIE4D2VRIsh50b5VXOHXBLFamKFeo/YuZvUetezdTXWrtE2ydxvq0+/xrUeMur2/fgTCv9tOp5h9FxDY+tgDT230l02my+u5CvzfsY3a9Cmasf2EniRebeAqLnvE4+wrXgPsp/idWXekow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPMaZyxn66NanZam7WVD+eGYJncttcFLzeIYaRsUck8=;
 b=Z2lg+hvnURBEgz+Ia/GfuDeRFMR20H7GH7YZl2VRY7cX9CjnAQmajGBpFj/97Y37L7nGmxMEKoJ4SDugHAEbP+Q9lNz+LeR6LNlaNDn9RhhxG/a9xkK+oAIujIavZSpH0r67wI9YlAGRcPZxednfTf08DGj+JkqQJYFxCYApsAFfDlFskcBGbVRy+/QzSc5utwNlHvVPFz0e1geP6rlPiIZh8XcFjxJxl7flMos0xC2oPw73giuslguXMh3R92CLd2aL4t6InhVEh/eaadOTBWNef0pjkNbjww2yDgkBQ3ZWbbLK8f6XQH9efNFxSp7XSEUflWJySh4VbzUZTkJYAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPMaZyxn66NanZam7WVD+eGYJncttcFLzeIYaRsUck8=;
 b=DUgGntrmZdEC4GsfUB/ZvMzaWeo41c5mD5htWgoMDn0B/i996ZNnWAIcntkry9rNWU6bJ5lc1SDjLvr+pd3OFCl6fcLVb/z2DzrsshtK3LqpPqXTat+l6dkgujddkt6IGdSZIOdcpSlaC7Mb0/0XsdXejvXZa6X04QMb8DmJCqwY9uOKT29ru68X7Khqnm5Fx67j41mTJ1fYzC7F5ThFnmnSC5qXcj15rZilqPWQJP6eS9VYkAB4BXSrfAU7VtecJDPh56qRq8xyiTNmqe4TwXeES149kAnODA7CJuf8enG48Cy21TrMgl20tbB3SadWkiBxgHsOUp32Qpyr3JKMfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SEZPR02MB7871.apcprd02.prod.outlook.com (2603:1096:101:216::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 04:44:42 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 04:44:42 +0000
Date: Fri, 11 Sep 2026 12:44:37 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Zephyr Li <fritchleybohrer@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-stable@nongnu.org, 
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com, 
 pierrick.bouvier@oss.qualcomm.com, alex.bennee@linaro.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH v2] target/riscv: fix RV32 fixed counter accesses
Message-ID: <aqOHF2QVtK0UWM-e@MacBook-Pro-4.local>
References: <20260909072356.42784-1-fritchleybohrer@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909072356.42784-1-fritchleybohrer@gmail.com>
X-ClientProxiedBy: PH8P221CA0063.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::15) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SEZPR02MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f9401d-a84a-4186-b895-08df0fbf6575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|18002099003|5023799004|10067099003|56012099006|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info: sJ+JCZYmcNES41LbDMeLkWbylU1gPl1MahZpC2/3JyiCK6nu4cbUlVxeKHD1tq/AJAiHGdKLLroIF4S4JsSUcyYDML3vxGjqLAKJVHu8Fwlaa6Cs0n+OMI7+1fGyoCjlCgnFe5eh8WUSRM9DLzKAFkr2vpIKKgAzZdaP1hU0UQdVjOMcj1QUb3xBfV/QaBx17dp2Mp13jBLsVLkNTMVm83j5eU0vTkY0zjOB28uERSK5EBzD9vuCcHmPjX0efq2jdcc0A+kFrOF4YHGiTD225uIrOilPxU9hbMdKTuYCjvPbNXs9qJr9YF7lx8jWYkSnLwfoHOx2hbesqOfyrJLhqQKmIFPSxMEDaS9m4j8IW5lYXkCuZWMOb3HaYHgOWGxJ3bSyNvwRCPbKpE4r4tUW2ad7hjHxO++R6Ez6MJ9ixGMc1I+vrF41K2BYBSmFIqUywg1w9fPFxe4GYyxIDuiI5tgU9+ILrvAwwbR9gmhm1u8XpBp7vONSX3coQKwG6YOsewGyRi2oIdGgY29IUtrwy1ZqrsI6/yfmTyqJxJUuUvibj/8HYG8KzOoFbnKJyyP/62nSbCdHclyWlY2cyaeK/VLwPDtlkd23QAZMsHy5EOxL9Q3suMO/eX8guYj1a5NJ+jm4rmy36zXasZnSNDAhSuGw5sPlNti73HBLMcUaWpo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(5023799004)(10067099003)(56012099006)(3023799007)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LTUsQkPKcMAigO9Yg9f9A0+zaXwhXysZQJW4MRs7TJ+Ved4POEm9IsEtjmye?=
 =?us-ascii?Q?ZQTjqjJBnaNYOzJanmw5+ciekYMFy26bY/1p+kve4mlbi9eYIIc8JM8TxfI6?=
 =?us-ascii?Q?q/b/tsAvY5Hhlwrtt4Zu8OIStCYmoTQa1epUXAvdH/E76V/omJWE+m0DHNku?=
 =?us-ascii?Q?YqNf7XsdRvfxT2BkoeMZ231SL1BVwyYhbXhHViE0/Tkfyn7ZFDHhNJ6iB+MH?=
 =?us-ascii?Q?CuOcEM08Y5EZX1SSI8AIfoIX6xoI6RnXfTQZmbnUv3vlb877W5Rk7pNW9NXt?=
 =?us-ascii?Q?l3EudOXtqcoNTbLJyRl2qtsmexcERvyGtnxADprmK4eOV11WfVddFB6o8VMa?=
 =?us-ascii?Q?Y+R1+5vm87+6iX/Bkko+ePAd/S1BnFE9VM5dC2kNyIlMwcpnVbRWXRXnnkcH?=
 =?us-ascii?Q?1Xfhhqw6NkQNnKM6nzU+P7+DKzFGIIvtECnidynfc6PVPqGi8Jhhk5o2BSfY?=
 =?us-ascii?Q?Ft3FZam8uZl4vOPy9yy0d++RyNOG9bbg/F5HsaqsSTOMJ64CRGVvI5GieAot?=
 =?us-ascii?Q?JnH7Q/UZ7XBJmH3ivMa5TtOoYvYmLqAQmhqN9hnWWI072GC4jo/QVddVeMUe?=
 =?us-ascii?Q?jUvyDlxGf4B09lNuQIN2E1+OIdBbPG9LNdAGKWMS5/qSCT873ncixEhrIWu/?=
 =?us-ascii?Q?i7Fs4379c7CHDthoCnGNLF+QcOemL3Z4QM/piw/eJD/zrmmxXeWy3aPIoEcD?=
 =?us-ascii?Q?5wpSpzhiZGEXsI10g182tKp5WngNHOuqDsnshKLcjVu/9txPaowzmZQhcW4C?=
 =?us-ascii?Q?vtzu2RAyrOplqEg4Dpu3YWvEAEmfTuIYhV8Ipx7LJ+PLXHtxDBdDzReFGTzZ?=
 =?us-ascii?Q?aFKbDtpvFbABc5pjHDtl0dMn/5dKCypF7O7t6OWmVw7S4ttaUBrr0LrH5+A9?=
 =?us-ascii?Q?VTjMRRfpOa5d67Fw0gsvnWokXr0L3uHJrSbBuRZujXo9ORNqlFB4gut0+bK6?=
 =?us-ascii?Q?MiU1d6QwlSuuwSurx6CFvHDhCw2WGUm9FxZeAPuZglu20ZNaT7D12ZthEtrS?=
 =?us-ascii?Q?lQ9CxrbdhBcJByNNwqnYze87dj4tGrplxAgnO4+bHS1Oh8MFIpzaxbmcm+Sq?=
 =?us-ascii?Q?7sPLdfJqRsA132Yk4wUpsP1kiwNNjPoWBqVEJdKaKQWsFCdGTVulaDmUJv8v?=
 =?us-ascii?Q?GI9WQl3Fe8OQQkgzb2siC2vDoD17NbzeIn19UdM5/9XDsSMiwm2rOpUkfN3g?=
 =?us-ascii?Q?MgnNX/R+RHuzbwhnBxLPfArqngFns4tqqJ+vnYBCoHlDkEU4HeZPhwGFCqj/?=
 =?us-ascii?Q?J9IdDbvF3O45ekFwLNctIUiZ42YJXmGXDePfc5pEGCK1kDI9RRFd6oJYJjGr?=
 =?us-ascii?Q?8XvxnaGRHjeq85YdnBzTWdPqVJONWwb/nS50/B/ARDs7dHK4DeYAbxaoyY7A?=
 =?us-ascii?Q?3AVnd5IuTlBA7fl+IF9EKo87rniiciIk+NH3EnBsHdpvzi3fjheQE8izLZUi?=
 =?us-ascii?Q?KprylHB7CkYftYml41hxQuup59nY7IrF7PPWrxaoPvUWhKz2HTP6iE5nTfnN?=
 =?us-ascii?Q?h9H0ZdFBtu2rAaxQrGMcdFcLPm7Tt5J0+c2+jiQMHDc1W4fumNkYk2j4uJ+q?=
 =?us-ascii?Q?tHw8nKs8vQSMVa+RaHPgxC9qrHLHaBhRx1WlFmP7kCdSrVAMMgUINBtyx2L2?=
 =?us-ascii?Q?4a2D5Nj+RXQ7bFhQei1qXvBDLyb6QTxDYciFG0A0LpKQs9zPZvlj8YN9U225?=
 =?us-ascii?Q?VH8JRz5XhPslXSYWQtnshYj2fMXKFu720iKeBEbfvtIzAgXV9Tdaom9RdZ4r?=
 =?us-ascii?Q?L2necZ2HgyOMeQ45nKix4EMPLwdmShk=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f9401d-a84a-4186-b895-08df0fbf6575
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 04:44:42.7366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrP0q7M2vHA+wHMVJGH9cQgYJYX9yqO0sChFf1N00X32mFrnXOY5bHKTttuGfkVJa0oVq5jcrlkZBekOG+TG38lWr0IlzEKhhVHfWFwPeKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7871
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=chao.liu@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

On Wed, Sep 09, 2026 at 03:23:55PM +0800, Zephyr Li wrote:
> Since commit cfc96df65e01, riscv_pmu_ctr_get_fixed_counters_val()
> returns the complete 64-bit fixed-counter value. The RV32 counter
> access paths, however, still perform parts of the offset calculation
> on separately extracted 32-bit halves.
> 
> In particular, riscv_pmu_write_ctrh() deposits the low 32 bits of the
> complete fixed-counter value into the high half of mhpmcounter_prev.
> riscv_pmu_read_ctr() also subtracts a 32-bit half of the previous value
> from the complete 64-bit fixed-counter value. Consequently, writes to
> mcycleh can be lost and carries between the low and high halves are not
> handled correctly.
> 
> Keep the fixed-counter offset calculation entirely in 64 bits. Before
> a running counter is partially written, materialize its current
> architectural value and reset the fixed-counter baseline. On reads,
> calculate the complete 64-bit counter value before extracting the half
> requested by RV32.
> 
> Register RV32 system TCG tests with the Meson build. Add a test for
> high-half writes, low-to-high carry, and preserving the carried high
> half across a subsequent low-half write.
> 
> Fixes: cfc96df65e01 ("target/riscv: Remove upper_half from riscv_pmu_ctr_get_fixed_counters_val")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4219
> Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> 
> ---
> Changes in v2:
> - Move the test to a new tests/tcg/riscv32 directory.
> - Convert the test registration to the Meson TCG test framework.
> - Add RV32 TCG cross-compiler options and cover the test directory in
>   MAINTAINERS.
> - Add a riscv32-local semihosting linker script.
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7183babd6a..5f75b2684f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -377,6 +377,7 @@ F: include/hw/riscv/
>  F: common-user/host/riscv*
>  F: tests/functional/riscv32
>  F: tests/functional/riscv64
> +F: tests/tcg/riscv32/
>  F: tests/tcg/riscv64/
>  F: tests/qtest/iommu-riscv-test.c
>  
> diff --git a/meson_options.txt b/meson_options.txt
> index 292625af08..2ceebe7a44 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -452,6 +452,10 @@ option('tcg_tests_cross_cc_ppc64le', type: 'string',
>         description: 'cc for ppc64le tcg tests')
>  option('tcg_tests_cross_cflags_ppc64le', type: 'string',
>         description: 'cflags for ppc64le tcg tests')
> +option('tcg_tests_cross_cc_riscv32', type: 'string',
> +       description: 'cc for riscv32 tcg tests')
> +option('tcg_tests_cross_cflags_riscv32', type: 'string',
> +       description: 'cflags for riscv32 tcg tests')
>  option('tcg_tests_cross_cc_riscv64', type: 'string',
>         description: 'cc for riscv64 tcg tests')
>  option('tcg_tests_cross_cflags_riscv64', type: 'string',
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index bd4b6dc114..65985efb22 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -1337,23 +1337,23 @@ static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, target_ulong val,
>      int deposit_size = rv32 ? 32 : 64;
>      uint64_t ctr;
>  
> -    counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
> -                                         0, deposit_size, val);
> -
>      if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
>          (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
>           riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
>          ctr = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);
> -        counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
> -                                              0, deposit_size, ctr);
> +        counter->mhpmcounter_val += ctr - counter->mhpmcounter_prev;
> +        counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
> +                                             0, deposit_size, val);
> +        counter->mhpmcounter_prev = ctr;
>          if (ctr_idx > 2) {
>              riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx);
>          }
>       } else {
> +        counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
> +                                             0, deposit_size, val);
>          /* Other counters can keep incrementing from the given value */
>          counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
>                                                0, deposit_size, val);
> -
>      }
>  
>      return RISCV_EXCP_NONE;
> @@ -1363,20 +1363,22 @@ static RISCVException riscv_pmu_write_ctrh(CPURISCVState *env, target_ulong val,
>                                            uint32_t ctr_idx)
>  {
>      PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
> -    uint64_t ctrh;
> +    uint64_t ctr;
>  
> -    counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
> -                                         32, 32, val);
>      if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
>          (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
>           riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
> -        ctrh = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);
> -        counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
> -                                              32, 32, ctrh);
> +        ctr = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);
> +        counter->mhpmcounter_val += ctr - counter->mhpmcounter_prev;
> +        counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
> +                                             32, 32, val);
> +        counter->mhpmcounter_prev = ctr;
>          if (ctr_idx > 2) {
>              riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx);
>          }
>      } else {
> +        counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
> +                                             32, 32, val);
>          counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
>                                                32, 32, val);
>      }
> @@ -1407,12 +1409,11 @@ RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
>      bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
>      int start = upper_half ? 32 : 0;
>      int length = rv32 ? 32 : 64;
> -    uint64_t ctr_prev, ctr_val;
> +    uint64_t ctr_val;
>  
>      /* Ensure upper_half is only set for XLEN == 32 */
>      g_assert(rv32 || !upper_half);
>  
> -    ctr_prev = extract64(counter->mhpmcounter_prev, start, length);
>      ctr_val  = extract64(counter->mhpmcounter_val, start, length);
>  
>      if (get_field(env->mcountinhibit, BIT(ctr_idx))) {
> @@ -1431,7 +1432,8 @@ RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
>      if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
>          riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
>          uint64_t cntr = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx) -
> -                                                             ctr_prev + ctr_val;
> +                        counter->mhpmcounter_prev +
> +                        counter->mhpmcounter_val;
>          *val = extract64(cntr, start, length);
>      } else {
>          *val = ctr_val;
> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
> index d41a228fb3..60b5ce2529 100644
> --- a/tests/tcg/meson.build
> +++ b/tests/tcg/meson.build
> @@ -169,6 +169,7 @@ subdir('mips64el')
>  subdir('or1k')
>  subdir('ppc64')
>  subdir('ppc64le')
> +subdir('riscv32')
>  subdir('riscv64')
>  subdir('s390x')
>  subdir('sh4')
> diff --git a/tests/tcg/riscv32/meson.build b/tests/tcg/riscv32/meson.build
> new file mode 100644
> index 0000000000..c08dfd772d
> --- /dev/null
> +++ b/tests/tcg/riscv32/meson.build
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +cc = 'riscv64-linux-gnu-gcc'
> +cc_dockerfile = 'debian-all-test-cross'
> +cc_docker_host_arch = ['aarch64', 'x86_64']
> +
> +subdir('system')
> diff --git a/tests/tcg/riscv32/semihost.ld b/tests/tcg/riscv32/semihost.ld
> new file mode 100644
> index 0000000000..874838a865
> --- /dev/null
> +++ b/tests/tcg/riscv32/semihost.ld
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +ENTRY(_start)
> +
> +SECTIONS
> +{
> +    /* virt machine, RAM starts at 2gb */
> +    . = 0x80000000;
> +    .text : {
> +        *(.text)
> +    }
> +    .rodata : {
> +        *(.rodata)
> +    }
> +    /* align r/w section to next 2mb */
> +    . = ALIGN(1 << 21);
> +    .data : {
> +        *(.data)
> +    }
> +    .bss : {
> +        *(.bss)
> +    }
> +}
> diff --git a/tests/tcg/riscv32/system/meson.build b/tests/tcg/riscv32/system/meson.build
> new file mode 100644
> index 0000000000..16f9a06c94
> --- /dev/null
> +++ b/tests/tcg/riscv32/system/meson.build
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +tests = []
> +
> +link_script = files('../semihost.ld')[0]
> +cflags = ['-march=rv32im_zicsr',
> +          '-mabi=ilp32',
> +          '-nostdlib',
> +          '-ffreestanding',
> +          '-Wa,--noexecstack',
> +          '-Wl,-T', link_script]
> +qemu_args = ['-M', 'virt',
> +             '-display', 'none',
> +             '-serial', 'stdio',
> +             '-semihosting',
> +             '-bios']
> +
> +tests += {
> +  'test-mcycle.S': {
> +    'cflags': cflags,
> +    'qemu_args': ['-icount', 'shift=1', qemu_args],
> +  },
> +}
> +
> +if 'qemu-system-riscv32' in emulators
> +  tcg_tests += {
> +    'riscv32-softmmu': {
> +      'cc': cc,
> +      'cc_dockerfile': cc_dockerfile,
> +      'cc_docker_host_arch': cc_docker_host_arch,
> +      'folder': 'riscv32',
> +      'gdb_arch': 'riscv32',
> +      'qemu': emulators['qemu-system-riscv32'],
> +      'tests': tests,
> +    }
> +  }
> +endif
> diff --git a/tests/tcg/riscv32/test-mcycle.S b/tests/tcg/riscv32/test-mcycle.S
> new file mode 100644
> index 0000000000..189d1e13a2
> --- /dev/null
> +++ b/tests/tcg/riscv32/test-mcycle.S
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +	.option	norvc
> +
> +	.text
> +	.global	_start
> +_start:
> +	/* Exercise writes while mcycle is running. */
> +	csrw	mcountinhibit, zero
> +	csrw	mcycle, zero
> +
> +	/* A write to the high half must be immediately observable. */
> +	li	s0, 0x1234ffff
> +	csrw	mcycleh, s0
> +	csrr	t0, mcycleh
> +	bne	t0, s0, fail
> +
> +	/* Check carry from the low half into the high half. */
> +	li	s0, 0x12345678
> +	csrw	mcycleh, s0
> +	li	t0, 0xfffffff0
> +	csrw	mcycle, t0
> +	.rept	32
> +	nop
> +	.endr
> +	csrr	t0, mcycleh
> +	addi	s0, s0, 1
> +	bne	t0, s0, fail
> +
> +	/* A low-half write must preserve the carried high half. */
> +	li	t0, 0x22222222
> +	csrw	mcycle, t0
> +	csrr	t0, mcycleh
> +	bne	t0, s0, fail
> +
> +	li	t0, 0x100000
> +	li	t1, 0x5555	/* FINISHER_PASS */
> +	sw	t1, 0(t0)
> +	j	.
> +
> +fail:
> +	li	t0, 0x100000
> +	li	t1, 0x13333	/* status = FINISHER_FAIL, code = 1 */
> +	sw	t1, 0(t0)
> +	j	.
> -- 
> 2.43.0

