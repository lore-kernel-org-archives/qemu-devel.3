Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BDFF8D777
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 19:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDSlq-0004rE-TM; Thu, 16 Apr 2026 15:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDSlp-0004oo-Pw
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 15:53:01 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDSlm-0004qx-PN
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 15:53:01 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso101487655e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 12:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776369177; x=1776973977; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9yyyqJ5SsGAFp685+0pOeV9gBgjTw27IGwHqeCrzoV4=;
 b=HE6J37sJobbNRQFAcWIivfiAOanzXEo0HlBQzdpn9POwvsEsvZXJolg11JD4hqAtjv
 BI5YzjcmIzm3MaYKSJGZZlsNsPmr1ugQbp8Cg7Svy5tJUr4bFs1/haAkwb0GTxJ1CECc
 GHwrVeAA1hVrbgyK7P+IjIDOJxNj+h//XjzQQ5ux4B5TSawZxbvr4iVB5roURAqWtXp1
 DGbzjO7ZZRO8mCHYpDOPjJ5KjLTGfq5vaVEqusSeOvXpPkTcdOSna19TRlezOqRnjbP+
 2WUMqeVOchWzkgzMhaI0Z3AZd3bncKRXCVZ2XMpTnoTVMXKMecE/uFcbPeiawx9w+r2j
 ZvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776369177; x=1776973977;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9yyyqJ5SsGAFp685+0pOeV9gBgjTw27IGwHqeCrzoV4=;
 b=o0HodywjbqzarINm0IPV4kVkVE2kDL/WS0HTX8naaCLMd/P95bcxpw96gTwNVDddl3
 lHts7M2H5KhYyLmosjOLg2WLVKWRDbl1ycFhM7a03hKFGAzbCfUzWs/Nxz6GgE31Xuqu
 LP5SOECMuhvRzJF5msYjSU2KR95f9crWUNVPpEvzODVlBc8pu6t5DBXFnnW7on1/U1bO
 yfKbN07q0xRKamHCqTWSNgmxvNRgI4wXg2vubUI5V0d8Dg4seAiUAzYYSxVXoydlTRQM
 vUjg5lGWMkAiywXwVKpxzGArJ5tML2ppLBbYwl1eUGK4miU+C+RXV3+I7rGsgDXR+DAF
 GjUA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+5f1AThzvwr8m+oUkW89HX1DIOBkB1Do7sSgZIuCZVY9CcnDX3QaDcNIVJsZ9eRj3UuIpQT8U727Tt@nongnu.org
X-Gm-Message-State: AOJu0YxcSjE1iVXA2JZrRL4XvYsrGK2YOBkIO2KyjDFjrDIBJrEs5YzM
 MTkvyTZbt0qWGIguoLAvRXIJpD9ODxNkwu8DoX6/mwvwne88EDww7whbneENWuO1E7TS17bjUct
 aEV/HIh4=
X-Gm-Gg: AeBDietO4qs+75CBi/8JTpa7+SXOfYR1HwmhCabDKXQicfNgfxW5OzFJXPA3OBcEbIO
 xp+UYKaAp7v0MDZVfqpO3wNMfLjQW+OJgU6aylsuc5cNScD9Y6TGhp8MeR0GTh1BIPKVu9jeA9u
 lRm+693Vr7l6yq2xvUQCKtbW14I96RQkKGwg9XZ7rTqzL6ybGDygGMnvL1zYfIgXjc0kVVyI79R
 OK1v9vWGo44Wy89Qo1Ys7S788LtbfemSA/DeIUYPpFFmt3o2TmRB9JVAhRsFiZIoG0Yam+uEfdm
 9oOnA44apw2Y4f5EbggsUuc9WvcDj2yCCbrPq0nz64ZVPH6GPiheRhaWp757q38F2clE+oDXtQJ
 yypG4eKcrWcCj+SCR16yP6DSVsulnnnSP97WzkLwz8nqdC0C41xP3YV3CFE40Y+PCozpu6Jz/uC
 SwFgl+MQaLQGu5ZZ0+uvMWm6wEoS1JHrSGYLTbMF9suLrT/K1NQzStDskNZ/e9mmIlF9VqoB/2d
 O+l
X-Received: by 2002:a05:600c:4515:b0:488:a4d6:69ad with SMTP id
 5b1f17b1804b1-488fb790b84mr63035e9.27.1776369177018; 
 Thu, 16 Apr 2026 12:52:57 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb4458e8sm946065e9.28.2026.04.16.12.52.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 12:52:56 -0700 (PDT)
Message-ID: <a6cf5e39-033c-43b0-a8d4-069db5f688b6@linaro.org>
Date: Thu, 16 Apr 2026 21:52:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] target/arm: Clear AArch64 ID regs from
 ARMISARegisters if AArch64 disabled
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
References: <20260416165353.589569-1-peter.maydell@linaro.org>
 <20260416165353.589569-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260416165353.589569-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 16/4/26 18:53, Peter Maydell wrote:
> If we create a normally-AArch64 CPU and configure it with
> aarch64=off, this will by default leave all the AArch64 ID register
> values in its ARMISARegisters struct untouched.  That in turn means
> that tests of cpu_isar_feature(aa64_something, cpu) will return true.
> 
> Until now we have had a design policy that you shouldn't check an
> aa64_ feature unless you know that the CPU has AArch64; but this is
> quite fragile as it's easy to forget and only causes a problem in the
> corner case where AArch64 was turned off.  In particular, when we
> extend the ability to disable AArch64 from only KVM to also TCG there
> are many more aa64 feature check points which we would otherwise have
> to audit for whether they needed to be guarded with a check on
> ARM_FEATURE_AARCH64.
> 
> Instead, make the CPU realize function zero out all the 64-bit ID
> registers if a TCG CPU doesn't have AArch64; this will make aa64_
> feature tests generally return false.
> 
> We only do this for TCG because only TCG really needs it, and for
> KVM it might be confusing to have QEMU's idea of the ID registers
> be different from KVM's.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v1->v2: limit scope of register clearing to TCG, as I suggested
> after posting and testing the v1 version:
>   https://patchew.org/QEMU/20251002101648.2455374-1-peter.maydell@linaro.org/20251002101648.2455374-2-peter.maydell@linaro.org/
> ---
>   target/arm/cpu.c | 35 +++++++++++++++++++++++++++++++++++
>   target/arm/cpu.h |  3 ++-
>   2 files changed, 37 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

