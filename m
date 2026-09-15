Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DC7C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 23:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6cnt-0002zV-Bs; Tue, 15 Sep 2026 19:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6cns-0002zN-9n
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 19:43:08 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6cnp-0003T7-Rf
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 19:43:07 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2d91ede8035so3834095ad.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:43:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789515784; cv=none;
 d=google.com; s=arc-20260327;
 b=fepX7I2iGCU0d3cK11/YLrwEzAOhqwu9369ycMDJTn5e5R1JGDfOcv3KJGZy8C2GRs
 VCDUtXbJfL2/2Huty35GIPW7fYaVEgcsDtS7szp9MUGsG9+7za7BwO+RwiT2f8xIcAx7
 tN+inscMEgoFiOQihpWXGSLCaeKXFRTPxclkxt8MRvtWFshs2JVgMY96c3nNHPHTpQAC
 xSktQWaUhZFH8+3JocmPO3GHbRv/08OvvVJEk5mSU376Vn3A9CHheFVJdpjTI4KX/sNi
 nyvaT+f1k0mNJlAhttGHaRtnRBHv3o+IweO5HR4y2QiRGmN1EuYdLYOCN7Jmvf4PgnQ4
 /N3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EPFZM5n4BI6WZhdVXnGiR0bOe0fScX3sKrxX1IC+IJs=;
 fh=AvdUgREFPBGnLKtDjjPes0731VMeA8MKp16N55VMDg4=;
 b=g+lPhXaUvQk52D7bFU3E2qgUfJluja5uhwWQxUv5JR4jCfpkIkO+2DkGclhidSd/Yu
 UdOCYLehl3AQ3azuPy9Wc7+oUZlpjN0FldAkwhtPfzDov0VGGkffO/RgAQe8K82//YOJ
 SqIRjYQjhjewFja5QSVTMUbU8G9c5vIcSeGnr+SdpRsRbhn1b0dCumPygc4fuKhbjG98
 vc8UlfQt0Kv+5280ykiYAamO6Met4JCJYStSRKInKgomjpR5o8ro3TLUx3g6tRw+4Ox7
 whvZnGTBjn82VyVzouM0va7zuQVhFsT7qY1pcdKpbqub87hWKCnoiqj1LYdX+fvE+d3Z
 hD/w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789515784; x=1790120584; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EPFZM5n4BI6WZhdVXnGiR0bOe0fScX3sKrxX1IC+IJs=;
 b=h3RIDmYCcz+2mcaiDaDnS4284C/ya28FUwtf7gXPHWbKOhqZKTwETboWBbmEiX/gZg
 iZAMtC5/YZzDekbGyHYDnuhrEDOO1M5hGTnLUNHlqAJoYTYCFWiLpCvepZv0XAhxRhEt
 +wqg4nutbWkscedoU/5WXHazOf1pc53U1Axz5Dv9t51VGwVjMnpFN2K/eYWh24Tp1A1p
 M74lAAh3Mu/m1dD3QTdOMJnS8gAG65bKNVyErV8IiM6dYNDGKXFQhMVWL9/1S9jUnk75
 HuzUNwkCPE+ROjZYtrJTrfvhUbRNCt52m0c0ez8kirNDzt9rjYM/haW2vMR/xiKzeSWH
 WdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789515784; x=1790120584;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EPFZM5n4BI6WZhdVXnGiR0bOe0fScX3sKrxX1IC+IJs=;
 b=tBUxpE+IfSIjt/TjGwz8kmsXgl0GQl8d71ddku8tmwb1izl8MykB5PdVw2NlQvPTlo
 IAa1rMPQG8sB78esJP5dWuPkX1gA+FcsmCjA3pBz2oz8w+H79hB2y1c+oqH2wHALjrUa
 6O7+tR7/cZ9/fNDykLNN17OGG6HkE84HYGnVn/I5/PFuYdxz2yprgX2S0TDoZzPhG9+G
 nHj0S5O6MrX2rAxRYjxttvAD4AGXuW26C60IHfU2VD+cuKmohWd71FhxqWGtsk9APyoP
 llTacn37DMRLtWPwwjBUW6r3wcmnfAyXG1/kykDkVAUVF00Ep3KaDhtHayMMyOg/mzF/
 oJ2A==
