Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEB5CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHETZ-0002yy-Kk; Thu, 15 Oct 2026 01:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xHETB-0002Co-PI
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 01:57:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xHET9-0003J2-Qf
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 01:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792043854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hJHDnQZX6gxJBJ+TeMv2W47H55pt1rKvOc0qDAzQ+iY=;
 b=AjY2a8cGXCHs92Xzk4aibQwC7wQVO5UMvi830/KzoeyQQMMEVs4IhZQe4gwX7L02a4k+bt
 06HgK+r678ztjie10hncuxZOuU57+QqFQ/ORHBk0TPpn6s1pEg55zid5C3z379ui88g8kh
 9blGktBwArgYKlDoN40ee8c+TxeaMuc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-AOnvOIDkNN6atouxPZAGYg-1; Thu,
 15 Oct 2026 05:57:33 +0000
X-MC-Unique: AOnvOIDkNN6atouxPZAGYg-1
X-Mimecast-MFC-AGG-ID: AOnvOIDkNN6atouxPZAGYg_1792043852
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CC4518011EA; Thu, 15 Oct 2026 05:57:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A0E4018002B7; Thu, 15 Oct 2026 05:57:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 202C721E6A04; Thu, 15 Oct 2026 07:57:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 8/8] qmp: reimplement qmp_query_cpu_definitions as a
 dispatcher function
In-Reply-To: <20261015005355.62406-9-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Thu, 15 Oct 2026 00:53:55 +0000")
References: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
 <20261015005355.62406-9-pierrick.bouvier@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 07:57:29 +0200
