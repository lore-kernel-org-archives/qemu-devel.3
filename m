Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03991E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 21:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWMqV-0001ZI-1g; Fri, 10 Jan 2025 16:47:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWMqL-0001YP-1w
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 16:47:03 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWMqI-0006LI-9c
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 16:47:00 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38637614567so1280401f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 13:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736545615; x=1737150415; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sg7wo5Zc4DNJh7ebpBH7rIAGSnt3xDSucN4q8Glzgic=;
 b=XEYqIXYxqUP3TB+B2V9B4R9/A2pgC8eaua7mxH0QYblZSuZunAvr+r4oAmjLO7vN3L
 K+I5sy/60bJrfiMORlabFa6250C23dy2LUQrTwQGzJZ24BEM59hZkz36wstwt6yXeqPz
 ohXlV8GaeWHV2o3Ljk9R+Y/J3jTr9bXryBgyksCxKTS3QsNSs4hyzIybA/v4Nl/Sq+/c
 xnCXaJFcQsTNppUXWtwDCOWU0b47N49FtvbMCSDQKsAeu/QZ29uvcJPrygeWtQ1tYWgZ
 QYH0+j8+1Kw2jY/46frycpcxGZ1FyByg02dTtgAez1LbZ9LLc4GqaxvF5ulGuus4wOJB
 eneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736545615; x=1737150415;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sg7wo5Zc4DNJh7ebpBH7rIAGSnt3xDSucN4q8Glzgic=;
 b=Hi37KnBBZzR6myf3ArYIpz44OcP0Ic3pdNLJXv5/fWx+DdBDVFq1zDggAR22QsP7BD
 MpWwCF+03RDscMvqO3PHurzTCqLsbtaqm35cQmgw7Kmc9bdQ0J+TBuAgCzxVVfFQYVsU
 bvKwz0klg7K91++4v0KFdynoajHPe8yxJkXJ0KOd30KLTdIQqdcp7Rlk36j9nRuUryEd
 G7ZDLI9mDqiwZaAGoSW9sWLFVFfNv2mNNCbNme3iXgxgWjTz/EMYELzWaECov+RHYIy+
 DRwfsG2Jdcwnpv+JFpxZb5ZiJYM0YMXayucdlJbk5iLE+mum8y0lgzAOMB/n383tiCNe
 9WPA==
X-Gm-Message-State: AOJu0YxLVQgQ3AsSULOLCSWqSGslohKDsJW6Bg3OAotaCOTMzDod3w28
 kBD/NpWM9AgTCXlPiUa84B2RuXma8qqCiCOMiAfsMhC+JQKb4rZHAHZdpOnwrGzmjK6u7AAJKP9
 oLo4=
X-Gm-Gg: ASbGncsT6cJNK3iLdWf3d/x+7wqw2GbO8NIG3yru267nmWJeR3KbcYfbbocmKZ/UGDa
 ZH/O0li39HL42VHkTQXeC/oOUZBuv8HJ7ZnsIc27FbdZkjQq7bE6pal9hg9E6RuUoKVWlq/sR2A
 KPkbxU+qdJUJpspzP/+A2tlEZ+5G2zSKWEWkeOoLdSBqu3EHBNE8rCAGgl0b7r0SZc+y086SWBc
 yuJ8KhJCe6IY2VkFhHlt1dluNJdh/F2pIU60HwS71kce0uNZKlmtjuSmF5eoEN3WU/TasHlZ7F8
 86LKTUrhiXEdMnzmrihaKXa+EwGsDQ==
X-Google-Smtp-Source: AGHT+IFFcvoGbysMdheqlXySBhP6rTRXeZb4hKaR77QgS5mwpFNTmd1xBGX9j2MKVcEn9J5RaSRgSQ==
X-Received: by 2002:a05:6000:1f88:b0:385:fc97:9c63 with SMTP id
 ffacd0b85a97d-38a872f6915mr9734937f8f.9.1736545615592; 
 Fri, 10 Jan 2025 13:46:55 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38325esm5497960f8f.27.2025.01.10.13.46.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 13:46:55 -0800 (PST)
Message-ID: <7be26557-2ecb-40b4-86d5-721b0c285f71@linaro.org>
Date: Fri, 10 Jan 2025 22:46:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hw/char/serial: Ensure SerialState::irq is set
 when realizing
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250110182759.84071-1-philmd@linaro.org>
 <20250110182759.84071-2-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250110182759.84071-2-philmd@linaro.org>
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

On 10/1/25 19:27, Philippe Mathieu-Daudé wrote:
> SerialState::irq must be set by parent when the object is realized.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/char/serial-pci-multi.c | 2 +-
>   hw/char/serial-pci.c       | 2 +-
>   hw/char/serial.c           | 2 ++
>   3 files changed, 4 insertions(+), 2 deletions(-)


> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index 70044e14a0f..562931685e7 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -923,6 +923,8 @@ static void serial_realize(DeviceState *dev, Error **errp)
>   {
>       SerialState *s = SERIAL(dev);
>   
> +    assert(s->irq);

Patch incomplete, missing to update serial_mm_realize().

