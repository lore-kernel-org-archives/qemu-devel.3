Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24884C0218A
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2025 01:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teOju-00060s-Jr; Sat, 01 Feb 2025 20:25:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1teOjr-00060E-VY; Sat, 01 Feb 2025 20:25:32 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1teOjo-00034Q-Qm; Sat, 01 Feb 2025 20:25:31 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0ECF74E6001;
 Sun, 02 Feb 2025 02:25:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Abfaa_cQNmQO; Sun,  2 Feb 2025 02:25:22 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1DEED4E6004; Sun, 02 Feb 2025 02:25:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1B84874577C;
 Sun, 02 Feb 2025 02:25:22 +0100 (CET)
Date: Sun, 2 Feb 2025 02:25:22 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH] hw/ppc/e500: Partial implementation of local access
 window registers
In-Reply-To: <06F97BE3-057D-4D9D-AAAF-2B7438358BB8@gmail.com>
Message-ID: <69e08a66-b146-4d76-080f-7fa6f4a0a13f@eik.bme.hu>
References: <20250115211544.307124E602F@zero.eik.bme.hu>
 <22e114ac-2c3f-76f1-2172-9adf0c50ad5f@eik.bme.hu>
 <DE6FAB3B-F994-47B8-95A5-9D1BFD6B621F@gmail.com>
 <06F97BE3-057D-4D9D-AAAF-2B7438358BB8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Sat, 1 Feb 2025, Bernhard Beschow wrote:
> Am 1. Februar 2025 14:55:15 UTC schrieb Bernhard Beschow <shentey@gmail.com>:
>> Am 30. Januar 2025 12:45:58 UTC schrieb BALATON Zoltan <balaton@eik.bme.hu>:
>>> On Wed, 15 Jan 2025, BALATON Zoltan wrote:
>>>> This allows guests to set the CCSR base address. Also store and return
>>>> values of the local access window registers but their functionality
>>>> isn't implemented.
>>>
>>> Ping?
>>
>> I guess you're trying to boot a real firmware image from SD card?

I'm not trying, I've done it. I only needed these patches and commenting 
out the page_aligned = true in hw/sd/sdhci.c as I noted in the previous 
patch. U-Boot works and I can run commands in the firmware prompt but I 
did not try to boot an OS yet. The amigaos boot loader which U-Boot for 
Tabor loads by default crashes somewhere but this may be a bug in the 
patched U-Boot. I think I've seen similar with sam460ex U-Boot before, 
maybe it's because of not finding some expected devices and not handling 
the returned NULL value well but I did not debug it.

>> I've implemented that in my e500-fdt branch which I want to send as an 
>> RFC. I still need to clean it up. Once it's on the list we could make a 
>> plan how to turn it into a p10xx. Would that work for you?

Sure, I can try to test your patches once they are submitted to the list 
and rebase my changes on top if they still needed. I've just submitted 
these so you can incorporate them in your tree so I have less to rebase 
but I see you already have most of these. I'm OK to wait until your tree 
is cleaned and submitted but it seems there are a lot of patches so it 
might take a while. I don't expect that you can get it merged before the 
next release. Some of the patches may need several versions or alternative 
approaches until they can be merged. For example I expect problems with 
allowing ',' in device names as this is something that was removed before 
to avoid the need of quoting or something like that. But I'm not in a 
hurry as I don't have much free time for it anyway so only come back to 
this time to time and it's far from anything useful yet.

>>
>> Best regards,
>> Bernhard
>>
>> P.S. The last commit teaches you how to start a firmware from SD card.

I did not try your version but looking at the patch looks like you have 
some sparse-mem region. (I've added similar one from board code, I did not 
know about this device.) Isn't that the l2cache as RAM or on-chip SRAM or 
whatever it's called? You seem to have some emulation of that l2cache in a 
previous patch so can't that be mapped there? Maybe we'll eventually need 
to implement reading the BOOT data from the beginning of the SD card or 
flash ROM which may have some initial register values that set things up 
that are currently hard coded.

Meanwhile I can cherry pick some patches from your tree and test them. 
Looks like you have some DDR3 support added, I haven't got to that yet.

For USB I had this for now:

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index ee17acdb69..54890d25f3 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -900,6 +900,29 @@ static void ppce500_power_off(void *opaque, int line, int on)
      }
  }

+static uint64_t usb_read(void *opaque, hwaddr addr, unsigned size)
+{
+    switch (addr) {
+    case 0:
+        return BIT(2) | BIT(17);
+    }
+    return 0;
+}
+
+static void usb_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+}
+
+static const MemoryRegionOps usb_ops = {
+    .read = usb_read,
+    .write = usb_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
  void ppce500_init(MachineState *machine)
  {
      MemoryRegion *address_space_mem = get_system_memory();
@@ -1118,6 +1141,19 @@ void ppce500_init(MachineState *machine)
                                      sysbus_mmio_get_region(s, 0));
      }

+    /* USB */
+    dev = qdev_new("tegra2-ehci-usb");
+    s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_connect_irq(s, 0, qdev_get_gpio_in(mpicdev, 12));
+    memory_region_add_subregion(ccsr_addr_space, 0x22000,
+                                sysbus_mmio_get_region(s, 0));
+    {
+        MemoryRegion *mr =  g_new(MemoryRegion, 1);
+        memory_region_init_io(mr, OBJECT(dev), &usb_ops, s, "fsl-ehci", 4);
+        memory_region_add_subregion(ccsr_addr_space, 0x22500, mr);
+    }
+
      /* General Utility device */
      dev = qdev_new("mpc8544-guts");
      s = SYS_BUS_DEVICE(dev);

which is reusing a sufficiently similar existing device just to have 
minimal changes. This isn't the right way but since most of these just 
differ in the reg offsets I wonder if we could turn these offsets into 
properties so we don't need to add a new subclass for every device. I 
think subclasses came from the pci version where the PCI IDs are different 
and maybe sysbus was modelled after that but we only need subclasses where 
additional registers are needed (which may be the case for this fsl device 
so this property idea is just unrelated clean up).

Regards,
BALATON Zoltan

