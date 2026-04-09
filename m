Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E45F364A6
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAsyr-0004x3-K3; Thu, 09 Apr 2026 13:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wAsyl-0004sA-4J
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:15:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wAsyh-0000tA-Ny
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775754934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4WI70onklytO/0GFk7u4Ty3r38FWSYIgqh6nVMSPGI0=;
 b=aoPYI2+23RUkxcWJTgcVDsrWeFgBbv4JukH8CATat39lNF0mUHI5/Xu5/dNXoUuU/U49pN
 FlC1QoqpR4XEmrZUiGYZXxichWbGrj/CoI6HPoP/3y16NskoMl4oNQ2csmv7a12HE3PHzJ
 YRjjKpCBeCIduX21EIsARxTyWubOdKk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260--tRaIXeHOW-_g1u-m0B0Pw-1; Thu, 09 Apr 2026 13:15:33 -0400
X-MC-Unique: -tRaIXeHOW-_g1u-m0B0Pw-1
X-Mimecast-MFC-AGG-ID: -tRaIXeHOW-_g1u-m0B0Pw_1775754932
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43cff5bc312so954524f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 10:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775754932; x=1776359732; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4WI70onklytO/0GFk7u4Ty3r38FWSYIgqh6nVMSPGI0=;
 b=rbK/NlRSbSkpj2UgpygJ+IXCbsHIYRp6OXQ/QinsN0/X8g/3XzFaHXlSaKAUnazNMn
 skC8OvtJhERToBJvYuYonhR9Z1rm5lX9WffgE57YxHuLroZYcUwGEABnaNdRE3diLmVn
 ugIpqQET9BoYfnykDrjItrpijKUqufrDYzTcGGJBo6g+DUciN3K/eUrmhB3oU3RytRM7
 N0subiPLIgPvR3GhXL51hbmqloqqb5pphNe/hcOnRGMzXb7nd6nqPMsBSvp6u4hKMwy0
 nWtKvAJxBw231ASxiJd35o/EsvqYeZzPH+ugHHqlfJhqnyPxD0Ia/0yyAcnqg6aRNCMs
 TFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775754932; x=1776359732;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4WI70onklytO/0GFk7u4Ty3r38FWSYIgqh6nVMSPGI0=;
 b=pPrPc84pxtHr/a0ixyXSgE2wtP/HmE1Iixo6KK+Y8oBIJOM506or9TC5jEcYJxPZDK
 vMJSc7yDl4Lx/CP3++9KtAm/xSgqEWXkBv00LQxZBNpgIwSu9e0ouQnpk9u9xl5FGokg
 16Kh/0IVMmWvyb7XbXlH9zjErWeTLQZjRB+Q+c+SYS5JRCWvYmYLDlS12aziAaMA9m1C
 p1X92fKtK26DS6b7myvlxBFB7NRh4VFf+VdEqV50ryeTIic1fjtM1wN0g4PO6cThdihb
 YMPDNZXPtT/UeYtw4zRaV12PuXgI6wDPSBZP6eRfq3GzzHA3WztWm3FU+QeuI5mECDZt
 czzw==
X-Gm-Message-State: AOJu0Yx/zoiGAncWCGd9VEDNdcE97o41FmZzxfpZ3SIAN+XBH5VNZ7zI
 vYXeOc4y2ySgBr1zpmu+TLodAEUjF6pnx91YtP4Qlc7xwLjTXxZOCAIftLyQH6E2PdOQo59rjXU
 ToxTmMaiyR9s9VkSvUmOk89UdSMnsU1aCiwYir53nvdSinQKPxGX+mOwW
