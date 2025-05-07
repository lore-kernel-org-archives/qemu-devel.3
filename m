Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1037C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 15:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCgVQ-0003ck-Df; Wed, 07 May 2025 11:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCgVO-0003cJ-GR
 for qemu-devel@nongnu.org; Wed, 07 May 2025 11:16:18 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCgVL-0004ma-Nu
 for qemu-devel@nongnu.org; Wed, 07 May 2025 11:16:17 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-441ab63a415so71155625e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 08:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746630974; x=1747235774; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VEZ0oi9Y5BxqGYyNj9C4vU41h5WjR6d5z4rDLKBY/Mo=;
 b=VZ+E9yaqiivrlxInIAxwYZU9KTa6J/9yfHutjqHbboFUg9EKLETr7eV1Wd/LerZgW4
 S05crD6h6EJ0f0a1g3rAJBn3Nvhk54q/7HwSevdxPFCTJTxplt6IdlB6PW+qZ50fmPP8
 pS8NgcZ3z0WPSGpBPlsFaQoYiuEE4MHXMq9WuI44EIoW8RWi+DtcSJ6ole+kkw2mE7YQ
 UH/0UOuXrR9agjZOXThwRaNj1m+wrfeLzZA6+fJ3XmO7sUzkgD4PWdh0tRkBayeCdq5K
 XvsmPsS9DxU/qocHvIBSULS8L/q5ZvgNyUhSeqH1eKYT2S5yPLp84/j8rLfDVfObcN56
 +hFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746630974; x=1747235774;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VEZ0oi9Y5BxqGYyNj9C4vU41h5WjR6d5z4rDLKBY/Mo=;
 b=TPH7OaNe58TQ3kkPzQwrqCJpOAisIjoapD8A9inNNma/Cm1PAqLD3175AzIXORK7Du
 knY+YtpYRLhUoS1/iTp8rYjVwIlvjZM832Wh415tpbg5qUgtdKkk5KnijUtIdTFbRgz2
 7MUj8Rg7Yc3NEC3WA8twwHoQhLD1sQzq9F3b2nm221Hdfoy7Jq9AOCxjt6N5wXiYtcl4
 ATbSwNJDS5gPQvbIvSu1YD10VWvJ9YvHbhKGjA8B2o2+xExu219L38VtGbX7Fnz0XcGy
 57YJrC4m0cpo48KfuQmuAM0EYgCN2NRrTrx9Q1HgOBxr9m8vNfauufIMRDHyhRFBym2P
 Frhw==
X-Gm-Message-State: AOJu0YwFwaA4zh5ah+r05UeyDjSUWAmqfmOY8/RAarQMM+IoNSGa4jAt
 WyyPLXu0g2iFqeBuLBWoEZxW9444V6xL7NDyrWLT2WaW1seDEDDeWKuMbm2seM8=
X-Gm-Gg: ASbGncv5Qouj9sTDysx7zsD0YrDM5cZOjx9anzjEYjPmuo0KpTfpKrJbFmbu7b7xrq6
 QD/bsLxldffLKalM5Z/2uHO3kq99ZwhCNWqqIyLR6umUxYab94XgTmNFMkykF/acl3I3e9NaWg8
 4YpwEVBdovQHozkRLyjuaxAkA8QpZnNiK/n7DN2o0kytSsH8TD/8MLPWnrnCuqAacsqOYMBKde4
 c5SzpRZQN4RtHYcTJ7Bji7hnmOracmGD6umAwP8XNdw0P8X35zxghpnyj1G+CCUWD0YkESS8Hlt
 HbNYt80F3Nx4W7wZgxum52eETBUKCsG/3hUQ1UrM486ql3zYHBneGeiztthPEkoujBxpHl2hAPz
 zB8n18XsjEQ+CvPEumzF9WBrbIQQ4vek=
X-Google-Smtp-Source: AGHT+IHrGiHFGqWeft1YMEzFgBu5V6o+7nwA9q036wpGMyiBTuZeTubAntiGhwc4OcuN/VshzKV/Pw==
X-Received: by 2002:a05:600c:698e:b0:43b:c284:5bc2 with SMTP id
 5b1f17b1804b1-441d448c751mr38626895e9.0.1746630973872; 
 Wed, 07 May 2025 08:16:13 -0700 (PDT)
Received: from [192.168.1.70] (lputeaux-658-1-173-28.w92-154.abo.wanadoo.fr.
 [92.154.108.28]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0b44ad93asm3291848f8f.91.2025.05.07.08.16.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 08:16:12 -0700 (PDT)
Message-ID: <138e23f0-d7ac-401c-9625-5f4190119a59@linaro.org>
Date: Wed, 7 May 2025 17:16:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/32] target-arm queue
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
 <CAJSP0QXi1eGdbi5=2EGWuHdL2JX6h513wwVMi167xYZKHjbFSw@mail.gmail.com>
 <0d976e4f-f8d2-407f-891a-8b13ea621821@linaro.org>
