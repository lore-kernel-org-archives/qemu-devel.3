Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F479E6FE23
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 16:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY5Eq-0000oZ-O3; Tue, 23 Dec 2025 11:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY5Ek-0000nZ-8Y
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 11:27:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY5Eg-0005yc-Ph
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 11:27:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766507265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NJg3H8BbPpKkHO7uLlK5kE4EC17eVLZI0+V9NwByWWs=;
 b=d5wkJCDDko/RioLeGLQNALC5KYT5Z5ZZSYm9uvUkKHt820Jaa2vK3YGybjOh04aOj15sXq
 xug6butpnk3+MvBGgsrXObSVA0M9vQhDxvhA7kSYnCJAKtDWH81JIRv/yBTZjmS1Tmay4O
 VL7cHh9orhDqux0hPagWcYAPEXYrhQc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-6vu2XjUrMf2oNdLGTpah5Q-1; Tue, 23 Dec 2025 11:27:42 -0500
X-MC-Unique: 6vu2XjUrMf2oNdLGTpah5Q-1
X-Mimecast-MFC-AGG-ID: 6vu2XjUrMf2oNdLGTpah5Q_1766507261
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b2217a9c60so1929282285a.3
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 08:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766507261; x=1767112061; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NJg3H8BbPpKkHO7uLlK5kE4EC17eVLZI0+V9NwByWWs=;
 b=gIamh/gshQMxJQVFPJjheZ1NVVXBsMeZSv7KRwDNXzDT/txmeAxjEsL3rosMXUgose
 OTVOKn8dBzGZaPW7gNauo2SIcUDYyTfpmV5Hk4736FrniCfvlSZwBJt1tcwdJ8Y4Iic0
 K7RYCX4tvutDzRv+5cUAFQbgq3SNAtQRcSUY56clg8fQQuvTFvQwKjdmW/r2JYphMSdF
 ohfYerc9jAaP3+TK5EQnTBjd/yaDu+p7kIFoT80xHMWHTTqWSHh70jmFIMJC2iBPmp7X
 fZJ1pBM8mE4aBLAzkSt9fIDq6p3535wLLdbb243hS73/5O5hbQYjHpvZSuQPP8dEXXYj
 5hQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766507261; x=1767112061;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NJg3H8BbPpKkHO7uLlK5kE4EC17eVLZI0+V9NwByWWs=;
 b=Tlyu2VPZ4418Pv3qAlCqrfGxXMPRi6DWzoTHhOCJxDTKQl4IJ88/ld7ko2r+HGeoCD
 N+KlipWWShaIRzH5fbeo5aipZVnWpiDrM2T8CawNuQA0vx/7pdAVC7t53gNFSPbUzPfR
 gBk//nOOAiDH4a2frc/E/N1zKDhSCLIqLAGGmjkL9F7+npri3d7ERv7Ru6VDbSe/4GVD
 qTkocD2MHdn99ZIp2fOunsfn3RFRO8cSHUZdTqCPqlS71kN9WSL6Md/yExG2UfBxVesG
 SMJKuXdZuBmyO21t6crUVC691MO/h0Oa2/50ozMd/hFWtvcncgAX0NwLU2NCO47v+F8Q
 Hexw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB0iUUd7g+6AlnKumfM031TKyItj06cwdwWJpoCISXlhxUzKt7IoQKHH8OCozQFLa0WTCSGbJ9Naf5@nongnu.org
X-Gm-Message-State: AOJu0YyYwzA4l4SsO8uLXh/Q2K61iLdwi1ragIVyKLRWXnFq9jfePzKY
 +jj7YP2sOMod+0f/PPXWjymu8pTsQeGaAejhUmHrOcyNGbqzR/cS5mRPH0Fq+O3Gize2KhCrEuD
 d9F64ECYkPqERjTdz3l3xPtc7pIZsFFd6v2byIxmSBPcqjUl2DIo/kZop
X-Gm-Gg: AY/fxX4u22L4vhsEa9BUjnp4/fwX+F0Yn+/B4jeRK7lcTxS95eALXs65BAhRxROMXKo
 OxcfBXR7InyDMijbuZ9T5/s3IYLK5ySi9mAJZWvrgIMagsvLPx6fqfIlQD9b8V+JEJmDaCWF2st
 4pvG/wP3yt/SJZprX+UMwnY56W7pWfLMDiAoyx/OLd/UylWC8vJzERIncMiGCtIr67gV57Hu/jz
 rvCfHF6E5m32qE4YWVZUa6OzHfg60KgWg5jvW8DcUF66A8rAoBn9rHS0XYXx4W2onQuB7NlYkGl
 NXIw2yDDhFXEtFGgKjAqUmTi4K6rgALJIgKdchkqeVJXTak4LS82ciMdsizs05LYosmRoUd8mcc
 0YAE=
