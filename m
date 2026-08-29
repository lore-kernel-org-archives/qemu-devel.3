Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C71C61DBE
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 18:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0OEZ-0002h0-SW; Sat, 29 Aug 2026 14:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x0OEY-0002gn-RZ
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 14:56:54 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x0OEX-0005Qx-5b
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 14:56:54 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5b5e5ab03afso1654598e87.3
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2026 11:56:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788029810; cv=none;
 d=google.com; s=arc-20260327;
 b=GnKXxyc+BaxBcQlxefzgGmGE9dyVFzXbOKz18r+yilluTCGT60hcJbGs6JoJpY1+UI
 APCuF+vjmLWlHFShuUlekO5FSCre6R/pdY0YdyQCZd6KKioL0RSl9RKBPW7ieM2yuavm
 u5u1Nxb3wgtS1o+bWBSC2d0uE2FEKIRuPpvYBc0Mxf6XkZD36X2MoOU+krzxAPLbdOgX
 nOL0a27CUXdXkb9EbrfOyUqS4XTFOaHj3YolYI12iEn+NCNZ5ag3UpQtKW4jcg1v/eYp
 o77a1W/2lFGw08yXrBhscdB5/fXErV6PocCQiFh5OIEQX95v18NxaSwK6WDMhRbvpypO
 Zo+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zLyCT2XvsC9Lg4/n/Q7FyVFaXdSfVL9E44vwHE6Bjpo=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=as1yGyhZKQtT7Q+IFmQAJvS1jc9vg2cPcoaO+nkXWLAx1EkVO9Yad9CPbrEkjAcrxI
 uTlQs2UGdsQNqk4fe24I5jALa4OVi0b3aWZNn2Q3Jg100+4sZfUcx5HTo6IZqWUNEmsa
 z/LEIob2lFN7WAYw5QudfMMeL7Avrob8GpbU5NEFYLqLvEl1EDR/SaKT/DsouCGIRZ5F
 KrTD2eolZ89W2HBi8gg4BQtVTKFYh0djNKO/54htasBsIxynZT599cuJcLbHIpuRSSgf
 wBkbBLDGQMTqRqDyA64bQHiFZyDfuhJrgkszlSqafcoPQGC3/tWghaM28MvqXil07WTx
 UZOw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788029810; x=1788634610; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zLyCT2XvsC9Lg4/n/Q7FyVFaXdSfVL9E44vwHE6Bjpo=;
 b=AnPJ6jXgSRbspHjBE9HTsz5XJJMtaJF/psIXGF6t1BvR67qSuCmguyxxFozcPTgTCI
 B4bTBshCd1FQIi3TeeAajmm7bh0je12b/gL07vPFVGXLTPevXO/21aGvWW08g837Bafm
 4rqTL+nA4+01EbovYJcV+UO3aDUIuRUmg8gV+M03lFhu4MLieqqlNa4QqaeHL2BehtxU
 7/wT4MLePJIOXVlal60hfjJQAq1OSChGKvV/SwxD4wcabn6EYkcBfHU3MfnzQgsDMxwK
 UuohgTIQ0qglHquZ3D9CK+399tTBR7JSOn6FxjL/+Dc20uyAb3PX8v8EI+VjyI08JJ4d
 HepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788029810; x=1788634610;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zLyCT2XvsC9Lg4/n/Q7FyVFaXdSfVL9E44vwHE6Bjpo=;
 b=ZcZDDJMjjZHaZQTDZqm18dlu4F0kWzTaQdeY7cbl4ldQv/BcCl1j+eKK32zaB08iiT
 gDMtWtr5LoGk9rRKSG0fNNbk3Fs/cl4ylVYS6h0GLjf6AyWqXV8PwO8SSdAH86NITaqm
 3JpETWQB/QfA6QmEzBpzIsCrk8/Le2FAMR1hrYLiHwMHQK80Nn9a2lvYvHIlypX0dsqB
 h5JSHrIWqwsAO5015fDFtgYVubvY+JcvBZOgO6/+z5VTasbQOUnRZAnwjn280T9O2GvZ
 a8EExJundSV8+VmN9h190h/wWzjdtFkWI29X6VCveUT40oDXvdepERu4YPntsar/cCFA
 QOLQ==
X-Gm-Message-State: AFuF++lGj84Yx6eteMCxJDRgD0VviGcACyECyiRkXkCb0s7MMMTuGDk9
 dFHJSLdHnlsC7QFQ716ra4KPD2IiXg2Z6989Ghuzp/t86r8Ds0z3FP5d6HSsDgDuuncncrAearf
 z2UXLt7XBhFJf2SFHMMUT1krFhaFcl+A=
