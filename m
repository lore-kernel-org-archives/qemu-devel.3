Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8922CCCD18D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 12:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8eRv-0003ws-Vm; Tue, 14 Oct 2025 08:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v8eRs-0003wQ-Bx
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 08:48:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v8eRp-0003P2-Cq
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 08:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760446089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xhqgTfGP0cVEhW05IGKRboAdE53UtYSEmqf2h6z1Cog=;
 b=YFk8RfUIbK9Ebjjy4lgHxsDk5vw/MyNUhJt6ls02OQ5EpA1htj2In7JLU/Dh4I5LMiq42/
 t3pvqXvrLRiT9Z7phW2rZM5pyhaP5lwNdXNlK8QXzgaa4EmAlnJWT+VOVTyfBzD6rXPw7c
 kDb/fx7fCC6wy38pYf97QSgzpn4Tahc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-cb5OjNxiNbq9L8gGyn3pHA-1; Tue,
 14 Oct 2025 08:48:07 -0400
X-MC-Unique: cb5OjNxiNbq9L8gGyn3pHA-1
X-Mimecast-MFC-AGG-ID: cb5OjNxiNbq9L8gGyn3pHA_1760446086
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 876991956096; Tue, 14 Oct 2025 12:48:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 734B11800446; Tue, 14 Oct 2025 12:48:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0375E21E6A27; Tue, 14 Oct 2025 14:48:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Yanan Wang
 <wangyanan55@huawei.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Eric Blake <eblake@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  "Dr. David Alan Gilbert" <dave@treblig.org>,
 Laurent Vivier <lvivier@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v4 2/2] hw/uefi/ovmf-log: add maxsize parameter
In-Reply-To: <20251013104954.250166-3-kraxel@redhat.com> (Gerd Hoffmann's
 message of "Mon, 13 Oct 2025 12:49:54 +0200")
References: <20251013104954.250166-1-kraxel@redhat.com>
 <20251013104954.250166-3-kraxel@redhat.com>
Date: Tue, 14 Oct 2025 14:48:01 +0200
Message-ID: <874is1odj2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Gerd Hoffmann <kraxel@redhat.com> writes:

