Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69D9CCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 05:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8XNq-0001Cq-LJ; Tue, 14 Oct 2025 01:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v8XNp-0001CZ-Rv
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 01:15:37 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v8XNn-00051i-Mx
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 01:15:37 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-634b774f135so7779855a12.2
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 22:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760418934; x=1761023734; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TWEKL+K2EdHFX23rio2xc7rOoZrOpXqpzaRi2cEUSWI=;
 b=kpibA+fOq6oi+y+vT7rLJfXqhSeLVV+8uyJjkB36u4j8JXxnnd7rRJ8jGiMi5KCr8A
 beSqZlEjzZuM2pd5JwJwyWUQ0n1txeIaYg6zsfC0gjrJE5LYOioQbg/sAOYi4YDec3CR
 ySpESirMpY36CFZlWMYEsuKJY0uj/kJ8Gs6gAwkx9cUKlpJxEmEMjXcQtfRL5OgiI8xd
 v4/HN7UhsJzQZdHOIh4kdu50tE1JVNeOqko1FO/WwZ4zS8HpXwDqty4bCcuzEL4Ipp0L
 K4Dj/ct0gNL4HvMomm8sfkYkSIIwMdMwVkZy+xdINTYLxuadXXFh5SRdcHmJbxOeBVkD
 oGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760418934; x=1761023734;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TWEKL+K2EdHFX23rio2xc7rOoZrOpXqpzaRi2cEUSWI=;
 b=exZQHAr9bBW9PURscP3xweYS8xu4jiUR+0ZK/o+6s1l9HUYZmSRspM6DzZ2qHEWx5d
 oJWsDpYfzGSVBCmDUDlMC4d9hhawROp6LZJA5RUH/8BnaKOmX6c3FhWBP5+ce5GIb4OP
 9gZ7Fo/ko6wgcXPyp660U5MH7o1LCFFHyGBTr7BRVQ3Y4P+kJIUbMF3/asyAz3o+Z89a
 OC7XMI/7hftZRb7K+4h0Gph685Wz61YUYg4FRndCh4xDJNDJgwkkprAO7QPgu2VL4Fm+
 pZYYLM7gESneSSbfUFF9hqqGgGjXfcRFPg+72gWGGupcpoCk/wZq/1IZUySTj+85b/Zf
 00GA==
X-Gm-Message-State: AOJu0YynOHDfpecbDLJA62pQzDM5LSPDI1xir8EAYIqhyyAUstEUxa++
 0UzVBaBoi+63sa7fGZIGtLgwz8SR9WWTVFOJ8EYUUgIL+pTSw2kKGw+VunkTFDDblGWXjdr7spa
 RUl5/fmoxbImgVm0xzkocB6Hq8I2vpn0=
X-Gm-Gg: ASbGncu/0m7Qajdg2pn+j64SUOuztD67LRViTnbRLjWURSzm+hwvjDpecukR05qK2c1
 f5LYCHXQxvuyIaOlDXa2CU3Op4V8GCwL8eT8eXssHIU+1QXJpeTDJHlsJiIBm/f6KJ/m7VzTMLt
 ohG70PusvlvfhNmdnU9D8wUweN9FMrHPGnUL4hKANx/vkmo3qvW+rNsrh4dFKkIkJQb1tiyj8I4
 7btY6ybIPZ1AilypfHS9xdm2e25xDMtg9f62mib+3qQ6oBExwWYkyAJain7fMET/z8=
X-Google-Smtp-Source: AGHT+IE9X7t3z+452ufCeRYTLKfQWAh4Ln64+KM5dTXjusQ6j44w1gdeDyL8FuHmvmu0djQwo2YVWzck5vLgISzPVto=
X-Received: by 2002:a05:6402:34c9:b0:637:98a1:c7c4 with SMTP id
 4fb4d7f45d1cf-639d5b43aefmr18713744a12.5.1760418933869; Mon, 13 Oct 2025
 22:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <20251010155045.78220-1-philmd@linaro.org>
 <20251010155045.78220-14-philmd@linaro.org>
In-Reply-To: <20251010155045.78220-14-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 14 Oct 2025 15:15:06 +1000
X-Gm-Features: AS18NWBr7ECcFnKlgcz-_7xhjc7klpejQBzibBp52LlqBAsrtri2RAKly-7y2_I
Message-ID: <CAKmqyKMxiOc+Sm2eXVxm_HgBCi0v28Echu=EqAkyvNRCiVNHjw@mail.gmail.com>
Subject: Re: [PATCH 13/13] target/riscv: Introduce mo_endian_env() helper
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Christoph Muellner <christoph.muellner@vrull.eu>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Anton Johansson <anjo@rev.ng>, Richard Henderson <richard.henderson@linaro.org>,
 Valentin Haudiquet <valentin.haudiquet@canonical.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x536.google.com
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

