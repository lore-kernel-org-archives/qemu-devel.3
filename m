Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DC7C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 10:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujb0v-0006sI-RD; Wed, 06 Aug 2025 06:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ujb0j-0006l9-8e; Wed, 06 Aug 2025 06:04:47 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ujb0h-0000nB-01; Wed, 06 Aug 2025 06:04:40 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4b08c56d838so8313601cf.0; 
 Wed, 06 Aug 2025 03:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754474677; x=1755079477; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H48WduNjdgHJ0TgAi/YPlgpL0QBWwloFgkLKfykVXUY=;
 b=SdDEuE4kk5Xfcll+zZI+e/9lrQUfm+lX0A9pdYCRKXImPtMEZV+ItWxMMBJVtzJO8k
 XCdIb77gN/H7N+4iYwavJ1fIUY3iYLPLV4BKRfB6V50gABmgLdrevjijenVlVxukuH7l
 MMkJE8PmfSQBvvgKeNMuKWazgy6tbuoCy2mvKYu3jd82Z5KUdbe3eAGNsjpci2pKbSO3
 s5TraYRXWV793/DSQx66kxqGsrK75/UB4qgCgfNKwBUMHxSSGFxXQ9dycEhNW6J1giLd
 TIZOUe4+xBjxzfBojauZQ64yS3sw3rfj0h7TTWWhI1idixlujArGqxTrNS8+3VEzSH6R
 OiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754474677; x=1755079477;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H48WduNjdgHJ0TgAi/YPlgpL0QBWwloFgkLKfykVXUY=;
 b=XlyOZYbr/p/BobQ7EAbVEQVSpNb93onaFFaOR1fvb9SZMFTEF5py8jRuKA6Lt8SbpZ
 FuV5hzezvXbHn7IZTZBwIrTirUUjFCOBE7450kvJUID/luiwL2L0aZBzZZCSfrB/tmZP
 75kBxn6KnVC6GvQw4iB+xrS7EndYIbgwmOomOh+vF/ukeiCPowPlVm361tDKtyDj8030
 gOmWtOEVamOfElEWOKi7YmMcQuk9GJN3Hkr6jbOF5TqiHlmr6zjBAtDNAyfuK54PZVtV
 9Hyoro4VgAvWibzDOw1GVzZfWfpLd6FpIvvyW1UBdvtGgCIZBredSke04txTPh8ciOJJ
 pUMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLFWKFbZBQl6Nbs6yjVTllr9TMIQL2VxsLlspJft3SKx0fM+OPtqGNwy3MHctlWxb9i6aUPtEUoQ==@nongnu.org,
 AJvYcCXKNU2BPqfPmOXjFq5hZY+j/uQw44lOaMmEWCNF6qNVeUnoBLDVi+rMsHlsLXJAQ4zG2qLvgSwudyMv0A==@nongnu.org
X-Gm-Message-State: AOJu0YwloxdCO7hVbLh+CnxRldY2QHicJfqZSeIjINTA92b1mzDZSh+j
 f2ZPUv+VbQIa5LaQk0KD4YfaxOi+GEuLpcb1SQH0r9Ww+Dk3K6mRWSxBqklC87BKc2n0GUmvp2e
 2Ft43vDmTrkK+Oxi0K1YR5jHkRne3d7M=
X-Gm-Gg: ASbGncuW/+C2N/MrxLHkvYnbdA4kL5xQ8ZuoBHqcLng4g62pKkNMvLrs+SGxwWNCyC0
 MlPvF6EUOOYdeFPNR9wWO71rbBh9iM4VaUCwtGkVIUP6aX7fh6ylERqlXtjmFsyfLLf+5r3FAoz
 yFV6xf9OQQ0FbI6vcMBQI7D8Wsy52BVbcnWGjTfEod4ZUka3zkvC3R2IvGRnbPRstLa0bVtdN8o
 olFoStm
X-Google-Smtp-Source: AGHT+IFIeMdOq2BTObWOvODPaU0NMwJKeHC3KBPHrXb8feEvF+4G1n5JR1ZofAMSyS9e6n9LJm/AyWcU1T2WYslLYxU=
X-Received: by 2002:a05:622a:298f:b0:4b0:64ba:f2dd with SMTP id
 d75a77b69052e-4b09127d47bmr34719861cf.11.1754474677016; Wed, 06 Aug 2025
 03:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
 <20250805-propagate_tpm_error-v9-20-123450810db7@redhat.com>
 <CAMxuvazyJ89i=Yw1j49hSCmBvnuqeB+dMG3ms0=NjzhaB9Uw-A@mail.gmail.com>
 <aJMm5Qfdegtu9VNN@armenon-kvm.bengluru.csb>
