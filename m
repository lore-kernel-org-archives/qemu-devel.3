Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9712FC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 14:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd7yB-0002nq-RW; Fri, 26 Jun 2026 10:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wd7y7-0002ni-EP
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 10:55:47 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wd7y4-0007GY-WE
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 10:55:46 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-44755d837e8so731710fac.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 07:55:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782485742; cv=none;
 d=google.com; s=arc-20260327;
 b=nW8NsoT5Rc5mLBEpYGRAV19PrwaQeFb7cZg2mUg0XLX/HBgncoBrdf5Vo7XspsZX3Y
 2gKz5evweNsyeKTodwLMGesjgexZqisqpoG3sJFn9WUESPs6hQYAmYcGxZ80orOs2ZEd
 MDvZZZnb4dckbeEJ4Y0pWPiSZGNYq2t24gurEzFgN3fW7K/Pq71TQZhbS0NNc8TV20Ja
 16iQYPrUhBRCMqMrDwOB3KgipWijeyNXY96N7pj3IiZcHTmRrWhCDuyIseKt2NEfLOND
 9elimZQI+X2P+JXZUvDEc6jv8+zvQFQS5SeUJ2SshuGRJSxIbugenxJWKN7YjKYrtKOp
 1YdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pD8P5NRPQfxkH6rLhMMn2egGcCY78EFohNDmTKQq0e8=;
 fh=M53F9OyMyXaprNYz5ycy0QOslAkZgr8cpZk3PVQ0YK0=;
 b=TOjk0wGO9HW1tEF/efHgmMfiZC2QrGzd5Gz7WZpxbPQCGTocHkxV4DFiK8nXAfAMe2
 KhnX8rNNvMJbqj/1gxCmyWgOfsfmt0eiqBLf0hoIPrN9zCncHLq4JJpCP5ILNO2twWsI
 gpxahjoz0DvWW29+P2LGfr9rCW1bzIiw8E4QhWns1jpjf2ufLCnHarTVuioha3uQbdvs
 eGzKKCpOqOVCj9cTyurrY/9XAL0DOkd9D1V1vMV3VJnayjzjJsEwh87o3Kqca0+Dne7M
 DgUWutLJxqGWd3qv2PugtLw/SMfFeFfbZcnN/FnmlVntQTY5b5U1cQkgYF10NJCnPGJi
 ResQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782485742; x=1783090542; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pD8P5NRPQfxkH6rLhMMn2egGcCY78EFohNDmTKQq0e8=;
 b=XhGybrE7MUks9axmZdb0qwoZbeBHG+9Gp9I3Vu+R+JluBP13KavmevpbW1DU20oLHQ
 XfLd69B3cMokVsVl7jD1TU/Y9gPggy8gHcfmZy9rPhFFc6nttR7EL0yYYqwncAMdQBn7
 9mqzUJWCDQqSpvu+wM29E0qfkPns7C/PZZtWvh+y/SsLSiVUOGssNbaP3l7UB4JBCGM1
 uYG5AmkA/ykV65+4nBsVDTuko/14DV9S7jvqlBfJ1o69soa9rbooDHgdCj/hzl3KWATI
 yMAlFXTUaogbvoKQtmvSK7WQKQm01lph4umAaoI7D68xbUBRnrHsMWdgXJWoEpbdEYtO
 WTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782485742; x=1783090542;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pD8P5NRPQfxkH6rLhMMn2egGcCY78EFohNDmTKQq0e8=;
 b=SUt3f8BYQ0tPm8y8+0Yo1oPLcyiyIY9Nl1RpaaTwg9NKzhHXVqlwZa4hWiG8T/DDRV
 jV8P2GkA356Hv65s9R6+Nz73nlIlVy4nd2+CTWYiXgRlChHdwoXE35vPMOnd3ro7ru/8
 6KdXEDerbtGhMMqsSzX2UoSmy0PVTJgjphFfu5MT/g7p1OjrkE7fc7fWUI71f0OHhJsk
 F0X+DlkgUQVaOiYdyaKvgglu5L6SBJUNjGJ2uIlamRQA5UZyuovBVi1fr2TdV8r3zszS
 QL9JMqbJF5EUriNL4aIMqvKmn3llofreFoBXWdxq1kDvsA0NSWS48egxA43hYKtIQj4J
 t87g==
X-Gm-Message-State: AOJu0Yx4xmF4tZ0ObLVb8ZosuTcVqaOYamuL+pn7B/3WkobkqBUloY0w
 H4DtA/h317kg3W+pUTdf9Bgp0f7VcKqgZjWfHeoSTucqFFIyri5b7HuE8q9ylHLTghnWCUY8HLn
 U6CMfLMObP7CR/GqbM1VVxPVcELj9nzQ=
