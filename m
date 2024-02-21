Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51416C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoVu-0004cz-A5; Wed, 21 Feb 2024 10:28:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcoNP-0006oZ-FT
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:19:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcmfP-00080g-8F
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 08:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708522182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cCF9B/dPNar/dBTlgTXTODVGMSwxWMVrxZJM9zNu/VM=;
 b=d34ybzQtDTvANxrIVevndKhrSU+VnAj0kPWEpDPx9BDeWFEyRJQWwrKOgd9VvTjlywZg+6
 2bkf1BJf6ws7mvQMU+wQnCwiSn1ox2AP/bVCJumB+1o4vgjFXDY5QPBZcZ8zAo18xrqvNK
 wjL7GovCmKY/wcdleT3v4YGjz6kQWbc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-V37vrGBAMaulVVrmvzJakg-1; Wed, 21 Feb 2024 08:29:38 -0500
X-MC-Unique: V37vrGBAMaulVVrmvzJakg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A51FA859704;
 Wed, 21 Feb 2024 13:29:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 629FE492BD7;
 Wed, 21 Feb 2024 13:29:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4355C21E6740; Wed, 21 Feb 2024 14:29:35 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Peter Xu
 <peterx@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  =?utf-8?Q?Marc-An?=
 =?utf-8?Q?dr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH V4 1/5] util: strList_from_string
In-Reply-To: <1705099758-211963-2-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Fri, 12 Jan 2024 14:49:14 -0800")
References: <1705099758-211963-1-git-send-email-steven.sistare@oracle.com>
 <1705099758-211963-2-git-send-email-steven.sistare@oracle.com>
Date: Wed, 21 Feb 2024 14:29:35 +0100
Message-ID: <875xyi3pz4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

I apologize for the lateness of my review.

Steve Sistare <steven.sistare@oracle.com> writes:

> Generalize hmp_split_at_comma() to take any delimiter string, rename
> as strList_from_string(), and move it to util/strList.c.
>
> No functional change.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

I can't see an actual use of generalized delimiters outside tests in
this series.  Do you have uses?

> ---
>  include/monitor/hmp.h  |  1 -
>  include/qemu/strList.h | 24 ++++++++++++++++++++++++
>  monitor/hmp-cmds.c     | 19 -------------------
>  net/net-hmp-cmds.c     |  3 ++-
>  stats/stats-hmp-cmds.c |  3 ++-
>  util/meson.build       |  1 +
>  util/strList.c         | 24 ++++++++++++++++++++++++
>  7 files changed, 53 insertions(+), 22 deletions(-)
>  create mode 100644 include/qemu/strList.h
>  create mode 100644 util/strList.c
>
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index 13f9a2d..2df661e 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -19,7 +19,6 @@
>  
>  bool hmp_handle_error(Monitor *mon, Error *err);
>  void hmp_help_cmd(Monitor *mon, const char *name);
> -strList *hmp_split_at_comma(const char *str);
>  
>  void hmp_info_name(Monitor *mon, const QDict *qdict);
>  void hmp_info_version(Monitor *mon, const QDict *qdict);
> diff --git a/include/qemu/strList.h b/include/qemu/strList.h
> new file mode 100644
> index 0000000..010237f
> --- /dev/null
> +++ b/include/qemu/strList.h
> @@ -0,0 +1,24 @@
> +/*
> + * Copyright (c) 2022 - 2024 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef QEMU_STR_LIST_H
> +#define QEMU_STR_LIST_H
> +
> +#include "qapi/qapi-builtin-types.h"
> +
> +/*
> + * Break @in into a strList using the delimiter string @delim.
> + * The delimiter is not included in the result.
> + * Return NULL if @in is NULL or an empty string.
> + * A leading, trailing, or consecutive delimiter produces an
> + * empty string at that position in the output.
> + * All strings are g_strdup'd, and the result can be freed
> + * using qapi_free_strList.
> + */
> +strList *strList_from_string(const char *in, const char *delim);

The function name no longer tells us explicitly what the function does:
splitting the string.

