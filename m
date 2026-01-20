Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A17D2ED0F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 11:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi9qv-0001GF-9E; Tue, 20 Jan 2026 06:24:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vi9ql-0001BW-WC
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 06:24:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vi9qi-0006Fs-5j
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 06:24:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768908279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E90uUYdCYPLiZH2Zf2a3vtedkP8UqaTwoXr10fA1Kzs=;
 b=Vhc5GcR3Fn8O05x9+c5B/7cFoqmnPCo1/1h14wb8lqh89f/gjNZl0XT3HfOHR+qV+VHFR6
 7ra+VN8ev6kskyO6iwagJQA81rFWylz853Yo5RO10lzbv/e47wVDydBICnmjeryBXE9pMU
 JBhXgVlXScEd7vUGN4eEYfOK2TzWvd4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-kj-qZi6qN4iO7Z25qxAtGg-1; Tue, 20 Jan 2026 06:24:37 -0500
X-MC-Unique: kj-qZi6qN4iO7Z25qxAtGg-1
X-Mimecast-MFC-AGG-ID: kj-qZi6qN4iO7Z25qxAtGg_1768908277
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47ee056e5cfso44949095e9.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 03:24:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768908276; cv=none;
 d=google.com; s=arc-20240605;
 b=bT+mTpnG5rkmCx8Ia5LoDlqxu4+auH/MqixjEzfeyD97msStMyfNF4kX4JOmw2RJqQ
 gEfIfZIp7sorR6/8nLXU4wIHYhUcYQtTo6sTMTE8OGVBBZ1mjDg3BOEbmFozHFXw3ZEd
 r6k8Q0+NDw7QqTo1bLotBrFft7YBgpMntu/4KH4JFEBuwZDHw1ouolOwxRIrRvoSHkUh
 pnIVl2GBL5u64biDXaZAV7oMQgklfRiWjlojQqclfp7rdzzLsNgBu7PwY4c6G9mRowr4
 Nziy5qCODOZ2e8L5Sii8exdPi7WT+0id2aIGgsxlvki4yYZQnA4nbzlooE3eSENi9FX5
 GEmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=E90uUYdCYPLiZH2Zf2a3vtedkP8UqaTwoXr10fA1Kzs=;
 fh=jjq9sOgGRsbcm1AC8tD4S17WtZ06kUg+xzgdpLFYm5U=;
 b=bo8uwlDO1t99uaRXJLwUeJXVmv87K0xvisQL8ne3zpbZjgPfR8Ct6v/qgJPKFMaxhw
 bsU4Z+nXBcxYmq/TQf2xJAE5GiQkzZSdB10pPwPypxzpefquIdV2h7ZBiJTJ8qhYpT0q
 CvZAiUgTmjMxaaoa7DpVlVC65UwVvdYy6E+ZLO9c2GODYgfi6iRcuXk/mO9qgNYXqsg3
 cRAjm91FG4AIo3191DbAzE+B0XiNT4z4NYCwv2L+mtL4i7JUEIE2fA+nBKHeyKfKphps
 diLFk0ucQ1kcZaFUiRV9f0lf95x1Eh5Tj+bOyaBMN3gt6VyvbXe2XM/3/zsWq+5ucxjO
 19Ig==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768908276; x=1769513076; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E90uUYdCYPLiZH2Zf2a3vtedkP8UqaTwoXr10fA1Kzs=;
 b=IGGLObhK3sBkejrr60saJ3R0W5XQ5X/IGg/bYlWkBU9spt7di4teBqrRdhCidjPjP7
 S1076V0EhAvy+u6rRj3bmQYzTqug4zBGLZXurp64Qb3R8VOEhvRBOmC625mkE/bjnJ6l
 IZY8rOraRAmqPqDAsB17VrYmlE0QNiC/1XuZVq/hM3lBzQ7bbvYDR2xlespbD1UvW3dx
 pk99HO74Ss+qlWmtHrDVEhj3VznXMBfgZZvp+UfF3DdlfFNN40LtZvkoMPkbdtdZw4qX
 rtQlS81k1ZPg5mL1EoQnoDTrfDD2mv6E+N6Rhlh3SUSX4A6+iuOjXAMj9zoaqxBousSB
 PhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768908276; x=1769513076;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E90uUYdCYPLiZH2Zf2a3vtedkP8UqaTwoXr10fA1Kzs=;
 b=danLKo+www/x7vIxoZqe+ykRCzd2+mz/iCdfqOjhXm7GwrHFzfgdKhraV3h4ax+NH6
 3FfIPCsUygF2zxcQjpnvOeA1ljC787B+lsSOQPy0S3+AtODpeJAugb6i/u5ZNAJe6Imo
 zZjlnRD/RiEiSyENySeUnQsPaX38rvch5XJkIElZnDHTkH9mVtF71DBXo/0mYgh3VbtC
 IwCTsxAH5qzCXdPoM85HzqqHB9xWYT6cLDjb6uoPxqLpKo5RM8KTDO9NPE6xeJrOXiP0
 lkFFDD2nKLNMFacERlVVJPBKszC/BGvqtMoJ5rZAL3Rxzu1Pit1jJ7/03EkF0a9xoSSM
 6pog==
