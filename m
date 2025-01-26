Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406ADC0218D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 20:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc9NG-00040W-HA; Sun, 26 Jan 2025 15:36:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc9NE-0003yr-2V
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 15:36:52 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc9NB-0001SU-14
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 15:36:51 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2161eb94cceso44373165ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 12:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737923807; x=1738528607; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g2WeP5q4hv+K1Hr21O956YlU/gBG9YtJDHMFPAKuFc4=;
 b=lweBQhrZNoBasysEa37m7p9tA5SPa2ecWLgsLnu+e3IoluI5QngqbtOklDitqHd+0I
 ZEWDjfTEBE5iFz2ocGh0T3jCxfFxI4DF1OOT+L7llSmK8YjG3DieOQ0HIXcq7dxrpdau
 MF6d2IR/Jr+X7OQ+BUc1bT9BT6tWndz1EM9hNDDvGyN7dI0tnrbM4LGdN/H46p810WK/
 2WTaOd5luXU7hpYHgrk74AzgocJmjc1NDq/iUgseifT6NQAfMR4qLfeTbEEZjpmD4GVT
 EXq8lJIAoV8ZU6HwBsaIVx+ZE/J9tB0o3yqvO6x5Hs+JIFMWtipkW/oW+ryb2U18pQO9
 8DAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737923807; x=1738528607;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g2WeP5q4hv+K1Hr21O956YlU/gBG9YtJDHMFPAKuFc4=;
 b=UOSfkpXpmEX6vnfdyQNieFCqffbF5bdYYfbyxag4CAJjZYdrSnPQB/IVqItQGykslr
 rffzBGldEvhTBgyYDLh6j7xNATopprojasilFPGrzlwe3ag1hHBzexsrIcJwNZHOx/fT
 aWkS1s7nOesWb1rUvBHB/RY5tklqXWhhiBSxTfNjPEHeP4JRspXekRzSxRGymtwsfsEc
 6oxRA/602XIpeU+t57jN3VdAksaVu1r5TbSVtcosIrc1xqrjx2J9rmvdfmlbJjBNUu5x
 Ngh/BUfGO2mNxtjJqpm2xXdMjadb1UiKkinlDGS4uaZEE4zQ8ga/V3VwjEhOpp9XNM4/
 ZYAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsewmPs8CZx9oGCF4SrRewcw+ar+vX+LQ4tGjqaKckOT73albYI+VulSWrJPNV+fI3GGwqRSiawvSA@nongnu.org
X-Gm-Message-State: AOJu0YyN+SqY7CHuJ9NidpsCm6d67Pp9KOV3OO6A20kZnyjbh4t1atjx
 a0JIEWsmj5GuiJgMZ0ARiR8kSog56rhaura4MW/sTcsZEDWZLEAa8w6NhI6oKX0=
X-Gm-Gg: ASbGncuCmjiVb6V+B/yac5DGh3j675pVUX2oxnt9L1LMq7DUzkIhU1EuEI814BXfM8C
 kp5X+xOnu/rH23W8ZIelFwiI3MR/PFyUOQmSsj1LrITO5MqiXwDv7BglqYglnS2vdfzcpjTMALY
 E90ue3HNzSRgQXDJUtKdCQXEh7bc2BJg/FTBCuK4frdwGiNzvNjlNY20ye17SqtQEGSQQyHArtC
 jiwAlHqRFdjMlk1fYjNamxrH5CkdmqT3WPuav6t6hbdN0d1SR8hW6jhj1vZA6g1NE2JeNOx26ov
 a8qQTBSltOPGwakscuYsTnWFNXt2rbSZGZm+VS+ohGflSTU=
X-Google-Smtp-Source: AGHT+IG7QHEN6N12IEj7HpZ8+9ISOfMpvPDzHND+sb7CKsQVCW2Siz1JbFKV0CJ4CarsM9/PXCPftw==
X-Received: by 2002:a05:6a20:2447:b0:1e0:ce11:b0ce with SMTP id
 adf61e73a8af0-1eb215adabfmr66485176637.35.1737923807521; 
 Sun, 26 Jan 2025 12:36:47 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a6b18b5sm5645530b3a.39.2025.01.26.12.36.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 12:36:47 -0800 (PST)
Message-ID: <d81542e9-bebf-4f5f-a911-8ab7b6180d4e@linaro.org>
Date: Sun, 26 Jan 2025 12:36:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/20] accel/tcg: Rename 'hw/core/tcg-cpu-ops.h' ->
 'accel/tcg/cpu-ops.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, xen-devel@lists.xenproject.org
