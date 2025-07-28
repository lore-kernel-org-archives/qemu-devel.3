Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F77C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 10:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugLG0-0007mN-C0; Mon, 28 Jul 2025 06:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugKwM-0006Cz-4n
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 06:18:47 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugKwD-000218-2j
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 06:18:41 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so48050365e9.1
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 03:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753697911; x=1754302711; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DbHXTiiurlqHHXoNzK1HLQQcM4G2zIdrQoITCniBuPo=;
 b=ewxewxJ32YvOaE61UmZI2M/DPqPyVlwvWJzaXy2bijnYt4v/VMFTPJBsI4afP7T+ts
 n3OEY2Gx0YGO8RzrceZbqgC6JVycSXu4wmXNtymOu5KAtNkCORIxobiH87+fjt8Xc69c
 8+LHXA/+cF2VmP7Z4TcxWaTt++z7vVMoFLQpRYQWuUzL/hSFvWv09i+KWS6e1ovzYri/
 t9MknMxh62vMvluHep9a9/Q0MCGFkyzSvTJQYEC5DFHolhhmepwzUp8ToSabUQgL7Fdn
 8t/fkcwh3eZ40IjF9tRmI9EvcN1YZKPR4G3ZQpa8j2VXgSR0ucak08d6TFjASwORIYGd
 6dhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753697911; x=1754302711;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DbHXTiiurlqHHXoNzK1HLQQcM4G2zIdrQoITCniBuPo=;
 b=S2mwWh7OLdXEVXgdLMFPswy2Z0vyHFYPDwL1YpHgnp9REeKd/1FYZDH82HBi9HBSO0
 O2aevD5VMAsnba9b1OJyrWHj2eARDxDs/amKPxDcbHoUMC3cthJJg9cXyHYnM5ttuclN
 G35Hufz7tE1r8HlK4YokH9an9tETnZp6mhmA/vqwVJ+/nyXiQUPwrAd0+IekRwFCA97a
 bMmvBAgf4xqs73RZZW5v5P7SLIvYv9AklmXHeZlgU22Y1ZnbO0aRdwHEct7+dV0e9a3Q
 BLzNg2v6D8j0tFxozWlNislwUjLfczXjftAmY1gPbsLt6R3zqAT3pfhiidnJXMu3oWSo
 eLsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbfJe6hqaqAMSnorZVhNEhR712Y76fZPARawHeNU2avc+VJuBUEAM9CPr0xddmFY3ecryYTh4SmDYZ@nongnu.org
X-Gm-Message-State: AOJu0YxBlhLmHAyhiOyGYTd7hFDtOXvSE2ItzncN3SY7lZj/5K7HT138
 wS4A7n/FDWv1XSMrGE4SNC2pr8oJw+ewMqcPiVZTt4EPcq0cBxj4Gyp2AdOWS3uPvkg=
X-Gm-Gg: ASbGncvgHUP0MlJCK+AMYEw2wALH/pjxppgdW8/E/4gfAODoVxXjNK/zAJGUOtc5QqH
 MtfjThFywnrlu9ZE0OsmesH077bNH5PCQ+ICg4OiNEYhwpqY97SlK4ZCIL5aBJ0/ChZQqSKb5Bo
 yQlF2o3tqNufNxmHyOlVsXC2iYOXaBMoK3Tzrbi/bnak4KIcCRJxPBfeEVkFFIfeOSwWd2Fg5Ae
 5ycHRDswsMmRPQUBSH+IssiWkZpkKY/Imf6SU70GQB+UGpzflKWO5A6cX5x3e4AWfBoYYQO1Tr3
 2tjTFRgw8riAF2Elu0ETOfTazy9bClUbgPuPeEnHdn3d3pZpRZseC9SsvL3msCY9iQMbw6/9U6w
 fknA0u1YP9Axyqu+AvsxZEr10+0vPnjYrm+WaJ3vHO3wdegZlw/JC781fgbHhUmrzWw==
X-Google-Smtp-Source: AGHT+IF5JOoz/Xn9nawAktnwJI1Z51zXLbvRu4zlUNWpIWMJUKMzc4m0nQJB25/CJX2xToRdLDQRhg==
X-Received: by 2002:a05:600c:3f15:b0:456:58:1114 with SMTP id
 5b1f17b1804b1-458785288ccmr92315405e9.9.1753697910758; 
 Mon, 28 Jul 2025 03:18:30 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587ac660b6sm96033975e9.24.2025.07.28.03.18.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 03:18:30 -0700 (PDT)
Message-ID: <e9afdf9e-b357-43a5-acc6-f4839c539585@linaro.org>
Date: Mon, 28 Jul 2025 12:18:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/9] target/arm: add asserts for code paths not
 leveraged when using the vGIC
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250725223035.52284-1-mohamed@unpredictable.fr>
 <20250725223035.52284-4-mohamed@unpredictable.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250725223035.52284-4-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Hi Mohamed,

On 26/7/25 00:30, Mohamed Mediouni wrote:
> When using the vGIC, timers are directly handled by the platform, so no vmexits ought to happen in that case.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   target/arm/hvf/hvf.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)


> @@ -1965,6 +1971,10 @@ int hvf_vcpu_exec(CPUState *cpu)
>           /* This is the main one, handle below. */
>           break;
>       case HV_EXIT_REASON_VTIMER_ACTIVATED:
> +        /* This is only for when a user-mode irqchip is used. */
> +        if (hvf_irqchip_in_kernel()) {
> +            assert("vtimer activated vmexit when using platform GIC");

This line does nothing (not firing), is that what you intended to?

> +        }
>           qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
>           cpu->accel->vtimer_masked = true;
>           return 0;


