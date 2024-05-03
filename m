Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D612C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 14:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2u15-0004Sj-4B; Fri, 03 May 2024 10:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=qmem=MG=kaod.org=clg@ozlabs.org>)
 id 1s2u13-0004SB-Mj; Fri, 03 May 2024 10:36:01 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=qmem=MG=kaod.org=clg@ozlabs.org>)
 id 1s2u10-00089l-M6; Fri, 03 May 2024 10:36:01 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VWCyw6yNXz4xPX;
 Sat,  4 May 2024 00:35:52 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VWCyr29Btz4x1y;
 Sat,  4 May 2024 00:35:47 +1000 (AEST)
Message-ID: <39abc9f5-7f5f-4361-954c-489842c0bfd0@kaod.org>
Date: Fri, 3 May 2024 16:35:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/16] aspeed/smc: fix dma moving incorrect data length
 issue
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>,
 Yunlin Tang <yunlin.tang@aspeedtech.com>
References: <20240416091904.935283-1-jamin_lin@aspeedtech.com>
 <20240416091904.935283-8-jamin_lin@aspeedtech.com>
 <90a930b9-ec7f-47fc-bfc9-f4ac0958ef83@kaod.org>
 <cd94d997-8989-4518-ac9f-ab6a544ba77e@kaod.org>
 <SI2PR06MB504122AE11599095D521AA4AFC1A2@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <SI2PR06MB504122AE11599095D521AA4AFC1A2@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=qmem=MG=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/30/24 10:51, Jamin Lin wrote:
> Hi Cedric,
>> On 4/19/24 15:41, Cédric Le Goater wrote:
>>> On 4/16/24 11:18, Jamin Lin wrote:
>>>> DMA length is from 1 byte to 32MB for AST2600 and AST10x0 and DMA
>>>> length is from 4 bytes to 32MB for AST2500.
>>>>
>>>> In other words, if "R_DMA_LEN" is 0, it should move at least 1 byte
>>>> data for AST2600 and AST10x0 and 4 bytes data for AST2500.
>>>>> To support all ASPEED SOCs, adds dma_start_length parameter to store
>>>> the start length, add helper routines function to compute the dma
>>>> length and update DMA_LENGTH mask to "1FFFFFF" to fix dma moving
>>>> incorrect data length issue.
>>>
>>> OK. There are two problems to address, the "zero" length transfer and
>>> the DMA length unit, which is missing today. Newer SoC use a 1 bit /
>>> byte and older ones, AST2400 and AST2500, use 1 bit / 4 bytes.
>>>
>>> We can introduce a AspeedSMCClass::dma_len_unit and rework the loop to :
>>>
>>>       do {
>>>
>>>         ....
>>>
>>>          if (s->regs[R_DMA_LEN]) {
>>>               s->regs[R_DMA_LEN] -= 4 / asc->dma_len_unit;
>>>           }
>>>       } while (s->regs[R_DMA_LEN]);
>>>
>>> It should fix the current implementation.
>>
>>
>> I checked what FW is doing on a QEMU ast2500-evb machine :
>>
>>       U-Boot 2019.04-v00.04.12 (Sep 29 2022 - 10:40:37 +0000)
>>       ...
>>
>>          Loading Kernel Image ... aspeed_smc_write @0x88 size 4:
>> 0x80001000
>>       aspeed_smc_write @0x84 size 4: 0x20100130
>>       aspeed_smc_write @0x8c size 4: 0x3c6770
>>       aspeed_smc_write @0x80 size 4: 0x1
>>       aspeed_smc_dma_rw read flash:@0x00100130 dram:@0x1000
>> size:0x003c6774
>>       aspeed_smc_read @0x8 size 4: 0x800
>>       aspeed_smc_write @0x80 size 4: 0x0
>>       OK
>>          Loading Ramdisk to 8fef2000, end 8ffff604 ... aspeed_smc_write
>> @0x88 size 4: 0x8fef2000
>>       aspeed_smc_write @0x84 size 4: 0x204cdde0
>>       aspeed_smc_write @0x8c size 4: 0x10d604
>>       aspeed_smc_write @0x80 size 4: 0x1
>>       aspeed_smc_dma_rw read flash:@0x004cdde0 dram:@0xfef2000
>> size:0x0010d608
>>       aspeed_smc_read @0x8 size 4: 0x800
>>       aspeed_smc_write @0x80 size 4: 0x0
>>       OK
>>          Loading Device Tree to 8fee7000, end 8fef135e ... aspeed_smc_write
>> @0x88 size 4: 0x8fee7000
>>       aspeed_smc_write @0x84 size 4: 0x204c69b4
>>       aspeed_smc_write @0x8c size 4: 0x7360
>>       aspeed_smc_write @0x80 size 4: 0x1
>>       aspeed_smc_dma_rw read flash:@0x004c69b4 dram:@0xfee7000
>> size:0x00007364
>>       aspeed_smc_read @0x8 size 4: 0x800
>>       aspeed_smc_write @0x80 size 4: 0x0
>>       OK
>>
>>       Starting kernel ...
>>
>> It seems that the R_DMA_LEN register is set by FW without taking into account
>> the length unit ( bit / 4 bytes). Would you know why ?
>>
> https://github.com/AspeedTech-BMC/u-boot/blob/aspeed-master-v2019.04/lib/string.c#L559
> This line make user input data length 4 bytes alignment.
> https://github.com/AspeedTech-BMC/u-boot/blob/aspeed-master-v2019.04/arch/arm/mach-aspeed/ast2500/utils.S#L35

