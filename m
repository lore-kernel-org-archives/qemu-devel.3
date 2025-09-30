Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598EACAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 01:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Opj-0002TV-Vl; Mon, 29 Sep 2025 21:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v3Opi-0002TF-4t
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 21:07:10 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v3OpX-0002x5-U2
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 21:07:09 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b403bb7843eso267796866b.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 18:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759194415; x=1759799215; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K3mG6W244bnzz9EUy52hWRP/ADiTXf4+4aOjIXtXRvA=;
 b=XW6zb6Bj13B8m/UVGW0czv5pSH9rThubusF/mmoQ/llOQ5U/aYR5Awu0SsW6ggN27t
 I75+PXYpzaTbGmn0+oFYXDq38oC+qvpV4P9rja7vDtNDBn1zHRPeiFhsAOLnBZeLIoKh
 ErYEJH9p9tBz4lHbEycJOnk9xNQjuxZ0RSf6OOBlJ4Lyxg4mtg78ajnAPxDY6zA9W0A4
 UgEmMF5gPIBiBNq6w29wQtvfZjPdYjMWtCpsi4iLbCAG2dv3iZyp+bnUQ+ZmaX6m/JwO
 1pdpC//VOZ4p6Cji7j8JzHIrk9kOUTblvyJzAP9mDyGqjPEdtEA+e4QOkmzOv6ZViGD2
 TGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759194415; x=1759799215;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K3mG6W244bnzz9EUy52hWRP/ADiTXf4+4aOjIXtXRvA=;
 b=simCHesIieXutvhTM/+aDWloXLWaviEDcSmhHaw0ur6qyQt7fV6n3EOMWcBhxQbO0X
 3ORLyytrevYY+tlmEizwXsEoxRd4BFDvHrKCW8t3j4//6f201q5p0XSN4R8cS2GpxKl5
 qf0/EPsdnH3R1+/Pi7mKWnrA5EyyHtjfh1dXt8rRaFKjBHHA+7gzkAZJ34oTvIensu+6
 5pV8XF8+UvwEobbNrFAnEQKOW4aBgakWuE2ZHiGIE3l7DQ/qcMOy1WylMjayg61FtAM4
 q2jnMulQe2bBhsThFNFcybO53AJuz3D+rpviSu002noS+l2oMoRCReJ0TIewt5QP9YTY
 wxUg==
X-Gm-Message-State: AOJu0YyMwdlqZytkc5YTellHgOjE3ohcn7+f7xXhQMqcU5slV081d2vi
 HHjU85geAnycUu7KHlfGkJnJytVqJgHYW3dng/5W4aqZknAWuO6joF82ESTzgpTkVqsxlWQ/n/n
 8tmRvo4RswBfFIFxN1tcQFtVWyLlUglk=
X-Gm-Gg: ASbGnctR+RTVZ2dcrVv04hQ65FYNgcLnkA7j+aL6NBdDjXklIS7oUVBJMLPKmxnTxK/
 cnId98EflDAEjFoaJDDSj3I1yYkrSdA6hQgjqzrlXW54b7gFf/NEL9EhMG2QUFBX35R2uvbLJ3I
 LLOiDkqVEHdwzokqSpuNqYDbt/CJS0aPZYacp5HhsUmvP1nUqPVZwn3l+KQ04ytX39XQl/AeuGB
 Vt2OA6ZwkHC2x5599C8cCGbSWUQU4A8Q8jd9L27xXBF58OG
X-Google-Smtp-Source: AGHT+IGAwiUZ5hlLAGcwEUa5RhAPUgH0XSFEH0AhxlbMgpdmnbDJye1aqfQDFzhVychBVxnuu1uRnNgTxSv1A/rewf4=
X-Received: by 2002:a17:907:6093:b0:b04:6a58:560b with SMTP id
 a640c23a62f3a-b34ba93ce11mr2016409766b.39.1759194415187; Mon, 29 Sep 2025
 18:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250924091746.1882125-1-djordje.todorovic@htecgroup.com>
 <20250924091746.1882125-3-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250924091746.1882125-3-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Sep 2025 11:06:29 +1000
X-Gm-Features: AS18NWAJQ30Ys9wPN1UnsUW5EMJwv8AOBLKNvsw3jZwJFsfaVeALwaNPrPfiZQY
Message-ID: <CAKmqyKM+FXe3EVR1Mzpq3pVCEFg_wG7qfgkrjFuQ1HiifdGyvA@mail.gmail.com>
Subject: Re: [PATCH v8 02/14] target/riscv: Add cpu_set_exception_base
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>
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
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Sep 24, 2025 at 7:21=E2=80=AFPM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> Add a new function, so we can change reset vector from platforms
> during runtime.

There is already a "resetvec" property, which hw/riscv/opentitan.c is
using to set a custom resetvec. Why can't you use that?

Alistair

>
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c | 14 ++++++++++++++
>  target/riscv/cpu.h |  4 ++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d055ddf462..74728c5371 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -73,6 +73,20 @@ bool riscv_cpu_option_set(const char *optname)
>      return g_hash_table_contains(general_user_opts, optname);
>  }
>
> +#ifndef CONFIG_USER_ONLY
> +void cpu_set_exception_base(int vp_index, target_ulong address)
> +{
> +    CPUState *cpu_state =3D qemu_get_cpu(vp_index);
> +    if (cpu_state =3D=3D NULL) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "cpu_set_exception_base: invalid vp_index: %u",
> +                      vp_index);
> +    }
> +    RISCVCPU *vp =3D RISCV_CPU(cpu_state);
> +    vp->env.resetvec =3D address;
> +}
> +#endif
> +
>  static void riscv_cpu_cfg_merge(RISCVCPUConfig *dest, const RISCVCPUConf=
ig *src)
>  {
>  #define BOOL_FIELD(x) dest->x |=3D src->x;
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 4a862da615..34751bd414 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -672,6 +672,10 @@ G_NORETURN void riscv_raise_exception(CPURISCVState =
*env,
>  target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
>  void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
>
> +#ifndef CONFIG_USER_ONLY
> +void cpu_set_exception_base(int vp_index, target_ulong address);
> +#endif
> +
>  FIELD(TB_FLAGS, MEM_IDX, 0, 3)
>  FIELD(TB_FLAGS, FS, 3, 2)
>  /* Vector flags */
> --
> 2.34.1
>