X-Gm-Message-State: AOJu0Yw+8272hlsWUvkr8pIHmfXQDaOpVqKCj/jOXcwJzEnazH7YxNZD
 Rpr3iYkVqf/jjMFf/ZUciMs2WaP0D4ynQiCG7zh7WgVpCiza0U3KgOF76wdEZ2Q4TXfgYsETX3t
 nPw944uEP76Ff/9rzmk7Db1c3WUY6BdIFd/QrGo4lMxoCzpD/WavYYv94/cyx2dMKwZf86Swc1/
 l9krfqFRn9mJ64tr3OljHr35Vrh5jA0pD06eBCKlrQCg==
X-Gm-Gg: AY/fxX5R1GvtJEMhyYekQu37kBNRD3EHA97yygquCvrgH0hLBzPquhJeiaBeI9MF5xW
 XH1RHnVK9ILBCVVrmCgYUeBk4OgpFAfBH3N9yzXjmKsqfgJnfcOWZzGeF7z6lwa+e/4cXHzstno
 CsvG6CCXO/fTWGQGWJ4P2f1tgTYLdJbxGaOs3Aiv3xunGjDJ+/+/5M8zagQT9FgeVzIIDyxCDbq
 jWPB9CfSpArFCNykBtaUfNR5PFMlr2/k7JO4Ua+khk2f/Ezp8kxR8Io
X-Received: by 2002:a05:600c:3555:b0:47e:e20e:bb9c with SMTP id
 5b1f17b1804b1-4801e2f8e63mr191581495e9.8.1768908275659; 
 Tue, 20 Jan 2026 03:24:35 -0800 (PST)
X-Received: by 2002:a05:600c:3555:b0:47e:e20e:bb9c with SMTP id
 5b1f17b1804b1-4801e2f8e63mr191581155e9.8.1768908275235; Tue, 20 Jan 2026
 03:24:35 -0800 (PST)
MIME-Version: 1.0
References: <20260109124043.25019-1-farosas@suse.de>
 <20260109124043.25019-24-farosas@suse.de>
In-Reply-To: <20260109124043.25019-24-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 20 Jan 2026 16:54:18 +0530
X-Gm-Features: AZwV_QioSfcROUgbJn2AXawhk8ODFOVZaCySj3iKezah77_fvtQHCB7CprXBwZg
Message-ID: <CAE8KmOwv6+K5TzaXjmQ1Dz+72Mqjykr3ovhmqpFWLPHOepbkYA@mail.gmail.com>
Subject: Re: [PATCH v3 23/25] migration: Move CPR HUP watch to cpr-transfer.c
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>
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

