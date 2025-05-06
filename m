Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3656C3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 11:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCGlj-0003N1-Pl; Tue, 06 May 2025 07:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uCGlh-0003Md-IL
 for qemu-devel@nongnu.org; Tue, 06 May 2025 07:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uCGlf-0003Zw-85
 for qemu-devel@nongnu.org; Tue, 06 May 2025 07:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746532041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fPA83f9n7U+j2ivhh1cgKqvTOzonyblIQVSHD3/jO+Y=;
 b=Fm+lUuU9guQ2xNU6VqvV/rZQSoW3dZLFqY2bhoj5SXm62CcBi2+TVle3LBaYwsZxwXBbSr
 5hGN5KpTY69dsGoNP0xzkUnoP95n79iFFSGN0ccjiMsnQW7Hbi+UKb4Os7yLgwcsmQR5UC
 2XrxOshfDIwWYWLGZFE7WgzyS1Cc180=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-7WaJU5MjN_GLa4L2N08WeQ-1; Tue,
 06 May 2025 07:47:18 -0400
X-MC-Unique: 7WaJU5MjN_GLa4L2N08WeQ-1
X-Mimecast-MFC-AGG-ID: 7WaJU5MjN_GLa4L2N08WeQ_1746532036
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 904811955D54; Tue,  6 May 2025 11:47:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56427195608D; Tue,  6 May 2025 11:47:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AFC1D21E66C3; Tue, 06 May 2025 13:47:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Shameer Kolothum via <qemu-devel@nongnu.org>
Cc: <qemu-arm@nongnu.org>,  Shameer Kolothum
 <shameerali.kolothum.thodi@huawei.com>,  <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>,  <jgg@nvidia.com>,  <nicolinc@nvidia.com>,
 <ddutile@redhat.com>,  <berrange@redhat.com>,  <nathanc@nvidia.com>,
 <mochs@nvidia.com>,  <smostafa@google.com>,  <linuxarm@huawei.com>,
 <wangzhou1@hisilicon.com>,  <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>,  <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a PCIe RC
