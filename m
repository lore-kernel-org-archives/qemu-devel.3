Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92545C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 15:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhAeA-000866-VX; Mon, 04 Mar 2024 10:54:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=daq9=KK=kaod.org=clg@ozlabs.org>)
 id 1rhAe8-00085L-SN; Mon, 04 Mar 2024 10:54:32 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=daq9=KK=kaod.org=clg@ozlabs.org>)
 id 1rhAe6-0003bE-Dm; Mon, 04 Mar 2024 10:54:32 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TpNYD6DQNz4wnq;
 Tue,  5 Mar 2024 02:54:24 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TpNY96x8Wz4wcF;
 Tue,  5 Mar 2024 02:54:21 +1100 (AEDT)
Message-ID: <5e09c627-01aa-46cd-b367-b537f5b61e03@kaod.org>
Date: Mon, 4 Mar 2024 16:54:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] Add AST2700 support
Content-Language: en-US, fr
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240304092934.1953198-1-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240304092934.1953198-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=daq9=KK=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Hello Jamin,

On 3/4/24 10:29, Jamin Lin wrote:
> Changes from v1:
> The patch series supports WDT, SDMC, SMC, SCU, SLI and INTC for AST2700 SoC.
> 
> Changes from v2:
> - replace is_aarch64 with is_bus64bit for sdmc patch review.
> - fix incorrect dram size for AST2700
> 
> Test steps:
> 1. Download openbmc image for AST2700 from
>     https://github.com/AspeedTech-BMC/openbmc/releases/tag/v09.00
>     https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.00/
>     ast2700-default-obmc.tar.gz
> 2. untar ast2700-default-obmc.tar.gz
>     ```
>     tar -xf ast2700-default-obmc.tar.gz
>     ```
> 3. Run and the contents of scripts as following
> IMGDIR=ast2700-default
> UBOOT_SIZE=$(stat --format=%s -L ${IMGDIR}/u-boot-nodtb.bin)
> UBOOT_DTB_ADDR=$((0x400000000 + ${UBOOT_SIZE}))
> 
> qemu-system-aarch64 -M ast2700-evb -nographic\
>   -device loader,addr=0x400000000,file=${IMGDIR}/u-boot-nodtb.bin,force-raw=on\
>   -device loader,addr=${UBOOT_DTB_ADDR},file=${IMGDIR}/u-boot.dtb,force-raw=on\
>   -device loader,addr=0x430000000,file=${IMGDIR}/bl31.bin,force-raw=on\
>   -device loader,addr=0x430080000,file=${IMGDIR}/optee/tee-raw.bin,force-raw=on\
>   -device loader,addr=0x430000000,cpu-num=0\
>   -device loader,addr=0x430000000,cpu-num=1\
>   -device loader,addr=0x430000000,cpu-num=2\
>   -device loader,addr=0x430000000,cpu-num=3\
>   -smp 4\
>   -drive file=${IMGDIR}/image-bmc,format=raw,if=mtd\
>   -serial mon:stdio\
>   -snapshot
> 
> Known Issue:
> 1. QEMU supports ARM Generic Interrupt Controller, version 3(GICv3)
> but not support Shared Peripheral Interrupt (SPI), yet.
> Added work around in INTC patch to set GICINT132[18]
> which was BMC UART interrupt if it received GICINT132, so users are
> able to type any key from keyboard to trigger GICINT132 interrupt
> until AST2700 boot into login prompt. It is a temporary solution.
> If users encounter boot stck and no booting log,
> please type any key from keyboard.

I haven't looked at the GIC issue but I started reviewing what I
received.

The mailer issue needs to be fixed before we consider this patches
for merge. May be use an external email while keeping the same
From: and Signed-off-by address.

When you resend, could you please add an avocado test ?

Thanks,

C.


> Jamin Lin (9):
>    aspeed/wdt: Add AST2700 support
>    aspeed/sli: Add AST2700 support
>    aspeed/sdmc: Add AST2700 support
>    aspeed/smc: Add AST2700 support
>    aspeed/scu: Add AST2700 support
>    aspeed/intc: Add AST2700 support
>    aspeed/soc: Add AST2700 support
>    aspeed: Add an AST2700 eval board
>    aspeed/soc: fix incorrect dram size for AST2700
> 
>   hw/arm/aspeed.c                  |  32 ++
>   hw/arm/aspeed_ast27x0.c          | 554 +++++++++++++++++++++++++++++++
>   hw/arm/meson.build               |   1 +
>   hw/intc/aspeed_intc.c            | 135 ++++++++
>   hw/intc/meson.build              |   1 +
>   hw/misc/aspeed_scu.c             | 306 ++++++++++++++++-
>   hw/misc/aspeed_sdmc.c            | 215 ++++++++++--
>   hw/misc/aspeed_sli.c             | 179 ++++++++++
>   hw/misc/meson.build              |   3 +-
>   hw/misc/trace-events             |  11 +
>   hw/ssi/aspeed_smc.c              | 326 ++++++++++++++++--
>   hw/ssi/trace-events              |   2 +-
>   hw/watchdog/wdt_aspeed.c         |  24 ++
>   include/hw/arm/aspeed_soc.h      |  27 +-
>   include/hw/intc/aspeed_vic.h     |  29 ++
>   include/hw/misc/aspeed_scu.h     |  47 ++-
>   include/hw/misc/aspeed_sdmc.h    |   4 +-
>   include/hw/misc/aspeed_sli.h     |  32 ++
>   include/hw/ssi/aspeed_smc.h      |   1 +
>   include/hw/watchdog/wdt_aspeed.h |   3 +-
>   20 files changed, 1880 insertions(+), 52 deletions(-)
>   create mode 100644 hw/arm/aspeed_ast27x0.c
>   create mode 100644 hw/intc/aspeed_intc.c
>   create mode 100644 hw/misc/aspeed_sli.c
>   create mode 100644 include/hw/misc/aspeed_sli.h
> 


