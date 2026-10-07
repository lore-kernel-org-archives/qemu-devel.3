Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117D5CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xESkL-0005nD-D6; Wed, 07 Oct 2026 10:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xESjf-0005Qc-NI; Wed, 07 Oct 2026 10:35:18 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xESjc-0001SV-B6; Wed, 07 Oct 2026 10:35:11 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2038D583224;
 Wed, 07 Oct 2026 16:35:06 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id O6kPRQADNTi0; Wed,  7 Oct 2026 16:35:03 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E176E5831F1; Wed, 07 Oct 2026 16:35:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DEBFA5831F0;
 Wed, 07 Oct 2026 16:35:03 +0200 (CEST)
Date: Wed, 7 Oct 2026 16:35:03 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Utkarsh Verma <uverma@linux.ibm.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@amd.com, 
 nnmlinux@linux.ibm.com, avnish@linux.ibm.com, pbonzini@redhat.com, 
 th.huth@posteo.eu, sbhat@linux.ibm.com, harshpb@linux.ibm.com, 
 amachhiw@linux.ibm.com, rathc@linux.ibm.com, philmd@linaro.org, 
 npiggin@gmail.com, marcandre.lureau@redhat.com, fam@euphon.net, 
 alex.bennee@linaro.org, richard.henderson@linaro.org
Subject: Re: [RFC PATCH v2 4/8] ppc/spapr: add VTY backend support to OF
 read/write/open services
In-Reply-To: <20261002052605.605858-5-uverma@linux.ibm.com>
Message-ID: <24e395cc-09f8-36aa-9f6c-51d90f5b7bd9@eik.bme.hu>
References: <20261002052605.605858-1-uverma@linux.ibm.com>
 <20261002052605.605858-5-uverma@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Fri, 2 Oct 2026, uverma@linux.ibm.com wrote:
