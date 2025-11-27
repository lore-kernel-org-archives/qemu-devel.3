Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A147CFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 05:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOUs3-00088o-Ij; Thu, 27 Nov 2025 00:48:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOUs1-00088Z-RJ
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 00:48:45 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOUrz-0006E0-Gn
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 00:48:44 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-477b1cc8fb4so2094265e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 21:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764222522; x=1764827322; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8rbm2u57QUbybfY9DnVctk8qjag5ZWsibrK5eSGyLPg=;
 b=kiKJjMnqTRC7MRZshyFYqukBxGgWHkCrXlaPj0MVGcodr+zmP9nZ5ZtvcbwvWLUi0W
 8Qcfrdsc0oEQziAmRdZdJPA9Q47M7rEuSBxIhWhdjeTevI8LiyRdbIZ1AF4x0atuWn0f
 jIb01N5O7TBZ1gTl4gRNlafuTq/QOIWhGCdA55Ps4DSECxWgw8Sb9MGUbqCyW/Lj56yH
 DW3WnQKDgpxpuIENFguEWtJ79a5hId7N+bN6fEWnY3J6gCG7LEJQFSfDOxstAQIrUYFz
 QlOJOYSKiEFfAyihHWEaMQ59z5+37+7Dg1VR9Hx3aHH3fnqKa70QTloXjFc9LM7BIHNt
 tswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764222522; x=1764827322;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8rbm2u57QUbybfY9DnVctk8qjag5ZWsibrK5eSGyLPg=;
 b=RR1Ghp8qnImMG2yDD1btZB7yEd6fboTwua7CCLkjPNPUWe5yikTPx75uqL8dlAZpSw
 DiY48r1bgYiuWsCb1WW0M5rbm2ohx7ZVaKZTz7FsYa2G0x7HJDJK2/oxv4RlWaDufcCW
 a4mb8duFEKXoLwwPjYrera+xRY376wXwwJFd+UlRDNe4Q9pCD+zpD3RB+SoWR3xEoKv8
 EVuvcsUFw5xrO4MmBbhheOusQbQoTeINBPKMZJT8bkxLoMtCY+yvThHroCZbLi+sNqej
 LJIP/jPk1+vE1gaSMAhqCb4kqFKArptnXrjQF4s4HEj/IHlmsYBQM6G1nSfSsE1C6I6i
 2B2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmcv1TzDU4n87wKLWXo3QJPpH92SzYmdmVCi1jyTBvFNDeyJq2d006JUS/bz1yFrfCcfZWrYkeqq+2@nongnu.org
X-Gm-Message-State: AOJu0YzHXrSbvJ9Bpf5C/S3QY/ym7zO556NQUrPlXh4me7elIkZ5alY4
 tTuJR6vjMywUiGSs1GJ1dSVN65NqFIQT6d7oV4QIatRGJMciR/ue+EQphYjM5Dlh7vCv1awd7vq
 y8GUpE4zwHKB7
X-Gm-Gg: ASbGncv3HThET0caJfWtTwjkIHoDNnJeUqBCGNALr8Ob7hYzUI0uaJdjawfy8u7CWWI
 UN1LqTCrinYQ6Ph8+syFUTkan6xuaM5ZIjDCUMAW4z6TTQSvKERy9W0Wf8nr7WC4DvjFeaD0UXz
 V0MUR8uQ7GfztFK9Nszj+F1+THvJasVpR2ocDtDckXy3qVrax+BrUXEDHvB3G/uPintVu+kfE65
 XYJ1bQkW4jWleEARyjJ1XrCMFwu+XlxSE33eB4nrah16NyMRsrJhw1TRscYTBGMNM4rQ+0pNUoR
 f4IMbuGjlNWoJIBRJBtU5IVAEApL9lHYhIEbbXh/sSX1Ug9VstcUNdvx8D6RrJp+B4C5hzIpcSr
 lkJvN+wVqxFeN+X4ku+sxoexWt067L1AoFFZYQrqx1FJKBlVUoNvp2lebcl6uAkp6yQWxxCxIKZ
 SajXKM8jaCAejZYbYUJIwly+ov9v16iL76k3Eurp5JMBFm1UuwUMBGnQ==
