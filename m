Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB93E9A04C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 15:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt5nV-0001di-Oz; Thu, 19 Feb 2026 10:18:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vt5nT-0001cF-O5
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 10:18:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vt5nR-0000hj-96
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 10:18:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771514308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O8Lo9PM7XK6Fl9O/nsfkvTWkKsEhvGhNTcgvPBEoP2o=;
 b=U5fGEXIDabV6p67CHyTcHppakrn2i1ej84sMUZjWudQCe0B5Y9fVdYCfJaqXG0q8sqBwFL
 Wi3wSr1tvvPlP9dias5V6TBLCLCM6XERRgq/TxRZsmlP4lbxqC9vKi7zz9k+8YKh90dnA3
 rNH6OT5NkqOU0hLwnjjEGIU9NeVuxss=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-8iFNnHeaPEmqIi78mYT1Rg-1; Thu, 19 Feb 2026 10:18:26 -0500
X-MC-Unique: 8iFNnHeaPEmqIi78mYT1Rg-1
X-Mimecast-MFC-AGG-ID: 8iFNnHeaPEmqIi78mYT1Rg_1771514305
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43766514653so666888f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 07:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771514305; x=1772119105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O8Lo9PM7XK6Fl9O/nsfkvTWkKsEhvGhNTcgvPBEoP2o=;
 b=ONzEoLx/fne8Uy8gLBVbNs+XPDrXyYp0JbGCOBjDXxngX5B8i6QJMuqbyKTUeHIJj0
 DdkEDc1ejMLwldy7PdK20uwRp5upG8NxUNzV7PRtM9mR1/gBCMmgjoCN2F9oIs4RO/8t
 w89O66x03tu9zJRvDukI7W8alM+e1XIaJ/M9T5E5gbRAfKaSPC8Wy8CElZrxPwC67zEF
 Et+/OZpMGl1kekTZO5G7IqFtGxh4VFzbSoMuNrtyrTS2fLNAQRfvcVOYhV7jOyexr1EH
 tA6atmcMdVuxukSLe+dpGwHKjswF18AN/D3/bFh7mKrTnAaSZ4pYczrw/tSb/D2oseJ6
 7ZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771514305; x=1772119105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O8Lo9PM7XK6Fl9O/nsfkvTWkKsEhvGhNTcgvPBEoP2o=;
 b=CT0VgBEfoxrtdPGCqRdk7gCgMuhJqwBfgBUxuGL5aAaDaICp7n0fpD6reCbLLJgsEv
 bjL++BgOcMAKC9th9tKyfhId65TdGA7lHudRMmUOCNJqlAFx5KiV0CiW0zjaWKt2nLEh
 0cCQAj8+CuPrfIyxKmLYlhl+ba3jcLVjdv/IOFhjsZbZx5IFmlB6g9R7wdBW1SllhtS1
 ieglqy8g5jZyqszDAz/a9RICwuNm3h4NSSYkmBKc84/hEz/QnsY5ejoMgjMj1tHtuPec
 jRUjBhflLTMv7rakln+0fpXPP9NuEmB2P8/dkAIke7y8sZZh6DAUNf+5cT4usTYbdxnE
 qB2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4lL8Aj1uaRrWXag4aw8gdEPShb8m5jmUdVTQtHkh67x0JiNRFlA1jy1/2Yxo8l92dc41GKpBiPiwx@nongnu.org
X-Gm-Message-State: AOJu0Yyyann23LFBNPDufZQ3CUJqpJqQuKOUqwV4ydD6Se+U4jPWAHA9
 uzNH2wZPrijVpMmfmrnphUCRihpKYniJk6Wj29XOL1Vcesfzn880Fe62xwC8y4KTB9fvCGJpOxm
 V8zkAaSzVf3bzUveklUIHyCmkNVhaedGRxf1rYP4QiW2o41zzMXIXzFm9
X-Gm-Gg: AZuq6aJfQnVGbKzS2jKNDAoJu3fJnjM6eJZNngidHNcptJSgfIJBI9kffG/SDLrCFhU
 3BuarZgaEGpcoFFhY8yLtzKIorAfIN7+DAcnIr9pzN8xZ8hgtlmTJIY1CzfhL6qB4vs/AZKW65w
 iHOBMySKLamkHw5KUesT5rj5yuN5q3bXb/yNlACeEBDM2KmT02f52FS04GA7Qo1xoU3cR3HD67Z
 j5v4qjnsRWFAQeWZtgvO8HvII+R+fTci6G5W8ySI/m05jHaa2+TRXYWLA6aBoyfDcvuyvkoVqfR
 2sulrsXpHM+k/8Kz8SQRPO12phSLESPjKY3HlVZfRx2F/kWvmoJ6RvFuuTlkG9e/FEwaNqRxXr5
 66/o88w==
