Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B25CCFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 12:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNVwN-0005gV-5C; Mon, 24 Nov 2025 07:45:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNVsy-00020i-Sk
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:41:42 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNVsl-000823-FS
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:41:33 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42b379cd896so2313694f8f.3
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 04:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763988083; x=1764592883; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EYCOrQiDZP9Vv9w/s7yD8AZt9n4DxqQjK5uhNiddg2E=;
 b=hb7qBFvLKwnXHc1FR5wiKo7pDi2iqno8DQgXjOymdArcy+tbUjaQzpJE9y+MkgSHpA
 DUaRVa7y8iDnncfOh898DTSY2CHX0mW6pHMD+jirU0xFZ6nDv+7WIkCZJfcTf7o1qyli
 hDGY5wy7jqrxDR+Emz/NC6mW/dsRtB8Fh8qqH2tHCJYkrUqauszSSRK/M/nnJe5TS7b9
 agyyA8pUHCHm5SAWdGw9uanXblLtnqFDZhK+QAlp6ZkqcyEuwyHheiGJI7uzTbIHb80H
 ejfniCA/SOwM6tAhmD2w33xzLeqt6eFEH3dEmzC6ZoOmf1si99XlGUHP25dANTCKj9Tv
 fwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763988083; x=1764592883;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EYCOrQiDZP9Vv9w/s7yD8AZt9n4DxqQjK5uhNiddg2E=;
 b=qla8+T7E9lyRm2xbeZnGuLh5NCvBTsBYFSGP892Apb9V6cZXdYh2YQHfiqXOmJ9zl2
 3jelC189IhNDViaOUTOUhv4wY8JvgDp/RQ/Z2umcvUlXk1Vyou2seJykoKsjiM1+FtCk
 F9DC0nZGWyc5H4qzznR1l4KKN2NHCCtqfSK24yNAw1nS0i1L8OLIbtjQYh19CVEAq1xF
 8bInc3l+v3cmNcmvAIzLpaN0aSm2Y83tAcuksQ9WLELYM5G7WT2n+23EEdaxmp9nUoQr
 tRvFQo/ffbskP2MS6jsKwYZEa5jzsJG6CEv0rlmMFTXJvGTBkt0/XsGysPzjBmqMpngo
 RgQg==
X-Gm-Message-State: AOJu0YwFG9xase5TDouAchyEhPlUh2kC8cHv7FePHYHVU1je6EV4LyyR
 bhCPMars8FKiaNNiYUJY3EY4thVCxGO7I7c8wacaawj3K0t50tKp2rAhEHmxKuS7Uk7CfeDI0Ib
 lfJRehUvEzA==
X-Gm-Gg: ASbGncvfAe8Ed/aYDYQuQoCvGdu3lUUqng+Izq1eAw89JEafFErZyuTJ2xjZTc5tNyu
 rT6lfQYRobrX4cHAx/hE6GnXKXwTqlHJFS0On1tGtbIYxybWv0ueFV4enJTfZiP5h2LMylk1RpQ
 XEztjS0wPBKcMM8KCBuR4B3pxbbkCube5dnQZTq6nTb2t8xadbDHxYWMAfFpvDtXgmr+orWOEm6
 jr70+rK28mFP1SAlMDAtxsGuZyYrVT89iRT8dt6OOWKYcnj7+tkkmRv/0PiBn2JsMyXgc7shxJI
 TX9QBEgO62KV5sejzRX0iUUpfFYAdkdltHb1GezJdW/QN3O573wml4vJphZGozMRgrnjz890Miq
 63Orkp5BiEQyv6Mq5Fs5kIN30YNKmOcWWFK6SLLn2G697e+X6wqVnukUzPXt6tPw9iBu7oxcRcW
 6XUn/kd2gCsPPyf/yvDKYYe+Z7SdNZN0Xhfpzh9khLfRO17oOplC0h8VSkcRA=
X-Google-Smtp-Source: AGHT+IEsmAuqjNdcV6OBzbSpzY/t9xa7+7wTK8sTI+sfkDK9qGjZwhoO8btDQ5PV7pRq9oHkzNV2RQ==
X-Received: by 2002:a05:6000:1acd:b0:42b:55a1:2174 with SMTP id
 ffacd0b85a97d-42cc1d23ec1mr11150383f8f.59.1763988083131; 
 Mon, 24 Nov 2025 04:41:23 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fd8d97sm27714431f8f.42.2025.11.24.04.41.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 04:41:22 -0800 (PST)
Message-ID: <6cab2ac3-358f-49ad-9a1c-81536a2ddc6e@linaro.org>
Date: Mon, 24 Nov 2025 13:41:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC-PATCH-for-11.0] loader: Add support for U-Boot
 Zstandard-compressed image
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Daan De Meyer <daan.j.demeyer@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 WANG Xuerui <git@xen0n.name>
References: <20251124122224.80830-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251124122224.80830-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 24/11/25 13:22, Philippe Mathieu-Daudé wrote:
> U-Boot is able to decompress Zstandard images since almost
> 6 years (u-boot commit 8509f22a).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20251011081553.4065883-1-daan.j.demeyer@gmail.com>

Same patch applies on Daan's v4:
Based-on: <20251124123521.1058183-1-daan.j.demeyer@gmail.com>

> ---
>   hw/core/loader.c | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index e5904cdafa1..97fa8248ce7 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -635,7 +635,7 @@ static ssize_t load_uboot_image(const char *filename, hwaddr *ep,
>       uboot_image_header_t *hdr = &h;
>       uint8_t *data = NULL;
>       int ret = -1;
> -    int do_uncompress = 0;
> +    bool do_uncompress = false;
>   
>       fd = open(filename, O_RDONLY | O_BINARY);
>       if (fd < 0)
> @@ -685,7 +685,8 @@ static ssize_t load_uboot_image(const char *filename, hwaddr *ep,
>           case IH_COMP_NONE:
>               break;
>           case IH_COMP_GZIP:
> -            do_uncompress = 1;
> +        case IH_COMP_ZSTD:
> +            do_uncompress = true;
>               break;
>           default:
>               fprintf(stderr,
> @@ -747,10 +748,23 @@ static ssize_t load_uboot_image(const char *filename, hwaddr *ep,
>           max_bytes = UBOOT_MAX_GUNZIP_BYTES;
>           data = g_malloc(max_bytes);
>   
> -        bytes = gunzip(data, max_bytes, compressed_data, hdr->ih_size);
> +        switch (hdr->ih_comp) {
> +        case IH_COMP_GZIP:
> +            bytes = gunzip(data, max_bytes, compressed_data, hdr->ih_size);
> +            break;
> +#ifdef CONFIG_ZSTD
> +        case IH_COMP_ZSTD: {
> +            size_t ret = ZSTD_decompress(data, max_bytes,
> +                                         compressed_data, hdr->ih_size);
> +            bytes = ZSTD_isError(ret) ? -1 : (ssize_t) ret;
> +            } break;
> +#endif
> +        default:
> +            g_assert_not_reached();
> +        }
>           g_free(compressed_data);
>           if (bytes < 0) {
> -            fprintf(stderr, "Unable to decompress gzipped image!\n");
> +            fprintf(stderr, "Unable to decompress image!\n");
>               goto out;
>           }
>           hdr->ih_size = bytes;