References: <20250123234415.59850-1-philmd@linaro.org>
 <20250123234415.59850-11-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250123234415.59850-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
> TCGCPUOps structure makes more sense in the accelerator context
> rather than hardware emulation. Move it under the accel/tcg/ scope.
> 
> Mechanical change doing:
> 
>   $  sed -i -e 's,hw/core/tcg-cpu-ops.h,accel/tcg/cpu-ops.h,g' \
>     $(git grep -l hw/core/tcg-cpu-ops.h)
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS                                            | 2 +-
>   include/{hw/core/tcg-cpu-ops.h => accel/tcg/cpu-ops.h} | 0
>   accel/tcg/cpu-exec.c                                   | 4 ++--
>   accel/tcg/cputlb.c                                     | 2 +-
>   accel/tcg/translate-all.c                              | 2 +-
>   accel/tcg/user-exec.c                                  | 2 +-
>   accel/tcg/watchpoint.c                                 | 2 +-
>   bsd-user/signal.c                                      | 2 +-
>   hw/mips/jazz.c                                         | 2 +-
>   linux-user/signal.c                                    | 2 +-
>   system/physmem.c                                       | 2 +-
>   target/alpha/cpu.c                                     | 2 +-
>   target/arm/cpu.c                                       | 2 +-
>   target/arm/tcg/cpu-v7m.c                               | 2 +-
>   target/arm/tcg/cpu32.c                                 | 2 +-
>   target/arm/tcg/mte_helper.c                            | 2 +-
>   target/arm/tcg/sve_helper.c                            | 2 +-
>   target/avr/cpu.c                                       | 2 +-
>   target/avr/helper.c                                    | 2 +-
>   target/hexagon/cpu.c                                   | 2 +-
>   target/hppa/cpu.c                                      | 2 +-
>   target/i386/tcg/tcg-cpu.c                              | 2 +-
>   target/loongarch/cpu.c                                 | 2 +-
>   target/m68k/cpu.c                                      | 2 +-
>   target/microblaze/cpu.c                                | 2 +-
>   target/mips/cpu.c                                      | 2 +-
>   target/openrisc/cpu.c                                  | 2 +-
>   target/ppc/cpu_init.c                                  | 2 +-
>   target/riscv/tcg/tcg-cpu.c                             | 2 +-
>   target/rx/cpu.c                                        | 2 +-
>   target/s390x/cpu.c                                     | 2 +-
>   target/s390x/tcg/mem_helper.c                          | 2 +-
>   target/sh4/cpu.c                                       | 2 +-
>   target/sparc/cpu.c                                     | 2 +-
>   target/tricore/cpu.c                                   | 2 +-
>   target/xtensa/cpu.c                                    | 2 +-
>   36 files changed, 36 insertions(+), 36 deletions(-)
>   rename include/{hw/core/tcg-cpu-ops.h => accel/tcg/cpu-ops.h} (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7be3d8f431a..fa46d077d30 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -175,7 +175,7 @@ F: include/exec/helper-info.c.inc
>   F: include/exec/page-protection.h
>   F: include/system/cpus.h
>   F: include/system/tcg.h
> -F: include/hw/core/tcg-cpu-ops.h
> +F: include/accel/tcg/cpu-ops.h
>   F: host/include/*/host/cpuinfo.h
>   F: util/cpuinfo-*.c
>   F: include/tcg/
> diff --git a/include/hw/core/tcg-cpu-ops.h b/include/accel/tcg/cpu-ops.h
> similarity index 100%
> rename from include/hw/core/tcg-cpu-ops.h
> rename to include/accel/tcg/cpu-ops.h
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index be2ba199d3d..8ee76e14b0d 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -22,7 +22,7 @@
>   #include "qapi/error.h"
>   #include "qapi/type-helpers.h"
>   #include "hw/core/cpu.h"
> -#include "hw/core/tcg-cpu-ops.h"
> +#include "accel/tcg/cpu-ops.h"
>   #include "trace.h"
>   #include "disas/disas.h"
>   #include "exec/cpu-common.h"
> @@ -39,7 +39,7 @@
>   #include "exec/replay-core.h"
>   #include "system/tcg.h"
>   #include "exec/helper-proto-common.h"
> -#include "tb-jmp-cache.h"
> +//#include "tb-jmp-cache.h"

What's this?


r~

