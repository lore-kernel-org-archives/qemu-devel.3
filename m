Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07FCFEA801
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 03:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5FC7-0002kG-WD; Tue, 24 Mar 2026 23:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5FC6-0002hP-Ij
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 23:46:10 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5FC4-0004AL-G2
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 23:46:10 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b97bca3797dso250637166b.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 20:46:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774410366; cv=none;
 d=google.com; s=arc-20240605;
 b=X/ueoAvCir0RcYb3bZfd/qheyQHQJiNJOEAgbpXK7IO/z20J/VgMlUOGVp4GFoG/LE
 1b1h7skxR+mJBk921YO5rD4k4Crn83Fks8QS97bQjrY6ZZG0swdnM1D01atxar0Pex3V
 rDslNUyjx4GFMEywcNNPlSG2FIvx9NG25GT4Iu3NSru/4XtDaAM3yVnd9IaRFEU1+liH
 0IcqFntDAUNKa/3HQwILB7XLSAqq/QB5e2IVETiomCCpVX/SnR4EuIMPXmPv20Xpr98O
 RUE9qwTTfKP/HeiGZIZXMGHdLRtiCcjPGJExERhjyWZvyE4wvPenaZyAUknHWmCV2w3D
 bz4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Wfvzy181AztgS6X2Dqo5iK7pf3YdljMcckKZC3q7g84=;
 fh=zgMKJ7xzWQ+K5NnFyJlqBJTinRtC3IJ98Jm32NQIPHc=;
 b=VKRrqya6QDlwVcYDCYpt61LqYMwAxqc46KPPUnBxGLWbDnljqUWLpFU+VQZO1eWxeC
 dtPiMceQ4O1cyXX6MWhPobBE3TWmefZSDEuc8129Bw0SFOEDHtqJFVDrREgx2ydMM4cI
 ILbOiLUhY8zPNEfhSeN5Vsf15uEtQAqbfSHno4KDJgTKTrSC27PtewHo2aeEWNbyRQGA
 ln6TwHpsYOl5ltUewd1u7K98dzhld71B/8gmrMrT78mXQdTCf7GW0lTZ+nw9wsutOeW5
 g3DLBsLvxZidCSZdqB7wxchdfiHzetTRTseXeC0WHVmkMb9oVXzi5T1cbZamDh7tk2qO
 vUaA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774410366; x=1775015166; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wfvzy181AztgS6X2Dqo5iK7pf3YdljMcckKZC3q7g84=;
 b=AaY6/2eco6RTy9WBtNA6qMemWzdOW3kcwcs1s+sLppw2zNitN1/VkV6ebtFluKQsd5
 e/WHveKQZJutvPEhCGyX7R4oGdE+QDkMIe0XaqFvmy7cmdAKi8oSmb4EtPaYmEulpe/h
 p/HN5o2ue1jXt5EiRoex6EknD7bJRZ4ne5IgDtjcK4+8VaJLg0Zbyj0RdAXayltb/zY5
 985JYRAEFkk01bKs5bVSr+DCJiNsqufZ8L2OcQpBqAZdAk3jN/DweCGXXDJLBb0MmHRt
 PiIWBNlQrrTLXETsmSKNXRVJ3hKw2cKPz7NKSriw5McMjfQ8VSCj7c/SHbw2dFMXRdox
 OdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774410366; x=1775015166;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wfvzy181AztgS6X2Dqo5iK7pf3YdljMcckKZC3q7g84=;
 b=RDB19Gt/AYZmZ45kl/tq7+WILITvWmuSYWck5YODqsyfuqomyPsnrBE9SIjqIKZpsZ
 H5GYXa7tbL818EhVDyleaWlest2A+/O7h1jOklYNuFJu4QfUiK/iP4w6Wthekmc5mvi0
 zcrYe1hrgcsXOHf7aIuEpW0XJjnbMfBT2v5jWN4t8ufeXqKauM0lmFC9YlAIowjre9tH
 hOqUf2tdtDou3q5R2uA9eBO/HcJxI7MpUUApgaqrk/MvUev5aelVBVIXih7OPinLlH0z
 5njsCR20Wya+Mo4GAkbpn7kUN1nbM0tN/7DOfQN2o0Oq/WcBDH1oTtizFGvoQAKumgx8
 B2ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQflBVF1OXI1H7oGGtq4omblhhZuY+9TF5vPZHz1jHkRM2lJZbwVmvOEzpPQ7u9SZvb3RMyb5pjYwa@nongnu.org
