Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9923D41178
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 12:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgMH1-0006p3-Pk; Thu, 15 Jan 2026 07:16:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vgMGx-0006kn-Sm
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 07:16:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vgMGw-0002T3-D8
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 07:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768479376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=04i1qoxuBWUTacm8XX2Dz9EjxJfdYOOT4B2PC1aJaeU=;
 b=MRhdgw7YVtdgxkUIvJtc1Qlg2Q/5fudeowRfU/Q9L3b68dij5enMyG2LjmoSq05lKR44Xt
 F1fLVIpC7StTDtYssxE04HM5jTBSDUCsfZ7eSkHVrqC6lM8dNUfuQi82urZ/qCvsamzjgg
 ooYG2WvtWgLZX1sxND8890HagHZHrZ4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-cxFsAjlfPnCwdOmC_ZaqkA-1; Thu, 15 Jan 2026 07:16:15 -0500
X-MC-Unique: cxFsAjlfPnCwdOmC_ZaqkA-1
X-Mimecast-MFC-AGG-ID: cxFsAjlfPnCwdOmC_ZaqkA_1768479374
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47ee71f0244so8854435e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 04:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768479374; x=1769084174; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=04i1qoxuBWUTacm8XX2Dz9EjxJfdYOOT4B2PC1aJaeU=;
 b=okzxRkmxu2I4ok9HcnjdzgyvbxUI5NJKOu1krA5k6RPyhHUiSzMRrPTWIqqR2yGGt4
 Dv5P7fjscWy3tcu6pj0/5M7mNwW7HMOC2Y9ZT/kg0ZVoHBolne3zHX/+Zh8R6lAx9rsl
 o6EJpuiFof5H1nsf1+r8rSfzJoi2lTH3aU3CWgt9wn8BEaDrlurEYzBf/cNQ6MLk2Yjq
 f1X9Qc+yE0PrFke3PsPW9LuIkjSQvqAieC+kZ6PvK9gqak5zHmHRGHKR0IQtgfOoeRuK
 zW+SXKKIkMCPtYsNC7hKOc7llRLwKQP03sPqrVZSj9DDhAdsqYllc1nWoXukH5nLFFgT
 kWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768479374; x=1769084174;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=04i1qoxuBWUTacm8XX2Dz9EjxJfdYOOT4B2PC1aJaeU=;
 b=PrhHppaIxp18XG6hblcVXBQZDsr4nylhbm6zevProaJNlUk0Ws0iQ7n1sJeHGUzEKZ
 8kRMdSf6TfiLPrDyMfl2XIjhPT4lDqUIAi3Yt9QKim2iZDO8h5vdmCXu10wZxTdHSfGr
 vnl3Gn6tm8IH17B4zmu2udNxM80qeGExt5sEoVrBo1n/dMMRKf4YyaqsBP/mbeHjmEYL
 babIaX2ir3fuVFjYA7btO01zGiO7GcN7sHYjfnwWL+q1CXcSdbH3h6k/OjkduN1r2XGa
 Dvp3QqhunHrg95pmUhyK0PxQHvP2TRNcHlltRaLjQSrnmTSw8YxnrNEUU0FtS3l7S9yJ
 5Ebg==
X-Gm-Message-State: AOJu0YwHRJrXZ/dgmEDn2nfudTS1mhSiO17kJ6rcUh7nJINKPxW5Q/lF
 CTl0kC6R9GwHbNGfATpNom44HD4QUgDOemnCNJwQvAjTDNZJ/E9G4bHEwjIQWXg6+R2b6L5QhJU
 hMiO1PZSAQOXqZJezaZiQzP0R8Y4XQGVJK8xyzRSaBNb+9srhYODKroJ7uCian9iXyFsx4D89ae
 LSoT0U3nj2vq80+H9q+1rFfZqjjs6hrTU=
X-Gm-Gg: AY/fxX440O6qx6hzkhoXAPRUhHxdsRU4S1HwYtzlJuqsWOHrDuDg504xkIASlJQDCXW
 R+LDxzhaBp+UHy7WESlH0PJC6OjYzmsux4dFmFLkMW4KWUqQnhsyb64jf6eH4mROyk1TcDuSg+4
 t+YyK/rZBH1tw89F23kkBdMib3zTqGveqEAn1WAtzdbRsvm6TK1QeHKLKOD8tj9SL95OhZN9Pq6
 cRcud5v0j62EErfkOsSYO+DJfQGWrLUJVpkC6x76IIxwFe1zPRsA86g
