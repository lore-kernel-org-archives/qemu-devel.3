Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD198CEF17C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 14:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syB6b-0002EN-LD; Tue, 08 Oct 2024 10:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syB6Y-0002Dj-Fa
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:22:26 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syB6U-0000Zn-ID
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:22:25 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2fad100dd9fso81509941fa.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 07:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728397340; x=1729002140; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+BvfchHhPQ7gPGGaaZHCBCIR40F9CMJ0dK6KyV3qWO4=;
 b=yDhlOeQG/We7XM+eeRXJjf8JnQpcu6ISHH/rAbcrgPnH+SOZrF6waEbOnfefTJ1tn3
 Lqf/nuI8/RR6mXX8DQzPLcLyi56LJaY8AvpmqpyQJ8d+S7NdIz/BPlakpFVq9Iriab76
 xcBtZvhizZlwj1j4DXs9XpCaKP8jT2mRc+OAtCymSmh/4Pl4BfVDlmll6doZzdkOyQr2
 Ym6xEyp6gyTlN73PP6O/1rdpkegDB9bgoO5OdkvybK7rHNRiTSKUVsTT1syOdSc9j01E
 UmTRhZqIMBWXASczzlWVo32CkJD+KjcDYI3gduJrpA3sBnSb0WfaCY9O4TQLsqg7BDw3
 PIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728397340; x=1729002140;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+BvfchHhPQ7gPGGaaZHCBCIR40F9CMJ0dK6KyV3qWO4=;
 b=VjyeR26xouQUe3cIrRh9CT3d3ICo+Aze5lfbB2Gf7oK28tybCBRWQ9n7cP5D2LqRzU
 mKrX+iH4ntbGnfSYvejnjwTu8IjRSRGf0jdlYrpTIL2zb0QRjQWWEq15ElIdxC6Yc+3G
 a1aRlDmYyDim/wH6ctefhxA92u5M06OmMhhoRUswGl9/BUcRftJ8n0HZ70LP/JLWPdYK
 6olulUtJAssa2aHd0GCgbwKTaCoY9xeZtRlNuF8WE7Uj3VK4f0/x3t1KzbaSLIgIqKJ+
 LsOmDHucK6FMt7ygYQjy+okTfxI775EORsbZNNvCu/OT4wIh4poKN4pTBTAO13a0i6Kp
 zN+A==
X-Gm-Message-State: AOJu0YxfgUaa9ox9OTnHAEvs6v5S16fpEWKC7lt8SEZFRRXTWO9Fuq9B
 uv7e3237C8n/X0zLOMD7UFthjZiOqYChZtDyBOOql7MhC5VKc24+QxZkUsCp44Tq8+BzLIGrAPu
 AcLskcsiUjGiay04OMUYRaLPYqkwXnx+RhSiyjA==
X-Google-Smtp-Source: AGHT+IFmXQafHCHVn3GzWhEybdP/4UqbZi2jbsBme2sr67s7c+XRVtVA7FWeMDnget/zTThstcHM7ovYa1KlfEOyvNs=
X-Received: by 2002:a2e:bc0c:0:b0:2fa:d4ef:f234 with SMTP id
 38308e7fff4ca-2faf3c0c07amr109766201fa.1.1728397339598; Tue, 08 Oct 2024
 07:22:19 -0700 (PDT)
MIME-Version: 1.0
References: <20241005200600.493604-1-richard.henderson@linaro.org>
 <20241005200600.493604-20-richard.henderson@linaro.org>
In-Reply-To: <20241005200600.493604-20-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Oct 2024 15:22:08 +0100
Message-ID: <CAFEAcA9ATUA5Y-Pz1tqaPoNrSbpqL_+Ag6YB=gN3xQzKhpH1TQ@mail.gmail.com>
Subject: Re: [PATCH v2 19/21] target/arm: Move device detection earlier in
 get_phys_addr_lpae
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@kernel.org, alex.bennee@linaro.org, 
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
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

On Sat, 5 Oct 2024 at 21:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Determine cache attributes, and thence Device vs Normal memory,
> earlier in the function.  We have an existing regime_is_stage2
> if block into which this can be slotted.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/ptw.c | 49 ++++++++++++++++++++++++------------------------
>  1 file changed, 25 insertions(+), 24 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

