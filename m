Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF367606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zd/vQ4U4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUC9-0000NN-J2; Thu, 29 Oct 2026 13:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMUBC-0006u5-KR
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMUB8-0003cn-GJ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793295864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TYeeLfIIZtZ1tx/zizs4Nx4GkQC9RWB/i7ECbnLDle0=;
 b=Zd/vQ4U4dHe3nb21Xd/bIh0pPx+FbwlPZS23hxc+faxawyrOLCqK6tsnfN7+mPZG0BN2j2
 1RLoWJnqRaARppGfLWDQdS+KzVyWtlayV3G2X9FnorcpbcjaYy1d8g2Xpe459bqKaTI1yC
 SOkPQwkbTbf2Hba5+CQNuYnYVfwnlXM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-1EfTOtPePr2O3BKituryMw-1; Thu,
 29 Oct 2026 13:44:18 -0400
X-MC-Unique: 1EfTOtPePr2O3BKituryMw-1
X-Mimecast-MFC-AGG-ID: 1EfTOtPePr2O3BKituryMw_1793295857
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 784FC1800868; Thu, 29 Oct 2026 17:44:16 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B90A81955F1C; Thu, 29 Oct 2026 17:44:14 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 1/8] hw/usb/bus: Let the controller ask for the
 automatic hub
From: marcandre.lureau@redhat.com
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, junjie.cao@intel.com, 
 junjie.cao@linux.dev, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Kane Chen <kane_chen@aspeedtech.com>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 Troy Lee <troy_lee@aspeedtech.com>
In-Reply-To: <20261028034140.367393-2-jamin_lin@aspeedtech.com>
References: <20261028034140.367393-1-jamin_lin@aspeedtech.com>
 <20261028034140.367393-2-jamin_lin@aspeedtech.com>
Date: Thu, 29 Oct 2026 21:44:07 +0400
Message-Id: <179329584772.3884549.13961862737373033745.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4208;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=IE17bdRpPS4u6ZcK2uRdvVKyh/wPfTz/sJMF7uBsRlI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq44XqqX6pyNhystIwGCxbef1Kx/T3Mp+FIncAr
 lOGXHUnExmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauOF6gAKCRDa6OEJdZac
 5VxAD/93qCDvJBM9OOQuQYhQwbU1+14VEHBkPsaCx+8gslJyvjyXDfYzu9HfUYGnUHqBZExD9X+
 y3kRVsFanrJc0qbav4Q1H6lmSP8uD/JTc/0BTgrBtLJRNnkoJG9SgyzAKu1A2vDB8dAsJXFSFeq
 PFTEn8bOz1MtrouT1FRgBESdq6xI5kRnQYuS0P5ctTwBHF7rar8tBSIW9aqGmfC0th6JEAQ2OVj
 zd8WVtDexdarZ4UhJM6I1zbpkdSE1O9EqZV6A0HqAnb/1DS9X4kyXhpIdf7YUnQa4WJIn6OipyA
 ixM5SxRAd5OyG0KpQUE2RbzXY6Wlt5Oqb9BxclC0Znge1T4A2eJ/UAk9wd/H7mVXDAwVYQBkX2Q
 8JKFQe+Sysj9mSOv14MZEm/fieuv9v4GByziTq3cwaii2Tzrhe1DR/SB2MVzz6vNkjigCTG0tq8
 EcdQxT5zV9SBID79akt87wQwna3Xy3GnhOnbdrR3xCGWzCw3wftoUY2OU0dys2axF/SgmUzBOk9
 RFuZnCIFYiW2SSneK2gT+FyE3j2boTyQ1sVFZXwEA1QxcB+SY9LxpZZA979vYhgZnUVRC0bf8WE
 lf3a89njjZH63FUIq3o6wQZXSC4dFqnlpHIBK/Ti43JA0LPbqg7wFDKLacj5aVa0Oqd3EYTIqHy
 XmEqV+/m6GF4/uQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> usb_claim_port() plugs in a usb-hub when only one port is free, so that
