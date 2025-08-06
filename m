Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26663C87FD1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 07:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujYoT-0002AW-QR; Wed, 06 Aug 2025 03:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujYoR-00028i-Jj
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:43:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujYoO-0007mr-Uv
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754466227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qZlJDJUUVSGjDzw6z4RkVcvLJ8Ekth1X2IBB8d0QmmQ=;
 b=bpAoaiQUQgMGisGeVhwBxVdjkvTclY+SScYfaDRaaVhWKQtyI4bJke2RbOW7CM9fNqM4hy
 61H+8/VXqMUCwqT/DvdG0IWyRyryxDyjGUbyTr7GTMEOx04tMJoOKgMHYA3Uo859h/34v+
 Y51rTtXetnz/SSAgMR5+OAntIpUTyBg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-F4aGzXwgPnOSduwrFkMMlg-1; Wed, 06 Aug 2025 03:43:45 -0400
X-MC-Unique: F4aGzXwgPnOSduwrFkMMlg-1
X-Mimecast-MFC-AGG-ID: F4aGzXwgPnOSduwrFkMMlg_1754466225
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2400cbd4241so90018795ad.3
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 00:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754466223; x=1755071023;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qZlJDJUUVSGjDzw6z4RkVcvLJ8Ekth1X2IBB8d0QmmQ=;
 b=MV57o8VObdHpOi1EbUHu7qwmK9nEBhmDci9Toa9xsWWdFfHJ9VgGcK9qBo6ziTQm5G
 SelEKnrGNAkWuLonvkDlXtG2q193X922funfXRVHBPWaZiNNO8SC9esy0teo29dHeWAO
 J7f3UrqXY5bS46JDvzhgS55jQ+Wf5GEF2rDzWBkScq5W8C7fGSTlAr9zeORGHl5Kt4Jt
 Wqy6Yas1VUghLrdsaxCZAT8MH/ooXubzUouf8lkL6So9Ob+vygEtgs4x9NKCoZ60pvPC
 KmuH6b1ESmRHQ/LkSw+IVQUJsOM9VAIw0H3bb+ARGabN6DcXTa+i5dUcyV1tTkHmFnRQ
 rBLg==
X-Gm-Message-State: AOJu0YzWuHT8d5gAm9pggB7Uy86LXi6g1nswlmDKBOIPjnTmgX5hsa32
 Pb2JjRwbGGOmrv9PSm4/qE7jfFyWBci0Aw0Wc9PbHH+7NsrT4QV0DokHKDcsc6lEK/OVQ1vFy3n
 +CDEOxkWCChIelab7JP+gC696EFgkSQt7ncECngu5yTP3PvwBp0DnTDqU
X-Gm-Gg: ASbGncv1EIWUx4T7vfy0OzR8qWObWPPFjM0WAkiPALWlHYQbm0uGZKBZDjJDde+qiXN
 MXV6Dw//2U7/GhA8nyqLL+f9CwxUUC8g5w08oD9q+gWiDAYyKDzits1HXdX1OKGllGLvVLPAW5X
 j79kJdjxroZElKqkZ3+1OZgq3AyqnbWes8jpFzOPRVrSsnU8qDKmUjfk4xba0yvmYa/NaTci2Fw
 de3GUvTpP7Ow26VupgVs2fgr6YM2KHk+qgh6p2FQi0RAksYsgaD77imM/EqyDwm4g+6zyolamaa
 ZhnZ4J1EZJHVCTbFi9gOy+9ln7FugPjRbmarTWcBWIAxu5CvxhO2nw==
X-Received: by 2002:a17:902:f691:b0:240:3ed3:13e7 with SMTP id
 d9443c01a7336-2429f55dbe9mr27873385ad.42.1754466222715; 
 Wed, 06 Aug 2025 00:43:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFpmdnz1iksx7EPSN4vl6JciwM0fVXpyTZ85dQNRwQBJySj1+2xKwmSN7ryAe3p0XUVbxbVg==
X-Received: by 2002:a17:902:f691:b0:240:3ed3:13e7 with SMTP id
 d9443c01a7336-2429f55dbe9mr27873125ad.42.1754466222221; 
 Wed, 06 Aug 2025 00:43:42 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.249])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8975acbsm152378585ad.85.2025.08.06.00.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 00:43:41 -0700 (PDT)
Date: Wed, 6 Aug 2025 13:13:29 +0530
From: Arun Menon <armenon@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
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
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v9 09/27] migration: push Error **errp into
 qemu_loadvm_state_main()
Message-ID: <aJMHoZNCrThldW9w@armenon-kvm.bengluru.csb>
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
 <20250805-propagate_tpm_error-v9-9-123450810db7@redhat.com>
 <CAMxuvawFudjv_jHY6Gz2wfmFFXT9UNwrB1MnmXVpGFBrPr31Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvawFudjv_jHY6Gz2wfmFFXT9UNwrB1MnmXVpGFBrPr31Yw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Marc-André,
Thanks for the review.