X-Google-Smtp-Source: AGHT+IHYbWsR03P1fxyhY25ZlrDH9Eprgj9esam8PJkMRxEDwOuqAEO9CSlZnLL9Yn1m5hBTRj7kvw==
X-Received: by 2002:a05:600c:c8c:b0:477:a9e:859a with SMTP id
 5b1f17b1804b1-47904b1ad30mr79811685e9.22.1764222521689; 
 Wed, 26 Nov 2025 21:48:41 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5d6277sm1530837f8f.17.2025.11.26.21.48.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 21:48:41 -0800 (PST)
Message-ID: <084f637e-701a-4b46-a3b2-f4755ddb40fb@linaro.org>
Date: Thu, 27 Nov 2025 06:48:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/uefi: add pcap support
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20251126142559.4081483-1-kraxel@redhat.com>
 <20251126142559.4081483-3-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251126142559.4081483-3-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 26/11/25 15:25, Gerd Hoffmann wrote:
> Add pcapfile property to uevi-vars-* devices, allowing to write out a
> capture of the communication traffic between uefi firmware and qemu.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   include/hw/uefi/var-service.h | 10 ++++
>   hw/uefi/var-service-core.c    |  7 +++
>   hw/uefi/var-service-pcap.c    | 94 +++++++++++++++++++++++++++++++++++
>   hw/uefi/var-service-sysbus.c  |  1 +
>   hw/uefi/meson.build           |  1 +
>   roms/edk2                     |  2 +-
>   6 files changed, 114 insertions(+), 1 deletion(-)
>   create mode 100644 hw/uefi/var-service-pcap.c


> diff --git a/hw/uefi/var-service-pcap.c b/hw/uefi/var-service-pcap.c
> new file mode 100644
> index 000000000000..879eee4699a3
> --- /dev/null
> +++ b/hw/uefi/var-service-pcap.c
> @@ -0,0 +1,94 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "qemu/pcap.h"
> +#include "system/dma.h"
> +
> +#include "hw/uefi/var-service.h"
> +
> +#define LINKTYPE_EDK2_MM  302
> +
> +#define SNAPLEN   (64 * 1024)
> +#define TYPE_RESET       0x01
> +#define TYPE_REQUEST     0x02
> +#define TYPE_REPLY       0x03
> +
> +static void uefi_vars_pcap_header(FILE *fp)
> +{

static const

> +    struct pcap_hdr header = {
> +        .magic_number  = PCAP_MAGIC,
> +        .version_major = PCAP_MAJOR,
> +        .version_minor = PCAP_MINOR,
> +        .snaplen       = SNAPLEN,
> +        .network       = LINKTYPE_EDK2_MM,
> +    };
> +
> +    fwrite(&header, sizeof(header), 1, fp);
> +    fflush(fp);
> +}


> +void uefi_vars_pcap_init(uefi_vars_state *uv)
> +{
> +    int fd;
> +
> +    if (!uv->pcapfile) {
> +        return;
> +    }
> +
> +    fd = qemu_open_old(uv->pcapfile,
> +                       O_CREAT | O_WRONLY | O_TRUNC | O_BINARY, 0666);

Consider qemu_create() to help Markus' tree-wide cleanup.

> +    if (fd < 0) {
> +        warn_report("open %s: %s", uv->pcapfile, strerror(errno));
> +        return;
> +    }
> +
> +    uv->pcapfp = fdopen(fd, "wb");
> +    uefi_vars_pcap_header(uv->pcapfp);
> +}


> diff --git a/roms/edk2 b/roms/edk2
> index 4dfdca63a934..46548b1adac8 160000
> --- a/roms/edk2
> +++ b/roms/edk2
> @@ -1 +1 @@
> -Subproject commit 4dfdca63a93497203f197ec98ba20e2327e4afe4
> +Subproject commit 46548b1adac82211d8d11da12dd914f41e7aa775

Unrelated change I presume.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


