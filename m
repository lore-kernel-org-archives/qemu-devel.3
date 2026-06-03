Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C14CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 06:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUemY-0007ho-DT; Wed, 03 Jun 2026 02:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wUemW-0007hW-Sl
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 02:08:48 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wUemT-0008UC-03
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 02:08:48 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bec449d0af2so413395066b.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 23:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1780466923; x=1781071723; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UEPGR2NQtr4xH4ngNkgJ+91XrlvJSr3ME6z/t4Rl/ug=;
 b=RMOWvTIIzPu8LrPN5sN3KZvsq3kK/pUrfz2SPoaocq8qKagPJaaKp3Bk5dEmfCWRHz
 QQO0Y9G5I3WGWgN31v5Lpd3mlPXVZQ0Eim0dWmpfGuTjfgUGjpPA1gZqaDKJ1A93ZVpA
 sFHjG4wh+Fw+Wn4gJxoHW966ELjL0A6HlM6X0/JcGIny5t+EEcfBgSbXYLzZoVQXbiaN
 q2SuXWpQoeDlARWO2QUszzn4wK0rxo2hsGUxahOvhY12cXtgnWhFzPfuZmZ5N75Tnf9A
 giY/mUw0mvSl9hf2uwzfvaEf4vA4Ded4YItX8RRupn2kJVjMmzXmivMqL7iWYyz0CJRr
 XWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780466923; x=1781071723;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UEPGR2NQtr4xH4ngNkgJ+91XrlvJSr3ME6z/t4Rl/ug=;
 b=OZcEkJONZXzh/odsfWz74nFRAymueeeakQ+kEsy8l32N2ZLHK2CZjsl206+MyiO5oa
 kaO6kedrNOymGB6c8kNl/ipoM35IbusiwPErjFQ4Y/nHY4/TNkQNxoj0LmISM2LayOfb
 k7qWVCHumm0Vlr8M95ncpUtaaYrD8LpoLTVpk/AKwF7dguFVAchI7uAW4AQQC2pxbuGA
 MXyUjIR30d4GwKDhsAdK0XzGMatE93dA+JkKQZ2de7cfiLQBwQuhIhNsaedASaKnYO41
 R0pIgw3hNhKwOu5RxWtAsoBzqTUPEmdLMz4lZeQNws1TtOlddxg/aZMUVqsyETPfHLL3
 Pp3g==
X-Gm-Message-State: AOJu0YziG2t23/ATk6TRtCncM5mPglbwj+roYX/mkwbNXP1mktaCki8/
 pkfJp7PLK3bNcQISGVjou7YIgGb54WPYh0j0jUUF64vP4iJVpVBA+P/4HqIqdH0IX89P6UzEPKn
 LgtOhbix4nZr1ZHif7or9Fc8dlxeedjC8aKkEPnhvqihBYs3vdKwWaObN1/kI16+kpwh+9fNNeN
 hrIsTX/CedqTNSizO3Eyo5nOV3g3JdxTG+tkCbp1XCDHs=
X-Gm-Gg: Acq92OE9LxfqAlZ+WrWvgVeDYozjUd7/m0DWnXA6Iw33uTV4u8rIQY6jS3tve4gLTOl
 ja6yUW7Ffn96eRIK6lh5nS0nM2ID/8jloJ+W+WCzvExujJMhWgwAwNomEnEyB9hilG38Nn+PjHI
 25hrIqBMm6dUt0XR09BChu4feybiIBGyhvwZmb0ZOPnBwED7jQOJtGjmf0Qe+17ELpzoldRoPGA
 RfHeZ3+JoAibabxIQUYOHiSttRTlcLnpH8KMzS0rsskA9q/StYnPKrqIqsy92LYctJRf44wnYTJ
 J+gUEu7sB4p/A7UsBs2IM60UnlrMqcabomQfAPpsZISYVJSzvOHcvd5zd0Wg1PfFXS+Zl+NgZ9L
 xZ7dp8enM4gGkk0ofyeOm62z/B+Idgo5+z9l29PkQK8xn0D+eJU2UTcr6SnlfN4srQIlDp+k2il
 1UuLGPTNpqC+ayKeow0Th2wVBus2Gi2dR7X4JeKjbVmzteMwwKOXMLQgLx6pYJ0DIw9CRv2Q4=
X-Received: by 2002:a17:906:d552:b0:bef:1df6:12f2 with SMTP id
 a640c23a62f3a-bf0acf0fa2fmr72813866b.18.1780466922356; 
 Tue, 02 Jun 2026 23:08:42 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com.
 [209.85.208.47]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf055309368sm86038766b.49.2026.06.02.23.08.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2026 23:08:41 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-68d234218bcso6648009a12.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 23:08:41 -0700 (PDT)
X-Received: by 2002:a05:6402:3216:b0:68c:d4e:3a4a with SMTP id
 4fb4d7f45d1cf-68e6f0def90mr709572a12.7.1780466921048; Tue, 02 Jun 2026
 23:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260318185238.99143-1-luisccunha8@gmail.com>
 <20260318185238.99143-2-luisccunha8@gmail.com>
In-Reply-To: <20260318185238.99143-2-luisccunha8@gmail.com>
From: Sifive <jay.chang@sifive.com>
Date: Wed, 3 Jun 2026 14:08:29 +0800
X-Gmail-Original-Message-ID: <CAMXXpfZayOu=98rgBXacB6JNvtErDBpAVU7PaBuKw=236JytEQ@mail.gmail.com>
X-Gm-Features: AVHnY4KH-ipMUt-jWsCKHggpFIhP54nKN8c2iR1nyfQR7ee90m1To8agEBpyk0k
Message-ID: <CAMXXpfZayOu=98rgBXacB6JNvtErDBpAVU7PaBuKw=236JytEQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] target/riscv: Add SPMP infrastructure
To: luisccc <luisccunha8@gmail.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>, frank.chang@sifive.com
Content-Type: multipart/alternative; boundary="0000000000005d0e2406535342f2"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=jay.chang@sifive.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000005d0e2406535342f2
Content-Type: text/plain; charset="UTF-8"

