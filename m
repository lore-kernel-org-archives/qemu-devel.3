Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF12CDE00C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 01:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcvCR-0006f9-2x; Thu, 25 Jun 2026 21:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcvCM-0006eg-Aw
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 21:17:39 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcvCJ-00056T-QU
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 21:17:37 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6978f0870c9so714698a12.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 18:17:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782436654; cv=none;
 d=google.com; s=arc-20260327;
 b=l+2aMOb84+cQiQTBYuuURqlbrrWpXyqg90Fmx1meiE4cn+FVRF8fwW7tyDmLyQa9wY
 MUMd2IWXystFNtf0qxYfQ2cryVh9lsgDFWAGk6Oc7+ytW1xv1wHIgLTLI+C+UBUOlZD3
 M6VV3jq4x8NZHQgoNQ5G5xXnaFtl6F7HZckNHEAlBOaAesUUS/We6XfsRf3LTZgDoRon
 RLTXYUvxF3t3Row/pDXIjYEdhv4EJ7VeH5nMoL+so1CmnQWSXJv8buBv5yaEjGwwiWF0
 sfKsiqeNCw8TWwmnhy+aO4y5zHoSb/8V8yHucxjHpmhy+Ww1GubNzp0PpTzesyEMDa/Z
 OXHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=naFbRo+L+gKf9Smlbf6aGayGRsGasYoZNdRCa0x4oPg=;
 fh=9/4tzqKjgzJcjmYJcCvfm+LbcgW0ATp/rdwAYjKmbVo=;
 b=J1v4oIHTaRDVo9Uo/uwv1pk/M0S6nCqmGceMgn+CIIYwcmIy6PAgyAHl2+G7gyitYr
 NuZOIOJbNOSrHjZWVcJ7QqIdSjE/2Js5Sy4UtL2ab/2FfxhX1Jxfj1PMLAOKZQCAJZ/j
 QIlx2jatCHxJoIZjo/VVpuG58+/2QspqW3nI8H0amVxX6V53cVpNKuQ9c179QkwWrifS
 6ngGA/8oj54tj3j83iC6avNJ6C08qJ87UR6TBxGayG+q4GtsHxze3sltklhgMuNDMNVX
 /FIbuzvP0X/Pc48lBfixp4tHx3l9KcPwouywZ94P+uUEEwb4SroMntYxuD1eYlCK5cSP
 USpw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782436654; x=1783041454; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=naFbRo+L+gKf9Smlbf6aGayGRsGasYoZNdRCa0x4oPg=;
 b=V+cB1D2YgcSUx7/U3Xj0BVRbXaKFNZIl3QktID4IVUl+eUFpLaze0P8qVaIlJYVMMD
 PE7mMbvnUpIkmno0bICmCNd0oN7vSM3Nf8NGrK/f+YBwQFGOtQFmbh7WvcnBhhaFoGFb
 Qss9bhkVOEGPxoDyYRGa6YZwRHV0Wl3kK2zIQQLDsGf3vOHb+PG3Mg5+J9WHAUpN/Stl
 TYr7byv8JrA0HyXmMzkdfhrYEwOLp8PEmwR+QjQilEHalx9TT2dF+EnMpOe7Kn4b/d7T
 iFB2ZuVRAdgiMz4Sdo2BoqHswTRacLO869hFQ1TBbL0jfndiU4z5OisaGoONtFydicsQ
 GaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782436654; x=1783041454;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=naFbRo+L+gKf9Smlbf6aGayGRsGasYoZNdRCa0x4oPg=;
 b=RnBPwK/GC6gzsGHu41eKPVZU014uozWwBffNtHQTiE5RFaXPtixtjfGv07YVkifHBI
 1IQO+aJnIMxTKcf9n2+VSbjp1h9NwOOAn3KtAvRjlIRBtPn3u1cyzluiRhtiOgXu2mM5
 AGvJ9IZEVeISAG28T1jHQIbWB0pgKGacvxWPxEQkfY+Yih42cShlaEpNWxY6YXkCqAEm
 PQf1TFxjbfZNG9mpqrgERxL1cqZGcmr5YN0Dpu0TtwiJTKegHTcSnwfhazvhVbYjeOwt
 k/nCd1tjVUfGT2fcQkrvgsO3IXLgXtwaTx7VL5NoSICSpxuAgfgmoc2kBUiR0saBq7gU
 fdZg==
X-Gm-Message-State: AOJu0YztJIbuVNgXR18y4Xaya+fbGw+XYiLu+ailsuWNA3NbwgPehx6/
 mF4ijIViFBQEb7VKH3o/TMOQXgQSjJPvclMtV5SdvZ2ExLaATSvVveaG2bopwBW4aNA5FiOKG+B
 jt9VnCnVLEcCz3XOVzkU0gcu0Zc0vVcg=
