Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533A6C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 15:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmwjj-0005az-4G; Tue, 25 Feb 2025 10:20:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tmwjg-0005WQ-Ev; Tue, 25 Feb 2025 10:20:40 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tmwjd-0005gb-GI; Tue, 25 Feb 2025 10:20:39 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1DDFA4E6039;
 Tue, 25 Feb 2025 16:20:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id LX-9kM4mVNNA; Tue, 25 Feb 2025 16:20:29 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2D44B4E6014; Tue, 25 Feb 2025 16:20:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2A9CC74577D;
 Tue, 25 Feb 2025 16:20:29 +0100 (CET)
Date: Tue, 25 Feb 2025 16:20:29 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>
Subject: Re: [RFC PATCH] target/ppc: drop ppc_tlb_invalidate_all from cpu_rest
In-Reply-To: <20250225150124.3497568-1-alex.bennee@linaro.org>
Message-ID: <7289c285-eb95-0a1a-adb2-4066c8c1a6a1@eik.bme.hu>
References: <20250225150124.3497568-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-358765520-1740496829=:47077"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-358765520-1740496829=:47077
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 25 Feb 2025, Alex Bennée wrote:
> The vCPU parent already triggers a tb_flush so this is un-needed:

Typo in subject: cpu_reset

>  #0  tlb_flush_other_cpu (cpu=0x555556df8630) at ../../accel/tcg/cputlb.c:419
>  #1  0x0000555555ee38c9 in tcg_cpu_reset_hold (cpu=0x555556df8630) at ../../accel/tcg/tcg-accel-ops.c:88
>  #2  0x0000555555bc29e5 in cpu_exec_reset_hold (cpu=0x555556df8630) at ../../system/cpus.c:208
>  #3  0x00005555558932c3 in cpu_common_reset_hold (obj=0x555556df8630, type=RESET_TYPE_COLD) at ../../hw/core/cpu-common.c:139
>  #4  0x0000555555d480b1 in ppc_cpu_reset_hold (obj=0x555556df8630, type=RESET_TYPE_COLD) at ../../target/ppc/cpu_init.c:7200
>  #5  0x0000555555ef28f0 in resettable_phase_hold (obj=0x555556df8630, opaque=0x0, type=RESET_TYPE_COLD) at ../../hw/core/resettable.c:162
>  #6  0x0000555555ef24f4 in resettable_assert_reset (obj=0x555556df8630, type=RESET_TYPE_COLD) at ../../hw/core/resettable.c:58
>  #7  0x0000555555ef244c in resettable_reset (obj=0x555556df8630, type=RESET_TYPE_COLD) at ../../hw/core/resettable.c:45
>  #8  0x0000555555eef525 in device_cold_reset (dev=0x555556df8630) at ../../hw/core/qdev.c:239
>  #9  0x00005555558931ab in cpu_reset (cpu=0x555556df8630) at ../../hw/core/cpu-common.c:114
>  #10 0x0000555555d1ec6b in ppce500_cpu_reset (opaque=0x555556df8630) at ../../hw/ppc/e500.c:785
>  #11 0x000055555595c410 in legacy_reset_hold (obj=0x555556e6bbc0, type=RESET_TYPE_COLD) at ../../hw/core/reset.c:76
>  #12 0x0000555555ef28f0 in resettable_phase_hold (obj=0x555556e6bbc0, opaque=0x0, type=RESET_TYPE_COLD) at ../../hw/core/resettable.c:162
>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
> target/ppc/cpu_init.c | 3 ---
> 1 file changed, 3 deletions(-)
>
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 062a6e85fb..f987b75c4f 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -7242,9 +7242,6 @@ static void ppc_cpu_reset_hold(Object *obj, ResetType type)
>     if (tcg_enabled()) {
>         cpu_breakpoint_remove_all(cs, BP_CPU);
>         cpu_watchpoint_remove_all(cs, BP_CPU);
> -        if (env->mmu_model != POWERPC_MMU_REAL) {
> -            ppc_tlb_invalidate_all(env);
> -        }
>         pmu_mmcr01a_updated(env);
>     }
>
>
--3866299591-358765520-1740496829=:47077--

