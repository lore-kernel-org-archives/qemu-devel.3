Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C16CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ4eQ-0004HB-Hy; Thu, 21 May 2026 10:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ4eE-00047L-Ur
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:45:20 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ4e9-0003Xd-4Z
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:45:15 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-65eb1b25c77so742342d50.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 07:45:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779374712; cv=none;
 d=google.com; s=arc-20240605;
 b=ezzgw9Lp/hU5m28/D0UQ60BUBb2pw6U4n4MnBaPRp5ocglHHpHudNUFGrijWw7LrZ4
 QNYJTqZwLBYu6Kaj39ob1BVRwatHbpyjqwAI4uEp+SYObWkReA9oOgwaWMPiUXr1dSiA
 dRl/DWkqhpm8F7FDY7MJ/RO9Oe0kZlgPTuLZi0+h0NO/RNhaMR/Q8ETSesaf+XkyVwPZ
 aJjsMX1hSU/DlGQoi+amtWgSnF2EwTZJ/fad+p7KkIrGjkiup48VXy0Psry0RD1az7En
 XGKKGujfZb0Kf6n+4j51mnHvtwR2VWahctyWxc8IJ3urib0XLBfdtCBfKdoHIBFCoOxY
 o04w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=v2ExbkSicBtuqdhUXIVrle7UIPWK29wVusskBwUtfyw=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=E3f9/Rhdh6+je2Vg9HVMf8y1/7CUTz64bYyJhbLuWL5AOzED8MSmhvon2DeZ7FJcjK
 8jr3+0pMAS6bhRIGQ5FDRBA4XWO6mCrF54WWmNF/5X/xm4ELkK5+frUqe9m+JPyQEssF
 o0PxQfp/dhPsMwlpc3U90KLBcYi1iI4bedpDb9gJj1iNNVn1HyjVy/5s0O9BMmH70U31
 Pv7V9oH0IBQpkRzdbi9dlwnVqZg7LGjgk66bNhCZTdEnQ9O3T1yyVHy25drlKVhbqUYj
 yajK8Ig0oLSM5beDp0FtDUYn8j3oN7xCbpDG86rfp5KXBWjbjymNzHVLoEgXrqPDUWXy
 syQA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779374712; x=1779979512; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v2ExbkSicBtuqdhUXIVrle7UIPWK29wVusskBwUtfyw=;
 b=l4XMn9oYGUvdEqh1BSMXnOIxRwMT78T+XJp6GgITgIGhRS444w338kWu5Et3z/DOL5
 83eu8+2esI9PcFX/gcJtClnvnBp/9BusUw4HQ2kchLBlOhVjzQ+Vb+8Pyj7Qhrw9qcXF
 NOin7P4wVNxsnR4tIxg65goHgkYlcIfopO0D3eKsxAGUV4F+GbceIRdnDRr26om23fOs
 dGwaKdk9EWp92qFRzet41Vszm6/qade3G11R5y0ZKTuDjDNf3sNp+OzqoVNhdt9unTfi
 JcdVRQ9+Y/kW6tjd3WSBj+8iuF7RTzB6XXcQnt6UPEjVZL7OgZyUvLZjEc6Y+sisi5Lv
 Lw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779374712; x=1779979512;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v2ExbkSicBtuqdhUXIVrle7UIPWK29wVusskBwUtfyw=;
 b=d0a4brM+conPvJ4fwh7oqx9PZdE3kYcr1z5mGAizariigCU8XndEwDbfx7aXuQ34Bt
 grqOUT06BtBtLc62182Vkiap6whnVjnL/2OVb81rSyL9XRv3HXC6NTG0cmkIkg7ALLaB
 kQzbyVKLlu6X2IUwuKql+TgMuAwRhz6kwAeKIZtN3gFTZ4Dyss5MNdVIgnDlL90EuZQB
 r18VQXnN/3OEbeOp50jiF1c1dORMXQilCd733d1baiLqk1xNs3MznjpQ12K59/Vkzll5
 QOtzE4ijZWJHUu9ymyV0JLGi+rF320M7q5bVOSF6Og0M0gMaoUl6pBMHd6Y1tKoicHR8
 pV9w==
X-Gm-Message-State: AOJu0YxQYZyg9l6zah/Gx6xc2JvkVcfnzFpQB+Ss0hXwa5+H8a+TFxqe
 ZiYHZpph/CmdS/emn5gjY2srkfPi5Uit7X3EMd1QvosagNvMZ1rO1ndfp0c9I+eTi8e8yPcVuWH
 +CjM3j+nP4byCNax2HcqZurzZD/9daJXi+N4BHJhzfA==
X-Gm-Gg: Acq92OHJwIkDqLcLh8fxjVOUpErEBS2uxzshyQv7pY3PQXTa7FmUU78MuZAYFEedgFS
 wQdGpai9F1bCyp1v6Nimogh2TWWbVqDpi0auAH/9OnR3CsziDRF46XAYTywWD/Tc9AmdfCyBbYZ
 jwWszuE9c7wprkzErXWXWcBymJCQ2SPoGwbL8XzMNn5PPFwFNSL1fBMI49p1/lvLUR5VcgXS7+J
 8seEUwZBTer1/CuLA561nCZ1XM37lKpXIO5WpoMTJ0frHqa61XEhBEEMLU51yqltbnEFthDRAzz
 mV3YqMslBQBwMD6PEMkJJwsvZKfpqlxM1YkEU2oFLO15w/gkXvCa0Hf5UcBbue1xNzxvNfnauVj
 SFw==
X-Received: by 2002:a05:690e:438b:b0:65d:6eed:4a4e with SMTP id
 956f58d0204a3-65eadfb3316mr2039260d50.24.1779374711957; Thu, 21 May 2026
 07:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-19-richard.henderson@linaro.org>
In-Reply-To: <20260520182213.872945-19-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 15:44:59 +0100
X-Gm-Features: AVHnY4Ily2boV1VfbNDsL753poka48T1W1TMtqui3P_uWmu-5_tPQ2ufQKQ__b0
Message-ID: <CAFEAcA9bWxsbAUg1M3q4UC86Ar49DMAhnv_TJcXAt9f6oP5vJA@mail.gmail.com>
Subject: Re: [PATCH v6 18/64] target/arm: Add isar_feature_aa64_f8cvt
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Wed, 20 May 2026 at 19:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

