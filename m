Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413E6E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 22:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQwmU-0006wv-Dh; Thu, 26 Dec 2024 17:56:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQwmS-0006u2-9f
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 17:56:36 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQwmL-0005f2-BQ
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 17:56:36 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-219f8263ae0so43530535ad.0
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 14:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735253786; x=1735858586; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OnV6u3+nfKWuKtFOAsMOV2oEcpMmocVR6sSgqBRQgSU=;
 b=k2o3Kwadt/M4vxeDgozKHtBXO59wRCHkOW6EGH9mpuGGwmSvuibIHDmK+TnAu9TGGn
 rhStJ7tnkh2ZqlzGDxnbfsn8sCPVQ7yQPREO/5JEBh1sNZIgexyEEb6xD09J5aLwNuSF
 A/G+rSRe/BYfbiOw68d8CjZ/8nB9FU6HKKqTg73P1BSISnXu+Prd5QMeMJYNtzTtLhuX
 A3gYwNxga2gInSHQDq6m1OMcUrn1XpOxSmKXXXDc1BDacDt4lAjzDmUnf8KNzeLjlSjG
 TBAO6SfJSZOBSqxNQSGZto31AKxYAm6kA/0ask+vaGJfWVCiW9QfYByhVmh4cdyIsSUb
 4sPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735253786; x=1735858586;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OnV6u3+nfKWuKtFOAsMOV2oEcpMmocVR6sSgqBRQgSU=;
 b=ZQ556xgkqob/yAaBegT+7hmj3/fcOiGoeXCX0rk0e0g6WJ5DLC833PYJRM+mkQ3PJp
 3trGuF/daIfRS3I5pzBkyIQhWXzekuX5mFo+1hbC4E4WO0el2JA66NbouBEYQzZjErx6
 gBbkznysNGxiPol/iw2yrF4I0XERM0OQiM+qVh8jA7xe1eW7pK+j5oLz6Ms0FETw+IHm
 MTCj3MQL17gUJL8oZwkajM1ZlKvBqWm7NykVzCw/7IJsHs3pvae+HfM+qIjVhAsGiRdL
 y0geCbhj0RmDef+Ix9ghzHcJuaLngV1U4KsjOqvZwBipINDHSrIXHXwhU1XYl9bM/3pE
 JOKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE4WSRD29vsfE8M+ffy1BbBgg4JEz8yH/TNs3TVBAqx3XsnsjxapXvY9uBiPjGsEvJEXjt+A7GqFKO@nongnu.org
X-Gm-Message-State: AOJu0Yz8iUPjI1YMAD9+Ma2ShXnyxCNFCkEdMOCRz9QHrt7AHX/KbJXy
 k/hb9g1LaQZB4HQdmIGBtKmySBzPVfSBq5LR7RveUe8J4Q/3m2r6CPfjX0FAed8=
X-Gm-Gg: ASbGnctGeGuSZPZ00ZMXi9v8t9iaTWzrf0aXFU6pZ/b4C74SMUeuurlasMBcKiD0Kle
 luyi9vgqpC6RUV8YuXYblMegC5cBKOAZ+acj+wbEl1hnSgoW83X9muDdph5bSc8yoQSR4yAUWJe
 BU2xMljTpzwTMyJN4cKbU6NaBK/DX3AkLtehjduCdPSu6nV0zGDX9Gzo3NlvryyoS5dg+BIZabR
 GTO4MQXH4w12R8WLJ6LgWagQXvuyEoKesnnk0r9z1yKLvrhywYGsejIsYlTkCg8zjn1j6Edl22h
 v3PSvxhnwIMzSy5122i7lhN6copL5A==
X-Google-Smtp-Source: AGHT+IH2gsh01F6eaPxTfkahBsQq7GUkn9UimKARLVfSvEI5O4RanIYyUXaJgRxagqjc9HWKTROaiQ==
X-Received: by 2002:a17:903:94f:b0:216:393b:23d4 with SMTP id
 d9443c01a7336-219e6e89543mr364676835ad.11.1735253785954; 
 Thu, 26 Dec 2024 14:56:25 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9d4441sm121334335ad.129.2024.12.26.14.56.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 14:56:25 -0800 (PST)
Message-ID: <189159ad-0b0d-46db-bc58-c7e1f0ef9bc6@linaro.org>
Date: Thu, 26 Dec 2024 23:56:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/23] hw/loongarch/virt: Default to max32 CPU for
 LoongArch 32 build
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
 <20241226-la32-fixes1-v2-20-0414594f8cb5@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241226-la32-fixes1-v2-20-0414594f8cb5@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62d.google.com
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

On 26/12/24 22:19, Jiaxun Yang wrote:
> la464 CPU is not available on LoongArch32. Use max32 which makes
> more sense here.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   hw/loongarch/virt.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 3a905cf71d46e3c5a29672f7bb73faedf1d29444..343d2e745e155d59f0ff17124b3c77ec9b3c111e 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -1440,7 +1440,11 @@ static void virt_class_init(ObjectClass *oc, void *data)
>       HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
>   
>       mc->init = virt_init;
> +#if defined(TARGET_LOONGARCH64)
>       mc->default_cpu_type = LOONGARCH_CPU_TYPE_NAME("la464");
> +#elif defined(TARGET_LOONGARCH32)
> +    mc->default_cpu_type = LOONGARCH_CPU_TYPE_NAME("max32");

Why can't we use it on LOONGARCH64?

> +#endif
>       mc->default_ram_id = "loongarch.ram";
>       mc->desc = "QEMU LoongArch Virtual Machine";
>       mc->max_cpus = LOONGARCH_MAX_CPUS;
> 


