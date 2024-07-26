Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF68C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 10:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXI7r-0000LH-UC; Fri, 26 Jul 2024 06:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sXI7p-0000KO-FS
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 06:24:37 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sXI7k-000216-Oe
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 06:24:36 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WVkN10Fmbz6K5kR;
 Fri, 26 Jul 2024 18:22:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id BDFA5140A46;
 Fri, 26 Jul 2024 18:24:24 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 26 Jul
 2024 11:24:24 +0100
Date: Fri, 26 Jul 2024 11:24:23 +0100
To: Hendrik Wuethrich <whendrik@google.com>
CC: <qemu-devel@nongnu.org>, <eduardo@habkost.net>,
 <richard.henderson@linaro.org>, <marcel.apfelbaum@gmail.com>,
 <mst@redhat.com>, <pbonzini@redhat.com>, <peternewman@google.com>
Subject: Re: [PATCH v1 1/9] Add Intel RDT device to config.
Message-ID: <20240726112423.00005e5f@Huawei.com>
In-Reply-To: <20240719162929.1197154-2-whendrik@google.com>
References: <20240719162929.1197154-1-whendrik@google.com>
 <20240719162929.1197154-2-whendrik@google.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.174.77]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
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

On Fri, 19 Jul 2024 16:29:21 +0000
Hendrik Wuethrich <whendrik@google.com> wrote:

> From: =E2=80=AAHendrik W=C3=BCthrich <whendrik@google.com>
>=20
> Change config to show RDT, add minimal code to the rdt.c module to make
> sure things still compile.
>=20
> Signed-off-by: Hendrik W=C3=BCthrich <whendrik@google.com>

Hi Hendrik

Great to see emulation of this. Will be handy for testing
kernel changes etc.

Not convinced it's worth a separate patch just to add stubs.
Why not at least bring some real code in with this?

> ---
>  hw/i386/Kconfig       |  4 ++++
>  hw/i386/meson.build   |  1 +
>  hw/i386/rdt.c         | 49 +++++++++++++++++++++++++++++++++++++++++++
>  include/hw/i386/rdt.h | 12 +++++++++++
>  4 files changed, 66 insertions(+)
>  create mode 100644 hw/i386/rdt.c
>  create mode 100644 include/hw/i386/rdt.h
>=20
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index f4a33b6c08..4dd05ed6f2 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -10,6 +10,9 @@ config SGX
>      bool
>      depends on KVM
> =20
> +config RDT
> +    bool
> +
>  config PC
>      bool
>      imply APPLESMC
> @@ -26,6 +29,7 @@ config PC
>      imply QXL
>      imply SEV
>      imply SGX
> +    imply RDT
>      imply TEST_DEVICES
>      imply TPM_CRB
>      imply TPM_TIS_ISA
> diff --git a/hw/i386/meson.build b/hw/i386/meson.build
> index 03aad10df7..fdbf5962b5 100644
> --- a/hw/i386/meson.build
> +++ b/hw/i386/meson.build
> @@ -21,6 +21,7 @@ i386_ss.add(when: 'CONFIG_VMPORT', if_true: files('vmpo=
rt.c'))
>  i386_ss.add(when: 'CONFIG_VTD', if_true: files('intel_iommu.c'))
>  i386_ss.add(when: 'CONFIG_SGX', if_true: files('sgx-epc.c','sgx.c'),
>                                  if_false: files('sgx-stub.c'))
> +i386_ss.add(when: 'CONFIG_RDT', if_true: files('rdt.c'))
> =20
>  i386_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-common.c'))
>  i386_ss.add(when: 'CONFIG_PC', if_true: files(
> diff --git a/hw/i386/rdt.c b/hw/i386/rdt.c
> new file mode 100644
> index 0000000000..0a5e95606b
> --- /dev/null
> +++ b/hw/i386/rdt.c

License etc missing.

> @@ -0,0 +1,49 @@
> +#include "qemu/osdep.h"
> +#include "hw/i386/rdt.h"
> +#include <stdint.h>
> +#include "hw/qdev-properties.h"
> +#include "qemu/typedefs.h"
> +#include "qom/object.h"
> +#include "target/i386/cpu.h"
> +#include "hw/isa/isa.h"

Ordering seems a bit random.  I don't really mind what order
they are in but it is easier to pick an option so it
becomes obvious where to put things later.

Also better to bring these in when they are needed so it
is obvious why they are here.


> +
> +#define TYPE_RDT "rdt"
> +
> +OBJECT_DECLARE_TYPE(RDTState, RDTStateClass, RDT);
> +
> +struct RDTState {
> +    ISADevice parent;
> +};
> +
> +struct RDTStateClass { };
I'd do
...Class {
};

As will reduce noise in later patches assuming this will have
content.


> +
> +OBJECT_DEFINE_TYPE(RDTState, rdt, RDT, ISA_DEVICE);
> +
> +static Property rdt_properties[] =3D {
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void rdt_init(Object *obj)

Not used?

> +{
> +}
> +
> +static void rdt_realize(DeviceState *dev, Error **errp)
> +{
> +}
> +
> +static void rdt_finalize(Object *obj)
> +{
> +}

Not used?

> +
> +static void rdt_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->hotpluggable =3D false;
> +    dc->desc =3D "RDT";
> +    dc->user_creatable =3D true;
> +    dc->realize =3D rdt_realize;
> +
> +    device_class_set_props(dc, rdt_properties);
> +}
> +
> diff --git a/include/hw/i386/rdt.h b/include/hw/i386/rdt.h
> new file mode 100644
> index 0000000000..45e34d3103
> --- /dev/null
> +++ b/include/hw/i386/rdt.h
> @@ -0,0 +1,12 @@
> +#ifndef HW_RDT_H
> +#define HW_RDT_H
> +
> +#include <stdbool.h>
> +#include <stdint.h>

Not used so don't include them until needed.

> +
> +typedef struct RDTState RDTState;
> +typedef struct RDTStateInstance RDTStateInstance;
> +typedef struct RDTMonitor RDTMonitor;
> +typedef struct RDTAllocation RDTAllocation;
> +
> +#endif


