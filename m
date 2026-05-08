Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34502CD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 20:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLSEt-0007Lj-TB; Fri, 08 May 2026 16:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLSEp-0007LU-7G
 for qemu-devel@nongnu.org; Fri, 08 May 2026 16:56:00 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLSEn-0005rh-FZ
 for qemu-devel@nongnu.org; Fri, 08 May 2026 16:55:58 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6948e6bc30cso808556eaf.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 13:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778273756; x=1778878556; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OxtrZULiBSLNjHISmO7/YEQrR4uPBndywiNN77Ta7kc=;
 b=IHidpTx9kKMtHKbjKLVzg1hKoo/XXKveCrSfUb5xfSE5AOfuIY7eJLHF5r/hAi5yqX
 3nFPYAWNHCvAAk/XpkOfOs+wlpvhIdY29rhTeKEeBibw3rOSKLcjzPCSVU4umPyP/p0y
 VMGhmssX7Y3HQN4XsKYcgStqwmK/XsmjpPFvdHN7ZGsTnSYUgFXVAdQLL8vBJzTHHa/C
 dJYxJDGHD9z8nGTksDTBL2x3Hf5BWHUXJ3QgFguyo8eaj9BpUTpWH3jsJs+x1V0805Vf
 OUiXQKAgD5lM3qPWBkyLYZU0DuBDQ/myGEY32A8lJR8fxdS/tbfIMeZAXVzPXKy/z0FA
 wv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778273756; x=1778878556;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OxtrZULiBSLNjHISmO7/YEQrR4uPBndywiNN77Ta7kc=;
 b=CAcXh0w5MxUiNbnxkgLPCwMa6MQTJduRhUVDmnHxOENd5FH0gDbjSfW2W1I1OQheVg
 Jr72MmfBUZQuraWbF/bB9XQJElL9DliTiftj3c4aIdvFdOg8rrzWq5GSRIwkiraJkcw+
 BOtuqQadSZhKhNrzA/1C++cgW6PESwIT5BNHXs8uRT0J0Cj8+Pb1XJy37bbmPfHiJum8
 ElX5Bp7fgn48txXHkySoG4ov9tVlNOWM7DxgLjbMc5fIds8+wvmXBt/3hYumoPveA7GQ
 5PlretARVx3bVba5Au4j0T1t4inxOeQvomluHOHJxhB9BnLM4caIm7uKE85eCb/4grd0
 TXFg==
X-Gm-Message-State: AOJu0Yw2jRTwYYVNg9mJ59J6CeJ89Tq60M2iKEcDFC0hE4Y+4hmuyQ0s
 PH+XqWy+w0UFKThTfOaj8RsiVcVd5dt44aVCPku9I+LWjwV9vaH0GIFjElnMF0sz+YeH5f9AFgk
 FfZwM
X-Gm-Gg: AeBDiesohsrzN5E0EsKGo1M0oIunHal3gWSwYVfmR5gTuVGwWfykpTZlODL9yqSeNqn
 OgUUZRKD370DdYRpzLTAXHqdzyKw5bDl3+eqWzmf0j9tF+ONqfraQu4QjP9DanxUKHJNko5IjBj
 mtIYdduRScmQjwN5tw5xdIcH03ZAlguzvtucOjdLrk5lvBzSGdpvIsAeLlIqeNQ4GI0bhS5G6K4
 hb2NsMG7ueY+d1VXgBmJWK69NwbfCPJoDNbMd3tap9suwzop0XxxZMrKU1FxpJAaFhTCNPKKmK3
 DXCHm2s5L0P85ZhY24mYlVykY7/Y8foqp9SFyytvbUgHl4EEXvQ/FwATaZH6uUJ5/HEE7MlSAIx
 3LufloImKB4Bgx1AeJ/vNDh/JgeQLYdcZlgnPOfd6RmSP9Joj4Ixs9qVexd2q6DI+uMHrrLUZ6G
 is6MUb4MEzXf0uyDGkfmbIHbV2NizkaeNeacxzw3qQ6NeUOZ8/7pCUbyaDbueUMNyf5UYz2Ascm
 hSyp3w=
X-Received: by 2002:a05:6820:2d42:b0:696:89d2:fc92 with SMTP id
 006d021491bc7-69998d6aaedmr7998300eaf.59.1778273755803; 
 Fri, 08 May 2026 13:55:55 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1a91:1de:21e3:45a9:5df:5a65?
 ([2607:fb91:1a91:1de:21e3:45a9:5df:5a65])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25c1c240sm1757629eaf.2.2026.05.08.13.55.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 13:55:55 -0700 (PDT)
Message-ID: <ecb34bdc-190a-4918-b11c-4ecfce8ca2d8@linaro.org>
Date: Fri, 8 May 2026 15:55:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson.build: Add -fzero-init-padding-bits=all
To: qemu-devel@nongnu.org
References: <20260508104723.2144051-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260508104723.2144051-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2d.google.com
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

On 5/8/26 05:47, Peter Maydell wrote:
> The C standard doesn't always guarantee that struct and union padding
> bits are zero initialized, even if the code initializes a struct.
> For QEMU, this is potentially problematic, because we often have
> structs that match data structures in guest memory, where we
> initialize them and then bulk copy them into the guest.  If the
> compiler didn't zero init the whole of the memory containing the
> struct, we could potentially leak random data from the host into the
> guest via the padding bytes.
> 
> We already use -ftrivial-auto-var-init=zero, which will zero out
> padding in many of these cases, but -fzero-init-padding-bits=all
> closes some gaps, for example cases where we initialize a
> variable with a struct initializer, and cases involving unions.
> 
> Follow the Linux kernel in using both options. Compare kernel
> commit dce4aab8441 ("kbuild: Use -fzero-init-padding-bits=all").
> 
> This option exists in gcc-15 and above; it's not supported
> by clang, but clang documents that it guarantees zero init
> of these cases always:
> https://clang.llvm.org/docs/LanguageExtensions.html#union-and-aggregate-initialization-in-c
> Older gcc which don't have the option behave as if it were set.
> 
> (These options are passed through the cc.get_supported_arguments()
> filter, so we don't need to do anything extra to avoid passing it to
> a compiler that doesn't recognize it.)
> 
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> CC stable just as a precautionary thing; it's safe and we
> might as well make sure the hardening options are set there.
> ---
>   meson.build | 6 ++++++
>   1 file changed, 6 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

