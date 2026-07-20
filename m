Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F0FC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlisd-0006Ph-E4; Mon, 20 Jul 2026 03:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wlisb-0006PX-Qm
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:57:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wlisa-0006vw-8l
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784534255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/kBn5dGHXt1uir+tVc9QkqZtMNeZwRApMNzNYyfst4c=;
 b=IWGgp2/L/i2FrSh2DROqECBpOAl4xpvtivik3cMJyxXAEghNvkTzx+tiHHCQRHu2xTiuf/
 ojICzKOJOLd6G+jHCMxS7Ng15LE+rCKFXkd4pjYvJQ2aGB06Ni4o+3aEEjP94R1wRYPciC
 jc6X5oQytcIOxQrzNuTTcMXXLX8ATgU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-QZcnKLNaNV6Sxi6juK_Jyw-1; Mon, 20 Jul 2026 03:57:33 -0400
X-MC-Unique: QZcnKLNaNV6Sxi6juK_Jyw-1
X-Mimecast-MFC-AGG-ID: QZcnKLNaNV6Sxi6juK_Jyw_1784534252
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49545755b03so29596565e9.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 00:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784534252; x=1785139052; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/kBn5dGHXt1uir+tVc9QkqZtMNeZwRApMNzNYyfst4c=;
 b=cykREAqWnM+nsFaNE37q60JjcfuNndJ3K3sJlOKUD8QVeqzvFwkcxL2OEiOfseoUGx
 XUIrMU+ImAAGCEWFpl5wFo4brfYlxclRfJ10k+uZVcAT0b2/PoPKYMwcEi205v0WaJJk
 qO/iCGY09XHO2KNdPUTqA+SCcjB/+mCU3L1ZFfnmnUbNciMTRngspl0bU0c97WT7tz2+
 oyTdlmvCwTviBKhT6rBE3/LDCxOVhvOExgxxXi86het1km8q49gf1wpXEfdlcBPirZfC
 3VSqKI17SXmQI+aqHLQ8oqEV97nafAtbXhG/s94hIrdmrlsIrs0CO7BP9O1lDvziteei
 zrqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784534252; x=1785139052;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/kBn5dGHXt1uir+tVc9QkqZtMNeZwRApMNzNYyfst4c=;
 b=aw140uD4+96QfERZsr/2EM9QVNkYID1gCyq1a62dFDhbj3vzfOghdxoMySDG+rBiI6
 jOWN2HeCXkC7p+2dDxJ4GeUT6zvDGkQGm7k2fPWxAp+VONqkwec4z+yYpvJcxqsvA07X
 4fykBFToHgctWlYhDg+yFUIUV5A/MnpPKl0ru/aFXYU0ftx7nzBsDbO5a8ds/ZTU1ro+
 mXOl3qNGrXKlItXcO3FeCdCbYHkulkzJHqoVjI2AoVBS49vmouGvpiQc2WAOyqirO9d+
 JkeabF1GvTZuyRbTyNmHjmZLks/dbvF0vcycXTvt4IuWaQhJ9fDSBNTihfKgR7Ce7XC9
 z63A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQGjOBYZEralQTCBjnB+z20efubvMTm+3MLDbsFqjpNlWBQlK7hoKrOjCmUaG5Ij/RHrJGEcqqHIbj@nongnu.org
X-Gm-Message-State: AOJu0YzsF46fPBnLYah5237QH4TaKLDsyvs4S/yUwE7LRQGjzXoXyqZb
 j82mxeG0Gan+W9u5ZFbHlYS2tPatdISOrmhlj0CwRfaodzlsSNYz1X4gPhz7se57BpODuHwaDRs
 B6jWLVNCOVpPB2iioAc45lKBeUflR1GMBVlvt3HKYRhSccsHqJIZW97Lv
