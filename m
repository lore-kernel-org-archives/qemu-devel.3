Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BEBC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 11:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1MNc-000840-SA; Tue, 01 Sep 2026 07:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x1MNb-00083k-Jm
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 07:10:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x1MNZ-0003Qi-3p
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 07:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788261012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dLMTZB5ZFpjV1BdeqOefWic3n4bWtticW+r6wUXOh5A=;
 b=DNtUL6Hh/ht6/qRfR2+56KeLqSAf7VrNDkhgudPvkdljX8XdOsU+92fKcYVAwDWxoVW00F
 ck5PzL0wywbB/aGyjzDQq587w5Xlu3PSUR/O848RzrB3K/DOOG0GavGTj1mNVxukVo/wR4
 6ryTy8R/ZIxVT6DMoQu1ukcfJIM16IQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-fRc271XBOHyPCaX1LnPh8w-1; Tue,
 01 Sept 2026 07:10:08 -0400
X-MC-Unique: fRc271XBOHyPCaX1LnPh8w-1
X-Mimecast-MFC-AGG-ID: fRc271XBOHyPCaX1LnPh8w_1788261003
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA4A0184B384; Tue,  1 Sep 2026 11:10:01 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 24A8018005AD; Tue,  1 Sep 2026 11:09:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 21/21] accel/tcg: Constify @cpu in cpu_mmu_index()
 and TCGCPUOps handlers
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Michael Rolnik <mrolnik@gmail.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Helge Deller <deller@gmx.de>, Song Gao <17746591750@163.com>, 
 Bibo Mao <maobibo@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>, 
 Laurent Vivier <laurent@vivier.eu>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
In-Reply-To: <20260901095229.72018-22-philmd@oss.qualcomm.com>
References: <20260901095229.72018-1-philmd@oss.qualcomm.com>
 <20260901095229.72018-22-philmd@oss.qualcomm.com>
Date: Tue, 01 Sep 2026 15:09:56 +0400
Message-Id: <178826099688.50872.3562022774061385831.b4-reply@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=16239;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=1Eorb054cqkHuwc/3wWC3McCt+JAymfcHFqNDlSnv5g=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqlrKFjALoxL4u/cHqpWy5YJJyrzgd+2SCsUSMz
 gf5SqF/tRqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapayhQAKCRDa6OEJdZac
 5ZlBEACV7wpukO63ZlfyIM970UYIsPV5zKoNYPHXyapkrS+KrDwGwpmYjiaTdfNp9YRU6twGEb4
 +q5/RdXJqeKvUwZeS+zcvnlu/e6+tGyER5K67Z0hnziyQvUPNRM2cHsKC8UWsjgUJ14R77+nSJ9
 38WMTXmDKzeNy9lGcegSIEPSZP6QtJjLkzhtcwSQvBL6McesRX6ZxjSuJDztabqu1jbur8Idsqi
 ScJp1WdX7JsqWp0V8quXJaLOCcYIY0cObUbspZQYZdxoXMlz6U8hcGIAeRAy5GO6yuO1zMhsU+O
 uF3ltyxCnlou/jWUnma7EREUNaOV/8XcqXvi3Gol1T9PzdxkXxCgL3r7U70e0r79JuHqSOSaUjj
 fdPnEWck/f9kzlhGskq4obEm/8HHbI4hTRvDzmUGeSaYpayWTqRzu50puUx4wGSHOmLh33C/vTI
 3pgsm3qEQx/F1fUvwysu61+lEIBsPSX9nS/p7/XHYmMEoCfGKiaeqDfv3UZdNeOWTrM0V/pkRpy
 UJx5wJdqnTxZ+zqS8OI3TYJZhMgi3Z3JYR2NXP479y1u9mXK64uevjXb4GZiR7XZmeI1H6NCCHK
 5I5+Qu0bCeB4ywglC2KMo73EixGF3iH9rBJCdipcBJ4JFq5rmmQ/yY6ST2toiP6WLopG4n0mioa
 oT0G1z696d9scQw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2026-09-01 11:52 +0200, Philippe Mathieu-Daudé wrote:
> All functions called by cpu_mmu_index() take a const
> @cpu argument. Propagate the constness to the caller
> (CPU state should not mutate when resolving the MMU
> index of the current translation regime).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