Hi Luisccc,
Thank you for this patch. I have two main questions about the
implementation:

The SPMP CSR write functions don't flush the TLB after modifying entries:
- spmpcfg_csr_write()
- spmpaddr_csr_write()
- sspmpen_csr_write()

PMP implements granularity handling for address matching (masking low bits
in TOR mode, reinterpreting NA4 as NAPOT, etc.), but SPMP doesn't.
https://lists.nongnu.org/archive/html/qemu-riscv/2025-10/msg00416.html
<https://lists.nongnu.org/archive/html/qemu-riscv/2025-10/msg00416.html>

+/*
> + * Accessor method to extract address matching type 'a field' from cfg reg
> + */
> +uint8_t spmp_get_a_field(uint8_t cfg)
> +{
> +    uint8_t a = cfg >> 3;
> +    return a & 0x3;
> +}

+
> +/*
> + * Check whether mstatus.sum is set.
> + */
> +static inline int sum_is_set(CPURISCVState *env)
> +{
> +    if (env->mstatus & MSTATUS_SUM) {
> +        return 1;
> +    }
> +
> +    return 0;
> +}
>

These two helper functions could be simplified:
uint8_t spmp_get_a_field(uint8_t cfg)
{
    return (cfg & SPMP_AMATCH) >> 3;
}

static inline bool sum_is_set(CPURISCVState *env)
{
    return !!(env->mstatus & MSTATUS_SUM);
}

+static void spmp_update_rule_addr(CPURISCVState *env, uint32_t spmp_index)
> +{
> +    uint8_t this_cfg = env->spmp_state.spmp[spmp_index].cfg_reg;
> +    target_ulong this_addr = env->spmp_state.spmp[spmp_index].addr_reg;
> +    target_ulong prev_addr = 0u;
> +    target_ulong sa = 0u;
> +    target_ulong ea = 0u;
> +
> +    if (spmp_index >= 1u) {
> +        prev_addr = env->spmp_state.spmp[spmp_index - 1].addr_reg;
> +    }
> +
> +    switch (spmp_get_a_field(this_cfg)) {
> +    case SPMP_AMATCH_OFF:
> +        sa = 0u;
> +        ea = -1;
> +        break;
> +
> +    case SPMP_AMATCH_TOR:
> +        sa = prev_addr << 2; /* shift up from [xx:0] to [xx+2:2] */
> +        ea = (this_addr << 2) - 1u;
> +        break;
> +
> +    case SPMP_AMATCH_NA4:
> +        sa = this_addr << 2; /* shift up from [xx:0] to [xx+2:2] */
> +        ea = (sa + 4u) - 1u;
> +        break;
> +
> +    case SPMP_AMATCH_NAPOT:
> +        spmp_decode_napot(this_addr, &sa, &ea);
> +        break;
> +
> +    default:
> +        sa = 0u;
> +        ea = 0u;
> +        break;
> +    }
> +
> +    env->spmp_state.addr[spmp_index].sa = sa;
> +    env->spmp_state.addr[spmp_index].ea = ea;
> +}

The current SPMP implementation doesn't handle granularity configuration
like PMP does.

int g = spmp_get_granularity_g(env);
case SPMP_AMATCH_TOR:
    /* Bits spmpaddr[G-1:0] do not affect the TOR address-matching logic. */
    if (g >= 1) {
        prev_addr &= ~((1ULL << g) - 1ULL);
        this_addr &= ~((1ULL << g) - 1ULL);
    }
    if (prev_addr >= this_addr) {
        sa = ea = 0u;
        break;
    }
case SPMP_AMATCH_NAPOT:
    /* Align to pmp_granularity */
    if (g >= 2) {
        this_addr |= ((1ul << (g - 1ul)) - 1ul);
    }
    spmp_decode_napot(this_addr, &sa, &ea);


> +
> +static void spmp_update_rule_nums(CPURISCVState *env)
> +{
> +    int i;
> +
> +    env->spmp_state.num_active_rules = 0;
> +    for (i = 0; i < MAX_RISCV_SPMPS; i++) {
> +        const uint8_t a_field =
> +            spmp_get_a_field(env->spmp_state.spmp[i].cfg_reg);
> +        if (SPMP_AMATCH_OFF != a_field) {
> +            env->spmp_state.num_active_rules++;
> +        }
> +    }
> +}
>

Optimize spmp_update_rule_nums() to O(1)
Currently this function scans all 64 entries on every config write.
We can optimize it to O(1) by incrementally updating the counter:

static void spmp_update_rule_nums(CPURISCVState *env, uint32_t spmp_index,
                                  uint8_t old_a_field)
{
    uint8_t new_a_field =
        spmp_get_a_field(env->spmp_state.spmp[spmp_index].cfg_reg);

    if (old_a_field == SPMP_AMATCH_OFF && new_a_field != SPMP_AMATCH_OFF) {
        env->spmp_state.num_active_rules++;
    } else if (old_a_field != SPMP_AMATCH_OFF
               && new_a_field == SPMP_AMATCH_OFF) {
        env->spmp_state.num_active_rules--;
    }
}

> +
> +static uint8_t spmp_is_in_range(CPURISCVState *env, int spmp_index,
> +                                target_ulong addr)
> +{
> +    if ((addr >= env->spmp_state.addr[spmp_index].sa)
> +        && (addr <= env->spmp_state.addr[spmp_index].ea)) {
> +        return 1;
> +    }
> +
> +    return 0;
> +}
> +
>
It would be clearer to use bool instead of uint8_t for the return type.
return (addr >= env->spmp_state.addr[spmp_index].sa) &&
           (addr <= env->spmp_state.addr[spmp_index].ea);
