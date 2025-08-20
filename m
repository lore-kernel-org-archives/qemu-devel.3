Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1332CA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 17:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uombM-0000Qo-QW; Wed, 20 Aug 2025 13:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uombJ-0000Px-5W
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 13:27:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uombG-00071a-Gq
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 13:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755710860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uzagBq92TkRMbC0d57UvJ/4tJKLJIzHzfh71AktkPvw=;
 b=UUmbxy2rk5KRyZpFHPy2J+iMtBmtEGw5ZBvyuNTO1HU7WSBCJ7btxWEGmw7CsBmIm6Tm+S
 yhDz/YrUfp3wbj7HYDf5LVcUMznJp+CjyyUjHqQAjZJoGVoPLFszZCH9Q7Fu6vHxEZY7Nd
 vy4s1brfVMledEE+usB/rA8qDmmh+xo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-mK2cCdfBPiWPDSLdSGeu0w-1; Wed, 20 Aug 2025 13:27:38 -0400
X-MC-Unique: mK2cCdfBPiWPDSLdSGeu0w-1
X-Mimecast-MFC-AGG-ID: mK2cCdfBPiWPDSLdSGeu0w_1755710858
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-32326e0c0baso146534a91.2
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 10:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755710858; x=1756315658;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uzagBq92TkRMbC0d57UvJ/4tJKLJIzHzfh71AktkPvw=;
 b=p8oeVGCOUuAPi74JSxcPq3arkVJPr0ogONl8s20m9RDqllRcBuTCJ+kogNNao5nZk+
 3bXlc0A/dnUiqdeyURaOn8L+VKA279HF9WAwxn8fmgMW/jQIDMiDlGeqD73WrsRKAhFN
 uddF115NbklXGFzldgrgiWXA7JHjb6qWADtQ4q2ZRJYgrVarfXWoqAJPCkgEETAYJ973
 1z9PQXDSKuCLAXrv7yA5rxKacpmhtvyqzc4iRtizp40ji8ITJPCqG5XQxt1A7bBmzj1K
 ulf8uqQjhbaVDmYNXv8TcGJe9PaZgHqM8ufoDduObmDVINOCylsutfEHsIyfOpIivRlB
 Cutw==
X-Gm-Message-State: AOJu0YysoVHwzlcmkDWgGGF+Re1CxA5eel3/deKK9DKCt3u0klRiGsh1
 M+mZa3Kz334pIi8MKCuKEbXXvR66+/P4nNzumisLuYhXw2w/6eF0dE4HbQ5c3n9e6Yl9HQuUpor
 sAo3GeO/A9bHuL2jXEzOJmP+8sZJWAFbPIE2w1TFlmTHDjxDnkjl4tCDW
X-Gm-Gg: ASbGncuDEg2Yf02TFUYIqLOyJ6XVFdVr1ccpeT8z4ypKKxFPnnnpE+Mj6Ph5zOUaoVW
 RKry4/CyHdBJibpw83Ub6XwVdnGeBnGa5+FWvZoayq4TZmWWDu/nhFLFWKzgxsyfMaoTHLd8sF7
 IWwEDaQrJlYVdlAU+5iDIJYrkv8zOVExPtXMdXe5/oFLcdhe6Txz51Mz+H9hBWZrmAZnV/tN2mw
 XG5z+qgFsFCJ3x1QiLfm8g9jI+ypd3sdzbsnASy2YRbu14LpCSRS5yq3/2IwpNi3GoNVr/3wD9a
 tjqIm2ttdrv0vBg7euhoR9rYlcMX09ymGdARh0BI+66qKS4X7SWe
X-Received: by 2002:a17:90b:5107:b0:31e:f397:b5b4 with SMTP id
 98e67ed59e1d1-324e13d8586mr4615473a91.22.1755710857566; 
 Wed, 20 Aug 2025 10:27:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNnuZUbnh/6+/EfT0CrrEgwZt7ATI+Xp4bc2Pe7nOQOIcnXQCflEOe4wMYG2S6lvnK2zp7mw==
X-Received: by 2002:a17:90b:5107:b0:31e:f397:b5b4 with SMTP id
 98e67ed59e1d1-324e13d8586mr4615420a91.22.1755710857005; 
 Wed, 20 Aug 2025 10:27:37 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.192.65])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-324e23df7fdsm2926766a91.0.2025.08.20.10.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 10:27:36 -0700 (PDT)
Date: Wed, 20 Aug 2025 22:57:22 +0530
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
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v11 09/27] migration: push Error **errp into
 qemu_loadvm_state_main()
