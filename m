Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA54CF34C3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 21:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swSyk-0007LB-Ju; Thu, 03 Oct 2024 17:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swSyf-0007Io-3m
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:03:13 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swSyd-0000Gl-4b
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:03:12 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42cb6f3a5bcso18045085e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 14:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727989389; x=1728594189; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1ogKuEvpJG9qrjpZiP0Rtoap+HaJtxmOoDNKwVPs9vw=;
 b=h7MhsmvilE/K8Z1dmJuGEvrbMH+pKnVo6RZrL//pLOgLKod4fsWrizkf1UPn8Qx3di
 fWg4dx9lQ7d+hzte0rumjl84twimiIPbezzWJF5LA50mg1fjLjfGbrgyjCXJY7D8JDF9
 63NbCWkjJa+6iOE4hH95joRhEtF/fSzDeCiBicXCkhAMS5SpSXoPC7cBzGGL4Z734eYK
 9KQQtzND4DwHvAeX2Ke2lrYKDFc+DDzAUmQ+kqV+H2ci51CXJzSZ7RBuZmnqwK6NT9ji
 KRdG+CvuXaAM7QxCckel6wf+oYVkOEelBoqFb+9/uqRu3sOHXKg98c32b5VaQt8Z5H7E
 WuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727989389; x=1728594189;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1ogKuEvpJG9qrjpZiP0Rtoap+HaJtxmOoDNKwVPs9vw=;
 b=JD1YQ774/VnaXmqFeHgIx7XCMs41aqfTF+/cThiIlEUXypE+dKWXzPNmNsFiLlj9v4
 42XpUq66EQe4TM/x0XOhs08TdnB7hBXEgY2wHZm2DiCUdt5VQCYNYjiUuiZy3wi3ZB7b
 g/zc+cMMPFNHbQKA2hFeRKTV6rqGYyh01v97aGXZu8MUEkurDgM4lAa7NLPbBZXVn4Kn
 7QTeOkx3NyrZ1JmGUFODyUp7Arw0/4nrie8F3qT1o7PWed6gmLAANcJZqMcSxx9+CJQN
 +g0zArPQesNP+kWp0/KW4KeH+siiJCwn+HCGtq0ZHd71PBNaXovkLt7Mz2JMGqt3fI0e
 oclw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8Xkf1RI/6RK6lCBN7P9OVuJNa/0/HefNOOVBQs324R49OsDdiDtad12mzTlaKN+ZlVcXKJmLPS0dl@nongnu.org
X-Gm-Message-State: AOJu0YxGHvZm9g1ibnRubkmNLaaXanWXJWzc5LHoq2tJ6lAIe/MLG9gg
 355TcaBOd+jIHRgmm7iUxSEtfQRIJWtxm8SMOEY9v7JeGBq9cJhMjwHVjOmkLQs=
X-Google-Smtp-Source: AGHT+IE2Ql6Sc1xnLlqJP5X7PTh3Lxr5Qq/5EOoJ3tjB+HW3wf9bsMXFpAvgDhb3X7IFdfauVBaPoA==
X-Received: by 2002:a05:600c:4f52:b0:42c:bd5a:9455 with SMTP id
 5b1f17b1804b1-42f85aba082mr2946365e9.18.1727989389443; 
 Thu, 03 Oct 2024 14:03:09 -0700 (PDT)
