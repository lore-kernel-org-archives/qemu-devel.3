Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E75C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 10:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thRTF-0001un-Ig; Mon, 10 Feb 2025 05:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thRTC-0001tZ-Lx
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:56:54 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thRTA-0007YL-IJ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:56:54 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so2160197f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 02:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739185010; x=1739789810; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lnTm0/EWUv4t24n6rwqJSngp3RTq2TCMT1H6F9kJzMg=;
 b=E+ko42Frnc2U35RTdiwDWeL498gmSx4Y4nC9yzVPWwxye28za2T0Nhu5HY1e9Q8Izl
 cAIxmg6jczKx289icNkfve5jYoaQ0Dr2WWJQGUe5bhhCYhzF1ESpcXJnxARnRCPB1AQ8
 FKOKM1ptT6dWPDYJeVyAP1jyc7VrV5AB84ppOatbCukJR6ngW7Zh3Hl4sXorCTGWGd5m
 fNCwKKqGuYNfxKpp2znA6pOhRx2RDOxcZSWuadL7rE0rgOKXM51NaiKo/DvY7QT+Rm5m
 3bwwMudC2ubmjoSwVqOCqYNe3t6l8m56wEvo+BImSGhHfjOWIqeDWLPD+Q/Q8QTdzotM
 9bVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739185010; x=1739789810;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lnTm0/EWUv4t24n6rwqJSngp3RTq2TCMT1H6F9kJzMg=;
 b=Wmhy6qTlPuexLBrAIR0x0awAV5Ec8z1YlkCiDqTAc6nNxRn7izV1+pX0ooxjNG7Jt8
 6kR0sIGgpEpn1XwfNWRfcj8ETFMScrR8veQ52qfgG8k5+N3SwnM8bdfI5BuFKWe6O1o7
 WtUiJBjLs0AarEah+kZXh6vGwOdZwgM5H09NgXXW6GIT+bx6uT30tp3/gBdFpF6T4i1Z
 L4BEQrhbydipr8OZdrxtqmvOD70VNvqUN7B/DE1zUQ3lCRB2zxQubOa75PAdYgba6Bd2
 AG+NVwmLxnEbJppx84AF41labYZBRx2mlXEwl56We1uf3EvVucNyHVXqp2YbXgtbUf2P
 xMfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkpmITsvgQgiSSlwt7tnVSiDnPELm9Hn9vExoc01JmA7I464b4M30Ow3I1BBoAwWZjEYmboGD4Di7E@nongnu.org
X-Gm-Message-State: AOJu0Yz+CBOCPEdS36/wt9trZ9GYrxyjG+y0hj0CqrRBh39T25k0BylE
 YjPCXRhOteblWnC8ieJJSIy08QfTjoigYzwKgAyHjeq+kfwZRy9PMPqDoEHQKS4=
X-Gm-Gg: ASbGncvK1niYUtOlGynTOOWgGMksjP/kvsO4ef+2QGG5igQm7YeZnqc/mSh3sj6GmF9
 uguuIeyFJUCSdE0ElEKg+d9Y+X69/f7g7A9LmYty9i4BOGlybLREPOSD87hQwQYnyrjd7gbieOM
 pt53MYTc+O7+UgKDHLeHMdPwkh2J7Uu2yOxG1oSeuEEw0NBUyF4q5ASVUDDVjbbMIwmd1IyVaeC
 Yb1lU/F8nIqGafV5RxyU0SHyP110fMCkGd+roWZ56+f+ZyHCNm+skYRW5ivIVXP38/G4dngfOXL
 +2K/lpfyk42nDc36etqj2C+3i/4wl2l5W2lGZ0RVe5nDGh5DfREl1PVhQ5RZM5ar
X-Google-Smtp-Source: AGHT+IFEc36926KZk3E8JRQYvXZcsKNx83Q1ldy2Mwn78rFXhbioLOhPsoMuDnol/7TNHadA6tFNUA==
X-Received: by 2002:a05:6000:1884:b0:385:e0d6:fb73 with SMTP id
 ffacd0b85a97d-38dc8dc1f92mr9343297f8f.15.1739185010210; 
 Mon, 10 Feb 2025 02:56:50 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd4c8ca52sm6295133f8f.89.2025.02.10.02.56.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 02:56:49 -0800 (PST)
Message-ID: <fd7e874a-9cb1-4b41-ad89-d9c34d9def5f@linaro.org>
Date: Mon, 10 Feb 2025 11:56:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] hw/mips/boston: Support dumpdtb monitor commands
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Aleksandar Rikalo
 <arikalo@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jia Liu <proljc@gmail.com>
References: <20250206151214.2947842-1-peter.maydell@linaro.org>
 <20250206151214.2947842-5-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250206151214.2947842-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Hi Peter,

