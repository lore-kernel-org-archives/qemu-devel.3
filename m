Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B13CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ4Yi-0000UJ-Qb; Thu, 21 May 2026 10:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ4YF-0000LZ-Bs
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:39:08 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ4YC-0000iu-F7
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:39:05 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-65c6a2158d3so4504080d50.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 07:39:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779374343; cv=none;
 d=google.com; s=arc-20240605;
 b=B4ydwJX487uG6cAMby8c3TdvCjdg9yVK++GfnnYHxCo1xT5ChGnClgIBjtN4YminRr
 M4OviEZJz6omI9+PPlrVf16S561L05iG9DfeSC/waTu+hN/YGDvEFWL+mBr1+Mfkocmv
 BWSUlON23taT8ddlb/8yiNuZEIpBIJN7mA9WNhEKtYH2MMVxjCafCuG675FEe5J3jmNE
 MaL9JUeC4/ftWLfb4W3ZM3nX7MujAl7OrKxjBFFE4IgtIpHW+paxiwkKHxozDQGKiNsD
 Kcbke+QKiL7DotEjv7YVDVLTRvl/i+k/1Kj53SWXHfl0dv/Xnxz95K+9QSYaEcKkQ86p
 AwEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OViE6hLzerBYdVb6X057GkDOGNqwUo94aWD03uPhf9Q=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=Dcya7pVqyI/zgd5u0rULbH84uR+rLAviTgxgRJ0/TibhXeIszu+SCKpHq0IBS2l2s9
 scDbPkcMLigyNBboemzmjXAQ3NJymXpar/raCUwo/IxbylMvpn0jBYQ0W/8VACEuHqxw
 ABfG9iONwthgvpwkkRCbDjjNUZ0QWV+pJ3lTqZ/EQnXe1q03d39FPlUBCxnJLFOIBzbs
 +f9hH0OUDdAPompF3/5qKI0zb6M6PPka3O7BYMmmSnS0Vn1raBnVANNvnf1YdWqCZ9X1
 vUKjdRx9QzE/hfmZfl8CgUZaLhOj5ajhucxngIAtOVglBajLKvUIgwv62KtTOLO2+gYN
 no3g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779374343; x=1779979143; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OViE6hLzerBYdVb6X057GkDOGNqwUo94aWD03uPhf9Q=;
 b=i5Y/UeAYaH8KDRev7OqypgqWcSG/VFSbt7BZMl1DX82VGIBCA7H2y8eIiZrgKhXu/X
 9Xt0s1zjohKo7dRzrNAD/zqWcLn5DgCCkFwSbHRJKBx0ESaiF9IiKiSr32A/0G5bhgcI
 ZYZu2vzND+emt38B/zVeRSQ9PPwT37Acpc3Mn3az1bRUj1HbsCUKDdId1WzhP/8ceQxz
 ixJ0nUSUKe8/0FV4WeXgZ9Nmvg3/EnmmwLA82jttkyX+5mjqE0XboVw2dQ339HhAS87i
 hGZ2gTqnyx3i3hE3ZMICY4ni+OUYjLoq6FNwWlSzusxJZPCEpFtmuGl2hbBmO8w4nnuE
 E0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779374343; x=1779979143;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OViE6hLzerBYdVb6X057GkDOGNqwUo94aWD03uPhf9Q=;
 b=bFdtH/98qOb0gSIJyN7Icl6j3LKopiIPQfDwuUg+c2oU3ky3VZYZBIZu6uuprKqwqC
 VkMvvqA7Bly7oy2l+n4g88zolrLbf6vLJIBn9kAHnUMMvUc4Y1VRDFDumgvQw9Zak31Y
 Ked6YasYcFhAvnZMJtmfuiP2jL89fN2B69IT8VtsN1T5wTgp7ak26EMHuuEhFiAWJdvi
 tDKs7r5utAJkgB0yjNJNoD93LTbXZUredRZUJvaShIZcefC5nOC5bw5DZtUbyXdM58Oe
 5KeIYVrw1U3WGArTAKejuM0oJtpoet5ZgtT1y356UTkGhmRVccZL1MlYJ3BMg0WV2eWv
 tCCA==