On Wed, Aug 06, 2025 at 11:34:23AM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Aug 5, 2025 at 10:29 PM Arun Menon <armenon@redhat.com> wrote:
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
> >  migration/savevm.c | 33 ++++++++++++++++++++-------------
> >  migration/savevm.h |  3 ++-
> >  3 files changed, 25 insertions(+), 16 deletions(-)
> >
> > diff --git a/migration/colo.c b/migration/colo.c
> > index
> > 0ba22ee76a13e313793f653f43a728e3c433bbc1..a96e4dba15516b71d1b315c736c3b4879ff04e58
> > 100644
> > --- a/migration/colo.c
> > +++ b/migration/colo.c
> > @@ -659,6 +659,7 @@ void migrate_start_colo_process(MigrationState *s)
> >  static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
> >                        QEMUFile *fb, QIOChannelBuffer *bioc, Error **errp)
> >  {
> > +    ERRP_GUARD();
> >      uint64_t total_size;
> >      uint64_t value;
> >      Error *local_err = NULL;
> > @@ -686,11 +687,11 @@ static void
> > colo_incoming_process_checkpoint(MigrationIncomingState *mis,
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
> >          return;
> >      }
> >
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index
> > f3b91c8ae0eee6078406081f0bd7f686fed28601..ad3dd9b172afc541f104d2187a79bafa8e380466
> > 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2105,7 +2105,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
> >      qemu_file_set_blocking(f, true);
> >
> >      /* TODO: sanity check that only postcopiable data will be loaded here
> > */
> > -    load_res = qemu_loadvm_state_main(f, mis);
> > +    load_res = qemu_loadvm_state_main(f, mis, NULL);
> >
> 
> What's the rationale to make the function silent or not gather the error?
> It seems error reporting could be improved below this. Maybe pass
> &error_warn here, and add a second TODO to improve error handling?

There is a separate patch which handles postcopy_ram_listen_thread
 - PATCH 22/27
Therefore I left this as is. But yes, we can pass &error_warn here.
> 
> 
> >
> >      /*
> >       * This is tricky, but, mis->from_src_file can change after it
> > @@ -2407,6 +2407,7 @@ static int
> > loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
> >   */
> >  static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error
> > **errp)
> >  {
> > +    ERRP_GUARD();
> >      int ret;
> >      size_t length;
> >      QIOChannelBuffer *bioc;
> > @@ -2456,9 +2457,9 @@ static int
> > loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
> >          qemu_coroutine_yield();
> >      } while (1);
> >
> > -    ret = qemu_loadvm_state_main(packf, mis);
> > +    ret = qemu_loadvm_state_main(packf, mis, errp);
> >      if (ret < 0) {
> > -        error_setg(errp, "VM state load failed: %d", ret);
> > +        error_prepend(errp, "Loading VM state failed: %d: ", ret);
> >      }
> >      trace_loadvm_handle_cmd_packaged_main(ret);
> >      qemu_fclose(packf);
> > @@ -3074,8 +3075,10 @@ static bool
> > postcopy_pause_incoming(MigrationIncomingState *mis)
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
> >
> > @@ -3083,8 +3086,10 @@ retry:
> >      while (true) {
> >          section_type = qemu_get_byte(f);
> >
> > -        ret = qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_dst,
> > NULL);
> > +        ret = qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_dst,
> > errp);
> >          if (ret) {
> > +            error_prepend(errp, "Failed to load device state section ID:
> > %d: ",
> > +                          ret);
> >              break;
> >          }
> >
> > @@ -3105,7 +3110,7 @@ retry:
> >              }
> >              break;
> >          case QEMU_VM_COMMAND:
> > -            ret = loadvm_process_command(f, NULL);
> > +            ret = loadvm_process_command(f, errp);
> >              trace_qemu_loadvm_state_section_command(ret);
> >              if ((ret < 0) || (ret == LOADVM_QUIT)) {
> >                  goto out;
> > @@ -3115,7 +3120,7 @@ retry:
> >              /* This is the end of migration */
> >              goto out;
> >          default:
> > -            error_report("Unknown savevm section type %d", section_type);
> > +            error_setg(errp, "Unknown savevm section type %d",
> > section_type);
> >              ret = -EINVAL;
> >              goto out;
> >          }
> > @@ -3123,6 +3128,9 @@ retry:
> >
> >  out:
> >      if (ret < 0) {
> > +        if (*errp == NULL) {
> > +            error_setg(errp, "Loading VM state failed: %d", ret);
> > +        }
> >          qemu_file_set_error(f, ret);
> >
> >          /* Cancel bitmaps incoming regardless of recovery */
> > @@ -3143,6 +3151,8 @@ out:
> >              migrate_postcopy_ram() && postcopy_pause_incoming(mis)) {
> >              /* Reset f to point to the newly created channel */
> >              f = mis->from_src_file;
> > +            error_free(*errp);
> > +            *errp = NULL;
> >              goto retry;
> >          }
> >      }
> > @@ -3176,10 +3186,7 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
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
> > @@ -3260,9 +3267,9 @@ int qemu_load_device_state(QEMUFile *f, Error **errp)
> >      int ret;
> >
> >      /* Load QEMU_VM_SECTION_FULL section */
> > -    ret = qemu_loadvm_state_main(f, mis);
> > +    ret = qemu_loadvm_state_main(f, mis, errp);
> >      if (ret < 0) {
> > -        error_setg(errp, "Failed to load device state: %d", ret);
> > +        error_prepend(errp, "Failed to load device state: %d: ", ret);
> >          return ret;
> >      }
> >
> > diff --git a/migration/savevm.h b/migration/savevm.h
> > index
> > b12681839f0b1afa3255e45215d99c13a224b19f..c337e3e3d111a7f28a57b90f61e8f70b71803d4e
> > 100644
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
> >
> > --
> > 2.50.1
> >
> >
Regards,
Arun


