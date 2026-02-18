Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC3CE9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 19:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsmwM-0003bn-Tv; Wed, 18 Feb 2026 14:10:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vsmwD-0003aR-2C
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 14:10:18 -0500
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vsmwB-0003vn-EB
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 14:10:16 -0500
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-649278a69c5so137901d50.3
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 11:10:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771441814; cv=none;
 d=google.com; s=arc-20240605;
 b=ZnC0JmfhxmuP9BrczCakCEKoy55I4Cl1TK1T5DchylS2RoHZZIamGnKpcDO/i1Hrc7
 ZWq8etv3zgjS2X7oLinEVtUh1zLeTrBPOoZeu4vtULM6pPre3j6+7taE1rY8km2WhYXn
 3bUc5pTY2xI39NkSRlNSPmRFVYKcuecPLvGd+QgAOuuiO1j0JcH93Vi2k45pgoqANnC3
 ATpohsGFNHq28cfVWbd2rD1I4y/8piMdJLdayuj74Dj4pHa0IPAuxcWgKM/OHSnV6Tai
 f/D0bgOgDn7UUYekIJ7hcbOZCg5guJFNYCESVuYUQIWsegP3wrG0lSdt/jF9m1xp9Ryp
 W+7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nXz63d/gKZN17DMQFYFZCoYm6USju4qIdzs9GEUlCW0=;
 fh=ljsPVrMqM9WEgWa5yaVojVHzX4ehGvtuqRUN4Y5D7gg=;
 b=WMXa6iE9vOfHwZbbLOiBDtHYoifJoVGYmH6lEDLvmb4QWav6MiS7P/dhEF4ez+wBU7
 UD0DkBBZ+OEwfwuqlaBREt3W37SqJqKlT4mzX/KUStQnQJlA7mH1VTMJ3ooImVSZjFgE
 BE5ow4dhBm60FrPxERjXTO3PJ6H4mBoyDLWEbbnldSO1KgrodSzWaipCkabwW3F06T6P
 vmwPRr6irPQ4Xsp475z6ylsZcdgq66n/oG/uL9fdTmiN7umnP6FHeAqZrOTm6C5JJfl0
 kywuTgiqcKMtYvv2AhXusYAeHH3GYRPZTPecIBQRlwFz+i4W1LOm+ecEErT/m59mWDDK
 PBeQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771441814; x=1772046614; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nXz63d/gKZN17DMQFYFZCoYm6USju4qIdzs9GEUlCW0=;
 b=ta7KJZYm/W5j7Yc2NCfNqIugh9EUUvN15kNIv/LW3nfHVUllWplSxPQp9F5XbDg/sH
 9Hm0lUngoKRO4me8NVDwNnEJnpShJ5+aHnRgvGfSQM/iEMfqGLiiyYohmJYkNarjLVlj
 lG+DLHesEBlzsBwKI3lNcX25AEZjLPZlkCm/VySvulWc6EP8XXFHuFFZKI/kqIBsuhhc
 ZsAVlhWm71iJdNRWEboCQUh2pVpPmRe0bzctoQ1wRmgDlWi1ukqsm8ZcY9b/hs2w44K3
 sWumEH9Q7r39/MT5EeKauMzZEovNAivkTTjjPas2S7l2PzA9fcnKWX1VsQqXSJdvLmGC
 rXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771441814; x=1772046614;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nXz63d/gKZN17DMQFYFZCoYm6USju4qIdzs9GEUlCW0=;
 b=uJgq+5TL7e5ZKvG8D8A6ltJrm2pOxsAn3JgivSOHJ04ZDa1vOd7fSI0mSJY1l6hH1d
 SRtKyiM/dqa0XnUBot5Hs5I2ryqijMVvbCUmrv/UaBjZmTT8Ey38UNa2pX4Ew1Cxy/kz
 3PqJrPfZNRI1BI7GHdy0aS4K2mMik0iTtTTmuIrxqii6qR3Dk38+fnAzSehMclZmBkwI
 mxJnK6d82agQwCfHuAU33jdf1ecnRm6Good0mvcRh07Wb23fhnPwL41f96WzoACYB7gM
 Y1P7lx1UHDk4OnKGXqBwOfkcRUAYl5pjUfg0jcmUR4rXtREly03zsTElm0/yfcm1pktL
 lNfQ==
X-Gm-Message-State: AOJu0Yx2KRpjEqhHNyFsh9RO10pgbube1Wwr1CH6JZ+dxICetMevIHEn
 583DvkHiPiLh4rN1G+eZYfhh+fF8j9OmeVINyVSs/y7orUo0U5nY0DMMs8UWe3EWmJiOTIUZWBO
 o7Tz2r+SlGgop22eIz1d0zH+z7Ro1coP13TA6BqJt/Q==
X-Gm-Gg: AZuq6aL4Z4lJAa6KtA0n0YQOfF0EsN35aggLk1PzRdxnfsAaZZGtB2FJtvz1kSY8awg
 H0G87tjJW0dJwlrguGWKYVtSOqp0gPBWE54xPAOSRVDoAL0aNpOyjWg6Mh3BA1yl26a+Wm49byn
 6Kvha3umVup+08VzHIafTHN2haciisWwJ8LN4sEErXZXz+ChVznzjhsn39irQpScjTOSRGRkk7q
 UFma28KrBgW4dRY/5SpvRMWZMixh/B1NjmemwhVn9m65fikSM3fLy0ABzQHNdXRS8RdRVwfdOsK
 nvArqTFI0LWa5xIZNZvEzJqmEe1DcQsTusnqjdO2gdwcLEgNxP6R5qt8GjJeILDsSio=
X-Received: by 2002:a05:690e:1515:b0:64a:d29c:e159 with SMTP id
 956f58d0204a3-64c14dceacfmr13865906d50.82.1771441814231; Wed, 18 Feb 2026
 11:10:14 -0800 (PST)
MIME-Version: 1.0
References: <20260206131438.1857182-1-imammedo@redhat.com>
In-Reply-To: <20260206131438.1857182-1-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Feb 2026 19:10:02 +0000
X-Gm-Features: AZwV_Qjxq9ubraA4U_y5tjXub_pbF0nmaBehX4vfQrLu9cly50eEJBcmtH413uk
Message-ID: <CAFEAcA-jtOBvOs2dJkrd2vwHFj54m2jPKK9fLSBLptAVNorhSA@mail.gmail.com>
Subject: Re: [PATCH 00/11] Introduce ACPI watchdog for Q35 and arm/virt boards
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com, 
 pbonzini@redhat.com, shannon.zhaosl@gmail.com, philmd@linaro.org, 
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Fri, 6 Feb 2026 at 13:14, Igor Mammedov <imammedo@redhat.com> wrote:
>
> Windows doesn't ship built-in TCO watchdog driver, and users are
> forced to install vendor specific driver(s) if such exists.
> However OS provides a generic watchdog driver that uses
> ACPI WDAT table [1] to abstract actual hardware behind it.
> The same applies to ARM version of Windows.
>
> This series adds
>  *  WDAT table tailored for TCO watchdog that Q35 already
>     has as part of ICH9 chipset and a knob to enable it.
>  *  SBSA GWDT to arm/vit machine with WDAT table tailored
>     for it and necessary tweaks to GWDT to make usable
>     with WDAT driver.

> Also CCing SBSA folks to see if they are interested in adding it to their
> reference machine

The sbsa-ref machine already implements an sbsa-gwdt watchdog...

-- PMM

