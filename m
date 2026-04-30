Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C6CFF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISYH-0003My-Bm; Thu, 30 Apr 2026 10:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wISYF-0003LW-RN
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 10:39:39 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wISYD-0003FJ-Dp
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 10:39:39 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43fe8bda8e9so649300f8f.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 07:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777559976; x=1778164776; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+RHpXEfnyQSdv2a1hOGc38+OSqul2NUBnPS0Fc7M1iA=;
 b=eYUnkgStoBnIaLx3IfFnT30Ccs+ymjhsrO52yku8+qpFhpKpygSXjuKiiNcwxT95+G
 YnSRT0coUORC1UI2dAVxOMi2/uJqgfXd0nsobkIbrPUL11dQp3XNa2jx2av0nE8Fv7U0
 j/gpGSeVv7Me47gt9AE7Qs1uTJhN3tjXDGyJzbZQ4IVD2o1DQqOgNY3JZjXIQP8pYZBx
 L7zaIc7W0fpIH7UyxED9hL6tjg6F7eSu5mRQSYSUH03sU7/rPqbpo6c6Rmg+TN33OIVG
 9oLxhm72q+9A+wUtsfAJj+hRP02/rzNyCYzdGUNZwOb1EcuTqGXic9FSUdtQfOahd4Ii
 wikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777559976; x=1778164776;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+RHpXEfnyQSdv2a1hOGc38+OSqul2NUBnPS0Fc7M1iA=;
 b=FVzpZc+gkFoSEtPhqUS+5ZFiabiDKDh4678Us4zJd0LZt4jBm48B29VuziKHcTJZfy
 DuoZPvs4VAO0TJKYiEEJAjVeJxK5wmdDvINqwR4jAout8qZEAnhQ+P0WJpCZ8OH4g7dK
 8x25eV+okjfRCeqaIkspmOk4sKGYqCUhvzGeezb81hNWkeY5LJEJ8briHlOKms0r7N7a
 gwsLyCmqB+BP3Vt5HCmyPsfZDilMbHnt7IdnnrIhJZhFm2SzD4DC58IgOTsM7LfDkp7X
 IQwIEZVltTdcTfeCkg83eBNZhN75+ZrBHlRuLevDOr3HtZPZOX2TzjAicY2DSoieJ2yJ
 mmqg==
X-Forwarded-Encrypted: i=1;
 AFNElJ++lp/HFNIdG1XtrKLGSDd36Vo0JUWhvuv6HHoU3WVdykgyA3iuJkHesDg/qCcErHk73Sv4eBCiSzSd@nongnu.org
X-Gm-Message-State: AOJu0YyUS0EXEHf5LnFEY2NMCBlyvQpHG+1+0MpRTOLqRa+LzqBfua4U
 G/1avsv6tIMlDE/W/xzMXQ+Lbq/VT0c3IQvs4kKjls8Knhc6Gh1pSHLaUMIXl+puTx4=
X-Gm-Gg: AeBDieuOucEgO2WiV/DdlqM3wkZSHCjoR1PpANuDcGcWQzeMq1nSbPi7M8ZcjDFZtdT
 G5mYIGaNRh7lEe5WBZBBMr1be/14/kY6i9mbjIaoGybNkVs1ZdBcP2Ctw83/lXvQT6tR9c1xgKG
 rlTJ+SH6nQhtfF5S0TuIC8rPuFcqV23Ppp5iDVyU/VysXgK4/9jtUHKDjtRWjMJ/CwY3/pMCsnG
 5tGDnbu6D/HlcGRI+jVX3b8LheKjXkdDruAUqKlLWNt6JhzO24Ki8rOsvKEoHR4RvdyNmv2gucm
 gc+HoeTCnw8fWnlkrq/pKzcQarExfctT6M5o0x1WKNi2NmGxRBYyUxLeKL0/nz7PwMdTGkvo7jj
 3bGqT1VBhTwnsBbc4FCa5LPyJ77UDjPIG3YPgI2cB1FOs86xp8LANXgUuR7DJ0y7Jq9V2Uq1jqg
 ScgUOj4Y0WbbBHZ/CyRnu4vocczBr2FfLt5EG5HiLxNlWrLc2JquoaQaNWC6kGXFRqjm9tNbE9D
 v4+
X-Received: by 2002:a05:6000:208a:b0:43f:ea04:dcc7 with SMTP id
 ffacd0b85a97d-4493f621cedmr5686660f8f.24.1777559975487; 
 Thu, 30 Apr 2026 07:39:35 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b4216ecasm13799984f8f.14.2026.04.30.07.39.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 07:39:34 -0700 (PDT)
Message-ID: <d1f18fd9-cd4a-4aa5-aad0-a1f0c63af149@linaro.org>
Date: Thu, 30 Apr 2026 16:39:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/25] plugins/api.c: Use cpu_translate_for_debug()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
 <20260430093810.2762539-25-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430093810.2762539-25-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 30/4/26 11:38, Peter Maydell wrote:
> We want to remove the cpu_get_phys_addr_debug() function; update the
> plugin code to use cpu_translate_for_debug() instead.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   plugins/api.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

