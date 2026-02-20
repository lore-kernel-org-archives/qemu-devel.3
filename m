Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99BFC56205
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 15:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtRzC-0006hP-Sz; Fri, 20 Feb 2026 10:00:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vtRz9-0006gZ-FK
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 10:00:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vtRz4-00016z-OT
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 10:00:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771599596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WaceR6dm230qbEqVcg1fKMJzATvx1ZMDXaNGSn7OPKk=;
 b=X6/kymWsjMfTzMLvE3BxJeEKX9+TWGAC+AbHtYEE9qLYgQCXQYo/ZpjVZEQxTCydyyJiRv
 GgGp3itUuLLeBN4OluQTIhVZvorKs0wa2RX461mU2CUuA15dK1HP/Xy1YSV2ToUkq7QpIW
 5iMP5Jhlj/qkGW4+jafDEdzNMaZIp58=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-_R8QiArnNZ2AtWNyZHyRhA-1; Fri, 20 Feb 2026 09:59:54 -0500
X-MC-Unique: _R8QiArnNZ2AtWNyZHyRhA-1
X-Mimecast-MFC-AGG-ID: _R8QiArnNZ2AtWNyZHyRhA_1771599593
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4837907ec88so30831775e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 06:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771599593; x=1772204393; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WaceR6dm230qbEqVcg1fKMJzATvx1ZMDXaNGSn7OPKk=;
 b=drj2Xf1BUbtm989Tu35wBy4ovUFDwEVIaDrj4W4rA7n5Z/VqLArZN6+FvsjHTqA91j
 cQFMiMeIuz2QD6ZWK4i7uxnJF8sRM8tkZGUulSahXy1KDZiXw/oF/VwzeuCueau6Ca/e
 VbkfAlEjnFMogDwCPY2BGxOT01OYgM9Jy2R/5JONv/Kx66/hcVzYaHkI7NCYJkceSmAK
 Yuy/M552j4hxj7SmaWdlj1Ej4y4gxx/JgdDSi+TLQ15UzPcgmLUql6EwqVWDoJ5LJb7G
 EsUPx5gzr90yeGDTt14jbjq+hru7pNi74cYpPkivtvwj5Hn3e+7NGinBXL5cHZ90CUuW
 EyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771599593; x=1772204393;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WaceR6dm230qbEqVcg1fKMJzATvx1ZMDXaNGSn7OPKk=;
 b=EM4W52JA8hsL0++fuG1ao7YFYppBgrqrSYLc/QiS5FtuGwdHhXzBgeC400aiAW2QhT
 /H8M20KA8Pu4/G7I0bSKGCGXqT5xVQY9lHMC+cHhaMlVzu87WYj34axhTvzM1nMgKsCo
 YM4B/M4P+fmOPCbdWAwLW9o4WKepaTMLSH5YAB10WP1ibmtJNpmZsfSaJYCFPrgyqojZ
 yE0/K5lHYxhUOrL+HW5xDQmTG6phFP1YtpSXL5D/ck7q5yXZIG7hff1358djOECKasyl
 dasIuE7fx3Z3WtZ77p7eawdcbf2VVrUAE1IOvP/TibvTph7ZN/mCrvVajhz6E+2BjtnU
 xRNw==
X-Gm-Message-State: AOJu0Yz4+kGCEGV21ZbSmN8jQjLKBWxdGEU4K4lBJE35KbBEHt8+FMPV
 Y/awCMre93TlYVEg4BO56PaFfCJ0XjE2TyK3m1M8vVwKE34fkzB1+DwgOHvLV/BbCBukg00TNQA
 KI7oEp81PKnmh6bpwixh/sGSzsCIVmbeoyTRFDCvX35tceUIdRAotyMLA
