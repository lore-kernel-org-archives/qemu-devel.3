Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F09EC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 12:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXK6G-0004dh-VZ; Fri, 26 Jul 2024 08:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sXK65-0004UA-Pf; Fri, 26 Jul 2024 08:30:57 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sXK62-0000oY-AF; Fri, 26 Jul 2024 08:30:57 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WVn9t0DCHz6K5ny;
 Fri, 26 Jul 2024 20:29:06 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id F25AE140A34;
 Fri, 26 Jul 2024 20:30:49 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 26 Jul
 2024 13:30:49 +0100
Date: Fri, 26 Jul 2024 13:30:48 +0100
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov
 <imammedo@redhat.com>, "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter
 Maydell <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Yanan Wang" <wangyanan55@huawei.com>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 2/7] arm/virt: Wire up GPIO error source for ACPI / GHES
Message-ID: <20240726133048.00004e13@Huawei.com>
In-Reply-To: <034a7e86761e09996001394c98ffb8201ac52cd2.1721630625.git.mchehab+huawei@kernel.org>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
 <034a7e86761e09996001394c98ffb8201ac52cd2.1721630625.git.mchehab+huawei@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.174.77]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 22 Jul 2024 08:45:54 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Creates a GED - Generic Event Device and set a GPIO to
The wonder of confusing names in ACPI.  I thought I'd
fixed this but clearly not.

