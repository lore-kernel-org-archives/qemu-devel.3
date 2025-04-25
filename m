Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9F4C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 12:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8IFR-0002Ft-EI; Fri, 25 Apr 2025 08:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8IFP-0002Cp-Ao
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:33:39 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8IFN-0005ZD-EH
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 08:33:38 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2255003f4c6so23664475ad.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 05:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745584415; x=1746189215; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UIyb3tajohBn41IvsVzzTeHub8Xedi+O49qE04sxOw0=;
 b=XLVxdKRxRfIaVko5qsdxbkff76OcFJ+KFu/Qf3R+zY/b+w9cF2V9hHzJ7EjyDziyep
 WlJ8Ce42xd9YgafssvNAmWt6UCfg98k+V5OLHc1Ppw+mTQYBuxbQn6coi1Q6w4cePm6L
 ARKptFX7W0CUvUXIcWhTjmbcbQog3KAcMe2l7gvqapbqTv+m8RAEjny7Dtelz49FQMgm
 CMO4fp9YztM41AyFK68onFTVIYznAYYjoCpaQegCK6CYn6PSJc5/F0/ATAsK8E4EWG1K
 D6QLoMMh3gyziW0LJlDQoxedeUHU3kccIBUrRw8K9RrSCaXSLYV+EnTDlSPY6nOahpez
 FJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745584415; x=1746189215;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UIyb3tajohBn41IvsVzzTeHub8Xedi+O49qE04sxOw0=;
 b=iKG7VOrxV1ApzZfGSLbHxGfP9hdUVB/CfhaR/LTSmDjG5OmR3jlHwmlL6CmzXDzQM0
 5HJAhVb766FG06FwAsKb8m/aOknjpvkmaFMAIBAiOMJbUMK24OLzTzC1lRNuCw5jFuqy
 lPeqXxGr6UXDQPZbMxzm65CkxmVdN0gs5xtYCscKt4PhizS9+2Ww1RATCz4yFLX542Zd
 a4Xc5P30oRfKB4IoJ7Ivat/aE5GjuBoloE+vG03SbRvAQLxLGTSUXfPeL1UGDfHNjAYt
 CjDSxVUzS5P9k5CDaTelfH7HktNEd+Y7scStD/9dmE7lmffna8vJoQPC1OiJkTa74/jc
 tnBg==
X-Gm-Message-State: AOJu0Yw2IAyP2MRFawFy+Y4zGQE3H+GWCfIprtxlAcrQebYtactBgf1h
 FZTfHIRyXtgV8NqpSG1lua5x66Gv3SWKFi1odP9dvmJ9TDASL8um2mngjzMyWDk=
X-Gm-Gg: ASbGncsFX6RjOnYJgNYzuZdrvQARdpLzZkTVn6kdMF+7ENIUmuZ0gDjMEus78dtRWKp
 yhTEuJkpoAvunZQe3Zz9OsLLeQ3NpPD5liAJBhT3yWl3pGW6qt1w75Vh+DXKTSTOfXc+j1LA5i2
 BiKxG5XIbvQjmX9FtmcYZtVOwvPHzNi962Pmh4dP8fyUFMaFgBl5Ejae9Z6/p+HcNXQPU3tYEoB
 OBwNWCxN6c+V01VHRiTdATImXfv8Ihh6nT/ib0q5FQrvGOQiu6EkRw2Jm9Gag5kxi27TCz8AYUJ
 JkG88N1RX8JamsV/bbogvD6d/3mDrJwXZfOdnAythg7o4y+eOEnMJCA=
X-Google-Smtp-Source: AGHT+IFsuOgb4AfDfFtK9DsAg/Z4N27i3msPmoOHBa83Kd+/b7ivqbld+jhH/B9tX7qIkhqzLhoKTA==
X-Received: by 2002:a17:902:d492:b0:221:331:1d46 with SMTP id
 d9443c01a7336-22dbf5d9d49mr32266565ad.2.1745584415652; 
 Fri, 25 Apr 2025 05:33:35 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5216a32sm30695405ad.219.2025.04.25.05.33.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 05:33:35 -0700 (PDT)
Message-ID: <3b31ef8d-87aa-4a38-8ada-39490f7a4908@ventanamicro.com>
Date: Fri, 25 Apr 2025 09:33:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] hw/riscv/virt.c: remove 'long' casts in fmt strings
To: Joel Stanley <joel@jms.id.au>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20250423110630.2249904-1-dbarboza@ventanamicro.com>
 <20250423110630.2249904-10-dbarboza@ventanamicro.com>
 <CACPK8Xei9L_82YV7+wPmTacEh2MNLFticOEny_6kSM9miCAt2w@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CACPK8Xei9L_82YV7+wPmTacEh2MNLFticOEny_6kSM9miCAt2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x634.google.com
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



On 4/24/25 6:41 AM, Joel Stanley wrote:
> On Wed, 23 Apr 2025 at 20:39, Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>>
>> We can avoid the 'long' casts by using PRIx64 and HWADDR_PRIx on the fmt
>> strings for uint64_t and hwaddr types.
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   hw/riscv/virt.c | 29 +++++++++++++++--------------
>>   1 file changed, 15 insertions(+), 14 deletions(-)
>>
>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>> index 036a0a9bfb..075c035f25 100644
>> --- a/hw/riscv/virt.c
>> +++ b/hw/riscv/virt.c
>> @@ -309,7 +309,7 @@ static void create_fdt_socket_memory(RISCVVirtState *s, int socket)
>>
>>       addr = s->memmap[VIRT_DRAM].base + riscv_socket_mem_offset(ms, socket);
>>       size = riscv_socket_mem_size(ms, socket);
>> -    mem_name = g_strdup_printf("/memory@%lx", (long)addr);
>> +    mem_name = g_strdup_printf("/memory@%"PRIx64, addr);
> 
> I wondered why this wasn't a HWADDR_PRIx.
> 
> addr (and NodeInfo::node_mem?) could be a hwaddr? That would make
> everything more consistent.

I didn't put too much thought about it in this patch. I saw that 'addr' was an
uint64_t and just matched the format string.

As for whether this 'addr' var and NodeInfo::node_mem could be a hwaddr, at first
glance I don't see why not. There are lots of 'hwaddr' references in the memory API
(memory_region_* functions, address_space* functions, etc) so using hwaddr in the
memory context is valid.

If we want to go further, the patch that introduced hwaddr in QEMU (commit a8170e5e)
states:

---------
Rename target_phys_addr_t to hwaddr

target_phys_addr_t is unwieldly, violates the C standard (_t suffixes are
reserved) and its purpose doesn't match the name (most target_phys_addr_t
addresses are not target specific).  Replace it with a finger-friendly,
standards conformant hwaddr.
---------

So it seems to me that the idea is to have an abstraction of target independent
physical addresses, and memory is a good example of that. I believe we're not
making full use of hwaddr and overusing uint64_t. Thanks,


Daniel

> 
> Cheers,
> 
> Joel


