Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE763ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snieK-0002Fx-74; Mon, 09 Sep 2024 13:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snieH-00026K-0j
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:58:01 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snieF-0000mp-2B
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:58:00 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-374c4c6cb29so4215310f8f.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725904677; x=1726509477; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0paHbpejSENVQX5QhJH2kVydFzGP6Ub5wr6GqAXUY/Y=;
 b=ILsVLUYlF3FKCz1V40KQ3d3u3L262qDHQYG7lsf6mOkLzQO9zWU5jgnuy8U2gTbo3B
 PafIeoyJQKWPuzPqqwbQtlTW5TgbTlerUkZoj7y6/ip7Ml1tqdA+uyqbN4dygd24adeD
 B4c9II6FpMk8lnY5dQ5CnHwYlBcL81VLraaBoEp2m+V83vAzxHLZqzzsNFcyhDNVizvm
 XYg5rs1nS2a3utuEqfPLg+75168/CAGhqHCk900mC0QLlAzCanidfjQzQIktkN47Th24
 fr5JFa0ZRgmR/iLyFndWgHSRTYxu+sjtT4zi6qILYFJJIkjouFeWNTkCq45mRvT5Vc6I
 5ZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725904677; x=1726509477;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0paHbpejSENVQX5QhJH2kVydFzGP6Ub5wr6GqAXUY/Y=;
 b=SKGOugXZfBZjMl+8U3cfVHagurekq/YA0kcEqKGNteY7TclpXvG6/mLkriaVgutJnf
 uKPhpfZQRhfhbZ+HN8eWYPPz+xy5PD7HgIDsXj4yuJsSOWiNqWlOGHlIXu80Qrbv0fff
 26SH+yrhFYwP3rm9eQFoiDpaTe+gPmiq/tWNGtMWm+E6WqgZBwq0vlCQPpLw4Vle26Xc
 ixpbVMS3b7VM1YiH//bQEqT5gS4988++BW1yHHDTtpA/l+yo7aHNwzdWeyBNQSBetIlf
 AOzWMIt2G75JhpvxVTvENr1VPzkFh9KpKKVx7+m1xGXD3Yscu1W1g8Sqy/YWuUWs6Wnr
 BWWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUAxJEeKXMqg5HlYUjAhSln2N9JFd6R5SkIGEdwoszNSqpnyhLxQwmE9w1yzAoAdeAJVG6PHN/4qJ/@nongnu.org
X-Gm-Message-State: AOJu0YzULE7dye4ZRzuqXDoJZpaFOYJJze7eqP3Rp0acy687bF+GYt6N
 xWvqu7vaRXn57Ij2ZTCJDpHRj0U7k80JYLrUXEWBQRbsjLDZJvwI2g3v99ElCeY=
X-Google-Smtp-Source: AGHT+IE83Ku/JF92mySA3pIn5VE/prG4aS798ulSilcbqDFXgBHbx/fT4PodKxE0LRGYAGkbLqAa9g==
X-Received: by 2002:adf:ef43:0:b0:374:d07a:c136 with SMTP id
 ffacd0b85a97d-378922d62bamr6450053f8f.36.1725904677314; 
 Mon, 09 Sep 2024 10:57:57 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25926ee8sm372557866b.50.2024.09.09.10.57.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 10:57:56 -0700 (PDT)
Message-ID: <cac430b5-fda4-4667-ae16-f93aad8dd2f5@linaro.org>
Date: Mon, 9 Sep 2024 19:57:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 52/53] hw/dma: Remove omap_dma4 device
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-53-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-53-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 3/9/24 18:07, Peter Maydell wrote:
> The omap_dma4 device was only used in the OMAP2 SoC, which has
> been removed.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/arm/omap.h |   1 -
>   hw/dma/omap_dma.c     | 451 +-----------------------------------------
>   2 files changed, 3 insertions(+), 449 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