X-Gm-Message-State: AFuF++nAgTCCJgyaGly4Y7JN04DsxXtc6IencEy27gVek5LLxIrwcQeB
 nGYdyMa//Fa8k74Cv2dZbYPMD/sr8BVzjMv+xdPHqIOQ6MNTtkclaqbTocf+ZGL+Km1gLHCE4j5
 Nv5awRfFCW0XggAtrx04nsqoR96AH/VA=
X-Gm-Gg: AYBFou27l3jXJdpTmd34+gJSBEszx6q47k0Flb6AOpl3yrXde4DNcXxHgY4BrLA9PuX
 zc3vMUx0KZ9nKCBGCKeWzNz0cCArjqQCCpDj3vl0ZA+eZ0evAbc1zHb87LBsl+lQ0OtrPE5g5o1
 MiboPMUTuUHhqIK9zV5s0b4klZj9N3xLe1onu1GY478UqVzJmELAoQRQgJae8GAl8y7EZLqBMR0
 KlaL7nYCsJkgifSAniNd5doVf24TAZ11vwx+/FuEG11fs1ZZcYY/ZfLXgLzbzWMzu6kzJFTmadx
 31GNKAgPb1MDRQBM46ioiIab116KGuIOXSnoWyeR8HJcvb1wgyvG4tSx1RyXRmNXssDT46/zfL3
 YMP3zMoZtHIE=
X-Received: by 2002:a17:902:f684:b0:2d1:134:b86e with SMTP id
 d9443c01a7336-2dd8dd1a880mr8403085ad.2.1789515783820; Tue, 15 Sep 2026
 16:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260915154502.4106597-1-brian.cain@oss.qualcomm.com>
 <20260915154502.4106597-2-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260915154502.4106597-2-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Tue, 15 Sep 2026 17:42:50 -0600
X-Gm-Features: AcwNN1VfkTtDQYE2QPoMcJ7o4rB4Irr9hgC0iC9uqYkxPMu7VXwInHaSfX3rZlI
Message-ID: <CAATN3NqXpi1bdZXHT2=imVdOPE=7d5cbr45MtAeci=iRgWoYLg@mail.gmail.com>
Subject: Re: [PATCH 1/4] target/hexagon: pass the packet PC to the
 k0lock/tlblock helpers
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: multipart/alternative; boundary="0000000000009d578d065b8e1c7d"
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
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

--0000000000009d578d065b8e1c7d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 9:45=E2=80=AFAM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

> Hand the k0lock/tlblock helpers the packet PC as a constant instead
> of relying on next_PC's opcode-dependent staging.
>

The word "helpers" isn't entirely accurate.  The QEMU helpers already take
PC as an argument.
This patch adds the PC argument to the implementation functions
hex_tlb_lock/hex_k0_lock called from the respective helpers.
See my comment below on hex_common.py.


>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/hex_mmu.h     |  9 +++++----
>  target/hexagon/sys_macros.h  |  4 ++--
>  target/hexagon/hex_mmu.c     | 15 ++++++++-------
>  target/hexagon/op_helper.c   | 15 ++++++++-------
>  target/hexagon/hex_common.py |  6 +++++-
>  5 files changed, 28 insertions(+), 21 deletions(-)
>
> diff --git a/target/hexagon/hex_mmu.h b/target/hexagon/hex_mmu.h
> index 56b2c4a89d0..4eaf15c4996 100644
> --- a/target/hexagon/hex_mmu.h
> +++ b/target/hexagon/hex_mmu.h
> @@ -17,12 +17,13 @@ extern uint32_t hex_tlb_lookup(CPUHexagonState *env,
> uint32_t ssr, uint32_t VA);
>  extern void hex_mmu_on(CPUHexagonState *env);
>  extern void hex_mmu_off(CPUHexagonState *env);
>  extern void hex_mmu_mode_change(CPUHexagonState *env);
> -extern bool hex_tlb_find_match(CPUHexagonState *env, uint32_t VA,
> -                               MMUAccessType access_type, hwaddr *PA, in=
t
> *prot,
> -                               uint64_t *size, int32_t *excp, int
> mmu_idx);
> +extern bool hex_tlb_find_match(CPUHexagonState *env, target_ulong VA,
> +                               MMUAccessType access_type,
> +                               hwaddr *PA, int *prot, uint64_t *size,
> +                               int32_t *excp, int mmu_idx);
>