On Fri, 9 Jan 2026 at 18:19, Fabiano Rosas <farosas@suse.de> wrote:
> Move this CPR-specific code into a cpr file. While here, give the
> functions more significant names.
>
> This makes the new idea (after cpr-transfer) of having two parts to
> qmp_migrate slightly more obvious: either wait for the hangup or
> continue directly.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  include/migration/cpr.h  |  5 +++++
>  migration/cpr-transfer.c | 23 +++++++++++++++++++++++
>  migration/migration.c    | 27 +++------------------------
>  3 files changed, 31 insertions(+), 24 deletions(-)
>
> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
> index 027cb98073..5850fd1788 100644
> --- a/include/migration/cpr.h
> +++ b/include/migration/cpr.h
> @@ -9,6 +9,7 @@
>  #define MIGRATION_CPR_H
>
>  #include "qapi/qapi-types-migration.h"
> +#include "io/channel.h"
>  #include "qemu/queue.h"
>
>  #define MIG_MODE_NONE           -1
> @@ -53,6 +54,10 @@ int cpr_get_fd_param(const char *name, const char *fdname, int index,
>  QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
>  QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
>
> +void cpr_transfer_add_hup_watch(MigrationState *s, QIOChannelFunc func,
> +                                void *opaque);
> +void cpr_transfer_source_destroy(MigrationState *s);
> +
>  void cpr_exec_init(void);
>  QEMUFile *cpr_exec_output(Error **errp);
>  QEMUFile *cpr_exec_input(Error **errp);
> diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
> index 00371d17c3..61d5c9dce2 100644
> --- a/migration/cpr-transfer.c
> +++ b/migration/cpr-transfer.c
> @@ -6,7 +6,10 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qapi/clone-visitor.h"
>  #include "qapi/error.h"
> +#include "qapi/qapi-visit-migration.h"
> +#include "io/channel.h"
>  #include "io/channel-file.h"
>  #include "io/channel-socket.h"
>  #include "io/net-listener.h"
> @@ -72,3 +75,23 @@ QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp)
>          return NULL;
>      }
>  }
> +
> +void cpr_transfer_add_hup_watch(MigrationState *s, QIOChannelFunc func,
> +                                void *opaque)
> +{
> +    s->hup_source = qio_channel_create_watch(cpr_state_ioc(), G_IO_HUP);
> +    g_source_set_callback(s->hup_source,
> +                          (GSourceFunc)func,
> +                          QAPI_CLONE(MigrationAddress, opaque),
> +                          (GDestroyNotify)qapi_free_MigrationAddress);
> +    g_source_attach(s->hup_source, NULL);
> +}
> +
> +void cpr_transfer_source_destroy(MigrationState *s)
> +{
> +    if (s->hup_source) {
> +        g_source_destroy(s->hup_source);
> +        g_source_unref(s->hup_source);
> +        s->hup_source = NULL;
> +    }
> +}
> diff --git a/migration/migration.c b/migration/migration.c
> index 5167233f76..6be2849326 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -100,7 +100,6 @@ static bool migration_object_check(MigrationState *ms, Error **errp);
>  static bool migration_switchover_start(MigrationState *s, Error **errp);
>  static bool close_return_path_on_source(MigrationState *s);
>  static void migration_completion_end(MigrationState *s);
> -static void migrate_hup_delete(MigrationState *s);
>
>  static void migration_downtime_start(MigrationState *s)
>  {
> @@ -1297,7 +1296,7 @@ static void migration_cleanup(MigrationState *s)
>
>      qemu_savevm_state_cleanup();
>      cpr_state_close();
> -    migrate_hup_delete(s);
> +    cpr_transfer_source_destroy(s);
>
>      close_return_path_on_source(s);
>
> @@ -1480,7 +1479,7 @@ void migration_cancel(void)
>          migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
>                            MIGRATION_STATUS_CANCELLED);
>          cpr_state_close();
> -        migrate_hup_delete(s);
> +        cpr_transfer_source_destroy(s);
>      }
>  }
>
> @@ -2004,25 +2003,6 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
>
>  static void qmp_migrate_finish(MigrationAddress *addr, Error **errp);
>
> -static void migrate_hup_add(MigrationState *s, QIOChannel *ioc, GSourceFunc cb,
> -                            void *opaque)
> -{
> -    s->hup_source = qio_channel_create_watch(ioc, G_IO_HUP);
> -    g_source_set_callback(s->hup_source, cb,
> -                          QAPI_CLONE(MigrationAddress, opaque),
> -                          (GDestroyNotify)qapi_free_MigrationAddress);
> -    g_source_attach(s->hup_source, NULL);
> -}
> -
> -static void migrate_hup_delete(MigrationState *s)
> -{
> -    if (s->hup_source) {
> -        g_source_destroy(s->hup_source);
> -        g_source_unref(s->hup_source);
> -        s->hup_source = NULL;
> -    }
> -}
> -
>  static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
>                                        GIOCondition cond,
>                                        void *opaque)
> @@ -2083,8 +2063,7 @@ void qmp_migrate(const char *uri, bool has_channels,
>       * connection, so qmp_migrate_finish will fail to connect, and then recover.
>       */
>      if (migrate_mode() == MIG_MODE_CPR_TRANSFER) {
> -        migrate_hup_add(s, cpr_state_ioc(), (GSourceFunc)qmp_migrate_finish_cb,
> -                        main_ch->addr);
> +        cpr_transfer_add_hup_watch(s, qmp_migrate_finish_cb, main_ch->addr);
>
>      } else {
>          qmp_migrate_finish(main_ch->addr, errp);
> --

* Looks okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


