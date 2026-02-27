Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB8CFD530D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 07:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvskw-0005Aj-M6; Fri, 27 Feb 2026 02:59:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vvskp-0005AP-4Y
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 02:59:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vvskm-0001Lf-Q0
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 02:59:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772179155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tEUZl22mNOAUBTkeRo/W/6ZhvO67dYHDdW2li1cwZeM=;
 b=Nigb2exXZ7OkUuqpDSj8OcWbxafEgoK87bLJuTzl/aBrsBv1gAk03bx5hdM8VeqMRiLS/C
 2NNRmuklviGfIcX9N+zYXbfJEaG0rur6FUtHyaolkSQ8YSMK3BZlw2w3T0ihrxVqO1m9tZ
 7carlU6ZwlBIttalZTZDKw4CdFyacdg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-4RaPvCe1PlWOoWaOYnhp1Q-1; Fri,
 27 Feb 2026 02:59:13 -0500
X-MC-Unique: 4RaPvCe1PlWOoWaOYnhp1Q-1
X-Mimecast-MFC-AGG-ID: 4RaPvCe1PlWOoWaOYnhp1Q_1772179152
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D777C180057E; Fri, 27 Feb 2026 07:59:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.13])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 636BF30001B9; Fri, 27 Feb 2026 07:59:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EC8B221E6932; Fri, 27 Feb 2026 08:59:08 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH] hw/pci: Avoid adding PCI devices to the "unattached"
 QOM tree node
In-Reply-To: <20260219161822.55e83382@imammedo> (Igor Mammedov's message of
 "Thu, 19 Feb 2026 16:18:22 +0100")
References: <20260217065512.245237-1-thuth@redhat.com>
 <20260219160641.6f63c27d@imammedo> <20260219161822.55e83382@imammedo>
Date: Fri, 27 Feb 2026 08:59:08 +0100
Message-ID: <87342md3cj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Igor Mammedov <imammedo@redhat.com> writes:

> On Thu, 19 Feb 2026 16:06:41 +0100
> Igor Mammedov <imammedo@redhat.com> wrote:
>
>> On Tue, 17 Feb 2026 07:55:12 +0100
>> Thomas Huth <thuth@redhat.com> wrote:
>> 
>> > From: Thomas Huth <thuth@redhat.com>
>> > 
>> > PCI devices that are added via pci_create_simple_multifunction(),
>> > pci_create_simple() or pci_init_nic_in_slot() currently show up
>> > under "/machine/unattached" in the QOM tree. This is somewhat ugly,
>> > the parent should rather be the PCI bus node instead, so let's add
>> > the proper relation here.
>> > 
>> > Signed-off-by: Thomas Huth <thuth@redhat.com>
>> > ---
>> >  hw/pci/pci.c | 14 ++++++++++++++
>> >  1 file changed, 14 insertions(+)
>> > 
>> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> > index 90d6d71efdc..2f4d2be50fd 100644
>> > --- a/hw/pci/pci.c
>> > +++ b/hw/pci/pci.c
>> > @@ -2071,6 +2071,15 @@ const pci_class_desc *get_class_desc(int class)
>> >      return desc;
>> >  }
>> >  
>> > +static void pci_dev_property_add_child(PCIBus *bus, const char *name,
>> > +                                       PCIDevice *dev)
>> > +{
>> > +    g_autofree char *childname = g_strdup_printf("%s[%d.%d]", name,
>> > +                                                 PCI_SLOT(dev->devfn),
>> > +                                                 PCI_FUNC(dev->devfn));
>> > +    object_property_add_child(OBJECT(bus), childname, OBJECT(dev));
>> > +}
>> > +
>> >  void pci_init_nic_devices(PCIBus *bus, const char *default_model)
>> >  {
>> >      qemu_create_nic_bus_devices(&bus->qbus, TYPE_PCI_DEVICE, default_model,
>> > @@ -2114,6 +2123,7 @@ bool pci_init_nic_in_slot(PCIBus *rootbus, const char *model,
>> >  
>> >      pci_dev = pci_new(devfn, model);  
>> there are a few more places that have similar pattern, should we fix them to?
>> 
>> >      qdev_set_nic_properties(&pci_dev->qdev, nd);
>> > +    pci_dev_property_add_child(bus, model, pci_dev);  
>> 
>> >      pci_realize_and_unref(pci_dev, bus, &error_fatal);  
>> this one also takes bus as an argument, and then goes down to
>>  qdev_realize_and_unref->qdev_realize->qdev_set_parent_bus->bus_add_child
>> that eventually creates a link to device.
>> 
>> wouldn't pci_dev_property_add_child() create a duplicate entry
>> as a child with different name component there?
>> 
>> another question, should we 'fix' qdev_set_parent_bus->bus_add_child
>> to add a child instead of a link? That would do what patch intends
>> but consistently for all devices with parent bus.
>
> and then this rises a question if the bus should be a parent or
> the owner of the bus is the parent?

This question is about the QOM composition tree (the thing "info
qom-tree" shows).

There is also the qdev tree (the thing "info qtree" shows).  In the qdev
tree, the PCI device's parent is a PCI bus, and the PCI bus's parent is
the device providing the bus.  An edge from qdev to parent qbus means
qdev plugs into qbus.  An edge from qbus to parent qdev means qbus is
provided by qdev.

Example: an i440FX machine's device i440FX-pcihost is parent of PCI bus
"pci.0" is parent of device PIIX3.

In the QOM composition tree, an edge from child to parent means parent
contains child.

Example: a i440FX machine's i440FX-pcihost device object /machine/i440fx
is the parent of PCI bus object /machine/i440fx/pci.0.  Makes sense.
i440FX-pcihost also contains a PIIX3 PCI device wired to its PCI bus.
Should PIIX3 be the QOM child of the i440FX-pcihost device, or of its
PCI bus?  This is Igor's question.  Due to sloppy modeling, it's
currently neither: it's at /machine/unattached/device[3] instead.

Is there any non-sloppy precedence to guide us?

QOM maintainers, do you have any advice?

[...]


