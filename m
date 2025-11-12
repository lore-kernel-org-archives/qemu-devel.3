Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79587CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 09:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ6iO-0006wL-Kj; Wed, 12 Nov 2025 04:00:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vJ6hy-0006pp-GN
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 04:00:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vJ6hu-0004p2-CX
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 04:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762937995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XvjNZzXQZJcAJcVbCJnBYjpYL1HMhEu9sk+EC8shCPI=;
 b=Gl8eFn/ol+VMq3AN6/OU3w/tMX9uRdEFtvKFiprhEq6rQV5voaiCRiCMtxGAFkwqVxiSvI
 i2So7mzWnH6E0XiWZbU1ndKjqBqYxwOE0Hnp5Uoa8jahx6U15wlw9aRUR3ZSPqJS9hinXe
 S0uge3bnX/oBtgOPfXxgq+Wi9+02xso=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-vahaQn9dOOKiO1phEqoavQ-1; Wed,
 12 Nov 2025 03:59:53 -0500
X-MC-Unique: vahaQn9dOOKiO1phEqoavQ-1
X-Mimecast-MFC-AGG-ID: vahaQn9dOOKiO1phEqoavQ_1762937992
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E11431800650; Wed, 12 Nov 2025 08:59:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 377A01800900; Wed, 12 Nov 2025 08:59:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3CBAE21E6A27; Wed, 12 Nov 2025 09:59:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jie Song <mail@jiesong.me>
Cc: qemu-devel@nongnu.org,  armbru@redhat.com,  Jie Song
 <songjie_yewu@cmss.chinamobile.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH] monitor/qmp: cleanup socket listener sources early to
 avoid fd handling race
In-Reply-To: <20251111150144.76751-1-mail@jiesong.me> (Jie Song's message of
 "Tue, 11 Nov 2025 23:01:44 +0800")
References: <20251111150144.76751-1-mail@jiesong.me>
Date: Wed, 12 Nov 2025 09:59:47 +0100
Message-ID: <87a50r8w3g.fsf@pond.sub.org>
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

Daniel, is this in your area of expertise?

Jie Song, can you identify the commit that introduced the bug?

Jie Song <mail@jiesong.me> writes:

> From: Jie Song <songjie_yewu@cmss.chinamobile.com>
>
> When starting a dummy QEMU process with virsh, monitor_init_qmp() enables
> IOThread monitoring of the QMP fd by default. However, a race condition
> exists during the initialization phase: the IOThread only removes the
> main thread's fd watch when it reaches qio_net_listener_set_client_func_full(),
> which may be delayed under high system load.
>
> This creates a window between monitor_qmp_setup_handlers_bh() and
> qio_net_listener_set_client_func_full() where both the main thread and
> IOThread are simultaneously monitoring the same fd and processing events.
> This race can cause either the main thread or the IOThread to hang and
> become unresponsive.
>
> Fix this by proactively cleaning up the listener's IO sources in
> monitor_init_qmp() before the IOThread initializes QMP monitoring,
> ensuring exclusive fd ownership and eliminating the race condition.
>
> The fix introduces socket_chr_listener_cleanup() to destroy and unref
> all existing IO sources on the socket chardev listener, guaranteeing
> that no concurrent fd monitoring occurs during the transition to
> IOThread handling.
>
> Signed-off-by: Jie Song <songjie_yewu@cmss.chinamobile.com>
> ---
>  chardev/char-socket.c         | 18 ++++++++++++++++++
>  include/chardev/char-socket.h |  2 ++
>  monitor/qmp.c                 |  6 ++++++
>  3 files changed, 26 insertions(+)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 62852e3caf..073a9da855 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -656,6 +656,24 @@ static void tcp_chr_telnet_destroy(SocketChardev *s)
>      }
>  }
>  
> +void socket_chr_listener_cleanup(Chardev *chr)
> +{
> +    SocketChardev *s = SOCKET_CHARDEV(chr);
> +
> +    if (s->listener) {
> +        QIONetListener *listener = s->listener;
> +        size_t i;
> +
> +        for (i = 0; i < listener->nsioc; i++) {
> +            if (listener->io_source[i]) {
> +                g_source_destroy(listener->io_source[i]);
> +                g_source_unref(listener->io_source[i]);
> +                listener->io_source[i] = NULL;
> +            }
> +        }
> +    }
> +}
> +
>  static void tcp_chr_update_read_handler(Chardev *chr)
>  {
>      SocketChardev *s = SOCKET_CHARDEV(chr);
> diff --git a/include/chardev/char-socket.h b/include/chardev/char-socket.h
> index d6d13ad37f..682440c6de 100644
> --- a/include/chardev/char-socket.h
> +++ b/include/chardev/char-socket.h
> @@ -84,4 +84,6 @@ typedef struct SocketChardev SocketChardev;
>  DECLARE_INSTANCE_CHECKER(SocketChardev, SOCKET_CHARDEV,
>                           TYPE_CHARDEV_SOCKET)
>  
> +void socket_chr_listener_cleanup(Chardev *chr);
> +
>  #endif /* CHAR_SOCKET_H */
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index cb99a12d94..d9d1fafa70 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -25,6 +25,7 @@
>  #include "qemu/osdep.h"
>  
>  #include "chardev/char-io.h"
> +#include "chardev/char-socket.h"
>  #include "monitor-internal.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-control.h"
> @@ -537,6 +538,11 @@ void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
>           * e.g. the chardev is in client mode, with wait=on.
>           */
>          remove_fd_in_watch(chr);
> +        /*
> +         * Clean up listener IO sources early to prevent racy fd
> +         * handling between the main thread and the I/O thread.
> +         */
> +        socket_chr_listener_cleanup(chr);
>          /*
>           * We can't call qemu_chr_fe_set_handlers() directly here
>           * since chardev might be running in the monitor I/O


