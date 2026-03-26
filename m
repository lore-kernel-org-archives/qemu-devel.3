Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7398910A62CF
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 13:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5ko6-0003Cp-Av; Thu, 26 Mar 2026 09:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w5knp-00039w-MB
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 09:31:14 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w5knm-0007lx-7H
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 09:31:13 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EE38F5BD0C;
 Thu, 26 Mar 2026 13:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774531869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vaP/I0dVj4y1PHocSe3Wwg/IFJ8AQqhpMf0BWEm3DkA=;
 b=MzaBHXJKHxDgONg+yJ2IHkU5pholXh4n8cdqPB22p9R28ICJaMv51mhpmfPdCeGqDmTI3I
 0IwJ1Ye1g8IPUuuCDTL1CCarAhmZN6mI3HIa9E3BIRP86xGQyQGc5lxy/chU5QrggMEchv
 2ZSOFM5YepROHcRk/wyaKgI0H0D75Ao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774531869;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vaP/I0dVj4y1PHocSe3Wwg/IFJ8AQqhpMf0BWEm3DkA=;
 b=zS10CKrNxvBaKIliv78elDo15Odnmd3YulfaXBZ6dWZBrx5lA7SYlLcNNpsnI0gzt0gn4t
 OxY8cf4d62jRCWAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774531868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vaP/I0dVj4y1PHocSe3Wwg/IFJ8AQqhpMf0BWEm3DkA=;
 b=barcybPOURXK06YNnj/ha6rW5zjfs/EA415XMndn+UhzWkPOPk6K7rxTP9AZMoEMetfsMX
 yE9V918NTG56l9kYrjx5sDnmSFf/Zx9CNezhFqHvFCjDEufcOdw/RrrUKSLkzsOY0ddwsh
 NfMRrWlzXtOECPCjl+P01JyMpaUv69o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774531868;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vaP/I0dVj4y1PHocSe3Wwg/IFJ8AQqhpMf0BWEm3DkA=;
 b=9F4ja1Om/68wo4StBAed7olhBtlLxLsH7OV81iWci5XHNzlANZMJKaZOl72anZAKptY4KC
 seIfEOQ0gJjgOuDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FC904A0A3;
 Thu, 26 Mar 2026 13:31:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cclzEhw1xWkraQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 26 Mar 2026 13:31:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Peter Xu
 <peterx@redhat.com>
Subject: Re: [PATCH] hw/display/vga-isa: Fix migration of the isa-vga device
In-Reply-To: <20260326113457.159065-1-thuth@redhat.com>
References: <20260326113457.159065-1-thuth@redhat.com>
Date: Thu, 26 Mar 2026 10:31:06 -0300
Message-ID: <87a4vuk99h.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Thomas Huth <thuth@redhat.com> writes:

> From: Thomas Huth <thuth@redhat.com>
>
> QEMU currently crashes when migrating a guest that uses the
> isa-vga device as display. This happens because vga_isa_class_initfn()
> registers a vmsd for vmstate_vga_common that operates on VGACommonState.
> But the isa-vga device is derived from ISADevice, not from VGACommonState,
> so the migration code tries to fill in the data for VGACommonState to
> the memory that is a ISADevice instead, which is of cause causing trouble.
>
> We need an indirection here as it's also e.g. done in vga-pci.c, so
> that the migration data gets filled into the right location.
>
> While we're at it, also drop the "global_vmstate = true" here. Since
> migration was broken for this device during the last 15 years (!) anyway,
> we don't have to worry about maintaining backward compatibility with this
> switch for older versions of QEMU anymore.
>
> Fixes: 7435b791ca9 ("vga-isa: convert to qdev")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/display/vga-isa.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/vga-isa.c b/hw/display/vga-isa.c
> index 95d85ff69a5..5f55c884a1b 100644
> --- a/hw/display/vga-isa.c
> +++ b/hw/display/vga-isa.c
> @@ -32,6 +32,7 @@
>  #include "qemu/timer.h"
>  #include "hw/core/loader.h"
>  #include "hw/core/qdev-properties.h"
> +#include "migration/vmstate.h"
>  #include "ui/console.h"
>  #include "qom/object.h"
>  
> @@ -62,7 +63,6 @@ static void vga_isa_realizefn(DeviceState *dev, Error **errp)
>      MemoryRegion *vga_io_memory;
>      const MemoryRegionPortio *vga_ports, *vbe_ports;
>  
> -    s->global_vmstate = true;
>      if (!vga_common_init(s, OBJECT(dev), errp)) {
>          return;
>      }
> @@ -88,6 +88,15 @@ static void vga_isa_realizefn(DeviceState *dev, Error **errp)
>      rom_add_vga(VGABIOS_FILENAME);
>  }
>  
> +static const VMStateDescription vmstate_vga_isa = {
> +    .name = "vga-isa",
> +    .version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_STRUCT(state, ISAVGAState, 0, vmstate_vga_common, VGACommonState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const Property vga_isa_properties[] = {
>      DEFINE_PROP_UINT32("vgamem_mb", ISAVGAState, state.vram_size_mb, 8),
>  };
> @@ -98,7 +107,7 @@ static void vga_isa_class_initfn(ObjectClass *klass, const void *data)
>  
>      dc->realize = vga_isa_realizefn;
>      device_class_set_legacy_reset(dc, vga_isa_reset);
> -    dc->vmsd = &vmstate_vga_common;
> +    dc->vmsd = &vmstate_vga_isa;
>      device_class_set_props(dc, vga_isa_properties);
>      set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
>  }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

