Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7AAEA8124
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 14:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vppB5-00077R-Mj; Tue, 10 Feb 2026 09:57:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vppB2-00072F-VV
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:57:21 -0500
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vppAy-0004gR-Tl
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:57:20 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.249.68])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4f9PmS0HQtz5w9T;
 Tue, 10 Feb 2026 14:57:12 +0000 (UTC)
Received: from kaod.org (37.59.142.102) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 10 Feb
 2026 15:57:11 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R004d70a592a-8e8d-4dca-9dfb-f4d26cca8ab0,
 013E132ABECAD38B5622F7607EFF7317793E1520) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <10afb416-c681-4049-98e4-8d6d796f6ddd@kaod.org>
Date: Tue, 10 Feb 2026 15:57:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hw/i2c/aspeed_i2c: Fix out-of-bounds read in I2C
 MMIO handlers
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
References: <20260210024331.3984696-1-jamin_lin@aspeedtech.com>
 <20260210024331.3984696-2-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSBDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQGthb2Qub3JnPsLBeAQTAQIAIgUCW7yjdQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AACgkQUaNDx8/77KGRSxAAuMJJMhJdj7acTcFtwof7CDSfoVX0owE2FJdd
 M43hNeTwPWlV5oLCj1BOQo0MVilIpSd9Qu5wqRD8KnN2Bv/rllKPqK2+i8CXymi9hsuzF56m
 76wiPwbsX54jhv/VYY9Al7NBknh6iLYJiC/pgacRCHtSj/wofemSCM48s61s1OleSPSSvJE/
 jYRa0jMXP98N5IEn8rEbkPua/yrm9ynHqi4dKEBCq/F7WDQ+FfUaFQb4ey47A/aSHstzpgsl
 TSDTJDD+Ms8y9x2X5EPKXnI3GRLaCKXVNNtrvbUd9LsKymK3WSbADaX7i0gvMFq7j51P/8yj
 neaUSKSkktHauJAtBNXHMghWm/xJXIVAW8xX5aEiSK7DNp5AM478rDXn9NZFUdLTAScVf7LZ
 VzMFKR0jAVG786b/O5vbxklsww+YXJGvCUvHuysEsz5EEzThTJ6AC5JM2iBn9/63PKiS3ptJ
 QAqzasT6KkZ9fKLdK3qtc6yPaSm22C5ROM3GS+yLy6iWBkJ/nEYh/L/du+TLw7YNbKejBr/J
 ml+V3qZLfuhDjW0GbeJVPzsENuxiNiBbyzlSnAvKlzda/sBDvxmvWhC+nMRQCf47mFr8Xx3w
 WtDSQavnz3zTa0XuEucpwfBuVdk4RlPzNPri6p2KTBhPEvRBdC9wNOdRBtsP9rAPjd52d73O
 wU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhWpOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNL
 SoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZKXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVU
 cP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwpbV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+
 S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc
 9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFUCSLB2AE4wXQkJbApye48qnZ09zc929df5gU6
 hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iSYBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616d
 tb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6gLxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/
 t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1c
 OY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0SdujWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475
 KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/JxIqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8
 o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoX
 ywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjKyKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0
 IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9jhQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Ta
 d2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yops302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it
 +OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/pLHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1n
 HzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBUwYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVIS
 l73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lUXOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY
 3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfAHQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4Pls
 ZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQizDiU6iOrUzBThaMhZO3i927SG2DwWDVzZlt
 KrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gDuVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260210024331.3984696-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.102]
