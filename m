Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDFFE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 19:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJeES-0001vg-Lu; Fri, 06 Dec 2024 14:43:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJeEQ-0001ux-ID
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:43:18 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJeEO-0007m6-Cl
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:43:18 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7fbc65f6c72so2452097a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 11:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733514195; x=1734118995; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VDsQj6Tx2Hgt2tRuxm2uoTNTdw7TFqMvw6RHuQeRPEs=;
 b=rI90hz3Te5Cv38zsGxLk6M7y2l+Q8X9SFPrWHRJc4CLZj2jvPmuMdsyq8/G9h/vuDG
 mG2Sn86vyiaBdqsJNvDH9xzuQXUeDZIUyMs+bgQk86PfBJBDRFshBesKPBReT8fkj4YZ
 G91FXBFir7FQi/xHThS1IOCitpCj4TDvM4lW2eY+JYkxHgP4+lYsKuIV/AQANRGiW71X
 L9xfNyHEZRLVpI8/Fyd/eHXcN7/4iHA375b9u4IOAdjXxhB0TcroUuMw1FVSco1z/iou
 LEwmhK0W04ECRm5LVR3qclwpXFB6DZSpv31eXMvQDYtoCRjUEDe/B9M0PLESQlBaZp59
 EQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733514195; x=1734118995;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VDsQj6Tx2Hgt2tRuxm2uoTNTdw7TFqMvw6RHuQeRPEs=;
 b=fyl6ldaUcWti5p8I2HjvlidQElf8PJUWFPvAg38pF308nKEQJQB4BokrQSGtuTUb15
 5raM5943mIem2l/kywRf8bpoEv1my8/I+zbqpbZ++3n/vtKcGCseg0GNjvKQLfuAzsOf
 mNXwA9XuMu5jrYfj6JRY6q2LqDfsCMgjFpzkcK7ERLoEbTYuB1bXKKpYIVlcedhh6PqN
 klGpRE+CnWrGx9UkasR8hn6/KyXCCs38Za6GKUaXWVGL4O2eTCaE2xzyB27RbaqUr+3u
 GCwvwV+mV3N572xPc9lfnHWYJIdzKuY5dn8oDEo5qtYFpGZDImmJYBNHsf0eifTGFZ2d
 O/3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5115P19RHt2nz78bedcjEC53JsqzdY54KPu5bczYtlqoirHevK+28ZUDokMyrBD8gT7V+e7UlxLqB@nongnu.org
X-Gm-Message-State: AOJu0YzH7yOXwuDj6W3JfTewLXwobxZg02XD9145IYdaRbq04eBkBmIh
 qRZNhEUooIk8oYroTVMSfUftAxW7gxAm+TjonYoKgQB7FHB+OH+rF7+gwfOzSA4=
X-Gm-Gg: ASbGnculsPEg1qGg2JezQ51cFLnXUS1r+qkWhY8omZsp/qMHtBMYVGLXwFoSY5Lmwk7
 9L98+qw30uSbVbbfSoG7hDzEIppatrHBAn6sK1V7rBCqJNbS4P1uUbfxrxnqpl9eIRwzc1qwGOa
 NzKKs4DtPQyXWMc+JzPSRJNKVizjUofHHalNmrIBsq383iD8je8vEGQnN8mOStG9LKNsV8SDbTY
 ++Uy5/4UiwCN2EsohwoOlv6GsxRN3n4yQSjmOAtTPfZh7yTsVvtOLPhSO55FOTxDWTE35W+NRKC
 Oq2lF+4MYpDGzmayGQJ4ow==
X-Google-Smtp-Source: AGHT+IHh5NpglCGT/ptzXXM+EV0JPWKHtZSAR97ItWF6LBNSnc3Ct8PHf24a/RMYFImvDfxIdAl5ZQ==
X-Received: by 2002:a05:6a21:9989:b0:1e0:d123:7154 with SMTP id
 adf61e73a8af0-1e1870bb909mr5433484637.17.1733514195089; 
 Fri, 06 Dec 2024 11:43:15 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a29e8f29sm3308971b3a.43.2024.12.06.11.43.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 11:43:14 -0800 (PST)
