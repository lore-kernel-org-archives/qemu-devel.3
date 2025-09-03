Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF0BCA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 10:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utkTm-0004Fu-Bk; Wed, 03 Sep 2025 06:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkTX-000425-R1
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:12:25 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkTV-0000mD-8M
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:12:23 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45b9853e630so15787095e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 03:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756894338; x=1757499138; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9/IZWFrW5IhGd9GyKd6ZrmUwMraLMxhPEYvLIzqwP50=;
 b=TcyKiQtryU7XlQHCnSn5wFgQhJDGqlm3p2+pLZ/Mvh2Yq3KBtVivTnMtRBfog7jWeV
 obn/5xkA58QaXD/oPUw4bn3+R9szZaIxjdBjnN5q23vDQG3NF154dDmEmx2kgloRkSbC
 eLIaGYH5oEUAER9TcbvBbFiu+st8P1gJK2HqtXGzQXfTS6+QFFv0pFltlj1MomCBGG+B
 AtDsxJZUgnqcXmxwajk0F6CmleE9FGGQdsvdU2JkD7B0EZ0KVFrBw2Uv3AhVCUzrvi0e
 f4MgwfmJzuMF8nAtc8t049CorZzSs9HSWSNdhDzVMJx6heyFbqldHDX+H9UrWjM9GFEg
 //DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756894338; x=1757499138;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9/IZWFrW5IhGd9GyKd6ZrmUwMraLMxhPEYvLIzqwP50=;
 b=jvhrd1+OlegjueWK2PiJf6hdpnsDzaYN21NcLaIfJfDmLYbOGW8SkgCEF1lSp4CXia
 HfBVU4aVCrDMj1Qhu4PFpKDYI58hzBblObfFT72Ii2lNoC9UK+AnMCxUbKFZkGsZSqyn
 HjcaO3guavSMOLmKzntpjBoBX3LKhZ3zVuyuwvkvaoj9V3jVyUcN+EXGtKUM1C+cDRvv
 l1Fwv+punsTDurUlubgfwDJ2KPlvBybCN7veRZvbv8V63vE/eEBZ0SAKpQVT4j9Xm2iN
 DyZ1C2CDscIojnL3cqQg7yUSfWg/CBITouPfkbOiAt8lW2bERvEqU/t9U4hH3KZ6fY4O
 3QMw==
X-Gm-Message-State: AOJu0YyyJisB/28c4C+eLj0T/XMdD0ajhjqa2oT1srvak/aE5XLtE87M
 +xvGxwCs65m49lPAl3Fzddy/F6TIl11XYnXjhYnGb1Tcwt1qt6FUvHEZsk4/GaC0WYmZ/BxkXcZ
 Nhf1Ezhc=
X-Gm-Gg: ASbGncvx6131RvPL0BQnQvHBwPn8TVO7birD07WMsMcJcFGKjm/xqJzXGZj6RKiH6tC
 TnatPEWo+66BmQXDMWZ/Gk3Jm1Y07LKsYbyHj0cwNLXlAB0Bpsc/ynvUbgWryzMo0SahjvUTsen
 kg6dMtWN8ku+tBzhPiF795TKaoxQcaOwyjdHa1F9c/EV5POeNoZwXZUoO5PM6nkBA80oirpax4b
 6As6oetqtzBuP2B2y7fSQqOQAKhIe1ShjYi4zRHYOM7LvqeyV1kJP6v7skNPSLrjCUHaiPv7ReQ
 L6cd0TQirtvq1hgofv2krQX339xj1WT9AwnsN7oq82S0pIcK/j04LDEK9gWAJ72uOkx98Gjzf0F
 Hxd2Z4dCXVEs+vgZkxYQb81ySMfGafDNPJb2rmK75E0zRFrmokzTK1V3qva+nszayWmXBvotNjv
 YnnSHfM7u8
X-Google-Smtp-Source: AGHT+IFQZCg+j9rYs2aYBlI/Q1NA1vnuBlYKk1ozog9uwEkCMROYvZbO21Ukdei2AxevzD1AQ1HalQ==
X-Received: by 2002:a05:600c:1c03:b0:45b:88ed:95a4 with SMTP id
 5b1f17b1804b1-45b88ed9c98mr99009275e9.26.1756894338501; 
 Wed, 03 Sep 2025 03:12:18 -0700 (PDT)
Received: from [10.223.47.213] (98.red-88-29-180.dynamicip.rima-tde.net.
 [88.29.180.98]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b96d2a6b3sm38538005e9.10.2025.09.03.03.12.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 03:12:17 -0700 (PDT)
Message-ID: <8c66b4c7-a5ac-4e01-a226-61e2e0435418@linaro.org>
Date: Wed, 3 Sep 2025 12:12:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/24] target/arm: Add arm_destroy_cpreg_list() helper
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-25-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250903100702.16726-25-philmd@linaro.org>
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

On 3/9/25 12:07, Philippe Mathieu-Daudé wrote:
> arm_destroy_cpreg_list() releases ressources allocated by
> arm_init_cpreg_list().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/internals.h | 2 ++
>   target/arm/helper.c    | 8 ++++++++
>   2 files changed, 10 insertions(+)


> +void arm_destroy_cpreg_list(ARMCPU *cpu)
> +{
> +    g_free(cpu->cpreg_indexes);
> +    g_free(cpu->cpreg_values);
> +    g_free(cpu->cpreg_vmstate_indexes);
> +    g_free(cpu->cpreg_vmstate_values);
> +}

Please ignore this patch, it is part of another series related
to arm DeviceUnrealize() implementation.

