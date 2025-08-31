Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51254CA0FE8
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Aug 2025 15:46:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uskFA-0001DW-A6; Sun, 31 Aug 2025 11:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uskF7-0001CU-GT
 for qemu-devel@nongnu.org; Sun, 31 Aug 2025 11:45:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uskF5-0007sK-5w
 for qemu-devel@nongnu.org; Sun, 31 Aug 2025 11:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756655117;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=In5bJWbApn4CY8LbTZodn7oyH71hzfzXlfi9guy7FRE=;
 b=J6bfdcMDfyzHnHKWK662lPLcE7o37/W0oNfa4WEqn3ZyPkwMiZ9SUw3KSEKU6XIbqaX58u
 OAlbFveQ2uKvApyLVfjmOy5JZU5dOLdH7nDbKNLnyk8PTu2RWhwrQnLhQNWB8NQViZu1nK
 hjp62c9UCt/59yEYQ+5yXGO9f64gsZ4=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-ajjhse6-OkG6zXhuA5dM6w-1; Sun, 31 Aug 2025 11:45:15 -0400
X-MC-Unique: ajjhse6-OkG6zXhuA5dM6w-1
X-Mimecast-MFC-AGG-ID: ajjhse6-OkG6zXhuA5dM6w_1756655114
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-7724046c346so783839b3a.1
 for <qemu-devel@nongnu.org>; Sun, 31 Aug 2025 08:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756655114; x=1757259914;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=In5bJWbApn4CY8LbTZodn7oyH71hzfzXlfi9guy7FRE=;
 b=BAHCzqVk/qXFKymCaBL5XimN2jnJHeAVzato3/NkAoNHv8NGdeU9Mdx7uwhAOzzJQ/
 BPWyoqU4gK0+fUL9HkboCDUDtS5KKyW84285DSl1MA6hnHq5wH9VM6taaBT5WcQ2RngI
 KX8QVi8aF2lq+pyxm8AJRDagY8FvEPqw/v65Cv3rUI5xXiBvOiiIc+pJphx3eaR8CQiu
 Nc5/Sd9SgVy0LZMojDA+A6VdeWQOrJ5M3TB3FeigSMzAOblkwGU3mPwQYylyYxlNwcFj
 LLN7ExcTKFbSvwpSNOPYudC+CXFhC7eeE+EYEztQmo9y16MJGrskqdwpj4eXIwRRm/Zf
 o4TA==
X-Gm-Message-State: AOJu0Yyz4tWxeEeMlDav1fguKS2QodXiMSm8Le40JakNpdibewLrXWUe
 Zt4LKj9sVi5RgHQRDD0tlJYQtgkgiC8/22L9VLE9RYN2Y5dZu+1bFI5EHoyDtm4RNWfQIiKK1qt
 eq5Kq5+ECg5FW8z0iVJLVFw8e/75yMuXG+Gp0FVw17YSMt1UqOLVoVhkA
X-Gm-Gg: ASbGncs91DV5Hb79KsU2SIGm2nC8Udig4lUxurU+y+n0N3F94INX6OG2reZXAt7ict5
 EuWljGp/RWF08GiykPHSNL7ArwwV26C1B0iYR4470q8Yq3GPt+j90gWO5w4rp7jcuOMdxTih0GR
 frw7PL2UeI8LHgFqqHFXpSdm7XpXoDnqC8nd1FhM7sekqO7kcl9onlcYurCMcDFqFGiTSm1gZrv
 Z/R/Q693lVKes4KgdXmX/dHwFXLMcrCpCkx6QvX1Lw9D3snT2WY7Y43LQ5s6iaX97eGLOCjRAqw
 qKmwrdflu0s/Dbd4Ki0MZzGvLuGZtPyGVqZBP3xyg7NaR19js0IB
X-Received: by 2002:a05:6a00:c8b:b0:772:3b9a:9f30 with SMTP id
 d2e1a72fcca58-7723e21a723mr5240204b3a.3.1756655114144; 
 Sun, 31 Aug 2025 08:45:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4wXiYiFXkbjMu59ibjlm+N2WwiEXFS7cP13oXSpyH+aQbIcF0U1V3qjMdMV8Ces8/vLfdNg==