X-Gm-Gg: AfdE7cmM9qZ4yty0ap52FKSUADfw4e+qUVPZEDoj0UyNlD8s0W0p2PyM9Wfp8SMmQkc
 jh2RfjnXXNSsi4Qc8Qqt9PSW92TnS7dBL5W4TBXVoJm58esbURzf7jhoyLtdxHDN+6h+ekoIL9+
 VKC8hpVu2D+zZUx+yujbRhmocKqTV/iMM3qSqR27QSFN9U0WRvdocqAfWn8jqwk3KYajcayV85Q
 rTGYPyWzocsy2Qu8QSWdyWcFJrjwAVqmUfXfUjW1LREY+K5qYGQ7J9EwLW3k3HL/Tiuu2m7jKfa
 7UBxkN3Mx+Xm883vdtosUnPpZRQWuJCB3IuZuOo1Q8DgPTY7Cw1RiRCepdk7hosnY+EwKdw9Fw=
 =
X-Received: by 2002:a05:600c:4f56:b0:495:4dd3:ca97 with SMTP id
 5b1f17b1804b1-4954dd3cb28mr119667125e9.29.1784534252338; 
 Mon, 20 Jul 2026 00:57:32 -0700 (PDT)
X-Received: by 2002:a05:600c:4f56:b0:495:4dd3:ca97 with SMTP id
 5b1f17b1804b1-4954dd3cb28mr119666835e9.29.1784534251984; 
 Mon, 20 Jul 2026 00:57:31 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49563969482sm4542855e9.3.2026.07.20.00.57.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 00:57:31 -0700 (PDT)
Message-ID: <b523e2ab-3af6-42fe-ad03-4276b1d4b00c@redhat.com>
Date: Mon, 20 Jul 2026 09:57:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] backends/rng: cap request size to avoid oversized
 allocation
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Amit Shah <amit@kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 qemu-stable@nongnu.org
References: <20260715141300.2295392-1-lvivier@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260715141300.2295392-1-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On 15/07/2026 16.13, Laurent Vivier wrote:
> rng_backend_request_entropy() uses the requested size to allocate
> a buffer with g_malloc(). With virtio-rng, this size comes from
> guest-supplied descriptor lengths. A malicious guest can set a very
> large descriptor length, causing QEMU to attempt a multi-gigabyte
> allocation and abort.
> 
> Cap the allocation to 64 KiB. The virtio-rng queue size is
> hardcoded to 8 entries, the EGD backend protocol limits requests
> to 255 bytes, the Linux kernel hwrng framework requests at most
> SMP_CACHE_BYTES per call (64 bytes on x86_64), and the Windows
> viorng driver uses a 4 KiB buffer. The worst legitimate case is
> 8 x 4 KiB = 32 KiB, so 64 KiB is well above any legitimate use.
> 
> Fixes: 14417039653d ("virtio-rng: use virtqueue_get_avail_bytes, fix migration")
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3983
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   backends/rng.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/backends/rng.c b/backends/rng.c
> index ab94dfea850a..d8904f89dc43 100644
> --- a/backends/rng.c
> +++ b/backends/rng.c
> @@ -11,11 +11,14 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/units.h"
>   #include "system/rng.h"
>   #include "qapi/error.h"
>   #include "qemu/module.h"
>   #include "qom/object_interfaces.h"
>   
> +#define RNG_MAX_REQUEST_SIZE (64 * KiB)
> +
>   void rng_backend_request_entropy(RngBackend *s, size_t size,
>                                    EntropyReceiveFunc *receive_entropy,
>                                    void *opaque)
> @@ -27,7 +30,7 @@ void rng_backend_request_entropy(RngBackend *s, size_t size,
>           req = g_malloc(sizeof(*req));
>   
>           req->offset = 0;
> -        req->size = size;
> +        req->size = MIN(size, RNG_MAX_REQUEST_SIZE);
>           req->receive_entropy = receive_entropy;
>           req->opaque = opaque;
>           req->data = g_malloc(req->size);

Reviewed-by: Thomas Huth <thuth@redhat.com>


