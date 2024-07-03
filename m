Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B163C30658
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 01:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOp2A-0001Nu-Pt; Tue, 02 Jul 2024 21:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sOp29-0001NW-6t; Tue, 02 Jul 2024 21:43:45 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sOp26-0003tu-US; Tue, 02 Jul 2024 21:43:44 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B82EE4E6004;
 Wed, 03 Jul 2024 03:43:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id dlDnWnh8x76g; Wed,  3 Jul 2024 03:43:35 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D63EA4E6001; Wed, 03 Jul 2024 03:43:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D4767746E3B;
 Wed, 03 Jul 2024 03:43:35 +0200 (CEST)
Date: Wed, 3 Jul 2024 03:43:35 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Zheyu Ma <zheyuma97@gmail.com>
cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/display/sm501: Validate local memory size index in
 sm501_system_config_write
In-Reply-To: <20240702222402.3070730-1-zheyuma97@gmail.com>
Message-ID: <638ce3f8-f17f-658d-7d5c-ff904c7f706d@eik.bme.hu>
References: <20240702222402.3070730-1-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 3 Jul 2024, Zheyu Ma wrote:
> In sm501_system_config_write(), we update the local memory size index
> based on the incoming value. However, there was no check to ensure
> that the index is within the valid range, which could result in
> a buffer overflow.
>
> This commit adds a check to ensure that the local memory size index
> is within the valid range before updating it. If the index is not
> valid, an error is logged and the index is not updated.
>
> ASAN log:
> ==3067247==ERROR: AddressSanitizer: global-buffer-overflow on address 0x55c6586e4d3c at pc 0x55c655d4e0ac bp 0x7ffc9d5c6a10 sp 0x7ffc9d5c6a08
> READ of size 4 at 0x55c6586e4d3c thread T0
>    #0 0x55c655d4e0ab in sm501_2d_operation qemu/hw/display/sm501.c:729:21
>    #1 0x55c655d4b8a1 in sm501_2d_engine_write qemu/hw/display/sm501.c:1551:13
>
> Reproducer:
> cat << EOF | qemu-system-x86_64  \
> -display none -machine accel=qtest, -m 512M -machine q35 -nodefaults \
> -device sm501 -qtest stdio
> outl 0xcf8 0x80000814
> outl 0xcfc 0xe4000000
> outl 0xcf8 0x80000804
> outw 0xcfc 0x02
> writel 0xe4000010 0xe000
> writel 0xe4100010 0x10000
> writel 0xe4100008 0x10001
> writel 0xe410000c 0x80000000
> EOF
>
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
> hw/display/sm501.c | 12 ++++++++++--
> 1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 26dc8170d8..2cdfeaacab 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -1020,11 +1020,19 @@ static void sm501_system_config_write(void *opaque, hwaddr addr,
>         s->gpio_63_32_control = value & 0xFF80FFFF;
>         break;
>     case SM501_DRAM_CONTROL:
> -        s->local_mem_size_index = (value >> 13) & 0x7;
> -        /* TODO : check validity of size change */
> +    {
> +        int local_mem_size_index = (value >> 13) & 0x7;
> +        if (local_mem_size_index < ARRAY_SIZE(sm501_mem_local_size)) {
> +            s->local_mem_size_index = local_mem_size_index;
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "sm501: Invalid local_mem_size_index value: %d\n",
> +                          local_mem_size_index);
> +        }

Thanks. This fixes the overflow in the size index array but we may need to 
also check if it would set it to larger than 
memory_region_size(&s->local_mem_region) otherwise 2d operations may 
overflow that.

Regards,
BALATON Zoltan

>         s->dram_control &= 0x80000000;
>         s->dram_control |= value & 0x7FFFFFC3;
>         break;
> +    }
>     case SM501_ARBTRTN_CONTROL:
>         s->arbitration_control = value & 0x37777777;
>         break;
>

