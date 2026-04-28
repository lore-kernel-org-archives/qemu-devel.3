Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AC9FF8867
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 03:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHYlP-0004vw-0C; Mon, 27 Apr 2026 23:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHYlL-0004tF-VE
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 23:05:28 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHYlK-0003W3-4V
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 23:05:27 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ba9ad0fbc3aso1027012166b.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 20:05:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777345523; cv=none;
 d=google.com; s=arc-20240605;
 b=cGv7fPgBQcgcv/XUZJY4YwwIMg3Ug17492CWXAjVT4TOGWr2n9os280B0eS/ANgT0q
 DD2WnH5c+wUlPQd8zaJeJarV+zAtuz+nXvVTGMgXK/TVHmSN7NcKDZVpkxD5BLAeRN5i
 PRIAksHeBfumWaafEukrOLDMaJJLxemlbWgC3HheTMt4gQGxOEA3a7FNSJ/ZpTsn+GJb
 ASxqBxe5sq0f/py4YMkaXzjgK0hZi9AuBeHixtbHFAA9PzaCGYWwlmHx7S6bVDkGR7Rh
 NnMWx2fdXgDfZfzv0O28RLFXI98HWXdn3mEtYTCW1BdyurKR1Z6pCp12WIG0d4fyqiiv
 wZXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RMiHQvtdpj/ii8VBP35u29oLpEp2nxYWzUHFyrv78jw=;
 fh=fx/r/twi0lR0VsLAVqPkirIE7VN6h63K7UWTunhhuts=;
 b=O4BPiNOLtpdiosRaLz02l0wswRDitLhnqiTe6pS86iRF/fArSB0VSYDY3CsB9s1kN6
 tQNPx2DiWeSG9snJ/9XUEkDMWziKMAEDYkZsgtnvuLh6a2lSIgK1BljIrQZT7OY36zVb
 1/kxrmjOwklj492INhBTaToUERDhPlSkm5+SL0RzIXkF+75+J7WCFbNEM0GD6uWR8A3u
 XYLBBBn+cKYrCbKv9F3RJ4Wuez8gvBJTBiNX0pzfKvVQ+pooCP/wqtJXHZsY7vzeyGQT
 NewDtl9BsDKvBJV6tG5FmOA2zC/yqoXpmcyW/IU4HAv+/ZvVwuwTXer9jNITxRDMvP60
 fSdA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777345523; x=1777950323; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RMiHQvtdpj/ii8VBP35u29oLpEp2nxYWzUHFyrv78jw=;
 b=a6bzPQS6K3PYJYfGV1heh2pBno7T96OUk5uKAfx2xMBJW8ZFUzyMl6HC7JmTusV5Xh
 ZK5a/7rgIh23furyvJ1eHvrB8/c2KlvKLxGnFnNQKwggZVTiKX09zEnlhGCvy8LxVcy5
 Ipw+tXeJ/d9+PuU1dzEw3J8W75dLfIRUBbTwPm5M4L9E+Ctmu8ELeN5QcGNXfUenb651
 fZqbIJ8sbTbvBJzdr73/3GHVM3QRArKaLueszXVoELNE4mDWbnBqC2wSyt00B7nIc37j
 xF8njvhQC0a4mhcvxFpeGPM71YqjSus2dCs0Mi1vVWjk6YN5WZZ1TUz6je4/yrcqEa+D
 ihcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777345523; x=1777950323;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RMiHQvtdpj/ii8VBP35u29oLpEp2nxYWzUHFyrv78jw=;
 b=GwLcxcHx1RsZibFTSCydS0CPAPokQeO/BiyqXLyMTSZLrY6FVyZXbe5v/eJwhapol2
 tGw+PYIo5l/Use+GnTXvaUoZt12RhGXFw+z63fWbez4yVwkPKyGrJA1QaPqaJ0rbhLA+
 5Vgy7k0X+MNniBtQ3RZTxnLjQG7sS6jeZQsZBASRuiHScJxes7JUTGWa3e6/85cPEaAf
 xBZNyXABRI/VGFtimG+nRw8G03WTrojQMBMmlnfhuH9TFnStZyvUe6xErBJ4Qwa0uPnM
 IEReeXsrrzmkiuzyewkkVVYk3PuAEPhXmeXHk2txxT2l+ws/k+CoQH9iPTnFUD3wWU45
 XeBQ==
