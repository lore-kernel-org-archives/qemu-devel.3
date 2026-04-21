Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8753CF94CB7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 23:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFKyN-0000ZX-EC; Tue, 21 Apr 2026 19:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wFKyL-0000Wx-Ox
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 19:57:41 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wFKyK-0001RL-3G
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 19:57:41 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-65c0891f4e9so8054886a12.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 16:57:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776815858; cv=none;
 d=google.com; s=arc-20240605;
 b=Ev4UK+sp4KIeQHajnZJj6f4Hj2f3MV1+H1Gzv2Zl4C7mFK3zEJbe7nx9w5qMEOSZ1t
 QJQyIEqx/ib0WpUJ6G/MjOc4L+XUnGHa1yI37KC8DAOvdAC2lEkdGM4rO/8UlzxzVAYH
 NHxAcY6FMyJjZl5l4iPu2uTyURRyfKG5IQHSwGabLSPy11SnV8xXbtBy5S7q00FNZezV
 UX5H4dr+hu56JVWIiHz8xsSMM7GN2nR3VSrGRJkk44HHhO8x3iHy8c55PxWXQmc1g2iY
 +RgR49Vdfotmz6lUdmvvX9ENWKguISJV227bCF1nuLjXO/o3FsE3vHtcbM5OGkDpX8vO
 hO+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=I9w/6NvHBWVwk0rPZmeWxQn7vrzQdM3PVh9A3yMtdro=;
 fh=fx/r/twi0lR0VsLAVqPkirIE7VN6h63K7UWTunhhuts=;
 b=LgML5/xTDnQeVDeunFAMe2+BLPukUFhG0UIJmDqrXny/fmc5SnECcU3x2h+1f7HE0w
 pdPCEq/YQcd6RGAuxAlhea/rRTSM6mdOm8eZl3AB7S5hQzzCjUFbG5c9fS+pmdwavIxC
 P8ZkHEgT4tJX0IK3P3Mh66gQDRoBsctOMiIyVKq4lzhDK8grBkV6u0g0ymNV1KPOD+XI
 q91zIWDAFAxdyKUAxrv2OiHt8R1lIaCYaS3OyXVY2XP4hXLXb2jyzpGXHqF+OYk1TR0G
 8aXnqqGgJ/iS1x6DZj4BW8vxGfuv+PHXy2K7R5FCmG0Ujavcz0tSO1W7OyVYbJl2j4O6
 hFFQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776815858; x=1777420658; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I9w/6NvHBWVwk0rPZmeWxQn7vrzQdM3PVh9A3yMtdro=;
 b=FC4iLYUBk1u0TBmob7RxM4reuYNwNnHKCyFpXIxRVtMPm2gZoG/bDu5OJR8KEwiQZe
 OF4VZR5eLughS6vHWySjq0W1O0FesCiLQ7IdmODAi25eTyYQfC69yle3K5Kytje5uQLA
 2tAFf9Q3sQiDtUVdpnFyvL2RXyjuS/2F9mN8mjGfD+FJp6lXAq07VsFItubR3otBh63A
 IlaPF5pa+pminblgmQZTkofKZc8x7L/+ulG/bTM4jfhT7K2ZFzdNGIQhxpd9XasAMjtB
 T2d6FVs/XOqHnen9NpvScGK4WgAkPNQ82K0wqsA7Jri4mPulZ4c62p9GMYT5GOTeNwg8
 OoVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776815858; x=1777420658;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I9w/6NvHBWVwk0rPZmeWxQn7vrzQdM3PVh9A3yMtdro=;
 b=PVA2dcabxFR28CDIp9a/U1vjy/vU+rGRZHiSVPkt4M7ZOdCQqDKuP+zMRLAE1iBChk
 TQH0iQyfaRojKKA2Bsqyn9rl3NAISTVifk/dWP7ffWjfhXLWDcqJ3W6O7iSZWQ1xzg8z
 oIhgecRHn8jaf+9zpFSO8o+jEI6q6rZX/ayJMp5Y94QXf84C5aepSv5eQJK0ICHVs5Kt
 fSTFTiVYDsVfDjxUCLon7cHzRXmHW1T/xg6uYpqEv6MHnkkB9OK8VR+G7gH9qBMaIzan
 dB7YDt/NRtkGOIT0Xjbm3wYjYyAOWolLWACio0FXqrXXs+n/zjIs+0rp6Xd6ShAg49yn
 gjvw==