Why is this change included in this patch?


>  extern int hex_tlb_check_overlap(CPUHexagonState *env, uint64_t entry,
>                                   uint64_t index);
> -extern void hex_tlb_lock(CPUHexagonState *env);
> +extern void hex_tlb_lock(CPUHexagonState *env, target_ulong PC);
>  extern void hex_tlb_unlock(CPUHexagonState *env);
>  void dump_mmu(MonitorHMP *hmp, CPUHexagonState *env);
>  #endif
> diff --git a/target/hexagon/sys_macros.h b/target/hexagon/sys_macros.h
> index a5b9b7f2592..72179d49ab3 100644
> --- a/target/hexagon/sys_macros.h
> +++ b/target/hexagon/sys_macros.h
> @@ -145,10 +145,10 @@
>  #define fDCINVIDX(REG)
>  #define fDCINVA(REG) do { REG =3D REG; } while (0) /* Nothing to do in q=
emu
> */
>
> -#define fSET_TLB_LOCK()       hex_tlb_lock(env);
> +#define fSET_TLB_LOCK()       hex_tlb_lock(env, PC);
>  #define fCLEAR_TLB_LOCK()     hex_tlb_unlock(env);
>
> -#define fSET_K0_LOCK()        hex_k0_lock(env);
> +#define fSET_K0_LOCK()        hex_k0_lock(env, PC);
>  #define fCLEAR_K0_LOCK()      hex_k0_unlock(env);
>
>  #define fTLB_IDXMASK(INDEX) \
> diff --git a/target/hexagon/hex_mmu.c b/target/hexagon/hex_mmu.c
> index d6ee7c40798..d7acaae5ac8 100644
> --- a/target/hexagon/hex_mmu.c
> +++ b/target/hexagon/hex_mmu.c
> @@ -156,7 +156,7 @@ static inline void print_thread_states(const char *st=
r)
>      }
>  }
>
> -void hex_tlb_lock(CPUHexagonState *env)
> +void hex_tlb_lock(CPUHexagonState *env, target_ulong PC)
>  {
>      qemu_log_mask(CPU_LOG_MMU, "hex_tlb_lock: " TARGET_FMT_ld "\n",
>                    env->threadId);
> @@ -170,7 +170,6 @@ void hex_tlb_lock(CPUHexagonState *env)
>      uint8_t tlb_lock =3D GET_SYSCFG_FIELD(SYSCFG_TLBLOCK, syscfg);
>      if (tlb_lock) {
>          if (env->tlb_lock_state =3D=3D HEX_LOCK_QUEUED) {
> -            env->next_PC +=3D 4;
>              env->tlb_lock_count++;
>              env->tlb_lock_state =3D HEX_LOCK_OWNER;
>              SET_SYSCFG_FIELD(env, SYSCFG_TLBLOCK, 1);
> @@ -178,19 +177,21 @@ void hex_tlb_lock(CPUHexagonState *env)
>          }
>          if (env->tlb_lock_state =3D=3D HEX_LOCK_OWNER) {
>              qemu_log_mask(CPU_LOG_MMU | LOG_GUEST_ERROR,
> -                          "Double tlblock at PC: 0x%" PRIx32
> -                          ", thread may hang\n",
> -                          env->next_PC);
> -            env->next_PC +=3D 4;
> +                          "Double tlblock at PC: 0x%x, thread may
> hang\n", PC);
>

Don't use %x, use TARGET_FMT_lx.


>              CPUState *cs =3D env_cpu(env);
>              cpu_interrupt(cs, CPU_INTERRUPT_HALT);
>              return;
>          }
>          env->tlb_lock_state =3D HEX_LOCK_WAITING;
> +        /*
> +         * next_PC has already been advanced past this packet.  Rewind i=
t
> +         * so that the thread re-executes the tlblock when it is woken b=
y
> +         * the thread that releases the lock.
> +         */
> +        env->next_PC =3D PC;
>          CPUState *cs =3D env_cpu(env);
>          cpu_interrupt(cs, CPU_INTERRUPT_HALT);
>      } else {
> -        env->next_PC +=3D 4;
>          env->tlb_lock_count++;
>          env->tlb_lock_state =3D HEX_LOCK_OWNER;
>          SET_SYSCFG_FIELD(env, SYSCFG_TLBLOCK, 1);
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 0d08ac77361..07ba639449c 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -1278,7 +1278,7 @@ void HELPER(modify_ssr)(CPUHexagonState *env,
> uint32_t new, uint32_t old)
>      hexagon_modify_ssr(env, new, old);
>  }
>
> -static void hex_k0_lock(CPUHexagonState *env)
> +static void hex_k0_lock(CPUHexagonState *env, target_ulong PC)
>  {
>      HexagonCPU *cpu =3D env_archcpu(env);
>      CPUState *cs =3D env_cpu(env);
> @@ -1292,7 +1292,6 @@ static void hex_k0_lock(CPUHexagonState *env)
>                                 env->threadId) : 0;
>      if (GET_SYSCFG_FIELD(SYSCFG_K0LOCK, syscfg)) {
>          if (env->k0_lock_state =3D=3D HEX_LOCK_QUEUED) {
> -            env->next_PC +=3D 4;
>              env->k0_lock_count++;
>              env->k0_lock_state =3D HEX_LOCK_OWNER;
>              SET_SYSCFG_FIELD(env, SYSCFG_K0LOCK, 1);
> @@ -1300,19 +1299,21 @@ static void hex_k0_lock(CPUHexagonState *env)
>          }
>          if (env->k0_lock_state =3D=3D HEX_LOCK_OWNER) {
>              qemu_log_mask(LOG_GUEST_ERROR,
> -                          "Double k0lock at PC: 0x%" PRIx32
> -                          ", thread may hang\n",
> -                          env->next_PC);
> -            env->next_PC +=3D 4;
> +                          "Double k0lock at PC: 0x%x, thread may hang\n"=
,
> PC);
>

Don't use %x, use TARGET_FMT_lx.


>              cpu_interrupt(cs, CPU_INTERRUPT_HALT);
>              cpu_loop_exit(cs);
>              return;
>          }
>          env->k0_lock_state =3D HEX_LOCK_WAITING;
> +        /*
> +         * next_PC has already been advanced past this packet.  Rewind i=
t
> +         * so that the thread re-executes the k0lock when it is woken by
> +         * the thread that releases the lock.
> +         */
> +        env->next_PC =3D PC;
>          cpu_interrupt(cs, CPU_INTERRUPT_HALT);
>          cpu_loop_exit(cs);
>      } else {
> -        env->next_PC +=3D 4;
>          env->k0_lock_count++;
>          env->k0_lock_state =3D HEX_LOCK_OWNER;
>          SET_SYSCFG_FIELD(env, SYSCFG_K0LOCK, 1);
> diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
> index c180c19b092..1bd31f76a4f 100755
> --- a/target/hexagon/hex_common.py
> +++ b/target/hexagon/hex_common.py
> @@ -284,7 +284,11 @@ def need_ea(tag):
>
>
>  def need_PC(tag):
> -    return "A_IMPLICIT_READS_PC" in attribdict[tag]
> +    return (
> +        "A_IMPLICIT_READS_PC" in attribdict[tag]
> +        or tag =3D=3D "Y2_k0lock"
> +        or tag =3D=3D "Y2_tlblock"
> +    )
>

This isn't needed.  These 2 opcodes already have A_IMPLICIT_READS_PC set.
Look for fSET_K0_LOCK and fSET_TLB_LOCK in calculate_attribs in
hex_common.py.


Thanks,
Taylor

--0000000000009d578d065b8e1c7d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 15,=
 2026 at 9:45=E2=80=AFAM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">Hand the k0lock/tlblock helpers the =
packet PC as a constant instead<br>
of relying on next_PC&#39;s opcode-dependent staging.<br></blockquote><div>=
<br></div><div>The word &quot;helpers&quot; isn&#39;t entirely accurate.=C2=
=A0 The QEMU helpers already take PC as an argument.</div><div>This patch a=
dds the PC argument to the implementation functions hex_tlb_lock/hex_k0_loc=
k called from the respective helpers.</div><div>See my comment below on hex=
_common.py.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/hex_mmu.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 9 +++++----<br>
=C2=A0target/hexagon/sys_macros.h=C2=A0 |=C2=A0 4 ++--<br>
=C2=A0target/hexagon/hex_mmu.c=C2=A0 =C2=A0 =C2=A0| 15 ++++++++-------<br>
=C2=A0target/hexagon/op_helper.c=C2=A0 =C2=A0| 15 ++++++++-------<br>
=C2=A0target/hexagon/hex_common.py |=C2=A0 6 +++++-<br>
=C2=A05 files changed, 28 insertions(+), 21 deletions(-)<br>
<br>
diff --git a/target/hexagon/hex_mmu.h b/target/hexagon/hex_mmu.h<br>
index 56b2c4a89d0..4eaf15c4996 100644<br>
--- a/target/hexagon/hex_mmu.h<br>
+++ b/target/hexagon/hex_mmu.h<br>
@@ -17,12 +17,13 @@ extern uint32_t hex_tlb_lookup(CPUHexagonState *env, ui=
nt32_t ssr, uint32_t VA);<br>
=C2=A0extern void hex_mmu_on(CPUHexagonState *env);<br>
=C2=A0extern void hex_mmu_off(CPUHexagonState *env);<br>
=C2=A0extern void hex_mmu_mode_change(CPUHexagonState *env);<br>
-extern bool hex_tlb_find_match(CPUHexagonState *env, uint32_t VA,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MMUAccessType access_type, hwaddr *PA=
, int *prot,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t *size, int32_t *excp, int mm=
u_idx);<br>
+extern bool hex_tlb_find_match(CPUHexagonState *env, target_ulong VA,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MMUAccessType access_type,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hwaddr *PA, int *prot, uint64_t *size=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int32_t *excp, int mmu_idx);<br></blo=
ckquote><div><br></div><div>Why is this change included in this patch?</div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0extern int hex_tlb_check_overlap(CPUHexagonState *env, uint64_t entry=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t index);<br>
-extern void hex_tlb_lock(CPUHexagonState *env);<br>
+extern void hex_tlb_lock(CPUHexagonState *env, target_ulong PC);<br>
=C2=A0extern void hex_tlb_unlock(CPUHexagonState *env);<br>
=C2=A0void dump_mmu(MonitorHMP *hmp, CPUHexagonState *env);<br>
=C2=A0#endif<br>
diff --git a/target/hexagon/sys_macros.h b/target/hexagon/sys_macros.h<br>
index a5b9b7f2592..72179d49ab3 100644<br>
--- a/target/hexagon/sys_macros.h<br>
+++ b/target/hexagon/sys_macros.h<br>
@@ -145,10 +145,10 @@<br>
=C2=A0#define fDCINVIDX(REG)<br>
=C2=A0#define fDCINVA(REG) do { REG =3D REG; } while (0) /* Nothing to do i=
n qemu */<br>
<br>
-#define fSET_TLB_LOCK()=C2=A0 =C2=A0 =C2=A0 =C2=A0hex_tlb_lock(env);<br>
+#define fSET_TLB_LOCK()=C2=A0 =C2=A0 =C2=A0 =C2=A0hex_tlb_lock(env, PC);<b=
r>
=C2=A0#define fCLEAR_TLB_LOCK()=C2=A0 =C2=A0 =C2=A0hex_tlb_unlock(env);<br>
<br>
-#define fSET_K0_LOCK()=C2=A0 =C2=A0 =C2=A0 =C2=A0 hex_k0_lock(env);<br>
+#define fSET_K0_LOCK()=C2=A0 =C2=A0 =C2=A0 =C2=A0 hex_k0_lock(env, PC);<br=
>
=C2=A0#define fCLEAR_K0_LOCK()=C2=A0 =C2=A0 =C2=A0 hex_k0_unlock(env);<br>
<br>
=C2=A0#define fTLB_IDXMASK(INDEX) \<br>
diff --git a/target/hexagon/hex_mmu.c b/target/hexagon/hex_mmu.c<br>
index d6ee7c40798..d7acaae5ac8 100644<br>
--- a/target/hexagon/hex_mmu.c<br>
+++ b/target/hexagon/hex_mmu.c<br>
@@ -156,7 +156,7 @@ static inline void print_thread_states(const char *str)=
<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-void hex_tlb_lock(CPUHexagonState *env)<br>
+void hex_tlb_lock(CPUHexagonState *env, target_ulong PC)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0qemu_log_mask(CPU_LOG_MMU, &quot;hex_tlb_lock: &quot; T=
ARGET_FMT_ld &quot;\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&g=
t;threadId);<br>
@@ -170,7 +170,6 @@ void hex_tlb_lock(CPUHexagonState *env)<br>
=C2=A0 =C2=A0 =C2=A0uint8_t tlb_lock =3D GET_SYSCFG_FIELD(SYSCFG_TLBLOCK, s=
yscfg);<br>
=C2=A0 =C2=A0 =C2=A0if (tlb_lock) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (env-&gt;tlb_lock_state =3D=3D HEX_LOC=
K_QUEUED) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;next_PC +=3D 4;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;tlb_lock_count++;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;tlb_lock_state =3D =
HEX_LOCK_OWNER;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SET_SYSCFG_FIELD(env, SYSCF=
G_TLBLOCK, 1);<br>
@@ -178,19 +177,21 @@ void hex_tlb_lock(CPUHexagonState *env)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (env-&gt;tlb_lock_state =3D=3D HEX_LOC=
K_OWNER) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(CPU_LOG_MMU |=
 LOG_GUEST_ERROR,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;Double tlblock at PC: 0x%&quot; PRIx32<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;, thread may hang\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 env-&gt;next_PC);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;next_PC +=3D 4;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;Double tlblock at PC: 0x%x, thread may hang\n&quot;=
, PC);<br></blockquote><div><br></div><div>Don&#39;t use %x, use TARGET_FMT=
_lx.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPUState *cs =3D env_cpu(en=
v);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_interrupt(cs, CPU_INTER=
RUPT_HALT);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;tlb_lock_state =3D HEX_LOCK_WAITI=
NG;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* next_PC has already been advanced past=
 this packet.=C2=A0 Rewind it<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* so that the thread re-executes the tlb=
