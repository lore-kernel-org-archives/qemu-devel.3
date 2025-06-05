Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F02DC5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 05:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN2tb-0004T2-Pf; Thu, 05 Jun 2025 01:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uN2tS-0004SO-3V
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 01:11:59 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uN2tQ-0002NB-AJ
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 01:11:57 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-450d37d4699so2895715e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 22:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749100314; x=1749705114; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b7H6tai2vwhMMTZPKeAKNG0qd+0DBDEG1dLIPfX5fos=;
 b=zZF8U8R44x0WwFu8fqRYRM0g1dkSG0+/47/nFfnpPNFc2F+GhU9BottgXVmhYwBNBZ
 A5Bxwu3odViUAcb3hMc0HCMRMMZ4tk/fsXe0guscu0d9N+YVIKXOKKwI+gPpHKIjzYRE
 KmoAARTrlxzhVckw5sHUbpQ4McAFaYygQNJxVWh/DLeal5MCOcQlAAsIHcR4Vlsi8mUI
 LFAQeZOYCpGi8a1liOEWVVBMf3U6oP+066hEASHeugqRXe7L5XRni4WidUmqSdkqWwy/
 3R29bhNogYtKip5FD6viyejmIVz7VkfLjQRJI6HazRN5kz98U5CRqUwYZWt0HKyo70VP
 Kpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749100314; x=1749705114;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b7H6tai2vwhMMTZPKeAKNG0qd+0DBDEG1dLIPfX5fos=;
 b=wC8jEDkLNONs2AwUHUUeDVQ0dJA9ghf9N9wjd6lOcuiNj/1W/jHyLQJC7dgtcqg3mz
 xR2FeERmBX5ePtiZvVu9wIG/55lE+gCrpEoPFkz7Mu+ejBiSpsFvxuOwtO1lAQ3oQPFp
 9d9n8FdMCEuA61MJmxfIeuT9g+2MeQRsUgh4SRGFI87yNaCnXqmOjhKmgRcGEXYPjyI3
 d3PmnMukwx50qZWv8eqnJbQ85nWljLevsZ7QvufeYYvG8Js5fhkyxdty6n2x6gzh71kB
 5LytEqEYM0als1FTDHLz7yJTdsJvR4iURPrgtMTr/zYZPhOOfAgB0+UK9q5PqHIJghjn
 FFXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK3gnDonTneXSAZ9ECRaTPoftFRr8yCfSbhgj7YO+sayXFOvWyQmpgc708hdyLn6lwZU2AlZVyW4xW@nongnu.org
X-Gm-Message-State: AOJu0YwAcT21uF5mlQ9yIhMkHl0gUEw44SsxoE9HXCR4WjO/vieMFx8X
 2aRmRXORlzRrz1Dau34WUVMFkmtxqP928skhPT2fRPKFB8NiuTqp/aNVMIJ0D8v5J/g=
X-Gm-Gg: ASbGncsQCTM3qdA7i2lcNVFDSlPeLMKw8NuUdTZehA59KFpm8Ulnyz/XpWF9Z1bv7TM
 29N3OKkCiJZpCC4lW4e7ua3rcrZPBMv6tB4c4md1huUx3n8uElztIrXpYD3Tlxt3UuuaqkJVrS7
 WvKox9CWYIlXZcAEUrNz7GyHnmSsA5anJk8OCgMo/jsdNFDm/VtxSokrbqH0qEUqMWn9HyvZqpT
 5X8k4npDUBgLyl0e4+3Y0o7bxozWb0Cgv0Y1NZXl81t90iRf0zjZNnuzSKOF6CyT0Go4qUQ7lVF
 Gu51j/mJUcOaCnALLxZsINrGL/BZJoU+K7yEHQRQ5xDftkdFTFQT+9Y7WvqP8r9rlTYjNrRi8RE
 I55eevgjgLqh22rtOfn7i9tDnaIMs4Q==
