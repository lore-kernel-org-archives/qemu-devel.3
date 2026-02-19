Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0845E9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 15:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt5cL-0005VW-SB; Thu, 19 Feb 2026 10:07:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vt5cF-0005UH-Qt
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 10:06:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vt5c8-0005YT-9P
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 10:06:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771513607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3dOw8GcyV2J4tK0C+Aypy3GhH8FaC0m8/W9G4oei8MY=;
 b=fzf+cHyiTs6W5AJYucA+RgfU4zKtWdqfmT+n057AyEd1uGlHsiLd+MXKinc0LIk0yjkM8a
 jomr0A5eG3vO/6m+qkxfocJo2UmO9F+6wQ9R6qHWK4Q8ASkcER6qpctm7SSskqW4rLaQOx
 slPccexA+e+GFmklrNswWpMpGt4LgAU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-FzaQ6tFvMUehXh1bMTg1wQ-1; Thu, 19 Feb 2026 10:06:45 -0500
X-MC-Unique: FzaQ6tFvMUehXh1bMTg1wQ-1
X-Mimecast-MFC-AGG-ID: FzaQ6tFvMUehXh1bMTg1wQ_1771513604
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48069a43217so9719985e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 07:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771513604; x=1772118404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3dOw8GcyV2J4tK0C+Aypy3GhH8FaC0m8/W9G4oei8MY=;
 b=PNcsMFiJ7FS9JQxjrCkprVPDxx7iEOVtY8guZi1Ubwf3JfNOovAolO+ZXMJrmOarN3
 RAVhJ6vSuYwNURxn02gqE1F4Hjind4fIPeNOHBSmwuMAcg+9cjJmszFhUsJQJA/niy8X
 Xo5W3ZxhCsxZhN1Qd4zAu5mFrW87Pu8Rbggr5qFWaHV8ESrZ03KAtdihNt0ACThfOe0H
 4hQJnCogihalnbyVQddOoN9uAxN6QXv7VzIIxsgSCvyVj8ykSHQ+yPMeLSU0JWJdO4jf
 /3jLQaMBdKSGUFf8Q/L9I5j2IpOrX7iDUCbu+2e4ifxdyVQVBpSpbfecPIonVgAbQ9IG
 qSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771513604; x=1772118404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3dOw8GcyV2J4tK0C+Aypy3GhH8FaC0m8/W9G4oei8MY=;
 b=qfXkHfoMS6A/fg2J5Fj/1Pj6JjMU7oU7B/7G14cEi1lCqHMYsg+pHvTczxaeSjXnd1
 ZxPOSkHKoT+2uzrlZM2SLy5wOer5Fy7A/7qWuFeHrv7H2+BfgccpoirmLvKwxWmEK0VZ
 mToN9cIHtclG6OIM8vDVInpQYKtvNmycbuT3xtkL1VxIbBD9ogS/RChRsCvELCsZsuC1
 dLpsIw4OP1aedqa6+sd2dR34nUuLujGwxVmrR2I3UG+H8uThScV6YQbgHagc9Jmz0Jhs
 IC62ZWOFaXyZi58IYLK4HgSZj3JL0ApvAj22yg0kAafg7AvmtdkEYKeSZ8nL5svpUf8X
 a/YA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGA2fOTpNLXoFvbiozDXAdik6JkP6+jjXGUPCGs6QUDWq4c61DXEHKivYoHOTlD/3wXghoqulzPCFc@nongnu.org
X-Gm-Message-State: AOJu0Yy3WZedyNyH49bMIQq9edKkuxgCHbhj6hsAIERb9qHWaB+NH/qB
 T10ZVj43wJOCU/6UE9vKN1h/YefZhBboZKYoAFlX7AbHeNYium3FBVJTini4ymeR8EqN/afXrYg
 bGxMGNz2g2qyXinkNbxY/ksYRAFf5BUaWN2fRrGKZdvrZ0U7n5VBxa1zr
X-Gm-Gg: AZuq6aK0dReWCqo4TJT6txubA64JvjFHeMaVN8cq96OzC/eO99eMJP49ifeAh6OQTN8
 7lFzJqP0ZrP4GWYF6xSnN6C1KTQlPQeHDIp46TnO8a16VfquSIUxXXR8iTvu5XiMxyoZV2ZwV9g
 clbp+/+LjeMd4YwStcMEnXiVjmQKF3FXvGfTgO3Pj7mlEZqC/iky6CelhU+y6BC7P0dG9YSoIg3
 NlT8qcjnCyAcmzSIU9GHt2ZHmbsNQqbQDk8D16/p2kWqRba0FQ+j27rJZwEs2qXfcVvC32B/95G
 nXdhC5pWW71kygW1U38sHZQPuaIuP1NeVWD2o0TEo7/SQip7QpVnrhpAgv4IEsT0vcmEoaIU4an
 r364u7g==