X-Gm-Gg: AZuq6aIMnroypYBLTf2F3rStxc9Vxp3EifnZV3o5AQdpPSzB3mDxiebH2+Ui+rBzJDU
 JZbbBwpjEzwZaYdOvPzFLBzLaZ4y5RrVGTsRrf45pbm8jfzml999h9+dblxMfifKiDGM1jb6rat
 jw5PsF1dwhnFC3yjSSFn4507PYzskrKUKWSGrhWejnnTs7CTgEwoOocyajOTO8PDrA4jd45SDKX
 gPGeTnt+jKy3LO9dixeYPbdyo0mjw8Ka1IDOe/PNT/V0hzFHQ8HjCntxIdf4K0RtkusTB/0Nspy
 KZ7gHtx1n6Lpuwiy1u5INvYQhRWUk20dlmnNkXafYjwuw5MS0vcZvl4yYa6DbJ0Y0M9GWVTldFT
 4xa/bNCY214BhWL7msJK7sXveLdZhjUT85qBJd8YWmVDQPg==
X-Received: by 2002:a05:600c:a407:b0:477:7bca:8b2b with SMTP id
 5b1f17b1804b1-483a5e18c61mr32742165e9.15.1771599593279; 
 Fri, 20 Feb 2026 06:59:53 -0800 (PST)
X-Received: by 2002:a05:600c:a407:b0:477:7bca:8b2b with SMTP id
 5b1f17b1804b1-483a5e18c61mr32741635e9.15.1771599592730; 
 Fri, 20 Feb 2026 06:59:52 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31ff4d7sm78554685e9.15.2026.02.20.06.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 06:59:52 -0800 (PST)
Date: Fri, 20 Feb 2026 09:59:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, alex.bennee@linaro.org,
 philmd@linaro.org, berrange@redhat.com, marcandre.lureau@redhat.com,
 Cornelia Huck <cohuck@redhat.com>,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Tyler Fanelli <tfanelli@redhat.com>, mknaust@amazon.com,
 nh-open-source@amazon.com
Subject: Re: [PATCH 07/10] hw/nitro: Add nitro machine
Message-ID: <20260220095806-mutt-send-email-mst@kernel.org>
References: <20260218015151.4052-1-graf@amazon.com>
 <20260218015151.4052-8-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260218015151.4052-8-graf@amazon.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Feb 18, 2026 at 01:51:47AM +0000, Alexander Graf wrote:
