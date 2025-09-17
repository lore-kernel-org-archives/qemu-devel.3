Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D82CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 15:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uytvE-0007b7-9K; Wed, 17 Sep 2025 11:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uytvB-0007W0-6R
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 11:18:14 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uytv9-0001R7-CN
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 11:18:12 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-32ee4817c43so589997a91.0
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 08:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758122288; x=1758727088; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i9t7n8QKSWH4J102rwnBM7d98yPBkMbSSke+1UeV8x0=;
 b=VxZieQd1aqV2q8yKtfNvgu3WTS0gmMm04/KEjp7h2qg7pvJLudfcyVyHFrmlefBO9+
 4gUWK8bY5cbxeYqN3ejP9142SqqqkmF1fuJ897gJfiqsnkE/dIH0YwecHThd3DlvCHR2
 k7FfjVZsvJKSjypMO9y8gXWoEvSO6Cj/PBZUI24ZuB6DrPpEKUibek425wpMhLxjGPTf
 KXuuHHKVF0lSmUWHv/45G/PopQ+RlO5p+Kg2XuOrfd5x8DiQjyTJBppQnYnmY/mTNoVn
 AXrd+/uGPDF1D/CM2uIZTpWinXuK/cKpysQox0EDhVrpC8Fyf0YELPlXwUROLjNA2FiB
 y4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758122288; x=1758727088;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i9t7n8QKSWH4J102rwnBM7d98yPBkMbSSke+1UeV8x0=;
 b=IYLWCXoKNgzYV4qCUqFH+QWSAms2qgxx8IWKdgMO86El5H5nP2ggvUgXnts2wySXCh
 JcT9snTX4YQumES5swf7NFgCEAV9HvRnvFw4voMNNuhgYeem0+Wee1eYfZJ1mzAqQonA
 +Lb1L4lXJDSU82TPg+laT6Z/FidIUWQiQCAqrge1KDkjQkUvma4EJ9zJxX2rO/iBXOng
 ds2HYVpF9+jJ2e80r9t+2hYhVa/E//++xTES6zbEmj6yxf/+YPQ+RhjWtyxR4BVOz0Dq
 u4yGXCblJdu353DqE1+1m2rPtBFkfWq6TTHVP6vS/W2Yjgl3nn708elDWvRaonKTTG4U
 in2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVc486FPuvC3QBMPMQlFG8Q5rcBcKHRbyDaBoeTO8zVAXvBK2dxBVrqMfh4jc+1mlYFar8uAvSRJ4S@nongnu.org
X-Gm-Message-State: AOJu0Yx7R5D+nimAUbcN8SVmPn28PNZv3zL7HNa0C5yXqONDAWVyrB/F
 i2owihU7Bl/Jx6pXYVW/u3tZKj7R2l6phs4HHdxjRn6uEs19VmKXATqFcjjkDtdv1+W3wjKj254
 +h5ZM
X-Gm-Gg: ASbGncskF3x9Zny2IyWNvTP9pksU/zL4dpVLYPTyEQ7uPaWmZQCSymav8FmV6IrShh9
 B7Aaq7kgQfkt/vCWr+OAd1sotnUHIjFn+fdada8KPjzDqdtb4ZRfA6zMspsN5Uwqvm0CeSLVMbL
 sgfS4ZZJxoMofkSvJYk+gnHQihIhmVYADr2rwqeo02ctLZGI+W4Z3I1B4ku6rsLKok4QULZtaXK
 FECV73u793K6/VLXPXAiq39bTNFjDgXB4qnZo7L9nc5DsYAHf6bKga4yKnmgcAb1GLQnz18veCP
 E414tDkzA4tETxtsFSdKNeR/A2tSFEMWXp5xQ0vSWsPxiKfyoiZ56eDtAfeR/S5CmpKHWQczmR7
 T8FkIHevPFf2TgcILtg68HL89ufCNpn/gFlks
X-Google-Smtp-Source: AGHT+IGB8toCCUH/pDo9TaaXI72Y77GFJLSLnxkJg2CYARJ8T8p1JarM4w3SYpdoEjjwj4xqlNg4+g==
X-Received: by 2002:a17:90b:5448:b0:31c:39c2:b027 with SMTP id
 98e67ed59e1d1-32ee3f2e92emr3460661a91.7.1758122288238; 
 Wed, 17 Sep 2025 08:18:08 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32ed2685fc8sm2840612a91.4.2025.09.17.08.18.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 08:18:07 -0700 (PDT)
Message-ID: <73f3ad14-e9cd-4477-afdb-76fb65f5617e@linaro.org>
Date: Wed, 17 Sep 2025 08:18:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/35] hw/core/loader: Use address_space_get_path()
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
References: <20250917-qom-v1-0-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp>
 <20250917-qom-v1-2-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250917-qom-v1-2-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 9/17/25 05:56, Akihiko Odaki wrote:
> The name field of an QOM-ified AddressSpace represents a property name,
> which may not be sufficient to identify the AddressSpace. Use
> address_space_get_path() instead.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   hw/core/loader.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 524af6f14a09..1ee603f19c90 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -1258,10 +1258,10 @@ static bool roms_overlap(Rom *last_rom, Rom *this_rom)
>           last_rom->addr + last_rom->romsize > this_rom->addr;
>   }
>   
> -static const char *rom_as_name(Rom *rom)
> +static const char *rom_as_path(Rom *rom)
>   {
> -    const char *name = rom->as ? rom->as->name : NULL;
> -    return name ?: "anonymous";
> +    const char *path = rom->as ? address_space_get_path(rom->as) : NULL;
> +    return path ?: "anonymous";
>   }

You're not freeing the result of address_space_get_path.


r~

>   
>   static void rom_print_overlap_error_header(void)
> @@ -1280,7 +1280,7 @@ static void rom_print_one_overlap_error(Rom *last_rom, Rom *rom)
>   {
>       error_printf(
>           "\nThe following two regions overlap (in the %s address space):\n",
> -        rom_as_name(rom));
> +        rom_as_path(rom));
>       error_printf(
>           "  %s (addresses 0x" HWADDR_FMT_plx " - 0x" HWADDR_FMT_plx ")\n",
>           last_rom->name, last_rom->addr, last_rom->addr + last_rom->romsize);
> 