Message-ID: <55c95bd1-a1bc-460c-b4fe-1f52f8af2c2e@linaro.org>
Date: Fri, 6 Dec 2024 11:43:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add additional plugin API functions to read and
 write memory and registers
Content-Language: en-US
To: Rowan Hart <rowanbhart@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
References: <20241206102605.961658-1-rowanbhart@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241206102605.961658-1-rowanbhart@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x529.google.com
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

Hi Rowan,

thanks for this submission!

On 12/6/24 02:26, Rowan Hart wrote:
> This patch set follows a previous patch which added the
> qemu_plugin_read_memory_vaddr function and adds a set of similar
> functions to read and write registers, virtual memory, and
> physical memory.
> 
> The use case I have in mind is for use of QEMU for program analysis and
> testing. For example, a fuzzer which uses QEMU for emulation might wish to
> inject test data into a program at runtime using qemu_plugin_write_memory_vaddr
> (and likewise if testing an operating system or bare metal application using
> qemu_plugin_write_memory_hwaddr). It may also wish to read the initial contents
> of memory using qemu_plugin_read_memory_vaddr/hwaddr.
> 

I am personally in favor to adding such features in upstream QEMU, but 
we should discuss it with the maintainers, because it would allow to 
change the state of execution, which is something qemu plugins actively 
didn't try to do. It's a real paradigm shift for plugins.

By writing to memory/registers, we can start replacing instructions and 
control flow, and there is a whole set of consequences to that.

> Similarly, a testing framework may wish to fake register values, perhaps to
> simulate a device failure, perhaps by using qemu_plugin_write_register to set a
> register value to an error code.
> 
> I think all this functionality works together to make QEMU
> plugins more powerful and versatile, hopefully removing barriers
> to using upstream QEMU for these tasks which have historically
> required maintaining a QEMU fork downstream (like QEMUAFL
> https://github.com/AFLplusplus/qemuafl), which is tedious, error
> prone, and results in users missing out on enhancements to QEMU.
> 
> A test is provided, compile:
> 
> gcc -o tests/tcg/x86_64/inject-target tests/tcg/x86_64/inject-target.c
> 
> And run:
> 
> ./build/qemu-x86_64 -d plugin --plugin build/tests/tcg/plugins/libinject.so tests/tcg/x86_64/inject-target
> 
> Hopefully after a number of tries, the inject plugin will inject the right
> value into the target program, leading to a victory message. This plugin
> handles simple "hypercalls", only one of which is implemented and injects
> data into guest memory.
> 

The hypercall functionality would be useful for plugins as a whole. And 
I think it definitely deserves to be worked on, if maintainers are open 
to that as well.

> novafacing (3):
>    Expose gdb_write_register function to consumers of gdbstub
>    Add plugin API functions for register R/W, hwaddr R/W, vaddr W
>    Add inject plugin and x86_64 target for the inject plugin
> 
>   gdbstub/gdbstub.c                |   2 +-
>   include/exec/gdbstub.h           |  14 +++
>   include/qemu/qemu-plugin.h       | 116 +++++++++++++++--
>   plugins/api.c                    |  66 +++++++++-
>   tests/tcg/plugins/inject.c       | 206 +++++++++++++++++++++++++++++++
>   tests/tcg/plugins/meson.build    |   2 +-
>   tests/tcg/x86_64/Makefile.target |   1 +
>   tests/tcg/x86_64/inject-target.c |  27 ++++
>   8 files changed, 418 insertions(+), 16 deletions(-)
>   create mode 100644 tests/tcg/plugins/inject.c
>   create mode 100644 tests/tcg/x86_64/inject-target.c
> 

Regards,
Pierrick

