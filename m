Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B49CD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 13:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp6ra-0001Lk-MQ; Tue, 26 Mar 2024 09:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp6rX-0001KP-TN
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:29:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp6rV-0002l2-Ej
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711459747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OicrD7O6SHbgh0NKnNiM0QdxrXxrvqefLuRqQi+U5aY=;
 b=hSxLoqto+SahCl1bwDDpsQk2xOJ6TikWv38ArfTNoeF9DonNRBtiogV21teI2LSyYE5jQE
 dSyzSrxJw81mv9QpZHbU3uRYtdyNgYmQOv+Q8Ioj7ndIRaad/zT29KPShn1tRxHv7tDX4L
 WAuNU2dOloJVrd9yIXs8n+NfQ/yZ084=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-K-tlxBGrNbyXje-ODa7yIA-1; Tue, 26 Mar 2024 09:29:04 -0400
X-MC-Unique: K-tlxBGrNbyXje-ODa7yIA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2848C101A526;
 Tue, 26 Mar 2024 13:29:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 856772166B31;
 Tue, 26 Mar 2024 13:29:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8182C21E669D; Tue, 26 Mar 2024 14:28:57 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,
 qemu-riscv@nongnu.org,  Anton Johansson <anjo@rev.ng>,
 qemu-s390x@nongnu.org,  qemu-ppc@nongnu.org,  Daniel P . =?utf-8?Q?Berra?=
 =?utf-8?Q?ng=C3=A9?=
 <berrange@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>,  Zhao Liu
 <zhao1.liu@intel.com>,  qemu-arm@nongnu.org,  Thomas Huth
 <thuth@redhat.com>,  Michael Roth <michael.roth@amd.com>
Subject: Re: [RFC PATCH-for-9.1 14/21] system: Introduce QMP
 generic_query_cpu_definitions()
In-Reply-To: <20240315130910.15750-15-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 15 Mar 2024 14:09:02
 +0100")
References: <20240315130910.15750-1-philmd@linaro.org>
 <20240315130910.15750-15-philmd@linaro.org>