lock when it is woken by<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* the thread that releases the lock.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;next_PC =3D PC;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPUState *cs =3D env_cpu(env);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_interrupt(cs, CPU_INTERRUPT_HALT);<br=
>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;next_PC +=3D 4;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;tlb_lock_count++;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;tlb_lock_state =3D HEX_LOCK_OWNER=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SET_SYSCFG_FIELD(env, SYSCFG_TLBLOCK, 1);=
<br>
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c<br>
index 0d08ac77361..07ba639449c 100644<br>
--- a/target/hexagon/op_helper.c<br>
+++ b/target/hexagon/op_helper.c<br>
@@ -1278,7 +1278,7 @@ void HELPER(modify_ssr)(CPUHexagonState *env, uint32_=
t new, uint32_t old)<br>
=C2=A0 =C2=A0 =C2=A0hexagon_modify_ssr(env, new, old);<br>
=C2=A0}<br>
<br>
-static void hex_k0_lock(CPUHexagonState *env)<br>
+static void hex_k0_lock(CPUHexagonState *env, target_ulong PC)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0HexagonCPU *cpu =3D env_archcpu(env);<br>
=C2=A0 =C2=A0 =C2=A0CPUState *cs =3D env_cpu(env);<br>
@@ -1292,7 +1292,6 @@ static void hex_k0_lock(CPUHexagonState *env)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;threadId) : 0;<br>
=C2=A0 =C2=A0 =C2=A0if (GET_SYSCFG_FIELD(SYSCFG_K0LOCK, syscfg)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (env-&gt;k0_lock_state =3D=3D HEX_LOCK=
_QUEUED) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;next_PC +=3D 4;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;k0_lock_count++;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;k0_lock_state =3D H=
EX_LOCK_OWNER;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SET_SYSCFG_FIELD(env, SYSCF=
G_K0LOCK, 1);<br>
@@ -1300,19 +1299,21 @@ static void hex_k0_lock(CPUHexagonState *env)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (env-&gt;k0_lock_state =3D=3D HEX_LOCK=
_OWNER) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(LOG_GUEST_ERR=
OR,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;Double k0lock at PC: 0x%&quot; PRIx32<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;, thread may hang\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 env-&gt;next_PC);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;next_PC +=3D 4;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;Double k0lock at PC: 0x%x, thread may hang\n&quot;,=
 PC);<br></blockquote><div><br></div><div>Don&#39;t use %x, use TARGET_FMT_=