X-Gm-Message-State: AOJu0YyE+2Fh6QHVx4smi9k5HtCF8wteTF4E09wfM9Dk90Vff3f86BlO
 4TT/S2QrlKzZvcTtwyuSoWK65FRVR0R9vzQSlMPAgSlkaFaMpq0xfD093sfZnzNspNPrPMP8/lX
 4iz1P97gAVvH4ZgMSMu1W1AdnzFCWBI0=
X-Gm-Gg: AeBDietdQJI+qZyjv5iVDQpRbfwgcrrZNoY72OZXmHJKBj9Qf1izHEQ+Bja0EtMExVr
 cJZwWM4VjcxX1t4ujE7Ts4ntwUNYmL2FaT96N4zLiNOyuGzvL8WcJz+XpX+aii8HuGOdu1rqo2v
 /qeIIVhMiIJ5fmLlsW6cYKyGchkh4hz99S5D/KA7jsxMgNHUOlUmKIrC2OYIL9zQY7kYhNVOKx+
 gKIKhCJ6o4G0zLcu9bPQC4YB/8ZSDdR7CimjvcsiXmsxfGYmsubSuH7HlcgstC5wl7rLxGLIlJc
 D80aCl/BbReSSkX3oEVabSly7gwIqgcKQWeLbFRwKWPlaC3M
X-Received: by 2002:a17:907:96a1:b0:ba9:2137:7165 with SMTP id
 a640c23a62f3a-ba92146ccc2mr372284966b.1.1776815858294; Tue, 21 Apr 2026
 16:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260421074940.2916287-1-frank.chang@sifive.com>
In-Reply-To: <20260421074940.2916287-1-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 22 Apr 2026 09:57:10 +1000
X-Gm-Features: AQROBzBHs5KgDJc1ZLdsdOp1k94OSWHIEnhy9m26XKLAAPNsm5Ajgc9LMnO55iE
Message-ID: <CAKmqyKN0oaRYxDV8cbDDDowY_GJUMpYtny0neTNZwnyRxwYy6A@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: Mask xepc[0] only when Zc* extension is
 enabled
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x533.google.com
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

On Tue, Apr 21, 2026 at 5:50=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> IALIGN is 16 when the CPU supports the Zc* extension. Only xepc[0]
> should be masked when the Zc* extension is enabled.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/internals.h | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index b001cbc080a..ab8dea45c90 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -173,9 +173,15 @@ static inline float16 check_nanbox_bf16(CPURISCVStat=
e *env, uint64_t f)
>
>  static inline target_ulong get_xepc_mask(CPURISCVState *env)
>  {
> -    /* When IALIGN=3D32, both low bits must be zero.
> -     * When IALIGN=3D16 (has C extension), only bit 0 must be zero. */
> -    if (riscv_has_ext(env, RVC)) {
> +    RISCVCPU *cpu =3D env_archcpu(env);
> +
> +    /*
> +     * When IALIGN=3D32, both low bits must be zero.
> +     * When IALIGN=3D16 (has C or Zc* extensions), only bit 0 must be ze=
ro.
> +     */
> +    if (riscv_has_ext(env, RVC) || cpu->cfg.ext_zca ||
> +        cpu->cfg.ext_zcb || cpu->cfg.ext_zcd || cpu->cfg.ext_zce ||
> +        cpu->cfg.ext_zcf || cpu->cfg.ext_zcmp || cpu->cfg.ext_zcmt) {
>          return ~(target_ulong)1;
>      } else {
>          return ~(target_ulong)3;
> --
> 2.43.0
>
>

