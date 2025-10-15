Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA03CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 14:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v92h3-0000Yp-PQ; Wed, 15 Oct 2025 10:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v92go-0000Nz-S0
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:41:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v92gf-0006Js-Dz
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760539265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R1MLAN7CR8OZ9XZGygHRbL8NAIs9pi1ZShZl/FkeZOs=;
 b=OskIw6A7hEHUx4Jg6/UBCbvKIrEOeBMRLThq9d2HJM6ofVTRNyHKzq8fVuubaly8ek7s7l
 BbPATXKUDHuYfO5ojOo7ZOQZVAU08XedMUx6Ip6Hhszu1i6KDmElUtfWUsRg8YQtefiJ5T
 2WU/X64tTPrkUcIlOyYtiO23rEGZlV8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-WiZZrmeHPP-8aixi4OjAKg-1; Wed,
 15 Oct 2025 10:41:01 -0400
X-MC-Unique: WiZZrmeHPP-8aixi4OjAKg-1
X-Mimecast-MFC-AGG-ID: WiZZrmeHPP-8aixi4OjAKg_1760539260
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE7C019560BB; Wed, 15 Oct 2025 14:40:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D85FA30001A1; Wed, 15 Oct 2025 14:40:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7209921E6A27; Wed, 15 Oct 2025 16:40:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org,  Yanan Wang <wangyanan55@huawei.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,  Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v5 3/3] hw/uefi/ovmf-log: add maxsize parameter
In-Reply-To: <20251015120637.1736402-4-kraxel@redhat.com> (Gerd Hoffmann's
 message of "Wed, 15 Oct 2025 14:06:37 +0200")
References: <20251015120637.1736402-1-kraxel@redhat.com>
 <20251015120637.1736402-4-kraxel@redhat.com>
Date: Wed, 15 Oct 2025 16:40:56 +0200
Message-ID: <87wm4w9qiv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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
>  hw/uefi/ovmf-log.c   | 42 ++++++++++++++++++++++++++++++++++--------
>  hmp-commands-info.hx |  4 ++--
>  qapi/machine.json    |  5 +++++
>  3 files changed, 41 insertions(+), 10 deletions(-)
>
> diff --git a/hw/uefi/ovmf-log.c b/hw/uefi/ovmf-log.c
> index e281a980a101..28788620e3f6 100644
> --- a/hw/uefi/ovmf-log.c
> +++ b/hw/uefi/ovmf-log.c
> @@ -18,6 +18,7 @@
>  #include "qapi/error.h"
>  #include "qapi/type-helpers.h"
>  #include "qapi/qapi-commands-machine.h"
> +#include "qobject/qdict.h"
>  
>  
>  /* ----------------------------------------------------------------------- */
> @@ -164,7 +165,8 @@ static void handle_ovmf_log_range(GString *out,
>      }
>  }
>  
> -FirmwareLog *qmp_query_firmware_log(Error **errp)
> +FirmwareLog *qmp_query_firmware_log(bool have_max_size, uint64_t max_size,
> +                                    Error **errp)
>  {
>      MEM_DEBUG_LOG_HDR header;
>      dma_addr_t offset, base;
> @@ -184,18 +186,40 @@ FirmwareLog *qmp_query_firmware_log(Error **errp)
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
> +    if (have_max_size) {
> +        if (max_size > MiB) {
> +            error_setg(errp, "firmware log: max-size larger than 1 MiB");

"parameter 'max-size' exceeds 1MiB" or similar.

> +            return NULL;
> +        }
> +    } else {
> +        max_size = MiB;
> +    }
> +
> +    /* adjust header.DebugLogHeadOffset so we return at most maxsize bytes */
> +    if (header.DebugLogHeadOffset > header.DebugLogTailOffset) {
> +        /* wrap around */
> +        if (header.DebugLogTailOffset > max_size) {
> +            header.DebugLogHeadOffset = header.DebugLogTailOffset - max_size;
> +        } else {
> +            uint64_t max_chunk = max_size - header.DebugLogTailOffset;
> +            if (header.DebugLogSize > max_chunk &&
> +                header.DebugLogHeadOffset < header.DebugLogSize - max_chunk) {
> +                header.DebugLogHeadOffset = header.DebugLogSize - max_chunk;
> +            }
> +        }
> +    } else {
> +        if (header.DebugLogTailOffset > max_size &&
> +            header.DebugLogHeadOffset < header.DebugLogTailOffset - max_size) {
> +            header.DebugLogHeadOffset = header.DebugLogTailOffset - max_size;
> +        }
> +    }

Didn't review this part; my brain's fried for today :)

> +
>      base = offset + header.HeaderSize;
>      if (header.DebugLogHeadOffset > header.DebugLogTailOffset) {
>          /* wrap around */
> @@ -239,8 +263,10 @@ void hmp_info_firmware_log(Monitor *mon, const QDict *qdict)
>      Error *err = NULL;
>      FirmwareLog *log;
>      gsize log_len;
> +    int64_t maxsize;
>  
> -    log = qmp_query_firmware_log(&err);
> +    maxsize = qdict_get_try_int(qdict, "maxsize", -1);
> +    log = qmp_query_firmware_log(maxsize != -1, (uint64_t)maxsize, &err);
>      if (err)  {
>          hmp_handle_error(mon, err);
>          return;
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index f0aef419923c..f00d7081b40c 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -993,8 +993,8 @@ ERST
>  
>      {
>          .name       = "firmware-log",
> -        .args_type  = "",
> -        .params     = "",
> +        .args_type  = "maxsize:o?",
> +        .params     = "[maxsize]",
>          .help       = "show the firmware (ovmf) debug log",
>          .cmd        = hmp_info_firmware_log,
>      },

Might want to spell it max-size for consistency with QMP.  Up to you.

> diff --git a/qapi/machine.json b/qapi/machine.json
> index 96133e5c71cf..e4b15680c172 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1858,9 +1858,14 @@
>  #
>  # Find firmware memory log buffer in guest memory, return content.
>  #
> +# @max-size: limit the amount of log data returned.  Up to 1 MiB if
> +#            log data is allowed.  In case the amout of log data is

What are you trying to convey by "if log data is allowed"?

s/amout/amount/

> +#            larger than max-size the tail of the log is returned.

Please use @max-size here for nicer rendering.

> +#
>  # Since: 10.2
>  ##
>  { 'command': 'query-firmware-log',
> +  'data': { '*max-size': 'size' },
>    'returns': 'FirmwareLog' }
>  
>  ##


