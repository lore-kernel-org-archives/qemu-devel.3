Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2079CCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 10:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCEmU-0008Pu-Je; Fri, 24 Oct 2025 06:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCEmT-0008Pd-LI
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 06:12:21 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCEmR-0001rV-NZ
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 06:12:21 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4710665e7deso9041715e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 03:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761300737; x=1761905537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PshoiaMyHo7Oub4BjijO08HeN/GWrXAlXLoGyR6sehQ=;
 b=mfZYjohl953digfsoCNdd2vCjsO7aDHMxufoXw5DFuOc38ktOUfNg+dfp9fiI4AJmF
 5E97XJFiC4c7tsAPord11c3MVZi7HdSgjtIwPOiuGu+s7U6YnAmmsa9CozHAGpw0ONrE
 +ZCIVcoKSd5UZDf/v/vyUigk2OpyxVDGNG1LdG90HfppL6+cgSyxaArTnx2oO+dUwgSj
 jR0LSoKqOUPosDlPJ07TNBsO+tqd2TVQ+6HJDbYhHWnopLYQVPVDuNA7ObhUesjm0NeJ
 T41QGdPY3tAWCFuo114L8LwyiUTeRUQ5OV5cwz91jrU6RXIPo0gzT3QZPaglDQDwm7ux
 vHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761300737; x=1761905537;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PshoiaMyHo7Oub4BjijO08HeN/GWrXAlXLoGyR6sehQ=;
 b=gLpNmSM9asxpmJl1lxDudwZYjIs0APsGkOt57MXXFIg422XdvfKPuFR4yAYupLU8lX
 0/BTgDjOl2ZD8UIstmQHIL79OOCBc72tA2DUPHXHjrGqXIpboAoOk4vV1/0/WSAXpgPM
 2O9dVZw/69GUZC5ZdieKB99HNckzIeIRYXm7tOfGtPFZz2mxmAEN8ZPx+qwT+ZN9kmJ9
 raT06IoJiet0JldJOdS5th1n3pCmA3we7mt6N3dG+h3MBmcji5MTXQO9EPioU6Rukike
 ugNPCEHKHdCQHkSNPGVUMNM3YJxBM5w7PSF97+zdi4MNFr6zH+tUVxUGsznN3P6lK5hm
 Ly0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzZ3Nsd4pvLQVTZ20O8VTxdvY0lqAVngHPk9+yPuIKZKjAhl7UJO7ykq85pQkA2w98byjq8Dydoecq@nongnu.org
X-Gm-Message-State: AOJu0YxzvyUO+omgIWd+N0VCYtWtufR24JQVi6gNODSvnz3HI5EybrDs
 gHfeabvw9OJ/+DdL9IMyRsun/9JfVyEPWy8AyZesiGTog32XU0atyzCZ/xnktEiZoyU=
X-Gm-Gg: ASbGncvDsG6TjYTrRJ7Gyg4zVH1QeYaIwKzG76dwmQ/OX5NR96E04s2WCyvJEcx5BF5
 6gqySpc3upZi8zkaj09biMVgiB8WN3IYGI52y1WZjoc6x6b+kkKUteTvExnoxH5TsZ7CJW7PDce
 FA3VmkeHrUM70jKhuXIzgtB3+i/7BnRkrNKraR+WarvO8yOynwdx8dFPV+xULhSL6lZgYF2nK42
 0gCz4ugyIOhPEQKlDdX62cKjvMsBcXG7bRtBFQEN5lhJqm0lri1jgVY5L3mFCXlv+mgrd4TN7pW
 y9sMmKKBe7liGGhzWPV4zwIVK+KVBGHyhOcxw4iARStJ3lOAZTDBlJbRDfLQI6qd2MPnH6nyYRv
 Dj7+2iE8M7blh3o6b3xIQ1XR0fW3LC3vxwBRaG93sJqO4fRmt2BBTAXotH3pGpoyZ62gB+YS4IT
 trbPwDrHp+KnOxNMdRuDWLM8fy9UzwJOTjxn+18OAy5HEOebioYBkYuQ==
X-Google-Smtp-Source: AGHT+IGUUUSupAZOF6lx4+rxTB4jGtORcLvjkfeEXtMxqobSXO6ZMlHfHa18F5qJXx9ZWA5nHSfQyA==
X-Received: by 2002:a05:600c:138c:b0:471:3b5:aeac with SMTP id
 5b1f17b1804b1-475cafae52bmr37428105e9.15.1761300736739; 
 Fri, 24 Oct 2025 03:12:16 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429897e75a0sm8770601f8f.5.2025.10.24.03.12.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Oct 2025 03:12:16 -0700 (PDT)
Message-ID: <3153671f-9984-4687-9561-bfcfa8e97ed1@linaro.org>
Date: Fri, 24 Oct 2025 12:12:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 3/6] core/loader: improve error handling in image
 loading functions
Content-Language: en-US
To: Vishal Chourasia <vishalc@linux.ibm.com>, adityag@linux.ibm.com,
 harshpb@linux.ibm.com, milesg@linux.ibm.com, npiggin@gmail.com,
 peter.maydell@linaro.org, alistair23@gmail.com, balaton@eik.bme.hu,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, berrange@redhat.com
References: <20251024092616.1893092-2-vishalc@linux.ibm.com>
 <20251024092616.1893092-6-vishalc@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251024092616.1893092-6-vishalc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
> Add error checking for lseek() failure and provide better error
> messages when image loading fails, including filenames and addresses.
> 
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
>   hw/core/loader.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 7aca4989ef..48dd4e7b33 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -79,6 +79,10 @@ int64_t get_image_size(const char *filename, Error **errp)
>       if (fd < 0)
>           return -1;
>       size = lseek(fd, 0, SEEK_END);
> +    if (size < 0) {
> +        error_setg_errno(errp, errno, "lseek failure: %s", filename);
> +        return -1;
> +    }
>       close(fd);
>       return size;
>   }
> @@ -129,14 +133,24 @@ ssize_t load_image_targphys_as(const char *filename,
>                                  hwaddr addr, uint64_t max_sz, AddressSpace *as,
>                                  Error **errp)
>   {
> +    ERRP_GUARD();
>       ssize_t size;
>   
>       size = get_image_size(filename, errp);
> -    if (size < 0 || size > max_sz) {
> +    if (*errp) {

Although safe with ERRP_GUARD(), we try to avoid checking *errp as
a pattern. I'll update (no need to repost) as:

       if (size < 0) {

> +        return -1;
> +    }

        else

> +    if (size > max_sz) {
> +        error_setg(errp, "%s exceeds maximum image size (%" PRIu64 " MiB)",
> +                   filename, max_sz / MiB);
>           return -1;
>       }

         else

>       if (size > 0) {
>           if (rom_add_file_fixed_as(filename, addr, -1, as) < 0) {
> +            error_setg(errp, "could not load '%s' at %" HWADDR_PRIx,
> +                       filename, addr);
>               return -1;
>           }
>       }
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

