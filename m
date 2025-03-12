Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B748C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 19:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsRc4-00065n-KO; Wed, 12 Mar 2025 15:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsRc1-00064u-Qx
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 15:19:29 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsRc0-0001eY-2Y
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 15:19:29 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4394a823036so1421905e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 12:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741807164; x=1742411964; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nOT/cGJwPVoU+wOUKMLRMzvtZXecr78MQOzBVJw9OUw=;
 b=n41U4iF7IeucR2ogknN/fa/FWfIgozIQUcz0HmwgwylLqT/DzD5bQR/ZjZ8la2GbVb
 asPzjczLR8n9pigVOclSL5ehPV1S8+MUUL9MQbEXSBCRoIf+g6poaJf9I1sq0Xn3k0ei
 M0hXqka02iweJ93qggQml5Zd1WEQFNR5u3KCMELVNnkJBkmud9Ny5hCDWE6rk6hq4YO2
 1MsmOODV0RwtUhYB4sbii4OVr9BByS1tj6RlO2ve6EZbGCQAjluqhYkaFkA5eU6pLB7q
 e5x+411f+Y4oe7TZWTwfwQu577S+X3Skd60IYcq5hx+q3FrhO8iw/bQvc+ph6RfnoxEU
 nCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741807164; x=1742411964;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nOT/cGJwPVoU+wOUKMLRMzvtZXecr78MQOzBVJw9OUw=;
 b=kGvYsWbeg1lsNpZlQ2Ez9+eGCsljKIH58+hedysebcgqg4rHLaTOLsYpUs5BwPWKXN
 yRkFiNmSjWXiEN/5VXd+vWy2oLVstevmWB4OV3WxVoi9mgPHQJiYYvJtEMtF0aApl4aI
 zARkGL9g7UBIkJRX195Qmxx923P0X5goNgn89ACCoJO9lsNaVxQ/z/AMQO6/XvGM3dXO
 km0qRwTYG3JLmDF0TsJ3WR2iIz+ONeKuke/G6h4DIOT2SnO6fmnoeA99+jV0fDaXcpFD
 WM8b+x0MRCuTxkg3gcajymGFr/7Bv9SYShSBc/dhikqrK7zGMHwgg3UiitfyHuS60x5o
 ApnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpvnfiOfCTWKMjvj50c2qSblMTpKrICEP29u56QLQsxHWcodD6/d0+k6vh4fxo6WjgXX0I7sfjnyRd@nongnu.org
X-Gm-Message-State: AOJu0YxgZt4Reve/rWx3cFSFYL9svfm4mz/s95rpTW+4s1+HIjv2lL1H
 D4Fl5O3qbu15KLinEy/DEvYYGQhOtE2V4mqQSpfdEMjdB7Q8VTbFjKR/6A7pzJk=
X-Gm-Gg: ASbGncv+/761J5oEeOTgHq+/Uj8j/VnLc0ir6dLqsOQnzFlW4q3RixTXBGgAj4TOy23
 XgFhNfXzueqYLnuxzuxAwrdK8ssCvUNToCysdlSpjb0c3TjKPxafefq3w7QEVTKU3ZhKHJcm+e8
 h66EZCJ+HFJRuN+6lqUQ5cdpNfleNuOxgiJzzjdLOWr/acBNRLas8Zsg4CflBhXuBnQEUqiVFc6
 7z8qCInFH1JALqZUueCHZOMW40qasS8hu99AUw3l6qT1VmMDrHJlBUVVZq+cOPpaTZe90ndNzMT
 l0c8yZ0BgsjbSUqFRb5clihxyi5rFe6Or/XGB1o8iptRNZzhutu8wf7lCBw1F3P1Hmeb/ViWas3
 nb6N7RMXcKmngm8w=
X-Google-Smtp-Source: AGHT+IG4Ysdi413+/PSj3k0/sdsnpk/OONf1t4SZg9Lxcp+fFDAa7FNcKEBuqUp8C6sJbNb6dqy2JQ==
X-Received: by 2002:a05:600c:35c7:b0:43b:cbe2:ec03 with SMTP id
 5b1f17b1804b1-43d01c22600mr82090675e9.27.1741807164615; 
 Wed, 12 Mar 2025 12:19:24 -0700 (PDT)
Received: from [192.168.1.20] (88-178-97-237.subs.proxad.net. [88.178.97.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d0a8c5d04sm31090585e9.27.2025.03.12.12.19.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 12:19:24 -0700 (PDT)
Message-ID: <44e23197-a2ec-4477-a4b8-a526f83e47c2@linaro.org>
Date: Wed, 12 Mar 2025 20:19:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/38] target/hexagon: Initialize htid, modectl regs
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng,
 anjo@rev.ng, quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-29-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250301052628.1011210-29-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 1/3/25 06:26, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/cpu.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 36a93cc22f..2b6a707fca 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -26,6 +26,7 @@
>   #include "fpu/softfloat-helpers.h"
>   #include "tcg/tcg.h"
>   #include "exec/gdbstub.h"
> +#include "cpu_helper.h"
>   
>   static void hexagon_v66_cpu_init(Object *obj) { }
>   static void hexagon_v67_cpu_init(Object *obj) { }
> @@ -290,11 +291,18 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
>       set_float_default_nan_pattern(0b11111111, &env->fp_status);
>   
>   #ifndef CONFIG_USER_ONLY
> +    HexagonCPU *cpu = HEXAGON_CPU(cs);
> +
>       if (cs->cpu_index == 0) {

This doesn't scale to heterogeneous emulation.

>           memset(env->g_sreg, 0, sizeof(target_ulong) * NUM_SREGS);
>       }
>       memset(env->t_sreg, 0, sizeof(target_ulong) * NUM_SREGS);
>       memset(env->greg, 0, sizeof(target_ulong) * NUM_GREGS);
> +
> +    if (cs->cpu_index == 0) {

Ditto.

> +        arch_set_system_reg(env, HEX_SREG_MODECTL, 0x1);
> +    }
> +    arch_set_system_reg(env, HEX_SREG_HTID, cs->cpu_index);
>   #endif
>   }
>   


