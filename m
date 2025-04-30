Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AC8C369DC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 00:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9uyd-0004nP-Dl; Tue, 29 Apr 2025 20:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u9uyY-0004kZ-MG; Tue, 29 Apr 2025 20:06:58 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u9uyV-0007yX-MD; Tue, 29 Apr 2025 20:06:58 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-736dd9c4b40so411951b3a.0; 
 Tue, 29 Apr 2025 17:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745971612; x=1746576412; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DZu9v8h0D1Rx+bBqJwETekmmLEFUmfFO+gechqg4ENU=;
 b=nbf4r7crWX9d81fNRUA6Fussxv+gay0+8PhljYFppk3hV51/ZTPCXhs0Im80WfPHNv
 BGuJvR50J1lQ2CKZL9T8o4eTVEc8WIWxRjFrPG2jOmr9/h//HiXEupkveI2boOiDflQ7
 6yCTQumhPchHvetIK3kDwJheLNxSdIpsUFXBcj9xfGGrpcEdJAtSxRlWSXGSyOvrkqm4
 1bStptgDGFJtk1QMzRmGLX8lsg5TZBDm+j+y5ld2Huc3uFmQbEXl5vDDAAsFjdUERbat
 vrAd4Tmr0ng/ecH+Bt31wC4KnbkFwPW+eiDWWwZmvd/qB2W0WuHABglYqAKvAElmGYQf
 B2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745971612; x=1746576412;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DZu9v8h0D1Rx+bBqJwETekmmLEFUmfFO+gechqg4ENU=;
 b=HS+tp2ItArR8Zrxi9XV8IcuwcTEsQkZR94dwvzZuXkq/rOrKQZwW33zAdQITFM9Yil
 2uYuP90Tvt4+NdxS03oJzaH32B7Cxru9XJD4PWz2hPIiM9Oyuq7A+qzdyGIIs35D0veU
 oKkzgtAgFRcETcU6B9hzI1I1jQ94Im2Z9MuN3iFIrkvjSDIdEJcWGYXXO36hFHvC1/zv
 C5mK4vj0mwvovGAEzMjG2FDpNfvSh5rkGjGTZj0wLels/mAsEUzHGQqbBzUHwZFOQ9jM
 CCtPN8fB56mm3yPo49dCJToaBawPO63QXb85xc7c4iTuZ0KR3LQG1PbSvHr6fVaVq591
 7+0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4Mzgtkf2y7O5yLmuN76wZ/10iMlCiyLyrM12MlMOzzDM36uH/d7nMoqC1xP8Af3JljTspsunS0K/hrw==@nongnu.org,
 AJvYcCUQEJ3G3hUimVk1q3nFI18lF6qfeLagEe5+6/y6LrJcXIp8IlxzhOg7RGG6qQqE/Rc+ivegJHoS4A==@nongnu.org,
 AJvYcCVtHCWAMlQdWDTPHlHN202OaPVRDCZdElz6UwXKVSWBxO1W7VXfcHpKcOeD1wlN5wMhsubAQ9RUcu90ug==@nongnu.org,
 AJvYcCWh2fJpv0AUIzqvqPwt8brXWCRzHYDVrKxC/nWZqEGCZSR++bgB8Tos57rFuTKrGsqaOy066PxDmk3GDQ==@nongnu.org,
 AJvYcCX0j0Pi9SWSvncCSbmfVNWddTd4zszE+u81WDPH4fD/Kp6goJkbom0+YBVZOjt4LT+mLPGqrSlUu0E=@nongnu.org
X-Gm-Message-State: AOJu0YygacdQHPJrseRNMEHXfzBdyB5MN/nsQBhFwjCpLC/mz6t2HP09
 58l9AjvagLnIMb9omBO+MTZ1PJH7ym4brt9/qMzt0G4C4LsOO6PAJJ2GQX6U
