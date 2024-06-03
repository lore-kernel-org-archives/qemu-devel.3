Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10D5C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 12:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE6eg-00077u-5r; Mon, 03 Jun 2024 08:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sE6ed-00075y-S4
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sE6eb-0003Ft-0M
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717417148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jpPGUxRfLC9lufqxPrIETHhm/prOnpC8Fj4J3nxx8w4=;
 b=Xjces98enfmvaiBCj70obvoWJV6NXyE8gWjmjNgTIOC4Ciey+fm2mqvc/oC0JxpK1Iu0fm
 IpC9pu3mIQbD92bFTY2P2+DRXJDLHVXIRGjylceeX5bRRtE9lyRAO718RCH/O6CdIXZlgm
 sUu9NxI8fW9TyGtwTGBrIXyPJ+Fx19I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-Abl5ND4MMDyk-ELq31WW2w-1; Mon,
 03 Jun 2024 08:19:05 -0400
X-MC-Unique: Abl5ND4MMDyk-ELq31WW2w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E01023806703;
 Mon,  3 Jun 2024 12:19:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F3C6E402EB4;
 Mon,  3 Jun 2024 12:19:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2063C21E66E5; Mon,  3 Jun 2024 14:19:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eduardo
 Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>,  "Michael S . Tsirkin" <mst@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Eric Blake <eblake@redhat.com>,  Marcelo
 Tosatti <mtosatti@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  Sia Jee Heng
 <jeeheng.sia@starfivetech.com>,  qemu-devel@nongnu.org,
 kvm@vger.kernel.org,  qemu-riscv@nongnu.org,  qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,  Dapeng Mi
 <dapeng1.mi@linux.intel.com>,  Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [RFC v2 1/7] hw/core: Make CPU topology enumeration arch-agnostic
In-Reply-To: <20240530101539.768484-2-zhao1.liu@intel.com> (Zhao Liu's message
 of "Thu, 30 May 2024 18:15:33 +0800")
References: <20240530101539.768484-1-zhao1.liu@intel.com>
 <20240530101539.768484-2-zhao1.liu@intel.com>
Date: Mon, 03 Jun 2024 14:19:02 +0200
Message-ID: <87y17mfccp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Zhao Liu <zhao1.liu@intel.com> writes:

> Cache topology needs to be defined based on CPU topology levels. Thus,
> define CPU topology enumeration in qapi/machine.json to make it generic
> for all architectures.
>
> To match the general topology naming style, rename CPU_TOPO_LEVEL_SMT
> and CPU_TOPO_LEVEL_PACKAGE to CPU_TOPO_LEVEL_THREAD and
> CPU_TOPO_LEVEL_SOCKET.
>
> Also, enumerate additional topology levels for non-i386 arches, and add
> helpers for topology enumeration and string conversion.
>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Changes since RFC v1:
>  * Use QAPI to enumerate CPU topology levels.
>  * Drop string_to_cpu_topo() since QAPI will help to parse the topo
>    levels.
> ---
>  MAINTAINERS                    |  2 ++
>  hw/core/cpu-topology.c         | 36 ++++++++++++++++++++++++++++++
>  hw/core/meson.build            |  1 +
>  include/hw/core/cpu-topology.h | 20 +++++++++++++++++
>  include/hw/i386/topology.h     | 18 +--------------
>  qapi/machine.json              | 40 ++++++++++++++++++++++++++++++++++
>  target/i386/cpu.c              | 30 ++++++++++++-------------
>  target/i386/cpu.h              |  4 ++--
>  8 files changed, 117 insertions(+), 34 deletions(-)
>  create mode 100644 hw/core/cpu-topology.c
>  create mode 100644 include/hw/core/cpu-topology.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 448dc951c509..09173e8c953d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1875,6 +1875,7 @@ R: Yanan Wang <wangyanan55@huawei.com>
>  S: Supported
>  F: hw/core/cpu-common.c
>  F: hw/core/cpu-sysemu.c
> +F: hw/core/cpu-topology.c
>  F: hw/core/machine-qmp-cmds.c
>  F: hw/core/machine.c
>  F: hw/core/machine-smp.c
> @@ -1886,6 +1887,7 @@ F: qapi/machine-common.json
>  F: qapi/machine-target.json
>  F: include/hw/boards.h
>  F: include/hw/core/cpu.h
> +F: include/hw/core/cpu-topology.h
>  F: include/hw/cpu/cluster.h
>  F: include/sysemu/numa.h
>  F: tests/unit/test-smp-parse.c
> diff --git a/hw/core/cpu-topology.c b/hw/core/cpu-topology.c
> new file mode 100644
> index 000000000000..20b5d708cb54
> --- /dev/null
> +++ b/hw/core/cpu-topology.c
> @@ -0,0 +1,36 @@
> +/*
> + * QEMU CPU Topology Representation
> + *
> + * Copyright (c) 2024 Intel Corporation
> + *
> + * Authors:
> + *  Zhao Liu <zhao1.liu@intel.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * later.  See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/core/cpu-topology.h"
> +
> +typedef struct CPUTopoInfo {
> +    const char *name;
> +} CPUTopoInfo;
> +
> +CPUTopoInfo cpu_topo_descriptors[] = {
> +    [CPU_TOPO_LEVEL_INVALID] = { .name = "invalid", },
> +    [CPU_TOPO_LEVEL_THREAD]  = { .name = "thread",  },
> +    [CPU_TOPO_LEVEL_CORE]    = { .name = "core",    },
> +    [CPU_TOPO_LEVEL_MODULE]  = { .name = "module",  },
> +    [CPU_TOPO_LEVEL_CLUSTER] = { .name = "cluster", },
> +    [CPU_TOPO_LEVEL_DIE]     = { .name = "die",     },
> +    [CPU_TOPO_LEVEL_SOCKET]  = { .name = "socket",  },
> +    [CPU_TOPO_LEVEL_BOOK]    = { .name = "book",    },
> +    [CPU_TOPO_LEVEL_DRAWER]  = { .name = "drawer",  },
> +    [CPU_TOPO_LEVEL__MAX]    = { .name = NULL,      },
> +};

This looks redundant with generated

    const QEnumLookup CPUTopoLevel_lookup = {
        .array = (const char *const[]) {
            [CPU_TOPO_LEVEL_INVALID] = "invalid",
            [CPU_TOPO_LEVEL_THREAD] = "thread",
            [CPU_TOPO_LEVEL_CORE] = "core",
            [CPU_TOPO_LEVEL_MODULE] = "module",
            [CPU_TOPO_LEVEL_CLUSTER] = "cluster",
            [CPU_TOPO_LEVEL_DIE] = "die",
            [CPU_TOPO_LEVEL_SOCKET] = "socket",
            [CPU_TOPO_LEVEL_BOOK] = "book",
            [CPU_TOPO_LEVEL_DRAWER] = "drawer",
        },
        .size = CPU_TOPO_LEVEL__MAX
    };

> +
> +const char *cpu_topo_to_string(CPUTopoLevel topo)
> +{
> +    return cpu_topo_descriptors[topo].name;
> +}

And this with generated CPUTopoLevel_str().

> diff --git a/hw/core/meson.build b/hw/core/meson.build
> index a3d9bab9f42a..71dc396e9bfc 100644
> --- a/hw/core/meson.build
> +++ b/hw/core/meson.build
> @@ -13,6 +13,7 @@ hwcore_ss.add(files(
>  ))
>  
>  common_ss.add(files('cpu-common.c'))
> +common_ss.add(files('cpu-topology.c'))
>  common_ss.add(files('machine-smp.c'))
>  system_ss.add(when: 'CONFIG_FITLOADER', if_true: files('loader-fit.c'))
>  system_ss.add(when: 'CONFIG_GENERIC_LOADER', if_true: files('generic-loader.c'))
> diff --git a/include/hw/core/cpu-topology.h b/include/hw/core/cpu-topology.h
> new file mode 100644
> index 000000000000..0e21fe8a9bf8
> --- /dev/null
> +++ b/include/hw/core/cpu-topology.h
> @@ -0,0 +1,20 @@
> +/*
> + * QEMU CPU Topology Representation Header
> + *
> + * Copyright (c) 2024 Intel Corporation
> + *
> + * Authors:
> + *  Zhao Liu <zhao1.liu@intel.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * later.  See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef CPU_TOPOLOGY_H
> +#define CPU_TOPOLOGY_H
> +
> +#include "qapi/qapi-types-machine.h"
> +
> +const char *cpu_topo_to_string(CPUTopoLevel topo);
> +
> +#endif /* CPU_TOPOLOGY_H */
> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> index dff49fce1154..c6ff75f23991 100644
> --- a/include/hw/i386/topology.h
> +++ b/include/hw/i386/topology.h
> @@ -39,7 +39,7 @@
>   *  CPUID Fn8000_0008_ECX[ApicIdCoreIdSize[3:0]] is set to apicid_core_width().
>   */
>  
> -
> +#include "hw/core/cpu-topology.h"
>  #include "qemu/bitops.h"
>  
>  /*
> @@ -62,22 +62,6 @@ typedef struct X86CPUTopoInfo {
>      unsigned threads_per_core;
>  } X86CPUTopoInfo;
>  
> -/*
> - * CPUTopoLevel is the general i386 topology hierarchical representation,
> - * ordered by increasing hierarchical relationship.
> - * Its enumeration value is not bound to the type value of Intel (CPUID[0x1F])
> - * or AMD (CPUID[0x80000026]).
> - */
> -enum CPUTopoLevel {
> -    CPU_TOPO_LEVEL_INVALID,
> -    CPU_TOPO_LEVEL_SMT,
> -    CPU_TOPO_LEVEL_CORE,
> -    CPU_TOPO_LEVEL_MODULE,
> -    CPU_TOPO_LEVEL_DIE,
> -    CPU_TOPO_LEVEL_PACKAGE,
> -    CPU_TOPO_LEVEL_MAX,
> -};
> -
>  /* Return the bit width needed for 'count' IDs */
>  static unsigned apicid_bitwidth_for_count(unsigned count)
>  {
> diff --git a/qapi/machine.json b/qapi/machine.json
> index bce6e1bbc412..7ac5a05bb9c9 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1667,6 +1667,46 @@
>       '*reboot-timeout': 'int',
>       '*strict': 'bool' } }
>  
> +##
> +# @CPUTopoLevel:
> +#
> +# An enumeration of CPU topology levels.
> +#
> +# @invalid: Invalid topology level, used as a placeholder.

