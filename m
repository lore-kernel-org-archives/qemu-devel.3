Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B401061B22
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 21:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Kd3-00016E-Vy; Mon, 30 Mar 2026 17:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7Kcz-00015t-T3
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:58:34 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7Kcw-0001Yg-Ck
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:58:33 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4873ce69ba9so15256005e9.2
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 14:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774907909; x=1775512709; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mvYK8xsRHKLVYcUoNPBOaYi1/RzqbOQeBKzf0CNIZyQ=;
 b=dGJhvUC/DC6c3LCu1S1D0XsRNB4hTucwQciVZPlr8K7zsvw7uYbqnIOlNRF6sLRRAJ
 mwCjHdiPDa2KDlPYp6GHzWavlYJnU9TUC6P9Gq+FRhD+J6mehFL+kTqnIZyUSJvpyY5R
 pmCN13/FS3+2EZku4d4RtAyGFBtuypXAChebuLB29UTEoadc7myE3Tl773v78iVPZyf9
 VpnHBW12mj76/aAlkAPPmYRuYTfRJjkt9stFoKVEJuq2+VsYzsoiNrJa95fR1tOkePNI
 fF1z1pwHunQeAhht/wSCsHld7WuXdf9vojChwdwc+cgzZmVm+xMYcnr4r1DeJEew7CNu
 WuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774907909; x=1775512709;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mvYK8xsRHKLVYcUoNPBOaYi1/RzqbOQeBKzf0CNIZyQ=;
 b=JBEuht1p9R7tRGkR9kX5Zi/T3VGOXJFquwXd4x7aZnZ+6VXj44h4ixaieqw8ANcWCg
 41Du5xRdBhq7Qc2qxVHDs7Hm2qLDjxstGlchIuc6UHD4kwCmQIxDyYZvkGdlBmPbys52
 nMCL6kdOM9i8NKF72lDItOtIclYPi1zkECn6gtkaWdurZpFFmZS1/srOiDn8d+2Z+DN3
 G9yU2GMh2QhbkAc67q01UWK/hguoT/5n6KryYowQ1Y6Yu7sKGYmj/Br9f2qj2u9Hil54
 c9IS1nMwupVf+T1CtX9++HJlk6O1zU7rkTPpqMGV1AjMBdWvwISR+KU+egX2tUtJrYyO
 Uu5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1WT9DRwsYAncVnpOXf3r0TvSqo9MQcDEJSuXmgWcECx5IFuELEBNcJMvphgIAANuBzHyFaXvaw/Ya@nongnu.org
X-Gm-Message-State: AOJu0YwtZbauXSEni14Y+CQN69hSrFrNs1D2AG8AYJbXrxb9pg8hkEOr
 ooDEELShLRFgl/Puwt/LnnSd/2pMLF5yebgccuXTfOZPTIXsmefFyxiJq3nUv6Qth7Y=
X-Gm-Gg: ATEYQzxWOFNLfvEH6PRKET0MXBVcMUlil8yHGEvUJqRZshZxSUxjyHC3uJ+OrMpDxGC
 bYOOwC3W/mOXnviIG68deSrXeyvwPWIG8iBhxJ4yS38CQbkcBm49ghOuRKQ/t23QKFLa5pm2ioA
 G74cGw0PDpKCscLTdnXpNOzmuCWi3vs6rmPYHSPe6dNPO8hyqW/EMNjwHc9scwTxnLi5NiW1HN2
 SyjmFwmHHuBaPWlJX8j0pFkS8DBCf914zV6+tkCCBmkqUyEUQyH/yakhNYMYIJjGFSTUiS9nUMD
 IDFD6tHeL9s6BVYsMk8ljtzvNW9aXPaswaKNsRxtrqkvXQo6xe+3g9GyjsvoGCUulQNt/GXTWrk
 Ii5MnlJrho5hftjOkwYJKC2dZcU6ioavv0+RpjBY6HwLScW0IY2lhJT6RmEZJcNGEbR4N8jsI6K
 S07twiUVAAWN6wLT8xU5KJViGxakewI16PC9tVqOqJv2EijAbJM3fUsPw8Devz
X-Received: by 2002:a05:600c:4e08:b0:485:363b:fafe with SMTP id
 5b1f17b1804b1-48727d5e971mr258090465e9.1.1774907908612; 
 Mon, 30 Mar 2026 14:58:28 -0700 (PDT)
Received: from [10.193.39.66] (246.148.216.82.rev.sfr.net. [82.216.148.246])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887adadf4fsm2299695e9.11.2026.03.30.14.58.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 14:58:27 -0700 (PDT)
Message-ID: <6aa40bb8-4d1b-40b6-9350-9e806a1c98f4@linaro.org>
Date: Mon, 30 Mar 2026 23:58:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Treat qtest like TCG for supported-features
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20260330151437.1787008-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260330151437.1787008-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 30/3/26 17:14, Peter Maydell wrote:
> In x86_cpu_get_supported_feature_word() we figure out the supported
> features differently for each accelerator. The default case is
> "set all feature bits"; however this triggers a warning because
> it enables two features which conflict with each other:
> 
> $ ./build/x86/qemu-system-x86_64   -cpu max -accel qtest -S
> qemu-system-x86_64: warning: this feature conflicts with APX: CPUID[eax=07h,ecx=00h].EBX.mpx [bit 14]
> qemu-system-x86_64: warning: this feature conflicts with MPX: CPUID[eax=07h,ecx=01h].EDX.apxf [bit 21]
> 
> Treat qtest like TCG here, to avoid the complaint.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This suggests to me that the default case is not something
> we ever want to be in, and we should instead be exhaustively
> enumerating the accelerators and asserting if we don't know
> how to handle this for the accelerator in use. But there are
> several accelerators that we don't have code for here...

Indeed. Meanwhile:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> ---
>   target/i386/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