X-Gm-Message-State: AOJu0YxPiTUOL6am2hGJ42buwXPbhGtjo9rjojKO3z3+QyH9q+A4WgbB
 1XiqbQUvGwHVyY26FVV7ZGBmz1NqaBys6BABAnQsX5CvpmA8LvuW3hveZ/Exs8vTAxHe9OiASgf
 Thfxr4Lzmsc71CdcrRnhNsDwnMdp1LHc=
X-Gm-Gg: ATEYQzzQs8k6Wh6pnyZ1FCQFjVV1xXE0KHsxJ8KmHBF8c+IKfbVnJpYWDp300PTfvJe
 3/f8JhXLi5JAKHq8wkn4oDLlUo/wsJOzDip0GnxY1RbEcfTJQUgTUfJP+GgeIhAd7CQr7QQ26nK
 J3QqJLvINCbW+Q6edKD4YOl/8xj3pMN8vVk/VzbYBmnMKqR3tCTx0rg1N8E0cilas3EC07JFd0F
 qSdchPEhiBhDB8MunxIcOrOL9LIrTBS2rFW0+yH31uFwttF4MSd9B0KVgQmNaSfQoFzcaw5Zgie
 LD9EbE0VD1OfRlwaj7gu4QQmtTpDKpXk8Iis1w==
X-Received: by 2002:a17:906:f59c:b0:b98:8a4a:7d15 with SMTP id
 a640c23a62f3a-b9a3f1a70fdmr113026466b.19.1774410366058; Tue, 24 Mar 2026
 20:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260321141345.599105-1-npiggin@gmail.com>
 <20260321141345.599105-5-npiggin@gmail.com>
