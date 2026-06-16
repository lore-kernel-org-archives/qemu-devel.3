Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19C8CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 13:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZTxR-0006M7-Gb; Tue, 16 Jun 2026 09:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZTxQ-0006LZ-HH
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:36:00 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZTxP-00086L-5L
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:36:00 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-6626cd98209so4798448d50.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 06:35:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781616958; cv=none;
 d=google.com; s=arc-20240605;
 b=MnjvCl7IbRahS2X8082l1lTMUZj0cDqTeerCndsgTMN9JwJmAkngbV6vyeu9Dpyepo
 TVz75CzdsxrvEMENCTe5l1gBzpJKJjTm1F58g2lnV+iPuVFuqFvDeWYt7LhpaFrD0gU+
 LBn6LdFoWY0p0xrOilwjb4X4VC75n52W8ml45eShWHvxPEO+ciK9e8pshST5GiI15FiY
 Vo+qpxxoX6fHqaz6coN1/t/zd/DsahdrnWzhoJYdtx3jNwbaLtMbibe2wYVRlyPTcxs+
 Jp5GNBvb3bvptiRNgjHag0kT/OBJZIpReRSC69dESiE1yhhIQRCadlLmXnMLOm/BLUzm
 ht5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jVdCM0vm9fG8/nik0JzNJlA9w2tO0XZ4Hh14ixz2hhQ=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=c5VSWzquFXRsOLA1fHQDCsPRVl9/VcdRmXTCz2ncViBTcW5t9IUDxv3tVP5vjTxDCD
 v2Njx+dK7gIe/5B2DzJgDBBvMN8aCUZ5Jh7HlXHQSTv0esTxqcVVqMgWYLV0ao+iYXPr
 8012PoQUUXaOG2bC4PtyZ75IvQUowYfY4HST+IL4WgjNUMtjfCChCkcobXgHYc3W1L8h
 4Aiudx1Osk07CAodv4d5sUKqNTwNEskZHbq7oIyNDf0NfgpENmojpzgcnO766B+3cBBI
 cGnjenJJNI3T7fP9nIjCzTV8l5kHHLHuOLBqih5RH3pcPtvyhF1rRofM76CNXcEs67aL
 73Rg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781616957; x=1782221757; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jVdCM0vm9fG8/nik0JzNJlA9w2tO0XZ4Hh14ixz2hhQ=;
 b=rCrSNjrPzNm51cHkiWdMEWeAVmNMO8Zc+48wN0+tJiWZP+S2HQ+36+E2ylUkyWRm8v
 JIihibgdgBV6FsU7r1OnUu2Iy37sEm6g/FODXGkFKSJx57qh3D5AKWMQBcSTXzJtJKf5
 oN6jU2GyPeAM84LQESA6E8GxPgn54lBN3XkGRt1N//UAOI5U2piZakJ5wvD3bdLMKqSw
 GWqN9J+nb9C6N8ogcEIYYvFM566y5zRWYY0tRcUmXJLi3282eK78na5fBz0XrCrZX1sY
 X0dla1Q4oywIOqbCyMbP9/x0dkA6mxBz5yjz114xP3kixxUOiJDCblBjskpuSFvDfV1s
 RY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781616957; x=1782221757;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jVdCM0vm9fG8/nik0JzNJlA9w2tO0XZ4Hh14ixz2hhQ=;
 b=PJMnSuTYB/Ru4Lhez0XE9uwUpo0JITOQTpzukVY2pdzn0LXCr5nIvS2yC/3MkTnhFb
 EoDAmpt88gycBboO3i0vLq8s06qZXTg8i0ef3TctHhrrcXuLJXu2p5ZHRzgErtzwkRmj
 REDdjk74EAQx10dr5qzvY3wKu6sLd494EFQBLljOl+pF91/4BbJAGdg7kwTnFOlM1g4t
 Eg08xmKQtqYyCBuiHKIY/MP8Pf9DOhVv2m6ywnn2tUEtqItfPuatMsQ/JAX7U4BL90HB
 Sb65lbg9R4e9+tNmSUf0aLhuOJyrhVD6fZglmpj3N31u42KwVW1eHUoOnCBhiTJ+uJOi
 Sbfw==
X-Gm-Message-State: AOJu0Yz95+Uw3XMOcrDJJGej/oziS0gV7FrHvQnEJIPr+jF6ghiceEUI
 wryLtvO2DDi8tC4HV2nwWC6plSep0Gj43SVfNfAOTENGTLcxCgYhzEauKXrANTtd4TlvcacVtPK
 gtxM70JZz9H9bgPsgSB4oqcdh7vWckFUk7JyuG3Ik9w==
