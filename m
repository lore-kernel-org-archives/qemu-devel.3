Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4B7E9A04C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 08:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vszip-0002LC-SZ; Thu, 19 Feb 2026 03:49:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vszio-0002L2-Gp
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 03:49:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vszim-00060f-AP
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 03:49:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771490953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FQxPdGv3vL6y6uPlT83ZP5eypFxu8NkCpR+l20z6wKs=;
 b=XQqLIEtIVkJyNcw0q2JYAo1uiRfPT6H6WJ0/Wt15FBUKMeb1OzczHKJ7hqhNpf1KOAsVp0
 vkkx3HdC00afRhnmfSrRP0ERooK9I4cOMozaSe6aiqmlATdbzbQDNZqQ+xPO4h7Qe4x2fw
 mEAr0WySqiE+92O4qVEfp7M45WjtU38=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-O7EbssunOSCsSKqZSPMC4Q-1; Thu,
 19 Feb 2026 03:49:10 -0500
X-MC-Unique: O7EbssunOSCsSKqZSPMC4Q-1
X-Mimecast-MFC-AGG-ID: O7EbssunOSCsSKqZSPMC4Q_1771490949
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 177BB1956063; Thu, 19 Feb 2026 08:49:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E1FB19560A7; Thu, 19 Feb 2026 08:49:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E9E2821E692D; Thu, 19 Feb 2026 09:49:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>
Subject: Re: [RFC PATCH] hw/core: Avoid attaching qdevs to
 /machine/unattached if they have a bus
In-Reply-To: <20260217164049.543975-1-thuth@redhat.com> (Thomas Huth's message
 of "Tue, 17 Feb 2026 17:40:49 +0100")
References: <20260217164049.543975-1-thuth@redhat.com>
Date: Thu, 19 Feb 2026 09:49:05 +0100
Message-ID: <874ind5da6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.754, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
> We still have a lot of devices that end up in /machine/unattached in
> case the caller forgot to use object_property_add_child() to add it
> to a proper location in the QOM tree.

This is QOM papering over sloppy modeling.  Predictably, it has enabled
us to remain sloppy slobs.

I think the decision to paper over sloppiness to get QOM off the ground
quickly was defensible back then.  It's a lot less defensible now that
QOM has been off the ground for more than a decade.

I believe people are by and large unaware of the need to add children.
This risks further accumulation of technical debt.

To really put a stop to it, we'd have to mark the existing misuses, then
warn or crash on umarked misuse.

None of the above is an objection to your patch.

>                                       But at least for the devices
> that get realized via qdev_realize() and that have a bus specified,
> we can do better: Add the device automatically as a child to the bus
> device instead! This way the QOM tree looks way more logical, with
> way less devices hanging around in the /machine/unattached space.
>
> While we're at it, use the type name as node name (instead of using
> "device" like we did in the "unattached" space). But since these
> entries might not be stable (they use a counting number in the square
> brackets), the code also uses a "x-" prefix here to indicate that
> this still might change in the course of time (once a board decides
> to manually attach the device with a proper name instead).
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/core/qdev.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 42641c5224e..5b773d0108a 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -266,9 +266,19 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
>      assert(!dev->realized && !dev->parent_bus);
>  
>      if (bus) {
> +        Object *obj = OBJECT(dev);
> +
>          if (!qdev_set_parent_bus(dev, bus, errp)) {
>              return false;
>          }
> +
> +        if (!obj->parent) {
> +            static int count;
> +            g_autofree char *name = g_strdup_printf("x-%s[%d]",
> +                                                    object_get_typename(obj),
> +                                                    count++);
> +            object_property_add_child(OBJECT(bus), name, obj);
> +        }
>      } else {
>          assert(!DEVICE_GET_CLASS(dev)->bus_type);
>      }

As a quick test, I ran

    $ qemu-system-x86_64 -S -display none -nodefaults -monitor stdio
    QEMU 10.2.50 monitor - type 'help' for more information
    (qemu) info qom-tree

