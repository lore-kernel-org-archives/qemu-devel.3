Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA05C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2m6-0003cu-Eb; Thu, 20 Aug 2026 09:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wx2m4-0003aD-EZ
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:25:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wx2m1-0003u1-Uc
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787232337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G4uNuyJwqSntO8liZDsT9AxHNVsfYMVt+Zn1mb+jg5Y=;
 b=RoixKnHD89sq5ywOtX+32YkDIYZVkiOnHNFiMQkAMnw/69bd/c85YTDdgDQZacKLMLuRCc
 odoFYPSUhe0voVTwSe8ahtGcUfdsvDjekRol+fmCVsSH7CFhx71P6iWB0ok/mfSGAus3JO
 JwNdsnC5jZqo4GLvQcFbKcUxkJdRxPI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-5zwJ7JTePae7Q_-G1AVcWQ-1; Thu,
 20 Aug 2026 09:25:33 -0400
X-MC-Unique: 5zwJ7JTePae7Q_-G1AVcWQ-1
X-Mimecast-MFC-AGG-ID: 5zwJ7JTePae7Q_-G1AVcWQ_1787232327
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A59C1956041; Thu, 20 Aug 2026 13:25:25 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 645A83002D2A; Thu, 20 Aug 2026 13:25:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [RFC PATCH 13/13] cpus: Constify @cpu in
 SysemuCPUOps::has_work() handler
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 qemu-arm@nongnu.org, Michael Rolnik <mrolnik@gmail.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Helge Deller <deller@gmx.de>, Zhao Liu <zhao1.liu@intel.com>, 
 Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>, 
 Xianglai Li <lixianglai@loongson.cn>, Laurent Vivier <laurent@vivier.eu>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>, 
 Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
In-Reply-To: <20260820104730.25462-14-philmd@oss.qualcomm.com>
References: <20260820104730.25462-1-philmd@oss.qualcomm.com>
 <20260820104730.25462-14-philmd@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 17:22:15 +0400
Message-Id: <178723213517.2730041.8745378645612815468.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=12609;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=thqgSDRBVYShVPRi5Wke843ba4uIt1wtRWFSyPhrqrY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhv/r8vGJi4Wt4zkYah570Arb6jY62epXEyQNK
 pGEZuFZHgqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaob/6wAKCRDa6OEJdZac
 5Y19D/4vRxbvSNMvto6c79kENM46KeoH2A8Xj7iGdbGhZacskI9K5dRFVQwSmpKklApu2wuOpno
 6Is4x5w7HAi816/sgJoC6Y9zxQu+5Z3EW2di/VRGTOMvq5lnuvdDrIFkCf1IBu42O0REYv9eCi9
 CfsyM4ruhA6nvYWbmpbDzntLW0kpxHY01mqy7RyFZWRI2QRIpNnbHGtf24UECNwx4GKG80UiozN
 cjLXpHk0uSA1B4ZfST611CvsxPgyF5+0LbXgC4M0xPbKgb1ubjVfyEoJVjRrO8HVUXeyQWu/qPK
 KLCMMUrnVj6JKAe+w79ukXK1BCiM6/kM6nH0w08P8BMJIUgVq7x3k19sjo1hxyDi6bIfP6iNeSk
 7UJIR9++jW+2mPcjN+WDYfiGula34cmvWszfWLSbvyzvq0vRaH3dRwSXDhMVe7du58WJ9rHkWYv
 qV4KJpo9Ecxo0r1ZrNoXuAr/Z4kq3rX+lux39mD+XuBolmHt/Gfft8oTsFhoxI1oX/N+el0unRv
 QOr54CNF6CIJqAkmEfOQBZF+rVmge/3lznYGiAZqQ9iawS5sTqCr72sZ5AJ2JEH9oo1sxG9rblj
 R4DPOHatpN8s9jCOIKu8ftfJezIhlxvlzegrBO3I3hvWHHqZPHGPg0Bw5TBvNsnpYg5vAonT+Ud
 MGb7Hkr5PgVYJsQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> All functions called by target has_work() handler take a const @cpu
