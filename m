Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2991CE7716A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 10:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNUTU-0001jO-5V; Tue, 17 Dec 2024 05:06:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tNUTR-0001j0-3z
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 05:06:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tNUTJ-0001PT-9X
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 05:06:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734429990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XijC3Uksp2qlLe/MRtb8DujDyBUSQ2tcc3CwTKH9fwM=;
 b=h1aPhj+eoeeoTZH7CmxYWTH04qrJuywCUtL96kjDzYy/Qo8ANdsYAleFkHM2jO0K8seEV/
 1LqEjGHPbEQ6KjocUXs0welC9Q5I7RXJ/1H4y7KXFbFS7i2DgTXvAdpbH0McXUrE53ffPd
 EUfsI6aMD4V/1eIRThK9OxaTl1a55m0=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-JxzJ2YFRMeeCIM5Otg03cw-1; Tue, 17 Dec 2024 05:06:29 -0500
X-MC-Unique: JxzJ2YFRMeeCIM5Otg03cw-1
X-Mimecast-MFC-AGG-ID: JxzJ2YFRMeeCIM5Otg03cw
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-727c59ecb9fso4621844b3a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 02:06:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734429988; x=1735034788;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XijC3Uksp2qlLe/MRtb8DujDyBUSQ2tcc3CwTKH9fwM=;
 b=oV6DdAZlTJUFFnkrZ83F9B3lJaeiZ68z6BwBi7gNxOZoXCyB5YWnGiajSd6DUMJzlQ
 oZSZUjq1prhq8U2akL8Aq5dwvNvh1pYUBYKfAZyHoTyW/hOc7iLz2i1Cjqql4XF86mMI
 5LC1dAywTsqlOxMPSfO8hzylrHeQMiLZVUynoHCy8gWwWTfgz+3RwH9y2O1S13+JHvhf
 ec9Keo1lDK+eqCKpReSN5Zhgp0+w2ldY0cykVxk3EYJsza9+NiXaLj1SWnmVAdCcWP/p
 JdvqjQOiutFjGOVVGf3djjZs+7AmItmSI30MGdi/Km1UfMl7akQmWzbnOJL5o+Z4j82a
 cFbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDOJKkOAmQ/hIMK36RQHwK8ezYqpfMvSujXuY47hmmgqfxizOoO40MDsD6KhNQj9l+lGUEawA1kw55@nongnu.org
X-Gm-Message-State: AOJu0YzNGt/5IXlhxRjg4gmiinXNTCDna/l1k6N90+R/Q/MdnGad5xiw
 NnP3Dj6LTFt7BEEfNQxODdcn/ArPkEFDKWRuGkncFX5k1qzWTJEsbU7q66UKJjXGCLxzXBljkGF
 WpAUgSa/hdW+1gX/WiMLGMhbzCaXQMnl4k+oN4vMzkkILC+aY8qNy
X-Gm-Gg: ASbGncsKQa5zVg5SqNuKhrURgSjWMnIZnT4PcqHftkU05qGkGRQEbXOx0VXHka5CGuB
 +VzoI1SbmksFra+hmLN4jBwAdoryHQuvLx6FQQ82Lwo1rqJr4kOQKl19Wcb6i+/Rx+MZ5KlJ45s
 eQFb969m3afOEoJ7XwmpXycoUGKigAW7i8OB6WssjTjYs5L9h53FugdYCPrJQ4uKLoDJnbDqOxO
 pdyLF71wbFQHGCIyJqxsEoMSg6rIGrLXMiAF3iH2jbVo0uoR1GkMeWukTcStih4D5b/l9yL
X-Received: by 2002:a05:6a00:2788:b0:728:e40d:c5fc with SMTP id
 d2e1a72fcca58-7290c261ca6mr22652912b3a.22.1734429988306; 
 Tue, 17 Dec 2024 02:06:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtULokU31/nFi8UyLXTL/KJRJ6qPqdTFYcDJkUUhQOYwbwOWSUzfOhkMHyXMuuRyjmzKwi7A==
