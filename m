Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571B5C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 07:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reVdV-0001CH-VC; Mon, 26 Feb 2024 02:42:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reVdR-000184-7s
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:42:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reVdP-0005W6-T8
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:42:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708933366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qwE/LN83B4APmN8L6sgRYVF8h57lMXmfWJHnQeezrQU=;
 b=D/UA1sXR3J8DuTI7fF9jmbzoK+NPYAMBSpEaqrTUt5G5pT32R9gDXQW2jcowu0UP7urUvB
 MuKm6bq5exqdS/ZWc57UH6wy9yQVvwPWPsE4V6YxbiOZP3MPdkOAnnKmkfppi6ML3odgoq
 IpVywwKAT9YRsITWX054rUec0FYV1II=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-ep81XQOvOk-LtMEwySFCXg-1; Mon, 26 Feb 2024 02:42:45 -0500
X-MC-Unique: ep81XQOvOk-LtMEwySFCXg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C19E88A67E6;
 Mon, 26 Feb 2024 07:42:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FA221121337;
 Mon, 26 Feb 2024 07:42:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9B99621E6767; Mon, 26 Feb 2024 08:42:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  balaton@eik.bme.hu
Subject: Re: [PATCH 02/10] ppc: sam460ex: do not use usb_bus_find()
In-Reply-To: <20240223124406.234509-3-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Fri, 23 Feb 2024 13:43:58 +0100")
References: <20240223124406.234509-1-pbonzini@redhat.com>
 <20240223124406.234509-3-pbonzini@redhat.com>
Date: Mon, 26 Feb 2024 08:42:43 +0100
Message-ID: <87sf1fk6x8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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

> usb_bus_find() is always used with argument -1; it can be replaced with
> a search of the single USB bus on the machine.
>
> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/ppc/sam460ex.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 1e615b8d355..4d5655ab6b4 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -273,6 +273,7 @@ static void sam460ex_init(MachineState *machine)
>      DeviceState *uic[4];
>      int i;
>      PCIBus *pci_bus;
> +    USBBus *usb_bus;
>      PowerPCCPU *cpu;
>      CPUPPCState *env;
>      I2CBus *i2c;
> @@ -420,8 +421,9 @@ static void sam460ex_init(MachineState *machine)
>      sysbus_realize_and_unref(sbdev, &error_fatal);
>      sysbus_mmio_map(sbdev, 0, 0x4bffd0000);
>      sysbus_connect_irq(sbdev, 0, qdev_get_gpio_in(uic[2], 30));
> -    usb_create_simple(usb_bus_find(-1), "usb-kbd");
> -    usb_create_simple(usb_bus_find(-1), "usb-mouse");
> +    usb_bus =3D USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS, &e=
rror_abort));

This long line is really easy to break.

> +    usb_create_simple(usb_bus, "usb-kbd");
> +    usb_create_simple(usb_bus, "usb-mouse");
>=20=20
>      /* PCIe buses */
>      dev =3D qdev_new(TYPE_PPC460EX_PCIE_HOST);


