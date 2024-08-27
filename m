Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D014CC54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 16:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siybl-000189-IP; Tue, 27 Aug 2024 11:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1siybk-00017g-Tu
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 11:59:48 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1siybj-0005xR-0j
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 11:59:48 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-202089e57d8so36153255ad.0
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 08:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724774385; x=1725379185; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KfK7CjE0af+i2PvWXnfYzZz3lvaa3Aq71jeF4wdeUVQ=;
 b=OtyvJV75Qcn+eLmu/EAz4kusf7BpLcqYb+zaGrACsgomkKre0Nu6kqzOMUKeDI159R
 P/iaWdrwhLYusGHEeAL9B+msd4V8BQnG/DFA7oGwYM1Pj9NQE4pN8J0XVBMbMiG+MZyf
 cgk5ie3LVs+aEkXw9oyhJZuTEVhSZdQtxPX4dVBrLKYGeeunz7kM7tBqxAczsdGcIEaY
 ZtvJHvdq7nx7SjKPWZN6Vnt7+nhG/Eq8dBYtcQXQpIIdmrHl/Z3w4gu6oZy8TtWzxtd3
 k/4BjRbWMNU/tjKgJ48Kht8WkscmkZKY43tTg7Utyo9pJ5dytGf+5iLlBsYV08hrMU7W
 Px1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724774385; x=1725379185;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KfK7CjE0af+i2PvWXnfYzZz3lvaa3Aq71jeF4wdeUVQ=;
 b=GTta0jQq18QgH4JsFJFyQUCaBtO68j1EtD9Jtc/TsfDpDonBiBYJykwZKzeibZhkWU
 xZz5rRzZ9jM2/FbH4HJWGMn71ASLjsEbcvgUKDWW0wbceTSgmgXiDhLk89ICWVezr01r
 yOBxLxtHXCEEXGUHUNcRm5Z5xrLN3+iUnnIOVM1c2Bm0zvIvBMBIHH/Rtiw2IM7CxAFR
 cR2j+sE0OxRELZBqpX7de04uEJbzHgdNeh1G618/rsCqri0xxV6fTrG7GgzzdeAQry/x
 MGi1y+WmSUY0FE8xuOoxTPpzoCZn1GRNG1+2SXKAgSIFAZvz7xSLc8oatO47egkHI5eO
 bJlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDzzX+GmrKE90ffUgREWkdMtTTfCj4mm0Lcin+XRewyCQ9cnp9DZDusKgQKjQsWjENJmdN7000BaFZ@nongnu.org
X-Gm-Message-State: AOJu0YxAyuovKf0LT1ckuwActzS97eXJTEFmsaYACanAGkBIab5lQopL
 aA3OHKZz4d6kw4X5ElyDXW2sU18XnQHXo2hgwrlWXfwx11y+yKaVV7bC6Gwk99SV/zFzHL6KDFq
 79s0ycw==
