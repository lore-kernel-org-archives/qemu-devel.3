Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1462ECD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 12:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRqkr-0004gW-02; Tue, 26 May 2026 08:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRqkp-0004c4-BQ
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:19:27 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRqkn-0007um-Ls
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:19:27 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48e6db3ff7eso54233825e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 05:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779797964; x=1780402764; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CXoPa6m17h4DqLeFKUxx06IILBeKT/BlObPXpO0sqM4=;
 b=gmtvuOqWqpgd4IJpD9QajV1QxTRXjww5VEctNvjoF0ghwuQskfwMMSsBoacFRothhG
 U1gQ71EjHbYeyemPTW87CMr9959GkgPRkPjCIf72E1pl7OaJIGBS8MijMY7a+GuHZDoi
 2HO4xmZyE7AAvexrQWjYPfy83YrgAfSJMpdC/j2CQc8z4MXAo59TTAyz7oDOsUXMhGU3
 hRyoUruGC4IuqBpqd/SeEYTLmDFAlkDQE6krpfUc5OYIACANs25emOYn5XauOnPDiejp
 ai73NEqCHBSveJ3s/SWK2tKluHEBzCY+caOkks9Q918GvPhMGjGFxXsywPdGzIdAC0+F
 adhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779797964; x=1780402764;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CXoPa6m17h4DqLeFKUxx06IILBeKT/BlObPXpO0sqM4=;
 b=l8690+kfkfPLLdodxmDc/TG5QeQ9lp6lOGy9G/VXLBrudYMWoskfAK3wkhb64Ax27Z
 b2HWTi2VGhBCnxzBc8svee3rVl8w/xOC4HIqpTkGqHf+AMMQi/Gt+d+6OQ/vo30iSC0/
 13gDAtaJF1daTpVtdpjUtmLCkPC11tpqtP2SguoRHAGRFUoHU7uQugjfRJE3slX+7U0u
 +3X+XbKFhQbE16eOJPwwEhDADqgWXWy3wFOu8c+E9OQFlFmFiUm2n7LFvQDsynAKmdcJ
 Ng7LfwZ11OgBoay861WFW68/99W1iJEc6Cnkt8DK6Wisoqv1YIFfXzbMz4lpIGcEILTM
 p8yw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+AAaKe+/Njr14at9AcLajJrOfomJ1VWQQ2V7qTCe7s+5V6zk+XWkL4FX6z1SoGMMV48uq+m1IGtNSx@nongnu.org
X-Gm-Message-State: AOJu0YxqvBUboAP/9Wa1nsIj+otuWF/t/Uqvg7sbzBppwZrurfk96Jbi
 WTub28L9eYgPSM1rY3FBr19Y4S25mBpJR3YLgvNnWPoUs4d8SuM4qr/l/pXCfCMb8bQ=
X-Gm-Gg: Acq92OGbecTrQPz3kgWZACJuJ4hLPpE3MlwC+1ny32jbAlXwXZX9YKJypJOpeGwJwDb
 SgcT4sUv/GoW4b5ye8gbQenTP1440+jrGJCIY67BrtsfD/yecmiyqG7+yBXjM2ttSou0DESNLqh
 v9j/nftVpWH2dZyNW14goe0ohWmlihHs4Wx2JOKnAQEOhA3M3BqSKWWoEjKH+BvF7OqvROm1KUR
 ph/BtbWDxQ3zFl8S6u99bOysDVJUyBkQS7/5YNYgc2zFB1fNA/BH8xZa8d4F6GDJOejnqa4lMi2
 VzuU5pZAIIMdZcZjprvPOr8WkSZl4dQDGx2QqiRpBGRBS6jVyCTwALv+2a3yZtVHBioVAnACw5F
 F7fCowtT4gOwVvNR2fPC71CyQYI+R1f3TPGkWjhmgd0s2+3XHAyX66e+Nwtep3uQ7Xc9BtbeN0W
 Z+nOrSQQFRxQ/ckzmDvi1UPs24jsnCMx8umc2Q+ZeNpwN7To2/XFWDr7dcFf0xeVocpw==
X-Received: by 2002:a05:600c:3b02:b0:489:201c:dc46 with SMTP id
 5b1f17b1804b1-490424b2cf1mr312324255e9.12.1779797963784; 
 Tue, 26 May 2026 05:19:23 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454a0b82sm339222215e9.9.2026.05.26.05.19.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 05:19:22 -0700 (PDT)
Message-ID: <4e562850-06c3-48f0-9023-d1c5df71e828@linaro.org>
Date: Tue, 26 May 2026 14:19:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] target/riscv: Reject x-misa-w without TCG
Content-Language: en-US
To: Zephyr Li <fritchleybohrer@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, daniel.barboza@oss.qualcomm.com
References: <cover.1779792111.git.fritchleybohrer@gmail.com>
 <c33bea8085f103db209eaf06f978297bba727d88.1779792111.git.fritchleybohrer@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c33bea8085f103db209eaf06f978297bba727d88.1779792111.git.fritchleybohrer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 26/5/26 13:04, Zephyr Li wrote:
> Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
> ---
>   target/riscv/cpu.c         |  7 +++++++
>   target/riscv/tcg/tcg-cpu.h | 10 ++++++++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 1dea66972d..8f54610097 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -955,6 +955,13 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>       RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
>       Error *local_err = NULL;
>   
> +#ifndef CONFIG_TCG
> +    if (cpu->cfg.misa_w) {
> +        error_setg(errp, "x-misa-w requires TCG");
> +        return;
> +    }
> +#endif
> +
>       cpu_exec_realizefn(cs, &local_err);
>       if (local_err != NULL) {
>           error_propagate(errp, local_err);
> diff --git a/target/riscv/tcg/tcg-cpu.h b/target/riscv/tcg/tcg-cpu.h
> index a23716a5ac..20ad294f88 100644
> --- a/target/riscv/tcg/tcg-cpu.h
> +++ b/target/riscv/tcg/tcg-cpu.h
> @@ -22,7 +22,17 @@
>   
>   #include "cpu.h"
>   
> +#ifdef CONFIG_TCG
>   void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp);
> +#else
> +static inline void riscv_cpu_validate_set_extensions(RISCVCPU *cpu,
> +                                                     Error **errp)
> +{
> +    (void)cpu;
> +    (void)errp;
> +    qemu_build_not_reached();

By stub I meant a new unit file added to the stub_ss[] meson source set.

Anyway, I'm not familiar enough with RISCV but if it works similarly to
ARM I'd expect an accelerated 'host' CPU type to have all host-enabled
features, with the ability to deselect few of them. In that case, the
riscv_cpu_validate_set_extensions() helper wouldn't be TCG specific
(since validating the architecture restrictions).

If you need accelerator-specific CPU feature validators, you could
dispatch in riscv_cpu_validate_set_extensions, eventually expanding
AccelOpsClass.

> +}
> +#endif
>   void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
>   bool riscv_cpu_tcg_compatible(RISCVCPU *cpu);
>   