In-Reply-To: <20250502102707.110516-2-shameerali.kolothum.thodi@huawei.com>
 (Shameer Kolothum via's message of "Fri, 2 May 2025 11:27:02 +0100")
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-2-shameerali.kolothum.thodi@huawei.com>
Date: Tue, 06 May 2025 13:47:11 +0200
Message-ID: <877c2ut0zk.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Shameer Kolothum via <qemu-devel@nongnu.org> writes:

> Although this change does not affect functionality at present, it lays
> the groundwork for enabling user-created SMMUv3 devices in
> future patches
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/smmuv3.c | 26 ++++++++++++++++++++++++++
>  hw/arm/virt.c   |  3 ++-
>  2 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index ab67972353..605de9b721 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -24,6 +24,7 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/qdev-core.h"
>  #include "hw/pci/pci.h"
> +#include "hw/pci/pci_bridge.h"
>  #include "cpu.h"
>  #include "exec/target_page.h"
>  #include "trace.h"
> @@ -1874,6 +1875,25 @@ static void smmu_reset_exit(Object *obj, ResetType=
 type)
>      smmuv3_init_regs(s);
>  }
>=20=20
> +static int smmuv3_pcie_bus(Object *obj, void *opaque)
> +{
> +    DeviceState *d =3D opaque;
> +    PCIBus *bus;
> +
> +    if (!object_dynamic_cast(obj, TYPE_PCI_HOST_BRIDGE)) {
> +        return 0;
> +    }
> +
> +    bus =3D PCI_HOST_BRIDGE(obj)->bus;
> +    if (d->parent_bus && !strcmp(bus->qbus.name, d->parent_bus->name)) {
> +        object_property_set_link(OBJECT(d), "primary-bus", OBJECT(bus),
> +                                 &error_abort);
> +        /* Return non-zero as we got the bus and don't need further iter=
ation.*/
> +        return 1;
> +    }
> +    return 0;
> +}
> +
>  static void smmu_realize(DeviceState *d, Error **errp)
>  {
>      SMMUState *sys =3D ARM_SMMU(d);
> @@ -1882,6 +1902,10 @@ static void smmu_realize(DeviceState *d, Error **e=
rrp)
>      SysBusDevice *dev =3D SYS_BUS_DEVICE(d);
>      Error *local_err =3D NULL;
>=20=20
> +    if (!object_property_get_link(OBJECT(d), "primary-bus", &error_abort=
)) {
> +        object_child_foreach_recursive(object_get_root(), smmuv3_pcie_bu=
s, d);
> +    }
> +
>      c->parent_realize(d, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> @@ -1996,6 +2020,8 @@ static void smmuv3_class_init(ObjectClass *klass, c=
onst void *data)
>      device_class_set_parent_realize(dc, smmu_realize,
>                                      &c->parent_realize);
>      device_class_set_props(dc, smmuv3_properties);
> +    dc->hotpluggable =3D false;
> +    dc->bus_type =3D TYPE_PCIE_BUS;

This is very, very wrong.

The function serves as .class_init() for QOM type "arm-smmuv3", defined
as:

   static const TypeInfo smmuv3_type_info =3D {
       .name          =3D TYPE_ARM_SMMUV3,
       .parent        =3D TYPE_ARM_SMMU,

Subtype of "arm-smmuv3".

       .instance_size =3D sizeof(SMMUv3State),
       .instance_init =3D smmuv3_instance_init,
       .class_size    =3D sizeof(SMMUv3Class),
       .class_init    =3D smmuv3_class_init,
   };


    static const TypeInfo smmu_base_info =3D {
        .name          =3D TYPE_ARM_SMMU,
        .parent        =3D TYPE_SYS_BUS_DEVICE,

Subtype of "sys-bus-device".

        .instance_size =3D sizeof(SMMUState),
        .class_data    =3D NULL,
        .class_size    =3D sizeof(SMMUBaseClass),
        .class_init    =3D smmu_base_class_init,
        .abstract      =3D true,
    };

Have a look at the instance struct:

   struct SMMUv3State {
       SMMUState     smmu_state;

Starts with the supertype's instance struct, as is proper.

       uint32_t features;
       [more ...]
   };

Here's the supertype's instance struct:

   struct SMMUState {
       /* <private> */
       SysBusDevice  dev;

Again, starts with the supertype's instance struct.

       const char *mrtypename;
       [more...]
   };

This is a sysbus device, not a PCI device.  Monkey-patching dc->bus_type
from TYPE_SYSTEM_BUS to TYPE_PCIE_BUS won't change that.  All it
accomplishes is making the qdev core believe it plugs into a PCIE bus.
This can only end in tears.

In fact, when I build with the entire series applied (so the device can
actually be used with -device), the result dies within seconds of my ad
hoc testing:

    $ qemu-system-aarch64 -nodefaults -S -display none -monitor stdio -M vi=
rt -device pxb-pcie,id=3Dpcie.1,bus_nr=3D2 -device arm-smmuv3,bus=3Dpcie.1
    QEMU 10.0.50 monitor - type 'help' for more information
    qemu-system-aarch64: -device arm-smmuv3,bus=3Dpcie.1: warning: SMMUv3 d=
evice only supported with pcie.0 for DT
    (qemu) info qtree
    bus: main-system-bus
      type System
      dev: pxb-host, id ""
        x-config-reg-migration-enabled =3D true
        bypass-iommu =3D false
        bus: pcie.1
          type pxb-pcie-bus
          dev: arm-smmuv3, id ""
            gpio-out "sysbus-irq" 4
            stage =3D "nested"
            bus_num =3D 0 (0x0)
    Segmentation fault (core dumped)

Backtrace:

    #0  0x00005555557d8521 in pcibus_dev_print
        (mon=3D0x55555826d0e0, dev=3D0x5555590ad360, indent=3D8)
        at ../hw/pci/pci-hmp-cmds.c:140
    #1  0x0000555555eac0a0 in bus_print_dev
        (bus=3D<optimized out>, mon=3D<optimized out>, dev=3D0x5555590ad360=
, indent=3D8)
        at ../system/qdev-monitor.c:773
    #2  qdev_print (mon=3D<optimized out>, dev=3D<optimized out>, indent=3D=
8)
        at ../system/qdev-monitor.c:805
    #3  qbus_print
        (mon=3Dmon@entry=3D0x55555826d0e0, bus=3Dbus@entry=3D0x5555590ac4a0=
, indent=3D6,=20
        indent@entry=3D4, details=3Ddetails@entry=3Dtrue) at ../system/qdev=
-monitor.c:821
    #4  0x0000555555eabd92 in qbus_print
        (mon=3D0x55555826d0e0, bus=3D<optimized out>, indent=3D2, details=
=3Dtrue)
        at ../system/qdev-monitor.c:824
    #5  0x0000555555979789 in handle_hmp_command_exec
        (cmd=3D<optimized out>, mon=3D0x55555826d0e0, qdict=3D0x55555907d8e=
0)
        at ../monitor/hmp.c:1106
    #6  handle_hmp_command_exec
        (mon=3D0x55555826d0e0, cmd=3D0x55555769d220 <hmp_info_cmds+2560>, q=
dict=3D0x55555907d8e0) at ../monitor/hmp.c:1098
    #7  handle_hmp_command (mon=3Dmon@entry=3D0x55555826d0e0, cmdline=3D<op=
timized out>,=20
        cmdline@entry=3D0x555558657490 "info qtree") at ../monitor/hmp.c:11=
58
    #8  0x000055555597983c in monitor_command_cb

Crash line is

    int class =3D pci_get_word(d->config + PCI_CLASS_DEVICE);

Debugger shows that d->config is invalid.  This is hardly surprising!

