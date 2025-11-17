Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2209DCEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 17:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL2nm-0008FH-5J; Mon, 17 Nov 2025 12:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vL2nY-0007y8-3C
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:13:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vL2nV-0006xt-FW
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:13:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763399628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rivxdtJOIlouE9+EE296t9Z5KRR72XB0SmVPzPY3syA=;
 b=HCtHAMUaEm/EG/vqXeRS/uzqNKKE/+Li5LDeChJgHQc5MdwMyG4DWbdvJJshm1+VyWvaUF
 nIevgJokdueIdwwKuT2JgfAahFIjOXuVUble7Ohcb2dl5jWevAM0zOnhx6bE2k9g2LRwdK
 sRjfvs4StXTEQFjn49DUVh94TiAdbd0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-ANT1B8m2M2mf_tzLAsmDwA-1; Mon,
 17 Nov 2025 12:13:44 -0500
X-MC-Unique: ANT1B8m2M2mf_tzLAsmDwA-1
X-Mimecast-MFC-AGG-ID: ANT1B8m2M2mf_tzLAsmDwA_1763399623
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DAFC1955F54; Mon, 17 Nov 2025 17:13:43 +0000 (UTC)
Received: from localhost (unknown [10.45.225.173])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F40711800367; Mon, 17 Nov 2025 17:13:41 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org, Peter Maydell
 <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 1/2] hw/arm/imx8mp-evk: Add KVM support
In-Reply-To: <20251101120130.236721-2-shentey@gmail.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20251101120130.236721-1-shentey@gmail.com>
 <20251101120130.236721-2-shentey@gmail.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Mon, 17 Nov 2025 18:13:38 +0100
Message-ID: <87v7j8r399.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Nov 01 2025, Bernhard Beschow <shentey@gmail.com> wrote:

> Allows the imx8mp-evk machine to run guests with KVM acceleration.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  docs/system/arm/imx8mp-evk.rst | 19 +++++++++++++++++++
>  hw/arm/fsl-imx8mp.c            | 34 +++++++++++++++++++++++++++++-----
>  hw/arm/imx8mp-evk.c            | 11 +++++++++++
>  hw/arm/Kconfig                 |  3 ++-
>  4 files changed, 61 insertions(+), 6 deletions(-)
>
> diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
> index b2f7d29ade..75c8fbd366 100644
> --- a/docs/system/arm/imx8mp-evk.rst
> +++ b/docs/system/arm/imx8mp-evk.rst
> @@ -60,3 +60,22 @@ Now that everything is prepared the machine can be started as follows:
>        -dtb imx8mp-evk.dtb \
>        -append "root=/dev/mmcblk2p2" \
>        -drive file=sdcard.img,if=sd,bus=2,format=raw,id=mmcblk2
> +
> +
> +KVM Acceleration
> +----------------
> +
> +To enable hardware-assisted acceleration via KVM, append
> +``-accel kvm -cpu host`` to the command line. While this speeds up performance
> +significantly, be aware of the following limitations:
> +
> +* The ``imx8mp-evk`` machine is not included under the "virtualization use case"
> +  of :doc:`QEMU's security policy </system/security>`. This means that you
> +  should not trust that it can contain malicious guests, whether it is run
> +  using TCG or KVM. If you don't trust your guests and you're relying on QEMU to
> +  be the security boundary, you want to choose another machine such as ``virt``.
> +* Rather than Cortex-A53 CPUs, the same CPU type as the host's will be used.
> +  This is a limitation of KVM and may not work with guests with a tight
> +  dependency on Cortex-A53.
> +* No EL2 and EL3 exception levels are available which is also a KVM limitation.
> +  Direct kernel boot should work but running U-Boot, TF-A, etc. won't succeed.
> diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
> index 866f4d1d74..ee6f3e42d2 100644
> --- a/hw/arm/fsl-imx8mp.c
> +++ b/hw/arm/fsl-imx8mp.c
> @@ -12,11 +12,13 @@
>  #include "system/address-spaces.h"
>  #include "hw/arm/bsa.h"
>  #include "hw/arm/fsl-imx8mp.h"
> -#include "hw/intc/arm_gicv3.h"
>  #include "hw/misc/unimp.h"
>  #include "hw/boards.h"
> +#include "system/kvm.h"
>  #include "system/system.h"
> +#include "target/arm/cpu.h"
>  #include "target/arm/cpu-qom.h"
> +#include "target/arm/kvm_arm.h"
>  #include "qapi/error.h"
>  #include "qobject/qlist.h"
>  
> @@ -193,15 +195,15 @@ static void fsl_imx8mp_init(Object *obj)
>  {
>      MachineState *ms = MACHINE(qdev_get_machine());
>      FslImx8mpState *s = FSL_IMX8MP(obj);
> +    const char *cpu_type = ms->cpu_type ?: ARM_CPU_TYPE_NAME("cortex-a53");
>      int i;
>  
>      for (i = 0; i < MIN(ms->smp.cpus, FSL_IMX8MP_NUM_CPUS); i++) {
>          g_autofree char *name = g_strdup_printf("cpu%d", i);
> -        object_initialize_child(obj, name, &s->cpu[i],
> -                                ARM_CPU_TYPE_NAME("cortex-a53"));
> +        object_initialize_child(obj, name, &s->cpu[i], cpu_type);
>      }
>  
> -    object_initialize_child(obj, "gic", &s->gic, TYPE_ARM_GICV3);
> +    object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());

