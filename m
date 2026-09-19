Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39799C982D7
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 21:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x82ZO-00008e-4K; Sat, 19 Sep 2026 17:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x82ZM-00008W-R9
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 17:26:01 -0400
Received: from mail-lf2-x10.google.com ([2a00:1450:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x82ZK-00088e-Kq
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 17:26:00 -0400
Received: by mail-lf2-x10.google.com with SMTP id
 2adb3069b0e04-5b5e4f15b78so1723129e87.2
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 14:25:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789853156; cv=none;
 d=google.com; s=arc-20260327;
 b=rpWfYmP33u4pjGVYIk5urLnD9gfs8B+mbvHLFyxBq91YCmL64CXIHFUUkvP4v7u4nr
 twvVVEVNhv0O52DdVnKCefCPgI+AG4VGcRO8BsNLxipgyBOqUiMNifkQ6z4vrzvRetSa
 qBg1visYq12hGpPnVw1Cn9z6qDw2Vq8CLKMNMfMlD8XclUV4fMBgRm8tcaWq7R54QVcp
 PKQIlAyrK6tZpMuf+RuySTCSh58E/Pvs559qA4xwjbqaNOrIVuKm8G0PpN5suuKMyNog
 yE7eB+npDwKNIEUw+GG5ssBBMKrDw476MwktyvVg62GNyqaBJ45a5jNsZ3MUCaTCIXis
 wdbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qPsnH49pRMF3R53AnkLADS5zvG6FopXBvh4vy62CYZk=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=TwtKKes/iCjibsxLP9NYeEWNmQGJnzdKaq8OYMvqSQKCGVefhiqMu9shis16FvrJWd
 oX5Oaug0icWXi0ElVdO86js+VQdvSJKHM0YMevV0HklFNFvw/mXdQmElIclZGiEnVVGa
 Searv7Z1RJWmxrCSAent/5SGAUyiREnz3rsDF1X+ZUceUJea38aVPNhnKilZQm4F0wDw
 aYnBh468kO1QySsAWzXW2ZI4SLdS+C+uF/vCutA4PnyTW2TzfZc4mi+4i18UDVUCT8ie
 Hr5vQbCoXpinfPsw8umQNpMRc5cngkBbdrf1dVgsYCmoYNzhfN8SZYoV/vvDN9TmpmsH
 rLTA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789853156; x=1790457956; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qPsnH49pRMF3R53AnkLADS5zvG6FopXBvh4vy62CYZk=;
 b=VCTFx+IBWgvVMJRTZqcJNYG/Uzes7lVrHnm84AF8LJBNEK18IdXDvW8iRaSmQSh1rW
 edzwnOng82UrWFqFQgY9psnpCMm801oMXpVcfgN7XM2HRItSmppp/6yTXUcqlDXiysoP
 epekDC/X+7i1pclkIe3J1BV21VsaVH7ltiev9jc1i1ER1veJqCHndv0BkxwYZA2i2dFA
 i9ACQgTmIBXMsARhm2hFSbbBWsk77DmNAQo8tI98SFq78YBYxpaOYU1cKCEnF4S6n3nW
 RfhYKZPwhRGsLr8H2Vcktu8swrtzX/lrsJcxP1n/Bs2SDZGcmb3Mmizmt4FMcIzfrvZ/
 J3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789853156; x=1790457956;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qPsnH49pRMF3R53AnkLADS5zvG6FopXBvh4vy62CYZk=;
 b=d/HtZWx6RvS24PzGjFUTIHTs1iYfwjYkL88Ev/4sw1+bvlnyBvrSWmb3p6ie2p6PAS
 4FcksAuNWXRiE3m4XYT/Q2OM0Jk6X2DVs4J22StxBfXl75S5KUgLUoLZdkxCIYd/c7qo
 I7j6KjsmeqovcfhxPdCWEJUj9ca288W7xLZC8cUxnyYCul+vK8flg9rEARc5nPGbqP+N
 VcRj7UjPEQyFD8TC2a3WgLSK3RCfCsYj+gOq08EdnmPTXn0z4E9wOBiSOPCyv3hbHTaO
 9qc/pjKAvrAzZjz5cHZfwjgjZ0qwQ5ssyha0DrJr7UvbVHyMfsTrg8kAkx9jnmCamr1H
 ZiTA==
X-Gm-Message-State: AFuF++nNzxuciRgQ/LqjQRMTTk8Nilqu9l3HfV+AQwjmTnOdfO7EozrZ
 QtHf6HxiRkkiH5Ndb+yfgwaWEGO3454IOtW1FxlYIXHU3O42piroUCWp0eXW0tdsfTXtybKAB/L
 Kb5QJsyBQHnQTGNZObq/iJjLzEVFGKyqz7a+5n8g=
X-Gm-Gg: AYBFou3GXbzCxrFJnl2Nrw4li+f47XnnLaMGeING4aOo/MAYKWoJfEQ8Uh8x+55h+3k
 XpTKlBg0U8fnAGr0hq8AmWUBvx4yMOWWX7F7sNsVztDmStu7XqS9mHe00WGysy7TYcYCuNs7pKS
 6dcxRVLqgZJOzN2zf550/MpbIgAudxaZSwym2fk1oW5U8uRHNQI9JTzNYFhoxHujQhLP2z7s9NV
 VExERdWPflf+pGe1/J3qu94zuoOrvdgVUioVsSOajlntclHI4aHpX7RoWRSkWWI/1VIcWUE5VGx
 oFUFhXnhsEgLx8hxqABJuZt8mEWfCtJaMU4pIjgam3PvwRw7qxuw8wnOR16r51syK9HNuymsulm
 y7yvhLgwkrb5Saw==
X-Received: by 2002:a05:6512:1595:b0:5b8:bc5e:b58b with SMTP id
 2adb3069b0e04-5b8c1967cb2mr1807162e87.67.1789853156302; Sat, 19 Sep 2026
 14:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260917093307.1092084-1-richard.henderson@linaro.org>
 <20260917093307.1092084-2-richard.henderson@linaro.org>
In-Reply-To: <20260917093307.1092084-2-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 19 Sep 2026 17:25:43 -0400
X-Gm-Features: AcwNN1X9qzempNpWImqqF3pBtUBIXy7MczoH98HH7Iw07J8XWeQh7nMV73-YTV0
Message-ID: <CAEdQ38ERKDR5vFhONrTZYSE1VfVyoaDsyMApNoWhfFAkWnmBXQ@mail.gmail.com>
Subject: Re: [PATCH v6 01/13] tcg: add tcg_gen_goto_jc{3}_{i32,i64,tl}
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:36::10;
 envelope-from=mattst88@gmail.com; helo=mail-lf2-x10.google.com
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

On Thu, Sep 17, 2026 at 5:33=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> From: Matt Turner <mattst88@gmail.com>
>
> At translation time the caller often already has the destination PC
> in a temp and knows the flags, cflags and cs_base any destination it
> may reach has to match because they are the same as the ones as the
> current block being generated.  But the promise that the flags are
> known (or unchanged) is subtle.
>
> So add new entry points with new semantics and --enable-debug-tcg
> checks against get_tb_cpu_state() at run time.
>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> [rth: Split out target changes; add jc3 variant; expand via tcg-op-def.h.=
inc]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/tcg-runtime.h      |  4 +++
>  include/tcg/tcg-op-common.h  | 29 +++++++++++++++++++
>  include/tcg/tcg-op.h         |  4 +++
>  include/tcg/tcg-op-def.h.inc |  2 ++
>  accel/tcg/cpu-exec.c         | 27 ++++++++++++++++++
>  tcg/tcg-op.c                 | 55 ++++++++++++++++++++++++++++++++----
>  6 files changed, 115 insertions(+), 6 deletions(-)
>
> diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
> index 0dda2079fd0..098c2235b5f 100644
> --- a/accel/tcg/tcg-runtime.h
> +++ b/accel/tcg/tcg-runtime.h
> @@ -9,6 +9,10 @@ DEF_HELPER_FLAGS_1(ctpop_i64, TCG_CALL_NO_RWG_SE, i64, i=
64)
>
>  DEF_HELPER_FLAGS_1(lookup_tb_ptr, TCG_CALL_NO_WG_SE, cptr, env)
>
> +#ifdef CONFIG_DEBUG_TCG
> +DEF_HELPER_FLAGS_4(goto_jc_check, TCG_CALL_NO_WG, void, env, i64, i64, i=
32)
> +#endif
> +
>  DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
>
>  #ifndef IN_HELPER_PROTO
> diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
> index 2bcf737aa56..5102f9bb4dd 100644
> --- a/include/tcg/tcg-op-common.h
> +++ b/include/tcg/tcg-op-common.h
> @@ -85,6 +85,35 @@ void tcg_gen_goto_tb(unsigned idx);
>   */
>  void tcg_gen_lookup_and_goto_ptr(void);
>
> +/**
> + * tcg_gen_goto_jc3_i32() - dispatch to the destination TB via the jump =
cache
> + * tcg_gen_goto_jc3_i64() - dispatch to the destination TB via the jump =
cache
> + * @pc: temp holding the destination guest PC
> + * @cs_base: temp holding the destination guest cs_base
> + * @flags: the destination guest flags
> + *
> + * The contract is that the values provided inline are exactly the
> + * cpu state that would be returned by TCGCPUOps::get_tb_cpu_state.
> + * --enable-debug-tcg checks the contract at runtime.
> + *
> + * Using those values, the lookup may be done inline.
> + *
> + * Actually declared and defined via tcg-op-def.h.inc.
> + */
> +
> +/**
> + * tcg_gen_goto_jc_i32() - dispatch to the destination TB via the jump c=
ache
> + * tcg_gen_goto_jc_i64() - dispatch to the destination TB via the jump c=
ache
> + * @pc: temp holding the destination guest PC
> + *
> + * Similar, but cs_base and flags are taken from the current TB.
> + *
> + * Thus the contract is that no cpu state changes have occured

typo: occurred

> + * that affect the translation block flags.
> + *
> + * Actually declared and defined via tcg-op-def.h.inc.
> + */
> +
>  void tcg_gen_plugin_cb(unsigned from);
>  QEMU_ARG_NONNULL void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned memi=
nfo);
>
> diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
> index a7d001c959c..02732652b8f 100644
> --- a/include/tcg/tcg-op.h
> +++ b/include/tcg/tcg-op.h
> @@ -175,6 +175,8 @@ typedef TCGv_i64 TCGv;
>  #define tcg_gen_atomic_umax_fetch_tl tcg_gen_atomic_umax_fetch_i64
>  #define tcg_gen_dup_tl_vec  tcg_gen_dup_i64_vec
>  #define tcg_gen_dup_tl tcg_gen_dup_i64
> +#define tcg_gen_goto_jc_tl tcg_gen_goto_jc_i64
> +#define tcg_gen_goto_jc3_tl tcg_gen_goto_jc3_i64
>  #define dup_const_tl dup_const
>  #else
>  #define tcg_gen_movi_tl tcg_gen_movi_i32
> @@ -299,6 +301,8 @@ typedef TCGv_i64 TCGv;
>  #define tcg_gen_atomic_umax_fetch_tl tcg_gen_atomic_umax_fetch_i32
>  #define tcg_gen_dup_tl_vec  tcg_gen_dup_i32_vec
>  #define tcg_gen_dup_tl tcg_gen_dup_i32
> +#define tcg_gen_goto_jc_tl tcg_gen_goto_jc_i32
> +#define tcg_gen_goto_jc3_tl tcg_gen_goto_jc3_i32
>
>  #define dup_const_tl(VECE, C)                                      \
>      (__builtin_constant_p(VECE)                                    \
> diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
> index b60edca6e42..97024fcb222 100644
> --- a/include/tcg/tcg-op-def.h.inc
> +++ b/include/tcg/tcg-op-def.h.inc
> @@ -31,6 +31,8 @@ DEF2(ext16u, TCGV, TCGV)
>  DEF4(extract, TCGV, TCGV, unsigned, unsigned)
>  DEF4(extract2, TCGV, TCGV, TCGV, unsigned)
>  DEF3(eqv, TCGV, TCGV, TCGV)
> +DEF1(goto_jc, TCGV)
> +DEF3(goto_jc3, TCGV, TCGv_i64, unsigned)
>  DEF3(ld, TCGV, TCGv_ptr, tcg_target_long)
>  DEF3(ld8s, TCGV, TCGv_ptr, tcg_target_long)
>  DEF3(ld8u, TCGV, TCGv_ptr, tcg_target_long)
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 5226cfb7650..1493fe0c963 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -407,6 +407,33 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
>      return tb->tc.ptr;
>  }
>
> +#ifdef CONFIG_DEBUG_TCG
> +/**
> + * helper_goto_jc_check: check the contract of tcg_gen_goto_jc_*()
> + * @env: current cpu state
> + * @pc: the destination pc the caller passed at translation time
> + * @cs_base: the cs_base the dispatching block was translated with
> + * @flags: the flags the dispatching block was translated with
> + *
> + * A goto_jc looks the destination up on the caller's @pc with the flags=
 and
> + * cs_base of the block doing the dispatching, so all three have to be w=
hat
> + * get_tb_cpu_state() reports by the time the dispatch runs.  That is a
> + * property of the translator, not of the generated code, so check it he=
re
> + * rather than leaving a target that gets it wrong to be debugged as a b=
lock
> + * running with someone else's flags.
> + */
> +void HELPER(goto_jc_check)(CPUArchState *env, uint64_t pc, uint64_t cs_b=
ase,
> +                           uint32_t flags)
> +{
> +    CPUState *cpu =3D env_cpu(env);
> +    TCGTBCPUState s =3D cpu->cc->tcg_ops->get_tb_cpu_state(cpu);
> +
> +    assert(s.pc =3D=3D pc);
> +    assert(s.flags =3D=3D flags);
> +    assert(s.cs_base =3D=3D cs_base);
> +}
> +#endif
> +
>  /* Return the current PC from CPU, which may be cached in TB. */
>  static vaddr log_pc(CPUState *cpu, const TranslationBlock *tb)
>  {
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index d271d83a7d2..09d9a7963ae 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -277,6 +277,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned me=
minfo)
>  #define DEF6(NAME, T1, T2, T3, T4, T5, T6) \
>      QEMU_ARG_NONNULL static void glue(gen_,NAME)(TCGType, T1, T2, T3, T4=
, T5, T6);
>
> +#define TCGv_i64  TCGTemp *
>  #define TCGv_ptr  TCGTemp *
>  #define TCGV      TCGTemp *
>  #define TINT      int64_t
> @@ -286,6 +287,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned me=
minfo)
>  #undef TINT
>  #undef TCGV
>  #undef TCGv_ptr
> +#undef TCGv_i64
>
>  #undef DEF1
>  #undef DEF2
> @@ -1940,20 +1942,61 @@ void tcg_gen_goto_tb(unsigned idx)
>      tcg_gen_op1i(INDEX_op_goto_tb, 0, idx);
>  }
>
> +static void gen_lookup_tb_ptr_and_goto(void)
> +{
> +    TCGv_ptr ptr =3D tcg_temp_ebb_new_ptr();
> +
> +    gen_helper_lookup_tb_ptr(ptr, tcg_env);
> +    tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
> +    tcg_temp_free_ptr(ptr);
> +}
> +
>  void tcg_gen_lookup_and_goto_ptr(void)
>  {
> -    TCGv_ptr ptr;
> -
>      if (tcg_ctx->gen_tb->cflags & CF_NO_GOTO_PTR) {
>          tcg_gen_exit_tb(NULL, 0);
>          return;
>      }
>
>      plugin_gen_disable_mem_helpers();
> -    ptr =3D tcg_temp_ebb_new_ptr();
> -    gen_helper_lookup_tb_ptr(ptr, tcg_env);
> -    tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
> -    tcg_temp_free_ptr(ptr);
> +    gen_lookup_tb_ptr_and_goto();
> +}
> +
> +static void gen_goto_jc3(TCGType type, TCGTemp *pc,
> +                         TCGTemp *cs_base, unsigned flags)
> +{
> +    plugin_gen_disable_mem_helpers();

[...]

> +    gen_lookup_tb_ptr_and_goto();
> +}

