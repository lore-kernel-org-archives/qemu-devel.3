Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24A5E7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 15:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJDfX-0002Pn-N8; Thu, 05 Dec 2024 10:21:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tJDfW-0002Pd-Up
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:21:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tJDfU-0007KP-Mf
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:21:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733412087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bIoqRXZ/B1R564DTsFfbTZhSWQBt47EHzZvf61i+qT0=;
 b=duLwvWfZoJcyiLt2gM/qNT7x2QBHuVAFb5HrVwapN4ws2EEAU8j3KCH4GCrTTlRq5OxmTr
 K4D09U2Rv0zkM6A+OZpmbyznkDN8nKJiyEQav4TIRzBt+5+5o2UAcrLcuMTIh3Sc4XmyMI
 kzwAlTct5Q2GIlvdhFTvSxLiS9FCNT8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-jBqtbcy6N_KSj8OfMWMTmQ-1; Thu, 05 Dec 2024 10:21:25 -0500
X-MC-Unique: jBqtbcy6N_KSj8OfMWMTmQ-1
X-Mimecast-MFC-AGG-ID: jBqtbcy6N_KSj8OfMWMTmQ
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4669d0e1696so23413591cf.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 07:21:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733412085; x=1734016885;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bIoqRXZ/B1R564DTsFfbTZhSWQBt47EHzZvf61i+qT0=;
 b=RMwXBKWNH9ospACjP6sQ8lbBUKt04hCRgaSBULlYLA+8sWfbik2Xs7MgzCHGSBQscf
 er2Ar/rh1XRW4mCAUlxAgSvKJz0VcP67FBDGYgzVu7HTWAeUcWqMMKwC4NbTioedXu3c
 GnSYV0UgBGCKo08zgNSW8N94qqMxOQC/bfT2e1jIK3FeMXhtRRu4H7huqaF3po7oYePs
 qaPjFCHv2kM2A2PiuKWDrN1jwOhyO/CYrVAxjaQPljHdffgQQQJHex7OBfU4t6m0WYBy
 LfUooA7CH0L2BFYtkUQrdfn1M41qfi/S8XIruyV8AQR04z+L9cgFucY6V0AvuPZa20A4
 lYRQ==
X-Gm-Message-State: AOJu0YwKeOCqVrTAGVUKV6lTAOovDzFUI2h/GzcpKSVe9e0eS5wHzOS8
 pK7ooImQYlKH5lVetNmuGeNKosj4P2SHmMyDZFwZycb/vdGWvykK6QF5PUQ83bpb7eGLnDJZuKZ
 vwvbBgIQvMwmjQx9YziuWrWBnsQtP/YkVaixIYJyCBGp261pD4gjl
X-Gm-Gg: ASbGncvQAYwXdky9U8E172m90VqqEic7YqJ679rQ8wyYyaildbJJomfyM8U4fe43wMh
 /ej8XC8hFYaBcRFKsFNCP0fxF2fq9JLC/5Lj9zI1q+ejfIQ8yDjPNpW/Z+VmhHoWcgXeLydVcNQ
 pw+JRiM2aeG2Bq6DWrhYxBQT/XQyUNwjLfXVyIE9rfQCTMbHi20S5cTdhCIKUh1o0Ai2JEnCLoo
 i8WGOo0SZfYgzH1DrWAN0KY8Iq3VOlDeGwJB0LM7jyaekQbFim/
X-Received: by 2002:a05:6214:21e4:b0:6d8:a5f7:f108 with SMTP id
 6a1803df08f44-6d8b73a5492mr194198026d6.26.1733412084777; 
 Thu, 05 Dec 2024 07:21:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCk2HJ2Nj+RMV1gWbzGGum02m5IHJVQJtJ5SCJrcf8yb13NQnOEBV7IE1Sp4tl4vVml+WzQA==
X-Received: by 2002:a05:6214:21e4:b0:6d8:a5f7:f108 with SMTP id
 6a1803df08f44-6d8b73a5492mr194197636d6.26.1733412084501; 
 Thu, 05 Dec 2024 07:21:24 -0800 (PST)
Received: from [10.20.9.127] ([144.121.20.162])
 by smtp.googlemail.com with ESMTPSA id
 6a1803df08f44-6d8dabfa585sm7379636d6.99.2024.12.05.07.20.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 07:21:23 -0800 (PST)
Message-ID: <a76ccad6-5c8d-47e1-9613-9ac48df38940@redhat.com>
Date: Thu, 5 Dec 2024 16:20:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 13/13] i386: enable rust hpet for pc when rust is enabled
To: Zhao Liu <zhao1.liu@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-14-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241205060714.256270-14-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/5/24 07:07, Zhao Liu wrote:
> Add HPET configuration in PC's Kconfig options, and select HPET device
> (Rust version) if Rust is supported.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   hw/i386/Kconfig       | 2 ++
>   hw/timer/Kconfig      | 1 -
>   rust/hw/Kconfig       | 1 +
>   rust/hw/timer/Kconfig | 2 ++
>   4 files changed, 5 insertions(+), 1 deletion(-)
>   create mode 100644 rust/hw/timer/Kconfig
> 
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index 32818480d263..83ab3222c4f0 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -39,6 +39,8 @@ config PC
>       select PCSPK
>       select I8257
>       select MC146818RTC
> +    select HPET if !HAVE_RUST
> +    select X_HPET_RUST if HAVE_RUST

HPET is optional, so you need to have...

>   config HPET
>       bool
> -    default y if PC
>   

+default y if PC && !HAVE_RUST

with a matching "default y if PC && HAVE_RUST" for X_HPET_RUST.

Paolo

>   config I8254
>       bool
> diff --git a/rust/hw/Kconfig b/rust/hw/Kconfig
> index 4d934f30afe1..36f92ec02874 100644
> --- a/rust/hw/Kconfig
> +++ b/rust/hw/Kconfig
> @@ -1,2 +1,3 @@
>   # devices Kconfig
>   source char/Kconfig
> +source timer/Kconfig
> diff --git a/rust/hw/timer/Kconfig b/rust/hw/timer/Kconfig
> new file mode 100644
> index 000000000000..afd980335037
> --- /dev/null
> +++ b/rust/hw/timer/Kconfig
> @@ -0,0 +1,2 @@
> +config X_HPET_RUST
> +    bool


