Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A346C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 23:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsVi5-0000bu-HP; Wed, 12 Mar 2025 19:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsVi3-0000bO-N5
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 19:41:59 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsVi1-0002TQ-Qf
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 19:41:59 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso2921285e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 16:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741822916; x=1742427716; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Oq1wNqWt44npgQTTfVXNN+4HcTVH3dl5D8oFlHK2ivM=;
 b=Vdrpt/p4f88dGIULbwds+l1lkH27UV0HLQjh23mOAhADE/8ZQNEZiB3AdHGnEwlUMS
 G4QKxj/fLc8iN9rvXu+4TOGlNvVKtxJ72uA4Pd5cxQX+P3mNuQBBWXnJjVYBjDKI2D1v
 OxAW3FonruUvdKvcaciLP8KkImyBTJI29o50hjNxlY5X9ylWNgldkdWs5bDvIxJoDk8q
 g/0RJbzbN1QitqMQ/zNiXftonB3zzzBrYzOgvwBZcgtnBKcOww58bB88YzOduzNzTTq9
 u7EhkHxUpvnYvovl/bn1/M4ej58V9ysZGv18sWqrcG6C2onRQhmJbnO7dxorRAYKIcjA
 Z7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741822916; x=1742427716;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Oq1wNqWt44npgQTTfVXNN+4HcTVH3dl5D8oFlHK2ivM=;
 b=m/3Y9BNq62BDq14DNiNgq/mnDCR/B9ojYqJpQaISYmP71yaHmu10VmVR/MCmsiWZLU
 OOeUnmAp5U2okYEBS4GTv/BmIvSqfRVH99xVR/qNokjcp38CXmSYa9N+q44cdjhm3CiF
 StAEsqJWs15niBE3WY8m7BY0x531L4xxk89FDputOJZwbXBR35YrqIB8VHXyvrTsJ/D+
 LcRTjzvLXuTuVVdsB4kXBKMIh1PbamGvKMbR2oACA/a4aVphdL71ewv2ulNYLvjcZJ5p
 4Y6KOY3GpICrlSoE2azlb1xeTwhpTJJhq+JkLQnxWdoGybctAHQ3HMzQAh7+9ahT4Zjs
 fd6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyeVlGJ/OunL2eydQeixVRPSOtDL5DhrU83e6hkVhj2sZk/9Fv+Hbv6mhGHxnCMCyaCm0+7BgB+ri2@nongnu.org
X-Gm-Message-State: AOJu0Ywd5qmo7BhXfE+ixkKGLqUxNHPKOe0PITxyWh/yv4EZtlw2uKuh
 8qUA7XYVUQEuyUBza3fT6ufO01757k7i4V3baqxG0jjB1bTxvzlCnk4LHvMyIss=
X-Gm-Gg: ASbGncswZrKeoFAQk3aqI1kfpzVciw5ACF+leacV2AO2Ip5USZXfeYsAUZ3sCR5s95P
 cz3kB3mrS9u8s1P4jUFfYnQ8owclTyOmx40o4mhRfolruF2Fks0FmgGyMBnNr5K7L5cW8ExlCST
 FwVZGXdK062Sf7NDDTruaHyuCTd7PxZEBecTv4Htb/QT2VIN9BWJnwVWMTA07cOrXjMpvbQeTU7
 8KJIG0zSQDii6Z2ZPGXn6tTLO6BmR+QYF+KXbd6w9VESs3BPGl8MCVlPCjDVnKuvtyNJOefL44d
 gaOX6/Y+dHehzHCn4ahjtd/PtS0ODfYKZJnrtXHUaXsAnBS7v8FU581ymVGVfjAYHvxtaPsY+h3
 ZD9J/eKbr8g==
X-Google-Smtp-Source: AGHT+IFQYMoJ6sUlDEaUsHrRWdf2Q2xpWK/cwdODVyX35c1shkbsnih14ocY/yL5HPcLFjIFAFfoDg==
X-Received: by 2002:a5d:64c7:0:b0:390:e2a3:cb7b with SMTP id
 ffacd0b85a97d-39132da28a0mr22583500f8f.34.1741822915899; 
 Wed, 12 Mar 2025 16:41:55 -0700 (PDT)
Received: from [192.168.1.20] (88-178-97-237.subs.proxad.net. [88.178.97.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7ebbb7sm187402f8f.92.2025.03.12.16.41.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 16:41:54 -0700 (PDT)
Message-ID: <f7eb2c19-4950-4d33-aa9c-5d8052717e71@linaro.org>
Date: Thu, 13 Mar 2025 00:41:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/arm/fsl-imx8mp: Make SoC not user-creatable,
 derive from TYPE_SYS_BUS_DEVICE
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>
References: <20250312212611.51667-1-shentey@gmail.com>
 <20250312212611.51667-2-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250312212611.51667-2-shentey@gmail.com>
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

On 12/3/25 22:26, Bernhard Beschow wrote:
> Fixes a crash when creating the SoC object on the command line:
> 
>    $ ./qemu-system-aarch64  -M virt -device fsl-imx8mp
>    **
>    ERROR:../../devel/qemu/tcg/tcg.c:1006:tcg_register_thread: assertion failed:
>    (n < tcg_max_ctxs)
>    Bail out! ERROR:../../devel/qemu/tcg/tcg.c:1006:tcg_register_thread:
>    assertion failed: (n < tcg_max_ctxs)
>    Aborted (core dumped)
> 
> Furthermore, the SoC object should be derived from TYPE_SYS_BUS_DEVICE such that
> it gets properly reset.
> 
> Fixes: a4eefc69b237 "hw/arm: Add i.MX 8M Plus EVK board"
> Reported-by: Thomas Huth <thuth@redhat.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/arm/fsl-imx8mp.h | 3 ++-
>   hw/arm/fsl-imx8mp.c         | 4 +++-
>   hw/arm/imx8mp-evk.c         | 2 +-
>   3 files changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


