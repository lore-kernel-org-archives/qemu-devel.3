Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC5CC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 09:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Evz-0001fw-LB; Fri, 25 Apr 2025 05:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u8Evp-0001e9-AU
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 05:01:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u8Evi-0004mL-Lz
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 05:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745571664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sZlf4Ki0ILTf7DSzPCwsaG6Mz5kWBOKsa24PqXYPLp4=;
 b=OTV1XpvzkxBsk0b3F4aN0X+FMFOEPGdSajf+bYTcZjp4LqvoJRDBCwQamiK+OawiWKPFhw
 ApJnC10K7AlpvGBAgMhA7tlQEQKB1heFh8HMqaRkzqUCpY9LcOf4WoBr4lxbCZPkQ78fLG
 Wq6/3FDvfTbJCwaNigDzVaErhJ6wrPA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-zO8kBoWzO9eA4uccVyjP0A-1; Fri, 25 Apr 2025 05:01:02 -0400
X-MC-Unique: zO8kBoWzO9eA4uccVyjP0A-1
X-Mimecast-MFC-AGG-ID: zO8kBoWzO9eA4uccVyjP0A_1745571661
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cec217977so10219955e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 02:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745571661; x=1746176461;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sZlf4Ki0ILTf7DSzPCwsaG6Mz5kWBOKsa24PqXYPLp4=;
 b=rcwzDb3oHMdepz67qC5qvSbhA9B1e8LVsC6GhovgB4/glsZsCOyog9f96JO6tpvGw8
 7m+vlNCx5kcaHzQIvxsovNRvdzgP+NzwQ1WUwQ23KoiTQcUYImNlWS8CDSMZNGWxhlKv
 CAh3bEw/fSn189L5riu9Cosxiq0RddslF0/HUrEBFkIzOaIYwMrObQteoDTVzyq4wyQo
 Qv8HVZ0UPJz3fMvwxurD8sFfRPSLXScIFqVFgENChaWyKiigCVfm4GlRvdl6ccDdXwb9
 sbiPGh+d0pnkb9oTdX+KU7xMJ2MW6hufLWubgH/lX0vT8KOHwgTqNtFs02PLe8QD3l81
 Yihw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2GmE+HL5C4YYtPJHr4rK9ted0bxCae99MZB9CHwgDbm6xPwzzUEE3CTaYmVC8K9LcHHzKwXIMv1/h@nongnu.org
X-Gm-Message-State: AOJu0Ywgh5q+qK27lZ51XI26ycx82Ji8q7aexjvF2KJmdTvxVH2HnEQx
 Ap4Vw9gzoxEzos7YJ9K8KDcSPgEoGubvl50zx3SSPpwGe5EmKCO3nj81jRdi7q7fNc2m8Uei2vt
 EiwRSw9poOB6I6TcA1KsZ51Fue/h0HnZW7AHhGgvFDJgdjIMBjO0X
X-Gm-Gg: ASbGncuCjDLRzDuh1R9CkEpXgi+29cGX/kopMalof5JwitmOVWBzk46s/KsUAV4OjOD
 w4cfV5eYsqGTt0UEzR3kkVUD09ZLEi9iHGj7Qe2nVeWqD1DuoHyTUGUT3QFR4g6QL1TbXWqGChQ
 mrVO4BaRPI0JxpaEiCMvvMWXGGVhdH0XFWET9LHoJnoSoY0syNIbrxjkXAyKHOyUdNblChBDglI
 o6xi+6orw9SuvVGiT0pLaT5b1kZGv/qbswaALwxzqduMSSxrGvRdYGKv45v+XqoJNFmG/LQvKDt
 PJQsy6feDkOBtwZ7wSxcfTV2syjzQoMGAULEbDedXsJ++w==
X-Received: by 2002:a05:600c:1988:b0:440:9b1a:cd78 with SMTP id
 5b1f17b1804b1-440a65dc984mr15081505e9.10.1745571661366; 
 Fri, 25 Apr 2025 02:01:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr6ff6dbji0vLJXcEu0BsBPZIa4+SO722Ss84DP8ZsJPwPJaY5i+hyUfnJh0a5pOkYrfd29Q==
X-Received: by 2002:a05:600c:1988:b0:440:9b1a:cd78 with SMTP id
 5b1f17b1804b1-440a65dc984mr15080975e9.10.1745571660904; 
 Fri, 25 Apr 2025 02:01:00 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-43-178-177.web.vodafone.de.
 [109.43.178.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2e01bdsm51047535e9.38.2025.04.25.02.00.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 02:01:00 -0700 (PDT)
Message-ID: <06f9244c-671c-4215-9d20-7bb69194fae6@redhat.com>
Date: Fri, 25 Apr 2025 11:00:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] util: Add functions for s390x mmio read/write
To: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, stefanha@redhat.com, mjrosato@linux.ibm.com,
 schnelle@linux.ibm.com, philmd@linaro.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net
References: <20250417173801.827-1-alifm@linux.ibm.com>
 <20250417173801.827-2-alifm@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250417173801.827-2-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 17/04/2025 19.37, Farhan Ali wrote:
> Starting with z15 (or newer) we can execute mmio
> instructions from userspace. On older platforms
> where we don't have these instructions available
> we can fallback to using system calls to access
> the PCI mapped resources.
> 
> This patch adds helper functions for mmio reads
> and writes for s390x.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>   include/qemu/s390x_pci_mmio.h |  24 ++++++
>   util/meson.build              |   2 +
>   util/s390x_pci_mmio.c         | 148 ++++++++++++++++++++++++++++++++++
>   3 files changed, 174 insertions(+)
>   create mode 100644 include/qemu/s390x_pci_mmio.h
>   create mode 100644 util/s390x_pci_mmio.c
> 
> diff --git a/include/qemu/s390x_pci_mmio.h b/include/qemu/s390x_pci_mmio.h
> new file mode 100644
> index 0000000000..c5f63ecefa
> --- /dev/null
> +++ b/include/qemu/s390x_pci_mmio.h
> @@ -0,0 +1,24 @@
> +/*
> + * s390x PCI MMIO definitions
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Farhan Ali <alifm@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef S390X_PCI_MMIO_H
> +#define S390X_PCI_MMIO_H
> +
> +#ifdef __s390x__
> +uint8_t s390x_pci_mmio_read_8(const void *ioaddr);
> +uint16_t s390x_pci_mmio_read_16(const void *ioaddr);
> +uint32_t s390x_pci_mmio_read_32(const void *ioaddr);
> +uint64_t s390x_pci_mmio_read_64(const void *ioaddr);
> +
> +void s390x_pci_mmio_write_8(void *ioaddr, uint8_t val);
> +void s390x_pci_mmio_write_16(void *ioaddr, uint16_t val);
> +void s390x_pci_mmio_write_32(void *ioaddr, uint32_t val);
> +void s390x_pci_mmio_write_64(void *ioaddr, uint64_t val);
> +#endif /* __s390x__ */
> +
> +#endif /* S390X_PCI_MMIO_H */
> diff --git a/util/meson.build b/util/meson.build
> index 780b5977a8..acb21592f9 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -131,4 +131,6 @@ elif cpu in ['ppc', 'ppc64']
>     util_ss.add(files('cpuinfo-ppc.c'))
>   elif cpu in ['riscv32', 'riscv64']
>     util_ss.add(files('cpuinfo-riscv.c'))
> +elif cpu == 's390x'
> +  util_ss.add(files('s390x_pci_mmio.c'))
>   endif
> diff --git a/util/s390x_pci_mmio.c b/util/s390x_pci_mmio.c
> new file mode 100644
> index 0000000000..820458a026
> --- /dev/null
> +++ b/util/s390x_pci_mmio.c
> @@ -0,0 +1,148 @@
> +/*
> + * s390x PCI MMIO definitions
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Farhan Ali <alifm@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include <unistd.h>

unistd.h is already included by osdep.h, so you don't have to include it 
again here.

> +#include <sys/syscall.h>
> +#include "qemu/s390x_pci_mmio.h"
> +#include "elf.h"
> +
> +union register_pair {
> +    unsigned __int128 pair;
> +    struct {
> +        uint64_t even;
> +        uint64_t odd;
> +    };
> +};
> +
> +static bool is_mio_supported;
> +
> +static __attribute__((constructor)) void check_is_mio_supported(void)
> +{
> +    is_mio_supported = !!(qemu_getauxval(AT_HWCAP) & HWCAP_S390_PCI_MIO);
> +}
> +
> +static uint64_t s390x_pcilgi(const void *ioaddr, size_t len)
> +{
> +    union register_pair ioaddr_len = { .even = (uint64_t)ioaddr,
> +                                       .odd = len };
> +    uint64_t val;
> +    int cc;
> +
> +    asm volatile(
> +        /* pcilgi */
> +        ".insn   rre,0xb9d60000,%[val],%[ioaddr_len]\n"
> +        "ipm     %[cc]\n"
> +        "srl     %[cc],28\n"
> +        : [cc] "=d"(cc), [val] "=d"(val),
> +        [ioaddr_len] "+&d"(ioaddr_len.pair) :: "cc");

Do we need the "&" modifier here? ... at least the kernel does not seem to 
use it ...

> +
> +    if (cc) {
> +        val = -1ULL;
> +    }
> +
> +    return val;
> +}
> +
> +static void s390x_pcistgi(void *ioaddr, uint64_t val, size_t len)
> +{
> +    union register_pair ioaddr_len = {.even = (uint64_t)ioaddr, .odd = len};
> +
> +    asm volatile (
> +        /* pcistgi */
> +        ".insn   rre,0xb9d40000,%[val],%[ioaddr_len]\n"
> +        : [ioaddr_len] "+&d" (ioaddr_len.pair)

dito

> +        : [val] "d" (val)
> +        : "cc", "memory");
> +}
...
> +void s390x_pci_mmio_write_64(void *ioaddr, uint64_t val)
> +{
> +    if (is_mio_supported) {
> +        s390x_pcistgi(ioaddr, val, sizeof(val));
> +    } else {
> +        syscall(__NR_s390_pci_mmio_write, ioaddr, &val, sizeof(val));
> +    }
> +}
> +

FWIW, "git am" complains about "new blank line at EOF" here.

Apart from these nits, the patch looks sane to me.

  Thomas