X-Gm-Gg: ASbGnctZAEoZxyU30J0kkQkS5iLc9yUCQYkZJrZdGlwPqm7s7ikX7lkMR9fBeTgRV2k
 UeDE5ePMOU6S6cR2DelWx/Yg+ysmxZlKoxdAn1+Rxl2qpuYBTZxOhNQf3FuY5Cuc3wdf+SMZIIZ
 9lrSkyfgCuiHGIX3XWrhbyFUo/+MFfXLXsYYHpo2leEgxPPauDJbqti0x6opNLjBhgwZIc46ttV
 cFTKkzE+1ul3cWmNglgGu0oZBV7HbXMo3xbn4VySivbzruJ5ud+nmlYnSGPiuR8yh2zobGsBCrT
 /tzDWKOlwzgZfClif9IUCv8l9k0GGFq5
X-Google-Smtp-Source: AGHT+IF8hyA8fPxShcIgpDKTZtNqkQhtsaSqGv8bCMN/2Uo9KokzfdpWBFjL4mfKCVaOSLqoJjcUig==
X-Received: by 2002:a05:6a21:9993:b0:1e1:9e9f:ae4 with SMTP id
 adf61e73a8af0-20a8fe24493mr946514637.13.1745971611802; 
 Tue, 29 Apr 2025 17:06:51 -0700 (PDT)