On 6/2/25 16:12, Peter Maydell wrote:
> The boston machine doesn't set MachineState::fdt to the DTB blob that
> it has loaded or created, which means that the QMP/HMP dumpdtb
> monitor commands don't work.
> 
> Setting MachineState::fdt is easy in the non-FIT codepath: we can
> simply do so immediately before loading the DTB into guest memory.
> The FIT codepath is a bit more awkward as currently the FIT loader
> throws away the memory that the FDT was in after it loads it into
> guest memory.  So we add a void *pfdt argument to load_fit() for it
> to store the FDT pointer into.
> 
> There is some readjustment required of the pointer handling in
> loader-fit.c, so that it applies 'const' only where it should (e.g.
> the data pointer we get back from fdt_getprop() is const, because
> it's into the middle of the input FDT data, but the pointer that
> fit_load_image_alloc() should not be const, because it's freshly
> allocated memory that the caller can change if it likes).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/loader-fit.h | 21 ++++++++++++++++++---
>   hw/core/loader-fit.c    | 38 +++++++++++++++++++++-----------------
>   hw/mips/boston.c        | 11 +++++++----
>   3 files changed, 46 insertions(+), 24 deletions(-)
> 
> diff --git a/include/hw/loader-fit.h b/include/hw/loader-fit.h
> index 0832e379dc9..9a43490ed63 100644
> --- a/include/hw/loader-fit.h
> +++ b/include/hw/loader-fit.h
> @@ -30,12 +30,27 @@ struct fit_loader_match {
>   struct fit_loader {
>       const struct fit_loader_match *matches;
>       hwaddr (*addr_to_phys)(void *opaque, uint64_t addr);
> -    const void *(*fdt_filter)(void *opaque, const void *fdt,
> -                              const void *match_data, hwaddr *load_addr);
> +    void *(*fdt_filter)(void *opaque, const void *fdt,
> +                        const void *match_data, hwaddr *load_addr);
>       const void *(*kernel_filter)(void *opaque, const void *kernel,
>                                    hwaddr *load_addr, hwaddr *entry_addr);
>   };
>   
> -int load_fit(const struct fit_loader *ldr, const char *filename, void *opaque);
> +/**
> + * load_fit: load a FIT format image
> + * @ldr: structure defining board specific properties and hooks
> + * @filename: image to load
> + * @pfdt: pointer to update with address of FDT blob

It is not clear this field is optional or mandatory.

Looking at other docstrings, optional is not always precised,
and code often consider optional if not precised. Mandatory is
mentioned explicitly.

> + * @opaque: opaque value passed back to the hook functions in @ldr
> + * Returns: 0 on success, or a negative errno on failure
> + *
> + * @pfdt is used to tell the caller about the FDT blob. On return, it
> + * has been set to point to the FDT blob, and it is now the caller's
> + * responsibility to free that memory with g_free(). Usually the caller
> + * will want to pass in &machine->fdt here, to record the FDT blob for
> + * the dumpdtb option and QMP/HMP commands.
> + */
> +int load_fit(const struct fit_loader *ldr, const char *filename, void **pfdt,
> +             void *opaque);


>   static int fit_load_fdt(const struct fit_loader *ldr, const void *itb,
>                           int cfg, void *opaque, const void *match_data,
> -                        hwaddr kernel_end, Error **errp)
> +                        hwaddr kernel_end, void **pfdt, Error **errp)
>   {
>       ERRP_GUARD();
>       Error *err = NULL;
>       const char *name;
> -    const void *data;
> -    const void *load_data;
> +    void *data;
>       hwaddr load_addr;
>       int img_off;
>       size_t sz;
> @@ -194,7 +193,7 @@ static int fit_load_fdt(const struct fit_loader *ldr, const void *itb,
>           return 0;
>       }
>   
> -    load_data = data = fit_load_image_alloc(itb, name, &img_off, &sz, errp);
> +    data = fit_load_image_alloc(itb, name, &img_off, &sz, errp);
>       if (!data) {
>           error_prepend(errp, "unable to load FDT image from FIT: ");
>           return -EINVAL;
> @@ -211,19 +210,23 @@ static int fit_load_fdt(const struct fit_loader *ldr, const void *itb,
>       }
>   
>       if (ldr->fdt_filter) {
> -        load_data = ldr->fdt_filter(opaque, data, match_data, &load_addr);
> +        void *filtered_data;
> +
> +        filtered_data = ldr->fdt_filter(opaque, data, match_data, &load_addr);
> +        if (filtered_data != data) {
> +            g_free(data);
> +            data = filtered_data;
> +        }
>       }
>   
>       load_addr = ldr->addr_to_phys(opaque, load_addr);
> -    sz = fdt_totalsize(load_data);
> -    rom_add_blob_fixed(name, load_data, sz, load_addr);
> +    sz = fdt_totalsize(data);
> +    rom_add_blob_fixed(name, data, sz, load_addr);
>   
> -    ret = 0;
> +    *pfdt = data;

Here pfdt is assumed to be non-NULL, so a mandatory field.

Could you update the documentation? Otherwise consider adding
a non-NULL check.

Either ways:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +    return 0;
>   out:
>       g_free((void *) data);
> -    if (data != load_data) {
> -        g_free((void *) load_data);
> -    }
>       return ret;
>   }
>   
> @@ -259,7 +262,8 @@ out:
>       return ret;
>   }


