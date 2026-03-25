Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087DFFEA802
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 03:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Ehy-0001kp-3l; Tue, 24 Mar 2026 23:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5Ehw-0001jx-7a
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 23:15:00 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5Ehu-0007Jy-DZ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 23:14:59 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso105434966b.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 20:14:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774408497; cv=none;
 d=google.com; s=arc-20240605;
 b=XZRPv8vYIOKk3XyfoXLDESMe+YTXhLHGlwf3iAHqQZcS6ZALoLIjLYEXfMYIKT4lE1
 in/Bb7zAiHJSqdyWLe6GcblEm3W2rS5/hVhlwwFyvZckS0ZAvcBt7AQGseXgI4Emo+bt
 ASyiMH8bkni5X9m790V9qz8OL3BwpqerFul/V/Knq4m6nSxA/bl1sIvfzDjUOPQgQ5O3
 gDliUX1qOWfTtDojPsOzhWttZ4hCmrsfm/dbre36enwep0oSrvOUREhR7XFnh/74sHg8
 a5y2RX42JThdbr9rJRnWWOUVdKsrzzJXdAI4YyFNWj/MXGToevaavVHKWPKZxUgO7Xpf
 kQ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FZcCt6K1ChIemZxf4SW8DRwqQIfqh/ODxhoJfdAe5fA=;
 fh=Su2FPx71BQho6tN89vAi6wUVPZAGYbP0ier5t6FRizo=;
 b=dWSgjGqwBU5NUE+w1gtGP5dr+ENu3PuN12VTvGB9TRVdx+GEMCiwdHCmkm/dYjFfMU
 O/X88ns5NdMpX3UIP2+arKYUgE4Vc4RdriQakkT+lDS1hMvCbnI+f3NCZ6D9+hEo5au7
 WnI1QdY0MBzjybSNXMtyN2EXCYZfSqbawoFsJK1sk4iKoP2myd2I2agY+S3aauz5jHg5
 SEtcnzbPioYhY6TJJ/dehmjj5ha7aNOaecpUOLDmVR7W/YiRHZjeTq/Ncekxz+73OQd9
 qQ6nGGqNxZporhmPJ6mnP4By/qXQzNjEIB+MubHH+9tQjl84tOCzMbcFKavfMcSNulR7
 y0Pg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774408497; x=1775013297; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FZcCt6K1ChIemZxf4SW8DRwqQIfqh/ODxhoJfdAe5fA=;
 b=eiWCZ/rmltBK4/yOfHlZqbMdCPIK+r9n5kKaUyFneyrIa1Wh95vtgBORKw5noqq/Iv
 aEA89ORi2cRPJfVZa/T54IjvbVH3+/T2l8io0zaLR+0XiMHtuDbCwHPgSxrrvIEA4NnL
 Ekkg9+x1cJQLYbeprs5ymySCtuQBw0eOgIAxQqMtXFq/2DUU01In4HVRnlt1SXEAZPcG
 Gz5i6vePqwxfwltqranIRmAezicfpqQynB51obQ6hQQ/IdAfwIz6UQjDVjEm0/5I55vO
 HOygVtOGAXP797qraeDcEqEF7putVack44UxzRTQSdd3Be/SLOD3ZdZFt86vZHYAKB0s
 AjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774408497; x=1775013297;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FZcCt6K1ChIemZxf4SW8DRwqQIfqh/ODxhoJfdAe5fA=;
 b=Q/c/EBUgpG8PuLz6/Sih3rzM/0kHEkJhhOOIfFfRe0cMuqXYipn+YLvcC3AJUcPXrc
 vS2ZD4L43OuOVrGuAeQQ7fM30ZrvkvgZosiFJmhA6dmVzYcTsm59s/tVSKvdw0U3Nau8
 BAhLYecQqo1peONgcG9Xpjn8DVFfQFLA0Gq3oB/Z3je27IH1AGWatCtQqVHPkGqgUdgF
 FTgcGyPBzLVPyaC3Xm/g4AiMfdwFza7B+E/3DC6KbK1ba/je56z0GkF8xOL9z4iy+20r
 lRtaWkPd67pJstTrD7NQ7QL+j0CE68QPqzNlBYpF8wrNf+wrpYgVEgv2KCG3Vc4waz1l
 xsFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMwPTKYLfoxlo2ZTeKZe8gtmdd34DReLj+DpeW0GDrLERne0GXj4btc+7aX7UqXRWv2Ox5AXknd0ac@nongnu.org