X-Received: by 2002:a05:620a:28c6:b0:8b2:f269:f899 with SMTP id
 af79cd13be357-8c08fc01490mr2159620385a.56.1766507261426; 
 Tue, 23 Dec 2025 08:27:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFW5X8Dw8B6eZCJC1OR1WJNKwM1LIEynWlFxSn/NjzlN3HrXwOGS/CyGrnSHEsmN8mIHkoexQ==
X-Received: by 2002:a05:620a:28c6:b0:8b2:f269:f899 with SMTP id
 af79cd13be357-8c08fc01490mr2159616385a.56.1766507260913; 
 Tue, 23 Dec 2025 08:27:40 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88d9a83bcbasm109720076d6.54.2025.12.23.08.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 08:27:40 -0800 (PST)
Date: Tue, 23 Dec 2025 11:27:39 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH] migration: introduce MIGRATION_STATUS_FAILING
Message-ID: <aUrC-5uNCGcWB61Z@x1.local>
References: <20251222114822.327623-1-ppandit@redhat.com>
 <aUqyfkOtXwl6cy9A@x1.local> <87a4z9ky6k.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a4z9ky6k.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Tue, Dec 23, 2025 at 12:36:19PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Dec 22, 2025 at 05:18:22PM +0530, Prasad Pandit wrote:
> >> From: Prasad Pandit <pjp@fedoraproject.org>
> >> 
> >> When migration connection is broken, the QEMU and libvirtd(8)
> >> process on the source side receive TCP connection reset
> >> notification. QEMU sets the migration status to FAILED and
> >> proceeds to migration_cleanup(). Meanwhile, Libvirtd(8) sends
> >> a QMP command to migrate_set_capabilities().
> >> 
> >> The migration_cleanup() and qmp_migrate_set_capabilities()
> >> calls race with each other. When the latter is invoked first,
> >> since the migration is not running (FAILED), migration
> >> capabilities are reset to false, so during migration_cleanup()
> >> the QEMU process crashes with assertion failure.
> >> 
> >>   Stack trace of thread 255014:
> >>    #0  __pthread_kill_implementation (libc.so.6 + 0x822e8)
> >>    #1  raise (libc.so.6 + 0x3a73c)
> >>    #2  abort (libc.so.6 + 0x27034)
> >>    #3  __assert_fail_base (libc.so.6 + 0x34090)
> >>    #4  __assert_fail (libc.so.6 + 0x34100)
> >>    #5  yank_unregister_instance (qemu-kvm + 0x8b8280)
> >>    #6  migrate_fd_cleanup (qemu-kvm + 0x3c6308)
> >>    #7  migration_bh_dispatch_bh (qemu-kvm + 0x3c2144)
> >>    #8  aio_bh_poll (qemu-kvm + 0x8ba358)
> >>    #9  aio_dispatch (qemu-kvm + 0x8a0ab4)
> >>    #10 aio_ctx_dispatch (qemu-kvm + 0x8bb180)
> >> 
> >> Introduce a new migration status FAILING and use it as an
> >> interim status when an error occurs. Once migration_cleanup()
> >> is done, it sets the migration status to FAILED. This helps
> >> to avoid the above race condition and ensuing failure.
> >> 
> >> Interim status FAILING is set wherever the execution moves
> >> towards migration_cleanup() directly OR via:
> >> 
> >>   migration_iteration_finish  bg_migration_iteration_finish
> >>   -> migration_bh_schedule    -> migration_bh_schedule
> >>    -> migration_cleanup_bh     -> migration_cleanup_bh
> >>     -> migration_cleanup        -> migration_cleanup
> >>      -> FAILED                   -> FAILED
> >> 
> >> The migration status finally moves to FAILED and reports an
> >> appropriate error to the user.
> >
> > I raised a request while I was discussing with you internally, I didn't see
> > this, I will request again:
> >
> > Would you please list where you decided to switch from FAILED -> FAILING,
> > and where you decided not, with justifications for each of them?
> >
> > Let me give a detailed example in this patch, please see below.
> >
> >> 
> >> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> >> ---
> >>  migration/migration.c                 | 33 +++++++++++++++------------
> >>  migration/multifd.c                   |  4 ++--
> >>  qapi/migration.json                   |  8 ++++---
> >>  tests/qtest/migration/migration-qmp.c |  3 ++-
> >>  tests/qtest/migration/precopy-tests.c |  5 ++--
> >>  5 files changed, 31 insertions(+), 22 deletions(-)
> >> 
> >> diff --git a/migration/migration.c b/migration/migration.c
> >> index b316ee01ab..5c32bc8fe5 100644
> >> --- a/migration/migration.c
> >> +++ b/migration/migration.c
> >> @@ -1216,6 +1216,7 @@ bool migration_is_running(void)
> >>      case MIGRATION_STATUS_DEVICE:
> >>      case MIGRATION_STATUS_WAIT_UNPLUG:
> >>      case MIGRATION_STATUS_CANCELLING:
> >> +    case MIGRATION_STATUS_FAILING:
> >>      case MIGRATION_STATUS_COLO:
> >>          return true;
> >>      default:
> >> @@ -1351,6 +1352,7 @@ static void fill_source_migration_info(MigrationInfo *info)
> >>          break;
> >>      case MIGRATION_STATUS_ACTIVE:
> >>      case MIGRATION_STATUS_CANCELLING:
> >> +    case MIGRATION_STATUS_FAILING:
> >>      case MIGRATION_STATUS_POSTCOPY_DEVICE:
> >>      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
> >>      case MIGRATION_STATUS_PRE_SWITCHOVER:
> >> @@ -1409,6 +1411,7 @@ static void fill_destination_migration_info(MigrationInfo *info)
> >>      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
> >>      case MIGRATION_STATUS_POSTCOPY_PAUSED:
> >>      case MIGRATION_STATUS_POSTCOPY_RECOVER:
> >> +    case MIGRATION_STATUS_FAILING:
> >>      case MIGRATION_STATUS_FAILED:
> >>      case MIGRATION_STATUS_COLO:
> >>          info->has_status = true;
> >> @@ -1531,6 +1534,9 @@ static void migration_cleanup(MigrationState *s)
> >>      if (s->state == MIGRATION_STATUS_CANCELLING) {
> >>          migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
> >>                            MIGRATION_STATUS_CANCELLED);
> >> +    } else if (s->state == MIGRATION_STATUS_FAILING) {
> >> +        migrate_set_state(&s->state, MIGRATION_STATUS_FAILING,
> >> +                          MIGRATION_STATUS_FAILED);
> >>      }
> >>  
> >>      if (s->error) {
> >> @@ -1584,7 +1590,7 @@ static void migration_connect_set_error(MigrationState *s, const Error *error)
> >>  
> >>      switch (current) {
> >>      case MIGRATION_STATUS_SETUP:
> >> -        next = MIGRATION_STATUS_FAILED;
> >> +        next = MIGRATION_STATUS_FAILING;
> >
> > This is the first real change that we'll switch to FAILING when
> > migration_connect_set_error() is invoked and migration failed.
> >
> > Please justify why setting FAILING is correct here.
> >
> > This function is invoked in three callers:
> >
> > qmp_migrate[2302]              migration_connect_set_error(s, local_err);
> > qmp_migrate_finish[2347]       migration_connect_set_error(s, local_err);
> > migration_connect[4047]        migration_connect_set_error(s, error_in);
> >
> > At least from the initial two callers, I don't see migration_cleanup()
> > invoked after setting FAILING.  Could this cause migration to get into
> > FAILING status forever without finally move to FAILED?
> >
> 
> Good point, I'm working on some cleanups to connection code and one
> change I did there is to add a migration_cleanup() call into
> migration_connect_error_propagate().

Yeh, this sounds like a good thing in general.  A few quick comments
below.

> 
> 1) branch WIP:
> https://gitlab.com/farosas/qemu/-/commits/migration-connect-cleanup
> 
> 2) the patch:
> ---
> From 1f9eeb898f3a5efba7c183e351fa36a5471fd0b2 Mon Sep 17 00:00:00 2001
> From: Fabiano Rosas <farosas@suse.de>
> Date: Thu, 18 Dec 2025 10:54:46 -0300
> Subject: [PATCH] migration: Fold migration_cleanup into
>  migration_connect_error_propagate
> 
> The code path from qmp_migrate() until the migration thread starts is
> a little twisty due to the async nature of some routines. One issue is
> that the async functions cannot return errors to their callers and
> must instead call forward into migration_channel_connect() and pass
> the error as input.
> 
> Ideally we'd have a function that just receives the error as input and
> handles it. However, currently migration_channel_connect() has a code
> path that moves forward into migration_connect(), also passing the
> error as input, only for migration_connect() to then check that an
> error happened and call migration_cleanup().
> 
> Clean this up:
> 
> 1) Make migration_connect_error_propagate() be the function that
> handles the error and call it at the point the error happens in the
> async code. (this is all migration code, there's no layering
> violation)
> 
> 2) Stop checking for an incoming error in migration_connect(), that
> function should be only reached when everything that came before
> succeeded.
> 
> 3) Fold migration_cleanup() into migration_connect_error_propagate()
> so the cleanup happens at the moment the error is detected and not
> several calls down the stack.
> 
> 4) To address the quirk that during postcopy recovery there should be
> no cleanup, move that check into migration_cleanup() and return early
> if doing resume.
> 
> Notable functional changes:
> 
> i) Assumes a larger window for what it means to be "in resume"
>    before: from qmp_migrate until migration_connect
>    after: from qmp_migration until the state transition into
>           MIGRATION_STATUS_POSTCOPY_RECOVER
> 
> ii) After an error, MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP changes to
>     MIGRATION_STATUS_POSTCOPY_PAUSED.
> 
>     This is already the case when migration_connect_error_propagate()
>     was used, but not when migration_connect() receives
>     error_in. Seems like a pre-existing bug actually.
> 
> iii) If the socket_start_outgoing_migration function *returns* an
>      error, now migration_cleanup() is called. Previously, cleanup
>      only happened when the error was *passed* forward, i.e. only
>      after the async call.
> 
> iv) If cpr_state_save() fails, now migration_cleanup() is called.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 4b1afcab24..52c1a97e46 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1481,6 +1481,14 @@ static void migration_cleanup(MigrationState *s)
>      MigrationEventType type;
>      QEMUFile *tmp = NULL;
>  
> +    /*
> +     * Don't do cleanup if we're waiting for another connection from
> +     * the user.
> +     */
> +    if (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP) {
> +        return;
> +    }