Placeholder for what?

> +#
> +# @thread: thread level, which would also be called SMT level or logical
> +#     processor level. The @threads option in -smp is used to configure
> +#     the topology of this level.
> +#
> +# @core: core level. The @cores option in -smp is used to configure the
> +#     topology of this level.
> +#
> +# @module: module level. The @modules option in -smp is used to
> +#     configure the topology of this level.
> +#
> +# @cluster: cluster level. The @clusters option in -smp is used to
> +#     configure the topology of this level.
> +#
> +# @die: die level. The @dies option in -smp is used to configure the
> +#     topology of this level.
> +#
> +# @socket: socket level, which would also be called package level. The
> +#     @sockets option in -smp is used to configure the topology of this
> +#     level.
> +#
> +# @book: book level. The @books option in -smp is used to configure the
> +#     topology of this level.
> +#
> +# @drawer: drawer level. The @drawers option in -smp is used to
> +#     configure the topology of this level.

As far as I can tell, -smp is sugar for machine property "smp" of QAPI
type SMPConfiguration.  Should we refer to SMPConfiguration instead of
-smp?

> +#
> +# Since: 9.1
> +##
> +{ 'enum': 'CPUTopoLevel',
> +  'prefix': 'CPU_TOPO_LEVEL',
> +  'data': [ 'invalid', 'thread', 'core', 'module', 'cluster',
> +            'die', 'socket', 'book', 'drawer' ] }
> +
>  ##
>  # @SMPConfiguration:
>  #

[...]


