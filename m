Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD2CD2ED0F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 09:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi8E2-0008Cg-FL; Tue, 20 Jan 2026 04:40:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vi8Du-00088k-E1
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 04:40:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vi8Ds-0007Jk-DV
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 04:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768902025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l7C95vsoYKIXW5DBvUTmBY4ZdYT/uAimm8N6cw4c0xQ=;
 b=A+drGQedYtXHQufvXyhS4Jn1/o8esb3J34RqJPkRePrfWQieMxwGusJmdSh5zbBNUd6Y0H
 B5EHD8z2XoqXa6JIoqkT1NJ9BPzIdOAF/4YlFEWktEP30aYLimAuTBHkD5roAZ59sRLtDe
 JXMj737YYrItTJPopv5SN0ZZB8soZrw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-nxUJb1W4NvSQl_H6l90O2Q-1; Tue, 20 Jan 2026 04:40:23 -0500
X-MC-Unique: nxUJb1W4NvSQl_H6l90O2Q-1
X-Mimecast-MFC-AGG-ID: nxUJb1W4NvSQl_H6l90O2Q_1768902022
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47d3c9b8c56so60360615e9.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 01:40:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768902022; cv=none;
 d=google.com; s=arc-20240605;
 b=cCdtM3jIeoyqzglzKB56mNnfXZFoWHHLQMpVcGJ3xfADMu1r/YlRNij4ojj0+pgct5
 uJQZ3zgqCyQfm7G1UBxn5llZMx4C6ERBN7IYNsme5pwvinpFp8c8ABXQFiHL9ztVCBSp
 v7fWm8x17Bzz78PcEPgWtcDOMgcnO14mTJo3W+zAmQH19/ieh6XU9AXOzW51ZP5jU04m
 7XrjmWWQK4krFGOHXyMzumGdo30LCNRXqholOtA1S6Wg1volpnVe+bVHm/5pM2tYjyG8
 hs00ZTntNCOMwA9tu8Z4HIrdmukVm7K+E0OCyw8IBq+fGSZv+U2AeI9wuZLC2zxQ+Fan
 mHFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=l7C95vsoYKIXW5DBvUTmBY4ZdYT/uAimm8N6cw4c0xQ=;
 fh=SJ3HPovJyRUvRbjEYgfW8f8/HsJC2a+l/HOVRBs3/Wg=;
 b=UGKhOBLmck7Ry3ccT1PT7AmX1DSj/a6iocYpWY1F824ByOPHtfKeDEbTcV13cdJD0t
 ElyS9rAqdg5sZwDDB2zkX82K8R6zNvqnLb9EIjt1fYtv4e99lbfNV5CwPl867eIEz9lq
 e6YlomkryJlGUn5bv8znGG+9IyCgTdZar8XdzQWtSa5H2pETnTf3r4lzZbO8MhpKba3X
 u4NScu6esQELFs1JoBd4y4XLzqWGluDa0gJkaMQhK+awVppq5AFdrKWuJABoAgp0FTuY
 HVdTPoJsduoGWBun+TgfAdLKwYiJlKLH6ZkjYCeC5IpzODyAh6e+7H87hBlFUqEvxES0
 Y1eA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768902022; x=1769506822; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l7C95vsoYKIXW5DBvUTmBY4ZdYT/uAimm8N6cw4c0xQ=;
 b=AV8kyhV6WI0l0mleUtkHjjaggMMb6Z67wCDe+4dr2k9I1fDv5ppMfrAOxBqEPf+G1i
 E8/0Gjk0QYUNJ0DHmBWExyZHBD/6fNpKgRvJ6gOCtAYINtFfq3gsx+71NGpfOE2la6LZ
 r+3G8n5FKOYTNXbDOLNxl56YOOZ8WLJxhJK7rMvQyALEN7uFvt6PX4DASJDHxverZaWZ
 bzZClAtg1QZ/BDtSyp/PNyYDK5BLbdO0q/rTtkZ/gegcBywrMHQTBkUXCrEyEVruvf6F
 79T55Z4A3vYy4IpagQKnzJhmbdb5T8S9GlyIzAZxZqoIDBzf4x3RnTvjZ4SXU4dirNMU
 Nong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768902022; x=1769506822;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l7C95vsoYKIXW5DBvUTmBY4ZdYT/uAimm8N6cw4c0xQ=;
 b=qHXlLmzHKCZBOxhG6WiEYTTl54aHBo+O+vwXpUBATc7av1Twaj06kUs7rNC/Z5kWfD
 0gk1l2lzzm6LwO8Dng8RztZFb5rEf/l+EPLPE51++if+WQ1vR/gsG0GlH17iU+bH9q6d
 2h6Ck/lbopVO1anVh+x0YH8SmkGTd5ME7fA+Gm8LqWE9bTDgvbSWx9nPXrcFNvhCL6x7
 ZweMHzHvLjLt4OT4WFc4pBWBL1SPB0cwU56iuRaRtXBMPni7ZvyieUIIRC0yb6kVxRRs
 Gua8FE19MOXPk+3DHcKjJbYIukyGu0ZC+YAHy5J07Eh7YjLfkhzQHFaeD0Zx3iRA9EbQ
 L3EQ==
