Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E9310F2842
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 15:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w692r-0005wJ-PX; Fri, 27 Mar 2026 11:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1w692p-0005tE-Ew
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 11:24:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1w692n-0006On-Jg
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 11:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774625056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V3+mbHYPicDYwddhhfkl13HlHM4+rE47TWKOegbasu8=;
 b=MOccEOtIO4WNHXHerQ2DO6qZnC8YBG/u6MTreQFkKnmPTiVW9giEdxlCIA7uYbOiPz2RrE
 Doz9Acl0x+94zaeKR3gUA/m/tLEjXSvFw1NsyfpHm2iJEYYI7KkcCWvb1wqyuK9pJES2eP
 4cp29tXyf/3HlFG4Pk9fHNDra7BLeRg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-IC4kfnR2NvaRocTCTcZ1Zw-1; Fri, 27 Mar 2026 11:24:14 -0400
X-MC-Unique: IC4kfnR2NvaRocTCTcZ1Zw-1
X-Mimecast-MFC-AGG-ID: IC4kfnR2NvaRocTCTcZ1Zw_1774625053
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b984798d468so214925066b.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 08:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774625053; x=1775229853; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=V3+mbHYPicDYwddhhfkl13HlHM4+rE47TWKOegbasu8=;
 b=m7tkgt4fX1pyjsqkNrzL//i7jhgtiZafGGB2g7RmllBIalhOXEiuCw9olEFfvsUoUA
 61Er2VBgefgq1Do3TLki5KhWXkZtHk3QUaDlPJZsgftnTaJoZNAq9fyUq+QTPnc6mcYv
 bXj8OHUfgS3kleoYHLUXLQr+VMqQYc/3d9VuErMiImeK6tErApb2HCI3oKUodwaXI85S
 VRxR9a+tr9unzJUqahjiEn5s+0WIeK7zXyelRLMC+CgHfYN1iP992erVo5fVxCDS21Bp
 6KevjN4m3LguO7P85T5plPK1TU33Sjc56ZYytKRKsI6wwaN0WYgUaHBjmQPZceRaRNli
 S+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774625053; x=1775229853;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V3+mbHYPicDYwddhhfkl13HlHM4+rE47TWKOegbasu8=;
 b=L4GFHF1XRyslO++jthXcTV24VVolGHKYsQb3CYbHW0TQhcwWwkl3+cs/oE9IWLnPT/
 B9WnPub2TcnWmXtfxDncKbBwfrVyrrxHZPbN6CGT0tXOd97PAS/xCOIYs9V028t0Q4NR
 on3pdIxiylrGH6X2l8xa64dL0q+/CCLJCTcgIVqAZdNrpA4Motnpg6/JIiscFScsKVOU
 C+B+zgEsuxlerPFicsInrd0OonQlzxexnWONnwQVGiTg2uonsJPmgmxrq/dTzS19hBSs
 CrmI/m0rId9LIqZWsgUO6P1NcskkXJwktWWVvORYAo+jeusPvgpgEpr0EK8QXNyo7jl0
 Zyow==
X-Gm-Message-State: AOJu0Yx/70TMLT2doxssW7ZrAwMr6qsSH3McB+2sTG9Xa21kzFUgAE3c
 uBQnlEJUQdnx3nVQPTx/bcSjNdk0pepLJcSn0M7lyZfQylZn3RqoehI/CHmemxrefcDxd9/3JaC
 3bn0iSKwpOFQZwh+P3A9sq2GU3yPuckRaHdBqm23n1aa35YehR2EyCvQe
X-Gm-Gg: ATEYQzzM0qHybyvO2D+BbCQdP3VRGvFiCzZymxmeajMCwSj5GQAOfxUj31rJ3WX2vh1
 xJsGRd+FIZep6o/u1oBUp9o4NIogr8dlZxa6Vx8h7+pkVo48RLR2Atk4LpOtKhAK2Zss2UCFgeZ
 KYLhQ4uIWs8pB8PvRqO9LuhyRej5HySrclz1Hoe7XkTUVMx2Mo+21uj28YM3ub3aUkUL9ngj7ll
 8P1NN9h7XDjhl5j1jEhO8Ukj4CORNA4tUI6A8LVhS89AuwjUWzThBQQntcwUfSYJPl52etCaR2F
 JyvwL8lF2yJyG45DLy+BGzgl591U5KyhtpJu0CHhpbDmZrdm7kh3GYfmv3+Nf1s2iUztG6LJP1g
 XcA==
X-Received: by 2002:a17:907:7b98:b0:b99:1074:74f with SMTP id
 a640c23a62f3a-b9b508faf7amr241146766b.34.1774625053130; 
 Fri, 27 Mar 2026 08:24:13 -0700 (PDT)
X-Received: by 2002:a17:907:7b98:b0:b99:1074:74f with SMTP id
 a640c23a62f3a-b9b508faf7amr241143966b.34.1774625052528; 
 Fri, 27 Mar 2026 08:24:12 -0700 (PDT)
Received: from fedora ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b2043add3sm271590066b.58.2026.03.27.08.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 08:24:11 -0700 (PDT)
Date: Fri, 27 Mar 2026 16:24:09 +0100
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Kirti Wankhede <kwankhede@nvidia.com>, 
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
 Joao Martins <joao.m.martins@oracle.com>, Alex Williamson <alex@shazbot.org>, 
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>, 
 Pranav Tyagi <prtyagi@redhat.com>, Zhiyi Guo <zhguo@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>, 
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH RFC 06/12] migration: Use the new save_query_pending()
 API directly
