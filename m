Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8C2CCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 01:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEe1Q-0007vi-QE; Thu, 30 Oct 2025 21:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEe1L-0007vF-3S
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 21:33:40 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEe12-0000J2-UD
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 21:33:38 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-63c3d913b3bso3083885a12.2
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 18:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761874392; x=1762479192; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GjrI8zRvcr+mNYeRrFpZPsB13dZDT10u4hZ4ldLQtXA=;
 b=gVjBF+HZjpNopsj3T+CXg/wL1MR+FDPSCHzRTo7QJUMB5QzlKOeGsQWywZ6XLP7D8i
 rfP4FQf1UsqRjbiz2e8fEUcNYMFRMPYt60VrY4I4wZBsn7Lenjw8QCNhyUpqaDTud7io
 VyiiFvOHJgqjCLe41/HDWTTnSDw1kRPLhG5mkro1Vrk7S6qGF6XDeuWXrta7G08tRMnD
 56Ke20jNW/R7bPgc4KPISoOr+HfemOVINijWT7M4Yh+2Z8xXZ3lFSlqUaS7VARb8F090
 gXZLGyiPE1dWspUIa4toKKfTE6L1LFUIXwaHPqSYsn1huOe5Ih7pkRbVvrymjpGZ5KA6
 N5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761874392; x=1762479192;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GjrI8zRvcr+mNYeRrFpZPsB13dZDT10u4hZ4ldLQtXA=;
 b=Ewj8QJI3IuRQ5CzbRwyeJ3w+j+dW2DBhW9nqU8OPn5tBmZY3F5/loV17gJODB0D0rF
 a0Hw6+BabFffh3Nf2UO/R6LJEm9bz8UISxEk9yT8giiJ2kuEhD1RyaOb7ZD9wynIT108
 Yqw1lfct5onmZml+t3lpjZ8wuYVDbucNR4cX3oF6FliWAT/ZAOw0dbcC/MDUngFVCY/i
 IAvBRwr5MwGuWhQ4CwDZGppl2d5ds0I4vc1YSo4+tklViXHitLb/jV7304cjVcOMhOZG
 mXZUZgZZ/JF26QPiRqmh6c43piIcWS+6ZAz6/LgCcBp80sZOIQHnSZaVl64HbiETVFVu
 1NGg==
X-Gm-Message-State: AOJu0Yy3IAceqqN07mHrEEZm4r4ZCJyZgEhQiTkEYjiRzX4XldlDB6me
 MVNCJzezKYm54Lihuct1wDxU7LdHFhTt2Sm0A3p4BofWRuI9JyHU7w/C2Glek/emVJdPF8XsVS6
 7/tYUQPc8q4Z1PD+q2J2dzcqmYgz456k=
X-Gm-Gg: ASbGncv+4AlNARsaJc5RuOrjiUJA1MQ0qwz06Z1se1cZr90sg8yaBcISrzeEemshxDk
 GKUoyblFkWM/3acfiml16Vfp/1PFhtaaCOWBh2M1kDRgNp4Q2W61hrgVjrNRN7vOZT3VTMegZJu
 X8qYDUePLivf/wSgIcckhqZcwoiVdQAAeRbpBAc0D9IkZvkAP3oIdWesPRL+g3Lc4RwqFH8e2Og
 7GGn4U/e742pWYUSQbgdvkKrgM0ub1JSzQG+jQOlAXNPcdFUnh+tTRARdxdGTkggiUJmaA8ZPey
 pQAJv5e6d7ToPXk=
X-Google-Smtp-Source: AGHT+IEyl0pN/Ae3qrdKFFZm2CgnXLF5PavW8+ph0Q3ylBhDFZYR+Q9QS0lsta7nODd+ZLigZmGK3Vgir3FO1fRIZQ8=
X-Received: by 2002:a05:6402:274d:b0:634:a32f:abbc with SMTP id
 4fb4d7f45d1cf-6407703021fmr1393621a12.25.1761874391918; Thu, 30 Oct 2025
 18:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20251027181831.27016-1-anjo@rev.ng>
 <20251027181831.27016-4-anjo@rev.ng>