X-Google-Smtp-Source: AGHT+IHRt5e5q0rubROVCLC67RuoZRDNbZXY5uVkzUT7sgT0XaZchWzrGbWtMQ9EeVAYtTHKgIJuRQ==
X-Received: by 2002:a17:903:120d:b0:1fd:7ff5:c673 with SMTP id
 d9443c01a7336-204ddcaee55mr59376065ad.2.1724774385012; 
 Tue, 27 Aug 2024 08:59:45 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00:5b09:8db7:b002:cf61?
 ([2604:3d08:9384:1d00:5b09:8db7:b002:cf61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2038556544esm84981455ad.44.2024.08.27.08.59.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Aug 2024 08:59:44 -0700 (PDT)
Message-ID: <1593cf8c-d46d-43cc-afb4-b532598e96f5@linaro.org>
Date: Tue, 27 Aug 2024 08:59:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] plugins: add plugin API to read guest memory
Content-Language: en-US
To: Rowan Hart <rowanbhart@gmail.com>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20240827021847.218390-1-rowanbhart@gmail.com>
 <20240827021847.218390-2-rowanbhart@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240827021847.218390-2-rowanbhart@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/26/24 19:18, Rowan Hart wrote:
> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
> ---
>   include/qemu/qemu-plugin.h   | 32 +++++++++++++++++++++++++++++++-
>   plugins/api.c                | 20 ++++++++++++++++++++
>   plugins/qemu-plugins.symbols |  1 +
>   3 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index c71c705b69..10f9db8cdc 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -57,11 +57,19 @@ typedef uint64_t qemu_plugin_id_t;
>    * - Remove qemu_plugin_register_vcpu_{tb, insn, mem}_exec_inline.
>    *   Those functions are replaced by *_per_vcpu variants, which guarantee
>    *   thread-safety for operations.
> + *
> + * version 3:
> + * - modified arguments and return value of qemu_plugin_insn_data to copy
> + *   the data into a user-provided buffer instead of returning a pointer
> + *   to the data.
> + *
> + * version 4:
> + * - added qemu_plugin_read_memory_vaddr
>    */
>   
>   extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
>   
> -#define QEMU_PLUGIN_VERSION 3
> +#define QEMU_PLUGIN_VERSION 4
>   
>   /**
>    * struct qemu_info_t - system information for plugins
> @@ -852,6 +860,28 @@ typedef struct {
>   QEMU_PLUGIN_API
>   GArray *qemu_plugin_get_registers(void);
>   
> +/**
> + * qemu_plugin_read_memory_vaddr() - read from memory using a virtual address
> + *
> + * @addr: A virtual address to read from
> + * @data: A byte array to store data into
> + * @len: The number of bytes to read, starting from @addr
> +

Missing '*' on this line, generating an error when building doc.

> + * @len bytes of data is read starting at @addr and stored into @data. If @data
> + * is not large enough to hold @len bytes, it will be expanded to the necessary
> + * size, reallocating if necessary. @len must be greater than 0.
> + *
> + * This function does not ensure writes are flushed prior to reading, so
> + * callers should take care when calling this function in plugin callbacks to
> + * avoid attempting to read data which may not yet be written and should use
> + * the memory callback API instead.
> + *
> + * Returns true on success and false on failure.
> + */
> +QEMU_PLUGIN_API
> +bool qemu_plugin_read_memory_vaddr(uint64_t addr,
> +                                          GByteArray *data, size_t len);
> +
>   /**
>    * qemu_plugin_read_register() - read register for current vCPU
>    *
> diff --git a/plugins/api.c b/plugins/api.c
> index 2ff13d09de..cb7d818918 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -527,6 +527,26 @@ GArray *qemu_plugin_get_registers(void)
>       return create_register_handles(regs);
>   }
>   
> +bool qemu_plugin_read_memory_vaddr(vaddr addr, GByteArray *data, size_t len)
> +{
> +    g_assert(current_cpu);
> +
> +    if (len == 0) {
> +        return false;
> +    }
> +
> +    g_byte_array_set_size(data, len);
> +
> +    int result = cpu_memory_rw_debug(current_cpu, addr, data->data,
> +                                data->len, 0);
> +
> +    if (result < 0) {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>   int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
>   {
>       g_assert(current_cpu);
> diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
> index ca773d8d9f..3ad479a924 100644
> --- a/plugins/qemu-plugins.symbols
> +++ b/plugins/qemu-plugins.symbols
> @@ -20,6 +20,7 @@
>     qemu_plugin_num_vcpus;
>     qemu_plugin_outs;
>     qemu_plugin_path_to_binary;
> +  qemu_plugin_read_memory_vaddr;
>     qemu_plugin_read_register;
>     qemu_plugin_register_atexit_cb;
>     qemu_plugin_register_flush_cb;

Otherwise,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

@Rowan, for v3, you can add this "Reviewed-by: ..." line in your commit 
message, so it shows it was reviewed.