X-Gm-Message-State: AOJu0Yx5DY0i+0o/YydsmHjl4+Mb48BoUKMTS/CoTs9rPSl6d47+3QeZ
 mkblcI2ikAnyXbjQsP+baNyMbS3zHpA/1ZrVVHlWqPsO28Z99X/g2aKh5kP6kNUoNhzlLD+1crd
 z2/d1XbKHoamsQdmQs5ZPrc6Ww2DlNqfvHiWWdLm7xQ==
X-Gm-Gg: Acq92OF8Jbc493cWSdQqLZW7YkJr2v30HasLYt8ZqxbqypV77RJysCYL8C+lnY+agL+
 vmYozP8QqIxtqAXH8Mll6jxrkXiiCu0e+yT0Rz//O0skskQTIbMw2eLHATL7lqOf9cqY1kmunVX
 E/t9cm4kAhHEW0iK/lI962bAWSt61UpyrBJvd+TK2y3AcBFiIrpnmdap2zyieBnYVyhrnXZRtAE
 8NpKAT6AbTcftVgc9NRCaUdwE5PNRlKNQcMFCFVH65c4jS06dydk7I7ZGRcVRaIke4rLsP0rsBD
 l2m7CT0c6w+Ani9E4aBzru6HExHk58fokUpSCik6h8PWqq1jEzOV7JPVO4T9lXu6dpM=
X-Received: by 2002:a05:690e:140d:b0:653:1c2a:94a5 with SMTP id
 956f58d0204a3-65eadf950b1mr2596845d50.8.1779374343038; Thu, 21 May 2026
 07:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-13-richard.henderson@linaro.org>
In-Reply-To: <20260520182213.872945-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 15:38:51 +0100
X-Gm-Features: AVHnY4IiczqvFD5L1yp-gv1dRlBSSTV1zwNOkTkKL0Djh5iLtNmqgE-XtFVKf7U
Message-ID: <CAFEAcA-t2Yh9YQGPmByWeVd11+L57mE-X=ZHLw6PhNBRDNYxAw@mail.gmail.com>
Subject: Re: [PATCH v6 12/64] target/arm: Add FPMR_EL to TBFLAGS
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Wed, 20 May 2026 at 19:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Prepare to perform access checks for direct and
> indirect uses of FPMR.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h               |  1 +
>  target/arm/tcg/translate.h     |  2 ++
>  target/arm/tcg/hflags.c        | 41 ++++++++++++++++++++++++++++++++++
>  target/arm/tcg/translate-a64.c |  1 +
>  4 files changed, 45 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index c114510446..9e637c1d80 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2567,6 +2567,7 @@ FIELD(TBFLAG_A64, ZT0EXC_EL, 39, 2)
>  FIELD(TBFLAG_A64, GCS_EN, 41, 1)
>  FIELD(TBFLAG_A64, GCS_RVCEN, 42, 1)
>  FIELD(TBFLAG_A64, GCSSTR_EL, 43, 2)
> +FIELD(TBFLAG_A64, FPMR_EL, 45, 2)
>
>  /*
>   * Helpers for using the above. Note that only the A64 accessors use
> diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
> index 77fdc5f3a1..1648c2c96f 100644
> --- a/target/arm/tcg/translate.h
> +++ b/target/arm/tcg/translate.h
> @@ -199,6 +199,8 @@ typedef struct DisasContext {
>      uint8_t gm_blocksize;
>      /* True if the current insn_start has been updated. */
>      bool insn_start_updated;
> +    /* FMPR exception EL or 0 if enabled. */

"FPMR"


> +/*
> + * Return the exception level to which exceptions should be taken for FPMR.
> + * C.f. the ARM pseudocode function CheckFPMREnabled.

This pseudocode reference is a bit misleading, because that function
is for the indirect-access checks, which UNDEF to the preferred
exception level, but here we're returning the EL to use for a
trap on direct FPMR access.

We do end up mentioning that later in fpmr_access_check(),
but I think it would be useful also to say this in this
comment and to also refer the reader to the access
pseudocode for the FPMR register. We could also mention
that this only deals with the FPMR trap bits and that
generic "FP must be enabled" traps will be checked separately.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

