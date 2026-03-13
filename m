Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14ACE106FD6C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 03:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0t33-0003wJ-Ri; Thu, 12 Mar 2026 23:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0t32-0003vj-4x
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 23:18:48 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0t2z-0002sK-2V
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 23:18:47 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48538c5956bso16224595e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 20:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773371923; x=1773976723; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8+DCiQF/rpBWfwiV5ZKCslOhtRLarKuS9r8GiB+oR0M=;
 b=tigyL13hNSpPJAEqDnq3Gia6Vv9F3uNuVV5V7X897PDunbdp/b+uTd++C0XaL14AdD
 yAsSS1qysKvuFWypc7pk2nRvWIiLo/EnDpQwuWPBE+Rit474uw9AMO+Q9VFrlYzd3ZKa
 ZYZNN26kwCG6KULJwNtQ/5Qs5VNcyzMyho+VgRYvLZ0E63SB16eN1dUqpsENCQeJnBnn
 DnRGs2DkifhGQiIp7kDXs80ecK3GSY9AOyjNQ/oXYFw83fRYPqAJqvy9vgXAy9BeQVj1
 +j1QBNm1Obk0jgh7Zo234qjwByPKN4mK93kMNVP9B2qpNOs7IMk7INdFi28USx2/g9f4
 wUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773371923; x=1773976723;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8+DCiQF/rpBWfwiV5ZKCslOhtRLarKuS9r8GiB+oR0M=;
 b=hq0D/IQDDyrPNKCNQ55cKsy1lp67JPEWVEPMAz2SSB1Wk6TAvZqwXXTJ4bDhZpEk6G
 samSvHpHfZAkOTwhYcDfh8y8KuHkMk/tjEzmOLbZFr8V7yS7G/00GirGRptvjgZLHYBW
 PkdrNeOlaSZb3kU6arTUd8jhdB8S6ommuP3MufQJ1tbRKroq1A2f6CVL1o8TZIvw8pTw
 wwCgVp1jI1xjkZqukm8Gib1jCUGn04x3cpEvhjvClSeTMvSOepXD3rh8psZogisBhgTE
 0gLFsjCGtm//P+wF73JsZQ7q7X135AUiZXIotLjq30I8vcyN+wltA2eXdDKoXr57CACS
 FpUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXRZpbra5k7LfCTHZjN9wIb/mtNPk+rVu8tN5A2V67/LmC62cHSIfytG/u1+xGm8P8l1HB0GuScwaw@nongnu.org
X-Gm-Message-State: AOJu0Yxtpa3rrcldYeCFtFu728GK18KSm9c5mPCWlUwffD6NAqc+jlrL
 XMznve5y3Nxulp9mtIn0GFeO+meYSCQb1o3hfU5pyaewFhIjDaH/XF4t742D8MiP9Iw=
X-Gm-Gg: ATEYQzzkZ4oewDHNJ9vu/CTFBgAWH1T9IVbbjHu8d9/a0oL40T0P+SkHE2S97CuRFqQ
 wB7v6poqtEoVQ7h655vLf3loD1CahXa0MArDy1ZBK8QZ5t1M6dODsrTDARLxRgpFsBhwAYgVdx0
 jftPWrLCpI1OmoGWlRzHaeERIzjTikQfj0JMpESCQwxHj21Ox2OVjMwAz6ZTK56F4YxW94VtSfI
 v8jJfF9wOM0bIsZ74UEjfJCTZStts6uSQZ0S8Cy7lO3NMLLrW6gM+k8U7SeAmLlualwc8Wx9qJt
 b3h0Qq9ANHAxYBoMuuHFkiJENQh8iX16+gO11+Gq9g4SQ7DOyayMIIkOXcaTwxa9hTClqWfNad3
 efhqGdE4/R2x3TkEUrPfu3B62qRO6bpiFXUzSBt9TgNK6gWAQ0od2E0mkIBU5GC3zP+Dsc3Xckl
 5+gIIWemNZNzAYoSemzKz0q4XWcYl52Vv2QKmQawMq7qmVSs/sUm/uQbkhmFAHlvwzYg==
X-Received: by 2002:a05:600c:4752:b0:485:38f1:5cec with SMTP id
 5b1f17b1804b1-48555ac714fmr28740765e9.7.1773371923408; 
 Thu, 12 Mar 2026 20:18:43 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48558fd09d8sm13769305e9.7.2026.03.12.20.18.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 20:18:42 -0700 (PDT)
Message-ID: <0d62dfd9-30c4-4389-8d0d-2655ba28cb73@linaro.org>
Date: Fri, 13 Mar 2026 04:18:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] hw/vfio/helpers.c: extract kvm helpers in
 kvm-helpers.c
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
 <20260312224449.1605071-3-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260312224449.1605071-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 12/3/26 23:44, Pierrick Bouvier wrote:
> Because those functions use kvm specific types, they need to be isolated
> in another source file.
> This allows us to link kvm-helpers only in configurations with
> CONFIG_KVM.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/vfio/helpers.c     | 172 -------------------------------------
>   hw/vfio/kvm-helpers.c | 192 ++++++++++++++++++++++++++++++++++++++++++
>   hw/vfio/kvm-stubs.c   |  27 ++++++
>   hw/vfio/meson.build   |   2 +
>   4 files changed, 221 insertions(+), 172 deletions(-)
>   create mode 100644 hw/vfio/kvm-helpers.c
>   create mode 100644 hw/vfio/kvm-stubs.c


> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index 82f68698fb8..f32d8573600 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -7,6 +7,8 @@ vfio_ss.add(files(
>     'container-legacy.c',
>     'helpers.c',
>   ))
> +vfio_ss.add(when: 'CONFIG_KVM', if_true: files('kvm-helpers.c'),
> +                                if_false: files('kvm-stubs.c'))

Directly add to global stubs source set:

   stub_ss.addfiles('kvm-stubs.c'))

>   vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
>   vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
>     'pci-quirks.c',


