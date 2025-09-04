Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3074ACA1002
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 12:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu9UY-0006Dd-QB; Thu, 04 Sep 2025 08:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uu9UU-0006BC-Ju
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 08:55:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uu9UN-0004xA-LO
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 08:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756990491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/JsCGZhY0WwTKaa+9j4GgraFmHEGimU/KsqFe08f/b4=;
 b=buWZkMaaY7KmDtNyAIwTnGd/cCddnewKuRWM/AEdChtvJMb00R3HCUrU5/Qxl2C2RcBAbf
 R1h9Lga1Ob2DNZadMsQwbrHHvHew+I4/MTKMdvzWkerM4VM1S10O9X+1RV+VwJtxKc/mVQ
 1aOK1JDhDyqt6kmXYwvC9xiUFFEH+sY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-FG9W9skDPmaK5XAg6b2I4A-1; Thu, 04 Sep 2025 08:54:50 -0400
X-MC-Unique: FG9W9skDPmaK5XAg6b2I4A-1
X-Mimecast-MFC-AGG-ID: FG9W9skDPmaK5XAg6b2I4A_1756990489
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45b869d3562so8189135e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 05:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756990489; x=1757595289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/JsCGZhY0WwTKaa+9j4GgraFmHEGimU/KsqFe08f/b4=;
 b=XbX26YcDiE9bhH72aOf9V7jqIc2vEgLTsSSbfvYpTPLq/3aUgSgjOhstXD9mM71mDb
 An2ehb7kFNsU8xKCi0esTa32OrEnjZtBCbCHsySOMYbkRbdYU7xe2l4W10diNAY9C6cf
 r/5T/xnqSls4zoE0MVxyTRBobewlypKloxnc0fGsKbtFqRBL7RuiNUHgsU4CWOiF4gcY
 RDTE54CBB/6tOT0I0FgHU23AbD5b3Hi2CrmNts1AKoQeFUJ2dgoYfpJD5on1t3FM1E98
 6kZYGWkmTflWGZva3U2f1qeUwraszOxH6NCVV9J+bPm0tKE3C6SE8hcJc1W/Ut9XTkKk
 eauw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnsjYkYt4bh/OQDQOZjiIjh3m5/GNUbMlC/0yzHjhqxCxF/b99CF+u49gfF6hiXwr2Y99XLrtorRKM@nongnu.org
X-Gm-Message-State: AOJu0Yzkb0HFVxGwoChnNHjJpXCDhfGwcT1eM50P4FoAh7zcmzrZp52j
 GDbvosGJfDEv8ZnWQZ1xyA5/ffLRHAhaSIo9PKajQfBVwbhh8P9A6t3dNvXrGLIG4qn4PfFiVRm
 EvMvRBYeFtY5BTV613/B4J5M3sSP1QqBb2XL8q3el/6istna7j45f6t0E
X-Gm-Gg: ASbGncsV6O2rPJToRsdzcE+QMkCmfyw7pT2Ly+i8003/fjGf+8T8GZ+PviS0C2OX/ZF
 1weDsgApqgOE2aZQ9EpY6xYcDtHGPQvZRDCxzURHXdppYqyxcJm0ytJDQJ18x8pFhOM0l8ndUgb
 b5gQ01O0+SdKzfVH9He2Qn07Boggb9Db8WUUjAhf0Q438lf+gLfuHOgsfVvjz1DNZbz1b6G62QL
 pyTb/VdSlX3VAYXv+GB7lai6RzMv/KQPwHcS7RXCqzhI3tFhVqm+5C0WLjNEfO0lUBydp6Bl090
 5ymbzDo2NNTnzecj/BCa+KlwNlRLlg==
X-Received: by 2002:a05:600c:4512:b0:458:bfb1:1fb6 with SMTP id
 5b1f17b1804b1-45b8555070fmr153618915e9.2.1756990488575; 
 Thu, 04 Sep 2025 05:54:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU40VGzNpZfDkvTEgVeb+TW/Yp9DpMeuYkyogfbNHjonMvPLbTfwb1l1NDFv6AA7e6/mATbw==
