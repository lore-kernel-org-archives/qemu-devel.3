Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1863E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 13:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSFV8-0007tx-9v; Mon, 30 Dec 2024 08:08:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSFV2-0007tk-E6
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 08:08:00 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSFV0-0001ZZ-DE
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 08:08:00 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so104079755e9.0
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 05:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735564076; x=1736168876; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iHyjo8ldqRXFIJGWD1qbWkOleNn2wbGvAlqA7B6yK9E=;
 b=WcU2EdMgCrnpRz35NxcXJEco3HsW4uET7CaihxybYB+L8SBvNuabTiN3HJaYQN1kcX
 A2Tet/999D1sQvKoL7S8+aFBe2qunrWaJLVleTAlIKyvXk+av7qOz/h1u4bvWIk1N+vk
 2Rbd3MPSl67dxhb2Lqaj3TFwLNlCm5SpN/uesPuxLu8t/i9eGTOexfeFfzdtyMq4bxfu
 +qSVIB3NJZxRqOxVehpy2tUrEizlUrGFCYA5sKEwzsUuB9/WX+miDK3wCRWT7r6OJg8z
 7fetwOkt8VUgJvETO0ViElw/HhKUlxVUgunTCH8o9mVf84CM2VPFDw4Ot0kOqpwvbG74
 wYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735564076; x=1736168876;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iHyjo8ldqRXFIJGWD1qbWkOleNn2wbGvAlqA7B6yK9E=;
 b=qRgctjuEyGZKQPQ/zUM1W+2Va9u/xNUbQbHbMjtfDIIhHo/uqLx18qxysZbWtqYTYC
 CQaA5IBcwsvfs9+tQAsGNvEJLd1F+xkzYzkgbMq6IlhdFfNhcagLPgF+C1t74wTEjG9d
 fkKOn4TVFtwrpv/SYEd/l/HZb50m/8lRlx+EbSR1KiiAd8RWE9K1yyna8tRONiZTeYmO
 EerkYZQIynSbkyGxBMtihPfbWMerDQ+PEDuzfOIRMI+29xsVu95qp14ERYjExqUf1P0J
 TTXfOrpjGHU+xTW6qmw/1z09uG1CcyoB4AYeCnyoXKzHoz/a8VokRVS9rNP7UbAxRnca
 W4bQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWalgmfBOjy9H7o6yJHeSe6AXXD0NcPDVw3AzpFJW+0aQML13BxZH+BOuYuPNLyjHYq3lB6M/xAuMG9@nongnu.org
X-Gm-Message-State: AOJu0YyieNkkxWQ9WT5b/bLHiL6NNvvacgC9Qg/238AdGDNR8OhRJ6I1
 xO5CtQUciRSCSdKCjaRTWOyFtbsgUYFd0Yu5mjNgFf9tj32X5OTvswIR+rxPJd8=
X-Gm-Gg: ASbGncuEzSMpYwtKZNJb2mOp9zKoSsas8m6e6SHEYOpjnBjl2+v1aUkm9Zx0BwuU8Ww
 8gquMsETuL2dNaj1ZriAJo5wRib0Y1RvdcNhWuPzqtmwThwnyjZ4bGDYcWTeRi5MHjHJmu3laMQ
 TrhWs8X0k+qFCViksf/2uu0xareIXC6gMZ+0Vh+h79M3TWm7hYQO+vLeMxzgo/Av/Mnjba+05YP
 ecXTNdrrdP6nEknurxcJIh5uJsJsi7MPh/wU8+hMp6V6f2I2PTbItJ1MW70Vid//mZC30DmQBsb
 MxiR3WoXn98ya9nGoR/xrr93
X-Google-Smtp-Source: AGHT+IGndNsTgAhaLDq+kKfvdGMREKWKoXwjMq4rrB0LKbkBsOxtoyxXmB+inuaEs9iSHhZsldCz4Q==
X-Received: by 2002:a5d:6d84:0:b0:386:45e9:fc8a with SMTP id
 ffacd0b85a97d-38a221e1dfemr30879259f8f.5.1735564076210; 
 Mon, 30 Dec 2024 05:07:56 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a412f778esm15166428f8f.4.2024.12.30.05.07.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Dec 2024 05:07:55 -0800 (PST)
Message-ID: <2dcfe635-0a0c-4cf4-95b3-7d0e5ce27f16@linaro.org>
Date: Mon, 30 Dec 2024 14:07:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/2] target/hppa: Add CPU reset method
To: deller@kernel.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Helge Deller <deller@gmx.de>
References: <20241230002248.33648-1-deller@kernel.org>
 <20241230002248.33648-2-deller@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241230002248.33648-2-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Hi Helge,

On 30/12/24 01:22, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Add the CPU reset method, which resets all CPU registers and the TLB to
> zero. Then the CPU will switch to 32-bit mode (PSW_W bit is not set) and
> start execution at address 0xf0000004.
> Although we currently want to zero out all values in the CPUHPPAState
> struct, add the end_reset_fields marker in case the state structs gets
> extended with other variables later on which should not be reset.

This patch is doing multiple things at once.

> Signed-off-by: Helge Deller <deller@gmx.de>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/hppa/machine.c |  6 +++---
>   target/hppa/cpu.c | 26 ++++++++++++++++++++++++--
>   target/hppa/cpu.h |  5 +++++
>   3 files changed, 32 insertions(+), 5 deletions(-)


> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index c38439c180..cb1b5191a4 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -194,11 +194,9 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
>   
>   static void hppa_cpu_initfn(Object *obj)
>   {
> -    CPUState *cs = CPU(obj);
>       HPPACPU *cpu = HPPA_CPU(obj);
>       CPUHPPAState *env = &cpu->env;
>   
> -    cs->exception_index = -1;
>       cpu_hppa_loaded_fr0(env);
>       cpu_hppa_put_psw(env, PSW_W);

This is reset code.

Should PSW_M bit set on hard reset?

>   }
> @@ -235,15 +233,39 @@ static const TCGCPUOps hppa_tcg_ops = {
>   #endif /* !CONFIG_USER_ONLY */
>   };
>   
> +static void hppa_cpu_reset_hold(Object *obj, ResetType type)
> +{
> +    HPPACPU *cpu = HPPA_CPU(obj);
> +    HPPACPUClass *scc = HPPA_CPU_GET_CLASS(cpu);
> +    CPUHPPAState *env = &cpu->env;
> +    CPUState *cs = CPU(cpu);
> +
> +    if (scc->parent_phases.hold) {
> +        scc->parent_phases.hold(obj, type);
> +    }
> +
> +    memset(env, 0, offsetof(CPUHPPAState, end_reset_fields));
> +    cpu_set_pc(cs, 0xf0000004);
> +    cpu_hppa_put_psw(env, hppa_is_pa20(env) ? PSW_W : 0);

PSW_W is already cleared in cpu_hppa_put_psw() for PA1.x.

> +    cpu_hppa_loaded_fr0(env);
> +
> +    cs->exception_index = -1;
> +    cs->halted = 0;
> +}

For clarity I'll respin your patch including my comments.

