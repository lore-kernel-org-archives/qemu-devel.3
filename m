Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B070C0219C
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 13:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg1oY-0005hp-GT; Thu, 06 Feb 2025 08:21:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tg1oW-0005hL-Rm
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:21:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tg1oU-0002g4-Gd
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738848061;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b//hxbdw1y6xdYdmTbhLOXF6hJuN9b1J4ev/dlzbVLc=;
 b=EdXONh71cUo6rsUdeArtX1a3k7tM2F+5Uwr3PWzOMXlKvt63Pm9E0UqLADWMbjq3Wd6ZZm
 33I94o1wZGBnzmcT2f/oe4fZiRmd29CC+cWQFaw41fbheOFCjwQoJqH2NOMl4zwHGeB36Y
 yEIc5Xe7a+8iz6wc94rt9nAHq+e8wk4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-C3R6hvGqP2mxeLF7XDGKJA-1; Thu,
 06 Feb 2025 08:20:59 -0500
X-MC-Unique: C3R6hvGqP2mxeLF7XDGKJA-1
X-Mimecast-MFC-AGG-ID: C3R6hvGqP2mxeLF7XDGKJA
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B675A1955D53; Thu,  6 Feb 2025 13:20:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.33])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1A4518004A7; Thu,  6 Feb 2025 13:20:53 +0000 (UTC)
Date: Thu, 6 Feb 2025 13:20:50 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Anton Johansson <anjo@rev.ng>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v5 11/16] hw/microblaze: Support various endianness for
 s3adsp1800 machines
Message-ID: <Z6S3Mgt1G7fIjeBB@redhat.com>
References: <20250206131052.30207-1-philmd@linaro.org>
 <20250206131052.30207-12-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250206131052.30207-12-philmd@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Feb 06, 2025 at 02:10:47PM +0100, Philippe Mathieu-Daudé wrote:
> Introduce an abstract machine parent class which defines
> the 'little_endian' property. Duplicate the current machine,
> which endian is tied to the binary endianness, to one big
> endian and a little endian machine; updating the machine
> description. Keep the current default machine for each binary.
> 
> 'petalogix-s3adsp1800' machine is aliased as:
> - 'petalogix-s3adsp1800-be' on big-endian binary,
> - 'petalogix-s3adsp1800-le' on little-endian one.

Does it makes sense to expose these as different machine types ?

If all the HW is identical in both cases, it feels like the
endianness could just be a bool property of the machine type,
rather than a new machine type.

> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/microblaze/petalogix_s3adsp1800_mmu.c | 62 +++++++++++++++++++-----
>  1 file changed, 51 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> index 96aed4ed1a3..aea727eb7ee 100644
> --- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
> +++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> @@ -55,8 +55,17 @@
>  #define ETHLITE_IRQ         1
>  #define UARTLITE_IRQ        3
>  
> +typedef struct PetalogixS3adsp1800MachineClass {
> +    MachineClass parent_obj;
> +
> +    bool little_endian;
> +} PetalogixS3adsp1800MachineClass;
> +
>  #define TYPE_PETALOGIX_S3ADSP1800_MACHINE \
> -            MACHINE_TYPE_NAME("petalogix-s3adsp1800")
> +            MACHINE_TYPE_NAME("petalogix-s3adsp1800-common")
> +DECLARE_CLASS_CHECKERS(PetalogixS3adsp1800MachineClass,
> +                       PETALOGIX_S3ADSP1800_MACHINE,
> +                       TYPE_PETALOGIX_S3ADSP1800_MACHINE)
>  
>  static void
>  petalogix_s3adsp1800_init(MachineState *machine)
> @@ -71,11 +80,13 @@ petalogix_s3adsp1800_init(MachineState *machine)
>      MemoryRegion *phys_ram = g_new(MemoryRegion, 1);
>      qemu_irq irq[32];
>      MemoryRegion *sysmem = get_system_memory();
> +    PetalogixS3adsp1800MachineClass *pmc;
>  
> +    pmc = PETALOGIX_S3ADSP1800_MACHINE_GET_CLASS(machine);
>      cpu = MICROBLAZE_CPU(object_new(TYPE_MICROBLAZE_CPU));
>      object_property_set_str(OBJECT(cpu), "version", "7.10.d", &error_abort);
>      object_property_set_bool(OBJECT(cpu), "little-endian",
> -                             !TARGET_BIG_ENDIAN, &error_abort);
> +                             pmc->little_endian, &error_abort);
>      qdev_realize(DEVICE(cpu), NULL, &error_abort);
>  
>      /* Attach emulated BRAM through the LMB.  */
> @@ -95,7 +106,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
>                            64 * KiB, 1, 0x89, 0x18, 0x0000, 0x0, 1);
>  
>      dev = qdev_new("xlnx.xps-intc");
> -    qdev_prop_set_bit(dev, "little-endian", !TARGET_BIG_ENDIAN);
> +    qdev_prop_set_bit(dev, "little-endian", pmc->little_endian);
>      qdev_prop_set_uint32(dev, "kind-of-intr",
>                           1 << ETHLITE_IRQ | 1 << UARTLITE_IRQ);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> @@ -107,7 +118,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
>      }
>  
>      dev = qdev_new(TYPE_XILINX_UARTLITE);
> -    qdev_prop_set_bit(dev, "little-endian", !TARGET_BIG_ENDIAN);
> +    qdev_prop_set_bit(dev, "little-endian", pmc->little_endian);
>      qdev_prop_set_chr(dev, "chardev", serial_hd(0));
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, UARTLITE_BASEADDR);
> @@ -115,7 +126,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
>  
>      /* 2 timers at irq 2 @ 62 Mhz.  */
>      dev = qdev_new("xlnx.xps-timer");
> -    qdev_prop_set_bit(dev, "little-endian", !TARGET_BIG_ENDIAN);
> +    qdev_prop_set_bit(dev, "little-endian", pmc->little_endian);
>      qdev_prop_set_uint32(dev, "one-timer-only", 0);
>      qdev_prop_set_uint32(dev, "clock-frequency", 62 * 1000000);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> @@ -123,7 +134,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
>      sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ]);
>  
>      dev = qdev_new("xlnx.xps-ethernetlite");
> -    qdev_prop_set_bit(dev, "little-endian", !TARGET_BIG_ENDIAN);
> +    qdev_prop_set_bit(dev, "little-endian", pmc->little_endian);
>      qemu_configure_nic_device(dev, true, NULL);
>      qdev_prop_set_uint32(dev, "tx-ping-pong", 0);
>      qdev_prop_set_uint32(dev, "rx-ping-pong", 0);
> @@ -133,26 +144,55 @@ petalogix_s3adsp1800_init(MachineState *machine)
>  
>      create_unimplemented_device("xps_gpio", GPIO_BASEADDR, 0x10000);
>  
> -    microblaze_load_kernel(cpu, !TARGET_BIG_ENDIAN, ddr_base, ram_size,
> +    microblaze_load_kernel(cpu, pmc->little_endian, ddr_base, ram_size,
>                             machine->initrd_filename,
>                             BINARY_DEVICE_TREE_FILE,
>                             NULL);
>  }
>  
> -static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc, void *data)
> +static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc,
> +                                                    bool little_endian)
>  {
>      MachineClass *mc = MACHINE_CLASS(oc);
> +    PetalogixS3adsp1800MachineClass *pmc = PETALOGIX_S3ADSP1800_MACHINE_CLASS(oc);
>  
> -    mc->desc = "PetaLogix linux refdesign for xilinx Spartan 3ADSP1800";
>      mc->init = petalogix_s3adsp1800_init;
> -    mc->is_default = true;
> +    pmc->little_endian = little_endian;
> +    mc->desc = little_endian
> +        ? "PetaLogix linux refdesign for xilinx Spartan 3ADSP1800 (little endian)"
> +        : "PetaLogix linux refdesign for xilinx Spartan 3ADSP1800 (big endian)";
> +    if (little_endian == !TARGET_BIG_ENDIAN) {
> +        mc->is_default = true;
> +        mc->alias = "petalogix-s3adsp1800";
> +    }
> +}
> +
> +static void petalogix_s3adsp1800_machine_class_init_be(ObjectClass *oc, void *data)
> +{
> +    petalogix_s3adsp1800_machine_class_init(oc, false);
> +}
> +
> +static void petalogix_s3adsp1800_machine_class_init_le(ObjectClass *oc, void *data)
> +{
> +    petalogix_s3adsp1800_machine_class_init(oc, true);
>  }
>  
>  static const TypeInfo petalogix_s3adsp1800_machine_types[] = {
>      {
>          .name           = TYPE_PETALOGIX_S3ADSP1800_MACHINE,
>          .parent         = TYPE_MACHINE,
> -        .class_init     = petalogix_s3adsp1800_machine_class_init,
> +        .abstract       = true,
> +        .class_size     = sizeof(PetalogixS3adsp1800MachineClass),
> +    },
> +    {
> +        .name           = MACHINE_TYPE_NAME("petalogix-s3adsp1800-be"),
> +        .parent         = TYPE_PETALOGIX_S3ADSP1800_MACHINE,
> +        .class_init     = petalogix_s3adsp1800_machine_class_init_be,
> +    },
> +    {
> +        .name           = MACHINE_TYPE_NAME("petalogix-s3adsp1800-le"),
> +        .parent         = TYPE_PETALOGIX_S3ADSP1800_MACHINE,
> +        .class_init     = petalogix_s3adsp1800_machine_class_init_le,
>      },
>  };
>  
> -- 
> 2.47.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


