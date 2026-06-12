Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE023CD98CF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 16:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY4MK-0007h3-A5; Fri, 12 Jun 2026 12:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wY4MJ-0007gQ-3n
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 12:03:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wY4MH-0004ID-7R
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 12:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781280227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6nZDNmZMC1kgHXeNSJN14Ci5wcHhqGBxfwlQs3TMv90=;
 b=c8ieP7AXq5kAOXLi+rIaZcP3MENWgmbeVDnEZSVr2hiYOOf26fTkWS50RPYA3Dc0ObeIkN
 EKZM3uOdZQPHyJYSxxtXEUkbPjqsNBFxOQFhdMYCURB6c3hcYLYCuxF/BQXKqvYJHCoxS7
 eCt0BJyVoq+RN07/Ct9puBZF2pIfZ1s=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-7piOmn69OYWBEI_wapfgnQ-1; Fri, 12 Jun 2026 12:03:45 -0400
X-MC-Unique: 7piOmn69OYWBEI_wapfgnQ-1
X-Mimecast-MFC-AGG-ID: 7piOmn69OYWBEI_wapfgnQ_1781280224
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5a94a743521so641713e0c.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 09:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781280224; x=1781885024; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6nZDNmZMC1kgHXeNSJN14Ci5wcHhqGBxfwlQs3TMv90=;
 b=Ody3BaJex2o6mbLIyId429cudH63qqwe6xGaz9BzeImpoLFhNP6+K5IHJXx1fYHWgf
 T5ze8KdW9Z9X8meKzEyExdR4E5YpbSvn+5BqUaD1912VNFiBdkms9BSuaJ3doRDOxp0Z
 k9EmJ3LivvtkfmaTXgUaR8+cNgt8lap3ALbwSDpQHR5JUnlZkNQEcA7XxdyN/9wGW/12
 j9Xo/MDrD3Waoe3rj20mkDRMBKGHhl9wMPwWEXzhWsFKl1MLpxqdl4UZwJhGFEPY0W0J
 M1Yh+JfTwE3Mh25E6CyAR4daS/O8SLFuunyAMOotH2aSqcGtVTQCXqysTJ3Sbe2SVuhZ
 n3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781280224; x=1781885024;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6nZDNmZMC1kgHXeNSJN14Ci5wcHhqGBxfwlQs3TMv90=;
 b=HnkIHWHZNe1koM40H343jcFAzQpMhvj5bwPzD12gId07xTnf1GXy3q1WRgHtEnlYVI
 pWVnYga7NsSxyf3CwBZTeC2joOac2JVMzJcALh6AZcakketL99LC8gNEtqCBEF513rQK
 70g3xKgWZu0UuY7uty7Cm1BayZqoJGqiPwSJ/ilf0odmt+o3WBg/Fll8va8Q9i4ekWNz
 cYc9H3IuOqYC5Ys2gucNd3mKtuaB5zmlcAsSjWyqgiBLzLtlYzWqNrnQxEoxKRTOM+9Y
 enO/arSrRTBMpgwj6jzFUxeferdBOMr0y0ElwGWTVY0TetTGcnLdUv0Smv86tFc29VmR
 o4PA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8i0IKt2fyIm2li8/vR6o31ctX6KVUx+NC4UtEjm0slBK2VQxFqkwhVDoxdiF0joGP33SvsrWpjITN/@nongnu.org
X-Gm-Message-State: AOJu0YyuKX2jgfqm3j9OY0o2A6HGFovUvHE7RiBlzRs/TpMzzALbhy6V
 UWmeew0zV5M76LT4sgkZhYQzf2PsxZjNJ7Ok7JUwRGjaDLrOvKFGX+8sD0IUjd0xE/V1B7Ned+u
 UqECaRH+yEGqQIVK6h9SGSx6mn4EJwSerCTTzzj8HAOZ+jdxOR5Nd8S0N
X-Gm-Gg: Acq92OGpxiRZI4U0Zt+/qg4mCnl/XNvrXZJ0UqagijE+S/pfItAq8YcoGafdQPXNJx+
 6BaB3kl0ZpFgiOKthbcvsNBkg2mzfx1sQLsB0MHNUJguXb6n+UgIZIa41l03ef0pq4N+U/Ao89N
 zly8mCelQVIvicqa/2/rcYby6lA+SOqlJA3jH6trmzuiN4xyIB2Hb+aNujqOLQhOStJTcjqIl7o
 Gci6TnR4Swv+k5LbHWUjHBQIkFb0F2soqMYLtu+Vr2QHK5EocG+C74LQU6nfCBDmrn524k+sSj0
 xhD3rQ8357gDjAM8s9TTIUVNJWrSKtTBRExYD9s33hJ49K01uD6019B+FyDfKInW7FjuSAlE8zD
 nwGnKG7eUrheLvn0=
X-Received: by 2002:a05:6122:1984:b0:5a1:edab:f216 with SMTP id
 71dfb90a1353d-5bb79cb5ce9mr81531e0c.11.1781280223441; 
 Fri, 12 Jun 2026 09:03:43 -0700 (PDT)
X-Received: by 2002:a05:6122:1984:b0:5a1:edab:f216 with SMTP id
 71dfb90a1353d-5bb79cb5ce9mr81465e0c.11.1781280222885; 
 Fri, 12 Jun 2026 09:03:42 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5bb691fd8adsm3039186e0c.13.2026.06.12.09.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 09:03:41 -0700 (PDT)
