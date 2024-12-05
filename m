Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4086FE7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 22:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJJtF-0005SC-0z; Thu, 05 Dec 2024 17:00:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJJt9-0005Qr-GD
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:59:59 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJJt7-00006V-RT
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:59:59 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-385e075255fso1083975f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 13:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733435995; x=1734040795; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XGf03nzHAWGwYGnYhWNnoe3LnELscMFwzsl0qyNy81s=;
 b=Lr+XHBspwjE+uBLigknys+gryWdCn8apz+TphLYvC6KncuM2EyBfPMlZS+v9hh4KLd
 rRBLRDdXiC1YOoukD5zQmCGl1M9JPV+qXnWK8b/cefkPuH+ZSkTcqEvC0L9L1O+SIlvD
 3RjZPqgWZ8l8FTC9UJqX9w0osAHJq2cHVDeahSfbmG3G2BkUHMSiFVGjn4uRAGK0Ya0I
 vKNMRL9L3myDKsJvS9Eh0rPndkykoau61l9iL0Z7+gUryhBdDUnOYcGJLAtxEvv0g+PI
 m/tj4/RVjKdBnDr3FU0OSJqxQO0GXJHL7SJ3iaMoVTujJ3cuzdNSwn0sLXQ2BiPye+/u
 bWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733435995; x=1734040795;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XGf03nzHAWGwYGnYhWNnoe3LnELscMFwzsl0qyNy81s=;
 b=spQjV30lvtBXi0qEgtuPy9JOldM7BGXihrSKJSOKQJ8n2yiJ2mcCZBXTe7XSvmNmaP
 egX63wjKBNCr+3/TQOiJtiNvxeeH1m0U1sgSXkShrn+TeCjBGHyR+f1Y8VkIny04kJ59
 +D2IrzhdZ7pRNpeMf+njWYTm+88mMD+SasvZ+SvWeS8OL8zZfApljov2EVKqu75A5WzN
 o6cT1F6JxdnIw8NnpcvjQOvV3Sq42S5A3L2L6hvN4/T9+XxPNrc363VxUWZ+kQ7vfaG2
 Udm6yubdo++NF5p55nhnaBCZ8m68xd5k9OVndC6xgb16jxzIMkuXMwY8BXmMPFjoaiS+
 TjZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC+zArOIRFm6P/d+SRc/IaatYHJAz+sh4BuyNhKOZF/JuQDV4dHdkha3XTffasd3Iksf5+a4Z7jMjq@nongnu.org
X-Gm-Message-State: AOJu0Yzx0V1h+S55enrs1Hy301gsYnitao96eKaJnSVH3lKVJM25ekNu
 G0em30EewD8MhqKlm4axmbsrUygnl7xfLBcU/rPWb9PU3gqVY9oXJohw5sH6/9Y=
X-Gm-Gg: ASbGncuRNHTQvhZFctparC0dy0CGJqJIEA/H2KEtuRDNAY7lwGhUmuai2tMlGLHlzKW
 Z6Fgpc7X17A4NVgCwMpOz+Y0ltI7l1Xs8dy4Ho+12Q9RD4+2g/6V+V0acXmp8XgX7PemfQRHT/S
 wTEYvV6pxu4EXhw2V0iiJ87kYcHrUQt12yltzO0QaKPevTg+JT6B9wpogaIbKjHIZ0Q9dpKFbTt
 GKouW6GmFTAjlZoNXaXXyr/yndyNADBjvfU7pcCa4E6MxoDEg52WLlaowwxv4Z6xCUwV8z7p1MJ
 ZiEyU3EcHOpJhBRJLQ==
X-Google-Smtp-Source: AGHT+IFfsj7oglQJaZj64jQW53x0qDcr57liYsCT64pEl87oeDBXk+V2SZtm5P461qbVXcOl1tN58w==
X-Received: by 2002:a05:6000:1448:b0:385:f00a:a45b with SMTP id
 ffacd0b85a97d-3862b3560damr560287f8f.21.1733435994457; 
 Thu, 05 Dec 2024 13:59:54 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-386220b071dsm2948809f8f.101.2024.12.05.13.59.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 13:59:53 -0800 (PST)