X-Gm-Gg: AeBDieu5QGpA325rFsTG/31B+f+5k8FjjBK8x0XHrcBOGp8COtgE80TVx7VSKj5BJ8K
 tLZTKLLrbVzRE/ih0cHa4esOGvmwBGXSmO55GJXU2gTrfroJ3F7ai7HF1/Y8nRX8M66ZukVilIU
 FiicCVmQgwfDX1AaUxfBcx70EL21FSpFE7i33NOQU3KaNpg9r6efLSfhof6Oxfq6n63L0/NvsbN
 PfzBK2B/TEwUdiPdh+l456SsVl0Dm48v7SUtjAk1I7McFoGNIt5OICDZdz8A45PN1yj3EYXRFo+
 jeLv9/UoOd7CHgCiMFEW9lSA0nYK/7BeAGbV2i2toQxHBJ/+KihSst2Yhvb7iATCkEuZgX/7vRN
 puDt2K1zRguCFGswqOQaREa9SDHhFoVYxoGWGP1A=
X-Received: by 2002:a05:6000:2388:b0:43d:b99:bdc4 with SMTP id
 ffacd0b85a97d-43d292d32d9mr36944541f8f.30.1775754931488; 
 Thu, 09 Apr 2026 10:15:31 -0700 (PDT)
X-Received: by 2002:a05:6000:2388:b0:43d:b99:bdc4 with SMTP id
 ffacd0b85a97d-43d292d32d9mr36944474f8f.30.1775754930976; 
 Thu, 09 Apr 2026 10:15:30 -0700 (PDT)
Received: from fedora (nat-88-212-17-233.antik.sk. [88.212.17.233])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e50044sm230785f8f.25.2026.04.09.10.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 10:15:30 -0700 (PDT)
Date: Thu, 9 Apr 2026 19:15:28 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, 
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
 Zhiyi Guo <zhguo@redhat.com>, Prasad Pandit <ppandit@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, 
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Joao Martins <joao.m.martins@oracle.com>, Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH 08/14] migration: Make qemu_savevm_query_pending()
 available anytime
Message-ID: <adfegWEjLcGmDTPi@fedora>
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-9-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408165559.157108-9-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

On 2026-04-08 12:55, Peter Xu wrote:
> After qemu_savevm_query_pending() be exposed to more code paths, it can be
> used at very early stage when migration started and this may expose some
> race conditions that we don't use to have.  This patch make it prepared
> for such use cases so this API is fine to be used almost anytime.
> 
> What matters here is, querying pending for each module normally depends on
> save_setup() being run first, otherwise modules may not be ready for the
> query request.
> 
> Consider an early cancellation of migration after SETUP status but before
> invocations of save_setup() hooks, source QEMU may fall into CANCELLING
> stage directly from SETUP (not ACTIVE, which is the normal use case), in
> which case save_setup() may not have been invoked and modules are not
> ready.  However qemu_savevm_query_pending() may still be used in QMP
> commands like query-migrate and causing crashes.
> 
> Guard such use case by introducing a boolean reflecting the availability of
> vmstate save handlers on correct completions of save_setup()s.  So far,
> only protect qemu_savevm_query_pending() with it.  Logically other hooks
> face similar concern, but most of them shouldn't be reachable from random
> code path except migration thread so it should be fine.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.h |  8 ++++++++
>  migration/savevm.h    |  2 +-
>  migration/migration.c |  2 +-
>  migration/savevm.c    | 37 +++++++++++++++++++++++++++++++++----
>  4 files changed, 43 insertions(+), 6 deletions(-)
> 
> diff --git a/migration/migration.h b/migration/migration.h
> index b6888daced..e504df6915 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -522,6 +522,14 @@ struct MigrationState {
>       * anything as input.
>       */
>      bool has_block_bitmap_mapping;
> +
> +    /*
> +     * This boolean reflects if the vmstate handlers have been properly
> +     * setup on source side.  It is set after vmstate save_setup() hooks
> +     * are successfully invoked, and cleared after save_cleanup()s.  It
> +     * reflects a general availability of vmstate hooks on the source side.
> +     */
> +    bool save_setup_ready;
>  };
>  
>  void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 96fdf96d4e..04ed09cec2 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -42,7 +42,7 @@ int qemu_savevm_state_resume_prepare(MigrationState *s);
>  void qemu_savevm_send_header(QEMUFile *f);
>  void qemu_savevm_state_header(QEMUFile *f);
>  int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
> -void qemu_savevm_state_cleanup(void);
> +void qemu_savevm_state_cleanup(MigrationState *s);
>  void qemu_savevm_state_complete_postcopy(QEMUFile *f);
>  int qemu_savevm_state_complete_precopy(MigrationState *s);
>  void qemu_savevm_query_pending(MigPendingData *pending, bool exact);
> diff --git a/migration/migration.c b/migration/migration.c
> index bb17bd0e68..a9ee3360e1 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1283,7 +1283,7 @@ static void migration_cleanup(MigrationState *s)
>      g_free(s->hostname);
>      s->hostname = NULL;
>  
> -    qemu_savevm_state_cleanup();
> +    qemu_savevm_state_cleanup(s);
>      cpr_state_close();
>      cpr_transfer_source_destroy(s);
>  
> diff --git a/migration/savevm.c b/migration/savevm.c
> index b75c311a95..1d3fce45b9 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1387,7 +1387,8 @@ int qemu_savevm_state_non_iterable_early(QEMUFile *f,
>      return 0;
>  }
>  
> -static int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
> +static int qemu_savevm_state_setup(MigrationState *s, QEMUFile *f,
> +                                   Error **errp)
>  {
>      SaveStateEntry *se;
>      int ret;
> @@ -1409,6 +1410,13 @@ static int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
>          }
>      }
>  
> +    /*
> +     * Logically, it should be paired with any hook being used who needs to
> +     * load_acquire() the flag first.  So far, only save_query_pending()
> +     * uses it.
> +     */
> +    qatomic_store_release(&s->save_setup_ready, true);