Running current master (resp. with this patch applied), I'm getting make
check failures on an aarch64 (Mt. Snow) host ("qemu-system-aarch64:
unknown type 'arm-gicv3'" while using this machine); going back right
before this patch, everything works fine. Haven't tried to debug this
yet (maybe I'm the one with the weird config again...)

>  
>      object_initialize_child(obj, "ccm", &s->ccm, TYPE_IMX8MP_CCM);
>  
> @@ -274,7 +276,8 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
>      /* CPUs */
>      for (i = 0; i < ms->smp.cpus; i++) {
>          /* On uniprocessor, the CBAR is set to 0 */
> -        if (ms->smp.cpus > 1) {
> +        if (ms->smp.cpus > 1 &&
> +                object_property_find(OBJECT(&s->cpu[i]), "reset-cbar")) {
>              object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
>                                      fsl_imx8mp_memmap[FSL_IMX8MP_GIC_DIST].addr,
>                                      &error_abort);
> @@ -286,6 +289,16 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
>          object_property_set_int(OBJECT(&s->cpu[i]), "cntfrq", 8000000,
>                                  &error_abort);
>  
> +        if (object_property_find(OBJECT(&s->cpu[i]), "has_el2")) {
> +            object_property_set_bool(OBJECT(&s->cpu[i]), "has_el2",
> +                                     !kvm_enabled(), &error_abort);
> +        }
> +
> +        if (object_property_find(OBJECT(&s->cpu[i]), "has_el3")) {
> +            object_property_set_bool(OBJECT(&s->cpu[i]), "has_el3",
> +                                     !kvm_enabled(), &error_abort);
> +        }
> +
>          if (i) {
>              /*
>               * Secondary CPUs start in powered-down state (and can be
> @@ -304,6 +317,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
>      {
>          SysBusDevice *gicsbd = SYS_BUS_DEVICE(&s->gic);
>          QList *redist_region_count;
> +        bool pmu = object_property_get_bool(OBJECT(first_cpu), "pmu", NULL);
>  
>          qdev_prop_set_uint32(gicdev, "num-cpu", ms->smp.cpus);
>          qdev_prop_set_uint32(gicdev, "num-irq",
> @@ -360,6 +374,16 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
>                                 qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
>              sysbus_connect_irq(gicsbd, i + 3 * ms->smp.cpus,
>                                 qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
> +
> +            if (kvm_enabled()) {
> +                if (pmu) {
> +                    assert(arm_feature(&s->cpu[i].env, ARM_FEATURE_PMU));
> +                    if (kvm_irqchip_in_kernel()) {
> +                        kvm_arm_pmu_set_irq(&s->cpu[i], VIRTUAL_PMU_IRQ);
> +                    }
> +                    kvm_arm_pmu_init(&s->cpu[i]);
> +                }
> +            }
>          }
>      }
>  
> diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
> index fc880a1d44..3ddcf1af5a 100644
> --- a/hw/arm/imx8mp-evk.c
> +++ b/hw/arm/imx8mp-evk.c
> @@ -13,6 +13,7 @@
>  #include "hw/arm/machines-qom.h"
>  #include "hw/boards.h"
>  #include "hw/qdev-properties.h"
> +#include "system/kvm.h"
>  #include "system/qtest.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> @@ -94,12 +95,22 @@ static void imx8mp_evk_init(MachineState *machine)
>      }
>  }
>  
> +static const char *imx8mp_evk_get_default_cpu_type(const MachineState *ms)
> +{
> +    if (kvm_enabled()) {
> +        return ARM_CPU_TYPE_NAME("host");
> +    }
> +
> +    return ARM_CPU_TYPE_NAME("cortex-a53");
> +}
> +
>  static void imx8mp_evk_machine_init(MachineClass *mc)
>  {
>      mc->desc = "NXP i.MX 8M Plus EVK Board";
>      mc->init = imx8mp_evk_init;
>      mc->max_cpus = FSL_IMX8MP_NUM_CPUS;
>      mc->default_ram_id = "imx8mp-evk.ram";
> +    mc->get_default_cpu_type = imx8mp_evk_get_default_cpu_type;
>  }
>  
>  DEFINE_MACHINE_AARCH64("imx8mp-evk", imx8mp_evk_machine_init)
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index b44b85f436..0cdeb60f1f 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -622,7 +622,8 @@ config FSL_IMX8MP
>  config FSL_IMX8MP_EVK
>      bool
>      default y
> -    depends on TCG && AARCH64
> +    depends on AARCH64
> +    depends on TCG || KVM
>      select FSL_IMX8MP
>  
>  config ARM_SMMUV3
> -- 
> 2.51.2


