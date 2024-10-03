Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210A1CF34BE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 18:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swR2h-0004Ur-Ih; Thu, 03 Oct 2024 14:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swR2f-0004Se-CR
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:59:13 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swR2d-0003TI-WD
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:59:13 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2e0be1afa85so1185783a91.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 11:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727981950; x=1728586750; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/TvMjeS3E4TFlzpCcoVrD1vmCtyQ2aLQeiABCCCG8hI=;
 b=x3+6gPH5DHq49u2/kr4+bwjfN9yJJBYMkoNn6LjCU7BN7us49HM8lnmZLIDmzZ6YeG
 JH6TpzQXLjH7kR7J1bCzLdj1tmbGkcu9PfFqiPfldv/hUk4SxuITmkc2hpGI3zXO+lFN
 cKA8ZFUOnpP6mFD/PbQqRDnLrYBw1BwcKMbkqhbvNaNGPu7l/WHbaB3Cc4A5/ytsl0wr
 fybEbgsyMOZEWSwF/db8ieEedqrni0NC25pCoygBDadKE3BfRxhm0W2po+j7d1bZBHNy
 HqrAYnJjDpHhe/PvfmozwaibzWqEk9iTvTXJ1RaV61yHiT8bOgO6/qPbGZ7Dl0EjulWD
 j2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727981950; x=1728586750;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/TvMjeS3E4TFlzpCcoVrD1vmCtyQ2aLQeiABCCCG8hI=;
 b=KUYYe/f+FO+eCvS4Em1CdfwgFJ+dAJhVDG/zCXEwCQHPTZC0Qjw197qieoYKZh0qhJ
 nKMagP64x2k48UOI5YdloOShvUBhB/yUFgyWA+yVXFHoJEc2cyePROaR4wlmGwRHv6xX
 t2pccE2/+Ij9YcA7FeFTQRrMt9u1G82SF55+MnHdzrIDierhPPaVTBORNem6Zz91HieB
 yFWgD/uio6zOMqqTHDC4WqaYAoddzlP1GD1IWEaEuKYGAqCuvcEos/Rk4XdPbPS6ELlj
 xnmTvo9eqmuhwTwKs5OtHCuZWNrXf3jowBeGdcMpRW/6RfPmeHSEQNjl3z1gi5GfPQeC
 B+tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrGtuy0WhOfSP1Ote0ZjEKuqnvBX+LtaRJ9pKAR723egxQBfOnCXdjImSnlLaIpHw7PrUifXBPmpj0@nongnu.org
X-Gm-Message-State: AOJu0YzOFtrnlDLJeOLXl4Kq2NJnEp8SnhaQMLA0KJil/oz2uQvugaDh
 6bYoYGaZ/aRDs6ZmbSMM1Y2PqDZ/7b/6gOiOIlObcar+bYGkCSCoyrVRJvAzT/g=
X-Google-Smtp-Source: AGHT+IGYGFW3yFQAXiHklu6vSyeTrTYpdtlGEHAXZXwSmojdW1RIpBCP+RvrCXTQ8k6Dm4ZNu0uNhA==
X-Received: by 2002:a17:90a:39c7:b0:2e0:6c40:e389 with SMTP id
 98e67ed59e1d1-2e1e63650aamr89182a91.33.1727981950011; 
 Thu, 03 Oct 2024 11:59:10 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e18f541bbesm4196727a91.11.2024.10.03.11.59.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 11:59:09 -0700 (PDT)
Message-ID: <cc91f4b4-3d9d-42af-8c43-11b54abcaaf3@linaro.org>
Date: Thu, 3 Oct 2024 11:59:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/audio/virtio-snd: Remove unnecessary "exec/tswap.h"
 header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20240926102113.64890-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240926102113.64890-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 9/26/24 03:21, Philippe Mathieu-Daudé wrote:
> We were including the "exec/tswap.h" header to get
> target_words_bigendian() declaration, but since commit a276ec8e26
> ("hw/audio/virtio-snd: Always use little endian audio format")
> removed this method call, we don't need this header anymore.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/audio/virtio-snd.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

