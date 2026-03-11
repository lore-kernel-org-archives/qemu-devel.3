Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015701062884
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 12:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0IZi-0003qH-VH; Wed, 11 Mar 2026 08:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0IZb-0003pc-9T
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 08:22:00 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0IZX-0001Dv-5T
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 08:21:58 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4853e1ce427so36359815e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 05:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773231713; x=1773836513; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WnBmABRuWBVbbe92jmgnLNltmfut4q6/tK3EoxhHdPI=;
 b=F6/bfMsoYI+7MsXoLyPFXUaUWuzL6hhleBRzEJgNs7iV5E551UDqtV5dS5ZYEBOZqU
 c5wqfBX4UjThZrOdPlPduhSK3uHP7SXRRb79B8zTdkeo1AqMkDOg3jZWM7dKhqi/EGJ4
 tLdBHxcFiw69xj/caxryHlyCt1RjbEt6QFMR5Br7+zsBVeXitfv0hE/s1KxoxG/+A66h
 LN/4O32Ve/XX8bsJkuzCDvt2wJuIePzStDUeXCoeU0NgW1R4i+ISlvhI0HNRS1hCv9xU
 tKvGV8TE75S/ZmkvCk6kRMFkMnhdjb+QpRzKkv34lbwvik55liMSUrDHlK4lCuiTsHEm
 i+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773231713; x=1773836513;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WnBmABRuWBVbbe92jmgnLNltmfut4q6/tK3EoxhHdPI=;
 b=EGsxUVnBf7SgxKf8rlbk2ul5fAqOrJymXRe4Ma1toR9gA3tRko9ERpyoJ0MJLWPnNU
 AElw4kCWVC/hIp+2H6RtS9JPnNT+h4rVZTd3OgHBreWCeXDlDYWPRUlCu4ry4ILEj5WK
 H4KC9PBpRvPhJVCXvEN4MKMiTPjQBcLWtpswDcGnDXWKlVE+ZAij6lAqJIkqhZ2gvPrT
 OUB91YUBrj6aoJ/5rEcNGRl2Xh3z9YDqwn/jdtqia8B/t8ucnxi8gFv2Z0+cdWHGfw9k
 ErTUZes5c8P2wD8HQt/KFpK/OpLOyUeRVhXgfSKhabAa3z2Ph44KpiSDMvgofhJ+YOwZ
 DUZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJa9fWi1e3Zm/2my3GXNOvUgJ/wG1nJLTqINTgd+vXbCEasEE3vL+Km7slRK0RowK//hUOQaXP4MJY@nongnu.org
X-Gm-Message-State: AOJu0YzjOn47ym06ehu7ynJ1QNxeXmq8AoG1iCUSnabkAr9oCCrgyVQR
 /BD9Qzn+apr0ZYdHmlgVmxP+kwB3CoSxZ0CHZRFQDfSp95o9OBHfuiS5XB85p61WzN0=
X-Gm-Gg: ATEYQzz2UVDIRYBL7n2jceiHrdqWd1ou1OrvwFXR81bX3LGD9ZIpeBgKkIQ6pfN0s5H
 3f2gtfKCxXnjgEpMhEPh25CtxKrt87ialt6kCPT1LI/N8rdZmR6S+5pOv02BI80UKXPxeG2WEO4
 gWIqQZUkSnSTsctYwcpHaMmEfL1qjdF9JzbcNUFr+FlJzOSgHOm5V3lifZj6DHhKF82rPf2E7Zo
 zOQouRYC/jy+8AJvgK9L1Fx/gAZFCQQeZmGvhU0mg7JpnulJDTuPwcRbh5nM5rQTdw7PZHHvtAo
 fzyOJh5r4fqGuMVeDgG8UAtq4ETtkCPt6c/+euL7fJGbLN6PC+qDC9vHNI2rPqYOgPsKBICHcS0
 3hijtj6rc0uMPxOcp1N3A8l2PJ98nEkG75U9MSuVKQmZLymkJE8U0aFDrhhIMdH0vzyVWWifKuy
 XwYLrBPrk9p16Mf+BJsU8l/VwQbfcAS3nvSYXeNerhzeUr7FeyX174btigFmwqc/eJ6A==
X-Received: by 2002:a05:600c:8486:b0:482:f564:d613 with SMTP id
 5b1f17b1804b1-4854b0cbe60mr39381635e9.15.1773231713371; 
 Wed, 11 Mar 2026 05:21:53 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b5e912fsm127270175e9.2.2026.03.11.05.21.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 05:21:52 -0700 (PDT)
Message-ID: <aa9b58c0-2435-4517-8465-285d8d697e61@linaro.org>
Date: Wed, 11 Mar 2026 13:21:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] hw/virtio: Support runtime endianness in virtio
 access helpers
Content-Language: en-US
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
References: <20260311115910.564481-1-djordje.todorovic@htecgroup.com>
 <20260311115910.564481-10-djordje.todorovic@htecgroup.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260311115910.564481-10-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 11/3/26 12:59, Djordje Todorovic wrote:
> For targets compiled as little-endian but supporting runtime big-endian
> mode (e.g. RISC-V with big-endian=true), virtio_access_is_big_endian()
> unconditionally returned false. This caused legacy virtio config space
> values to be stored in LE byte order even when the guest runs in BE mode,
> leading to byte-swapped config reads (e.g. virtio-blk block size 512
> read as 131072).
> 
> Use target_big_endian() in the #else branch to detect runtime endianness.
> For LE targets that are truly LE, target_big_endian() returns false so
> behavior is unchanged. For bi-endian targets running in BE mode, config
> values are now correctly stored in BE byte order, matching what the
> guest's le32_to_cpu() conversion expects.
> ---
>   include/hw/virtio/virtio-access.h | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
> index b58fb6ed7e..a3f1b9f5fe 100644
> --- a/include/hw/virtio/virtio-access.h
> +++ b/include/hw/virtio/virtio-access.h
> @@ -20,6 +20,7 @@
>   #include "system/memory_cached.h"
>   #include "hw/virtio/virtio.h"
>   #include "hw/virtio/virtio-bus.h"
> +#include "qemu/target-info.h"
>   
>   #if defined(TARGET_PPC64) || defined(TARGET_ARM)
>   #define LEGACY_VIRTIO_IS_BIENDIAN 1
> @@ -36,7 +37,10 @@ static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
>       }
>       return true;
>   #else
> -    return false;
> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +        return false;
> +    }
> +    return target_big_endian();
>   #endif
>   }

See commit 93b32a87377 and around, and please rebase your series on
current /master.