> Allow limiting the amount of log output sent.  Allow up to 1 MiB.
> In case the guest log buffer is larger than 1 MiB limit the output
> instead of throwing an error.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/uefi/ovmf-log.c   | 40 ++++++++++++++++++++++++++++++++--------
>  hmp-commands-info.hx |  5 ++---
>  qapi/machine.json    |  3 +++
>  3 files changed, 37 insertions(+), 11 deletions(-)
>
> diff --git a/hw/uefi/ovmf-log.c b/hw/uefi/ovmf-log.c
> index f03e47a290d6..9d9dc7b0d8d5 100644
> --- a/hw/uefi/ovmf-log.c
> +++ b/hw/uefi/ovmf-log.c
> @@ -19,6 +19,7 @@
>  #include "qapi/error.h"
>  #include "qapi/type-helpers.h"
>  #include "qapi/qapi-commands-machine.h"
> +#include "qobject/qdict.h"
>  
>  
>  /* ----------------------------------------------------------------------- */
> @@ -167,7 +168,8 @@ static void handle_ovmf_log_range(GString *out,
>      }
>  }
>  
> -FirmwareLog *qmp_query_firmware_log(Error **errp)
> +FirmwareLog *qmp_query_firmware_log(bool have_maxsize, uint64_t maxsize,
> +                                    Error **errp)
>  {
>      MEM_DEBUG_LOG_HDR header;
>      dma_addr_t offset, base;
> @@ -187,18 +189,38 @@ FirmwareLog *qmp_query_firmware_log(Error **errp)
>          return NULL;
>      }
>  
> -    if (header.DebugLogSize > MiB) {
> -        /* default size is 128k (32 pages), allow up to 1M */
> -        error_setg(errp, "firmware log: log buffer is too big");
> -        return NULL;
> -    }
> -
>      if (header.DebugLogHeadOffset > header.DebugLogSize ||
>          header.DebugLogTailOffset > header.DebugLogSize) {
>          error_setg(errp, "firmware log: invalid header");
>          return NULL;
>      }
>  
> +    if (!have_maxsize) {
> +        maxsize = MiB;
> +    }
> +    if (maxsize > MiB) {
> +        maxsize = MiB;

Silently "fixing" the user's instructions is rarely a good idea.  Either
don't limit the argument (if the user asks for rope...), or make
exceeding the limit an error.

> +    }
> +
> +    /* adjust header.DebugLogHeadOffset so we rezturn at most maxsize bytes */
> +    if (header.DebugLogHeadOffset > header.DebugLogTailOffset) {
> +        /* wrap around */
> +        if (header.DebugLogTailOffset > maxsize) {
> +            header.DebugLogHeadOffset = header.DebugLogTailOffset - maxsize;
> +        } else {
> +            uint64_t maxchunk = maxsize - header.DebugLogTailOffset;
> +            if (header.DebugLogSize > maxchunk &&
> +                header.DebugLogHeadOffset < header.DebugLogSize - maxchunk) {
> +                header.DebugLogHeadOffset = header.DebugLogSize - maxchunk;
> +            }
> +        }
> +    } else {
> +        if (header.DebugLogTailOffset > maxsize &&
> +            header.DebugLogHeadOffset < header.DebugLogTailOffset - maxsize) {
> +            header.DebugLogHeadOffset = header.DebugLogTailOffset - maxsize;
> +        }
> +    }
> +
>      base = offset + header.HeaderSize;
>      if (header.DebugLogHeadOffset > header.DebugLogTailOffset) {
>          /* wrap around */
> @@ -237,8 +259,10 @@ void hmp_info_firmware_log(Monitor *mon, const QDict *qdict)
>  {
>      Error *errp = NULL;
>      FirmwareLog *log;
> +    int64_t maxsize;
>  
> -    log = qmp_query_firmware_log(&errp);
> +    maxsize = qdict_get_try_int(qdict, "maxsize", -1);
> +    log = qmp_query_firmware_log(maxsize != -1, (uint64_t)maxsize, &errp);

Put a pin here.

>      if (errp)  {
>          hmp_handle_error(mon, errp);
>          return;
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 257015f0b403..db03d88d3c74 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -980,11 +980,10 @@ ERST
>  
>      {
>          .name       = "firmware-log",
> -        .args_type  = "",
> -        .params     = "",
> +        .args_type  = "maxsize:i?",

args_type 'i' is a 32 bit signed integer, so this gives us 31 bits.
Suffices.  But what happens when the user specifies a negative number?
I think hmp_info_firmware_log() treats -1 as if the parameter was
omitted.  qmp_query_firmware_log() then defaults to 1MiB.  Any other
negative number hmp_info_firmware_log() turns into a huge positive
number, which qmp_query_firmware_log() silently limits to 1MiB (but I
recommended not to do that).

Let's use 'o' instead of 'i'.  Enables convenient syntax like "64k".  63
bits.  No risk of sign accidents.

> +        .params     = "[maxsize]",
>          .help       = "show the firmware (ovmf) debug log",
>          .cmd        = hmp_info_firmware_log,
> -        .flags      = "p",

Accident?

>      },
>  
>  SRST
> diff --git a/qapi/machine.json b/qapi/machine.json
> index c96e582afdd6..d0c6d3ede027 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1857,9 +1857,12 @@
>  #
>  # Find firmware memory log buffer in guest memory, return content.
>  #
> +# @maxsize: limit the amount of logdata returned.

Please spell it @max-size.  We already use that spelling in this file.

"logdata" isn't a word.

The 1MiB limit for @maxsize needs to be documented (if we keep it).

Recommend to spell out that the command returns the tail of the log
buffer when it can't return all of it.

> +#
>  # Since: 10.2
>  ##
>  { 'command': 'query-firmware-log',
> +  'data': { '*maxsize': 'size' },
>    'returns': 'FirmwareLog' }
>  
>  ##


