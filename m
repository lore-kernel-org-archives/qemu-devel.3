Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D8DD40CE0
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SUz-0001Wh-8s; Tue, 05 Nov 2024 17:58:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8SUw-0001OR-6g; Tue, 05 Nov 2024 17:58:06 -0500
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8SUt-0006a8-Fw; Tue, 05 Nov 2024 17:58:05 -0500
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-84fe454176bso2344825241.1; 
 Tue, 05 Nov 2024 14:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730847480; x=1731452280; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=We6j0KP009ueD40evB1SXX2cvSr19QGfXSwUYGQPazw=;
 b=PNGV/9UyNP9Wodl1y40u82QJJ50/nxhMp9PebQykJNvhyBkVkQ1gid7l9PRW3xNKmW
 1yc8atZoPLVFn2cgTG3ja32yM1MdGIEq1oZ1CFlqY4fi4jDXYfpQRUX2L8ECdn0eEyUN
 gy1+74pNuV3UjjevWmubQ2j698xaRXBvbN1m6vcRpbszIHoG1i4kiE47/tHVfli+MH0A
 4zKZOIOWem0Q+cTXEq8VLw9tNjXMEIKacdDxHKQTaKEXeOhyiBz37pjKax86pfyPqEQ9
 lFfbvrJ68yp176JjiLo+LS5oW35t92cIeuCBxJMdCiyAi7Y5XJ4qcDLGBbAONahXGzrH
 M2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730847480; x=1731452280;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=We6j0KP009ueD40evB1SXX2cvSr19QGfXSwUYGQPazw=;
 b=iiCXS4F6Tj+pTaMfVRWzHHUywZGAIIXjLDmoxfIxyQyAxOnKnrjjsX7cWKrLKgMVdt
 ax1/7ZpCmsMR186B8Weuw7ia6hwdQhRRq+81BTPUmMC71ONF2nroap0F9fdCcN+G40OM
 H5GP00fm1VkOvhyAQjStgd6WXbGzVgyA6DYAWrBAM09gexjlt4qIik0k05QlW1f19vz6
 i+FIOuc0GVirAXzB9dD2E43rAwJ3xa7aSQbiAiWd0uxWRj2dvsdYsBzNEk6gFYP1Pxav
 8hT9s5ujlHcX14m+3AsRNUVwsu/6gbD2X2+51HOT0JqM+xPXtK8XAS1ekzwVR7EGwWsJ
 iARg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyFNUh9JWtKw/EjXf72q2dchJnmBR+mbsoreaCfQVMdLMBBWQuFu9S/VP8R02PThgVx6796fj7Jw==@nongnu.org
X-Gm-Message-State: AOJu0YzbfhxDU0Du98QZnopMAjISrl+nDOz5TOKMBTY0FIfTQSMh5L16
 8mzn5c6PCxSSreZBGnVnnDAVoVE2a7scIJG5L9SnsZ7iRhU0KMofl8t1hXjXXvn564KG7HcVceK
 MQT07hwXdCjXUVC9LTrlvE8R8HIo=
X-Google-Smtp-Source: AGHT+IEAjPPVO2l8sW/WSmTdZHPNzxS0u5gO4oTMeEKyEzXEaEtx9DAxGARSRED+0TzmEq9sguy6ULglCUseOzXFuuA=
X-Received: by 2002:a05:6102:26c3:b0:4a4:7e16:6176 with SMTP id
 ada2fe7eead31-4a954262b73mr20962786137.6.1730847480582; Tue, 05 Nov 2024
 14:58:00 -0800 (PST)
MIME-Version: 1.0
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-14-philmd@linaro.org>
In-Reply-To: <20241105130431.22564-14-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Nov 2024 08:57:34 +1000
Message-ID: <CAKmqyKMjWPMg8c0S76eXN-tUK2Ly1qD48G78qtFJ=8Eh1BNTxw@mail.gmail.com>
Subject: Re: [PATCH 13/19] target/microblaze: Explode MO_TExx -> MO_TE | MO_xx
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
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

