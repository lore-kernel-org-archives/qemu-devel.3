Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEDECA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 17:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uomko-0006Ss-Ry; Wed, 20 Aug 2025 13:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uomkN-0006HO-KR
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 13:37:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uomkK-0008RW-Pr
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 13:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755711432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vl2fq39H82JLMnNSQEjysE7jvMgWSC17rNTDrFCSItQ=;
 b=CfDJwDFJsZm4lHCPXxF6iOrxYmPHb5C7RGrM41WXFADdQfoww9M8JofxbZ3K+OPaVPUV9N
 +ZoxKNZdKSDkveOKEboUXkZDwlEvz1hkcD5rq9J73dh52hnkndM2X7GSZ3vLkvmsvXUAHl
 KsiIzybnYzgACRn5HE73zcVqFJTrZ+c=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-8sludJPBNcubMMAray9GFg-1; Wed, 20 Aug 2025 13:37:08 -0400
X-MC-Unique: 8sludJPBNcubMMAray9GFg-1
X-Mimecast-MFC-AGG-ID: 8sludJPBNcubMMAray9GFg_1755711428
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-24457f440f0so1177205ad.0
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 10:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755711427; x=1756316227;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vl2fq39H82JLMnNSQEjysE7jvMgWSC17rNTDrFCSItQ=;
 b=j83FHE6kwn8SElYyt8Dn4Y9Bgc9EBaLc8SYZe/gjiIkgRu9ksgGyK4AdUQuN3mzFSW
 a2Gt7eWUKcYE47hzxkOVwM8UyE/RDf4/mTLRYw8BDeMj6JyUqu8kphyBp6fi/5CfU8wD
 as66r81JeNAIKKhLeopOLiRdzbJHfcUPu2zcQ722mse6grV54ZO95cUwoKZcDpPW40Qi
 fqPhSR679rUgwelyzCBBxt6/1yg723zbdRTUBxqduFGvUOeXEJbrSs0s6phFwijcskCD
 zorjxvU43/w1O3LRroW7laVPEHBCIYZFPL6xX1xj2JGeTEUMn2TpiP6Dg/PmINIancP8
 qQ0Q==
X-Gm-Message-State: AOJu0Yx+H+tgDRQN4Mqv9NKg41oVIISaIxEeTHzOE3PXGGXC9FQp/Nye
 Az2oggdllztpY5GYCzirEtuJZB6o6jhuXTV/NV8TvGNuJaiOKIw5AgpH43V1moS/PqG36FdC80W
 3M8DxeH1Wlvd8cYRWyE5peE4xtjYDww8jTQoQGgBckSoDpanUKTkeRlQE
X-Gm-Gg: ASbGncu0ud7BJfmqd+B9mnKLUcpTHUh6LmcrytkS86i3A0LYf3dEYPoqOzWUlIk3nHw
 I/oThqqgOKBYEZ9vdnBh9s16bZ9tx3P0xxpNdMkwq39Lhbxkq5HebxOcPzjExw0DfEfJNfkjNB3
 0k6Rjd+PHTI+N6JJm21hjWsKkZQUudyhFdtvd61wioDgDwNnNlbbplLkzgcG+1kgCOc/BV45H9B
 eqt9U93V+rNWp1DBQOubRvBgl1o2aloC4yWOSB6asWo/F5ZnvHzjWPFbTuOU3p5bh5yH/7uHNxi
 YnIZJYW0o82eADqO0zxL4O7qe1Mp0Njbf0PBhP8V8VZj3HhZTJNj
X-Received: by 2002:a17:903:19cc:b0:240:49bf:6332 with SMTP id
 d9443c01a7336-245ef26c548mr43576085ad.47.1755711427399; 
 Wed, 20 Aug 2025 10:37:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzgPj3HYxjgdB7G9IToIPVIJy7/pfTUKw/4Hb1wMMgB3JBgtDW9xouPWGBMKJZki20Vdq/qQ==
