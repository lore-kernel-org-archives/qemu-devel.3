Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD5F3CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFrZg-00061k-Lw; Mon, 03 Nov 2025 05:14:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrZe-00061S-TM
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:14:06 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrZc-00030V-5f
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:14:06 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-475dc6029b6so37585675e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 02:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762164840; x=1762769640; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rlujYw+RiSOLNRW7TpT1O8LSg6bN2iOs+PleaszjFGk=;
 b=TVgD3RiPEuEEA8FPesOsg9NFwVY/ZGVG3JjmwmKXR52tJiEMmqjBnJh3+a/EYv4brZ
 6RYTJfcgyaOoNf2TqDU71T740l+HA9b/fMoQ+0jKig3zm7YgcrCB08rKaDV5zWlG23rf
 mm5dRR6uchM0iRUFkCZkPtZWg2dMoHmvVWOoiu3PFZ38iEAC74R/K+P5mAz7s+Me8tCv
 pQzbsjHajp4chUpIN+i5cfBqwwXKpEcFR4FuN7M5tEW32k3n9gIq0sfYIRYz6hJWNlKz
 P6zxeCWNHBuP+1Gz/u3emN5NXyeEEpovyR/7NbzspAuZEooTbc4SPgZXRJTRd3CDo+74
 k4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762164840; x=1762769640;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rlujYw+RiSOLNRW7TpT1O8LSg6bN2iOs+PleaszjFGk=;
 b=Y4yqtH1ge+wgohWzXTR0oI9p9qLF0lnbDRSzLJZAuHIgg++FGJXrdeJ8vCY0kkAZm4
 Qi+PeRxlP2EO12hHRRLuoMFcn7E7JpQ5idXNZ78S2U//iqYruKlUSzmqaIDA5zl0oyPd
 miBodMe7B31ZCBDOmpyRWIZWMS3yj3inuLwoMOMfdMmgN9u+aP4+79anAbOznCKXQnfK
 jhhvDPNOqTtrYOdLl+78+lQt7mhVb7Owm9uw9y20hArMLR3OFgJKyC5fvpNaVe6nZub3
 jXniQ+vQpI5pe6PFRQbgL9sF3MSyiEftwKwCqqR1qJpsF4KUGyEMbuhrsAF4g3Nihn+x
 hQNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnQGc6sNZc1/dOEX5nWBljiyD038+HeeFE1qdZ2Z0X18U8HGwV+L2W2HKnO2VEW1T8RZh2Re4feF3b@nongnu.org
X-Gm-Message-State: AOJu0YwxK/HgnwoMh8VZ5LbVD/AO426zOyL79a3zQmjQEROwb9QQNKnO
 NTveQb8XjZm7xmSPi8Yk7LSmtE4ED2ML1njRSs2nxi/Xh1BJNTuoTonNY7+peqHptW1Q9aer8id
 xYqe+6lM=
X-Gm-Gg: ASbGnct/hLgZ7hrxZSarkekXub3DgHcVQMCrl1Jb6GDAIT5rVUmdZdjevkihBRpK7Uq
 4ijXh+JcT2Dx3iWyCfmGcqHKKccmZVQMAMO7ucFFjyhpB4NSKnhauDr82KgGUOjLeWBVEGGXuj8
 1ukkgXg/3GRrF5ERhqu1DUQXK1o6cq0rrlUOSfql3ad9AZ7BbskkRK7nMCpK7KdDOpcKqu4LrxF
 aaU4uN5AB5J+/GPvrCHQUa0DxT6gKONPNRwt37nBCmZTA6Q1n23YH49zSUGnxwFoIZa29Ze4rrd
 q57P1ZmQqdLpIBV8yCs/MAaNYdffAfUrXyaWTcvez7vaKGFsNqP5vcmVmzjnltDSp+Dkg8zMEjM
 PeylWV7O96hZcfG80XBkZivV8emlWbdt0s2ltVBhIX5LE/juB2CZyzlM8+GMyS3PLAElwRMaEyZ
 3sVL5cgCQ53d6EbC4h3lQuNqkDCYvagtCWLOP9mx8py+LiXvqaZ7vC0qIBE/Oeew==
X-Google-Smtp-Source: AGHT+IH/4EpD2Fs7Pe/mB/ocjhUc7f1ngUT1xUeriXenTikeZ+zOg1vVXhX4BZgWFCKrqbcAbehIEg==
X-Received: by 2002:a05:600c:3489:b0:477:cb6:805e with SMTP id
 5b1f17b1804b1-477307e0513mr91449915e9.18.1762164838363; 
 Mon, 03 Nov 2025 02:13:58 -0800 (PST)
Received: from [172.18.178.65] (ip-185-104-138-122.ptr.icomera.net.
 [185.104.138.122]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c48e805sm147655675e9.4.2025.11.03.02.13.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 02:13:57 -0800 (PST)
Message-ID: <4142ad61-f71f-4985-8261-8a0700909209@linaro.org>
Date: Mon, 3 Nov 2025 11:13:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/37] target/arm/hvf: Assert no 128-bit sysregs in
 hvf_arch_init_vcpu
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-15-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251014200718.422022-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 14/10/25 22:06, Richard Henderson wrote:
> HVF has not yet enabled 128-bit system registers.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


