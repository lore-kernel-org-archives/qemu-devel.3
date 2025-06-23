Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7B2C77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 10:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTdzo-0005u6-2L; Mon, 23 Jun 2025 06:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTdzT-0005oV-Qx
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:01:29 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTdzP-0005AZ-CD
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:01:26 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-70f94fe1e40so38395097b3.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 03:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750672882; x=1751277682; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gf2MRS+mWn7KwU3W5xvQuWJD1ZhhnYKhUn0KAgpq33c=;
 b=hk6oZ7QQ3LHtH0KJo2huewwwLIudtdUIujRZuwzZMZqhsiLa24zHVBgJm32jnCUdIT
 l4MhbU7ZlQHaqg3cHrrcm1lDIKEk0gBvJwUaSDWNRuqcLK+pUjCzQzeZsy+mYGTypWOE
 Sqa8IIM8fC/QMBBEPclGKCvaz8MVI7PT+T1aQG0S6l+aomeEYjriccy2oI5v1SABICyf
 9x4MgJjKznBCJ2mdPK6V8j1qpoKkAjhWvSI8HjtTNgWogqlJoZ6fL8JFCqFAQXNnHr/6
 EDnH/enorn6I+LQk6rqMQYa4r0unW8GgjjeDjqa5p5xLzqIBv2r4kLVKu2k4jEQudLxM
 lG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750672882; x=1751277682;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gf2MRS+mWn7KwU3W5xvQuWJD1ZhhnYKhUn0KAgpq33c=;
 b=Vd2W8Pv7CgZJaAyEIaxR30/LtTSniPSaweDc+D3e2Yr7HvjI9lHSNpr8f0e0f7CK+z
 gTaUKisf2a4kIzMNPi2veRTc36rl0Ntyai59BUiSv5o/vjTRsAJIb+7QE8ZD6H0BXq3K
 KgCoOWZ7FHu4I+5yGzaIzgCemM6Ma0eHxPe3KVYFUOvKbL102wXvNSUc9EOy3pJ6qolh
 2gFKkWKm+jzELWU9TKpe9WGZezFyaXFpCG21/yOhDZOYNSFZFW4nvPZzifnibHT7twtb
 xGR6HhUoAGIOkU4fG1rg2xA+RL9HfOVmb3FlL/mPpeaS4kH78FExPRuf9bIE7Qg72eAj
 PNLg==
X-Gm-Message-State: AOJu0YwHMPDMcFn26Wjj80ODqsI4EYy/qvOQp0FnGonpXpXCYbFQ/jLq
 vGf3mnyNRZpP/ZwblfSfvYbZ7ChgPceWn2MkGVyJs2TO+4ru7YVOJ38kNG6xg4fYV5J/Hxu+vFW
 pFsdBqtkkmef2dlMQqnP2qIpv6Ows+vZpBZ4NhPnJoFjnlnuI7eA7
X-Gm-Gg: ASbGncsUJXArpCnLZQKGtX6rC564clBrWbzOrnWsX0iHa5RPlK0b/r+H/9ENyafwxkb
 icKJM/rv/lYyfncqkPv4lfebUxDXKPzhsvPP+hbdQyEIcNkbxgN1cs6y9X3LOEZepPHPURQxiTf
 N8xrROf4uAtlg0FX1bO4t/3NDi3QMco/WKV8qumBQNrgF9
X-Google-Smtp-Source: AGHT+IH84tmXhNRjUYy47tTce1V/NnJgszw8cwZPTS96sg5N5wfmcJrzzY0pgo/kJTRHSB9Uns2w7GjwstXHi5vtYuo=
X-Received: by 2002:a05:690c:312:b0:70e:7f7f:cfda with SMTP id
 00721157ae682-712ca3fede4mr148698967b3.10.1750672882126; Mon, 23 Jun 2025
 03:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-3-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 11:01:10 +0100
X-Gm-Features: AX0GCFve5zq3KN6pMQPiUA2MNz0dZwimb5Am8N5zUsBi46Dd_HBAJGvJzTte8tQ
Message-ID: <CAFEAcA_KndtoXuGEHUbdYEs5PP5XH1kPGaVi5N984Kume8n5Gw@mail.gmail.com>
Subject: Re: [PATCH v2 002/101] tcg: Add dbase argument to do_dup
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Sun, 22 Jun 2025 at 00:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg-op-gvec.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index 1aad7b0864..451091753d 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -534,9 +534,9 @@ static void do_dup_store(TCGType type, TCGv_ptr dbase, uint32_t dofs,
>   * Only one of IN_32 or IN_64 may be set;
>   * IN_C is used if IN_32 and IN_64 are unset.
>   */

There's a doc comment just above here which needs to be
updated to say "at DBASE + DOFS", I think.

> -static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
> -                   uint32_t maxsz, TCGv_i32 in_32, TCGv_i64 in_64,
> -                   uint64_t in_c)
> +static void do_dup(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
> +                   uint32_t oprsz, uint32_t maxsz,
> +                   TCGv_i32 in_32, TCGv_i64 in_64, uint64_t in_c)

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

