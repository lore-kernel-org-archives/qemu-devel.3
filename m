Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C309CFB43F
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2024 16:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxUZ0-000886-Vd; Sun, 06 Oct 2024 12:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sxUYz-00087q-Md; Sun, 06 Oct 2024 12:56:57 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sxUYy-0000cB-4f; Sun, 06 Oct 2024 12:56:57 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 543694E6004;
 Sun, 06 Oct 2024 18:56:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 12nZs-NBiZTg; Sun,  6 Oct 2024 18:56:52 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5A61B4E6001; Sun, 06 Oct 2024 18:56:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 581E0746F60;
 Sun, 06 Oct 2024 18:56:52 +0200 (CEST)
Date: Sun, 6 Oct 2024 18:56:52 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Corey Minyard <cminyard@mvista.com>, qemu-ppc@nongnu.org, 
 Alex Williamson <alex.williamson@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: Re: [PATCH v2 01/23] hw/ppc/e500: Do not leak struct boot_info
In-Reply-To: <20241005194603.23139-2-shentey@gmail.com>
Message-ID: <631e016f-730f-7b2d-2ab0-49ce767e5e37@eik.bme.hu>
References: <20241005194603.23139-1-shentey@gmail.com>
 <20241005194603.23139-2-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, 5 Oct 2024, Bernhard Beschow wrote:
> The struct is allocated once with g_new0() but never free()'d. Fix the leakage
> by adding an attribute to struct PPCE500MachineState which avoids the
> allocation.
>
> While at it remove the obsolete /*< private >*/ markers.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
> hw/ppc/e500.h |  9 +++++++--
> hw/ppc/e500.c | 17 ++++-------------
> 2 files changed, 11 insertions(+), 15 deletions(-)
>
> diff --git a/hw/ppc/e500.h b/hw/ppc/e500.h
> index 8c09ef92e4..5654bb7907 100644
> --- a/hw/ppc/e500.h
> +++ b/hw/ppc/e500.h
> @@ -5,18 +5,23 @@
> #include "hw/platform-bus.h"
> #include "qom/object.h"
>
> +typedef struct boot_info {
> +    uint32_t dt_base;
> +    uint32_t dt_size;
> +    uint32_t entry;
> +} boot_info;
> +

You either don't need a typedef or don't need a struct name. Since coding 
style says typedefs should be camel case but other machines don't use a 
typedef it's probably simplest to drop the typedef and define the machine 
state field as struct boot_info below for consistency with other similar 
structs. Otherwise you'd have to come up with some camel case type name 
here but that would be less consistent with other machines. So I'd go 
without the typedef.

Regards,
BALATON Zoltan

> struct PPCE500MachineState {
> -    /*< private >*/
>     MachineState parent_obj;
>
>     /* points to instance of TYPE_PLATFORM_BUS_DEVICE if
>      * board supports dynamic sysbus devices
>      */
>     PlatformBusDevice *pbus_dev;
> +    boot_info boot_info;
> };
>
> struct PPCE500MachineClass {
> -    /*< private >*/
>     MachineClass parent_class;
>
>     /* required -- must at least add toplevel board compatible */
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 3bd12b54ab..75b051009f 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -80,13 +80,6 @@
>
> #define PLATFORM_CLK_FREQ_HZ       (400 * 1000 * 1000)
>
> -struct boot_info
> -{
> -    uint32_t dt_base;
> -    uint32_t dt_size;
> -    uint32_t entry;
> -};
> -
> static uint32_t *pci_map_create(void *fdt, uint32_t mpic, int first_slot,
>                                 int nr_slots, int *len)
> {
> @@ -919,7 +912,6 @@ void ppce500_init(MachineState *machine)
>     bool kernel_as_payload;
>     hwaddr bios_entry = 0;
>     target_long payload_size;
> -    struct boot_info *boot_info = NULL;
>     int dt_size;
>     int i;
>     unsigned int smp_cpus = machine->smp.cpus;
> @@ -974,9 +966,8 @@ void ppce500_init(MachineState *machine)
>         /* Register reset handler */
>         if (!i) {
>             /* Primary CPU */
> -            boot_info = g_new0(struct boot_info, 1);
>             qemu_register_reset(ppce500_cpu_reset, cpu);
> -            env->load_info = boot_info;
> +            env->load_info = &pms->boot_info;
>         } else {
>             /* Secondary CPUs */
>             qemu_register_reset(ppce500_cpu_reset_sec, cpu);
> @@ -1274,9 +1265,9 @@ void ppce500_init(MachineState *machine)
>     }
>     assert(dt_size < DTB_MAX_SIZE);
>
> -    boot_info->entry = bios_entry;
> -    boot_info->dt_base = dt_base;
> -    boot_info->dt_size = dt_size;
> +    pms->boot_info.entry = bios_entry;
> +    pms->boot_info.dt_base = dt_base;
> +    pms->boot_info.dt_size = dt_size;
> }
>
> static void e500_ccsr_initfn(Object *obj)
>

