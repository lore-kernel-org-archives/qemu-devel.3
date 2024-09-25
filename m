Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40B5C369CC
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 11:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stPpZ-0003Cm-DR; Wed, 25 Sep 2024 07:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1stPpS-00038X-Sq
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:05:07 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1stPpR-00024G-1L
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:05:06 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5356ab89665so7885975e87.1
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 04:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727262302; x=1727867102; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XD7RRfHaxQ6/w3m7YDB0Ut+qX/tB8DtOzSqGUUCudAU=;
 b=rouTciOmxEg7pZpm8W4ShGZcdLfifK03ZsGjK/iNLaVAEyvMbaUayBtSvi9tP5qgjF
 XrEOxtCH9zFBwzxyH9UpLLAzpLH3/+t0sAct349aEfXzclAfwQctXzVAimxXp9ethKoW
 0d5/OBVwmCJWW2O7s9AGB6K/Ssc3IrK8wZDHKGoZlnt5cblrcY0RQAxJz6sT+/gzE838
 gfGX3o/kuIegrhdVtrWjVAIia9ONcYxjx7FKkb0mAU6v1GTXiv5WBy818BnFvSDTueTT
 EOKL4uzzvyDxbkf9KHMNDTvtYfvEvDXhXRTzhr+7UzXoDCdyRFgq02ukBZyvvEIrt4Ue
 Dqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727262302; x=1727867102;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XD7RRfHaxQ6/w3m7YDB0Ut+qX/tB8DtOzSqGUUCudAU=;
 b=hB+A6Dcnp/riq/KNtufCdCIlYQp/p0E0D41NjC7uyUud4SxySC53W69XpWX+z+1Bu+
 moLnCb4nHXUDPLYoKfxVlVvPI6xRW3MrO94rMnNq5mwwFrn8nBbrGtITBoSWW7bSFIvW
 5sqiR8iP/JX+wWoLKXlWHJWKd2ajfovu94eaIk5m9Xy7ycyqzRmnebskE4qfnp4HO/yX
 uvVjBPEvAa16eYbzZ9eajKxw9sh62GNZAogXIefYq2veKc8ZJ47KEocs9lEzBxsqMfpH
 ewVWR3k/2FAoT4fj1FoOKnZGN5WMqWZNdymVL1tDtbrREx5sBeHjDxfzyUSXOvKsE/fE
 Ee2Q==
X-Gm-Message-State: AOJu0YxOxxWZFurCxVD7meo8gDzC7aI/y18iSxbRu06VbrNtcY7g3kXS
 7VWZphLsTZjWRzlW1nsmJBOJi+VFJYNczLeX8FhxuPC7abugELfA2Oc4f/jJteQZ8vJ9yEx6loE
 aM0LSOdrrYUhUGbKWq9x4y9z9RtLfcvC+Xw39nQ==
X-Google-Smtp-Source: AGHT+IFM5/tFY7M+ylOTIShQ/r++jC8Wk0gzdtCffm/qYnBqzngRQrDBsWz/EbAnxyg8XvUtNDUAvRlgLPmMtoxdOts=
X-Received: by 2002:a05:6512:3e1b:b0:536:52c4:d7d3 with SMTP id
 2adb3069b0e04-5387048abcemr1110828e87.9.1727262301950; Wed, 25 Sep 2024
 04:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240924191932.49386-1-philmd@linaro.org>
In-Reply-To: <20240924191932.49386-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Sep 2024 12:04:50 +0100
Message-ID: <CAFEAcA-X+BUGcq0EGOC05DWqjNd+WSs_Ufqv8=gpRfF0uAmUYg@mail.gmail.com>
Subject: Re: [RFC PATCH] hw/arm/armv7m: Expose and access System Control Space
 as little endian
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Tony Nguyen <tony.nguyen@bt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Tue, 24 Sept 2024 at 20:19, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.o=
rg> wrote:
>
> Per the Armv7-M Architecture Reference Manual (ARM DDI 0403E):
>
>   The System Control Space (SCS, address range 0xE000E000 to
>   0xE000EFFF) is a memory-mapped 4KB address space that provides
>   32-bit registers for configuration, status reporting and control.
>   All accesses to the SCS are little endian.
>
> Expose the region as a little-endian one and force dispatched
> accesses to also be in little endianness.
>
> Fixes: d5d680cacc ("memory: Access MemoryRegion with endianness")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

What's the rationale for this change? All Arm system emulator
builds are TARGET_LITTLE_ENDIAN, so MO_TE and MO_LE have
identical behaviour, as do DEVICE_LITTLE_ENDIAN and
DEVICE_TARGET_ENDIAN.

thanks
-- PMM

