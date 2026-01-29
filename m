Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AC1D6101A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 15:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlTs1-0007yB-Hm; Thu, 29 Jan 2026 10:23:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlTrz-0007xK-QI
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 10:23:43 -0500
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlTry-0005bw-5B
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 10:23:43 -0500
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-79496f0ea57so6064967b3.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 07:23:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769700221; cv=none;
 d=google.com; s=arc-20240605;
 b=Mdk8dSRcmEDZer3XPIeYPfBxvodnsXfoSdRG7jibTea2LiQu4vzzrpmbJQxUjoePtF
 d5btRqwn2S4S9vYScVe0qq6+cKnejb2zos85DDbvwx4Y1ngzLhE9J1JQ7Q/Z2vJ+eGcW
 2N+XZH2kM1p1pwxOP0unRhpaToBa/G+VJNv/ZNZeklI8zh3v5V0wUquMOxGbaOkUlfMn
 tXV+1d1keQKwREq6t16DeJBVNiCkh+z7+vioUu3HRiD8TcvH1Uf7F/5NfSzSoDMzbU4l
 4QTZqx87AuBnReHoR8cUD2rfz4byxCtnkqoKlXCfhnSBLKJ0C3rGOl1Q/lcstg2PKdtP
 1Ndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HGsBBVoPwOoSO4+vUaMv95px2FvM22R0jza8OCwLrdg=;
 fh=us4lPT8YSvMw3WPWVr1x1zbLMIgA1kHH4DqlCTpJeag=;
 b=NHS0mHalKswPTTvOTnSOebyFRnecSDvtnj4wbgsxahawIop/TOiCQ0ClGWjjsL1mBZ
 tjydbrLuvwOVxIWKqCZXWz/2zow6C68AyZOAA0HAg0DPKgHtr0ZTF73eMs9jDPrFL0jk
 306ZbiunfXnNOJV2KCbEbab5eCjYxZ++doB0Nheb7TnsFfqTUhh0ReOCppqFMhlFpTw6
 2RPn1UVy6X1pOeIAex5xqMJLszcTLp0W2CThmUsIywUqLTKhL+yzYul1HAS1gRhiIiWi
 TV9ThCyv7fga2NYnbfwEaqxRryfyMXzgaM6M9CJp4X60XMCjKTaV9rXW6rVUTgOOjAO/
 s9Pw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769700221; x=1770305021; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HGsBBVoPwOoSO4+vUaMv95px2FvM22R0jza8OCwLrdg=;
 b=WE748xu7TclcfDfKrOpdFOuXFHUCHmpt1NVKFzIH2uJFPi2m4uVGGayZdPK7JhIvb5
 XNQx911Ny4jNTq0bnnI5R/8QA505FN4eHk787X/kjKv9SfEZLIMlxnIzHfxGpOWAYy8g
 z+NMR8A/lu+20jvJnMCZuHIm9mgGghk5oODjSyUMzg/edNP/CQaGGqxwPL9b6icr5/WP
 UsBlcktrPsIE/4cjHlNinyhI6R25olgzD8MNoE7T4feCSGpRXblUjl6TkRohNgD3Vwaf
 st+8Jkmwmwr/7KzLnHSm514alweQ6fwYo8xXDFmEx1GQldYsGnhEow1oK/qsjr9pBmsm
 sRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769700221; x=1770305021;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HGsBBVoPwOoSO4+vUaMv95px2FvM22R0jza8OCwLrdg=;
 b=BSafKMmDeMkGRg+5DY/sdIKAiCat1x/QfDLAtkVMFxvMvWwa3Dr6vxR6RpZum5Dq88
 trqw/k9oFm+uCZsObY/EIezfgYUF5sb6jMtlY2p55NdnxWJfX+inUwRB5muFDb0uGZoU
 HCrErJWjhC8etsytl5iMkbBMNzg3xHiW251q2vbJkiDH8hYIto5/3TIncgjQaOzVsXSR
 HkO5nJKHUEKhMNcMfCdXn66bzbDw25MnmYII0vytHaxwK+y/QH44bjKJTUYg87tIaoLD
 BLNNG9szCW6PJaMMmpztkV5+kfzOqj3FxLlGE3zwACMQ0vlQqjuOUm+hDq+8k6G16FLP
 oO0g==