before and after.  Diff of output appended.

Observations:

* 24 of 25 device[*] move out of /machine/unattached/.  Remaining:

  - /device[0] (qemu64-x86_64-cpu) because it doesn't plug into a bus.

  - /sysbus (System)

  - A bunch of memory regions and irqs.  Some of them smell like sloppy
    modeling: ide[*].

* The moved device[i] get renamed to x-type-name[j].  The number changes
  because the type-name[*] use their own global counter.  Changing the
  number is fine, but I wonder whether a counter local to the parent
  would be better.  BusClass does that for "automatically allocated bus
  ids".

--- info-qom-tree@master	2026-02-19 08:43:03.732267517 +0100
+++ -	2026-02-19 08:43:43.562332914 +0100
@@ -37,6 +37,156 @@
     /pci-conf-data[0] (memory-region)
     /pci-conf-idx[0] (memory-region)
     /pci.0 (PCI)
+      /x-PIIX3[2] (PIIX3)
+        /bus master container[0] (memory-region)
+        /bus master[0] (memory-region)
+        /dma[0] (i8257)
+          /dma-chan[0] (memory-region)
+          /dma-cont[0] (memory-region)
+          /dma-page[0] (memory-region)
+          /dma-page[1] (memory-region)
+        /dma[1] (i8257)
+          /dma-chan[0] (memory-region)
+          /dma-cont[0] (memory-region)
+          /dma-page[0] (memory-region)
+          /dma-page[1] (memory-region)
+        /ide (piix3-ide)
+          /bmdma[0] (memory-region)
+          /bmdma[1] (memory-region)
+          /bus master container[0] (memory-region)
+          /bus master[0] (memory-region)
+          /ide.0 (IDE)
+          /ide.1 (IDE)
+          /piix-bmdma-container[0] (memory-region)
+          /piix-bmdma[0] (memory-region)
+          /piix-bmdma[1] (memory-region)
+        /isa.0 (ISA)
+          /x-i8042[9] (i8042)
+            /i8042-cmd[0] (memory-region)
+            /i8042-data[0] (memory-region)
+            /ps2-kbd-input-irq[0] (irq)
+            /ps2-mouse-input-irq[0] (irq)
+            /ps2kbd (ps2-kbd)
+            /ps2mouse (ps2-mouse)
+          /x-isa-fdc[8] (isa-fdc)
+            /fdc[0] (memory-region)
+            /fdc[1] (memory-region)
+            /floppy-bus.0 (floppy-bus)
+          /x-isa-i8259[3] (isa-i8259)
+            /elcr[0] (memory-region)
+            /pic[0] (memory-region)
+            /unnamed-gpio-in[0] (irq)
+            /unnamed-gpio-in[1] (irq)
+            /unnamed-gpio-in[2] (irq)
+            /unnamed-gpio-in[3] (irq)
+            /unnamed-gpio-in[4] (irq)
+            /unnamed-gpio-in[5] (irq)
+            /unnamed-gpio-in[6] (irq)
+            /unnamed-gpio-in[7] (irq)
+          /x-isa-i8259[4] (isa-i8259)
+            /elcr[0] (memory-region)
+            /pic[0] (memory-region)
+            /unnamed-gpio-in[0] (irq)
+            /unnamed-gpio-in[1] (irq)
+            /unnamed-gpio-in[2] (irq)
+            /unnamed-gpio-in[3] (irq)
+            /unnamed-gpio-in[4] (irq)
+            /unnamed-gpio-in[5] (irq)
+            /unnamed-gpio-in[6] (irq)
+            /unnamed-gpio-in[7] (irq)
+          /x-isa-pcspk[7] (isa-pcspk)
+            /pcspk[0] (memory-region)
+          /x-isa-pit[6] (isa-pit)
+            /pit[0] (memory-region)
+            /unnamed-gpio-in[0] (irq)
+          /x-port92[12] (port92)
+            /port92[0] (memory-region)
+          /x-vmmouse[11] (vmmouse)
+          /x-vmport[10] (vmport)
+            /vmport[0] (memory-region)
+        /piix-reset-control[0] (memory-region)
+        /pm (PIIX4_PM)
+          /acpi-cnt[0] (memory-region)
+          /acpi-cpu-hotplug[0] (memory-region)
+          /acpi-evt[0] (memory-region)
+          /acpi-gpe0[0] (memory-region)
+          /acpi-pci-hotplug[0] (memory-region)
+          /acpi-tmr[0] (memory-region)
+          /apm-io[0] (memory-region)
+          /bus master container[0] (memory-region)
+          /bus master[0] (memory-region)
+          /i2c (i2c-bus)
+            /x-smbus-eeprom[13] (smbus-eeprom)
+            /x-smbus-eeprom[14] (smbus-eeprom)
+            /x-smbus-eeprom[15] (smbus-eeprom)
+            /x-smbus-eeprom[16] (smbus-eeprom)
+            /x-smbus-eeprom[17] (smbus-eeprom)
+            /x-smbus-eeprom[18] (smbus-eeprom)
+            /x-smbus-eeprom[19] (smbus-eeprom)
+            /x-smbus-eeprom[20] (smbus-eeprom)
+          /piix4-pm[0] (memory-region)
+          /pm-smbus[0] (memory-region)
+        /rtc (mc146818rtc)
+          /rtc-index[0] (memory-region)
+          /rtc[0] (memory-region)
+      /x-i440FX[1] (i440FX)
+        /bus master container[0] (memory-region)
+        /bus master[0] (memory-region)
+        /pam-pci[0] (memory-region)
+        /pam-pci[10] (memory-region)
+        /pam-pci[11] (memory-region)
+        /pam-pci[12] (memory-region)
+        /pam-pci[13] (memory-region)
+        /pam-pci[14] (memory-region)
+        /pam-pci[15] (memory-region)
+        /pam-pci[16] (memory-region)
+        /pam-pci[17] (memory-region)
+        /pam-pci[18] (memory-region)
+        /pam-pci[19] (memory-region)
+        /pam-pci[1] (memory-region)
+        /pam-pci[20] (memory-region)
+        /pam-pci[21] (memory-region)
+        /pam-pci[22] (memory-region)
+        /pam-pci[23] (memory-region)
+        /pam-pci[24] (memory-region)
+        /pam-pci[25] (memory-region)
+        /pam-pci[2] (memory-region)
+        /pam-pci[3] (memory-region)
+        /pam-pci[4] (memory-region)
+        /pam-pci[5] (memory-region)
+        /pam-pci[6] (memory-region)
+        /pam-pci[7] (memory-region)
+        /pam-pci[8] (memory-region)
+        /pam-pci[9] (memory-region)
+        /pam-ram[0] (memory-region)
+        /pam-ram[10] (memory-region)
+        /pam-ram[11] (memory-region)
+        /pam-ram[12] (memory-region)
+        /pam-ram[1] (memory-region)
+        /pam-ram[2] (memory-region)
+        /pam-ram[3] (memory-region)
+        /pam-ram[4] (memory-region)
+        /pam-ram[5] (memory-region)
+        /pam-ram[6] (memory-region)
+        /pam-ram[7] (memory-region)
+        /pam-ram[8] (memory-region)
+        /pam-ram[9] (memory-region)
+        /pam-rom[0] (memory-region)
+        /pam-rom[10] (memory-region)
+        /pam-rom[11] (memory-region)
+        /pam-rom[12] (memory-region)
+        /pam-rom[1] (memory-region)
+        /pam-rom[2] (memory-region)
+        /pam-rom[3] (memory-region)
+        /pam-rom[4] (memory-region)
+        /pam-rom[5] (memory-region)
+        /pam-rom[6] (memory-region)
+        /pam-rom[7] (memory-region)
+        /pam-rom[8] (memory-region)
+        /pam-rom[9] (memory-region)
+        /smram-low[0] (memory-region)
+        /smram-region[0] (memory-region)
+        /smram[0] (memory-region)
   /peripheral (container)
   /peripheral-anon (container)
   /unattached (container)
