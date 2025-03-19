Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A42C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 00:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuhVu-0007Li-5G; Tue, 18 Mar 2025 20:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuhVs-0007LU-Ka
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:42:28 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuhVq-0005UW-Te
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:42:28 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ff80290e44so7511700a91.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 17:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742344945; x=1742949745; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pgUqM0gKRVDRs5JxOKSJyIzGjBQ3MHUXvp9FU98uwLY=;
 b=lQjDVtCKCO+dzzB+XT6p1JXvcrMP6E36TbIcOYBLr+2sni7nu3whsshn/jXWY1M8qG
 jarKB7wICwD/67GPi+T0lzsL+ysfQgZCSvFoHlVaGM4U7Hjrm0+P22dBPvAfb1xksXWb
 pAOta/6H5Doi1/sSeYv+wEGXZ7Lh+r28ktxScaeSRe4/suN+wq3OYJR+Pm3x0voa9LaS
 MwAkNd60fO+P/B2FVm3og2ZvjiRvsT4Yp47Uw8+1/hxuzZVhzk/bLroEVck5CXdv9RcY
 MaMjL+TmR7Bmt0vH2eQtDJXmAf6U0NUba3SHMCWqszKhq+nWHZiPWSJnk/V2IxEZ6h3o
 zQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742344945; x=1742949745;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pgUqM0gKRVDRs5JxOKSJyIzGjBQ3MHUXvp9FU98uwLY=;
 b=Bl42bwTCYNQslPQSA7jJJbz4YCCNCaosLOUefQ85b1uYVvTx/3j1mWAmM5wqRru8mx
 gbu2S+8Hul9ErzDwhVWwTfMtaqzs8yWmlF2r2xDfeC9EHz0BtrSYwwNR5d43Vly9jBq1
 jjxHsrhYgqANzX3FWk6dxizR69W1lVyZFGL7dMrhG+RPMk6YTQ3tBkng9hl0+jSiKnY7
 OZMerqZxdhDNzSNMenoDXAooFCa2+y4n1/NkyxrvH6x0Tw0E5FVM7GTQsJAax5PebEIt
 I7r3mNS6rT+gup7gpqVMqiXPQAe7YXkAjE1ZJ2jYvAGoHaWE1YEA0anJfE2B9cdm3WY5
 tfEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0VOmgezsQ5A9jmLexu/kYo7wBOJDpwIzKFwlvL9+htDBZxOe62peCjXEkKP+Dq8fUwvXf7qR9wsD0@nongnu.org
X-Gm-Message-State: AOJu0YzT3hCm4AJhhGop3pmiiT9iUQjWnfba03lYeYlVC5GSgUdIHuKB
 3pyMY3OVPRmrvqikkDcUZ9/XFhWdTECk95zj5L1RRZJY3IukV9DtIxKXBX0XX8M=
X-Gm-Gg: ASbGnctnAw3PZcJIukijz7nQitilz6NrdlX8076hj8p1LFP5USseFrYRCODWHMajppB
 wYUI85/exakWKIoj7DMhj2C8t6wOvb9hVVH7hiqWuhhIeM2+j3wCJ67JrbF/kgtPeI6loqE8JBk
 G6P9KTiObSHovao5YyjJb+yO1zLIeQ9a9C/yd+MpgQ3V1BqeqCpjc2EklH3iZ6tzmh/AtR0xJSf
 SC+TptcoYUXov1HGguNKdldzqaYF9l5ZTJih64KIYyYIMCx0lv37CcWciZkjdVtp30RmDj/D3Dj
 HSolGv+jGk0gM/rgsyYjwduwvq3ziqbX/fezTl2vFETMfYjgssKF/LYyxw==
X-Google-Smtp-Source: AGHT+IHr1Ze8q3eNYzd8N5GR6xpbGMWbpTvqOdUtl7wnbCN1YDz8gFWTa0cBFTOq7AjwY/dQs2ZHXg==
X-Received: by 2002:a17:90b:274e:b0:2ff:52e1:c4a1 with SMTP id
 98e67ed59e1d1-301be1f91a7mr1348483a91.24.1742344945036; 
 Tue, 18 Mar 2025 17:42:25 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf63716fsm154716a91.47.2025.03.18.17.42.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 17:42:24 -0700 (PDT)
Message-ID: <81230881-d918-4cf7-bf35-03e54e5e88d8@linaro.org>
Date: Tue, 18 Mar 2025 17:42:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 38/42] include/exec: Protect icount_enabled from
 poisoned symbols
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-39-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250318213209.2579218-39-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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

On 3/18/25 14:32, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/icount.h | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/exec/icount.h b/include/exec/icount.h
> index 4964987ae4..7a26b40084 100644
> --- a/include/exec/icount.h
> +++ b/include/exec/icount.h
> @@ -22,13 +22,21 @@ typedef enum {
>       ICOUNT_ADAPTATIVE,
>   } ICountMode;
>   
> -#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
> +#ifdef CONFIG_TCG
>   extern ICountMode use_icount;
>   #define icount_enabled() (use_icount)
>   #else
>   #define icount_enabled() ICOUNT_DISABLED
>   #endif
>   
> +/* Protect the CONFIG_USER_ONLY test vs poisoning. */
> +#if defined(COMPILING_PER_TARGET) || defined(COMPILING_SYSTEM_VS_USER)
> +# ifdef CONFIG_USER_ONLY
> +#  undef  icount_enabled
> +#  define icount_enabled() ICOUNT_DISABLED
> +# endif
> +#endif
> +
>   /*
>    * Update the icount with the executed instructions. Called by
>    * cpus-tcg vCPU thread so the main-loop can see time has moved forward.

I understand the shortcut taken here, but I'm not sure we want to start 
having specifics for COMPILING_SYSTEM_VS_USER, out of the poison file.

In this case, we can change icount_enabled() to a function, implement it 
in accel/tcg/icount-common.c (which is system only), and add a stub for 
user mode in accel/tcg/icount-user.c (or common-user/icount.c), 
returning ICOUNT_DISABLED, or 0, more simply.

