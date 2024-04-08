Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2E8C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 10:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtmFD-0006lk-1W; Mon, 08 Apr 2024 06:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtmF7-0006l9-RP
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 06:28:49 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtmF6-00042i-64
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 06:28:49 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-56dfb52d10cso4858357a12.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 03:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712572126; x=1713176926; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nW2cG2aNDmSD+6Tw+AYal38gVj08ZJV5WAGqAMe+QZw=;
 b=T9OM47IrCMSUn+LmqTxdRgNOpRW4V8H1P/NSwmHcKwo62Lsv7o7IcLv8l4jYM2rjPA
 MLtCYoqbhUcm/t4SrMwzqaLUnVdQs8ShYH55i0qmtJzW+hPl47JTswqdJrz5rJtI8sJT
 GKM97WcCZiiXD/UDoZwua2Ntr+enyS1xJ/1BMw3yF3AsjJSZ3l14XDHkZhBvo+67Yd0G
 AzsbNSmqkUTnYcNS8uqCPF3lCH9Xsum/yWgv4cB29jSGu6RFGkQ9x7or8FInr4xk2M3k
 3ny8iAGMW0AOrfX5thjHrbb4ek08t21jAo7BpbVEvG1r9OZcewaPnSz3TGWktkE0pTq+
 mH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712572126; x=1713176926;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nW2cG2aNDmSD+6Tw+AYal38gVj08ZJV5WAGqAMe+QZw=;
 b=UNeMqaAUQUDYv16wGfSGkBbmqAER+FulCcUHWPh53CwOHpUydfhnjGg1kbCNMiC6/K
 WbKyiwOG5al1YJ9acOS2bp/xDMoAvbo+B710emJqudDw/IThtlrFuhdF2hNW8txC7XVC
 rNeMzjQqTjw95VymYD86cofwbu2FoIcwXydc85DxvlbTfmFo+WvmTmzY/W/xR1VIPRet
 z6PYPZgHMor2pkSe70Rgakku0h1BYJlxVZ0fyxUBhwQVH3TbMh0KXo6GcWQckhTGxVD2
 jB5/W034vSH8pAPuDY3W54hxGymx8w92+oo9aLLWQoghmNCC6af7qCLKJfku9Ys3p9IP
 YmTA==
X-Gm-Message-State: AOJu0YwHppxnkay0anBSLRUxErKydV9FbHolFFQtxLvonbzrZu6rJ/xq
 8C50D13OnjhTyMXeQFTXjHFIDnRuFfGsybV1rMDHCS0Cmxg69xomJFjtu2ZegJwVWB3EloKetJT
 E
X-Google-Smtp-Source: AGHT+IHzP85FLt2YVO6qxRsfA1SU+vHh4mNzJS3vwQCDOcCCH6srnIqRlVt2qtVsoUGKeoNYqHxsyQ==
X-Received: by 2002:a50:d4d8:0:b0:56d:c928:ad76 with SMTP id
 e24-20020a50d4d8000000b0056dc928ad76mr6447841edj.26.1712572126231; 
 Mon, 08 Apr 2024 03:28:46 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 fe10-20020a056402390a00b0056e4556834csm2628442edb.66.2024.04.08.03.28.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 03:28:45 -0700 (PDT)
Message-ID: <1926e063-5621-440b-a957-c9f76d4dc073@linaro.org>
Date: Mon, 8 Apr 2024 12:28:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0?] hw/net/smc91c111: Fix out of bounds access in
 packets buffer
To: qemu-devel@nongnu.org, Chuhong Yuan <hslester96@gmail.com>
Cc: Alexander Bulekov <alxndr@bu.edu>, qemu-arm@nongnu.org,
 Jason Wang <jasowang@redhat.com>
References: <20240408102711.58485-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240408102711.58485-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 8/4/24 12:27, Philippe Mathieu-Daudé wrote:
> While the Packet Number Register is 6-bit wide and could hold
> up to 64 packets [*] our implementation is clamped at 4 packets.
> 
> Reproducer:
> 
>    $ cat << EOF | qemu-system-arm -display none \
>                                   -machine mainstone,accel=qtest \
>                                   -qtest stdio
>    outl 0xcf8 0x80000010
>    outl 0xcfc 0x10000300
>    outl 0xcf8 0x80000004
>    outl 0xcfc 0x07
>    writel 0x1000030c 0x66027cd6
>    writel 0x10000300 0x64af8eda
>    readw 0x10000308
>    EOF
>    hw/net/smc91c111.c:607:24: runtime error:
>    index 175 out of bounds for type 'uint8_t[4][2048]' (aka 'unsigned char[4][2048]')
>    SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
>    =================================================================
>    ==397944==ERROR: AddressSanitizer: SEGV on unknown address 0x629000077db4
>        (pc 0x56272aed3b8d bp 0x7ffd1471f290 sp 0x7ffd1471ea20 T0)
>    ==397944==The signal is caused by a READ memory access.
>        #0 0x56272aed3b8d in smc91c111_readb hw/net/smc91c111.c:607:24
>        #1 0x56272aecfd61 in smc91c111_readfn hw/net/smc91c111.c:650:16
>        #2 0x56272d4b228b in memory_region_read_accessor system/memory.c:445:11
>        #3 0x56272d46fb85 in access_with_adjusted_size system/memory.c:573:18
>        #4 0x56272d46c58e in memory_region_dispatch_read1 system/memory.c:1426:16
>        #5 0x56272d46bcd7 in memory_region_dispatch_read system/memory.c:1459:9
>        #6 0x56272d4e8e03 in flatview_read_continue_step system/physmem.c:2794:18
>        #7 0x56272d4e871e in flatview_read_continue system/physmem.c:2835:19
>        #8 0x56272d4e98b8 in flatview_read system/physmem.c:2865:12
>        #9 0x56272d4e9388 in address_space_read_full system/physmem.c:2878:18
>        #10 0x56272d6e7840 in address_space_read include/exec/memory.h:3026:18
>        ...
> 
> Broken since model introduction in commit 80337b66a8.
> 
> [*] LAN91C111 DS00002276A.pdf, chapter 8.17, Packet Number Register
> 
> Reported-by: Will Lester

Apparently also
Reported-by: Chuhong Yuan <hslester96@gmail.com>

> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2268
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/net/smc91c111.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
> index 702d0e8e83..286298bf06 100644
> --- a/hw/net/smc91c111.c
> +++ b/hw/net/smc91c111.c
> @@ -429,7 +429,7 @@ static void smc91c111_writeb(void *opaque, hwaddr offset,
>               /* Ignore.  */
>               return;
>           case 2: /* Packet Number Register */
> -            s->packet_num = value;
> +            s->packet_num = value & (NUM_PACKETS - 1);
>               return;
>           case 3: case 4: case 5:
>               /* Should be readonly, but linux writes to them anyway. Ignore.  */


