Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A78C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 19:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9UHH-0000wL-8V; Mon, 28 Apr 2025 15:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9UHF-0000vs-Ad
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:36:29 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9UHD-00012E-4J
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:36:28 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so7029469b3a.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 12:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745868985; x=1746473785; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tG9rtszfKpI6JIRQ6cOZyNrKxoWnVoT5lszhtLjWB/Q=;
 b=gdlrbfbILHuXz43Tt15w3KytUhRP3KbK/AnZhYdw5pgJAUuvSY9ADCJPGv/eo0J5DO
 T/wprWyOAFDEjOULN7HnKqkT4hkMrXvZ4BsExfKABlumW8pm3col/aMmv71e59Osnl4a
 dApJ/29T1/FJcyW4oHAX3SsP9L3mVNRwrfIfsEkqOmo9+vLyrYhvd4MDQ8B/sb5MTLUU
 yNkffoohkx85JM/t5dgaiaJfYt3LOJ29NDfyNSMfdALOE3KKxRLCt6yhwbg/e5Seu34i
 iarP4fNRS7/KeTkXPu3G0x5myzZtZKGIJ880x5x4vp7HO8CPIl845D/hKakhKV4muYxZ
 mqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745868985; x=1746473785;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tG9rtszfKpI6JIRQ6cOZyNrKxoWnVoT5lszhtLjWB/Q=;
 b=Ne/0W9PP9IbqPSJZeCvrD/Blx7oFzdWdz9Ai7z/v+sFRPPy4X46vp/gN4XSRLcgv0G
 6OqEg5eZo6pxYWWalQqZPXU7SK0jeZseWE4vNxRzMLgRc4mz2oUKSDKwWAs6OSCZWoi0
 MhVx6gsZbFTAK5XAhpqIqjUTtWOSTjs4RgemwwcbvhUHa5EVIfeZlU437izkxuZbZAvp
 zmwc8wypPQ1vFO5K8TSR3RkIYGMaZ706zEdGwdvJrZZKzDqt+8HYyS7pky1rJYVSw5rW
 xnuk7C+zXDGjqth2w8Iq+io3ayYVZD/sjbQ/aeDdKe+aCBTnnlEFhMzXHDTDHsCiMx/l
 70eA==
X-Gm-Message-State: AOJu0YxlCJRDQlnLrZJjHaNB570VdnkXurfZ/7bzXKV+4qdvMnUiOC2G
 0WuXPHAN9+bUI8GJu+ZSkoxBusvs7sjDq4u/vV8ZP/HSf9ywwA/D4hby4fiKryExhh8HGkEkmmm
 0
X-Gm-Gg: ASbGncsmppOwH4UOQ+QBqC/iwvog1tdk6IupDbBF7BbzBLepVfFCsGxs1gw598H2Ojq
 38SGVvRWXEua2dS9MF1QV4b9a+5C7ocLDEYWltd02uU9Gqh/0nFxqhlpido4AaZUBP9e4KYAUUe
 ymzMqKPwmhybmUgRJOtUQNFbZlRLX46jQFveVgx077J5s9Ee09JC33aR38+20jwy7eyHLBp4IHz
 WFAxHK4LsVU3zxPBkVp/jewgxW2G/eYnVYJz19daQ5mwN1xsQF3ueYpVSTU5PXtKD02cJwFRGE4
 6sbMRj8dH7SivrTk+htZbJV9Fpj4Ap5eS96wh61eOh5mKC+MLStdYQ==
X-Google-Smtp-Source: AGHT+IGNrE1QjYa/OY9IjNphAfi1yAvOEiQ9GJhV2vfLfOOxq4SSmth3HMoFZYuoTSSM9ZLNf3jcww==
X-Received: by 2002:a05:6a00:acd:b0:73e:598:b2a1 with SMTP id
 d2e1a72fcca58-74027102b74mr1301113b3a.1.1745868985323; 
 Mon, 28 Apr 2025 12:36:25 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74022ee1fdcsm1071956b3a.15.2025.04.28.12.36.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 12:36:24 -0700 (PDT)
Message-ID: <0a39e805-eb75-4b88-b316-189acad38efa@linaro.org>
Date: Mon, 28 Apr 2025 12:36:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bsd-user: add option to enable plugins
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, richard.henderson@linaro.org,
 alex.bennee@linaro.org, Kyle Evans <kevans@freebsd.org>
References: <20250331234228.3475706-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250331234228.3475706-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

On 3/31/25 4:42 PM, Pierrick Bouvier wrote:
> Nothing prevent plugins to be enabled on this platform for user
> binaries, only the option in the driver is missing.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   bsd-user/main.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index fdb160bed0f..329bd1acc02 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -175,6 +175,9 @@ static void usage(void)
>              "-strace           log system calls\n"
>              "-trace            [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
>              "                  specify tracing options\n"
> +#ifdef CONFIG_PLUGIN
> +           "-plugin           [file=]<file>[,<argname>=<argvalue>]\n"
> +#endif
>              "\n"
>              "Environment variables:\n"
>              "QEMU_STRACE       Print system calls and arguments similar to the\n"
> @@ -225,6 +228,8 @@ static void init_task_state(TaskState *ts)
>       };
>   }
>   
> +static QemuPluginList plugins = QTAILQ_HEAD_INITIALIZER(plugins);
> +
>   void gemu_log(const char *fmt, ...)
>   {
>       va_list ap;
> @@ -307,6 +312,7 @@ int main(int argc, char **argv)
>       cpu_model = NULL;
>   
>       qemu_add_opts(&qemu_trace_opts);
> +    qemu_plugin_add_opts();
>   
>       optind = 1;
>       for (;;) {
> @@ -399,6 +405,11 @@ int main(int argc, char **argv)
>               do_strace = 1;
>           } else if (!strcmp(r, "trace")) {
>               trace_opt_parse(optarg);
> +#ifdef CONFIG_PLUGIN
> +        } else if (!strcmp(r, "plugin")) {
> +            r = argv[optind++];
> +            qemu_plugin_opt_parse(r, &plugins);
> +#endif
>           } else if (!strcmp(r, "0")) {
>               argv0 = argv[optind++];
>           } else {
> @@ -433,6 +444,7 @@ int main(int argc, char **argv)
>           exit(1);
>       }
>       trace_init_file();
> +    qemu_plugin_load_list(&plugins, &error_fatal);
>   
>       /* Zero out regs */
>       memset(regs, 0, sizeof(struct target_pt_regs));

Gentle ping on this series.
As we didn't have any feedback from BSD side, could we consider to 
enable this upstream?

Regards,
Pierrick

