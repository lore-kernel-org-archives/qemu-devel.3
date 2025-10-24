Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F18CCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 10:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCEpa-0001PQ-II; Fri, 24 Oct 2025 06:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCEpZ-0001P5-CZ
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 06:15:33 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCEpX-0002Qs-Dp
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 06:15:33 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so18556175e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 03:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761300929; x=1761905729; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ABUJa2GyE3kMHWJoD9/FpOutFXSfDUQQndczWNfxGsw=;
 b=Woenkn+w8xtJFwBPAwEW+UQ0m4QzCUgwS9lq/iOs1oEPTbrlY1dUKDBOlkj4+2sJS8
 5wBsRAkZcqxMlzqupzU7XtP4GqeJLVHpojCvlP4uXou/phmUXHgfvhyLHIsLoYZg3fq1
 oHTZixQUbrX5KyedVKEhQ4S3R/kt/Zce2bnnS9zN/RRbr/KtPRhKP+w3slagU2Xrkl6U
 zSHQIAOgFIsklXm4XtmwoaAVf+Q5Nag9c6+hmCxhue1UF54Ac4V1GIKdfu00nfI04iUZ
 NF4aXyPiFyDqK1v81OSdu0Q5k+pDMAbp/Cgn9JsTLD0eVv9AKFBnH3Ze5Ynog96pLDAN
 cLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761300929; x=1761905729;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ABUJa2GyE3kMHWJoD9/FpOutFXSfDUQQndczWNfxGsw=;
 b=oTKfeUm4486OQzBjdfabGNKlmweH/7rKMyIEQCQmqyaxb6vG/lOfH6j/c/9KL+pl4k
 y9WDTG/P+zDE9ChNW4IDJtR/H9nHHQC3SM3vK9C3akgaM2qnMhXM4MRKuoqhxbk6wD5f
 kkOGW/5RW4BQxtK+U9yC7CGoH1MPKu1WNrjmqmcDJIHObIOKMSMt2GyVZzAb7Ig69NCC
 tdfkJsoR2GcN3Eg9+SnFQ5FUwFXe7oWK57fI2rimEsg4cQN1yPDV/8lv9BVRzbHdRK+9
 +T1FqcgWP1WFM4DQI4PQ+stSif5hm9AHuXj01UUCPCUIs+rtwb265o/YUEN4x4Xqmx7I
 ZgoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYCX/qwzT0s9pl4BFecIURVN0VaYHIB2lqdSowMD9PowRbjx98llDVaujE6ibIeVZXPjd3nA8rfie6@nongnu.org
X-Gm-Message-State: AOJu0YxjhNSUXPGWX6HZp8FzVXXM68RQAtovgp2IUslvuMFEh3tSVCIt
 MOq8COs4Dsb/RZGRF2ArUIh8EciTEmqiZBn3eJa+V8p9i3XBJPWlO+0mYNlT2SJrp3M=
X-Gm-Gg: ASbGncs3gO/ASUBo4x5Qq5mDwZ9prGtsfMst8DkubOIqlIDjMH8P6e9RHqYfRbsP6Br
 rE5DFyjpzQmLSaTETjREhK8sFhlCVe4QzcqSSVw8D2HMTekZdDiGbukEyh2q3F+gaViwMNdz/xn
 K0wJOqnSm5ucVdojmi6wFlcenFd+d8X2i85QeZ68vmAYpWBLOmrWQAEHkMaXmgBX+nsEdUdW4mP
 zJxE6N/lCVWNmKBy8YP+EQNF3LdrCEOdk3gqv/ttFp4WuLcuFVIipoeBPYGvDz1TukMtxkp8RWa
 lBbspiQ+BgBQIupiyR8jlMjHpNN0uMQ2Sjb3HWexY9lOy1L4+fkrYJF1fsR9+WBPudrV/6FQQru
 5uXJRe3Ez8pEiSQJERbVnoz/6k4/tLtONoftWbMITB+Fu/5zGueD9wZfhQqOxaEEinZ7i7Wzy4D
 PvOsK0vMg30pl+sDBiQ63T6mufWIjapQ9cuypNcUPz7ZKt5Cl1gchj4g==
