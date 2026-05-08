Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502D9CD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 20:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLSBy-0006Tx-R8; Fri, 08 May 2026 16:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLSBx-0006Tk-Qt
 for qemu-devel@nongnu.org; Fri, 08 May 2026 16:53:01 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLSBw-00052x-C4
 for qemu-devel@nongnu.org; Fri, 08 May 2026 16:53:01 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4756e74f8edso1754444b6e.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 13:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778273579; x=1778878379; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F5W1XO46XOxX4uwu0Z5QuUibvWeQ3pATlSaCUnigUmk=;
 b=gt9Em7fK6mi/HBQfzNvQJ/9avxeHO99rpLdF7D9/xtf9c8Tg6Kp/JpBZt+lXMIZ9BV
 mD1/yWUkDA5tpRBSs/aGVBdkqFxaqCgWdbGAUu4WgMDmKv8yoW7hlysLBqlIXd8u/lmm
 tyFmqwu8KQeBd10t2gpbV1+HZkVzNiAXa+9BSZ4KWGuo+W0us8ECXHeiqoHuWaIrpFkg
 5OeN3hTjppXLFA8Q7FZu+B8hWi+Z0axAPCeB9N1A4ifyA2msvvzntw1fwGGY+mHzLVVC
 +bSqZBJjmKjqeLZ6b0TZhksP/YuZHkaqkdWCJ924GTrqR9PS7pRxeYvO79TqnzIzWAQN
 GzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778273579; x=1778878379;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F5W1XO46XOxX4uwu0Z5QuUibvWeQ3pATlSaCUnigUmk=;
 b=KqueTDaeZE1Rin8MaVG6ioG6ZSUXWeCJmMuz3h4dEhctqbPyghTUpG0eDwootncTEN
 BSrJtElDx6rjlj1yAAn5Bor+b0dStgOeuteOpsqZitptFa1AQd2GR1yEWlJbcUWCWLd5
 eAtvpVWJNzG+S/iHWAgS3I0w3ZhoxCb5GN1m0icgGzwdF8GzBUXya2yC/V23sFdofZld
 uNejrdYsyzSB/zoHgh/pB8/bmTfIkQTq6LYG5H2CMz3usPajDWjOijzEQzBAxL7vm+8g
 /csbaEx5MGQQWEZDqMbTlWfXrAQIXpSNbCvUJQpDCv7FgtAXvUI7GcI/fZ6RB4/kqyof
 X+9A==
X-Gm-Message-State: AOJu0YyEvKCeyjTXUv3avhqX4O9Mh4lxGrcj8rmdMvCmgXLjISRxjihX
 eugU6l+6WOypVTdHnXhH01kWcFssyyl0swoMhyL1byiNzJYCNx8EjYE6AyRp0I2FOuZRruhp68u
 OrT4h
X-Gm-Gg: AeBDieupjXsGiZzP0ryRpomcs9xFBm9+yCZgT7r9e+4otK+yvqObLT/zeVXv83EnN55
 7mCBofmXL+YSRvEPjVyvBrdato3p0kG2vbdOoK5mXaru5gXB66s3klR0ja8nkSkBjjP6jgW6YC8
 nNX7FUNrluh8CIWRY2wwWJXsLkyuoduqg0LKuAyZ6hqxXQvulP+Zjl3YAAHm5K/Z3nwDw/VYEBq
 dttaa7o4lp7YNEhsUiobKJ1yc9Wl6xqr4GLuSvEwJ96IIxKLUB9QaL3QkYU1MJJwMoJVwAmpJzj
 Jpcy4flVKy42h1xQCQeVHhK2otLXDKm3dBGyJcbpRSo5X4UWdcsiNB7iI+gpmrpu7apgQgOEe+D
 LEpzHDFLP7aPHTfDrZOf4/io99Ta2nY628QwLOZ17cZzcxKCywCT2WotEGilhAvs9xav4qUwXci
 2nbqhpIRUnVt6PF1/9jbt29YhnvnzhVs673QlZXGt5ziIgCRLNPNNo1P6cNKm+PyiaEJ/1Zv5vs
 YM4oZ/uFZGBJedJZw==
X-Received: by 2002:a05:6808:e655:b0:479:f9df:ab44 with SMTP id
 5614622812f47-480424fcd3fmr6401136b6e.35.1778273579007; 
 Fri, 08 May 2026 13:52:59 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1a91:1de:21e3:45a9:5df:5a65?
 ([2607:fb91:1a91:1de:21e3:45a9:5df:5a65])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435570ad8f4sm2665861fac.4.2026.05.08.13.52.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 13:52:58 -0700 (PDT)
Message-ID: <f70e9b69-716f-4fa7-8b87-17dd0180287e@linaro.org>
Date: Fri, 8 May 2026 15:52:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] tests/functional/test_tuxrun: Restrict to TCG
To: qemu-devel@nongnu.org
References: <20260507194728.2034696-1-peter.maydell@linaro.org>
 <20260507194728.2034696-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260507194728.2034696-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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

On 5/7/26 14:47, Peter Maydell wrote:
> The tuxrun tests specify the cortex-a57 CPU; this doesn't work on a
> KVM-only QEMU build, where the default accelerator is KVM but KVM
> doesn't support that CPU type.  Restrict the test to TCG, to avoid
> failures on KVM-only AArch64 builds:
>          Output: qemu-system-aarch64: kvm_init_vcpu: kvm_arch_init_vcpu failed (0): Invalid argument
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/functional/aarch64/test_tuxrun.py | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tests/functional/aarch64/test_tuxrun.py b/tests/functional/aarch64/test_tuxrun.py
> index 75adc8acb8..7dd50c3de1 100755
> --- a/tests/functional/aarch64/test_tuxrun.py
> +++ b/tests/functional/aarch64/test_tuxrun.py
> @@ -25,6 +25,7 @@ class TuxRunAarch64Test(TuxRunBaselineTest):
>   
>       def test_arm64(self):
>           self.set_machine('virt')
> +        self.require_accelerator('tcg')
>           self.cpu='cortex-a57'
>           self.console='ttyAMA0'
>           self.wait_for_shutdown=False
> @@ -40,6 +41,7 @@ def test_arm64(self):
>   
>       def test_arm64be(self):
>           self.set_machine('virt')
> +        self.require_accelerator('tcg')
>           self.cpu='cortex-a57'
>           self.console='ttyAMA0'
>           self.wait_for_shutdown=False

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

