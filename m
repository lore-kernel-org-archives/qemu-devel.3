Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F081C5DF71
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 05:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUI0l-0002tZ-7T; Tue, 02 Jun 2026 01:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUI0j-0002t4-1z
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 01:49:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUI0f-00089s-PL
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 01:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780379389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YicdZ+7VcJPGsXcIq3ARCeTEZ+88Rn1BIP5t3vU6DOw=;
 b=VbQwvopXoRyTZh8A9EUm4WWiAwaClz0hGguDD4NIZ3uf6M42ngxypJcnHcYUpOUBuwThND
 vUoG9/7cXn/3RCCWS8nYoOWIvXVgTK6rAwiW332YJYi7P6zD5a4Nyp9kWY5NCKG9kBn0pY
 vvyY3g8wg1TtZ+VrN4NqPeEuToMi5Vs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-JuXAGZGwMJ2Gva9EdS4waA-1; Tue,
 02 Jun 2026 01:49:45 -0400
X-MC-Unique: JuXAGZGwMJ2Gva9EdS4waA-1
X-Mimecast-MFC-AGG-ID: JuXAGZGwMJ2Gva9EdS4waA_1780379384
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2E9C1800451; Tue,  2 Jun 2026 05:49:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E25E41800286; Tue,  2 Jun 2026 05:49:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5C1F521E6A01; Tue, 02 Jun 2026 07:49:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Leonid Bloch <lb.workbox@gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,  Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Dmitry Fleytman
 <dmitry.fleytman@gmail.com>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v4 3/8] hw/acpi: Introduce the QEMU Battery
In-Reply-To: <20260526042928.9203-4-lb.workbox@gmail.com> (Leonid Bloch's
 message of "Tue, 26 May 2026 07:29:22 +0300")
References: <20260526042928.9203-1-lb.workbox@gmail.com>
 <20260526042928.9203-4-lb.workbox@gmail.com>
Date: Tue, 02 Jun 2026 07:49:41 +0200
Message-ID: <87a4td8pai.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Leonid Bloch <lb.workbox@gmail.com> writes:

> The battery device communicates battery state to the guest via ACPI.
> Battery state is controlled programmatically via QMP commands, making
> the device deterministic and migration-safe.
>
> Properties:
> - 'ioport': I/O port base address (default: 0x530)
>
> The device implements the ACPI_DEV_AML_IF interface to generate its
> own AML code, placing the BAT0 device directly under \_SB scope as
> per ACPI specification.
>
> QMP commands:
> - battery-set-state: Set battery state (present, charging, capacity, rate)
> - query-battery: Query current battery state

Could we have one patch adding the device, and a second one adding the
QMP commands?

