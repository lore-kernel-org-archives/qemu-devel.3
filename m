Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B89CD4F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 01:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOmS9-0003QY-BZ; Sun, 17 May 2026 21:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOmS5-0003QD-7D
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:07:26 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOmS3-0007EZ-By
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:07:24 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bcd0111ea98so267241766b.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 18:07:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779066442; cv=none;
 d=google.com; s=arc-20240605;
 b=CaVLnTkSJxZ2HwJZspoFrp8jkauj4NJtnk8M4oem8e9CzGW5pjndTgxG2Acxl1fyJq
 0k02L0y76mX3HDt09HrQ3tWxQiHUK4S+tlFtD2L1WaAHzpCjntCHKS3J5A3lUxMVa4EF
 wAEoxygdQwFD2/3488XDt+lyXuh7HoUMLPa5gPQQwVH8vjD24tiq6zglt5fL8s8pcReB
 hxvwB6M3ltQdQArwaGPOIzJy1KUzTujbtH9qPA7plzpoVpEsz7BSdMcPb5/VqPcIm6+h
 RRJKfo0e/t0ng+5jVoFuoeOyg0AXzN8EhIQR2pI8chLsBO6Om1mh/GrUN7n448GtDpeW
 sORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3PsanRJawgTZh8ENd4SGuL6iSAfZ65tgAg9UIL6zQDo=;
 fh=7yLd7axCS8kVnP6j1ayRnO1ahOV61/LRzLUqWQL+O9A=;
 b=Gym4CTfuflGCY/7CgJAeIaG2p+z6zwuXdFsmEeBPRAaHJy8wx2QCwAUjfvMGwpEAP4
 NVLrWK4NqvNKOkUC2Nxi5O2Vbzm8YZJ06KKus8fFai2ACiF0umdU/LO0w0x7uHqce+bk
 mESuJ6Sryn4S/UVzyzcWWJ/PDF7Cr/jQcnzGl7B7Bjd3fEMOH/OVU4dLdh2DXsGUgWqG
 ynmOYUNoLOHf5Ba4nM+t087gfWPA/Vbettzi6e6cDgExRaJlvaoU+b0T4oHhvTimykVh
 6HfSVOp8Gv+dzfltMz+SarkN3T5x+9aGck0zOqDAj9MjgwjNoy9lVvL+6KHcKBrgqcWx
 A7JQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779066442; x=1779671242; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3PsanRJawgTZh8ENd4SGuL6iSAfZ65tgAg9UIL6zQDo=;
 b=HGjFQr2N7Qx9L5xsoNc/C70d+1weROutxB6o8qRovrdyCKPIcP9rU7j/0Cgib/K5P8
 BDpQF+ttynpJlfqUcCvk2+oeUIoijzbrZwxviwmQfb7+Who2OEMHPlln0E7ctORe0WQy
 HJQChSDTy5zg8F1jrK1+lPKaV5knJSq4B3w2+4trpZI7TPot+stsU3OApvkr3TXGfOhb
 r94EgZ6AZWFdmlQVkoGVv+n21GQ9l4T8wZsfgYF42pumYq63ZKHCR/UAWpnvFYeFln3s
 qZ365qCrEqlkFEScZwUuCznYMCXakuF3f7tagb75fb5zCafO44L5eTwWyZAUAMUjdONu
 VIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779066442; x=1779671242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3PsanRJawgTZh8ENd4SGuL6iSAfZ65tgAg9UIL6zQDo=;
 b=baAlBBWBs47dbzMv0bkWJESHfJkF1LgGZyFNGDA/zE1CFqlzrZP7owkKmrHYmcFh6s
 +u+jLREqEJxd+hkU9TquFDsDw8Q3fT35+MnRoU6exk3BXNP0dAEg1UHPVcAyEFUbgB10
 JDKzd316IsrMPK94eH7rplrOAkuTFljwUqbYxg9gnDYmwq0edEgCVETljBeIFX8mVQNK
 DScErbxmUTAYOX3+G0EeF1ccp/omrN0DETvz5rFKFoLf0IVz1QmVD7dOuFr2mPYVS6+C
 x9pE4dQNdp1FsbDECaLsSgV+weZMiCHeE34ss4lDRJ0CnH56ApmmMbArkZ5BThCJEEXQ
 FsfQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Sp1BXbWY4yIE2qgFQvmcr4iRV5oGnQ7ZLNzmC7TFRyadEq23H7NKCMGC35CP6RA5Dk4eTdyOpdxUc@nongnu.org
