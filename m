Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273F0C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 07:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti6zA-0001iH-5w; Wed, 12 Feb 2025 02:16:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ti6z6-0001hB-DF
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 02:16:36 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ti6z0-0000gl-TS
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 02:16:32 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4395a917f33so1268125e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 23:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739344589; x=1739949389; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qrgu9hs9c3G8jzMx4VuGJDs3pr2q3fx2Xzhva7/JQuo=;
 b=O6bPCCFt/mSF+kGUawlRzf6bBuyaatxhpym7Tv1sl57iyDtVc5NVGvEXkwp9IV3FdS
 CeT+q/oTNfAQiAGTwUTnnkG74K1c6u44FC9EZDJaj8LJp4mvusWyiiv4hClzMZjp0R7D
 WqmfpoAibwZT3mVixIBC4HdUTk+4NbLNKY333kFZAfJ6ZN7Qjf7/8l/NNfA589xHrbpw
 nKCXGCd3gzGRIqwJX96Tlso+Ak0U5WiwbtPTbyInvULLKUZywhzLXIUmSQkbk+p3bVhF
 WSK3fLLKMagB4SUjw8NmTquK1g17gICLbBFBecl16/sd+XNKs/Bop94gFfBkh7ygTkad
 r5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739344589; x=1739949389;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qrgu9hs9c3G8jzMx4VuGJDs3pr2q3fx2Xzhva7/JQuo=;
 b=ijXt8hg9b5f3o99rlNwHuK/+EX8JfWRZqxnKP832Y8pWWQ6WTAxw6+kRbWkRQx1bwZ
 k9WgaOY40b3O5OVpZrKu3NfJIL9qZGvm4CGlKvEEkGida5HEFdf+IEkJoxJRo/RmYPln
 OlQ+GYODVUScFSGR9yTrCxm/nWKr1eKCfANrCP0+Dvl/eBoekBXc1BqR1OSS4YARX5GU
 3uFj+IrHvLRnyz+IYcb37zb8ULc4QgVQ+hLAyqfkbr2r/9KLtiio2v6hQIhehP1HRC/0
 XW9U4F2wm8YD8B8N8djJLI9ViPzmr8jfxFvQzEWw0F0rcrr1MmmV6ePTvIGkS+PNsFg0
 XQyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAytLsjb9GZxXB3/eQSRBRvrt565AJcFmkeq6ifl4G68rKUQaoWnD+lvuUo/w9hAaXklhpLLBkNQr1@nongnu.org
X-Gm-Message-State: AOJu0YxTPyZ/+OtDSB+3NSn2v5fGwDmTX3dAsbmR4LJzraYUzvecWRSA
 nkZ2x6ref2aP2qD9SfSdSaSniUnLkPKTC6QMbOZZHJcfBB8Q+9w37T0JeIIQTOM=
X-Gm-Gg: ASbGnctKIqfEKy2rVU6W2+sT+soTJLgxlqHRK7wlB5cdNw2Htp0A32DIkPv3YJ2pD5I
 dgQTKpuYkd36/xuoQdcBdu1/R8tf1uE1PUILqF3sJw2XDEscxUBmMAgu8bwAcTNvtFp9DU+aOb0
 782BxE5uWvoGkyJO417GYfdotJwCjE1d/mdTA6PfFsNYh3rb9QMZyIgUv84W5KVSNdcI4tzX7Up
 TWCFgrD/vFF17J8vpIJMPnow+jw6M6d86hmgAk1hwlgvRM25eAlRj2qixgbWg2R2T5+fxR6Hr1U
 ijD791AQPN1ORl4ZGbU7rlzTeJH8tEBQoRgktrlh1KHzoQHC8mR66CJ3VPY=
X-Google-Smtp-Source: AGHT+IH9mCvkldw+9KgenCT0DgajJSoOMlG6ZRNE74TK/S9Idw+CIcsJFEs2hfqDtDBYEfvQRiNugg==
X-Received: by 2002:a05:600c:5246:b0:439:3159:c33d with SMTP id
 5b1f17b1804b1-439583d13b4mr14519305e9.13.1739344589058; 
 Tue, 11 Feb 2025 23:16:29 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a055e02sm10905155e9.15.2025.02.11.23.16.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2025 23:16:28 -0800 (PST)
Message-ID: <0a82687d-08e4-4db8-a7c4-ac7a2faa97b6@linaro.org>
Date: Wed, 12 Feb 2025 08:16:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] plugins: Fix qemu_plugin_read_memory_vaddr
 parameters
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Rowan Hart <rowanbhart@gmail.com>
References: <20250205040341.2056361-1-richard.henderson@linaro.org>
 <20250205040341.2056361-9-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250205040341.2056361-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 5/2/25 05:03, Richard Henderson wrote:
> The declaration uses uint64_t for addr.
> 

Fixes: 595cd9ce2ec ("plugins: add plugin API to read guest memory")

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   plugins/api.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/plugins/api.c b/plugins/api.c
> index 4110cfaa23..cf8cdf076a 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -561,7 +561,7 @@ GArray *qemu_plugin_get_registers(void)
>       return create_register_handles(regs);
>   }
>   
> -bool qemu_plugin_read_memory_vaddr(vaddr addr, GByteArray *data, size_t len)
> +bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
>   {
>       g_assert(current_cpu);
>   

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