X-Received: by 2002:a05:600c:1e1d:b0:471:14af:c715 with SMTP id
 5b1f17b1804b1-47ee47be554mr55158285e9.3.1768479373877; 
 Thu, 15 Jan 2026 04:16:13 -0800 (PST)
X-Received: by 2002:a05:600c:1e1d:b0:471:14af:c715 with SMTP id
 5b1f17b1804b1-47ee47be554mr55158085e9.3.1768479373527; Thu, 15 Jan 2026
 04:16:13 -0800 (PST)
MIME-Version: 1.0
References: <20260114195659.2543649-1-peterx@redhat.com>
 <20260114195659.2543649-4-peterx@redhat.com>
In-Reply-To: <20260114195659.2543649-4-peterx@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 15 Jan 2026 17:45:57 +0530
X-Gm-Features: AZwV_QgmnXgJGJM2N8kakGB1KinHQB-J0EjBbrxrzj0wWNmxjMXW3JCNfPdlLC8
Message-ID: <CAE8KmOzAFJztQGvgEYHHuFbtafiKFg4QV38ZGK2DW+TpPGVG2w@mail.gmail.com>
Subject: Re: [PATCH 3/3] migration: Remove fd: support on files
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, 15 Jan 2026 at 01:30, Peter Xu <peterx@redhat.com> wrote:
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  docs/about/deprecated.rst       | 11 -----------
>  docs/about/removed-features.rst |  9 +++++++++
>  migration/fd.c                  | 11 +++++++----
>  3 files changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 6e4e2e4833..76ac735315 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -564,17 +564,6 @@ be rejected.
>  Migration
>  ---------
>
> -``fd:`` URI when used for file migration (since 9.1)
> -''''''''''''''''''''''''''''''''''''''''''''''''''''
> -
> -The ``fd:`` URI can currently provide a file descriptor that
> -references either a socket or a plain file. These are two different
> -types of migration. In order to reduce ambiguity, the ``fd:`` URI
> -usage of providing a file descriptor to a plain file has been
> -deprecated in favor of explicitly using the ``file:`` URI with the
> -file descriptor being passed as an ``fdset``. Refer to the ``add-fd``
> -command documentation for details on the ``fdset`` usage.
> -
>  COLO migration framework (since 11.0)
>  '''''''''''''''''''''''''''''''''''''
>
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index 8a9d21068a..538914ef00 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -710,6 +710,15 @@ Use blockdev-mirror with NBD instead. See "QMP invocation for live
>  storage migration with ``blockdev-mirror`` + NBD" in
>  docs/interop/live-block-operations.rst for a detailed explanation.
>
> +``migrate`` command with file-based ``fd:`` URI (removed in 11.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +In order to reduce ambiguity, the ``fd:`` URI usage of providing a
> +file descriptor to a plain file has been removed in favor of
> +explicitly using the ``file:`` URI with the file descriptor being
> +passed as an ``fdset``. Refer to the ``add-fd`` command documentation
> +for details on the ``fdset`` usage.
> +
>  ``migrate-set-capabilities`` ``block`` option (removed in 9.1)
>  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>
> diff --git a/migration/fd.c b/migration/fd.c
> index 9bf9be6acb..fdeece2101 100644
> --- a/migration/fd.c
> +++ b/migration/fd.c
> @@ -24,6 +24,7 @@
>  #include "qemu/sockets.h"
>  #include "io/channel-util.h"
>  #include "trace.h"
> +#include "qapi/error.h"
>
>  static bool fd_is_pipe(int fd)
>  {
> @@ -58,8 +59,9 @@ void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **
>      }
>
>      if (!migration_fd_valid(fd)) {
> -        warn_report("fd: migration to a file is deprecated."
> -                    " Use file: instead.");
> +        error_setg(errp, "fd: migration to a file is not supported."
> +                   " Use file: instead.");
> +        return;
>      }
>
>      trace_migration_fd_outgoing(fd);
> @@ -92,8 +94,9 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
>      }
>
>      if (!migration_fd_valid(fd)) {
> -        warn_report("fd: migration to a file is deprecated."
> -                    " Use file: instead.");
> +        error_setg(errp, "fd: migration to a file is not supported."
> +                   " Use file: instead.");
> +        return;
>      }

* If we are sure that an invalid 'fd' is always the file one,  then
maybe (if possible) 'migrate_fd_valid' could be renamed to
'is_fd_file()'. Above snippet reads that 'fd' is invalid and the error
message says migration to file is deprecated.

Otherwise change looks okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