> more devices fit. Every bus gets that today. A controller with a single
> root port then puts its only device behind a hub, and a transport that
> carries one device cannot use that.
> 
> The hub speaks USB 1.1, so this belongs to UHCI and OHCI. Add auto_hub
> and leave it off by default. UHCI and OHCI set it, both when they own
> the bus and when they join one as a companion. dwc2 sets it too, so the
> boards that use it keep working.
> 
> xHCI has up to 15 root ports, so it no longer grows a hub on its own. A
> user who wants more ports there adds "-device usb-hub".
> 
> Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Message-ID: <20261028034140.367393-2-jamin_lin@aspeedtech.com>
> ---
>  include/hw/usb/usb.h | 1 +
>  hw/usb/bus.c         | 6 +++++-
>  hw/usb/hcd-dwc2.c    | 1 +
>  hw/usb/hcd-ohci.c    | 1 +
>  hw/usb/hcd-uhci.c    | 1 +
>  5 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/hw/usb/bus.c b/hw/usb/bus.c
> index 5cc5ffec33a1..d1ad22ac9432 100644
> --- a/hw/usb/bus.c
> +++ b/hw/usb/bus.c
> @@ -363,6 +363,9 @@ void usb_register_companion(const char *masterbus, USBPort *ports[],
>          return;
>      }
>  
> +    /* Only UHCI and OHCI come in as a companion, and both want the hub. */
> +    bus->auto_hub = true;
> +
>      for (i = 0; i < portcount; i++) {
>          usb_fill_port(ports[i], opaque, i, ops, speedmask);
>      }
> @@ -413,7 +416,8 @@ void usb_claim_port(USBDevice *dev, Error **errp)
>              return;
>          }
>      } else {
> -        if (bus->nfree == 1 && strcmp(object_get_typename(OBJECT(dev)), "usb-hub") != 0) {
> +        if (bus->nfree == 1 && bus->auto_hub &&
> +            strcmp(object_get_typename(OBJECT(dev)), "usb-hub") != 0) {
>              /* Create a new hub and chain it on */
>              hub = USB_DEVICE(qdev_try_new("usb-hub"));
>              if (hub) {
> diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
> index cd3b61158d17..104f49310502 100644
> --- a/hw/usb/hcd-dwc2.c
> +++ b/hw/usb/hcd-dwc2.c
> @@ -1354,6 +1354,7 @@ static void dwc2_realize(DeviceState *dev, Error **errp)
>      address_space_init(&s->dma_as, s->dma_mr, "dwc2");
>  
>      usb_bus_new(&s->bus, sizeof(s->bus), &dwc2_bus_ops, dev);
> +    s->bus.auto_hub = true;
>      usb_register_port(&s->bus, &s->uport, s, 0, &dwc2_port_ops,
>                        USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL |
>                        (s->usb_version == 2 ? USB_SPEED_MASK_HIGH : 0));
> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> index 5e5fe41f473d..d6b1fc5b62ae 100644
> --- a/hw/usb/hcd-ohci.c
> +++ b/hw/usb/hcd-ohci.c
> @@ -1987,6 +1987,7 @@ void usb_ohci_init(OHCIState *ohci, DeviceState *dev, uint32_t num_ports,
>          }
>      } else {
>          usb_bus_new(&ohci->bus, sizeof(ohci->bus), &ohci_bus_ops, dev);
> +        ohci->bus.auto_hub = true;
>          for (i = 0; i < num_ports; i++) {
>              usb_register_port(&ohci->bus, &ohci->rhport[i].port,
>                                ohci, i, &ohci_port_ops,
> diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
> index a7b9fe131759..f11664bd553c 100644
> --- a/hw/usb/hcd-uhci.c
> +++ b/hw/usb/hcd-uhci.c
> @@ -1213,6 +1213,7 @@ void usb_uhci_common_realize(PCIDevice *dev, Error **errp)
>          }
>      } else {
>          usb_bus_new(&s->bus, sizeof(s->bus), &uhci_bus_ops, DEVICE(dev));
> +        s->bus.auto_hub = true;
>          for (i = 0; i < UHCI_PORTS; i++) {
>              usb_register_port(&s->bus, &s->ports[i].port, s, i, &uhci_port_ops,
>                                USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL);
> diff --git a/include/hw/usb/usb.h b/include/hw/usb/usb.h
> index cbd4711933e8..cc1d6d74b124 100644
> --- a/include/hw/usb/usb.h
> +++ b/include/hw/usb/usb.h
> @@ -484,6 +484,7 @@ struct USBBus {
>      int busnr;
>      int nfree;
>      int nused;
> +    bool auto_hub;

Missing xen-usb, I assume it will be taken care of in v8.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


