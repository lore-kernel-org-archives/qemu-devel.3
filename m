Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D960CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 09:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKvbz-0001al-SS; Mon, 17 Nov 2025 04:33:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vKvbt-0001aT-Ry
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:33:21 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vKvbr-0005Cl-Pw
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:33:21 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42b38de7940so2302660f8f.3
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 01:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763371998; x=1763976798; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t+GnBIPajjMHi5mqzBa0gAL6fZKvuZOCSU/V3hLILKw=;
 b=qkMFYL4YyjYwSo7sOR/O4SjDV6+VjyzxLmsoaVUzThmpYzqO35WZfmseCuHwPa+tQb
 yp+wen7egzkwOTrmzg9FH95Qt7/7BkgU/Ii3qBvCY4rhrHWUhsygbCllxunL8FFDDXFx
 5s9KdAErePkW8hDv6cQWwHYcjmfmokLjKcCD4TMHL7SgL8o+HqWzXhdqD4nqaNlXaPcy
 +Tq8hV0YjRQ/CvBnOcx46XdMWUzJKJFg0YpqNkx7rP11Um7JgImyBviXy/qRibme85qe
 EQAZ4tG5fWx4KGPu4IlIxC8y3ab7b63GAfqE7iKMARrLITPAh+QxLRMEbeH+TkoC3AkH
 Wshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763371998; x=1763976798;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t+GnBIPajjMHi5mqzBa0gAL6fZKvuZOCSU/V3hLILKw=;
 b=YkyGdvn5F4fWaKZvv1w4Rh4pyOEZVDtt89igoYEXVpOD+IKzJBZx4KG06ZoTYfHdwI
 jeky3yyowB11s2lpZsB1l1PBM/4lTXaOzOrxXvETq9cnWgqkTNXtKXmXa4t2tRUyXfNv
 5TkTudq139+BkrkF3L8sRcT8BiB91dRgdoaY+FvHhvxudHphgnmdLB+dQ2+zI2lpyab2
 cF/i66oyzR8PaY9qSp5Efce5h0HfnCjp5s8+SpgXTE8GoPENt/90OVUoAoX2ewNfa3yG
 n6jY+axX8DNKVBtD0dgx2z9YlEOWk+IzYIgkOuiSoeqTWugQsqNa0v8oRMpYCQapfTcv
 +s6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR6A2mAF+Z1OaOqHB7aTrAna9Q6XPLcS9vWMA9e4DfSAz+09CzbA5xM/AMp2APC5wMzepYeFiZfByo@nongnu.org
X-Gm-Message-State: AOJu0Yz7xI9S83M5xHgAn5l/wh10BsHgFVsp/TbL2xYZWUaC+7ZgoS9A
 yrYvMoQjfXMYhOryoezA6vdWwB7BqF9bsFv79bB1A7pQdsNs8iUt4R4nObQnIx48e7VMHs0kROr
 T1Y+HO9s=
X-Gm-Gg: ASbGncsJdJkEsHJyItOKyErpWI/UkDJmJZax5W70/lVSQ1ebm3HfZg58btfitMqM8rS
 rhubA4Cmy2PKCbG5H1Iv73XAcIwEK5Qc3EC6kjCu6pzrYtUCwy5rWQmNh7nK36uVqG06kkRV/MH
 w7E4W5TN3keDZIbzFizdPeS5Ytbcp2wEmjoh1QdSgSgPFx3VgnN5j8SdJiYsn4jrDE6hIMjj1sW
 tIwEM0bc2XHIjOG2DIyNJ5j2KGPEeFP1ndVwrG0KHt/7Ji88vPADBirFHp+1KE72bVPbHetgmsM
 pmaPUVmOKILQSlatdtRQpAL+M8bN48tLWXJxvW0x47mEI2tYpeIAlC9Tlg6D0gkQt+g/2eBFhH/
 D3MQRmMdE9Ct4nIz2pRP6Tf+LTt75dlMX7rzjNJLc2VXqsf/y2AApmCcT+i8kUmyVOwJxZW3l/3
 JzDUqswSbE2wSV4Q5OwG5K79Ks3Ts2BbILAYVooJcYTupvzi7wtXGLfD3ZTueBeXnsDrC3Ttw=
X-Google-Smtp-Source: AGHT+IEnYSOiaEQmo9qFoAuVRUTvqZw0DMAb5YMXnumaA4ivKfABdThUtMOWAYKhXrNwMBkejd8AmA==
X-Received: by 2002:a05:6000:2f83:b0:429:d3e9:694 with SMTP id
 ffacd0b85a97d-42b5932360dmr10278550f8f.5.1763371998204; 
 Mon, 17 Nov 2025 01:33:18 -0800 (PST)
Received: from [192.168.8.105] (66.red-37-158-132.dynamicip.rima-tde.net.
 [37.158.132.66]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e982d6sm25477934f8f.21.2025.11.17.01.33.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 01:33:17 -0800 (PST)
Message-ID: <7c11abf4-f557-4c42-b2ee-38426ffc4b8c@linaro.org>
Date: Mon, 17 Nov 2025 10:33:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] scripts/clean-includes: Update exclude list
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>
References: <20251104160943.751997-1-peter.maydell@linaro.org>
 <20251104160943.751997-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251104160943.751997-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
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

On 11/4/25 17:09, Peter Maydell wrote:
> Remove from the exclude list:
>   * tests/plugin, which is a non-existent directory. This was
>     probably intended to exclude tests/tcg/plugins/, which is caught
>     by the tests/tcg exclude pattern anyway
> Add to the exclude list:
>   * rust/ -- the headers in here are purely for input to bindgen
>   * target/hexagon has some standalone tools used at build time
>   * linux-user/gen-vsdo.c -- another standalone tool
>   * linux-user/mips64/elfload.c just includes mips/elfload.c
>   * scripts/xen-detect.c is feature-detection code used by meson.build
>   * tests/tracetool/simple.c is autogenerated
>   * tests/unit/ has some "C file just includes another one" files
>   * include/system/os-wasm.h is like os-posix.h and os-win32.h and
>     shouldn't be adjusted
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   scripts/clean-includes | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

