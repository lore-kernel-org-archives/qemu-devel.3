Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4FECCF2EF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 12:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhoVq-0000Hh-Hr; Mon, 19 Jan 2026 07:37:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vhoVp-0000Ed-0H
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 07:37:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vhoVn-0006LI-3k
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 07:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768826258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vzJFACuNWFfNwYg9VHI6d1FpXkBE8MrLN0kzYbbdTWY=;
 b=iyrO9zCiGykwd3xzOy/DTdMKDbP/5g/XIpep8RCjZspF5QWrt9moN3Goii/dtJeOIaTInG
 wZjbbG5RpKuSGX1CJ9wvMLra284x+rOx08SpmR7FX7B2z8kPaBH0iUY92j/LcCoff27D/q
 bwmZLuTOdivDNZklKKz1ogpTXoFxyuc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-U9tC8KAcM9iIl9ltAMYhNg-1; Mon, 19 Jan 2026 07:37:36 -0500
X-MC-Unique: U9tC8KAcM9iIl9ltAMYhNg-1
X-Mimecast-MFC-AGG-ID: U9tC8KAcM9iIl9ltAMYhNg_1768826255
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4801e3aab32so20710575e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 04:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768826255; x=1769431055; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vzJFACuNWFfNwYg9VHI6d1FpXkBE8MrLN0kzYbbdTWY=;
 b=mIRf7qY3GYRKfE8tCrHy3vH6475fB+G8Wvgag6b4pyVu8MzgAcJknkJJUpgeqWdccQ
 bJevcAYey2h8HvQdbnWFU11ypIL+/YVkFQQtdia3Nn4Aq5i//9TmpA9QrBoAPzk9vL0F
 MJSE3Pojp9+kj8oJmepa52DmbEQSuvk7HdGNkmEmPdxFoOwxyYa3S4ZN4TkY/susmkX7
 WQnrShxzSfmUi/aGFAaUa/qfvXdNN87b/I5fgEjHS86HB6VSxC0jQMTG2NbtDbE381HT
 NQN7MZnPxRwuLFfQj19YRGhSbH4GdEqJvw9lJ9uKvejO5nWuALZo2vqqgRtPSDrStik8
 ddjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768826255; x=1769431055;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vzJFACuNWFfNwYg9VHI6d1FpXkBE8MrLN0kzYbbdTWY=;
 b=w8PtnC2uBp//sBFl8Db74ImCpJDvGzThqjNrsvbUJaVWFNDoRC4bRjmdaNX7qRpD+x
 Fepr3iXlH8LczxenD2d8TLD/vnHnw/nGvU7+X4itHU3PSkLhdKn/gGOvAAPx/bRtfBKL
 +6JYtbplX9Gxh9akcDuSSN7+pc9Au+xdMXcPU9r68TF57jbec221MGRdpQn8vYmbG4oJ
 cA9dyLGiF8sQjJm22fRGa2jyj+ngmjzFDvJc2q+5KWIC918Inq04Rlyy/8GIxV5woTFs
 OYGA97iNn+5zieTAZbbSrhBA4Ir8uCCf/hHP47d4dDYusFZqP1PARYjcpXslfRWzO/ne
 SlWQ==
X-Gm-Message-State: AOJu0YyyM33bXaKQSKycKHQnNCeMglpJeQXQzgNJ52PO6+wr/DlNDZHb
 89Xy5eV+WfzMuzOLbBIl+n56ejTDBb1KCqtZRPag0MG/q/V1WgE0rRPTNsK9lZpyAzDfdi+BimZ
 xOb4gYwnhNyQzZVkE08JvveKR04agKro1s7kdHB/aT+ACQ4BaHMZamVdLS/A7LHKEJ6N2VfH1P6
 r38MTBVqs+lNuvSPJPPh0SXZLQ4EZCZCo=
X-Gm-Gg: AY/fxX4Xmxul06e6xJURFw1t2AcED5pAuAP92L8j2p5yoSBS1UFuGrw2q3T05FYWzPR
 esvBk8qnB3qsG+72Oj420glwngQmNuckiIFmvCO8r3Fe3xNhng9WaA+L8KCQsRFjXirNnGQeUQG
 8qgNlFl5Ya2TjpS2qMMTWLRqetBwxYWbOXXyfrNB1srfz/xg25lT5Yph/XQtoqvTz41Rf2b4Ndp
 M5tcbToZRJlEpRmq61oS/9JT3s8564u05F6JfuznUObJNIIf5NBQIIZ