Content-Language: en-US
In-Reply-To: <0d976e4f-f8d2-407f-891a-8b13ea621821@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 7/5/25 16:57, Philippe Mathieu-Daudé wrote:
> On 7/5/25 16:05, Stefan Hajnoczi wrote:
>> On Tue, May 6, 2025 at 10:52 AM Peter Maydell 
>> <peter.maydell@linaro.org> wrote:
>>>
>>> Now I'm back from holiday, here's a target-arm pullreq :-)
>>>
>>> thanks
>>> -- PMM
>>>
>>> The following changes since commit 
>>> a9e0c9c0f14e19d23443ac24c8080b4708d2eab8:
>>>
>>>    Merge tag 'pull-9p-20250505' of https://github.com/cschoenebeck/ 
>>> qemu into staging (2025-05-05 11:26:59 -0400)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull- 
>>> target-arm-20250506
>>>
>>> for you to fetch changes up to 607e1208b53ac713a76d158f4abc4cd2e8870051:
>>>
>>>    hw/arm/virt: Remove deprecated virt-4.0 machine (2025-05-06 
>>> 15:02:35 +0100)
>>>
>>> ----------------------------------------------------------------
>>> target-arm queue:
>>>   * hw/arm/npcm8xx_boards: Correct valid_cpu_types setting of NPCM8XX 
>>> SoC
>>>   * arm/hvf: fix crashes when using gdbstub
>>>   * target/arm/ptw: fix arm_cpu_get_phys_page_attrs_debug
>>>   * hw/arm/virt: Remove deprecated old versions of 'virt' machine
>>>   * tests/functional: Add test for imx8mp-evk board with USDHC coverage
>>>   * hw/arm: Attach PSPI module to NPCM8XX SoC
>>>   * target/arm: Don't assert() for ISB/SB inside IT block
>>>   * docs: Don't define duplicate label in qemu-block-drivers.rst.inc
>>>   * target/arm/kvm: Drop support for kernels without 
>>> KVM_ARM_PREFERRED_TARGET
>>>   * hw/pci-host/designware: Fix viewport configuration
>>>   * hw/gpio/imx_gpio: Fix interpretation of GDIR polarity
>>>
>>> ----------------------------------------------------------------
>>> Bernhard Beschow (4):
>>>        tests/functional: Add test for imx8mp-evk board with USDHC 
>>> coverage
>>>        hw/pci-host/designware: Remove unused include
>>>        hw/pci-host/designware: Fix viewport configuration
>>>        hw/gpio/imx_gpio: Fix interpretation of GDIR polarity
>>>
>>> Mads Ynddal (2):
>>>        hvf: avoid repeatedly setting trap debug for each cpu
>>>        hvf: only update sysreg from owning thread
>>
>> Please take a look at the following aarch64 macOS CI failure:
>>
>> ../accel/hvf/hvf-all.c:61:54: error: unknown type name 'run_on_cpu_data'
>> 61 | static void do_hvf_update_guest_debug(CPUState *cpu, 
>> run_on_cpu_data arg)
>> | ^
>> ../accel/hvf/hvf-all.c:68:5: error: call to undeclared function
>> 'run_on_cpu'; ISO C99 and later do not support implicit function
>> declarations [-Wimplicit-function-declaration]
>> 68 | run_on_cpu(cpu, do_hvf_update_guest_debug, RUN_ON_CPU_NULL);
>> | ^
>> ../accel/hvf/hvf-all.c:68:48: error: use of undeclared identifier
>> 'RUN_ON_CPU_NULL'
>> 68 | run_on_cpu(cpu, do_hvf_update_guest_debug, RUN_ON_CPU_NULL);
>> | ^
>> 3 errors generated.
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/9962088576
> 
> "hvf: only update sysreg from owning thread" missing:
> 
> -- >8 --
> diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
> index 3fc65d6b231..8c387fda24d 100644
> --- a/accel/hvf/hvf-all.c
> +++ b/accel/hvf/hvf-all.c
> @@ -12,6 +12,7 @@
>   #include "qemu/error-report.h"
>   #include "system/hvf.h"
>   #include "system/hvf_int.h"
> +#include "hw/core/cpu.h"
> 
>   const char *hvf_return_string(hv_return_t ret)
>   {
> ---

Note, this is likely exposed (side effect) by:
https://lore.kernel.org/qemu-devel/20250506143512.4315-7-philmd@linaro.org/


