Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E26C54756
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 05:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHyub-00027h-6s; Thu, 22 May 2025 01:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uHyuW-00026w-JQ
 for qemu-devel@nongnu.org; Thu, 22 May 2025 01:56:08 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uHyuP-0004vH-8B
 for qemu-devel@nongnu.org; Thu, 22 May 2025 01:56:08 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-30ec226b7d6so4181271a91.2
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 22:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747893359; x=1748498159;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P9YtVX6tHIM4S8SiNEOfAuBtEEKz6i8ukp0QFvwVbCI=;
 b=2phw8pT5ngcpz/y3MQ+f8OwgxOuNwBlpWKok/u+i2SxJbmc75b2k+YuTlx8b5FLnrI
 1TsGkuSY4KCIAzK2f5FdiTyT9VijpQDR9gpcuC+9HWVi8a7yz3sBelD9syue850kXsTz
 bPFt0RWQFqEb7aHMls/zWElnk0T/3WGb68W2il/mszotFpTTc2RRstUIAAbe6pthfeum
 FRh+M5NyJ+CNFVEhT9FYJSYCi/rX7JQ/t1DCEiZ8wWskbIajYOMZqZ9YL63dEATYdvxh
 LGaF7Z7Le2sKA/h0YZmkhaiBq9kQXNOsAkUXgzCH/B0TIDhuZgcbUJ4GX87fMmDdQKyr
 9RNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747893359; x=1748498159;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P9YtVX6tHIM4S8SiNEOfAuBtEEKz6i8ukp0QFvwVbCI=;
 b=ClUOWcAdRiiyoE+1GUNSzdYGsxQjuJqUuGFgCReMRmLRwNFFSCCkvoHXC7a+ftueqN
 KPnJWlQF10GG5U+GdKkGDvTLqGQ5jxBtm5APzQvg5c0ik7mwD4BQTwp3usbM3eGMX26+
 lzzjCULNW02xjiA5ocet8SYnsUaLe64+2dsZ5uI5TTdZ4hfnRoqnb+LJ/LM9cNhkNGFW
 cMJd7f2ruJQ/cWx3ix7I6vzukzwiOQAkL04/vhfACS+mPdmFI9XJ3kuRymadCJOURBlA
 Pu9UbhyQIAYmTz8WBxTRb4wO2caOxrx0M0c6thXOkV6FEci+rHdSyJ6B4EQx619iD13H
 xqNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOhtQ1zeBu7dmwl6ReeY3Gb6tKQaPlN8V8Mo2CID/tdns1r7MtuipHwo9XI27PoKsGcEw2ZHkLwIDL@nongnu.org
X-Gm-Message-State: AOJu0Yw/APckUk465Lazqx7ljIF/DuJuGgfX6kDu2XD9f1z9H2178IV0
 Fcd3aetQPnDnhCcrhqdol8Ey0CpdjcCRvaVrOZo7ywlCTGtaxmxlVd1dp0KQ07wcmuw=
X-Gm-Gg: ASbGnctLxFdTzC5Yi+jd5m1mX95T3KF7gqkz6cxxivrVka6k/OKVHyEWvlUh8Ddlw9v
 Au7w7+B/+CLJFEBnYl0aff6YlGhISeACx6+TREGsyKlu8F4yCASJIMMzgQM1xilZv5z9rGigjmD
 qKJqEgPW9MP35+2qJhoc30Kz00SniDwcanssH4BUuCFjqemHR2oQbWbUowbItVy9bQwyzC+KQUF
 tWGIJVuuuK3LWZ/toyjpopLZ4vZPS4zuIQgZGtFeGfWX4+UOuIXIr5HSjm9Z1zXr9pUJodQC7VX
 TdEVOHeR0V9akPNbxj7jDJxchZwefg2r3JNkYFVmv/OiUsXYwaX589pnDvD4/A==