On Sat, Oct 11, 2025 at 1:56=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> mo_endian_env() returns the target endianness from CPUArchState.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/op_helper.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index c486f771d35..9d048089e2a 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -28,6 +28,18 @@
>  #include "exec/tlb-flags.h"
>  #include "trace.h"
>
> +static inline MemOp mo_endian_env(CPURISCVState *env)
> +{
> +    /*
> +     * A couple of bits in MSTATUS set the endianness:
> +     *  - MSTATUS_UBE (User-mode),
> +     *  - MSTATUS_SBE (Supervisor-mode),
> +     *  - MSTATUS_MBE (Machine-mode)
> +     * but we don't implement that yet.
> +     */
> +    return MO_TE;
> +}
> +
>  /* Exceptions processing helpers */
>  G_NORETURN void riscv_raise_exception(CPURISCVState *env,
>                                        RISCVException exception,
> @@ -633,7 +645,7 @@ target_ulong helper_hyp_hlv_hu(CPURISCVState *env, ta=
rget_ulong addr)
>  {
>      uintptr_t ra =3D GETPC();
>      int mmu_idx =3D check_access_hlsv(env, false, ra);
> -    MemOpIdx oi =3D make_memop_idx(MO_TE | MO_UW, mmu_idx);
> +    MemOpIdx oi =3D make_memop_idx(mo_endian_env(env) | MO_UW, mmu_idx);
>
>      return cpu_ldw_mmu(env, adjust_addr_virt(env, addr), oi, ra);
>  }
> @@ -642,7 +654,7 @@ target_ulong helper_hyp_hlv_wu(CPURISCVState *env, ta=
rget_ulong addr)
>  {
>      uintptr_t ra =3D GETPC();
>      int mmu_idx =3D check_access_hlsv(env, false, ra);
> -    MemOpIdx oi =3D make_memop_idx(MO_TE | MO_UL, mmu_idx);
> +    MemOpIdx oi =3D make_memop_idx(mo_endian_env(env) | MO_UL, mmu_idx);
>
>      return cpu_ldl_mmu(env, adjust_addr_virt(env, addr), oi, ra);
>  }
> @@ -651,7 +663,7 @@ target_ulong helper_hyp_hlv_d(CPURISCVState *env, tar=
get_ulong addr)
>  {
>      uintptr_t ra =3D GETPC();
>      int mmu_idx =3D check_access_hlsv(env, false, ra);
> -    MemOpIdx oi =3D make_memop_idx(MO_TE | MO_UQ, mmu_idx);
> +    MemOpIdx oi =3D make_memop_idx(mo_endian_env(env) | MO_UQ, mmu_idx);
>
>      return cpu_ldq_mmu(env, adjust_addr_virt(env, addr), oi, ra);
>  }
> @@ -669,7 +681,7 @@ void helper_hyp_hsv_h(CPURISCVState *env, target_ulon=
g addr, target_ulong val)
>  {
>      uintptr_t ra =3D GETPC();
>      int mmu_idx =3D check_access_hlsv(env, false, ra);
> -    MemOpIdx oi =3D make_memop_idx(MO_TE | MO_UW, mmu_idx);
> +    MemOpIdx oi =3D make_memop_idx(mo_endian_env(env) | MO_UW, mmu_idx);
>
>      cpu_stw_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
>  }
> @@ -678,7 +690,7 @@ void helper_hyp_hsv_w(CPURISCVState *env, target_ulon=
g addr, target_ulong val)
>  {
>      uintptr_t ra =3D GETPC();
>      int mmu_idx =3D check_access_hlsv(env, false, ra);
> -    MemOpIdx oi =3D make_memop_idx(MO_TE | MO_UL, mmu_idx);
> +    MemOpIdx oi =3D make_memop_idx(mo_endian_env(env) | MO_UL, mmu_idx);
>
>      cpu_stl_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
>  }
> @@ -687,7 +699,7 @@ void helper_hyp_hsv_d(CPURISCVState *env, target_ulon=
g addr, target_ulong val)
>  {
>      uintptr_t ra =3D GETPC();
>      int mmu_idx =3D check_access_hlsv(env, false, ra);
> -    MemOpIdx oi =3D make_memop_idx(MO_TE | MO_UQ, mmu_idx);
> +    MemOpIdx oi =3D make_memop_idx(mo_endian_env(env) | MO_UQ, mmu_idx);
>
>      cpu_stq_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
>  }
> @@ -703,7 +715,7 @@ target_ulong helper_hyp_hlvx_hu(CPURISCVState *env, t=
arget_ulong addr)
>  {
>      uintptr_t ra =3D GETPC();
>      int mmu_idx =3D check_access_hlsv(env, true, ra);
> -    MemOpIdx oi =3D make_memop_idx(MO_TE | MO_UW, mmu_idx);
> +    MemOpIdx oi =3D make_memop_idx(mo_endian_env(env) | MO_UW, mmu_idx);
>
>      return cpu_ldw_code_mmu(env, addr, oi, GETPC());
>  }
> @@ -712,7 +724,7 @@ target_ulong helper_hyp_hlvx_wu(CPURISCVState *env, t=
arget_ulong addr)
>  {
>      uintptr_t ra =3D GETPC();
>      int mmu_idx =3D check_access_hlsv(env, true, ra);
> -    MemOpIdx oi =3D make_memop_idx(MO_TE | MO_UL, mmu_idx);
> +    MemOpIdx oi =3D make_memop_idx(mo_endian_env(env) | MO_UL, mmu_idx);
>
>      return cpu_ldl_code_mmu(env, addr, oi, ra);
>  }
> --
> 2.51.0
>
>

