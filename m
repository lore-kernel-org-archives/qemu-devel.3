Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8051C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 07:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reVdJ-00010K-Jg; Mon, 26 Feb 2024 02:42:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reVdH-0000sX-KZ
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:42:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reVdG-0005Vn-0B
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:42:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708933356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XMtFpvSB/1w2t5LZ3R3il70+amBpqQC/pQ0ioDnJv34=;
 b=dM86S6mUHofZSnIglmHhqY7Pmwa50/pP0vFw9ypm0o04ddW92xaWckb//+ms/XB8XOKUCh
 l8xqfKmWux6nUveP9eNo5oP3m490h6omAwUEUm3aarGNw7qffxp/tb66sMvvVIKCbB1Lyl
 Ian4a04enFwsJw92TdCciFYAsNcrkAc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-NUm0T1kwMZeKz9MNkxYSHA-1; Mon, 26 Feb 2024 02:42:35 -0500
X-MC-Unique: NUm0T1kwMZeKz9MNkxYSHA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D377F185A783;
 Mon, 26 Feb 2024 07:42:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B14FB201EAF9;
 Mon, 26 Feb 2024 07:42:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A91AC21E66F4; Mon, 26 Feb 2024 08:42:30 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  balaton@eik.bme.hu
Subject: Re: [PATCH 04/10] mips/loongson3_virt: do not require CONFIG_USB
In-Reply-To: <20240223124406.234509-5-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Fri, 23 Feb 2024 13:44:00 +0100")
References: <20240223124406.234509-1-pbonzini@redhat.com>
 <20240223124406.234509-5-pbonzini@redhat.com>
Date: Mon, 26 Feb 2024 08:42:30 +0100
Message-ID: <87wmqrk6xl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Once the Kconfig for hw/mips is cleaned up, it will be possible to build a
> binary that does not include any USB host controller and therefore that
> does not include the code guarded by CONFIG_USB.  While the simpler
> creation functions such as usb_create_simple can be inlined, this is not
> true of usb_bus_find().  Remove it, replacing it with a search of the
> single USB bus created by loongson3_virt_devices_init().
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/mips/loongson3_virt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
> index caedde2df00..b2a8b22b4ea 100644
> --- a/hw/mips/loongson3_virt.c
> +++ b/hw/mips/loongson3_virt.c
> @@ -447,8 +447,9 @@ static inline void loongson3_virt_devices_init(MachineState *machine,
>  
>      if (defaults_enabled() && object_class_by_name("pci-ohci")) {
>          pci_create_simple(pci_bus, -1, "pci-ohci");
> -        usb_create_simple(usb_bus_find(-1), "usb-kbd");
> -        usb_create_simple(usb_bus_find(-1), "usb-tablet");
> +        Object *usb_bus = object_resolve_type_unambiguous(TYPE_USB_BUS, &error_abort);
> +        usb_create_simple(USB_BUS(usb_bus), "usb-kbd");
> +        usb_create_simple(USB_BUS(usb_bus), "usb-tablet");

In the previous patches, you cast just once, like this:

           USBBus *usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS, &error_abort));
           usb_create_simple(usb_bus, "usb-kbd");
           usb_create_simple(usb_bus, "usb-tablet");

Could you do that here, too?

Same for the next few patches.

>      }
>  
>      pci_init_nic_devices(pci_bus, mc->default_nic);


