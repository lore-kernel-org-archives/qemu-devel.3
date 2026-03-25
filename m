Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43640FEA83D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 09:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Kyw-0002Wq-2A; Wed, 25 Mar 2026 05:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5Kyt-0002WY-Pi
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 05:56:55 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5Kys-00074B-Cr
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 05:56:55 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-486fba7ce4cso21703335e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 02:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774432611; x=1775037411; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5g0B8H2F+sysjektrId4PyrhfUrsLAVnGGc5jrOOfys=;
 b=vVqhjX9sqo+zB3ahXyBtzKHuaXS7a5om35Hz6zbHvaxE+ZdBMqTdIMIFQJbXjas4FM
 TtCBZGifO4H3PBeUocdL5WfgBJJ0SS3EgiVhht0WLaLMQ5Vsct9h3zpWosjHtpMrLQ7K
 Ib3v2knyu+7fyUmejF9K1aRiKeQYFOWLj/yKAeqkQ7gw/5J7Z3RVl4On4m/Z2CuFLHfq
 Nw4tExAJAWkVL0AOGuO/ymrmWphTgxczI32zCSlY0zBnGX7xfA5Vjw75P8AamxaJuh/f
 +pnXoS82/Ss5o5jVG0P4uIwg/X3lXSXabjEseS/hinuPdaJQwiOuW91GionRuJRLq5lz
 h4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774432611; x=1775037411;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5g0B8H2F+sysjektrId4PyrhfUrsLAVnGGc5jrOOfys=;
 b=lArJfZOU+M/SJn/UNU+jT1/+bd8ErEmWMetFtgImGSv5c95LufOByZixea3d09VTiv
 K4+BP77hHcX43x2tT3XyDZ6jiQ8E51LQX8W2h0eELeZDlZ9ad1HT78gVuiLU7xWriboL
 +TN6+KrOy/hAzCr/SChWwMvBT9bmOjsTob5ehz/+uILRHcpaSSfkcwMPLjiIDhPl06Qh
 1XImBHCVXIltg+4gn6HbgZO5ZqlkdGqkgeiEcd2cl6uo0APX08xdHvU5Ph8kC7tHCk2U
 xeCJjqyx/sztinCwQVwaPUFivubeTjPmyM3lxlyjzWcqxzT+nahkDlx/v+EQS888rNdt
 zgMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuCrx2FK/wkd7eCyAwF6qKo96L0icpQu9FWLlb3o/ENsT1/jW9L21QQGxLen9PT9O6lyTt6LxSD/bn@nongnu.org
X-Gm-Message-State: AOJu0YykvhQqu/sJvmxCBGls3JMqMq7YTzJJ2uErCLAmnSBGF8xUu4oS
 AD/25xVNNE5uyXUWivjNxrkR+pHQyNLhuACPNOnE625DQcEK7kiuvjTdNK2zgxRYCy0=
X-Gm-Gg: ATEYQzyTVSvyHzo033sXge6raWn9uht3McVVIDHj159QiOvg9pAuyoF4eI9IhVEzu6g
 p6FOgpKpJzMAA93ZyD30RoBb1z7v7NnO7m+skzk0BoE4gu57VXiMG8nKtBucln376/ENWmnKGaS
 BOZjFXHrfPsfItlpT+WO2Y2+iay9ol8PzNAVywmm90GZyB9DiFhXt84dI3KipQ7iiEDcg3kOPqP
 MpDCol9Sj3IRhSzTbAkmAnr/Ss4ZCdZIORTOdUwAy+AJyd8ybzkMwC1cAA/ImLKpb2kqwf3i+hc
 QTqLxUuIJPNkR/KjhPpW/oURwRz5/WU7DXvg9EKrvZ4M8Q7wx6ULsc+aM5LqX21Bfu4vBJxqJTM
 ubHbEvlnxiz5Afx8hTYoTjxfW6UtQD0LQE9Rd9vxZNBfGTsceLcakqpEW+TUqgAu5MuxcOUMI69
 cTbNOIIABuqemNrci5UmH/m8zhnesUu5S91A5oBhjiajx8sxp5eXn8SoNOWTELN65jr6RrPCswE
 Ivs
X-Received: by 2002:a05:600c:4f89:b0:487:1c2:6a79 with SMTP id
 5b1f17b1804b1-48715fc39d3mr37961695e9.1.1774432610819; 
 Wed, 25 Mar 2026 02:56:50 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48711693a08sm162176445e9.2.2026.03.25.02.56.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 02:56:50 -0700 (PDT)
Message-ID: <cc41a837-e53b-41c5-b9e2-c090d0f57395@linaro.org>
Date: Wed, 25 Mar 2026 10:56:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v7 6/7] vmapple, gicv2m: add macOS compat quirk
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>
References: <20260324204855.29759-1-mohamed@unpredictable.fr>
 <20260324204855.29759-7-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260324204855.29759-7-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 24/3/26 21:48, Mohamed Mediouni wrote:
> macOS expects bit 31 of MSI_TYPER to be set.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   hw/intc/arm_gicv2m.c | 5 +++++
>   hw/vmapple/vmapple.c | 1 +
>   2 files changed, 6 insertions(+)


>   static void gicv2m_set_irq(void *opaque, int irq)
> @@ -81,6 +82,9 @@ static uint64_t gicv2m_read(void *opaque, hwaddr offset,
>       case V2M_MSI_TYPER:
>           val = (s->base_spi + 32) << 16;
>           val |= s->num_spi;
> +        if (s->macos_compat) {
> +            val |= BIT(31);
> +        }
>           return val;
>       case V2M_MSI_IIDR:
>           /* We don't have any valid implementor so we leave that field as zero
> @@ -173,6 +177,7 @@ static void gicv2m_init(Object *obj)
>   static const Property gicv2m_properties[] = {
>       DEFINE_PROP_UINT32("base-spi", ARMGICv2mState, base_spi, 0),
>       DEFINE_PROP_UINT32("num-spi", ARMGICv2mState, num_spi, 64),
> +    DEFINE_PROP_UINT32("macos-compat", ARMGICv2mState, macos_compat, 0),

DEFINE_PROP_BOOL("x-macos-compat")?

>   };

