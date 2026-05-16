Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65291CD4F3C
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 18:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOKAi-000423-Mk; Sat, 16 May 2026 14:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOKAg-00041b-EM
 for qemu-devel@nongnu.org; Sat, 16 May 2026 14:55:34 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOKAe-0005Re-TN
 for qemu-devel@nongnu.org; Sat, 16 May 2026 14:55:34 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2b941cd869cso5538055ad.1
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 11:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778957731; x=1779562531; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W968GmVFdT8VfygAvbCDT6jqwcSnuiT1M1AyEkHTzhE=;
 b=dwMFpcP/t6TjKpZJe+Z+e+jF7fTVWaYFIrT8GJXjYe/bsuI5u7h012/T7qyLrR18YF
 NYodbHVnEtfydFE6u5NkK0+jTYM3EBRTFBCfxSVF/Wf1C7Bc2B2OuS/gXlPArcFudYRb
 J3x1iMDTQf4xJ6+fbZaFcCbms3R5i1dSNtiuGZ+bIdKLrPywNTozZI60LpRpDkeW9dFD
 2WuWVE/XAXQwSYJIAZTUnp//vMXNzDEwGMeP4omu192YjHWbdK4sAmP1nahxyCPbU7O9
 Vkjz5MeKDG90zFS1FGaOClWju7hNOJQ6jcLW8JoNpUw5XoV9VTj2eIjH3KmN7zJlHH6k
 T2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778957731; x=1779562531;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W968GmVFdT8VfygAvbCDT6jqwcSnuiT1M1AyEkHTzhE=;
 b=b99/jHXQCv3lslCJN2YMXLNrGhy4xoaee82S/4yLcR5ICiyvr8KskG5T7sQeY91RjG
 9HP7rm/1s1JMqKuS8DJEiakhtsC9vMzwqU4sL+gF+FZQWuD30Cjoy35f8tvPF2SX8FY5
 mD4ccRZ711G3+Utf3oVETq9JCvTteNPrgGiWDED9w4+i66LiPbx88rD50q7fBfEL/F4b
 APhEFGtiJO1DUvI5ZDyZmve55afEjRXKfMufskg7TGG6Per7SCs/8Ug1btyFZPZ/WLbq
 EqBNS1wFGk7SbdRX+OC/pjY6ABIUookfZ+vkppRq0XfbRXR7hgJFPL6wjtgnX7Sb1S5X
 I/8Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+B8IDgpSnTp846CGL30FqBkgQvhdz+WSKxQE/SrUKuD2q/rGcrVG3KuLfQG0K6mqMD14C+P2q3Kf9a@nongnu.org
X-Gm-Message-State: AOJu0YyqYWDFyNRQg1ekK/rIHVcycLELJmdiiFzPjssnKXTMuIw0OGrL
 f3kF0Hh1QXYfOIcYUZVsjyctXLnMpkch0bnYcRaa1ZjYWLT7PC/C0Eie2aqggzsnYM8=
X-Gm-Gg: Acq92OGZK6zgEHiYAq2srkd97fvogP92xAdQh24LjZA4d/v9XSJAGbzQsHJ7sBPDO7D
 x2P3uBqFqBqjb7U6pxLzfo1Qq7qGrIJ3foOT5/trw7lWNKwbVRRaV3jCg63XsKpVDyDvQrM0SCU
 h71/AzN+eiaXLYlWptG/DK3WMdDYISoRSuo+tJkuO9MkYBInyKw+EN8xxd4l+EFpImwLXlrbRSe
 pB1dxit3XuX1mmiIgvQaHwrLfoNkE0RpODvKgSINgeBQE2x6NW9iBpdf9nYJR5BVMZ1iBddI77T
 SXKSovr8EW34ABN15wY6mPGw4d32Icy/t9S9cdyRCh9cPK06/i1z0ZEYExCke/kzayqHfduAD/6
 UqdpQWEW2BkzjmYGg37NMUk0tUhv2v8/s5kpDQSSoetjV5WcOXl4nQEUU7NjfbGI+HfpBTL7WdD
 7ocvvgw9jGRCyPlE137LK2g8v3T22XAbJxt/7L
X-Received: by 2002:a17:902:7892:b0:2bd:63dc:b7ad with SMTP id
 d9443c01a7336-2bd7e86c6b1mr72429765ad.2.1778957731494; 
 Sat, 16 May 2026 11:55:31 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5d0fbc05sm97267645ad.57.2026.05.16.11.55.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 May 2026 11:55:31 -0700 (PDT)
Message-ID: <d7dd6063-63a0-4053-b0df-a4416508661a@linaro.org>
Date: Sat, 16 May 2026 11:55:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/core: Remove
 SysemuCPUOps::get_phys_addr_attrs_debug
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20260515125727.349675-1-peter.maydell@linaro.org>
 <20260515125727.349675-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260515125727.349675-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 5/15/26 05:57, Peter Maydell wrote:
> No targets use the SysemuCPUOps::get_phys_addr_attrs_debug method
> any more, so we can remove it, together with the handling of it
> in cpu_translate_for_debug().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/core/cpu-system.c             | 11 ++---------
>   include/hw/core/sysemu-cpu-ops.h | 14 --------------
>   2 files changed, 2 insertions(+), 23 deletions(-)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

