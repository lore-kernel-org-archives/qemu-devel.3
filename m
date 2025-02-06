Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D291EC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 09:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfyAM-0007Gg-9P; Thu, 06 Feb 2025 04:27:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfyAJ-0007GI-VB
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:27:20 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfyAI-0004LB-5m
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:27:19 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so3913315e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 01:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738834036; x=1739438836; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cNep7Wfr1D0nH06IxVT8g1BocdGSdHc6ANCazY79bd8=;
 b=llcDd5rdEmLGEOMR9mE01JoRqNTgh9+QfXC8xfWSXeVXXRJgBQ3qg5dW4T9suiWgT7
 nXEJGMJJ4wqJWwt/o2Lo55mFnsP7SS+EM8SJoT41C5Hndaylm55cOpVXu5+E3edgc+20
 +xO+gzyDP8FUhgq67pQ6oYXFM+786DeUhk/2iluZwbXeP5tqM6zjRhObpjrAQAEwQc3h
 GxSP177OftK8s/9mxxFTaDsTPCmu6j/et54j/M+eRo1jehRBJIvGJWtvwi/7blpgqbA0
 AJSP26/00c3GvGHoRO2jrWN5WA93Ns8yAlLgl2UGY91K2hsy49cyNsImWRMWVYSJHFNQ
 /qtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738834036; x=1739438836;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cNep7Wfr1D0nH06IxVT8g1BocdGSdHc6ANCazY79bd8=;
 b=O/W6Khd9nHT5N92NW1aWd9syDxqI4bcN8zEeG4X6jmvKatmzC0dr1VClFpmKVQD+eO
 5P+0K8NsdjpF2e2uQ6jsKVqqIFQVHtnb/+T1RyuRMnMcc2VkASnDdbyJ0LzxSN716p11
 fVTt9Scd1a5Bc4QIPwYxjp0NQjFMtjosku6ZWXMyC5I3+HYJ9ACtrbuHyFRAWsudTLSm
 RMl1eEoFxHViMDR3BFMXJBXKETxIiEJe+oVD+xDiKJ2J7PX3/1g6hrOCQnawq0KRYt11
 xFfMo9jbGIcp2GzG8/OBrzv29Jbi3fp4QFDBoe866SPwaOnurJUGfFeYVzcIdm+eDlFM
 5iaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5YlXzNSOgdqAfiAB1jqnv2YS7ntQwqlyd+qySxc5AqfcJf6NVDZcEjxhjq0SGCh0N4VDGwX5rmae8@nongnu.org
X-Gm-Message-State: AOJu0YzZXwOpFjdhX0Y66K00hxQHQl0hcNqImflpswLaf7XbUAF8ZBNN
 StnY8H/n6fI8STJVDhu0+d2WZ3uGVKkmhyN195KWMIElIrG0q0rUbACKjBDAPnE=
X-Gm-Gg: ASbGncvaEKWce1PzB/Lbo4R5K3BUI9dpv2AAT64Nf+zfYFqrCeCMoAnE8O1mDv3TfqW
 AD/jXfVnEMSVajbUKDOMO6ByTiTSd8pyDkP9dyQ9irsLUMidauocjY40ZSR4bHLBONJ9/6FWCfh
 POUXT5SId6rlgnI4/Cto3l2kE/30Io6BhkQWYKQR86ZCRZA20A7xnVP+hJWobY0tJ0Il+kHx9A9
 4yJWbX1/G2dZNFvuvzrOA49hdxO0ZvvW7qq2x0tefbA7dUPKA0TF2Bc176bqWMcVFmDYffGF1Wb
 iTbKR3BVS6zhszdSFyo4HkyL2CNzYbYg/wweI/HOm25Jl/oUerMbD/sMBSs=
X-Google-Smtp-Source: AGHT+IG+sGnjYzYdB8MiVAeAi1ssRvZAy4YoRuH1nySDEIyv30pfYJpwbSrqJNLx3Rt2bHvCZm7+3w==
X-Received: by 2002:a05:600c:5112:b0:434:f1e9:afb3 with SMTP id
 5b1f17b1804b1-4390d43127bmr49398105e9.3.1738834036500; 
 Thu, 06 Feb 2025 01:27:16 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390daf3c70sm48511565e9.26.2025.02.06.01.27.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 01:27:16 -0800 (PST)
Message-ID: <965daf37-813b-4fd0-9575-a55fbfaa28c7@linaro.org>
Date: Thu, 6 Feb 2025 10:27:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/17] hw/arm: Add NPCM845 Evaluation board
To: Hao Wu <wuhaotsh@google.com>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, venture@google.com,
 Avi.Fishman@nuvoton.com, kfting@nuvoton.com, hskinnemoen@google.com,
 titusr@google.com, chli30@nuvoton.corp-partner.google.com
References: <20250206013105.3228344-1-wuhaotsh@google.com>
 <20250206013105.3228344-17-wuhaotsh@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250206013105.3228344-17-wuhaotsh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 6/2/25 02:31, Hao Wu wrote:
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> ---
>   hw/arm/meson.build       |   2 +-
>   hw/arm/npcm8xx_boards.c  | 253 +++++++++++++++++++++++++++++++++++++++
>   include/hw/arm/npcm8xx.h |  20 ++++
>   3 files changed, 274 insertions(+), 1 deletion(-)
>   create mode 100644 hw/arm/npcm8xx_boards.c


> diff --git a/include/hw/arm/npcm8xx.h b/include/hw/arm/npcm8xx.h
> index 1f7e3d8116..f465d1eeb5 100644
> --- a/include/hw/arm/npcm8xx.h
> +++ b/include/hw/arm/npcm8xx.h
> @@ -52,6 +52,26 @@
>   
>   #define NPCM8XX_NR_PWM_MODULES 3
>   
> +typedef struct NPCM8xxMachine {
> +    MachineState        parent;

Please use docs/devel/style.rst recommendations:

'parent_obj'

<new line>

> +    /*
> +     * PWM fan splitter. each splitter connects to one PWM output and
> +     * multiple MFT inputs.
> +     */
> +    SplitIRQ            fan_splitter[NPCM8XX_NR_PWM_MODULES *
> +                                     NPCM7XX_PWM_PER_MODULE];
> +} NPCM8xxMachine;
> +
> +
> +typedef struct NPCM8xxMachineClass {
> +    MachineClass        parent;

'parent_class'

> +
> +    const char          *soc_type;
> +} NPCM8xxMachineClass;
> +
> +#define TYPE_NPCM8XX_MACHINE MACHINE_TYPE_NAME("npcm8xx")
> +OBJECT_DECLARE_TYPE(NPCM8xxMachine, NPCM8xxMachineClass, NPCM8XX_MACHINE)
> +
>   typedef struct NPCM8xxState {
>       DeviceState         parent;
>   