This drops the CF_NO_GOTO_PTR check that tcg_gen_lookup_and_goto_ptr()
does, so every call site converted to goto_jc keeps chaining when the
cflags say not to.  Patch 9 doesn't restore it either: CF_NO_GOTO_PTR
there only selects the helper over the inline probe, and the helper
looks up with curr_cflags() and chains.

CF_NO_GOTO_PTR is set for gdb single-step and in
cpu_exec_step_atomic(), so single-step runs away on all five converted
targets.  With qemu-alpha -g and a raw RSP client sending 's',
counting "Trace" lines
in -d exec:

  6c9d78bbc4:              1 TB per step, every step
  + this series:           step 271:  5835 TBs
                           step 277:  1737 TBs
                           step 281: 40723 TBs, pc advanced 92 bytes

Fixed by mirroring tcg_gen_lookup_and_goto_ptr():

    static void gen_goto_jc3(TCGType type, TCGTemp *pc,
                             TCGTemp *cs_base, unsigned flags)
    {
        if (tcg_ctx->gen_tb->cflags & CF_NO_GOTO_PTR) {
            tcg_gen_exit_tb(NULL, 0);
            return;
        }

        plugin_gen_disable_mem_helpers();

Note this also makes the comment in target/ppc/translate.c wrong in
gen_lookup_and_goto_ptr() and ppc_tr_tb_stop():

        /*
         * tcg_gen_lookup_and_goto_ptr will exit the TB if
         * CF_NO_GOTO_PTR is set. Count insns now.
         */
        if (ctx->base.tb->flags & CF_NO_GOTO_PTR) {
            pmu_count_insns(ctx);
        }

        tcg_gen_goto_jc_tl(cpu_nip);