The qdev core is trying to print information on the "arm_smmuv3" device
here.  It's working with a DeviceState.  Your monkey-patching convinced
it it's a PCIDevice, so it duly calls pcibus_dev_print() to print PCI
device information.  pcibus_dev_print() casts the DeviceState * to
PCIDevice *.  This assumes the device's instance actually starts with
PCIDevice.  It actually starts with SysBusDevice.

Unsurprisingly, and "make check" also fails:

    >>> MESON_TEST_ITERATION=3D1 MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_=
error=3D1:print_summary=3D1:print_stacktrace=3D1 RUST_BACKTRACE=3D1 QTEST_Q=
EMU_BINARY=3D./qemu-system-aarch64 QTEST_QEMU_IMG=3D./qemu-img G_TEST_DBUS_=
DAEMON=3D/work/armbru/qemu/tests/dbus-vmstate-daemon.sh ASAN_OPTIONS=3Dhalt=
_on_error=3D1:abort_on_error=3D1:print_summary=3D1 PYTHON=3D/work/armbru/qe=
mu/bld-arm/pyvenv/bin/python3 UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_er=
ror=3D1:print_summary=3D1:print_stacktrace=3D1 MALLOC_PERTURB_=3D22 /work/a=
rmbru/qemu/bld-arm/tests/qtest/test-hmp --tap -k
    =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95
    stderr:
    qemu-system-aarch64: ../hw/core/qdev.c:113: qdev_set_parent_bus: Assert=
ion `dc->bus_type && object_dynamic_cast(OBJECT(bus), dc->bus_type)' failed.
    Broken pipe
    ../tests/qtest/libqtest.c:208: kill_qemu() detected QEMU death from sig=
nal 6 (Aborted) (core dumped)

and

    >>> MESON_TEST_ITERATION=3D1 MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_=
error=3D1:print_summary=3D1:print_stacktrace=3D1 RUST_BACKTRACE=3D1 QTEST_Q=
EMU_BINARY=3D./qemu-system-aarch64 MALLOC_PERTURB_=3D86 QTEST_QEMU_IMG=3D./=
qemu-img G_TEST_DBUS_DAEMON=3D/work/armbru/qemu/tests/dbus-vmstate-daemon.s=
h ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1 PYT=
HON=3D/work/armbru/qemu/bld-arm/pyvenv/bin/python3 UBSAN_OPTIONS=3Dhalt_on_=
error=3D1:abort_on_error=3D1:print_summary=3D1:print_stacktrace=3D1 /work/a=
rmbru/qemu/bld-arm/tests/qtest/qom-test --tap -k
    =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95
    stderr:
    qemu-system-aarch64: ../hw/core/qdev.c:113: qdev_set_parent_bus: Assert=
ion `dc->bus_type && object_dynamic_cast(OBJECT(bus), dc->bus_type)' failed.
    Broken pipe
    ../tests/qtest/libqtest.c:208: kill_qemu() detected QEMU death from sig=
nal 6 (Aborted) (core dumped)

Please make sure "make check" passes before posting patches for review.
If you need help getting there, post them marked RFC and with the bad
test results right in the cover letter.

>  }
>=20=20
>  static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 177f3dd22c..3bae4e374f 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -56,6 +56,7 @@
>  #include "qemu/cutils.h"
>  #include "qemu/error-report.h"
>  #include "qemu/module.h"
> +#include "hw/pci/pci_bus.h"
>  #include "hw/pci-host/gpex.h"
>  #include "hw/virtio/virtio-pci.h"
>  #include "hw/core/sysbus-fdt.h"
> @@ -1442,7 +1443,7 @@ static void create_smmu(const VirtMachineState *vms,
>      }
>      object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
>                               &error_abort);
> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    qdev_realize_and_unref(dev, &bus->qbus, &error_fatal);
>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
>      for (i =3D 0; i < NUM_SMMU_IRQS; i++) {
>          sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,

What are you trying to accomplish?

I *guess* you're trying to change the "arm-smmuv3" device to be a PCI
device.  Correct?

The only way to do that is making it a subtype of PCIDevice, i.e. change
the parent chain from

   arm-smmuv3 -> arm-smmu -> sys-bus-device -> device -> object

to something like

   arm-smmuv3 ->    ...   -> pci-device -> device -> object

Note you cannot have different subtypes of the same supertype (say
"arm-smmu") plug into different buses.  If you need a common device core
to plug into different buses, things get more complicated.  Here's how
the "serial-FOO" devices do it:

* "serial-mm", a subtype of "sys-bus-device", thus plugs into system bus
* "serial-isa", a subtype of "isa-device", thus plugs into ISA bus
* "serial-pci", a subtype of "pci-device", thus plugs into PCI bus

They all *contain* the core "serial" device, which is a subtype of
"device", and thus does not plug into any bus.  "Contain" is "has a",
not "subtype of".

[...]


