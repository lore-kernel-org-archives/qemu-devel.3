Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3496CCA5FAD
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 23:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBh73-0008AB-PC; Tue, 29 Sep 2026 19:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xBh72-00089y-Jk
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:19:52 -0400
Received: from mail-lr2-x0e.google.com ([2a00:1450:4864:38::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xBh70-0004ws-R3
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:19:52 -0400
Received: by mail-lr2-x0e.google.com with SMTP id
 38308e7fff4ca-3a66f8bc23bso28221361fa.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 16:19:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790723989; cv=none;
 d=google.com; s=arc-20260327;
 b=IEopyQvKfETe+rcNUc4dY0EdzkZpz1SxalExcwTxO99nDv8iQ2YJ1uj9scZj9EBuyE
 WZaaYrxKGpGvdzMTE8AiMvunCZHFU7eX3s9puq952n9BHfRDxz8/MdzsufQZS2QT/CQy
 t+dFmAjqC17WKhNBP9Q1EayA/qdcGNH+dclbfPfNZeGWbAbnFSZbjzrpR5MF5tWQqP1p
 YCk38qotBg6TIQQIwRoc6URS+yDZWSx8BFl+4F7vw04c7ob1MdXdbnHpU0Q1CQKdRh+U
 igbtXyJEg5z9/p0wLb2B7aQ96Jkzfhoz6606GCCzCYOS2bFpG1UBfRBBlX+nMFf2KK76
 Eshw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xC9XKZzf2tdlT8hSlLj+6hmL+TXDDjIef0dprevRScU=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=cxipRhzlf6LnvVkkVv2Idsa84HJVeOyIs0o8bAnwUYOvbxMVQd+ixpyJ1fVcH9OdWi
 8lZoPuW6rTa0on1Ggel748PTZu7xNSa5IbP6NP962hZiy6toe4Orodk+jJ1+/YudBinK
 FzggPoRjyDy+g564WkVvrqNcL0ZNXAzmPDle/dzwouGHe+YA5YKQdLr/TwxBZTTaK9NQ
 FbzTzS1juRnUD4upAObq1GtuhbBn3oJweZXxq/Y42aWk4hG7KUFORA7axnKXi0/pqq4S
 UCBoXioGLKi8fyiplLx373lnyUp9Vhk3Uq05VbjuTs+M+jYKYZBJYW/QVv+l9D1Qwmre
 dmug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790723989; x=1791328789; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xC9XKZzf2tdlT8hSlLj+6hmL+TXDDjIef0dprevRScU=;
 b=SRnNTwoyuUzQEmZHw0uBd1xhDFKRrZG2anBdeTvgUvu7ikOZD30mvFv8/vVetEwXYB
 fJH2NoAwjUu7A/Zu+CkiTxkjnPGOBRFuJLkHrgR7fr0+j/pTWD0UYuoekYz7iDRwpGO3
 RMFHxvtUjB60edrfKBCtnUeKKDGiVL9tRUeAwGbBXzC4kk/rhDPfdpd+MnvqUmfUZkc1
 +UrLvxARbwiDHukt/BaEk9USEMXpGoews+QicgV6/GSf0jwZMM3bEruri7wcPBOoBXaW
 53Ao+MftImq3vtOJOiwR2Imlx7bg3HxVgyXJzTltqdadHL08eH/xurIyou/JVNtNGx+a
 LOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790723989; x=1791328789;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xC9XKZzf2tdlT8hSlLj+6hmL+TXDDjIef0dprevRScU=;
 b=YZ/Ny55rumNFtUXBfOWrukwYmCvYePQNiO0S+rbzT+ZW2PV34JNtnaUw0fKLFOtb34
 hSp8gA/mHuh2K7WBl+VtKncuPyQ6EftRKpSLqdUbIISwTMkMDkETt83zQ8jXoN3JNfY/
 m/Fj8Ia0M9FYICOlclxTpUcSrcQRUQnICOm5XB+u3EyY1sKnyc4A300czci1+XtEKfMH
 lydZcUFelJK/lZiePFn93GtUcbJ1edYujjAYPCHqpvF7SbU8P4db1ZmvytYtNO9nDNe8
 UjQewqZj0P7IoF8C43Z5CSbcUr2ZPsSjfDTfsEm8Rgq0YkvUfZEV2cH6vw9mMoC3iM0f
 2H1A==
X-Gm-Message-State: AFq9FYLOC9rwqrH/ZaQLzkVnUhhQKp2zUyhULnGXZ6QUFT4I/tJj2X/3
 PhDitIZ3BPqk3kydsRx9pfSujW1sJEONs5WgQZyTQBfT0cI28WfYB9+laSINcvjwt3carDn4ssA
 XRfstoeGL5Omckb9m5XNsgee/iczdPv///A==
X-Gm-Gg: AYBFou0IZoF70gDljNpA8xGQ5ti8K5EAHOTNPLI+2lCzpRe7NLTGphqfnRhrFX0YLDr
 4Bb2WrNjrmhHeH1uz4B9pkKqwJgkkEhNSZf0KJkuJGEiMIod/+aiRqlRIBE8+E8RQQgh9r8Pn0t
 NcrLiKRntrUE74l74N53m+XQ00sQijryfVOSVib5bEfxQZm/9awIbvaBYu9E+mqcgD65pHOId0Q
 x8pRr6wH6VTGczBQDk4whuiqd2J/1Rh7VQOM28BlwzdQODs1j2sinObqyBW1lzZTyWbMGJvAZKm
 3SUOhNfvX6qQi4BrDIbmqdceSu5sAIMbfvNBaU9IWP6ytVkzCB+35pnx/jSACHo1bcVVYCf4CmT
 RMPvcTspiGEtvHA==
X-Received: by 2002:a05:651c:a101:20b0:3a6:4fdb:7a6e with SMTP id
 38308e7fff4ca-3a7718fec09mr1561121fa.23.1790723988626; Tue, 29 Sep 2026
 16:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-88-richard.henderson@linaro.org>
In-Reply-To: <20260927090011.10724-88-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 29 Sep 2026 19:19:34 -0400
X-Gm-Features: AclHuK905B4tT3vSknikVXItQLCcsdJEI9owO9zkvDhE93YdDLCd5hr9zFEQ5oU
Message-ID: <CAEdQ38FNswVRCmR7Mf2iV_Zs1ODLwauXOksBM9DDC3fWXLGF1Q@mail.gmail.com>
Subject: Re: [PATCH v5 087/101] tcg: Generic expansion of tcg_gen_revbit8_*
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:38::e;
 envelope-from=mattst88@gmail.com; helo=mail-lr2-x0e.google.com
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

On Sun, Sep 27, 2026 at 5:07=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/tcg/tcg-op-common.h  |  2 --
>  include/tcg/tcg-op-def.h.inc |  1 +
>  tcg/tcg-op.c                 | 51 +++++++++++++-----------------------
>  3 files changed, 19 insertions(+), 35 deletions(-)
>
> diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
> index d5915ecc1bb..ed503462a2e 100644
> --- a/include/tcg/tcg-op-common.h
> +++ b/include/tcg/tcg-op-common.h
> @@ -135,7 +135,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned me=
minfo);
>  void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i3=
2 arg2);
>  void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
>  void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
> -void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
>  void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
>
>  /* Replicate a value of size @vece from @in to all the lanes in @out */
> @@ -161,7 +160,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, =
unsigned flags);
>  void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
>  void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
>  void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
> -void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
>  void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
>  void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
>
> diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
> index 2ebcf4a0665..ab1bf259296 100644
> --- a/include/tcg/tcg-op-def.h.inc
> +++ b/include/tcg/tcg-op-def.h.inc
> @@ -49,6 +49,7 @@ DEF3(ori, TCGV, TCGV, TINT)
>  DEF3(orc, TCGV, TCGV, TCGV)
>  DEF3(rem, TCGV, TCGV, TCGV)
>  DEF3(remu, TCGV, TCGV, TCGV)
> +DEF2(revbit8, TCGV, TCGV)
>  DEF3(rotl, TCGV, TCGV, TCGV)
>  DEF3(rotli, TCGV, TCGV, TINT)
>  DEF3(rotr, TCGV, TCGV, TCGV)
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 0c6146cfbe6..17f323b1b72 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -119,11 +119,6 @@ static TCGOp * DNI tcg_gen_op1i(TCGOpcode opc, TCGTy=
pe type, TCGArg a1)
>      return tcg_gen_op1(opc, type, a1);
>  }
>
> -static void DNI tcg_gen_op2_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2)
> -{
> -    tcg_gen_op2(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2));
> -}
> -
>  static void DNI tcg_gen_op2_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2)
>  {
>      tcg_gen_op2(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2));
> @@ -1016,6 +1011,24 @@ void tcg_gen_remu(TCGType type, TCGTemp *dst, TCGT=
emp *src1, TCGTemp *src2)
>      }
>  }
>
> +void tcg_gen_revbit8(TCGType type, TCGTemp *dst, TCGTemp *src)
> +{
> +    static const TCGOpcode revw[2] =3D { INDEX_op_revbit32, INDEX_op_rev=
bit64 };
> +    static const TCGOpcode bswapw[2] =3D { INDEX_op_bswap32, INDEX_op_bs=
wap64 };
> +
> +    if (tcg_op_supported(INDEX_op_revbit8, type, 0)) {
> +        tcg_gen_op_tt(INDEX_op_revbit8, type, dst, src);
> +    } else if (tcg_op_supported(revw[type], type, 0) &&
> +               tcg_op_supported(bswapw[type], type, 0)) {
> +        tcg_gen_op_tt(revw[type], type, dst, src);
> +        tcg_gen_op_tti(bswapw[type], type, dst, dst, 0);
> +    } else {
> +        tcg_gen_bitswap(type, dst, src, 0x5555555555555555ull);
> +        tcg_gen_bitswap(type, dst, dst, 0x3333333333333333ull);
> +        tcg_gen_bitswap(type, dst, dst, 0x0f0f0f0f0f0f0f0full);

When called with type=3DI32, src2 won't be in the canonical (i.e.
sign-extended) form.