X-Gm-Message-State: AOJu0Yx94pYFoAZV7hO3d4AB/k3Z7u/RC7EtZWAp6Yt+lhXcEQRuVru9
 +kuKejpKNUBo/LrjbmoQTcgkKoo1gSmBfkfovcVcbc7t+Ik6DeEGjlzDoNlzDmEU5HFr/NaRON5
 nwsVEdDR1DAm5YEYMijjC8S1I/BsRZSI=
X-Gm-Gg: ATEYQzzRVqiMuukh4iMW5nx1SvRtmwCxN8zNup2hgbvedoPV3mh6Xlrt7XTlH9i90pa
 55qWStS76jb6IzuVBKYhTBAQ6kr/b7BrXclSulWZotx21RvStP6Gu6P8x3BKsdqc1cL0D0XMywt
 Jwl7KRzkNzDA8zsTC7peYV9bDsQjfGwKcPP14ioZYM6lWZLuXJaKVYGnOJM0I1wGHpWxr1PyGJ+
 2yz4//zun9itpLRgg6w4xaHYJGTX40pY/8jJxdHwaPoGRtUkJbHlpaf2IDXRJ6mk4HOIIEGbuwN
 lOPCck+uvHiOfuob/DyeL6sBTa9/iN6bTgrrbw==
X-Received: by 2002:a17:907:c27:b0:b9b:132c:a590 with SMTP id
 a640c23a62f3a-b9b132cc584mr27018366b.4.1774408496659; Tue, 24 Mar 2026
 20:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260321141345.599105-1-npiggin@gmail.com>
 <20260321141345.599105-4-npiggin@gmail.com>