> +static bool spmp_hart_has_privs_default(CPURISCVState *env, target_ulong
addr,
> +                                        spmp_priv_t *allowed_privs,
> +                                        target_ulong mode)
> +{
> +    bool ret;
> +    mode = env->virt_enabled ? PRV_U : mode;
> +
> +    if ((!riscv_cpu_cfg(env)->spmp) || !(mode == PRV_U)) {
Can we remove mode = env->virt_enabled ? PRV_U : mode; here ?

+/*
> + * Check if the address has required RWX privs to complete desired
> operation
> + */
> +bool spmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
> +    target_ulong size, spmp_priv_t privs, spmp_priv_t *allowed_privs,
> +    target_ulong mode)
> +{
> +    int i = 0;
> +    int ret = -1;
> +    int spmp_size = 0;
> +    target_ulong s = 0;
> +    target_ulong e = 0;
> +    bool spmpen_en = false;
> +
> +    /* If it is either VS or VU mode, we treat it as U mode */
> +    mode = env->virt_enabled ? PRV_U : mode;
> +
> +    /* Short cut for M-mode access */
> +    if (mode == PRV_M) {
> +        *allowed_privs = SPMP_READ | SPMP_WRITE | SPMP_EXEC;
> +        return true;
> +    }
> +
> +    /* Short cut if no rules */
> +    if (env->spmp_state.num_active_rules == 0) {
> +        return spmp_hart_has_privs_default(env, addr, allowed_privs,
> mode);
> +    }
>
We need to check this, num_active_rules == 0 doesn't mean no implemented
entries (OFF).
SEPC : If the effective privilege mode of the access is S/U and no SPMP
entry matches, but at least one
SPMP entry is implemented, the access is denied.

> +
> +    if (size == 0) {
> +        if (riscv_cpu_cfg(env)->mmu) {
> +            /*
> +             * If size is unknown (0), assume that all bytes
> +             * from addr to the end of the page will be accessed.
> +             */
> +            spmp_size = -(addr | TARGET_PAGE_MASK);
> +        } else {
> +            spmp_size = sizeof(target_ulong);
> +        }
> +    } else {
> +        spmp_size = size;
> +    }
> +
> +    /* It depends on mpmpdeleg */
> +    for (i = 0; i < env->spmp_state.num_deleg_rules; i++) {
> +        s = spmp_is_in_range(env, i, addr);
> +        e = spmp_is_in_range(env, i, addr + spmp_size - 1);
> +        spmpen_en = spmp_get_spmpen_bit(env, i);
> +
> +        /* partially inside */
> +        if ((s + e) == 1) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: spmp violation - access is partially
> inside\n",
> +                          __func__);
> +            ret = 0;
> +            break;
> +        }
>
return false directly ?

> +
> +        /* fully inside */
> +        const uint8_t a_field =
> +            spmp_get_a_field(env->spmp_state.spmp[i].cfg_reg);
> +
> +        /*
> +         * Convert the SPMP permissions to match the truth table in the
> +         * SPMP spec.
> +         */
> +        const uint8_t spmp_operation =
> +                                (env->spmp_state.spmp[i].cfg_reg &
> SPMP_EXEC)
> +                                | (env->spmp_state.spmp[i].cfg_reg &
> SPMP_WRITE)
> +                                | (env->spmp_state.spmp[i].cfg_reg &
> SPMP_READ);
> +
> +        if (((s + e) == 2) && (SPMP_AMATCH_OFF != a_field) && spmpen_en) {
> +            /*
> +             * If the SPMP entry is not off, spmpen bit is set, and the
> address
> +             * is in range, do the priv check
> +             */
> +
> +            /* Shared not set */
> +            if (!(env->spmp_state.spmp[i].cfg_reg & SPMP_SHARED)) {
> +                /*
> +                 *   Deny if:
> +                 *   S mode access, with SUM not set, and UMODE set.
> +                 *   U mode access, with UMODE not set.
> +                 */
> +                if ((mode == PRV_S && !sum_is_set(env) &&
> +                    (env->spmp_state.spmp[i].cfg_reg & SPMP_UMODE)) ||
> +                    (mode == PRV_U &&
> +                        !(env->spmp_state.spmp[i].cfg_reg & SPMP_UMODE)))
> {
> +                    *allowed_privs = 0;
> +                }
> +                /*
> +                 *   EnforceNoX if:
> +                 *   S mode access, with SUM set, and UMODE set.
> +                 *   Note: The specification has the table in RWX, the
> oposite
> +                 *   of the order in the cfg reg.
> +                 */
> +                else if (mode == PRV_S && sum_is_set(env) &&
> +                        (env->spmp_state.spmp[i].cfg_reg & SPMP_UMODE)) {
> +                    switch (spmp_operation) {
> +                    case 0:
> +                    case 2:
> +                    case 4:
> +                    case 6:
> +                        *allowed_privs = 0;
> +                        break;
> +                    case 1:
> +                    case 5:
> +                        *allowed_privs = SPMP_READ;
> +                        break;
> +                    case 3:
> +                    case 7:
> +                        *allowed_privs = SPMP_READ | SPMP_WRITE;
> +                        break;
> +                    default:
> +                        g_assert_not_reached();
> +                    }
> +                } else {
> +                    /* Check for reserved configs */
> +                    if (spmp_operation == 2 || spmp_operation == 6) {
> +                        *allowed_privs = 0;
> +                    } else {
> +                        /* U mode falls here - Enforce */
> +                        *allowed_privs = spmp_operation & 0x7;
> +                    }
> +                }
> +            }
> +            /* Set Shared bit */
> +            else {
>
Lack of spmpcfg.U == 0.

if (!(env->spmp_state.spmp[i].cfg_reg & SPMP_UMODE)) {
                    *allowed_privs = 0;
                }
                else if (mode == PRV_S) {

+/*
> + * Accessor to set the cfg reg for a specific SPMP/HART
> + * Bounds checks.
> + */
> +void spmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
> +    target_ulong val, bool m_mode_access)
> +{
> +    bool locked = m_mode_access ? false : is_entry_locked(env, reg_index);
> +
> +    /* If within bounds and not locked */
> +    if (reg_index < env->spmp_state.num_deleg_rules && !locked) {
> No blank
> +        env->spmp_state.spmp[reg_index].cfg_reg = val;
> +        /* Storing this allows for faster switching with the sspmpen ext
> */
> +        env->spmp_state.locked_rules |=
> +                                ((val & SPMP_LOCK) >> 7 & 0x1) <<
> reg_index;
> +
> +        spmp_update_rule(env, reg_index);
> +    } else {
> +        if (locked) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                    "%s: ignoring spmpcfg write - locked entry\n",
> __func__);
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                    "%s: ignoring spmpcfg write - out of bounds\n",
> __func__);
> +        }
> +    }
> +}

