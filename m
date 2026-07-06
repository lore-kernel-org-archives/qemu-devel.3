Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7C7C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 00:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgXRo-0006Ib-CH; Sun, 05 Jul 2026 20:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgXRn-0006Hj-3F
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 20:44:31 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgXRl-0004un-AC
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 20:44:30 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-698562f10e7so2986234a12.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 17:44:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783298668; cv=none;
 d=google.com; s=arc-20260327;
 b=NpE0zbWmiI1+jJX1B3THrgzFrSio3tHfsII1Z3XbSH6MmeJFmRfBZikFKPhHisyltI
 3E+4wQlT5ZRTFP4KeJ23AfLv8afRC+maUSnvE7ZYxUWqjMSX3rix2le4tsKigTDmb2N+
 Zfe7c3aOryCB6ycvfAylzSJCBfVsj5wgPGVOJz7QgsRnpBItNCasJZwkhgL+cnLJ9NVA
 sedxJNNdgK5adc9kzI13ViADOJZVSaFdV9GLZpbJQhZdWorsXDRaX1co9uwMo5rAr4VS
 0G5EMjGCdDoY+PFmHX9Dp4uIod8s1AOaB3K4XEyrn+Re5f7nca8j4AgTeV5aIZoo/qrZ
 QKJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ppIkqmGkODAX/F/4M1lcC1DPKwl+li8r85LjZtjyNIU=;
 fh=F2jHHLOhAUdxIpT/mOESKAzlhKPgUW33d0+z1UtXHTg=;
 b=JOjLPmXioaKa9YF15XDFYZmyjGzvZE4A0k1f2k1bKk6KfIdKSlHRU9UZBHgJNCE910
 PduYsdgtgdsZsn08WsFv10yUJ+aarDxMDdfab4QVDOY3ue2cEWhPQvVYxMwPmsZq807z
 ulTy5Rm8mmwV4eESddNfjuNpEdwn1uBGRhyTqebWVYfCHs+bWzmLlhIrXSxE1i99EFmD
 3o1xWDhQJ6oxAu/fcM4k/G0lkdzgpUSIhaeanq430Gh4x0FqUOOIyfqEQkHpDW0sh92t
 QPj2Arrc5jDMVjx/3MTT291NI2TB60D1Td/jvS2HWSexwgoy1bEJTee5N421PhNKfZ/a
 nHiA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783298668; x=1783903468; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ppIkqmGkODAX/F/4M1lcC1DPKwl+li8r85LjZtjyNIU=;
 b=sq7DAY/r6CWQkSIQE1tzYKWCk0e6dcN2pYStSiPxCk9hHD7koklKSIEVyK1hF5KAy/
 BR4utYIS+ShgXPa3MKkPTpjRxWwqK0tbb6apUgUfbWKGmWHS7bHW61tjRn7yd0yPwtB5
 E28nemhhFYaHMEUZADCpC/zEI0B/KFadtd+ks8zy+qINqW/TKiqoy7Wnld84BNAosjqK
 Tar+xCt03e14xlGrWtiteCl2f+RaPST4wmhsEozyQooVn6KFQUXzT7MAonXa2Ykm5zzk
 kLwDCGXSrreht7dLCK6viwVoUUP95X+f5NsyoPqomBXE/o5/yCo3C8cCJ36kPPdtSWdC
 L1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783298668; x=1783903468;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ppIkqmGkODAX/F/4M1lcC1DPKwl+li8r85LjZtjyNIU=;
 b=qvbqh8mv8BnweeDIFek0GoQxFMnA0umxo3TmdbfzocCB4+cIEHpmjGOjiSLOlPDDWB
 FiYdkSuszdBTKdGNLPlOnTOGy51sufUd2ep1gtka1f0JGpHn7V0828p2hpDhEf6SJmGD
 thYSYBAayHXTWv3/3GnvipYbAvXkL5gje3XWz3C9vB6138fmI9VYcu9jht0+zbMWpCV2
 ny7HcjZEZAU5w+aII5MQwz3OIyM17vhbkCd7Dd4GA8Xdw92qjAFVMBVWrsFwM45x4f7V
 +tGHpSsOr2wzQ8BvkmxSTC+rr+OgY1TbzZoZH7Kqhfx3q3iSqizO6TXtoDcdMHuj7rYI
 3GnQ==
