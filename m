Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF897CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 17:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6udE-0003g0-Tx; Thu, 09 Oct 2025 13:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6udB-0003fi-9M
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:40:45 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6ud2-0005Tg-Ux
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:40:44 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-33082c95fd0so1636868a91.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 10:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760031634; x=1760636434; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UyP+FBZJLq6xKNT7V4iq8Qi9Lqostur0CLvJD/v/ox0=;
 b=pyU2Zh2If6t8t3EiX8QqRamq/4y0jbs7oDnOdf28GIzuiz/DSZuJZjds2ErwDtoR5M
 4fxO2WcYlDieopC/3SJwWzPitee+sRv82E/NLUen+CIwwZwULMAV2ccvpwXopjWbp+4f
 EaKMjyWAT+TUoImQtORpVpejSgb88VDb4YhQf2huR6tLhEnA0jVKNBXAXUPWFYIB+3/L
 iWz8lWZJKXHn502J0ghKJL5/DJ1vL9cdouhiif+GufYh5YN+CgIfkNRYiI+ZmQgMMdCh
 9GqjtuP0NME/5bmDLIXs6+qaqVYQprGUxmx22yMMSvxKO7xHXUY0+vnqxFpVdwop2QvI
 wosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760031634; x=1760636434;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UyP+FBZJLq6xKNT7V4iq8Qi9Lqostur0CLvJD/v/ox0=;
 b=lpwkWzl9uiVI9Mxxk5gOnFtQti1vDda4GAN68eV35nARuwRIdGit9DdBlftEcFP7eK
 vCaGA/vN4/DzEd54PTqCo/S/vhmRL7AguaCwozeSEBNdWtvmJkK8KHbYB1FHu9jmlZsM
 oXp3Ca2k7+f1ySqykyG2ODg+yn4sA1L/N31uOmF2BHyfGqBQuoQHSCvmmYHNvSrBGiUN
 XUmazZavsBnXOq92VJYfzcAeL5GT9ONfEFGFlLk4b4lDphM+yyVAYQt8pfO1N8e/P+4s
 JqgmT5XPjjnQ3EXjKUQN/kEZv6osuUG0/PkHGVnxjhiASBbqLYrAWhVWfg/mUr989xhP
 JQDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXepCRj/MKhcOeZ2W3bLjV/p/EQ5stslsNSE8xHIpQbn0bsW6HoxB/gS7x0cKIl7fhrcMK8GqRCTX5n@nongnu.org
X-Gm-Message-State: AOJu0YxqVeDpl0Z5TlI9XfWNlv8FHeycxdyKwpt25ovViOUcztw2gLWk
 2FKVaYGjj6LJbw6SEALl3ccUKGZAR52HrYcgO5NBFbokDz8ZDh8M1KSP80hJ1dT3HhQ=
X-Gm-Gg: ASbGncuwamnxft6+vAiZklht96tomBtFPwvTVOSo2OqFMnXuN/vTHgKStGKiZ/Rixve
 xs65/0zZF4VuA4nHXcf799HnoXwTCjhkIajhSpFVSgSm2JUgM2gdn1oWNEnG+CvsqXCeX1dfK8l
 x7/lfn9SAVjPHxcaKyVKNuLPTl1nSqhKAwrn/txM1c8ckRZLblDA7QIg34WrfUAPh/poWLihImt
 5VLrpE7Gp7GXUcpPliSZCPgzfOfWiu+aXolYNXqVKhuVLRqXaNsgWD6QLlMgZLRkARlznmfCWEA
 IhswNQMkj7h9TAax2LTLe7VSWHNEsPvqWDHRYOs+PBrIIK//zQswydxp9cy90bBqRmvHt7AuM/z
 Qf+8FFlx2cbKUkKjXB6nESdjYOKS65VvmbjQ690R7dfY4Ktc7Kh1h2Q6PdSIOF7xE
X-Google-Smtp-Source: AGHT+IHZ96NW4MMM/hInIdXXFxq98t+HhezGWxPEL9/PdOgxH011jpkvpVDjmNhhIoqt8vu7nE9l5A==
X-Received: by 2002:a17:90b:1b4c:b0:32e:4924:6902 with SMTP id
 98e67ed59e1d1-33b511496d1mr11792218a91.3.1760031634137; 
 Thu, 09 Oct 2025 10:40:34 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b61a3cc5csm477891a91.10.2025.10.09.10.40.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 10:40:33 -0700 (PDT)
Message-ID: <fef2f604-453d-4d12-a75e-f84e05ff4242@linaro.org>
Date: Thu, 9 Oct 2025 10:40:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] hw/hppa: Use the machine default boot order at reset
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>
References: <20251009143106.22724-1-philmd@linaro.org>
 <20251009143106.22724-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009143106.22724-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 10/9/25 07:31, Philippe Mathieu-Daudé wrote:
> Since new machines might be added with different boot order
> than 'c', take the machine default one at reset.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/hppa/machine.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index dacedc5409c..1cce5c47b91 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -640,6 +640,7 @@ static void machine_HP_C3700_init(MachineState *machine)
>   
>   static void hppa_machine_reset(MachineState *ms, ResetType type)
>   {
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
>       unsigned int smp_cpus = ms->smp.cpus;
>       int i;
>   
> @@ -671,7 +672,7 @@ static void hppa_machine_reset(MachineState *ms, ResetType type)
>       cpu[0]->env.kernel_entry = 0;
>       cpu[0]->env.initrd_base = 0;
>       cpu[0]->env.initrd_end = 0;
> -    cpu[0]->env.cmdline_or_bootorder = 'c';
> +    cpu[0]->env.cmdline_or_bootorder = mc->default_boot_order[0];
>   }
>   
>   static void hppa_nmi(NMIState *n, int cpu_index, Error **errp)

Is this perhaps trying to reset boot order to 'c' for reboot?


r~

