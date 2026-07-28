Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65430C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojju-0005SP-Vp; Tue, 28 Jul 2026 11:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wojjt-0005Ri-83
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:29:05 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wojjr-00010u-S2
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:29:05 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c1c4c7ddaf6so585131966b.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:29:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785252542; cv=none;
 d=google.com; s=arc-20260327;
 b=l8NRq8R3WviqhdrTCU515vZ44Mjy8YjfAMFrnHWJqYqoYdhfyaoALZu7aN911vw5l1
 gQ8LzZ2k7rW8HVr2RuhTpyTg4wVZYcjHCYGu/wz4KTy9Hifix2pYJj9YwMi4atnPS/IA
 wpj4vCa5CUBR0SCep6uTbcIhmUTiLgkrEiw5SK5X274XKBXAETlq8Ss1g2YUzdH25tHn
 wjqlzFr/JAMkSugeuWQE+zsTVo/djy/QXQKSuQ6Qrp4gDGhpiWosgcFZkckHvq+a3R1e
 /aaFs+HJ+gk7uNKkDfOJ3eZVPt6OcWtNqlpFA2N5h/0pgN+HLUn1qXoe924VGp3n1+ea
 jwLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=44BEQ7ipJxjHOGbfQY/OqdTpMqmmzEr1C3BK7hck/io=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=n8PW/w2oJFAaAmsrk9xpb+PItuEAr3qOKOidG124DDLRWn8Cx2fSzS9fA2VEst0pCr
 8Tlnvtt80kkikayGp0jSRWenAjUN2XN5ttQpqgwBRFqRAKQ05TOv8rL+x4ggBfdZPw61
 9xRNa/wMxRYJwb92CE4lVoXe6d803VPOdA1yRlSbkaFZxt7zUs2hoaZL2Y6G6ovKE9Y4
 e0e/WcgxXqsu1G3jgolauYJsGKzVe2LB22PBzfcP/pMFmopZbQXNDg30X0SkjeAqKgm8
 BDepN0I3GABFJyQlAh3RLk+oETmJeX4TYWDMsYPnaK8KOimu8sRLzU/iGKoxxpm/ES2k
 935g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785252542; x=1785857342; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=44BEQ7ipJxjHOGbfQY/OqdTpMqmmzEr1C3BK7hck/io=;
 b=e/31b9Xs3OW8rclszzCCYG+cR8OxNelhpcpnLoHC771+OPaZ5erHD5ZfFMni0ZsyiD
 IXwm/RKHfjW57oxiqc5SrZr0ncZ8DJMDtiZyITlDL+y76/5jpR4cDHszqRdjJF65R7J9
 rEcWR0BPY9xcfCgXMkHzVpbC5eW5ar+CtKovqviLuXVEjZ/yv9Nw8e1QoreagnIpb1ag
 rnjKN6N3ZJP702zyxg2IlG9uSWmk/GFl5PeX+6g4N/ZQvvaQsDGecf50caysy4TG+3bz
 MK3Knw/VeQKDLba+ML4IGwRynFprqLupWgnnzEKSbSHETHGu4cDRc4LcNuCQNsoQfi+2
 +Lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785252542; x=1785857342;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=44BEQ7ipJxjHOGbfQY/OqdTpMqmmzEr1C3BK7hck/io=;
 b=sTZp4KxpPmFilJZXs44Ni+wDteZykUo9A2GA4190HOIGnK7eeJ4fKBlsO4Rcqlxh5n
 5ossqkCHdlnLF2N4n4Hok+JKp1vTRe0iRH0ULRl/IwVxA2RfQ06T3RALLcOeH5j6QYIx
 jYPSH0ss2/QgL2sIOgT9371s7NfRVmQ09EnUe28T3R9Gf3HZY29siPuhPCYId11ditVX
 Qel/HcgJdSjI46yLym5fEwm4/AUbx8+5BpxZh3YXjjx8g8SxZAmWSgYopDenbIIkCwH+
 v3xyeGdoZIE+1WD7fs9TfqQ0IcRFODdFtia7AY/Nq3PE2RBZQjT7DMVWCzeFQOdSaG2s
 ToYQ==
X-Gm-Message-State: AOJu0YyQdMujOY1PuzgZVYRTq/dBp96dN7tNqEnAgSBVOx4i1v99dv5s
 xet9jpQi6PauKSoiMhZPJ1ilmUi2FnSeT+Ou/iZWkWlX1S+VkSpZzpgHtwE4fSxrLOB+IHOw40G
 UyNDdrIPLQurZzVX+EGgtWHZ5EbT8QMT7FPZFbxY5Pg==
X-Gm-Gg: AR+sD13wU4SOTSIPzTBoIaD98SWZXTfg5FYI279ycvBY3/OyPxGpvOKrWz7NtUgTzAw
 FK/lvNbMImcdLSVRJDNV8WKfZY8DVsfhQ08SUNLPJYmGKtc/7cAVltS6x9oqbraFxbYX8Uwoa1r
 tINljAg/oqX9kjZ/dFSAHosL2WLEV9GpxgUWaC3F/oKsnXKuuin0d8plFdufE5zmzcqzZ+QApm+
 DRxewNIlQs0D6Q77HKoqmqz89DMbwZ8xVlSRvOtuRFvfRLXZ93khzxJqjHsJlAAqfbisqYtR4h6
 h94L9WFlESe8M/Zvyuqmukg9/vTSl6uLlqPWZRyJdazeFg==
X-Received: by 2002:a17:907:fd18:b0:c1c:2c92:fd60 with SMTP id
 a640c23a62f3a-c1f71e94502mr179646866b.13.1785252542179; Tue, 28 Jul 2026
 08:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260721184656.530230-1-richard.henderson@linaro.org>
 <20260721184656.530230-8-richard.henderson@linaro.org>
In-Reply-To: <20260721184656.530230-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 16:28:49 +0100
X-Gm-Features: AUfX_mwqegspqfC0MnZ8C_mgl9t3rCadnNzjnr-kdN0k6wzK0kD88cpAPcy_-Mg
Message-ID: <CAFEAcA9VWXPC11P3qKHstXOwKXEZf-hvPu7nyxyY78Z5AAyCag@mail.gmail.com>
Subject: Re: [PATCH 07/20] target/arm: Implement SME BFSCALE
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62a.google.com
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

On Tue, 21 Jul 2026 at 19:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h        |  5 +++++
>  target/arm/tcg/helper-a64-defs.h |  1 +
>  target/arm/tcg/translate-sme.c   |  4 ++++
>  target/arm/tcg/vec_helper64.c    |  1 +
>  target/arm/tcg/sme.decode        | 20 ++++++++++++++++----
>  5 files changed, 27 insertions(+), 4 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

