Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16C3C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMBz-0000XQ-Ro; Thu, 18 Jul 2024 04:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3riu=OS=kaod.org=clg@ozlabs.org>)
 id 1sUMBx-0000Va-Av; Thu, 18 Jul 2024 04:08:45 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3riu=OS=kaod.org=clg@ozlabs.org>)
 id 1sUMBu-0003rW-Aw; Thu, 18 Jul 2024 04:08:44 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WPln11K9Gz4x04;
 Thu, 18 Jul 2024 18:08:37 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WPlmw0xQ3z4wbr;
 Thu, 18 Jul 2024 18:08:31 +1000 (AEST)
Message-ID: <73ecf2fa-13dc-423b-a905-532c612cb7f9@kaod.org>
Date: Thu, 18 Jul 2024 10:08:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/15] hw/i2c/aspeed: rename the I2C class pool
 attribute to share_pool
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:STM32F205" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240718064925.1846074-1-jamin_lin@aspeedtech.com>
 <20240718064925.1846074-6-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240718064925.1846074-6-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=3riu=OS=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/18/24 08:49, Jamin Lin wrote:
> According to the datasheet of ASPEED SOCs,
> each I2C bus has their own pool buffer since AST2500.
> 
> Only AST2400 utilized a pool buffer share to all I2C bus.
> And firmware required to set the offset of pool buffer
> by writing "Function Control Register(I2CD 00)"
> 
> To make this model more readable, will change to introduce
> a new bus pool buffer attribute in AspeedI2Cbus.
> So, it does not need to calculate the pool buffer offset
> for different I2C bus.
> 
> This patch rename the I2C class pool attribute to share_pool.
> It make user more understand share pool and bus pool
> are different.
> 
> Incrementing the version of aspeed_i2c_vmstate to 3.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/i2c/aspeed_i2c.c         | 39 ++++++++++++++++++++-----------------
>   include/hw/i2c/aspeed_i2c.h |  4 ++--
>   2 files changed, 23 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index 462ad78a13..9c222a02fe 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -906,7 +906,7 @@ static const MemoryRegionOps aspeed_i2c_ctrl_ops = {
>       .endianness = DEVICE_LITTLE_ENDIAN,
>   };
>   
> -static uint64_t aspeed_i2c_pool_read(void *opaque, hwaddr offset,
> +static uint64_t aspeed_i2c_share_pool_read(void *opaque, hwaddr offset,
>                                        unsigned size)
>   {
>       AspeedI2CState *s = opaque;
> @@ -914,26 +914,26 @@ static uint64_t aspeed_i2c_pool_read(void *opaque, hwaddr offset,
>       int i;
>   
>       for (i = 0; i < size; i++) {
> -        ret |= (uint64_t) s->pool[offset + i] << (8 * i);
> +        ret |= (uint64_t) s->share_pool[offset + i] << (8 * i);
>       }
>   
>       return ret;
>   }
>   
> -static void aspeed_i2c_pool_write(void *opaque, hwaddr offset,
> +static void aspeed_i2c_share_pool_write(void *opaque, hwaddr offset,
>                                     uint64_t value, unsigned size)
>   {
>       AspeedI2CState *s = opaque;
>       int i;
>   
>       for (i = 0; i < size; i++) {
> -        s->pool[offset + i] = (value >> (8 * i)) & 0xFF;
> +        s->share_pool[offset + i] = (value >> (8 * i)) & 0xFF;
>       }
>   }
>   
> -static const MemoryRegionOps aspeed_i2c_pool_ops = {
> -    .read = aspeed_i2c_pool_read,
> -    .write = aspeed_i2c_pool_write,
> +static const MemoryRegionOps aspeed_i2c_share_pool_ops = {
> +    .read = aspeed_i2c_share_pool_read,
> +    .write = aspeed_i2c_share_pool_write,
>       .endianness = DEVICE_LITTLE_ENDIAN,
>       .valid = {
>           .min_access_size = 1,
> @@ -953,14 +953,15 @@ static const VMStateDescription aspeed_i2c_bus_vmstate = {
>   
>   static const VMStateDescription aspeed_i2c_vmstate = {
>       .name = TYPE_ASPEED_I2C,
> -    .version_id = 2,
> -    .minimum_version_id = 2,
> +    .version_id = 3,
> +    .minimum_version_id = 3,
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINT32(intr_status, AspeedI2CState),
>           VMSTATE_STRUCT_ARRAY(busses, AspeedI2CState,
>                                ASPEED_I2C_NR_BUSSES, 1, aspeed_i2c_bus_vmstate,
>                                AspeedI2CBus),
> -        VMSTATE_UINT8_ARRAY(pool, AspeedI2CState, ASPEED_I2C_MAX_POOL_SIZE),
> +        VMSTATE_UINT8_ARRAY(share_pool, AspeedI2CState,
> +                            ASPEED_I2C_SHARE_POOL_SIZE),
>           VMSTATE_END_OF_LIST()
>       }
>   };
> @@ -995,7 +996,7 @@ static void aspeed_i2c_instance_init(Object *obj)
>    *   0x140 ... 0x17F: Device 5
>    *   0x180 ... 0x1BF: Device 6
>    *   0x1C0 ... 0x1FF: Device 7
> - *   0x200 ... 0x2FF: Buffer Pool  (unused in linux driver)
> + *   0x200 ... 0x2FF: Buffer Pool (AST2500 unused in linux driver)
>    *   0x300 ... 0x33F: Device 8
>    *   0x340 ... 0x37F: Device 9
>    *   0x380 ... 0x3BF: Device 10
> @@ -1003,7 +1004,7 @@ static void aspeed_i2c_instance_init(Object *obj)
>    *   0x400 ... 0x43F: Device 12
>    *   0x440 ... 0x47F: Device 13
>    *   0x480 ... 0x4BF: Device 14
> - *   0x800 ... 0xFFF: Buffer Pool  (unused in linux driver)
> + *   0x800 ... 0xFFF: Buffer Pool (AST2400 unused in linux driver)
>    */
>   static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
>   {
> @@ -1038,8 +1039,9 @@ static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
>                                       &s->busses[i].mr);
>       }
>   
> -    memory_region_init_io(&s->pool_iomem, OBJECT(s), &aspeed_i2c_pool_ops, s,
> -                          "aspeed.i2c-pool", aic->pool_size);
> +    memory_region_init_io(&s->pool_iomem, OBJECT(s),
> +                          &aspeed_i2c_share_pool_ops, s,
> +                          "aspeed.i2c-share-pool", aic->pool_size);
>       memory_region_add_subregion(&s->iomem, aic->pool_base, &s->pool_iomem);
>   
>       if (aic->has_dma) {
> @@ -1267,8 +1269,9 @@ static qemu_irq aspeed_2400_i2c_bus_get_irq(AspeedI2CBus *bus)
>   static uint8_t *aspeed_2400_i2c_bus_pool_base(AspeedI2CBus *bus)
>   {
>       uint8_t *pool_page =
> -        &bus->controller->pool[ARRAY_FIELD_EX32(bus->regs, I2CD_FUN_CTRL,
> -                                                POOL_PAGE_SEL) * 0x100];
> +        &bus->controller->share_pool[ARRAY_FIELD_EX32(bus->regs,
> +                                                      I2CD_FUN_CTRL,
> +                                                      POOL_PAGE_SEL) * 0x100];
>   
>       return &pool_page[ARRAY_FIELD_EX32(bus->regs, I2CD_POOL_CTRL, OFFSET)];
>   }
> @@ -1303,7 +1306,7 @@ static qemu_irq aspeed_2500_i2c_bus_get_irq(AspeedI2CBus *bus)
>   
>   static uint8_t *aspeed_2500_i2c_bus_pool_base(AspeedI2CBus *bus)
>   {
> -    return &bus->controller->pool[bus->id * 0x10];
> +    return &bus->controller->share_pool[bus->id * 0x10];
>   }
>   
>   static void aspeed_2500_i2c_class_init(ObjectClass *klass, void *data)
> @@ -1338,7 +1341,7 @@ static qemu_irq aspeed_2600_i2c_bus_get_irq(AspeedI2CBus *bus)
>   
>   static uint8_t *aspeed_2600_i2c_bus_pool_base(AspeedI2CBus *bus)
>   {
> -   return &bus->controller->pool[bus->id * 0x20];
> +   return &bus->controller->share_pool[bus->id * 0x20];
>   }
>   
>   static void aspeed_2600_i2c_class_init(ObjectClass *klass, void *data)
> diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
> index 422ee0e298..02ede85906 100644
> --- a/include/hw/i2c/aspeed_i2c.h
> +++ b/include/hw/i2c/aspeed_i2c.h
> @@ -34,7 +34,7 @@
>   OBJECT_DECLARE_TYPE(AspeedI2CState, AspeedI2CClass, ASPEED_I2C)
>   
>   #define ASPEED_I2C_NR_BUSSES 16
> -#define ASPEED_I2C_MAX_POOL_SIZE 0x800
> +#define ASPEED_I2C_SHARE_POOL_SIZE 0x800
>   #define ASPEED_I2C_OLD_NUM_REG 11
>   #define ASPEED_I2C_NEW_NUM_REG 22
>   
> @@ -257,7 +257,7 @@ struct AspeedI2CState {
>       uint32_t ctrl_global;
>       uint32_t new_clk_divider;
>       MemoryRegion pool_iomem;
> -    uint8_t pool[ASPEED_I2C_MAX_POOL_SIZE];
> +    uint8_t share_pool[ASPEED_I2C_SHARE_POOL_SIZE];
>   
>       AspeedI2CBus busses[ASPEED_I2C_NR_BUSSES];
>       MemoryRegion *dram_mr;


