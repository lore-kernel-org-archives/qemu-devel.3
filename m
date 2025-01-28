Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83028C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcsad-0001x5-8q; Tue, 28 Jan 2025 15:53:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcsaZ-0001pd-Hf
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:53:41 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcsaY-0001Qv-33
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:53:39 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so1306535ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738097617; x=1738702417; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SVGsgP2JxnTbIVukHbum7BO51ahJ2agUN7ZMpTkHHzw=;
 b=C2J6AGSd/OXUn93uVNKZFv9Rvf13vt1luKcNzcJ5qY7ZFjYw80442IkxJRDK3ZsTUf
 ciHpncurQqAn9hnuhyAcXWXTOvYLybqu0QbkzdWMS07nSUuIJLO4gCuxTB4jMLlw5my9
 QRdAAfOhN/V21lKD8IEfc2bCI6PJ324AHyeaJEaJEVHhNc27j/XqxvjVOyPAbYbFtPRa
 Afxw5fTxeFVgmvsrb4Wp9gyEWZH5lJjedBYmphGFDzPmXCK3uBwsRby56b+8sk32GLtB
 D6jptp9+c+/OJm2YqbZU4z3+aW8TriHymC6ooc95+zqXNNbgCoecq4J24brxZqDXTB9+
 g1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738097617; x=1738702417;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SVGsgP2JxnTbIVukHbum7BO51ahJ2agUN7ZMpTkHHzw=;
 b=lRMGtdlSVdA4gCoTVxVwoOY1H9wmIsUw9qIMeqBzvTKkr/0UzZ+sBR2FC5UemrJdZk
 wBauQFkktlT8jKz1vZkMNwX45GA8eHLqVHHkQ0Z9wE/uDqy+gwdM+YsOfmkqr3VzME86
 AWdD2kleeWCZZhxuaUcU1Fp6+g3j0Cavafv9MP2boVIFfTq5sVknG36/b0w5CK+rc6vv
 mhhFIDtKmxxWgrFPCqJIG3goSd+QKQSLNFS6gTJIxhdIvq8PE1N3H5wm2Yj+x0iDm/nP
 YcqW7A1sSUCKE0m4CUjN/jbaJkzoRVgbqA51t1iYIOaqt7G+yw1cHk6Jc2IQy1v/wzCG
 Q9WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEpHAk9HEvGdUe1dfdUEnp3lMrmfgrHQvLOP+eAwEjoQNcNAEtqm2KFF2q6KY01KqM24+WFppOF2PI@nongnu.org
X-Gm-Message-State: AOJu0Yy38LrnjFYOCfZDA/mWYUiw0cpHw8/AE70yGkLZqrV1PhdnBN7D
 Dp4Wknan2x2NI+QuodgVpadCWFqyog4Whc95DzNvWEGU2K2rBY/ICIDWCGVUfQQ=
X-Gm-Gg: ASbGncv2jpcsPvsP0Fler5eORRW8/0uiuLuCq771V5jKgR16yIsxlCD/kcLeAbbtF99
 Ss4Ch1aSJATJqV2uyAwqHsqtSRZ0rBubnivqjhlvbanIpX/LwFAVEBgNnBJ6g8ibK30KucDxMvO
 RGTBJszqMY4qt/w1stskJvNTcvWCqIgDIigaL/a9lZCZD5vBeH6f4rQqtCipMif1I58UCnsIH0Z
 hlKbfrmv85jH+xbBF4AVtszq72cgdlnas33hEQ9n51Mw8ShGrKY7gfCunNRJnpVnjU3cuDSjEl1
 r4IIG/vRDi/PeY2zPhd0nFJkeF9lw92MRFMG/lGkwe8FikSQrzpxGIdOJyiULjVjbS7J
X-Google-Smtp-Source: AGHT+IGynnfw6l0HWGM419rZ6NjdwyyMXK8dmbERaW3Nncp5VQsCdqzgSfuOiObtiy+GivS9eKjeqw==
X-Received: by 2002:a05:6a21:b8a:b0:1e1:a449:ff71 with SMTP id
 adf61e73a8af0-1ed7a48c8c6mr1126983637.1.1738097616739; 
 Tue, 28 Jan 2025 12:53:36 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a69fe05sm9732184b3a.27.2025.01.28.12.53.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 12:53:36 -0800 (PST)
Message-ID: <6b7d03ac-68d3-4fbd-adc8-554e815ad785@linaro.org>
Date: Tue, 28 Jan 2025 12:53:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] cpus: Call hotplug handlers in DeviceWire()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250128142152.9889-1-philmd@linaro.org>
 <20250128142152.9889-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128142152.9889-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/28/25 06:21, Philippe Mathieu-Daudé wrote:
> To call the hotplug handlers with REALIZED vCPU, we can
> use the DeviceWire handler.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/core/cpu-common.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index 9ee44a00277..8a02ac146f6 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -211,16 +211,17 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
>           }
>       }
>   
> -    if (dev->hotplugged) {
> -        cpu_synchronize_post_init(cpu);
> -        cpu_resume(cpu);
> -    }
> -
>       /* NOTE: latest generic point where the cpu is fully realized */
>   }
>   
>   static void cpu_common_wire(DeviceState *dev)
>   {
> +    CPUState *cpu = CPU(dev);
> +
> +    if (dev->hotplugged) {
> +        cpu_synchronize_post_init(cpu);
> +        cpu_resume(cpu);
> +    }
>   }
>   
>   static void cpu_common_unwire(DeviceState *dev)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

