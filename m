Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115CFFF492D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 01:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w718b-00048Z-PN; Sun, 29 Mar 2026 21:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w718Y-00046p-OA
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 21:09:51 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w718W-0000P2-Pa
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 21:09:49 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2ad617d5b80so26271155ad.1
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2026 18:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774832987; x=1775437787; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bWcuM7LcTY+xuh8mNn8QIqY8lj7Da/e0c2r4p89Qsu0=;
 b=AH3VinFYi8Fxic1Jl86aAKnBV1q4FpZMi78VGRkGDu13XOtcV8z66IZdaHJirNVtX3
 Y5gRCWG+P0NdDZEktM78gFsgNgkMSboC50peRkDMdGgcGiaCAc33HMcm3/8NHuYcRNTF
 9bMsHmAeK7fE0y6VM3J4sC5xUeIGIwhgSibIuesHeJ2y/IEM0OaHXGo0LxoLAXfxHpEw
 tI599NW1GHcQxk9o5frF2B5lHbCz2X3KWG6c29xEEqjUnNvvxB+Nf54s2OzhR15i3YL4
 GvIlKUr+JAVPx8Efb4nRePTLsbhDpmZlDOc2a+VWXg9BKZDtDN1jM17f3nelLQZu8YXB
 i2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774832987; x=1775437787;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bWcuM7LcTY+xuh8mNn8QIqY8lj7Da/e0c2r4p89Qsu0=;
 b=NaQYf3aNLPE94L1XrwdMubLLm+3dc0sBkQodbfLN72njKaI5FK06D9EX0rhC+Q8Xda
 F3HnIp1xI3EZGAlcO9tSRLbGfPC0Zy9sXjQD4Gs9I7QqSKV0jNnw+aqxA/GkY068Gceh
 7bzuyysZNO2rBn1zoySHsqBUn1X8vEZtxbyGmQGf2ir/LkkL/J+QyTKME16mx6sFBJEC
 k+liO9XOz0IVYyjduNDL95qJsGbC5MQuf99JUk9txA2UM9d6wlmykZPIgDQYd4i6na4/
 k/PotVGzaSq6JKK0scJnWjJiNwJ0YXJwIOJyIy1l7P5e51+VMY7/uIKbPUIszrEPIdIr
 Drqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCViJjsUOcTxC7hopGBwqtTHC/a2OcmGsJKAJcM4defUsjifRfcptZAzIsyO4YJCWX6/p95HjWuyls1M@nongnu.org
X-Gm-Message-State: AOJu0YwgAHEZdOJQ+BNG1RNZSZM5FcbekKC7L8QvYstixPJYgo0vK2MU
 6uHvTJjJtwOfxHvbrPSgV1+LPl7/dIW7iK4oSWvv5Gcth/jt2KwwvYFRg7zjhZrmziM=
X-Gm-Gg: ATEYQzzHNXO650TBcojiJ3+dBoE/b3jSDV73fA/WUOUSg+1+Npl03TkvYSD1VRDMuLC
 WfT2RuXYoYohaGd/3tF/xj1QSIAHn9sHt5ipQIyuD1XNmPiZtLPCzow15YI2UPxY5utF1KP4nJe
 TIzSJf7JwyEVDXYqxIlVtatmKJ5oWx5zpYZu6xli6CiT9/O2ZV5NscIzipnUahIK/It/Ho3uNwp
 mmctp3DSrzopFSRN4al15roJsJP8Oi6LHmNRX89hCO7te0oZymFv2pN7Jph9Sc+CagdIYT0N1fA
 X+vToI9/nBzoNGbfUMP4UrxP7g5esDtq08Rga2h5I/OtHmZ/SFHzGzlfrne5sTleAcJoX0GfOAo
 2WSDHILtjt/G6L+PRX4tT7f86BPIcflITZQm92j5s9SGMrQChZ5cE1wA97Q3DfAup+D3vxerN+p
 6zbmagNmB6cqlBazi46CLl+EsjCkhuM6ajrD07eJ0=
X-Received: by 2002:a17:902:e74e:b0:2b2:45b7:306e with SMTP id
 d9443c01a7336-2b245b73bdbmr60693805ad.3.1774832986749; 
 Sun, 29 Mar 2026 18:09:46 -0700 (PDT)
Received: from [192.168.4.112] ([103.73.85.112])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2427b15a2sm71596935ad.73.2026.03.29.18.09.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Mar 2026 18:09:46 -0700 (PDT)
Message-ID: <b6895297-c24b-4605-8d2a-a8566dfd3604@linaro.org>
Date: Mon, 30 Mar 2026 11:09:40 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/12] target/arm/tcg/translate-vfp.c: make compilation
 unit common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, jim.macarthur@linaro.org
References: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
 <20260327165042.604105-6-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260327165042.604105-6-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 3/28/26 02:50, Pierrick Bouvier wrote:
> Generated decode files must be duplicated between user and system, as
> they are generated in private folders per libs, and can't be included
> otherwise, as meson does not give control on output folder.
> Indeed, meson generator is a different approach than custom_target, and
> this is a limitation by design.
> 
> They were already duplicated between arch variants anyway, so nothing
> new here.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/meson.build | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
> index 3e96c77df73..46bf4a6d76b 100644
> --- a/target/arm/tcg/meson.build
> +++ b/target/arm/tcg/meson.build
> @@ -30,7 +30,6 @@ arm_ss.add(files(
>     'translate-m-nocp.c',
>     'translate-mve.c',
>     'translate-neon.c',
> -  'translate-vfp.c',
>     'm_helper.c',
>     'mve_helper.c',
>     'op_helper.c',
> @@ -60,7 +59,10 @@ arm_common_ss.add(files(
>     'crypto_helper.c',
>   ))
>   
> -arm_common_system_ss.add(files(
> +arm_common_system_ss.add(
> +  decodetree.process('vfp.decode', extra_args: '--decode=disas_vfp'),
> +  decodetree.process('vfp-uncond.decode', extra_args: '--decode=disas_vfp_uncond'),

How are you not removing the other decodetree invocations at the top of the file?


r~

> +  files(
>     'cpregs-at.c',
>     'debug.c',
>     'hflags.c',
> @@ -68,6 +70,7 @@ arm_common_system_ss.add(files(
>     'psci.c',
>     'tlb_helper.c',
>     'tlb-insns.c',
> +  'translate-vfp.c',
>     'vec_helper.c',
>     'vfp_helper.c',
>   ))
> @@ -76,6 +79,7 @@ arm_user_ss.add(files(
>     'hflags.c',
>     'neon_helper.c',
>     'tlb_helper.c',
> +  'translate-vfp.c',
>     'vec_helper.c',
>     'vfp_helper.c',
>   ))