In-Reply-To: <20260321141345.599105-5-npiggin@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 25 Mar 2026 13:45:39 +1000
X-Gm-Features: AQROBzCBc91W2XiVSOvRmBk9NywXwk8tB1UAAvlTXDlJ9hFKj0gZ9K4jQelYe4A
Message-ID: <CAKmqyKPnQ_ozznZFi6EKZfiY9XxJwQEPhXhYrpBEDY1Qd17vvQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] linux-user/riscv: Add vector state to signal
 context
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sun, Mar 22, 2026 at 12:16=E2=80=AFAM Nicholas Piggin <npiggin@gmail.com=
> wrote:
>
> This enables vector state to be saved and restored across signals.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  linux-user/riscv/signal.c    | 175 +++++++++++++++++++++++++++++++++--
>  target/riscv/cpu.h           |   4 +
>  target/riscv/csr.c           |   7 +-
>  target/riscv/vector_helper.c |  19 +++-
>  4 files changed, 191 insertions(+), 14 deletions(-)
>
> diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
> index e20b9ac177..2e1a1a5027 100644
> --- a/linux-user/riscv/signal.c
> +++ b/linux-user/riscv/signal.c
> @@ -41,7 +41,17 @@ struct target_fp_state {
>      uint32_t fcsr;
>  };
>
> +struct target_v_ext_state {
> +    abi_ulong vstart;
> +    abi_ulong vl;
> +    abi_ulong vtype;
> +    abi_ulong vcsr;
> +    abi_ulong vlenb;
> +    abi_ptr   datap;
> +};
> +
>  /* The Magic number for signal context frame header. */
> +#define RISCV_V_MAGIC   0x53465457
>  #define END_MAGIC       0x0
>
>  /* The size of END signal context header. */
> @@ -106,6 +116,130 @@ static abi_ulong get_sigframe(struct target_sigacti=
on *ka,
>      return sp;
>  }
>
> +static unsigned int get_v_state_hdr_size(CPURISCVState *env)
> +{
> +    return sizeof(struct target_ctx_hdr) +
> +           sizeof(struct target_v_ext_state);
> +}
> +
> +static unsigned int get_v_state_data_size(CPURISCVState *env)
> +{
> +    RISCVCPU *cpu =3D env_archcpu(env);
> +    return cpu->cfg.vlenb * 32;
> +}
> +
> +static struct target_ctx_hdr *save_v_state(CPURISCVState *env,
> +                                           struct target_ctx_hdr *hdr)
> +{
> +    RISCVCPU *cpu =3D env_archcpu(env);
> +    target_ulong vlenb =3D cpu->cfg.vlenb;
> +    uint32_t riscv_v_sc_size =3D get_v_state_hdr_size(env) +
> +                               get_v_state_data_size(env);
> +    struct target_v_ext_state *vs;
> +    abi_ulong vcsr;
> +    abi_ptr datap;
> +    void *host_datap;
> +
> +#ifdef CONFIG_DEBUG_REMAP
> +    /*
> +     * The host pointers are derived from lock_user, not g2h, so
> +     * h2g can not be used when CONFIG_DEBUG_REMAP=3Dy.
> +     */
> +    qemu_log_mask(LOG_UNIMP, "signal: sigcontext can not save V state "
> +                             "when CONFIG_DEBUG_REMAP=3Dy\n");
> +    return hdr;
> +#endif
> +
> +    vs =3D (struct target_v_ext_state *)(hdr + 1);
> +    vcsr =3D riscv_csr_read(env, CSR_VCSR);
> +    host_datap =3D (vs + 1);
> +    datap =3D h2g(host_datap);
> +
> +    __put_user(RISCV_V_MAGIC, &hdr->magic);
> +    __put_user(riscv_v_sc_size, &hdr->size);
> +
> +    __put_user(env->vstart, &vs->vstart);
> +    __put_user(env->vl, &vs->vl);
> +    __put_user(env->vtype, &vs->vtype);
> +    __put_user(vcsr, &vs->vcsr);
> +    __put_user(vlenb, &vs->vlenb);
> +    __put_user(datap, &vs->datap);
> +
> +    for (int i =3D 0; i < 32; i++) {
> +        for (int j =3D 0; j < vlenb; j +=3D 8) {
> +            size_t idx =3D (i * vlenb + j);
> +            __put_user(env->vreg[idx / 8],
> +                       (uint64_t *)(host_datap + idx));
> +        }
> +    }
> +
> +    return (void *)hdr + riscv_v_sc_size;
> +}
> +
> +static bool restore_v_state(CPURISCVState *env,
> +                            struct target_ctx_hdr *hdr)
> +{
> +    RISCVCPU *cpu =3D env_archcpu(env);
> +    target_ulong vlenb;
> +    target_ulong vcsr, vl, vtype, vstart;
> +    struct target_v_ext_state *vs;
> +    uint32_t size;
> +    abi_ptr datap;
> +    void *host_datap;
> +
> +    if (!riscv_has_ext(env, RVV)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "signal: sigcontext has V state b=
ut "
> +                                       "CPU does not support V extension=
\n");
> +        return false;
> +    }
> +
> +    __get_user(size, &hdr->size);
> +    if (size < get_v_state_hdr_size(env)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "signal: sigcontext V state heade=
r "
> +                                       "size is too small (%u)\n", size)=
;
> +        return false;
> +    }
> +
> +    vs =3D (struct target_v_ext_state *)(hdr + 1);
> +
> +    __get_user(vstart, &vs->vstart);
> +    __get_user(vl, &vs->vl);
> +    __get_user(vtype, &vs->vtype);
> +    __get_user(vcsr, &vs->vcsr);
> +
> +    riscv_cpu_set_vstart(env, vstart);
> +    riscv_cpu_vsetvl(env, vl, vtype, 0);
> +    riscv_csr_write(env, CSR_VCSR, vcsr);
> +
> +    __get_user(vlenb, &vs->vlenb);
> +
> +    if (vlenb !=3D cpu->cfg.vlenb) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "signal: sigcontext has invalid "
> +                                       "vlenb\n");
> +        return false;
> +    }
> +
> +    __get_user(datap, &vs->datap);
> +
> +    host_datap =3D lock_user(VERIFY_READ, datap, vlenb * 32, true);
> +    if (!host_datap) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "signal: sigcontext has V state b=
ut "
> +                                       "datap pointer is invalid\n");
> +        return false;
> +    }
> +
> +    for (int i =3D 0; i < 32; i++) {
> +        for (int j =3D 0; j < vlenb; j +=3D 8) {
> +            size_t idx =3D (i * vlenb + j);
> +            __get_user(env->vreg[idx / 8],
> +                       (uint64_t *)(host_datap + idx));
> +        }
> +    }
> +    unlock_user(host_datap, datap, 0);
> +
> +    return true;
> +}
> +
>  static void setup_sigcontext(struct target_sigcontext *sc, CPURISCVState=
 *env)
