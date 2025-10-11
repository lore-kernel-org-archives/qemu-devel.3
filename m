Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F56CCCD183
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 09:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7VvE-0008KN-8z; Sat, 11 Oct 2025 05:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v7VvB-0008KF-BN
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 05:29:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v7Vv0-0004pR-PV
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 05:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760174976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9YHJvf8XqxyGAZw72MT6wARkf/KNahEtb+3o14TuVew=;
 b=L7qLu6ILyNya0Etie3D10FiN5FxRV/Gr5j/rpoCTuyg4UNh+YmvsQTbQvgqQasFbqfNIPK
 bIhqsWv3rS0Ti6BbXk0OsiymKf+WBwY09oMPTbFk+7jAY7QakazKw3CYKY9yiwp6sOrHPd
 ex52EpVbiDabTUrfUdbRAofd9qFVU+A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-1AkC8Wf5Nx2hwcsD7_Y4Ag-1; Sat,
 11 Oct 2025 05:29:35 -0400
X-MC-Unique: 1AkC8Wf5Nx2hwcsD7_Y4Ag-1
X-Mimecast-MFC-AGG-ID: 1AkC8Wf5Nx2hwcsD7_Y4Ag_1760174973
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A568180045C; Sat, 11 Oct 2025 09:29:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1AFFF1800578; Sat, 11 Oct 2025 09:29:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 588D821E6A27; Sat, 11 Oct 2025 11:29:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Yanan Wang
 <wangyanan55@huawei.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,  Eric Blake <eblake@redhat.com>,  "Dr.
 David Alan Gilbert" <dave@treblig.org>,  Laurent Vivier
 <lvivier@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v3] hw/uefi: add "info firmware-log" +
 "query-firmware-log" monitor commands
In-Reply-To: <874is6fyl7.fsf@pond.sub.org> (Markus Armbruster's message of
 "Fri, 10 Oct 2025 19:36:36 +0200")
References: <20251010071008.2555267-1-kraxel@redhat.com>
 <87ecrbj85s.fsf@pond.sub.org> <874is6fyl7.fsf@pond.sub.org>
Date: Sat, 11 Oct 2025 11:29:29 +0200
Message-ID: <87h5w5dbwm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
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

Yet another thing...

Markus Armbruster <armbru@redhat.com> writes:

