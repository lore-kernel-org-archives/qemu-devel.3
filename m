Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BAEFD377A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 17:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvIdJ-0001OE-QZ; Wed, 25 Feb 2026 12:25:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vvIdI-0001NK-71
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 12:25:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vvIdG-0000Af-Mk
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 12:25:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772040306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SGb3rIPrdkAZP+UMuAlFB/rUzyknUZtqzELTuwD6o34=;
 b=KOiw4lwDu0rFmutXEVzBwv9lEfl9fOQYel0KG9ZG5nzPiKHbPyjyeyEc7JNVCyob6Rtf/y
 6/jQIXD3yIDLamVL7SVtdAgXQrB4uOpmpLmISH8+t+jQjATuW6ZkmfejQu5itn0ECtv/io
 qbnb3eKBPdG0ToYJEZOmXxpjJ0YJrEw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-Pc3wIHUYNmK-CiaX_kuzVg-1; Wed, 25 Feb 2026 12:25:04 -0500
X-MC-Unique: Pc3wIHUYNmK-CiaX_kuzVg-1
X-Mimecast-MFC-AGG-ID: Pc3wIHUYNmK-CiaX_kuzVg_1772040303
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4837bfcfe0dso77874855e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 09:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772040303; x=1772645103; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SGb3rIPrdkAZP+UMuAlFB/rUzyknUZtqzELTuwD6o34=;
 b=aI6Up+OyjD4tgePW2az3z8QAD3jK/akXktwyFo+444tk7zpPsPQov7wkeUWA0Zu/pH
 R5k5f/RuP7Van5rphsdNPtKldqfQ1UCtqGYG4e+hbJsHQ05fzBSsbZH5/vCYwEPgBv5o
 Rg+hBAd7WqDY75yx3lipcS5JJII+zrSbm9ogHYEmTNIKQGc2Mgefb1+7adzbkCSoJXfa
 Lmw9xacht4C39fPLrnStkFP9hb9fMzEvVfUFFCcxl+a+08UGwIBgS/IRgMVdaReLIWKd
 2g797uG8D1BiMPnEmvsaG4gPA1PhTee8Naxk+3I6EGUwYbLJgi51aqbpwZyxvq0vmqYy
 M8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772040303; x=1772645103;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SGb3rIPrdkAZP+UMuAlFB/rUzyknUZtqzELTuwD6o34=;
 b=Ovv9tUtRtFgKy2r1dmz8c98YWp6XaQ2UMiWp4D6cFMTaEyiZeOXTs7T/uhhB3s+MDT
 2bdmlUeGQ2lqS24J7NPM4B82wjiv86Ejqac8zvq8FTbLn+v8OacaOr63uWh3r1MBxaHQ
 K9eWL5fhzwwQ/zNrcYpRWytCTUS06dUJZd9hsVP/ztZgaxgGPCWzQZi6XMbxLOoUlxAt
 +59AwTF2f+G5hKmCj22O2B0LoiqGPN8vTGmeyOqCBvQZ5DPpoY5i4Wqb20rvAeR5cvm7
 NJcbJ4+E5ukMkZ+rEfWSCBU+XmNyZ8sKDfdgl9BOonLXEpsLvS/YfFZ6/tr/HRQ2b+UK
 o8yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRW6UDeU6PcQz1m0edCR65cUtwNJETSPbYx8OGQnMuC7dU7zh3k3lWmydSsc626cy2XrY6hD+/d2V2@nongnu.org
X-Gm-Message-State: AOJu0Yxh9lR5am2Zo2mGpPneYiNG39XSO/nSfFl2lEK1EJPsU47WVgRi
 lLlqyJhg+CtVqY7vk2ptD/XY8IcR8wpnvlHlUrxJoxTk15fkm7afAMcsSqTe0/PzcobhViHrk68
 9q3hUE7aT4yFLTi8L0iglzIhDvsF9L3rUQYW6vz9pUzwMQTPUufBEt6zy
X-Gm-Gg: ATEYQzx1vhigfdQucZaNnrGHf0EJLegOZD5P99y6MAwQ9xr4EKx8nBRZP3ZqfBw7U+v
 mGIilp2o1T23IEbaC+Q3MI+t6jVk5EMaSd2jJShl4MDmzgoff2Zr2FGLgJeNRfWTI/kQM7YsxxX
 6bss/89A71hhZEWv7jSconf76B+alCcKSEGZDxJ7Y71dHYGqRBtUFjY9H/cE3Tiqx3unNM9eH1g
 SF8IpbZykVSLO8o3BFhpLsWRLe/f2PfG5gwbSb3OXuRrg2TmqioElKVOZvMEascUmZjbqeC4X1q
 yIKgxYzlt01yDzFhjdQtx38V5zW4TAZ1myYAtOKSFf/FAnzowY0ccJPDPqNCb/xUWDxG08Hlot4
 WgurMvJGKxN19nxRS+WX0H25vzEMIiW9RiEqsNi+EaGqUfZOWDSNLmWj9Yjo8PhZwvIU/f3goJs
 /PVMcErxs2Y/FTLpUmk3CHhD9ZRdc=
