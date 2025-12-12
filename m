Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4A2D44166
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 10:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU0VZ-0005nm-Pv; Fri, 12 Dec 2025 05:36:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vU0VL-0005he-8l
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 05:36:13 -0500
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vU0VJ-0003lk-8n
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 05:36:07 -0500
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-6455a60c11fso40719d50.2
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 02:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765535762; x=1766140562; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MVaEqJNoWHJldDXQYgvMqfSKVivAaMUvCAu099xaxUU=;
 b=px1x9aE2IptkSfPNbkzimZQC5WpX3DXJSVu/4OIuTPi8VRKk6895FSn9VtpM8hdsEs
 FsQYoDwlBpw8SrhfIIl+geJbLfRjAe8MM2Xv8pfNKJkHaFuuG2ySs9Qfyx3LkWgWsCu8
 ej70wysyXzJZu1FjeozdLEpsADZiBgV8Wr+pHuEbMPaaV07QEVw72FW235s8Xf+bFO9T
 LECH0pmKHtmsjJKynbl0MZzMlkbxF5XB5JzEy6kUvu3iBu1P/pUDV7b/bBwqjGyuCKJe
 VJqLfnar+IJ7UiClXpiYWA0rQ0zcyj6cHVTIS2lc6xE+THyodqge7wrYnV1B6OCfn4f1
 J4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765535762; x=1766140562;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MVaEqJNoWHJldDXQYgvMqfSKVivAaMUvCAu099xaxUU=;
 b=L76TQzvt4W5EJ3Eei4hzb+6K2NQlLdd0H0PdAWCHYaKC43O3GilsKrlPul9r+h28Oe
 xi+qJb/fHWuqOv59bcmHGjopaj2DFV4ca8xsgdEZ+75YSBm3p7plVflTG9wplY462Odd
 m6ypD2aGSalT0iXP3MnNIG1x9wmiBXc+icA3NZfDT9O9j0BC8MMvIKDtEKSbihiFTYB0
 vAMv+S7WFyfKbRwm12JDcKubbq735QPoa/jEV8Z78aIrK3NV9j8QqFHPnVSRZ13gmUg7
 vcVB1vkra0AJEpZzVLmNMCyLRDaIvxzKVM0MC603EtdQl/Pr+6wCVExibyBKwWcRgaqr
 9Oyw==
X-Gm-Message-State: AOJu0Yz/Y8dUjY3Whzm2r5VRWj3FzyiFKGGGIbj6oU89jMu0bOfGK6+z
 d3KSzk0RQgSnkryxV4GnobbfUc9O9HVqayfSeYkEx1ZmjonZX0CYeeYDAxSnk1MaNESgxs/Uley
 +1zuyssyycbl8NhkptdWJFaVTfsr/Z6ikUBi6rgmjLQ==
X-Gm-Gg: AY/fxX5pdJduGPxX/y2AmExN5L3XgnMuEr+inHNNz13oJ2I+pSKkpvEPrqdFkCe0FBl
 ZB0U0H+ZcbCpqHQIp7fsaIx1RI+y2lsut6ZZr0d/4ECQQa11bLYmaYaevB08MS/YtW43HZaMUXB
 4qNRXxnfPHNyStk15/MGvF8DYhkosVz/UPFa0+B9cC+chtoSngXIDP8GgF4BKwjYf7Hlz3K9ufx
 0dOyoK2hWBGv7Kdpd+D9jJ5ZW3VjBDaNRPwoIGHBYjlnMK9AODbtuK4EjtrLQs4BTppeNiH
X-Google-Smtp-Source: AGHT+IE9uPGbAP8yStN0BATMFYew9/wc1eAKy+mHpEcyndobabsrAZPzxZKiFFQLBPbkumGYbSFGDjmbklPgGZ+BGEc=
X-Received: by 2002:a05:690e:118b:b0:644:4259:9b71 with SMTP id
 956f58d0204a3-64555664c6dmr804284d50.65.1765535761405; Fri, 12 Dec 2025
 02:36:01 -0800 (PST)