X-Gm-Message-State: AOJu0Yzsta/4xhBdgoVl7rwJXBYeIgfXAMuN7fvJUbdNjV8a020KHGsX
 Euv4OTuyrWxbEuQa/1IZ2UGwSrV4pLyGj5Xl4ZM9302A+4FUGDc7T7k3BdkV+R99FWFVkuBrX/N
 5pHpqaqyroqNJcINIgy3Xu4TZg74q4IY=
X-Gm-Gg: Acq92OGk6mHp3sU7iOz8zj45hhYmrJs3hE1B7YYoraDiQKWLYvFMQ7+SZs54ZJSWfE2
 BSRMPYQpgWxZI2oQ889ED0HOiRXQnxzW0VyW/uu/H/fFjjKfgulVO1Y8D+xsQ2C3eWNldQqQnwz
 iPXkyosaQ/2F9xxU5FeL3o/yp2+rdgo06P2NkdIR+8PyBmfyL5xZdtq4bZlgTO/jxjSaZuL9zEb
 5dg8vadFFyIOzkKsIdVdVw1N1nbgMdaLJDb5dmycEYc6jPtQjGOSp9zVVc4phajYy31XW0UMQpJ
 AyaDIBwXISNwFgTOLEafRDdF4Qn5VC1dpAGQvg==
X-Received: by 2002:a17:906:6a21:b0:bd5:7a3:a593 with SMTP id
 a640c23a62f3a-bd517add181mr494615666b.46.1779066441558; Sun, 17 May 2026
 18:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260515180437.23620-1-anjo@rev.ng>
 <20260515180437.23620-25-anjo@rev.ng>
 <38468155-e075-4974-909c-5c7b6a52df5b@linaro.org>
In-Reply-To: <38468155-e075-4974-909c-5c7b6a52df5b@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2026 11:06:54 +1000
X-Gm-Features: AVHnY4I6TbUw0_ROIo5gRoQgvfxhRhc4ZJrsgLsBVcKwaHis4ujXb9kMoCKTxWg
Message-ID: <CAKmqyKMC4LOZN4befYQPF9MDSoTKpVhCDMmLGuLJ2S9F8EoZyQ@mail.gmail.com>
Subject: Re: [PATCH v6 24/27] target/riscv: Introduce externally facing CSR
 access functions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org,
 pierrick.bouvier@linaro.org, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x629.google.com
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