X-Received: by 2002:a05:600c:6815:b0:47e:e946:3a72 with SMTP id
 5b1f17b1804b1-483c21a10c5mr20770525e9.27.1772040302851; 
 Wed, 25 Feb 2026 09:25:02 -0800 (PST)
X-Received: by 2002:a05:600c:6815:b0:47e:e946:3a72 with SMTP id
 5b1f17b1804b1-483c21a10c5mr20770065e9.27.1772040302437; 
 Wed, 25 Feb 2026 09:25:02 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-483bd68826asm130006215e9.0.2026.02.25.09.25.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 09:25:01 -0800 (PST)
Message-ID: <9efd00f1-1cce-4518-ad85-4304805828b9@redhat.com>
Date: Wed, 25 Feb 2026 18:24:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] hw/nitro: Introduce Nitro Enclave Heartbeat
 device
To: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, alex.bennee@linaro.org, philmd@linaro.org,
 berrange@redhat.com, marcandre.lureau@redhat.com,
 Cornelia Huck <cohuck@redhat.com>, mst@redhat.com,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Tyler Fanelli <tfanelli@redhat.com>, mknaust@amazon.com,
 nh-open-source@amazon.com
References: <20260225144532.84673-1-graf@amazon.com>
 <20260225144532.84673-7-graf@amazon.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <20260225144532.84673-7-graf@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
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

On 2/25/26 15:45, Alexander Graf wrote:
> Nitro Enclaves expect the parent instance to host a vsock heartbeat listener
> at port 9000. To host a Nitro Enclave with the nitro accel in QEMU, add
> such a heartbeat listener as device model, so that the machine can
> easily instantiate it.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> 
> ---
> 
> v1 -> v2:
> 
>    - Convert to nitro-vsock-device
> ---
>   hw/nitro/Kconfig             |   4 ++
>   hw/nitro/heartbeat.c         | 115 +++++++++++++++++++++++++++++++++++
>   hw/nitro/meson.build         |   1 +
>   hw/nitro/trace-events        |   4 ++
>   include/hw/nitro/heartbeat.h |  24 ++++++++
>   5 files changed, 148 insertions(+)
>   create mode 100644 hw/nitro/heartbeat.c
>   create mode 100644 include/hw/nitro/heartbeat.h
> 
> diff --git a/hw/nitro/Kconfig b/hw/nitro/Kconfig
> index ce24c09c21..d3fbc7b683 100644
> --- a/hw/nitro/Kconfig
> +++ b/hw/nitro/Kconfig
> @@ -4,3 +4,7 @@ config NITRO_VSOCK_BUS
>   config NITRO_SERIAL_VSOCK
>       bool
>       depends on NITRO_VSOCK_BUS
> +
> +config NITRO_HEARTBEAT
> +    bool
> +    depends on NITRO_VSOCK_BUS
> diff --git a/hw/nitro/heartbeat.c b/hw/nitro/heartbeat.c
> new file mode 100644
> index 0000000000..dc41323266
> --- /dev/null
> +++ b/hw/nitro/heartbeat.c
> @@ -0,0 +1,115 @@
> +/*
> + * Nitro Enclave Heartbeat device
> + *
> + * Copyright © 2026 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * Authors:
> + *   Alexander Graf <graf@amazon.com>
> + *
> + * The Nitro Enclave init process sends a heartbeat byte (0xB7) to
> + * CID 3 (parent) port 9000 on boot to signal it reached initramfs.
> + * The parent must accept the connection, read the byte, and echo it
> + * back. If the enclave init cannot reach the listener, it exits.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "chardev/char.h"
> +#include "chardev/char-fe.h"
> +#include "hw/nitro/heartbeat.h"
> +#include "trace.h"
> +
> +#define HEARTBEAT_PORT      9000
> +#define VMADDR_CID_ANY_STR  "4294967295"
> +
> +static int nitro_heartbeat_can_read(void *opaque)
> +{
> +    NitroHeartbeatState *s = opaque;
> +
> +    /* One-shot protocol: stop reading after the first heartbeat */
> +    return s->done ? 0 : 1;
> +}

This made me notice that the nitro accelerator right now does not tell 
QEMU that it's not resettable.  Ok to squash in a

static bool nitro_cpus_are_resettable(void)
{
     return false;
}

in patch 4?  And then later on we could reuse the vmfd-rebuild machinery 
that Ani has plumbed into KVM, together with reset functions in the two 
vsock devices, in order to support reset.

Paolo



