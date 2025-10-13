Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247F2CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 13:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Ix3-0006ie-Gh; Mon, 13 Oct 2025 09:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8Iwy-0006hh-RC
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:50:57 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8Iwo-0008N4-Ck
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:50:56 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-73b4e3d0756so46279307b3.3
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 06:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760363442; x=1760968242; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B9dMIVS73mWDE4Lqp7+S3qAEr4HjA/1yzsmF8bF7IVA=;
 b=cnmCgAoyKr+qw5HlqkZurWhmI66Fg/R11drUuCqhs9egYFqxZFsSPIeAkDdexEe6CT
 L4SciDWeb/13peQV4jf61mwL16CShaxB7KKfShbB3JCAfXUdfk0VbKe0x8OduiU1Pyee
 +8uctn7CCCMeJ0LZjxu/LYYc1/RVN51bwG1CoiTjQWTIXKnChFHrKAeyDkJ8fmQ1Zwhl
 KUbCoXMxpcO0I56aUTA2D6GBjVEZno+qso6qsz8LgTE+JFQp5KSdvb02NyHJUYFnTfA+
 UZULLJgzl+z07C8jxH3BX68KD+6BcJ/PIuNmHxvQp5gKWrP05FI/N5xwDrcsuL2JkIVP
 60HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760363442; x=1760968242;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B9dMIVS73mWDE4Lqp7+S3qAEr4HjA/1yzsmF8bF7IVA=;
 b=SbEaQzqPKc6HKy260dK+PJ/+O0bNYRXkrjyqnGRBUe45jpF1Ns2KQA8cd4/wQ6SbuJ
 5zhaKY497g+l2KuXLjofn0ybA6eGcaLqwiO+5GDFORlBKpBT6xprrrWA2NgYHUfaDrER
 qAszvWFOnG+VE6SHAJ1cskG5fVLF2FtH5B4GWx2zmIi+h0FY31/lUQh/asCnGrNIs5Q6
 n3GI0XMXxIt8BkH1i1NeBqJgwEocFpjS5lcoT14h5niGOViKDIhTXSiNlXZeqe7htp9Y
 FeQgV9aJBu+tTFLRWItKHVfHkQCPVCCuw/Y/ClDAcmRWoxbggv87wCK8Pq6Dbh7gSR3r
 ZMgw==
X-Gm-Message-State: AOJu0YymVyJusp1nxZdJYjL7f79q8vdkSHy4H9N5YSecF5SMPKkKgMtE
 sCQfKxsaY9I4fAglMcsXHXvQZizpXIbCzWXy9tY551vA6q+2+jNiGytpzI6RO+6Yuwt6bwmWdDB
 Qtag/qxPQSbMvC1Vu94Ldw7cfiDBpjjDFuKhQULSdmA==
X-Gm-Gg: ASbGnctcN4+WqsxPROvkPF426yztSKI37VKNKwxjYuQMlFzSD2jhmwn0tPh7kEFrxXj
 E1VnDxAIw9Z3/f5deWNwohn9FKFmvrwu6HzL7NpySmwBX/81Dp4ICKQgAXqmBfRzOcg9e/v0iHV
 IIS+/uprVcmQa4lzZHYhVreE6tub/+abrp32UO0M6clpX95Ndw8VAq18+KJa9sFG13vKt+qbtGY
 UsMrgNcuOzie7xRFj17GRb+PQYNvTN1hFPvkm5BVA==
X-Google-Smtp-Source: AGHT+IFdZ1d5qVyQNkbQDZlej9eWCKaOhz4x9WUbZ54TZTmqM2CiRdYDrv4nJSerulA3GPeqxMhHnlO3NK/wFRxcjLc=
X-Received: by 2002:a53:accc:0:20b0:63c:f5a6:f2fe with SMTP id
 956f58d0204a3-63cf5a707bemr6283504d50.64.1760363441977; Mon, 13 Oct 2025
 06:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20251010201917.685716-1-richard.henderson@linaro.org>
 <20251010201917.685716-7-richard.henderson@linaro.org>
In-Reply-To: <20251010201917.685716-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Oct 2025 14:50:30 +0100
X-Gm-Features: AS18NWBnZiffbyKDGYNxlfrCWCUTXgWeO2eYHKECmloHfiIy5kMdVktMWSoG5_w
Message-ID: <CAFEAcA-Y6fHULs167FZBFTAOo0FuPdVvaPtPb2ihXWkf=e4gfQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] target/arm: Honor param.aie in get_phys_addr_lpae
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Fri, 10 Oct 2025 at 21:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/ptw.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 5fcf104272..23f6616811 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -2319,7 +2319,9 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
>
>          /* Index into MAIR registers for cache attributes */
>          attrindx = extract32(attrs, 2, 3);
> -        mair = env->cp15.mair_el[el];
> +        mair = (param.aie && extract64(attrs, 59, 1)
> +                ? env->cp15.mair2_el[el]
> +                : env->cp15.mair_el[el]);
>          result->cacheattrs.is_s2_format = false;
>          result->cacheattrs.attrs = extract64(mair, attrindx * 8, 8);

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

