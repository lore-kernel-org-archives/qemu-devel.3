Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459FBC5DF67
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 14:53:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvFl9-00082u-90; Sat, 15 Aug 2026 10:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvFl6-00082S-Au
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 10:53:16 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvFl4-0007FV-BB
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 10:53:16 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-836c8bdac50so27713877b3.0
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 07:53:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786805593; cv=none;
 d=google.com; s=arc-20260327;
 b=G3300vz3BTrXZ8K1o2uLfci86qjwuDozvulmRm+7iI7amFjJq60SK3wz0oyic7Jkx9
 F+/AxlAbmnxvwvQxTM6JewajuYbSHkV2A+Rj/gF4JbtOQe0JQfyKeu8/nn08vnDDyP1w
 82GnzhfsvWGHKTRU0HX/XnQSuHdq6CkTgLetUO5xjzoJQ8jUWYH3kYoK4Ul+7cYDS6oz
 oi6/4+S3alx46M0M0YJOdZEghYhKOdUW+2XiOR4u62zSOrYPPTKn0BtYEe7PnaB665xy
 +AwTZigyk5YliYGCcnIpNoq2hR3Xw5ubaZJ9H1nBGS8ILzxO35fb4pzOTohwXMd4u+0E
 CITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gbwFturU1lhddObbcEkxPnxbVvNHsQRAHmkziIayWcc=;
 fh=vE9mroPCwojMeyL7Rki+gZ+2836oHAtez0oUCr4h0qc=;
 b=JTDYbBJYCRikbmZ9ObNmhaqND8lHjhFsrwtYvakm/jKYSEu4W96g4/4anQkvBY56Qs
 fzJVyjRGdEQahniwSoq8aareUDtwqFgGSlSIeNxpt1fcz7XRmxpY7uAbC3IeIeAdHfKW
 9Iyft5LK6G/mqc/SdmyQK/x64rWNmyicY835bYP1UrHzZ3+z7HN8eETAxSz5RhcwGsDN
 3gUK6NFR+DcgxLdaDZ4hZZY45O6iHpOso1rK75ErkTKv+xGNa5EzWr/BjmH2/vEyHDPI
 H9jWAUSstITtQXGOkAtrrpLcVguqNZyK1xYVlLQfOZu0jdgkHSDZIAjb29JMqIU+ltrC
 PfcQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786805593; x=1787410393; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gbwFturU1lhddObbcEkxPnxbVvNHsQRAHmkziIayWcc=;
 b=HWx7Ad2qEwVDlMlX1g5mH01DtCU7YMHOyQ3ouC6L5CXk+JTBlN/yEmtgNBlgS3OrzU
 y8sapCV2d4FZZp6l3h6QqHFr5/rDVp0NItiy6qsAwYQrlYe/aJxWG7fUp7heBNQSKK3O
 O7kChxnXQvzf+qoygso4lznBDipm8zhY0VjJlLPOwfBl8d/0kfa64kc2chVH7UQETYfR
 LDVNzEtyCwls5Ql2xbxEl4kVP4HW1BFxMQTQ7JDmWuHq9hTTAAKRVEVrc7C2HDwlJLlh
 2KzK7zNsY8ZpGIlVjuKUrHYeL2wbfl3KkxpLzN8lLuuvBlDgWrS1gAz39aN0DOlaMbu9
 fIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786805593; x=1787410393;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gbwFturU1lhddObbcEkxPnxbVvNHsQRAHmkziIayWcc=;
 b=KCiOw6oa0fQz44eoPPvkawpe8B5Eq6Xd/N3hr56A4w5oVzp+0Mw0RgBpaLxQbw/OtY
 Rcfl38mfmY6np28Mik5YHZvu4Zl+VAZ8K3WQaNPDKne5doZ9lxokKovkypIw3UFFDJcK
 j8q6uacxqEWvPTheP5Gc/dolOWor29Kh+uq2JgO6YzXYF0s+xqQcIvCL4UCaUomomj8P
 lmHAWFo4RuG1V3JIyRYGN969ah0h7fA2Um5RCYrTwkbJte6JXvAt2JMbySUtGY02JVHS
 Dgu2aGlZ99ejG38BwKPhnjVJB+399u4zH5TkdS8PS+dHPwNomjQqOx7TMBUAVsNAU/Gv
 8E4A==
X-Gm-Message-State: AOJu0YwzaM0wmCGmH9uG87WaetW8PJs9xMCO2pSdhQ0wtcR2SEiSrM6Y
 Mj6vZsA9kjMt1OMudvljmrSytPupHpWWL9ZuxgQ1tD5QAS5SHuOmkHfWQQUKMtcLKVCMaXDtAMF
 PhrlcIaz8Z082Xouhpv5IbWWMXqLOh9qeiV1fN1E1tUx8RiNI6gOzJVM=
X-Gm-Gg: AR+sD10ExOlq1hv1RH1X3Sa3E4LaStcxRARYDG27t/ObcroxXjd7w7lYDFgCr8lF1H8
 039wUXAwDumeH7YJap8ax+pJCBehuihdP65bre3D2txvTLWtgdmIiTbtLgOFGBHg3omd3TCZJxi
 q6Y1GiLX8Mbw4MHhaWUESscYSRopLyJWr6W9oiSsxSqgEMzB0SfBL4NYpd6yT9hgnJsDLgbXwFc
 gPPZC9TGExSYx543DQvq5bNrf/hONULMqrw5BFTpLgg4D8tXS7rX/BZvr3hDm5foWNsprIljcPs
 DnGGIOI/4bmgqdUttjgiHhVmyZspkaBpY2U46fixKHy4tp4XO6ruXR8MSqPKwNvbA4q5lLb47BM
 IlXMnCinvjEDXKHTPynXaIgDZmfYj
X-Received: by 2002:a05:690c:4349:b0:81f:d515:8c06 with SMTP id
 00721157ae682-83713568937mr41110177b3.29.1786805593033; Sat, 15 Aug 2026
 07:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260812220816.94034-1-philmd@oss.qualcomm.com>
In-Reply-To: <20260812220816.94034-1-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 15 Aug 2026 15:53:00 +0100
X-Gm-Features: AcwNN1UXX2k8-hO23AI6Waxf82nkb0U5ItY48GiqAwTTdb6YF5gzr1WWLBydB7Y
Message-ID: <CAFEAcA-NUOtTPuvxKja+bNU6wy6EQFVMfX9nmQ_LbtAPKHqMXA@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/arm_gicv3: Have GIC kconfig select GICv3 for HVF
 and WHPX
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Wed, 12 Aug 2026 at 23:08, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> While trying to fix the GICv3 dependency on KVM and WHPX in
> commit 39a8c3941eb, we missed the Kconfig ARM_GIC symbol only
> selects GICv3 for TCG, not HVF and WHPX. Fix that.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 39a8c3941eb ("hw/intc/arm_gicv3: Fix ARM_GICV3 dependency for KVM =
/ WHPX")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  hw/intc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
> index 097de4efc5d..05e697967d0 100644
> --- a/hw/intc/Kconfig
> +++ b/hw/intc/Kconfig
> @@ -26,7 +26,7 @@ config APIC
>
>  config ARM_GIC
>      bool
> -    select ARM_GICV3 if TCG
> +    select ARM_GICV3 if TCG || HVF || WHPX
>      select ARM_GIC_KVM if KVM
>      select MSI_NONBROKEN

Is this instead of RTH's patch "hw/intc: Fix arm kvm gicv3 selection",
or do we need both?

thanks
-- PMM