X-Gm-Message-State: AOJu0YziXK6hKp1/AAQyI4Pul4B8lU+6Ew2gc8+9mwsWrUYFouoxuiS8
 8qYtAmw5ITt4vS3EcAlMcSqTQnTHYfYcY1qOjSx21jUvtfV/fs27lneyIyA/xedTlJ8ie0Kol7F
 PoygFjowjmMBWVWBHSmsrDoeOKpSbqlI=
X-Gm-Gg: AfdE7ck9XgDca0fYdiBqNuwhzITskVthwj8D+1ObIwL4hsiHWdH+Fx5RM2DiB+i65w4
 BwAnfZY6BTd7CqpwBw95SzxPk/EGbAGD6g+P+hUJouVpRA6Nfr2R+TfptuJtq43WS0XmiCd20ow
 c/XZDjOoUEA5MAyW2r5wEuRhYKnSt9SZuW+AeDC92BN3rDm41kW05sHVco73vi6DOGC2Wq5baRl
 I0oHytSulxN1TxPV4vBuxULhZxZko2uLh9qtQbkR+ydFJcxqu0ZvYAX4LtYUZF2abvEe7S1VE1z
 7bGJXBAUOhvSG6uX/mGUV74q4N2PCMDJTFoWYA==
X-Received: by 2002:a05:6402:5288:b0:698:bf58:e53f with SMTP id
 4fb4d7f45d1cf-69a1a2ae4aemr2367560a12.20.1783298667764; Sun, 05 Jul 2026
 17:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
 <20260702135128.1188021-23-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260702135128.1188021-23-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2026 10:44:00 +1000
X-Gm-Features: AVVi8CdRt8wtqws8gBd39OCr2toHeTQYHBLTxGLTTqq98Kz7Z8b9Kby0lpUJPK4
Message-ID: <CAKmqyKOMf4977GaNZq4VFa8J+s8C46bHAcXjmUEWTm15Kv2xRQ@mail.gmail.com>
Subject: Re: [PATCH v3 22/24] target/riscv: move riscv_cpu_set_geilen() to
 riscv-imsic
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jul 2, 2026 at 11:56=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> riscv_imsic.c is the only caller.  Having it sitting in the TCG only
> cpu_helper.c gets in the way of --disable-tcg for no good reason.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/intc/riscv_imsic.c         | 13 +++++++++++++
>  target/riscv/cpu.h            |  1 -
>  target/riscv/tcg/cpu_helper.c | 13 -------------
>  3 files changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
> index 7e5b5349ba..ebb55191c7 100644
> --- a/hw/intc/riscv_imsic.c
> +++ b/hw/intc/riscv_imsic.c
> @@ -46,6 +46,19 @@
>  #define IMSIC_EISTATE_ENPEND           (IMSIC_EISTATE_ENABLED | \
>                                          IMSIC_EISTATE_PENDING)
>
> +static void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen)
> +{
> +    if (!riscv_has_ext(env, RVH)) {
> +        return;
> +    }
> +
> +    if (geilen > (TARGET_LONG_BITS - 1)) {
> +        return;
> +    }
> +
> +    env->geilen =3D geilen;
> +}
> +
>  static uint32_t riscv_imsic_topei(RISCVIMSICState *imsic, uint32_t page)
>  {
>      uint32_t i, max_irq, base;
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 7618110412..7a4d8abe07 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -646,7 +646,6 @@ int riscv_cpu_pending_to_irq(CPURISCVState *env,
>
>
>  bool riscv_cpu_fp_enabled(CPURISCVState *env);
> -void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen);
>  bool riscv_cpu_vector_enabled(CPURISCVState *env);
>  void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
>  int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
> diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.=
c
> index 6b39152ee2..71a96a20ef 100644
> --- a/target/riscv/tcg/cpu_helper.c
> +++ b/target/riscv/tcg/cpu_helper.c
> @@ -526,19 +526,6 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *e=
nv)
>      }
>  }
>
> -void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen)
> -{
> -    if (!riscv_has_ext(env, RVH)) {
> -        return;
> -    }
> -
> -    if (geilen > (TARGET_LONG_BITS - 1)) {
> -        return;
> -    }
> -
> -    env->geilen =3D geilen;
> -}
> -
>  void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level)
>  {
>      CPURISCVState *env =3D &cpu->env;
> --
> 2.43.0
>
>

