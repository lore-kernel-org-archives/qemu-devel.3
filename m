Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397D4C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 11:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzacI-0002qc-Po; Wed, 24 Apr 2024 07:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rzacB-0002pS-3p
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 07:16:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rzac9-0006wG-0K
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 07:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713957395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jYmO/M9Ur/Qfkgn9LUApbJZOelOP5x9iOICHoNUu/8w=;
 b=WnB0l1YJ1df5tdAVhVq0n6/mvjOswssWZfHVqRm/Q/FKunLbhpVGyGRFzRwEf/eLcQbWEy
 9Vpbifd/sAm0NTipDheqrwHcsWvpCk30zQVuDEIWd3NwNb+4A1shnHcPMMg7efg+HLZNh0
 h12iyLgdH/C0UJjEZHK3rd3jaYPOxTg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-kBUq7rhJMLiaNw4t81ocNg-1; Wed, 24 Apr 2024 07:16:32 -0400
X-MC-Unique: kBUq7rhJMLiaNw4t81ocNg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD63F104B503;
 Wed, 24 Apr 2024 11:16:31 +0000 (UTC)
Received: from dobby.home.kraxel.org (unknown [10.39.192.254])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CE99EC682;
 Wed, 24 Apr 2024 11:16:31 +0000 (UTC)
Received: by dobby.home.kraxel.org (Postfix, from userid 1000)
 id 168D6F6235; Wed, 24 Apr 2024 13:16:30 +0200 (CEST)
Date: Wed, 24 Apr 2024 13:16:30 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Alan Stern <stern@rowland.harvard.edu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: Re: Problems (timeouts) when testing usb-ohci with qemu
Message-ID: <edfmff7qm46edap6nz2ppvfhcw4jp6ahjltrv76jsiq5rhz5hw@v2lcbclpdsjt>
References: <4664cf39-5dfe-4557-959d-149640ca36e1@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4664cf39-5dfe-4557-959d-149640ca36e1@roeck-us.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> qemu hack:
> 
>  hw/usb/hcd-ohci.c | 11 +++++++++++
>  hw/usb/hcd-ohci.h |  1 +
>  2 files changed, 12 insertions(+)
> 
> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> index fc8fc91a1d..99e52ad13a 100644
> --- a/hw/usb/hcd-ohci.c
> +++ b/hw/usb/hcd-ohci.c
> @@ -267,6 +267,10 @@ static inline void ohci_intr_update(OHCIState *ohci)
>          (ohci->intr_status & ohci->intr))
>          level = 1;
>  
> +    if (level && ohci->level)
> +        qemu_set_irq(ohci->irq, 0);
> +
> +    ohci->level = level;
>      qemu_set_irq(ohci->irq, level);
>  }
>  
> diff --git a/hw/usb/hcd-ohci.h b/hw/usb/hcd-ohci.h
> index e1827227ac..6f82e72bd9 100644
> --- a/hw/usb/hcd-ohci.h
> +++ b/hw/usb/hcd-ohci.h
> @@ -52,6 +52,7 @@ struct OHCIState {
>      uint32_t ctl, status;
>      uint32_t intr_status;
>      uint32_t intr;
> +    int level;
>  
>      /* memory pointer partition */
>      uint32_t hcca;

Phew.  Disclaimer: Havn't looked at the ohci emulation code for years.

It should not be needed to store the interrupt level that way.  It is
possible to calculate what the interrupt level should be, based on the
interrupt status register and the interrupt mask register, and the code
above seems to do exactly that (the "ohci->intr_status & ohci->intr"
bit).

ohci_intr_update() must be called if one of these two registers changes,
i.e. if the guest changes the mask, if the guest acks an IRQ by clearing
an status bit, if the device raises an IRQ by setting an status bit.
Might be the ohci emulation has a bug here.

Another possible trouble spot is that the timing behavior is different
on virtual vs. physical hardware.  Specifically with the emulated
hardware some actions appear to complete instantly (when the vmexit to
handle the mmio register write returns it's finished already), which
will never complete that quickly on physical hardware.  So drivers can
have race conditions which only trigger on virtual hardware.  The error
pattern you are describing sounds like this could be the case here.

HTH & take care,
  Gerd


