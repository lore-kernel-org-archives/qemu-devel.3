Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CC8C0218F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 07:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfDLG-00081V-Aq; Tue, 04 Feb 2025 02:27:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tfDLD-00080p-WA
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 02:27:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tfDLA-0001bU-Vp
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 02:27:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738654044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=caml/dtjCA6naDwITJNCmxDJeeSE9T0JRM/DysEV6o8=;
 b=AsSFU+1LEJlVUv1d1/A+s9TZWCFekgoQgzzTA5uYafgkpuYBsE48ZxxRbR8Qyhcrixyf3O
 d3YUQeuQK1aT5z5AQWAwGj/QYz1rosk0ce2+uDjW5V9qpK86gp1toOIZ/lzEZZk7SJK57K
 c2WLkPMANzN0gbuJ3lqH0uMZUhnyg1c=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-wrgYE7msNjGJ43OpTbsQ5A-1; Tue, 04 Feb 2025 02:27:22 -0500
X-MC-Unique: wrgYE7msNjGJ43OpTbsQ5A-1
X-Mimecast-MFC-AGG-ID: wrgYE7msNjGJ43OpTbsQ5A
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2165433e229so118892475ad.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 23:27:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738654042; x=1739258842;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=caml/dtjCA6naDwITJNCmxDJeeSE9T0JRM/DysEV6o8=;
 b=m/MAgq8YLBX0xJjWTJ8b6mweRwbtKx36kykshs0OFkziTkTMlwmLqvyyrA3Hgs6xLV
 UNPkwIXBjyfnYr8HMFhsLWU6xvZTF6hJbgoVHWHqpsHvAaLtxNs6VJMu41QiFe5BUXde
 E+AyH+M/NokCOSaTtNccLYLWlysgG3JIC1Fw7KugE4AmhPXz1nWmfYB6toEGDZjTXs0q
 3m5M0JydunJOCw2XIKyTzSGhvk3A44l8vPRF+QQITDe/OsO1Ivo2Urw2Y3GnIKW2Bs+E
 YlrD6OwVT5fQPPIm/+QwJ3Gq6jFxqHA4mVuFYOmLAeWtQ8g+1lOMWcR28CTVlK5cLOfk
 xPtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBztrvuQoENATBuGg1a4GvrsyHehwC/g5W9Ddd8Vx6e6xrwVkn5awcpuJ/hWkk4jUroV/auXzzC2GE@nongnu.org
X-Gm-Message-State: AOJu0Yx3RbQvpi1uXa4U3a0T6cj+RvCi27ZFN7Fwtx7bbdV+AAM5eTht
 qC+KH7gkbungUdn9KqLpcL90/1fugI5KVK53QOUrzCF4ojvMYkqNc+B5MspfT8UijsojenVkdMc
 wxAjGlytQkFYq+PK0bTTtLpa1lrxAdCJUGux8at9slDU0+pby8HPa
X-Gm-Gg: ASbGncu8pHkDuNV1+AKR+PAA10QKddTFPqyu+kAmqE/By7YS6DC99qNLPZqw5JIObAb
 fHL2+g0Re29esjAw+ybe4xW5mIc1MK4mKpG0kgqbS34qPJTVqiHVJ+Rw82G/LAQLEkDKm6fX5Fs
 9NExBZAmvmK6ENSD7wqbjHVuMPR325icGOud36zr7dlL8YMehQpaP23PSQ99166oaYUT9U+N7Ha
 LaUmi3SgGod7oJvjPTqA0mWsWAAlU3q425JyKik2js4NIg/IjE7TJ2s76fGZIBtvqPxabQ0hgUx
 xeb0Gg==
X-Received: by 2002:a17:902:eb54:b0:215:a2f2:cfbf with SMTP id
 d9443c01a7336-21dd7c66954mr249327595ad.18.1738654041859; 
 Mon, 03 Feb 2025 23:27:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJ7hGl1p4k8PZzKY8c4GxA8SgSTYlQcV2cStO8A63nMYYTv/dMFqNOFf/1QwPthXI7JEg6eg==
X-Received: by 2002:a17:902:eb54:b0:215:a2f2:cfbf with SMTP id
 d9443c01a7336-21dd7c66954mr249327435ad.18.1738654041574; 
 Mon, 03 Feb 2025 23:27:21 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.64])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-acebddbb1dfsm9411422a12.5.2025.02.03.23.27.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 23:27:21 -0800 (PST)
Message-ID: <e8075a46-8810-4be2-8ad0-b465268541b8@redhat.com>
Date: Tue, 4 Feb 2025 17:27:17 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/26] hw/arm/boot: Mark all guest memory as RIPAS_RAM.
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-20-jean-philippe@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20241125195626.856992-20-jean-philippe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/26/24 5:56 AM, Jean-Philippe Brucker wrote:
> All Realm IPA states are by default RIPAS_EMPTY, and accessing them in
> that state causes injection of synchronous exception. Either the loader
> or the guest needs to set IPA state to RIPAS_RAM before accessing it.
> Since a Linux guest needs all memory ready at boot [1], initialize it
> here.
> 
> [1] https://docs.kernel.org/arch/arm64/booting.html
>      https://lore.kernel.org/all/20241004144307.66199-12-steven.price@arm.com/
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v2->v3: New: the Linux guest does not initialize RIPAS itself anymore,
> and expects the loader to do it.
> ---
>   hw/arm/boot.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 

I think the changes in this patch can be combined to the following one,
or move this after it. It logically to initialize guest's RAM covered
by PATCH[9]. I'm not sure if there is particular reasonable why we
don't do that.

PATCH[09/26] target/arm/kvm-rme: Initialize Realm memory

> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 5301d8d318..a2414b1f98 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -26,6 +26,7 @@
>   #include "qemu/config-file.h"
>   #include "qemu/option.h"
>   #include "qemu/units.h"
> +#include "kvm_arm.h"
>   
>   /* Kernel boot protocol is specified in the kernel docs
>    * Documentation/arm/Booting and Documentation/arm64/booting.txt
> @@ -1238,6 +1239,9 @@ void arm_load_kernel(ARMCPU *cpu, MachineState *ms, struct arm_boot_info *info)
>       info->dtb_filename = ms->dtb;
>       info->dtb_limit = 0;
>   
> +    /* Mark all Realm memory as RAM */
> +    kvm_arm_rme_init_guest_ram(info->loader_start, info->ram_size);
> +
>       /* Load the kernel.  */
>       if (!info->kernel_filename || info->firmware_loaded) {
>           arm_setup_firmware_boot(cpu, info);

Thanks,
Gavin


