Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87525EB3634
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 20:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx9se-0007YE-5G; Mon, 02 Mar 2026 15:28:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vx9sd-0007Xh-2v
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 15:28:39 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vx9sb-0002Bo-LJ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 15:28:38 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id ACC5F5969F0;
 Mon, 02 Mar 2026 21:28:34 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id aDEfFDcGHn1H; Mon,  2 Mar 2026 21:28:32 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AA61B5969FA; Mon, 02 Mar 2026 21:28:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A8D7A5969F2;
 Mon, 02 Mar 2026 21:28:32 +0100 (CET)
Date: Mon, 2 Mar 2026 21:28:32 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v10 16/17] ati-vga: Implement HOST_DATA register writes
In-Reply-To: <20260302180447.1078098-17-chad@jablonski.xyz>
Message-ID: <12ec87e8-3c50-d3a9-05d7-2c322604b01b@eik.bme.hu>
References: <20260302180447.1078098-1-chad@jablonski.xyz>
 <20260302180447.1078098-17-chad@jablonski.xyz>
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

On Mon, 2 Mar 2026, Chad Jablonski wrote:
> Writing to any of the HOST_DATA0-7 registers pushes the written data
> into a 128-bit accumulator. When the accumulator is full a flush is
> triggered to copy it to the framebuffer. A final write to HOST_DATA_LAST
> will also initiate a flush. The flush itself is left for the next patch.
>
> Unaligned HOST_DATA* writes result in, from what I can tell, undefined
> behavior on real hardware. A well-behaved driver shouldn't be doing this
> anyway. For that reason they are not handled here at all.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati.c      | 30 ++++++++++++++++++++++++++++++
> hw/display/ati_dbg.c  |  9 +++++++++
> hw/display/ati_int.h  |  9 +++++++++
> hw/display/ati_regs.h |  9 +++++++++
> 4 files changed, 57 insertions(+)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 6cf243bcf9..965110c13a 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -1024,6 +1024,31 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>     case SRC_SC_BOTTOM:
>         s->regs.src_sc_bottom = data & 0x3fff;
>         break;
> +    case HOST_DATA0:
> +    case HOST_DATA1:
> +    case HOST_DATA2:
> +    case HOST_DATA3:
> +    case HOST_DATA4:
> +    case HOST_DATA5:
> +    case HOST_DATA6:
> +    case HOST_DATA7:
> +        if (!s->host_data.active) {
> +            break;
> +        }
> +        s->host_data.acc[s->host_data.next++] = data;
> +        if (s->host_data.next >= 4) {
> +            qemu_log_mask(LOG_UNIMP, "HOST_DATA flush not yet implemented\n");
> +            s->host_data.next = 0;
> +        }
> +        break;
> +    case HOST_DATA_LAST:
> +        if (!s->host_data.active) {
> +            break;
> +        }
> +        s->host_data.acc[s->host_data.next] = data;
> +        qemu_log_mask(LOG_UNIMP,
> +                      "HOST_DATA finish flush not yet implemented\n");
> +        break;

These look quite similar so maybe it could be simpler as
case HOST_DATA7:
case HOST_DATA_LAST:
     if (!s->host_data.active) {
         break;
     }
     s->host_data.acc[s->host_data.next++] = data;
     if (s->host_data.next >= 4 || addr == HOST_DATA_LAST) {
         flush;
         s->host_data.next = 0; // is this needed? flush might reset it
     }

Regards,
BALATON Zoltan

