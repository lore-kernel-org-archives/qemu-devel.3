Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C634EA794F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 01:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnnrv-0001BK-4i; Wed, 04 Feb 2026 20:09:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnnrt-0001BB-FK
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 20:09:13 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnnrr-0001yi-Vj
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 20:09:13 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-34abc7da414so178545a91.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 17:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770253750; x=1770858550; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FBJGSV0IiHkIh7sCgm5nJKCrzHz0OnqHzXbN5BXOyzI=;
 b=A2gW6wIwLhP8xNyJ5DigFKNrLdmWMmeaBjd/2Nh9SsoznNklAOlRzk/nKENzihMqxM
 aIw1gC6KFunemneW2mCMDqnHzhes4JDZO5xdB0bvwTS0DaDnwLeWJWMPwJAUu2Otr0yj
 vkB1/4AnI8iKsVXjnLPF0s6fXkqR+5CrErlbby8SgQfjmRuKj8rE4VcN7wR7YxipRyTi
 0IILxDodxD3GLGpu48odtc5J7ZpbnG/4Y2TLRGcTXuIFzYuTHWsQKaQlrd6d8NCfjQKG
 A7888L9iVbs/bX5Zzu5MrWZGKKkFzB/joe3lMkp6iiqNK6EKPB2aGNANNn1vcaM4g8bM
 N2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770253750; x=1770858550;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FBJGSV0IiHkIh7sCgm5nJKCrzHz0OnqHzXbN5BXOyzI=;
 b=b5MoG9n7Z70gE2fAIE2YEdmS/H0kiirOkTv9wYVUToKvjNeokBHs/8zVkrIxIfaoDG
 hWr8s7gPnQMksomFwB5ZHZisRoy+T0SzL37Edcz+1V/CWjPe/ci/mAWoamaerQFWo+lP
 fdhbpUdlWvj8GhFCGjngsj0sbyy37ZoQ9rnvsJQE6COvB+qIPInzqqvifNL9K9W2kCt2
 B5ieS3j+gkAvToyH08SjZyK6y5BE850FUMrkouclk7NhPDyaKFhRMVmdJvdmaoT69e0n
 /uUh3d580v/VAaZY2GMSA3iziOjMdtDYqG7nEQ8dYUW4e9hrHXWtWYuXQ2mm41aqBvsp
 LwCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhd+MMFV6LtlOvwqfNyiJ57MDY5R7ZbZnXzSkQhoZ1lP8BdobQrW2kl6xEJ543wGxpu6Vyz1oC8YGI@nongnu.org
X-Gm-Message-State: AOJu0Yz7RA5AF208bTu4z9+sfm6oWvxadb35xhNmuMyM52lE52W506AZ
 AamkugJlDgQMUPIYTARPD4wLAEQ+cfX8vapKTwXCJiJKsPWbiDWATDTMAMlGp/wSA30=
X-Gm-Gg: AZuq6aLAedGFT6VY8gJXMiVp5ixXEcDo1B7YfupNmJfFddcevQYSGfo7kM0d/bd7jac
 Kz4U4WULSRw/6fqjoKPtz9jH1NaimMFN70rkGxmUNnEVf0h9jNXltuTTDdkIvSjuDzA8p3K9z1Y
 XJ6SENztmM9Ao/RWsx9GdZsYN3SdUfUoZYi2joXoTXIMTuGpp16KfP+AQrh0aMhC2LuWRuAlnpU
 LpwcvSRCSlD0goZIeU95rqAxg0SkiAwvpWzf3mVlTbQObYSKjsj8/kaZEcQq/rT+gAzAF4gFAmO
 Ysmr9p7rtahYod3V8mXHeuMKjryETBvCxklqLrvZNEJ11PXyyJbALe3Q8e80ZGPpZHIWOEu+vLU
 vfNwCUaO9FaF+2OFrOerlGGpQVa2YBfc8T7AYjQOVDCqCBp6GqZ93O+qwHbj+olUNcazvCmBI8O
 GNw6mELy7RVTTg7GaSIwb0LoQsrCSYKyP08rPkMN4MsCc4nMnUOHex30XiCinzlww7fZ0go3U3X
 nMza1wiRui6E16WwJzaneEV180FO8H74mu0c8vbb5KQkpdhtHy0
X-Received: by 2002:a17:90b:568e:b0:32b:9774:d340 with SMTP id
 98e67ed59e1d1-3548720a9a2mr4459189a91.33.1770253750269; 
 Wed, 04 Feb 2026 17:09:10 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:7515:513c:b646:18b8?
 (bg30dhzygc4twf4fscxk.ip6.superloop.au.
 [2401:d002:dc0f:2100:7515:513c:b646:18b8])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3549c09adffsm550455a91.4.2026.02.04.17.09.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 17:09:09 -0800 (PST)
Message-ID: <4d16ca07-d3c9-4e46-b618-0739c9dfe169@linaro.org>
Date: Thu, 5 Feb 2026 10:44:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] configs/targets: Restrict legacy ldst_phys() API on
 32-bit SPARC target
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260204215304.52757-1-philmd@linaro.org>
 <20260204215304.52757-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260204215304.52757-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

On 2/5/26 07:53, Philippe Mathieu-Daudé wrote:
> Since we removed the last legacy uses of the legacy ldst_phys()
> API, set the TARGET_NOT_USING_LEGACY_LDST_PHYS_API variable to
> hide the legacy API to the qemu-system-sparc binary, avoiding
> further API uses to creep in.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   configs/targets/sparc-softmmu.mak | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/targets/sparc-softmmu.mak b/configs/targets/sparc-softmmu.mak
> index 272fd46f6db..c4c38946d54 100644
> --- a/configs/targets/sparc-softmmu.mak
> +++ b/configs/targets/sparc-softmmu.mak
> @@ -1,4 +1,5 @@
>   TARGET_ARCH=sparc
>   TARGET_BIG_ENDIAN=y
>   TARGET_LONG_BITS=32
> +TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
>   TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

