Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08D5C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXJKP-0004DD-O6; Thu, 03 Jul 2025 08:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXJJz-0003iO-Vf
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:45:48 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXJJv-00065u-I0
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:45:47 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-711d4689084so86872927b3.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 05:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751546738; x=1752151538; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q48XdcF4tFMmxzGzPCV/CG5KN8deHO+RM21kqPZKR5A=;
 b=uQiRzq/vGtu6rIg9hNxADiofnrNxTkRgxbw8FnTgVsABpgJ/LFxDn0PCa6PCKnQ8gE
 7pgzShtcl9UzqHthTpWVltJqOK33tsSQNgq+2zRWxN0NYZzdiv5pvD+dC958AOi/F4Lb
 1DdCO2nv+qYwDEEkVMPrUOAhftFUMjAzi4akpSFB+wniGNsGM/dolggqXzRbpBvtqaCm
 Us9/3pO7qwosueZdELWLTmCrg/d4yPvFNRdn7z5THMHa0qSWhG1sWK1vQcwiyovDtJqS
 xrnXv0ey9plGxvGIzGunbJDN370qBFewlQpkDeaLUw6tKe9OHjp2ITJlEMKzYIR1c+dw
 RY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751546738; x=1752151538;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q48XdcF4tFMmxzGzPCV/CG5KN8deHO+RM21kqPZKR5A=;
 b=c0O/Xp6BymY/hhoN5MtzcDYYbEYO4YZ6HM1bCQUwu+HoT2RFisY4t/4w12zxavQaJa
 DEsnW9StVkSQKShj1oE84Qkr35rWBlOw/VPkKaKChJl2Pb93QQpqrv+KJ2xFpUeGMIAr
 bZNwr36GZuyelWaPg8Xnz1wqoHEzPaS/5GuyBfw3ACaqTmzrJknWMymFDb0SXzpO3i57
 MySZb/+7LRnm3rGFwAnh6yt96Jl7bkzXCWKzbd+FTEfUoL2h2qETnSxqYpdlVjOZ/gJr
 vmaclm4ngtML9t4r6c3jF6ir1opwrDp5vWWG/r07QQ6+RzdY4wKLYC6PLgVmkH9jvxmj
 IY9g==
X-Gm-Message-State: AOJu0YzvGNmADb+T6fTNdOT+PanVFY4hwt5rgw0k4r3zSQ+7iAUOkfAE
 Ktm3+nuHLD7jc6MO6LtnmsytzJrvHb9S3GiDRLJZhva85XvlDtmVYwIBzpRQYNC4rsxrSilbwOs
 s4hnX8HOmLIFzSis3qGf1Q4OHw0wfB7ZwcELrt79UpumMR2XBEqpY
X-Gm-Gg: ASbGncvfGgZhlBfYgu7C4TE8FqSnlBZ3h45d6RmWppYugnCg9mkBZgPTbslkDVpOqiT
 NUcWExF3NByO9s+SxWts/B+qXFyil+0mlhnOPG6fAQiJ16HRRJ3CpIsP7IQsr+WdndfXtC5g1BQ
 LD3TCbZlZyKGyIFZKND5jwvNnartZ4x3+QQXO2KqPETq6g
X-Google-Smtp-Source: AGHT+IExFyd+etMtP9rxJXZXkNiJiur1qw1y1iJOuyHlsv4bQ1NFUtMYTP80lbG7rsB/e9N6S95GoEd+z8Nf9BhW8xs=
X-Received: by 2002:a05:690c:b90:b0:714:583:6d05 with SMTP id
 00721157ae682-7164d525662mr87271757b3.32.1751546738286; Thu, 03 Jul 2025
 05:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-93-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-93-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 13:45:27 +0100
X-Gm-Features: Ac12FXwVHmd_e5dx9NMu0qyzSvuR4RmrHw72xD9iaSWMhpMPXz52R8z130dj58I
Message-ID: <CAFEAcA_PHOjoqhUjDZ-V+MYp4bDXm5inuq3MDXRWA+mxMNgjCA@mail.gmail.com>
Subject: Re: [PATCH v3 92/97] target/arm: Support FPCR.AH in SME FMOPS, BFMOPS
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Wed, 2 Jul 2025 at 13:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> For non-widening, we can use float_muladd_negate_product,
> For widening, which uses dot-product, we need to handle
> the negation explicitly.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