Date: Fri, 12 Jun 2026 12:03:39 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH v3 01/14] migration: Propagate errors in
 migration_completion_precopy()
Message-ID: <aiwt2_I2wK6FBJnO@x1.local>
References: <20260609075812.32067-1-avihaih@nvidia.com>
 <20260609075812.32067-2-avihaih@nvidia.com>
 <775738ae-3a47-4ee6-900c-56ba77b4185e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <775738ae-3a47-4ee6-900c-56ba77b4185e@oss.qualcomm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 09, 2026 at 02:11:00PM +0200, Philippe Mathieu-Daudé wrote:
> On 9/6/26 09:57, Avihai Horon wrote:
> > migration_completion_precopy() doesn't propagate errors to migration
> > core which leads to error information loss. Fix that.
> > 
> > This prepares for a follow-up where migration_switchover_start() can
> > fail on switchover-ack and still report a useful error.
> > 
> > Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> > ---
> >   migration/savevm.h    |  2 +-
> >   migration/migration.c | 13 ++++++++-----
> >   migration/savevm.c    | 29 +++++++++++++++++------------
> >   3 files changed, 26 insertions(+), 18 deletions(-)
> > 
> > diff --git a/migration/savevm.h b/migration/savevm.h
> > index 96fdf96d4e..b6bb4fa977 100644
> > --- a/migration/savevm.h
> > +++ b/migration/savevm.h
> > @@ -44,7 +44,7 @@ void qemu_savevm_state_header(QEMUFile *f);
> >   int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
> >   void qemu_savevm_state_cleanup(void);
> >   void qemu_savevm_state_complete_postcopy(QEMUFile *f);
> > -int qemu_savevm_state_complete_precopy(MigrationState *s);
> > +int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp);
> >   void qemu_savevm_query_pending(MigPendingData *pending, bool exact);
> >   int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
> >   bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 074d3f2c69..aad23f3228 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -2814,7 +2814,7 @@ static bool migration_switchover_start(MigrationState *s, Error **errp)
> >       return true;
> >   }
> > -static int migration_completion_precopy(MigrationState *s)
> > +static int migration_completion_precopy(MigrationState *s, Error **errp)
> >   {
> >       int ret;
> > @@ -2823,16 +2823,17 @@ static int migration_completion_precopy(MigrationState *s)
> >       if (!migrate_mode_is_cpr()) {
> >           ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
> >           if (ret < 0) {
> > +            error_setg_errno(errp, -ret, "Failed to stop the VM");
> >               goto out_unlock;
> >           }
> >       }
> > -    if (!migration_switchover_start(s, NULL)) {
> > +    if (!migration_switchover_start(s, errp)) {
> >           ret = -EFAULT;
> 
> This function should now returns a boolean IMHO.
> 
> >           goto out_unlock;
> >       }
> > -    ret = qemu_savevm_state_complete_precopy(s);
> > +    ret = qemu_savevm_state_complete_precopy(s, errp);
> >   out_unlock:
> >       bql_unlock();
> >       return ret;
> > @@ -2869,7 +2870,7 @@ static void migration_completion(MigrationState *s)
> >       Error *local_err = NULL;
> >       if (s->state == MIGRATION_STATUS_ACTIVE) {
> > -        ret = migration_completion_precopy(s);
> > +        ret = migration_completion_precopy(s, &local_err);
> >       } else if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
> >           migration_completion_postcopy(s);
> >       } else {
> > @@ -2900,7 +2901,9 @@ static void migration_completion(MigrationState *s)
> >       return;
> >   fail:
> > -    if (qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
> > +    if (local_err) {
> > +        migrate_error_propagate(s, local_err);
> > +    } else if (qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
> 
>   if (local_err
>       || qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
> 
> >           migrate_error_propagate(s, local_err);
> >       } else if (ret) {
> >           error_setg_errno(&local_err, -ret, "Error in migration completion");
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 23adaf9dd9..9d1d58c8f4 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -1771,28 +1771,34 @@ int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp)
> >       return 0;
> >   }
> > -int qemu_savevm_state_complete_precopy(MigrationState *s)
> > +int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp)
> >   {
> > +    ERRP_GUARD();
> >       QEMUFile *f = s->to_dst_file;
> > -    Error *local_err = NULL;
> >       int ret;
> >       ret = qemu_savevm_state_complete_precopy_iterable(f, false);
> >       if (ret) {
> > +        qemu_file_get_error_obj(f, errp);
> > +        error_prepend(errp, "Failed to save iterable device state: ");
> >           return ret;
> >       }
> > -    /* TODO: pass error upper */
> > -    ret = qemu_savevm_state_non_iterable(f, &local_err);
> > +    ret = qemu_savevm_state_non_iterable(f, errp);
> >       if (ret) {
> > -        migrate_error_propagate(s, error_copy(local_err));
> > -        error_report_err(local_err);
> >           return ret;
> >       }
> >       qemu_savevm_state_end_precopy(s, f);
> > -    return qemu_fflush(f);
> > +    ret = qemu_fflush(f);
> > +    if (ret) {
> > +        qemu_file_get_error_obj(f, errp);
> > +        error_prepend(errp, "%s: Failed to flush QEMUFile", __func__);
> 
> Ditto, directly return boolean.
> 
> Anyway can be done on top, so:

Agreed, I didn't mention this because I know touching the retval needs
further touch callers.  Can be done on top.

> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