Message-ID: <564df018-6d47-4cb6-b781-5a2e58669da6@linaro.org>
Date: Thu, 5 Dec 2024 22:59:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/26] hw/core/loader: Add ROM loader notifier
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 alex.bennee@linaro.org
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-10-jean-philippe@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241125195626.856992-10-jean-philippe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 25/11/24 20:56, Jean-Philippe Brucker wrote:
> Add a function to register a notifier, that is invoked after a ROM gets
> loaded into guest memory.
> 
> It will be used by Arm confidential guest support, in order to register
> all blobs loaded into memory with KVM, so that their content is moved
> into Realm state and measured into the initial VM state.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>   include/hw/loader.h | 15 +++++++++++++++
>   hw/core/loader.c    | 15 +++++++++++++++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/include/hw/loader.h b/include/hw/loader.h
> index 7f6d06b956..0cd9905f97 100644
> --- a/include/hw/loader.h
> +++ b/include/hw/loader.h
> @@ -353,6 +353,21 @@ void *rom_ptr_for_as(AddressSpace *as, hwaddr addr, size_t size);
>   ssize_t rom_add_vga(const char *file);
>   ssize_t rom_add_option(const char *file, int32_t bootindex);
>   
> +typedef struct RomLoaderNotify {
> +    /* Parameters passed to rom_add_blob() */
> +    hwaddr addr;

This is the buffer (blob) address in guest physical memory.

> +    size_t len;

This is the buffer length.

> +    size_t max_len;

This is the size of the MemoryRegion ROM containing the buffer.

Do we need to notify it? You don't use it in your next patch.
If so, I'd rather have this API returns a MemoryRegion (Rom->mr),
max_len can be retrieved using memory_region_size(mr); but I
don't think we need this at all (at least for now).

> +} RomLoaderNotify;
> +
> +/**
> + * rom_add_load_notifier - Add a notifier for loaded images
> + *
> + * Add a notifier that will be invoked with a RomLoaderNotify structure for each
> + * blob loaded into guest memory, after the blob is loaded.
> + */
> +void rom_add_load_notifier(Notifier *notifier);
> +
>   /* This is the usual maximum in uboot, so if a uImage overflows this, it would
>    * overflow on real hardware too. */
>   #define UBOOT_MAX_GUNZIP_BYTES (64 << 20)
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 31593a1171..759a62cf58 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -67,6 +67,8 @@
>   #include <zlib.h>
>   
>   static int roms_loaded;
> +static NotifierList rom_loader_notifier =
> +    NOTIFIER_LIST_INITIALIZER(rom_loader_notifier);
>   
>   /* return the size or -1 if error */
>   int64_t get_image_size(const char *filename)
> @@ -1179,6 +1181,11 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
>       return mr;
>   }
>   
> +void rom_add_load_notifier(Notifier *notifier)
> +{
> +    notifier_list_add(&rom_loader_notifier, notifier);
> +}
> +
>   /* This function is specific for elf program because we don't need to allocate
>    * all the rom. We just allocate the first part and the rest is just zeros. This
>    * is why romsize and datasize are different. Also, this function takes its own
> @@ -1220,6 +1227,7 @@ ssize_t rom_add_option(const char *file, int32_t bootindex)
>   static void rom_reset(void *unused)
>   {
>       Rom *rom;
> +    RomLoaderNotify notify;
>   
>       QTAILQ_FOREACH(rom, &roms, next) {
>           if (rom->fw_file) {
> @@ -1268,6 +1276,13 @@ static void rom_reset(void *unused)
>           cpu_flush_icache_range(rom->addr, rom->datasize);
>   
>           trace_loader_write_rom(rom->name, rom->addr, rom->datasize, rom->isrom);
> +
> +        notify = (RomLoaderNotify) {
> +            .addr = rom->addr,
> +            .len = rom->datasize,
> +            .max_len = rom->romsize,
> +        };
> +        notifier_list_notify(&rom_loader_notifier, &notify);
>       }
>   }
>   


