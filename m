Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AADECCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 08:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8aq5-000691-Vo; Tue, 14 Oct 2025 04:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v8aq4-00068s-T7
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 04:57:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v8aq1-0007Xk-90
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 04:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760432215;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=JG0nljE1uvF8rOVPOA6b6wqCFLyeXeIK9yh62Gc/ou4=;
 b=fP3iFi27swpOGXbKJTUy8uZjWlkK3shWZOq7a5OqqajC+Kf0sa0EOrcWzPz5ILR3I+GfzM
 W8EDLZhRgIH+Td8Zs7JCVEGhnjpJl8A994NERJ2HsOob0NfsAIOF+3Ds3ZjrpKDm0JkvlU
 kSmW+/yNM6bafDjjJQ4DpCIdj+eCCds=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-wNCNyDIePOOp3RQHFGecnA-1; Tue,
 14 Oct 2025 04:56:51 -0400
X-MC-Unique: wNCNyDIePOOp3RQHFGecnA-1
X-Mimecast-MFC-AGG-ID: wNCNyDIePOOp3RQHFGecnA_1760432210
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E90F1955F0D; Tue, 14 Oct 2025 08:56:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.198])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA9421800446; Tue, 14 Oct 2025 08:56:44 +0000 (UTC)
Date: Tue, 14 Oct 2025 09:56:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v4 1/2] hw/uefi: add "info firmware-log" +
 "query-firmware-log" monitor commands
Message-ID: <aO4QSE7oNqpNApFZ@redhat.com>
References: <20251013104954.250166-1-kraxel@redhat.com>
 <20251013104954.250166-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251013104954.250166-2-kraxel@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Oct 13, 2025 at 12:49:53PM +0200, Gerd Hoffmann wrote:
> Starting with the edk2-stable202508 tag OVMF (and ArmVirt too) have
> optional support for logging to a memory buffer.  There is guest side
> support -- for example in linux kernels v6.17+ -- to read that buffer.
> But that might not helpful if your guest stops booting early enough that
> guest tooling can not be used yet.  So host side support to read that
> log buffer is a useful thing to have.
> 
> This patch implements both qmp and hmp monitor commands to read the
> firmware log.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/monitor/hmp.h      |   1 +
>  hw/uefi/ovmf-log.c         | 267 +++++++++++++++++++++++++++++++++++++
>  tests/qtest/qmp-cmd-test.c |   2 +
>  hmp-commands-info.hx       |  14 ++
>  hw/uefi/meson.build        |   2 +-
>  qapi/machine.json          |  23 ++++
>  6 files changed, 308 insertions(+), 1 deletion(-)
>  create mode 100644 hw/uefi/ovmf-log.c
> 
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index ae116d9804a3..885c0ecd2aed 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -178,5 +178,6 @@ void hmp_boot_set(Monitor *mon, const QDict *qdict);
>  void hmp_info_mtree(Monitor *mon, const QDict *qdict);
>  void hmp_info_cryptodev(Monitor *mon, const QDict *qdict);
>  void hmp_dumpdtb(Monitor *mon, const QDict *qdict);
> +void hmp_info_firmware_log(Monitor *mon, const QDict *qdict);
>  
>  #endif
> diff --git a/hw/uefi/ovmf-log.c b/hw/uefi/ovmf-log.c
> new file mode 100644
> index 000000000000..f03e47a290d6
> --- /dev/null
> +++ b/hw/uefi/ovmf-log.c
> @@ -0,0 +1,267 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * print ovmf debug log
> + *
> + * see OvmfPkg/Library/MemDebugLogLib/ in edk2
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qemu/base64.h"
> +#include "qemu/target-info-qapi.h"
> +#include "hw/boards.h"
> +#include "hw/i386/x86.h"
> +#include "hw/arm/virt.h"
> +#include "system/dma.h"
> +#include "monitor/hmp.h"
> +#include "monitor/monitor.h"
> +#include "qapi/error.h"
> +#include "qapi/type-helpers.h"
> +#include "qapi/qapi-commands-machine.h"
> +
> +
> +/* ----------------------------------------------------------------------- */
> +/* copy from edk2                                                          */
> +
> +#define MEM_DEBUG_LOG_MAGIC1  0x3167646d666d766f  /* "ovmfmdg1" */
> +#define MEM_DEBUG_LOG_MAGIC2  0x3267646d666d766f  /* "ovmfmdg2" */
> +
> +/*
> + * Mem Debug Log buffer header.
> + * The Log buffer is circular. Only the most
> + * recent messages are retained. Older messages
> + * will be discarded if the buffer overflows.
> + * The Debug Log starts just after the header.
> + */
> +typedef struct {
> +    /*
> +     * Magic values
> +     * These fields are used by tools to locate the buffer in
> +     * memory. These MUST be the first two fields of the structure.
> +     * Use a 128 bit Magic to vastly reduce the possibility of
> +     * a collision with random data in memory.
> +     */
> +    uint64_t             Magic1;
> +    uint64_t             Magic2;
> +    /*
> +     * Header Size
> +     * This MUST be the third field of the structure
> +     */
> +    uint64_t             HeaderSize;
> +    /*
> +     * Debug log size (minus header)
> +     */
> +    uint64_t             DebugLogSize;
> +    /*
> +     * edk2 uses this for locking access.
> +     */
> +    uint64_t             MemDebugLogLock;
> +    /*
> +     * Debug log head offset
> +     */
> +    uint64_t             DebugLogHeadOffset;
> +    /*
> +     *  Debug log tail offset
> +     */
> +    uint64_t             DebugLogTailOffset;
> +    /*
> +     * Flag to indicate if the buffer wrapped and was thus truncated.
> +     */
> +    uint64_t             Truncated;
> +    /*
> +     * Firmware Build Version (PcdFirmwareVersionString)
> +     */
> +    char                 FirmwareVersion[128];
> +} MEM_DEBUG_LOG_HDR;
> +
> +
> +/* ----------------------------------------------------------------------- */
> +/* qemu monitor command                                                    */
> +
> +typedef struct {
> +    uint64_t             magic1;
> +    uint64_t             magic2;
> +} MEM_DEBUG_LOG_MAGIC;
> +
> +/* find log buffer in guest memory by searching for the magic cookie */
> +static dma_addr_t find_ovmf_log_range(dma_addr_t start, dma_addr_t end)
> +{
> +    static const MEM_DEBUG_LOG_MAGIC magic = {
> +        .magic1 = MEM_DEBUG_LOG_MAGIC1,
> +        .magic2 = MEM_DEBUG_LOG_MAGIC2,
> +    };
> +    MEM_DEBUG_LOG_MAGIC check;
> +    dma_addr_t step = 4 * KiB;
> +    dma_addr_t offset;
> +
> +    for (offset = start; offset < end; offset += step) {
> +        if (dma_memory_read(&address_space_memory, offset,
> +                            &check, sizeof(check),
> +                            MEMTXATTRS_UNSPECIFIED)) {
> +            /* dma error -> stop searching */
> +            break;
> +        }
> +        if (memcmp(&magic, &check, sizeof(check)) == 0) {
> +            return offset;
> +        }
> +    }
> +    return (dma_addr_t)-1;
> +}
> +
> +static dma_addr_t find_ovmf_log(void)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    dma_addr_t start, end, offset;
> +
> +    if (target_arch() == SYS_EMU_TARGET_X86_64 &&
> +        object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE)) {
> +        X86MachineState *x86ms = X86_MACHINE(ms);
> +
> +        /* early log buffer, static allocation in memfd, sec + early pei */
> +        offset = find_ovmf_log_range(0x800000, 0x900000);
> +        if (offset != -1) {
> +            return offset;
> +        }
> +
> +        /*
> +         * normal log buffer, dynamically allocated close to end of low memory,
> +         * late pei + dxe phase
> +         */
> +        end = x86ms->below_4g_mem_size;
> +        start = end - MIN(end, 128 * MiB);
> +        return find_ovmf_log_range(start, end);
> +    }
> +
> +    if (target_arch() == SYS_EMU_TARGET_AARCH64 &&
> +        object_dynamic_cast(OBJECT(ms), TYPE_VIRT_MACHINE)) {
> +        VirtMachineState *vms = VIRT_MACHINE(ms);
> +
> +        /* edk2 ArmVirt firmware allocations are in the first 128 MB */
> +        start = vms->memmap[VIRT_MEM].base;
> +        end = start + 128 * MiB;
> +        return find_ovmf_log_range(start, end);
> +    }
> +
> +    return (dma_addr_t)-1;
> +}
> +
> +static void handle_ovmf_log_range(GString *out,
> +                                  dma_addr_t start,
> +                                  dma_addr_t end,
> +                                  Error **errp)
> +{
> +    g_autofree char *buf = NULL;

Left-over variable - unfortunately gcc doens't warn about unused
vars when g_autofree is present :-(

> +
> +    if (start > end) {
> +        return;
> +    }
> +
> +    size_t len = end - start;
> +    g_string_set_size(out, out->len + len);
> +    if (dma_memory_read(&address_space_memory, start,
> +                        out->str + (out->len - len),
> +                        len, MEMTXATTRS_UNSPECIFIED)) {
> +        error_setg(errp, "firmware log: buffer read error");
> +        return;
> +    }
> +}

> diff --git a/qapi/machine.json b/qapi/machine.json
> index 038eab281c78..c96e582afdd6 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1839,6 +1839,29 @@
>    'returns': 'HumanReadableText',
>    'features': [ 'unstable' ]}
>  
> +##
> +# @FirmwareLog:
> +#
> +# @version: Firmware version.
> +#
> +# @log: Firmware debug log, in base64 encoding.
> +#
> +# Since: 10.2
> +##
> +{ 'struct': 'FirmwareLog',
> +  'data': { '*version': 'str',
> +            '*log': 'str' } }

Having version be optional makes sense, but what is the semantics for
'log' being optional. If the log is unavailable, wouldn't we be better
raising an error ?


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