X-Gm-Message-State: AOJu0YyvgcDvsN3wn4iNzaX6hrVcg+dRIXUPQg5KUsvFCxpJRAUv3Man
 8gQdCBOd2heEpQRmviqEUalMoze2/TDeyHezmfiQ8PfFpqMLJXgGTB9YOg15OoneRK0fSfIFpwS
 G7RXGuiO1KHlr03wAYHR1eKXwo0Y3vk0=
X-Gm-Gg: AeBDiessWjsy5rd5yV5S0/hgwEX0Cjj3OV0mhaU3AgNu6OjfwDk4fAbwGVy5Ln3PyVW
 N+uJ2qASmTqetAFwSqOuZT7b7S6ccrL+tkSuOg1hNDkXzhtI71RgYcORDs3YlQ5YJcshr9gs7b+
 NfiYVUFqYyDXQxAZN53Cb4OJzZnZ0aSSPWM/6saqSOr/zGwHcPrFXBCzUjFCIhBOrXAQiEBvd/T
 qILrZ8o7mCBkPao2Z8peBJSpMT/u9pjZNwKgMM4Ig6VixkpcVPPVrklW9gQOZEv6GX+5JXDk5si
 13nsbQRF74YFEZ8NmfIiEeo2wyt3oKWBJ26CBVlutipxYcGl
X-Received: by 2002:a17:906:ef04:b0:ba8:6369:8b8f with SMTP id
 a640c23a62f3a-bb802ea0fd6mr61084866b.21.1777345522987; Mon, 27 Apr 2026
 20:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260421093715.2995067-1-frank.chang@sifive.com>
 <20260421093715.2995067-5-frank.chang@sifive.com>
In-Reply-To: <20260421093715.2995067-5-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 28 Apr 2026 13:04:56 +1000
X-Gm-Features: AVHnY4L4Ug3gYyugoY7U8glXPt4G1B0ONvCX7dLDvXQsn97hgTW5s0RLIVV6fr4
Message-ID: <CAKmqyKOwi9NrpAs8G7dt3PyPU0XGLwFfnyooFaF8JOJoAEQD6w@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] target/riscv: Fix pointer masking for
 virtual-machine load/store insns
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62b.google.com
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

On Tue, Apr 21, 2026 at 7:38=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> The effective privilege of explicit memory accesses made by
> virtual-machine load/store instructions (HLV.* and HSV.*) is controlled
> by hstatus.SPVP. mstatus.MPRV does not affect these virtual-machine
> load/store instructions.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_helper.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index bab4153e53b..2b3fea81d50 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -217,16 +217,23 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
>  RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env)
>  {
>  #ifndef CONFIG_USER_ONLY
> -    int priv_mode =3D cpu_address_mode(env);
> +    int priv_mode;
> +
> +    if (!riscv_cpu_cfg(env)->ext_ssnpm ||
> +        get_field(env->mstatus, MSTATUS_MXR) ||
> +        get_field(env->vsstatus, MSTATUS_MXR)) {
> +        return PMM_FIELD_DISABLED;
> +    }
> +
> +    priv_mode =3D get_field(env->hstatus, HSTATUS_SPVP);
>
> -    if (priv_mode =3D=3D PRV_U) {
> -        return get_field(env->hstatus, HSTATUS_HUPMM);
> +    if (priv_mode =3D=3D PRV_S) {
> +        /* Effective privilege mode: VS */
> +        return get_field(env->henvcfg, HENVCFG_PMM);
>      } else {
> -        if (get_field(env->hstatus, HSTATUS_SPVP)) {
> -            return get_field(env->henvcfg, HENVCFG_PMM);
> -        } else {
> -            return get_field(env->senvcfg, SENVCFG_PMM);
> -        }
> +        /* Effective privilege mode: VU */
> +        return (env->priv =3D=3D PRV_U) ? get_field(env->hstatus, HSTATU=
S_HUPMM) :
> +                                      get_field(env->senvcfg, SENVCFG_PM=
M);
>      }
>  #else
>      return PMM_FIELD_DISABLED;
> --
> 2.43.0
>
>