X-Gm-Gg: AfdE7ckHgCRnpFt7KNL+yOfuhdRMXf0jLfPvF92tMEcxuV/8rrJatpZ02fMQHi+Q8+t
 cx/N91fog24tyODWOwTOyuU/uCcbbI1PHbALFzXF/SMsVOMJkPUmubNUQWLFujJQL68THRFopC8
 3OmF/KyG3hgqDufRIwMAWZSJQPTXifwunByXF4Wu2whbdAtC/OVoekXpCP4iM8HFucQjMwcD0/p
 Zb/mS4yRcxFOj8uHdEURPW1IM+D+G54c9/xq3QFeaK0Fnj4o57OurI9TExvnXASUPXGIyk0t1n6
 N/ztwPengBxrT/jsb0dX2oqoGp0=
X-Received: by 2002:a05:6870:15c7:b0:448:558c:d8cb with SMTP id
 586e51a60fabf-448558cf013mr173589fac.41.1782485742015; Fri, 26 Jun 2026
 07:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260618032010.88755-1-aadeshveer07@gmail.com>
 <20260618032010.88755-5-aadeshveer07@gmail.com> <87y0g4nfdm.fsf@suse.de>
In-Reply-To: <87y0g4nfdm.fsf@suse.de>
From: Aadeshveer Singh <aadeshveer07@gmail.com>
Date: Fri, 26 Jun 2026 20:25:30 +0530
X-Gm-Features: AVVi8CfgKydFKAZERtqFV1d05SvfCcYpGqXAStl6wVnJyeiIQL3CWcR1r1a6o7o
Message-ID: <CA++cPvKY1Fh1xaq+HXWZnUeh_a25MtfZWJXK+8dXuQtTp9odbg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] migration: write up code to run fast snapshot
 load in qemu_loadvm_state
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, pbonzini@redhat.com, 
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=aadeshveer07@gmail.com; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jun 24, 2026 at 8:40=E2=80=AFPM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> Aadeshveer Singh <aadeshveer07@gmail.com> writes:
>
> > When both mapped-ram and postcopy-ram are set, divert from
> > qemu_loadvm_state to run fast snapshot load
> >
> > Initialize postcopy RAM state and register RAM Blocks with userfaultfd
> > via ram_postcopy_incoming_init() and postcopy_ram_incoming_setup().
> > Launch fault thread before VM to serve faults for some hardwares
> > emulation that need to read RAM (like vapic devices). Populate bitmaps
> > and offset tables while reading file in qemu_loadvm_state_main. Call to
> > qemu_loadvm_state_postcopy() which starts the VM using
> > loadvm_postcopy_handle_run_bh() and launches eager load thread.
> >
> > Skip scheduling process_incoming_migration_bh() in
> > process_incoming_migration_co(), for fast snapshot load as the state
> > cleanup is managed by eager load thread on completion.
> >
> > Skip setting migration status to ACTIVE in process_incoming_migration_c=
o
> > and set set it to POSTCOPY_DEVICE in qemu_loadvm_state() itself.
> >
> > Remove the capability check that rejected mapped-ram and postcopy-ram
> > being set simultaneously, as this combination now corresponds to fast
> > snapshot load. The corresponding test will be updated in following
> > patch.
> >
> > Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> > ---
> >  migration/migration.c | 10 ++++++---
> >  migration/options.c   |  6 -----
> >  migration/savevm.c    | 52 +++++++++++++++++++++++++++++++++++++++++--
> >  migration/savevm.h    |  2 ++
> >  4 files changed, 59 insertions(+), 11 deletions(-)
> >
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 074d3f2c69..e1ac310e20 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -756,8 +756,10 @@ process_incoming_migration_co(void *opaque)
> >
> >      mis->largest_page_size =3D qemu_ram_pagesize_largest();
> >      postcopy_state_set(POSTCOPY_INCOMING_NONE);
> > -    migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
> > -                      MIGRATION_STATUS_ACTIVE);
> > +    if (!migrate_fast_snapshot_load()) {
> > +        migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
> > +                          MIGRATION_STATUS_ACTIVE);
> > +    }
> >
> >      mis->loadvm_co =3D qemu_coroutine_self();
> >      ret =3D qemu_loadvm_state(mis->from_src_file, &local_err);
> > @@ -786,7 +788,9 @@ process_incoming_migration_co(void *opaque)
> >          colo_incoming_co();
> >      }
> >
> > -    migration_bh_schedule(process_incoming_migration_bh, mis);
> > +    if (!migrate_fast_snapshot_load()) {
> > +        migration_bh_schedule(process_incoming_migration_bh, mis);
> > +    }
>
> This inconspicuous 4 line hunk will cause bugs for years to come. =3DD
>
> We should try to include the fast_snapshot actions within the incoming
> BH so the paths are the same in both types of migration. Ideally we'd
> merge all the BHs in a single one.
>