X-Received: by 2002:a05:6a00:c8b:b0:772:3b9a:9f30 with SMTP id
 d2e1a72fcca58-7723e21a723mr5240171b3a.3.1756655113630; 
 Sun, 31 Aug 2025 08:45:13 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.106.50])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a26abdesm7873142b3a.1.2025.08.31.08.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Aug 2025 08:45:13 -0700 (PDT)
Date: Sun, 31 Aug 2025 21:15:00 +0530
From: Arun Menon <armenon@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: Re: [PATCH v13 07/27] migration: push Error **errp into
 qemu_loadvm_state()
Message-ID: <aLRt_G-pOH1rwJbb@armenon-kvm.bengluru.csb>
References: <20250830-propagate_tpm_error-v13-0-a4e777b7eb2c@redhat.com>
 <20250830-propagate_tpm_error-v13-7-a4e777b7eb2c@redhat.com>
 <078e2ef1-fbfa-450a-a2ab-d1e77cc8e850@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <078e2ef1-fbfa-450a-a2ab-d1e77cc8e850@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: armenon@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Akihiko,
Thanks for the review.

On Sat, Aug 30, 2025 at 02:58:05PM +0900, Akihiko Odaki wrote:
> On 2025/08/30 5:01, Arun Menon wrote:
> > This is an incremental step in converting vmstate loading
> > code to report error via Error objects instead of directly
> > printing it to console/monitor.
> > It is ensured that qemu_loadvm_state() must report an error
> > in errp, in case of failure.
> > 
> > When postcopy live migration runs, the device states are loaded by
> > both the qemu coroutine process_incoming_migration_co() and the
> > postcopy_ram_listen_thread(). Therefore, it is important that the
> > coroutine also reports the error in case of failure, with
> > error_report_err(). Otherwise, the source qemu will not display
> > any errors before going into the postcopy pause state.
> > 
> > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >   migration/migration.c |  9 +++++----
> >   migration/savevm.c    | 30 ++++++++++++++++++------------
> >   migration/savevm.h    |  2 +-
> >   3 files changed, 24 insertions(+), 17 deletions(-)
> > 
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 10c216d25dec01f206eacad2edd24d21f00e614c..c6768d88f45c870c7fad9b9957300766ff69effc 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -881,7 +881,7 @@ process_incoming_migration_co(void *opaque)
> >                         MIGRATION_STATUS_ACTIVE);
> >       mis->loadvm_co = qemu_coroutine_self();
> > -    ret = qemu_loadvm_state(mis->from_src_file);
> > +    ret = qemu_loadvm_state(mis->from_src_file, &local_err);
> >       mis->loadvm_co = NULL;
> >       trace_vmstate_downtime_checkpoint("dst-precopy-loadvm-completed");
> > @@ -908,7 +908,8 @@ process_incoming_migration_co(void *opaque)
> >       }
> >       if (ret < 0) {
> > -        error_setg(&local_err, "load of migration failed: %s", strerror(-ret));
> > +        error_prepend(&local_err, "load of migration failed: %s: ",
> > +                      strerror(-ret));
> >           goto fail;
> >       }
> > @@ -924,13 +925,13 @@ fail:
> >       migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
> >                         MIGRATION_STATUS_FAILED);
> >       migrate_set_error(s, local_err);
> > -    error_free(local_err);
> > +    error_report_err(local_err);
> 
> This is problematic because it results in duplicate error reports when
> !mis->exit_on_error; in that case the query-migrate QMP command reports the
> error and this error reporting is redundant.

If I comment this change, then all of the errors propagated up to now, using
error_setg() will not be reported. This is the place where it is finally reported,
when qemu_loadvm_state() fails. In other words, all the error_reports() we removed
from all the files, replacing them with error_setg(), will finally be reported here
using error_report_err().