lx.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_interrupt(cs, CPU_INTER=
RUPT_HALT);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_loop_exit(cs);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;k0_lock_state =3D HEX_LOCK_WAITIN=
G;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* next_PC has already been advanced past=
 this packet.=C2=A0 Rewind it<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* so that the thread re-executes the k0l=
ock when it is woken by<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* the thread that releases the lock.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;next_PC =3D PC;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_interrupt(cs, CPU_INTERRUPT_HALT);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_loop_exit(cs);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;next_PC +=3D 4;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;k0_lock_count++;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;k0_lock_state =3D HEX_LOCK_OWNER;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SET_SYSCFG_FIELD(env, SYSCFG_K0LOCK, 1);<=
br>
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py<br=
>
index c180c19b092..1bd31f76a4f 100755<br>
--- a/target/hexagon/hex_common.py<br>
+++ b/target/hexagon/hex_common.py<br>
@@ -284,7 +284,11 @@ def need_ea(tag):<br>
<br>
<br>
=C2=A0def need_PC(tag):<br>
-=C2=A0 =C2=A0 return &quot;A_IMPLICIT_READS_PC&quot; in attribdict[tag]<br=
>
+=C2=A0 =C2=A0 return (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;A_IMPLICIT_READS_PC&quot; in attribdict[=
tag]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 or tag =3D=3D &quot;Y2_k0lock&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 or tag =3D=3D &quot;Y2_tlblock&quot;<br>
+=C2=A0 =C2=A0 )<br></blockquote><div><br></div><div>This isn&#39;t needed.=
=C2=A0 These 2 opcodes already have A_IMPLICIT_READS_PC set.</div><div>Look=
 for fSET_K0_LOCK and fSET_TLB_LOCK in calculate_attribs in hex_common.py.<=
/div><div>=C2=A0</div><div><br></div><div>Thanks,</div><div>Taylor</div><di=
v><br></div></div></div>

--0000000000009d578d065b8e1c7d--