1. SPMP configuration changes require TLB flush (currently missing)
When SPMP entries are modified, cached TLB entries may still contain old
permission information
2. NA4 mode should be reinterpreted as NAPOT when granularity > 4 bytes
     if (reg_index < env->spmp_state.num_deleg_rules && !locked) {
        if (env->spmp_state.spmp[reg_index].cfg_reg != new_val) {
            uint8_t old_a_field =
                spmp_get_a_field(env->spmp_state.spmp[reg_index].cfg_reg);
            uint8_t a_field = spmp_get_a_field(new_val);
            /*
             * When granularity g >= 1 (i.e., granularity > 4 bytes),
             * the NA4 (Naturally Aligned 4-byte) mode is not selectable.
             * In this case, an NA4 setting is reinterpreted as a NAPOT
mode.
             */
            if ((riscv_cpu_cfg(env)->pmp_granularity >
                MIN_RISCV_PMP_GRANULARITY) && (a_field == SPMP_AMATCH_NA4))
{
                    new_val |= SPMP_AMATCH;
            }
            env->spmp_state.spmp[reg_index].cfg_reg = new_val;
            spmp_update_rule(env, reg_index, old_a_field);
            tlb_flush(env_cpu(env));
>
>

+/*
> + * Handle a write to a spmpaddr CSR
> + */
> +void spmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
> +    target_ulong val, bool m_mode_access)
> +{
> +    bool locked = m_mode_access ? false : is_entry_locked(env,
> addr_index);
> +
> +    /* If within bounds and not locked */
> +    if (addr_index < env->spmp_state.num_deleg_rules && !locked) {
> +
> +        env->spmp_state.spmp[addr_index].addr_reg = val;
> +        spmp_update_rule(env, addr_index);
> +    } else {
> +        if (locked) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                    "%s: ignoring spmpaddr write - locked entry\n",
> __func__);
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                    "%s: ignoring spmpaddr write - out of bounds\n",
> __func__);
> +        }
> +    }
> +}

 We need to handle flush here
        if (env->spmp_state.spmp[addr_index].addr_reg != new_val) {
            uint8_t old_a_field =
                spmp_get_a_field(env->spmp_state.spmp[addr_index].cfg_reg);
            env->spmp_state.spmp[addr_index].addr_reg = new_val;
            spmp_update_rule(env, addr_index, old_a_field);
            tlb_flush(env_cpu(env));
        }

