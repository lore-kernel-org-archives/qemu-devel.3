Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B0DC3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 11:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDLu9-0007y8-T9; Fri, 09 May 2025 07:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uDLu7-0007xH-Gc
 for qemu-devel@nongnu.org; Fri, 09 May 2025 07:28:35 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uDLu1-0003Ns-Gh
 for qemu-devel@nongnu.org; Fri, 09 May 2025 07:28:35 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7376e311086so2933854b3a.3
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 04:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746790107; x=1747394907; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+9rueWZypn7lBwBRMEUinSSumAwKTV6EEpft5DmMmpg=;
 b=Ab6y+LgNvaJW4zgZvOgMgF9vteyBDA8K1MOPFAC3wK+0TYDQa9+ecv8O/PRuRBE8oa
 B/Zd9OAAVvYhFqPLnubzBhZyF9a4qfwK8d83L05N6oISdYyeRzw72iHaN5OuSpFxU1RT
 n58VtbFfV6XwDLe2suOTZKSICbXMHlDF1RBC4iYuiNffmuOw+k34ftH3BpTuk5XP2qbk
 G3mHEr62ldPD832HQY9lc4LMCqpb/FHkC3Ml2VqGVKFev01LKLHsBE0pBffCl1ggThmA
 gNg6wz/p3jLHNy6xT5dtUqRWfuk+6qECZvkqpTI1oVqOlOQh6dBjxR8t88a1zuw0EMaU
 BVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746790107; x=1747394907;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+9rueWZypn7lBwBRMEUinSSumAwKTV6EEpft5DmMmpg=;
 b=RXRPnM7svUGISe9WYioH41On8f0iGQE9wfX5ED1MnC33PNrHBQougrGBjhtSUhknXh
 aU8b23OxmWvI1zzg1iPbfHeLDK16AB4KVe+3+GCBK2KA64U+er9ObFqmOvFkZ8jyJWzb
 Y4invO6b4DpTHsD9C1UbQU8SLKUJJh+EPvVXNZKAG5DU2G71/eR2b2rHHEQjp9VuYzzC
 tSkIhBsbh0ToDYJIZWgLnWINMjKUHUjVizkVG48V7yYBabQHGDAYtOSzOGKG/aX22jTe
 PArWnh1cokfQn0JC5JAaBFqBLZpBcvoPiR3X0QRUkeiW+b6IIZ3Ap53g76/pvOKT24Sk
 6QOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2wURswDo1A49FZU8zPgGoa88327WPPdJfycEAiocuuVIUPELVkuYIbezMlOiT+SvnqNoC+JlS4Eh4@nongnu.org
X-Gm-Message-State: AOJu0YyUNXPSdZkVh6hotJLh4nfvJNCjKrOmp3C5Bz4zdaGINRYCgvox
 PuGUGr3QoAPBEWsmm48r50XO5vDGeulnpY66WVSb7qjhv2zQb1tnikZ0/YBCTmsINzuLT4ktNpJ
 lD/A=
X-Gm-Gg: ASbGncuG9xYMHy5IRTviM1OKtFmGJiDHJQ/tMMMpjJvu4Rz8eOzlgaUrh7XBgrFLyW0
 OYI/DOQuVt/cVg3M3o+C30MIZ19hIDkGAsDWZi1CJpb3xNpaxaR8KCq0JgUtTrkGklPZOETlOhQ
 E+xNp+6ueC6uyS/NOjFWqijGZUizBAc1pr/PvwVF+tqIlhAe2SbjMK/tDo2AvFepMhQEhOvWqP2
 sJMF+RWqlYShiNZnqwf/QvSdiBaK6XWU1KMK2z/WoJVl68/9MYOHuYNAHvOziMi7OouHyTG0lI3
 4UK14TD93ypcjjY8chvol0phtWafOfBHvHqQ+CRuQVrupD8hrbgxo6HjIUr5tE77sMyGbLDTEk4
 Z+LAjOspkSwQ1AAwXa5s=
X-Google-Smtp-Source: AGHT+IEWV1t8e+NVc+VjZ2sfY0YJq09lquEpkfxHtUGj1kMfjAK1dUWyvkWrLfY9T8pBcJ/vxMZdwA==
X-Received: by 2002:a05:6a00:b95:b0:73f:eeb:84bb with SMTP id
 d2e1a72fcca58-7423c0050f7mr4377506b3a.19.1746790107155; 
 Fri, 09 May 2025 04:28:27 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237a3d856sm1553822b3a.144.2025.05.09.04.28.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 04:28:26 -0700 (PDT)
Message-ID: <6222ad86-ef37-49f8-9e89-997208123c99@linaro.org>
Date: Fri, 9 May 2025 13:28:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/audio/cs4231a: fix assertion error in isa_bus_get_irq
To: Zheng Huang <hz1624917200@gmail.com>, qemu-devel@nongnu.org
References: <b18184b6-aa78-4b81-b2af-96a5628f122b@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b18184b6-aa78-4b81-b2af-96a5628f122b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42a.google.com
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

Hi Zheng,

On 9/5/25 13:15, Zheng Huang wrote:
> This patch fixes an assertion error in isa_bus_get_irq() in
> /hw/isa/isa-bus.c by adding a constraint to the irq property.

Can you provide a reproducer to trigger that?

> 
> Signed-off-by: Zheng Huang <hz1624917200@gmail.com>
> ---
>   hw/audio/cs4231a.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
> index 5a9be80ba3..d390da4c37 100644
> --- a/hw/audio/cs4231a.c
> +++ b/hw/audio/cs4231a.c
> @@ -682,6 +682,10 @@ static void cs4231a_realizefn (DeviceState *dev, Error **errp)
>           return;
>       }
>   
> +    if (s->irq >= ISA_NUM_IRQS) {
> +        error_setg(errp, "Invalid IRQ %d (max %d)", s->irq, ISA_NUM_IRQS);
> +        return;
> +    }
>       s->pic = isa_bus_get_irq(bus, s->irq);
>       k = ISADMA_GET_CLASS(s->isa_dma);
>       k->register_channel(s->isa_dma, s->dma, cs_dma_read, s);