In-Reply-To: <20251027181831.27016-4-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Oct 2025 11:32:45 +1000
X-Gm-Features: AWmQ_bkvtI43jjtw8-1d0uthFUW52K2X7S3EFdIuqKtdgBZeAzzw5_5OHPFMAn4
Message-ID: <CAKmqyKNWbypqixp+X8coHZLVGZso5zbUs=KknoSSNS7YdG41RA@mail.gmail.com>
Subject: Re: [PATCH v4 03/33] target/riscv: Bugfix
 riscv_pmu_ctr_get_fixed_counters_val()
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
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

On Tue, Oct 28, 2025 at 4:23=E2=80=AFAM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> From my understanding the upper_half argument only indicates whether the
> upper or lower 32 bits should be returned, and upper_half will only ever
> be set when MXLEN =3D=3D 32.  However, the function also uses upper_half =
to
> determine whether the inhibit flags are located in mcyclecfgh or
> mcyclecfg, but this misses the case where MXLEN =3D=3D 32, upper_half =3D=
=3D false
> for TARGET_RISCV32 where we would also need to read the upper half field.
>
> Minor simplifications are also made along with some formatting fixes.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  target/riscv/csr.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 5c91658c3d..657179a983 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -17,6 +17,7 @@
>   * this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>
> +#include "cpu_bits.h"
>  #include "qemu/osdep.h"
>  #include "qemu/log.h"
>  #include "qemu/timer.h"
> @@ -1243,18 +1244,21 @@ static target_ulong riscv_pmu_ctr_get_fixed_count=
ers_val(CPURISCVState *env,
>      int inst =3D riscv_pmu_ctr_monitor_instructions(env, counter_idx);
>      uint64_t *counter_arr_virt =3D env->pmu_fixed_ctrs[inst].counter_vir=
t;
>      uint64_t *counter_arr =3D env->pmu_fixed_ctrs[inst].counter;
> -    target_ulong result =3D 0;
>      uint64_t curr_val =3D 0;
>      uint64_t cfg_val =3D 0;
> +    bool rv32 =3D riscv_cpu_mxl(env) =3D=3D MXL_RV32;
> +
> +    /* Ensure upper_half is only set for MXL_RV32 */
> +    g_assert(rv32 || !upper_half);
>
>      if (counter_idx =3D=3D 0) {
> -        cfg_val =3D upper_half ? ((uint64_t)env->mcyclecfgh << 32) :
> +        cfg_val =3D rv32 ? ((uint64_t)env->mcyclecfgh << 32) :
>                    env->mcyclecfg;
>      } else if (counter_idx =3D=3D 2) {
> -        cfg_val =3D upper_half ? ((uint64_t)env->minstretcfgh << 32) :
> +        cfg_val =3D rv32 ? ((uint64_t)env->minstretcfgh << 32) :
>                    env->minstretcfg;
>      } else {
> -        cfg_val =3D upper_half ?
> +        cfg_val =3D rv32 ?
>                    ((uint64_t)env->mhpmeventh_val[counter_idx] << 32) :
>                    env->mhpmevent_val[counter_idx];
>          cfg_val &=3D MHPMEVENT_FILTER_MASK;
> @@ -1262,7 +1266,7 @@ static target_ulong riscv_pmu_ctr_get_fixed_counter=
s_val(CPURISCVState *env,
>
>      if (!cfg_val) {
>          if (icount_enabled()) {
> -                curr_val =3D inst ? icount_get_raw() : icount_get();
> +            curr_val =3D inst ? icount_get_raw() : icount_get();
>          } else {
>              curr_val =3D cpu_get_host_ticks();
>          }
> @@ -1294,13 +1298,7 @@ static target_ulong riscv_pmu_ctr_get_fixed_counte=
rs_val(CPURISCVState *env,
>      }
>
>  done:
> -    if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> -        result =3D upper_half ? curr_val >> 32 : curr_val;
> -    } else {
> -        result =3D curr_val;
> -    }
> -
> -    return result;
> +    return upper_half ? curr_val >> 32 : curr_val;

This isn't right, why shift this back if it potentially wasn't shifted
in the first place.

This patch should be dropped from the series. If you want I'm happy to
rebase the followup patches

  target/riscv: Combine mhpmevent and mhpmeventh
  target/riscv: Combine mcyclecfg and mcyclecfgh
  target/riscv: Combine minstretcfg and minstretcfgh
  target/riscv: Combine mhpmcounter and mhpmcounterh

without this patch and send them?

Alistair

>  }
>
>  static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, target_ulo=
ng val,
> --
> 2.51.0
>
>

