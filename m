Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291D7C83F10
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 13:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZV9T-0004YB-Sa; Wed, 09 Jul 2025 09:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZV8E-0003wM-BL
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 09:46:42 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZV8C-0005U9-Oh
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 09:46:42 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-72c09f8369cso1833999a34.3
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 06:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752068799; x=1752673599; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2UX7BPaZX+G4MUKFrT8rmfDY73rzszJdU+KLzT3HOOc=;
 b=XwQqvrT2JEe8xH39SyWZGDbsR8tS8fPUODKyi92F0gXpJcc5mW+H+8wssZi7oN4TbT
 fF9TsBIU38oKjnAuJtLVgvySrMpfNPWXRcsKzZ4MGc3CzFnlKO7S6yj5fCRycjOi4rgG
 8joFNQ4dG1GXKp0vUROQqB3AMKJZmSgdlg1gBRYsoyxUhs8w6FWCVfjzkh+RtV9g2a5+
 WYgPC92O/+wMX/xubVXDcr01mjE3F55UghQgHmCEi4ZszKA9s8wZ5uPvzWgKOpU+ZFmc
 K/7O3EyhFxkCuxLK2Ip8LkHVaBngvXJFjbZ0qCfFhV/DCwj9lnNB8fZ5hyMHWRy+jhS8
 MlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752068799; x=1752673599;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2UX7BPaZX+G4MUKFrT8rmfDY73rzszJdU+KLzT3HOOc=;
 b=T5/8sEmwDiJxcozxRfkyU/+Ga7UofWk4b+tajhzv+y+tu3e2rTSl9LjtBo0X9vJfRo
 hBHvyixvp7sNxziWI3WmMfwHxfXugOQijfzPvHelCzXQTMcoIhQ30WCpEwdji9sOtiz2
 SbRIhkAd29FCvXeLbgggj/Actt/Hjvj81zKu838+ggpgFDnrlbUBIBlwUeiOznO+lDjp
 SM7NgvsG3IdMn/YgQ84eQw19+sRcT4Mk8tPu4qn7QfFTZB+rfrbCobwPn+f2kjDYFVRE
 4de37jtHeLrIV0LmQAFhHhIlseqN0MKL8IRTe0rjeyfntQV2YBWOC0s8MrmiLiz13k0F
 RqLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVejVOdOX3ywsMTC17sB4rkyoKQasOrw77KFeeeH19nTyL7da3ydfhUOlPBoWsyc6FQAqNLsv5RoV2v@nongnu.org
X-Gm-Message-State: AOJu0YwoxlewrIywm6dz80qrcS8hrHPdfk8eRhBeS8USZxZydzcVGLAO
 GB4Xz2NVP7qayXNoQ2ofspGkgcY1Z9no5IYSLu5H3iVTWeKgCT4pUvys0jmDYOuFnXsRH7Ah6r3
 R9ZGb
X-Gm-Gg: ASbGnct6RFC0cLeH74fzFbw+DH/W15W+TMbuObOdPVexJYBCH4EejJG9VN2YpE1j50J
 0niJMGd2V3aMJHegEL6jQAts0Cp7ANOEAzS/qnBht6yDb9TT9zisEwrXwUheWWHPG1nUs3WIa3q
 c+xWelOJngwFNdEtoNCvLQWUsnAMjhYm3gAzEHG0yjh8abbtn/wvz1/gEk7KiDjwQwhmKeoNQqU
 Ux62JYNqGdVUUVzdiLI2fxjWkZD7MPWa0pEBRPlZYEez0PEPYB2SIxyx75Mv91gwMTlN2jLijlj
 bJUGr5adlHmRJQAG1u4FJ8vrlwV+LzIST9yfEfQjjN2qUakFpWlzcZvFxQbcmrWWrUL+VSrSfX7
 sFgE=
X-Google-Smtp-Source: AGHT+IEC1a8IAPoyiAKN2hZIXWYKVtogw9oKfY/U1cfRMsILBVzfABC8gMN2hA6jVPJL+2WLfcd/KA==
X-Received: by 2002:a9d:6049:0:b0:73c:bb23:3cf7 with SMTP id
 46e09a7af769-73ce635d4d8mr1823978a34.17.1752068798989; 
 Wed, 09 Jul 2025 06:46:38 -0700 (PDT)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73c9f75dbd2sm2398581a34.27.2025.07.09.06.46.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 06:46:38 -0700 (PDT)
Message-ID: <0986b734-74cf-4b4c-9dc9-766824d3a47e@linaro.org>
Date: Wed, 9 Jul 2025 07:46:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] hw/intc/arm_gicv3_dist: Implement GICD_TYPER2 as 0
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>
References: <20250708115238.667050-1-peter.maydell@linaro.org>
 <20250708115238.667050-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250708115238.667050-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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

On 7/8/25 05:52, Peter Maydell wrote:
> The GIC distributor registers GICD_TYPER2 is present when the
> GICv4.1 is implemented, and RES0 otherwise. QEMU's TCG implementation
> is only GICv4.0, so this register is RES0. However, since it's
> reasonable for GICv4.1-aware software to read the register, expecting
> the zero for GICv3 and GICv4.0, implement the case to avoid it being
> logged as an invalid guest read.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
>   hw/intc/gicv3_internal.h | 1 +
>   hw/intc/arm_gicv3_dist.c | 9 +++++++++
>   2 files changed, 10 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

