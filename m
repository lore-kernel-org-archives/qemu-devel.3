Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57839EF070B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 05:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpJeV-0005OQ-B8; Mon, 09 Feb 2026 00:17:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpJeE-0005Ir-HP
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 00:17:22 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpJeB-0000y5-UZ
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 00:17:21 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-352f60d6c2fso1798193a91.1
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 21:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770614237; x=1771219037; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iAdDk3aNKxLVDkfSD9u9nPa+W0IDAfnvaVy9fDhIYdE=;
 b=qh4zRNRfCCHIO9wpHoYqFTanDQ0xLhc4RjzHUnQs2leAed+dPd2MRhZHQUyG3imfX2
 ZV7nN5XsFV4UTRNPDG2thB4qRLPtv1S2q1UOun/hOeli1sTYnjcdfA/1rZjQLXb4oqLv
 n1/lIfUUjptfc2y0nxm24SHB98Fi1yTNkd4CSRQdhWtWhAqj5YJPuhqXYNsE3ilqmteG
 OOSjPUHEOeQATl+eMBKMrPmhqAUWptQ4VBsQeQuzMT39Mtn1+waxrbG2Ky3uFMUgH4IO
 4Om1hLGUgt7e6ry1B7Av2dWBV4juUCvTGbLr/RJFjAtcqhYPDQvHgiGQyF5EEkBSNJkp
 MlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770614237; x=1771219037;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iAdDk3aNKxLVDkfSD9u9nPa+W0IDAfnvaVy9fDhIYdE=;
 b=l6KUY3Kqjx1kJF++nNx2eWEKgzgafI1o5S832dwG7bNipe3lTKVxRUMoMxZFo9JDt+
 lVDzkU6tT40B36O+HtMMy7k5AYTGcn1tAHXdxZ4nfPGODfswF74wl1Tk/fIV1OhcR0z4
 uIRWvfxnb2FvtsJeQiPo3a4UxOtN+l1TpDs1qf0yKacKpynHAxt5WOKm/IOsH/BSFsDU
 FwOwBMlVatGapzEIW+eZih/OYQ0aExloEjDaRRK0n3wtun+8H983QI0QP/adWbGtqB4X
 DLFfW9CENP7hN1mm8RtoECdIDNz5QWC0WESvMSlqiuNj01qzHYMftREqDWwxNDq1Gxzq
 6f7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWsisxcm8ffJUaS6yXtwx9vyhH3ZFOrtbkUy+GJEX3zwXtW1xTrREMTDECcbNlyNvDMZN/OwvUCm3p@nongnu.org
X-Gm-Message-State: AOJu0Yw6lVTIIv6ZCrzYWp7UI5ABt5a0yt2d1TokPRyLvsTAOBhYl64q
 mPgQff2kVT2bzznjFo0Y3r8He7IpEmDA7VCjp5jIvo+SrqeJmctGk7c/SloGaX0wIaM=
X-Gm-Gg: AZuq6aLe7lIrBhedrA8GZAFbc1uK0i11xg50HcWBcvSEY0oDMeyI8duhs/1d0j1CWVv
 Ig+z88h+11KzdxMH1tiR+YbmFT1cGQLR+k7I95YMMvmisDbWF0LQDAfPsPd0RKWMFcotlMgVtbn
 AkeKtwRGYCyNafQT3ZtpXLFqnnbc60QWmWz5o28dipYnmVm8Gvrc5wA4DctZeM3fvW1CEF4LK+W
 AMz4s51U90JJ6OHW0jJSgF9tJjUIuCzc27vOQD2EU0RVM0mV1zedfVpSQ/Nxtu01sFjGdzoMRGt
 FZQLw5c0bDIdRrEpx613ztB/7iaTXbpA3r1eu7PVpITXQIWke1prcKLPh1SLbiuRnZv7VVsi+mf
 dOSrNzPGYvNawx79L0r8WDN+csOwTxpNeKERUXy8dHB9GXdKGNR6O8qnGzOTrshxj99cS2gbtRW
 YNU6ygN4tv2IcvZbtE9/5jO4qPFgOJJHKX0J3r8x2/0l8Zz5Giaq0MbVAxNJefRFV1UtWYa52OG
 w==
X-Received: by 2002:a17:90a:e7c1:b0:354:c602:a573 with SMTP id
 98e67ed59e1d1-354c602a7e9mr6777981a91.27.1770614237023; 
 Sun, 08 Feb 2026 21:17:17 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:9c4:a3d:914:f9b?
 ([2001:8003:e109:dd00:9c4:a3d:914:f9b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3549c38fa4fsm14246621a91.13.2026.02.08.21.17.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Feb 2026 21:17:16 -0800 (PST)
Message-ID: <b3edeaca-f48d-4c2f-bf02-415a013f9096@linaro.org>
Date: Mon, 9 Feb 2026 15:17:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] include/hw/virtio/virtio-access.h: remove target
 specifics define
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Nicholas Piggin
 <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, stefanha@redhat.com,
 qemu-ppc@nongnu.org
References: <20260206221908.1451528-1-pierrick.bouvier@linaro.org>
 <20260206221908.1451528-5-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260206221908.1451528-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 2/7/26 08:19, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/hw/virtio/virtio-access.h | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
> index f3b4d0075b5..1bea3445979 100644
> --- a/include/hw/virtio/virtio-access.h
> +++ b/include/hw/virtio/virtio-access.h
> @@ -17,27 +17,27 @@
>   #define QEMU_VIRTIO_ACCESS_H
>   
>   #include "exec/hwaddr.h"
> +#include "qemu/target-info.h"
>   #include "system/memory_cached.h"
>   #include "hw/virtio/virtio.h"
>   #include "hw/virtio/virtio-bus.h"
>   
> -#if defined(TARGET_PPC64) || defined(TARGET_ARM)
> -#define LEGACY_VIRTIO_IS_BIENDIAN 1
> -#endif
> -
>   static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
>   {
> -#if defined(LEGACY_VIRTIO_IS_BIENDIAN)
> -    return virtio_is_big_endian(vdev);
> -#elif TARGET_BIG_ENDIAN
> -    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> -        /* Devices conforming to VIRTIO 1.0 or later are always LE. */
> -        return false;
> +    if (target_ppc64() || target_base_arm()) {
> +        return virtio_is_big_endian(vdev);
>       }
> -    return true;
> -#else
> +
> +    if (target_big_endian()) {
> +        if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +            /* Devices conforming to VIRTIO 1.0 or later are always LE. */
> +            return false;
> +        } else {
> +            return true;
> +        }
> +    }
> +
>       return false;
> -#endif
>   }
>   
>   static inline void virtio_stw_p(VirtIODevice *vdev, void *ptr, uint16_t v)


