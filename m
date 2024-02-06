Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEADC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 16:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXOid-0002kH-HV; Tue, 06 Feb 2024 11:54:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=f3tV=JP=kaod.org=clg@ozlabs.org>)
 id 1rXOib-0002jv-SI; Tue, 06 Feb 2024 11:54:45 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=f3tV=JP=kaod.org=clg@ozlabs.org>)
 id 1rXOiZ-0007rU-Tq; Tue, 06 Feb 2024 11:54:45 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TTq9B5vsQz4wd0;
 Wed,  7 Feb 2024 03:54:38 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TTq983XM5z4wcC;
 Wed,  7 Feb 2024 03:54:36 +1100 (AEDT)
Message-ID: <a9c0d2b2-2bb4-4770-97e5-5a061862da02@kaod.org>
Date: Tue, 6 Feb 2024 17:54:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0 2/2] aspeed: fix hardcode boot address 0
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20240205091415.935686-1-jamin_lin@aspeedtech.com>
 <20240205091415.935686-3-jamin_lin@aspeedtech.com>
 <46d14718-2b2c-45aa-aa12-854a2704383b@linaro.org>
 <SI2PR06MB504143638045D7666B341C09FC462@SI2PR06MB5041.apcprd06.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <SI2PR06MB504143638045D7666B341C09FC462@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=f3tV=JP=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 2/6/24 02:48, Jamin Lin wrote:
>> -----Original Message-----
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Sent: Monday, February 5, 2024 9:20 PM
>> To: Jamin Lin <jamin_lin@aspeedtech.com>; Cédric Le Goater <clg@kaod.org>;
>> Peter Maydell <peter.maydell@linaro.org>; Andrew Jeffery
>> <andrew@codeconstruct.com.au>; Joel Stanley <joel@jms.id.au>; open
>> list:ASPEED BMCs <qemu-arm@nongnu.org>; open list:All patches CC here
>> <qemu-devel@nongnu.org>
>> Cc: Troy Lee <troy_lee@aspeedtech.com>
>> Subject: Re: [PATCH v0 2/2] aspeed: fix hardcode boot address 0
>>
>> Hi Jamin,
>>
>> On 5/2/24 10:14, Jamin Lin via wrote:
>>> In the previous design of QEMU model for ASPEED SOCs, it set the boot
>>> address at 0 which was the hardcode setting for ast10x0, ast2600,
>>> ast2500 and ast2400.
>>>
>>> According to the design of ast2700, it has bootmcu which is used for
>>> executing SPL and initialize DRAM,
>>
>> Out of curiosity, what architecture is this MCU?
> MCU is riscv-ibex and its architecture is riscv-32.
> 
>>
>>> then, CPUs(cortex-a35)
>>> execute u-boot, kernel and rofs. QEMU will only support
>>> CPU(coretax-a35) parts and the boot address is "0x400000000" for ast2700.
>>
>> OK, but I don't get how you get from here ...
>>
> Our design make MCU execute SPL and copy u-boot image from SPI to DRAM at address 0x400000000 at SPL boot stage.
> However, QEMU will only support to emulate CPU sides (coretex-a35) for ast2700, 

The fby35 is an example of a machine with two ARM SoCs : ast1030-a1
and ast2600-a3. There is work in progress for heterogeneous QEMU
machines and It might be possible to model RISC-V and ARM one day.

> that was why we want to change the boot address at 0x400000000
> And use the following start command by QEMU.
> 
> ./qemu-system-aarch64 -M ast2750-evb -nographic -m 8G \
>   -device loader,addr=0x400000000,file=${IMGDIR}/u-boot-nodtb.bin,force-raw=on \
>   -device loader,addr=$((0x400000000 + ${UBOOT_SIZE})),file=${IMGDIR}/u-boot.dtb,force-raw=on \
>   ---
>   ---
ok. Makes sense.
  
> By the way, I will send a new patch series to support ast2700 in two weeks and
> We set memory map for ast2700 as following.
> 
> static const hwaddr aspeed_soc_ast2700_memmap[] = {
>      [ASPEED_DEV_SPI_BOOT]  =  0x400000000,
>      [ASPEED_DEV_SRAM]      =  0x10000000,

Excellent !

Thanks,

C.



