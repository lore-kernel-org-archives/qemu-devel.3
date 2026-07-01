Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D414EC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weu6y-0002RT-5D; Wed, 01 Jul 2026 08:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1weu6u-0002Qs-GF
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:32:13 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1weu6s-00017x-Uv
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:32:12 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 426CE596707;
 Wed, 01 Jul 2026 14:32:09 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id w44ufI6MfD1M; Wed,  1 Jul 2026 14:32:07 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2FA43596704; Wed, 01 Jul 2026 14:32:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2E4425966FB;
 Wed, 01 Jul 2026 14:32:07 +0200 (CEST)
Date: Wed, 1 Jul 2026 14:32:07 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 6/7] ati-vga: Disable GUI engine MMIO writes when CCE
 enabled (r128 only)
In-Reply-To: <20260606195216.2524314-7-chad@jablonski.xyz>
Message-ID: <b0c004cb-db54-af1e-535f-d1757ac4fcfb@eik.bme.hu>
References: <20260606195216.2524314-1-chad@jablonski.xyz>
 <20260606195216.2524314-7-chad@jablonski.xyz>
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

On Sat, 6 Jun 2026, Chad Jablonski wrote:
> When the CCE engine is enabled, real r128 hardware ignores any MMIO writes to
> GUI registers (0x1400-0x1fff range). Writes made by the CCE engine are
> not affected by this.
>
> Testing on r100 shows that this behavior is specific to r128.
>
> Tested and validated against a Rage 128 Pro Ultra (PCI 1002:5446) and
> Radeon QY (RV100) (PCI 1002:5159).
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index e1ba64747b..582c646a3d 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -1183,6 +1183,15 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>     if (addr < CUR_OFFSET || addr > CUR_CLR1 || ATI_DEBUG_HW_CURSOR) {
>         trace_ati_mm_write(size, addr, ati_reg_name(addr & ~3ULL), data);
>     }
> +    if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF &&
> +        s->cce.buffer_mode && addr >= 0x1400 && addr <= 0x1fff) {

Should this go to ati_r128_mm_write then if we decided to have chip 
specific functions? I still wonder if keeping the ifs would be simpler.

Regards,
BALATON Zoltan

> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "ati_mm_write: wrote 0x%"PRIx64" to gui register "
> +            "0x%"PRIx64" while cce engine enabled, ignored.\n",
> +            data, addr);
> +        return;
> +    }
> +
>     switch (addr) {
>     case MM_INDEX:
>         s->regs.mm_index = data & ~3;
>