X-Gm-Message-State: AOJu0Yw1VBit7lWc7UZNj5VCaB7xMFAFzAkNr0VFl9BZdcVrhwYCgI35
 BCXKYeRz15+bYIEQkQXR+o17TqVxcw/bdpjC8fC9lIwrupN4JKMGyoXFOVr7Hjb8pV+wHwaNoRG
 q7i4yHR4Np3C56ltXvRmp1Vu7bZQ+PKxLJS96ffj9Iw==
X-Gm-Gg: AZuq6aIwxoUiqcgmCF1rqh/JRT0AcbfgY63luwh45oDUvydt4M4QZLZ3sH2cQu/SKib
 o92z6ZiwLjC0W5xqk0YG9RjQSnporRe/NSVjaDfKgln00+edEtybJ3trbGukModa0umcCvr3FRA
 MfuyYXcceYbgy1XfuP1pP069Zvwz+VjIBRocoQs/HhiSQB209PXd0ix6DZUUhsC+tbWFInWBPJR
 ZUto7UB1JPrtjxnocN4sTeQejmk7Qldxq1/yAqee32UY2RuZt9YAOtDaZMuqLt9mwFpKA==
X-Received: by 2002:a05:690c:5609:b0:793:d0b5:9bcb with SMTP id
 00721157ae682-7947ab4127emr53311227b3.24.1769700220783; Thu, 29 Jan 2026
 07:23:40 -0800 (PST)
MIME-Version: 1.0
References: <20260127182805.73212-1-mohamed@unpredictable.fr>
 <20260127182805.73212-8-mohamed@unpredictable.fr>
In-Reply-To: <20260127182805.73212-8-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jan 2026 15:23:29 +0000
X-Gm-Features: AZwV_Qi6JHi-PlV0zbQOn9dWM1cACeq9E9hSqMK1cT3rLe52xaq93XWs8ti5UQk
Message-ID: <CAFEAcA-AFji3sUmFV7+vj+UVj7asVdPJpnPt01zS07CkncYD-w@mail.gmail.com>
Subject: Re: [PATCH v18 07/22] docs: arm: update virt machine model description
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 qemu-arm@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, Igor Mammedov <imammedo@redhat.com>, 
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Phil Dennis-Jordan <phil@philjordan.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

On Tue, 27 Jan 2026 at 18:28, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> Update the documentation to match current QEMU.
>
> Remove the mention of pre-2.7 machine models as those aren't provided
> anymore.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>  docs/system/arm/virt.rst | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
> index e5570773ba..3799d2237e 100644
> --- a/docs/system/arm/virt.rst
> +++ b/docs/system/arm/virt.rst
> @@ -41,9 +41,10 @@ The virt board supports:
>  - User-creatable SMMUv3 devices (see below for example)
>  - hotpluggable DIMMs
>  - hotpluggable NVDIMMs
> -- An MSI controller (GICv2M or ITS). GICv2M is selected by default along
> -  with GICv2. ITS is selected by default with GICv3 (>= virt-2.7). Note
> -  that ITS is not modeled in TCG mode.
> +- An MSI controller (GICv2m or ITS).
> +  - When using GICv3, ITS is selected by default when available on the platform.
> +  - If using GICv2, a GICv2m is provided by default instead.
> +  - When ITS is not available on a GICv3 platform, a GICv2m is provided by default.
>  - 32 virtio-mmio transport devices
>  - running guests using the KVM accelerator on aarch64 hardware
>  - large amounts of RAM (at least 255GB, and more if using highmem)
> @@ -167,9 +168,11 @@ gic-version
>      with TCG this is currently ``3`` if ``virtualization`` is ``off`` and
>      ``4`` if ``virtualization`` is ``on``, but this may change in future)
>
> +msi
> +  Set ``auto``/``gicv2m``/``its``/``none`` to control MSI controller configuration. The default is ``auto``.

We can be a bit more verbose than this. Compare

https://patchew.org/QEMU/20260120180339.1416328-1-peter.maydell@linaro.org/20260120180339.1416328-5-peter.maydell@linaro.org/

thanks
-- PMM

