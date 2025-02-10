Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00143C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thX0M-0004Un-0x; Mon, 10 Feb 2025 11:51:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thX02-0004Tq-Vb
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:51:12 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thWzz-00078n-Fi
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:51:10 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2fa8ada6662so1450755a91.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739206264; x=1739811064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zKhcPZDyDkMb0I4535dq3caoKzbRC3tNQalV1ksPLzY=;
 b=Wc2JOw//IzR/py6RuauHaFr08NQdMJHbGe+EBZL4i+8KKe84dSKvQHn3AITEnc1JLN
 UQbQNIGG7SG0NuOzk3c2c5iVsqoe6lx3+RELhcX7djBUOziVkjbT06lp4wuTBwlKDwZ/
 kIDEAyFluGg6gqUEuIwZQxt7cXMVrTabIaMHCpdYBee83Uj/9npUXWhHFW7hA6cK+VPZ
 iZE7JYZ5yRgPM2mW5CN4buo2xk4oR7nZaq5Z2/SsdH5KSHzVb0TtHjJhOX/LPHjzDXpx
 NGwxVSO5+Sqg1TwemUI9Obu2nQu9NqLKlTb89Q4j3/FZwKQNp8SqpP8mKlwmOXHi873p
 6/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739206264; x=1739811064;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zKhcPZDyDkMb0I4535dq3caoKzbRC3tNQalV1ksPLzY=;
 b=KoiKG7ed1SqfYqRSXNAy4314VPek6zjlIhhdmWbCYlRLy1YNbXhgFFzZKfue/pdDTk
 mVAuxy5vZ6EfKcsoCrgJ+Yx+DrJECAsQPwgwAx12pMupoEe6KH8jr3GPfJPwtn+7X5o7
 3WOs/LUdy42ulO76PzNEqXzHKqs2lc+F9usVL9I6B1FHmjJyMoFX2uvWzL/DwSP0V9eW
 sRpPwrN4y3HrAe0fWjeHfMfgErItp4Co+x2ZY+9zOmzCeZgWBsYjwxXbNTKqn3FJitE/
 xN9JxcssmeWbPb9uGfnygCa8bm4B3FXy5tGeS0+wZqDMSB+1LFVBAuvr4PCzHl+L0bjm
 ynAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUV+gj/iSus0lg5bhjiFlCfr2PKo1TTT93b/UmYNp1AG71+PzDlAdNTu4v7sIvmQrj6WxbrrJqs7x4@nongnu.org
X-Gm-Message-State: AOJu0YwqrYL4F5iw6XmtDiUCKQXACq0nrlWvE/EadErNiOdkdGm1NT3I
 M1fyak3tHVf4KWeZG5DFa+QM/SRpnUpSAIG4Pndq726RV/NnJChpQQdyvjprd+A=
X-Gm-Gg: ASbGncs4iGXWjVeDWid8mo71V5QwYGdXqKY7WGPPedplrZwwWr6tvwc/O3v6W1jdzT+
 7U/RAItBVQDeCgdPksGL7bnx/EEBfrZ/sAAvFR1ed5RbtihfRreK9ahYXcxEA5fw2ZQretM/leX
 t2IZ40Xms0FWsLH/86sGBe2Yx6JKLNP46v/gsEdgbuAENcFq9C7vkBtIgQJ4p+gg0Nbde+X1uH7
 MZNWEzRh4ClifRfAZUIlD/971VGjt8augHPbrZbyKa1iCScA9v5RRNPLu5RhzkhFYkdJ8fXfVCx
 vJIf6y+JJlOIw1S1j7MvlTIRvVCDshp4rLO0TBjm1q1tDe739BvOWSA=
X-Google-Smtp-Source: AGHT+IHvBXvOqGSSmDIZn+ruRr4jtH1XJdOOJcrsrRx9PQWsCyTEw/GG4hzR1z6oyJLH4qHEqE2tmw==
X-Received: by 2002:a17:90b:5544:b0:2f9:c56b:6ec8 with SMTP id
 98e67ed59e1d1-2fa24069385mr24047129a91.10.1739206264007; 
 Mon, 10 Feb 2025 08:51:04 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa17618064sm8061239a91.41.2025.02.10.08.51.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 08:51:03 -0800 (PST)
Message-ID: <37042664-844b-4376-ac35-6426b5e34c5d@linaro.org>
Date: Mon, 10 Feb 2025 08:51:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] qom: Have class_init() take a const data argument
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20250210133134.90879-1-philmd@linaro.org>
 <20250210133134.90879-10-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250210133134.90879-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 2/10/25 05:31, Philippe Mathieu-Daudé wrote:
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -170,7 +170,7 @@ struct CPUClass {
>       void (*disas_set_info)(CPUState *cpu, disassemble_info *info);
>   
>       const char *deprecation_note;
> -    struct AccelCPUClass *accel_cpu;
> +    const struct AccelCPUClass *accel_cpu;
>   

This to have been split out previously.
It's certainly not gsed material.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



