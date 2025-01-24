Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3C2C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 17:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbNNA-00013J-O9; Fri, 24 Jan 2025 12:21:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbNN8-000113-60
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:21:34 -0500
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbNN3-0007cv-NS
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:21:32 -0500
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7bcf32a6582so202949485a.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 09:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737739289; x=1738344089; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ImGrmBzdXq1o9Ekh6nXkpOqPkLGM9i2Zcy4Mnrd6Di0=;
 b=S4esURCXhhOGbbYs9M18rbd8FIg9eiLrSjk8e7IUWCw0Gu7zaex4OkJkio4Zi0Ofzf
 HlA6+M7qvFlEvpY1KJ5zsaXEW5oihpAjNgt51u1JPTGzYyQYtatYXKPWsx1CS/FEIQTi
 rjNjxvUc1S8tx9l6wfKzf2+P++0y6C86SHe5OKv520OIOEzFCKZ1LPobosAXzsgBu2Pt
 wSAJo1/on+WYD9cA6YYK8mXNiNHQicVlo/Ah7nlHd4N+7BTg1PAOmKix90LGTyYiClEX
 K5siBOsk6/kU2FqpX6o27+XUeXWfL4/9DhF7pWOdrxWR/RQoXifySo2OSeHpBHqBl5jP
 Hf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737739289; x=1738344089;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ImGrmBzdXq1o9Ekh6nXkpOqPkLGM9i2Zcy4Mnrd6Di0=;
 b=iuA3PKp+ZmX/eLxRBM8wGKCBb2rJtrSgTyxqayJx7uMcFLbvGQz22WKLr1DGvas1Yb
 AyGJJT74elpF07c9gmAcPpRAAJVxiFnvYzZfx5fgTuEFoYtfAetpHE9/E20WsEYNhCDB
 UYC++L2r/2aGR+aLjU6Q8C7NxN7fl8m7b++j49PCQRiyIrRB5Yoh1saQTfUh2jbLTBxY
 3w/E/c5a/QzlSc8W3UtcJd/oG05rtO4W86htNKvGI4eZJHsmHs3RTdJg4hFrlzwh+UVI
 4aluJIHxP5DMCfgF/PlrqWpEn4bqdEaQnnfUA+gK5uU2Og+LNd9CjDBczoLwAI+sL1AU
 a2gQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa9lVfEmqmz0vEz0UWGceyqQ9gPEUYGONtmLBptZmI53JEyHnb9USRfhYLz325tsgDNihEl7P7nxOp@nongnu.org
X-Gm-Message-State: AOJu0YzljQvlDCbYfov6U/fOoGzHWjkpMreT02ntPvxl0wCqrKzPGCw5
 +CLXVg0oSGWqYPEvFaO5rW959AAvPSGJR4LUvgYnSrT+QxSgXz52DiXSxzlyn5E=
X-Gm-Gg: ASbGncs9pNuM56sNNzRl62O7IlMJJNtouW7CiDqLjmNzleZ8nHCE/E0EdUf++zxlIw6
 kx2yqeX96GRMZPjyeYETQeRJcPl2pwLeb8MdnJvU7CI5GcxjaY5r0WUHeRt43KHVFcHB2VnXyHP
 6SdJewg4iV/GHtkA7zXOzKj2cIpEV3bp1w4eEPMjuRFEHmcFNtbnO8CyOzrudswB9mJ4wnm+f7j
 pflJfDgxJ0Yua8LNWHAjTIXi818a6HV4PI9egfNc4QzCP669pE5JxDekE7if6u4/dwVgQpFfWXY
 JedqJ9J1ggr4dmVuqah2xnUbOtF3HmBt6RyZCiuE5T1adXEaRNTIag/4IXGgGZisZg==
X-Google-Smtp-Source: AGHT+IH4B5Mr04ZTnWtSbQoG+IdolA5TDsTFdUlIu8WQkskUgJgAKbzpFB7vMXA62KNzzbEjqxJIKQ==
X-Received: by 2002:a05:620a:3950:b0:7b6:d58b:9dce with SMTP id
 af79cd13be357-7be63288566mr4136041385a.51.1737739288849; 
 Fri, 24 Jan 2025 09:21:28 -0800 (PST)
Received: from ?IPV6:2607:fb90:c9e1:9829:9eed:533c:6788:9f4a?
 ([2607:fb90:c9e1:9829:9eed:533c:6788:9f4a])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9af0d1a4sm112277185a.96.2025.01.24.09.21.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 09:21:28 -0800 (PST)
Message-ID: <5dec9e09-11f8-4fe7-ac73-6562374d9400@linaro.org>
Date: Fri, 24 Jan 2025 09:21:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/28] target/s390x: Move has_work() from CPUClass to
 SysemuCPUOps
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250121142341.17001-1-philmd@linaro.org>
 <20250121142341.17001-24-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121142341.17001-24-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x733.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/21/25 06:23, Philippe Mathieu-Daudé wrote:
> Move has_work() from CPUClass to SysemuCPUOps, move
> s390_cpu_has_work() to cpu-system.c so it is only build
> for system emulation binaries, restrict functions not
> used anymore on user emulation in interrupt.c.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/s390x/s390x-internal.h |  3 +++
>   target/s390x/cpu-system.c     | 18 ++++++++++++++++++
>   target/s390x/cpu.c            | 18 ------------------
>   target/s390x/interrupt.c      |  8 ++------
>   4 files changed, 23 insertions(+), 24 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

