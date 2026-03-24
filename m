Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B000AE9A743
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 09:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4yBR-0007Cp-HO; Tue, 24 Mar 2026 05:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w4yBH-00077Q-5l
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 05:36:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w4yBD-0006mR-7M
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 05:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774344964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MmDeBojZMVM6gw1cmlEyl0ViO3ORRvnJFHCelIk5brI=;
 b=W5KENVzouLnCmzEsqaK0mOACbepwaXwCObVqDgr70Dse6KuO++XhTeME0liC0YDY6QpgvT
 eTZn8bzpP/xdncLA12OMAIX4l22KaXRaxfjeTNxC/vj1bXWxgGvPiYR3BojQ/auKYokRxo
 sotFRFKi+p8ClGf9R1cDl14XEExKpFc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-esUozHukOTGAoJuvFA2uTg-1; Tue, 24 Mar 2026 05:36:02 -0400
X-MC-Unique: esUozHukOTGAoJuvFA2uTg-1
X-Mimecast-MFC-AGG-ID: esUozHukOTGAoJuvFA2uTg_1774344961
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4839fc4cef6so67599325e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 02:36:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774344961; cv=none;
 d=google.com; s=arc-20240605;
 b=fHcKREChV1QHQmYDAr/+IRnf3ZjXrjP1Lkrs8VT811xSy9PT+GWykk+sjl4asn6aUw
 GDdY8GVwRVO3QuCXHsVrShSr+r6WKMS2FPxP46Sm6v7oDs9AyfYXgEEb2BTopgJbGhgp
 a4oNqoCf5S8O0kBdQhwMQDKT3eFmncI7wsqfuEK/g3+L1xx4HasVlrIibjsv7rdvtrmq
 q6JYGpCKycEXO7jm60ZOJELP+HHKm/BGC2LS10Acc8oX+/72uGGx1GwZ42YBK6KpMMD6
 wiDTftSVCxQ0fsIq4ngkjSZeTbPrSvjLi+D080+ZMUXVugBLkWPCyMmu95EmKJrSLH2a
 VTVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MmDeBojZMVM6gw1cmlEyl0ViO3ORRvnJFHCelIk5brI=;
 fh=PJ2YM0MCLDpxc+Rr1VwlqTOUmMMZEVsV9MPE+Th47YI=;
 b=LXZbc63MM/wgFuCY1Wiw67OIneW09drNwH6AaXYNgDEaFOgE+ASL+5PXbfce9Rdnwm
 Ok1a4ve33D6T7GLTMvb0zG+GQt3FcdnOE4fstO6pEBVnkU6e/XZ2R1dowQMLTaTGghKx
 2oSguPlLjCASaZGxlvVyvDLdpmCEor7/EpHEzjSCIf9/z1ADgb8OTA2fQC9g0Kwvln1l
 ZkWR3TLnYJwT9MZ9pUl545RX7tCq8drVx7gmHzXE/5r2MeiX68DqT/U/y7JtUEKOnNna
 V4qeUXH/4ZLfSWYq4A1momNTz5j9SlZUC1SSLSZTuhHz05SLPwS1tIfpl8ULd4egL8dO
 +Q0g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774344961; x=1774949761; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MmDeBojZMVM6gw1cmlEyl0ViO3ORRvnJFHCelIk5brI=;
 b=Gx9zllJKbJFe8PjqoOG+a7/CFuoAmL9YNWVP96ERafM+cElonraTnn0lQzowndfszl
 WiLbO1wCeypxzLwwrw1z2Tt6rvywjRe+5RvhjcMTAM1FB9JByqERCUkrD/7pMdJ1AMnB
 Uc+h0nghllSVUrg6w0tOARUALQc4/U0Dzal+dOgTfHNbCD3hNtFYIM/X8hRFZhXEzE5z
 lWPJQeZSxc9LWzSqtzRs2MKPNATS7ruKu6z71aWMm4eFvWA+wPJyPzgO3um940A7ISCC
 wYSATULAdaAgllqAHmS75fLs9Y8KAW+7kE9FL0FJK6PRC38DfqcSsx8Y2dyYEWQwuFlE
 Ov+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774344961; x=1774949761;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MmDeBojZMVM6gw1cmlEyl0ViO3ORRvnJFHCelIk5brI=;
 b=FXbrXK9J9iUMz8TOt5OIgyK6evAAhF8DG7vQ42JpE5xBC5AYtFPdBZa1zUTiHQ9pqs
 3YMeFsL6ABMnOEOchmwHiq7Q6ClKNHw17K+j0kz6VgjZ9ykrCNo/fkp10OjP6otwazm/
 wXPDX5EryYXviDOlCrime4+UIYZjBoa3Xe8krpjI80QE/YppMYBCblTJJNpzjn6M1cJo
 AA3ug/RIQpHh2OrHGVx68gBvv7SidAiyy1osZqXXvJHHuaZpJESEOSr6WJ6kGYjdTKH5
 8LxNpZ5xpwM+RgKXCgpe0NUjcFIRh7QmNAyVtOEqs0igw0+dVLMzSBE8MUR0B16Q6+bT
 406g==