X-Gm-Gg: AfdE7ckGxl3eSdIg5rgq1Ap106+SzqhEhN61Lg3gBK/KtTjLO36CgEUR8OTDVD4WgzC
 I+qbADruSfRDPEtvve+HRuKKFDDik9DlwrBONvrAcTGCkL92BJUIv3MF2hyUG4GTRpQRR9WcxQm
 731NbselNrEV30WuSWKXHWX0FBumgtPVdoHeoJusBJ4pjhiUoKpNF41EaOe1KKpdWpv9roCfLoy
 soXDXJkgroAiOjqmp+o4dCHJ0IemY6sr7WaM0j/yHLz3gzdnxvA/XPorCrmw8/WS2Qg+VByaCNp
 Uv2QhyARugZ/t8VMFRvB6ufG/Y0yRBb3qRktAX4PvOSZnvmqNwUhw2EugkggPSbb/xM=
X-Received: by 2002:a05:690e:124a:b0:660:6971:db6c with SMTP id
 956f58d0204a3-662b6136872mr2697099d50.44.1781616957358; Tue, 16 Jun 2026
 06:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260604234852.573178-1-richard.henderson@linaro.org>
 <20260604234852.573178-21-richard.henderson@linaro.org>
In-Reply-To: <20260604234852.573178-21-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 14:35:45 +0100
X-Gm-Features: AVVi8CcycCkRH0RFQNH7U70Z8i_r5BS5KfBphlJLe4QnrTZ1PqY2l2wE96vKVUY
Message-ID: <CAFEAcA8Vnncc0dfz8D8DRe0npH9FSRPsNWg+_-PDFdiqyWHSdA@mail.gmail.com>
Subject: Re: [PATCH 20/25] target/arm: Generalize sve_compact_[sd]
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 5 Jun 2026 at 00:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Implement with a DO_COMPACT macro and general purpose
> predicate handling.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/sve_helper.c | 51 +++++++++++++++----------------------
>  1 file changed, 21 insertions(+), 30 deletions(-)
>
> diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
> index a13ccf4b85..40cf567b0d 100644
> --- a/target/arm/tcg/sve_helper.c
> +++ b/target/arm/tcg/sve_helper.c
> @@ -3637,39 +3637,30 @@ DO_TRN(sve2_trn_q, Int128, )
>  #undef DO_UZP
>  #undef DO_TRN
>
> -void HELPER(sve_compact_s)(void *vd, void *vn, void *vg, uint32_t desc)
> -{
> -    intptr_t i, j, opr_sz = simd_oprsz(desc) / 4;
> -    uint32_t *d = vd, *n = vn;
> -    uint8_t *pg = vg;
> -
> -    for (i = j = 0; i < opr_sz; i++) {
> -        if (pg[H1(i / 2)] & (i & 1 ? 0x10 : 0x01)) {
> -            d[H4(j)] = n[H4(i)];
> -            j++;
> -        }
> -    }
> -    for (; j < opr_sz; j++) {
> -        d[H4(j)] = 0;
> -    }
> +#define DO_COMPACT(NAME, TYPE, H)                                     \
> +void HELPER(NAME)(void *vd, void *vn, void *vg, uint32_t desc)        \
> +{                                                                     \
> +    intptr_t i = 0, j = 0, oprsz = simd_oprsz(desc);                  \
> +    do {                                                              \
> +        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));               \
> +        do {                                                          \
> +            if (pg & 1) {                                             \
> +                *(TYPE *)(vd + H(j)) = *(TYPE *)(vn + H(i));          \
> +                j += sizeof(TYPE);                                    \
> +            }                                                         \
> +            i += sizeof(TYPE);                                        \
> +            pg >>= sizeof(TYPE);                                      \
> +        } while (i & 15);                                             \
> +    } while (i < oprsz);                                              \
> +    for (; j < oprsz; j += sizeof(TYPE)) {                            \
> +        *(TYPE *)(vd + H(j)) = 0;                                     \
> +    }                                                                 \
>  }

Why do we have special versions of the predicated loop for 64-bit operands
elsewhere (eg DO_ZPZ vs DO_ZPZ_D, DO_ZPZZ vs DO_ZPZZ_D, etc) but we don't
need to do that for compact ?

Similar query about do-while to the previous patch.

-- PMM

