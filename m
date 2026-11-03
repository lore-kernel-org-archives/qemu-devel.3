Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B162606A326
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LgA8j437
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO5Ea-0006jG-OS; Mon, 02 Nov 2026 22:30:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO5ES-0006f7-N6; Mon, 02 Nov 2026 22:30:45 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO5EQ-0006Ri-5S; Mon, 02 Nov 2026 22:30:43 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BEB7A6021D;
 Tue,  3 Nov 2026 03:30:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B7F1F00919;
 Tue,  3 Nov 2026 03:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793676640;
 bh=oaZPkTg943EtaoH09ffe/KVILlvsjFws1H/SUeAFpQQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=LgA8j437eunt3BVS/KcImb/+HUgHeZeZHahXk71J6K8Q3O5EhSRGRLCrZTHLpHKZ8
 BZzpzcTCqYR75B8HWK3zF6rDZGqH1pNOkitUnG6GMBW3ri1lwa1dXdV4KB7jj+xbuq
 i3XEKci/XZ+1Jm5VSmbWjj8X7+yXuBhvLE3+PJf5Y9/Ca8iThm3C2rwc2OkDanrZ13
 Q4wCM4IlajvLhkKR0HXU7u9XGJ7E7Cl+xTTPsWAlpnBK9Q+8V62g7qPJHbfb5VvJqI
 p8BbaMqBcHpzWJRy3q9T3X6ES6D9JINpRSUWjulfPiGYq0bH2saZjhm0Q06wM5WRPB
 xJ6ftzCCrCiHA==
Date: Tue, 3 Nov 2026 03:30:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 34/37] hw/arm/virt: Wire MSC error and overflow
 interrupts to the GIC
Message-ID: <20261103033032.1a097d66@jic23-hlaptop>
In-Reply-To: <tencent_E3765EAA6D66F47871052AAD65C21FD1F905@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
 <tencent_E3765EAA6D66F47871052AAD65C21FD1F905@qq.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=jic23@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 16 Oct 2026 18:10:54 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jinjie Ruan <ruanjinjie@huawei.com>
>=20
> Each board-created MSC gets two free SPIs above the platform bus range
> (MPAM_SPI_BASE =3D 112 + PLATFORM_BUS_NUM_IRQS), connected to the GIC
> (sysbus irq outputs [0] error, [1] overflow, both level).  The
> assigned GSIVs (SPI + 32) are recorded as err-gsiv/oflow-gsiv qdev
> properties, which the ACPI MPAM table already reports.
>=20
> Guest-verified on virt,mpam=3Don gic-v3 with linux 7.3.0-rc6:
> /proc/interrupts lists mpam:msc:error on hwirq 208/210/212 Level, no
> error storms, full resctrl regression suite passes.
>=20
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  hw/arm/virt.c | 59 +++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 53 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 1bcdd20..4ef7aed 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2144,8 +2144,35 @@ static void create_virtio_iommu_dt_bindings(VirtMa=
chineState *vms)
>  #define MPAM_VIRT_NUM_PARTID     256
>  #define MPAM_VIRT_NUM_INTPARTID  32
> =20
> +/*
> + * MPAM MSC wired interrupts start above the platform bus SPI range
> + * (112 .. 112 + PLATFORM_BUS_NUM_IRQS - 1).  Two lines per MSC.
> + */
> +#define MPAM_SPI_BASE   (112 + PLATFORM_BUS_NUM_IRQS)
> +
> +/*
> + * Hand a not-yet-realized MSC its two wired interrupt SPIs (error first,
> + * overflow second =E2=80=94 the sysbus_init_irq() order in hw/arm/mpam.=
c), and
> + * record the GSIVs (INTID =3D SPI + 32) the ACPI MPAM table must report.
> + */
> +static void mpam_msc_assign_irqs(DeviceState *dev,
> +                                 int *err_spi, int *oflow_spi, int *next=
_spi)
> +{
> +    if (*next_spi + 1 >=3D NUM_IRQS) {

+ 2 ?  Seems more logical as you are going to use 2 of them.

> +        error_report("virt: out of SPIs for MPAM MSC interrupts");
> +        exit(1);
> +    }
> +    *err_spi =3D (*next_spi)++;
> +    *oflow_spi =3D (*next_spi)++;
> +
> +    object_property_set_int(OBJECT(dev), "err-gsiv", *err_spi + 32,
> +                            &error_fatal);
> +    object_property_set_int(OBJECT(dev), "oflow-gsiv", *oflow_spi + 32,
> +                            &error_fatal);
> +}
> +
>  static void create_mpam_msc_cache(VirtMachineState *vms, int level,
> -                                  hwaddr *base)
> +                                  hwaddr *base, int *next_spi)
>  {
>      MachineState *ms =3D MACHINE(vms);
>      const CPUArchIdList *cpu_list =3D ms->possible_cpus;
> @@ -2180,13 +2207,14 @@ static void create_mpam_msc_cache(VirtMachineStat=
e *vms, int level,
>      }
> =20
>      for (i =3D 0; i < cpu_list->len; i +=3D step) {
> +        int err_spi, oflow_spi;
> +
>          dev =3D qdev_new(TYPE_MPAM_MSC_CACHE);
>          object_property_set_uint(OBJECT(dev), "num-ris", 1, &error_fatal=
);
>          object_property_set_uint(OBJECT(dev), "num-partid",
>                                   MPAM_VIRT_NUM_PARTID, &error_fatal);
>          object_property_set_uint(OBJECT(dev), "num-int-partid",
> -                                 MPAM_VIRT_NUM_INTPARTID,
> -                                 &error_fatal);
> +                                 MPAM_VIRT_NUM_INTPARTID, &error_fatal);
Push that back to where it was introduced, not here.

>          object_property_set_uint(OBJECT(dev), "cache-level", level,
>                                   &error_fatal);
>          object_property_set_uint(OBJECT(dev), "cache-type", UNIFIED_CACH=
E,
> @@ -2196,8 +2224,13 @@ static void create_mpam_msc_cache(VirtMachineState=
 *vms, int level,
...

>      } else {
>          int count_with_mem =3D 0;
> +        int err_spi, oflow_spi;
> =20
>          for (i =3D 0; i < ms->numa_state->num_nodes; i++) {
>              if (ms->numa_state->nodes[i].node_mem) {
> @@ -2252,14 +2295,18 @@ static void create_mpam_msc(VirtMachineState *vms=
, Error **errp)
>          object_property_set_uint(OBJECT(dev), "num-int-partid",
>                                   2, /* extreme narrowing */
>                                   &error_fatal);
> -
If you don't want this white space, figure out where it came from in earlier
patch and never introduce it.  Let's keep these patches tidy!

> +        mpam_msc_assign_irqs(dev, &err_spi, &oflow_spi, &next_spi);
>          sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>          sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
> +                           qdev_get_gpio_in(vms->gic, err_spi));
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1,
> +                           qdev_get_gpio_in(vms->gic, oflow_spi));
>          base +=3D MPAM_SIZE;
>      }
> =20
> -    create_mpam_msc_cache(vms, 3, &base);
> -    create_mpam_msc_cache(vms, 2, &base);
> +    create_mpam_msc_cache(vms, 3, &base, &next_spi);
> +    create_mpam_msc_cache(vms, 2, &base, &next_spi);
>  }
> =20
>  static void create_pcie(VirtMachineState *vms)