Message-ID: <87cxtbbj5i.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> Now that we have per target implementations of this function, we simply
> dispatch the call to relevant implementation.
> This eliminates duplication of qmp_query_cpu_definitions symbol.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  hw/core/machine-qmp-cmds.c            | 32 +++++++++++++++++++++++++++
>  stubs/meson.build                     |  6 +++++
>  stubs/qmp-cpu-arm.c                   |  9 ++++++++
>  stubs/qmp-cpu-i386.c                  |  9 ++++++++
>  stubs/qmp-cpu-loongarch.c             |  9 ++++++++
>  stubs/qmp-cpu-mips.c                  |  9 ++++++++
>  stubs/qmp-cpu-ppc.c                   |  9 ++++++++
>  stubs/qmp-cpu-riscv.c                 |  9 ++++++++
>  stubs/qmp-cpu-s390x.c                 |  6 +++++
>  stubs/qmp-cpu.c                       |  7 ------
>  target/arm/arm-qmp-cmds.c             |  5 -----
>  target/i386/cpu.c                     |  5 -----
>  target/loongarch/loongarch-qmp-cmds.c |  5 -----
>  target/mips/system/mips-qmp-cmds.c    |  5 -----
>  target/ppc/ppc-qmp-cmds.c             |  5 -----
>  target/riscv/riscv-qmp-cmds.c         |  5 -----
>  target/s390x/cpu_models_system.c      |  5 -----
>  17 files changed, 98 insertions(+), 42 deletions(-)
>  create mode 100644 stubs/qmp-cpu-arm.c
>  create mode 100644 stubs/qmp-cpu-i386.c
>  create mode 100644 stubs/qmp-cpu-loongarch.c
>  create mode 100644 stubs/qmp-cpu-mips.c
>  create mode 100644 stubs/qmp-cpu-ppc.c
>  create mode 100644 stubs/qmp-cpu-riscv.c
>
> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
> index 9c08b17510a..3fee45d568d 100644
> --- a/hw/core/machine-qmp-cmds.c
> +++ b/hw/core/machine-qmp-cmds.c
> @@ -27,6 +27,7 @@
>  #include "system/hostmem.h"
>  #include "system/hw_accel.h"
>  #include "system/numa.h"
> +#include "system/qmp-cpu.h"
>  #include "system/ramlist.h"
>  #include "system/runstate.h"
>  #include "system/system.h"
> @@ -93,6 +94,37 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
>      return head;
>  }
>  
> +CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
> +{
> +    switch (target_arch()) {
> +    case SYS_EMU_TARGET_AARCH64:
> +    case SYS_EMU_TARGET_ARM:
> +        return qmp_query_arm_cpu_definitions(errp);
> +    case SYS_EMU_TARGET_I386:
> +    case SYS_EMU_TARGET_X86_64:
> +        return qmp_query_i386_cpu_definitions(errp);
> +    case SYS_EMU_TARGET_LOONGARCH64:
> +        return qmp_query_loongarch_cpu_definitions(errp);
> +    case SYS_EMU_TARGET_MIPS:
> +    case SYS_EMU_TARGET_MIPS64:
> +    case SYS_EMU_TARGET_MIPS64EL:
> +    case SYS_EMU_TARGET_MIPSEL:
> +        return qmp_query_mips_cpu_definitions(errp);
> +    case SYS_EMU_TARGET_PPC:
> +    case SYS_EMU_TARGET_PPC64:
> +        return qmp_query_ppc_cpu_definitions(errp);
> +    case SYS_EMU_TARGET_RISCV32:
> +    case SYS_EMU_TARGET_RISCV64:
> +        return qmp_query_riscv_cpu_definitions(errp);
> +    case SYS_EMU_TARGET_S390X:
> +        return qmp_query_s390x_cpu_definitions(errp);
> +    default:
> +        error_setg(errp,
> +                   "CPU model definitions are not supported on this target");
> +        return NULL;
> +    }
> +}
> +
>  MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
>                                      Error **errp)
>  {
> diff --git a/stubs/meson.build b/stubs/meson.build
> index 29b6644b254..dcb67ce5295 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -86,6 +86,12 @@ if have_system
>    stub_ss.add(files('qmp-i386-sgx.c'))
>    stub_ss.add(files('qmp-i386-xen.c'))
>    stub_ss.add(files('qmp-cpu.c'))
> +  stub_ss.add(files('qmp-cpu-arm.c'))
> +  stub_ss.add(files('qmp-cpu-i386.c'))
> +  stub_ss.add(files('qmp-cpu-loongarch.c'))
> +  stub_ss.add(files('qmp-cpu-mips.c'))
> +  stub_ss.add(files('qmp-cpu-ppc.c'))
> +  stub_ss.add(files('qmp-cpu-riscv.c'))
>    stub_ss.add(files('qmp-cpu-s390x.c'))
>    stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
>    if have_hmp
> diff --git a/stubs/qmp-cpu-arm.c b/stubs/qmp-cpu-arm.c
> new file mode 100644
> index 00000000000..6249d7bde8d
> --- /dev/null
> +++ b/stubs/qmp-cpu-arm.c
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include "qemu/osdep.h"
> +#include "system/qmp-cpu.h"
> +
> +CpuDefinitionInfoList *qmp_query_arm_cpu_definitions(Error **errp)
> +{
> +    g_assert_not_reached();
> +}
> diff --git a/stubs/qmp-cpu-i386.c b/stubs/qmp-cpu-i386.c
> new file mode 100644
> index 00000000000..4858951f8c2
> --- /dev/null
> +++ b/stubs/qmp-cpu-i386.c
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include "qemu/osdep.h"
> +#include "system/qmp-cpu.h"
> +
> +CpuDefinitionInfoList *qmp_query_i386_cpu_definitions(Error **errp)
> +{
> +    g_assert_not_reached();
> +}
> diff --git a/stubs/qmp-cpu-loongarch.c b/stubs/qmp-cpu-loongarch.c
> new file mode 100644
> index 00000000000..695b6558d7e
> --- /dev/null
> +++ b/stubs/qmp-cpu-loongarch.c
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include "qemu/osdep.h"
> +#include "system/qmp-cpu.h"
> +
> +CpuDefinitionInfoList *qmp_query_loongarch_cpu_definitions(Error **errp)
> +{
> +    g_assert_not_reached();
> +}
> diff --git a/stubs/qmp-cpu-mips.c b/stubs/qmp-cpu-mips.c
> new file mode 100644
> index 00000000000..4d251d5f078
> --- /dev/null
> +++ b/stubs/qmp-cpu-mips.c
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include "qemu/osdep.h"
> +#include "system/qmp-cpu.h"
> +
> +CpuDefinitionInfoList *qmp_query_mips_cpu_definitions(Error **errp)
> +{
> +    g_assert_not_reached();
> +}
> diff --git a/stubs/qmp-cpu-ppc.c b/stubs/qmp-cpu-ppc.c
> new file mode 100644
> index 00000000000..315461c7db7
> --- /dev/null
> +++ b/stubs/qmp-cpu-ppc.c
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include "qemu/osdep.h"
> +#include "system/qmp-cpu.h"
> +
> +CpuDefinitionInfoList *qmp_query_ppc_cpu_definitions(Error **errp)
> +{
> +    g_assert_not_reached();
> +}
> diff --git a/stubs/qmp-cpu-riscv.c b/stubs/qmp-cpu-riscv.c
> new file mode 100644
> index 00000000000..ce500ffa3f3
> --- /dev/null
> +++ b/stubs/qmp-cpu-riscv.c
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include "qemu/osdep.h"
> +#include "system/qmp-cpu.h"
> +
> +CpuDefinitionInfoList *qmp_query_riscv_cpu_definitions(Error **errp)
> +{
> +    g_assert_not_reached();
> +}
> diff --git a/stubs/qmp-cpu-s390x.c b/stubs/qmp-cpu-s390x.c
> index 71e794482b5..4556072a226 100644
> --- a/stubs/qmp-cpu-s390x.c
> +++ b/stubs/qmp-cpu-s390x.c
> @@ -3,6 +3,12 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-machine.h"
> +#include "system/qmp-cpu.h"
> +
> +CpuDefinitionInfoList *qmp_query_s390x_cpu_definitions(Error **errp)
> +{
> +    g_assert_not_reached();
> +}
>  
>  CpuModelCompareInfo *
>  qmp_query_cpu_model_comparison(CpuModelInfo *infoa,

I believe the stubs are needed to make hw/core/machine-qmp-cmds.c link
when targets are compiled out.  Suggest to briefly explain that in the
commit message.

[...]


