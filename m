Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800A4C5AD7B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 04:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wte8T-00054Q-4m; Tue, 11 Aug 2026 00:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wte8R-00053r-BQ; Tue, 11 Aug 2026 00:30:43 -0400
Received: from smtpout1.mo2.mail-out.ovh.net ([79.137.123.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wte8P-0006fD-AS; Tue, 11 Aug 2026 00:30:43 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo2.mail-out.ovh.net (Postfix) with ESMTPS id 4hJzFQ4fhlz43tH;
 Tue, 11 Aug 2026 04:30:34 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue, 11 Aug 2026 04:30:33 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.58.241])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hJzFP6MSWz1xs5; Tue, 11 Aug 2026 04:30:33 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.6])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id C3DD212E3EF9;
 Tue, 11 Aug 2026 04:30:31 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G002879a27af-58ae-45b3-a63f-c2199e09811d,
 803E6BE66494CDF3CD1430A16CDAFD105E03C239) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Message-ID: <9311015c-69a5-482a-99ed-93548a9f493d@kaod.org>
Date: Tue, 11 Aug 2026 06:30:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] i2c/aspeed: Fix DMA receive first-byte handling
 for block reads
To: Mikail Sadic <mikail.sadic@ibm.com>, peter.maydell@linaro.org
Cc: pbonzini@redhat.com, ninad@linux.ibm.com, titusr@google.com,
 jeuk20.kim@samsung.com, philmd@mailo.com, steven_lee@aspeedtech.com,
 leetroy@gmail.com, jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@linux.ibm.com,
 milesg@linux.ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20260810185748.1253-1-mikail.sadic@ibm.com>
 <20260810185748.1253-5-mikail.sadic@ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260810185748.1253-5-mikail.sadic@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 11919057890490887299
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFzAf7HQkFTqyu2fy66E0185S7wnOnageh8MILSIL9y2srcLsAbHU6hvy8LepSkwo8Ff3bDdgWeLV2XqagCyZh9C5AZNBbmsz5Xw3pVoR0QZMisFZNjIUtJufPaagujBoMNMNCnQ9/a7Eoh28pADVQxsNV7DyC/dSkr4ImmX53U5IBXNDwEB/77OujbHpVSO0Z6LgXnzkBJ7Hru0bfI4jcEkJH5oLIjQr/Q+JDqHJ8CH3w5q7tizUGpw0Z6huOjiL2EmBXfC26G9dTP3BE2gdhKC7WLhJpbAEcc9LKST+z76xIjR+pVN9nqHXKY166Ktt8/wKVJzLdBafRdElgfKICwIr9x5A3glEuVpvQQJNB6TRHjy6yoc+ULh7FoI9mJeGjYmZdydg+9jFkdeaB0wK0A7zjdil5V+429yIGBd7bjn0cbGJohDhXLBOBjFsGml108hru0ycw59njj+iM5eVuMwsnunK13N0hk0/HY0hYzbDG2ajj0EMyS+XVE+wBJGgEiomUhrQmNmviSvo1hmsF4eYK16B7NsTRzitaMlKdJqoB+c2G7Z0P8OY/f+k9GgeHrcRppR2WDpOVR2r6HW3mF+QT+IbISAEyG+RZkUjoVZHUaOe85SwsVNsw789ebOnjHO5zH/+kV0nsKqX75UsSINuDa/pG/n+qlBB4HUAdsMQ
DKIM-Signature: a=rsa-sha256; bh=anU1q9+aapk7XZxfobfhPAVZnNabszZXotzDRiKDD2o=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1786422636; v=1;
 b=L/fIw2/mqg3a7LkNB1NMipPmEU/b5wgmI7H3hQZu0fgSLQOOT9/pKskLZLll0ccG0fQViOXK
 /vEPm6G5ab5VhCj1QAPE9dADc0YH1SaegplZzP61Q6vvGoOmLzBQLnC2TokV21RbPt6wczZ631M
 yVOOc+GNEqUCG5c3FRVQqheQskMb+qcED7cXAA8AJTeswOtatQfVQEGpjPcnOHk9JMuKMQLzGGY
 uQ8SL1qgVXoti2BFSp6jphYgPjTPEHpEqQMv8pZqRZt2Is5HCn/EjYbTVZrmz7zwB+tPh+ZpGyo
 WnnCDJOyeZb4ohHsJyc3b7jzgEYkyvYN7ZlIG1cAG/BHw==
Received-SPF: pass client-ip=79.137.123.219; envelope-from=clg@kaod.org;
 helo=smtpout1.mo2.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Jamin,

I would appreciate a feedback from you on this change.

On 8/10/26 20:57, Mikail Sadic wrote:
> An SMBus block read (I2C_M_RECV_LEN) reads the block length from the
> first received byte. The Linux/U-Boot aspeed I2C driver obtains that
> first byte from the I2CC_STS_AND_BUFF register (modelled here as
> reg_byte_buf), even when the transfer uses DMA. The DMA receive path,
> however, only wrote received data to DRAM and never updated
> reg_byte_buf, so block reads read a stale/zero length.
> 
> Mirror the first DMA-received byte into reg_byte_buf so that
> I2C_M_RECV_LEN transfers using DMA report the correct block length.
> This is required for the ucd9000 driver, which uses
> i2c_smbus_read_block_data().
> 
> Signed-off-by: Mikail Sadic <mikail.sadic@ibm.com>

Does this change deserve a Fixes: tag ?

Thanks,

C.

> ---
>   hw/i2c/aspeed_i2c.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index 27afcaecee..facb54d27e 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -365,6 +365,7 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
>       uint32_t reg_pool_ctrl = aspeed_i2c_bus_pool_ctrl_offset(bus);
>       uint32_t reg_byte_buf = aspeed_i2c_bus_byte_buf_offset(bus);
>       uint32_t reg_dma_len = aspeed_i2c_bus_dma_len_offset(bus);
> +    bool first_dma_byte;
>       int pool_rx_count = SHARED_ARRAY_FIELD_EX32(bus->regs, reg_pool_ctrl,
>                                                   RX_SIZE) + 1;
>   
> @@ -391,6 +392,7 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
>           }
>   
>           aspeed_i2c_set_rx_dma_dram_offset(bus);
> +        first_dma_byte = true;
>           while (bus->regs[reg_dma_len]) {
>               MemTxResult result;
>   
> @@ -407,6 +409,11 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
>                   return;
>               }
>   
> +            /* Mirror first byte to reg_byte_buf for I2C_M_RECV_LEN. */
> +            if (first_dma_byte) {
> +                SHARED_ARRAY_FIELD_DP32(bus->regs, reg_byte_buf, RX_BUF, data);
> +                first_dma_byte = false;
> +            }
>               bus->dma_dram_offset++;
>               bus->regs[reg_dma_len]--;
>               /* In new mode, keep track of how many bytes we RXed */


