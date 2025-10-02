Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4085BCAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 23:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4SpE-00013n-JP; Thu, 02 Oct 2025 19:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4SpB-000132-I5
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 19:35:02 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4Soz-0008P9-RD
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 19:35:01 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-61feb87fe26so2411075a12.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 16:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759448083; x=1760052883; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qHVCxeKg8WYAzpgu+GOpSI1O1J8JbosL+BT4I/pTwlA=;
 b=kkkYHncKnYGRnNHB03bgb6uZtsSpMqmKveoNtJrOmOtCVNXvac7+r6QSd2H9x0qEMb
 vW+9QEL9oIRBrrf1lo5tPTno4IiS8mK42vCrOFl4y2dsG/jsKCHnH3WpsisMgVEqys5l
 lSVlggbeu1Mn7UBJJHCriZMjn+tammIAtheBxQd7RhuXBKUtR+7FXgFUgppfjPiqO9f/
 WTYxG7oTwSAcyERPCYmt6N3Ur2qk4nZC6yHyNzTBmKajBrQbAPP9nQbJd5FXQ2yBoPJ3
 gaOViX+mTU6potgOyzi2vVWFiKaAMxd1om2OmE6xKiWg4Wiz5orJp31bR0bk/cqxpbcc
 qgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759448083; x=1760052883;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qHVCxeKg8WYAzpgu+GOpSI1O1J8JbosL+BT4I/pTwlA=;
 b=JAKUkUr/8TwmZ/ot81RPVeN7Xp0yrcJnVWcDkZ2o1wKgeSh2+on7KmFHNKxl4AKvDS
 nrHQiD+yguyW6wwe4S6JkwLEqJ3djNZSoxz8J1mbb72BuIj+YHrPW7KDXdBoMI6YS9tJ
 Ke4/ZDjzOf2GPid6cErvJSGdZLb6qsJINSW49//LUh09E9CyOS5iAX9HmclhgIqqY+g/
 REczSSs8dmryh0S+IkB2DB9UWwZ19OsUr5IEwlGUbIdP4jRQuXCiNEIkBj5D5PQGPUMz
 O/t0bZObmVG1ZXJz5LwJDcRPR0VBcsJX5J9uRpuO9ey4GdXeC21pB8ePCgxycTdFvttZ
 JK9g==
X-Gm-Message-State: AOJu0YxlI3ddQWppZ0PLCiCdiShDRkJTE3nq9aEnus5weXu04lI9wAgK
 Pdrq9jxj4rpvwfGMdXUmU9DkLkyJpHolr+GbPqT206HYxKUY2A7VlwegQPHKg+mzXrDjqzCCUzj
 sMxWFcOakdVHiOI7XwH1Fv7EXH3rCdGU=
X-Gm-Gg: ASbGncs/QPb1o7+3Bs7qjJAhurWmN+AtyImkdrqlA1Va6pIIuETjAEL46JiMmdN4r3r
 2IMEt+L1dkfeMCITJGihTXL/LM+gFsTMpr7oQQi1CFwzCoelfv8081qQCAZFWPkdpP3RGZrmCCf
 BebOvAfcRuaugUT9zrKrRE70YWqvGUvIZUrz1QlszsQbz7r0eomkq+kHrtMcGCnQqVO4zKAoS1T
 NLUEPXJcxd/CLO2VvzFcvrhZeNn2/NXduW6+7sIbpF6BAq53hIOmHhFYNvJxQ==
X-Google-Smtp-Source: AGHT+IHEKUSFozRtnqJBXRNCaxAyeIZQvES6jc7lVArDRDNY1bsaunxd+ExkMPo35ac/XmW2Z4qXsuRFIbECHc0cqbg=
X-Received: by 2002:a17:906:c151:b0:b41:a571:21b0 with SMTP id
 a640c23a62f3a-b49c3d71b70mr130694566b.39.1759448082840; Thu, 02 Oct 2025
 16:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-5-anjo@rev.ng>
In-Reply-To: <20251001073306.28573-5-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 3 Oct 2025 09:34:16 +1000
X-Gm-Features: AS18NWAezip0Yru1oDi2b_lyKJ_yB0gd-JrW9-Ndrw4EvAo7xYVf006JFz_rQZs
Message-ID: <CAKmqyKMSViOs=knzH0bi7k776FvqUX2=XtnKmGrHaeG79=qYEw@mail.gmail.com>
Subject: Re: [PATCH v2 04/33] target/riscv: Bugfix
 riscv_pmu_ctr_get_fixed_counters_val()
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 richard.henderson@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52b.google.com
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

On Wed, Oct 1, 2025 at 5:43=E2=80=AFPM Anton Johansson via
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

If MXLEN =3D=3D 32, upper_half =3D=3D false then we want to read mcyclecfg,
which the code today seems to be doing correctly.

>
> Minor simplifications are also made along with some formatting fixes.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/riscv/csr.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 3c8989f522..859f89aedd 100644
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
> @@ -1241,18 +1242,21 @@ static target_ulong riscv_pmu_ctr_get_fixed_count=
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

This doesn't look right.

RV32 will want to access both mcyclecfgh and mcyclecfg, but this
change restricts access to mcyclecfg as rv32 will always be true.

I don't think there is anything wrong with the current code.

Alistair

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
> @@ -1260,7 +1264,7 @@ static target_ulong riscv_pmu_ctr_get_fixed_counter=
s_val(CPURISCVState *env,
>
>      if (!cfg_val) {
>          if (icount_enabled()) {
> -                curr_val =3D inst ? icount_get_raw() : icount_get();
> +            curr_val =3D inst ? icount_get_raw() : icount_get();
>          } else {
>              curr_val =3D cpu_get_host_ticks();
>          }
> @@ -1292,13 +1296,7 @@ static target_ulong riscv_pmu_ctr_get_fixed_counte=
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
>  }
>
>  static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, target_ulo=
ng val,
> --
> 2.51.0
>
>