> One more thing...  or rather two.
>
> Markus Armbruster <armbru@redhat.com> writes:
>
>> Gerd Hoffmann <kraxel@redhat.com> writes:
>>
>>> Starting with the edk2-stable202508 tag OVMF (and ArmVirt too) have
>>> optional support for logging to a memory buffer.  There is guest side
>>> support -- for example in linux kernels v6.17+ -- to read that buffer.
>>> But that might not helpful if your guest stops booting early enough that
>>> guest tooling can not be used yet.  So host side support to read that
>>> log buffer is a useful thing to have.
>>>
>>> This patch implements both qmp and hmp monitor commands to read the
>>> firmware log.
>>
>> So this is just for EDK2, at least for now.
>>
>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>> ---
>>>  include/monitor/hmp.h      |   1 +
>>>  hw/uefi/ovmf-log.c         | 265 +++++++++++++++++++++++++++++++++++++
>>>  tests/qtest/qmp-cmd-test.c |   2 +
>>>  hmp-commands-info.hx       |  14 ++
>>>  hw/uefi/meson.build        |   2 +-
>>>  qapi/machine.json          |  23 ++++
>>>  6 files changed, 306 insertions(+), 1 deletion(-)
>>>  create mode 100644 hw/uefi/ovmf-log.c
>>>
>>> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
>>> index ae116d9804a3..885c0ecd2aed 100644
>>> --- a/include/monitor/hmp.h
>>> +++ b/include/monitor/hmp.h
>>> @@ -178,5 +178,6 @@ void hmp_boot_set(Monitor *mon, const QDict *qdict);
>>>  void hmp_info_mtree(Monitor *mon, const QDict *qdict);
>>>  void hmp_info_cryptodev(Monitor *mon, const QDict *qdict);
>>>  void hmp_dumpdtb(Monitor *mon, const QDict *qdict);
>>> +void hmp_info_firmware_log(Monitor *mon, const QDict *qdict);
>>>  
>>>  #endif
>>> diff --git a/hw/uefi/ovmf-log.c b/hw/uefi/ovmf-log.c
>>> new file mode 100644
>>> index 000000000000..89e27d916531
>>> --- /dev/null
>>> +++ b/hw/uefi/ovmf-log.c
>>> @@ -0,0 +1,265 @@
>>> +/*
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + *
>>> + * print ovmf debug log
>>> + *
>>> + * see OvmfPkg/Library/MemDebugLogLib/ in edk2
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "qemu/units.h"
>>> +#include "qemu/base64.h"
>>> +#include "qemu/target-info-qapi.h"
>>> +#include "hw/boards.h"
>>> +#include "hw/i386/x86.h"
>>> +#include "hw/arm/virt.h"
>>> +#include "system/dma.h"
>>> +#include "monitor/hmp.h"
>>> +#include "monitor/monitor.h"
>>> +#include "qapi/error.h"
>>> +#include "qapi/type-helpers.h"
>>> +#include "qapi/qapi-commands-machine.h"
>>> +
>>> +
>>> +/* ----------------------------------------------------------------------- */
>>> +/* copy from edk2                                                          */
>>> +
>>> +#define MEM_DEBUG_LOG_MAGIC1  0x3167646d666d766f  /* "ovmfmdg1" */
>>> +#define MEM_DEBUG_LOG_MAGIC2  0x3267646d666d766f  /* "ovmfmdg2" */
>>> +
>>> +/*
>>> + * Mem Debug Log buffer header.
>>> + * The Log buffer is circular. Only the most
>>> + * recent messages are retained. Older messages
>>> + * will be discarded if the buffer overflows.
>>> + * The Debug Log starts just after the header.
>>> + */
>>> +typedef struct {
>>> +    /*
>>> +     * Magic values
>>> +     * These fields are used by tools to locate the buffer in
>>> +     * memory. These MUST be the first two fields of the structure.
>>> +     * Use a 128 bit Magic to vastly reduce the possibility of
>>> +     * a collision with random data in memory.
>>> +     */
>>> +    uint64_t             Magic1;
>>> +    uint64_t             Magic2;
>>> +    /*
>>> +     * Header Size
>>> +     * This MUST be the third field of the structure
>>> +     */
>>> +    uint64_t             HeaderSize;
>>> +    /*
>>> +     * Debug log size (minus header)
>>> +     */
>>> +    uint64_t             DebugLogSize;
>>> +    /*
>>> +     * edk2 uses this for locking access.
>>> +     */
>>> +    uint64_t             MemDebugLogLock;
>>> +    /*
>>> +     * Debug log head offset
>>> +     */
>>> +    uint64_t             DebugLogHeadOffset;
>>> +    /*
>>> +     *  Debug log tail offset
>>> +     */
>>> +    uint64_t             DebugLogTailOffset;
>>> +    /*
>>> +     * Flag to indicate if the buffer wrapped and was thus truncated.
>>> +     */
>>> +    uint64_t             Truncated;
>>> +    /*
>>> +     * Firmware Build Version (PcdFirmwareVersionString)
>>> +     */
>>> +    char                 FirmwareVersion[128];

Note for later: FirmwareVersion is an array.

>>> +} MEM_DEBUG_LOG_HDR;

[...]

