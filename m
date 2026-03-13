Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA58106FD9A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 07:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0xDP-0007Fs-Mk; Fri, 13 Mar 2026 03:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w0xDK-0007D6-6W
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 03:45:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w0xDH-0007lZ-0e
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 03:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773387938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qxeH9khtPSLe3LWFKWIs1IoX3thVeaFOy/khH2W7Fjc=;
 b=XlZHNI/FW7S2H0xKOBJ2sKcpO7ozIe6twcN2kyXgDK5byF01FQQwtJiX2+mADJNgzPXigq
 a6AexV2m0MMKL1qMaJPAhDYmHT6R/+H7Pf+LkDlXC4InmQcbDWiZzWK5gkAd5lBdF7WtBj
 A+63vzT0ZcUYUkqluKxmxMn32MKAuCE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-94si0NHXND24wJE-Nz8AVw-1; Fri, 13 Mar 2026 03:45:37 -0400
X-MC-Unique: 94si0NHXND24wJE-Nz8AVw-1
X-Mimecast-MFC-AGG-ID: 94si0NHXND24wJE-Nz8AVw_1773387936
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-439a85832c0so1856131f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 00:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773387936; x=1773992736; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=qxeH9khtPSLe3LWFKWIs1IoX3thVeaFOy/khH2W7Fjc=;
 b=mn/W6U8+NfaPn2KvhnM7sqSuYkqioqMiZM21xmfcl8PqQDcDJB6lSVJVQpk0v0YRW7
 EQX6cL8KHmbMK/dTM7RhPCRSDR6t7bqGkT6C7BHV/azt3rIC0f/d46ZWyMcemEvXERnL
 h1eVmGuqS4i5QpUlkOzL9A4eIJtANn2cl9sFvGZuUnSkh1Z5bjGwFU9QOsVBE/8L52Pu
 yHitt+BuUaIb76tPIiLKxLYrZoWv3VpJlxJ0ZIneqbrypsWmNGMe6bJYUq7uqMcoQ2AZ
 8VPPBO7+noaXTKe4CcXcrruDJCn2Ydp6xAjQjvIwk7VVhJlm+8i07t9+SZi1a2YcuTJY
 I6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773387936; x=1773992736;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qxeH9khtPSLe3LWFKWIs1IoX3thVeaFOy/khH2W7Fjc=;
 b=nib8yVuPiqLVHZ/wE5RbZbyGFS8fy4uTpIPXQ7l8TZ+uTKad7JUB0TGR0qEiSFzGiy
 19RAQOJcAqEdca2MJu3NtJtyiYOg6YPSmHzfnPyp+hQla2IRsldtM59GlMv+Mk1yBNAo
 p/moqbUFUWfKGxuaJxvTqo00/R1XPNt1f3/OvQvBwRMG4XIx7hF2jETJPsOAGmyVsrYZ
 vi84ECVOO5Xy6J+UBqkGXOYOQ6J85oLz+Pnm8hDLVP7276F+i7dj2fsr544uXBvmhvnt
 lLC0wcn5rUt+ky0kqihO6WeSJFwOq5N+lLTiJUd+v0gRnmxSJeZ50qZT6Rg3xOjseqNF
 P0hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcX+HMkcR7KfiUSvoVP0HTyuGoqJeaI5S8BL3QQPWo5ApVqdJ4fLHnea3WVi6cCtWLpEKjv2QIXQVd@nongnu.org
X-Gm-Message-State: AOJu0Yy1QsQf/bLWUefBNyJAdzRvwC2mnJuqeRlBT/Yzk5RBuXtvIkd/
 r6N/YYF5yLUvGQB9H4fHg3OtNsXU5kYeKdFElMfBb8EgDPQRnqjFVrW6hwog+8xiQ8+HRpJ47hr
 kRbm/691dGaUq+s5kbM4uRRl+rWTdO0xc5UAWrMafXv6PLhoYqNw/jmNi
X-Gm-Gg: ATEYQzw93afJEhQprJFH/mRyj78InQ83c6OKDlJZ6siiOz8wOuVZiv6AK4RfQwpnmSQ
 dxeEuAcVxjqtotp4mvaKmk29Au6ym2DnGqEbOeH0byWJ5uvyXtgTs5ECaEfmoI6Sx3A/bDMdWk5
 oPfi6O7El1TvmYlXVcR58r18ouJsZW07DsklQ6WtgoGNWqihnFRIGaB8bVFL81030ZOlVZgmLJF
 c2/YCHXznL/00FUwun2kNBXZVC2i1yKoPKx2zyXq6X1qcMtUs7aHA11FRc26+/wFaTMjaAiNyXO
 wcwZhp2KFwtgxxV/vhBTLVOmdqIz9jiNmSEIHh/WVfywdaUY2sWlGP73x8x1LUtqcfpZFCRSOpP
 1vRgGD/Ny9LrxJEFiQqoH/M3RYW3/M9yCrvJKDsKP9mDwvPVA0X52sKK5T91F
X-Received: by 2002:a05:600c:1e8b:b0:483:b505:9db7 with SMTP id
 5b1f17b1804b1-4855672ada8mr30752345e9.32.1773387935768; 
 Fri, 13 Mar 2026 00:45:35 -0700 (PDT)
X-Received: by 2002:a05:600c:1e8b:b0:483:b505:9db7 with SMTP id
 5b1f17b1804b1-4855672ada8mr30752115e9.32.1773387935362; 
 Fri, 13 Mar 2026 00:45:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557c6ce2fsm13914035e9.25.2026.03.13.00.45.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 00:45:34 -0700 (PDT)
Message-ID: <b1ec1e57-2d6a-4301-bf98-e1c2d7c307bc@redhat.com>
Date: Fri, 13 Mar 2026 08:45:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] hw/vfio/ap.c: use full path for target specific header
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
 <20260312224449.1605071-7-pierrick.bouvier@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260312224449.1605071-7-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/12/26 23:44, Pierrick Bouvier wrote:
> In addition, we fix target/s390x/kvm/kvm_s390x.h cpu-qom include also.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/s390x/kvm/kvm_s390x.h | 2 +-
>   hw/vfio/ap.c                 | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
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
> index 856fa2678cd..3fae9ae9814 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -25,7 +25,7 @@
>   #include "qemu/module.h"
>   #include "qemu/option.h"
>   #include "qemu/config-file.h"
> -#include "kvm/kvm_s390x.h"
> +#include "target/s390x/kvm/kvm_s390x.h"
>   #include "migration/vmstate.h"
>   #include "hw/core/qdev-properties.h"
>   #include "hw/s390x/ap-bridge.h"

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