X-Google-Smtp-Source: AGHT+IGoPH4sCJ3T8/TFYIDO3t5zasgB1cAGV4fyMr+0DDLXEu4+3bcz1DGhCbgRAUUnIyl+G/uPTg==
X-Received: by 2002:a05:600c:b96:b0:441:d43d:4f68 with SMTP id
 5b1f17b1804b1-451f0f4f1c5mr47350685e9.15.1749100314574; 
 Wed, 04 Jun 2025 22:11:54 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451f97f797bsm12009995e9.1.2025.06.04.22.11.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 22:11:54 -0700 (PDT)
Message-ID: <746b078e-bd06-4361-aec7-2301412abb18@linaro.org>
Date: Thu, 5 Jun 2025 07:11:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ramfb: Add property to control if load the romfile
To: Shaoqin Huang <shahuang@redhat.com>, qemu-arm@nongnu.org
Cc: Eric Auger <eauger@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
References: <20250605030351.2056571-1-shahuang@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250605030351.2056571-1-shahuang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Hi Shaoqin,

On 5/6/25 05:03, Shaoqin Huang wrote:
> Now the ramfb will load the vgabios-ramfb.bin unconditionally, but only
> the x86 need the vgabios-ramfb.bin, this can cause that when use the
> release package on arm64 it can't find the vgabios-ramfb.bin.
> 
> So add a new property ramfb-romfile in both ramfb and vfio_pci device,
> because the vfio display also use the ramfb_setup() to load the
> vgabios-ramfb.bin file.
> 
> After have this property, the machine type can set the compatibility to
> not load the vgabios-ramfb.bin if the arch doesn't need it.
> 
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>   hw/display/ramfb-standalone.c | 4 +++-
>   hw/display/ramfb-stubs.c      | 2 +-
>   hw/display/ramfb.c            | 6 ++++--
>   hw/vfio/display.c             | 4 ++--
>   hw/vfio/pci.c                 | 1 +
>   hw/vfio/pci.h                 | 1 +
>   include/hw/display/ramfb.h    | 2 +-
>   7 files changed, 13 insertions(+), 7 deletions(-)

Simpler to directly pass the ROM path instead of using a boolean,
so board (or CLI) could pass path to non-x86 rom.

> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 7f1532fbed..bfdf365978 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3564,6 +3564,7 @@ static const TypeInfo vfio_pci_dev_info = {
>   
>   static const Property vfio_pci_dev_nohotplug_properties[] = {
>       DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
> +    DEFINE_PROP_BOOL("ramfb-romfile", VFIOPCIDevice, ramfb_romfile, true),

         DEFINE_PROP_STRING("rom-path", ...);

>       DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, ramfb_migrate,
>                               ON_OFF_AUTO_AUTO),
>   };
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index d94ecaba68..d567de8f10 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -177,6 +177,7 @@ struct VFIOPCIDevice {
>       bool no_kvm_ioeventfd;
>       bool no_vfio_ioeventfd;
>       bool enable_ramfb;
> +    bool ramfb_romfile;

         char *rompath;

>       OnOffAuto ramfb_migrate;
>       bool defer_kvm_irq_routing;
>       bool clear_parent_atomics_on_exit;
> diff --git a/include/hw/display/ramfb.h b/include/hw/display/ramfb.h
> index a7e0019144..172aa6dc89 100644
> --- a/include/hw/display/ramfb.h
> +++ b/include/hw/display/ramfb.h
> @@ -6,7 +6,7 @@
>   /* ramfb.c */
>   typedef struct RAMFBState RAMFBState;
>   void ramfb_display_update(QemuConsole *con, RAMFBState *s);
> -RAMFBState *ramfb_setup(Error **errp);
> +RAMFBState *ramfb_setup(bool romfile, Error **errp);

   RAMFBState *ramfb_setup(char *rompath, Error **errp);

>   
>   extern const VMStateDescription ramfb_vmstate;
>   


