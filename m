Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B3EC0218D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 20:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc9Pz-00060c-3l; Sun, 26 Jan 2025 15:39:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc9Px-0005zZ-Sr
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 15:39:41 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc9Pv-0001jz-7L
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 15:39:41 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2164b1f05caso63124695ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 12:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737923978; x=1738528778; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MvjpRtAdSgDSzkYfmgpR6A/dBIEK8m+/NiOGB5xZ+o4=;
 b=W9r9yhkckEoycQ/x91/77jSu8AtUNwVaKseTs1FF+1J83qnDNwf5B5khE50wTDLmOS
 PGL8/h1CcRXr1mi6UqZfu2jp6LLoX9d3oYFIWYcdI0Fkqw2jN8DHGPmnsHsOvJGCqnv6
 HnMoFbnGRIlnLiftA1M8xmWZr7ZISmI4iqEorb7lg5d8W5X8mucCkYuR2XsJB8vkcnad
 WJ+d2A1BK5jgTZyn1lBxaZ+yPB24ichha39K7Kmj6Uw9WQ2RROtfiDy/Vw5dMm6Mxgwq
 AXJ+0t4dKF+7bU9cL9EsNrs2rHw8T2s8UrZThvkz8XbiuMxi2++hXZeBLXlWgqFF43Ax
 ipng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737923978; x=1738528778;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MvjpRtAdSgDSzkYfmgpR6A/dBIEK8m+/NiOGB5xZ+o4=;
 b=UfsO7MXUMkgLVxk3ZW1LeFDElLgxQ/NCz9Aq148Na8DDO8DqhVDd3hLTmzOdCi3iUF
 KqLh1+sNySm3c+lwOYU9gnhNsd/xmWs5dwow0jDxauOxzE/wy1dPXsfKE2H/nmFXldVT
 5E5ySxPUHzq6tTJdtOPwJwKKmyYup9oL8GM7xBa8OSfd9bmmzRw8Fv+rUHyykmFuidXJ
 NUYhV+k9ObJlNqFg6jKUM71r/StvTjbF5+AhXp0v0y7v9aozZ7J6nnuqm+PIu8a7AOcE
 Si9y/phOxxok2Txb9jLbp/E2eqry0d/c3JcA+XT6P8tXfemw5l1Dd+8ZNS0J2p97MZro
 uZYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO4isj1J5EZhiXQFoT+jMCMeAOL6V+R/9mMWSjRBT92M9b60LOjIckFPtktwYkl9MzDddIPSBS/Oem@nongnu.org
X-Gm-Message-State: AOJu0Yx6o3qSkqcAvfNSd3QpDutVHzv+yqvp5NYCeSiXih8UGvsLKg4z
 EjXOwuKqKd3oEXhtr0htPi8AA0THNrgeF8QIc+7C2D08C3KWjG9zUxvmuWhCCo0=
X-Gm-Gg: ASbGncvsDo/baX8WGc8w9xIXZElw1vRkyk5g8snlVzJ6d9pyoHVPDjVMki6cdADIxON
 VtKvxya/+1v8pe/mcyF0Zdq6e/7l0aA6WEYX5HxEZTD2PsnHvhtJOqBTPl2KvZTd7/pafrkOwKj
 9kbI7exrNt2CuwaskG4sY43MqulhliDnj9hMHqIhv7kX5160qwL0OZelDnxLBHAoEEG3j/UkC90
 zaAxmGX0uzo9gEsgCXoDIwAmVMQl3LQwEnMhauIgpsMjLo+wVEA4JLONQfMRGJl38I2urnrvG4x
 WheOYO5LbyRR3necG9Hdk7TP9duiOoP4CpdHcf8cOWEtByM=
X-Google-Smtp-Source: AGHT+IGm+ocgYvvkVWsUvSKMByg6rdOolrkUz0sM7TYcNoHM9kXNHQjPzT7fvMCLNswi1NUAED96dg==
X-Received: by 2002:a05:6a20:394b:b0:1e5:a0d8:5a33 with SMTP id
 adf61e73a8af0-1eb21480ef0mr65256986637.18.1737923977749; 
 Sun, 26 Jan 2025 12:39:37 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ac48f897f8dsm4913213a12.22.2025.01.26.12.39.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 12:39:37 -0800 (PST)
Message-ID: <25ab2464-7878-4ade-89b5-1691f70736fc@linaro.org>
Date: Sun, 26 Jan 2025 12:39:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/20] accel: Rename 'hw/core/accel-cpu.h' ->
 'accel/accel-cpu-target.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, xen-devel@lists.xenproject.org
References: <20250123234415.59850-1-philmd@linaro.org>
 <20250123234415.59850-12-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250123234415.59850-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/23/25 15:44, Philippe Mathieu-Daudé wrote:
> AccelCPUClass is for accelerator to initialize target specific
> features of a vCPU. Not really related to hardware emulation,
> rename "hw/core/accel-cpu.h" as "accel/accel-cpu-target.h"
> (using the explicit -target suffix).
> 
> More importantly, target specific header often access the
> target specific definitions which are in each target/FOO/cpu.h
> header, usually included generically as "cpu.h" relative to
> target/FOO/. However, there is already a "cpu.h" in hw/core/
> which takes precedence. This change allows "accel-cpu-target.h"
> to include a target "cpu.h".
> 
> Mechanical change doing:
> 
>   $  git mv include/hw/core/accel-cpu.h \
>             include/accel/accel-cpu-target.h
>   $  sed -i -e 's,hw/core/accel-cpu.h,accel/accel-cpu-target.h,' \
>     $(git grep -l hw/core/accel-cpu.h)
> 
> and renaming header guard 'ACCEL_CPU_TARGET_H'.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   MAINTAINERS                                               | 2 +-
>   include/{hw/core/accel-cpu.h => accel/accel-cpu-target.h} | 4 ++--
>   accel/accel-target.c                                      | 2 +-
>   cpu-target.c                                              | 2 +-
>   target/i386/hvf/hvf-cpu.c                                 | 2 +-
>   target/i386/kvm/kvm-cpu.c                                 | 2 +-
>   target/i386/tcg/tcg-cpu.c                                 | 2 +-
>   target/ppc/kvm.c                                          | 2 +-
>   target/riscv/kvm/kvm-cpu.c                                | 2 +-
>   target/riscv/tcg/tcg-cpu.c                                | 2 +-
>   10 files changed, 11 insertions(+), 11 deletions(-)
>   rename include/{hw/core/accel-cpu.h => accel/accel-cpu-target.h} (95%)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

