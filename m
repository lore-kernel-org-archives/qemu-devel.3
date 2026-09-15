Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F70FC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 13:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6T92-0006qp-9y; Tue, 15 Sep 2026 09:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6T8w-0006n3-CX
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 09:24:17 -0400
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6T8u-0001Sm-Bf
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 09:24:13 -0400
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-6713d20d375so2762266d50.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 06:24:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789478650; cv=none;
 d=google.com; s=arc-20260327;
 b=opjFnpBjdn+mWY9VHsnUc+KAD3eLAQChS8G0I0QKc4SZ5raDsxIFKGPXiHsKiRZns1
 UlBYC8mfu/sxKwop7WeS+QBYFg2gMdsrMk9Tnk2UE4Aa9TmSdMPuS3fscg7mH76zgtDD
 DRorcuX1Vb4wnzrd9YbAId8qCqC+cSbX28aBd1W6oS1Hi3cIRN+cZsmSAlre8WDdeqAm
 s61O3HhrRIesRO8IFfcViT+bW6zmdW2lSzUr3iQgNlzg9KJcnSpXjq2y8ufLR1VGHq8g
 vZamZJ5N6GiCYYAP+AtznqDJuMvArN0Ue1SJHV11wMGUfCP10oZLt1HeygpXduaTsRpO
 2IVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=z+LYvIcju2WpXeok+AWw5FmBhtN3Wn+MgNOU4JqJKy0=;
 fh=fVPfpHMeJX2gxPKYTBQCzQO60hB2p26ro2vRuUEPsJ4=;
 b=XJ26WcjpIgLp6uoIfXG7JdgiCbd3RVdsCQ19KrHVaPoDGBzjXaXanGzZVepXG2QBiV
 //14ssM5NT10gqsX9q2O842RJqdVm2ZZ9Atggh4lNCOHNJRsJrDdw30oOEAcVsdQc5xe
 /OfH7nM1cDR4p7JssQFm6HiPSt21iVyQ4S4G+xpTSRJcaZXBzgNf+/sYEb+jTk0/9mIo
 rXTX5InydWIZMni4IbHAUn6rGWLPprPTWihPIm9N1Wx1NfkfyClWg+zkVPbvwATk03YD
 LLRs4NUimYu1sGrhyBpx807rDyhWoNCGh2dhaxWvDRKIEmySuaszIWblpfe0fY0L6wZ0
 ULqw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789478650; x=1790083450; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=z+LYvIcju2WpXeok+AWw5FmBhtN3Wn+MgNOU4JqJKy0=;
 b=zEVf/HgnOFz399Y2ZMZSGTOwOLmdFPRUnxHpMymWvX6uHaFsQkTaoQ3kfH3jE9n/l2
 cCGtHclgyFZh0fFQEPW2vsdA7pDI/rpO6UCzV2aERSlMwFtc8QBzdPS5Y3xL45Mo1p9T
 S020VKnUQWW2x1qeeTYtwEG8q9Ici29chLiXPPzDN2j8U+ko4RibiGBQhUCrpmMRdluH
 fqgsMVUl01lw4AIgBSkFTqFT26oTPXmy+f+PTuHk0Ri4AOhpMOyuX5bTzV7IlkDBk7gl
 FkxNbZVLFjYGB9P6LkIjG+UOfY1fWX4/AErYiEdZcyZroPukv7qVwMfOgcBM/e0MDpei
 vLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789478650; x=1790083450;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=z+LYvIcju2WpXeok+AWw5FmBhtN3Wn+MgNOU4JqJKy0=;
 b=YOyVKRwBKXXPpAf7a1L8LRW4uuQib/wEqytjIEIsU64XLTzzyRzJfW4cNDURltL5MI
 nUMpSv3zBAF9AaThNOi6in/mQblYb+x24QmH5K5Cv5npaaz5XRHDe1UkPQq695OnjKuA
 EA/fMCHBpqZ1GbLlcHZ0F1rBDvpzj+VpAORU3rzvQX+9/CMCOMs42tbCQWbi45WOjjje
 Pzq+Af1IRDDC2zzk7dnqn20OK96cJ8z85YXiGGjVlILHp9YywmiDJ2Odb6esTZQESA3e
 /AMUvUhct8vPGEbvxRXBZJvdg0EfGco6asO7IBghVt5pa1C6RY11UgtHv7x8SJnJcCA6
 jKbg==
X-Gm-Message-State: AFuF++ltxyoM1yjBTySsLCkk4dev6fk7GNy6eVfhlurswwVUdNGvHVk0
 XFKoqjAlImSKOsynCKWB+BigPXLy+5NNNMIAPudDgVw+U+iuKlLTC2CvIef5Tzzq8wOJ5zyBN/Y
 te+2Ucewf0MwNXMiieVfXUEfQGRXs+JA1yOo15Jd8YjyShZzQbsLbvEM=
X-Gm-Gg: AYBFou06oFajbDDLydPQ0xotCk6eHKPr7xPfZMGOQuGHcNDQkixw24OQyPtSKJ0Rk/V
 GxJ8JS+6lE4jS3t7M15yVxsn1P1GqzMwXLG9ilcApMnwlxUj4pzq0x0uyKM3JIvleXaK7ii7BV5
 NiF28s68w+4MXjF4kbEp3ta/FmRAUODDFQokPRW480FMeB2i1o3hXJ+ngopE+5OE6xT2VTKz/oP
 UYO5jACwD5Strd1LSpn9AZm/7Djsd6iGaOV6TT4mU9Ae6e0DEKp7zjsPve6r3h1fPAWSLYkudeK
 tvzYSSUlE7pQTnJ61iGfjrm4GGAMEZDAP6yqXdIRfRmIsfcrpdH4OVrnxnF5e35htfXnYUkKc00
 dVLQrwWlO8wqoDalo2ZY4AmmX342wDRm0eiwiKqxQ
X-Received: by 2002:a05:690e:d8d:b0:66e:6089:b3ab with SMTP id
 956f58d0204a3-6714e1c1506mr1875802d50.47.1789478650022; Tue, 15 Sep 2026
 06:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260914192323.29250-1-gilles.grimaud@univ-lille.fr>
 <20260914192323.29250-7-gilles.grimaud@univ-lille.fr>
In-Reply-To: <20260914192323.29250-7-gilles.grimaud@univ-lille.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Sep 2026 14:23:57 +0100
X-Gm-Features: AcwNN1XZmMCEGv5Nnl5PnCWDKWB3SBOqaf67rRMjKBYTK1XNvjpMz7qO_L5hf9U
Message-ID: <CAFEAcA_33b2zu_JEdQvyPyRS8+wikhz7aKAbFA0C8j348gMBdw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 6/6] target/arm: extend PMSAv7 support to v6-M CPUs
To: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::11;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Mon, 14 Sept 2026 at 20:29, Gilles Grimaud
<gilles.grimaud@univ-lille.fr> wrote:
>
> QEMU conditions PMSAv7 storage, reset, allocation, the pmsav7-dregion property,
> migration and address translation on ARM_FEATURE_V7, which prevents the Armv6-M
> MPU from being used. The checks are widened to also accept ARM_FEATURE_M while
> preserving the PMSAv8 path for v8-M CPUs (PMSAv8 is tested first and the
> migration vmstate excludes v8-M with !ARM_FEATURE_V8). This lets a Cortex-M0+
> declare and use its MPU regions without setting ARM_FEATURE_V7, while v8-M CPUs
> continue to use PMSAv8 storage and migration.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

