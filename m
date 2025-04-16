Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B610C369C2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 14:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u53zV-0000PR-RX; Wed, 16 Apr 2025 10:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u53zU-0000PC-5x
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 10:43:52 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u53zS-0000A7-FP
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 10:43:51 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-30155bbbed9so5350822a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 07:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744814629; x=1745419429; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ub5frZUrYEM3lY/ffUk632gF7y6vI8PGd5dndCynyM=;
 b=Os78SRsd6CP8Dzuxv6AJ2Hyyjy4BJ8mlKbfkXfcSdtRLRam4Yxmr0UiLofVuTkkAXJ
 WVnOJ11zQMl0pFE9Iz8IUPWC3O0+A7d8ruFgKgE6lSHagx5Wy42dYf5hNzGWCFqEAMoL
 OQ48uYj5hitYoS5HeJ/Qoek5Mm5at7B8tJQ9/gbpnjxRkFZYag+503jXC/FN6ielHqM8
 cYQDDsIPMFt8SOxnet2I56/XD0LJXMGodvxsnnu2Yzcaj92NqBl1IQKdHgubtVHjzS6Y
 Hzbyq8dP4fCEqt0rUye9L29SNvKjVknSaCamW98FJHGWQISDoD/sYddWQnozcJap8INU
 J2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744814629; x=1745419429;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3ub5frZUrYEM3lY/ffUk632gF7y6vI8PGd5dndCynyM=;
 b=oh0eGugjU3EQ3L7Cj39taewxn1utQJrF1YuwrJjSDDCPCXEDTpt+XbaS8Osuy6D/LS
 i8D1Kzv2pV0QdYBqfScGMzphB8pOAbGQyTp6J/WT1PicHkVaYNDWM6mdesZ8+I8GMR3K
 vPog4oAslhYmQPBTi5rbO2/HVLRQbuna5ZMLvyMj2N+WjjiN9kK4zsZyxnyWfMgGypp7
 ZuSw2LWQZD0f7990ceRVZY/BYCTEOONO4UHQDHqhFie8fX5ia2N6/67rDCd2oF8WUcyh
 Py74DOeO26CBemgSsl/28ufDAvOzl6kZG4AGdJPo1pSOB1myW2/M/rg5VhyXWKT9rU+Q
 Q37g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0IN0IvgP8YagOb26tanMruCh8xI8rV5X776FGgTV8+gxdaEYqVqvu0YgaJVtF/oV1xgRon7zjd/hl@nongnu.org
X-Gm-Message-State: AOJu0Yy2BDxGAgGGZ0Qb7dzc4Gkp3bonJckHEue+e6NwZnuZMKopBad1
 zffBEHPNPSTQ7TGSAAa25ka1LAfSsg97unVNFaGGuSE1RGhJ0Jt5
X-Gm-Gg: ASbGncvpRMaeKVOebX1b5VZUts2a4TiLOSlC89SClQnEEdefWNb2wILBoRjzg8Z12iU
 nLUiByzJf1olMLVjh4tbSYRCGIGwdmm6Bz7bqe6bd99CbCPP4o9OQD75bc73FsVATMKqwuNJdwB
 LnlnaOaSDraU7ORNRwsH7e2BzZTpo6uGhfT8z2sU4HjMLxsH3ydcdlvhsz7g4Pqj6D02b1ejLmF
 3tqWbXiMZtoU1XAo9WZ/RFFcuxgXQzy3v8G43GwVVjBoLIpmawZJn0TspAU4EBr2GvVfJVGEjbK
 eJIyHjE+H4XI2gPAiSSIvGMiBHG0jKM=
X-Google-Smtp-Source: AGHT+IHjMYZKqZyFNia3VfAA//Ue42T8krz184h16kExFukz0O/wZNew7VaTD3ZBOOmJBMqEmjUYhw==
X-Received: by 2002:a17:90b:1f88:b0:2f6:d266:f462 with SMTP id
 98e67ed59e1d1-30864172a14mr2976726a91.35.1744814628732; 
 Wed, 16 Apr 2025 07:43:48 -0700 (PDT)
Received: from localhost ([1.145.55.85]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-308611f3f31sm1677354a91.16.2025.04.16.07.43.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 07:43:48 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Apr 2025 00:43:44 +1000
Message-Id: <D9855WYVZU02.HS264Q491Q1R@gmail.com>
Subject: Re: [PATCH v4 084/163] tcg/ppc: Expand arguments to tcg_out_cmp2
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-85-richard.henderson@linaro.org>
In-Reply-To: <20250415192515.232910-85-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed Apr 16, 2025 at 5:23 AM AEST, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Looks equivalent.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  tcg/ppc/tcg-target.c.inc | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index 1782d05290..669c5eae4a 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -2206,8 +2206,8 @@ static void tcg_out_cntxz(TCGContext *s, TCGType ty=
pe, uint32_t opc,
>      }
>  }
> =20
> -static void tcg_out_cmp2(TCGContext *s, const TCGArg *args,
> -                         const int *const_args)
> +static void tcg_out_cmp2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg =
ah,
> +                         TCGArg bl, bool blconst, TCGArg bh, bool bhcons=
t)
>  {
>      static const struct { uint8_t bit1, bit2; } bits[] =3D {
>          [TCG_COND_LT ] =3D { CR_LT, CR_LT },
> @@ -2220,18 +2220,9 @@ static void tcg_out_cmp2(TCGContext *s, const TCGA=
rg *args,
>          [TCG_COND_GEU] =3D { CR_GT, CR_LT },
>      };
> =20
> -    TCGCond cond =3D args[4], cond2;
> -    TCGArg al, ah, bl, bh;
> -    int blconst, bhconst;
> +    TCGCond cond2;
>      int op, bit1, bit2;
> =20
> -    al =3D args[0];
> -    ah =3D args[1];
> -    bl =3D args[2];
> -    bh =3D args[3];
> -    blconst =3D const_args[2];
> -    bhconst =3D const_args[3];
> -
>      switch (cond) {
>      case TCG_COND_EQ:
>          op =3D CRAND;
> @@ -2286,7 +2277,8 @@ static void tcg_out_cmp2(TCGContext *s, const TCGAr=
g *args,
>  static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
>                               const int *const_args)
>  {
> -    tcg_out_cmp2(s, args + 1, const_args + 1);
> +    tcg_out_cmp2(s, args[5], args[1], args[2], args[3], const_args[3],
> +                 args[4], const_args[4]);
>      tcg_out32(s, MFOCRF | RT(TCG_REG_R0) | FXM(0));
>      tcg_out_rlw(s, RLWINM, args[0], TCG_REG_R0, CR_EQ + 0*4 + 1, 31, 31)=
;
>  }
> @@ -2294,7 +2286,8 @@ static void tcg_out_setcond2(TCGContext *s, const T=
CGArg *args,
>  static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
>                              const int *const_args)
>  {
> -    tcg_out_cmp2(s, args, const_args);
> +    tcg_out_cmp2(s, args[4], args[0], args[1], args[2], const_args[2],
> +                 args[3], const_args[3]);
>      tcg_out_bc_lab(s, TCG_COND_EQ, arg_label(args[5]));
>  }
> =20