On Mon, May 18, 2026 at 1:43=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 15/5/26 20:04, Anton Johansson wrote:
> > Convert riscv_csr_[read|write]() into target_ulong angnostic CSR access
> > functions that can be safely used from outside of target/ without
> > knowledge of the target register size.  Replace the 4 existing CSR
> > accesses in hw/ and linux-user/.
> >
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > ---
> >   target/riscv/cpu.h        |  7 ++++++-
> >   target/riscv/csr.h        | 13 -------------
> >   hw/riscv/riscv_hart.c     |  7 +++----
> >   linux-user/riscv/signal.c |  5 +++--
> >   target/riscv/csr.c        | 17 +++++++++++++++++
> >   5 files changed, 29 insertions(+), 20 deletions(-)
> >
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index eb18e1f59f..3352409676 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -903,7 +903,12 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
> >   RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *env);
> >   uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);
> >
> > -#include "target/riscv/csr.h"
> > +/*
> > + * Externally facing CSR access functions, wrappers around riscv_csr*(=
).
>
> Return: #RISCVException
>
> > + */
> > +
> > +int riscv_csr_write_i64(CPURISCVState *env, int csrno, uint64_t val);
> > +int riscv_csr_read_i64(CPURISCVState *env, int csrn, uint64_t *res);
>
> s/int/RISCVException/?
>
> >
> >   /*
> >    * The event id are encoded based on the encoding specified in the
> > diff --git a/target/riscv/csr.h b/target/riscv/csr.h
> > index fef3cd34cb..370da83a69 100644
> > --- a/target/riscv/csr.h
> > +++ b/target/riscv/csr.h
> > @@ -23,19 +23,6 @@ RISCVException riscv_csrrw_debug(CPURISCVState *env,=
 int csrno,
> >                                    target_ulong new_value,
> >                                    target_ulong write_mask);
> >
> > -static inline void riscv_csr_write(CPURISCVState *env, int csrno,
> > -                                   target_ulong val)
> > -{
> > -    riscv_csrrw(env, csrno, NULL, val, MAKE_64BIT_MASK(0, TARGET_LONG_=
BITS), 0);
> > -}
> > -
> > -static inline target_ulong riscv_csr_read(CPURISCVState *env, int csrn=
o)
> > -{
> > -    target_ulong val =3D 0;
> > -    riscv_csrr(env, csrno, &val);
> > -    return val;
> > -}
> > -
> >   typedef RISCVException (*riscv_csr_predicate_fn)(CPURISCVState *env,
> >                                                    int csrno);
> >   typedef RISCVException (*riscv_csr_read_fn)(CPURISCVState *env, int c=
srno,
> > diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> > index e675358e1a..d1c7188369 100644
> > --- a/hw/riscv/riscv_hart.c
> > +++ b/hw/riscv/riscv_hart.c
> > @@ -67,12 +67,11 @@ static void csr_call(char *cmd, uint64_t cpu_num, i=
nt csrno, uint64_t *val)
> >       RISCVCPU *cpu =3D RISCV_CPU(cpu_by_arch_id(cpu_num));
> >       CPURISCVState *env =3D &cpu->env;
> >
> > -    int ret =3D RISCV_EXCP_NONE;
> > +    RISCVException ret =3D RISCV_EXCP_NONE;
> >       if (strcmp(cmd, "get_csr") =3D=3D 0) {
> > -        ret =3D riscv_csrr(env, csrno, (target_ulong *)val);
> > +        ret =3D riscv_csr_read_i64(env, csrno, val);
> >       } else if (strcmp(cmd, "set_csr") =3D=3D 0) {
> > -        ret =3D riscv_csrrw(env, csrno, NULL, *(target_ulong *)val,
> > -                          MAKE_64BIT_MASK(0, TARGET_LONG_BITS), 0);
> > +        ret =3D riscv_csr_write_i64(env, csrno, *val);
> >       }
> >
> >       g_assert(ret =3D=3D RISCV_EXCP_NONE);
> > diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
> > index 358fa1d82d..9d5ba300e4 100644
> > --- a/linux-user/riscv/signal.c
> > +++ b/linux-user/riscv/signal.c
> > @@ -90,7 +90,8 @@ static void setup_sigcontext(struct target_sigcontext=
 *sc, CPURISCVState *env)
> >           __put_user(env->fpr[i], &sc->fpr[i]);
> >       }
> >
> > -    uint32_t fcsr =3D riscv_csr_read(env, CSR_FCSR);
> > +    uint64_t fcsr;
> > +    riscv_csr_read_i64(env, CSR_FCSR, &fcsr);
> >       __put_user(fcsr, &sc->fcsr);
> >   }
> >
> > @@ -159,7 +160,7 @@ static void restore_sigcontext(CPURISCVState *env, =
struct target_sigcontext *sc)
> >
> >       uint32_t fcsr;
> >       __get_user(fcsr, &sc->fcsr);
> > -    riscv_csr_write(env, CSR_FCSR, fcsr);
> > +    riscv_csr_write_i64(env, CSR_FCSR, fcsr);
> >   }
> >
> >   static void restore_ucontext(CPURISCVState *env, struct target_uconte=
xt *uc)
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index 6cc3fcd4e3..3ffb56e938 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -5716,6 +5716,23 @@ RISCVException riscv_csrrw(CPURISCVState *env, i=
nt csrno,
> >       return riscv_csrrw_do64(env, csrno, ret_value, new_value, write_m=
ask, ra);
> >   }
> >
> > +int riscv_csr_write_i64(CPURISCVState *env, int csrno, uint64_t val)
> > +{
> > +    RISCVException ret;
> > +    ret =3D riscv_csrrw(env, csrno, NULL, val,
> > +                      MAKE_64BIT_MASK(0, TARGET_LONG_BITS), 0);
> > +    return ret;
>
> (Directly return?)
>
> > +}
> > +
> > +int riscv_csr_read_i64(CPURISCVState *env, int csrno, uint64_t *res)
> > +{
> > +    RISCVException ret;
> > +    target_ulong val =3D 0;
> > +    ret =3D riscv_csrr(env, csrno, &val);
> > +    *res =3D val;
>
> Clever :)

With the comments addressed:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> > +    return ret;
> > +}
> > +
> >   static RISCVException riscv_csrrw_do128(CPURISCVState *env, int csrno=
,
> >                                           Int128 *ret_value,
> >                                           Int128 new_value,
>
>