yes. I don't see any 1bit / 4bytes conversion when setting the DMA_LEN
register. Am I mistaking ? That's not what the specs says.

> This line set the value of count parameter to AST_FMC_DNA_LENGTH.
> AST_FMC_DMA_LENGTH is 4 bytes alignment value.
> Example: input 4
> ((4+3)/4) * 4 --> (7/4) *4 ---> 4
> If AST_FMC_DMA_LENGTH is 0, it means it should move 4 bytes data and AST_FMC_DMA_LENGTH do not need to be divided by 4.

ok. For that, I think you could replace aspeed_smc_dma_len() with

    return QEMU_ALIGN_UP(s->regs[R_DMA_LEN] + asc->dma_start_length, 4);

Thanks,

C.



> 
>> If I change the model to match 1 bit / 4 bytes unit of the R_DMA_LEN register.
>> Linux fails to boot. I didn't dig further and this is something we need to
>> understand before committing.
>>
>>> I don't think this is necessary to add a Fixes tag because the problem
>>> has been there for ages and no one reported it. Probably because the
>>> only place DMA transfers are used is in U-Boot and transfers have a
>>> non-zero length.
>>>
>>>> Currently, only supports dma length 4 bytes aligned.
>>
>> Is this 4 bytes alignment new for the AST2700 or is this something you added
>> because the mask of DMA_LENGTH is now relaxed to match all addresses ?
>>
>> #define DMA_LENGTH(val)         ((val) & 0x01FFFFFF)
> AST2700, AST2600 and AST1030 is from 1 byte to 1FFFFFF, so I change this Micro to fix data lost.
> https://github.com/AspeedTech-BMC/u-boot/blob/aspeed-master-v2023.10/arch/arm/mach-aspeed/ast2700/spi.c#L186
> Please see this line, it decrease dma_len 1 byte first then, set to DMA_LEN register because DMA_LEN is 0 which means should move 1 byte data if DMA enables for AST2600, AST1030 and AST2700.
>>
>> Thanks,
>>
>> C.
> 
> Only AST2500 need 4 bytes alignment for DMA Length. However, according to the design of sapped_smc_dma_rw function,
> it utilizes address_space_stl_le API and it only works data 4 bytes alignment. https://github.com/qemu/qemu/blob/master/hw/ssi/aspeed_smc.c#L889
> For example,
> If users want to move 0x101 data_length, after 0x100 data has been moved and remains 1 byte data need to be moved.
> Please see this line program, https://github.com/qemu/qemu/blob/master/hw/ssi/aspeed_smc.c#L940
> ```
> s->regs[R_DMA_LEN] -= 4;
> ```
> The value of s->regs[R_DMA_LEN] becomes 0xffffffffXX because it is uint32_t data type and this while loop run in the unexpected behavior, https://github.com/qemu/qemu/blob/master/hw/ssi/aspeed_smc.c#L864
> That was, why I set 4bytes alignment for all models.
> 
> 


