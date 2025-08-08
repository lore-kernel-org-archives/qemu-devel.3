Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA34C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 20:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukTya-0000lL-28; Fri, 08 Aug 2025 16:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukTyS-0000bw-QT
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 16:46:01 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukTyR-0003eo-4u
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 16:46:00 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-459eb4ae596so22919815e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 13:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754685957; x=1755290757; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DWbHVPSnx3zBRESkWw4iY6+p9DQAd5CJqsRJ0vGzSSs=;
 b=Rs0pF6O4HWaNjs58+EFLCZNHwQgOVhjIWKnjPiS4crBD2vgQptfe1zjP9hN4JHsNRE
 eBx7Q2TaoTpLh8mus4y15AGEUWfNvsnn1HgTVK2IMPbFwX1kSAnfkIKMgq1Job7GK04g
 jgCiieY7Hu3mgHkBK/K4xRd0UYk55a4yB0pAQiuNMa8EobpdZ0aI9a0ClMxjFp+VKhNa
 PfzuaZMozfbVWicJCmexFm2kA5ixhklGlPOcJAZdtzerFUxSwgXL7zqB5efiYNM1XF5S
 ruZNVMandWYn0D7oJWOUgfpvIsrkYPtvAiQJu19wAtvmtYfqTHh1ecQUe5SQXApnflFT
 1jQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754685957; x=1755290757;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DWbHVPSnx3zBRESkWw4iY6+p9DQAd5CJqsRJ0vGzSSs=;
 b=gq5/YirYkyMuHAiIeFlOI8vL8nX0cYocGeEF04xd4TYIfR9C+m7z0TZ6EcBplak/Ln
 AWY/DokQdrNSosyg7sYdjNdCyxX7YRU/5iGeyFLmz+FAD7Ta/DSsxgCzKEHLWlo5irxX
 Y635rg/rGuNZTyEAyBpQSFnYXkaagndRhMUYIHebnytWG4WLWqRhaK9SnuHnRbU9SDwa
 /bwAjEE/UV95icKiE4mXVcTDxK8mKvY+EYxWo8uLiP9gqmeUv/aDSEf404JuzeHh2+d4
 SDum8AlOIYLGW9RXfQ0CVyh9lC3c6c3UTLbxZ0+8xz2iyLpqOGcHchm2ADKiqBo8SdOk
 n5Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF0NloRysvVV62CpsrIAMOhBObpNlOlXBnLpNYw/xGWg4Hwhb17AF7tAwUpFjGgc0NeuXm0kMMgswm@nongnu.org
X-Gm-Message-State: AOJu0Yzy3xsPaI2uH9HW5JzZKr2e6D9BjFfLzYZG6IsKd/i5KXlulyMQ
 yBdUMfM5RpSIEfEXMA5E2wrcKn79BuBYOiFkTEXsExxEURd5ZmglbiebaDSjN9c7XkU=
X-Gm-Gg: ASbGncvzuDbzrz0SuUcPnhPvRCqtVcao2neEW+hZIaLqvWnGqHvngzBYCx3TTFO+b73
 Tw+8b1cK1C4F3LqA+Pt7+A6EAvcJF7uIMLd/tPy+V8nb39cbVnL6RO/1jd9nC3VaAA1sy0uSW7s
 ItcepSm4p1B5U6PNSZTkyhprt5Oqn7oNBXUtxYs4gUJv+Gjadr+FBS3uEDNZ4vs0cyiR0BAI2IQ
 isRZSzO5t+CMkxgcEHbNOwadaicjkLMtGAwkWRzG+2KTZhnjTXCfXR2AWE6r3LPVNadajCQoVMk
 kqIZxO61onOJZgsGIH3BA9O0kQqbX5HahJblPjtEMCGqPXoQgWx6Up+/zehV2dis68nDqhdvHG8
 mAxA09ewZng9+mGYS8keGD3V93J213Ya/DIbD7FO2yjdy1WNK7JM8lk+Q+TTmyQdmBw==
X-Google-Smtp-Source: AGHT+IEhLJ2welCu6ohViBY86RDdco6ICImm1tGHosw1q+JqBz/RI6BeqmpYLcX57zPq/NKnTagcig==
X-Received: by 2002:a05:600c:474f:b0:459:db54:5f34 with SMTP id
 5b1f17b1804b1-459f4fc273dmr45806025e9.31.1754685956783; 
 Fri, 08 Aug 2025 13:45:56 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458be70c5f7sm273777125e9.26.2025.08.08.13.45.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 13:45:56 -0700 (PDT)
Message-ID: <ae58547f-79f2-4bde-a3ac-46bea847b37d@linaro.org>
Date: Fri, 8 Aug 2025 22:45:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/18] hw, target, accel: whpx: change apic_in_platform
 to kernel_irqchip
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250808065419.47415-1-mohamed@unpredictable.fr>
 <20250808065419.47415-8-mohamed@unpredictable.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250808065419.47415-8-mohamed@unpredictable.fr>
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

On 8/8/25 08:54, Mohamed Mediouni wrote:
> Change terminology to match the KVM one, as APIC is x86-specific.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   accel/whpx/whpx-accel-ops.c    |  2 +-
>   accel/whpx/whpx-common.c       |  4 ++--
>   hw/i386/x86-cpu.c              |  4 ++--
>   include/system/whpx-internal.h |  2 +-
>   include/system/whpx.h          |  4 ++--
>   target/i386/cpu-apic.c         |  2 +-
>   target/i386/whpx/whpx-all.c    | 14 +++++++-------
>   7 files changed, 16 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


