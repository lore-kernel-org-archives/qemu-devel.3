Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80C4CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENFp-0000wl-9Y; Wed, 07 Oct 2026 04:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xEJDI-0003IF-61
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:25:17 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xEJDD-0000fm-Gi
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:25:06 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-88bc25fcd0eso2974711b3a.2
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 21:25:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791347101; cv=none;
 d=google.com; s=arc-20260327;
 b=Id1AT4yj/VGNuUV1fsAYppJl+47xrHE+9z8QoCPQtYw6ada0In+9oC0QkDX3/NCqSd
 Lc+xpJt0Dn4uDLisDxzeKO+wNy8s2djNxSFv+g4rwb5IKk4ehsv87GWHFBdBeS8GMjFf
 y2i2ndC0NPlAD5Z/1TIHE+XcNs4QREE/ShGFvtOW25ktKcOSNef7MuGGcUBFOtGlFVNd
 MaynHmLGDpAduRkT4CuG391biddzvQrFZag3JqlNuL55KI4JHzeKut+0He/2v+9tHctS
 I0EdJaK8e8hrmElm7f1PrJJ5NlcmnnCeUd0TgvehRAKpqmSo7FYVpeMFyVvoOjRRCLme
 /PBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rA6d3LHupZheAqdSUzkSD64WVV+9ZI/EreB9XaQHC/A=;
 fh=yezQdXMrdWVAkuoITllCrNKDtPeRvDbT088ugBj5u5I=;
 b=RHiIPHI6ibxveypVNXVDc7e9PPz667oTsDAzHNsfCEVCSDDrecznPT+sKci7gJny7R
 aamlLk/l9btJOiJANtcyDo5I0hj4hs8T29MEgQcBhGzB4Lj3jsNIejj2U7MeZVZrfx9+
 9hPn/4LoDvYHi9pVAgBwzKmyCT7L1nm50WOiFA52VZ7GweFio7h54ACBtZzp9ZE2ltU/
 S9/XQ87MRnbTQLYB4/JHdiSpyZ3lD5FOmHZBBBI1ZRVF1aRTass9fMPuLqkbT0eAeZWy
 q11YRISHRlzqg+4c08zJh/rWTAy2u3O5bxK4y8kavkBOzRjthDO0+FAJzexqlq+lJDsE
 S0fQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791347101; x=1791951901; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rA6d3LHupZheAqdSUzkSD64WVV+9ZI/EreB9XaQHC/A=;
 b=Bcm1+zaE5NPBLv/ChRmYGdWMVUEM20LOkJnIwgOzI20vfY467SJA9j8HyhtQe0ZaDx
 51HdfhXBxcDVMFgWGYX2Z1opVeFcZWfVRr1ld/LmLr1rmM9xKUo/u0WNjQ0RiS0hCjMC
 QZkLB2qd5hLhe9wfJN2XREcmoGKYJdmlu+EdVwqaq8XLC3x+HfxCPWtHanLJaGyh1bxX
 r7NHhxi9X9D75RgrC7qRu/0p7jFPpxEwntY7QenLopb1kKTzn82e9Ghn0bMHFPLxSh+v
 rRB34vpS7SuEglpUBOxo81Ti3ztDz/iiT2hsHQVRWAbW+8aAJm04XOH3SZcZL122aeQo
 lizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791347101; x=1791951901;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rA6d3LHupZheAqdSUzkSD64WVV+9ZI/EreB9XaQHC/A=;
 b=CDFo8oGhUt2MkUxyAz4IvmKVlUVdqQx8+mnf9hIJqMqE13f2hIaZZrbmAqdCOtC3MP
 f2zsK4z8pfpwdJID3i1OPLHFIunnK9cXnqBm6Wcy8wOkhb9/qoMqq1k7553Ymu4Lk4+o
 pU7dam62SaGo4rKxBFmuLzboKTgSJWEgEhk3beKEidWx/HRyWCHnweHJWv1QzjNBoF6e
 nzpx30q0EjSYgim3+Wk53vdVsU6ToCAl4rrmc18O5Xn3MOhleC4McwRSkv6EEEYzRjig
 xQOS38pEO0EV5Sy9+FA0Xt2cMUx7XS1MdCEpDxRntqhKspN6eHJrmAXcvCZH/sC48JmY
 CAPw==
