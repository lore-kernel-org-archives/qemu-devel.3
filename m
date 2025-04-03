Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374D5C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 16:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0MzB-0005LE-5I; Thu, 03 Apr 2025 12:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0Mys-0005E1-Kk
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:59:59 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0Myp-0001Gg-A0
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:59:48 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7376dd56eccso1222390b3a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 08:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743695976; x=1744300776; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=b766tCAV9jLcAE67LqCJ9r0kWHYTjvrHiYTPNw9kS5g=;
 b=TfpqnMXotl9ZV9gGQ4b6vz6VwTjrHL1t6sOP3S/0rR3zKbG4rci+gcjBN851LwnBKw
 LHENHTLW4HurueBHUbbLsy8cykrHBTo4IXX6JbkZdj4Cblsj24u3psNU3zwRM8wY6fd6
 uuxaSjNHGxHPUQH/5AwSdqnn/bN10JzOQDXvITYq+PRVIE3EfYf/DV5qqom5e9KDMKIH
 JuNLnHniO49Ymux+R6fVHs7JMPuUf6o2Y3hj5TQAmZKuIBxQZCEDBTUbrFqyKbY0IVo2
 IiS0ITuwimcswyvVBRV0sFzobCtghUumHTKDcaQT3FGJCXTzOq27oNYh75S0kqz35tqV
 k1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743695976; x=1744300776;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b766tCAV9jLcAE67LqCJ9r0kWHYTjvrHiYTPNw9kS5g=;
 b=Jtl3XxOnjDyw3fE86mzjMGnFYNvrVWhmdCIN3INT6dP9s71/b4npUpu5ZYufirqlKb
 teh43wDirFuGjbOG+w4++3VQ63JqjEdvUurqxaiy38NL+qvHBLMYNdjuM6ksUIE+4cPv
 wKdD4WSHzQ9GXJKch2n+YVJekInQQtS1PMB8yX7YkDv6cpGy0t58Nye95o6RCi6aBFgF
 aPSiTSQN2Mq34MkKzb4HcLfxfKCdtTaozuU9+1/H8sdkArafmqcC2ifnKQoEW7Jo2RO7
 RKtncs18kyqy9dBTU/EQlQHhxghjv9+/YwzmNIsxUwhUezITqEH/GdidMlx1dSUXrQ5e
 O3SA==
X-Gm-Message-State: AOJu0Yz4AdYq85h9d2EFUh2Afze4nnjEsBrKZMhO5hAFKWvA7q6b2uR9
 Z57h7UIHHb+nDagui+Q5JW+c+y3ZTb7bh90ZV68VPzqiczR4s4eDJCrsx3V6rXpaucn2h1A7+px
 h
X-Gm-Gg: ASbGncsWOKfpJySmGgV4Qceg6OE19MAl2c498FcIIwmFmH2i8cleH31oVxcPvwdnVpy
 52n1GIdm4w758ulhBVMwoIVx+9ejRyjbioyA/NPlJjl0AgodW1Enhtoo8+qlqF01egk+qqxzaQR
 rCtMNvc+G5yXkdZIQniR1s255X9AVRxqcDN4aCtGXUkGo3K/5vba13YIPXIcScMZMUIjY/d0vpL
 Tz6SspmgZAfWwT32BwuQjznfohFhytPi/lwmwEpa9Gqh2wlhPCr+PXaRAqH1fIw3cBSAN6+YyEx
 H9PeQyfUKT+oyJrBcUSjaXSnfr9e0yvkhQElkItMFlMcd455PmAI/ql6fYZ3+LwbqLHRC3P+g/x
 oMnEAUb79
X-Google-Smtp-Source: AGHT+IGm7/lZHicNhkVZAyMP8I+emjDOHx/Kjqx5soNx473qvfJGqadWfxHSJHqwN0AardR8+H9svg==
X-Received: by 2002:a05:6a00:4606:b0:732:a24:7354 with SMTP id
 d2e1a72fcca58-739e48f949amr135647b3a.4.1743695975916; 
 Thu, 03 Apr 2025 08:59:35 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af9bc2d04e5sm1388991a12.4.2025.04.03.08.59.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 08:59:35 -0700 (PDT)
Message-ID: <4f0d713d-7101-4f8b-9036-c846f740c473@linaro.org>
Date: Thu, 3 Apr 2025 08:59:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hexagon: Implement CPUState.mmu_index
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@nongnu.org
References: <20250403154956.791976-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250403154956.791976-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 4/3/25 08:49, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hexagon/cpu.c | 6 ++++++
>   1 file changed, 6 insertions(+)

I meant to add, this is to enable some of the other single-binary cleanups, wherein 
implementation of CPUState.mmu_index becomes mandatory.


r~

> 
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 766b678651..59fc9ed698 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -313,6 +313,11 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
>       mcc->parent_realize(dev, errp);
>   }
>   
> +static int hexagon_cpu_mmu_index(CPUState *cs, bool ifetch)
> +{
> +    return MMU_USER_IDX;
> +}
> +
>   static void hexagon_cpu_init(Object *obj)
>   {
>   }
> @@ -341,6 +346,7 @@ static void hexagon_cpu_class_init(ObjectClass *c, void *data)
>                                          &mcc->parent_phases);
>   
>       cc->class_by_name = hexagon_cpu_class_by_name;
> +    cc->mmu_index = hexagon_cpu_mmu_index;
>       cc->dump_state = hexagon_dump_state;
>       cc->set_pc = hexagon_cpu_set_pc;
>       cc->get_pc = hexagon_cpu_get_pc;


