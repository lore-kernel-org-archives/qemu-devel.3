Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47729CF45C6
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 01:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfT4B-0001sQ-MR; Mon, 12 Jan 2026 20:19:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vfT49-0001h7-Uk
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 20:19:25 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vfT48-0001cr-FS
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 20:19:25 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-81f5381d168so1421472b3a.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 17:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768267163; x=1768871963; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2bpPa26c5eU+alk3SooULZpSqHmkr4dyfvja6AA7i0w=;
 b=VoMhOJ4mh6sgE9R9hmMfSZHxy3tV0kPOf/AXVUPxsiZMXuBLy+MpEHhJ22PBRju3Jv
 q/jBoUwtZTCw5/PoHft7nw6VRcQYZXSwBI1rzbF8wwck0LZgRlLA9lKxKpBaX5TYBVZm
 6HOs6GMJtIX3yLFgpjBsHX/H/mnoxo+GcxopuZGBj+b1kPo6cxQNw3j1anNdCKxcCgfb
 +jEkB1mh0j+AByJXs6UPVXbsX3mD1PF/KOJMIwDauztpjLDc+KttsPpqLNjD7f+vGkQX
 S9A1D+VlYp+oV2AzDw3kWdH8d+P32cIhVfBkFw0KqmcdD+jHAm3iefydtUTZJSnTcRQj
 3ujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768267163; x=1768871963;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2bpPa26c5eU+alk3SooULZpSqHmkr4dyfvja6AA7i0w=;
 b=f6m69s1MFiRzXHbRv795b1qbvBS7xvdgc2ewKIoLSwCbYnor6HWl0FV4JFN3OKoh2G
 x6sMDswt+/bZl6HXTuBkYdJ6U1VVf9wU8BrwCTnvRNdnMaRrvhKrQv3vtlQzqqXdsGCZ
 2g4xhG/Gjfnt5OMebniIkN1J72YkrzB1dworfeK29zSoGrt0kf+Ph2cHPnyL+nfVgUFK
 1OAy7xr2Rc6egJYvibcBy+IH5dAII0rSelGnYLk2DUENTt8zb+xIDfvi3xGGYUr3cGLI
 U7pOY6PX+jQ4+fn9NKdikutmPsKWk295hDp4oDwFJHzaW3gxNVtn/AszbchbLrt27jDR
 UDVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHnUKlqzTQ7yU9RN8KONjI6DKyNGSIovyJ+kL80r4K6kyb5+Dc5Xd7eRSODlBwt+fvhAUtnjR6cuJK@nongnu.org
X-Gm-Message-State: AOJu0YybQX9KDCs+2aqPC/uDa3uW1BROqLXc5PKyU15X+oT1XwfeeXb/
 yLkACQsdP8XkwAGJzTWv8o8ViSlaCseWbT+gQVyy+NIIHjCLEZe/jhygdmOQaOlH0cI=
X-Gm-Gg: AY/fxX7+hUmFBEozdHhfA0/aYnJSGDyERJTNdXTl+aThkh5InaL55bI12oUUcLjIhZB
 HvrHLot3nkfJy7+gYQhC1ARz15kS4pvE/74o5heWiJBSChnEzG0szcE4JyJtajfH1xMKiWRqGy5
 TcF3/yzjKj6ClBdJ+9mXcXoW4GEB/AXkJgbBdUscAx90MoUiIu0QwkM6zYDEAyOthwMeCBPwu0Z
 G7+g6M5hVO4u2WF6MgwTljDb7BDZB3e5kMjgC9uVtZGMG+MVDTdWA3T+Eh6NnT3E7ikVUv4IpuZ
 k9AoQRlutE0UdkF2+GFEtdLOhue9pQxTia6uM+VqvoYdwBC54Pnf5y/8eRqm2gxt/RXd+ZAQgYK
 m4vKCNOodNT0M6mAMAjnysFvQbWi8/NzS3jQKUNjgUvbtNrIPGoGOmdEQR822oStdL95CM+60J2
 +N2ciAifx9+zgRwjREmdUWz9Sebaw=
X-Google-Smtp-Source: AGHT+IGaN73LNVf/l0wG+Vb3AWeqaTyN+9ZV44ccGSDb3mTCvH4sQxntY6fRo/aByk2LAjp4FAGD8w==
X-Received: by 2002:a05:6a00:1bcd:b0:81f:52d9:5f5 with SMTP id
 d2e1a72fcca58-81f52d90cf1mr5087236b3a.10.1768267163025; 
 Mon, 12 Jan 2026 17:19:23 -0800 (PST)
Received: from [192.168.15.8] ([101.187.175.172])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819c5adf1cfsm18479149b3a.57.2026.01.12.17.19.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 17:19:22 -0800 (PST)
Message-ID: <e79fd7d3-5a5e-44e9-a258-a707d3e60080@linaro.org>
Date: Tue, 13 Jan 2026 12:19:13 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/12] hw/m68k: just use reset_pc for virt platform
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu
 <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Yanan Wang <wangyanan55@huawei.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Thomas Huth <huth@tuxfamily.org>, Eduardo Habkost <eduardo@habkost.net>
References: <20260108143423.1378674-1-alex.bennee@linaro.org>
 <20260108143423.1378674-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260108143423.1378674-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/9/26 01:34, Alex Bennée wrote:
> @@ -129,8 +122,8 @@ static void virt_init(MachineState *machine)
>       SysBusDevice *sysbus;
>       hwaddr io_base;
>       int i;
> -    ResetInfo *reset_info;
>       uint8_t rng_seed[32];
> +    CPUM68KState *env;
>   
>       if (ram_size > 3399672 * KiB) {
>           /*
> @@ -142,13 +135,10 @@ static void virt_init(MachineState *machine)
>           exit(1);
>       }
>   
> -    reset_info = g_new0(ResetInfo, 1);
> -
>       /* init CPUs */
>       cpu = M68K_CPU(cpu_create(machine->cpu_type));
> -
> -    reset_info->cpu = cpu;
> -    qemu_register_reset(main_cpu_reset, reset_info);
> +    qemu_register_reset(main_cpu_reset, cpu);
> +    env = &cpu->env;
>   
>       /* RAM */
>       memory_region_add_subregion(get_system_memory(), 0, machine->ram);
> @@ -235,7 +225,7 @@ static void virt_init(MachineState *machine)
>               error_report("could not load kernel '%s'", kernel_filename);
>               exit(1);
>           }
> -        reset_info->initial_pc = elf_entry;
> +        env->reset_pc = elf_entry;
>           parameters_base = (high + 1) & ~1;
>           param_ptr = param_blob;
>   

Why introduce env rather than use cpu->env like elsewhere in the function?

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

