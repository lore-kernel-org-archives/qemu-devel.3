Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A57C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 15:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl8gD-0004D6-Tu; Thu, 20 Feb 2025 10:41:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tl8gB-0004Cf-E1
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:41:35 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tl8g8-00039J-PG
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:41:34 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YzHVK5PSRz6GDj0;
 Thu, 20 Feb 2025 23:38:49 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 7080F140601;
 Thu, 20 Feb 2025 23:41:27 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Feb
 2025 16:41:26 +0100
Date: Thu, 20 Feb 2025 15:41:25 +0000
To: Hendrik Wuethrich <whendrik@google.com>
CC: <qemu-devel@nongnu.org>, <eduardo@habkost.net>,
 <richard.henderson@linaro.org>, <marcel.apfelbaum@gmail.com>,
 <mst@redhat.com>, <pbonzini@redhat.com>, <zhao1.liu@intel.com>,
 <xiaoyao.li@intel.com>, <peternewman@google.com>
Subject: Re: [PATCH v5 1/8] i386: Add Intel RDT device and State to config.
Message-ID: <20250220154125.00007a08@huawei.com>
In-Reply-To: <20241213172645.2751696-2-whendrik@google.com>
References: <20241213172645.2751696-1-whendrik@google.com>
 <20241213172645.2751696-2-whendrik@google.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 13 Dec 2024 17:26:38 +0000
Hendrik Wuethrich <whendrik@google.com> wrote:

> From: =E2=80=AAHendrik W=C3=BCthrich <whendrik@google.com>
>=20
> Change config to show RDT, add minimal code to the rdt.c module to make
> sure things still compile.
>=20
> Signed-off-by: Hendrik W=C3=BCthrich <whendrik@google.com>
Hi,

A few drive by comments.

> ---
>  hw/i386/Kconfig       |  4 ++
>  hw/i386/meson.build   |  1 +
>  hw/i386/rdt.c         | 99 +++++++++++++++++++++++++++++++++++++++++++
>  include/hw/i386/rdt.h | 25 +++++++++++
>  target/i386/cpu.h     |  3 ++
>  5 files changed, 132 insertions(+)
>  create mode 100644 hw/i386/rdt.c
>  create mode 100644 include/hw/i386/rdt.h

> diff --git a/hw/i386/rdt.c b/hw/i386/rdt.c
> new file mode 100644
> index 0000000000..b2203197e3
> --- /dev/null
> +++ b/hw/i386/rdt.c
> @@ -0,0 +1,99 @@
> +/*
> + * Intel Resource Director Technology (RDT).
> + *
> + * Copyright 2024 Google LLC
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but W=
ITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
> + * for more details.
> + */
> +
> +#include "hw/i386/rdt.h"
> +#include "qemu/osdep.h" /* Needs to be included before isa.h */
> +#include "hw/isa/isa.h"
> +#include "hw/qdev-properties.h"
> +#include "qom/object.h"
> +
> +/* Max counts for allocation masks or CBMs. In other words, the size of
> + * respective MSRs.
> + * L3_MASK and L3_mask are architectural limitations. THRTL_COUNT is just
> + * the space left until the next MSR.
> + * */


Should match multiline comment style in qemu style guide.

> +
> +/*One instance of RDT-internal state to be shared by all cores*/
> +struct RDTState {
> +    ISADevice parent;
> +
> +    /*Max amount of RMIDs*/

Spaces typically after * and before * I think are most common
syntax for comments in qEMU

> +    uint32_t rmids;
> +
> +    /*Per core state*/
> +    RDTStatePerCore *rdtInstances;
> +    RDTAllocation *allocations;
> +
> +    /*RDT Allocation bitmask MSRs*/
> +    uint32_t msr_L3_ia32_mask_n[RDT_MAX_L3_MASK_COUNT];
> +    uint32_t msr_L2_ia32_mask_n[RDT_MAX_L2_MASK_COUNT];
> +    uint32_t ia32_L2_qos_ext_bw_thrtl_n[RDT_MAX_MBA_THRTL_COUNT];
> +};
> +
> +struct RDTStateClass {
> +};
> +
> +OBJECT_DEFINE_TYPE(RDTState, rdt, RDT, ISA_DEVICE);
> +
> +static Property rdt_properties[] =3D {
> +    DEFINE_PROP_UINT32(RDT_NUM_RMID_PROP, RDTState, rmids, 256),
> +    DEFINE_PROP_END_OF_LIST(),

You'll see this in a rebase but this terminator is no longer needed
(or defined I think)
> +};
> +
> +static void rdt_init(Object *obj)
> +{
> +}
> +
> +static void rdt_finalize(Object *obj)
> +{
> +}

Why introduce this pair as empty and as far as I can see not called?
init is called in patch 2 so bring it in there.  I'm struggling to
spot finalize being called.


> +
> +static void rdt_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->hotpluggable =3D false;
> +    dc->desc =3D "RDT";
> +    dc->user_creatable =3D true;
> +
> +    device_class_set_props(dc, rdt_properties);
> +}

>      int32_t node_id; /* NUMA node this CPU belongs to */