MIME-Version: 1.0
References: <20251211234426.2403792-1-pierrick.bouvier@linaro.org>
 <20251211234426.2403792-3-pierrick.bouvier@linaro.org>
In-Reply-To: <20251211234426.2403792-3-pierrick.bouvier@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Dec 2025 10:35:50 +0000
X-Gm-Features: AQt7F2p9FH6d43ZMGz76b3xLcfzcGgSD-yEbBD0OnN9vSDk-HxrqSMOE0YDa7BM
Message-ID: <CAFEAcA-G0QchOw_zXNwUq3KAAKJZggnpeXkt7ePBAUa1SD1P2Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/arm/ptw: make granule_protection_check usable
 without a cpu
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org, 
 Tao Tang <tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 11 Dec 2025 at 23:44, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> By removing cpu details and use a config struct, we can use the
> same granule_protection_check with other devices, like SMMU.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

I'm not 100% sure about this approach, mainly because for SMMU
so far we have taken the route of having its page table
walk implementation be completely separate from the one in
the MMU, even though it's pretty similar: the spec for
CPU page table walk and the one for SMMU page table walk
are technically in different documents and don't necessarily
proceed 100% in sync. Still, the function is a pretty big
one and our other option would probably end up being
copy-and-paste, which isn't very attractive.

So my comments below are minor things.

> ---
>  target/arm/cpu.h | 14 ++++++++++++++
>  target/arm/ptw.c | 41 ++++++++++++++++++++++++-----------------
>  2 files changed, 38 insertions(+), 17 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index efbef0341da..38cc5823a93 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1216,6 +1216,20 @@ void arm_v7m_cpu_do_interrupt(CPUState *cpu);
>
>  hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
>                                           MemTxAttrs *attrs);
> +
> +typedef struct ARMGranuleProtectionConfig {
> +    uint64_t gpccr;
> +    uint64_t gptbr;
> +    uint8_t parange;
> +    bool support_sel2;
> +    AddressSpace *as_secure;
> +} ARMGranuleProtectionConfig;
> +
> +bool arm_granule_protection_check(ARMGranuleProtectionConfig config,
> +                                  uint64_t paddress,
> +                                  ARMSecuritySpace pspace,
> +                                  ARMSecuritySpace ss,
> +                                  ARMMMUFaultInfo *fi);

Could we have a doc comment for these prototypes, please?

