Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E042CD3436
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 10:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKZq6-0005HZ-1O; Wed, 06 May 2026 06:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKZq4-0005HQ-3j
 for qemu-devel@nongnu.org; Wed, 06 May 2026 06:50:48 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKZq2-0000wY-I5
 for qemu-devel@nongnu.org; Wed, 06 May 2026 06:50:47 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488b0046078so54966135e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 03:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778064645; x=1778669445; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VRPPQ07XO3kfFYslI/zsngkOin2sXH99ji/BRY7EYeA=;
 b=rltRzEW3NMZ49wQmajkQ/VXZ8H+G+0fnstbLC7z1lZDrT5qeVubUyP8lzCYjqaEG+T
 pU+I/yp0QxbO+C6czHUN2zGnZkHPHgQMlPTVXsksvQUWDhevaJjzmPG1eUik7SKxR8VI
 Ve7BHAGItDQ0hL1QMulfDeVCussrnrMLKeBTAqQD0nIAFmE5KHjKVnOP9CWBAIsThOdV
 ymLD2GBPbtT1lNE3qMMa4/lFbJ03SR1FR+DWH/8O/yZxvq4C4lZLL4uv+fWQQytjH95D
 D5kkRxP6s4ikYnghP/Gzj7vsVp6XCxRZFuwmzp8V+ObGrTJDwuY+b3dy0sLWv+VA/Y1w
 d8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778064645; x=1778669445;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VRPPQ07XO3kfFYslI/zsngkOin2sXH99ji/BRY7EYeA=;
 b=GM8hZ0jKSC1kCOzb/WBq35sO3/7kMh4lBfwLClTtrXf/Ul93zZ4zoL7xnvyleIgdKW
 eCjxdE3x50cznaRfA0v2U83sZnT8NvZ6+gyp3Ugl1MEenSHfdQ0o5xoGGFKh3uEBn/FC
 B7YN6ilh79ACj9yaYNcrS6Cus0bTqJLOvbU2gCZ/Ytgt0cvwlWQGIaRmGEJJ1p8JDRzJ
 GjzTKCX0Bw4terJMXiWP9yEvZRqoAYUztlDuTZV3BnzkTzpXocihyMJsuyBTXeFKsJJQ
 Npj/JBXN6eaQKrqUEtU/kW0zFCKG5GHyKSIXUcB54sqBgrwxc6VD9NSo3zJDvFsn5VeV
 oZCA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8KEVRAMqyi74EofKFFbHfNWcYaHqA8xSk8tPlnDC/gQayXP1j0qvR9sfDcQsYuhUw4n6S0dCUG6UtW@nongnu.org
X-Gm-Message-State: AOJu0YyCMA2ShxTmHwA4Oc50eahODiv4QOJ2ut+Wh6DWK3odzDFWObfX
 OpDs0/TiCpm8a0FaC+72gY9pb3J7PaT9B53xrjOx8I+JniV5qY3jCf3sp7t0I4dRGwg=
X-Gm-Gg: AeBDietu/leNPsJTtnvr5wiCvd/u6wOVWXBTba8ga8mplIvNAS/eICAOGoCL0Hotw5i
 BbQMRQM8CWs/JX740h1BMbaTDbwrCUcPeVEsXy9cf1u7YhV+0nij/KIy8dJXwrgYdtaXMKU3ByR
 gsf6TbRHkosKH8YgWsZLLHaRpH0gUdUj40garkR0l2gtdLf+W/JVYGnEnZ8p6pKmNBBkxBngGF4
 gNrOU76lux3ewCfE19y2EUEqzdz3/DLhLNDwb4qC349BR9uXsEESrZQa5+rC7iYsxcPOi9pQjF5
 rXG78cEfyuRUfyVWgkRNiOoob108+AbLqJv/gBoTUdqHQOVGYx0H5gyXAS3rsabbJYTn/3KKuEI
 pvoovKY8fVQDOb8SgSdIU/4sZWNTiWYCee3cxRNW5a6BLCyZr6IChhsERDcSAmxW0KA0pk/Ix9i
 wg62e0/nV8yp4LCWPZQ/mNXMh1ZOrvpSqVYVdSUbeJJdtGObsuPlwkVB0EltvbNMSVSSFCzswtQ
 +mSYkauIu0RlYA=
X-Received: by 2002:a05:600c:1d18:b0:489:1f97:6b1d with SMTP id
 5b1f17b1804b1-48e51f4844emr50186045e9.28.1778064644848; 
 Wed, 06 May 2026 03:50:44 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45054b03d4csm12301906f8f.22.2026.05.06.03.50.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 03:50:44 -0700 (PDT)
Message-ID: <28cbf878-6edb-49ce-b73d-205cdd2a321a@linaro.org>
Date: Wed, 6 May 2026 12:50:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/mips: Free mvp in unrealize
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20260317175031.3035740-1-peter.maydell@linaro.org>
 <20260317175031.3035740-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317175031.3035740-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 17/3/26 18:50, Peter Maydell wrote:
> We allocate memory for cpu->mvp in mips_cpu_realizefn(), but we
> never free it, which causes memory leaks like this:
> 
>      Direct leak of 24 byte(s) in 2 object(s) allocated from:
>          #0 0x5f9458e61c8d in calloc (/home/pm215/qemu/build/san/qemu-mips+0x4d8c8d) (BuildId: 4153e33b3d08657a71ce2a04a82d0c2954966d9c)
>          #1 0x74761891a771 in g_malloc0 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x63771) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>          #2 0x5f94590687aa in mvp_init /home/pm215/qemu/build/san/../../target/mips/cpu-defs.c.inc:1037:16
>          #3 0x5f94590687aa in mips_cpu_realizefn /home/pm215/qemu/build/san/../../target/mips/cpu.c:489:5
>          #4 0x5f9459366a3a in device_set_realized /home/pm215/qemu/build/san/../../hw/core/qdev.c:523:13
>          #5 0x5f9459380a49 in property_set_bool /home/pm215/qemu/build/san/../../qom/object.c:2376:5
>          #6 0x5f945937bace in object_property_set /home/pm215/qemu/build/san/../../qom/object.c:1450:5
>          #7 0x5f945938816c in object_property_set_qobject /home/pm215/qemu/build/san/../../qom/qom-qobject.c:28:10
>          #8 0x5f94592cc100 in cpu_copy /home/pm215/qemu/build/san/../../linux-user/main.c:240:25
>          #9 0x5f9459309931 in do_syscall1 /home/pm215/qemu/build/san/../../linux-user/syscall.c
>          #10 0x5f94593058d8 in do_syscall /home/pm215/qemu/build/san/../../linux-user/syscall.c:14422:15
>          #11 0x5f945905c73e in cpu_loop /home/pm215/qemu/build/san/../../linux-user/mips/cpu_loop.c:124:23
> 
> for linux-user, where each new guest thread is a new CPU object that
> we need to destroy on thread exit.
> 
> Add an unrealize method which frees this memory.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/mips/cpu.c | 12 ++++++++++++
>   target/mips/cpu.h |  1 +
>   2 files changed, 13 insertions(+)
> 
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index 789ca188b5..0663cda003 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -502,6 +502,16 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
>       mcc->parent_realize(dev, errp);
>   }
>   
> +static void mips_cpu_unrealizefn(DeviceState *dev)
> +{
> +    MIPSCPU *cpu = MIPS_CPU(dev);
> +    MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(dev);
> +
> +    g_free(cpu->mvp);

We could avoid this patch by embedding CPUMIPSMVPContext in MIPSCPU,
anyway:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


