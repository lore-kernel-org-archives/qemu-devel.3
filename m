Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D86C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 10:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9NDF-0003Oo-6j; Tue, 21 May 2024 06:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=PaxS=MY=kaod.org=clg@ozlabs.org>)
 id 1s9NDD-0003OS-Bc
 for qemu-devel@nongnu.org; Tue, 21 May 2024 06:59:19 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=PaxS=MY=kaod.org=clg@ozlabs.org>)
 id 1s9NDA-0000L6-UM
 for qemu-devel@nongnu.org; Tue, 21 May 2024 06:59:19 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VkBJb6Gqrz4wyY;
 Tue, 21 May 2024 20:59:11 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VkBJY5ZT1z4wxt;
 Tue, 21 May 2024 20:59:09 +1000 (AEST)
Message-ID: <490c64c6-d76d-4f52-9a1c-c888305f2208@kaod.org>
Date: Tue, 21 May 2024 12:59:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/32] hw/sd: eMMC support
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bin.meng@windriver.com>, Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
References: <20230703132509.2474225-1-clg@kaod.org>
 <92eeb7a2-39d9-b725-3e38-f9ac91440b78@kaod.org>
Content-Language: en-US, fr
In-Reply-To: <92eeb7a2-39d9-b725-3e38-f9ac91440b78@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=PaxS=MY=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/28/23 18:27, Cédric Le Goater wrote:
> Hello,
> 
> On 7/3/23 15:24, Cédric Le Goater wrote:
>> Hello,
>>
>> This series adds an extension for a new eMMC device using the
>> framework Philippe put in place to support various SD implementations.
>> Previous discussion on the same topic:
>>
>>    http://patchwork.ozlabs.org/project/qemu-devel/list/?series=250563
>>    https://lore.kernel.org/qemu-devel/20220318132824.1134400-1-clg@kaod.org/
>>
>> patch 1-12
>>    - introduce SDProto structure
>>    - could be merged. They have been reviewed.
>> patch 13
>>    - adds a SPI variant model
> 
> I plan to include 1-13 in the next aspeed PR.

I plan to include the rest of this series in the next aspeed PR,
for QEMU 9.1


Thanks,

C.



> 
> Thanks,
> 
> C.
> 
>> patch 14-27
>>    - adds eMMC support
>>    - need better commit logs
>> patch 28-32 (for later)
>>
>>    - aspeed wiring
>>
>> Please comment the core part, we can leave out the aspeed part for
>> now. I won't have much time to fix the issues unless it's about
>> compile and style issues. If someone is interested and could take
>> over the series, that would be nice.
>>
>> Thanks,
>>
>> C.
>>
>> Cédric Le Goater (11):
>>    hw/sd: Introduce a "sd-card" SPI variant model
>>    hw/sd: Add emmc_cmd_SEND_OP_CMD() handler
>>    hw/sd: Add emmc_cmd_ALL_SEND_CID() handler
>>    hw/sd: Add emmc_cmd_SEND_RELATIVE_ADDR() handler
>>    hw/sd: Add emmc_cmd_APP_CMD() handler
>>    hw/sd: add emmc_cmd_SEND_TUNING_BLOCK() handler
>>    hw/sd: Add emmc_cmd_SEND_EXT_CSD() handler
>>    hw/sd: Fix SET_BLOCK_COUNT command argument
>>    hw/arm/aspeed: Add eMMC device
>>    hw/arm/aspeed: Load eMMC first boot area as a boot rom
>>    aspeed: Introduce a 'boot-emmc' property for AST2600 based machines
>>
>> Joel Stanley (6):
>>    hw/sd: Add sd_cmd_SEND_TUNING_BLOCK() handler
>>    hw/sd: Support boot area in emmc image
>>    hw/sd: Subtract bootarea size from blk
>>    hw/sd: Add boot config support
>>    hw/arm/aspeed: Set boot device to emmc
>>    aspeed: Set bootconfig
>>
>> Philippe Mathieu-Daudé (12):
>>    hw/sd: When card is in wrong state, log which state it is
>>    hw/sd: When card is in wrong state, log which spec version is used
>>    hw/sd: Move proto_name to SDProto structure
>>    hw/sd: Introduce sd_cmd_handler type
>>    hw/sd: Add sd_cmd_illegal() handler
>>    hw/sd: Add sd_cmd_unimplemented() handler
>>    hw/sd: Add sd_cmd_GO_IDLE_STATE() handler
>>    hw/sd: Add sd_cmd_SEND_OP_CMD() handler
>>    hw/sd: Add sd_cmd_ALL_SEND_CID() handler
>>    hw/sd: Add sd_cmd_SEND_RELATIVE_ADDR() handler
>>    hw/sd: Add sd_cmd_SET_BLOCK_COUNT() handler
>>    hw/sd: Basis for eMMC support
>>
>> Sai Pavan Boddu (3):
>>    hw/sd: Add CMD21 tuning sequence
>>    hw/sd: Add mmc switch function support
>>    hw/sd: Update CMD1 definition for MMC
>>
>>   docs/system/arm/aspeed.rst   |   2 +
>>   hw/sd/sdmmc-internal.h       |  97 +++++
>>   include/hw/arm/aspeed_soc.h  |   1 +
>>   include/hw/misc/aspeed_scu.h |   7 +
>>   include/hw/sd/sd.h           |  10 +
>>   hw/arm/aspeed.c              |  68 +++-
>>   hw/arm/aspeed_ast2600.c      |   1 +
>>   hw/arm/stellaris.c           |   3 +-
>>   hw/riscv/sifive_u.c          |   3 +-
>>   hw/sd/sd.c                   | 702 ++++++++++++++++++++++++++++-------
>>   hw/sd/sdmmc-internal.c       |   2 +-
>>   11 files changed, 748 insertions(+), 148 deletions(-)
>>
> 
> 