X-Received: by 2002:a05:600c:4513:b0:477:9cdb:e337 with SMTP id
 5b1f17b1804b1-4801e2fc2e3mr150020075e9.7.1768826254810; 
 Mon, 19 Jan 2026 04:37:34 -0800 (PST)
X-Received: by 2002:a05:600c:4513:b0:477:9cdb:e337 with SMTP id
 5b1f17b1804b1-4801e2fc2e3mr150019755e9.7.1768826254397; Mon, 19 Jan 2026
 04:37:34 -0800 (PST)
MIME-Version: 1.0
References: <20260109124043.25019-1-farosas@suse.de>
 <20260109124043.25019-4-farosas@suse.de>
In-Reply-To: <20260109124043.25019-4-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 19 Jan 2026 18:07:18 +0530
X-Gm-Features: AZwV_QjGSETJ6WX9TH2HtRfso8he6BZ7dtrquq_v-0_impSVR29NHmdjACs3Lss
Message-ID: <CAE8KmOwuAS399-cCyj66b7uBeF5VLTg-KNSnDh-bXuqUuGK2wQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/25] migration/tls: Remove unused parameter
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
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

On Fri, 9 Jan 2026 at 18:14, Fabiano Rosas <farosas@suse.de> wrote:
> MigrationState is not used at migration_tls_channel_process_incoming().

* MigrationState -> MigrationState parameter
* at -> in

> The last usage was removed by commit 3f461a0c0b ("migration: Drop
> unused parameter for migration_tls_get_creds()")
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/channel.c | 3 +--
>  migration/tls.c     | 4 +---
>  migration/tls.h     | 4 +---
>  3 files changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/migration/channel.c b/migration/channel.c
> index 4768c71455..b4ab676048 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -32,7 +32,6 @@
>   */
>  void migration_channel_process_incoming(QIOChannel *ioc)
>  {
> -    MigrationState *s = migrate_get_current();
>      MigrationIncomingState *mis = migration_incoming_get_current();
>      Error *local_err = NULL;
>
> @@ -40,7 +39,7 @@ void migration_channel_process_incoming(QIOChannel *ioc)
>          ioc, object_get_typename(OBJECT(ioc)));
>
>      if (migrate_channel_requires_tls_upgrade(ioc)) {
> -        migration_tls_channel_process_incoming(s, ioc, &local_err);
> +        migration_tls_channel_process_incoming(ioc, &local_err);
>      } else {
>          migration_ioc_register_yank(ioc);
>          migration_ioc_process_incoming(ioc, &local_err);
> diff --git a/migration/tls.c b/migration/tls.c
> index 56b5d1cc90..1df31bdcbb 100644
> --- a/migration/tls.c
> +++ b/migration/tls.c
> @@ -71,9 +71,7 @@ static void migration_tls_incoming_handshake(QIOTask *task,
>      object_unref(OBJECT(ioc));
>  }
>
> -void migration_tls_channel_process_incoming(MigrationState *s,
> -                                            QIOChannel *ioc,
> -                                            Error **errp)
> +void migration_tls_channel_process_incoming(QIOChannel *ioc, Error **errp)
>  {
>      QCryptoTLSCreds *creds;
>      QIOChannelTLS *tioc;
> diff --git a/migration/tls.h b/migration/tls.h
> index 58b25e1228..7607cfe803 100644
> --- a/migration/tls.h
> +++ b/migration/tls.h
> @@ -24,9 +24,7 @@
>  #include "io/channel.h"
>  #include "io/channel-tls.h"
>
> -void migration_tls_channel_process_incoming(MigrationState *s,
> -                                            QIOChannel *ioc,
> -                                            Error **errp);
> +void migration_tls_channel_process_incoming(QIOChannel *ioc, Error **errp);
>
>  QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
>                                             const char *hostname,
> --

* Looks right.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