> From: Utkarsh Verma <uverma@linux.ibm.com>
>
> Extend the VOF client interface to support console I/O through the sPAPR VTY
> device, which is needed by bootloaders such as GRUB during disk boot.
>
> Add vof_read() to implement the OpenFirmware "read" client service, which was
> previously missing.
>
> Route the OF read and write services backed by vty_getchars() and vty_putchars()
>
> Make vty_getchars() public similar to vty_putchars().
>
> AI-used-for: code
> Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
> ---
> hw/char/spapr_vty.c        |  2 +-
> hw/ppc/spapr_vof.c         |  2 +
> hw/ppc/trace-events        |  2 +
> hw/ppc/vof.c               | 84 ++++++++++++++++++++++++++++++++++++++
> include/hw/ppc/spapr_vio.h |  1 +
> 5 files changed, 90 insertions(+), 1 deletion(-)
>
> diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
> index 1dd9fb155c..2c97e0e027 100644
> --- a/hw/char/spapr_vty.c
> +++ b/hw/char/spapr_vty.c
> @@ -52,7 +52,7 @@ static void vty_receive(void *opaque, const uint8_t *buf, int size)
>     }
> }
>
> -static int vty_getchars(SpaprVioDevice *sdev, uint8_t *buf, int max)
> +int vty_getchars(SpaprVioDevice *sdev, uint8_t *buf, int max)
> {
>     SpaprVioVty *dev = VIO_SPAPR_VTY_DEVICE(sdev);
>     int n = 0;
> diff --git a/hw/ppc/spapr_vof.c b/hw/ppc/spapr_vof.c
> index 78d5b7d5b5..3195c859a4 100644
> --- a/hw/ppc/spapr_vof.c
> +++ b/hw/ppc/spapr_vof.c
> @@ -76,6 +76,8 @@ void spapr_vof_client_dt_finalize(SpaprMachineState *spapr, void *fdt)
>     if (stdout_path) {
>         _FDT(vof_client_open_store(fdt, spapr->vof, "/chosen", "stdout",
>                                    stdout_path));
> +        _FDT(vof_client_open_store(fdt, spapr->vof, "/chosen", "stdin",
> +                                   stdout_path));
>     }
> }
>
> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> index 1f125ce841..dbdcfada26 100644
> --- a/hw/ppc/trace-events
> +++ b/hw/ppc/trace-events
> @@ -79,6 +79,7 @@ vof_error_unknown_method(const char *method) "\"%s\""
> vof_error_unknown_ihandle_close(uint32_t ih) "ih=0x%x"
> vof_error_unknown_path(const char *path) "\"%s\""
> vof_error_write(uint32_t ih) "ih=0x%x"
> +vof_error_read(uint32_t ih) "ih=0x%x"
> vof_finddevice(const char *path, uint32_t ph) "\"%s\" => ph=0x%x"
> vof_claim(uint32_t virt, uint32_t size, uint32_t align, uint32_t ret) "virt=0x%x size=0x%x align=0x%x => 0x%x"
> vof_release(uint32_t virt, uint32_t size, uint32_t ret) "virt=0x%x size=0x%x => 0x%x"
> @@ -92,6 +93,7 @@ vof_package_to_path(uint32_t ph, const char *tmp, int ret) "ph=0x%x => %s len=%d
> vof_instance_to_path(uint32_t ih, uint32_t ph, const char *tmp, int ret) "ih=0x%x ph=0x%x => %s len=%d"
> vof_instance_to_package(uint32_t ih, uint32_t ph) "ih=0x%x => ph=0x%x"
> vof_write(uint32_t ih, unsigned cb, const char *msg) "ih=0x%x [%u] \"%s\""
> +vof_read(uint32_t ih, unsigned cb, const char *msg) "ih=0x%x [%u] \"%s\""
> vof_avail(uint64_t start, uint64_t end, uint64_t size) "0x%"PRIx64"..0x%"PRIx64" size=0x%"PRIx64
> vof_claimed(uint64_t start, uint64_t end, uint64_t size) "0x%"PRIx64"..0x%"PRIx64" size=0x%"PRIx64
>
> diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
> index 9ad1aa7626..6f6d424347 100644
> --- a/hw/ppc/vof.c
> +++ b/hw/ppc/vof.c
> @@ -9,6 +9,7 @@
>  * SPDX-License-Identifier: GPL-2.0-or-later
>  */
>
> +#include CONFIG_DEVICES /* CONFIG_PSERIES */
> #include "qemu/osdep.h"
> #include "qemu/ctype.h"
> #include "qemu/timer.h"
> @@ -23,6 +24,7 @@
> #include "qom/qom-qobject.h"
> #include "trace.h"
>
> +#include "hw/ppc/spapr_vio.h"
> #include <libfdt.h>
>
> /*
> @@ -45,6 +47,7 @@ typedef struct {
> typedef struct {
>     char *path; /* the path used to open the instance */
>     uint32_t phandle;
> +    void *vty;
> } OfInstance;
>
> static int readstr(hwaddr pa, char *buf, int size)
> @@ -459,6 +462,28 @@ static uint32_t vof_do_open(void *fdt, Vof *vof, int offset, const char *path)
>     ++vof->of_instance_last;
>
>     inst->path = g_strdup(path);
> +    inst->vty = NULL;
> +
> +#ifdef CONFIG_PSERIES
> +    const char *node_name = fdt_get_name(fdt, offset, NULL);
> +    if (node_name && strncmp(node_name, "vty", 3) == 0) {
> +        uint8_t discard_buf[VOF_VTY_BUF_SIZE];
> +        MachineState *ms = MACHINE(qdev_get_machine());
> +        SpaprMachineState *spapr = SPAPR_MACHINE(ms);
> +
> +        if (spapr && spapr->vio_bus) {
> +            inst->vty = spapr_vty_get_default(spapr->vio_bus);
> +            if (inst->vty) {
> +                /* Flush any stale data from the VTY input buffer */
> +                while (vty_getchars(inst->vty, discard_buf,
> +                                    sizeof(discard_buf)) > 0) {
> +                    /* discard */
> +                }
> +            }
> +        }
> +    }
> +#endif
> +
>     g_hash_table_insert(vof->of_instances,
>                         GINT_TO_POINTER(vof->of_instance_last),
>                         inst);
> @@ -577,6 +602,23 @@ static uint32_t vof_write(Vof *vof, uint32_t ihandle, uint32_t buf,
>         return PROM_ERROR;
>     }
>
> +#ifdef CONFIG_PSERIES
> +    if (inst->vty) {
> +        uint32_t total_written = 0;
> +
> +        for ( ; len > 0; len -= cb) {
> +            cb = MIN(len, sizeof(tmp));
> +            if (VOF_MEM_READ(buf, tmp, cb) != MEMTX_OK) {
> +                return PROM_ERROR;
> +            }
> +            vty_putchars(inst->vty, (uint8_t *)tmp, cb);
> +            buf += cb;
> +            total_written += cb;
> +        }
> +        return total_written;
> +    }
> +#endif
> +