On Tue, Nov 5, 2024 at 11:07=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Extract the implicit MO_TE definition in order to replace
> it by runtime variable in the next commit.
>
> Mechanical change using:
>
>   $ for n in UW UL UQ UO SW SL SQ; do \
>       sed -i -e "s/MO_TE$n/MO_TE | MO_$n/" \
>            $(git grep -l MO_TE$n target/microblaze); \
>     done
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/microblaze/translate.c | 36 +++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.=
c
> index 4beaf69e76a..4c25b1e4383 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -779,13 +779,13 @@ static bool trans_lbui(DisasContext *dc, arg_typeb =
*arg)
>  static bool trans_lhu(DisasContext *dc, arg_typea *arg)
>  {
>      TCGv addr =3D compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_load(dc, arg->rd, addr, MO_TEUW, dc->mem_index, false);
> +    return do_load(dc, arg->rd, addr, MO_TE | MO_UW, dc->mem_index, fals=
e);
>  }
>
>  static bool trans_lhur(DisasContext *dc, arg_typea *arg)
>  {
>      TCGv addr =3D compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_load(dc, arg->rd, addr, MO_TEUW, dc->mem_index, true);
> +    return do_load(dc, arg->rd, addr, MO_TE | MO_UW, dc->mem_index, true=
);
>  }
>
>  static bool trans_lhuea(DisasContext *dc, arg_typea *arg)
> @@ -797,26 +797,26 @@ static bool trans_lhuea(DisasContext *dc, arg_typea=
 *arg)
