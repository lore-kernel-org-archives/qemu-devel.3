Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D27E6F075
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 18:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6wE8-0005tq-9s; Fri, 01 Nov 2024 14:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6wE6-0005tV-UL
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 14:18:26 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6wE4-0005AM-NE
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 14:18:26 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2e2ed59a35eso1801616a91.0
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 11:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730485102; x=1731089902; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EHALLruCPYNcR7crLmfNk0HOaV84UIms6V7q6OHvPwk=;
 b=BwFkxbyLtQQwALeChRzSp5g7YJdDrxhwGZMpd6MXNlQTi2lvoll/uwzuo/LwXiNtkj
 QTXsRpzcGeaNPATSV4tQb5I/0TxlqXMUAF+iw4qoWS+8jvowfx5q/KeQSJpGYh0hu2ke
 kjHBmgneIcKV0ykv//fSQma2/eVb+mVUfTXQvHGgrp4xYKN8DEoQgD7ZPyHA/0o+v/XS
 wwW7f5LKVuZGv/uOdwEk3JSsGHFkFlp05xcDnPLywnyLNTDiCgVa4CtQYN2cNMgGSc5H
 AnXhJ3y3eeeh1YaYjZ5bADccVDzCsSEJqEr8qnCqB3cq8GeyTt2U2E56oPFRZAup8RYp
 WBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730485102; x=1731089902;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EHALLruCPYNcR7crLmfNk0HOaV84UIms6V7q6OHvPwk=;
 b=tTzqK6GKmxrJNblS0jz4GatUflLLvBgzRoWy7EV919GvhHJnKVkf3qFcr+A8bCK/Ph
 LuN5/mlE1WQ9xzx4kWyJU3FKuj3lXmC4LAoLIrTEC1HpW5TUwmlqr8L3sK39++AM4Dlt
 qdl3ILWlyFVMrVHPgduRbn2aC/KQFYjZtZ525xLR1XkdjstLHS1R/o1pkUp+isKO126W
 00HTWP6rLkZ0GVBr46G/WOix0gMbIwbGkC5NJivueb83ntxV89RaMGn57uNqQyNyBfFA
 6oNOeSXTprynW4B0njD7eAfZEG1s896c+EdbP4UODXJ3u5kK4kl6mjNo4Omo9+oWXRYt
 RSLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl4jvtHHEDzvv0SxJcL7I8m/TfkYpZZlXxeyCJdCViYouwYuy94WX64VHD1W3LqEkuG+t9Zepq+pzJ@nongnu.org
X-Gm-Message-State: AOJu0Yzapk/WQ7FBf324PwwUb7konNXaxEQi6Gq8RUMJUKSw7Q8Mnwq/
 Q+96BuWKHCu7v9zOlq28h/UAYUf/dKk1sHrhwt1K9NQzE1ZH5ap7vflxytfBOgU=
X-Google-Smtp-Source: AGHT+IGRsMXyq1rTcIC60xphH0vpO8XLKX2sheCLjkpgAmfZsI7V3WzNP7ajj+7BJ42FSwppwrLpdw==
X-Received: by 2002:a17:90a:b30e:b0:2e2:daab:cc69 with SMTP id
 98e67ed59e1d1-2e8f105e941mr24119775a91.12.1730485101793; 
 Fri, 01 Nov 2024 11:18:21 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e93db17b19sm2981861a91.38.2024.11.01.11.18.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Nov 2024 11:18:21 -0700 (PDT)
Message-ID: <497a69fe-e792-45c6-a629-f4872d86322a@linaro.org>
Date: Fri, 1 Nov 2024 11:18:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: add plugin API to get args passed to binary
Content-Language: en-US
To: "demin.han" <demin.han@starfivetech.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, erdnaxe@crans.org, ma.mandourr@gmail.com
References: <20241101090032.1413255-1-demin.han@starfivetech.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241101090032.1413255-1-demin.han@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

Hi Demin,

thanks for your contribution.

On 11/1/24 02:00, demin.han wrote:
> Why we need args?
> When plugin outputs log files, only binary path can't distinguish multiple
> runs if the binary passed with different args.
> This is bad for CI using plugin.
>

Can it be solved simply by encoding this in name of log file from the CI 
run script?
$ cmd="/usr/bin/echo Hello world"
$ out_file="$(echo "$cmd" | sed -e 's/\s/_/').log"
$ qemu -plugin... -d plugin -D "$out_file" $cmd

I can see some good points to add this new API, but for the use case 
presented in commit message, I'm not sure to see what it solves.

> Signed-off-by: demin.han <demin.han@starfivetech.com>
> ---
>   include/qemu/qemu-plugin.h   | 11 +++++++++++
>   plugins/api.c                | 16 ++++++++++++++++
>   plugins/qemu-plugins.symbols |  1 +
>   3 files changed, 28 insertions(+)
> 
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index 622c9a0232..daf75c9f5a 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -837,6 +837,17 @@ bool qemu_plugin_bool_parse(const char *name, const char *val, bool *ret);
>   QEMU_PLUGIN_API
>   const char *qemu_plugin_path_to_binary(void);
>   
> +/**
> + * qemu_plugin_argv_to_binary() - argv to binary file being executed
> + *
> + * Return a string array representing the argv to the binary. For user-mode
> + * this is the main executable's argv. For system emulation we currently
> + * return NULL. The user should g_free() the string array once no longer
> + * needed.
> + */
> +QEMU_PLUGIN_API
> +const char **qemu_plugin_argv_to_binary(void);
> +
>   /**
>    * qemu_plugin_start_code() - returns start of text segment
>    *
> diff --git a/plugins/api.c b/plugins/api.c
> index 24ea64e2de..fa2735db03 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -485,6 +485,22 @@ const char *qemu_plugin_path_to_binary(void)
>       return path;
>   }
>   
> +const char **qemu_plugin_argv_to_binary(void)
> +{
> +    const char **argv = NULL;
> +#ifdef CONFIG_USER_ONLY
> +    int i, argc;
> +    TaskState *ts = get_task_state(current_cpu);
> +    argc = ts->bprm->argc;
> +    argv = g_malloc(sizeof(char *) * (argc + 1));
> +    for (i = 0; i < argc; ++i) {
> +        argv[i] = g_strdup(ts->bprm->argv[i]);
> +    }
> +    argv[argc] = NULL;
> +#endif
> +    return argv;
> +}
> +
>   uint64_t qemu_plugin_start_code(void)
>   {
>       uint64_t start = 0;
> diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
> index 032661f9ea..532582effe 100644
> --- a/plugins/qemu-plugins.symbols
> +++ b/plugins/qemu-plugins.symbols
> @@ -1,4 +1,5 @@
>   {
> +  qemu_plugin_argv_to_binary;
>     qemu_plugin_bool_parse;
>     qemu_plugin_end_code;
>     qemu_plugin_entry_code;

Regards,
Pierrick

