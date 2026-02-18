Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A013E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 14:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsiAh-000711-PS; Wed, 18 Feb 2026 09:04:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsiAN-0006zb-KW
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 09:04:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsiAL-0007cT-TN
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 09:04:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771423471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3FLojfTLE4eLm/XXjE3D7lXFlW7GaXopO/nuhESGVJg=;
 b=Vg8zisJ3cZF7Y+y5mTpgzBpiOqdCe7WoQs/3/aVjRsVAplVz40kM/jv9W1pD39nk8DYUYF
 SnMeWQKDeIsLRuPYR8vPO68iOCrVmkMLPkmhodVnydC20KXYIhy2vXC8xwi5dEYpUA5X+c
 Ark7KOYg/B73M9tcMq/PqW17WFau2Wk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-YXjKa5LFN8i2DxQauVFtYw-1; Wed,
 18 Feb 2026 09:04:28 -0500
X-MC-Unique: YXjKa5LFN8i2DxQauVFtYw-1
X-Mimecast-MFC-AGG-ID: YXjKa5LFN8i2DxQauVFtYw_1771423467
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4FD21800342; Wed, 18 Feb 2026 14:04:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 206611800370; Wed, 18 Feb 2026 14:04:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B927721E692D; Wed, 18 Feb 2026 15:04:23 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Stefan Weil <sw@weilnetz.de>,  "Dr.
 David Alan Gilbert" <dave@treblig.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  devel@lists.libvirt.org,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Kevin
 Wolf <kwolf@redhat.com>,  qemu-block@nongnu.org,  qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH v6 22/27] util: introduce common helper for error-report
 & log code
In-Reply-To: <20260211152508.732487-23-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 11 Feb 2026 15:25:03
 +0000")
References: <20260211152508.732487-1-berrange@redhat.com>
 <20260211152508.732487-23-berrange@redhat.com>
Date: Wed, 18 Feb 2026 15:04:23 +0100
Message-ID: <87342yb120.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.754, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The error-report and log code both have a need to add prefixes
> to messages they are printing, with the current example being
> a timestamp.
>
> The format and configuration they use should be consistent, so
> providing a common helper will ensure this is always the case.
> Initially the helper only emits a timestamp, but future patches
> will expand this.
>
> This takes the liberty of assigning the new file to the same
> maintainer as the existing error-report.c file, given it will
> be extracting some functionality from the latter.

Fair.

> While vreport() dynamically changes between reporting to the
> monitor vs stderr, depending on whether HMP is active or not,
> message prefixes are only ever used in the non-HMP case. Thus
> the helper API can take a FILE * object and not have to deal
> with the monitor at all.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  MAINTAINERS            |  2 ++
>  include/qemu/message.h | 28 ++++++++++++++++++++++++++++
>  util/meson.build       |  1 +
>  util/message.c         | 23 +++++++++++++++++++++++
>  4 files changed, 54 insertions(+)
>  create mode 100644 include/qemu/message.h
>  create mode 100644 util/message.c

No uses, yet.  Commit message could mention it's put to use in the next
few commits.

>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 29f88d48f3..96a4ce438e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3261,9 +3261,11 @@ M: Markus Armbruster <armbru@redhat.com>
>  S: Supported
>  F: include/qapi/error.h
>  F: include/qemu/error-report.h
> +F: include/qemu/message.h
>  F: qapi/error.json
>  F: util/error.c
>  F: util/error-report.c
> +F: util/message.c
>  F: scripts/coccinelle/err-bad-newline.cocci
>  F: scripts/coccinelle/error-use-after-free.cocci
>  F: scripts/coccinelle/error_propagate_null.cocci
> diff --git a/include/qemu/message.h b/include/qemu/message.h
> new file mode 100644
> index 0000000000..0a06421f77
> --- /dev/null
> +++ b/include/qemu/message.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef QEMU_MESSAGE_H
> +#define QEMU_MESSAGE_H
> +
> +enum QMessageFormatFlags {
> +    QMESSAGE_FORMAT_TIMESTAMP =3D (1 << 0),
> +};
> +
> +/**
> + * qmessage_set_format:
> + * @flags: the message information to emit
> + *
> + * Select which pieces of information to
> + * emit for messages
> + */
> +void qmessage_set_format(int flags);
> +
> +/**
> + * qmessage_context_print:
> + * @fp: file to emit the prefix on
> + *
> + * Emit a message prefix with the information selected by
> + * an earlier call to qmessage_set_format.
> + */
> +void qmessage_context_print(FILE *fp);
> +
> +#endif /* QEMU_MESSAGE_H */
> diff --git a/util/meson.build b/util/meson.build
> index 7c9445615d..3035bd4bee 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -38,6 +38,7 @@ util_ss.add(files('host-utils.c'))
>  util_ss.add(files('bitmap.c', 'bitops.c'))
>  util_ss.add(files('fifo8.c'))
>  util_ss.add(files('cacheflush.c'))
> +util_ss.add(files('message.c'))
>  util_ss.add(files('error.c', 'error-report.c'))
>  util_ss.add(files('qemu-print.c'))
>  util_ss.add(files('id.c'))
> diff --git a/util/message.c b/util/message.c
> new file mode 100644
> index 0000000000..99a403f9d0
> --- /dev/null
> +++ b/util/message.c
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include "qemu/osdep.h"
> +
> +#include "qemu/message.h"
> +#include "monitor/monitor.h"

Superfluous #include.

It'll become used in PATCH 26, for qemu_thread_get_name().  Should
include qemu/thread.h there instead.

> +
> +static int message_format;
> +
> +void qmessage_set_format(int flags)
> +{
> +    message_format =3D flags;
> +}
> +
> +void qmessage_context_print(FILE *fp)
> +{
> +    if (message_format & QMESSAGE_FORMAT_TIMESTAMP) {
> +        g_autoptr(GDateTime) dt =3D g_date_time_new_now_utc();
> +        g_autofree char *timestr =3D g_date_time_format_iso8601(dt);
> +        fputs(timestr, fp);
> +        fputc(' ', fp);

The context string is either empty, or it ends with a space, for ease of
use.  Okay.

I'd go for

           fprintf(fp, "%s ", timestr);

> +    }
> +}

Alright, everybody's favorite topic: naming.

message.[ch] aren't about messages, but message *prefixes*.  You call
them "context" in qmessage_context_print().  I'm fine with "context".

External symbols are prefixed with qmessage_.  I prefer such prefixes to
match the filename.

Prefix in util/ overwhelmingly start with qemu_.

Somewhat long prefixes feel okay here, as these symbols are used only a
couple of times.  qemu_message_context_ might be too long, though.

Could use the classic technique of murdering vowels: to qemu_msg_ctxt_.

Thoughts?