X-Received: by 2002:a05:6a00:2788:b0:728:e40d:c5fc with SMTP id
 d2e1a72fcca58-7290c261ca6mr22652881b3a.22.1734429987894; 
 Tue, 17 Dec 2024 02:06:27 -0800 (PST)
Received: from smtpclient.apple ([115.96.128.70])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918b790a6sm6471656b3a.128.2024.12.17.02.06.24
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Dec 2024 02:06:27 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH v2] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <26c97140-6ec5-49f5-b0d4-d4f7f82a12f0@linaro.org>
Date: Tue, 17 Dec 2024 15:36:11 +0530
Cc: Alexander Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E18F7A48-BA4D-46B3-BD73-38322BF33CEC@redhat.com>
References: <20241216114841.1025070-1-anisinha@redhat.com>
 <26c97140-6ec5-49f5-b0d4-d4f7f82a12f0@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
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



> On 16 Dec 2024, at 8:35=E2=80=AFPM, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Hi Ani,
>=20
> On 16/12/24 12:48, Ani Sinha wrote:
>> VM firmware update is a mechanism where the virtual machines can use =
their
>> preferred and trusted firmware image in their execution environment =
without
>> having to depend on a untrusted party to provide the firmware bundle. =
This is
>> particularly useful for confidential virtual machines that are =
deployed in the
>> cloud where the tenant and the cloud provider are two different =
entities. In
>> this scenario, virtual machines can bring their own trusted firmware =
image
>> bundled as a part of their filesystem (using UKIs for example[1]) and =
then use
>> this hypervisor interface to update to their trusted firmware image. =
This also
>> allows the guests to have a consistent measurements on the firmware =
image.
>> This change introduces basic support for the fw-cfg based hypervisor =
interface
>> and the corresponding device. The change also includes the
>> specification document for this interface. The interface is made =
generic
>> enough so that guests are free to use their own ABI to pass required
>> information between initial and trusted execution contexts (where =
they are
>> running their own trusted firmware image) without the hypervisor =
getting
>> involved in between. In subsequent patches, we will introduce other =
minimal
>> changes on the hypervisor that are required to make the mechanism =
work.
>> [1] See systemd pull requests =
https://github.com/systemd/systemd/pull/35091
>> and https://github.com/systemd/systemd/pull/35281 for some =
discussions on
>> how we can bundle firmware image within an UKI.
>> CC: Alex Graf <graf@amazon.com>
>> CC: Paolo Bonzini <pbonzini@redhat.com>
>> CC: Gerd Hoffman <kraxel@redhat.com>
>> CC: Igor Mammedov <imammedo@redhat.com>
>> CC: Vitaly Kuznetsov <vkuznets@redhat.com>
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>>  MAINTAINERS                  |   9 ++
>>  docs/specs/index.rst         |   1 +
>>  docs/specs/vmfwupdate.rst    | 109 ++++++++++++++++++++++++
>>  hw/misc/meson.build          |   2 +
>>  hw/misc/vmfwupdate.c         | 157 =
+++++++++++++++++++++++++++++++++++
>>  include/hw/misc/vmfwupdate.h | 103 +++++++++++++++++++++++
>>  6 files changed, 381 insertions(+)
>>  create mode 100644 docs/specs/vmfwupdate.rst
>>  create mode 100644 hw/misc/vmfwupdate.c
>>  create mode 100644 include/hw/misc/vmfwupdate.h
>=20
> Can we have a test?

This interface requires guest side support which is being worked on atm. =
So if you are thinking of a full integration test, it might take a =
while.
Ofcourse, I am open to ideas here.