> ---
>  include/accel/tcg/cpu-mmu-index.h | 2 +-
>  include/accel/tcg/cpu-ops.h       | 2 +-
>  target/alpha/cpu.h                | 2 +-
>  target/arm/internals.h            | 4 ++--
>  target/i386/tcg/tcg-cpu.h         | 2 +-
>  target/ppc/cpu.h                  | 2 +-
>  target/s390x/cpu.h                | 2 +-
>  target/alpha/cpu.c                | 2 +-
>  target/arm/cpu.c                  | 2 +-
>  target/avr/cpu.c                  | 2 +-
>  target/hexagon/cpu.c              | 6 +++---
>  target/hppa/cpu.c                 | 4 ++--
>  target/i386/tcg/tcg-cpu.c         | 6 +++---
>  target/loongarch/tcg/tcg_cpu.c    | 4 ++--
>  target/m68k/cpu.c                 | 2 +-
>  target/microblaze/cpu.c           | 6 +++---
>  target/mips/cpu.c                 | 2 +-
>  target/or1k/cpu.c                 | 4 ++--
>  target/ppc/cpu_init.c             | 2 +-
>  target/riscv/tcg/tcg-cpu.c        | 2 +-
>  target/rx/cpu.c                   | 2 +-
>  target/s390x/cpu.c                | 2 +-
>  target/sh4/cpu.c                  | 4 ++--
>  target/sparc/cpu.c                | 4 ++--
>  target/tricore/cpu.c              | 2 +-
>  target/xtensa/cpu.c               | 2 +-
>  26 files changed, 38 insertions(+), 38 deletions(-)
> 
> diff --git a/include/accel/tcg/cpu-mmu-index.h b/include/accel/tcg/cpu-mmu-index.h
> index e0fb6ef91c8..01152075372 100644
> --- a/include/accel/tcg/cpu-mmu-index.h
> +++ b/include/accel/tcg/cpu-mmu-index.h
> @@ -30,7 +30,7 @@
>   * Return the core mmu index for the current translation regime.
>   * This function is used by generic TCG code paths.
>   */
> -static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
> +static inline int cpu_mmu_index(const CPUState *cs, bool ifetch)
>  {
>  #ifdef COMPILING_PER_TARGET
>  # ifdef CONFIG_USER_ONLY
> diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
> index a88cc4dc572..69d7ec29115 100644
> --- a/include/accel/tcg/cpu-ops.h
> +++ b/include/accel/tcg/cpu-ops.h
> @@ -102,7 +102,7 @@ struct TCGCPUOps {
>      void (*debug_excp_handler)(CPUState *cpu);
>  
>      /** @mmu_index: Callback for choosing softmmu mmu index */
> -    int (*mmu_index)(CPUState *cpu, bool ifetch);
> +    int (*mmu_index)(const CPUState *cpu, bool ifetch);
>  
>  #ifdef CONFIG_USER_ONLY
>      /**
> diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
> index 378bd96d941..1c9f9fce20b 100644
> --- a/target/alpha/cpu.h
> +++ b/target/alpha/cpu.h
> @@ -383,7 +383,7 @@ enum {
>  
>  #define TB_FLAG_UNALIGN       (1u << 1)
>  
> -static inline int alpha_env_mmu_index(CPUAlphaState *env)
> +static inline int alpha_env_mmu_index(const CPUAlphaState *env)
>  {
>      int ret = env->flags & ENV_FLAG_PS_USER ? MMU_USER_IDX : MMU_KERNEL_IDX;
>      if (env->flags & ENV_FLAG_PAL_MODE) {
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index f1a80c890ee..d582cefcfa4 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -55,7 +55,7 @@ static inline MemOp mo_endian(const CPUARMState *env)
>      return EX_TBFLAG_ANY(env->hflags, BE_DATA) ? MO_BE : MO_LE;
>  }
>  
> -static inline int arm_env_mmu_index(CPUARMState *env)
> +static inline int arm_env_mmu_index(const CPUARMState *env)
>  {
>      return EX_TBFLAG_ANY(env->hflags, MMUIDX);
>  }
> @@ -431,7 +431,7 @@ void arm_restore_state_to_opc(CPUState *cs,
>  #ifdef CONFIG_TCG
>  TCGTBCPUState arm_get_tb_cpu_state(CPUState *cs);
>  void arm_cpu_synchronize_from_tb(CPUState *cs, const TranslationBlock *tb);
> -int arm_cpu_mmu_index(CPUState *cs, bool ifetch);
> +int arm_cpu_mmu_index(const CPUState *cs, bool ifetch);
>  #endif /* CONFIG_TCG */
>  
>  typedef enum ARMFPRounding {
> diff --git a/target/i386/tcg/tcg-cpu.h b/target/i386/tcg/tcg-cpu.h
> index 85bcd61678f..1127861e337 100644
> --- a/target/i386/tcg/tcg-cpu.h
> +++ b/target/i386/tcg/tcg-cpu.h
> @@ -82,6 +82,6 @@ extern const TCGCPUOps x86_tcg_ops;
>  
>  bool tcg_cpu_realizefn(CPUState *cs, Error **errp);
>  
> -int x86_mmu_index_pl(CPUX86State *env, unsigned pl);
> +int x86_mmu_index_pl(const CPUX86State *env, unsigned pl);
>  
>  #endif /* TCG_CPU_H */
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 3fb51bbeb82..56264752c1b 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1736,7 +1736,7 @@ int ppc_dcr_write(ppc_dcr_t *dcr_env, int dcrn, uint32_t val);
>  
>  /* MMU modes definitions */
>  #define MMU_USER_IDX 0
> -static inline int ppc_env_mmu_index(CPUPPCState *env, bool ifetch)
> +static inline int ppc_env_mmu_index(const CPUPPCState *env, bool ifetch)
>  {
>  #ifdef CONFIG_USER_ONLY
>      return MMU_USER_IDX;
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 998bbb0d7ff..cd5f9256b24 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -373,7 +373,7 @@ QEMU_BUILD_BUG_ON(FLAG_MASK_DAT != PSW_MASK_DAT >> FLAG_MASK_PSW_SHIFT);
>  #define MMU_HOME_IDX            2
>  #define MMU_REAL_IDX            3
>  
> -static inline int s390x_env_mmu_index(CPUS390XState *env, bool ifetch)
> +static inline int s390x_env_mmu_index(const CPUS390XState *env, bool ifetch)
>  {
>  #ifdef CONFIG_USER_ONLY
>      return MMU_USER_IDX;
> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
> index 21d4f8ac23b..3bf88702dc1 100644
> --- a/target/alpha/cpu.c
> +++ b/target/alpha/cpu.c
> @@ -93,7 +93,7 @@ static bool alpha_cpu_has_work(const CPUState *cs)
>  }
>  #endif /* !CONFIG_USER_ONLY */
>  
> -static int alpha_cpu_mmu_index(CPUState *cs, bool ifetch)
> +static int alpha_cpu_mmu_index(const CPUState *cs, bool ifetch)
>  {
>      return alpha_env_mmu_index(cpu_env(cs));
>  }
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index ba66359d410..63ef00735ca 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -126,7 +126,7 @@ void arm_restore_state_to_opc(CPUState *cs,
>      }
>  }
>  
> -int arm_cpu_mmu_index(CPUState *cs, bool ifetch)
> +int arm_cpu_mmu_index(const CPUState *cs, bool ifetch)
>  {
>      return arm_env_mmu_index(cpu_env(cs));
>  }
> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> index a96bef46ff1..24a5a9debc9 100644
> --- a/target/avr/cpu.c
> +++ b/target/avr/cpu.c
> @@ -50,7 +50,7 @@ static bool avr_cpu_has_work(const CPUState *cs)
>              && cpu_interrupts_enabled(cpu_env(cs));
>  }
>  
> -static int avr_cpu_mmu_index(CPUState *cs, bool ifetch)
> +static int avr_cpu_mmu_index(const CPUState *cs, bool ifetch)
>  {
>      return ifetch ? MMU_CODE_IDX : MMU_DATA_IDX;
>  }
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 868aef0cde4..2bc58fc6305 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -482,11 +482,11 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
>      mcc->parent_realize(dev, errp);
>  }
>  
> -static int hexagon_cpu_mmu_index(CPUState *cs, bool ifetch)
> +static int hexagon_cpu_mmu_index(const CPUState *cs, bool ifetch)
>  {
>  #ifndef CONFIG_USER_ONLY
> -    CPUHexagonState *env = cpu_env(cs);
> -    HexagonCPU *cpu = HEXAGON_CPU(cs);
> +    const CPUHexagonState *env = cpu_env(cs);
> +    const HexagonCPU *cpu = HEXAGON_CPU(cs);
>      int cpu_mode;
>  
>      BQL_LOCK_GUARD();
> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index dbf58466c24..ec351302406 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -140,9 +140,9 @@ static bool hppa_cpu_has_work(const CPUState *cs)
>  }
>  #endif /* !CONFIG_USER_ONLY */
>  
> -static int hppa_cpu_mmu_index(CPUState *cs, bool ifetch)
> +static int hppa_cpu_mmu_index(const CPUState *cs, bool ifetch)
>  {
> -    CPUHPPAState *env = cpu_env(cs);
> +    const CPUHPPAState *env = cpu_env(cs);
>  
>      if (env->psw & (ifetch ? PSW_C : PSW_D)) {
>          return PRIV_P_TO_MMU_IDX(env->iaoq_f & 3, env->psw & PSW_P);
> diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
> index e4fc212aca5..da1498ee45d 100644
> --- a/target/i386/tcg/tcg-cpu.c
> +++ b/target/i386/tcg/tcg-cpu.c
> @@ -114,7 +114,7 @@ static void x86_restore_state_to_opc(CPUState *cs,
>      }
>  }
>  
> -int x86_mmu_index_pl(CPUX86State *env, unsigned pl)
> +int x86_mmu_index_pl(const CPUX86State *env, unsigned pl)
>  {
>      int mmu_index_32 = (env->hflags & HF_CS64_MASK) ? 0 : 1;
>      int mmu_index_base =
> @@ -125,9 +125,9 @@ int x86_mmu_index_pl(CPUX86State *env, unsigned pl)
>      return mmu_index_base + mmu_index_32;
>  }
>  
> -static int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
> +static int x86_cpu_mmu_index(const CPUState *cs, bool ifetch)
>  {
> -    CPUX86State *env = cpu_env(cs);
> +    const CPUX86State *env = cpu_env(cs);
>      return x86_mmu_index_pl(env, env->hflags & HF_CPL_MASK);
>  }
>  
> diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
> index 7ea2a1eb933..a26233d5eed 100644
> --- a/target/loongarch/tcg/tcg_cpu.c
> +++ b/target/loongarch/tcg/tcg_cpu.c
> @@ -301,9 +301,9 @@ static void loongarch_restore_state_to_opc(CPUState *cs,
>      set_pc(cpu_env(cs), data[0]);
>  }
>  
> -static int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch)
> +static int loongarch_cpu_mmu_index(const CPUState *cs, bool ifetch)
>  {
> -    CPULoongArchState *env = cpu_env(cs);
> +    const CPULoongArchState *env = cpu_env(cs);
>      CPUSysState *sys = env_sys(env);
>  
>      if (FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PG)) {
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index da3681fab1f..f1fd2e6f14d 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -82,7 +82,7 @@ static bool m68k_cpu_has_work(const CPUState *cs)
>  }
>  #endif /* !CONFIG_USER_ONLY */
>  
> -static int m68k_cpu_mmu_index(CPUState *cs, bool ifetch)
> +static int m68k_cpu_mmu_index(const CPUState *cs, bool ifetch)
>  {
>      return cpu_env(cs)->sr & SR_S ? MMU_KERNEL_IDX : MMU_USER_IDX;
>  }
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index d1d2f0ec7e3..524175d2236 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -133,10 +133,10 @@ static bool mb_cpu_has_work(const CPUState *cs)
>  }
>  #endif /* !CONFIG_USER_ONLY */
>  
> -static int mb_cpu_mmu_index(CPUState *cs, bool ifetch)
> +static int mb_cpu_mmu_index(const CPUState *cs, bool ifetch)
>  {
> -    CPUMBState *env = cpu_env(cs);
> -    MicroBlazeCPU *cpu = env_archcpu(env);
> +    const CPUMBState *env = cpu_env(cs);
> +    const MicroBlazeCPU *cpu = env_archcpu(env);
>  
>      /* Are we in nommu mode?.  */
>      if (!(env->msr & MSR_VM) || !cpu->cfg.use_mmu) {
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index 0f39f8fe0a5..a428176d9e8 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -671,7 +671,7 @@ static const Property mips_cpu_properties[] = {
>  #ifdef CONFIG_TCG
>  #include "accel/tcg/cpu-ops.h"
>  
> -static int mips_cpu_mmu_index(CPUState *cs, bool ifunc)
> +static int mips_cpu_mmu_index(const CPUState *cs, bool ifunc)
>  {
>      return mips_env_mmu_index(cpu_env(cs));
>  }
> diff --git a/target/or1k/cpu.c b/target/or1k/cpu.c
> index 10b13ae69cd..c9ab5c0f1c1 100644
> --- a/target/or1k/cpu.c
> +++ b/target/or1k/cpu.c
> @@ -82,9 +82,9 @@ static bool openrisc_cpu_has_work(const CPUState *cs)
>  }
>  #endif /* !CONFIG_USER_ONLY */
>  
> -static int openrisc_cpu_mmu_index(CPUState *cs, bool ifetch)
> +static int openrisc_cpu_mmu_index(const CPUState *cs, bool ifetch)
>  {
> -    CPUOpenRISCState *env = cpu_env(cs);
> +    const CPUOpenRISCState *env = cpu_env(cs);
>  
>      if (env->sr & (ifetch ? SR_IME : SR_DME)) {
>          /* The mmu is enabled; test supervisor state.  */
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index c72a7168a23..a33a074b796 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -7215,7 +7215,7 @@ static void ppc_restore_state_to_opc(CPUState *cs,
>      cpu->env.nip = data[0];
>  }
>  
> -static int ppc_cpu_mmu_index(CPUState *cs, bool ifetch)
> +static int ppc_cpu_mmu_index(const CPUState *cs, bool ifetch)
>  {
>      return ppc_env_mmu_index(cpu_env(cs), ifetch);
>  }
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index cd303660f1f..a0210ca50e3 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -95,7 +95,7 @@ static const char *cpu_priv_ver_to_str(int priv_ver)
>      return priv_spec_str;
>  }
>  
> -static int riscv_cpu_mmu_index(CPUState *cs, bool ifetch)
> +static int riscv_cpu_mmu_index(const CPUState *cs, bool ifetch)
>  {
>      return riscv_env_mmu_index(cpu_env(cs), ifetch);
>  }
> diff --git a/target/rx/cpu.c b/target/rx/cpu.c
> index dfa09a85bce..c5dfba8976a 100644
> --- a/target/rx/cpu.c
> +++ b/target/rx/cpu.c
> @@ -78,7 +78,7 @@ static bool rx_cpu_has_work(const CPUState *cs)
>      return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR);
>  }
>  
> -static int rx_cpu_mmu_index(CPUState *cs, bool ifunc)
> +static int rx_cpu_mmu_index(const CPUState *cs, bool ifunc)
>  {
>      return 0;
>  }
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index c34f4b23472..a043f1e7920 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -311,7 +311,7 @@ static const Property s390x_cpu_properties[] = {
>  #include "accel/tcg/cpu-ops.h"
>  #include "tcg/tcg_s390x.h"
>  
> -static int s390x_cpu_mmu_index(CPUState *cs, bool ifetch)
> +static int s390x_cpu_mmu_index(const CPUState *cs, bool ifetch)
>  {
>      return s390x_env_mmu_index(cpu_env(cs), ifetch);
>  }
> diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
> index b0ed356d0f7..f8b33844d2a 100644
> --- a/target/sh4/cpu.c
> +++ b/target/sh4/cpu.c
> @@ -113,9 +113,9 @@ static bool superh_cpu_has_work(const CPUState *cs)
>  }
>  #endif /* !CONFIG_USER_ONLY */
>  
> -static int sh4_cpu_mmu_index(CPUState *cs, bool ifetch)
> +static int sh4_cpu_mmu_index(const CPUState *cs, bool ifetch)
>  {
> -    CPUSH4State *env = cpu_env(cs);
> +    const CPUSH4State *env = cpu_env(cs);
>  
>      /*
>       * The instruction in a RTE delay slot is fetched in privileged mode,
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index 8dd9b0d5ee3..f1ae16c91e9 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -790,9 +790,9 @@ static bool sparc_cpu_has_work(const CPUState *cs)
>  }
>  #endif /* !CONFIG_USER_ONLY */
>  
> -static int sparc_cpu_mmu_index(CPUState *cs, bool ifetch)
> +static int sparc_cpu_mmu_index(const CPUState *cs, bool ifetch)
>  {
> -    CPUSPARCState *env = cpu_env(cs);
> +    const CPUSPARCState *env = cpu_env(cs);
>  
>  #ifndef TARGET_SPARC64
>      if ((env->mmuregs[0] & MMU_E) == 0) { /* MMU disabled */
> diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
> index 357f3737053..09d4270df60 100644
> --- a/target/tricore/cpu.c
> +++ b/target/tricore/cpu.c
> @@ -117,7 +117,7 @@ static bool tricore_cpu_has_work(const CPUState *cs)
>      return true;
>  }
>  
> -static int tricore_cpu_mmu_index(CPUState *cs, bool ifetch)
> +static int tricore_cpu_mmu_index(const CPUState *cs, bool ifetch)
>  {
>      return 0;
>  }
> diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
> index 1b299568776..8cf973632e7 100644
> --- a/target/xtensa/cpu.c
> +++ b/target/xtensa/cpu.c
> @@ -148,7 +148,7 @@ static bool xtensa_cpu_has_work(const CPUState *cs)
>  }
>  #endif /* !CONFIG_USER_ONLY */
>  
> -static int xtensa_cpu_mmu_index(CPUState *cs, bool ifetch)
> +static int xtensa_cpu_mmu_index(const CPUState *cs, bool ifetch)
>  {
>      return xtensa_get_cring(cpu_env(cs));
>  }
> -- 
> 2.53.0
> 
> 
> 



