Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7F8CCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI9tK-00005v-CM; Wed, 29 Apr 2026 14:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wI9tI-0008S2-5v
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:44:08 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wI9tG-0001vn-CR
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:44:07 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43cf7683a28so78976f8f.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 11:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777488244; x=1778093044; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0W1iPJWDnkJlimZv5pxeThwtL4TRFrhvZK8ZpaKMxo0=;
 b=FtJUTJ0e4+SLU/bsMJkDLZbPQZb1AHYOxN+VAugTf5Zgv3S48AKQZSztLyMUEnOt14
 22XGFedHjaaqZYblUynSX8jnfRANaQBiccvD5SnUUtG7087BS0f36GfVce79hjx/ktRo
 2P7Vd0xivDL3lURLb+D9716CamU2+UXvwwv9zHD9Tp9YhTckXCDRbSnKJ6vpxOWwmUJv
 qKB4kEvgYmx3NGZs2HJA+TPfW5ewwOwV1xSebwJu9kz1ppSX5efS8UPhTrN54HoKZRen
 IK2U9qhNwjNK/Ix6rBZBFRO6f01wlClBO1ueSRTOuflUR/L+2777P2Dm/13+K+XSkv4s
 6wdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777488244; x=1778093044;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0W1iPJWDnkJlimZv5pxeThwtL4TRFrhvZK8ZpaKMxo0=;
 b=Fz8jxCJc8vjoQ+yYedcqElJonX45u0hH5erbak2NPKDC3E2OZO+VsySvDihW/s1K8O
 EiWjut9wD606kpsHNRWBlknlUuwlZT3cpDtEQnBRZzmy+yERhK7MC8wqm662kIThYrN1
 CjEpP3kP4DQMCbtcPE1kAaeAFxs0r/EFu+a+fhD7rkml2ou+8UbsBwA3WyLTp3FLzKAl
 MYytkIl4H25YtuhEsSyL5aPeVlGx9Eh3tSPSKQgbJzyZ2LWHoASwdYWXP0yNs0rKLorJ
 rSH0OWbmIi1W1le+EXjQN55lw1DYhDMwkdGAGDKMKcyOSyHicO4QVR8ROoH0LosIfWa9
 eySw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/7AeiUTlO7SnnWYCkRk8GQRLzt8ClWI8CChySB/b8pkMgHS5hQX8RwwfDziMIaOxG3bxPoSfHLdJX8@nongnu.org
X-Gm-Message-State: AOJu0YzWlcgmAISol5p3U41rtxK/pWv3pYz76ZZSU4Dk6K0qWfu+2msx
 vzvQwrn2fhF5fmFXGRU3BVby5EG4Ds6HKoWiDT2AB56guKiUYbkZ9BqrtFIljhbp5UsCEKxAmbC
 cXYl+Wmw=
X-Gm-Gg: AeBDiev1Daefof1SSibkEXbdsudtQFOb1sPUjjkHDVAfdXfaQnhrRZk+qgiGTuBeZFt
 6h6TNkDwyU4MhNrUonJ1zHZLv/cv18wPk130mm3UvdEGtiRh9hDhgyE2ob1vH8qJnwdPEgGZWyh
 XaVvB5/mGwDtLP35Xy/mTCpXINJYse2u026V2/TOUr26l65nu02+dKn8Wh+taWPH9ht36tYISaQ
 XZJmLoCiLhnUvJ0cAAz1fuO1rH4gOIzOtYhFpWEw/UF+/DAt5WI4ZuX7MD2syFHRRQUFaY86wAP
 3RMH1lgv30XMZ4nljy4sH/v7qeFm5fWIOrS0vcS4heWhv0eB3UmYMts6FxlLYfq5JrDOOeTAaGL
 vlgY8Aj0uQbPQl/5m8IzjireQfUlvNR2UUzAjlq7YzO08NYYlckCI6lsV2MWhfmZtgYFNo369er
 evXPYF0FTenx4L4vtAVikfKDJ2o7wtcrNxvOCORYfcQb4SHucEHPt9V0J2oNjnA7/Piw/g+gWfN
 osl9RmvvM+9dnU=
X-Received: by 2002:a5d:584f:0:b0:43d:1cec:4767 with SMTP id
 ffacd0b85a97d-4479065eb4emr9240460f8f.36.1777488244481; 
 Wed, 29 Apr 2026 11:44:04 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b7218622sm7240642f8f.21.2026.04.29.11.44.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 11:44:03 -0700 (PDT)
Message-ID: <f0d98db0-3be7-4007-b0b3-e65e17009ea0@linaro.org>
Date: Wed, 29 Apr 2026 20:44:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 37/84] fpu: Return struct from float16a_unpack_canonical
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-38-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-38-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 26/4/26 15:39, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