> +/*
> + * Handle a read from a spmpaddr CSR
> + */
> +target_ulong spmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
> +{
> +    target_ulong val = 0;
> +
> +    if (addr_index < env->spmp_state.num_deleg_rules) {
> +        val = env->spmp_state.spmp[addr_index].addr_reg;

Handle granularity
        int g = spmp_get_granularity_g(env);
        switch (spmp_get_a_field(env->spmp_state.spmp[addr_index].cfg_reg))
{
        case SPMP_AMATCH_OFF:
            /* fallthrough */
        case SPMP_AMATCH_TOR:
            /* Bit [g-1:0] read all zero */
            if (g >= 1 && g < TARGET_LONG_BITS) {
                val = deposit64(val, 0, g, 0);
            }
            break;
        case SPMP_AMATCH_NAPOT:
            /* Bit [g-2:0] read all one */
            if (g >= 2 && g < TARGET_LONG_BITS) {
                val = deposit64(val, 0, g - 1, -1ULL);
            }
            break;
        default:
            break;
        }

> +/*
> + * Handle a write to the sspmpen CSR
> + */
> +void sspmpen_csr_write(CPURISCVState *env, uint64_t new_val)
> +{
> +    uint64_t mask = (env->spmp_state.num_deleg_rules == MAX_RISCV_SPMPS) ?
> +                    ~0ULL : ((1ULL << env->spmp_state.num_deleg_rules) -
> 1);
> +
> +    /* If the rule is locked, the bit cannot be changed */
> +    env->spmp_state.spmpen =
> +                    (env->spmp_state.spmpen &
> env->spmp_state.locked_rules) |
> +                    (new_val & ~env->spmp_state.locked_rules);
> +    env->spmp_state.spmpen &= mask;
> +}
>
flush()

> +
> +/*
> + * Convert SPMP privilege to TLB page privilege.
> + */
> +int spmp_priv_to_page_prot(spmp_priv_t spmp_priv)
> +{
> +    int prot = 0;
> +
> +    if (spmp_priv & SPMP_READ) {
> +        prot |= PAGE_READ;
> +    }
> +    if (spmp_priv & SPMP_WRITE) {
> +        prot |= PAGE_WRITE;
> +    }
> +    if (spmp_priv & SPMP_EXEC) {
> +        prot |= PAGE_EXEC;
> +    }
> +
> +    return prot;
> +}
>
int spmp_priv_to_page_prot(spmp_priv_t spmp_priv)
{
    return spmp_priv & PAGE_RWX;
}


> +
> +void spmp_unlock_entries(CPURISCVState *env)
> +{
> +    /* Reset everything */
> +    for (int i = 0; i < MAX_RISCV_SPMPS; i++) {
> +        env->spmp_state.spmp[i].cfg_reg &= ~(SPMP_LOCK | SPMP_AMATCH);
> +    }
>
Maybe we can clear it all ?
void spmp_unlock_entries(CPURISCVState *env)
{
    /* Reset everything */
    memset(&env->spmp_state, 0, sizeof(env->spmp_state));
}

> +
> +    env->spmp_state.locked_rules = 0;
> +    env->spmp_state.num_active_rules = 0;
> +}
>
>
>

--0000000000005d0e2406535342f2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><div>Hi=
=C2=A0Luisccc,<br>Thank you for this patch. I have two main questions about=
 the implementation:<br><br>The SPMP CSR write functions don&#39;t flush th=
e TLB after modifying entries:<br>- spmpcfg_csr_write()<br>- spmpaddr_csr_w=
rite()<br>- sspmpen_csr_write()<br><br>PMP implements granularity handling =
for address matching (masking low bits<br>in TOR mode, reinterpreting NA4 a=
s NAPOT, etc.), but SPMP doesn&#39;t.<br><a href=3D"https://lists.nongnu.or=
g/archive/html/qemu-riscv/2025-10/msg00416.html">https://lists.nongnu.org/a=
rchive/html/qemu-riscv/2025-10/msg00416.html=C2=A0</a></div><div><br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">+/*<br>
+ * Accessor method to extract address matching type &#39;a field&#39; from=
 cfg reg<br>
+ */<br>
+uint8_t spmp_get_a_field(uint8_t cfg)<br>
+{<br>
+=C2=A0 =C2=A0 uint8_t a =3D cfg &gt;&gt; 3;<br>
+=C2=A0 =C2=A0 return a &amp; 0x3;<br>
+}=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+/*<br>
+ * Check whether mstatus.sum is set.<br>
+ */<br>
+static inline int sum_is_set(CPURISCVState *env)<br>
+{<br>
+=C2=A0 =C2=A0 if (env-&gt;mstatus &amp; MSTATUS_SUM) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br></blockquote><div><br></div><div>These two helper functions could be =
simplified:<br>uint8_t spmp_get_a_field(uint8_t cfg)<br>{<br>=C2=A0 =C2=A0 =
return (cfg &amp; SPMP_AMATCH) &gt;&gt; 3;<br>}</div><div><br>static inline=
 bool sum_is_set(CPURISCVState *env)<br>{<br>=C2=A0 =C2=A0 return !!(env-&g=
t;mstatus &amp; MSTATUS_SUM);<br>}</div><div><br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
+static void spmp_update_rule_addr(CPURISCVState *env, uint32_t spmp_index)=
<br>
+{<br>
+=C2=A0 =C2=A0 uint8_t this_cfg =3D env-&gt;spmp_state.spmp[spmp_index].cfg=
_reg;<br>
+=C2=A0 =C2=A0 target_ulong this_addr =3D env-&gt;spmp_state.spmp[spmp_inde=
x].addr_reg;<br>
+=C2=A0 =C2=A0 target_ulong prev_addr =3D 0u;<br>
+=C2=A0 =C2=A0 target_ulong sa =3D 0u;<br>
+=C2=A0 =C2=A0 target_ulong ea =3D 0u;<br>
+<br>
+=C2=A0 =C2=A0 if (spmp_index &gt;=3D 1u) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 prev_addr =3D env-&gt;spmp_state.spmp[spmp_ind=
ex - 1].addr_reg;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 switch (spmp_get_a_field(this_cfg)) {<br>
+=C2=A0 =C2=A0 case SPMP_AMATCH_OFF:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sa =3D 0u;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ea =3D -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case SPMP_AMATCH_TOR:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sa =3D prev_addr &lt;&lt; 2; /* shift up from =
[xx:0] to [xx+2:2] */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ea =3D (this_addr &lt;&lt; 2) - 1u;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case SPMP_AMATCH_NA4:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sa =3D this_addr &lt;&lt; 2; /* shift up from =
[xx:0] to [xx+2:2] */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ea =3D (sa + 4u) - 1u;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case SPMP_AMATCH_NAPOT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 spmp_decode_napot(this_addr, &amp;sa, &amp;ea)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sa =3D 0u;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ea =3D 0u;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 env-&gt;spmp_state.addr[spmp_index].sa =3D sa;<br>
+=C2=A0 =C2=A0 env-&gt;spmp_state.addr[spmp_index].ea =3D ea;<br>
+}</blockquote><div>The current SPMP implementation doesn&#39;t handle gran=
ularity configuration like PMP does.</div><div><br></div><div>int g =3D spm=
p_get_granularity_g(env);</div><div>case SPMP_AMATCH_TOR:<br>=C2=A0 =C2=A0 =
/* Bits spmpaddr[G-1:0] do not affect the TOR address-matching logic. */<br=
>=C2=A0 =C2=A0 if (g &gt;=3D 1) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 prev_addr =
&amp;=3D ~((1ULL &lt;&lt; g) - 1ULL);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 this_a=
ddr &amp;=3D ~((1ULL &lt;&lt; g) - 1ULL);<br>=C2=A0 =C2=A0 }<br>=C2=A0 =C2=
=A0 if (prev_addr &gt;=3D this_addr) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 sa =
=3D ea =3D 0u;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>=C2=A0 =C2=A0 }</di=
v><div>case SPMP_AMATCH_NAPOT:<br>=C2=A0 =C2=A0 /* Align to pmp_granularity=
 */<br>=C2=A0 =C2=A0 if (g &gt;=3D 2) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 this=
_addr |=3D ((1ul &lt;&lt; (g - 1ul)) - 1ul);<br>=C2=A0 =C2=A0 }<br>=C2=A0 =
=C2=A0 spmp_decode_napot(this_addr, &amp;sa, &amp;ea);</div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+static void spmp_update_rule_nums(CPURISCVState *env)<br>
+{<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 env-&gt;spmp_state.num_active_rules =3D 0;<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; MAX_RISCV_SPMPS; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const uint8_t a_field =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spmp_get_a_field(env-&gt;spmp_st=
ate.spmp[i].cfg_reg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (SPMP_AMATCH_OFF !=3D a_field) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;spmp_state.num_active_ru=
les++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+}<br></blockquote><div>=C2=A0</div><div>Optimize spmp_update_rule_nums() t=
o O(1)<br>Currently this function scans all 64 entries on every config writ=
e.<br>We can optimize it to O(1) by incrementally updating the counter:<br>=
<br>static void spmp_update_rule_nums(CPURISCVState *env, uint32_t spmp_ind=
ex,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t old_a_field)<b=
r>{<br>=C2=A0 =C2=A0 uint8_t new_a_field =3D<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 spmp_get_a_field(env-&gt;spmp_state.spmp[spmp_index].cfg_reg);<br><br>=C2=
=A0 =C2=A0 if (old_a_field =3D=3D SPMP_AMATCH_OFF &amp;&amp; new_a_field !=
=3D SPMP_AMATCH_OFF) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;spmp_state.nu=
m_active_rules++;<br>=C2=A0 =C2=A0 } else if (old_a_field !=3D SPMP_AMATCH_=
OFF<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;&amp; ne=
w_a_field =3D=3D SPMP_AMATCH_OFF) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;=
spmp_state.num_active_rules--;<br>=C2=A0 =C2=A0 }<br>}</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
+<br>
+static uint8_t spmp_is_in_range(CPURISCVState *env, int spmp_index,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_ulong addr)<br>
+{<br>
+=C2=A0 =C2=A0 if ((addr &gt;=3D env-&gt;spmp_state.addr[spmp_index].sa)<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; (addr &lt;=3D env-&gt;spmp_state.ad=
dr[spmp_index].ea)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br></blockquote><div>It would be clearer to use bool instead of uint8_t f=
or the return type.</div><div>return (addr &gt;=3D env-&gt;spmp_state.addr[=
spmp_index].sa) &amp;&amp;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(add=
r &lt;=3D env-&gt;spmp_state.addr[spmp_index].ea);<br>&gt; +static bool spm=
p_hart_has_privs_default(CPURISCVState *env, target_ulong addr,<br>&gt; + =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spmp_priv=
_t *allowed_privs,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0target_ulong mode)<br>&gt; +{<br>&gt; + =C2=A0 =C2=A0bo=
ol ret;<br>&gt; + =C2=A0 =C2=A0mode =3D env-&gt;virt_enabled ? PRV_U : mode=
;<br>&gt; +<br>&gt; + =C2=A0 =C2=A0if ((!riscv_cpu_cfg(env)-&gt;spmp) || !(=
mode =3D=3D PRV_U)) {</div><div>Can we remove mode =3D env-&gt;virt_enabled=
 ? PRV_U : mode; here ?</div><div><br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
+/*<br>
+ * Check if the address has required RWX privs to complete desired operati=
on<br>
+ */<br>
+bool spmp_hart_has_privs(CPURISCVState *env, target_ulong addr,<br>
+=C2=A0 =C2=A0 target_ulong size, spmp_priv_t privs, spmp_priv_t *allowed_p=
rivs,<br>
+=C2=A0 =C2=A0 target_ulong mode)<br>
+{<br>
+=C2=A0 =C2=A0 int i =3D 0;<br>
+=C2=A0 =C2=A0 int ret =3D -1;<br>
+=C2=A0 =C2=A0 int spmp_size =3D 0;<br>
+=C2=A0 =C2=A0 target_ulong s =3D 0;<br>
+=C2=A0 =C2=A0 target_ulong e =3D 0;<br>
+=C2=A0 =C2=A0 bool spmpen_en =3D false;<br>
+<br>
+=C2=A0 =C2=A0 /* If it is either VS or VU mode, we treat it as U mode */<b=
r>
+=C2=A0 =C2=A0 mode =3D env-&gt;virt_enabled ? PRV_U : mode;<br>
+<br>
+=C2=A0 =C2=A0 /* Short cut for M-mode access */<br>
+=C2=A0 =C2=A0 if (mode =3D=3D PRV_M) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *allowed_privs =3D SPMP_READ | SPMP_WRITE | SP=
MP_EXEC;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Short cut if no rules */<br>
+=C2=A0 =C2=A0 if (env-&gt;spmp_state.num_active_rules =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return spmp_hart_has_privs_default(env, addr, =
allowed_privs, mode);<br>
+=C2=A0 =C2=A0 }<br></blockquote><div>We need to check this, num_active_rul=
es =3D=3D 0 doesn&#39;t mean no implemented entries (OFF).<br>SEPC : If the=
 effective privilege mode of the access is S/U and no SPMP entry matches, b=
ut at least one<br>SPMP entry is implemented, the access is denied.=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 if (size =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (riscv_cpu_cfg(env)-&gt;mmu) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If size is unknown (0), =
assume that all bytes<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* from addr to the end of =
the page will be accessed.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spmp_size =3D -(addr | TARGET_PA=
GE_MASK);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spmp_size =3D sizeof(target_ulon=
g);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 spmp_size =3D size;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* It depends on mpmpdeleg */<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; env-&gt;spmp_state.num_deleg_rules; i++=
) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s =3D spmp_is_in_range(env, i, addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 e =3D spmp_is_in_range(env, i, addr + spmp_siz=
e - 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 spmpen_en =3D spmp_get_spmpen_bit(env, i);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* partially inside */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((s + e) =3D=3D 1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;%s: spmp violation - access is partially inside\n&q=
uot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 __func__);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br></blockquote><div>return false directly ?=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* fully inside */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const uint8_t a_field =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spmp_get_a_field(env-&gt;spmp_st=
ate.spmp[i].cfg_reg);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Convert the SPMP permissions to match =
the truth table in the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* SPMP spec.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const uint8_t spmp_operation =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (env-&gt;spmp_state.spmp[i].cfg_reg =
&amp; SPMP_EXEC)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | (env-&gt;spmp_state.spmp[i].cfg_re=
g &amp; SPMP_WRITE)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | (env-&gt;spmp_state.spmp[i].cfg_re=
g &amp; SPMP_READ);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (((s + e) =3D=3D 2) &amp;&amp; (SPMP_AMATCH=
_OFF !=3D a_field) &amp;&amp; spmpen_en) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If the SPMP entry is not=
 off, spmpen bit is set, and the address<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* is in range, do the priv=
 check<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Shared not set */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(env-&gt;spmp_state.spmp[i]=
.cfg_reg &amp; SPMP_SHARED)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=
=A0Deny if:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=
=A0S mode access, with SUM not set, and UMODE set.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=
=A0U mode access, with UMODE not set.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((mode =3D=3D P=
RV_S &amp;&amp; !sum_is_set(env) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (env=
-&gt;spmp_state.spmp[i].cfg_reg &amp; SPMP_UMODE)) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (mod=
e =3D=3D PRV_U &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 !(env-&gt;spmp_state.spmp[i].cfg_reg &amp; SPMP_UMODE))) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *all=
owed_privs =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=
=A0EnforceNoX if:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=
=A0S mode access, with SUM set, and UMODE set.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=
=A0Note: The specification has the table in RWX, the oposite<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=
=A0of the order in the cfg reg.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (mode =3D=
=3D PRV_S &amp;&amp; sum_is_set(env) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (env-&gt;spmp_state.spmp[i].cfg_reg &amp; SPMP_UMODE)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 swit=
ch (spmp_operation) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case=
 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case=
 2:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case=
 4:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case=
 6:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 *allowed_privs =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case=
 1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case=
 5:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 *allowed_privs =3D SPMP_READ;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case=
 3:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case=
 7:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 *allowed_privs =3D SPMP_READ | SPMP_WRITE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 defa=
ult:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 g_assert_not_reached();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* C=
heck for reserved configs */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
spmp_operation =3D=3D 2 || spmp_operation =3D=3D 6) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 *allowed_privs =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } el=
se {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* U mode falls here - Enforce */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 *allowed_privs =3D spmp_operation &amp; 0x7;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Set Shared bit */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else {<br></blockquote><div>Lack=
 of spmpcfg.U =3D=3D 0.</div><div>=C2=A0</div>if (!(env-&gt;spmp_state.spmp=
[i].cfg_reg &amp; SPMP_UMODE)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *allowed_privs =3D 0;<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } <br><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (mode =3D=3D PRV_S) {=C2=A0</div><d=
iv><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+/*<br>
+ * Accessor to set the cfg reg for a specific SPMP/HART<br>
+ * Bounds checks.<br>
+ */<br>
+void spmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,<br>
+=C2=A0 =C2=A0 target_ulong val, bool m_mode_access)<br>
+{<br>
+=C2=A0 =C2=A0 bool locked =3D m_mode_access ? false : is_entry_locked(env,=
 reg_index);<br>
+<br>
+=C2=A0 =C2=A0 /* If within bounds and not locked */<br>
+=C2=A0 =C2=A0 if (reg_index &lt; env-&gt;spmp_state.num_deleg_rules &amp;&=
amp; !locked) {<br>No blank<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;spmp_state.spmp[reg_index].cfg_reg =3D=
 val;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Storing this allows for faster switching wi=
th the sspmpen ext */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;spmp_state.locked_rules |=3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((val &amp; SPMP_LOCK) &gt;&gt; 7 &a=
mp; 0x1) &lt;&lt; reg_index;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 spmp_update_rule(env, reg_index);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (locked) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;%s: ignoring spmpcfg write - locked entry\n&quot;, __func__);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;%s: ignoring spmpcfg write - out of bounds\n&quot;, __func__);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+}</blockquote><div>1. SPMP configuration changes require TLB flush (curren=
tly missing)=C2=A0</div><div>When SPMP entries are modified, cached TLB ent=
ries may still contain old permission information<br>2. NA4 mode should be =
reinterpreted as NAPOT when granularity &gt; 4 bytes</div><div>=C2=A0 =C2=
=A0 =C2=A0if (reg_index &lt; env-&gt;spmp_state.num_deleg_rules &amp;&amp; =
!locked) {</div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (env-&gt;spmp_state.spmp[reg=
_index].cfg_reg !=3D new_val) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint8_t old_a_field =3D<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 spmp_get_a_field(env-&gt;spmp_state.spmp[reg_index].cfg_reg);=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t a_field =3D spmp_get_=
a_field(new_val);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* When granularity g &gt;=3D 1 (i=
.e., granularity &gt; 4 bytes),<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0* the NA4 (Naturally Aligned 4-byte) mode is not selectable.<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* In this case, an NA4 sett=
ing is reinterpreted as a NAPOT mode.<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0*/<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((riscv_cp=
u_cfg(env)-&gt;pmp_granularity &gt;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 MIN_RISCV_PMP_GRANULARITY) &amp;&amp; (a_field =3D=3D =
SPMP_AMATCH_NA4)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 new_val |=3D SPMP_AMATCH;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;spmp_s=
tate.spmp[reg_index].cfg_reg =3D new_val;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 spmp_update_rule(env, reg_index, old_a_field);<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tlb_flush(env_cpu(env));<blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">=C2=A0</blockquote><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
+/*<br>
+ * Handle a write to a spmpaddr CSR<br>
+ */<br>
+void spmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,<br>
+=C2=A0 =C2=A0 target_ulong val, bool m_mode_access)<br>
+{<br>
+=C2=A0 =C2=A0 bool locked =3D m_mode_access ? false : is_entry_locked(env,=
 addr_index);<br>
+<br>
+=C2=A0 =C2=A0 /* If within bounds and not locked */<br>
+=C2=A0 =C2=A0 if (addr_index &lt; env-&gt;spmp_state.num_deleg_rules &amp;=
&amp; !locked) {<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;spmp_state.spmp[addr_index].addr_reg =
=3D val;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 spmp_update_rule(env, addr_index);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (locked) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;%s: ignoring spmpaddr write - locked entry\n&quot;, __func__);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;%s: ignoring spmpaddr write - out of bounds\n&quot;, __func__);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+}</blockquote><div>=C2=A0We need to handle flush here</div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if (env-&gt;spmp_state.spmp[addr_index].addr_reg !=3D new_val=
) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t old_a_field =3D<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spmp_get_a_field(e=
nv-&gt;spmp_state.spmp[addr_index].cfg_reg);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 env-&gt;spmp_state.spmp[addr_index].addr_reg =3D new_val;<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spmp_update_rule(env, addr_index=
, old_a_field);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tlb_flush(env_=
cpu(env));<br><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
+/*<br>
+ * Handle a read from a spmpaddr CSR<br>
+ */<br>
+target_ulong spmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)<br=
>
+{<br>
+=C2=A0 =C2=A0 target_ulong val =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 if (addr_index &lt; env-&gt;spmp_state.num_deleg_rules) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D env-&gt;spmp_state.spmp[addr_index].ad=
dr_reg;</blockquote><div>Handle granularity=C2=A0<br></div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 int g =3D spmp_get_granularity_g(env);<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 switch (spmp_get_a_field(env-&gt;spmp_state.spmp[addr_index].cfg=
_reg)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 case SPMP_AMATCH_OFF:<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* fallthrough */<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 case SPMP_AMATCH_TOR:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /=
* Bit [g-1:0] read all zero */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 if (g &gt;=3D 1 &amp;&amp; g &lt; TARGET_LONG_BITS) {<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D deposit64(val, 0, g, 0);<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 break;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 case SPMP_AMATCH_NAPOT:=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Bit [g-2:0] read all one *=
/<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g &gt;=3D 2 &amp;&amp; g=
 &lt; TARGET_LONG_BITS) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 val =3D deposit64(val, 0, g - 1, -1ULL);<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;<br><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
+/*<br>
+ * Handle a write to the sspmpen CSR<br>
+ */<br>
+void sspmpen_csr_write(CPURISCVState *env, uint64_t new_val)<br>
+{<br>
+=C2=A0 =C2=A0 uint64_t mask =3D (env-&gt;spmp_state.num_deleg_rules =3D=3D=
 MAX_RISCV_SPMPS) ?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~0UL=
L : ((1ULL &lt;&lt; env-&gt;spmp_state.num_deleg_rules) - 1);<br>
+<br>
+=C2=A0 =C2=A0 /* If the rule is locked, the bit cannot be changed */<br>
+=C2=A0 =C2=A0 env-&gt;spmp_state.spmpen =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (env=
-&gt;spmp_state.spmpen &amp; env-&gt;spmp_state.locked_rules) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (new=
_val &amp; ~env-&gt;spmp_state.locked_rules);<br>
+=C2=A0 =C2=A0 env-&gt;spmp_state.spmpen &amp;=3D mask;<br>
+}<br></blockquote><div>flush()=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
+<br>
+/*<br>
+ * Convert SPMP privilege to TLB page privilege.<br>
+ */<br>
+int spmp_priv_to_page_prot(spmp_priv_t spmp_priv)<br>
+{<br>
+=C2=A0 =C2=A0 int prot =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 if (spmp_priv &amp; SPMP_READ) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 prot |=3D PAGE_READ;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (spmp_priv &amp; SPMP_WRITE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 prot |=3D PAGE_WRITE;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (spmp_priv &amp; SPMP_EXEC) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 prot |=3D PAGE_EXEC;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return prot;<br>
+}<br></blockquote>int spmp_priv_to_page_prot(spmp_priv_t spmp_priv)<br>{<b=
r>=C2=A0 =C2=A0 return spmp_priv &amp; PAGE_RWX;<br>}<br><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+void spmp_unlock_entries(CPURISCVState *env)<br>
+{<br>
+=C2=A0 =C2=A0 /* Reset everything */<br>
+=C2=A0 =C2=A0 for (int i =3D 0; i &lt; MAX_RISCV_SPMPS; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;spmp_state.spmp[i].cfg_reg &amp;=3D ~(=
SPMP_LOCK | SPMP_AMATCH);<br>
+=C2=A0 =C2=A0 }<br></blockquote><div>Maybe we can clear it all ?<br>void s=
pmp_unlock_entries(CPURISCVState *env)<br>{<br>=C2=A0 =C2=A0 /* Reset every=
thing */<br>=C2=A0 =C2=A0 memset(&amp;env-&gt;spmp_state, 0, sizeof(env-&gt=
;spmp_state));<br>}</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 env-&gt;spmp_state.locked_rules =3D 0;<br>
+=C2=A0 =C2=A0 env-&gt;spmp_state.num_active_rules =3D 0;<br>
+}<br><br>
<br>
</blockquote></div></div>

--0000000000005d0e2406535342f2--

