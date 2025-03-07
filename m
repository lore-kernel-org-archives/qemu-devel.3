Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA19C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 20:43:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqeX2-0008Rj-MV; Fri, 07 Mar 2025 15:42:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqeWx-0008MO-CD
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:42:52 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqeWu-00028Y-Rj
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:42:50 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2241053582dso19189865ad.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 12:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741380167; x=1741984967; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=du8QOQGF2nqhWzxCQqgYoIbW1gsvamlhUrbkXg3XLe8=;
 b=rksgBp2om3ntcBxIyyBVRBSEeeKVus0a0+MA8IvaBdztiP3ASqb+JogzyYscKqkPM5
 gIi2zIF0TJsluXDGD8w1xo15L570gtJpT1W9gVc8C8sNgTobxhXBJa5wO6ML3Rg8lTQ3
 WgJfsjMRrxowGuWicJgJHJ2JVOYGLpfYtt2XmXOeA260cylZI0m1yfjEVZvUGjkSuGGS
 ThC4MenjCwtZv6AmL9bzcYKwxh1MucFKkpX6lDl+CUx0LceRopGivgftxiTupQpfDSrD
 ZLf2JLB9I9f37NxqJ9MvQUqviezoicM4QEm66NbzGFsYcIfUjSidnKHsV/pXQmoKYRuf
 wzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741380167; x=1741984967;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=du8QOQGF2nqhWzxCQqgYoIbW1gsvamlhUrbkXg3XLe8=;
 b=RwhKlhYqT6RIU3G+lkUKvef+0yJG7Hj+B5ZX+9EjwYCm5Hy2bB0WUvj3jvtEx66ezM
 gBgod+EulSxYK0kiTtZhHs5pfpPrg2IeHHAztBXnH4p1R0FSWZWAY7mMp2R3B90C1EaU
 pQwr0CUDpfXSQbXAu11bTGZIriN0cj3tEKMN81Y1EV1acyuhQpP491I31V2e1P9xKg2P
 H+g7ghjTS0R9H+jWmZfxyzI2jwYU0IvVhELzS3CQJvjWzhZBMoVYmxDusAyycrtgRWHM
 htBb82P8iwidxg/85WfjJ165WILI4SNSVz0m5JDiPB7D3S2gAoQmkzzQRIXmVmFB1ARJ
 +a5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwO2QTN3DwlxCFbf+c5D56Pe/Zi7Uv7PfMv3kryhfC0J+4BUL4+dCA08p65e4yBjXFMNUAkeucuXWm@nongnu.org
X-Gm-Message-State: AOJu0YwlTDuTa24ZvZtWSf2uEGcoXI9AzL+SRpgYI9ZlWEG5EKSSEkVG
 IStLgajjlDnKYdZq9rGhPMpVb/o0v9oBqtGqZUqvOXEV0BZcNgrXovWYdHPNRDO2/snZgU4WHHI
 +
X-Gm-Gg: ASbGnctiEP1MKK0w7d+a9M3ruZWM4nYYtJeKZsHOMCFOgoelr9I6+/qSzenohR8vXI8
 54I7cKqZXRfz3m+qxOmdY9gxWsNKBy6wHqSuyzdTNq4iOZ/PINeXbBs6NBikFrxtyYleYdy4dJ+
 981quTdMJl/1fc/sxmp+4Cn1XMX9BunSCBQtcMWYcH1S7xDCSV+whUXr+10AU34jnZJ5LWUv6rQ
 ImuuIjawSwXON54ahqwpauoZNsfOpIcVh5KVMOVDuys6B5s2gYoWx/Qn8ZF7HOiijUbFK+ukg9K
 r0XuIjgxff8fyNpq7aFvK40FIum1Tr6ut2BmP0veGipTB3nCrFjxioxpsf+HPaLUrf6khjWV09y
 5WTz5URS7
X-Google-Smtp-Source: AGHT+IF+pabbrgtp5ClZ67I4Q0a375fRWyeWGuyJTM4E1w6Uf2hReBGX5lyrMQOH9uSMhrXmwwNDwg==
X-Received: by 2002:a05:6a20:72a5:b0:1f3:4661:d197 with SMTP id
 adf61e73a8af0-1f544acd52dmr10283340637.2.1741380167372; 
 Fri, 07 Mar 2025 12:42:47 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af281287d78sm3411324a12.74.2025.03.07.12.42.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 12:42:47 -0800 (PST)
Message-ID: <e4dd7393-47d4-4923-b907-dbb875821274@linaro.org>
Date: Fri, 7 Mar 2025 12:42:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] hw/vfio/ap: Check CONFIG_IOMMUFD at runtime using
 iommufd_builtin()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250307180337.14811-1-philmd@linaro.org>
 <20250307180337.14811-13-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250307180337.14811-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 3/7/25 10:03, Philippe Mathieu-Daudé wrote:
> Convert the compile time check on the CONFIG_IOMMUFD definition
> by a runtime one by calling iommufd_builtin().
> 
> Since the file doesn't use any target-specific knowledge anymore,
> move it to system_ss[] to build it once.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/kvm/kvm_s390x.h |  2 +-
>   hw/vfio/ap.c                 | 27 +++++++++++++--------------
>   hw/vfio/meson.build          |  2 +-
>   3 files changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/target/s390x/kvm/kvm_s390x.h b/target/s390x/kvm/kvm_s390x.h
> index 649dae5948a..7b1cce3e60d 100644
> --- a/target/s390x/kvm/kvm_s390x.h
> +++ b/target/s390x/kvm/kvm_s390x.h
> @@ -10,7 +10,7 @@
>   #ifndef KVM_S390X_H
>   #define KVM_S390X_H
>   
> -#include "cpu-qom.h"
> +#include "target/s390x/cpu-qom.h"
>   
>   struct kvm_s390_irq;
>   
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index c7ab4ff57ad..832b98532ea 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -11,7 +11,6 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
>   #include <linux/vfio.h>
>   #include <sys/ioctl.h>
>   #include "qapi/error.h"
> @@ -24,7 +23,7 @@
>   #include "qemu/module.h"
>   #include "qemu/option.h"
>   #include "qemu/config-file.h"
> -#include "kvm/kvm_s390x.h"
> +#include "target/s390x/kvm/kvm_s390x.h"

Do I take from this that this is actually a target-specific device?
Otherwise the two s390x changes are confusing.
Is it built once already, due to only being enabled for qemu-system-s390x?
If so, I question the need to move it out of specific_ss at all.

Anyway, this is two changes -- one for iommufd_builtin and one for meson.build.


r~