@@ -46,162 +196,6 @@
       /memory[0] (memory-region)
       /memory[1] (memory-region)
       /smram[0] (memory-region)
-    /device[10] (i8042)
-      /i8042-cmd[0] (memory-region)
-      /i8042-data[0] (memory-region)
-      /ps2-kbd-input-irq[0] (irq)
-      /ps2-mouse-input-irq[0] (irq)
-      /ps2kbd (ps2-kbd)
-      /ps2mouse (ps2-mouse)
-    /device[11] (vmport)
-      /vmport[0] (memory-region)
-    /device[12] (vmmouse)
-    /device[13] (port92)
-      /port92[0] (memory-region)
-    /device[14] (smbus-eeprom)
-    /device[15] (smbus-eeprom)
-    /device[16] (smbus-eeprom)
-    /device[17] (smbus-eeprom)
-    /device[18] (smbus-eeprom)
-    /device[19] (smbus-eeprom)
-    /device[1] (kvmvapic)
-      /kvmvapic[0] (memory-region)
-    /device[20] (smbus-eeprom)
-    /device[21] (smbus-eeprom)
-    /device[2] (i440FX)
-      /bus master container[0] (memory-region)
-      /bus master[0] (memory-region)
-      /pam-pci[0] (memory-region)
-      /pam-pci[10] (memory-region)
-      /pam-pci[11] (memory-region)
-      /pam-pci[12] (memory-region)
-      /pam-pci[13] (memory-region)
-      /pam-pci[14] (memory-region)
-      /pam-pci[15] (memory-region)
-      /pam-pci[16] (memory-region)
-      /pam-pci[17] (memory-region)
-      /pam-pci[18] (memory-region)
-      /pam-pci[19] (memory-region)
-      /pam-pci[1] (memory-region)
-      /pam-pci[20] (memory-region)
-      /pam-pci[21] (memory-region)
-      /pam-pci[22] (memory-region)
-      /pam-pci[23] (memory-region)
-      /pam-pci[24] (memory-region)
-      /pam-pci[25] (memory-region)
-      /pam-pci[2] (memory-region)
-      /pam-pci[3] (memory-region)
-      /pam-pci[4] (memory-region)
-      /pam-pci[5] (memory-region)
-      /pam-pci[6] (memory-region)
-      /pam-pci[7] (memory-region)
-      /pam-pci[8] (memory-region)
-      /pam-pci[9] (memory-region)
-      /pam-ram[0] (memory-region)
-      /pam-ram[10] (memory-region)
-      /pam-ram[11] (memory-region)
-      /pam-ram[12] (memory-region)
-      /pam-ram[1] (memory-region)
-      /pam-ram[2] (memory-region)
-      /pam-ram[3] (memory-region)
-      /pam-ram[4] (memory-region)
-      /pam-ram[5] (memory-region)
-      /pam-ram[6] (memory-region)
-      /pam-ram[7] (memory-region)
-      /pam-ram[8] (memory-region)
-      /pam-ram[9] (memory-region)
-      /pam-rom[0] (memory-region)
-      /pam-rom[10] (memory-region)
-      /pam-rom[11] (memory-region)
-      /pam-rom[12] (memory-region)
-      /pam-rom[1] (memory-region)
-      /pam-rom[2] (memory-region)
-      /pam-rom[3] (memory-region)
-      /pam-rom[4] (memory-region)
-      /pam-rom[5] (memory-region)
-      /pam-rom[6] (memory-region)
-      /pam-rom[7] (memory-region)
-      /pam-rom[8] (memory-region)
-      /pam-rom[9] (memory-region)
-      /smram-low[0] (memory-region)
-      /smram-region[0] (memory-region)
-      /smram[0] (memory-region)
-    /device[3] (PIIX3)
-      /bus master container[0] (memory-region)
-      /bus master[0] (memory-region)
-      /dma[0] (i8257)
-        /dma-chan[0] (memory-region)
-        /dma-cont[0] (memory-region)
-        /dma-page[0] (memory-region)
-        /dma-page[1] (memory-region)
-      /dma[1] (i8257)
-        /dma-chan[0] (memory-region)
-        /dma-cont[0] (memory-region)
-        /dma-page[0] (memory-region)
-        /dma-page[1] (memory-region)
-      /ide (piix3-ide)
-        /bmdma[0] (memory-region)
-        /bmdma[1] (memory-region)
-        /bus master container[0] (memory-region)
-        /bus master[0] (memory-region)
-        /ide.0 (IDE)
-        /ide.1 (IDE)
-        /piix-bmdma-container[0] (memory-region)
-        /piix-bmdma[0] (memory-region)
-        /piix-bmdma[1] (memory-region)
-      /isa.0 (ISA)
-      /piix-reset-control[0] (memory-region)
-      /pm (PIIX4_PM)
-        /acpi-cnt[0] (memory-region)
-        /acpi-cpu-hotplug[0] (memory-region)
-        /acpi-evt[0] (memory-region)
-        /acpi-gpe0[0] (memory-region)
-        /acpi-pci-hotplug[0] (memory-region)
-        /acpi-tmr[0] (memory-region)
-        /apm-io[0] (memory-region)
-        /bus master container[0] (memory-region)
-        /bus master[0] (memory-region)
-        /i2c (i2c-bus)
-        /piix4-pm[0] (memory-region)
-        /pm-smbus[0] (memory-region)
-      /rtc (mc146818rtc)
-        /rtc-index[0] (memory-region)
-        /rtc[0] (memory-region)
-    /device[4] (isa-i8259)
-      /elcr[0] (memory-region)
-      /pic[0] (memory-region)
-      /unnamed-gpio-in[0] (irq)
-      /unnamed-gpio-in[1] (irq)
-      /unnamed-gpio-in[2] (irq)
-      /unnamed-gpio-in[3] (irq)
-      /unnamed-gpio-in[4] (irq)
-      /unnamed-gpio-in[5] (irq)
-      /unnamed-gpio-in[6] (irq)
-      /unnamed-gpio-in[7] (irq)
-    /device[5] (isa-i8259)
-      /elcr[0] (memory-region)
-      /pic[0] (memory-region)
-      /unnamed-gpio-in[0] (irq)
-      /unnamed-gpio-in[1] (irq)
-      /unnamed-gpio-in[2] (irq)
-      /unnamed-gpio-in[3] (irq)
-      /unnamed-gpio-in[4] (irq)
-      /unnamed-gpio-in[5] (irq)
-      /unnamed-gpio-in[6] (irq)
-      /unnamed-gpio-in[7] (irq)
-    /device[6] (hpet)
-      /hpet[0] (memory-region)
-      /unnamed-gpio-in[0] (irq)
-      /unnamed-gpio-in[1] (irq)
-    /device[7] (isa-pit)
-      /pit[0] (memory-region)
-      /unnamed-gpio-in[0] (irq)
-    /device[8] (isa-pcspk)
-      /pcspk[0] (memory-region)
-    /device[9] (isa-fdc)
-      /fdc[0] (memory-region)
-      /fdc[1] (memory-region)
-      /floppy-bus.0 (floppy-bus)
     /ide[0] (memory-region)
     /ide[1] (memory-region)
     /ide[2] (memory-region)
@@ -243,5 +237,11 @@
     /pci[0] (memory-region)
     /ram-below-4g[0] (memory-region)
     /sysbus (System)
+      /x-hpet[5] (hpet)
+        /hpet[0] (memory-region)
+        /unnamed-gpio-in[0] (irq)
+        /unnamed-gpio-in[1] (irq)
+      /x-kvmvapic[0] (kvmvapic)
+        /kvmvapic[0] (memory-region)
     /system[0] (memory-region)


