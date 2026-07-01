Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A94BC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weu5G-0001sq-80; Wed, 01 Jul 2026 08:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1weu57-0001lI-R7
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:30:28 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1weu55-0000YE-1I
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:30:20 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6D967596708;
 Wed, 01 Jul 2026 14:30:17 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 67Xpi1muRu0a; Wed,  1 Jul 2026 14:30:15 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 41522596707; Wed, 01 Jul 2026 14:30:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 40210596704;
 Wed, 01 Jul 2026 14:30:15 +0200 (CEST)
Date: Wed, 1 Jul 2026 14:30:15 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 3/7] ati-vga: Implement CCE microcode register handling
In-Reply-To: <20260606195216.2524314-4-chad@jablonski.xyz>
Message-ID: <82234c1c-0675-3f1c-9401-0e0c1b1b50e4@eik.bme.hu>
References: <20260606195216.2524314-1-chad@jablonski.xyz>
 <20260606195216.2524314-4-chad@jablonski.xyz>
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
> Implement registers used for loading and reading microcode for the CCE
> engine. Loading the microcode is the first step for any driver
> implementing CCE. Reading, while not used by drivers, is very helpful for
> any reverse engineering and testing work. The microcode is currently
> stored but not used. This lays the groundwork for future RE work on the
> microcode.
>
> There's some quirky behavior around microcode reads that isn't
> documented elsewhere. There appear to be two internal pointers, one for
> reading and one for writing that can get out of sync. Comments in the
> code expand on this.
>
> Tested and validated against a Rage 128 Pro Ultra (PCI 1002:5446) and
> Radeon QY (RV100) (PCI 1002:5159).
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati.c     | 61 ++++++++++++++++++++++++++++++++++++++++++++
> hw/display/ati_int.h | 11 ++++++++
> 2 files changed, 72 insertions(+)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 826c856b1c..73fd5e7d23 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -579,6 +579,36 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>         qemu_log_mask(LOG_GUEST_ERROR,
>                       "Read from write-only register 0x%x\n", (unsigned)addr);
>         break;
> +    /* r100: CP_ME_RAM_ADDR */
> +    case PM4_MICROCODE_ADDR:
> +        val = s->cce.microcode.addr;
> +        break;
> +    /* r100: CP_ME_RAM_RADDR */
> +    case PM4_MICROCODE_RADDR:
> +        /* Always returns 0. Tested on hardware. */
> +        val = 0;
> +        break;
> +    /* r100: CP_ME_RAM_DATAH */
> +    case PM4_MICROCODE_DATAH:
> +        val = (s->cce.microcode.microcode[s->cce.microcode.raddr] >> 32) &
> +              0xffffffff;

I'm not sure we need to mask here as you shift out the low part and the 
high part will be 0 so unless the compiler warns I'd just write >> 32 but 
I'm not sure we need all of this anyway as I'm not sure any driver would 
do more than just write the microcode and then never read it. So I'd only 
bother to implement it if something is known to need it.

Regards,
BALATON Zoltan

