Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16B7C7EE2A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 08:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTz7L-0004g0-0x; Tue, 24 Jun 2025 04:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uTz7J-0004fq-3k
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 04:34:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uTz7D-0006TQ-2Y
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 04:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750754087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zhi7gKDyEXBFIyLUoXiDoNyk7C8y4NcDTzWfXoLTuys=;
 b=WV0D1mhXcwLX9DQIfHefNePhb+LXR0TUXUpSyxJ/Ml2Dogqll2PaRrSiZo55o7ug77aT1Y
 IxnnTjQdxxy6oCgyxhRdi/fR0Uux1M/58BvEyWq+WlneepHFPumrLzXOtwLxCtaV9dCxjY
 e61qvWbTGQl3cLiy/+nEMWwAdlNUpq0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-Jm3dV0TEM_qIqkMxNbbn1g-1; Tue, 24 Jun 2025 04:34:43 -0400
X-MC-Unique: Jm3dV0TEM_qIqkMxNbbn1g-1
X-Mimecast-MFC-AGG-ID: Jm3dV0TEM_qIqkMxNbbn1g_1750754082
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4532ff43376so41550845e9.3
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 01:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750754082; x=1751358882;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zhi7gKDyEXBFIyLUoXiDoNyk7C8y4NcDTzWfXoLTuys=;
 b=Co7FgcTrsOZpvY+E+6wlE3Gwe1/mJ5CSuqWm7hx6WzztxlIKSS+26QjYziiG1eWgc0
 7ytX85vpqcVIGnpLmDOk7TBDviGW6DIIYvR8VboLDGew5N4O+YXm1c3lMBO7i06fcIKs
 FjADFnMC1BrNOfWTUekAUe7hdigCmWrMtOeCwzK0DcggVZdb/y1Umktj4f2Ul8GRH/IS
 gp5ctX1e5bVw/r8qwu0zAPOhyfKug3yYYlBn3Dtt774Jm5gMWWtbP/XRzqzQW5ODMeSj
 Q9gbSHAU5fFJr40b3w0mjlinKCJu4T4gZ1GA8hkbWgyAnUfy4gAsIdFcoauNpX9x/8k1
 NeaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXccKZ/L+zK1x0ucxcQnWYWghQSk++Mj6RYXU3MYOs4fC0Lp7zl1JUKVf/4JesELwFonzOKy3QkFDpz@nongnu.org
X-Gm-Message-State: AOJu0YzMDNRc7+fwYriUzS6iTxXv6BzmfJtglFXcPea6gj2n7C+tDZUx
 HNNzafCc3s99T6dkWADl+5WmwCQ4ZEWrQNPCrswDh+IoyZLfyxmHoJzwSl5k6tmQ9oPQIgacojq
 y3cYN1eIGc0HBRyQ4kvYRre008DKq7PoDbpq1vW11RUANMnF7yg49Ynz0
X-Gm-Gg: ASbGnctsY+IdG3DaXDD71pa0ysEkQ4+4o47koJeNOHETm3p1OLNdO3I4PMRagnhMl4z
 Fpc3EBRBAnrFpxWbOnDqS3Vrd2Xz00VrXgMSeQquhVaYMGlYRwv8JHUOmNftYKjxTPyJpkNrR2C
 IadUxNx2m21mF6GZMUQaw3YoGXTbf7/MFElgATrcbNtK3gN1/jycWY7xFB5hiImylPWjNTf4fim
 E7qwU/ndXgrXTBKt0UERHaW0CqHJmVHm4y4IzjwWTwX41azHyyBpMpF7vFn2UNv4t8UDgQ39WmZ
 bilpxiEenDiT0V4XyGCxMtHBY9N8KcNdYsAJGl4G+7Iaahaob0NnJsrwSk8R
X-Received: by 2002:a05:600c:4ed1:b0:43c:fcbc:9680 with SMTP id
 5b1f17b1804b1-453659ec030mr128910925e9.25.1750754081860; 
 Tue, 24 Jun 2025 01:34:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHed1fNjG0nOWCWGlBzuwIiBTy0Oy2F1aoTDbb/HZ3Qd2vFztSp746RK88K1yFsE5kTYaTM8g==
X-Received: by 2002:a05:600c:4ed1:b0:43c:fcbc:9680 with SMTP id
 5b1f17b1804b1-453659ec030mr128910615e9.25.1750754081410; 
 Tue, 24 Jun 2025 01:34:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8050cc1sm1378421f8f.10.2025.06.24.01.34.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 01:34:40 -0700 (PDT)
Message-ID: <78fc7bed-75cb-4d9a-b6e2-86b95319bcfa@redhat.com>
Date: Tue, 24 Jun 2025 10:34:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: add license tag to some files
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250623093053.1495509-1-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250623093053.1495509-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

+ Daniel

On 6/23/25 11:30, John Levon wrote:
> Add SPDX-License-Identifier to some files missing it in hw/vfio/.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio/trace.h      | 3 +++
>   hw/vfio/Kconfig      | 2 ++
>   hw/vfio/meson.build  | 2 ++
>   hw/vfio/trace-events | 2 ++
>   4 files changed, 9 insertions(+)

I think that's OK to add a GPL-2.0-or-later SPDX tag on these files
because they are simple infrastructure files, and we know when they
come from. How useful it is ? that I don't know.

For other source files, without a license, if we have any, I think
the answer would be much more complex.

Daniel, What would be our position on such files ?

Thanks,

C.




> diff --git a/hw/vfio/trace.h b/hw/vfio/trace.h
> index 5a343aa59c..b34b61ddb2 100644
> --- a/hw/vfio/trace.h
> +++ b/hw/vfio/trace.h
> @@ -1 +1,4 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
>   #include "trace/trace-hw_vfio.h"
> diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
> index 7cdba0560a..91d9023b79 100644
> --- a/hw/vfio/Kconfig
> +++ b/hw/vfio/Kconfig
> @@ -1,3 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
>   config VFIO
>       bool
>       depends on LINUX
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index 73d29f925f..63ea393076 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -1,3 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
>   vfio_ss = ss.source_set()
>   vfio_ss.add(files(
>     'listener.c',
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index f06236f37b..e1728c4ef6 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -1,4 +1,6 @@
>   # See docs/devel/tracing.rst for syntax documentation.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
>   
>   # pci.c
>   vfio_intx_interrupt(const char *name, char line) " (%s) Pin %c"