X-Google-Smtp-Source: AGHT+IGFfqB3NKrrkh/7mohrbyX1Fa1AzLb7COo/uXx9SF6QPi9uUs1QlLQjmoC9VdY49zY9aaeh8w==
X-Received: by 2002:a05:600c:468d:b0:45f:28d2:bd38 with SMTP id
 5b1f17b1804b1-471178b14acmr206929445e9.18.1761300929293; 
 Fri, 24 Oct 2025 03:15:29 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47496be2eb6sm83395175e9.2.2025.10.24.03.15.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Oct 2025 03:15:28 -0700 (PDT)
Message-ID: <051e07c7-715e-4797-89b9-af1faa1a4183@linaro.org>
Date: Fri, 24 Oct 2025 12:15:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 5/6] core: Pass errp to load_image_targphys_as()
Content-Language: en-US
To: Vishal Chourasia <vishalc@linux.ibm.com>, adityag@linux.ibm.com,
 harshpb@linux.ibm.com, milesg@linux.ibm.com, npiggin@gmail.com,
 peter.maydell@linaro.org, alistair23@gmail.com, balaton@eik.bme.hu,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, berrange@redhat.com
References: <20251024092616.1893092-2-vishalc@linux.ibm.com>
 <20251024092616.1893092-8-vishalc@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251024092616.1893092-8-vishalc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 24/10/25 11:26, Vishal Chourasia wrote:
> Pass errp to load_image_targphys_as() in generic-loader and
> guest-loader to capture detailed error information from the
> loader functions.
> 
> Use error_prepend() instead of error_setg() to preserve the
> underlying error details while adding context about which image
> failed to load.
> 
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
>   hw/core/generic-loader.c | 7 ++++---
>   hw/core/guest-loader.c   | 7 ++++---
>   2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
> index 6689847c33..35d4e5f4ea 100644
> --- a/hw/core/generic-loader.c
> +++ b/hw/core/generic-loader.c
> @@ -60,6 +60,7 @@ static void generic_loader_reset(void *opaque)
>   
>   static void generic_loader_realize(DeviceState *dev, Error **errp)
>   {
> +    ERRP_GUARD();
>       GenericLoaderState *s = GENERIC_LOADER(dev);
>       hwaddr entry;
>       ssize_t size = 0;
> @@ -149,13 +150,13 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
>           if (size < 0 || s->force_raw) {
>               /* Default to the maximum size being the machine's ram size */
>               size = load_image_targphys_as(s->file, s->addr,
> -                    current_machine->ram_size, as, NULL);
> +                    current_machine->ram_size, as, errp);
>           } else {
>               s->addr = entry;
>           }
>   
> -        if (size < 0) {
> -            error_setg(errp, "Cannot load specified image %s", s->file);
> +        if (*errp) {

Again I'd keep the 'if (size < 0)' check to avoid *errp.

> +            error_prepend(errp, "Cannot load specified image %s: ", s->file);
>               return;
>           }
>       }
> diff --git a/hw/core/guest-loader.c b/hw/core/guest-loader.c
> index 59f325ad9c..dcbe8e4520 100644
> --- a/hw/core/guest-loader.c
> +++ b/hw/core/guest-loader.c
> @@ -81,6 +81,7 @@ static void loader_insert_platform_data(GuestLoaderState *s, int size,
>   
>   static void guest_loader_realize(DeviceState *dev, Error **errp)
>   {
> +    ERRP_GUARD();
>       GuestLoaderState *s = GUEST_LOADER(dev);
>       char *file = s->kernel ? s->kernel : s->initrd;
>       int size = 0;
> @@ -101,9 +102,9 @@ static void guest_loader_realize(DeviceState *dev, Error **errp)
>   
>       /* Default to the maximum size being the machine's ram size */
>       size = load_image_targphys_as(file, s->addr, current_machine->ram_size,
> -                                  NULL, NULL);
> -    if (size < 0) {
> -        error_setg(errp, "Cannot load specified image %s", file);
> +                                  NULL, errp);
> +    if (*errp) {

Ditto, otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +        error_prepend(errp, "Cannot load specified image %s: ", file);
>           return;
>       }
>   