I wonder if QEMU will be in RECOVER_SETUP when reaching here..  shouldn't
below [2] already moved it to PAUSED for a postcopy?

The other thing is, migration_cleanup() currently also takes the job of
dumping the error to stderr:

    if (s->error) {
        /* It is used on info migrate.  We can't free it */
        error_report_err(error_copy(s->error));
    }

I wonder if we could merge [1] below, then here when it's PAUSED we "goto"
that part (we may need to move the error_report_err to the end of
migration_cleanup, though, please double check).

> +
>      trace_migration_cleanup();
>  
>      migration_cleanup_json_writer(s);
> @@ -1585,6 +1593,14 @@ static void migration_connect_error_propagate(MigrationState *s, Error *error)
>      case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
>          /* Never fail a postcopy migration; switch back to PAUSED instead */
>          next = MIGRATION_STATUS_POSTCOPY_PAUSED;
> +
> +        /*
> +         * Give HMP user a hint on what failed.  It's normally done in
> +         * migration_cleanup(), but call it here explicitly because we
> +         * don't do cleanup when waiting for postcopy recover.
> +         */
> +        error_report_err(error_copy(error));

[1]

> +
>          break;
>      default:
>          /*
> @@ -1598,6 +1614,7 @@ static void migration_connect_error_propagate(MigrationState *s, Error *error)
>  
>      migrate_set_state(&s->state, current, next);

[2]

>      migrate_error_propagate(s, error);
> +    migration_cleanup(s);
>  }
>  
>  void migration_cancel(void)
> @@ -2326,12 +2343,8 @@ static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
>      }
>  
>      if (local_err) {
> -        if (!resume_requested) {
> -            yank_unregister_instance(MIGRATION_YANK_INSTANCE);
> -        }
> -        migration_connect_error_propagate(s, error_copy(local_err));
> +        migration_connect_error_propagate(s, local_err);

I feel like this is a rebase accident.. now after renaming this function to
migration_connect_error_propagate() it'll take over the ownership, so IIUC
error_copy() will be needed here (as error_propagate() right below will
also take the ownership..).

>          error_propagate(errp, local_err);
> -        return;
>      }
>  }
>  
> @@ -4026,18 +4039,6 @@ void migration_connect(MigrationState *s, Error *error_in)
>      s->expected_downtime = migrate_downtime_limit();
>      if (error_in) {
>          migration_connect_error_propagate(s, error_in);
> -        if (resume) {
> -            /*
> -             * Don't do cleanup for resume if channel is invalid, but only dump
> -             * the error.  We wait for another channel connect from the user.
> -             * The error_report still gives HMP user a hint on what failed.
> -             * It's normally done in migration_cleanup(), but call it here
> -             * explicitly.
> -             */
> -            error_report_err(error_copy(s->error));
> -        } else {
> -            migration_cleanup(s);
> -        }

Yeah this part looks better.

>          return;
>      }
>  
> -- 
> 

-- 
Peter Xu


