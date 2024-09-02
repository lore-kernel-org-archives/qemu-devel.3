Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163F1CA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 13:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl6nd-0003ef-GZ; Mon, 02 Sep 2024 09:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3a9v=QA=kaod.org=clg@ozlabs.org>)
 id 1sl6na-0003cH-Hc; Mon, 02 Sep 2024 09:08:50 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3a9v=QA=kaod.org=clg@ozlabs.org>)
 id 1sl6nY-0004xV-32; Mon, 02 Sep 2024 09:08:50 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Wy8G14NyCz4xDT;
 Mon,  2 Sep 2024 23:08:41 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wy8Fw0GDfz4x2M;
 Mon,  2 Sep 2024 23:08:32 +1000 (AEST)
Message-ID: <ffb6506a-3903-4f7f-b3ef-744e9877d8a1@kaod.org>
Date: Mon, 2 Sep 2024 15:08:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] hw/i2c/aspeed: support discontinuous register
 memory region of I2C bus
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240808024916.1262715-1-jamin_lin@aspeedtech.com>
 <20240808024916.1262715-2-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240808024916.1262715-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=3a9v=QA=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 8/8/24 04:49, Jamin Lin wrote:
> It only support continuous register memory region for all I2C bus.
> However, the register address of all I2c bus are discontinuous
> for AST2700.
> 
> Ex: the register address of I2C bus for ast2700 as following.
> 0x100 - 0x17F: Device 0
> 0x200 - 0x27F: Device 1
> 0x300 - 0x37F: Device 2
> 0x400 - 0x47F: Device 3
> 0x500 - 0x57F: Device 4
> 0x600 - 0x67F: Device 5
> 0x700 - 0x77F: Device 6
> 0x800 - 0x87F: Device 7
> 0x900 - 0x97F: Device 8
> 0xA00 - 0xA7F: Device 9
> 0xB00 - 0xB7F: Device 10
> 0xC00 - 0xC7F: Device 11
> 0xD00 - 0xD7F: Device 12
> 0xE00 - 0xE7F: Device 13
> 0xF00 – 0xF7F: Device 14
> 0x1000 – 0x107F: Device 15
> 
> Introduce a new class attribute to make user set each I2C bus gap size.
> Update formula to create all I2C bus register memory regions.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/i2c/aspeed_i2c.c         | 3 ++-
>   include/hw/i2c/aspeed_i2c.h | 1 +
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index b52a99896c..9c222a02fe 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -1012,6 +1012,7 @@ static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
>       SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>       AspeedI2CState *s = ASPEED_I2C(dev);
>       AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(s);
> +    uint32_t reg_offset = aic->reg_size + aic->reg_gap_size;
>   
>       sysbus_init_irq(sbd, &s->irq);
>       memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_i2c_ctrl_ops, s,
> @@ -1034,7 +1035,7 @@ static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
>               return;
>           }
>   
> -        memory_region_add_subregion(&s->iomem, aic->reg_size * (i + offset),
> +        memory_region_add_subregion(&s->iomem, reg_offset * (i + offset),
>                                       &s->busses[i].mr);
>       }
>   
> diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
> index fad5e9259a..02ede85906 100644
> --- a/include/hw/i2c/aspeed_i2c.h
> +++ b/include/hw/i2c/aspeed_i2c.h
> @@ -275,6 +275,7 @@ struct AspeedI2CClass {
>   
>       uint8_t num_busses;
>       uint8_t reg_size;
> +    uint32_t reg_gap_size;
>       uint8_t gap;
>       qemu_irq (*bus_get_irq)(AspeedI2CBus *);
>   


