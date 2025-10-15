Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E041CCD194
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 14:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v92Ok-000266-1A; Wed, 15 Oct 2025 10:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v92Oj-00025p-0T
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:22:37 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v92Oc-0003LT-Ns
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:22:36 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-426ed6f4db5so592544f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 07:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760538143; x=1761142943; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yrrBWw3LihWXb8dKwlQCxt/zOTqqanWRMwFtwAtrgwA=;
 b=YwTczBlj3ICiNtqs4FTT7NFSQckTHy1O/iNT6SLEoiC0pBDXw4OvRR57WXfcB6TagX
 VYNf2Zi+CGx52njbJpRhbAakwnFhAPlfXA1zKWAWJfArKirmPejjZCEO6LRYwW8PUYPK
 stlkv4pvG/8wueziPv2pGAmienbvzZvMF5jWp06qORC94WsndjLoxADtxJHgmZM0d7K8
 IGOB4x3Vu+GVwuWxuKo7Zr8c6SkP92sIPoR7iu7LLQgf4z9gkvCjVxeVB9siQJg3cE/Y
 /4WeiOEe3LhQkkw6KYS8bAVzYTUImPwN9KNPHWo7XgtScs5IWAS0XFTaRaCyW/TWjIWi
 Wvag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760538143; x=1761142943;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yrrBWw3LihWXb8dKwlQCxt/zOTqqanWRMwFtwAtrgwA=;
 b=PBtQrB6U4FeFEXF83XdOx36Zh4YluNUitr1YpIn5pnktfHQPd8EP8RR/8osfUvH9If
 2W9k0lm+xtSEMuNwyzEisq4zItHjhZh2N2HcFToHa4KOa5tuCzDi9wLLkG4GK+hHqtXN
 wwjBf8c7sMN7seU1ychA/vgD6HlbTnxBHNWXNj7uHNJq/kUUr//1t1FpadvJr+pUCquj
 dEsjqOlJPsTng0HhCnqLVmon+/ikVz+ECP7QaSR5X6DoYE2fI5Q1OjpnnDraBVOTyYA8
 aO9RiYmITTU5yWy6aZY21CMNVLOHLVJXTwCvYgXXWV01LpySy+lUF544AWuqxntuQSEf
 EvXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5E4Er5IfMQ3QXPU3/F+t7XSV+pOio/2oF630312gwDNjUOemwkQ0dz/tBz24ZeDipEOCa05MEIqS6@nongnu.org
X-Gm-Message-State: AOJu0YzjiI9yDKXUV2A1ULWLr5F7LFcP+A5PVKWgR/GOdMqVl6v9lYkr
 ipUpJ833XZGJRxLO7yjgthotoCb84JuyXH6JGgABGseNdWF59NGUd/RU+HXC1Ukfdbk=
X-Gm-Gg: ASbGncs/JcNgAAvOFJvf9AcHDgcT1/4ALjE9THNxCI0HapRkOQG0CCJpN5AO7vjHC6B
 4vnawRyo4sOjdFqGdQtRkuKeEPD6fszUjIr0g/vy28UStYNbdc/jUUllTJKS+w9darBxHy3mF2K
 UO3b/UWLZo1gU33ERgufe4/J1brU5YBCHpQczcedlMDr8Wp/QeCUs67Su9MQrsCDMDVsx1OHZu5
 qJ2K1N/VlZ0Z2oxVQUpTkDQZP1enLgRcy8MxQQrr4UnJisTUJ31okHz9pqQWcL97tGo7E7cA3vG
 4Kpe/KGEyiY55npBRu4iUnECHBdU6EQdlAtoFiJkJlzIkEPjnqcqRfiGyN5yQxnQvmRNo/vRonm
 Gdd0hh7rZaAmwyuaDq5eYIjFCVMLicQohZlvozI7hbUQqj0PaBcMcHDMzaEi3TNnbAZWQ6NiROb
 5PnNoh7XroJ3qz
X-Google-Smtp-Source: AGHT+IEO9Yann+gO7IyjmKy6QdT+ab8p19mQ13nPHMk5XxzTY69evZQYHUGSClFJz+AaHqlSfX9p4g==
X-Received: by 2002:a05:6000:2f82:b0:3ea:fb3d:c4d1 with SMTP id
 ffacd0b85a97d-426fb7bba19mr201313f8f.18.1760538142963; 
 Wed, 15 Oct 2025 07:22:22 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426f2f72e18sm8174191f8f.0.2025.10.15.07.22.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 07:22:22 -0700 (PDT)
Message-ID: <a12f9dfb-a4e4-46de-8581-128372150efb@linaro.org>
Date: Wed, 15 Oct 2025 16:22:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] hw/riscv: Replace target_ulong uses
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, alistair.francis@wdc.com,
 richard.henderson@linaro.org, palmer@dabbelt.com
References: <20251015-feature-single-binary-hw-v1-v1-0-8b416eda42cf@rev.ng>
 <20251015-feature-single-binary-hw-v1-v1-2-8b416eda42cf@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251015-feature-single-binary-hw-v1-v1-2-8b416eda42cf@rev.ng>
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

On 15/10/25 15:27, Anton Johansson wrote:
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   hw/riscv/riscv-iommu.c | 5 +++--
>   hw/riscv/riscv_hart.c  | 2 +-
>   2 files changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