>  #endif /* !CONFIG_USER_ONLY */
>
>  int arm_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 2e6b149b2d1..2b620b03014 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -330,24 +330,23 @@ static bool regime_translation_disabled(CPUARMState *env, ARMMMUIdx mmu_idx,
>      return (regime_sctlr(env, mmu_idx) & SCTLR_M) == 0;
>  }
>
> -static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
> -                                     ARMSecuritySpace pspace,
> -                                     ARMSecuritySpace ss,
> -                                     ARMMMUFaultInfo *fi)
> +bool arm_granule_protection_check(ARMGranuleProtectionConfig config,
> +                                  uint64_t paddress,
> +                                  ARMSecuritySpace pspace,
> +                                  ARMSecuritySpace ss,
> +                                  ARMMMUFaultInfo *fi)
>  {

A comment here noting that we share this function with the SMMU
would probably help us in avoiding inadvertently introducing
CPU-specifics in future.

>      MemTxAttrs attrs = {
>          .secure = true,
>          .space = ARMSS_Root,
>      };
> -    ARMCPU *cpu = env_archcpu(env);
> -    uint64_t gpccr = env->cp15.gpccr_el3;
> +    const uint64_t gpccr = config.gpccr;
>      unsigned pps, pgs, l0gptsz, level = 0;
>      uint64_t tableaddr, pps_mask, align, entry, index;
> -    AddressSpace *as;
>      MemTxResult result;
>      int gpi;
>
> -    if (!FIELD_EX64(gpccr, GPCCR, GPC)) {
> +    if (!FIELD_EX64(config.gpccr, GPCCR, GPC)) {

We just set up the 'gpccr' local so we don't need to change this line,
I think ?

Also, the SMMU's SMMU_ROOT_GPT_BASE_CFG does not have the GPC field
(it keeps its enable bit elsewhere).

>          return true;
>      }
>
> @@ -362,7 +361,7 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
>       * physical address size is invalid.
>       */
>      pps = FIELD_EX64(gpccr, GPCCR, PPS);
> -    if (pps > FIELD_EX64_IDREG(&cpu->isar, ID_AA64MMFR0, PARANGE)) {
> +    if (pps > config.parange) {
>          goto fault_walk;
>      }
>      pps = pamax_map[pps];
> @@ -432,7 +431,7 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
>      }
>
>      /* GPC Priority 4: the base address of GPTBR_EL3 exceeds PPS. */
> -    tableaddr = env->cp15.gptbr_el3 << 12;
> +    tableaddr = config.gptbr << 12;
>      if (tableaddr & ~pps_mask) {
>          goto fault_size;
>      }
> @@ -446,12 +445,10 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
>      align = MAKE_64BIT_MASK(0, align);
>      tableaddr &= ~align;
>
> -    as = arm_addressspace(env_cpu(env), attrs);
> -
>      /* Level 0 lookup. */
>      index = extract64(paddress, l0gptsz, pps - l0gptsz);
>      tableaddr += index * 8;
> -    entry = address_space_ldq_le(as, tableaddr, attrs, &result);
> +    entry = address_space_ldq_le(config.as_secure, tableaddr, attrs, &result);

as_secure is an odd name for the AS here, because architecturally
GPT walks are done to the Root physical address space. (This is
why in the current code we set attrs.space to ARMSS_Root and then
get the QEMU AddressSpace corresponding to those attrs. It happens
that at the moment that's the same one we use as Secure, but in
theory we could have 4 completely separate ones for NS, S, Root
and Realm.)

>      if (result != MEMTX_OK) {
>          goto fault_eabt;
>      }
> @@ -479,7 +476,7 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
>      level = 1;
>      index = extract64(paddress, pgs + 4, l0gptsz - pgs - 4);
>      tableaddr += index * 8;
> -    entry = address_space_ldq_le(as, tableaddr, attrs, &result);
> +    entry = address_space_ldq_le(config.as_secure, tableaddr, attrs, &result);
>      if (result != MEMTX_OK) {
>          goto fault_eabt;
>      }
> @@ -513,7 +510,7 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
>      case 0b1111: /* all access */
>          return true;
>      case 0b1000: /* secure */
> -        if (!cpu_isar_feature(aa64_sel2, cpu)) {
> +        if (!config.support_sel2) {
>              goto fault_walk;
>          }
>          /* fall through */
> @@ -3786,8 +3783,18 @@ static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
>                              memop, result, fi)) {
>          return true;
>      }
> -    if (!granule_protection_check(env, result->f.phys_addr,
> -                                  result->f.attrs.space, ptw->in_space, fi)) {
> +
> +    ARMCPU *cpu = env_archcpu(env);
> +    struct ARMGranuleProtectionConfig gpc = {
> +        .gpccr = env->cp15.gpccr_el3,
> +        .gptbr = env->cp15.gptbr_el3,
> +        .parange = FIELD_EX64_IDREG(&cpu->isar, ID_AA64MMFR0, PARANGE),
> +        .support_sel2 = cpu_isar_feature(aa64_sel2, cpu),
> +        .as_secure = cpu_get_address_space(env_cpu(env), ARMASIdx_S)

Directly coding ARMASIDx_S here is a bit awkward, as noted above.

> +    };
> +    if (!arm_granule_protection_check(gpc, result->f.phys_addr,
> +                                      result->f.attrs.space, ptw->in_space,
> +                                      fi)) {
>          fi->type = ARMFault_GPCFOnOutput;
>          return true;
>      }

thanks
-- PMM