> argument. We can now fulfill the comment added in commit c2804566f6
> ("target/arm: do not clear halting reason in has_work helper"),
> qualifying the handler const to denote its idempotency.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Message-ID: <20260820104730.25462-14-philmd@oss.qualcomm.com>
>
> diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
> index 9a45596169a3..095bdcd997aa 100644
> --- a/include/hw/core/sysemu-cpu-ops.h
> +++ b/include/hw/core/sysemu-cpu-ops.h
> @@ -19,10 +19,10 @@ typedef struct SysemuCPUOps {
>      /**
>       * @has_work: Callback for checking if there is work to do.
>       *
> -     * This function should be idempotent (i.e. not change state) as
> +     * This function is idempotent (i.e. not change state) as
>       * it will likely be queried multiple times before a CPU resumes.
>       */
> -    bool (*has_work)(CPUState *cpu); /* MANDATORY NON-NULL */
> +    bool (*has_work)(const CPUState *cpu); /* MANDATORY NON-NULL */
>      /**
>       * @get_memory_mapping: Callback for obtaining the memory mappings.
>       */
> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
> index 12e860216634..991dfd8c38a9 100644
> --- a/target/alpha/cpu.c
> +++ b/target/alpha/cpu.c
> @@ -77,7 +77,7 @@ static void alpha_restore_state_to_opc(CPUState *cs,
>  }
>  
>  #ifndef CONFIG_USER_ONLY
> -static bool alpha_cpu_has_work(CPUState *cs)
> +static bool alpha_cpu_has_work(const CPUState *cs)
>  {
>      /* Here we are checking to see if the CPU should wake up from HALT.
>         We will have gotten into this state only for WTINT from PALmode.  */
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 77aa78f00e2f..7ee701d5d138 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -141,9 +141,9 @@ int arm_cpu_mmu_index(CPUState *cs, bool ifetch)
>   * CPU_INTERRUPT_*NMI anyway. So we might as well accept NMI here
>   * unconditionally.
>   */
> -static bool arm_cpu_has_work(CPUState *cs)
> +static bool arm_cpu_has_work(const CPUState *cs)
>  {
> -    ARMCPU *cpu = ARM_CPU(cs);
> +    const ARMCPU *cpu = ARM_CPU(cs);
>  
>      /*
>       * Only another PSCI call can wake the CPU up in which case the
> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> index f8409f32ab98..00f06d71eaae 100644
> --- a/target/avr/cpu.c
> +++ b/target/avr/cpu.c
> @@ -23,6 +23,7 @@
>  #include "qemu/qemu-print.h"
>  #include "exec/translation-block.h"
>  #include "system/address-spaces.h"
> +#include "hw/core/cpu.h"
>  #include "cpu.h"
>  #include "disas/dis-asm.h"
>  #include "tcg/debug-assert.h"
> @@ -43,10 +44,10 @@ static vaddr avr_cpu_get_pc(CPUState *cs)
>      return cpu->env.pc_w * 2;
>  }
>  
> -static bool avr_cpu_has_work(CPUState *cs)
> +static bool avr_cpu_has_work(const CPUState *cs)
>  {
>      return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_RESET)
> -            && cpu_interrupts_enabled(cpu_env(cs));
> +            && cpu_interrupts_enabled(cpu_env_const(cs));
>  }
>  
>  static int avr_cpu_mmu_index(CPUState *cs, bool ifetch)
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index da11d266c351..3139fcb695de 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -364,9 +364,9 @@ bool hexagon_thread_is_enabled(const CPUHexagonState *env)
>      return E_bit;
>  }
>  
> -static bool hexagon_cpu_has_work(CPUState *cs)
> +static bool hexagon_cpu_has_work(const CPUState *cs)
>  {
> -    CPUHexagonState *env = cpu_env(cs);
> +    const CPUHexagonState *env = cpu_env_const(cs);
>  
>      return hexagon_thread_is_enabled(env) &&
>          (cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_SWI
> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index 07b49e513263..28a1f1143166 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -134,7 +134,7 @@ static void hppa_restore_state_to_opc(CPUState *cs,
>  }
>  
>  #ifndef CONFIG_USER_ONLY
> -static bool hppa_cpu_has_work(CPUState *cs)
> +static bool hppa_cpu_has_work(const CPUState *cs)
>  {
>      return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
>  }
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 8777bcbae858..93b617f94dce 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -10639,7 +10639,7 @@ int x86_cpu_pending_interrupt(const CPUState *cs, int interrupt_request)
>      return 0;
>  }
>  
> -static bool x86_cpu_has_work(CPUState *cs)
> +static bool x86_cpu_has_work(const CPUState *cs)
>  {
>      return x86_cpu_pending_interrupt(cs, cs->interrupt_request) != 0;
>  }
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 82ec35e081fd..4c1aae4fb013 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -96,12 +96,12 @@ bool cpu_loongarch_hw_interrupts_pending(const CPULoongArchState *env)
>  #endif
>  
>  #ifndef CONFIG_USER_ONLY
> -bool loongarch_cpu_has_work(CPUState *cs)
> +bool loongarch_cpu_has_work(const CPUState *cs)
>  {
>      bool has_work = false;
>  
>      if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
> -        cpu_loongarch_hw_interrupts_pending(cpu_env(cs))) {
> +        cpu_loongarch_hw_interrupts_pending(cpu_env_const(cs))) {
>          has_work = true;
>      }
>  
> diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
> index 6a733e6c3a58..d86029bcb31d 100644
> --- a/target/loongarch/internals.h
> +++ b/target/loongarch/internals.h
> @@ -38,7 +38,7 @@ uint64_t cpu_loongarch_get_constant_timer_counter(LoongArchCPU *cpu);
>  uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu);
>  void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
>                                                 uint64_t value);
> -bool loongarch_cpu_has_work(CPUState *cs);
> +bool loongarch_cpu_has_work(const CPUState *cs);
>  bool cpu_loongarch_hw_interrupts_pending(const CPULoongArchState *env);
>  #endif /* !CONFIG_USER_ONLY */
>  
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index 6012dc3186c7..49ef822cbd9a 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -76,7 +76,7 @@ static void m68k_restore_state_to_opc(CPUState *cs,
>  }
>  
>  #ifndef CONFIG_USER_ONLY
> -static bool m68k_cpu_has_work(CPUState *cs)
> +static bool m68k_cpu_has_work(const CPUState *cs)
>  {
>      return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD);
>  }
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 389a5124b124..86692239a1e8 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -127,7 +127,7 @@ static void mb_restore_state_to_opc(CPUState *cs,
>  }
>  
>  #ifndef CONFIG_USER_ONLY
> -static bool mb_cpu_has_work(CPUState *cs)
> +static bool mb_cpu_has_work(const CPUState *cs)
>  {
>      return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
>  }
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index 0fead20d6515..07129731e75c 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -134,9 +134,9 @@ static vaddr mips_cpu_get_pc(CPUState *cs)
>  }
>  
>  #if !defined(CONFIG_USER_ONLY)
> -static bool mips_cpu_has_work(CPUState *cs)
> +static bool mips_cpu_has_work(const CPUState *cs)
>  {
> -    CPUMIPSState *env = cpu_env(cs);
> +    const CPUMIPSState *env = cpu_env_const(cs);
>      bool has_work = false;
>  
>      /*
> diff --git a/target/or1k/cpu.c b/target/or1k/cpu.c
> index 66c00c0930cd..d4d81d0c3512 100644
> --- a/target/or1k/cpu.c
> +++ b/target/or1k/cpu.c
> @@ -76,7 +76,7 @@ static void openrisc_restore_state_to_opc(CPUState *cs,
>  }
>  
>  #ifndef CONFIG_USER_ONLY
> -static bool openrisc_cpu_has_work(CPUState *cs)
> +static bool openrisc_cpu_has_work(const CPUState *cs)
>  {
>      return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_TIMER);
>  }
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index e3a1075aad3f..c5a29cfee856 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -7224,7 +7224,7 @@ static int ppc_cpu_mmu_index(CPUState *cs, bool ifetch)
>  #endif /* CONFIG_TCG */
>  
>  #ifndef CONFIG_USER_ONLY
> -static bool ppc_cpu_has_work(CPUState *cs)
> +static bool ppc_cpu_has_work(const CPUState *cs)
>  {
>      return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD);
>  }
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ab2868dc1e2f..b455b997561d 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -950,7 +950,7 @@ int riscv_cpu_vsirq_pending(const CPURISCVState *env)
>                                      (irqs | irqs_f_vs), env->hviprio);
>  }
>  
> -bool riscv_cpu_has_work(CPUState *cs)
> +bool riscv_cpu_has_work(const CPUState *cs)
>  {
>      RISCVCPU *cpu = RISCV_CPU(cs);
>      CPURISCVState *env = &cpu->env;

I guess you should make them const

> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index 5d84e4de960a..782f12abfaf0 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -203,7 +203,7 @@ static inline target_ulong get_xepc_mask(CPURISCVState *env)
>  
>  #ifndef CONFIG_USER_ONLY
>  /* Our implementation of SysemuCPUOps::has_work */
> -bool riscv_cpu_has_work(CPUState *cs);
> +bool riscv_cpu_has_work(const CPUState *cs);
>  #endif
>  
>  /* Zjpm addr masking routine */
> diff --git a/target/rx/cpu.c b/target/rx/cpu.c
> index 9b8473d71cf6..bc18dd250cf3 100644
> --- a/target/rx/cpu.c
> +++ b/target/rx/cpu.c
> @@ -73,7 +73,7 @@ static void rx_restore_state_to_opc(CPUState *cs,
>      cpu->env.pc = data[0];
>  }
>  
> -static bool rx_cpu_has_work(CPUState *cs)
> +static bool rx_cpu_has_work(const CPUState *cs)
>  {
>      return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR);
>  }
> diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
> index cc9685221ae8..22ed2b097bbd 100644
> --- a/target/s390x/cpu-system.c
> +++ b/target/s390x/cpu-system.c
> @@ -39,7 +39,7 @@
>  #include "system/tcg.h"
>  #include "hw/core/sysemu-cpu-ops.h"
>  
> -bool s390_cpu_has_work(CPUState *cs)
> +bool s390_cpu_has_work(const CPUState *cs)
>  {
>      S390CPU *cpu = S390_CPU(cs);

same

>  
> diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
> index 54b62808d834..00917473a544 100644
> --- a/target/s390x/s390x-internal.h
> +++ b/target/s390x/s390x-internal.h
> @@ -248,7 +248,7 @@ bool s390_cpu_system_realize(DeviceState *dev, Error **errp);
>  void s390_cpu_finalize(Object *obj);
>  void s390_cpu_system_class_init(CPUClass *cc);
>  void s390_cpu_machine_reset_cb(void *opaque);
> -bool s390_cpu_has_work(CPUState *cs);
> +bool s390_cpu_has_work(const CPUState *cs);
>  #endif /* CONFIG_USER_ONLY */
>  
>  
> diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
> index 3bbdee301d5d..36e8b4725aae 100644
> --- a/target/sh4/cpu.c
> +++ b/target/sh4/cpu.c
> @@ -107,7 +107,7 @@ static bool superh_io_recompile_replay_branch(CPUState *cs,
>      return false;
>  }
>  
> -static bool superh_cpu_has_work(CPUState *cs)
> +static bool superh_cpu_has_work(const CPUState *cs)
>  {
>      return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD);
>  }
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index 1bc14b586bb9..0ecb573129b1 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -783,10 +783,10 @@ static void sparc_restore_state_to_opc(CPUState *cs,
>  }
>  
>  #ifndef CONFIG_USER_ONLY
> -static bool sparc_cpu_has_work(CPUState *cs)
> +static bool sparc_cpu_has_work(const CPUState *cs)
>  {
>      return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
> -           cpu_interrupts_enabled(cpu_env(cs));
> +           cpu_interrupts_enabled(cpu_env_const(cs));
>  }
>  #endif /* !CONFIG_USER_ONLY */
>  
> diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
> index dcd5c5065bcd..837ecb9b343f 100644
> --- a/target/tricore/cpu.c
> +++ b/target/tricore/cpu.c
> @@ -111,9 +111,9 @@ static void tricore_cpu_reset_hold(Object *obj, ResetType type)
>      cpu_state_reset(cpu_env(cs));
>  }
>  
> -static bool tricore_cpu_has_work(CPUState *cs)
> +static bool tricore_cpu_has_work(const CPUState *cs)
>  {
> -    return true;
> +    return true; /* XXX */
>  }

Add more explicit FIXME?

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