> Add a machine model to spawn a Nitro Enclave. Unlike the existing -M
> nitro-enclave, this machine model works exclusively with the -accel
> nitro accelerator to drive real Nitro Enclave creation. It supports
> memory allocation, number of CPU selection, both x86_64 as well as
> aarch64, implements the Enclave heartbeat logic and debug serial
> console.
> 
> To use it, create an EIF file and run
> 
>   $ qemu-system-x86_64 -accel nitro,debug-mode=on -M nitro -nographic \
>                        -kernel test.eif
> 
> or
> 
>   $ qemu-system-aarch64 -accel nitro,debug-mode=on -M nitro -nographic \
>                        -kernel test.eif
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>  hw/nitro/Kconfig           |   7 ++
>  hw/nitro/machine.c         | 180 +++++++++++++++++++++++++++++++++++++
>  hw/nitro/meson.build       |   1 +
>  include/hw/nitro/machine.h |  20 +++++
>  4 files changed, 208 insertions(+)
>  create mode 100644 hw/nitro/machine.c
>  create mode 100644 include/hw/nitro/machine.h
> 
> diff --git a/hw/nitro/Kconfig b/hw/nitro/Kconfig
> index 6fe050d35d..910068c23c 100644
> --- a/hw/nitro/Kconfig
> +++ b/hw/nitro/Kconfig
> @@ -5,3 +5,10 @@ config NITRO_SERIAL_VSOCK
>  config NITRO_HEARTBEAT
>      bool
>      depends on NITRO
> +
> +config NITRO_MACHINE
> +    bool
> +    default y
> +    depends on NITRO
> +    select NITRO_HEARTBEAT
> +    select NITRO_SERIAL_VSOCK
> diff --git a/hw/nitro/machine.c b/hw/nitro/machine.c
> new file mode 100644
> index 0000000000..197adfbdb5
> --- /dev/null
> +++ b/hw/nitro/machine.c
> @@ -0,0 +1,180 @@
> +/*
> + * Nitro Enclaves (accel) machine
> + *
> + * Copyright © 2026 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * Authors:
> + *   Alexander Graf <graf@amazon.com>
> + *
> + * Nitro Enclaves machine model for -accel nitro. This machine behaves
> + * like the nitro-enclave machine, but uses the real Nitro Enclaves
> + * backend to launch the virtual machine. It requires use of the -accel
> + * nitro.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "qapi/error.h"
> +#include "qom/object_interfaces.h"
> +#include "chardev/char.h"
> +#include "hw/core/boards.h"
> +#include "hw/core/cpu.h"
> +#include "hw/core/sysbus.h"
> +#include "hw/core/qdev-properties-system.h"
> +#include "hw/nitro/heartbeat.h"
> +#include "hw/nitro/machine.h"
> +#include "hw/nitro/serial-vsock.h"
> +#include "system/address-spaces.h"
> +#include "system/hostmem.h"
> +#include "system/system.h"
> +#include "system/nitro-accel.h"
> +#include "qemu/accel.h"
> +#include "hw/arm/machines-qom.h"
> +
> +#define EIF_LOAD_ADDR   (8 * 1024 * 1024)
> +
> +static void nitro_create_cpu(const char *cpu_type, int index)
> +{
> +    Object *obj = object_new(cpu_type);
> +
> +    /* x86 CPUs require an apic-id before realize */
> +    if (object_property_find(obj, "apic-id")) {
> +        object_property_set_int(obj, "apic-id", index, &error_fatal);
> +    }
> +
> +    qdev_realize(DEVICE(obj), NULL, &error_fatal);
> +}
> +
> +static void nitro_machine_init(MachineState *machine)
> +{
> +    const char *eif_path = machine->kernel_filename;
> +    const char *cpu_type = machine->cpu_type;
> +    g_autofree char *eif_data = NULL;
> +    gsize eif_size;
> +    int i;
> +
> +    if (!nitro_enabled()) {
> +        error_report("The 'nitro' machine requires -accel nitro");
> +        exit(1);
> +    }
> +
> +    if (!cpu_type) {
> +        ObjectClass *oc = cpu_class_by_name(target_cpu_type(), "host");
> +
> +        if (!oc) {
> +            error_report("nitro: no 'host' CPU available");
> +            exit(1);
> +        }
> +        cpu_type = object_class_get_name(oc);
> +    }
> +
> +    if (!eif_path) {
> +        error_report("nitro: -kernel <eif-file> is required");
> +        exit(1);
> +    }
> +
> +    /* Expose memory as normal QEMU RAM. Needs to be huge page backed. */
> +    memory_region_add_subregion(get_system_memory(), 0, machine->ram);
> +
> +    /*
> +     * Load EIF (-kernel) as raw blob at the EIF_LOAD_ADDR into guest RAM.
> +     * The Nitro Hypervisor will extract its contents and bootstrap the
> +     * Enclave from it.
> +     */
> +    if (!g_file_get_contents(eif_path, &eif_data, &eif_size, NULL)) {
> +        error_report("nitro: failed to read EIF '%s'", eif_path);
> +        exit(1);
> +    }
> +    address_space_write(&address_space_memory, EIF_LOAD_ADDR,
> +                        MEMTXATTRS_UNSPECIFIED, eif_data, eif_size);
> +
> +    /* Nitro Enclaves require a heartbeat device. Provide one. */
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(qdev_new(TYPE_NITRO_HEARTBEAT)),
> +                             &error_fatal);
> +
> +    /*
> +     * In debug mode, Nitro Enclaves expose the guest's serial output via
> +     * vsock. When the accel is in debug mode, wire the vsock serial to
> +     * the machine's serial port so that -nographic automatically works
> +     */
> +    if (object_property_get_bool(OBJECT(current_accel()), "debug-mode", NULL)) {
> +        Chardev *chr = serial_hd(0);
> +
> +        if (chr) {
> +            DeviceState *dev = qdev_new(TYPE_NITRO_SERIAL_VSOCK);
> +
> +            qdev_prop_set_chr(dev, "chardev", chr);
> +            sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +        }
> +    }


Would  respecting -nodefaults and then maybe not wiring up all the
vsock things make sense? allows users to set it up any way
they want ...