In-Reply-To: <aJMm5Qfdegtu9VNN@armenon-kvm.bengluru.csb>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 6 Aug 2025 14:04:25 +0400
X-Gm-Features: Ac12FXyPDaiGtpo9LuuOc8FXka7YkS5E0kFS1t14An0utKUOnIfuuEeDqu3Ac8k
Message-ID: <CAJ+F1CLVentLao9yL2pMsnYUSHV01z1mpY=jXF2DXp9mq9-dVQ@mail.gmail.com>
Subject: Re: [PATCH v9 20/27] migration: push Error **errp into
 loadvm_process_enable_colo()
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x833.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Wed, Aug 6, 2025 at 1:58=E2=80=AFPM Arun Menon <armenon@redhat.com> wrot=
e:
>
> Hi Marc-Andr=C3=A9,
> Thanks for the review and the Reviewed-by tag.
>
> On Wed, Aug 06, 2025 at 12:07:25PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Tue, Aug 5, 2025 at 10:31=E2=80=AFPM Arun Menon <armenon@redhat.com>=
 wrote:
> >
> > > This is an incremental step in converting vmstate loading
> > > code to report error via Error objects instead of directly
> > > printing it to console/monitor.
> > > It is ensured that loadvm_process_enable_colo() must report an error
> > > in errp, in case of failure.
> > >
> > > Signed-off-by: Arun Menon <armenon@redhat.com>
> > >
> >
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> >
> > > ---
> > >  include/migration/colo.h |  2 +-
> > >  migration/migration.c    | 12 ++++++------
> > >  migration/ram.c          |  8 ++++----
> > >  migration/ram.h          |  2 +-
> > >  migration/savevm.c       | 26 ++++++++++++++------------
> > >  5 files changed, 26 insertions(+), 24 deletions(-)
> > >
> > > diff --git a/include/migration/colo.h b/include/migration/colo.h
> > > index
> > > 43222ef5ae6adc3f7d8aa6a48bef79af33d09208..d4fe422e4d335d3bef4f860f564=
00fcd73287a0e
> > > 100644
> > > --- a/include/migration/colo.h
> > > +++ b/include/migration/colo.h
> > > @@ -25,7 +25,7 @@ void migrate_start_colo_process(MigrationState *s);
> > >  bool migration_in_colo_state(void);
> > >
> > >  /* loadvm */
> > > -int migration_incoming_enable_colo(void);
> > > +int migration_incoming_enable_colo(Error **errp);
> > >  void migration_incoming_disable_colo(void);
> > >  bool migration_incoming_colo_enabled(void);
> > >  bool migration_incoming_in_colo_state(void);
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index
> > > 6962dc7d7f3e0121d28994c98f12f9f2258343d7..4a76d7ed730589bae87115368b0=
bf4819f8b161e
> > > 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -623,22 +623,22 @@ void migration_incoming_disable_colo(void)
> > >      migration_colo_enabled =3D false;
> > >  }
> > >
> > > -int migration_incoming_enable_colo(void)
> > > +int migration_incoming_enable_colo(Error **errp)
> > >  {
> > >  #ifndef CONFIG_REPLICATION
> > > -    error_report("ENABLE_COLO command come in migration stream, but =
the "
> > > -                 "replication module is not built in");
> > > +    error_setg(errp, "ENABLE_COLO command come in migration stream, =
but
> > > the "
> > > +               "replication module is not built in");
> > >      return -ENOTSUP;
> > >  #endif
> > >
> > >      if (!migrate_colo()) {
> > > -        error_report("ENABLE_COLO command come in migration stream, =
but
> > > x-colo "
> > > -                     "capability is not set");
> > > +        error_setg(errp, "ENABLE_COLO command come in migration stre=
am"
> > > +                   ", but x-colo capability is not set");
> > >          return -EINVAL;
> > >      }
> > >
> > >      if (ram_block_discard_disable(true)) {
> > > -        error_report("COLO: cannot disable RAM discard");
> > > +        error_setg(errp, "COLO: cannot disable RAM discard");
> > >          return -EBUSY;
> > >      }
> > >      migration_colo_enabled =3D true;
> > > diff --git a/migration/ram.c b/migration/ram.c
> > > index
> > > 6a0dcc04f436524a37672c41c38f201f06773374..995431c9e320f443c385c29d664=
d62e18c1afd90
> > > 100644
> > > --- a/migration/ram.c
> > > +++ b/migration/ram.c
> > > @@ -3576,7 +3576,7 @@ static void colo_init_ram_state(void)
> > >   * memory of the secondary VM, it is need to hold the global lock
> > >   * to call this helper.
> > >   */
> > > -int colo_init_ram_cache(void)
> > > +int colo_init_ram_cache(Error **errp)
> > >  {
> > >      RAMBlock *block;
> > >
> > > @@ -3585,9 +3585,9 @@ int colo_init_ram_cache(void)
> > >              block->colo_cache =3D qemu_anon_ram_alloc(block->used_le=
ngth,
> > >                                                      NULL, false, fal=
se);
> > >              if (!block->colo_cache) {
> > > -                error_report("%s: Can't alloc memory for COLO cache =
of
> > > block %s,"
> > > -                             "size 0x" RAM_ADDR_FMT, __func__,
> > > block->idstr,
> > > -                             block->used_length);
> > > +                error_setg(errp, "Can't alloc memory for COLO cache =
of "
> > > +                           "block %s, size 0x" RAM_ADDR_FMT,
> > > +                           block->idstr, block->used_length);
> > >                  RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> > >                      if (block->colo_cache) {
> > >                          qemu_anon_ram_free(block->colo_cache,
> > > block->used_length);
> > > diff --git a/migration/ram.h b/migration/ram.h
> > > index
> > > 275709a99187f9429ccb4111e05281ec268ba0db..24cd0bf585762cfa1e86834dc03=
c6baeea2f0627
> > > 100644
> > > --- a/migration/ram.h
> > > +++ b/migration/ram.h
> > > @@ -109,7 +109,7 @@ void ramblock_set_file_bmap_atomic(RAMBlock *bloc=
k,
> > > ram_addr_t offset,
> > >                                     bool set);
> > >
> > >  /* ram cache */
> > > -int colo_init_ram_cache(void);
> > > +int colo_init_ram_cache(Error **errp);
> > >  void colo_flush_ram_cache(void);
> > >  void colo_release_ram_cache(void);
> > >  void colo_incoming_start_dirty_log(void);
> > > diff --git a/migration/savevm.c b/migration/savevm.c
> > > index
> > > 938adb20270adbf9546b0884d0877c25c3f0f816..a6b71a958aeda31e89043f8103b=
fe2fc89542fb5
> > > 100644
> > > --- a/migration/savevm.c
> > > +++ b/migration/savevm.c
> > > @@ -2519,15 +2519,21 @@ static int
> > > loadvm_handle_recv_bitmap(MigrationIncomingState *mis,
> > >      return 0;
> > >  }
> > >
> > > -static int loadvm_process_enable_colo(MigrationIncomingState *mis)
> > > +static int loadvm_process_enable_colo(MigrationIncomingState *mis,
> > > +                                      Error **errp)
> > >  {
> > > -    int ret =3D migration_incoming_enable_colo();
> > > +    ERRP_GUARD();
> > > +    int ret;
> > >
> > > -    if (!ret) {
> > > -        ret =3D colo_init_ram_cache();
> > > -        if (ret) {
> > > -            migration_incoming_disable_colo();
> > > -        }
> > > +    ret =3D migration_incoming_enable_colo(errp);
> > > +    if (ret < 0) {
> > > +        return ret;
> > > +    }
> > > +
> > > +    ret =3D colo_init_ram_cache(errp);
> > > +    if (ret) {
> > >
> >
> > Note: here you keep the "ret" error condition !=3D0, ok.
> >
> > colo_init_ram_cache(), returns -errno on error. Although errno should
> > remain unchanged on success (during qemu_anon_ram_free etc), I think it
> > would be safer to convert the function to follow the recommended
> > bool-valued function for true on success / false on failure instead.
>
> There has been some discussion on this here:
> https://lore.kernel.org/all/aH5AtUcjI3HYXdBe@redhat.com/
> It has been advised not to use bool return.

Ok, but the usage of errno in that function seems fragile as other
functions could clear it before it is returned. Can you make another
patch to change the return value to -1 and document it?

thanks

>
> >
> >
> > > +        error_prepend(errp, "failed to init colo RAM cache: %d: ", r=
et);
> > > +        migration_incoming_disable_colo();
> > >
> >      }
> > >      return ret;
> > >  }
> > > @@ -2646,11 +2652,7 @@ static int loadvm_process_command(QEMUFile *f,
> > > Error **errp)
> > >          return loadvm_handle_recv_bitmap(mis, len, errp);
> > >
> > >      case MIG_CMD_ENABLE_COLO:
> > > -        ret =3D loadvm_process_enable_colo(mis);
> > > -        if (ret < 0) {
> > > -            error_setg(errp, "Failed to load device state command: %=
d",
> > > ret);
> > > -        }
> > > -        return ret;
> > > +        return loadvm_process_enable_colo(mis, errp);
> > >
> > >      case MIG_CMD_SWITCHOVER_START:
> > >          ret =3D loadvm_postcopy_handle_switchover_start();
> > >
> > > --
> > > 2.50.1
> > >
> > >
> Regards,
> Arun
>
>


--=20
Marc-Andr=C3=A9 Lureau