X-Gm-Message-State: AFuF++l5dONmvIKLlGWL1fp47abZwpVbtQjKTbdbCCkMezu+TIZOgVrL
 /xyQY+JAWyfUNaENJXBseUuDU8ZKBeOOJ3Ban6gQkbjXSRyoLQnNMmuTV/DauKy7I111GSeJfb9
 ofNYovamVxZpQ5xOBxVGMcfkqfC2loVgSNEUcPK1psqepbbrREBPVhSA=
X-Gm-Gg: AYBFou1IG4hucNl2zoJ3OErwXhfRsd5auCwZxjBYwdhdshzNvmgv/f3l6mNMXZb2ii4
 mCPnfFBuIifpua11Pakc6pPM4nPJb9DN21stuLmX5BFJeMPbfIWQjEYPZpOdNRgMnOphuJCoy+w
 DVcOIw/OOvzetAhZwQgbhciybW0NIpVNDPlAZrgM9SsQ7aMCw/2tAyV3QhLptHRbg/yThNpOJT/
 +Gozu2aD1LyxIx/x7xACqYBx+KQCvmb8mlPPmbvKdy4XcFPAhLRBCQ+E7fylM7QRZASquEZn4qW
 5LScf+zHJh3G+Eq4eJBdTmrBqrIsEC7b8yOsBms2qxn8TJg1uMhatumscPsDvfK1DkJKCtUddS2
 e5p9j6wMdo8wmNulkihhirCTe1Tl6Mxv+uAZfLqWJWa0r547hlg==
X-Received: by 2002:a05:690c:a4c2:b0:8a8:466a:72a with SMTP id
 00721157ae682-8ae95adcf20mr30134807b3.67.1791288519607; Tue, 06 Oct 2026
 05:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260923214453.45335-1-manuele.conti@archimede-energia.com>
 <20260923214453.45335-3-manuele.conti@archimede-energia.com>
In-Reply-To: <20260923214453.45335-3-manuele.conti@archimede-energia.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Oct 2026 13:08:28 +0100
X-Gm-Features: AclHuK-8UMHKAjJ5zTHc4ltC633LRsQFOwpjqDLQx6EXdJBO2C4fSFQuKJFbmpo
Message-ID: <CAFEAcA_i-iRvgWMdiLstnaosHANJE-OG_5oNZkhwqXHPgPT_qQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/misc/stm32_rcc: mirror oscillator ready and system
 clock status
To: Manuele Conti <manuele.conti@archimede-energia.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 23 Sept 2026 at 22:56, Manuele Conti
<manuele.conti@archimede-energia.com> wrote:
>
> RM0090 7.3.1/7.3.3: HSERDY follows HSEON, PLLRDY follows PLLON and
> SWS follows SW. Upstream stored raw values, so firmware polling for
> ready or checking SWS never saw the expected state.
>
> Mirror enable bits into ready bits on CR writes and SW into SWS on
> CFGR writes. Clock switching is instantaneous in QEMU. No oscillator
> startup or PLL lock delay is modelled.
>
> Add qtest writing HSEON/PLLON/SW and checking HSERDY/PLLRDY/SWS,
> including clearing again on HSEOFF/PLLOFF.
>
> Signed-off-by: Manuele Conti <manuele.conti@archimede-energia.com>
> ---
>  hw/misc/stm32_rcc.c              | 18 ++++++++++
>  tests/qtest/meson.build          |  3 +-
>  tests/qtest/stm32f405-rcc-test.c | 57 ++++++++++++++++++++++++++++++++
>  3 files changed, 77 insertions(+), 1 deletion(-)
>  create mode 100644 tests/qtest/stm32f405-rcc-test.c
>
> diff --git a/hw/misc/stm32_rcc.c b/hw/misc/stm32_rcc.c
> index 5cfb39e560..ba64a87bdd 100644
> --- a/hw/misc/stm32_rcc.c
> +++ b/hw/misc/stm32_rcc.c
> @@ -90,6 +90,24 @@ static void stm32_rcc_write(void *opaque, hwaddr addr,
>      }
>
>      switch (addr) {
> +    case STM32_RCC_CR:
> +        /*
> +         * Oscillators become ready immediately in QEMU.
> +         * Mirror enable bits into ready bits: HSEON->HSERDY,
> +         * PLLON->PLLRDY. See RM0090 7.3.1.
> +         */
> +        value = deposit32(value, 17, 1, extract32(value, 16, 1));
> +        value = deposit32(value, 25, 1, extract32(value, 24, 1));

The manual says that also bit 27 is the RDY flag for bit 26
(PLLI2SON) and bit 1 is the RDY flag for bit 0 (HSION).
I think we should make those also follow their ON bits
while we're here.

Otherwise this change looks good.

thanks
-- PMM