X-Google-Smtp-Source: AGHT+IHT+x1bXD9VP4n4gXHsME7KhEB7XkFIWRQM6Y47ObixU0hopbdl14D5eiQBNFc4FZJFOCVmnA==
X-Received: by 2002:a17:90b:3e8e:b0:301:1bce:c255 with SMTP id
 98e67ed59e1d1-30e7d5a93bamr34284005a91.27.1747893358872; 
 Wed, 21 May 2025 22:55:58 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eaf6e609sm10581840a12.19.2025.05.21.22.55.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 22:55:58 -0700 (PDT)
Message-ID: <c3f5ae11-1333-4267-a07d-ff4112714cd5@daynix.com>
Date: Thu, 22 May 2025 14:55:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/20] contrib/plugins: allow setting of instructions
 per quantum
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
 <20250521164250.135776-9-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250521164250.135776-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2025/05/22 1:42, Alex Bennée wrote:
> The default is we update time every 1/10th of a second or so. However
> for some cases we might want to update time more frequently. Allow
> this to be set via the command line through the ipq argument.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> ---
> v3
>    - error checking for ipq
> v2
>    - checkpatch fixes.
> ---
>   docs/about/emulation.rst |  4 ++++
>   contrib/plugins/ips.c    | 15 ++++++++++++++-
>   2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
> index a72591ee4d..456d01d5b0 100644
> --- a/docs/about/emulation.rst
> +++ b/docs/about/emulation.rst
> @@ -811,6 +811,10 @@ This plugin can limit the number of Instructions Per Second that are executed::
>     * - ips=N
>       - Maximum number of instructions per cpu that can be executed in one second.
>         The plugin will sleep when the given number of instructions is reached.
> +  * - ipq=N
> +    - Instructions per quantum. How many instructions before we re-calculate time.
> +      The lower the number the more accurate time will be, but the less efficient the plugin.
> +      Defaults to ips/10
>   
>   Other emulation features
>   ------------------------
> diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
> index eb4418c25b..f1523cbee3 100644
> --- a/contrib/plugins/ips.c
> +++ b/contrib/plugins/ips.c
> @@ -145,6 +145,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>                                              const qemu_info_t *info, int argc,
>                                              char **argv)
>   {
> +    bool ipq_set = false;
> +
>       for (int i = 0; i < argc; i++) {
>           char *opt = argv[i];
>           g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
> @@ -175,6 +177,14 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>                       return -1;
>                   }
>               }
> +        } else if (g_strcmp0(tokens[0], "ipq") == 0) {
> +            max_insn_per_quantum = g_ascii_strtoull(tokens[1], NULL, 10);
> +
> +            if (max_insn_per_quantum == 0 || max_insn_per_quantum == G_MAXUINT64) {
> +                fprintf(stderr, "bad ipq value: %s\n", g_strerror(errno));

This check should follow one of ips.

First, it should check errno. Otherwise it may emit a cryptic message 
saying: "bad ipq value: Success".

max_insn_per_quantum == G_MAXUINT64 is unnecessary. A sufficiently large 
value of max_insn_per_quantum should result in the same behavior anyway: 
a quantum never ends.

Following the check of ips is an easy way to implement a correct 
checking and it also ensures consistency.

> +                return -1;
> +            }
> +            ipq_set = true;
>           } else {
>               fprintf(stderr, "option parsing failed: %s\n", opt);
>               return -1;
> @@ -182,7 +192,10 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>       }
>   
>       vcpus = qemu_plugin_scoreboard_new(sizeof(vCPUTime));
> -    max_insn_per_quantum = max_insn_per_second / NUM_TIME_UPDATE_PER_SEC;
> +
> +    if (!ipq_set) {
> +        max_insn_per_quantum = max_insn_per_second / NUM_TIME_UPDATE_PER_SEC;
> +    }
>   
>       if (max_insn_per_quantum == 0) {
>           fprintf(stderr, "minimum of %d instructions per second needed\n",