Message-ID: <aKYFep9deUh0-EO9@armenon-kvm.bengluru.csb>
References: <20250813-propagate_tpm_error-v11-0-b470a374b42d@redhat.com>
 <20250813-propagate_tpm_error-v11-9-b470a374b42d@redhat.com>
 <874iu8z8w1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874iu8z8w1.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
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
On Fri, Aug 15, 2025 at 04:23:42PM -0300, Fabiano Rosas wrote:
> Arun Menon <armenon@redhat.com> writes:
> 
> > This is an incremental step in converting vmstate loading
> > code to report error via Error objects instead of directly
> > printing it to console/monitor.
> > It is ensured that qemu_loadvm_state_main() must report an error
> > in errp, in case of failure.
> > loadvm_process_command also sets the errp object explicitly.
> >
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >  migration/colo.c   |  5 +++--
> >  migration/savevm.c | 36 +++++++++++++++++++-----------------
> >  migration/savevm.h |  3 ++-
> >  3 files changed, 24 insertions(+), 20 deletions(-)
> >
> > diff --git a/migration/colo.c b/migration/colo.c
> > index 0ba22ee76a13e313793f653f43a728e3c433bbc1..a96e4dba15516b71d1b315c736c3b4879ff04e58 100644
> > --- a/migration/colo.c
> > +++ b/migration/colo.c
> > @@ -659,6 +659,7 @@ void migrate_start_colo_process(MigrationState *s)
> >  static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
> >                        QEMUFile *fb, QIOChannelBuffer *bioc, Error **errp)
> >  {
> > +    ERRP_GUARD();
> 
> With my suggestion below, this goes away.
Yeah.
> 
> >      uint64_t total_size;
> >      uint64_t value;
> >      Error *local_err = NULL;
> > @@ -686,11 +687,11 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
> >  
> >      bql_lock();
> >      cpu_synchronize_all_states();
> > -    ret = qemu_loadvm_state_main(mis->from_src_file, mis);
> > +    ret = qemu_loadvm_state_main(mis->from_src_file, mis, errp);
> >      bql_unlock();
> >  
> >      if (ret < 0) {
> > -        error_setg(errp, "Load VM's live state (ram) error");
> > +        error_prepend(errp, "Load VM's live state (ram) error: ");
> 
> Another one to leave out. There's enough information downstream
> already. Also, this "(ram)" doesn't look right.
Yes, shall remove it.
> 
> >          return;
> >      }
> >  
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 70e021597d884030c4a0dc2a7bc27d42a7371797..9ec07892cd6ea666431410657c840b6325377d97 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2105,7 +2105,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
> >      qemu_file_set_blocking(f, true);
> >  
> >      /* TODO: sanity check that only postcopiable data will be loaded here */
> > -    load_res = qemu_loadvm_state_main(f, mis);
> > +    load_res = qemu_loadvm_state_main(f, mis, &error_fatal);
> >  
> >      /*
> >       * This is tricky, but, mis->from_src_file can change after it
> > @@ -2407,6 +2407,7 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
> >   */
> >  static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
> >  {
> > +    ERRP_GUARD();
> >      int ret;
> >      size_t length;
> >      QIOChannelBuffer *bioc;
> > @@ -2456,9 +2457,9 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
> >          qemu_coroutine_yield();
> >      } while (1);
> >  
> > -    ret = qemu_loadvm_state_main(packf, mis);
> > +    ret = qemu_loadvm_state_main(packf, mis, errp);
> >      if (ret < 0) {
> > -        error_setg(errp, "VM state load failed: %d", ret);
> > +        error_prepend(errp, "Loading VM state failed: %d: ", ret);
> 
> This is getting out of hand for code review, may I suggest you
> artificially trigger these errors, look at the resulting message and
> remove all the unnecessary wrapping? Each error_prepend is a candidate
> for removal if it will just state "load failed".
> 
> Using error_prepend partly defeats the purpose of propagating errp. We
> should only use it when there's valuable information to be provided.
I understand. I shall remove error_prepend from where it is not required.
> 
> >      }
> >      trace_loadvm_handle_cmd_packaged_main(ret);
> >      qemu_fclose(packf);
> > @@ -3080,18 +3081,21 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
> >      return true;
> >  }
> >  
> > -int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
> > +int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
> > +                           Error **errp)
> >  {
> > +    ERRP_GUARD();
> >      uint8_t section_type;
> >      int ret = 0;
> > -    Error *local_err = NULL;
> >  
> >  retry:
> >      while (true) {
> >          section_type = qemu_get_byte(f);
> >  
> > -        ret = qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_dst, NULL);
> > +        ret = qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_dst, errp);
> >          if (ret) {
> > +            error_prepend(errp, "Failed to load device state section ID: %d: ",
> > +                          ret);
> 
> We could drop some extra words here, the term 'section' is already quite
> representative.
> 
> "Failed to load section ID: stream error: %d: "
Thanks, will do.
> 
> 
> >              break;
> >          }
> >  
> > @@ -3112,10 +3116,7 @@ retry:
> >              }
> >              break;
> >          case QEMU_VM_COMMAND:
> > -            ret = loadvm_process_command(f, &local_err);
> > -            if (ret < 0) {
> > -                warn_report_err(local_err);
> > -            }
> > +            ret = loadvm_process_command(f, errp);
> 
> Good.
> 
> >              trace_qemu_loadvm_state_section_command(ret);
> >              if ((ret < 0) || (ret == LOADVM_QUIT)) {
> >                  goto out;
> > @@ -3125,7 +3126,7 @@ retry:
> >              /* This is the end of migration */
> >              goto out;
> >          default:
> > -            error_report("Unknown savevm section type %d", section_type);
> > +            error_setg(errp, "Unknown savevm section type %d", section_type);
> 
> Not sure if they're referring to "savevm" here as a generic term for
> vmstate/migration or if it was intended to say: "savevm wrote a section
> type that this loadvm instance doesn't understand".
> 
> Since you're here, could you fix this? Migration errors from source and
> destination are often interleaved in logs, we don't want to see the
> "savevm" word in a destination-side error message. Just put a small note
> in the commit message, no need for another patch.
Yes, shall remove savevm and amend the commit message.
> 
> >              ret = -EINVAL;
> >              goto out;
> >          }
> > @@ -3133,6 +3134,9 @@ retry:
> >  
> >  out:
> >      if (ret < 0) {
> > +        if (*errp == NULL) {
> > +            error_setg(errp, "Loading VM state failed: %d", ret);
> > +        }
> 
> Another candidate for removal, then we avoid having to dereference errp.
This is added so that errp is set in case of failure in paths that are not
converted yet in the series. The out label comes in handy.
This is removed in the future patch 4648a1849a
> 
> >          qemu_file_set_error(f, ret);
> >  
> >          /* Cancel bitmaps incoming regardless of recovery */
> > @@ -3153,6 +3157,7 @@ out:
> >              migrate_postcopy_ram() && postcopy_pause_incoming(mis)) {
> >              /* Reset f to point to the newly created channel */
> >              f = mis->from_src_file;
> > +            error_free_or_abort(errp);
> 
> What's this about?
The errp needs to be freed and reset to NULL if we go into retry and
intend to use the variable again.
> 
> >              goto retry;
> >          }
> >      }
> > @@ -3186,10 +3191,7 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
> >  
> >      cpu_synchronize_all_pre_loadvm();
> >  
> > -    ret = qemu_loadvm_state_main(f, mis);
> > -    if (ret < 0) {
> > -        error_setg(errp, "Load VM state failed: %d", ret);
> > -    }
> > +    ret = qemu_loadvm_state_main(f, mis, errp);
> >      qemu_event_set(&mis->main_thread_load_event);
> >  
> >      trace_qemu_loadvm_state_post_main(ret);
> > @@ -3270,9 +3272,9 @@ int qemu_load_device_state(QEMUFile *f, Error **errp)
> >      int ret;
> >  
> >      /* Load QEMU_VM_SECTION_FULL section */
> > -    ret = qemu_loadvm_state_main(f, mis);
> > +    ret = qemu_loadvm_state_main(f, mis, errp);
> >      if (ret < 0) {
> > -        error_setg(errp, "Failed to load device state: %d", ret);
> > +        error_prepend(errp, "Failed to load device state: %d: ", ret);
Maybe this can also be removed.
> >          return ret;
> >      }
> >  
> > diff --git a/migration/savevm.h b/migration/savevm.h
> > index b12681839f0b1afa3255e45215d99c13a224b19f..c337e3e3d111a7f28a57b90f61e8f70b71803d4e 100644
> > --- a/migration/savevm.h
> > +++ b/migration/savevm.h
> > @@ -66,7 +66,8 @@ int qemu_save_device_state(QEMUFile *f);
> >  
> >  int qemu_loadvm_state(QEMUFile *f, Error **errp);
> >  void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
> > -int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
> > +int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
> > +                           Error **errp);
> >  int qemu_load_device_state(QEMUFile *f, Error **errp);
> >  int qemu_loadvm_approve_switchover(void);
> >  int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
> 

Regards,
Arun