`> +
> +#endif
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 871898a..66b68a0 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -38,25 +38,6 @@ bool hmp_handle_error(Monitor *mon, Error *err)
>      return false;
>  }
>  
> -/*
> - * Split @str at comma.
> - * A null @str defaults to "".
> - */
> -strList *hmp_split_at_comma(const char *str)
> -{
> -    char **split = g_strsplit(str ?: "", ",", -1);
> -    strList *res = NULL;
> -    strList **tail = &res;
> -    int i;
> -
> -    for (i = 0; split[i]; i++) {
> -        QAPI_LIST_APPEND(tail, split[i]);
> -    }
> -
> -    g_free(split);
> -    return res;
> -}
> -
>  void hmp_info_name(Monitor *mon, const QDict *qdict)
>  {
>      NameInfo *info;
> diff --git a/net/net-hmp-cmds.c b/net/net-hmp-cmds.c
> index 41d326b..e893801 100644
> --- a/net/net-hmp-cmds.c
> +++ b/net/net-hmp-cmds.c
> @@ -26,6 +26,7 @@
>  #include "qemu/config-file.h"
>  #include "qemu/help_option.h"
>  #include "qemu/option.h"
> +#include "qemu/strList.h"
>  
>  void hmp_info_network(Monitor *mon, const QDict *qdict)
>  {
> @@ -72,7 +73,7 @@ void hmp_announce_self(Monitor *mon, const QDict *qdict)
>                                              migrate_announce_params());
>  
>      qapi_free_strList(params->interfaces);
> -    params->interfaces = hmp_split_at_comma(interfaces_str);
> +    params->interfaces = strList_from_string(interfaces_str, ",");
>      params->has_interfaces = params->interfaces != NULL;
>      params->id = g_strdup(id);
>      qmp_announce_self(params, NULL);
> diff --git a/stats/stats-hmp-cmds.c b/stats/stats-hmp-cmds.c
> index 1f91bf8..428c0e6 100644
> --- a/stats/stats-hmp-cmds.c
> +++ b/stats/stats-hmp-cmds.c
> @@ -10,6 +10,7 @@
>  #include "monitor/hmp.h"
>  #include "monitor/monitor.h"
>  #include "qemu/cutils.h"
> +#include "qemu/strList.h"
>  #include "hw/core/cpu.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/error.h"
> @@ -176,7 +177,7 @@ static StatsFilter *stats_filter(StatsTarget target, const char *names,
>              request->provider = provider_idx;
>              if (names && !g_str_equal(names, "*")) {
>                  request->has_names = true;
> -                request->names = hmp_split_at_comma(names);
> +                request->names = strList_from_string(names, ",");
>              }
>              QAPI_LIST_PREPEND(request_list, request);
>          }
> diff --git a/util/meson.build b/util/meson.build
> index af3bf56..e1d1e1f 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -1,4 +1,5 @@
>  util_ss.add(files('osdep.c', 'cutils.c', 'unicode.c', 'qemu-timer-common.c'))
> +util_ss.add(files('strList.c'))
>  util_ss.add(files('thread-context.c'), numa)
>  if not config_host_data.get('CONFIG_ATOMIC64')
>    util_ss.add(files('atomic64.c'))
> diff --git a/util/strList.c b/util/strList.c
> new file mode 100644
> index 0000000..7991de3
> --- /dev/null
> +++ b/util/strList.c
> @@ -0,0 +1,24 @@
> +/*
> + * Copyright (c) 2023 Red Hat, Inc.
> + * Copyright (c) 2022 - 2024 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/strList.h"
> +
> +strList *strList_from_string(const char *str, const char *delim)
> +{
> +    g_autofree char **split = g_strsplit(str ?: "", delim, -1);
> +    strList *res = NULL;
> +    strList **tail = &res;
> +    int i;
> +
> +    for (i = 0; split[i]; i++) {
> +        QAPI_LIST_APPEND(tail, split[i]);
> +    }
> +
> +    return res;
> +}


