Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C613C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 09:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taX6d-0004Ja-6T; Wed, 22 Jan 2025 04:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taX6Q-0003mV-DZ
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 04:32:52 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taX6M-0003TH-I4
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 04:32:49 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43618283dedso68333765e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 01:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737538364; x=1738143164; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U+c1swIdX25raxhIVr45XwfuWhAb+MHj2TpSRJRPmw4=;
 b=goQieLPQU+R/W6HQOcToU+/yvk1bYP1VbvBN2+sYuS2ceO51rEVkqNcpezi9tohpXY
 2ISBeunF4Q4zflUTc5aKPoGEcww0PI3o5g559t9/XxlmXV08CAsSp9fTOq3vH9U8Rolt
 6PqQHlK6o2xgBjZAmPntexjt5Q9GY9u9tVm6Bkh1CHsm9XTExqCIcFIh7FO39MOZLtGB
 r3g/68OvqpxZORsCw8+jtvN5tStJstEtHkuQPqZrNk4YZ77ToHH9k4ZV3ceDyoqOFerp
 Pyo6LFZJOEMqyv4h1dzcg8XoqUWdJZ1AjCnlNuIvZl7cjoyz0aQdFFsuOmWwnhVoZ5BA
 sAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737538364; x=1738143164;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U+c1swIdX25raxhIVr45XwfuWhAb+MHj2TpSRJRPmw4=;
 b=cz95jAN9kFlsaHYc8H1uo94K5U6lICOW1OK4sOF/E4/6OmloQ7tSU2U5hbHUblqLVy
 J9EEVg8zzbmsIBo6HnT/Lmy4vRK8BkdIBXMFFrWqfz/gHnjBYc/v/ReDLLbesycjmSmW
 AkYZI7JJOWV4l2wk/14lznKvoVjXntqBbS9Bb3V5qFmnRPfXRMZlXoakXHYUL54mEvke
 2nA/hwOs25B4DuKoDl57IJSmhJ5jhsMkaq3XthD6Rwp+XWKz6Wu0gdvHPHp80ETmuy4a
 Ly9dwSWNCUnyVmR1Fj8PRiFXhqsc1Kl1M86yI/0d1EgG2kN2WFYe4WA5VDT9SMyQLFte
 qtjg==
X-Gm-Message-State: AOJu0Yz0cEECeP4zmSPOpVjWRVz62VZkKj4db0vsX7D3jMmdoYmLGi6h
 0nkR5rf8h1NO1pesnziJp7BG+okQWN91KG75kViFQqtJY0ddUXxh/KVmBk/xHmRNBqTYlDX266l
 0d30=
X-Gm-Gg: ASbGncvDSMhMotFK9ZdG4G/ODWRztiFTKce3aUFlFz8eN/XS9G1/gUclkYISmC+QZ+0
 BDPRKHkx16u7LVTCr0xNlk/Rb+74G+b8It/4o8tE7NDdhGwE+JtAIgIcQ9uCMeqSff0m34Jrxkw
 99L5QV4wJwWWydv9V2PhkdzocuLUDO6di5Z71cfdVWZYtbEHUksAaE7XcBUqCQk1vQKTvwwc6u8
 V8l+7MEm8TE9dw6DvAXd1Vkb7JGyeZLN8dVPFQlfbOqaXrKYPFoXxYTNlwzQesTEy7Pkh5DQZxf
 ExpJP8Jb8oUcz7b5WP8NoJmKplsfx9BPkbo+Gg==
X-Google-Smtp-Source: AGHT+IFnb94z8uN14ed8JufyynaaLzmxZhewH5ITBpwDQCN121Y+HFMqyEfhMa6yMCQQLL16jM8/SA==
X-Received: by 2002:a05:600c:1f8f:b0:431:93d8:e1a1 with SMTP id
 5b1f17b1804b1-43891430defmr164864795e9.27.1737538364286; 
 Wed, 22 Jan 2025 01:32:44 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b1d904cbsm12962295e9.1.2025.01.22.01.32.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2025 01:32:43 -0800 (PST)
Message-ID: <dda293ce-575c-45c8-ab36-93938a7c5bdc@linaro.org>
Date: Wed, 22 Jan 2025 10:32:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] gdbstub: Clarify no more than @gdb_num_core_regs
 can be accessed
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250122093028.52416-1-philmd@linaro.org>
 <20250122093028.52416-3-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250122093028.52416-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 22/1/25 10:30, Philippe Mathieu-Daudé wrote:
> Both CPUClass::gdb_read_register() and CPUClass::gdb_write_register()
> handlers are called from common gdbstub code, and won't be called with
> register index over CPUClass::gdb_num_core_regs:
> 
>    int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
>    {
>        CPUClass *cc = CPU_GET_CLASS(cpu);
> 
>        if (reg < cc->gdb_num_core_regs) {
>            return cc->gdb_read_register(cpu, buf, reg);
>        }
>        ...
>    }
> 
>    static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
>    {
>        CPUClass *cc = CPU_GET_CLASS(cpu);
> 
>        if (reg < cc->gdb_num_core_regs) {
>            return cc->gdb_write_register(cpu, mem_buf, reg);
>        }
>        ...
>    }
> 
> Clarify that in CPUClass docstring, and remove unreachable code on
> the microblaze and tricore implementations.

s/tricore/openrisc/ 🤦

> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/core/cpu.h       | 2 ++
>   target/microblaze/gdbstub.c | 5 -----
>   target/openrisc/gdbstub.c   | 5 -----
>   3 files changed, 2 insertions(+), 10 deletions(-)


