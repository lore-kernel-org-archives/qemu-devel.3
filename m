Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4123DC87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 23:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj4Dn-0003kV-MK; Mon, 04 Aug 2025 19:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uj4Dg-0003eN-LM
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 19:03:55 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uj4De-0002Rm-P0
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 19:03:52 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-458baf449cbso24019045e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 16:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754348629; x=1754953429; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NVGrd9yjfT3pHxjGFXLaE0sIhVqs1g8qtZf2BA1Hpg8=;
 b=u1b9nfY6QWBbBTvg7jw1/OoaBIMi6tVzGh7AQ9cISleT717WbadAqOP/7VJvzfO8XA
 XaXJUnLEgr0WUhwEjCQTUO/ve+618ahYw75LlNKGC8F0DZw49DfIuS3NEnzur5mtzYLt
 QDGWZmmjfafmSW6BNuCUXJHzA/iHwAOuJ79nZniSkh1qtuXyCXglKb3iu9vrKLE8zRTj
 Ww73w22HXvSec1qHhXMYRobWlS8XA/tJVONM4gjKYyO4F/8PQGdggWOlfRiLmxue3+NI
 zBXoh0lbxuHk4vWKWrijN4aPPMAeTOlPfRmQZWYSbyNH3KG7HD4BZ4jENLtzyszg5KL/
 ZMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754348629; x=1754953429;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NVGrd9yjfT3pHxjGFXLaE0sIhVqs1g8qtZf2BA1Hpg8=;
 b=Gtf8DSQ1H/MFJXBD2uBkxxdFt/XM+ShFe0IGSilgRmz/dHQirPlV4qq2NaCV3IWm1J
 QQoHANW8kxDJHrqfTJV8nrBQag5qudJrt8e7wTerB2pqa2aGGQ6fzHsSD/Ho0V4Lx8mV
 8XAUQKneNKVCQmTQqY2JEZIQl5JfHQcmLSckAlXcaHGxHgfhX9qDrG7QNA0t34zWh5BQ
 5VHuVa3cnn1TUU5blGW0UkZrD0LkUY47f6Tac/5hjXYLoZ+SRPQgtqFcXIXFR44w6o0y
 GjnYOyFPHDZ/5d1EXsOkv6O04K+yE9evC7HMbwI33JtwM6pcsQ4owaVkx6Ox30cMCYdk
 akhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyjJMRJ5cGbGPt9c70ljRVLqxR0/AFVqyUEugPNbYm2tTjHeSIAZMRIWXIN3/JXZHsblRD3Oe5hxlS@nongnu.org
X-Gm-Message-State: AOJu0YyPhTrYVDpiSEegZtETbROya3eFclqJgIAlDReueyk9bic+WIEn
 G+TERXFf+fxpmMgJisaKsvjRcuZJMXcp3ZjgFdG/CtKd60kaOo6xkGl7vdS2HAKVzpw=
X-Gm-Gg: ASbGncvQOPzNPZm8yd/Ju4SjubbE+yxWE7oXvDk6T3Zzq+rDiRO1PFGBjVjEgDS7yB9
 ntUraS4ZN6PkcHsPPYsGLELX0rnZ+hW3JUKv/SvqKJ8fPs21f58PD1ELgTGF6Ce0l+ub39cP5Jq
 jvi6hMTs04hXVX8QPeCsfwoVVZUKW/x53K2Ff9aGNnuK/k1BsEZU5AlGMKC7CrlCiqYY2s1MYlp
 aDO30qA3f7gvKQnUwFfd5+eT6jeqyikMbLEm0VN3AjRMxC7TCC8XouuwNYi3hucbIGf8+xJMwDe
 y66SiTI/FeqLxepDuJCB2/OHBkq2/aQqlEIEYukCgNVwKKDEXqJ0NiVtEebbJ1ZWmyLFL4XaDuo
 mImUPUAB+r+cgDWb6Oo81TlV+X00wI1w8wOGg+FZ4UP2EOKwme4NZFJiRDeSR+6ZFE4lhM3jMBQ
 Rl
X-Google-Smtp-Source: AGHT+IGezxXjuqT3MPgMkGaqM/Psf+/Fauc38KwQVfXTldx4R2KDMKRmURv6PP0Pcd+zlykfOIiCKg==
X-Received: by 2002:a5d:584b:0:b0:3b7:908e:e46e with SMTP id
 ffacd0b85a97d-3b8d9481a22mr7989789f8f.25.1754348629124; 
 Mon, 04 Aug 2025 16:03:49 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459de85efb0sm36591855e9.7.2025.08.04.16.03.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 16:03:48 -0700 (PDT)
Message-ID: <e5bfbc26-de3d-4f4c-b15d-6c7ea1b29e49@linaro.org>
Date: Tue, 5 Aug 2025 01:03:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/17] hw/arm, accel/hvf, whpx: unify
 get_physical_address_range between WHPX and HVF
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250804142326.72947-1-mohamed@unpredictable.fr>
 <20250804142326.72947-15-mohamed@unpredictable.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250804142326.72947-15-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 4/8/25 16:23, Mohamed Mediouni wrote:
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   accel/hvf/hvf-all.c        |  7 +++++--
>   hw/arm/virt.c              | 41 ++++----------------------------------
>   include/hw/boards.h        |  4 ++--
>   include/system/hvf_int.h   |  2 ++
>   target/arm/hvf-stub.c      | 20 -------------------
>   target/arm/hvf/hvf.c       |  6 +++---
>   target/arm/hvf_arm.h       |  3 ---
>   target/arm/meson.build     |  1 -
>   target/arm/whpx/whpx-all.c |  5 +++--
>   target/i386/hvf/hvf.c      | 10 ++++++++++
>   10 files changed, 29 insertions(+), 70 deletions(-)
>   delete mode 100644 target/arm/hvf-stub.c


> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index 818b50419f..fa06e3b815 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -225,6 +225,16 @@ int hvf_arch_init(void)
>       return 0;
>   }
>   
> +uint32_t hvf_arch_get_default_ipa_bit_size(void)
> +{
> +    return 48;
> +}
> +
> +uint32_t hvf_arch_get_max_ipa_bit_size(void)
> +{
> +    return 48;

These don't make much sense on x86...

> +}