Agreed! Bypassing the cleanup BH was definitely fragile.

I am working on adding the checks within the BH itself. Will resolve this i=
n v2.

> >      goto out;
> >
> >  fail:
> > diff --git a/migration/options.c b/migration/options.c
> > index 5f80dd5b42..3f447cf7b2 100644
> > --- a/migration/options.c
> > +++ b/migration/options.c
> > @@ -732,12 +732,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_=
caps, Error **errp)
> >                         "Mapped-ram migration is incompatible with xbzr=
le");
> >              return false;
> >          }
> > -
> > -        if (new_caps[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
> > -            error_setg(errp,
> > -                       "Mapped-ram migration is incompatible with post=
copy");
> > -            return false;
> > -        }
>
> Just checking: Does this allow any type of migration that is not covered
> by this series?
>

By removing this check, we are specifically allowing the combination
of mapped-ram and postcopy-ram.

Since mapped-ram fundamentally requires a file based migration (and
enforces this elsewhere in the capability checks), this combination
triggers the file-based postcopy behavior introduced in this series.
It does not enable this combination for network-based postcopy because
the underlying mapped-ram constraints still apply and block non-file
transports.

> >      }
> >
> >      /*
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 23adaf9dd9..f10cc3c2fc 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2959,6 +2959,32 @@ static bool postcopy_pause_incoming(MigrationInc=
omingState *mis)
> >      return true;
> >  }
> >
> > +/*
> > + * Starts the VM and launches the eager thread for fast snapshot load
> > + */
> > +int qemu_loadvm_state_postcopy(QEMUFile *f, MigrationIncomingState *mi=
s,
> > +                               Error **errp)
> > +{
> > +    ERRP_GUARD();
> > +    int ret =3D 0;
> > +
> > +    postcopy_state_set(POSTCOPY_INCOMING_RUNNING);
> > +
> > +    migration_bh_schedule(loadvm_postcopy_handle_run_bh, mis);
> > +
> > +    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
> > +                      MIGRATION_STATUS_POSTCOPY_ACTIVE);
> > +
> > +    ret =3D postcopy_ram_eager_load_setup(mis);
> > +    if (ret) {
> > +        error_prepend(errp,
> > +                      "Failed to setup eager load for fast snapshot lo=
ad: ");
> > +        return ret;
> > +    }
> > +
> > +    return ret;
> > +}
> > +
> >  int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
> >                             Error **errp)
> >  {
> > @@ -3067,8 +3093,30 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
> >
> >      cpu_synchronize_all_pre_loadvm();
> >
> > -    ret =3D qemu_loadvm_state_main(f, mis, errp);
> > -    qemu_event_set(&mis->main_thread_load_event);
> > +    if (migrate_fast_snapshot_load()) {
> > +        migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
> > +                          MIGRATION_STATUS_POSTCOPY_DEVICE);
> > +
> > +        if (ram_postcopy_incoming_init(mis, errp)) {
> > +            return -EINVAL;
> > +        }
> > +
> > +        postcopy_state_set(POSTCOPY_INCOMING_LISTENING);
> > +        if (postcopy_ram_incoming_setup(mis)) {
> > +            return -EINVAL;
> > +        }
> > +
> > +        ret =3D qemu_loadvm_state_main(f, mis, errp);
> > +
> > +        qemu_event_set(&mis->main_thread_load_event);
> > +
> > +        if (ret =3D=3D 0) {
> > +            ret =3D qemu_loadvm_state_postcopy(f, mis, errp);
> > +        }
> > +    } else {
> > +        ret =3D qemu_loadvm_state_main(f, mis, errp);
> > +        qemu_event_set(&mis->main_thread_load_event);
> > +    }
> >
> >      trace_qemu_loadvm_state_post_main(ret);
> >
> > diff --git a/migration/savevm.h b/migration/savevm.h
> > index 96fdf96d4e..9656acd7fe 100644
> > --- a/migration/savevm.h
> > +++ b/migration/savevm.h
> > @@ -67,6 +67,8 @@ void qemu_savevm_send_postcopy_ram_discard(QEMUFile *=
f, const char *name,
> >  int qemu_save_device_state(QEMUFile *f, Error **errp);
> >  int qemu_loadvm_state(QEMUFile *f, Error **errp);
> >  void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
> > +int qemu_loadvm_state_postcopy(QEMUFile *f, MigrationIncomingState *mi=
s,
> > +                               Error **errp);
> >  int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
> >                             Error **errp);
> >  int qemu_load_device_state(QEMUFile *f, Error **errp);