X-Gm-Gg: AYBFou3mFvGcFjlC+19JT5jfQ9lChBxS8qgcOwma/7rKBz310WccGqRtItomeOQowF5
 ZeW/8Uvu7dWXv2iNo/PKL4DrSempCimGrqKDJeJm7SsnRLtPzkumqXRRzL8sv4jfcYHrN+7Q69V
 TRFpAhpcEBsACQ624TtVHRQW0qurjWzxot/pZdDt9gBT9uKHNdIGn/lQ9ScqTxWqUTOQMiEjiXA
 Qxy29wBkeaPVpVIDQpD73IvhJIXyfR8MMthpF7ILOYc9rVET+EshwkFofI41XwNkTOFxUVMFCgq
 6hcHGvEMSQxJL5uPV4lKFfLCXO6RuZl5h1hE7QNHvWA4KwI=
X-Received: by 2002:a05:6512:3c92:b0:5b4:ef51:8cf6 with SMTP id
 2adb3069b0e04-5b5e6901619mr5098914e87.19.1788029809199; Sat, 29 Aug 2026
 11:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260828224451.1564072-1-richard.henderson@linaro.org>
 <20260828224451.1564072-4-richard.henderson@linaro.org>
In-Reply-To: <20260828224451.1564072-4-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 29 Aug 2026 14:56:37 -0400
X-Gm-Features: AcwNN1UlH3Hk0zue6Z_zrPNs4TII3ijbgxOWwyjkU6YSFy5NXoKa0oOB-TpB5S4
Message-ID: <CAEdQ38Fi-X+10TBS6=6JYZGzPUUVjpDt+mEyMBU-a-OR2q-8Yg@mail.gmail.com>
Subject: Re: [PATCH 03/16] tcg: Add tcg_gen_lea_{i32,i64,tl}
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=mattst88@gmail.com; helo=mail-lf1-x132.google.com
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

On Fri, Aug 28, 2026 at 6:44=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/tcg/tcg-op-common.h |  4 ++
>  include/tcg/tcg-op.h        |  2 +
>  tcg/tcg-op.c                | 90 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 96 insertions(+)
>
> diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
> index 9b321f959c0..b06445b8031 100644
> --- a/include/tcg/tcg-op-common.h
> +++ b/include/tcg/tcg-op-common.h
> @@ -167,6 +167,8 @@ void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_=
i32 arg2);
>  void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
>  void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
>  void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
> +void tcg_gen_lea_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b,
> +                     int32_t sh, int32_t imm);
>
>  /* Replicate a value of size @vece from @in to all the lanes in @out */
>  void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
> @@ -282,6 +284,8 @@ void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
>  void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
>  void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
>  void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
> +void tcg_gen_lea_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b,
> +                     int64_t sh, int64_t imm);
>
>  /* Replicate a value of size @vece from @in to all the lanes in @out */
>  void tcg_gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in);
> diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
> index 37211642365..a7d001c959c 100644
> --- a/include/tcg/tcg-op.h
> +++ b/include/tcg/tcg-op.h
> @@ -83,6 +83,7 @@ typedef TCGv_i64 TCGv;
>  #define tcg_gen_shri_tl tcg_gen_shri_i64
>  #define tcg_gen_sar_tl tcg_gen_sar_i64
>  #define tcg_gen_sari_tl tcg_gen_sari_i64
> +#define tcg_gen_lea_tl tcg_gen_lea_i64
>  #define tcg_gen_brcond_tl tcg_gen_brcond_i64
>  #define tcg_gen_brcondi_tl tcg_gen_brcondi_i64
>  #define tcg_gen_setcond_tl tcg_gen_setcond_i64
> @@ -209,6 +210,7 @@ typedef TCGv_i64 TCGv;
>  #define tcg_gen_shri_tl tcg_gen_shri_i32
>  #define tcg_gen_sar_tl tcg_gen_sar_i32
>  #define tcg_gen_sari_tl tcg_gen_sari_i32
> +#define tcg_gen_lea_tl tcg_gen_lea_i32
>  #define tcg_gen_brcond_tl tcg_gen_brcond_i32
>  #define tcg_gen_brcondi_tl tcg_gen_brcondi_i32
>  #define tcg_gen_setcond_tl tcg_gen_setcond_i32
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 2c88f4f7ca9..fb5fef9422d 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -498,6 +498,51 @@ void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, i=
nt32_t arg2)
>      }
>  }
>
> +void tcg_gen_lea_i32(TCGv_i32 ret, TCGv_i32 a1, TCGv_i32 a2,
> +                     int32_t sh, int32_t imm)
> +{
> +    TCGv_i32 t =3D tcg_temp_ebb_new_i32();

Dunno if it's worth it, but we can sink this into (multiple) branches
below and avoid emitting it in some cases. Same for tcg_gen_lea_i64.