Instead of adding #ifdefs in this file could these be implemented as some 
functions exported by spapr_vof.c and called here without needing #ifdefs? 
Maybe it could be part of VofMachineIfClass similar to setprop.

Regards,
BALATON Zoltan

>     for ( ; len > 0; len -= cb) {
>         cb = MIN(len, sizeof(tmp) - 1);
>         if (VOF_MEM_READ(buf, tmp, cb) != MEMTX_OK) {
> @@ -594,6 +636,46 @@ static uint32_t vof_write(Vof *vof, uint32_t ihandle, uint32_t buf,
>     return len;
> }
>
> +static uint32_t vof_read(Vof *vof, uint32_t ihandle, uint32_t buf,
> +                         uint32_t len)
> +{
> +    OfInstance *inst = (OfInstance *)
> +        g_hash_table_lookup(vof->of_instances, GINT_TO_POINTER(ihandle));
> +
> +    if (!inst) {
> +        trace_vof_error_read(ihandle);
> +        return PROM_ERROR;
> +    }
> +
> +#ifdef CONFIG_PSERIES
> +    if (inst->vty) {
> +        uint8_t tmp[VOF_VTY_BUF_SIZE];
> +        unsigned cb = MIN(len, sizeof(tmp));
> +        uint32_t bytes_read = vty_getchars(inst->vty, tmp, cb);
> +        if (bytes_read > 0) {
> +            if (VOF_MEM_WRITE(buf, tmp, bytes_read) != MEMTX_OK) {
> +                trace_vof_error_read(ihandle);
> +                return PROM_ERROR;
> +            }
> +        }
> +        if (trace_event_get_state(TRACE_VOF_READ) &&
> +            qemu_loglevel_mask(LOG_TRACE)) {
> +            char trace_buf[VOF_VTY_BUF_SIZE + 1];
> +            memcpy(trace_buf, tmp, bytes_read);
> +            trace_buf[bytes_read] = '\0';
> +            trace_vof_read(ihandle, bytes_read, trace_buf);
> +        }
> +        return bytes_read;
> +    }
> +#endif
> +
> +    /*
> +     * For other devices, return 0 to indicate no data available.
> +     * This allows GRUB to continue without blocking on input.
> +     */
> +    return 0;
> +}
> +
> static void vof_claimed_dump(GArray *claimed)
> {
>     int i;
> @@ -906,6 +988,8 @@ static uint32_t vof_client_handle(MachineState *ms, void *fdt, Vof *vof,
>         ret = vof_instance_to_path(fdt, vof, args[0], args[1], args[2]);
>     } else if (cmpserv("write", 3, 1)) {
>         ret = vof_write(vof, args[0], args[1], args[2]);
> +    } else if (cmpserv("read", 3, 1)) {
> +        ret = vof_read(vof, args[0], args[1], args[2]);
>     } else if (cmpserv("claim", 3, 1)) {
>         uint64_t ret64 = vof_claim(vof, args[0], args[1], args[2]);
>
> diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
> index 0ea0dbae8b..81e7c0b91b 100644
> --- a/include/hw/ppc/spapr_vio.h
> +++ b/include/hw/ppc/spapr_vio.h
> @@ -136,6 +136,7 @@ static inline int spapr_vio_dma_set(SpaprVioDevice *dev, uint64_t taddr,
> int spapr_vio_send_crq(SpaprVioDevice *dev, uint8_t *crq);
>
> SpaprVioDevice *vty_lookup(SpaprMachineState *spapr, target_ulong reg);
> +int vty_getchars(SpaprVioDevice *sdev, uint8_t *buf, int max);
> void vty_putchars(SpaprVioDevice *sdev, uint8_t *buf, int len);
> void spapr_vty_create(SpaprVioBus *bus, Chardev *chardev);
> void spapr_vlan_create(SpaprVioBus *bus, NICInfo *nd);
>

