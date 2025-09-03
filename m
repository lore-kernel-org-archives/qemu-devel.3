Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC49CA1010
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmi8-0004Wl-Hq; Wed, 03 Sep 2025 08:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmi6-0004Rg-0S
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:35:34 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmi3-0004yV-Dz
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:35:33 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b0415e03e25so500291666b.0
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 05:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756902929; x=1757507729; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lAi775/pz4+zzhS9cVzcoZx7x5i0XxhOh/w54AtMIsI=;
 b=Yc5SiI6OZ4pjtyuJblCqhT71DAPnTfbU/p7Ux1T7KQKwH7c5UDYk9g1gM/QOzICu8r
 UoJMqRFKGlMQBWs9TdyoGOnSSfhtpasAdnZUwqGGHGzLkbT/1fXKO+0X6naWg+mTNxnZ
 jBuXOVdN3fUD4RaeGzNcxnnLOGL8laCxTGCalF2PW66KZQWMD/xDAszB7w9Hs1R+6MD2
 u5+hXIoYPKKdWvwNCcf5T7WRam/QEq3zvsNn9bs3v0nx4F5Pj09dR36o62DAl+0rxect
 fQ/bYjeZii4Q9mf8AFMatoYDQWQc5eZPyJw/LM+xJZdou6BKqsHU/RSEeAmpA5IK+SrK
 ZsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756902929; x=1757507729;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lAi775/pz4+zzhS9cVzcoZx7x5i0XxhOh/w54AtMIsI=;
 b=ur5NKfod8xGhGg55pc8AHiOh8ZGua+rTSE1pcOO9AaqS28DoWBCdC+LzNzXzrT9Cyr
 NlvRD0WTS0oM8itn3Ff8fjj1yy+5KjGPOJMADoHuyHbhXhKSYiQPBt0JUwRBCyevMr+D
 9W7e7MhJNyM0/pRxchMsoNs7Pq0UjFkHGXctK2gU5IfX5g6/g7P+9iaHx9kLKpRQSLa+
 3WX1I2rU0/MCDoAFgwfNeXAy7GHEB5oZglr0jkTti2O43WbzBIZalWGL+a0eKHUfzH2m
 /trPFDeAqOWN98ZvTOsKmSYT3vKN5EZwDpvrGtNNWvPWVmeP1Y8bTHS5fGx+eq3LRcI5
 lVHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWouvBXiApu919M3YUIt7YtYxGQTI9+DH/+3epAFodrDaLBPPHJm+I0gNJHGdRj2aYFRtiIr//9mhQv@nongnu.org
X-Gm-Message-State: AOJu0Yw+j0XeizZv5pov/SWZRNq8CwqXTwH7WG/GMuywpbMGbgGfwcyT
 1jE5AwphJSIvYoIH95085VUWDNKXCWbktR2DdxUrBth7BFo41LJa5uW2oy8tApUzJPg=
X-Gm-Gg: ASbGnct9YNBlW8bbpwSH0PwmVBvZL7K8vNW7ve5WsnjMfLO3vTRRfQsBf4sKCRnSxDp
 oXrQJ+Enf4UZzsrdsLrgmNlYlpK+QGSvitqdz+GVcyfEG5Ik00S1LF2a42uwXxhH1mz2+6DRY/v
 i3Rm+yAXy7ncHqUQJ+fO1ZWw1/ZYuD8MJIodMI/n/yNpIsNAjckcAZaDDaPGXN4Zftun2TCXn/F
 aBnQ7NAyhVMMMvvc9IZ9LiJz8n+5OFlHHJn+n0CDlHVi+G9osKaC8kFPVQvkPKVdiaLCmuEJlAp
 yoYh0m/MaJgFv2rdkj/TgPnEEHeHhOW+EcbWfPpYbNA5H7iK3gVrfhOJQwy/w9uP75A7Ro6VKVX
 xoMLQwbd9l6IZh2xUFLmhSfcviWcaI25je9QIcnfNmbxlI7Slf4NaBG8dZH0YYRQbCvAzzP84Ad
 hvSehSqg==
X-Google-Smtp-Source: AGHT+IGZ+OfpjYfRFYCq8E6uT23A/mnfFnIlFQUang8AVtbHAle+m0HInXFc1vGtoait1HGu5XCNZA==
X-Received: by 2002:a17:907:7ba0:b0:af9:6bfb:58b7 with SMTP id
 a640c23a62f3a-b01d8a30045mr1524906666b.5.1756902929081; 
 Wed, 03 Sep 2025 05:35:29 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b04709b3effsm70971566b.5.2025.09.03.05.35.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 05:35:28 -0700 (PDT)
Message-ID: <04646a75-5278-4244-b578-e52ba951afec@linaro.org>
Date: Wed, 3 Sep 2025 14:35:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/24] accel/hvf: Implement hvf_arch_vcpu_destroy()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-14-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250903100702.16726-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x634.google.com
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

On 9/3/25 12:06, Philippe Mathieu-Daudé wrote:
> Call hv_vcpu_destroy() to destroy our vCPU context.
> 
> As hv_vcpu_destroy() must be called by the owning thread,
> document hvf_arch_vcpu_destroy() also does.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/hvf_int.h | 3 ++-
>   target/arm/hvf/hvf.c     | 4 ++++
>   2 files changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

