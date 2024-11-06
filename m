Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8661D59F56
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 17:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8k85-00089A-2W; Wed, 06 Nov 2024 12:47:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8k83-00088b-FK
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:47:39 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8k81-00071v-Pe
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:47:39 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4315df7b43fso757205e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 09:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730915256; x=1731520056; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YZ93fIKCMP7JhbMe+xz5YU8zRYunWzufrvuaSjfxrbU=;
 b=wT7azKmuxvV3vnDLLipY9O1N2c2a7jnRIiAT+50NNGwIfN6E7Tv2u2H7ckQJmL8Gd2
 vJLSIzKnXirDt5Vpkly6eLTvz/szLRoXMzc2a1CcQUcAHVjgxRPf/C8zp8ErDU0pOkkx
 jirfrQMLWWZDa4L4xO0zmXKx9W9ukjS4tRGQIt5DsFOKflCBbfgwR/o1ziJEhM6XI/cO
 sXBNBrpOO8QWQ4SPN52SgMhk2MFWC17Ex2TqjBv2rW8HuPwAt7lDO5M5NGElMIDZv1YL
 6+7Givzvya7lTka7jOM9NTAXzDUXYeRpgtH56q7NsWA89QCbCHb06cUlRFSJVJofe08H
 Yugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730915256; x=1731520056;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YZ93fIKCMP7JhbMe+xz5YU8zRYunWzufrvuaSjfxrbU=;
 b=C/kq/OsZV/TPdfiPsysE7NLP3FhGa2nOSH95Ta6BfICcrRqefwWO8J/ogyxdxMo/cH
 RUQZgHAc67Mqbt9mBveFaishCFUcCmBVrBgp7ujcjQx/IFBYJmpCAt7L1BBY5gwTAb9J
 cN8vBN6F+uIpkCqQNnNmxrC1HwWWcvmyVfTplaYlaSr8YmzDjpuMIyl3uHVrvOc/yQjW
 jdYMggB3TIvU6ROVhNAya0BZXK6x9gYlXpZ5qHiscgg0oD7Rne5muGrJgE1k7VoldOkq
 YWNM7iPjGxGSjQS3yGk+oRbtcZ5fM544YjvqRX5q2KcSt8s5JJuvISL8padruKNBUvJx
 pq9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxB32QBcFmdmzPQXK58pgiW3UGrW8Dk2Ne29saPMiymzH092DYt03bEFHrsPpDmwj9z1w+YuAUt9bB@nongnu.org
X-Gm-Message-State: AOJu0YzXXz6QaacOplTpjGho8sUCDCGLhvIIP4O560lE/9b78qHopLFa
 vzYbKWyzrdGs04wk1rLXbYgUDQF0OftC/Bpfb8p5sD/v3zgzlSmphpolOnX7WaM=
X-Google-Smtp-Source: AGHT+IHMfGixK6oBYA2sqyaV/ISNA0x2tF39s25xLltAzRjipGQIlSXRMsR5LTQNlu0dWbKYkSLErA==
X-Received: by 2002:adf:fbd2:0:b0:37d:5299:c406 with SMTP id
 ffacd0b85a97d-380611e4b44mr26394339f8f.38.1730915255620; 
 Wed, 06 Nov 2024 09:47:35 -0800 (PST)
Received: from [10.134.195.192] ([193.32.126.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7b32sm19873482f8f.18.2024.11.06.09.47.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 09:47:35 -0800 (PST)
Message-ID: <04fd0b86-4371-494e-a331-3d5d735f0d77@linaro.org>
Date: Wed, 6 Nov 2024 09:47:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eif: cope with huge section offsets
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: dorjoychy111@gmail.com
References: <20241106174241.556373-1-pbonzini@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241106174241.556373-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32d.google.com
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



On 11/6/24 09:42, Paolo Bonzini wrote:
> Check for overflow to avoid that fseek() receives a sign-extended value.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/qemu/osdep.h | 4 ++++
>   hw/core/eif.c        | 4 ++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index fe7c3c5f673..fdff07fd992 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -297,6 +297,10 @@ void QEMU_ERROR("code path is reachable")
>   #error building with G_DISABLE_ASSERT is not supported
>   #endif
>   
> +#ifndef OFF_MAX
> +#define OFF_MAX (sizeof (off_t) == 8 ? INT64_MAX : INT32_MAX)
> +#endif
> +
>   #ifndef O_LARGEFILE
>   #define O_LARGEFILE 0
>   #endif
> diff --git a/hw/core/eif.c b/hw/core/eif.c
> index 7f3b2edc9a7..cbcd80de58b 100644
> --- a/hw/core/eif.c
> +++ b/hw/core/eif.c
> @@ -115,6 +115,10 @@ static bool read_eif_header(FILE *f, EifHeader *header, uint32_t *crc,
>   
>       for (int i = 0; i < MAX_SECTIONS; ++i) {
>           header->section_offsets[i] = be64_to_cpu(header->section_offsets[i]);
> +        if (header->section_offsets[i] > OFF_MAX) {

Maybe we could add a comment that sections_offsets is unsigned, as it 
can be confusing to read value > INT_MAX without more context.

> +            error_setg(errp, "Invalid EIF image. Section offset out of bounds");
> +            return false;
> +        }
>       }
>   
>       for (int i = 0; i < MAX_SECTIONS; ++i) {

Else,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