X-Gm-Gg: AfdE7ckw340HUS3ABURbmYEI1NBMr9BU6w979m/HqEEH/bw+m0Hr7VkqHwCd6VsI4Qq
 sKJn1zrdg8RKX6nP96PKE9Bi2B7oaSgYJQLIDttmp1n3CGWwnvw7xhpnIUMdwLQhqYJewgZReYk
 iAlZQL+tInwGr9cVa9HDQoEpy+yhiuoSocmoISJN0CGwmrcbbF/yVr9VYnba0IeoKmuYQzwLZi4
 UDDRyakP8YFTjXJUx/J5Z2aio14Kt2MSYcncv3Z9/e9eTb/ncvxcDG+3FRh7j6rYZCFjWZjc317
 AEi6jKNXwwTRyiAjlovELDVuZNE=
X-Received: by 2002:a05:6402:3588:b0:698:ecf:d18a with SMTP id
 4fb4d7f45d1cf-69810a53296mr849906a12.9.1782436653888; Thu, 25 Jun 2026
 18:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
 <20260624000632.2149359-17-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260624000632.2149359-17-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 26 Jun 2026 11:17:07 +1000
X-Gm-Features: AVVi8Cf43PryZTnoRAWYN0iFSXWiDgxx34cbfv2Z5Yi2PXbT64MsktHpvJCe4bY
Message-ID: <CAKmqyKN6Su7VquExVU10s5DrJhgE_2ma1G6dpAbk2UyUgu8fPw@mail.gmail.com>
Subject: Re: [PATCH v2 16/24] target/riscv: gate riscv_cpu_update_mip with
 tcg_enabled()
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 fritchleybohrer@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52c.google.com
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

