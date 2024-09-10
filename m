Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E243ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1iV-0004PT-EG; Tue, 10 Sep 2024 10:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1so1iU-0004K7-3F
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:19:38 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1so1iS-0008DB-4e
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:19:37 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c251ba0d1cso978349a12.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725977974; x=1726582774; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1FREOUDCx1VLyhPhrv1zXf/ZT0CjpOXI1qZs1mxDi4w=;
 b=jt5vGjDYecgBROxTYNJh41S4m/USeT0ALbpGy3ebdWYa+AoVDmW8ZmrSlXOnd8NM/B
 iX8OCHMAyaCF03t2/RauzpE74sqYBqjei9HRzICcsdNwN8aru6pxXnpoceGLNUvK4GZ+
 czh7cHioV1L99cAcuaGcwLfRe8rZOdh02w7hoRN3KhwMQvhFh+V25UvRl8m+OjkNS9Ed
 HUJVPeKAAovLO1ouJc5CB+AJ6IDpNcW5dceP91tj7iVQ/9wVcFBPL/PPRgQenoAUuNSZ
 SvyzEH0mCskN1L63QlwPpB7Zya2NUDTAEvdJViPwYnxsjNNwsHVjmOReS7C/RUQGcP9b
 IQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725977974; x=1726582774;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1FREOUDCx1VLyhPhrv1zXf/ZT0CjpOXI1qZs1mxDi4w=;
 b=s15QFjHvs0ihLDsiV+jagD4Bx3N+e7/gb05T7zCjBFKUT5LS73p/poCUeI971StAQT
 BU1y4ZH5mXuxcOfbBlxnmDJ4/ziw5/sFKPm5vWuBA3Z3h6GZ/0Qr4wK9lHzFuGRTKVud
 lylO1C6oJu+HtYRnY7jp2h83hX+ogb4CfOl+CmdN6+GKoEAANMXoQcHNck1dgj0GpQNu
 V1TcWjpB97ekKO4cJGSSrIDCh0DBbuBvGZOJcmSxny27DteLJ4G3m866PrAIpptiSMTU
 YNaCQqWksK2Q2nTGfQ6bbPdVEzgR1ps2I10ikqqkcXep0fvnuU1sKwnr6ZZ5Eu0zWOgJ
 OtBA==
X-Gm-Message-State: AOJu0YxtCuqOBtF+XBlx3WHrN3XvSh9LhbZ5VGE0q5DIoirMimhvnxKz
 rpG3oCDo1Q0ZTtXWJsXHgLKoW9fudqVJ97SwQEZEdV0JVheHRP5tPhGBM+m8/SAhX+cn0yq4W29
 zCtcoBh15sGDByZ/a8ip7QuWiw1Gt+X/Qhf2BYQ==
X-Google-Smtp-Source: AGHT+IHn6mdwIBnnBRXZGVNoTzfTkCwYDnCmKlbcy2bFjpwAh3B7txbUA63EOCmm2cTaBzgosoA5mtKQMUq90kS4Aj8=
X-Received: by 2002:a05:6402:4312:b0:5c2:18fd:8a27 with SMTP id
 4fb4d7f45d1cf-5c3dc7b8016mr11653356a12.25.1725977974156; Tue, 10 Sep 2024
 07:19:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240909162240.647173-1-richard.henderson@linaro.org>
 <20240909162240.647173-27-richard.henderson@linaro.org>
In-Reply-To: <20240909162240.647173-27-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Sep 2024 15:19:23 +0100
Message-ID: <CAFEAcA_L06h8M1fUSs1aoOzvyuF4Qb94bzTYT9Ohkr=kY4Jqvg@mail.gmail.com>
Subject: Re: [PATCH v2 26/29] target/arm: Widen NeonGenNarrowEnvFn return to
 64 bits
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Mon, 9 Sept 2024 at 17:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> While these functions really do return a 32-bit value,
> widening the return type means that we need do less
> marshalling between TCG types.
>
> Remove NeonGenNarrowEnvFn typedef; add NeonGenOne64OpEnvFn.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> --- a/target/arm/tcg/neon_helper.c
> +++ b/target/arm/tcg/neon_helper.c
> @@ -598,13 +598,13 @@ NEON_VOP_ENV(qrdmulh_s32, neon_s32, 1)
>  #undef NEON_FN
>  #undef NEON_QDMULH32
>
> -uint32_t HELPER(neon_narrow_u8)(uint64_t x)
> +uint64_t HELPER(neon_narrow_u8)(uint64_t x)
>  {
>      return (x & 0xffu) | ((x >> 8) & 0xff00u) | ((x >> 16) & 0xff0000u)
>             | ((x >> 24) & 0xff000000u);
>  }

For almost all of these helper functions where we change the return
type, we return the same value we used to return, but zero extended
from 32 to 64 bits.

> -uint32_t HELPER(neon_narrow_sat_s32)(CPUARMState *env, uint64_t x)
> +uint64_t HELPER(neon_narrow_sat_s32)(CPUARMState *env, uint64_t x)
>  {
>      if ((int64_t)x != (int32_t)x) {
>          SET_QC();

But for this one we don't. e.g. if the input is 0xffff0000ffff0000
then the old output was 0x80000000 and the new output is
0xffffffff80000000.

Presumably we're effectively ignoring the high 32 bits in
the caller, but this seems inconsistent.

It might also be helpful to have a comment describing what
the semantics of the return value is for this class of helpers.

I suspect also that coverity may complain about the
    return (uint16_t)low | (high << 16);
in neon_unarrow_sat16, neon_narrow_sat_u16 and neon_narrow_sat_s16,
which have the desired semantics but look suspiciously like
somebody forgot to do the shift of 'high' as a 64-bit shift.
I guess we could write them as
    return deposit32(low, 16, 16, high);
or maybe
    return (uint16_t)low | (uint32_t)(high << 16);
to avoid that.

thanks
-- PMM