X-Gm-Message-State: AOJu0Yz+B9pEe3YzdN9gm+joiKL60zCbr3eo6tF+1O3eZdmop5uoBCYD
 TQDCyqh/kbRUMa1zUvZXAQSVDdYRea6SWwSp5G/tv5lKi/guybSkYMreIRhSVBGC/NcECT9yk7H
 XWRDBe5MPCHyDUotFLzOMnHPZSI+Y0bMruanhl8MQgRS17y5pf3GoFpWw5v3+5pbTp8gUhCg4aZ
 iUPivJ9iYHRogYtCeElm6UAGa60GcETtQ=
X-Gm-Gg: AY/fxX4ZEpnqIMzsecLlRzVkUkJM0LvzY6MfDE/Z4ZQOEyYuY4DPjV1l8Fo+wyf+VkU
 VEUKwZP5EmKDDcmzHXo6agckfOziNGwYDRyCMX+D0n0aS2lCD4CSY1IlOPBcVp52As9RxYVhMr6
 z3N5dutyM22VCDJGJ99kmIOZnlySIPn5ixNDZv9HtoKTJAJLbPraIIW6bLhhDSVen6B0JoxnekP
 dpKuEraKv9hApulO7omafUi1Q7Dz4dysxvSW5P6nVJQ4Iz1JfInbORj
X-Received: by 2002:a05:600c:e41a:b0:46e:4b79:551 with SMTP id
 5b1f17b1804b1-48024b8a77bmr158882525e9.31.1768902022074; 
 Tue, 20 Jan 2026 01:40:22 -0800 (PST)
X-Received: by 2002:a05:600c:e41a:b0:46e:4b79:551 with SMTP id
 5b1f17b1804b1-48024b8a77bmr158882285e9.31.1768902021704; Tue, 20 Jan 2026
 01:40:21 -0800 (PST)
MIME-Version: 1.0
References: <20260109124043.25019-1-farosas@suse.de>
 <20260109124043.25019-20-farosas@suse.de>
In-Reply-To: <20260109124043.25019-20-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 20 Jan 2026 15:10:05 +0530
X-Gm-Features: AZwV_QjZTKjVQS2mhbGOKbnVcL2gEyfBf4FPe45ck5Zr6bcJwRnFEXior4yygEs
Message-ID: <CAE8KmOyj9St4ezR7-51xeaoMWjn4ZJ=HYSZ+Z7Bj3aWKkR-C7w@mail.gmail.com>
Subject: Re: [PATCH v3 19/25] migration: Move transport connection code into
 channel.c
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 9 Jan 2026 at 18:13, Fabiano Rosas <farosas@suse.de> wrote:
> (I sorted the includes)

* Could be expunged.

> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/channel.c   | 66 +++++++++++++++++++++++++++++++++++++++----
>  migration/channel.h   |  4 +++
>  migration/migration.c | 46 ++----------------------------
>  3 files changed, 67 insertions(+), 49 deletions(-)
>
> diff --git a/migration/channel.c b/migration/channel.c
> index f61d30d986..56c80b5cdf 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -12,18 +12,74 @@
>
>  #include "qemu/osdep.h"
>  #include "channel.h"
> -#include "tls.h"
> +#include "exec.h"
> +#include "fd.h"
> +#include "file.h"
> +#include "io/channel-socket.h"
> +#include "io/channel-tls.h"
>  #include "migration.h"
>  #include "multifd.h"
> -#include "savevm.h"
> -#include "trace.h"
>  #include "options.h"
> +#include "qapi/qapi-types-migration.h"
>  #include "qapi/error.h"
> -#include "io/channel-tls.h"
> -#include "io/channel-socket.h"
> +#include "qemu-file.h"
>  #include "qemu/yank.h"
> +#include "rdma.h"
> +#include "savevm.h"
> +#include "socket.h"
> +#include "tls.h"
> +#include "trace.h"
>  #include "yank_functions.h"
>
> +void migration_connect_outgoing(MigrationState *s, MigrationAddress *addr,
> +                                Error **errp)
> +{
> +    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
> +        SocketAddress *saddr = &addr->u.socket;
> +        if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
> +            saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
> +            saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
> +            socket_connect_outgoing(s, saddr, errp);
> +        } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
> +            fd_connect_outgoing(s, saddr->u.fd.str, errp);
> +        }
> +#ifdef CONFIG_RDMA
> +    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
> +        rdma_connect_outgoing(s, &addr->u.rdma, errp);
> +#endif
> +    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
> +        exec_connect_outgoing(s, addr->u.exec.args, errp);
> +    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
> +        file_connect_outgoing(s, &addr->u.file, errp);
> +    } else {
> +        error_setg(errp, "uri is not a valid migration protocol");
> +    }
> +}
> +
> +void migration_connect_incoming(MigrationAddress *addr, Error **errp)
> +{
> +    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
> +        SocketAddress *saddr = &addr->u.socket;
> +        if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
> +            saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
> +            saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
> +            socket_connect_incoming(saddr, errp);
> +        } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
> +            fd_connect_incoming(saddr->u.fd.str, errp);
> +        }
> +#ifdef CONFIG_RDMA
> +    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
> +        rdma_connect_incoming(&addr->u.rdma, errp);
> +#endif
> +    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
> +        exec_connect_incoming(addr->u.exec.args, errp);
> +    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
> +        file_connect_incoming(&addr->u.file, errp);
> +    } else {
> +        error_setg(errp, "unknown migration protocol");
> +    }
> +}
> +
>  bool migration_has_main_and_multifd_channels(void)
>  {
>      MigrationIncomingState *mis = migration_incoming_get_current();
> diff --git a/migration/channel.h b/migration/channel.h
> index 19aa5ab795..8264fe327d 100644
> --- a/migration/channel.h
> +++ b/migration/channel.h
> @@ -17,6 +17,7 @@
>  #define QEMU_MIGRATION_CHANNEL_H
>
>  #include "io/channel.h"
> +#include "qapi/qapi-types-migration.h"
>
>  /* Migration channel types */
>  typedef enum {
> @@ -38,4 +39,7 @@ int migration_channel_read_peek(QIOChannel *ioc,
>  bool migration_has_main_and_multifd_channels(void);
>  bool migration_has_all_channels(void);
>
> +void migration_connect_outgoing(MigrationState *s, MigrationAddress *addr,
> +                                Error **errp);
> +void migration_connect_incoming(MigrationAddress *addr, Error **errp);
>  #endif
> diff --git a/migration/migration.c b/migration/migration.c
> index aa291f1fed..3c93fb23cc 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -20,13 +20,10 @@
>  #include "qemu/main-loop.h"
>  #include "migration/blocker.h"
>  #include "exec.h"
> -#include "fd.h"
>  #include "file.h"
> -#include "socket.h"
>  #include "system/runstate.h"
>  #include "system/system.h"
>  #include "system/cpu-throttle.h"
> -#include "rdma.h"
>  #include "ram.h"
>  #include "migration/cpr.h"
>  #include "migration/global_state.h"
> @@ -783,26 +780,7 @@ static void qemu_setup_incoming_migration(const char *uri, bool has_channels,
>          return;
>      }
>
> -    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
> -        SocketAddress *saddr = &addr->u.socket;
> -        if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
> -            saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
> -            saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
> -            socket_connect_incoming(saddr, errp);
> -        } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
> -            fd_connect_incoming(saddr->u.fd.str, errp);
> -        }
> -#ifdef CONFIG_RDMA
> -    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
> -        rdma_connect_incoming(&addr->u.rdma, errp);
> -#endif
> -    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
> -        exec_connect_incoming(addr->u.exec.args, errp);
> -    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
> -        file_connect_incoming(&addr->u.file, errp);
> -    } else {
> -        error_setg(errp, "unknown migration protocol: %s", uri);
> -    }
> +    migration_connect_incoming(addr, errp);
>
>      /* Close cpr socket to tell source that we are listening */
>      cpr_state_close();
> @@ -2234,31 +2212,11 @@ static void qmp_migrate_finish(MigrationAddress *addr, Error **errp)
>      MigrationState *s = migrate_get_current();
>      Error *local_err = NULL;
>
> -    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
> -        SocketAddress *saddr = &addr->u.socket;
> -        if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
> -            saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
> -            saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
> -            socket_connect_outgoing(s, saddr, &local_err);
> -        } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
> -            fd_connect_outgoing(s, saddr->u.fd.str, &local_err);
> -        }
> -#ifdef CONFIG_RDMA
> -    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
> -        rdma_connect_outgoing(s, &addr->u.rdma, &local_err);
> -#endif
> -    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
> -        exec_connect_outgoing(s, addr->u.exec.args, &local_err);
> -    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
> -        file_connect_outgoing(s, &addr->u.file, &local_err);
> -    } else {
> -        error_setg(&local_err, "uri is not a valid migration protocol");
> -    }
> +    migration_connect_outgoing(s, addr, &local_err);
>
>      if (local_err) {
>          migration_connect_error_propagate(s, error_copy(local_err));
>          error_propagate(errp, local_err);
> -        return;
>      }
>  }
>
> --

* Looks okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


