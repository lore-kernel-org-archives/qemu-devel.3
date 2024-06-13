Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC97C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 07:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHf8f-0001FW-OB; Thu, 13 Jun 2024 03:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9LeC=NP=kaod.org=clg@ozlabs.org>)
 id 1sHf8d-0001FB-7O
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 03:44:51 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9LeC=NP=kaod.org=clg@ozlabs.org>)
 id 1sHf8a-0004OZ-T6
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 03:44:50 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W0DvX6Md0z4wyf;
 Thu, 13 Jun 2024 17:44:40 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W0DvT3CRzz4wc8;
 Thu, 13 Jun 2024 17:44:37 +1000 (AEST)
Message-ID: <4d1777d6-0195-4ecb-a85f-09964268533d@kaod.org>
Date: Thu, 13 Jun 2024 09:44:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/32] hw/sd: Add mmc switch function support
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
References: <20230703132509.2474225-1-clg@kaod.org>
 <20230703132509.2474225-22-clg@kaod.org>
 <d9a20624-1813-4a29-b819-1de3961cc3cf@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <d9a20624-1813-4a29-b819-1de3961cc3cf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=9LeC=NP=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/13/24 12:49 AM, Philippe Mathieu-Daudé wrote:
> On 3/7/23 15:24, Cédric Le Goater wrote:
>> From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
>>
>> switch operation in mmc cards, updated the ext_csd register to
>> request changes in card operations. Here we implement similar
>> sequence but requests are mostly dummy and make no change.
>>
>> Implement SWITCH_ERROR if the write operation offset goes beyond length
>> of ext_csd.
>>
>> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
>> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>> [ clg: - ported on SDProto framework ]
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   hw/sd/sd.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 52 insertions(+)
> 
> 
>> +static void mmc_function_switch(SDState *sd, uint32_t arg)
>> +{
>> +    uint32_t access = extract32(arg, 24, 2);
>> +    uint32_t index = extract32(arg, 16, 8);
>> +    uint32_t value = extract32(arg, 8, 8);
>> +    uint8_t b = sd->ext_csd[index];
> 
> This field is added in the next patch :)
> 
> ../../hw/sd/sd.c:927:21: error: no member named 'ext_csd' in 'struct SDState'
>      uint8_t b = sd->ext_csd[index];
>                  ~~  ^
> ../../hw/sd/sd.c:949:9: error: no member named 'ext_csd' in 'struct SDState'
>      sd->ext_csd[index] = b;
>      ~~  ^
> 
> No need to respin, as I'm integrating your work.


Ah good !

There are 3 main parts :

   * Base eMMC support:
     hw/sd: Basis for eMMC support
     hw/sd: Add emmc_cmd_SEND_OP_CMD() handler
     hw/sd: Add emmc_cmd_ALL_SEND_CID() handler
     hw/sd: Add emmc_cmd_SET_RELATIVE_ADDR() handler
     hw/sd: Add emmc_cmd_APP_CMD() handler
     hw/sd: add emmc_cmd_SEND_TUNING_BLOCK() handler
     hw/sd: Add CMD21 tuning sequence
     hw/sd: Add mmc switch function support
     hw/sd: Add emmc_cmd_SEND_EXT_CSD() handler

   * Boot area support
     hw/sd: Support boot area in emmc image
     hw/sd: Subtract bootarea size from blk
     hw/sd: Add boot config support
     hw/sd: Fix SET_BLOCK_COUNT command argument
     hw/sd: Update CMD1 definition for MMC

   * Aspeed eMMC support :
     hw/arm/aspeed: Add eMMC device
     hw/arm/aspeed: Load eMMC first boot area as a boot rom
     hw/arm/aspeed: Set boot device to emmc
     aspeed: Set bootconfig
     aspeed: Introduce a 'boot-emmc' property for AST2600 based machines

and I can rework the aspeed part if needed.

Here is an image you can try boot on :

   https://www.kaod.org/qemu/aspeed/rainier/mmc-p10bmc.qcow2

Run with :

   qemu-system-arm -M rainier-bmc -net nic,netdev=net0 -netdev user,id=net0 -drive file=./mmc-p10bmc.qcow2,format=qcow2,if=sd,id=sd2,index=2 -nographic -serial mon:stdio

Thanks,

C.
  

>> +    switch (access) {
>> +    case MMC_CMD6_ACCESS_COMMAND_SET:
>> +        qemu_log_mask(LOG_UNIMP, "MMC Command set switching not supported\n");
>> +        return;
>> +    case MMC_CMD6_ACCESS_SET_BITS:
>> +        b |= value;
>> +        break;
>> +    case MMC_CMD6_ACCESS_CLEAR_BITS:
>> +        b &= ~value;
>> +        break;
>> +    case MMC_CMD6_ACCESS_WRITE_BYTE:
>> +        b = value;
>> +        break;
>> +    }
>> +
>> +    if (index >= 192) {
>> +        sd->card_status |= R_CSR_SWITCH_ERROR_MASK;
>> +        return;
>> +    }
>> +
>> +    sd->ext_csd[index] = b;
>> +}
> 


