Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF94C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfbPy-0007Lg-Ph; Fri, 03 Jul 2026 06:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfbPx-0007Kh-Ef
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 06:46:45 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfbPv-0007UY-QI
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 06:46:45 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-6626b5ace23so2110824d50.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 03:46:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783075602; cv=none;
 d=google.com; s=arc-20260327;
 b=TVoKgFprFEia6Op83AYCOMNPgWaGYwWomMuDoSRVmeGKAro7Lx+Li779C5HyXQOOy/
 sLPqw9uC6KOUJxHkdu81/ZPBsZNf/jow1QUDeLEKHTmuIrAcqUS+WcAhd7bGp5kIEKvx
 CcwXnbCa+x1xpAKymgxemPoxLk2ueNOo0/bPS9Fl3XUIkJWlFJA+G8vdytapwRTvFV3s
 0WLZZt+kK2hbWAWvM8NrwGlvbcaWo9CnFmBZ/jpsRLC02B8Zsqw6gsrUjGI4MrvsSuxs
 I9dTgTQXPAYMT2IMH1YxND9/N5+lIk5luZL+OJdo35DTrdcC3IyrH2D4wpE1zeiEtxkZ
 mBKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/1oN9NDaamuhHRrSeFKV/QD9wkCXZSvmScE7yxC50EU=;
 fh=Fb54Dv4QCRkweqzg7yG6muAVIAdP0ZjU/uO/KBHqsx4=;
 b=AaCXw3jnw7aQ+4JbyQZXpjXSjMHigKIK4DRpy60oQl6y/oWjsDQswGT1IG44teKAsX
 NBU+ty+4hhpjq3SMTQP9bZUIUDi+EOc/1NBr51jBtOscZglnbnJzrhOjWMrp2/Y+aIqL
 M0cP2cWL5K2oXJ4jthNxA+TwvSZ5WJVDJVeJ7HwkFabX8WUyYqd5yLF2M3Pl5Qaoy0eo
 gFAZvjcIh/XLuQ8k64iVxDFxmcki0/h+3IrCHZXMQQ/kEeAG5DpfJ0v9puMnQXQCk4JX
 AhXq/3POsZ2F3ZhmiU+aJ0J/MA9DUuVU0yE9886QMackQvZfTzvVYdNZadjH568jomzx
 jrtg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783075602; x=1783680402; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/1oN9NDaamuhHRrSeFKV/QD9wkCXZSvmScE7yxC50EU=;
 b=WYo4emC1B0IRB3qAEcNIVH2Zul4Rsk9682kT35Tdpn74wMmwOmrO/qQ/RXu4L9hMhB
 4Qi3tUZgYHvp+qntymgbPOQOFzrTOMZd/znOPybO96ma/R19d5iwz6U0cUZgy5LnIXSc
 ihOF4UQfoxPsW3+fo2QKqT04BmaOCue8y/YZO1SaEIDaV9dWeHSc0hHQG3IEcfFm32PU
 uCJhUV+EemZtiB7X9YRiD0XmA7tI1d2UXjyCEA8tAKcOuaQUiAbFdgT4IMTsbhN34zLq
 kg24sD3dIu/UTMqNutqxn1xQpl9kfLoeeAeJarEOnWPP7CZLNHG+OExesmxWnzuSvaRD
 ix4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783075602; x=1783680402;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/1oN9NDaamuhHRrSeFKV/QD9wkCXZSvmScE7yxC50EU=;
 b=UD6qgOfZtdZv6kzTSx4aWL3zfCNz3VPyq/4MRk3qmXpvZo2WV7kEJU7RGs88W/vH/m
 t41/ec42YRkMJ5vhscJpkd91xfBCrmO8BbV2W0+BmpKSas+gbO0ZAy/MlOKKiND+1kcm
 IntWsFXcW7ECjKCbN7wqjNlYqI5XFU5LlGHcGzoYg8WYYRXA8WogTu17uOdVU2xbc9Ul
 wxW84qRNXF4GSv3HsahAfZJjIWFgnv9QQSVx9YiYII3s/zaPvbOXRLvcbfAVojjYbgU+
 LaCZBa+CzVMoAJYPOf93o5/hhdPXlLFZpR6Mjb4bK97R3hSTOxww/8KSUbR/7AdGBfzS
 zPew==
X-Gm-Message-State: AOJu0YwAhigKcbTS8ZGmE8C3JBmYrlii9GIy+ejwyDxNZxzuCGWR1tJW
 acTUcO3u1diPTjlKQTHZgM+L80xl2UzUV73ryEgJ5JUhGiZhTYgZjugr1fUIZHMt4SCqKa0xRMl
 dlzNQiAaGrbutloHMGqm22VzXN6EDn40AR5ZwbkcxPg==
X-Gm-Gg: AfdE7cmOm89G8o5l79CUwqcwnfV3296O7QGtVHldECE7ouJ+Im/XdLTceuUbva4Unw5
 b8eA3JnClqzTZVWLykxoHpeQQa3m+tEKYnwUlTIjptoLl8jVkRUnsRN6weOnUrab+ZXgyRQ2khq
 HeOQ+TsFU59N+8EtD6RJsxsyIbezlbh0ZvZ8rZ2AeUI2GUi0A3x8MsQi2QuETAUx3mdcIqYVYCl
 K9CNIgW0LMvYv/gVp9pkIVq1V+Ug95De6KTujDfdWEkwi3lEjTPb0HaxUNqE8/QEJ2DEU1CSmvx
 iRF5BmwZ7ZPGzXMEZA/VdN1uijl1hW53TmHI3m4REujphU5fK2h/K0XP
