Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87BDC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 07:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta986-00047H-HD; Tue, 21 Jan 2025 02:56:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ta983-000471-5M
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 02:56:55 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ta97z-0006nD-7j
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 02:56:53 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361f65ca01so54136915e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 23:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737446208; x=1738051008; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3nnJzC/PO6uLiXSqil3pz4K7XaqHg0mQN6UMQeI9gOc=;
 b=UJPzfzfNq9DpEP6eQGyi3Bka9r6yPrnEHEQ1rCLfusJiXtWpKJ2uHf4QNySBunEEr4
 bhKmZCiwMWmGHx/4vxLIGKuHpBbZErG4xecapjcYgXWTJiOkD6hoZsJQxiF05Y79q0i6
 GlV3p3iCnVMnNcTlvabNf6CRlfaYwuJopbSMPnjzXtewCYxjtHf0Hm1gt40pvgunwEby
 dUKGNxyLivXKxxg+lBv4715zo/1oNKGtO8sFBBkqxkbR0pVM4RLlQ74z6Eez4vauU03a
 YWX4Yt23ibvqCP7btc10mqpwRm7zhvuuMOi+xVmcSAYAJq2zdm9HYYtkPl0vMOOGgzGz
 SHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737446208; x=1738051008;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3nnJzC/PO6uLiXSqil3pz4K7XaqHg0mQN6UMQeI9gOc=;
 b=qXf58rehapQJJMXfTkkfTjmgXmwj0UkRFhJmHY04aA8PYptxf0mnkRExGwt2YabluN
 gFMFtAhIRFECzczfL0ABMI4SNIPx5coK/dJ0D8OzlHEbHhisSxpIDVMT4bc2gMIn/MPF
 OE/ad/KW8S7mA7KK1L5tYX8vU77PElSSYBrG2oI/lVeSB/5+9SZsLS4v6uZUIAK3fO7b
 TA24usDHClRk6bWvSOTQWZTOaGxV0JPNtrWul3VhBhcbbpxuCQ/uvEJwzVN5p9s/u3Zv
 g8ozp1n8vR5AyHeAR2+oa3BjNDFjg6foSjtA2LwzjVLoW6if3Jeg2129Z+/ZwBFfF8Cd
 hZeg==
X-Gm-Message-State: AOJu0Yy1UBuvCQiGj6LT3AXrjIWy6aqdVcipT9aCTNjHdCY475fDbNJ6
 +e12KUvH0wZqTT0YGHveuvXvuacFbjPbvr9C5oBAX5QT+qNyakyjJePNcQ5juOF0GWkygCdfTX+
 HuJM=
X-Gm-Gg: ASbGncuZP8p+kSYGlkO3PKbfykH2nrqA4VR5Vz4oQw32mXwlRLVQ+TrWxn36bji8nhc
 bEfzziLfsUOm6bwQvYtoB1XHzMs1Mz0QhTJqOiYX0PfzQHM5t+U3rptzSCQp5X+YiJ1FCDni/Jg
 kGaP+cLASEXPfKBXpF7pZ+3e0xzaVZ0pE3mO+uXIGgAHW5HaA2aazQ5uJqAHS05qvCS53w6TBUo
 0xRnolXZJ8xw79B6DfSx7eURcONuWKwNOhjtaGXUXB3iy9w+JIqQcAj7sA9HzOxHj75KjkTGeiL
 gRIaYklUk/1NzHXbGcPmMp/humJlD4QdpCtnYA==
X-Google-Smtp-Source: AGHT+IHZmB8sGdXH6LISxwVv8YtnylU0j3OUp58d9CaxT7W3CO4jf88/c/yQPq9qXC80No0a/eZKaw==
X-Received: by 2002:a05:600c:468e:b0:436:5165:f1ec with SMTP id
 5b1f17b1804b1-4389143145bmr150550395e9.30.1737446206442; 
 Mon, 20 Jan 2025 23:56:46 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43890408447sm168728025e9.1.2025.01.20.23.56.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2025 23:56:46 -0800 (PST)
Message-ID: <6fce3a32-08f1-44f6-9e92-fb95c48ef66f@linaro.org>
Date: Tue, 21 Jan 2025 08:56:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/ipack: Remove legacy qemu_allocate_irqs() use
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alberto Garcia <berto@igalia.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20250121074412.70292-1-philmd@linaro.org>
 <20250121074412.70292-3-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250121074412.70292-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 21/1/25 08:44, Philippe Mathieu-Daudé wrote:
> No need to dynamically allocate IRQ when we know before hands
> how many we'll use. Declare the 2 of them in IPackDevice state
> and initialize them in the DeviceRealize handler.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/ipack/ipack.h | 7 ++-----
>   hw/ipack/ipack.c         | 7 +++----
>   2 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/ipack/ipack.h b/include/hw/ipack/ipack.h
> index cbcdda509d3..14540281496 100644
> --- a/include/hw/ipack/ipack.h
> +++ b/include/hw/ipack/ipack.h


>   struct IPackDevice {
> -    /*< private >*/
>       DeviceState parent_obj;
> -    /*< public >*/
>   
>       int32_t slot;
>       /* IRQ objects for the IndustryPack INT0# and INT1# */
> -    qemu_irq *irq;
> +    qemu_irq irq[2];

Oops forgot to commit:

   -    qemu_irq irq[2];
   +    IRQState irq[2];

>   };


