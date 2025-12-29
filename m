Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56DEE92FCA
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 17:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaHSi-0006sp-8b; Mon, 29 Dec 2025 12:55:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaHSP-0006cX-E0
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 12:55:06 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaHSL-0004oX-Dj
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 12:55:00 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7aab061e7cbso12551599b3a.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 09:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767030894; x=1767635694; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GYQJIN3N003Jiaq44UoCSPHrWkIZlb0Npd6wbYqgtTA=;
 b=qnQujXAf/GoFUI9FmYyCOPuKHGSz1PHXDsqWEF/hzRW72vs4X+IHUmiGToPAFYnXQm
 RUPZV+L1UcbzwV1NQsAO91m7Ogt3bviCf8vC4nZxKtPBO79BuDs2BGcHTWPWOyj7WU4r
 o41PKUL3AKUyJRhmLcv2Z9bjkB1Xzy/66vETEWdY+Lni2XQ6d2o4gpbjyJ+bNBcGS4io
 ajvZX21JlruxtYQeGNpGgj5/bgJL0fgS/E81wJwDypKwGNSvkM1HWLOK9B+T6lI0X5uS
 bNb40NasvppprIXdF62KxBCfeJ+rlJ1K04H4rVF+chmP9yTISxVTEQGHDR9Kz7x0ToZG
 A/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767030894; x=1767635694;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GYQJIN3N003Jiaq44UoCSPHrWkIZlb0Npd6wbYqgtTA=;
 b=RmjIcIexzgKPGAajfUzXNdd8iVugZGxvcrScMmW4OCfJNvOmOwHL4e+AGEnAtK7IIK
 37R/i41DFK831nwiZL81B7skKsoupyEvi3uTNw4FyEdHSWwmleGeCBSleh1BsycBU7PT
 GcPrA2MoDjw3iv3ojTTQSnLaWhtNVvh0lRro99+vLCzDsVCeP0s/H2jnXwiP6/kiQTQI
 rtUam6wFvLx5gA38EeA34dpqrQee3jpoK7y/4FJdWmP2UEq1SXKavZDcDJHVfXX0t7J3
 bsGy6OQPk8fybIX+DhjlT+roUD0NcWSmmNJA4TiRfO/If0nTkbDlWGhrzqmLLJOGayOn
 /kIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWuqSMdfwX5YLBBy+5HWJfE2OolSW3bnthbzRR3vqLlRTa+m75OY8ecSMiWIPAevXaf6xsgOfHN8/4@nongnu.org
X-Gm-Message-State: AOJu0YwfvtNYZ6VFsf9rgL/DKQOpcUMEM3+gDvgzsMpvc6Hzz6H1INIV
 yUVZxaFXGJq67oozVFeSrLFe/qVddGhC8dd32zC95EJgNVIx5VeAWbNyZLTiZFHyBQs=
X-Gm-Gg: AY/fxX7qckRrdKCFiSdmxviWeZCHRjHe/9l7lhh7974zwk9+ywu75Sq4oLEKM4IMsZN
 lRnrRGvaKdzzyyESR3QQn1SQjY5sr+WXdHIsrm7F7TZrHJ4wHlaeHwWGa9JmQ3c9omCoALa6u34
 niWO7PTT+/fO7E0Hfe7fGzk9rHREK/fl84cShz8z6U+szzSVyYvi7V5BnZcrI2JhJtJrpJE2l/D
 1hEoXVurEZdWOr2IPTf9Dk3H8buTbPiZunepvwKIb2BJMek0ked6/dy7qK51E4cOTw0ahyzFg7S
 mYQ7Xtmj9dx63VlaY8LLSAM+p8qDtZx7NQqHjWBGPVCX79F/enWG2crrQy3b8jl8ES5AI2KsUPo
 LIVR5mSOjLyf7ajQXyTXfbjQcYhtOm6PYKNm9Xcvlrr3lVuS20B0fTEeYk5y1O+F16+/rv9t6l5
 m+lkuhbs8auA50VrWmu6nWGuPXCxAH/8qCW2jIMShua5p4gO/wzdfc2WjS
X-Google-Smtp-Source: AGHT+IEKZHs2pS6BNNt1GybjHDp4orkhKQ29/lQ8hAEBaQVijQHH0IVExd1f+l7lYmSNDJ+IQ3yGIw==
X-Received: by 2002:a05:6a00:7613:b0:7ff:acc3:2f40 with SMTP id
 d2e1a72fcca58-7ffacc33e69mr22056701b3a.26.1767030894257; 
 Mon, 29 Dec 2025 09:54:54 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7aa328basm30231550b3a.11.2025.12.29.09.54.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Dec 2025 09:54:53 -0800 (PST)
Message-ID: <a56f5bd7-92e1-48ec-9579-4b67dedb65b9@linaro.org>
Date: Mon, 29 Dec 2025 09:54:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 17/28] whpx: change memory management logic
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 kvm@vger.kernel.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>
References: <20251228235422.30383-1-mohamed@unpredictable.fr>
 <20251228235422.30383-18-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251228235422.30383-18-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

On 12/28/25 3:54 PM, Mohamed Mediouni wrote:
> This allows edk2 to work on Arm, although u-boot is still not functional.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   accel/whpx/whpx-common.c | 97 +++++++++++++++-------------------------
>   1 file changed, 36 insertions(+), 61 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