Date: Tue, 26 Mar 2024 14:28:57 +0100
Message-ID: <87v859m89y.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Each target use a common template for qmp_query_cpu_definitions().
>
> Extract it as generic_query_cpu_definitions(), keeping the
> target-specific implementations as the following SysemuCPUOps
> handlers:
>  - cpu_list_compare()
>  - add_definition()
>  - add_alias_definitions()
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  MAINTAINERS                           |  2 +
>  include/hw/core/sysemu-cpu-ops.h      | 14 ++++++
>  include/qapi/commands-target-compat.h | 14 ++++++
>  system/cpu-qmp-cmds.c                 | 71 +++++++++++++++++++++++++++
>  system/meson.build                    |  1 +
>  5 files changed, 102 insertions(+)
>  create mode 100644 include/qapi/commands-target-compat.h
>  create mode 100644 system/cpu-qmp-cmds.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index af27490243..39d7c14d98 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -148,6 +148,7 @@ M: Richard Henderson <richard.henderson@linaro.org>
>  R: Paolo Bonzini <pbonzini@redhat.com>
>  S: Maintained
>  F: system/cpus.c
> +F: system/cpu-qmp-cmds.c
>  F: system/cpu-qom-helpers.c
>  F: system/watchpoint.c
>  F: cpu-common.c
> @@ -1894,6 +1895,7 @@ F: qapi/machine-target.json
>  F: include/hw/boards.h
>  F: include/hw/core/cpu.h
>  F: include/hw/cpu/cluster.h
> +F: include/qapi/commands-target-compat.h
>  F: include/sysemu/numa.h
>  F: tests/unit/test-smp-parse.c
>  T: git https://gitlab.com/ehabkost/qemu.git machine-next
> diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cp=
u-ops.h
> index 24d003fe04..2173226e97 100644
> --- a/include/hw/core/sysemu-cpu-ops.h
> +++ b/include/hw/core/sysemu-cpu-ops.h
> @@ -11,6 +11,7 @@
>  #define SYSEMU_CPU_OPS_H
>=20=20
>  #include "hw/core/cpu.h"
> +#include "qapi/qapi-types-machine.h"
>=20=20
>  /*
>   * struct SysemuCPUOps: System operations specific to a CPU class
> @@ -81,6 +82,19 @@ typedef struct SysemuCPUOps {
>       */
>      bool (*virtio_is_big_endian)(CPUState *cpu);
>=20=20
> +    /**
> +     * @cpu_list_compare: Sort alphabetically by type name,
> +     *                    respecting CPUClass::ordering.
> +     */
> +    gint (*cpu_list_compare)(gconstpointer cpu_class_a, gconstpointer cp=
u_class_b);
> +    /**
> +     * @add_definition: Add the @cpu_class definition to @cpu_list.
> +     */
> +    void (*add_definition)(gpointer cpu_class, gpointer cpu_list);
> +    /**
> +     * @add_alias_definitions: Add CPU alias definitions to @cpu_list.
> +     */
> +    void (*add_alias_definitions)(CpuDefinitionInfoList **cpu_list);
>      /**
>       * @legacy_vmsd: Legacy state for migration.
>       *               Do not use in new targets, use #DeviceClass::vmsd i=
nstead.
> diff --git a/include/qapi/commands-target-compat.h b/include/qapi/command=
s-target-compat.h
> new file mode 100644
> index 0000000000..86d45d8fcc
> --- /dev/null
> +++ b/include/qapi/commands-target-compat.h
> @@ -0,0 +1,14 @@
> +/*
> + * QAPI helpers for target specific QMP commands
> + *
> + * SPDX-FileCopyrightText: 2024 Linaro Ltd.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef QAPI_COMPAT_TARGET_H
> +#define QAPI_COMPAT_TARGET_H
> +
> +#include "qapi/qapi-types-machine.h"
> +
> +CpuDefinitionInfoList *generic_query_cpu_definitions(Error **errp);
> +
> +#endif
> diff --git a/system/cpu-qmp-cmds.c b/system/cpu-qmp-cmds.c
> new file mode 100644
> index 0000000000..daeb131159
> --- /dev/null
> +++ b/system/cpu-qmp-cmds.c
> @@ -0,0 +1,71 @@
> +/*
> + * QAPI helpers for target specific QMP commands
> + *
> + * SPDX-FileCopyrightText: 2024 Linaro Ltd.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qom/object.h"
> +#include "qapi/commands-target-compat.h"
> +#include "sysemu/arch_init.h"
> +#include "hw/core/cpu.h"
> +#include "hw/core/sysemu-cpu-ops.h"
> +
> +static void cpu_common_add_definition(gpointer data, gpointer user_data)
> +{
> +    ObjectClass *oc =3D data;
> +    CpuDefinitionInfoList **cpu_list =3D user_data;
> +    CpuDefinitionInfo *info;
> +    const char *typename;
> +
> +    typename =3D object_class_get_name(oc);
> +    info =3D g_malloc0(sizeof(*info));
> +    info->name =3D cpu_model_from_type(typename);
> +    info->q_typename =3D g_strdup(typename);
> +
> +    QAPI_LIST_PREPEND(*cpu_list, info);
> +}
> +
> +static void arch_add_cpu_definitions(CpuDefinitionInfoList **cpu_list,
> +                                     const char *cpu_typename)
> +{
> +    ObjectClass *oc;
> +    GSList *list;
> +    const struct SysemuCPUOps *ops;
> +
> +    oc =3D object_class_by_name(cpu_typename);
> +    if (!oc) {
> +        return;
> +    }
> +    ops =3D CPU_CLASS(oc)->sysemu_ops;
> +
> +    list =3D object_class_get_list(cpu_typename, false);
> +    if (ops->cpu_list_compare) {
> +        list =3D g_slist_sort(list, ops->cpu_list_compare);
> +    }
> +    g_slist_foreach(list, ops->add_definition ? : cpu_common_add_definit=
ion,
> +                    cpu_list);
> +    g_slist_free(list);
> +
> +    if (ops->add_alias_definitions) {
> +        ops->add_alias_definitions(cpu_list);
> +    }
> +}
> +
> +CpuDefinitionInfoList *generic_query_cpu_definitions(Error **errp)
> +{
> +    CpuDefinitionInfoList *cpu_list =3D NULL;
> +
> +    for (unsigned i =3D 0; i <=3D QEMU_ARCH_BIT_LAST; i++) {
> +        const char *cpu_typename;
> +
> +        cpu_typename =3D cpu_typename_by_arch_bit(i);
> +        if (!cpu_typename) {
> +            continue;
> +        }
> +        arch_add_cpu_definitions(&cpu_list, cpu_typename);
> +    }
> +
> +    return cpu_list;
> +}

The target-specific qmp_query_cpu_definitions() this is going to replace
each execute the equivalent of *one* loop iteration: the one
corresponding to their own arch bit.

For the replacement to be faithful, as cpu_typename_by_arch_bit() must
return non-null exactly once.

This is the case for the qemu-system-TARGET.  The solution feels
overengineered there.

I figure cpu_typename_by_arch_bit() will return non-null multiple times
in a future single binary supporting heterogeneous machines.

Such a single binary then can't serve as drop-in replacement for the
qemu-system-TARGET, because query-cpu-definitions returns more.

To get a drop-in replacement, we'll need additional logic to restrict
the query for the homogeneous use case.

I think this needs to be discussed in the commit message.

Possibly easier: don't loop over the bits, relying on
cpu_typename_by_arch_bit() to select the right one.  Instead get the
right bit from somewhere.

We can switch to a loop when we need it for the heterogeneous case.

> diff --git a/system/meson.build b/system/meson.build
> index c6ee97e3b2..dd78caa9b7 100644
> --- a/system/meson.build
> +++ b/system/meson.build
> @@ -10,6 +10,7 @@ system_ss.add(files(
>    'balloon.c',
>    'bootdevice.c',
>    'cpus.c',
> +  'cpu-qmp-cmds.c',
>    'cpu-qom-helpers.c',
>    'cpu-throttle.c',
>    'cpu-timers.c',


