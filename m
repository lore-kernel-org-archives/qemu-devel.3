Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40606C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 12:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9k1s-00046s-Cp; Tue, 29 Apr 2025 08:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1u9k1o-00046V-Se; Tue, 29 Apr 2025 08:25:38 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1u9k1l-0001Pj-Ft; Tue, 29 Apr 2025 08:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=FulfBLl+ryoBJvND2Xguk6hmdm7/JzY6FmhA7EIub6k=; b=P7bOC6ZLZYKAMHf
 YrU1O3CmQYGrLyMxE02eQxFB+rYGvLad0CFBjOgGqyed7S4z7ALirSv+B9+CcTQZ2/AAC5vwxbUsJ
 8Mnw04MForklBltw44GvEy0YavxagJ/zgtObuTd9qY23OnkpofNMv54IiRWtnLcZuiR2DvcdlCjBL
 Xs=;
Date: Tue, 29 Apr 2025 14:26:30 +0200
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 kvm@vger.kernel.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, richard.henderson@linaro.org
Subject: Re: [PATCH 09/13] target/arm/cpu: get endianness from cpu state
Message-ID: <bwdflzaiqdpq33uzowvrgjbha3wye6k74puwur755pq27z67eu@mnc2ze4it5cl>
References: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
 <20250429050010.971128-10-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250429050010.971128-10-pierrick.bouvier@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 29/04/25, Pierrick Bouvier wrote:
> Remove TARGET_BIG_ENDIAN dependency.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  target/arm/cpu.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index e7a15ade8b4..85e886944f6 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -67,6 +67,15 @@ static void arm_cpu_set_pc(CPUState *cs, vaddr value)
>      }
>  }
>  
> +static bool arm_cpu_is_big_endian(CPUState *cs)
> +{
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    CPUARMState *env = &cpu->env;
> +
> +    cpu_synchronize_state(cs);
> +    return arm_cpu_data_is_big_endian(env);
> +}
> +
>  static vaddr arm_cpu_get_pc(CPUState *cs)
>  {
>      ARMCPU *cpu = ARM_CPU(cs);
> @@ -1130,15 +1139,6 @@ static void arm_cpu_kvm_set_irq(void *opaque, int irq, int level)
>  #endif
>  }
>  
> -static bool arm_cpu_virtio_is_big_endian(CPUState *cs)
> -{
> -    ARMCPU *cpu = ARM_CPU(cs);
> -    CPUARMState *env = &cpu->env;
> -
> -    cpu_synchronize_state(cs);
> -    return arm_cpu_data_is_big_endian(env);
> -}
> -
>  #ifdef CONFIG_TCG
>  bool arm_cpu_exec_halt(CPUState *cs)
>  {
> @@ -1203,7 +1203,7 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
>  
>      info->endian = BFD_ENDIAN_LITTLE;
>      if (bswap_code(sctlr_b)) {
> -        info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
> +        info->endian = arm_cpu_is_big_endian(cpu) ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
>      }

I'm not the most familiar with arm but as far as I can tell these are
not equivalent. My understanding is that arm_cpu_is_big_endian() models
data endianness, and TARGET_BIG_ENDIAN instruction endianness.

Also, for user mode where this branch is relevant, bswap_code() still
depends on TARGET_BIG_ENDIAN anyway and the above branch would reduce to
(on arm32)

  if (TARGET_BIG_ENDIAN ^ sctlr_b) {
      info->endian = sctlr_b ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
  }

giving the opposite result to the original code.

-- 
Anton Johansson
rev.ng Labs Srl.

