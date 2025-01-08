Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00DFE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVdAt-0002I3-0u; Wed, 08 Jan 2025 16:01:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdAq-0002GC-J5
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:01:08 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdAo-000849-T8
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:01:08 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43635796b48so1586425e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 13:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736370065; x=1736974865; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ehfq1ffV8wUj/TGvS0nA3MzfJWjNX6FtUOdpJIjzIEM=;
 b=EI5dryKyjxIU8p10et4j/SFz6oTUn8erT4Gycg+8JvvY7145dt95mDXA0mZR8WFo1Q
 iJgscC7KT8FZCz9oHI/FRxH6QtzgZTEQUgAs3VBCsT/g1eYjo5emzsrqr1ckbfhlOELd
 2/pC0fVvVy+DL1RoQzJmkqsDYK0OahldHh8AZ7oleFUfb4Jmf4v5GDVC5GjiqR0p5D4L
 cQ7cltgnf+q8o5jezPisZAc7kLoSLUHL+YncW+c7q5+hhh0my4TKa5vX1I3RaSle7WlC
 p+EUcsqVYQtiytZ1YUu1FfLkMSerEJiXnQx+dlGaUEo7hb/OFBpj/1V6ZZ+xC9JLLXIY
 9bbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736370065; x=1736974865;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ehfq1ffV8wUj/TGvS0nA3MzfJWjNX6FtUOdpJIjzIEM=;
 b=FI7DLGQayQTmN+e4Coco3qPYDn8qeQMPRIz8yr3TAGSnCriRJt03RRRteLx9BA6u/8
 BcZKSuOzRf/q85eF0HcNQ+4z4BUG2gcrK3lvkaf1dFVQLXa4OnDCf/XyYqqjdspGZolX
 aIalezaY4xMzcv4s1rUyuRTyF9To2Qvirs8dhPfieFHkNiV/GPUN8u03DKSEJGHcT0eB
 HwCuA449P1fRPdVAu8XDgzfVbqGrwc0qYAU5La7WvY3tdQy+dr+j0zkB8cUgyvpUxUYT
 Q6KGBuDNueuHS+vHZDMv6xm/nPrzwdY2SKOfLKaVQvYJHSrt5y4ckYlF2zYpeqyHTfK3
 dqFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9Z5CsqaWFIoBFmwPUEk6+5zysLBcBd89N7VB/eir0pm/E0frNqymWQhOsb9sJnAwzhicEn945ndpv@nongnu.org
X-Gm-Message-State: AOJu0Yxkhf5G+4yOGTeohCmmxACVGiPsu03pCsaG/0/uV9nEi084n+yN
 P2bdUzSvic4VmRrjkI3+091xTuYng7ulmiO7xj+FDFtAiibIliHSPh9VA2jY6wQ=
X-Gm-Gg: ASbGnctDh66oIoOckADkBwwiaframVy+sQVW4iI+mulakeTBWSr/wK1GouoADvPy/Oc
 JNGcCMvwNq6sMr0PgnMFjdBppMrweY+TsTFqivB8PJYsFJTtKjSvW2NbF2QSBfyep8n8kSHUlMX
 x+e0DFqcZtlUhUsBmMfNHVitqA88kpSjr3d05nIsTx7hmipchfnUmlzQUe9yIuH0cqy/SW2HobO
 rKugn7cS+JMfOfeahLiXN0zp+2JyCwhkiPcWlJpR9LLsVhH1yjqVQPvUESeN0yHyi/RNHz9wAGA
 3xVLCM2BrJibbGNpuaiM4RNg
X-Google-Smtp-Source: AGHT+IHNKAsmofwAF8S9WLeCM7m80l7m9LeO5bbAEjMVhHwXvDKfYOacVD2s9GDu4hJfPyciiHiXtA==
X-Received: by 2002:a7b:cd13:0:b0:436:51ff:25de with SMTP id
 5b1f17b1804b1-436e8827fc8mr6378265e9.7.1736370065170; 
 Wed, 08 Jan 2025 13:01:05 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2dc12dasm32975945e9.10.2025.01.08.13.01.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 13:01:03 -0800 (PST)
Message-ID: <17151e49-cc1b-42a9-a74e-5e4c29123e9a@linaro.org>
Date: Wed, 8 Jan 2025 22:01:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 69/81] tcg: Merge INDEX_op_eqv_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-70-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-70-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 7/1/25 09:01, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    | 3 +--
>   tcg/optimize.c           | 6 ++++--
>   tcg/tcg-op.c             | 8 ++++----
>   tcg/tcg.c                | 6 ++----
>   tcg/tci.c                | 5 ++---
>   tcg/tci/tcg-target.c.inc | 2 +-
>   6 files changed, 14 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