This GED isn't a Generic Event Device, it's a 
Generic Error (Device) as per 
18.3.2.7.2  Event Notification for Generic Error Sources
in ACPI 6.5
PNP0C33 vs Generic Event Device which is unrelated :(
and has ID ACPI0013

This one is a bit of ACPI glue logic.
https://lore.kernel.org/lkml/1272350481-27951-8-git-send-email-ying.huang@intel.com/
which is the kernel patch provides a bit more info.
In kernel world this is called Hardware Error Device
I guess to avoid tripping over GED naming?
Maybe we are better using that here - so HED_*

> be used or error injection.

This should probably shout a bit more about the
set_error callback added to struct MachineClass

Whilst that works I suspect it will be controversial and I'd like to hear
other suggestions on how to provide a convenient hook to signal that
we've put an event in the firmware buffer where that signaling can come
from pretty much any hw device emulation in QEMU.

Jonathan



> 
> [mchehab: use a define for the generic event pin number and do some cleanups]
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/arm/virt-acpi-build.c | 30 ++++++++++++++++++++++++++----
>  hw/arm/virt.c            | 14 ++++++++++++--
>  include/hw/arm/virt.h    |  1 +
>  include/hw/boards.h      |  1 +
>  4 files changed, 40 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index f76fb117adff..c502ccf40909 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -63,6 +63,7 @@
>  
>  #define ARM_SPI_BASE 32
>  
> +#define ACPI_GENERIC_EVENT_DEVICE "GEDD"
>  #define ACPI_BUILD_TABLE_SIZE             0x20000
>  
>  static void acpi_dsdt_add_cpus(Aml *scope, VirtMachineState *vms)
> @@ -142,6 +143,8 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
>  static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
>                                             uint32_t gpio_irq)
>  {
> +    uint32_t pin;
> +
>      Aml *dev = aml_device("GPO0");
>      aml_append(dev, aml_name_decl("_HID", aml_string("ARMH0061")));
>      aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> @@ -155,7 +158,12 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
>  
>      Aml *aei = aml_resource_template();
>  
> -    const uint32_t pin = GPIO_PIN_POWER_BUTTON;
> +    pin = GPIO_PIN_POWER_BUTTON;
> +    aml_append(aei, aml_gpio_int(AML_CONSUMER, AML_EDGE, AML_ACTIVE_HIGH,
> +                                 AML_EXCLUSIVE, AML_PULL_UP, 0, &pin, 1,
> +                                 "GPO0", NULL, 0));
> +    /* Pin for generic error */
> +    pin = GPIO_PIN_GENERIC_ERROR;
>      aml_append(aei, aml_gpio_int(AML_CONSUMER, AML_EDGE, AML_ACTIVE_HIGH,
>                                   AML_EXCLUSIVE, AML_PULL_UP, 0, &pin, 1,
>                                   "GPO0", NULL, 0));
> @@ -166,6 +174,11 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
>      aml_append(method, aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
>                                    aml_int(0x80)));
>      aml_append(dev, method);
> +    method = aml_method("_E06", 0, AML_NOTSERIALIZED);
> +    aml_append(method, aml_notify(aml_name(ACPI_GENERIC_EVENT_DEVICE),
> +                                  aml_int(0x80)));
> +    aml_append(dev, method);
> +
>      aml_append(scope, dev);
>  }
>  
> @@ -800,6 +813,15 @@ static void build_fadt_rev6(GArray *table_data, BIOSLinker *linker,
>      build_fadt(table_data, linker, &fadt, vms->oem_id, vms->oem_table_id);
>  }
>  
> +static void acpi_dsdt_add_generic_event_device(Aml *scope)
> +{
> +    Aml *dev = aml_device(ACPI_GENERIC_EVENT_DEVICE);
> +    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C33")));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> +    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
> +    aml_append(scope, dev);
> +}
> +
>  /* DSDT */
>  static void
>  build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> @@ -841,10 +863,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>                        HOTPLUG_HANDLER(vms->acpi_dev),
>                        irqmap[VIRT_ACPI_GED] + ARM_SPI_BASE, AML_SYSTEM_MEMORY,
>                        memmap[VIRT_ACPI_GED].base);
> -    } else {
> -        acpi_dsdt_add_gpio(scope, &memmap[VIRT_GPIO],
> -                           (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
>      }
> +    acpi_dsdt_add_gpio(scope, &memmap[VIRT_GPIO],
> +                       (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
>  
>      if (vms->acpi_dev) {
>          uint32_t event = object_property_get_uint(OBJECT(vms->acpi_dev),
> @@ -858,6 +879,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      }
>  
>      acpi_dsdt_add_power_button(scope);
> +    acpi_dsdt_add_generic_event_device(scope);
>  #ifdef CONFIG_TPM
>      acpi_dsdt_add_tpm(scope, vms);
>  #endif
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index c99c8b1713c6..f81cf3a69961 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -997,6 +997,13 @@ static void create_rtc(const VirtMachineState *vms)
>  }
>  
>  static DeviceState *gpio_key_dev;
> +
> +static DeviceState *gpio_error_dev;
> +static void virt_set_error(void)
> +{
> +    qemu_set_irq(qdev_get_gpio_in(gpio_error_dev, 0), 1);
> +}
> +
>  static void virt_powerdown_req(Notifier *n, void *opaque)
>  {
>      VirtMachineState *s = container_of(n, VirtMachineState, powerdown_notifier);
> @@ -1015,6 +1022,9 @@ static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
>      gpio_key_dev = sysbus_create_simple("gpio-key", -1,
>                                          qdev_get_gpio_in(pl061_dev,
>                                                           GPIO_PIN_POWER_BUTTON));
> +    gpio_error_dev = sysbus_create_simple("gpio-key", -1,
> +                                          qdev_get_gpio_in(pl061_dev,
> +                                                           GPIO_PIN_GENERIC_ERROR));
>  
>      qemu_fdt_add_subnode(fdt, "/gpio-keys");
>      qemu_fdt_setprop_string(fdt, "/gpio-keys", "compatible", "gpio-keys");
> @@ -2385,9 +2395,8 @@ static void machvirt_init(MachineState *machine)
>  
>      if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
>          vms->acpi_dev = create_acpi_ged(vms);
> -    } else {
> -        create_gpio_devices(vms, VIRT_GPIO, sysmem);
>      }
> +    create_gpio_devices(vms, VIRT_GPIO, sysmem);
>  
>      if (vms->secure && !vmc->no_secure_gpio) {
>          create_gpio_devices(vms, VIRT_SECURE_GPIO, secure_sysmem);
> @@ -3101,6 +3110,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>      mc->default_ram_id = "mach-virt.ram";
>      mc->default_nic = "virtio-net-pci";
>  
> +    mc->set_error = virt_set_error;
>      object_class_property_add(oc, "acpi", "OnOffAuto",
>          virt_get_acpi, virt_set_acpi,
>          NULL, NULL);
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index a4d937ed45ac..c9769d7d4d7f 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -49,6 +49,7 @@
>  
>  /* GPIO pins */
>  #define GPIO_PIN_POWER_BUTTON  3
> +#define GPIO_PIN_GENERIC_ERROR 6
>  
>  enum {
>      VIRT_FLASH,
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index ef6f18f2c1a7..6cf01f3934ae 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -304,6 +304,7 @@ struct MachineClass {
>      const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
>      int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
>      ram_addr_t (*fixup_ram_size)(ram_addr_t size);
> +    void (*set_error)(void);
>  };
>  
>  /**


