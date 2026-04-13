Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39EDAF531CE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 23:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCR2R-0003fe-8G; Mon, 13 Apr 2026 19:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCR2M-0003Wm-Tm
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:49:50 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCR2L-00029M-GP
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:49:50 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-35d95017a68so3099007a91.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 16:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776124188; x=1776728988; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rm3XD9tSc9Dz8iZFicd+HFy/MCy9N4KSfThTwybVKKQ=;
 b=c41tEmsbIMk/tdkrlsHqHBTlMSnykTKfXpmiJxKla9ba9c9osVv3m2BonyTXNvTLK4
 ayFXH27SQ3neQxMqpY3P50v1DotiskmVpEiveLSiak0NqNLG6DfFvvyY5XDloQQmVfPz
 a4YxaBlKmoxEwyBPMVO+FUdF9SybprxgKlsecral73Cs2JatGBMuT88ftVh01MweeF9P
 ElcOmFUcMlKIApJdq7zj7QZqfR0ORrfRNwCVbhiRfJVYtULAv9g2eskmQbc7nBGk/bt9
 sdK3+HbXpGfNVud7x9k+XzNmauDce+6bJ/lO+rB8KA65Sg305MhiGx5k5XtPtSvN0hV4
 IM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776124188; x=1776728988;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rm3XD9tSc9Dz8iZFicd+HFy/MCy9N4KSfThTwybVKKQ=;
 b=cKT5mwekSKxGa3o5lAuvgk41Vpd25nSEi/K0vKyeQk1Ib5djhtGjtEwt+dbvSWWcWl
 tIWTv/xJTEGMdqGGX979T6LusW7A6Q7l5ZnFIUiJgrIbJOn/jKOF1G+A3IcGGaV4mBUU
 SY8FnAKfEBt4hxDz7dL0CkKxBOCWhSMAusHNHAXo6Rx30fKUx/Mr9Pg2ysbfv3qzutbJ
 M4TiWQ5WqGjK/AM+RxdVjBBjUHuKm+uKe9jekiX7HcUYXaeL5JN3Essp81drxV0KjKFJ
 xmfZ11w5MbNB201+GZ+lsZWkXsnQOJQlo9LlUGjOupEjOkvcTi3Gbk570ihPRB5SznzF
 cXZA==
X-Gm-Message-State: AOJu0YzzHH6pqOyL+cdmOcR5UbbjnUjf6g85RlNCwXg43EXyDH+lPZ9q
 GP6ehBNfgLRfSAwaaMfwIlXG3rM3QwOORqnDKGoaFU5BPh1DX0GZBb+jaiUBgTetXb/7hVfh+ZW
 1yD5U
X-Gm-Gg: AeBDieuQVlBKE2vRuxsQxs3x7SKQ3bhPSjHIFA/6uA0wZx4p2vTO6ixq9hDc0htPxMU
 H9AZdec8w4+mNQlzXSb7w5ztFz0tzqJQa07qiGn8+RHDvCxsbgFFsiQ/at2UB/BnJQuotAOA90k
 UMozEK39JI4uan9KgFozh566ZV8nJPXMUXB2TDjPzkbFtGiC42uJ/F2QqRyFkD5d/jpDQUwUsHM
 sYMEAuLF0qW28CFP0C62UdHzHG65BwcdrBsZ3dym3btMldU3YVJgKcfYrktIPZ8qib27oZ6yGzO
 KFCIohK81qHS25FudJn09Vp20vKcI6Qf9xvn+HInQj5AMJG0+oXl8riOlGj22uzF/IfXsDesUA0
 96x3fMA5brNOq4unS5LIoEAJOXZuefeuCN8EVuHgP8qpzbN0TQpCSpP38nGoIR8VVd2fuSp3zd+
 Q3x/YPEsOXBQ3HKAQoJGwT/1Og1ysz/Qvd9OSRaG42ZWmpglbHGjvxjPrOefDWvMESKiGNOavkB
 RhE1uvJqxsYbA==
X-Received: by 2002:a17:90b:2d07:b0:35d:a3b4:2f0d with SMTP id
 98e67ed59e1d1-35e4274e1damr14054913a91.6.1776124187928; 
 Mon, 13 Apr 2026 16:49:47 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:377f:61ec:6edd:e205?
 ([2401:d002:dc0f:2100:377f:61ec:6edd:e205])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4f08b9esm131448205ad.41.2026.04.13.16.49.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 16:49:47 -0700 (PDT)
Message-ID: <672c0e68-a82d-47e4-8ec0-64ecf0074ea6@linaro.org>
Date: Tue, 14 Apr 2026 09:49:43 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] target/arm: Compile m_helper.c once
To: qemu-devel@nongnu.org
References: <20260410200628.19378-1-philmd@linaro.org>
 <20260410200628.19378-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410200628.19378-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 4/11/26 06:06, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/tcg/m_helper.c  | 2 +-
>   target/arm/tcg/meson.build | 3 ++-
>   2 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

