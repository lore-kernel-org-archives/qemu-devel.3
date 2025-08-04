Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73068C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 15:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiwzs-00071N-3p; Mon, 04 Aug 2025 11:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uivWy-0004Tn-7o
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:47:15 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uivWv-0002UI-Gr
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:47:11 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b3507b63c6fso3204785a12.2
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 06:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754315226; x=1754920026; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FMRBnB2Qdvymd2OVLcmIiwPYyAa//gUJuXtuwL+CVeQ=;
 b=Y9T+OI17o9GLf4EqACQ4LyhompT4DoUrT5RBvws+Ob3V57M/lv1ozsrhW00zuaoR0J
 dTs/9ef9KT5hcFP169z5htIYJPGlWkWTSJS2R7yAfXp1aAbwo5yJ5FNgYfnrfwrm8WdR
 ltpe7jMs5vmjJOo1swC+Pp0VEZYSjCbFwx/Y1gwSO+LjdU5GGzOX9oiUMwTWEUrpD/Jk
 PTRzrtl9cm2K5hTGIG7sKiCSrS3qJcESaBcmf4rK3OD2p+G0vlO8jA+AugiL0uchAihm
 lavDwrW5TJXyCWnMlkAazDc9bmEpltY2D2WoRr0iz0g7kXZvHtv5NewYhnvC08pksY1i
 /O3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754315226; x=1754920026;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FMRBnB2Qdvymd2OVLcmIiwPYyAa//gUJuXtuwL+CVeQ=;
 b=EjMLsAA6Sx8rcCIinQNzdqlTGepwL2nPm229+yLtQ+u/U4wkeN5H+ILA8SNt1WY55W
 QN6wfD8CBWqRjBtDkvs3AEN4Q13BhzD4nkcx3LUmviTrmETplNDL1dhvWKVtc4WmFf56
 OZwn2lkyZx+LV29pweIQvcsYRH5k6MNJYBMyi7vk+7wtNV5Hc4qPPSGKzq1i34Pc3ipX
 5KEch5xwhLFdGaz+F831u10XPWMVeaRsPPvuPh4j/hfawFKU2tAX1PsQH14IA8LKY47c
 wraRMU0OtgK/2x6X3my/35jvF4Y4gX12dbn5/R4tv6zGBGq7a4HwekJ9ifiSviQ/nd2I
 0KYw==
X-Gm-Message-State: AOJu0YzHh7nrCBXYR4LI4bg/xPF0GoYLwYf4JPWs8leskCxpAWAWfHlX
 knDxYts7hLFlmMNZuYHmyPeVJolsoiaigukcgt50/1qtKNYTRcOkLp+wt+yZ5xqcAdy2amD31GO
 2A4TO
X-Gm-Gg: ASbGncsbYTv5WbIRKG7h9O5ul6Q4/TVnHelZqsbtHBfeo9l2sMKfwqHOh28J15RLUdz
 o05TFwZfZ4eTmFuPKKVtuCNQdyULIbz4HkmejsAOyoHj1ho4IyJ5d369QnOO3HyQrblpEazQtJl
 XMvZ9w9N4I8Q5IVrBjK2ZyAMEGRbNEArz3I3Dh5LnM+6yXYHf6uWZpuxkWdCZbnlUQHHcyOdBwg
 0OkmknsgmRZbcdRgXhh8GHe87mtKSFKOg1EdWkYtIUWcoh3UoOmua63rXzEQTUjWmaJeJ4Fte1o
 MRkNBMLMBdd2lz5/mj2mxMOa4DGnOKatGCs7+anttV3J2yYD2PeAD0w9i9OOGlMkyfuqvSSgJJj
 yRGkyOz+MTNtFfDSkqZdFnphD9RlxGvrJG5HLmn7E
X-Google-Smtp-Source: AGHT+IFeFYVN2wHlio62+arBpZrJG1D5aJHuJFDhlu1zdgMzpV0vvnp2zazxxQ+/0RUwWazjQulq5A==
X-Received: by 2002:a17:902:d2d1:b0:240:52d7:e890 with SMTP id
 d9443c01a7336-24247058a6fmr126978055ad.47.1754315226331; 
 Mon, 04 Aug 2025 06:47:06 -0700 (PDT)
Received: from [192.168.4.112] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0f7desm110055365ad.43.2025.08.04.06.47.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 06:47:05 -0700 (PDT)
Message-ID: <f97ef3cf-1586-4b3d-a52f-e6e05da5a2d6@linaro.org>
Date: Mon, 4 Aug 2025 23:47:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 10.1-rc2] tests/docker: fix docker-all-test-cross
To: qemu-devel@nongnu.org
References: <20250804104308.250949-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250804104308.250949-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/4/25 20:43, Alex Bennée wrote:
> It turns out you can't easily expand an ENV var across multiple steps
> in a dockerfile. This meant we silently dropped the architectures we
> should have even on amd64 hosts. As the updated AVAILABLE_COMPILERS is
> only needed for the following apt install line just merge them.
> 
> Fixes: 6da616bb170 (tests/docker: handle host-arch selection for all-test-cross)
> Suggested-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/docker/dockerfiles/debian-all-test-cross.docker | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
> index ef69bbc8a51..420a4e33e60 100644
> --- a/tests/docker/dockerfiles/debian-all-test-cross.docker
> +++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
> @@ -62,9 +62,7 @@ RUN if dpkg-architecture -e amd64; then \
>     export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross"; \
>     export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-sparc64-linux-gnu libc6-dev-sparc64-cross"; \
>     fi && \
> -  echo "compilers: ${AVAILABLE_COMPILERS}"
> -
> -RUN DEBIAN_FRONTEND=noninteractive eatmydata \
> +  DEBIAN_FRONTEND=noninteractive eatmydata \
>           apt install -y --no-install-recommends \
>           ${AVAILABLE_COMPILERS} && \
>           dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

