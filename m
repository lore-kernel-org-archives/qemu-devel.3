Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AA6C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 21:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4ofu-0006Rc-Jv; Wed, 08 May 2024 17:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4ofn-0006Hs-4b
 for qemu-devel@nongnu.org; Wed, 08 May 2024 17:18:01 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4ofk-0007uM-NL
 for qemu-devel@nongnu.org; Wed, 08 May 2024 17:17:58 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-34e0d8b737eso778284f8f.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 14:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715203075; x=1715807875; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=69R/wJYvWuD2wAvHVvx0E+UhACFA2oskUhXIQx9nbmA=;
 b=wtdRryd0Fo6MYFF2YcHV2xWiXOvvo/8h7VnDQE7QWzrLbdFq9Sqs1ZkSCOLIIVDWIV
 fuEU656arphzayxp9yYfvYmlvI/8gKDPYBaSwZN7tdE0F8SoC9/koxeIOWDEr06RBhOW
 V0UpSFF4BgqF2K0r3xCVnMsXkgJck0xSe63HXBH51OChr63obnh5+HsTVW0yET6zqDc4
 XbruSZx/wbWypTQ5crsGKpPI5mY2H705fvzseBNrS+FXGU7d1Y/CcanI4WVv06P/g/by
 72xWAdaSNBAzBdkZSwiDdS6vNfIKI0zgAG7tCe4DMpwW74+juXocOarVA9H45rM+SLIZ
 d2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715203075; x=1715807875;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=69R/wJYvWuD2wAvHVvx0E+UhACFA2oskUhXIQx9nbmA=;
 b=fBSddp4miwc4/mf2s9xc86aTcPcp3v/freqXs6n3Ad0LS+gFoLZDTfffx+3LCrCyov
 fO7nkUOAj4T/jwU5i2BKSKHVHuqSy3k+zv04X+r1R4IWrh+RTCLsyXfdXib/wUC4qdSL
 9RrE0v6WGZ2tfr7umgsatxVf1WIw2GBoPtur3v/YPaPNf1CzeqYYHF1uCEEC0XyxdDbG
 WyH/ed8aw8XIeJxBdW0T3IQOEYKaKEqP1Kpp8Q/IGgs9hutz0R0rCOdJjKhKBcsodD9y
 Vurx3c3fMBZmisIbJzl3D+xkVAXFg4QW6v8gMQpxjEC+Xdo4393SZarJDmJhbU1DfWBb
 mKkw==
X-Gm-Message-State: AOJu0Yxvpp1xw1fwYTaL+n6A599+4G+R6mFKToj+mQMEnzZnYOa9BuNe
 MXSkvtj1PoLoAahundlzKYN1ZqyddcXr1/M40AVrz/tcS7kmi2zE+oUjByOe4WxLJGMzOyznsP8
 x
X-Google-Smtp-Source: AGHT+IGA/S6jQtl5PVnrpFuAMCnI5NwP2N6M9X5OeWOSDeZbd+cK3i4gEVxsd9kdzgYMymQY4oMxdg==
X-Received: by 2002:adf:ef52:0:b0:34d:9d2c:8ea5 with SMTP id
 ffacd0b85a97d-350185d93b2mr624926f8f.28.1715203075358; 
 Wed, 08 May 2024 14:17:55 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f88208886sm35475405e9.45.2024.05.08.14.17.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 14:17:54 -0700 (PDT)
Message-ID: <619d76e2-0baa-4614-bb93-a32db2c58d0d@linaro.org>
Date: Wed, 8 May 2024 23:17:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/loongarch/virt: Fix memory leak
To: Song Gao <gaosong@loongson.cn>, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 richard.henderson@linaro.org, zhaotianrui@loongson.cn
References: <20240507022239.3113987-1-gaosong@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240507022239.3113987-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 7/5/24 04:22, Song Gao wrote:
> The char pointer 'ramName' point to a block of memory,
> but never free it. Use 'g_autofree' to automatically free it.
> 
> Resolves: Coverity CID 1544773
> 
> Fixes: 0cf1478d6 ("hw/loongarch: Add numa support")
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/loongarch/virt.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Thanks, patch queued to hw-misc tree.