>  {
>      struct target_ctx_hdr *hdr;
> @@ -126,6 +260,9 @@ static void setup_sigcontext(struct target_sigcontext=
 *sc, CPURISCVState *env)
>      __put_user(0, &sc->sc_extdesc.reserved);
>
>      hdr =3D &sc->sc_extdesc.hdr;
> +    if (riscv_has_ext(env, RVV)) {
> +        hdr =3D save_v_state(env, hdr);
> +    }
>      __put_user(END_MAGIC, &hdr->magic);
>      __put_user(END_HDR_SIZE, &hdr->size);
>  }
> @@ -152,17 +289,24 @@ void setup_rt_frame(int sig, struct target_sigactio=
n *ka,
>  {
>      abi_ulong frame_addr;
>      struct target_rt_sigframe *frame;
> +    size_t frame_size =3D sizeof(*frame);
>
> -    frame_addr =3D get_sigframe(ka, env, sizeof(*frame));
> +    if (riscv_has_ext(env, RVV)) {
> +        frame_size +=3D get_v_state_hdr_size(env) +
> +                      get_v_state_data_size(env);
> +    }
> +
> +    frame_addr =3D get_sigframe(ka, env, frame_size);
>      trace_user_setup_rt_frame(env, frame_addr);
>
> -    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
> +    frame =3D lock_user(VERIFY_WRITE, frame_addr, frame_size, 0);
> +    if (!frame) {
>          goto badframe;
>      }
>
>      setup_ucontext(&frame->uc, env, set);
>      frame->info =3D *info;
> -    unlock_user_struct(frame, frame_addr, 1);
> +    unlock_user(frame, frame_addr, frame_size);
>
>      env->pc =3D ka->_sa_handler;
>      env->gpr[xSP] =3D frame_addr;
> @@ -174,7 +318,7 @@ void setup_rt_frame(int sig, struct target_sigaction =
*ka,
>      return;
>
>  badframe:
> -    unlock_user_struct(frame, frame_addr, 1);
> +    unlock_user(frame, frame_addr, frame_size);
>      if (sig =3D=3D TARGET_SIGSEGV) {
>          ka->_sa_handler =3D TARGET_SIG_DFL;
>      }
> @@ -211,6 +355,11 @@ static bool restore_sigcontext(CPURISCVState *env, s=
truct target_sigcontext *sc)
>      __get_user(magic, &hdr->magic);
>      while (magic !=3D END_MAGIC) {
>          switch (magic) {
> +        case RISCV_V_MAGIC:
> +            if (!restore_v_state(env, hdr)) {
> +                return false;
> +            }
> +            break;
>          default:
>              qemu_log_mask(LOG_GUEST_ERROR, "signal: unknown extended sta=
te in "
>                                             "sigcontext, magic=3D0x%08x\n=
", magic);
> @@ -258,11 +407,23 @@ static bool restore_ucontext(CPURISCVState *env, st=
ruct target_ucontext *uc)
>  long do_rt_sigreturn(CPURISCVState *env)
>  {
>      struct target_rt_sigframe *frame;
> +    size_t frame_size =3D sizeof(*frame);
>      abi_ulong frame_addr;
>
> +    if (riscv_has_ext(env, RVV)) {
> +        /*
> +         * userspace may have set up a discontiguous V state data area,
> +         * so need to map that region separately once the address is
> +         * known, from datap.
> +         */
> +        frame_size +=3D get_v_state_hdr_size(env);
> +    }
> +
>      frame_addr =3D env->gpr[xSP];
>      trace_user_do_sigreturn(env, frame_addr);
> -    if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
> +
> +    frame =3D lock_user(VERIFY_READ, frame_addr, frame_size, 1);
> +    if (!frame) {
>          goto badframe;
>      }
>
> @@ -272,11 +433,11 @@ long do_rt_sigreturn(CPURISCVState *env)
>
>      target_restore_altstack(&frame->uc.uc_stack, env);
>
> -    unlock_user_struct(frame, frame_addr, 0);
> +    unlock_user(frame, frame_addr, 0);
>      return -QEMU_ESIGRETURN;
>
>  badframe:
> -    unlock_user_struct(frame, frame_addr, 0);
> +    unlock_user(frame, frame_addr, 0);
>      force_sig(TARGET_SIGSEGV);
>      return 0;
>  }
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 35d1f6362c..e1eca79197 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -668,6 +668,10 @@ G_NORETURN void riscv_raise_exception(CPURISCVState =
*env,
>  target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
>  void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
>
> +void riscv_cpu_set_vstart(CPURISCVState *env, target_ulong val);
> +target_ulong riscv_cpu_vsetvl(CPURISCVState *env, target_ulong s1,
> +                              target_ulong s2, target_ulong x0);
> +
>  #ifndef CONFIG_USER_ONLY
>  void cpu_set_exception_base(int vp_index, target_ulong address);
>  #endif
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 5064483917..8a6fd11fb5 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -991,11 +991,8 @@ static RISCVException write_vstart(CPURISCVState *en=
v, int csrno,
>  #if !defined(CONFIG_USER_ONLY)
>      env->mstatus |=3D MSTATUS_VS;
>  #endif
> -    /*
> -     * The vstart CSR is defined to have only enough writable bits
> -     * to hold the largest element index, i.e. lg2(VLEN) bits.
> -     */
> -    env->vstart =3D val & ~(~0ULL << ctzl(riscv_cpu_cfg(env)->vlenb << 3=
));
> +    riscv_cpu_set_vstart(env, val);
> +
>      return RISCV_EXCP_NONE;
>  }
>
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index caa8dd9c12..bceefe019b 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -33,8 +33,17 @@
>  #include "vector_internals.h"
>  #include <math.h>
>
> -target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
> -                            target_ulong s2, target_ulong x0)
> +void riscv_cpu_set_vstart(CPURISCVState *env, target_ulong val)
> +{
> +    /*
> +     * The vstart CSR is defined to have only enough writable bits
> +     * to hold the largest element index, i.e. lg2(VLEN) bits.
> +     */
> +    env->vstart =3D val & ~(~0ULL << ctzl(riscv_cpu_cfg(env)->vlenb << 3=
));
> +}
> +
> +target_ulong riscv_cpu_vsetvl(CPURISCVState *env, target_ulong s1,
> +                              target_ulong s2, target_ulong x0)
>  {
>      int vlmax, vl;
>      RISCVCPU *cpu =3D env_archcpu(env);
> @@ -99,6 +108,12 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, targe=
t_ulong s1,
>      return vl;
>  }
>
> +target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
> +                            target_ulong s2, target_ulong x0)
> +{
> +    return riscv_cpu_vsetvl(env, s1, s2, x0);
> +}
> +
>  /*
>   * Get the maximum number of elements can be operated.
>   *
> --
> 2.51.0
>
>