X-Received: by 2002:a05:600c:4512:b0:458:bfb1:1fb6 with SMTP id
 5b1f17b1804b1-45b8555070fmr153618705e9.2.1756990488055; 
 Thu, 04 Sep 2025 05:54:48 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e0f2ef13e2sm2994272f8f.31.2025.09.04.05.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 05:54:47 -0700 (PDT)
Date: Thu, 4 Sep 2025 14:54:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Leonid Bloch <lb.workbox@gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Eric
 Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Dmitry Fleytman
 <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/4] hw/acpi: Introduce the QEMU Battery
Message-ID: <20250904145444.40964692@fedora>
In-Reply-To: <20250827220054.37268-3-lb.workbox@gmail.com>
References: <20250827220054.37268-1-lb.workbox@gmail.com>
 <20250827220054.37268-3-lb.workbox@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 28 Aug 2025 01:00:48 +0300
Leonid Bloch <lb.workbox@gmail.com> wrote:

> The battery device communicates battery state to the guest via ACPI.
> It supports two modes of operation:
> 
> 1. QMP control mode (default): Battery state is controlled programmatically
>    via QMP commands, making the device deterministic and migration-safe.
> 
> 2. Host mirroring mode (optional): The device reflects the host's battery
>    state from sysfs. Probing occurs on guest ACPI requests and at timed
>    intervals (default 2 seconds, configurable via 'probe_interval' property
>    in milliseconds). State changes trigger ACPI notifications to the guest.
> 
> Properties:
> - 'use-qmp': Enable QMP control mode (default: true)
> - 'enable-sysfs': Enable host battery mirroring (default: false)
> - 'probe_interval': Probe interval in ms for sysfs mode (default: 2000)
> - 'sysfs_path': Override default sysfs path /sys/class/power_supply/
> 
> The device implements the ACPI_DEV_AML_IF interface to generate its
> own AML code, placing the BAT0 device directly under \_SB scope as
> per ACPI specification.
> 
> QMP commands:
> - battery-set-state: Set battery state (present, charging, capacity, rate)
> - query-battery: Query current battery state
> 
> This allows testing without host battery access and provides a stable
> interface for virtualization management systems.
> 
> Signed-off-by: Leonid Bloch <lb.workbox@gmail.com>
> Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
[...]

