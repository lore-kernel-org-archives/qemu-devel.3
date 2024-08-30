Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E403CA0FE8
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 19:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk7Kq-0007XI-HZ; Fri, 30 Aug 2024 15:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sk7Ko-0007W5-Va
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 15:31:03 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sk7Kn-0001pI-36
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 15:31:02 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2d3e44b4613so1668930a91.3
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 12:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725046259; x=1725651059; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SBb7+dm+rm3ph24huqG/oAT5Z3rNHDsNGEBpccGDhZU=;
 b=uR1j086rtWhIm+sgBGIELHye9bLyy8wyjcPE/mUL9Wbp9HvIiKnopT/ajofoD0sg82
 XszkAX3KWLfEM2UMQQxMa+GCdCb3TqJ+f00aJT6pu6+YCYCbhDZTQ0+6R5tTYOUYuzcV
 WED4AzlV1XahlaFo0AYOKC/odTK3Wo9D9P2wZN76qG36o4L08voCeffkLVrAER8N9IrQ
 i/l4fCbxFd6TYPuMfrXyJ02ZVooMaImnfOpTRrNQfjnBQ9nDWaLn3+AJNexaW3qjvb98
 gCYUeddpE1W1WuuTzXP5h2/DlNkhn3U26zfemcO51VFAU955CuJ9z7+4KzrIU2KQFGLl
 d1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725046259; x=1725651059;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SBb7+dm+rm3ph24huqG/oAT5Z3rNHDsNGEBpccGDhZU=;
 b=IXEuW6ii4E3x/pa8zbQFxOjEvaCijCNS2QiMBrydXa506vr50whDE77VpNYtlrIgFc
 c3o2DbuGjMkl3uSOxJ3JPAL2bBLo1Ar8DijEbhzAJ/D6KT1KXZq+udMAqHX4ooxZwsZ4
 owRVDkwzhqdNkOle7tI9Py8VoC0v1d+seSD3XuR+eKcG+fRJI/sK4V330e31VGkbgzkm
 N7gP9z8RbHnD0NXWCZNyu6iZYaVEiAK7bnse4TTGbjeG6ZWQYEvsrWJqxsSb6ixFuGPX
 97NKbVLb/2psKfjf+PDNQYG61M979RI6gcz5NOBhh3qcEwcKsez0XaB80kxk1XMhhyGa
 f3ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5/pGBGvTYieaU4dQVCr9sj3yAZCOxAFJob9XyrNVVoXAOwhZ3O09HgcNz7c8CX5Usg63hW6AXe8Ej@nongnu.org
X-Gm-Message-State: AOJu0YyG6RKtq7aia1uWySXpkt+phBcj03WrsNfSZxSIs6YgjrS1wFdd
 gMRGyQPz6FFXz2fKi5ZnuW7FmTTU7/CBlfOq9Cn1IAsmkpQvQOKbVl7LjPn1gco=
X-Google-Smtp-Source: AGHT+IEF5IAKhZonPV4j8yKT/exU8DkhvYGMdu1YzyQZe5CiU5BAMlyck/wZu5VwSUa+IJk2oBKHtQ==
X-Received: by 2002:a17:90b:180d:b0:2cf:eaec:d74c with SMTP id
 98e67ed59e1d1-2d8561af98cmr7651598a91.16.1725046259408; 
 Fri, 30 Aug 2024 12:30:59 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::27bd? ([2604:3d08:9384:1d00::27bd])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d8445e813dsm6759441a91.17.2024.08.30.12.30.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Aug 2024 12:30:59 -0700 (PDT)
Message-ID: <b2e9c814-36e2-49b6-8109-fbee788d4486@linaro.org>
Date: Fri, 30 Aug 2024 12:30:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] plugins: add API to read guest CPU memory from hwaddr
Content-Language: en-US
To: Rowan Hart <rowanbhart@gmail.com>, qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240828063224.291503-1-rowanbhart@gmail.com>
 <20240828063224.291503-2-rowanbhart@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240828063224.291503-2-rowanbhart@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

Hi Rowan,

thanks for this good complement on the virt address read function.

However, to be able to merge a new plugins API function, we must have a 
concrete usage of it, through one of the existing plugin.
What could be a good demonstration of value brought by being able to 
read a physical address?

Thanks,
Pierrick

On 8/27/24 23:32, Rowan Hart wrote:
> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
> ---
>   include/qemu/qemu-plugin.h   | 22 ++++++++++++++++++++++
>   plugins/api.c                | 17 +++++++++++++++++
>   plugins/qemu-plugins.symbols |  2 ++
>   3 files changed, 41 insertions(+)
> 
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index c71c705b69..25f39c0960 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -868,6 +868,28 @@ QEMU_PLUGIN_API
>   int qemu_plugin_read_register(struct qemu_plugin_register *handle,
>                                 GByteArray *buf);
>   
> +/**
> + * qemu_plugin_read_cpu_memory_hwaddr() - read CPU memory from hwaddr
> + *
> + * @addr: A virtual address to read from
> + * @data: A byte array to store data into
> + * @len: The number of bytes to read, starting from @addr
> + *
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
> +bool qemu_plugin_read_cpu_memory_hwaddr(uint64_t addr,
> +                                          GByteArray *data, size_t len);
> +
>   /**
>    * qemu_plugin_scoreboard_new() - alloc a new scoreboard
>    *
> diff --git a/plugins/api.c b/plugins/api.c
> index 2ff13d09de..c87bed6641 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -527,6 +527,22 @@ GArray *qemu_plugin_get_registers(void)
>       return create_register_handles(regs);
>   }
>   
> +bool qemu_plugin_read_cpu_memory_hwaddr(uint64_t addr,
> +                                        GByteArray *data, uint64_t len)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    if (len == 0) {
> +        return false;
> +    }
> +
> +    g_byte_array_set_size(data, len);
> +    cpu_physical_memory_rw(addr, (void *)data->data, len, 0);
> +    return true;
> +#else
> +    return false;
> +#endif
> +}
> +
>   int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
>   {
>       g_assert(current_cpu);
> @@ -534,6 +550,7 @@ int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
>       return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1);
>   }
>   
> +
>   struct qemu_plugin_scoreboard *qemu_plugin_scoreboard_new(size_t element_size)
>   {
>       return plugin_scoreboard_new(element_size);
> diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
> index ca773d8d9f..5d9cfd71bb 100644
> --- a/plugins/qemu-plugins.symbols
> +++ b/plugins/qemu-plugins.symbols
> @@ -20,6 +20,8 @@
>     qemu_plugin_num_vcpus;
>     qemu_plugin_outs;
>     qemu_plugin_path_to_binary;
> +  qemu_plugin_read_cpu_memory_hwaddr;
> +  qemu_plugin_read_io_memory_hwaddr;

As you mentioned, you can remove the second one for v2.

>     qemu_plugin_read_register;
>     qemu_plugin_register_atexit_cb;
>     qemu_plugin_register_flush_cb;