Received: from localhost ([1.145.95.178]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74039945b80sm324581b3a.76.2025.04.29.17.06.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 17:06:51 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Apr 2025 10:06:37 +1000
Message-Id: <D9JJ9YVKS9A5.24UP9SZ6LSZ5X@gmail.com>
To: "Ben Dooks" <ben.dooks@codethink.co.uk>, <richard.henderson@linaro.org>,
 <pbonzini@redhat.com>, <peter.maydell@linaro.org>, <mrolnik@gmail.com>,
 <brian.cain@oss.qualcomm.com>, <deller@gmx.de>, <zhao1.liu@intel.com>,
 <gaosong@loongson.cn>, <laurent@vivier.eu>, <edgar.iglesias@gmail.com>,
 <philmd@linaro.org>, <aurelien@aurel32.net>, <jiaxun.yang@flygoat.com>,
 <arikalo@gmail.com>, <shorne@gmail.com>, <danielhb413@gmail.com>,
 <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <liwei1518@gmail.com>,
 <zhiwei_liu@linux.alibaba.com>, <ysato@users.sourceforge.jp>,
 <david@redhat.com>, <iii@linux.ibm.com>, <thuth@redhat.com>,
 <mark.cave-ayland@ilande.co.uk>, <atar4qemu@gmail.com>,
 <kbastian@mail.uni-paderborn.de>, <jcmvbkbc@gmail.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <qemu-ppc@nongnu.org>,
 <qemu-riscv@nongnu.org>, <qemu-s390x@nongnu.org>
Cc: <srv_ts003@codethink.com>
Subject: Re: [RFC PATCH] tcg: allow tb_flags to be larger than 32bit
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.19.0
References: <20250423100949.2047161-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20250423100949.2047161-1-ben.dooks@codethink.co.uk>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed Apr 23, 2025 at 8:09 PM AEST, Ben Dooks wrote:
> In adding a new feature to the riscv target, it turns out the tb_flags
> had already got to the 32-bit limit. Everyone other target has been
> fine with uint32_t (except perhaps arm which does somethng strange to
> extend tb_flags, I think).
>
> To allow extending of tb_flags to be bigger, change the uint32_t to
> a tb_flags_t which a target can define to be bigger (and do this for
> riscv as having tb_flags_t be uint64_t somewhere is necessary to pick
> out bugs in this translation).
>
> This method of extension also stops having to go through each arch
> fixing field usage and anything else that may arise, and given this
> is currently only affecting the tcg, it can be done per target arch.
>
> Note, target/riscv does not currently use any of the other flag bits
> yet. The work is done as we would like to try the big-endian riscv
> again and someone has already taken the last bit we where using at
> (target/riscv/cpu.h#L666 adding PM_SIGNEXTEND where we had BE_DATA)
>
> Q: Do the cpu_get_tb_state calls need uint32_t changing to the
> tb_flag_t as part of this?
>
> Q: As part of this, should we also define a FLAG_DP_TB or similar
> wrapper for the relevant change?
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  accel/tcg/cpu-exec.c      | 10 +++++-----
>  accel/tcg/translate-all.c |  2 +-
>  target/alpha/cpu.h        |  3 ++-
>  target/arm/cpu.h          |  1 +
>  target/avr/cpu.h          |  1 +
>  target/hexagon/cpu.h      |  1 +
>  target/hppa/cpu.h         |  1 +
>  target/i386/cpu.h         |  1 +
>  target/loongarch/cpu.h    |  1 +
>  target/m68k/cpu.h         |  1 +
>  target/microblaze/cpu.h   |  1 +
>  target/mips/cpu.h         |  1 +
>  target/openrisc/cpu.h     |  1 +
>  target/ppc/cpu.h          |  1 +
>  target/riscv/cpu.h        |  3 ++-
>  target/riscv/cpu_helper.c | 40 +++++++++++++++++++--------------------
>  target/rx/cpu.h           |  1 +
>  target/s390x/cpu.h        |  1 +
>  target/sh4/cpu.h          |  1 +
>  target/sparc/cpu.h        |  1 +
>  target/tricore/cpu.h      |  1 +
>  target/xtensa/cpu.h       |  1 +
>  22 files changed, 47 insertions(+), 28 deletions(-)
>
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index ef3d967e3a..2610ecd40e 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -302,7 +302,7 @@ static void log_cpu_exec(vaddr pc, CPUState *cpu,
>  }
> =20
>  static bool check_for_breakpoints_slow(CPUState *cpu, vaddr pc,
> -                                       uint32_t *cflags)
> +                                       tb_flags_t *cflags)
>  {
>      CPUBreakpoint *bp;
>      bool match_page =3D false;
> @@ -368,7 +368,7 @@ static bool check_for_breakpoints_slow(CPUState *cpu,=
 vaddr pc,
>  }
> =20
>  static inline bool check_for_breakpoints(CPUState *cpu, vaddr pc,
> -                                         uint32_t *cflags)
> +                                         tb_flags_t *cflags)
>  {
>      return unlikely(!QTAILQ_EMPTY(&cpu->breakpoints)) &&
>          check_for_breakpoints_slow(cpu, pc, cflags);
> @@ -388,7 +388,7 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
>      TranslationBlock *tb;
>      vaddr pc;
>      uint64_t cs_base;
> -    uint32_t flags, cflags;
> +    tb_flags_t flags, cflags;

I would leave cflags alone, or at least make a separate patch
for it and type since it's not used the same way.

There is a lot of room in cs_base that most targets don't use.
Could that be customized per target now you are here. Each target
could define a struct type and put what it likes in there. It
would have to provide a compare function as well I guess which
might be a bit slow, so perhaps a default/fallback path that
could be a scalar type and simple inline compare.

Thanks,
Nick

> =20
>      /*
>       * By definition we've just finished a TB, so I/O is OK.
> @@ -565,7 +565,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
>      TranslationBlock *tb;
>      vaddr pc;
>      uint64_t cs_base;
> -    uint32_t flags, cflags;
> +    tb_flags_t flags, cflags;
>      int tb_exit;
> =20
>      if (sigsetjmp(cpu->jmp_env, 0) =3D=3D 0) {
> @@ -956,7 +956,7 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
>              TranslationBlock *tb;
>              vaddr pc;
>              uint64_t cs_base;
> -            uint32_t flags, cflags;
> +            tb_flags_t flags, cflags;
> =20
>              cpu_get_tb_cpu_state(cpu_env(cpu), &pc, &cs_base, &flags);
> =20
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 82bc16bd53..ec90a9a9b0 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -594,7 +594,7 @@ void tb_check_watchpoint(CPUState *cpu, uintptr_t ret=
addr)
>          vaddr pc;
>          uint64_t cs_base;
>          tb_page_addr_t addr;
> -        uint32_t flags;
> +        tb_flags_t flags;
> =20
>          cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
>          addr =3D get_page_addr_code(env, pc);
> diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
> index 80562adfb5..25694ede9d 100644
> --- a/target/alpha/cpu.h
> +++ b/target/alpha/cpu.h
> @@ -464,8 +464,9 @@ void alpha_cpu_do_transaction_failed(CPUState *cs, hw=
addr physaddr,
>                                       MemTxResult response, uintptr_t ret=
addr);
>  #endif
> =20
> +typedef uint32_t tb_flags_t;
>  static inline void cpu_get_tb_cpu_state(CPUAlphaState *env, vaddr *pc,
> -                                        uint64_t *cs_base, uint32_t *pfl=
ags)
> +                                        uint64_t *cs_base, tb_flags_t *p=
flags)
>  {
>      *pc =3D env->pc;
>      *cs_base =3D 0;
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index a8177c6c2e..fd32e8d22c 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -3151,6 +3151,7 @@ static inline bool bswap_code(bool sctlr_b)
>  #endif
>  }
> =20
> +typedef uint32_t tb_flags_t;
>  void cpu_get_tb_cpu_state(CPUARMState *env, vaddr *pc,
>                            uint64_t *cs_base, uint32_t *flags);
> =20
> diff --git a/target/avr/cpu.h b/target/avr/cpu.h
> index 06f5ae4d1b..1a3f31b779 100644
> --- a/target/avr/cpu.h
> +++ b/target/avr/cpu.h
> @@ -193,6 +193,7 @@ enum {
>      TB_FLAGS_SKIP =3D 2,
>  };
> =20
> +typedef uint32_t tb_flags_t;
>  static inline void cpu_get_tb_cpu_state(CPUAVRState *env, vaddr *pc,
>                                          uint64_t *cs_base, uint32_t *pfl=
ags)
>  {
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index f78c8f9c2a..c924aa7e91 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -136,6 +136,7 @@ G_NORETURN void hexagon_raise_exception_err(CPUHexago=
nState *env,
>                                              uint32_t exception,
>                                              uintptr_t pc);
> =20
> +typedef uint32_t tb_flags_t;
>  static inline void cpu_get_tb_cpu_state(CPUHexagonState *env, vaddr *pc,
>                                          uint64_t *cs_base, uint32_t *fla=
gs)
>  {
> diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
> index 8b36642b59..e56f327737 100644
> --- a/target/hppa/cpu.h
> +++ b/target/hppa/cpu.h
> @@ -352,6 +352,7 @@ hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr);
>  #define CS_BASE_DIFFPAGE    (1 << 12)
>  #define CS_BASE_DIFFSPACE   (1 << 13)
> =20
> +typedef uint32_t tb_flags_t;
>  void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
>                            uint64_t *cs_base, uint32_t *pflags);
> =20
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 76f24446a5..4283f71d45 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2612,6 +2612,7 @@ int cpu_mmu_index_kernel(CPUX86State *env);
>  #include "hw/i386/apic.h"
>  #endif
> =20
> +typedef uint32_t tb_flags_t;
>  static inline void cpu_get_tb_cpu_state(CPUX86State *env, vaddr *pc,
>                                          uint64_t *cs_base, uint32_t *fla=
gs)
>  {
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 254e4fbdcd..48252678c8 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -490,6 +490,7 @@ static inline void set_pc(CPULoongArchState *env, uin=
t64_t value)
>  #define HW_FLAGS_VA32       0x20
>  #define HW_FLAGS_EUEN_ASXE  0x40
> =20
> +typedef uint32_t tb_flags_t;
>  static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *p=
c,
>                                          uint64_t *cs_base, uint32_t *fla=
gs)
>  {
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index ddb0f29f4a..9787a0611a 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -607,6 +607,7 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr=
 physaddr, vaddr addr,
>  #define TB_FLAGS_TRACE          16
>  #define TB_FLAGS_TRACE_BIT      (1 << TB_FLAGS_TRACE)
> =20
> +typedef uint32_t tb_flags_t;
>  static inline void cpu_get_tb_cpu_state(CPUM68KState *env, vaddr *pc,
>                                          uint64_t *cs_base, uint32_t *fla=
gs)
>  {
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index e44ddd5307..8b8e312a4f 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -421,6 +421,7 @@ static inline bool mb_cpu_is_big_endian(CPUState *cs)
>      return !cpu->cfg.endi;
>  }
> =20
> +typedef uint32_t tb_flags_t;
>  static inline void cpu_get_tb_cpu_state(CPUMBState *env, vaddr *pc,
>                                          uint64_t *cs_base, uint32_t *fla=
gs)
>  {
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index f6877ece8b..e2a6b944ed 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -1368,6 +1368,7 @@ void cpu_mips_clock_init(MIPSCPU *cpu);
>  /* helper.c */
>  target_ulong exception_resume_pc(CPUMIPSState *env);
> =20
> +typedef uint32_t tb_flags_t;
>  static inline void cpu_get_tb_cpu_state(CPUMIPSState *env, vaddr *pc,
>                                          uint64_t *cs_base, uint32_t *fla=
gs)
>  {
> diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
> index b97d2ffdd2..cc923629d4 100644
> --- a/target/openrisc/cpu.h
> +++ b/target/openrisc/cpu.h
> @@ -351,6 +351,7 @@ static inline void cpu_set_gpr(CPUOpenRISCState *env,=
 int i, uint32_t val)
>      env->shadow_gpr[0][i] =3D val;
>  }
> =20
> +typedef uint32_t tb_flags_t;
>  static inline void cpu_get_tb_cpu_state(CPUOpenRISCState *env, vaddr *pc=
,
>                                          uint64_t *cs_base, uint32_t *fla=
gs)
>  {
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 3ee83517dc..1575e8584b 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -2755,6 +2755,7 @@ void cpu_write_xer(CPUPPCState *env, target_ulong x=
er);
>   */
>  #define is_book3s_arch2x(ctx) (!!((ctx)->insns_flags & PPC_SEGMENT_64B))
> =20
> +typedef uint32_t tb_flags_t;
>  #ifdef CONFIG_DEBUG_TCG
>  void cpu_get_tb_cpu_state(CPUPPCState *env, vaddr *pc,
>                            uint64_t *cs_base, uint32_t *flags);
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 51e49e03de..5ffa6e6f79 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -808,8 +808,9 @@ static inline uint32_t vext_get_vlmax(uint32_t vlenb,=
 uint32_t vsew,
>      return vlen >> (vsew + 3 - lmul);
>  }
> =20
> +typedef uint64_t tb_flags_t;
>  void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
> -                          uint64_t *cs_base, uint32_t *pflags);
> +                          uint64_t *cs_base, tb_flags_t *pflags);
> =20
>  bool riscv_cpu_is_32bit(RISCVCPU *cpu);
> =20
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 6c4391d96b..7d6878fbc3 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -135,7 +135,7 @@ bool riscv_env_smode_dbltrp_enabled(CPURISCVState *en=
v, bool virt)
>  }
> =20
>  void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
> -                          uint64_t *cs_base, uint32_t *pflags)
> +                          uint64_t *cs_base, tb_flags_t *pflags)
>  {
>      RISCVCPU *cpu =3D env_archcpu(env);
>      RISCVExtStatus fs, vs;
> @@ -162,18 +162,18 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr=
 *pc,
>          uint32_t maxsz =3D vlmax << vsew;
>          bool vl_eq_vlmax =3D (env->vstart =3D=3D 0) && (vlmax =3D=3D env=
->vl) &&
>                             (maxsz >=3D 8);
> -        flags =3D FIELD_DP32(flags, TB_FLAGS, VILL, env->vill);
> -        flags =3D FIELD_DP32(flags, TB_FLAGS, SEW, vsew);
> -        flags =3D FIELD_DP32(flags, TB_FLAGS, LMUL,
> +        flags =3D FIELD_DP64(flags, TB_FLAGS, VILL, env->vill);
> +        flags =3D FIELD_DP64(flags, TB_FLAGS, SEW, vsew);
> +        flags =3D FIELD_DP64(flags, TB_FLAGS, LMUL,
>                             FIELD_EX64(env->vtype, VTYPE, VLMUL));
> -        flags =3D FIELD_DP32(flags, TB_FLAGS, VL_EQ_VLMAX, vl_eq_vlmax);
> -        flags =3D FIELD_DP32(flags, TB_FLAGS, VTA,
> +        flags =3D FIELD_DP64(flags, TB_FLAGS, VL_EQ_VLMAX, vl_eq_vlmax);
> +        flags =3D FIELD_DP64(flags, TB_FLAGS, VTA,
>                             FIELD_EX64(env->vtype, VTYPE, VTA));
> -        flags =3D FIELD_DP32(flags, TB_FLAGS, VMA,
> +        flags =3D FIELD_DP64(flags, TB_FLAGS, VMA,
>                             FIELD_EX64(env->vtype, VTYPE, VMA));
> -        flags =3D FIELD_DP32(flags, TB_FLAGS, VSTART_EQ_ZERO, env->vstar=
t =3D=3D 0);
> +        flags =3D FIELD_DP64(flags, TB_FLAGS, VSTART_EQ_ZERO, env->vstar=
t =3D=3D 0);
>      } else {
> -        flags =3D FIELD_DP32(flags, TB_FLAGS, VILL, 1);
> +        flags =3D FIELD_DP64(flags, TB_FLAGS, VILL, 1);
>      }
> =20
>      if (cpu_get_fcfien(env)) {
> @@ -182,26 +182,26 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr=
 *pc,
>           * the start of the block is tracked via env->elp. env->elp
>           * is turned on during jalr translation.
>           */
> -        flags =3D FIELD_DP32(flags, TB_FLAGS, FCFI_LP_EXPECTED, env->elp=
);
> -        flags =3D FIELD_DP32(flags, TB_FLAGS, FCFI_ENABLED, 1);
> +        flags =3D FIELD_DP64(flags, TB_FLAGS, FCFI_LP_EXPECTED, env->elp=
);
> +        flags =3D FIELD_DP64(flags, TB_FLAGS, FCFI_ENABLED, 1);
>      }
> =20
>      if (cpu_get_bcfien(env)) {
> -        flags =3D FIELD_DP32(flags, TB_FLAGS, BCFI_ENABLED, 1);
> +        flags =3D FIELD_DP64(flags, TB_FLAGS, BCFI_ENABLED, 1);
>      }
> =20
>  #ifdef CONFIG_USER_ONLY
>      fs =3D EXT_STATUS_DIRTY;
>      vs =3D EXT_STATUS_DIRTY;
>  #else
> -    flags =3D FIELD_DP32(flags, TB_FLAGS, PRIV, env->priv);
> +    flags =3D FIELD_DP64(flags, TB_FLAGS, PRIV, env->priv);
> =20
>      flags |=3D riscv_env_mmu_index(env, 0);
>      fs =3D get_field(env->mstatus, MSTATUS_FS);
>      vs =3D get_field(env->mstatus, MSTATUS_VS);
> =20
>      if (env->virt_enabled) {
> -        flags =3D FIELD_DP32(flags, TB_FLAGS, VIRT_ENABLED, 1);
> +        flags =3D FIELD_DP64(flags, TB_FLAGS, VIRT_ENABLED, 1);
>          /*
>           * Merge DISABLED and !DIRTY states using MIN.
>           * We will set both fields when dirtying.
> @@ -221,12 +221,12 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr=
 *pc,
>      }
>  #endif
> =20
> -    flags =3D FIELD_DP32(flags, TB_FLAGS, FS, fs);
> -    flags =3D FIELD_DP32(flags, TB_FLAGS, VS, vs);
> -    flags =3D FIELD_DP32(flags, TB_FLAGS, XL, env->xl);
> -    flags =3D FIELD_DP32(flags, TB_FLAGS, AXL, cpu_address_xl(env));
> -    flags =3D FIELD_DP32(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env))=
;
> -    flags =3D FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
> +    flags =3D FIELD_DP64(flags, TB_FLAGS, FS, fs);
> +    flags =3D FIELD_DP64(flags, TB_FLAGS, VS, vs);
> +    flags =3D FIELD_DP64(flags, TB_FLAGS, XL, env->xl);
> +    flags =3D FIELD_DP64(flags, TB_FLAGS, AXL, cpu_address_xl(env));
> +    flags =3D FIELD_DP64(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env))=
;
> +    flags =3D FIELD_DP64(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
> =20
>      *pflags =3D flags;
>  }
> diff --git a/target/rx/cpu.h b/target/rx/cpu.h
> index 349d61c4e4..ad4247deec 100644
> --- a/target/rx/cpu.h
> +++ b/target/rx/cpu.h
> @@ -153,6 +153,7 @@ void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw,=
 int rte);
>  #define RX_CPU_IRQ 0
>  #define RX_CPU_FIR 1
> =20
> +typedef uint32_t tb_flags_t;
>  static inline void cpu_get_tb_cpu_state(CPURXState *env, vaddr *pc,
>                                          uint64_t *cs_base, uint32_t *fla=
gs)
>  {
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 5b7992deda..a42d412fe6 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -417,6 +417,7 @@ static inline int s390x_env_mmu_index(CPUS390XState *=
env, bool ifetch)
> =20
>  #include "tcg/tcg_s390x.h"
> =20
> +typedef uint32_t tb_flags_t;
>  void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
>                            uint64_t *cs_base, uint32_t *flags);
> =20
> diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
> index d536d5d715..b10698f1a9 100644
> --- a/target/sh4/cpu.h
> +++ b/target/sh4/cpu.h
> @@ -382,6 +382,7 @@ static inline void cpu_write_sr(CPUSH4State *env, tar=
get_ulong sr)
>      env->sr =3D sr & ~((1u << SR_M) | (1u << SR_Q) | (1u << SR_T));
>  }
> =20
> +typedef uint32_t tb_flags_t;
>  static inline void cpu_get_tb_cpu_state(CPUSH4State *env, vaddr *pc,
>                                          uint64_t *cs_base, uint32_t *fla=
gs)
>  {
> diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> index 68f8c21e7c..bc876becc9 100644
> --- a/target/sparc/cpu.h
> +++ b/target/sparc/cpu.h
> @@ -745,6 +745,7 @@ trap_state* cpu_tsptr(CPUSPARCState* env);
>  #define TB_FLAG_FSR_QNE      (1 << 8)
>  #define TB_FLAG_ASI_SHIFT    24
> =20
> +typedef uint32_t tb_flags_t;
>  void cpu_get_tb_cpu_state(CPUSPARCState *env, vaddr *pc,
>                            uint64_t *cs_base, uint32_t *pflags);
> =20
> diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
> index cf9dbc6df8..917cd9ab5d 100644
> --- a/target/tricore/cpu.h
> +++ b/target/tricore/cpu.h
> @@ -259,6 +259,7 @@ void tricore_tcg_init(void);
>  void tricore_translate_code(CPUState *cs, TranslationBlock *tb,
>                              int *max_insns, vaddr pc, void *host_pc);
> =20
> +typedef uint32_t tb_flags_t;
>  static inline void cpu_get_tb_cpu_state(CPUTriCoreState *env, vaddr *pc,
>                                          uint64_t *cs_base, uint32_t *fla=
gs)
>  {
> diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
> index 8d70bfc0cd..856f794342 100644
> --- a/target/xtensa/cpu.h
> +++ b/target/xtensa/cpu.h
> @@ -733,6 +733,7 @@ static inline uint32_t xtensa_replicate_windowstart(C=
PUXtensaState *env)
> =20
>  #include "exec/cpu-all.h"
> =20
> +typedef uint32_t tb_flags_t;
>  static inline void cpu_get_tb_cpu_state(CPUXtensaState *env, vaddr *pc,
>                                          uint64_t *cs_base, uint32_t *fla=
gs)
>  {