> +
> +static void build_battery_aml(AcpiDevAmlIf *adev, Aml *scope)
> +{
> +    Aml *dev, *field, *method, *pkg;
> +    Aml *bat_state, *bat_rate, *bat_charge;
> +    Aml *sb_scope;
> +    BatteryState *s = BATTERY_DEVICE(adev);
> +
> +    bat_state  = aml_local(0);
> +    bat_rate   = aml_local(1);
> +    bat_charge = aml_local(2);
> +
> +    sb_scope = aml_scope("\\_SB");
> +    dev = aml_device("BAT0");
> +    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C0A")));
> +
> +    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> +    aml_append(method, aml_return(aml_int(0x1F)));
> +    aml_append(dev, method);
> +
> +    aml_append(dev, aml_operation_region("DBST", AML_SYSTEM_IO,
> +                                         aml_int(s->ioport),
> +                                         BATTERY_LEN));
> +    field = aml_field("DBST", AML_DWORD_ACC, AML_NOLOCK, AML_PRESERVE);
> +    aml_append(field, aml_named_field("BSTA", 32));
> +    aml_append(field, aml_named_field("BRTE", 32));
> +    aml_append(field, aml_named_field("BCRG", 32));
> +    aml_append(dev, field);
> +
> +    method = aml_method("_BIF", 0, AML_NOTSERIALIZED);
> +    pkg = aml_package(13);
> +    /* Power Unit */
> +    aml_append(pkg, aml_int(0));             /* mW */
> +    /* Design Capacity */
> +    aml_append(pkg, aml_int(BATTERY_FULL_CAP));
> +    /* Last Full Charge Capacity */
> +    aml_append(pkg, aml_int(BATTERY_FULL_CAP));
> +    /* Battery Technology */
> +    aml_append(pkg, aml_int(1));             /* Secondary */
> +    /* Design Voltage */
> +    aml_append(pkg, aml_int(BATTERY_VAL_UNKNOWN));
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
> +    pkg = aml_package(4);
> +    /* Battery State */
> +    aml_append(pkg, aml_int(0));
> +    /* Battery Present Rate */
> +    aml_append(pkg, aml_int(BATTERY_VAL_UNKNOWN));
> +    /* Battery Remaining Capacity */
> +    aml_append(pkg, aml_int(BATTERY_VAL_UNKNOWN));
> +    /* Battery Present Voltage */
> +    aml_append(pkg, aml_int(BATTERY_VAL_UNKNOWN));
> +    aml_append(dev, aml_name_decl("DBPR", pkg));
> +
> +    method = aml_method("_BST", 0, AML_NOTSERIALIZED);
> +    aml_append(method, aml_store(aml_name("BSTA"), bat_state));
> +    aml_append(method, aml_store(aml_name("BRTE"), bat_rate));
> +    aml_append(method, aml_store(aml_name("BCRG"), bat_charge));
> +    aml_append(method, aml_store(bat_state,
> +                                 aml_index(aml_name("DBPR"), aml_int(0))));
> +    aml_append(method, aml_store(bat_rate,
> +                                 aml_index(aml_name("DBPR"), aml_int(1))));
> +    aml_append(method, aml_store(bat_charge,
> +                                 aml_index(aml_name("DBPR"), aml_int(2))));
> +    aml_append(method, aml_return(aml_name("DBPR")));
> +    aml_append(dev, method);
> +
> +    aml_append(sb_scope, dev);
> +    aml_append(scope, sb_scope);
> +
> +    /* Device Check */
> +    method = aml_method("\\_GPE._E07", 0, AML_NOTSERIALIZED);
> +    aml_append(method, aml_notify(aml_name("\\_SB.BAT0"), aml_int(0x01)));
> +    aml_append(scope, method);
> +
> +    /* Status Change */
> +    method = aml_method("\\_GPE._E08", 0, AML_NOTSERIALIZED);
> +    aml_append(method, aml_notify(aml_name("\\_SB.BAT0"), aml_int(0x80)));
> +    aml_append(scope, method);
> +
> +    /* Information Change */
> +    method = aml_method("\\_GPE._E09", 0, AML_NOTSERIALIZED);
> +    aml_append(method, aml_notify(aml_name("\\_SB.BAT0"), aml_int(0x81)));
> +    aml_append(scope, method);
> +}
> +
> +static void battery_class_init(ObjectClass *class, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(class);
> +    AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(class);
> +
> +    dc->realize = battery_realize;
> +    device_class_set_props(dc, battery_device_properties);
> +    dc->vmsd = &battery_vmstate;
> +    adevc->build_dev_aml = build_battery_aml;
> +}
> +
> +static uint64_t battery_ioport_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    BatteryState *s = opaque;
> +
> +    battery_get_dynamic_status(s);
> +
> +    switch (addr) {
> +    case bsta_addr0:
> +        return s->state.acc[0];
> +    case bsta_addr1:
> +        return s->state.acc[1];
> +    case bsta_addr2:
> +        return s->state.acc[2];
> +    case bsta_addr3:
> +        return s->state.acc[3];
> +    case brte_addr0:
> +        return s->rate.acc[0];
> +    case brte_addr1:
> +        return s->rate.acc[1];
> +    case brte_addr2:
> +        return s->rate.acc[2];
> +    case brte_addr3:
> +        return s->rate.acc[3];
> +    case bcrg_addr0:
> +        return s->charge.acc[0];
> +    case bcrg_addr1:
> +        return s->charge.acc[1];
> +    case bcrg_addr2:
> +        return s->charge.acc[2];
> +    case bcrg_addr3:
> +        return s->charge.acc[3];

why do you handle it as byte access when in AML fields are
declared as DWORD access?

> +    default:
> +        warn_report("Battery: guest read unknown value.");

abort here, but I doubt that you can get here at all
if memory region is correctly sized.

> +        trace_battery_ioport_read_unknown();
> +        return 0;
> +    }
> +}
> +
> +static const MemoryRegionOps battery_ops = {
> +    .read = battery_ioport_read,
> +    .impl = {
> +        .min_access_size = 1,
> +        .max_access_size = 1,
same question wrt access size.
Suggest making it explicitly 4 byte and little-endinan

> +    },
> +};
> +
> +static void battery_instance_init(Object *obj)
> +{
> +    BatteryState *s = BATTERY_DEVICE(obj);
> +
> +    memory_region_init_io(&s->io, obj, &battery_ops, s, "battery",
> +                          BATTERY_LEN);
> +}
> +
> +static const TypeInfo battery_info = {
> +    .name          = TYPE_BATTERY,
> +    .parent        = TYPE_ISA_DEVICE,
> +    .instance_size = sizeof(BatteryState),
> +    .class_init    = battery_class_init,
> +    .instance_init = battery_instance_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_ACPI_DEV_AML_IF },
> +        { },
> +    },
> +};
> +
> +static BatteryState *find_battery_device(void)
> +{
> +    Object *o = object_resolve_path_type("", TYPE_BATTERY, NULL);

also use 3rd argument and error out in case it's true,
so user would know what went wrong.
 
> +    if (!o) {
> +        return NULL;
> +    }
> +    return BATTERY_DEVICE(o);
> +}
> +
> +void qmp_battery_set_state(BatteryInfo *state, Error **errp)
> +{
> +    BatteryState *s = find_battery_device();
> +
> +    if (!s) {
> +        error_setg(errp, "No battery device found");
> +        return;
> +    }
> +
> +    s->qmp_present = state->present;
> +    s->qmp_charging = state->charging;
> +    s->qmp_discharging = state->discharging;
> +    s->qmp_charge_percent = state->charge_percent;
> +
> +    if (state->has_rate) {
> +        s->qmp_rate = state->rate;
> +    }
> +
> +    Object *obj = object_resolve_path_type("", TYPE_ACPI_DEVICE_IF, NULL);
> +    if (obj) {
> +        acpi_send_event(DEVICE(obj), ACPI_BATTERY_CHANGE_STATUS);
> +    }
> +}
> +
> +BatteryInfo *qmp_query_battery(Error **errp)
> +{
> +    BatteryState *s = find_battery_device();
> +    BatteryInfo *ret;
> +
> +    if (!s) {
> +        error_setg(errp, "No battery device found");
> +        return NULL;
> +    }
> +
> +    ret = g_new0(BatteryInfo, 1);
> +
> +    if (s->use_qmp_control) {
> +        ret->present = s->qmp_present;
> +        ret->charging = s->qmp_charging;
> +        ret->discharging = s->qmp_discharging;
> +        ret->charge_percent = s->qmp_charge_percent;
> +        ret->has_rate = true;
> +        ret->rate = s->qmp_rate;
> +    } else {
> +        battery_get_dynamic_status(s);
> +        ret->present = true;
> +        ret->charging = !!(s->state.val & BATTERY_CHARGING);
> +        ret->discharging = !!(s->state.val & BATTERY_DISCHARGING);
> +        ret->charge_percent = (s->charge.val * 100) / BATTERY_FULL_CAP;
> +        ret->has_rate = true;
> +        ret->rate = s->rate.val;
> +    }
> +
> +    ret->has_remaining_capacity = false;
> +    ret->has_design_capacity = true;
> +    ret->design_capacity = BATTERY_FULL_CAP;
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
> index 73f02b9691..10379a7b2c 100644
> --- a/hw/acpi/meson.build
> +++ b/hw/acpi/meson.build
> @@ -31,6 +31,7 @@ acpi_ss.add(when: 'CONFIG_PC', if_false: files('acpi-x86-stub.c'))
>  if have_tpm
>    acpi_ss.add(files('tpm.c'))
>  endif
> +acpi_ss.add(when: 'CONFIG_BATTERY', if_true: files('battery.c'))
>  system_ss.add(when: 'CONFIG_ACPI', if_false: files('acpi-stub.c', 'aml-build-stub.c', 'ghes-stub.c', 'acpi_interface.c'))
>  system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false: files('pci-bridge-stub.c'))
>  system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
> diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events
> index edc93e703c..dd3e815482 100644
> --- a/hw/acpi/trace-events
> +++ b/hw/acpi/trace-events
> @@ -87,3 +87,8 @@ acpi_nvdimm_read_io_port(void) "Alert: we never read _DSM IO Port"
>  acpi_nvdimm_dsm_mem_addr(uint64_t dsm_mem_addr) "dsm memory address 0x%" PRIx64
>  acpi_nvdimm_dsm_info(uint32_t revision, uint32_t handle, uint32_t function) "Revision 0x%" PRIx32 " Handle 0x%" PRIx32 " Function 0x%" PRIx32
>  acpi_nvdimm_invalid_revision(uint32_t revision) "Revision 0x%" PRIx32 " is not supported, expect 0x1"
> +
> +# battery.c
> +battery_realize(void) "Battery device realize entry"
> +battery_get_dynamic_status(uint32_t state, uint32_t rate, uint32_t charge) "Battery read state: 0x%"PRIx32", rate: %"PRIu32", charge: %"PRIu32
> +battery_ioport_read_unknown(void) "Battery read unknown"
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index 3a0e2b8ebb..2c878fd112 100644
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
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 423c4959fe..790b16e582 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1248,6 +1248,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>  
>          aml_append(sb_scope, dev);
>      }
> +
>      aml_append(dsdt, sb_scope);
>  
>      if (pm->pcihp_bridge_en || pm->pcihp_root_en) {
> diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
> index 68d9d15f50..3064ef6734 100644
> --- a/include/hw/acpi/acpi_dev_interface.h
> +++ b/include/hw/acpi/acpi_dev_interface.h
> @@ -13,6 +13,7 @@ typedef enum {
>      ACPI_NVDIMM_HOTPLUG_STATUS = 16,
>      ACPI_VMGENID_CHANGE_STATUS = 32,
>      ACPI_POWER_DOWN_STATUS = 64,
> +    ACPI_BATTERY_CHANGE_STATUS = 128,
>  } AcpiEventStatusBits;
>  
>  #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"
> diff --git a/include/hw/acpi/battery.h b/include/hw/acpi/battery.h
> new file mode 100644
> index 0000000000..5c5e83abfa
> --- /dev/null
> +++ b/include/hw/acpi/battery.h
> @@ -0,0 +1,33 @@
> +/*
> + * QEMU emulated battery device.
> + *
> + * Copyright (c) 2019 Janus Technologies, Inc. (http://janustech.com)
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
> +#define BATTERY_PATH_PROP             "sysfs_path"
> +#define BATTERY_PROBE_STATE_INTERVAL  "probe_interval"
> +
> +#define BATTERY_FULL_CAP     10000  /* mWh */
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
> index 906b3687a5..d1ad663bfd 100644
> --- a/qapi/acpi.json
> +++ b/qapi/acpi.json
> @@ -142,3 +142,76 @@
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
> +#
> +# @charging: whether the battery is charging
> +#
> +# @discharging: whether the battery is discharging
> +#
> +# @charge-percent: battery charge percentage (0-100)
> +#
> +# @rate: charge/discharge rate in mW (optional)
> +#
> +# @remaining-capacity: remaining capacity in mWh (optional)
> +#
> +# @design-capacity: design capacity in mWh (optional)
> +#
> +# Since: 10.2
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
> +
> +#
> +# Since: 10.2
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
> +
> +##
> +# @query-battery:
> +#
> +# Query the current state of the emulated battery device
> +#
> +# Returns: current battery state
> +#
> +# Since: 10.2
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


