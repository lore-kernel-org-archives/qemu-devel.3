Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B218AFDEE52
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 22:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG2gv-00027y-Jk; Thu, 23 Apr 2026 18:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG2gt-00027M-RQ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:38:35 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG2gs-0005U6-BI
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:38:35 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-35da2d35eccso5039747a91.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 15:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776983912; x=1777588712; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GcyBCWSwuqG+v+Hc0b6p7lbRTqkOioJq0+pQQRDLbPk=;
 b=D+ZHVdpVjf47RX4jWBbL9C7ooNkdEA19zfI92XVez620cvyBcTnHLqziaG7fmDjaP6
 ICNo30hK1Q/Ec6tEe+zbyi8WbcOU2kqzIJDWR4PFVNIGbXT/zHeoQNRkgarRejrGLaM3
 a75hH5ZmeQsTbGS30Hfpi/+IW4vBLXFgDZSYvdFsuOYuPC8x6LrBQ8JHU5DWYP8uwujG
 S55cyPVnIXqXU4/Fc0GrGaaxAGs5XU1xSKWpM8Wy11hsBPs5tIsA5850JxMYNlI6x8Ym
 ndgbsF+UC5TLNuGG1Sex1zAlelSL9X+s6IYovJJRFeBtfnOx8RdNSvu6lxD+Ldndnhav
 YiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776983912; x=1777588712;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GcyBCWSwuqG+v+Hc0b6p7lbRTqkOioJq0+pQQRDLbPk=;
 b=pCbT4fJ4LnsuHuBs5eB3WwqS67lkBkAQ29swM2ZxvycIfIIUrXPVxRWP8agIZ+Ql3Q
 NHiUANWavJFxsJ7FYbk3pm6Okym3fisbcXv+yxL/UozFUv0wCWAVR/JsLw5cYrYxaDWx
 NVp/BcjIQOnsAIIWzABuU3k2R5OFpdUVAeuS9rdGFpfrvmGAVxX1NchwEBq2g6y2iNlP
 lS8lB59HV5ClZf5ldQLByOM9HEsOcYaHK/RKY8iyAe6UfDrvaptUcrLxHBVSjxPVZFk8
 pK58TEkPc/U61pLyrIeQyHyVzOsiHZ7FXICXondV5LmM290lO1zJ9jrEd4aki+gtmCFB
 FhlA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8eI8FdGIiPUEQyy3COi/6PA9bpaQkeBD3FLWLSut8FAmegQSRahwHp6OWsqDCnp9FYKNQ9/a4YgZH5@nongnu.org
X-Gm-Message-State: AOJu0YyBS2/dFQyxNWShesoOe/a5Mm6tEbNprD2rcSqURzNqBkj2itDs
 6WDeLkHC9GXyoROokeT4BbpFXsltQ9bjt35t6IC3Nc/OwLM1nCKJH89+h4JsnjfgfDw=
X-Gm-Gg: AeBDiesjfsuQ4VMptQW9gofNmdBnpl+Uww4alE+cOdY+9I7hJKW2HSjJ/jMHbOeZXtr
 BTiBQIlDFrLCCAz67f3V7MnQ76zzGPZcNMszacgMeghGhtCOr6cNo85pUwN+ViH2OI4z9YNEXEc
 w46ld9nhek/+SaPFb5Uq/9xLjpNtLWbm4iy+1cs5NF0jTceYtG2bIXTpIQl4UiugdsN2g8+tOvS
 CacTTrD7bTgQkolv4WpF2QKRLAyvGvMIFh+1X0O5kabeXzVtwgtPX0C04vqOlNnyTi03JbZG0YT
 VW7xthj78GsEf/ZsmPB4RgdZorKoMAdBWB6pz0iiuq5gkK+chjwvzrn6mwcpqlIRwAkPm1I0ziW
 iI+kovcZtAthcmiytF6Llmexb6OLZYrqCW9WngPdqspYjZwuiBrHMvu1rfc9mSlXhpIFkksZJ8r
 +vxYcLLEU96BwNw//81RtaWHLTLp/RHlza+hUpPGhLUCLJNAV+qA==
X-Received: by 2002:a17:90b:5890:b0:35e:5723:85e3 with SMTP id
 98e67ed59e1d1-361403f12ddmr30141119a91.9.1776983912389; 
 Thu, 23 Apr 2026 15:38:32 -0700 (PDT)
Received: from [192.168.1.134] ([110.239.0.232])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3614186a52csm26887253a91.4.2026.04.23.15.38.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 15:38:31 -0700 (PDT)
Message-ID: <69b840fd-e274-4069-b472-5bdc40b1c0a2@linaro.org>
Date: Fri, 24 Apr 2026 08:38:22 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] target/arm: Remove vcpu_dirty=true assigments in
 hvf_handle_exception()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Mads Ynddal
 <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260423170229.64655-1-philmd@linaro.org>
 <20260423170229.64655-13-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260423170229.64655-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 4/24/26 03:02, Philippe Mathieu-Daudé wrote:
> Commit  2a425aae0b5 ("target/arm: ensure PSCI register updates
> are flushed") manually sets %vcpu_dirty in hvf_handle_exception(),
> but these calls follow calls to cpu_synchronize_state() which
> itself sets %vcpu_dirty. Better have the generic CPU API handle
> this, but add a pair of assertions when serializing the accelerator
> state to be safe.
> 
> Suggested-by: Alex Bennée<alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