>
> This provides a stable interface for virtualization management systems.
>
> Signed-off-by: Leonid Bloch <lb.workbox@gmail.com>
> Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> ---
>  MAINTAINERS                          |   2 +
>  hw/acpi/Kconfig                      |   4 +
>  hw/acpi/battery-stub.c               |  20 ++
>  hw/acpi/battery.c                    | 364 +++++++++++++++++++++++++++
>  hw/acpi/meson.build                  |   2 +
>  hw/acpi/trace-events                 |   4 +
>  hw/i386/Kconfig                      |   1 +
>  include/hw/acpi/acpi_dev_interface.h |   1 +
>  include/hw/acpi/battery.h            |  32 +++
>  qapi/acpi.json                       |  71 ++++++
>  10 files changed, 501 insertions(+)
>  create mode 100644 hw/acpi/battery-stub.c
>  create mode 100644 hw/acpi/battery.c
>  create mode 100644 include/hw/acpi/battery.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e356f46a58..ce50329f48 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3040,6 +3040,8 @@ Battery
>  M: Leonid Bloch <lb.workbox@gmail.com>
>  S: Maintained
>  F: docs/specs/battery.rst
> +F: hw/acpi/battery*
> +F: include/hw/acpi/battery.h
>=20=20
>  Subsystems
>  ----------
> diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
> index daabbe6cd1..6b2c46d37a 100644
> --- a/hw/acpi/Kconfig
> +++ b/hw/acpi/Kconfig
> @@ -88,3 +88,7 @@ config ACPI_ERST
>  config ACPI_CXL
>      bool
>      depends on ACPI
> +
> +config BATTERY
> +    bool
> +    depends on ACPI
> diff --git a/hw/acpi/battery-stub.c b/hw/acpi/battery-stub.c
> new file mode 100644
> index 0000000000..d2f13b51c1
> --- /dev/null
> +++ b/hw/acpi/battery-stub.c
> @@ -0,0 +1,20 @@
> +/*
> + * QEMU emulated battery device - QMP stubs.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-commands-acpi.h"
> +
> +void qmp_battery_set_state(BatteryInfo *state, Error **errp)
> +{
> +    error_setg(errp, "No battery device found");
> +}
> +
> +BatteryInfo *qmp_query_battery(Error **errp)
> +{
> +    error_setg(errp, "No battery device found");
> +    return NULL;
> +}
> diff --git a/hw/acpi/battery.c b/hw/acpi/battery.c
> new file mode 100644
> index 0000000000..35b81ad486
> --- /dev/null
> +++ b/hw/acpi/battery.c
> @@ -0,0 +1,364 @@
> +/*
> + * QEMU emulated battery device.
> + *
> + * Copyright (c) 2019-2026 Janus Technologies, Inc. (http://janustech.co=
m)
> + *
> + * Authors:
> + *     Leonid Bloch <lb.workbox@gmail.com>
> + *     Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> + *     Dmitry Fleytman <dmitry.fleytman@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "trace.h"
> +#include "hw/isa/isa.h"
> +#include "hw/acpi/acpi.h"
> +#include "qapi/error.h"
> +#include "hw/core/qdev-properties.h"
> +#include "migration/vmstate.h"
> +#include "hw/acpi/acpi_aml_interface.h"
> +#include "qapi/qapi-commands-acpi.h"
> +
> +#include "hw/acpi/battery.h"
> +
> +#define BATTERY_DEVICE(obj) OBJECT_CHECK(BatteryState, (obj), TYPE_BATTE=
RY)
> +
> +#define BATTERY_DISCHARGING  0x01  /* ACPI _BST bit 0 */
> +#define BATTERY_CHARGING     0x02  /* ACPI _BST bit 1 */
> +#define BATTERY_CRITICAL     0x04  /* ACPI _BST bit 2 */
> +#define BATTERY_PRESENT      0x10  /* ACPI _STA bit 4 */
> +
> +typedef struct BatteryState {
> +    ISADevice dev;
> +    MemoryRegion io;
> +    uint16_t ioport;
> +    uint32_t state;
> +    uint32_t rate;
> +    uint32_t charge;
> +    bool qmp_present;
> +    bool qmp_charging;
> +    bool qmp_discharging;
> +    int32_t qmp_charge_percent;
> +    int32_t qmp_rate;
> +} BatteryState;
> +
> +enum {
> +    BSTA_ADDR =3D 0,
> +    BRTE_ADDR =3D 4,
> +    BCRG_ADDR =3D 8,
> +};
> +
> +static void battery_get_dynamic_status(BatteryState *s)
> +{
> +    s->state =3D 0;
> +    if (s->qmp_present) {
> +        s->state |=3D BATTERY_PRESENT;
> +        if (s->qmp_charging) {
> +            s->state |=3D BATTERY_CHARGING;
> +        }
> +        if (s->qmp_discharging) {
> +            s->state |=3D BATTERY_DISCHARGING;
> +        }
> +    }
> +    s->rate =3D s->qmp_rate;
> +    s->charge =3D (s->qmp_charge_percent * BATTERY_FULL_CAP) / 100;
> +
> +    trace_battery_get_dynamic_status(s->state, s->rate, s->charge);
> +}
> +
> +static void battery_realize(DeviceState *dev, Error **errp)
> +{
> +    ISADevice *d =3D ISA_DEVICE(dev);
> +    BatteryState *s =3D BATTERY_DEVICE(dev);
> +    bool ambiguous;
> +
> +    trace_battery_realize();
> +
> +    object_resolve_path_type("", TYPE_BATTERY, &ambiguous);
> +    if (ambiguous) {
> +        error_setg(errp, "at most one %s device is permitted", TYPE_BATT=
ERY);
> +        return;
> +    }
> +
> +    /* Initialize QMP state to sensible defaults */
> +    s->qmp_present =3D true;
> +    s->qmp_charging =3D false;
> +    s->qmp_discharging =3D true;
> +    s->qmp_charge_percent =3D 50;
> +    s->qmp_rate =3D 1000;  /* 1000 mW discharge rate */
> +
> +    isa_register_ioport(d, &s->io, s->ioport);
> +}
> +
> +static const Property battery_device_properties[] =3D {
> +    DEFINE_PROP_UINT16(BATTERY_IOPORT_PROP, BatteryState, ioport, 0x530),
> +};
> +
> +static const VMStateDescription battery_vmstate =3D {
> +    .name =3D "battery",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_BOOL(qmp_present, BatteryState),
> +        VMSTATE_BOOL(qmp_charging, BatteryState),
> +        VMSTATE_BOOL(qmp_discharging, BatteryState),
> +        VMSTATE_INT32(qmp_charge_percent, BatteryState),
> +        VMSTATE_INT32(qmp_rate, BatteryState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void build_battery_aml(AcpiDevAmlIf *adev, Aml *scope)
> +{
> +    Aml *dev, *field, *method, *pkg;
> +    Aml *bat_state, *bat_rate, *bat_charge;
> +    Aml *sb_scope;
> +    BatteryState *s =3D BATTERY_DEVICE(adev);
> +
> +    bat_state  =3D aml_local(0);
> +    bat_rate   =3D aml_local(1);
> +    bat_charge =3D aml_local(2);
> +
> +    sb_scope =3D aml_scope("\\_SB");
> +    dev =3D aml_device("BAT0");
> +    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C0A")));
> +
> +    aml_append(dev, aml_operation_region("DBST", AML_SYSTEM_IO,
> +                                         aml_int(s->ioport),
> +                                         BATTERY_LEN));
> +    field =3D aml_field("DBST", AML_DWORD_ACC, AML_NOLOCK, AML_PRESERVE);
> +    aml_append(field, aml_named_field("BSTA", 32));
> +    aml_append(field, aml_named_field("BRTE", 32));
> +    aml_append(field, aml_named_field("BCRG", 32));
> +    aml_append(dev, field);
> +
> +    method =3D aml_method("_STA", 0, AML_NOTSERIALIZED);
> +    aml_append(method, aml_return(aml_or(aml_int(0x0F),
> +                                         aml_and(aml_name("BSTA"),
> +                                                 aml_int(0x10), NULL),
> +                                         NULL)));
> +    aml_append(dev, method);
> +
> +    method =3D aml_method("_BIF", 0, AML_NOTSERIALIZED);
> +    pkg =3D aml_package(13);
> +    /* Power Unit */
> +    aml_append(pkg, aml_int(0));             /* mW */
> +    /* Design Capacity */
> +    aml_append(pkg, aml_int(BATTERY_FULL_CAP));
> +    /* Last Full Charge Capacity */
> +    aml_append(pkg, aml_int(BATTERY_FULL_CAP));
> +    /* Battery Technology */
> +    aml_append(pkg, aml_int(1));             /* Secondary */
> +    /* Design Voltage */
> +    aml_append(pkg, aml_int(BATTERY_DESIGN_VOLTAGE));
> +    /* Design Capacity of Warning */
> +    aml_append(pkg, aml_int(BATTERY_CAPACITY_OF_WARNING));
> +    /* Design Capacity of Low */
> +    aml_append(pkg, aml_int(BATTERY_CAPACITY_OF_LOW));
> +    /* Battery Capacity Granularity 1 */
> +    aml_append(pkg, aml_int(BATTERY_CAPACITY_GRANULARITY));
> +    /* Battery Capacity Granularity 2 */
> +    aml_append(pkg, aml_int(BATTERY_CAPACITY_GRANULARITY));
> +    /* Model Number */
> +    aml_append(pkg, aml_string("QBAT001"));  /* Model Number */
> +    /* Serial Number */
> +    aml_append(pkg, aml_string("SN00000"));  /* Serial Number */
> +    /* Battery Type */
> +    aml_append(pkg, aml_string("Virtual"));  /* Battery Type */
> +    /* OEM Information */
> +    aml_append(pkg, aml_string("QEMU"));     /* OEM Information */
> +    aml_append(method, aml_return(pkg));
> +    aml_append(dev, method);
> +
> +    pkg =3D aml_package(4);
> +    /* Battery State */
> +    aml_append(pkg, aml_int(0));
> +    /* Battery Present Rate */
> +    aml_append(pkg, aml_int(BATTERY_VAL_UNKNOWN));
> +    /* Battery Remaining Capacity */
> +    aml_append(pkg, aml_int(BATTERY_VAL_UNKNOWN));
> +    /* Battery Present Voltage */
> +    aml_append(pkg, aml_int(BATTERY_DESIGN_VOLTAGE));
> +    aml_append(dev, aml_name_decl("DBPR", pkg));
> +
> +    method =3D aml_method("_BST", 0, AML_NOTSERIALIZED);
> +    aml_append(method, aml_store(aml_and(aml_name("BSTA"), aml_int(0x0F),
> +                                         NULL),
> +                                 bat_state));
> +    aml_append(method, aml_store(aml_name("BRTE"), bat_rate));
> +    aml_append(method, aml_store(aml_name("BCRG"), bat_charge));
> +    aml_append(method, aml_store(bat_state,
> +                                 aml_index(aml_name("DBPR"), aml_int(0))=
));
> +    aml_append(method, aml_store(bat_rate,
> +                                 aml_index(aml_name("DBPR"), aml_int(1))=
));
> +    aml_append(method, aml_store(bat_charge,
> +                                 aml_index(aml_name("DBPR"), aml_int(2))=
));
> +    aml_append(method, aml_return(aml_name("DBPR")));
> +    aml_append(dev, method);
> +
> +    aml_append(sb_scope, dev);
> +    aml_append(scope, sb_scope);
> +
> +    /* Status Change */
> +    method =3D aml_method("\\_GPE._E08", 0, AML_NOTSERIALIZED);
> +    aml_append(method, aml_notify(aml_name("\\_SB.BAT0"), aml_int(0x80))=
);
> +    aml_append(scope, method);
> +}
> +
> +static void battery_class_init(ObjectClass *class, const void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(class);
> +    AcpiDevAmlIfClass *adevc =3D ACPI_DEV_AML_IF_CLASS(class);
> +
> +    dc->realize =3D battery_realize;
> +    dc->hotpluggable =3D false;
> +    device_class_set_props(dc, battery_device_properties);
> +    dc->vmsd =3D &battery_vmstate;
> +    adevc->build_dev_aml =3D build_battery_aml;
> +}
> +
> +static uint64_t battery_ioport_read(void *opaque, hwaddr addr, unsigned =
size)
> +{
> +    BatteryState *s =3D opaque;
> +
> +    battery_get_dynamic_status(s);
> +
> +    switch (addr) {
> +    case BSTA_ADDR:
> +        return s->state;
> +    case BRTE_ADDR:
> +        return s->rate;
> +    case BCRG_ADDR:
> +        return s->charge;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static const MemoryRegionOps battery_ops =3D {
> +    .read =3D battery_ioport_read,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +    },
> +    .impl =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +    },
> +};
> +
> +static void battery_instance_init(Object *obj)
> +{
> +    BatteryState *s =3D BATTERY_DEVICE(obj);
> +
> +    memory_region_init_io(&s->io, obj, &battery_ops, s, "battery",
> +                          BATTERY_LEN);
> +}
> +
> +static const TypeInfo battery_info =3D {
> +    .name          =3D TYPE_BATTERY,
> +    .parent        =3D TYPE_ISA_DEVICE,
> +    .instance_size =3D sizeof(BatteryState),
> +    .class_init    =3D battery_class_init,
> +    .instance_init =3D battery_instance_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { TYPE_ACPI_DEV_AML_IF },
> +        { },
> +    },
> +};
> +
> +static BatteryState *find_battery_device(Error **errp)
> +{
> +    bool ambiguous;
> +    Object *o =3D object_resolve_path_type("", TYPE_BATTERY, &ambiguous);
> +
> +    if (!o) {
> +        error_setg(errp, "No battery device found");
> +        return NULL;
> +    }
> +    if (ambiguous) {
> +        error_setg(errp, "More than one battery device present");

How can we reach this error?  battery_realize() refuses to realize more
than one.

> +        return NULL;
> +    }
> +    return BATTERY_DEVICE(o);
> +}
> +
> +void qmp_battery_set_state(BatteryInfo *state, Error **errp)
> +{
> +    BatteryState *s =3D find_battery_device(errp);
> +    Object *obj;
> +
> +    if (!s) {
> +        return;
> +    }
> +
> +    if (state->charging && state->discharging) {
> +        error_setg(errp,
> +                   "'charging' and 'discharging' are mutually exclusive"=
);
> +        return;
> +    }
> +    if (!state->present && (state->charging || state->discharging)) {
> +        error_setg(errp,
> +                   "'charging'/'discharging' require 'present' to be tru=
e");
> +        return;
> +    }
> +    if (state->charge_percent < 0 || state->charge_percent > 100) {
> +        error_setg(errp, "'charge-percent' must be in the range 0..100");
> +        return;
> +    }
> +    if (state->has_rate && (state->rate < 0 || state->rate > INT32_MAX))=
 {
> +        error_setg(errp, "'rate' must be in the range 0..0x%" PRIX32,
> +                   (uint32_t)INT32_MAX);
> +        return;
> +    }

I feel some of these error messages need work, but let's nail down the
interface first.

> +
> +    s->qmp_present =3D state->present;
> +    s->qmp_charging =3D state->charging;
> +    s->qmp_discharging =3D state->discharging;
> +    s->qmp_charge_percent =3D state->charge_percent;
> +
> +    if (state->has_rate) {
> +        s->qmp_rate =3D state->rate;
> +    }
> +
> +    obj =3D object_resolve_path_type("", TYPE_ACPI_DEVICE_IF, NULL);
> +    if (obj) {
> +        acpi_send_event(DEVICE(obj), ACPI_BATTERY_CHANGE_STATUS);
> +    }
> +}
> +
> +BatteryInfo *qmp_query_battery(Error **errp)
> +{
> +    BatteryState *s =3D find_battery_device(errp);
> +    BatteryInfo *ret;
> +
> +    if (!s) {
> +        return NULL;
> +    }
> +
> +    ret =3D g_new0(BatteryInfo, 1);
> +
> +    ret->present =3D s->qmp_present;
> +    ret->charging =3D s->qmp_charging;
> +    ret->discharging =3D s->qmp_discharging;
> +    ret->charge_percent =3D s->qmp_charge_percent;
> +    ret->has_rate =3D true;
> +    ret->rate =3D s->qmp_rate;
> +
> +    ret->has_remaining_capacity =3D false;
> +    ret->has_design_capacity =3D true;
> +    ret->design_capacity =3D BATTERY_FULL_CAP;
> +
> +    return ret;
> +}
> +
> +static void battery_register_types(void)
> +{
> +    type_register_static(&battery_info);
> +}
> +
> +type_init(battery_register_types)
> diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
> index 1c5251909b..e6bc78274e 100644
> --- a/hw/acpi/meson.build
> +++ b/hw/acpi/meson.build
> @@ -35,6 +35,8 @@ if have_tpm
>  endif
>  stub_ss.add(files('acpi-stub.c', 'aml-build-stub.c', 'ghes-stub.c'))
>  stub_ss.add(files('pci-bridge-stub.c'))
> +acpi_ss.add(when: 'CONFIG_BATTERY', if_true: files('battery.c'))
> +stub_ss.add(files('battery-stub.c'))
>  system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
>  system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
>  stub_ss.add(files('ghes_cper_stub.c'))
> diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events
> index edc93e703c..8a6ab91a13 100644
> --- a/hw/acpi/trace-events
> +++ b/hw/acpi/trace-events
> @@ -87,3 +87,7 @@ acpi_nvdimm_read_io_port(void) "Alert: we never read _D=
SM IO Port"
>  acpi_nvdimm_dsm_mem_addr(uint64_t dsm_mem_addr) "dsm memory address 0x%"=
 PRIx64
>  acpi_nvdimm_dsm_info(uint32_t revision, uint32_t handle, uint32_t functi=
on) "Revision 0x%" PRIx32 " Handle 0x%" PRIx32 " Function 0x%" PRIx32
>  acpi_nvdimm_invalid_revision(uint32_t revision) "Revision 0x%" PRIx32 " =
is not supported, expect 0x1"
> +
> +# battery.c
> +battery_realize(void) "Battery device realize entry"
> +battery_get_dynamic_status(uint32_t state, uint32_t rate, uint32_t charg=
e) "Battery read state: 0x%"PRIx32", rate: %"PRIu32", charge: %"PRIu32
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index 12473acaa7..94004ffeb2 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -39,6 +39,7 @@ config PC
>      imply VIRTIO_VGA
>      imply NVDIMM
>      imply FDC_ISA
> +    imply BATTERY
>      select I8259
>      select I8254
>      select PCKBD
> diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_=
dev_interface.h
> index 65debb90a8..a6f9022c0b 100644
> --- a/include/hw/acpi/acpi_dev_interface.h
> +++ b/include/hw/acpi/acpi_dev_interface.h
> @@ -14,6 +14,7 @@ typedef enum {
>      ACPI_VMGENID_CHANGE_STATUS =3D 32,
>      ACPI_POWER_DOWN_STATUS =3D 64,
>      ACPI_GENERIC_ERROR =3D 128,
> +    ACPI_BATTERY_CHANGE_STATUS =3D 256,
>  } AcpiEventStatusBits;
>=20=20
>  #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"
> diff --git a/include/hw/acpi/battery.h b/include/hw/acpi/battery.h
> new file mode 100644
> index 0000000000..eaff760db9
> --- /dev/null
> +++ b/include/hw/acpi/battery.h
> @@ -0,0 +1,32 @@
> +/*
> + * QEMU emulated battery device.
> + *
> + * Copyright (c) 2019-2026 Janus Technologies, Inc. (http://janustech.co=
m)
> + *
> + * Authors:
> + *     Leonid Bloch <lb.workbox@gmail.com>
> + *     Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> + *     Dmitry Fleytman <dmitry.fleytman@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + */
> +
> +#ifndef HW_ACPI_BATTERY_H
> +#define HW_ACPI_BATTERY_H
> +
> +#define TYPE_BATTERY                  "battery"
> +#define BATTERY_IOPORT_PROP           "ioport"
> +
> +#define BATTERY_FULL_CAP        10000  /* mWh */
> +#define BATTERY_DESIGN_VOLTAGE  12000  /* mV */
> +
> +#define BATTERY_CAPACITY_OF_WARNING   (BATTERY_FULL_CAP /  10)  /* 10% */
> +#define BATTERY_CAPACITY_OF_LOW       (BATTERY_FULL_CAP /  25)  /* 4%  */
> +#define BATTERY_CAPACITY_GRANULARITY  (BATTERY_FULL_CAP / 100)  /* 1%  */
> +
> +#define BATTERY_VAL_UNKNOWN  0xFFFFFFFF
> +
> +#define BATTERY_LEN          0x0C
> +
> +#endif
> diff --git a/qapi/acpi.json b/qapi/acpi.json
> index 906b3687a5..4711a05614 100644
> --- a/qapi/acpi.json
> +++ b/qapi/acpi.json
> @@ -142,3 +142,74 @@
>  ##
>  { 'event': 'ACPI_DEVICE_OST',
>       'data': { 'info': 'ACPIOSTInfo' } }
> +
> +##
> +# @BatteryInfo:
> +#
> +# Battery state information
> +#
> +# @present: whether the battery is present

Peeking at the C code...  there is a difference between "have no
TYPE_BATTERY device" and "have one, but not present".  What does the
latter mean?  The machine has a battery device, but the actual battery
pack is not connected?

> +#
> +# @charging: whether the battery is charging
> +#
> +# @discharging: whether the battery is discharging

Peeking at the C code...  looks like @charging is initialized to false,
@discharging to true, battery-set-state doesn't let you set both to
true, and there is no other way to change them.  Correct?

If yes, you're encoding a tri-state (charging, discharging, neither) as
two bools.  Hmm.

Peeking at the C code some more...  looks like there's more
entanglement: @charging and @discharging must be false when @present is
false.

Let's go through the cases:

    present  charging  discharging  meaning
    false    false     false        battery pack missing
    true     false     true         battery charging
    true     true      false        battery discharging
    true     false     false        ???

Please complete / correct column meaning.

Are there missing rows?

> +#
> +# @charge-percent: battery charge percentage (0-100)
> +#
> +# @rate: charge/discharge rate in mW (optional)

Drop the (optional), please.  As is, the description gets rendered like

    =E2=80=A2 rate (int, optional) =E2=80=93 charge/discharge rate in mW (o=
ptional)

What does absent mean?  Hmm, the type is both ther argument of
battery-set-state and the return value of query-battery.  Let's discuss
there.

> +#
> +# @remaining-capacity: remaining capacity in mWh (optional)

Likewise.

> +#
> +# @design-capacity: design capacity in mWh (optional)

Likewise.

> +#
> +# Since: 11.1
> +##
> +{ 'struct': 'BatteryInfo',
> +  'data': { 'present': 'bool',
> +            'charging': 'bool',
> +            'discharging': 'bool',
> +            'charge-percent': 'int',
> +            '*rate': 'int',
> +            '*remaining-capacity': 'int',
> +            '*design-capacity': 'int' } }
> +
> +##
> +# @battery-set-state:
> +#
> +# Set the state of the emulated battery device
> +#
> +# @state: new battery state
> +#
> +# Since: 11.1
> +#
> +# .. qmp-example::
> +#
> +#     -> { "execute": "battery-set-state",
> +#          "arguments": { "state": { "present": true,
> +#                                    "charging": true,
> +#                                    "discharging": false,
> +#                                    "charge-percent": 85 } } }
> +#     <- { "return": {} }
> +##
> +{ 'command': 'battery-set-state',
> +  'data': { 'state': 'BatteryInfo' } }

This interface fundamentally assumes there is at most one battery.  Is
that what we want?  Forever and ever?

Let's avoid the silly "state": { ... }:

   { 'command': 'battery-set-state', 'boxed': true,
     'data': 'BatteryInfo' }

Peeking at the command handler code...  the command fails when there is
no TYPE_BATTERY device or more than one.

Members @charging, @discharging, @charge-percent are mandatory.  They
must be present even with "present": false.  Do they make any sense
then?

Should we document the command fails when there is no battery device?

> +
> +##
> +# @query-battery:
> +#
> +# Query the current state of the emulated battery device
> +#
> +# Returns: current battery state

This gets rendered like

 Command query-battery (Since: 11.1)

    Query the current state of the emulated battery device

    Return:

        BatteryInfo =E2=80=93 current battery state

If you simply omit the Returns: line, it'll be

 Command query-battery (Since: 11.1)

    Query the current state of the emulated battery device

    Return:

        BatteryInfo

Choice is up to you.

Should we document the command fails when there is no battery device?

> +#
> +# Since: 11.1
> +#
> +# .. qmp-example::
> +#
> +#     -> { "execute": "query-battery" }
> +#     <- { "return": { "present": true,
> +#                      "charging": true,
> +#                      "discharging": false,
> +#                      "charge-percent": 85 } }
> +##
> +{ 'command': 'query-battery',
> +  'returns': 'BatteryInfo' }


