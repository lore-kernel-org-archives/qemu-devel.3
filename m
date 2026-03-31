Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81332FF60D9
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 08:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7U5i-0002zq-4t; Tue, 31 Mar 2026 04:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7U5g-0002xp-6C
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 04:04:48 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7U5e-0001qb-NP
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 04:04:47 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-6501d242e2fso3262341d50.3
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 01:04:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774944285; cv=none;
 d=google.com; s=arc-20240605;
 b=cs2bWOAfYkUTTXZdm8X4tq8VDlPyTu6xAeYdPpw+vUU7wrz5Pkghjf4ee+K0PL7hOe
 9Bb4/4ZWXVbwqHAfyfN1S2YAjmvAOgvBwIB0Izk9aG5XqILqY/8z9AQqn4qu8bZpsou7
 f4Bnyx5fEsvNV98br0TOM/UDKYqw3ZxILQqjjS+atqM2N/dNe+cqZZ+0tlBvVWzPouA/
 olbaJ7QfhI0C9ir+pMV7LjIGMheyCnT3M1G91M+Wv/mMnqDOj7IqPsMFgM9C7okuM69R
 /8KjVtuVASc31FOE5owT9Y/mtAt5AL+5Eu3hR92UVp06IK1YKbU9a7CV5ha4si+ekPe9
 Wpzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bi9my3dx4PdA6/nJnQf4T4+0Puvh+eeVObAp//Y81bc=;
 fh=lSj/1hQsilLqqrIQB6s4Q1wh6081l/JyVKvt7e1AODI=;
 b=CYpHRCPDe6ypBE7vTTiTEQi3Qtv98VIk3MRwfckqZBc2Iwu+unOjN2dLYjyivj3u0r
 xJK0wYCTwKD+EAgVirWljyF7u7NHHXRLBY8qDAlJB3Fphha6VGlwilnkq6mFjw2kiwx6
 cYjEn9VKZ473sxjUO88wmsc7zx5TOGSFgAaQaG7qH4Se/m6ufgmZ7gWID8rbmlRB1MZC
 LtrKvgtzcPVa/a4k0sgSk2nEMlU4EbRRot0fPFndoTRgr10rDhMfFt0CGtcUbr07zdJR
 q7BCOL12yCVg04Pr9Zfd9KGqHpGh5xKKopFF5gOEH44cthhg6BpmUR0c8cJXN/qnHyiO
 kYdQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774944285; x=1775549085; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bi9my3dx4PdA6/nJnQf4T4+0Puvh+eeVObAp//Y81bc=;
 b=py8WrHtxGOolKHAuD3fhzLh+cKLTeTq/h7riz1IOAe50GvGt3FyAYu3j0xCPGKAHTU
 9hTCBCuEhkyoQz+h+I8Cblq/vhyl5DPk8n6s9bPm6Gk3xz4oSItJKQ+1NaAaGX+pQu5O
 QzFY77k5JI886Y0CCf7WHjxUGatSq8fphJ6FzBxG+58o2mW6EFLfbfYrpXa5AijELccy
 8vB8ivdiF7C1afNfZSjNrbgRq46zNu+mdOxuBTx/VtMIOkCY1PnFcLKEv13iPm/rVTbj
 NTX/jj8+I9Mhm+Z/61kPFrptn2FbfS8DvTUAsRkfMgSqmWxd0U/VZD/Eu8oiJyqYH5+t
 UINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774944285; x=1775549085;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bi9my3dx4PdA6/nJnQf4T4+0Puvh+eeVObAp//Y81bc=;
 b=YiNonHFlMhzVLp0uYX2YcmYdkSb99mkkr9K38RoKwil4rCBhj5fpdBNs3BEipJ98ij
 lC4G1xcz2mPT2fa/JZg4NXE16fFwuAX+UDaB1b2MaBsHAQ9jMNjcFPlVHijhebNhiHU1
 8siM0YcFN10zOblZJFOz+HCSFNIxY6GWLhz1XEuXrqhaelQHgkwKg7I63pYwtgMQaVdc
 nIbsVHFvFt+OzkDlh1JcZvvhJqftFrq/0OxNL/LWZV1XTCdZ303SsP9yfL51ckStmaaB
 LtRRvCzrQtw/AQUn4xWa9H3EiBsgicHyp3g5ngMYRd8NWk6Otu7MWvX8BGssAPLSmC5w
 pC1Q==
X-Gm-Message-State: AOJu0YwbPLuw3APT3R7Z1OfYXu0t1PZCXo3W95K+7YmCOyRX6m6bKtVP
 Vm0pwhgYtQ1LW3Hr0RpUjkBPI3VADHzv+E1Pu5CnvGSE/QCwdajYTF/Qj6yEDj5kQNygQxTAgJT
 MG9/63O78ccRsCglXXHf+UZtyoCyUmmVn29hpJdjKNw==
X-Gm-Gg: ATEYQzwfFzIR1K7en9TZYIRXrFQzZ7XZOuMn9X9WTsy2mi0yz2E/QyiTnZfb8psrW30
 ba6mpt3h7eYdRdfVbvOpEAiwfVE+pMRDJD/3aHDNFn9ZwL1dA3MtE5RHQu1A1mSXpUgXrikpI6R
 R2mkH8LD4Q6/KeIq3yTF9INWYT0k/RHMc9fd7pVIXqfMdj2f2oMMZYc14C2YQGeu4E+pbzooKrV
 fOsm5IAU/DQCD+ulhY+v2oLer/CatfuVUAbA0LWaVWVpmZiUppqXPkHqqZmiq6pOO+DxvxFs3g+
 Ox2QDJsNkmsa5YnFGhR/F/oBvt5wepTOTJ/j8a+9OJf+HH4akzPqR7iC1elFd4fBdWP41Uos3Vo
 j9g==
X-Received: by 2002:a05:690e:1c1c:b0:64e:e9b2:bdda with SMTP id
 956f58d0204a3-64ff71e8c8fmr15966961d50.17.1774944285360; Tue, 31 Mar 2026
 01:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774904832.git.balaton@eik.bme.hu>
 <24161ec41f118ad097387f8a84897dee7b4747b8.1774904832.git.balaton@eik.bme.hu>
In-Reply-To: <24161ec41f118ad097387f8a84897dee7b4747b8.1774904832.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Mar 2026 09:04:33 +0100
X-Gm-Features: AQROBzDCawWky5vSfVR3FtZc8G5tgn4TGdO5BpJ1dETT2Vw9phZugrWLWCZoDtE
Message-ID: <CAFEAcA9YFCRRy+44AZ-agSvMNvmV7MoCmHed92YS4EhhsPZ9Zg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ati-vga: Silence warning about operator precedence
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 marcandre.lureau@redhat.com, Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 30 Mar 2026 at 22:09, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> Coverity in CID 1645969 warns about possible operator precendence
> issue which is a false positive in this case but simplify the
> expression to silence the warning.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/display/ati_2d.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 23527b2c50..9baf6ff37b 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -91,7 +91,7 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
>      ctx->host_data_active = s->host_data.active;
>      ctx->left_to_right = s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT;
>      ctx->top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
> -    ctx->need_swap = HOST_BIG_ENDIAN != s->vga.big_endian_fb ? true : false;
> +    ctx->need_swap = (HOST_BIG_ENDIAN != s->vga.big_endian_fb);
>      ctx->frgd_clr = s->regs.dp_brush_frgd_clr;
>      ctx->palette = s->vga.palette;
>      ctx->dst_offset = s->regs.dst_offset;
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