Message-ID: <acagIGw8e0RKL2xt@fedora>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-7-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319231302.123135-7-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
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

On 2026-03-19 19:12, Peter Xu wrote:
> It's easier to use the new API directly in the migration iterations.  This
> also paves way for follow up patches to add new data to report directly to
> the iterator function.
> 
> When at it, merge the tracepoints too into one.
> 
> No functional change intended.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/savevm.h     |  4 ----
>  migration/migration.c  | 16 +++++++---------
>  migration/savevm.c     | 23 ++---------------------
>  migration/trace-events |  1 +
>  4 files changed, 10 insertions(+), 34 deletions(-)
> 
> diff --git a/migration/savevm.h b/migration/savevm.h
> index b116933bce..3c39190fa4 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -46,10 +46,6 @@ void qemu_savevm_state_cleanup(void);
>  void qemu_savevm_state_complete_postcopy(QEMUFile *f);
>  int qemu_savevm_state_complete_precopy(MigrationState *s);
>  void qemu_savevm_query_pending(MigPendingData *pending, bool fastpath);
> -void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
> -                                     uint64_t *can_postcopy);
> -void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
> -                                        uint64_t *can_postcopy);
>  int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
>  bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
>  void qemu_savevm_state_end(QEMUFile *f);
> diff --git a/migration/migration.c b/migration/migration.c
> index dfc60372cf..99c4d09000 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3204,17 +3204,17 @@ typedef enum {
>   */
>  static MigIterateState migration_iteration_run(MigrationState *s)
>  {
> -    uint64_t must_precopy, can_postcopy, pending_size;
>      Error *local_err = NULL;
>      bool in_postcopy = (s->state == MIGRATION_STATUS_POSTCOPY_DEVICE ||
>                          s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
>      bool can_switchover = migration_can_switchover(s);
> +    MigPendingData pending = { };
> +    uint64_t pending_size;
>      bool complete_ready;
>  
>      /* Fast path - get the estimated amount of pending data */
> -    qemu_savevm_state_pending_estimate(&must_precopy, &can_postcopy);
> -    pending_size = must_precopy + can_postcopy;
> -    trace_migrate_pending_estimate(pending_size, must_precopy, can_postcopy);
> +    qemu_savevm_query_pending(&pending, true);
> +    pending_size = pending.precopy_bytes + pending.postcopy_bytes;
>  
>      if (in_postcopy) {
>          /*
> @@ -3243,14 +3243,12 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>           * during postcopy phase.
>           */
>          if (pending_size <= s->threshold_size) {
> -            qemu_savevm_state_pending_exact(&must_precopy, &can_postcopy);
> -            pending_size = must_precopy + can_postcopy;
> -            trace_migrate_pending_exact(pending_size, must_precopy,
> -                                        can_postcopy);
> +            qemu_savevm_query_pending(&pending, false);
> +            pending_size = pending.precopy_bytes + pending.postcopy_bytes;
>          }
>  
>          /* Should we switch to postcopy now? */
> -        if (must_precopy <= s->threshold_size &&
> +        if (pending.precopy_bytes <= s->threshold_size &&
>              can_switchover && qatomic_read(&s->start_postcopy)) {
>              if (postcopy_start(s, &local_err)) {
>                  migrate_error_propagate(s, error_copy(local_err));
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 6268e68382..b3285d480f 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1779,28 +1779,9 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool fastpath)
>          }
>          se->ops->save_query_pending(se->opaque, pending);
>      }
> -}
> -
> -void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
> -                                        uint64_t *can_postcopy)
> -{
> -    MigPendingData pending;
> -
> -    qemu_savevm_query_pending(&pending, true);
> -
> -    *must_precopy = pending.precopy_bytes;
> -    *can_postcopy = pending.postcopy_bytes;
> -}
> -
> -void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
> -                                     uint64_t *can_postcopy)
> -{
> -    MigPendingData pending;
> -
> -    qemu_savevm_query_pending(&pending, false);
>  
> -    *must_precopy = pending.precopy_bytes;
> -    *can_postcopy = pending.postcopy_bytes;
> +    trace_qemu_savevm_query_pending(fastpath, pending->precopy_bytes,
> +                                    pending->postcopy_bytes);
>  }
>  
>  void qemu_savevm_state_cleanup(void)
> diff --git a/migration/trace-events b/migration/trace-events
> index 60e5087e38..5f836a8652 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -7,6 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
>  qemu_loadvm_state_post_main(int ret) "%d"
>  qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
>  qemu_savevm_send_packaged(void) ""
> +qemu_savevm_query_pending(bool fast, uint64_t precopy, uint64_t postcopy) "fast=%d, precopy=%"PRIu64", postcopy=%"PRIu64

Should probably remove these two trace events, or is keeping them
intentional?

    migrate_pending_exact(uint64_t size, uint64_t pre, uint64_t post) "exact pending size %" PRIu64 " (pre = %" PRIu64 " post=%" PRIu64 ")"
    migrate_pending_estimate(uint64_t size, uint64_t pre, uint64_t post) "estimate pending size %" PRIu64 " (pre = %" PRIu64 " post=%" PRIu64 ")"

>  loadvm_state_switchover_ack_needed(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
>  loadvm_state_setup(void) ""
>  loadvm_state_cleanup(void) ""
> -- 
> 2.50.1
> 

With unused trace events comment resolved,

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