X-Received: by 2002:a05:690e:4812:b0:664:b335:ed44 with SMTP id
 956f58d0204a3-66636942b98mr2216698d50.18.1783075601860; Fri, 03 Jul 2026
 03:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
 <20260629131232.2487780-39-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260629131232.2487780-39-brian.cain@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2026 11:46:29 +0100
X-Gm-Features: AVVi8Cf1oTC4SAcL3uEjD_FXGZ9grw_1zN_FTflCWOb77iXV3owgOTiQEwsKxSQ
Message-ID: <CAFEAcA_5cBGieaj2Ui_+8YeE_mUQL+9xZDAGHGm7d+QREo_+6w@mail.gmail.com>
Subject: Re: [PULL v5 38/77] target/hexagon: Update TARGET_PAGE_BITS, stubs
 for modify_ssr/get_exe_mode
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Mon, 29 Jun 2026 at 14:13, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> Add hex_mmu.[ch], cpu mode helpers, and additional includes/stubs
> that integrate the TLB device with the CPU model.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Hi; Coverity flagged up something that confused it in this
commit (CID 1660927), and I don't really understand it either...

> +void hex_tlb_lock(CPUHexagonState *env)
> +{
> +    qemu_log_mask(CPU_LOG_MMU, "hex_tlb_lock: " TARGET_FMT_ld "\n",
> +                  env->threadId);
> +    BQL_LOCK_GUARD();
> +    g_assert((env->tlb_lock_count == 0) || (env->tlb_lock_count == 1));

How does this tlb_lock_count variable work? Here we assert that
it's 0 or 1, but it looks like these lock and unlock operations
can be triggered by the guest and there's no obvious checks here
that would forbid the guest e.g. locking multiple times in a
row or unlocking when already unlocked so as to push the count
out of the {0,1} valid range.

> +
> +    HexagonCPU *cpu = env_archcpu(env);
> +    uint32_t syscfg = cpu->globalregs ?
> +        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_SYSCFG,
> +                               env->threadId) : 0;
> +    uint8_t tlb_lock = GET_SYSCFG_FIELD(SYSCFG_TLBLOCK, syscfg);
> +    if (tlb_lock) {
> +        if (env->tlb_lock_state == HEX_LOCK_QUEUED) {
> +            env->next_PC += 4;
> +            env->tlb_lock_count++;
> +            env->tlb_lock_state = HEX_LOCK_OWNER;
> +            SET_SYSCFG_FIELD(env, SYSCFG_TLBLOCK, 1);
> +            return;
> +        }
> +        if (env->tlb_lock_state == HEX_LOCK_OWNER) {
> +            qemu_log_mask(CPU_LOG_MMU | LOG_GUEST_ERROR,
> +                          "Double tlblock at PC: 0x%" PRIx32
> +                          ", thread may hang\n",
> +                          env->next_PC);
> +            env->next_PC += 4;
> +            CPUState *cs = env_cpu(env);
> +            cpu_interrupt(cs, CPU_INTERRUPT_HALT);
> +            return;
> +        }
> +        env->tlb_lock_state = HEX_LOCK_WAITING;
> +        CPUState *cs = env_cpu(env);
> +        cpu_interrupt(cs, CPU_INTERRUPT_HALT);
> +    } else {
> +        env->next_PC += 4;
> +        env->tlb_lock_count++;
> +        env->tlb_lock_state = HEX_LOCK_OWNER;
> +        SET_SYSCFG_FIELD(env, SYSCFG_TLBLOCK, 1);
> +    }
> +
> +    if (qemu_loglevel_mask(CPU_LOG_MMU)) {
> +        qemu_log_mask(CPU_LOG_MMU, "Threads after hex_tlb_lock:\n");
> +        print_thread_states("\tThread");
> +    }
> +}
> +
> +void hex_tlb_unlock(CPUHexagonState *env)
> +{
> +    BQL_LOCK_GUARD();
> +    g_assert((env->tlb_lock_count == 0) || (env->tlb_lock_count == 1));

In particular, what trips up Coverity is that here we say that
tlb_lock_count is either 0 or 1...

> +
> +    /* Nothing to do if the TLB isn't locked by this thread */
> +    HexagonCPU *cpu = env_archcpu(env);
> +    uint32_t syscfg = cpu->globalregs ?
> +        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_SYSCFG,
> +                               env->threadId) : 0;
> +    uint8_t tlb_lock = GET_SYSCFG_FIELD(SYSCFG_TLBLOCK, syscfg);
> +    if ((tlb_lock == 0) ||
> +        (env->tlb_lock_state != HEX_LOCK_OWNER)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "thread %" PRIu32 " attempted to tlbunlock"
> +                      " without having the lock, tlb_lock state = %d\n",
> +                      env->threadId, env->tlb_lock_state);
> +        g_assert(env->tlb_lock_state != HEX_LOCK_WAITING);
> +        return;
> +    }
> +
> +    env->tlb_lock_count--;

...and then here we unconditionally decrement it. If it was
initially 0 then that will underflow this unsigned value.

thanks
-- PMM

