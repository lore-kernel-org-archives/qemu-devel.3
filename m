Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C52BE8B383
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 02:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnSLj-0000eW-Qy; Tue, 03 Feb 2026 21:10:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnSLi-0000e0-J7
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 21:10:34 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnSLh-0002jP-2Z
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 21:10:34 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8230d228372so156537b3a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 18:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770171031; x=1770775831; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oX2gRXmsjH09OOSy6AzITXbftKhFHiKoWuLm1W5Fe14=;
 b=dGsQ5NjLTsX4bCGT2asxAISFGhMhnJPGVo2OOmSgE847xMbTOi7mrrPW/yaHGK1xhO
 UqNmiuomhFnFcpy4iXLJspXKVtKO+8ijsBmwHJRoqx7Nch1k+41noovRxHOf5rUI/fjB
 99TzcAaV+LJ4W4iFYI4+2OO91YXL15Dca6kPxZ+OPCATWeSo7Pv1natcBInQKryXox57
 WKoW7lW8CJxxsnv4HtCrfSks6OdKpVwUzm7STg9SQgJ+PcP9sKuKsYkUGdbXbuwJn42T
 TK8vReBU9yEluzSP5Tbh7cn9pQgPv1SxVZxfpF27qZkz3914me0zKH5fmZsP73ZVdbEs
 BVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770171031; x=1770775831;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oX2gRXmsjH09OOSy6AzITXbftKhFHiKoWuLm1W5Fe14=;
 b=sPusjlGLaRxmPn0KuALRkpU2MWVK/Eb8089giqc7B7lVweEwFEgMciuooK3GVcEHBd
 EpPz2QRMJnqVF/Jv3rEf6RMzGg0kVg2n3e8be9Qr4ArnnrlCW+YSTwmeEK/lBFCTunzM
 QvDpLqNPf9GB31n+qewfKiKJhujNbllPuxtQSzZAcdukZyWGQZ8YjKhOSyIBcuQegPKH
 T6Kt4FUpJ237VuLE7aRxesHuTN8XWcV8Lu9EGOqSHir98EM9TQkHkvWbqC/Ck6MIulz1
 yJHbGiNHdrgFnOoC49n7YPt0O/z0kkiT3st8S/Jk6G0ZE2zjtW0ZP4wC3Ob4Ln12VIzR
 ozWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKhyeY7z/UeFM/P1hYXYKi40bq7NConErLVKlnUCfFScE2a1oHLlGPLiYOBW0k+4ZdPAUqq/ZL99jj@nongnu.org
X-Gm-Message-State: AOJu0YyZc9rAAFAN2UjYQCeNEEwGmrIcsEbf9kb17Vuxah8JZq6P5FHh
 A+2z00giGXvgkP04Sx2SqcwkHXHwehn7MnnZE39msrFUel6jkE/IsOVUSew6TP9RFJU=
X-Gm-Gg: AZuq6aLJLePYUv98cy/BeLk89v7pQYQYP7xM6i6v+9JE6MPHuv1GGG17Rs2s4cO1DhP
 gmE4d/HlwCeE5tRhUIP6y3JKH91buLBs+j6CmCfSXT3L4VffdUYjddccnjGNdvqZz8JVT2KcbHX
 FmBCJpQDRH7lwdKvEDhqHok39UNLuDsr3u13JsF5oacMqx0WonJRAxbirfZFcL9lUGI3+QIsnag
 ZqKJLt6Ipqz9ro6+tP7RuFsSK5qaUst7tnCWunAzu1i9Jxuc3x0xNVwQbJ72RSMVymqS3673Uzq
 0IScPQRR1Erz9MuzyBOe9glVBuHU7wtpfMJ4lBMKwyjZ1YyER9CVJsi7ZTQ+ImCt7ZtsxfxaHUm
 M/aM54Xln3Fu2FBCGd5zui6m8keBBEjuI5jkQcuz/+CbmBSre1PyRbNtm/JABXfrgd/sbQklvYh
 1MnWzaC686HIWtZ12tpAE1T9TfxvaLAFTeBl1EWR/6ozk1dQbuLbHrs5elHnZFg6qXXt+19hlAm
 P4Rw7jfnD2c5n982OLvj0nE6dyyZkpxV77fjXb7nycGOjM=
X-Received: by 2002:a05:6a20:56a3:b0:366:14ac:e201 with SMTP id
 adf61e73a8af0-393724968d8mr1460280637.63.1770171031274; 
 Tue, 03 Feb 2026 18:10:31 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1bc:fe1e:491:928e?
 (bg30dhzlx7lnyrq74wrz.ip6.superloop.au.
 [2401:d002:dc0f:2100:1bc:fe1e:491:928e])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6c82e342e0sm613460a12.6.2026.02.03.18.10.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 18:10:30 -0800 (PST)
Message-ID: <5b4fca48-2fab-4874-8e0e-4dc8b63087b6@linaro.org>
Date: Wed, 4 Feb 2026 12:10:23 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] include/hw/virtio/virtio-access.h: remove target
 specifics define
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20260203205637.3109749-1-pierrick.bouvier@linaro.org>
 <20260203205637.3109749-6-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260203205637.3109749-6-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 2/4/26 06:56, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/hw/virtio/virtio-access.h | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
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

Why use two predicates like this, effectively calling target_arch() twice?
Surely it's better to do

     switch (target_arch()) {
     case SYS_EMU_TARGET_ARM:
     case SYS_EMU_TARGET_AARCH64:
     case SYS_EMU_TARGET_PPC64:
         return virtio_is_big_endian(vdev);
     default:
         break;
     }

Definitely with a comment saying this is about legacy behaviour.
And does VIRTIO_F_VERSION_1 really not take priority?


r~

