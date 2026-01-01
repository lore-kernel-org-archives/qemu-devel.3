Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA442EED612
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Jan 2026 14:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbJaD-0003kG-Jm; Thu, 01 Jan 2026 09:23:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vbJaB-0003js-E0
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 09:23:19 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vbJaA-0001lE-10
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 09:23:19 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 26D835969FA;
 Thu, 01 Jan 2026 15:23:15 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id yMEhJaUKltp0; Thu,  1 Jan 2026 15:23:13 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 31442596A0D; Thu, 01 Jan 2026 15:23:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 300C6596A0B;
 Thu, 01 Jan 2026 15:23:13 +0100 (CET)
Date: Thu, 1 Jan 2026 15:23:13 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 5/7] ati-vga: Disable GUI engine MMIO writes when CCE
 enabled
In-Reply-To: <20260101035555.1300511-6-chad@jablonski.xyz>
Message-ID: <fce26d22-b04e-1ac1-4a54-bbc3927d4c93@eik.bme.hu>
References: <20260101035555.1300511-1-chad@jablonski.xyz>
 <20260101035555.1300511-6-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

On Wed, 31 Dec 2025, Chad Jablonski wrote:
> When the CCE engine is enabled, real hardware ignores any MMIO writes to
> GUI registers (0x1400-0x1fff range). Writes made by the CCE engine are
> not affected by this.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati.c | 7 +++++++
> 1 file changed, 7 insertions(+)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 5f52739d33..29a89b3f80 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -1011,6 +1011,13 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>     if (addr < CUR_OFFSET || addr > CUR_CLR1 || ATI_DEBUG_HW_CURSOR) {
>         trace_ati_mm_write(size, addr, ati_reg_name(addr & ~3ULL), data);
>     }
> +    if (addr >= 0x1400 && addr <= 0x1fff && s->cce.buffer_mode != 0) {

Small nit, I'd write this as

(s->cce.buffer_mode && addr >= 0x1400 && addr <= 0x1fff)

to make it shorter and to skip testing the addr when not needed.

Regards,
BALATON Zoltan

> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "ati_mm_write: wrote 0x%lx to gui register 0x%lx while cce engine enabled, ignored.\n",
> +            data, addr);
> +        return;
> +    }
> +
>     ati_reg_write(s, addr, data, size);
> }
>
>

