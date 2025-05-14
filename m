Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9E8C3ABDD
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 08:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF7KY-00071y-0k; Wed, 14 May 2025 04:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uF7KV-00071O-Tr
 for qemu-devel@nongnu.org; Wed, 14 May 2025 04:19:07 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uF7KU-0004lp-50
 for qemu-devel@nongnu.org; Wed, 14 May 2025 04:19:07 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so46040075e9.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 01:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747210744; x=1747815544; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aTi8st/0AsQV+cQly4Cll1hkvAykif/4cfU6PxtgpL0=;
 b=Ma/WDaBWxyuYIfOX2cSStW7NdelhntMYL3bQ227GkzPrgbhPOBlITahzDO1iBdAOT6
 RSnQLjPsiSbAjdxhW0l3FhhmqviqeuP3oIjyRi7tZPHyBC7SMtw1PwBAg77ENhDxgaWO
 zmtQfV0LwAkeJZGG4FbjNA8y7lVuMK/8epMdDhxgPRb+kZADAHsWqfV7UyHpphKvhLlQ
 zDGA/fhi2UNJdabSDSOTGMD9gCLYUdgxc8zCKJxHrpJ0DUT9G/i80jNYdyoTcBW8CYH3
 TJ9iomYJ3BPlWV0rTcFvI4XAo01tQqwj0L8KQFWakRJLrU+6JKBVtcwwvYRtlM+vug/s
 3FKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747210744; x=1747815544;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aTi8st/0AsQV+cQly4Cll1hkvAykif/4cfU6PxtgpL0=;
 b=Kl68r5ULfas7EnyGNSXcxoLDCgeH4W4OHD67qc2xUdWOtEzEUPZB5ewPQb48G6SpPY
 t2L3f547XXYOufSs7ax/fNXme+VYFQ1AKhq5Au9CmAkRXb2/C2VSLhsNCSEbrBBavwuy
 j+RLmUuMLXhMwAAz38m+yqwC7lWo4g+Bj+0SZrhUEH20FmphkmcRgyQ5xEW+C0cTS/Di
 E5WIpjuXueiiKwXs9/014OGJrpVNiP/R7kLJd+7CUF24BPEyzCgXjiqhg6ke7qrlPjlu
 e4LNs0VXFbA+zSskh22oGweckXKPov1GlxfzX8G2eE/Skgq8FviP1cCAPD/pQTb0LYc9
 nfNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbc2yI83bb7voSFeVqWyH8UQukRo/v9IVPI0pDvljYLUp3pI0r+qM50yZ/k59kiWgr9lHtSm439Ww4@nongnu.org
X-Gm-Message-State: AOJu0Yz1qRXz4Rk5oPuZoflaHlXyssbxEspSqLr+2TQBIuE8JCxrDtD6
 7ZYlb0ns97x8OLqzaiAZFjFC7Ai/Xfq0FRV6mbVxiPX3wvBVH7TmqVxRn6Bq5t5wAUhFUAqKQoR
 Ao8FE5w==
X-Gm-Gg: ASbGnctRuD3Q8t23XZE/bQ/21vflZ5viCTNpF1fTTDXVhBn6scAIUWiMw9VFTzNZVnc
 G11k+oXbhi/3CwqU8TsHklw+HfrQrnSr8X9tOpQAaIEU5ypi+bg2mS79Gxe90rRbtMTjc2sPUcX
 mJb3NuK6f5M5xOcvAObdY6QDx7pSB/xPxFkmxly/ILCDJUdoJJkTnWkJt37q7VEI34sabRAH5Rh
 ARdTDuF63QetqVAB0YM790aRAxr97za5X4JefhNaTBeoWAsDCr4oVNvOzVESLB7727S2GaQjw1q
 Yiv1ZY4AwVuLZ899gk8eS/cTsenASBw2bXMw0da5ho6x7ya4FAMMD5l8nQ5ZF/nFwUPL0GmY+et
 Z5kR8Qk5srChQYbg3wbAGWrtPf0U=
X-Google-Smtp-Source: AGHT+IEsr5BpJopt8CXRcLyhlqq4zztr0aem1sb/umLeRk6pBYo7v9SzSULB78cEOjXiJ1YpP17biQ==
X-Received: by 2002:a05:600c:384e:b0:43d:fa58:700e with SMTP id
 5b1f17b1804b1-442f217a676mr17948285e9.33.1747210744076; 
 Wed, 14 May 2025 01:19:04 -0700 (PDT)
Received: from [10.61.1.204] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f39517f7sm19009185e9.20.2025.05.14.01.19.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 01:19:03 -0700 (PDT)
Message-ID: <8d7df77e-b8b8-46fb-b7b0-0ac51b4307b6@linaro.org>
Date: Wed, 14 May 2025 09:19:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/19] target/arm/hvf_arm: Avoid using poisoned CONFIG_HVF
 definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250513173928.77376-1-philmd@linaro.org>
 <20250513173928.77376-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250513173928.77376-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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

On 5/13/25 18:39, Philippe Mathieu-Daudé wrote:
> In order to allow non-target specific code to include
> "hvf_arm.h", define the stubs in hvf-stub.c.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   MAINTAINERS            |  1 +
>   target/arm/hvf_arm.h   | 16 ----------------
>   target/arm/hvf-stub.c  | 20 ++++++++++++++++++++
>   target/arm/meson.build |  1 +
>   4 files changed, 22 insertions(+), 16 deletions(-)
>   create mode 100644 target/arm/hvf-stub.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