Received: from [172.33.27.23] (134.pool62-36-43.static.orange.es.
 [62.36.43.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f7a02eb3csm52717555e9.43.2024.10.03.14.03.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 14:03:08 -0700 (PDT)
Message-ID: <71f9e218-a5a7-4f24-9b8e-a8af11ad2f41@linaro.org>
Date: Thu, 3 Oct 2024 23:03:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/spike: Replace tswap64() by ldq_endian_p()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Anton Johansson <anjo@rev.ng>, Palmer Dabbelt <palmer@dabbelt.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>
References: <20240930124831.54232-1-philmd@linaro.org>
 <c08eef57-6e93-4856-a1a4-634ce687997e@ventanamicro.com>
 <69ec3c06-ad14-4c86-8361-61dd8fbc67c7@ilande.co.uk>
 <3567507b-4e1e-4924-9088-8be3b09f552f@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3567507b-4e1e-4924-9088-8be3b09f552f@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 2/10/24 17:01, Daniel Henrique Barboza wrote:
> On 10/2/24 11:44 AM, Mark Cave-Ayland wrote:
>> On 02/10/2024 15:17, Daniel Henrique Barboza wrote:
>>
>>> Phil, this patch breaks 'make check-avocado' in my env:


>>> On 9/30/24 9:48 AM, Philippe Mathieu-Daudé wrote:
>>>> Hold the target endianness in HTIFState::target_is_bigendian.
>>>> Pass the target endianness as argument to htif_mm_init().
>>>> Replace tswap64() calls by ldq_endian_p() ones.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>> Based-on: <20240930073450.33195-2-philmd@linaro.org>
>>>>            "qemu/bswap: Introduce ld/st_endian_p() API"
>>>>
>>>> Note: this is a non-QOM device!
>>>> ---
>>>>   include/hw/char/riscv_htif.h |  4 +++-
>>>>   hw/char/riscv_htif.c         | 17 +++++++++++------
>>>>   hw/riscv/spike.c             |  2 +-
>>>>   3 files changed, 15 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/include/hw/char/riscv_htif.h 
>>>> b/include/hw/char/riscv_htif.h
>>>> index df493fdf6b..24868ddfe1 100644
>>>> --- a/include/hw/char/riscv_htif.h
>>>> +++ b/include/hw/char/riscv_htif.h
>>>> @@ -35,6 +35,7 @@ typedef struct HTIFState {
>>>>       hwaddr tohost_offset;
>>>>       hwaddr fromhost_offset;
>>>>       MemoryRegion mmio;
>>>> +    bool target_is_bigendian;
>>>>       CharBackend chr;
>>>>       uint64_t pending_read;
>>>> @@ -49,6 +50,7 @@ void htif_symbol_callback(const char *st_name, int 
>>>> st_info, uint64_t st_value,
>>>>   /* legacy pre qom */
>>>>   HTIFState *htif_mm_init(MemoryRegion *address_space, Chardev *chr,
>>>> -                        uint64_t nonelf_base, bool custom_base);
>>>> +                        uint64_t nonelf_base, bool custom_base,
>>>> +                        bool target_is_bigendian);
>>>>   #endif
>>>> diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
>>>> index 9bef60def1..77951f3c76 100644
>>>> --- a/hw/char/riscv_htif.c
>>>> +++ b/hw/char/riscv_htif.c
>>>> @@ -30,7 +30,6 @@
>>>>   #include "qemu/timer.h"
>>>>   #include "qemu/error-report.h"
>>>>   #include "exec/address-spaces.h"
>>>> -#include "exec/tswap.h"
>>>>   #include "sysemu/dma.h"
>>>>   #include "sysemu/runstate.h"
>>>> @@ -211,13 +210,17 @@ static void htif_handle_tohost_write(HTIFState 
>>>> *s, uint64_t val_written)
>>>>                       SHUTDOWN_CAUSE_GUEST_SHUTDOWN, exit_code);
>>>>                   return;
>>>>               } else {
>>>> +                bool be = s->target_is_bigendian;
>>>>                   uint64_t syscall[8];
>>>> +
>>>>                   cpu_physical_memory_read(payload, syscall, 
>>>> sizeof(syscall));
>>>> -                if (tswap64(syscall[0]) == PK_SYS_WRITE &&
>>>> -                    tswap64(syscall[1]) == HTIF_DEV_CONSOLE &&
>>>> -                    tswap64(syscall[3]) == HTIF_CONSOLE_CMD_PUTC) {
>>>> +                if (ldq_endian_p(be, &syscall[0]) == PK_SYS_WRITE &&
>>>> +                    ldq_endian_p(be, &syscall[1]) == 
>>>> HTIF_DEV_CONSOLE &&
>>>> +                    ldq_endian_p(be, &syscall[3]) == 
>>>> HTIF_CONSOLE_CMD_PUTC) {
>>>>                       uint8_t ch;
>>>> -                    cpu_physical_memory_read(tswap64(syscall[2]), 
>>>> &ch, 1);
>>>> +
>>>> +                    cpu_physical_memory_read(ldl_endian_p(be, 
>>>> &syscall[2]),
>>
>>                                                   ^^^^^^^^^^^^
>>
>> Shouldn't this be ldq_endian_p() for a 64-bit value?

Oops, thanks Mark, stupid c/p mistake.

> Bingo! This change fixes make check-avocado and the OpenSBI boot:
> 
> $ git diff
> diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
> index 77951f3c76..0ed038a70c 100644
> --- a/hw/char/riscv_htif.c
> +++ b/hw/char/riscv_htif.c
> @@ -219,7 +219,7 @@ static void htif_handle_tohost_write(HTIFState *s, 
> uint64_t val_written)
>                       ldq_endian_p(be, &syscall[3]) == 
> HTIF_CONSOLE_CMD_PUTC) {
>                       uint8_t ch;
> 
> -                    cpu_physical_memory_read(ldl_endian_p(be, 
> &syscall[2]),
> +                    cpu_physical_memory_read(ldq_endian_p(be, 
> &syscall[2]),
>                                                &ch, 1);
>                       qemu_chr_fe_write(&s->chr, &ch, 1);
>                       resp = 0x100 | (uint8_t)payload;
> 
> $ ./build/qemu-system-riscv32 -M spike --nographic
> 
> OpenSBI v1.5.1
>     ____                    _____ ____ _____
>    / __ \                  / ____|  _ \_   _|
>   | |  | |_ __   ___ _ __ | (___ | |_) || |
>   | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
>   | |__| | |_) |  __/ | | |____) | |_) || |_
>    \____/| .__/ \___|_| |_|_____/|____/_____|
>          | |
>          |_|
> (...)

I'll take that as a T-b tag :P Thanks Daniel!