> 
> >       migration_incoming_state_destroy();
> >       if (mis->exit_on_error) {
> >           WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
> > -            error_report_err(s->error);
> > +            error_free(s->error);
> 
> This change is problematic because s->error set somewhere else here will be
> ignored.

This is specific to the case when mis->exit_on_error is set.
since we did a migrate_set_error(s, local_err) before, we free the
error in s->error and set it to NULL, before an exit(EXIT_FAILURE)

> 
> I think the two changes I commented can be simply removed without causing
> other problems.

Please correct me if I am wrong.

> 
> >               s->error = NULL;
> >           }
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index de5671ffd1cd06e728227a3056c3f895d3a6e6f3..0087fca15ce108685667d3808350d80d37b807b1 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -3159,28 +3159,24 @@ out:
> >       return ret;
> >   }
> > -int qemu_loadvm_state(QEMUFile *f)
> > +int qemu_loadvm_state(QEMUFile *f, Error **errp)
> >   {
> >       MigrationState *s = migrate_get_current();
> >       MigrationIncomingState *mis = migration_incoming_get_current();
> > -    Error *local_err = NULL;
> >       int ret;
> > -    if (qemu_savevm_state_blocked(&local_err)) {
> > -        error_report_err(local_err);
> > +    if (qemu_savevm_state_blocked(errp)) {
> >           return -EINVAL;
> >       }
> >       qemu_loadvm_thread_pool_create(mis);
> > -    ret = qemu_loadvm_state_header(f, &local_err);
> > +    ret = qemu_loadvm_state_header(f, errp);
> >       if (ret) {
> > -        error_report_err(local_err);
> >           return ret;
> >       }
> > -    if (qemu_loadvm_state_setup(f, &local_err) != 0) {
> > -        error_report_err(local_err);
> > +    if (qemu_loadvm_state_setup(f, errp) != 0) {
> >           return -EINVAL;
> >       }
> > @@ -3191,6 +3187,9 @@ int qemu_loadvm_state(QEMUFile *f)
> >       cpu_synchronize_all_pre_loadvm();
> >       ret = qemu_loadvm_state_main(f, mis);
> > +    if (ret < 0) {
> > +        error_setg(errp, "Load VM state failed: %d", ret);
> > +    }
> >       qemu_event_set(&mis->main_thread_load_event);
> >       trace_qemu_loadvm_state_post_main(ret);
> > @@ -3208,8 +3207,15 @@ int qemu_loadvm_state(QEMUFile *f)
> >           if (migrate_has_error(migrate_get_current()) ||
> >               !qemu_loadvm_thread_pool_wait(s, mis)) {
> >               ret = -EINVAL;
> > +            error_setg(errp,
> > +                       "Error while loading vmstate");
> >           } else {
> >               ret = qemu_file_get_error(f);
> > +            if (ret < 0) {
> > +                error_setg(errp,
> > +                           "Error while loading vmstate: stream error: %d",
> > +                           ret);
> > +            }
> >           }
> >       }
> >       /*
> > @@ -3474,6 +3480,7 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
> >   void qmp_xen_load_devices_state(const char *filename, Error **errp)
> >   {
> > +    ERRP_GUARD();
> >       QEMUFile *f;
> >       QIOChannelFile *ioc;
> >       int ret;
> > @@ -3495,10 +3502,10 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
> >       f = qemu_file_new_input(QIO_CHANNEL(ioc));
> >       object_unref(OBJECT(ioc));
> > -    ret = qemu_loadvm_state(f);
> > +    ret = qemu_loadvm_state(f, errp);
> >       qemu_fclose(f);
> >       if (ret < 0) {
> > -        error_setg(errp, "loading Xen device state failed");
> > +        error_prepend(errp, "loading Xen device state failed: ");
> >       }
> >       migration_incoming_state_destroy();
> >   }
> > @@ -3569,13 +3576,12 @@ bool load_snapshot(const char *name, const char *vmstate,
> >           ret = -EINVAL;
> >           goto err_drain;
> >       }
> > -    ret = qemu_loadvm_state(f);
> > +    ret = qemu_loadvm_state(f, errp);
> >       migration_incoming_state_destroy();
> >       bdrv_drain_all_end();
> >       if (ret < 0) {
> > -        error_setg(errp, "Error %d while loading VM state", ret);
> >           return false;
> >       }
> > diff --git a/migration/savevm.h b/migration/savevm.h
> > index 2d5e9c716686f06720325e82fe90c75335ced1de..b80770b7461a60e2ad6ba5e24a7baeae73d90955 100644
> > --- a/migration/savevm.h
> > +++ b/migration/savevm.h
> > @@ -64,7 +64,7 @@ void qemu_savevm_send_colo_enable(QEMUFile *f);
> >   void qemu_savevm_live_state(QEMUFile *f);
> >   int qemu_save_device_state(QEMUFile *f);
> > -int qemu_loadvm_state(QEMUFile *f);
> > +int qemu_loadvm_state(QEMUFile *f, Error **errp);
> >   void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
> >   int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
> >   int qemu_load_device_state(QEMUFile *f);
> > 
> 
Regards,
Arun Menon