What other savevm functions would benefit from this? Would it make sense
to include them in this patch/series?

> +
>      return 0;
>  }
>  
> @@ -1429,7 +1437,7 @@ int qemu_savevm_state_do_setup(QEMUFile *f, Error **errp)
>          return ret;
>      }
>  
> -    ret = qemu_savevm_state_setup(f, errp);
> +    ret = qemu_savevm_state_setup(ms, f, errp);
>      if (ret) {
>          return ret;
>      }
> @@ -1764,10 +1772,23 @@ int qemu_savevm_state_complete_precopy(MigrationState *s)
>  
>  void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
>  {
> +    MigrationState *s = migrate_get_current();
>      SaveStateEntry *se;
>  
>      memset(pending, 0, sizeof(*pending));
>  
> +    /*
> +     * This API can be invoked very early before SETUP is properly done, in
> +     * that case don't invoke module queries because they're not ready.
> +     * Just report all zeros.
> +     *
> +     * This is paired with save_setup_ready updates on save_setup() and
> +     * save_cleanup().
> +     */
> +    if (!s || !qatomic_load_acquire(&s->save_setup_ready)) {
> +        return;
> +    }
> +
>      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>          if (!se->ops || !se->ops->save_query_pending) {
>              continue;
> @@ -1786,7 +1807,7 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
>                                      pending->postcopy_bytes);
>  }
>  
> -void qemu_savevm_state_cleanup(void)
> +void qemu_savevm_state_cleanup(MigrationState *s)
>  {
>      SaveStateEntry *se;
>      Error *local_err = NULL;
> @@ -1795,6 +1816,14 @@ void qemu_savevm_state_cleanup(void)
>          error_report_err(local_err);
>      }
>  
> +    s->save_setup_ready = false;
> +    /*
> +     * Make sure we clear the flag before invoking save_cleanup(), so any
> +     * racy QMP query-migrate won't try to invoke any save hooks.  Just use
> +     * an explicit barrier to be simple.
> +     */
> +    smp_mb();
> +
>      trace_savevm_state_cleanup();
>      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>          if (se->ops && se->ops->save_cleanup) {
> @@ -1841,7 +1870,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>          error_setg_errno(errp, -ret, "Error while writing VM state");
>      }
>  cleanup:
> -    qemu_savevm_state_cleanup();
> +    qemu_savevm_state_cleanup(ms);
>  
>      if (ret != 0) {
>          status = MIGRATION_STATUS_FAILED;
> -- 
> 2.53.0
> 