>=20
>> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
>> index d02d96e403..4c5bdb0de2 100644
>> --- a/hw/misc/meson.build
>> +++ b/hw/misc/meson.build
>> @@ -148,6 +148,8 @@ specific_ss.add(when: 'CONFIG_MAC_VIA', if_true: =
files('mac_via.c'))
>>  specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: =
files('mips_cmgcr.c', 'mips_cpc.c'))
>>  specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: =
files('mips_itu.c'))
>>  +specific_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: =
files('vmfwupdate.c'))
>> +
>>  system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
>>    # HPPA devices
>> diff --git a/hw/misc/vmfwupdate.c b/hw/misc/vmfwupdate.c
>> new file mode 100644
>> index 0000000000..1e29a610c0
>> --- /dev/null
>> +++ b/hw/misc/vmfwupdate.c
>> @@ -0,0 +1,157 @@
>> +/*
>> + * Guest driven VM boot component update device
>> + * For details and specification, please look at =
docs/specs/vmfwupdate.rst.
>> + *
>> + * Copyright (C) 2024 Red Hat, Inc.
>> + *
>> + * Authors: Ani Sinha <anisinha@redhat.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 =
or later.
>> + * See the COPYING file in the top-level directory.
>> + *
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "qemu/module.h"
>> +#include "sysemu/reset.h"
>> +#include "hw/nvram/fw_cfg.h"
>> +#include "hw/i386/pc.h"
>> +#include "hw/qdev-properties.h"
>> +#include "hw/misc/vmfwupdate.h"
>> +#include "qemu/error-report.h"
>> +
>> +static void fw_update_reset(void *dev)
>> +{
>> +    /* a NOOP at present */
>> +    return;
>> +}
>> +
>> +
>> +static uint64_t get_max_fw_size(void)
>> +{
>> +    Object *m_obj =3D qdev_get_machine();
>> +    PCMachineState *pcms =3D PC_MACHINE(m_obj);
>> +
>> +    if (pcms) {
>> +        return pcms->max_fw_size;
>> +    } else {
>> +        return 0;
>> +    }
>> +}
>> +
>> +static void fw_blob_write(void *dev, off_t offset, size_t len)
>> +{
>> +    VMFwUpdateState *s =3D VMFWUPDATE(dev);
>> +
>> +    /* for non-pc platform, we do not allow changing bios_size yet =
*/
>> +    if (!s->plat_bios_size) {
>> +        return;
>> +    }
>> +
>> +    /*
>> +     * in order to change the bios size, appropriate capability
>> +     * must be enabled
>> +     */
>> +    if (s->fw_blob.bios_size &&
>> +        !(s->capability & VMFWUPDATE_CAP_BIOS_RESIZE)) {
>> +        warn_report("vmfwupdate: VMFWUPDATE_CAP_BIOS_RESIZE not =
enabled");
>> +        return;
>> +    }
>> +
>> +    s->plat_bios_size =3D s->fw_blob.bios_size;
>> +
>> +    return;
>> +}
>> +
>> +static void vmfwupdate_realize(DeviceState *dev, Error **errp)
>> +{
>> +    VMFwUpdateState *s =3D VMFWUPDATE(dev);
>> +    FWCfgState *fw_cfg =3D fw_cfg_find();
>> +
>> +    /* multiple devices are not supported */
>> +    if (!vmfwupdate_find()) {
>> +        error_setg(errp, "at most one %s device is permitted",
>> +                   TYPE_VMFWUPDATE);
>> +        return;
>> +    }
>> +
>> +    /* fw_cfg with DMA support is necessary to support this device =
*/
>> +    if (!fw_cfg || !fw_cfg_dma_enabled(fw_cfg)) {
>> +        error_setg(errp, "%s device requires fw_cfg",
>> +                   TYPE_VMFWUPDATE);
>> +        return;
>> +    }
>> +
>> +    memset(&s->fw_blob, 0, sizeof(s->fw_blob));
>> +    memset(&s->opaque_blobs, 0, sizeof(s->opaque_blobs));
>> +
>> +    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_OBLOB,
>> +                             NULL, NULL, s,
>> +                             &s->opaque_blobs,
>> +                             sizeof(s->opaque_blobs),
>> +                             false);
>> +
>> +    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_FWBLOB,
>> +                             NULL, fw_blob_write, s,
>> +                             &s->fw_blob,
>> +                             sizeof(s->fw_blob),
>> +                             false);
>> +
>> +    /*
>> +     * Add global capability fw_cfg file. This will be used by the =
guest to
>> +     * check capability of the hypervisor.
>> +     */
>> +    s->capability =3D cpu_to_le16(CAP_VMFWUPD_MASK | =
VMFWUPDATE_CAP_EDKROM);
>> +    fw_cfg_add_file(fw_cfg, FILE_VMFWUPDATE_CAP,
>> +                    &s->capability, sizeof(s->capability));
>> +
>> +    s->plat_bios_size =3D get_max_fw_size(); /* for non-pc, this is =
0 */
>> +    /* size of bios region for the platform - read only by the guest =
*/
>> +    fw_cfg_add_file(fw_cfg, FILE_VMFWUPDATE_BIOS_SIZE,
>> +                    &s->plat_bios_size, sizeof(s->plat_bios_size));
>> +    /*
>> +     * add fw cfg control file to disable the hypervisor interface.
>> +     */
>> +    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_CONTROL,
>> +                             NULL, NULL, s,
>> +                             &s->disable,
>> +                             sizeof(s->disable),
>> +                             false);
>> +    /*
>> +     * This device requires to register a global reset because it is
>> +     * not plugged to a bus (which, as its QOM parent, would reset =
it).
>> +     */
>> +    qemu_register_reset(fw_update_reset, dev);
>> +}
>> +
>> +static Property vmfwupdate_properties[] =3D {
>> +    DEFINE_PROP_UINT8("disable", VMFwUpdateState, disable, 0),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void vmfwupdate_device_class_init(ObjectClass *klass, void =
*data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +
>> +    /* we are not interested in migration - so no need to populate =
dc->vmsd */
>> +    dc->desc =3D "VM firmware blob update device";
>> +    dc->realize =3D vmfwupdate_realize;
>> +    dc->hotpluggable =3D false;
>> +    device_class_set_props(dc, vmfwupdate_properties);
>> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>=20
> How is this device instantiated?

Something like this:
$ ./qemu-system-x86_64 -device vmfwupdate
VNC server running on ::1:5900

And we can maybe add a basic test for this scenario:

$ ./qemu-system-x86_64 -device vmfwupdate -device vmfwupdate
qemu-system-x86_64: -device vmfwupdate: at most one vmfwupdate device is =
permitted

To exercise the fwcfg files, guest support is needed as I said above.

>=20
>> +}
>> +
>> +static const TypeInfo vmfwupdate_device_info =3D {
>> +    .name          =3D TYPE_VMFWUPDATE,
>> +    .parent        =3D TYPE_DEVICE,
>> +    .instance_size =3D sizeof(VMFwUpdateState),
>> +    .class_init    =3D vmfwupdate_device_class_init,
>> +};
>> +
>> +static void vmfwupdate_register_types(void)
>> +{
>> +    type_register_static(&vmfwupdate_device_info);
>=20
> New models should use DEFINE_TYPES().
>=20

Will fix.

>> +}
>> +
>> +type_init(vmfwupdate_register_types);
>> diff --git a/include/hw/misc/vmfwupdate.h =
b/include/hw/misc/vmfwupdate.h
>> new file mode 100644
>> index 0000000000..e9229d807b
>> --- /dev/null
>> +++ b/include/hw/misc/vmfwupdate.h
>> @@ -0,0 +1,103 @@
>> +/*
>> + * Guest driven VM boot component update device
>> + * For details and specification, please look at =
docs/specs/vmfwupdate.rst.
>> + *
>> + * Copyright (C) 2024 Red Hat, Inc.
>> + *
>> + * Authors: Ani Sinha <anisinha@redhat.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 =
or later.
>> + * See the COPYING file in the top-level directory.
>> + *
>> + */
>> +#ifndef VMFWUPDATE_H
>> +#define VMFWUPDATE_H
>> +
>> +#include "hw/qdev-core.h"
>> +#include "qom/object.h"
>> +#include "qemu/units.h"
>> +
>> +#define TYPE_VMFWUPDATE "vmfwupdate"
>> +
>> +#define VMFWUPDCAPMSK  0xffff /* least significant 16 capability =
bits */
>> +
>> +#define VMFWUPDATE_CAP_EDKROM 0x08 /* bit 4 represents support for =
EDKROM */
>> +#define VMFWUPDATE_CAP_BIOS_RESIZE 0x04 /* guests may resize bios =
region */
>> +#define CAP_VMFWUPD_MASK 0x80
>> +
>> +#define VMFWUPDATE_OPAQUE_SIZE (1024 * MiB)
>> +
>> +/* fw_cfg file definitions */
>> +#define FILE_VMFWUPDATE_OBLOB "etc/vmfwupdate/opaque-blob"
>> +#define FILE_VMFWUPDATE_FWBLOB "etc/vmfwupdate/fw-blob"
>> +#define FILE_VMFWUPDATE_CAP "etc/vmfwupdate/cap"
>> +#define FILE_VMFWUPDATE_BIOS_SIZE "etc/vmfwupdate/bios-size"
>> +#define FILE_VMFWUPDATE_CONTROL "etc/vmfwupdate/disable"
>> +
>> +/*
>> + * Address and length of the guest provided firmware blob.
>> + * The blob itself is passed using the guest shared memory to QEMU.
>> + * This is then copied to the guest private memeory in the secure vm
>> + * by the hypervisor.
>> + */
>> +typedef struct {
>> +    uint32_t bios_size; /*
>> +                         * this is used by the guest to update =
plat_bios_size
>> +                         * when VMFWUPDATE_CAP_BIOS_RESIZE is set.
>> +                         */
>> +    uint64_t bios_paddr; /*
>> +                          * starting gpa where the blob is in shared =
guest
>> +                          * memory. Cleared upon system reset.
>> +                          */
>> +} VMFwUpdateFwBlob;
>> +
>> +typedef struct VMFwUpdateState {
>> +    DeviceState parent_obj;
>> +
>> +    /*
>> +     * capabilities - 64 bits.
>> +     * Little endian format.
>> +     */
>> +    uint64_t capability;
>> +
>> +    /*
>> +     * size of the bios region - architecture dependent.
>> +     * Read-only by the guest unless VMFWUPDATE_CAP_BIOS_RESIZE
>> +     * capability is set.
>> +     */
>> +    uint32_t plat_bios_size;
>> +
>> +    /*
>> +     * disable - disables the interface when non-zero value is =
written to it.
>> +     * Writing 0 to this file enables the interface.
>> +     */
>> +    uint8_t disable;
>> +
>> +    /*
>> +     * The first stage boot uses this opaque blob to convey to the =
next stage
>> +     * where the next stage components are loaded. The exact =
structure and
>> +     * number of entries are unknown to the hypervisor and the =
hypervisor
>> +     * does not touch this memory or do any validations.
>> +     * The contents of this memory needs to be validated by the =
guest and
>> +     * must be ABI compatible between the first and second stages.
>> +     */
>> +    unsigned char opaque_blobs[VMFWUPDATE_OPAQUE_SIZE];
>> +
>> +    /*
>> +     * firmware blob addresses and sizes. These are moved to guest
>> +     * private memory.
>> +     */
>> +    VMFwUpdateFwBlob fw_blob;
>> +} VMFwUpdateState;
>> +
>> +OBJECT_DECLARE_SIMPLE_TYPE(VMFwUpdateState, VMFWUPDATE);
>> +
>> +/* returns NULL unless there is exactly one device */
>> +static inline VMFwUpdateState *vmfwupdate_find(void)
>=20
> What is the point of this helper? Why inline it in header?

Ok will move this into vmfwupdate.c


>=20
>> +{
>> +    Object *o =3D object_resolve_path_type("", TYPE_VMFWUPDATE, =
NULL);
>> +
>> +    return o ? VMFWUPDATE(o) : NULL;
>> +}
>> +
>> +#endif



