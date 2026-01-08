Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0FCD1D48D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 20:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdwSd-0000ND-LB; Thu, 08 Jan 2026 15:18:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwSV-0000Lq-50
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:18:15 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwST-0002Sn-Df
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:18:14 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7a9c64dfa8aso2268208b3a.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 12:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767903491; x=1768508291; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V2nPM+oxm2d/VRIoBWo0QlDuYygszjLWSZt2ga7fV8Y=;
 b=j7ExiRimL6KMZd7X3ftMLcwtURZXas3HjKfqZtLNKWvl+bEaKRTwtQxPfYskyHL7HM
 6cFI/iSOC0zIFEwnWVBcdhTgxuEwTUxAe6adXBIZbVi8i9gcsmBfXSPeO74f4BttF8Bw
 ThZKcdB/5XTtx/c9EQL1i8wtLdZq0YykOSfU7Pc0F3HQAyq7ZBxuEThScI+Td1yW+yZW
 XQrpiij3JPMOSFm5ehIbTkn+duqAlCY6aVTzpX2nxa2YBpGlWL1a8lHeIEGE7iUcEOUs
 h62fd5gW4amHdcZ21pAl2mxsvaD/D6SgKQpk4iz8+wwTWO9vOwAsugookat94ueM/MlQ
 qmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767903491; x=1768508291;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V2nPM+oxm2d/VRIoBWo0QlDuYygszjLWSZt2ga7fV8Y=;
 b=CtRxgl5UVS1DuTr/6iOcbsa7zEMMBpO81vegJ2yopVCfJkO1Mt4YYCGss0YrYnberi
 ey0+CwAMMIDftsXctiU74eO/7KSyc4kWr9zkSR6NRDekE7einbklV44L1p3D/LmZQyC0
 apr+91lKvQJJvmYSGO7LX4AXX+s3hcYECqwaAlFKbq5+TAPl5EHGr9LBFzpsAVCGJq9N
 oAZtty/jdsX8SoLVw/Zk33vZ1FJKuhp2VKu+2MBwgS/UuZ7GQVuUxvM8N89pVAp2Gao8
 cgrB4wsimo+uKnmsnaA9Q5BBamrXYsoXbNa+oXfVq4imzFTwA3s7W2kaSH2T++WrMSbd
 /utg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFefbRuufAR9tDnHeojOh/Vae5oAEq6RyuCAJJTcfiTXVu2YBQdKb3Ar/jo0/WXye01DpIEKTIRHeh@nongnu.org
X-Gm-Message-State: AOJu0YzDHksEHJhnCr7YNkEhUkAtzED1qDQ1lAmQQNCLHLGQ3PcRs3Hg
 vTgCotGE5w85Ww+rZHWIxWGbUBSthQSgRP3iYzrLVyRs45Q+TdpVwexQAS13zWC8L1k=
X-Gm-Gg: AY/fxX7Hl+9xcpmnuZzdpK45VURmJozcwtzqo7qxp/Fru49W9KU7ufHSbLRGPv1/jjJ
 NdqoX6T7YAjlkssurtB9FCJ42IrPU96ZYsMwl7v504CQjCw2cMMvdwQiuOXuLcEKVYaPHKlSMf4
 WLYVUg42uReB2NT0Cya3IcM2vLcTyxkv8bH732EWphmOr1iDQisOmGg1Tdu37FINShpl3zJrw3M
 sbTfAak5MLCb3OoNwgnvmi9XM8wEviTyHo4ooyfXnKKk7BxMmcQtb6XuHRTO0bRvqlTmyCuyG1i
 NFvwDXM79ozCHVLMj86xQsnfld/eBI3wlsEXSpO2hCtzN3vQU1z9cPPElrkVBeh7VsOi98ZIFhl
 2mJzgOX0DPMiCG0w33ZQqdc68vFwUhf3vLwYmX5HCORJxnBgpUy8dw3XO99LjopwNU1npyiFfhm
 F/lrSEWU4x+jykPsGHMXFi/gSejVluXuwWGUQLdEJMP94p4nN3k4ysD4qn
X-Google-Smtp-Source: AGHT+IHffpyVqXZlXdxL083TT5mNrk7M6dw2HqcPU2oxX7bvKC0oTGrNTzMvWB3DR1Cwacypuc7Flg==
X-Received: by 2002:a05:6a00:4502:b0:81b:31e7:114e with SMTP id
 d2e1a72fcca58-81b7dd5ed67mr6684713b3a.22.1767903491127; 
 Thu, 08 Jan 2026 12:18:11 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819bab0e13asm8437482b3a.9.2026.01.08.12.18.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:18:10 -0800 (PST)
Message-ID: <91157998-3266-47d8-a83e-fe3c61a53aad@linaro.org>
Date: Thu, 8 Jan 2026 12:18:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/50] tcg/ppc64: Rename from ppc
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-13-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 1/7/26 9:29 PM, Richard Henderson wrote:
> Emphasize that we're generating 64-bit code.
> Drop the explicit rename from meson's cpu.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/{ppc => ppc64}/tcg-target-con-set.h  | 0
>   tcg/{ppc => ppc64}/tcg-target-con-str.h  | 0
>   tcg/{ppc => ppc64}/tcg-target-has.h      | 0
>   tcg/{ppc => ppc64}/tcg-target-mo.h       | 0
>   tcg/{ppc => ppc64}/tcg-target-reg-bits.h | 0
>   tcg/{ppc => ppc64}/tcg-target.h          | 0
>   MAINTAINERS                              | 2 +-
>   meson.build                              | 2 --
>   tcg/{ppc => ppc64}/tcg-target-opc.h.inc  | 0
>   tcg/{ppc => ppc64}/tcg-target.c.inc      | 0
>   10 files changed, 1 insertion(+), 3 deletions(-)
>   rename tcg/{ppc => ppc64}/tcg-target-con-set.h (100%)
>   rename tcg/{ppc => ppc64}/tcg-target-con-str.h (100%)
>   rename tcg/{ppc => ppc64}/tcg-target-has.h (100%)
>   rename tcg/{ppc => ppc64}/tcg-target-mo.h (100%)
>   rename tcg/{ppc => ppc64}/tcg-target-reg-bits.h (100%)
>   rename tcg/{ppc => ppc64}/tcg-target.h (100%)
>   rename tcg/{ppc => ppc64}/tcg-target-opc.h.inc (100%)
>   rename tcg/{ppc => ppc64}/tcg-target.c.inc (100%)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