X-Received: by 2002:a17:903:19cc:b0:240:49bf:6332 with SMTP id
 d9443c01a7336-245ef26c548mr43575615ad.47.1755711426927; 
 Wed, 20 Aug 2025 10:37:06 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.192.65])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245f374592fsm22129025ad.127.2025.08.20.10.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 10:37:05 -0700 (PDT)
Date: Wed, 20 Aug 2025 23:06:54 +0530
From: Arun Menon <armenon@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
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
Subject: Re: [PATCH v11 07/27] migration: push Error **errp into
 qemu_loadvm_state()
Message-ID: <aKYHtogykp3Lu62L@armenon-kvm.bengluru.csb>
References: <20250813-propagate_tpm_error-v11-0-b470a374b42d@redhat.com>
 <20250813-propagate_tpm_error-v11-7-b470a374b42d@redhat.com>
 <87a540za7c.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a540za7c.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Fabiano,
Thanks for the review.

On Fri, Aug 15, 2025 at 03:55:19PM -0300, Fabiano Rosas wrote:
> Arun Menon <armenon@redhat.com> writes:
> 
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
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >  migration/migration.c |  9 +++++----
> >  migration/savevm.c    | 31 +++++++++++++++++++------------
> >  migration/savevm.h    |  2 +-
> >  3 files changed, 25 insertions(+), 17 deletions(-)
> >
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 10c216d25dec01f206eacad2edd24d21f00e614c..c6768d88f45c870c7fad9b9957300766ff69effc 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -881,7 +881,7 @@ process_incoming_migration_co(void *opaque)
> >                        MIGRATION_STATUS_ACTIVE);
> >  
> >      mis->loadvm_co = qemu_coroutine_self();
> > -    ret = qemu_loadvm_state(mis->from_src_file);
> > +    ret = qemu_loadvm_state(mis->from_src_file, &local_err);
> >      mis->loadvm_co = NULL;
> >  
> >      trace_vmstate_downtime_checkpoint("dst-precopy-loadvm-completed");
> > @@ -908,7 +908,8 @@ process_incoming_migration_co(void *opaque)
> >      }
> >  
> >      if (ret < 0) {
> > -        error_setg(&local_err, "load of migration failed: %s", strerror(-ret));
> > +        error_prepend(&local_err, "load of migration failed: %s: ",
> > +                      strerror(-ret));
> >          goto fail;
> >      }
> >  
> > @@ -924,13 +925,13 @@ fail:
> >      migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
> >                        MIGRATION_STATUS_FAILED);
> >      migrate_set_error(s, local_err);
> > -    error_free(local_err);
> > +    error_report_err(local_err);
> >  
> >      migration_incoming_state_destroy();
> >  
> >      if (mis->exit_on_error) {
> >          WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
> > -            error_report_err(s->error);
> > +            error_free(s->error);
> >              s->error = NULL;
> >          }
> >  
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 4f8c40e284a1b199d12f3c7dd61212b3e0e057c9..05dc392bdf4e19f340bc72bf66ba0543d56868a5 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -3159,28 +3159,24 @@ out:
> >      return ret;
> >  }
> >  
> > -int qemu_loadvm_state(QEMUFile *f)
> > +int qemu_loadvm_state(QEMUFile *f, Error **errp)
> >  {
> >      MigrationState *s = migrate_get_current();
> >      MigrationIncomingState *mis = migration_incoming_get_current();
> > -    Error *local_err = NULL;
> >      int ret;
> >  
> > -    if (qemu_savevm_state_blocked(&local_err)) {
> > -        error_report_err(local_err);
> > +    if (qemu_savevm_state_blocked(errp)) {
> >          return -EINVAL;
> >      }
> >  
> >      qemu_loadvm_thread_pool_create(mis);
> >  
> > -    ret = qemu_loadvm_state_header(f, &local_err);
> > +    ret = qemu_loadvm_state_header(f, errp);
> >      if (ret) {
> > -        error_report_err(local_err);
> >          return ret;
> >      }
> >  
> > -    if (qemu_loadvm_state_setup(f, &local_err) != 0) {
> > -        error_report_err(local_err);
> > +    if (qemu_loadvm_state_setup(f, errp) != 0) {
> >          return -EINVAL;
> >      }
> >  
> > @@ -3191,6 +3187,9 @@ int qemu_loadvm_state(QEMUFile *f)
> >      cpu_synchronize_all_pre_loadvm();
> >  
> >      ret = qemu_loadvm_state_main(f, mis);
> > +    if (ret < 0) {
> > +        error_setg(errp, "Load VM state failed: %d", ret);
> > +    }
> >      qemu_event_set(&mis->main_thread_load_event);
> >  
> >      trace_qemu_loadvm_state_post_main(ret);
> > @@ -3208,8 +3207,14 @@ int qemu_loadvm_state(QEMUFile *f)
> >          if (migrate_has_error(migrate_get_current()) ||
> >              !qemu_loadvm_thread_pool_wait(s, mis)) {
> >              ret = -EINVAL;
> > +            error_setg(errp,
> > +                       "Error while loading VM state: "
> > +                       "Migration stream has error");
> 
> The stream error is the one below. Just keep a generic message here
> because we'll propagate the error from qemu_loadvm_state_main() later in
> the series.
Thanks for clarifying. Will do.
> 
> >          } else {
> >              ret = qemu_file_get_error(f);
> > +            if (ret < 0) {
> > +                error_setg(errp, "Error while loading vmstate : %d", ret);
> 
> + stream error:
Thanks.
> 
> > +            }
> >          }
> >      }
> >      /*
> > @@ -3474,6 +3479,7 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
> >  
> >  void qmp_xen_load_devices_state(const char *filename, Error **errp)
> >  {
> > +    ERRP_GUARD();
> >      QEMUFile *f;
> >      QIOChannelFile *ioc;
> >      int ret;
> > @@ -3495,10 +3501,10 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
> >      f = qemu_file_new_input(QIO_CHANNEL(ioc));
> >      object_unref(OBJECT(ioc));
> >  
> > -    ret = qemu_loadvm_state(f);
> > +    ret = qemu_loadvm_state(f, errp);
> >      qemu_fclose(f);
> >      if (ret < 0) {
> > -        error_setg(errp, "loading Xen device state failed");
> > +        error_prepend(errp, "loading Xen device state failed: ");
> >      }
> >      migration_incoming_state_destroy();
> >  }
> > @@ -3506,6 +3512,7 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
> >  bool load_snapshot(const char *name, const char *vmstate,
> >                     bool has_devices, strList *devices, Error **errp)
> >  {
> > +    ERRP_GUARD();
> >      BlockDriverState *bs_vm_state;
> >      QEMUSnapshotInfo sn;
> >      QEMUFile *f;
> > @@ -3569,13 +3576,13 @@ bool load_snapshot(const char *name, const char *vmstate,
> >          ret = -EINVAL;
> >          goto err_drain;
> >      }
> > -    ret = qemu_loadvm_state(f);
> > +    ret = qemu_loadvm_state(f, errp);
> >      migration_incoming_state_destroy();
> >  
> >      bdrv_drain_all_end();
> >  
> >      if (ret < 0) {
> > -        error_setg(errp, "Error %d while loading VM state", ret);
> > +        error_prepend(errp, "Error %d while loading VM state: ", ret);
> 
> This message will get redundant, leave it out.
Sure, will do.
> 
> >          return false;
> >      }
> >  
> > diff --git a/migration/savevm.h b/migration/savevm.h
> > index 2d5e9c716686f06720325e82fe90c75335ced1de..b80770b7461a60e2ad6ba5e24a7baeae73d90955 100644
> > --- a/migration/savevm.h
> > +++ b/migration/savevm.h
> > @@ -64,7 +64,7 @@ void qemu_savevm_send_colo_enable(QEMUFile *f);
> >  void qemu_savevm_live_state(QEMUFile *f);
> >  int qemu_save_device_state(QEMUFile *f);
> >  
> > -int qemu_loadvm_state(QEMUFile *f);
> > +int qemu_loadvm_state(QEMUFile *f, Error **errp);
> >  void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
> >  int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
> >  int qemu_load_device_state(QEMUFile *f);
>
Regards,
Arun 