X-Received: by 2002:a05:600c:154a:b0:47a:814c:eea1 with SMTP id
 5b1f17b1804b1-48379bfc005mr334922045e9.35.1771513603732; 
 Thu, 19 Feb 2026 07:06:43 -0800 (PST)
X-Received: by 2002:a05:600c:154a:b0:47a:814c:eea1 with SMTP id
 5b1f17b1804b1-48379bfc005mr334920645e9.35.1771513602724; 
 Thu, 19 Feb 2026 07:06:42 -0800 (PST)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31ba9easm8286825e9.4.2026.02.19.07.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 07:06:42 -0800 (PST)
Date: Thu, 19 Feb 2026 16:06:41 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Markus
 Armbruster <armbru@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] hw/pci: Avoid adding PCI devices to the "unattached"
 QOM tree node
Message-ID: <20260219160641.6f63c27d@imammedo>
In-Reply-To: <20260217065512.245237-1-thuth@redhat.com>
References: <20260217065512.245237-1-thuth@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 17 Feb 2026 07:55:12 +0100
Thomas Huth <thuth@redhat.com> wrote:

> From: Thomas Huth <thuth@redhat.com>
> 
> PCI devices that are added via pci_create_simple_multifunction(),
> pci_create_simple() or pci_init_nic_in_slot() currently show up
> under "/machine/unattached" in the QOM tree. This is somewhat ugly,
> the parent should rather be the PCI bus node instead, so let's add
> the proper relation here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/pci/pci.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 90d6d71efdc..2f4d2be50fd 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2071,6 +2071,15 @@ const pci_class_desc *get_class_desc(int class)
>      return desc;
>  }
>  
> +static void pci_dev_property_add_child(PCIBus *bus, const char *name,
> +                                       PCIDevice *dev)
> +{
> +    g_autofree char *childname = g_strdup_printf("%s[%d.%d]", name,
> +                                                 PCI_SLOT(dev->devfn),
> +                                                 PCI_FUNC(dev->devfn));
> +    object_property_add_child(OBJECT(bus), childname, OBJECT(dev));
> +}
> +
>  void pci_init_nic_devices(PCIBus *bus, const char *default_model)
>  {
>      qemu_create_nic_bus_devices(&bus->qbus, TYPE_PCI_DEVICE, default_model,
> @@ -2114,6 +2123,7 @@ bool pci_init_nic_in_slot(PCIBus *rootbus, const char *model,
>  
>      pci_dev = pci_new(devfn, model);
there are a few more places that have similar pattern, should we fix them to?

>      qdev_set_nic_properties(&pci_dev->qdev, nd);
> +    pci_dev_property_add_child(bus, model, pci_dev);

>      pci_realize_and_unref(pci_dev, bus, &error_fatal);
this one also takes bus as an argument, and then goes down to
 qdev_realize_and_unref->qdev_realize->qdev_set_parent_bus->bus_add_child
that eventually creates a link to device.

wouldn't pci_dev_property_add_child() create a duplicate entry
as a child with different name component there?

another question, should we 'fix' qdev_set_parent_bus->bus_add_child
to add a child instead of a link? That would do what patch intends
but consistently for all devices with parent bus.


>      return true;
>  }
> @@ -2412,6 +2422,8 @@ PCIDevice *pci_create_simple_multifunction(PCIBus *bus, int devfn,
>                                             const char *name)
>  {
>      PCIDevice *dev = pci_new_multifunction(devfn, name);
> +
> +    pci_dev_property_add_child(bus, name, dev);
>      pci_realize_and_unref(dev, bus, &error_fatal);
>      return dev;
>  }
> @@ -2419,6 +2431,8 @@ PCIDevice *pci_create_simple_multifunction(PCIBus *bus, int devfn,
>  PCIDevice *pci_create_simple(PCIBus *bus, int devfn, const char *name)
>  {
>      PCIDevice *dev = pci_new(devfn, name);
> +
> +    pci_dev_property_add_child(bus, name, dev);
>      pci_realize_and_unref(dev, bus, &error_fatal);
>      return dev;
>  }