> +
> +    /*
> +     * Spawn vCPUs. While the real Nitro Enclaves CPUs are owned by the
> +     * underlying hypervisor, we still want to maintain a local view of
> +     * them to trigger VM creation when vCPU 0 starts and to give us an
> +     * object to interact with.
> +     */
> +    for (i = 0; i < machine->smp.cpus; i++) {
> +        nitro_create_cpu(cpu_type, i);
> +    }
> +}
> +
> +static bool nitro_create_memfd_backend(MachineState *ms, const char *path,
> +                                       Error **errp)
> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    Object *root = object_get_objects_root();
> +    Object *obj;
> +    bool r = false;
> +
> +    obj = object_new(TYPE_MEMORY_BACKEND_MEMFD);
> +
> +    /* Nitro Enclaves require huge page backing */
> +    if (!object_property_set_int(obj, "size", ms->ram_size, errp) ||
> +        !object_property_set_bool(obj, "hugetlb", true, errp)) {
> +        goto out;
> +    }
> +
> +    object_property_add_child(root, mc->default_ram_id, obj);
> +
> +    if (!user_creatable_complete(USER_CREATABLE(obj), errp)) {
> +        goto out;
> +    }
> +    r = object_property_set_link(OBJECT(ms), "memory-backend", obj, errp);
> +
> +out:
> +    object_unref(obj);
> +    return r;
> +}
> +
> +static void nitro_machine_class_init(ObjectClass *oc, const void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
> +    mc->desc = "Nitro Enclave";
> +    mc->init = nitro_machine_init;
> +    mc->create_default_memdev = nitro_create_memfd_backend;
> +    mc->default_ram_id = "ram";
> +    mc->max_cpus = 4096;
> +}
> +
> +static const TypeInfo nitro_machine_info = {
> +    .name = TYPE_NITRO_MACHINE,
> +    .parent = TYPE_MACHINE,
> +    .instance_size = sizeof(NitroMachineState),
> +    .class_init = nitro_machine_class_init,
> +    .interfaces = (const InterfaceInfo[]) {
> +        /* x86_64 and aarch64 only */
> +        { TYPE_TARGET_AARCH64_MACHINE },
> +        { }
> +    },
> +};
> +
> +static void nitro_machine_register(void)
> +{
> +    type_register_static(&nitro_machine_info);
> +}
> +
> +type_init(nitro_machine_register);
> diff --git a/hw/nitro/meson.build b/hw/nitro/meson.build
> index b921da2b97..813f5a9c87 100644
> --- a/hw/nitro/meson.build
> +++ b/hw/nitro/meson.build
> @@ -1,2 +1,3 @@
>  system_ss.add(when: 'CONFIG_NITRO_SERIAL_VSOCK', if_true: files('serial-vsock.c'))
>  system_ss.add(when: 'CONFIG_NITRO_HEARTBEAT', if_true: files('heartbeat.c'))
> +system_ss.add(when: 'CONFIG_NITRO_MACHINE', if_true: files('machine.c'))
> diff --git a/include/hw/nitro/machine.h b/include/hw/nitro/machine.h
> new file mode 100644
> index 0000000000..d78ba7d6dc
> --- /dev/null
> +++ b/include/hw/nitro/machine.h
> @@ -0,0 +1,20 @@
> +/*
> + * Nitro Enclaves (accel) machine
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_NITRO_MACHINE_H
> +#define HW_NITRO_MACHINE_H
> +
> +#include "hw/core/boards.h"
> +#include "qom/object.h"
> +
> +#define TYPE_NITRO_MACHINE MACHINE_TYPE_NAME("nitro")
> +OBJECT_DECLARE_SIMPLE_TYPE(NitroMachineState, NITRO_MACHINE)
> +
> +struct NitroMachineState {
> +    MachineState parent;
> +};
> +
> +#endif /* HW_NITRO_MACHINE_H */
> -- 
> 2.47.1
> 
> 
> 
> 
> Amazon Web Services Development Center Germany GmbH
> Tamara-Danz-Str. 13
> 10243 Berlin
> Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
> Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> Sitz: Berlin
> Ust-ID: DE 365 538 597