>      return true;
>  #else
>      TCGv addr =3D compute_ldst_addr_ea(dc, arg->ra, arg->rb);
> -    return do_load(dc, arg->rd, addr, MO_TEUW, MMU_NOMMU_IDX, false);
> +    return do_load(dc, arg->rd, addr, MO_TE | MO_UW, MMU_NOMMU_IDX, fals=
e);
>  #endif
>  }
>
>  static bool trans_lhui(DisasContext *dc, arg_typeb *arg)
>  {
>      TCGv addr =3D compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
> -    return do_load(dc, arg->rd, addr, MO_TEUW, dc->mem_index, false);
> +    return do_load(dc, arg->rd, addr, MO_TE | MO_UW, dc->mem_index, fals=
e);
>  }
>
>  static bool trans_lw(DisasContext *dc, arg_typea *arg)
>  {
>      TCGv addr =3D compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_load(dc, arg->rd, addr, MO_TEUL, dc->mem_index, false);
> +    return do_load(dc, arg->rd, addr, MO_TE | MO_UL, dc->mem_index, fals=
e);
>  }
>
>  static bool trans_lwr(DisasContext *dc, arg_typea *arg)
>  {
>      TCGv addr =3D compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_load(dc, arg->rd, addr, MO_TEUL, dc->mem_index, true);
> +    return do_load(dc, arg->rd, addr, MO_TE | MO_UL, dc->mem_index, true=
);
>  }
>
>  static bool trans_lwea(DisasContext *dc, arg_typea *arg)
> @@ -828,14 +828,14 @@ static bool trans_lwea(DisasContext *dc, arg_typea =
*arg)
>      return true;
>  #else
>      TCGv addr =3D compute_ldst_addr_ea(dc, arg->ra, arg->rb);
> -    return do_load(dc, arg->rd, addr, MO_TEUL, MMU_NOMMU_IDX, false);
> +    return do_load(dc, arg->rd, addr, MO_TE | MO_UL, MMU_NOMMU_IDX, fals=
e);
>  #endif
>  }
>
>  static bool trans_lwi(DisasContext *dc, arg_typeb *arg)
>  {
>      TCGv addr =3D compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
> -    return do_load(dc, arg->rd, addr, MO_TEUL, dc->mem_index, false);
> +    return do_load(dc, arg->rd, addr, MO_TE | MO_UL, dc->mem_index, fals=
e);
>  }
>
>  static bool trans_lwx(DisasContext *dc, arg_typea *arg)
> @@ -845,7 +845,7 @@ static bool trans_lwx(DisasContext *dc, arg_typea *ar=
g)
>      /* lwx does not throw unaligned access errors, so force alignment */
>      tcg_gen_andi_tl(addr, addr, ~3);
>
> -    tcg_gen_qemu_ld_i32(cpu_res_val, addr, dc->mem_index, MO_TEUL);
> +    tcg_gen_qemu_ld_i32(cpu_res_val, addr, dc->mem_index, MO_TE | MO_UL)=
;
>      tcg_gen_mov_tl(cpu_res_addr, addr);
>
>      if (arg->rd) {
> @@ -929,13 +929,13 @@ static bool trans_sbi(DisasContext *dc, arg_typeb *=
arg)
>  static bool trans_sh(DisasContext *dc, arg_typea *arg)
>  {
>      TCGv addr =3D compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_store(dc, arg->rd, addr, MO_TEUW, dc->mem_index, false);
> +    return do_store(dc, arg->rd, addr, MO_TE | MO_UW, dc->mem_index, fal=
se);
>  }
>
>  static bool trans_shr(DisasContext *dc, arg_typea *arg)
>  {
>      TCGv addr =3D compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_store(dc, arg->rd, addr, MO_TEUW, dc->mem_index, true);
> +    return do_store(dc, arg->rd, addr, MO_TE | MO_UW, dc->mem_index, tru=
e);
>  }
>
>  static bool trans_shea(DisasContext *dc, arg_typea *arg)
> @@ -947,26 +947,26 @@ static bool trans_shea(DisasContext *dc, arg_typea =
*arg)
>      return true;
>  #else
>      TCGv addr =3D compute_ldst_addr_ea(dc, arg->ra, arg->rb);
> -    return do_store(dc, arg->rd, addr, MO_TEUW, MMU_NOMMU_IDX, false);
> +    return do_store(dc, arg->rd, addr, MO_TE | MO_UW, MMU_NOMMU_IDX, fal=
se);
>  #endif
>  }
>
>  static bool trans_shi(DisasContext *dc, arg_typeb *arg)
>  {
>      TCGv addr =3D compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
> -    return do_store(dc, arg->rd, addr, MO_TEUW, dc->mem_index, false);
> +    return do_store(dc, arg->rd, addr, MO_TE | MO_UW, dc->mem_index, fal=
se);
>  }
>
>  static bool trans_sw(DisasContext *dc, arg_typea *arg)
>  {
>      TCGv addr =3D compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_store(dc, arg->rd, addr, MO_TEUL, dc->mem_index, false);
> +    return do_store(dc, arg->rd, addr, MO_TE | MO_UL, dc->mem_index, fal=
se);
>  }
>
>  static bool trans_swr(DisasContext *dc, arg_typea *arg)
>  {
>      TCGv addr =3D compute_ldst_addr_typea(dc, arg->ra, arg->rb);
> -    return do_store(dc, arg->rd, addr, MO_TEUL, dc->mem_index, true);
> +    return do_store(dc, arg->rd, addr, MO_TE | MO_UL, dc->mem_index, tru=
e);
>  }
>
>  static bool trans_swea(DisasContext *dc, arg_typea *arg)
> @@ -978,14 +978,14 @@ static bool trans_swea(DisasContext *dc, arg_typea =
*arg)
>      return true;
>  #else
>      TCGv addr =3D compute_ldst_addr_ea(dc, arg->ra, arg->rb);
> -    return do_store(dc, arg->rd, addr, MO_TEUL, MMU_NOMMU_IDX, false);
> +    return do_store(dc, arg->rd, addr, MO_TE | MO_UL, MMU_NOMMU_IDX, fal=
se);
>  #endif
>  }
>
>  static bool trans_swi(DisasContext *dc, arg_typeb *arg)
>  {
>      TCGv addr =3D compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
> -    return do_store(dc, arg->rd, addr, MO_TEUL, dc->mem_index, false);
> +    return do_store(dc, arg->rd, addr, MO_TE | MO_UL, dc->mem_index, fal=
se);
>  }
>
>  static bool trans_swx(DisasContext *dc, arg_typea *arg)
> @@ -1014,7 +1014,7 @@ static bool trans_swx(DisasContext *dc, arg_typea *=
arg)
>
>      tcg_gen_atomic_cmpxchg_i32(tval, cpu_res_addr, cpu_res_val,
>                                 reg_for_write(dc, arg->rd),
> -                               dc->mem_index, MO_TEUL);
> +                               dc->mem_index, MO_TE | MO_UL);
>
>      tcg_gen_brcond_i32(TCG_COND_NE, cpu_res_val, tval, swx_fail);
>
> --
> 2.45.2
>
>