In-Reply-To: <20260321141345.599105-4-npiggin@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 25 Mar 2026 13:14:30 +1000
X-Gm-Features: AQROBzBbTjCDMjsG7crXRCYRLjoqZJYOlyEJug9L2RYbsfsPUyPND5IdLCd7Jt4
Message-ID: <CAKmqyKMVTjrm3-jn-hz5bsfa+TCF3yae-VcwuF7UTh_zqf5UMQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] linux-user/riscv: Add extended state to sigcontext
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
> Linux/riscv has extended the sigcontext with padding and an
> extended state structure that can save various optional
> features like vector in a flexible format. Update the
> linux-user signal handling to this new structure.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  linux-user/riscv/signal.c         | 93 +++++++++++++++++++++++++++----
>  linux-user/riscv/vdso-asmoffset.h |  4 +-
>  2 files changed, 85 insertions(+), 12 deletions(-)
>
> diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
> index ece276f85f..e20b9ac177 100644
> --- a/linux-user/riscv/signal.c
> +++ b/linux-user/riscv/signal.c
> @@ -31,14 +31,43 @@
>
>     The code below is qemu re-implementation of arch/riscv/kernel/signal.=
c */
>
> -struct target_sigcontext {
> +struct target_gp_state {
>      abi_long pc;
>      abi_long gpr[31]; /* x0 is not present, so all offsets must be -1 */
> +};
> +
> +struct target_fp_state {
>      uint64_t fpr[32];
>      uint32_t fcsr;
> +};
> +
> +/* The Magic number for signal context frame header. */
> +#define END_MAGIC       0x0
> +
> +/* The size of END signal context header. */
> +#define END_HDR_SIZE    0x0
> +
> +struct target_ctx_hdr {
> +    uint32_t magic;
> +    uint32_t size;
> +};
> +
> +struct target_extra_ext_header {
> +    uint32_t __padding[129] __attribute__((aligned(16)));
> +    uint32_t reserved;
> +    struct target_ctx_hdr hdr;
> +};
> +
> +struct target_sigcontext {
> +    struct target_gp_state sc_regs;
> +    union {
> +        struct target_fp_state sc_fpregs;
> +        struct target_extra_ext_header sc_extdesc;
> +    };
>  }; /* cf. riscv-linux:arch/riscv/include/uapi/asm/ptrace.h */

I would argue that arch/riscv/include/uapi/asm/sigcontext.h is a
better pointer, but both work

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> -QEMU_BUILD_BUG_ON(offsetof(struct target_sigcontext, fpr) !=3D offsetof_=
freg0);
> +QEMU_BUILD_BUG_ON(offsetof(struct target_sigcontext, sc_fpregs.fpr) !=3D
> +                  offsetof_freg0);
>
>  struct target_ucontext {
>      abi_ulong uc_flags;
> @@ -79,19 +108,26 @@ static abi_ulong get_sigframe(struct target_sigactio=
n *ka,
>
>  static void setup_sigcontext(struct target_sigcontext *sc, CPURISCVState=
 *env)
>  {
> +    struct target_ctx_hdr *hdr;
>      int i;
>
> -    __put_user(env->pc, &sc->pc);
> +    __put_user(env->pc, &sc->sc_regs.pc);
>
>      for (i =3D 1; i < 32; i++) {
> -        __put_user(env->gpr[i], &sc->gpr[i - 1]);
> +        __put_user(env->gpr[i], &sc->sc_regs.gpr[i - 1]);
>      }
>      for (i =3D 0; i < 32; i++) {
> -        __put_user(env->fpr[i], &sc->fpr[i]);
> +        __put_user(env->fpr[i], &sc->sc_fpregs.fpr[i]);
>      }
>
>      uint32_t fcsr =3D riscv_csr_read(env, CSR_FCSR);
> -    __put_user(fcsr, &sc->fcsr);
> +    __put_user(fcsr, &sc->sc_fpregs.fcsr);
> +
> +    __put_user(0, &sc->sc_extdesc.reserved);
> +
> +    hdr =3D &sc->sc_extdesc.hdr;
> +    __put_user(END_MAGIC, &hdr->magic);
> +    __put_user(END_HDR_SIZE, &hdr->size);
>  }
>
>  static void setup_ucontext(struct target_ucontext *uc,
> @@ -147,21 +183,58 @@ badframe:
>
>  static bool restore_sigcontext(CPURISCVState *env, struct target_sigcont=
ext *sc)
>  {
> +    struct target_ctx_hdr *hdr;
> +    uint32_t rsv, magic, size;
>      int i;
>
> -    __get_user(env->pc, &sc->pc);
> +    __get_user(env->pc, &sc->sc_regs.pc);
>
>      for (i =3D 1; i < 32; ++i) {
> -        __get_user(env->gpr[i], &sc->gpr[i - 1]);
> +        __get_user(env->gpr[i], &sc->sc_regs.gpr[i - 1]);
>      }
>      for (i =3D 0; i < 32; ++i) {
> -        __get_user(env->fpr[i], &sc->fpr[i]);
> +        __get_user(env->fpr[i], &sc->sc_fpregs.fpr[i]);
>      }
>
>      uint32_t fcsr;
> -    __get_user(fcsr, &sc->fcsr);
> +    __get_user(fcsr, &sc->sc_fpregs.fcsr);
>      riscv_csr_write(env, CSR_FCSR, fcsr);
>
> +    hdr =3D &sc->sc_extdesc.hdr;
> +    __get_user(rsv, &sc->sc_extdesc.reserved);
> +    if (rsv !=3D 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "signal: sigcontext reserved fiel=
d is "
> +                                       "non-zero\n");
> +        return false;
> +    }
> +
> +    __get_user(magic, &hdr->magic);
> +    while (magic !=3D END_MAGIC) {
> +        switch (magic) {
> +        default:
> +            qemu_log_mask(LOG_GUEST_ERROR, "signal: unknown extended sta=
te in "
> +                                           "sigcontext, magic=3D0x%08x\n=
", magic);
> +            return false;
> +        }
> +
> +        __get_user(size, &hdr->size);
> +        if (size =3D=3D 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "signal: extended state in "
> +                                           "sigcontext has size 0\n");
> +            return false;
> +        }
> +
> +        hdr =3D (void *)hdr + size;
> +        __get_user(magic, &hdr->magic);
> +    }
> +
> +    __get_user(size, &hdr->size);
> +    if (size !=3D END_HDR_SIZE) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "signal: extended state end heade=
r has "
> +                                       "size=3D%u (should be 0)\n", size=
);
> +        return false;
> +    }
> +
>      return true;
>  }
>
> diff --git a/linux-user/riscv/vdso-asmoffset.h b/linux-user/riscv/vdso-as=
moffset.h
> index 123902ef61..92e8ac10ab 100644
> --- a/linux-user/riscv/vdso-asmoffset.h
> +++ b/linux-user/riscv/vdso-asmoffset.h
> @@ -1,9 +1,9 @@
>  #ifdef TARGET_ABI32
> -# define sizeof_rt_sigframe     0x2b0
> +# define sizeof_rt_sigframe     0x3b0
>  # define offsetof_uc_mcontext   0x120
>  # define offsetof_freg0         0x80
>  #else
> -# define sizeof_rt_sigframe     0x340
> +# define sizeof_rt_sigframe     0x440
>  # define offsetof_uc_mcontext   0x130
>  # define offsetof_freg0         0x100
>  #endif
> --
> 2.51.0
>
>

