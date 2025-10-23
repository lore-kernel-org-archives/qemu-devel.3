Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08DBCCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwQz-0002fZ-U2; Thu, 23 Oct 2025 10:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBwQy-0002ee-AN
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:36:56 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBwQw-0002gS-NB
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:36:56 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4710022571cso9591165e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761230212; x=1761835012; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0Ub462uXy6yTKCuFon5m6KN+QCiu0CN9KdJm1niXHiE=;
 b=LXkgxsPfWWzcucsLoMdCLYfI0OctSWXUZIcv2wx1IXS0mQp0uHkl9SVLCSyq7wYj6S
 fBhuDfknQ3K/LTlEwLFf1jl43NqQaLsnmVPmRYwb49mbG5eM+z/ZTCWpI7Z6pWhuy+K4
 aQ+17GQj7hCr3yMMh7MQh3zfYemGPKRtFnbG56uLDA0AcaOgF8uRwNOZYPY32O5qBUlP
 u0ZiCu9gxvasMABulb2xrrOTwEHHIthQPebzeg8tbho6w8NOOGKtwVZPxpUzLqbpAjdM
 C/spLjeLGyFyKW+HMvW88ghwBVdrDJfjVJj0NX6DoDS1a8R9ECdksuxCy8tIbIHDq/LM
 LU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761230212; x=1761835012;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0Ub462uXy6yTKCuFon5m6KN+QCiu0CN9KdJm1niXHiE=;
 b=wtxwB1hsIFiEZRn30yoWKr2BONTRQZBd/6vj8VsPuSmYsUr5NVPJDJTGQJn+Hg8Rje
 NWPZeJkkDFU3H3/vQCKASLS51qV8gD9Bex7rdSdR8Z1tWb1xGq1DaoIGayQ7Ia/pylOh
 2zMiAttUdco8eSqKBppX/+J5bhrJRav4JmxUZVEJOTxol3tDamCbPGVj9gRJLOTEF6ln
 M61pFr1s7FsuCE61+9Amq3sNOeZ5R18CJ0BAduiro6TIFnz219y7yHG9S+7Gsto4zV1Y
 3wlBbF7h78Bx7Fvbe99LlSX4eAkwXlbGDrWEv8EJeuhp+lnE+4eZZVyYBUFvCxSzfTY5
 s46g==
X-Gm-Message-State: AOJu0Yyw3JpXpnKARba8X3AxYwMw4LSVGnpGoxCrjVJ63gHc2JZqeEle
 TonpQ/l7MZ8MwmcMYfJB4TTt6aIk/QeD9jwkknJEODNLrfIQ39et5H+IVcfp7ACuCQJJb9gukyW
 JoTfb0Eo=
X-Gm-Gg: ASbGncsIZQedEtBJuT4pmu/IZLSNYaJVCR4zmMug19fXzZuQx7jtNob6d+FzrQnTE6G
 INSYnBhNzjNwbTYx3nZKApBahxhElGnmOXvbakG+HR4MvXolxqjqPZERE/w8luej3uF+Enjs+U2
 hMzYMvlezzFlihh+Xe1+sxzslQBYmaP6D6DmT0YIryTbOT9Soj56R5WoI2P1xnu7NRR+liMxKsJ
 pOoqQ2Na/2sakavDjksFwGD4BI5jBE5l3g3UTaHJ6Y0jdpnSSIOrKz4J8lpmMXMHpsiMtfry87h
 S9n6QhUA1+7S6SfU2Bps2h4DvukGoKa4mHYF0Ly8uJ5nuJ6GInqYtQVfSLs4tPsMC+yVzUUX3Vk
 oSdQHuFx6eSqlIUJdHjVvtDx9WMRtha3L8/woDM3GwDr2MsuEWav9W5ozz3CLBfA9w8Y3Fx0RUA
 NYCO3fDhfaYfwhZ/vsg9tSHSxocfSwofLsGBLMp1gRc2wYl6lxzdWDZA==
X-Google-Smtp-Source: AGHT+IE5PW5jJBdZMO2EpWyaERiFtCBu01o4Wn2jhued+al5Cp66NYgkUowTzRiyOZFPyS8luXlM3Q==
X-Received: by 2002:a05:600c:3b03:b0:471:15df:9fc7 with SMTP id
 5b1f17b1804b1-47117906a72mr172109005e9.26.1761230212273; 
 Thu, 23 Oct 2025 07:36:52 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c428f709sm101809005e9.8.2025.10.23.07.36.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 07:36:51 -0700 (PDT)
Message-ID: <356351a5-ba6d-4d6a-913b-982630f7d299@linaro.org>
Date: Thu, 23 Oct 2025 16:36:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/58] accel/hvf: Guard hv_vcpu_run() between
 cpu_exec_start/end() calls
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Alexander Graf <agraf@csgraf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Collingbourne <pcc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Cameron Esfahani <dirty@apple.com>
References: <20251023114638.5667-1-philmd@linaro.org>
 <20251023143051.11195-3-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251023143051.11195-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 23/10/25 16:30, Philippe Mathieu-Daudé wrote:
> Similarly to 1d78a3c3ab8 for KVM, wrap hv_vcpu_run() with
> cpu_exec_start/end(), so that the accelerator can perform
> pending operations while all vCPUs are quiescent. See also
> explanation in commit c265e976f46 ("cpus-common: lock-free
> fast path for cpu_exec_start/end").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c  | 2 ++
>   target/i386/hvf/hvf.c | 4 ++++
>   2 files changed, 6 insertions(+)

I forgot:
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