X-Received: by 2002:a05:6000:2585:b0:432:8504:8d5b with SMTP id
 ffacd0b85a97d-4395fd5c21emr5231840f8f.50.1771514304981; 
 Thu, 19 Feb 2026 07:18:24 -0800 (PST)
X-Received: by 2002:a05:6000:2585:b0:432:8504:8d5b with SMTP id
 ffacd0b85a97d-4395fd5c21emr5231805f8f.50.1771514304532; 
 Thu, 19 Feb 2026 07:18:24 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a6c1bfsm50444935f8f.13.2026.02.19.07.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 07:18:23 -0800 (PST)
Date: Thu, 19 Feb 2026 16:18:22 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Markus
 Armbruster <armbru@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] hw/pci: Avoid adding PCI devices to the "unattached"
 QOM tree node
Message-ID: <20260219161822.55e83382@imammedo>
In-Reply-To: <20260219160641.6f63c27d@imammedo>
References: <20260217065512.245237-1-thuth@redhat.com>
 <20260219160641.6f63c27d@imammedo>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 19 Feb 2026 16:06:41 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> On Tue, 17 Feb 2026 07:55:12 +0100
> Thomas Huth <thuth@redhat.com> wrote:
> 
> > From: Thomas Huth <thuth@redhat.com>
> > 
> > PCI devices that are added via pci_create_simple_multifunction(),
> > pci_create_simple() or pci_init_nic_in_slot() currently show up
> > under "/machine/unattached" in the QOM tree. This is somewhat ugly,
> > the parent should rather be the PCI bus node instead, so let's add
> > the proper relation here.
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  hw/pci/pci.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index 90d6d71efdc..2f4d2be50fd 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -2071,6 +2071,15 @@ const pci_class_desc *get_class_desc(int class)
> >      return desc;
> >  }
> >  
> > +static void pci_dev_property_add_child(PCIBus *bus, const char *name,
> > +                                       PCIDevice *dev)
> > +{
> > +    g_autofree char *childname = g_strdup_printf("%s[%d.%d]", name,
> > +                                                 PCI_SLOT(dev->devfn),
> > +                                                 PCI_FUNC(dev->devfn));
> > +    object_property_add_child(OBJECT(bus), childname, OBJECT(dev));
> > +}
> > +
> >  void pci_init_nic_devices(PCIBus *bus, const char *default_model)
> >  {
> >      qemu_create_nic_bus_devices(&bus->qbus, TYPE_PCI_DEVICE, default_model,
> > @@ -2114,6 +2123,7 @@ bool pci_init_nic_in_slot(PCIBus *rootbus, const char *model,
> >  
> >      pci_dev = pci_new(devfn, model);  
> there are a few more places that have similar pattern, should we fix them to?
> 
> >      qdev_set_nic_properties(&pci_dev->qdev, nd);
> > +    pci_dev_property_add_child(bus, model, pci_dev);  
> 
> >      pci_realize_and_unref(pci_dev, bus, &error_fatal);  
> this one also takes bus as an argument, and then goes down to
>  qdev_realize_and_unref->qdev_realize->qdev_set_parent_bus->bus_add_child
> that eventually creates a link to device.
> 
> wouldn't pci_dev_property_add_child() create a duplicate entry
> as a child with different name component there?
> 
> another question, should we 'fix' qdev_set_parent_bus->bus_add_child
> to add a child instead of a link? That would do what patch intends
> but consistently for all devices with parent bus.

and then this rises a question if the bus should be a parent or
the owner of the bus is the parent?

> 
> 
> >      return true;
> >  }
> > @@ -2412,6 +2422,8 @@ PCIDevice *pci_create_simple_multifunction(PCIBus *bus, int devfn,
> >                                             const char *name)
> >  {
> >      PCIDevice *dev = pci_new_multifunction(devfn, name);
> > +
> > +    pci_dev_property_add_child(bus, name, dev);
> >      pci_realize_and_unref(dev, bus, &error_fatal);
> >      return dev;
> >  }
> > @@ -2419,6 +2431,8 @@ PCIDevice *pci_create_simple_multifunction(PCIBus *bus, int devfn,
> >  PCIDevice *pci_create_simple(PCIBus *bus, int devfn, const char *name)
> >  {
> >      PCIDevice *dev = pci_new(devfn, name);
> > +
> > +    pci_dev_property_add_child(bus, name, dev);
> >      pci_realize_and_unref(dev, bus, &error_fatal);
> >      return dev;
> >  }  
> 