On Wed, Jun 24, 2026 at 10:10=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> riscv_cpu_update_mip() is a TCG only call.  Its KVM equivalent is
> kvm_riscv_set_irq().  cpu.c gates the KVM only function with a
> kvm_enabled() check, making it unavailable for TCG only builds.  We need
> to do the same for riscv_cpu_update_mip() otherwise a KVM only build
> will fail because it doesn't know what this function is.
>
> Use tcg_enabled() for the couple of riscv_cpu_update_mip() calls we have
> unguarded in cpu.c.
>
> We have way more calls to deal with in time_helper.c which isn't using
> kvm_riscv_set_irq() at all, so create a riscv_accel_set_irq() local
> helper that will choose whether to use the KVM or TCG API.
>
> The reason we're going through all this hassle in time_helper.c is
> because hw/int/riscv_aclint.c uses it, and if we don't do something
> about we won't have riscv_aclint working for KVM.  Whether this is a
> real problem or not and we should remove aclint support for KVM is
> question for another day.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c         | 19 ++++++++++++++-----
>  target/riscv/time_helper.c | 33 +++++++++++++++++++++++++--------
>  2 files changed, 39 insertions(+), 13 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 7bd5bc0fc1..8f9d2967ef 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1336,14 +1336,18 @@ static void riscv_cpu_set_irq(void *opaque, int i=
rq, int level)
>          case IRQ_M_EXT:
>              if (kvm_enabled()) {
>                  kvm_riscv_set_irq(cpu, irq, level);
> -            } else {
> +            }
> +
> +            if (tcg_enabled()) {
>                  riscv_cpu_update_mip(env, 1 << irq, BOOL_TO_MASK(level))=
;
>              }
>               break;
>          case IRQ_S_EXT:
>              if (kvm_enabled()) {
>                  kvm_riscv_set_irq(cpu, irq, level);
> -            } else {
> +            }
> +
> +            if (tcg_enabled()) {
>                  env->external_seip =3D level;
>                  riscv_cpu_update_mip(env, 1 << irq,
>                                       BOOL_TO_MASK(level | env->software_=
seip));
> @@ -1370,9 +1374,14 @@ static void riscv_cpu_set_irq(void *opaque, int ir=
q, int level)
>              env->hgeip |=3D 1ULL << irq;
>          }
>
> -        /* Update mip.SGEIP bit */
> -        riscv_cpu_update_mip(env, MIP_SGEIP,
> -                             BOOL_TO_MASK(!!(env->hgeie & env->hgeip)));
> +        if (kvm_enabled()) {
> +            kvm_riscv_set_irq(cpu, irq, level);
> +        }
> +        if (tcg_enabled()) {
> +            /* Update mip.SGEIP bit */
> +            riscv_cpu_update_mip(env, MIP_SGEIP,
> +                                 BOOL_TO_MASK(!!(env->hgeie & env->hgeip=
)));
> +        }
>      } else {
>          g_assert_not_reached();
>      }
> diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
> index 400e917354..ede1a4c2a3 100644
> --- a/target/riscv/time_helper.c
> +++ b/target/riscv/time_helper.c
> @@ -21,19 +21,34 @@
>  #include "cpu_bits.h"
>  #include "time_helper.h"
>  #include "hw/intc/riscv_aclint.h"
> +#include "kvm/kvm_riscv.h"
> +#include "system/kvm.h"
> +#include "system/tcg.h"
> +
> +static void riscv_accel_set_irq(RISCVCPU *cpu, int irq, int level)
> +{
> +    if (kvm_enabled()) {
> +        kvm_riscv_set_irq(cpu, irq, level);
> +    }
> +
> +    if (tcg_enabled()) {
> +        riscv_cpu_update_mip(&cpu->env, irq, level);
> +    }
> +}
> +
>
>  static void riscv_vstimer_cb(void *opaque)
>  {
>      RISCVCPU *cpu =3D opaque;
>      CPURISCVState *env =3D &cpu->env;
>      env->vstime_irq =3D 1;
> -    riscv_cpu_update_mip(env, 0, BOOL_TO_MASK(1));
> +    riscv_accel_set_irq(cpu, 0, BOOL_TO_MASK(1));
>  }
>
>  static void riscv_stimer_cb(void *opaque)
>  {
>      RISCVCPU *cpu =3D opaque;
> -    riscv_cpu_update_mip(&cpu->env, MIP_STIP, BOOL_TO_MASK(1));
> +    riscv_accel_set_irq(cpu, MIP_STIP, BOOL_TO_MASK(1));
>  }
>
>  /*
> @@ -48,6 +63,7 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMU=
Timer *timer,
>      RISCVAclintMTimerState *mtimer =3D env->rdtime_fn_arg;
>      uint32_t timebase_freq;
>      uint64_t rtc_r;
> +    RISCVCPU *cpu;
>
>      if (!riscv_cpu_cfg(env)->ext_sstc || !env->rdtime_fn ||
>          !env->rdtime_fn_arg || !get_field(env->menvcfg, MENVCFG_STCE)) {
> @@ -63,6 +79,7 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMU=
Timer *timer,
>
>      timebase_freq =3D mtimer->timebase_freq;
>      rtc_r =3D env->rdtime_fn(env->rdtime_fn_arg) + delta;
> +    cpu =3D env_archcpu(env);
>
>      if (timecmp <=3D rtc_r) {
>          /*
> @@ -71,9 +88,9 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMU=
Timer *timer,
>           */
>          if (timer_irq =3D=3D MIP_VSTIP) {
>              env->vstime_irq =3D 1;
> -            riscv_cpu_update_mip(env, 0, BOOL_TO_MASK(1));
> +            riscv_accel_set_irq(cpu, 0, BOOL_TO_MASK(1));
>          } else {
> -            riscv_cpu_update_mip(env, MIP_STIP, BOOL_TO_MASK(1));
> +            riscv_accel_set_irq(cpu, MIP_STIP, BOOL_TO_MASK(1));
>          }
>          return;
>      }
> @@ -81,9 +98,9 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMU=
Timer *timer,
>      /* Clear the [VS|S]TIP bit in mip */
>      if (timer_irq =3D=3D MIP_VSTIP) {
>          env->vstime_irq =3D 0;
> -        riscv_cpu_update_mip(env, 0, BOOL_TO_MASK(0));
> +        riscv_accel_set_irq(cpu, 0, BOOL_TO_MASK(0));
>      } else {
> -        riscv_cpu_update_mip(env, timer_irq, BOOL_TO_MASK(0));
> +        riscv_accel_set_irq(cpu, timer_irq, BOOL_TO_MASK(0));
>      }
>
>      /*
> @@ -151,7 +168,7 @@ static void riscv_timer_disable_timecmp(CPURISCVState=
 *env, QEMUTimer *timer,
>  {
>      /* Disable S-mode Timer IRQ and HW-based STIP */
>      if ((timer_irq =3D=3D MIP_STIP) && !get_field(env->menvcfg, MENVCFG_=
STCE)) {
> -        riscv_cpu_update_mip(env, timer_irq, BOOL_TO_MASK(0));
> +        riscv_accel_set_irq(env_archcpu(env), timer_irq, BOOL_TO_MASK(0)=
);
>          timer_del(timer);
>          return;
>      }
> @@ -161,7 +178,7 @@ static void riscv_timer_disable_timecmp(CPURISCVState=
 *env, QEMUTimer *timer,
>          (!get_field(env->menvcfg, MENVCFG_STCE) ||
>           !get_field(env->henvcfg, HENVCFG_STCE))) {
>          env->vstime_irq =3D 0;
> -        riscv_cpu_update_mip(env, 0, BOOL_TO_MASK(0));
> +        riscv_accel_set_irq(env_archcpu(env), 0, BOOL_TO_MASK(0));
>          timer_del(timer);
>          return;
>      }
> --
> 2.43.0
>
>

