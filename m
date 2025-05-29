Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD606C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 18:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKiNM-0005qm-Bm; Thu, 29 May 2025 14:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uKiNJ-0005qS-Nv
 for qemu-devel@nongnu.org; Thu, 29 May 2025 14:53:09 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uKiNI-000586-2o
 for qemu-devel@nongnu.org; Thu, 29 May 2025 14:53:09 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so1362364b3a.2
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 11:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748544786; x=1749149586; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hZlIE+M9juR8ZCSkwq/LNLmQoNQrAyJev8aoYY22RvA=;
 b=Tl/iv7DT6oC70Q2kpzzRFt5ZZrcE8ISy1Df/t7D3J2pXwYjY5K8QnxwGRAHLQyiCky
 f6Y/8RbMgkHsm1xNuWVi44mYTv2ocbU8Es2ca/OsNMVoJq7sIgftKiP9Sqx/RXlPZr27
 SEqJYXBbFG17631/iXHF3gIlBTKAWaz2OZyurR25XF4QItMbxlc5NNMj5LpSDQCPbrcD
 sevxA5Mb7tQJr6Z5BHNq7kbS377ckslmuLwrTyoTn5XmTlxx3R7nSFB6sudabZEasYlT
 zQ9Sb9uJJV21jhJbdAaZIJxm1CRjv3jj/lzyE3+vid7mdBixTSAtYyslUnUB/0Ct5Zut
 /Uog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748544786; x=1749149586;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hZlIE+M9juR8ZCSkwq/LNLmQoNQrAyJev8aoYY22RvA=;
 b=wlW7J/QaPvI1u89AGyfdv2rsasj8V+i3gBFarquw1IM9GAfOWbGKKPJ+G6w4Y+4vFt
 8p7PVst5zWcll072AH4Fz1hcab/4ot2Plh2K09RZfofJc1tfxEtJ+823jb2LfOkSOobk
 iLOE2F59Np68Qan40hs7VdDuC7HDAyBHoYhLSw1NWbqH341flWwefYKVtxtu2Ajc7kG/
 vRz7UpsHX/4Z6drZHOvAPO8qD2UUkZauXvT8XdrGaJCPOmNzNIIc05JVJJIHD3q8lTIw
 BUBM2JIMk8OngPKR57NKVsz8cG32eN4fYIKr4UXorxScakcWggULb1kXiLk/ncgSO7AB
 ql0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6b4fPaJ9bX2i3l8U30T2qyzczFgWPOFrCQx+JwK2MUpGQTqoUdAS6jGoTDCG1GzbPJlmXqLaEwDAF@nongnu.org
X-Gm-Message-State: AOJu0YzjuGjAUyvgZxRv2gja3es3h6V6GRZF4bqz6BMquO6mxzcm/ujS
 r7H4JUJ/+7r/lplAjZBhLQX5rDoq8o/P0xpTTKXtOEvdu0Y+DUMLl7mUNoUYCSl3BvI=
X-Gm-Gg: ASbGncvQ7SEAy2rjw5hfsnVLa3A2+NbNtrJfuBmH9o0FrEXVx05qGnwjmLaZZwVOTVI
 +rIwkqPu/4yrayWFbgkzhSQ6+H2KLTb13APEf6V9iziGnwpa3TIALPRaySWJTs4VJq4WEl67u57
 YHJ+XSX1e2QQ6NEFJwA68qbcVWbC/wNCoNSqIyGFOFR3cAr71WxXf8rF4rfzPHToXEJ2cRyEtnm
 lVx3vr3I3S2h+jtUCtz5EAwEzeZ6xTGNfc9GkKRHD7JB8UKVqA5bd+6c/jJNDcfCwWdxLaVjX3d
 hfXmBqm1e368wDlra3XCNyaAl1wtWTejXVA2MFJdl//GAxDyXjiyMDWIIT8JZzTA
X-Google-Smtp-Source: AGHT+IFSjrgOfdf+Vmmr19mNeM8xuShet1f+NqENZMdURWiB++zCMdzMtgs8D3iYgvCB8sEvmtYcog==
X-Received: by 2002:a05:6a00:4b54:b0:736:5e6f:295b with SMTP id
 d2e1a72fcca58-747bd97b301mr743204b3a.12.1748544786473; 
 Thu, 29 May 2025 11:53:06 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afff724fsm1702755b3a.174.2025.05.29.11.53.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 11:53:06 -0700 (PDT)
Message-ID: <8e172b99-595b-4a8c-a97b-df679784aca4@linaro.org>
Date: Thu, 29 May 2025 11:53:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] plugins: Update plugin version and add notes
Content-Language: en-US
To: Rowan Hart <rowanbhart@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250523020344.1341179-1-rowanbhart@gmail.com>
 <20250523020344.1341179-10-rowanbhart@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250523020344.1341179-10-rowanbhart@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 5/22/25 7:03 PM, Rowan Hart wrote:
> From: novafacing <rowanbhart@gmail.com>
> 
> This patch updates the plugin version to gate new APIs and adds notes
> describing what has been added.
> 
> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
> ---
>   include/qemu/qemu-plugin.h | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index 2cb5de9f64..170a79e667 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -65,11 +65,18 @@ typedef uint64_t qemu_plugin_id_t;
>    *
>    * version 4:
>    * - added qemu_plugin_read_memory_vaddr
> + *
> + * version 5:
> + * - added qemu_plugin_write_memory_vaddr
> + * - added qemu_plugin_read_memory_hwaddr
> + * - added qemu_plugin_write_memory_hwaddr
> + * - added qemu_plugin_write_register
> + * - added qemu_plugin_translate_vaddr
>    */
>   
>   extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
>   
> -#define QEMU_PLUGIN_VERSION 4
> +#define QEMU_PLUGIN_VERSION 5
>   
>   /**
>    * struct qemu_info_t - system information for plugins

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


