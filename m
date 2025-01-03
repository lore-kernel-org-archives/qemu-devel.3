Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D23E7718F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 14:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTibr-0002Im-HZ; Fri, 03 Jan 2025 09:25:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTibY-0002Ay-BG
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:24:49 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTibW-0000FP-2f
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:24:48 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21631789fcdso127556235ad.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 06:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735914284; x=1736519084; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RwnpjxdgamyvNIwQh+gJ6DkbLiQwRVYTBDC4OQnqUmE=;
 b=hMrdVg6cGP6T+/aZYHOandamQg5OnKJQ6eA8JE2hw5KCSXogV0ab/fratU3QymhQBM
 DjK9FljGe4BmvxFJXnpoLd6cbk3OcPZBtIQYNbdb4uPEOWprI2oS0tNzSwNB2Ife7pnH
 s9GBE9sw7GPmhEFdfqX97qrWILW6AcTySmjNZtSGOaMJrxovlwltUJrIM8H0aTOLU2AB
 uXbuoD7VJE9BLH3bRfF23TMYLANYVByu+IhTq2tlVjq6282EZfjIYdAIOGadZ+hYjO1g
 /y5+lgRlu+C20wV+zoKEIxuFcRup/wvYRfMPW1dZB/eFCJ8szm+XlHN/nLlY0INb7pqS
 01lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735914284; x=1736519084;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RwnpjxdgamyvNIwQh+gJ6DkbLiQwRVYTBDC4OQnqUmE=;
 b=eZy7sWGw3XqrqbDAIj2gG7lB9dd/TSujv99oPZODvNYdo5PotIOx62d0p9mGGFK7vy
 FYIyTTqYjD6ED8dOWMTGdiSgq0yz9hBgUoFIFGUWqMiD4qoiiNdQWBhfFmGB/ZatyKts
 QbuYJfbrdOSnLzKOIiS9uZFORbaeXiwKomKZWvnNBhUvfO85KR/2twHUdnV1rM52jNLE
 OLYLXej3Cvdv4tv5oaHDJ4iFYkcbKHoSMz3JnmV92AUDswJz6h2WmH3SyrlR1xeMIqYD
 RM6z6skcAVWZjWNq4tsSU7wfBAaFelbb4//5xyHkG1WSL6iwZwSAE3E+EuDYZ4vAH6mB
 IaXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWciJRBIV9K4bEOgq/BdwRz/yGWKmqbvfOGXfGJI+wfFl9ll1Fbty4GrwozBND0F/Gfq0CatUwBhiMP@nongnu.org
X-Gm-Message-State: AOJu0YxOibD1HXkm6rcWqd9vfUEcfbUxNJMTnf7BJiBsdAE645OcP1hR
 Vmc4TAwNIycnjdU6jZoXVrSwRQdxMBdfELoYovbb8d3tTF+JLcqR+H0ClveqtEw=
X-Gm-Gg: ASbGncsLzJIK+wuJfGGWoPMVgSRj8AWnAmzi/4SzrK+AhaG6K4zZJOETsMi6XOCW1tO
 AUWRNtkSW4yi9+nH1aSRIyAwXC73nUdB7d3El4CZJ7R07TPVYnMpwlHwxlM6P34dYYbT5I8ITl9
 SsroSUvHAM1hjoLxSG1aWTu7rk3TofdOrdNTy+yLqwdvGrX6yX5VNqqyp5/Gz0xQ0vHI57e7tYI
 4/vcSmbcQa6Taz+hXjN4yAEx2wtm/c+5/s0PCyuW9Z3ipHvaOlC5C3tm+k/vuaYoBNFqJo=
X-Google-Smtp-Source: AGHT+IEFlBTkTo3F6i1ESVdzbdNC9wjhTAi1ShMqN65XteBxuU6oCEDANUAz5TD1jROE/C/uxluR9Q==
X-Received: by 2002:a05:6a20:2583:b0:1e1:aef4:9cd9 with SMTP id
 adf61e73a8af0-1e5e1fa2be3mr84906177637.23.1735914284364; 
 Fri, 03 Jan 2025 06:24:44 -0800 (PST)
Received: from [172.21.1.122] ([63.239.63.212])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8157e3sm18070698b3a.26.2025.01.03.06.24.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 06:24:43 -0800 (PST)
Message-ID: <87603a20-8c61-454e-9f05-bff7823f69e7@linaro.org>
Date: Fri, 3 Jan 2025 06:24:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] qdev: Implement qdev_create_fake_machine() for
 user emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Eduardo Habkost <eduardo@habkost.net>
References: <20250102211800.79235-1-philmd@linaro.org>
 <20250102211800.79235-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250102211800.79235-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 1/2/25 13:17, Philippe Mathieu-Daudé wrote:
> When a QDev instance is realized, qdev_get_machine() ends up called.
> In the next commit, qdev_get_machine() will require a "machine"
> container to be always present. To satisfy this QOM containers design,
> Implement qdev_create_fake_machine() which creates a fake "machine"
> container for user emulation.
> 
> On system emulation, qemu_create_machine() is called from qemu_init().
> For user emulation, since the TCG accelerator always calls
> tcg_init_machine(), we use it to hook our fake machine creation.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/qdev-core.h | 10 ++++++++++
>   accel/tcg/tcg-all.c    |  8 +++++++-
>   hw/core/qdev-user.c    | 21 +++++++++++++++++++++
>   hw/core/meson.build    |  1 +
>   4 files changed, 39 insertions(+), 1 deletion(-)
>   create mode 100644 hw/core/qdev-user.c
> 
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index e6ef80b7fd0..b83b1439968 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -1027,6 +1027,16 @@ const char *qdev_fw_name(DeviceState *dev);
>   void qdev_assert_realized_properly(void);
>   Object *qdev_get_machine(void);
>   
> +/**
> + * qdev_create_fake_machine(): Create a fake machine container.
> + *
> + * .. note::
> + *    This function is a kludge for user emulation (USER_ONLY)
> + *    because when thread (TYPE_CPU) are realized, qdev_realize()
> + *    access a machine container.
> + */
> +Object *qdev_create_fake_machine(void);
> +
>   /**
>    * qdev_get_human_name() - Return a human-readable name for a device
>    * @dev: The device. Must be a valid and non-NULL pointer.
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index c2565758876..95adaacee82 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -35,7 +35,9 @@
>   #include "qemu/atomic.h"
>   #include "qapi/qapi-builtin-visit.h"
>   #include "qemu/units.h"
> -#if !defined(CONFIG_USER_ONLY)
> +#if defined(CONFIG_USER_ONLY)
> +#include "hw/qdev-core.h"
> +#else
>   #include "hw/boards.h"
>   #endif
>   #include "internal-common.h"
> @@ -124,6 +126,10 @@ static int tcg_init_machine(MachineState *ms)
>       tcg_prologue_init();
>   #endif
>   
> +#ifdef CONFIG_USER_ONLY
> +    qdev_create_fake_machine();
> +#endif

No need to return the fake machine, it seems.  With that,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

