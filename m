Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5707C369BD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 14:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u53vn-0006NX-4U; Wed, 16 Apr 2025 10:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u53vk-0006Mb-3B
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 10:40:00 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u53vh-0007zB-MJ
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 10:39:59 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22928d629faso68410365ad.3
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 07:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744814396; x=1745419196; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YiUvf7B023DRcGAQtxabMGe2huPZJwGMXEV/QwBLNjE=;
 b=UO9wpFctDFlWP3n3BkxDHrBoBkGTRMfgDhKUpvvlE4ZWeNr65ltrWxxboXcT28vz7Y
 zd+lceJpRflDNCygSiJVpIIl5BDcEDMr+7iHUgR9mXQvAE6T+7jyRL7KGXKFCJ3dMhWK
 w6oj1qkUGvsGZ8U6eNY6qhAwkD90CdPvvuimncqvzArSKF9b8Y+dDsvX3T9KEf4c0Ext
 ICmy/SIPFfgo/7iILzzeR4+pHkw/MVERGXoMcWP+4FLgZlIkdbAKaQ4hvKnAPx9XArSD
 mnVeTBvGc7Kmn2EBzKKrvOXTNWpm9E3Ma8da7eYjwNnorXV7S13C+7kk1lS0N2ZA46cR
 bS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744814396; x=1745419196;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YiUvf7B023DRcGAQtxabMGe2huPZJwGMXEV/QwBLNjE=;
 b=w9A18eQ+aPvb4dRn5HFQf4BmIGDHjAMy3XlP4jc5wC5FCs+RQFhkRO5NQPfkA4kcw+
 X+OM4bVvZ0/ayrCkEl8w8YZd6UhtYVL0nNgUTTup/hEUMmMiME2MKjYSN6jlWA3Hrd/7
 FSWdQyQZnr9PEmATvU7TQp8k5i/wQp+AppCXxwbFKu2Jo1ln6/JLdoeGbZ251D0lSi6k
 9AhvTrqbFvMNQCsYMr4CRRKNGoO3pC2AI+fYX2DqU06qebHspN0UOn1BSNH4oW0sM6bB
 bO5L+x13MvMQK5ZNUuIlQ1kY+9+vcVe4irDN9AnrVFI0NMBRww8khqT64lFfsGkP2jH8
 4hOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3PJgNWcgEdvdXcGnsuW0wlaJfEeLa1HakvTigN9I9Hk8oF7RZdNZkB8dng52EJcmSZApklVtgWtY8@nongnu.org
X-Gm-Message-State: AOJu0Yw3T5sbKJ9mnCrQlfdlZO3KHa/ecG8PRzLk6F4orTYuBFqOH8Ll
 Zkqj0VaTFAGW29Ln6fcWRcJLQIOhQs9b/hH5dWcugNYnXan0VJc/
X-Gm-Gg: ASbGncvJym9sKD8GOWVqzkd1xwwH1S0PCufwqRRKTKfZB74JBmbxrJPENJ2eghMoNfY
 v49XE8a39jBspEu/Vncvjs8kWRSo10tiz4GBxm9T0JSbbJluUENs7ma1GtEz5IpKVKdICBOyDGK
 1Np77RxJUUMp3Cz0m6frVAS8n/mY5hR3D8idPV/Oro2M6XvpzJeMtEYSZKAh/q+84hTLgaycFjI
 d9dF+XDEAMPxLYOnYmORGPppQVLq7IdYCmxonMCdFs9BU1IuUCDMIJ8AtmBf2r+pRumq8tjA4wT
 g0nhhXKCoGYBfr5peuKa7yrpoztDX4drDP/gmJEMYQ==
X-Google-Smtp-Source: AGHT+IEbp94ObM7OvliWcBajwuhlmSnDcmugrYJ9OwY4TyezPgow32GveOkNsY2FKd7wlcu+jyDbqw==
X-Received: by 2002:a17:903:8c5:b0:223:5c33:56a2 with SMTP id
 d9443c01a7336-22c358ead4amr37393725ad.28.1744814396091; 
 Wed, 16 Apr 2025 07:39:56 -0700 (PDT)