X-Gm-Message-State: AOJu0YwRtWVbhWrX+JxaZPO/ggSdsEXecHlsLP8KeBlI0CQdq421GKKM
 LEx2em+pM9/M04c0evA8cCyxUlFbyePLKNV950TWijZ7M4g+JucwKvLiHPcpDSEZI+rMOonYbbN
 85QE3pPF8oNtHmC0hgwG7Dt0MXeAoQ2QTxCCtgrMmVGGDicEp4q9iU23r0mAtjkf495ycwNOGl4
 P+bVYXkcpPIasx+Inn0fdxRra6cezmidg=
X-Gm-Gg: ATEYQzz1M1BAukWjRKnEGOqDsI4xIAZB9RD9QBe9GbiU1Wnu3RGHL3vtYqgv8EuENXZ
 p8E2+xsGBJUhliW1AeU8pbpDCee9j0bGcZ7K2p7IjTomYAkuSn0AOwcmoBOHA/iZ4bNFQRwldp6
 d9Vw4i78H4ko19gHjVXwocNtTvc8JFmWzTimmNRY5kSytA9Pz6goWrm6qS9zSrGh8Z5Gqo5uPWY
 CSwK05M8WCr+PlyLNA857dGxKJ768RAeHiZ+y9id1+slm89UpA22eVOfqOk1GBp/OdP
X-Received: by 2002:a05:600c:4e13:b0:486:fbc4:8fe2 with SMTP id
 5b1f17b1804b1-4870f22485fmr37321855e9.15.1774344961196; 
 Tue, 24 Mar 2026 02:36:01 -0700 (PDT)
X-Received: by 2002:a05:600c:4e13:b0:486:fbc4:8fe2 with SMTP id
 5b1f17b1804b1-4870f22485fmr37321405e9.15.1774344960674; Tue, 24 Mar 2026
 02:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-7-peterx@redhat.com>
In-Reply-To: <20260319231302.123135-7-peterx@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 24 Mar 2026 15:05:42 +0530
X-Gm-Features: AQROBzCNokbBAYy4rWk8ZWlBFg6J34NeIgPqNM88lNO9Lt-PZsQvDLxwfPjKCuk
Message-ID: <CAE8KmOwdxaW+dnEq-gzLR1iWJQ-Ks6z+keT6Y=k1pg+DGT5PaQ@mail.gmail.com>
Subject: Re: [PATCH RFC 06/12] migration: Use the new save_query_pending() API
 directly
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>, 
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Joao Martins <joao.m.martins@oracle.com>, Alex Williamson <alex@shazbot.org>, 
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Pranav Tyagi <prtyagi@redhat.com>, 
 Zhiyi Guo <zhguo@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
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

On Fri, 20 Mar 2026 at 04:44, Peter Xu <peterx@redhat.com> wrote:
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

* +1.

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

* Why do we have 'precopy_bytes' & 'postcopy_bytes'? What if
qemu_savevm_query_pending() returned the pending data size?

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