X-ClientProxiedBy: DAG3EX2.mxp5.local (172.16.2.22) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: 9eab6640-243e-405a-a0ce-0902ccfa44e9
X-Ovh-Tracer-Id: 5136073900443798450
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTE2zbw9FOQ/Ui7D025MkYEGF6Y1AfegVl+MQNXvCwgOhNCiMp8G9Dn7QGMxn9uy2i5cuFDG+NsR+4pKv7Jo3Z6Qn65Dh4PnSxxMoQSXgacIO1kKniEuYGI+jxFLXFMmBqgu3pAA3D3Cbh+zBEiaVN7Ta6X0KtzkYrTl9k5RAA2Y8bywqtGfPDRsW3CWLszPGV1dvvAtFJ8DdbKjGueLhUvPxkbBhj2tGKT7zRDBMffDhGW4lPF11M8FdXt63yKS9ib3dUNbL5MnJvXcyrJp7f9p2VKIk8BmdoSK2yKstE0woiAG/BYhphaHHmZfbA4IQ+4XHflUN/fq8oIaugViidCJYt7Bvf3kXn1SxWjnmibn7y4m/YK/sj/8OsiMDQp3BPSsmVUf8w8hQHVQv2WCtLO2GNFepuGlMIJ9VxdqF72ty8J+aP6sZLXgU4wUZ5r5+Ey106DHPhYp8hwEADnxCNheDqkucJ5GN8egtmb2hSU0QqZB7ltjKqrLFOKGiXh29oBrIi3zThNHsA/+7rQwH7bHkC+dJVU5vMvb1Wm/NO0IkhTGRPByihZPNFI4ER0imHL6RiDetT3+VM8+WsgoHASJZ1CN+xpB04rCZiWoCqjSLcNhiN+eJjlClhYi0kM69ANcPle0hdsCPKnmimbnwD39jOQoLNMDufbGF3hB8V6m1g
DKIM-Signature: a=rsa-sha256; bh=f2mdjkVxWy3VPpPuYYXzI4ptS2A6qdM0skuGa/E7oXM=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770735433; v=1;
 b=QKGhlYxe9Apg8YBWQuF+E1UFrmf197iu6rPgPqmdAsNcYcD4NAeqbCJy4V6F2mSDQ5IpXRYl
 N/JRVrVMQI+BF/FXn81es8qkLqmBZWnxqcqKRKsa4bfd3g8LNNv+9Q/cBfSO9BTG99LHwPJV8tV
 0bWF8iqp6+Fe7LU+XAjvO7PGLTNIYBGn2P1j0c1fgt0OmtoBsFNnmLrv1DfNLwafgu8Bm0dqw2S
 bMi5V+Z9WDVOshCHrgqWwktVZQWBp9CsXgPmUYyBRcdzO3IMFIdt8XTff2iY/8qioXyOUpAOGP0
 Mv2wDAibEeb244/Uo+Q+aPQQuBv4kNtAxSXRAD3iR0PyQ==
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/10/26 03:43, Jamin Lin wrote:
> The ASPEED I2C controller exposes a per-bus MMIO window of 0x80 bytes on
> AST2600/AST1030/AST2700, but the backing regs[] array was sized for only
> 28 dwords (0x70 bytes). This allows guest reads in the range [0x70..0x7f]
> to index past the end of regs[].
> 
> Fix this by:
> - Sizing ASPEED_I2C_NEW_NUM_REG to match the 0x80-byte window
>    (0x80 >> 2 = 32 dwords).
> - Avoiding an unconditional pre-read from regs[] in the legacy/new read
>    handlers. Initialize the return value to -1 and only read regs[] for
>    offsets that are explicitly handled/valid, leaving invalid offsets to
>    return -1 with a guest error log.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3290

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/i2c/aspeed_i2c.h |  3 +--
>   hw/i2c/aspeed_i2c.c         | 22 ++++++++++------------
>   2 files changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
> index 68bd138026..1ba0112cef 100644
> --- a/include/hw/i2c/aspeed_i2c.h
> +++ b/include/hw/i2c/aspeed_i2c.h
> @@ -36,8 +36,7 @@ OBJECT_DECLARE_TYPE(AspeedI2CState, AspeedI2CClass, ASPEED_I2C)
>   #define ASPEED_I2C_NR_BUSSES 16
>   #define ASPEED_I2C_SHARE_POOL_SIZE 0x800
>   #define ASPEED_I2C_BUS_POOL_SIZE 0x20
> -#define ASPEED_I2C_OLD_NUM_REG 11
> -#define ASPEED_I2C_NEW_NUM_REG 28
> +#define ASPEED_I2C_NEW_NUM_REG (0x80 >> 2)
>   
>   #define A_I2CD_M_STOP_CMD       BIT(5)
>   #define A_I2CD_M_RX_CMD         BIT(3)
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index fb3d6a5600..741c7a7297 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -94,7 +94,7 @@ static uint64_t aspeed_i2c_bus_old_read(AspeedI2CBus *bus, hwaddr offset,
>                                           unsigned size)
>   {
>       AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
> -    uint64_t value = bus->regs[offset / sizeof(*bus->regs)];
> +    uint64_t value = -1;
>   
>       switch (offset) {
>       case A_I2CD_FUN_CTRL:
> @@ -105,7 +105,7 @@ static uint64_t aspeed_i2c_bus_old_read(AspeedI2CBus *bus, hwaddr offset,
>       case A_I2CD_DEV_ADDR:
>       case A_I2CD_POOL_CTRL:
>       case A_I2CD_BYTE_BUF:
> -        /* Value is already set, don't do anything. */
> +        value = bus->regs[offset / sizeof(*bus->regs)];
>           break;
>       case A_I2CD_CMD:
>           value = SHARED_FIELD_DP32(value, BUS_BUSY_STS, i2c_bus_busy(bus->bus));
> @@ -113,21 +113,20 @@ static uint64_t aspeed_i2c_bus_old_read(AspeedI2CBus *bus, hwaddr offset,
>       case A_I2CD_DMA_ADDR:
>           if (!aic->has_dma) {
>               qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA support\n",  __func__);
> -            value = -1;
>               break;
>           }
> +        value = bus->regs[offset / sizeof(*bus->regs)];
>           break;
>       case A_I2CD_DMA_LEN:
>           if (!aic->has_dma) {
>               qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA support\n",  __func__);
> -            value = -1;
> +            break;
>           }
> +        value = bus->regs[offset / sizeof(*bus->regs)];
>           break;
> -
>       default:
>           qemu_log_mask(LOG_GUEST_ERROR,
>                         "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func__, offset);
> -        value = -1;
>           break;
>       }
>   
> @@ -139,7 +138,7 @@ static uint64_t aspeed_i2c_bus_new_read(AspeedI2CBus *bus, hwaddr offset,
>                                           unsigned size)
>   {
>       AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
> -    uint64_t value = bus->regs[offset / sizeof(*bus->regs)];
> +    uint64_t value = -1;
>   
>       switch (offset) {
>       case A_I2CC_FUN_CTRL:
> @@ -159,13 +158,12 @@ static uint64_t aspeed_i2c_bus_new_read(AspeedI2CBus *bus, hwaddr offset,
>       case A_I2CS_CMD:
>       case A_I2CS_INTR_CTRL:
>       case A_I2CS_DMA_LEN_STS:
> -        /* Value is already set, don't do anything. */
> +    case A_I2CS_INTR_STS:
> +        value = bus->regs[offset / sizeof(*bus->regs)];
>           break;
>       case A_I2CC_DMA_ADDR:
>           value = extract64(bus->dma_dram_offset, 0, 32);
>           break;
> -    case A_I2CS_INTR_STS:
> -        break;
>       case A_I2CM_CMD:
>           value = SHARED_FIELD_DP32(value, BUS_BUSY_STS, i2c_bus_busy(bus->bus));
>           break;
> @@ -176,13 +174,13 @@ static uint64_t aspeed_i2c_bus_new_read(AspeedI2CBus *bus, hwaddr offset,
>           if (!aic->has_dma64) {
>               qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA 64 bits support\n",
>               __func__);
> -            value = -1;
> +            break;
>           }
> +        value = bus->regs[offset / sizeof(*bus->regs)];
>           break;
>       default:
>           qemu_log_mask(LOG_GUEST_ERROR,
>                         "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func__, offset);
> -        value = -1;
>           break;
>       }
>   