Received: from localhost ([1.145.55.85]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33fc4bd0sm14766275ad.184.2025.04.16.07.39.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 07:39:55 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Apr 2025 00:39:51 +1000
Message-Id: <D9852XZJ0WXK.1CO4OXV7BVNB3@gmail.com>
Subject: Re: [PATCH v4 082/163] tcg/ppc: Drop fallback constant loading in
 tcg_out_cmp
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-83-richard.henderson@linaro.org>
In-Reply-To: <20250415192515.232910-83-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
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
> Use U and C constraints for brcond2 and setcond2, so that
> tcg_out_cmp2 automatically passes in-range constants
> to tcg_out_cmp.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/ppc/tcg-target-con-set.h |  4 +--
>  tcg/ppc/tcg-target.c.inc     | 49 ++++++++++++------------------------
>  2 files changed, 18 insertions(+), 35 deletions(-)
>
> diff --git a/tcg/ppc/tcg-target-con-set.h b/tcg/ppc/tcg-target-con-set.h
> index 77a1038d51..14cd217287 100644
> --- a/tcg/ppc/tcg-target-con-set.h
> +++ b/tcg/ppc/tcg-target-con-set.h
> @@ -15,7 +15,7 @@ C_O0_I2(r, rC)
>  C_O0_I2(v, r)
>  C_O0_I3(r, r, r)
>  C_O0_I3(o, m, r)
> -C_O0_I4(r, r, ri, ri)
> +C_O0_I4(r, r, rU, rC)
>  C_O0_I4(r, r, r, r)
>  C_O1_I1(r, r)
>  C_O1_I1(v, r)
> @@ -34,7 +34,7 @@ C_O1_I2(v, v, v)
>  C_O1_I3(v, v, v, v)
>  C_O1_I4(v, v, v, vZM, v)
>  C_O1_I4(r, r, rC, rZ, rZ)
> -C_O1_I4(r, r, r, ri, ri)
> +C_O1_I4(r, r, r, rU, rC)
>  C_O2_I1(r, r, r)
>  C_N1O1_I1(o, m, r)
>  C_O2_I2(r, r, r, r)
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index 339b3a0904..1782d05290 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -1777,9 +1777,8 @@ static void tcg_out_test(TCGContext *s, TCGReg dest=
, TCGReg arg1, TCGArg arg2,
>  }
> =20
>  static void tcg_out_cmp(TCGContext *s, int cond, TCGArg arg1, TCGArg arg=
2,
> -                        int const_arg2, int cr, TCGType type)
> +                        bool const_arg2, int cr, TCGType type)
>  {
> -    int imm;
>      uint32_t op;
> =20
>      tcg_debug_assert(TCG_TARGET_REG_BITS =3D=3D 64 || type =3D=3D TCG_TY=
PE_I32);
> @@ -1796,18 +1795,15 @@ static void tcg_out_cmp(TCGContext *s, int cond, =
TCGArg arg1, TCGArg arg2,
>      case TCG_COND_EQ:
>      case TCG_COND_NE:
>          if (const_arg2) {
> -            if ((int16_t) arg2 =3D=3D arg2) {
> +            if ((int16_t)arg2 =3D=3D arg2) {
>                  op =3D CMPI;
> -                imm =3D 1;
> -                break;
> -            } else if ((uint16_t) arg2 =3D=3D arg2) {
> -                op =3D CMPLI;
> -                imm =3D 1;
>                  break;
>              }
> +            tcg_debug_assert((uint16_t)arg2 =3D=3D arg2);
> +            op =3D CMPLI;
> +            break;
>          }
>          op =3D CMPL;
> -        imm =3D 0;
>          break;
> =20
>      case TCG_COND_TSTEQ:
> @@ -1821,14 +1817,11 @@ static void tcg_out_cmp(TCGContext *s, int cond, =
TCGArg arg1, TCGArg arg2,
>      case TCG_COND_LE:
>      case TCG_COND_GT:
>          if (const_arg2) {
> -            if ((int16_t) arg2 =3D=3D arg2) {
> -                op =3D CMPI;
> -                imm =3D 1;
> -                break;
> -            }
> +            tcg_debug_assert((int16_t)arg2 =3D=3D arg2);
> +            op =3D CMPI;
> +            break;
>          }
>          op =3D CMP;
> -        imm =3D 0;
>          break;
> =20
>      case TCG_COND_LTU:
> @@ -1836,30 +1829,20 @@ static void tcg_out_cmp(TCGContext *s, int cond, =
TCGArg arg1, TCGArg arg2,
>      case TCG_COND_LEU:
>      case TCG_COND_GTU:
>          if (const_arg2) {
> -            if ((uint16_t) arg2 =3D=3D arg2) {
> -                op =3D CMPLI;
> -                imm =3D 1;
> -                break;
> -            }
> +            tcg_debug_assert((uint16_t)arg2 =3D=3D arg2);
> +            op =3D CMPLI;
> +            break;
>          }
>          op =3D CMPL;
> -        imm =3D 0;
>          break;
> =20
>      default:
>          g_assert_not_reached();
>      }
>      op |=3D BF(cr) | ((type =3D=3D TCG_TYPE_I64) << 21);
> -
> -    if (imm) {
> -        tcg_out32(s, op | RA(arg1) | (arg2 & 0xffff));
> -    } else {
> -        if (const_arg2) {
> -            tcg_out_movi(s, type, TCG_REG_R0, arg2);
> -            arg2 =3D TCG_REG_R0;
> -        }
> -        tcg_out32(s, op | RA(arg1) | RB(arg2));
> -    }
> +    op |=3D RA(arg1);
> +    op |=3D const_arg2 ? arg2 & 0xffff : RB(arg2);

Looks good as far as I can see (I don't know the backend very well).

arg2 should not ever have upper bits set here (nor in the code you
replaced), right?

FWIW,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> +    tcg_out32(s, op);
>  }
> =20
>  static void tcg_out_setcond_eq0(TCGContext *s, TCGType type,
> @@ -4297,9 +4280,9 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsig=
ned flags)
>      case INDEX_op_deposit_i64:
>          return C_O1_I2(r, 0, rZ);
>      case INDEX_op_brcond2_i32:
> -        return C_O0_I4(r, r, ri, ri);
> +        return C_O0_I4(r, r, rU, rC);
>      case INDEX_op_setcond2_i32:
> -        return C_O1_I4(r, r, r, ri, ri);
> +        return C_O1_I4(r, r, r, rU, rC);
>      case INDEX_op_add2_i64:
>      case INDEX_op_add2_i32:
>          return C_O2_I4(r, r, r, r, rI, rZM);