>>> +static void handle_ovmf_log_range(GString *out,
>>> +                                  dma_addr_t start,
>>> +                                  dma_addr_t end,
>>> +                                  Error **errp)
>>> +{
>>> +    g_autofree char *buf = NULL;
>>> +
>>> +    if (start > end) {
>>> +        return;
>>> +    }
>>> +
>>> +    buf = g_malloc(end - start + 1);
>>
>> How big can this buffer become?  See [*] below.
>>
>>> +    if (dma_memory_read(&address_space_memory, start,
>>> +                        buf, end - start,
>>> +                        MEMTXATTRS_UNSPECIFIED)) {
>>> +        error_setg(errp, "firmware log: buffer read error");
>>> +        return;
>>> +    }
>>> +
>>> +    buf[end - start] = 0;
>>> +    g_string_append_printf(out, "%s", buf);
>>
>> This falls apart when the log contains '\0'.  Suggest something like
>>
>>        g_string_append_len(out, buf, end - start);
>>
>> or even better, the direct read Daniel suggested.
>>
>>> +}
>>> +
>>> +FirmwareLog *qmp_query_firmware_log(Error **errp)
>>> +{
>>> +    MEM_DEBUG_LOG_HDR header;
>>> +    dma_addr_t offset, base;
>>> +    FirmwareLog *ret;
>>> +    g_autoptr(GString) log = g_string_new("");
>>> +
>>> +    offset = find_ovmf_log();
>>> +    if (offset == -1) {
>>> +        error_setg(errp, "firmware log: not found");
>>> +        return NULL;
>>> +    }
>>> +
>>> +    if (dma_memory_read(&address_space_memory, offset,
>>> +                        &header, sizeof(header),
>>> +                        MEMTXATTRS_UNSPECIFIED)) {
>>> +        error_setg(errp, "firmware log: header read error");
>>> +        return NULL;
>>> +    }
>>> +
>>> +    if (header.DebugLogSize > MiB) {
>>> +        /* default size is 128k (32 pages), allow up to 1M */
>>> +        error_setg(errp, "firmware log: log buffer is too big");
>>
>> [*] We limit the buffer to 1MiB.  No objection to the size.
>>
>> What do you mean by "default" in "default size"?  Is the size
>> configurable in EDK2?
>>
>> Should we try to cope more gracefully with oversized log buffers?  It's
>> a ring buffer.  What about silently reading the latest 1MiB then?
>> Behaves just as if the ring buffer was 1MiB.
>>
>>> +        return NULL;
>>> +    }
>>> +
>>> +    if (header.DebugLogHeadOffset > header.DebugLogSize ||
>>> +        header.DebugLogTailOffset > header.DebugLogSize) {
>>> +        error_setg(errp, "firmware log: invalid header");
>>> +        return NULL;
>>> +    }
>>> +
>>> +    base = offset + header.HeaderSize;
>>> +    if (header.DebugLogHeadOffset > header.DebugLogTailOffset) {
>>> +        /* wrap around */
>>> +        handle_ovmf_log_range(log,
>>> +                              base + header.DebugLogHeadOffset,
>>> +                              base + header.DebugLogSize,
>>> +                              errp);
>>> +        if (*errp) {
>>> +            return NULL;
>>> +        }
>>> +        handle_ovmf_log_range(log,
>>> +                              base + 0,
>>> +                              base + header.DebugLogTailOffset,
>>> +                              errp);
>>> +        if (*errp) {
>>> +            return NULL;
>>> +        }
>>> +    } else {
>>> +        handle_ovmf_log_range(log,
>>> +                              base + header.DebugLogHeadOffset,
>>> +                              base + header.DebugLogTailOffset,
>>> +                              errp);
>>> +        if (*errp) {
>>> +            return NULL;
>>> +        }
>>> +    }
>>> +
>>> +    ret = g_new0(FirmwareLog, 1);
>>> +    ret->version = g_strdup(header.FirmwareVersion);

FirmwareVersion is char[128].  g_strdup() copies until the first zero
byte.  I fear a malicious guest can set up its memory to make us
allocate and copy a lot more than 127 bytes.

Please use g_strndup().

>>> +    ret->log = g_base64_encode((const guchar *)log->str, log->len);
>>> +    return ret;
>>
>> Note for later [**]: both ->version and ->log are non-null on success.
>>
>>> +}

[...]


