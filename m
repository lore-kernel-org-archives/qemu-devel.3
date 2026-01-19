Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D277CCF2F4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 12:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vho23-0005Is-W0; Mon, 19 Jan 2026 07:06:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vho1u-0005H2-LL
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 07:06:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vho1s-0001I5-T1
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 07:06:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768824404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ACwFRoieI4ij14Qj0W7gUZjxgI5w2sVRGtU/Cw16WWU=;
 b=EM0sQmDite/zClJh1Qxqd3numcFh0G9b+lWn8CFZ85gVHwhC5UdMU5uQ3hnOyqVnVQPvC3
 RRB4ctzrbmTi3kOtFufZIRgMsWNOn7Fmov5BcPVscLRd27J/eZrzb+m7QPC9NIvZs0OTPZ
 glpveErvHQ5lxW3Lyrkv8T9d3Mh8Tf4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-Daw8FmMtPT6Ou8tt-fABOQ-1; Mon, 19 Jan 2026 07:06:42 -0500
X-MC-Unique: Daw8FmMtPT6Ou8tt-fABOQ-1
X-Mimecast-MFC-AGG-ID: Daw8FmMtPT6Ou8tt-fABOQ_1768824401
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477cf2230c8so38336645e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 04:06:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768824401; cv=none;
 d=google.com; s=arc-20240605;
 b=DFGlcvmA4rrC5dXtvONUtd7ejbAcGXSXcEhD7gbRypDr10caoqT2z0wzdajsRO0HxS
 VnTcwT15sifM+DmuWiYRUjlqtoglOKV0WTcrTyX/KBxp5dhMkKII7vPJcZCx7J6tOaPd
 w9L6az2ZZFILxW9a201xJvzZ1WmtLNXqEsx4+80mXYe6gjFpUutCmSn8MX1rJ3eo9O55
 NspvVtAl8fPNP5V8th2E1PBnah9QiVLpAIUgpQ/kAOK6Sz36puZY+G7UdQ71RDuwGOEh
 qYdLSKuo175zaUVMuyTFZxy3nmv3+z0+FAdtXROvZ9b3g3SuZhQc1sS5CuVWtTHR9d6m
 S95g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ACwFRoieI4ij14Qj0W7gUZjxgI5w2sVRGtU/Cw16WWU=;
 fh=jjq9sOgGRsbcm1AC8tD4S17WtZ06kUg+xzgdpLFYm5U=;
 b=MzkSOPUEQX+qiGHnDNI3QiazG27QbE3cbGq1pNpLpe2xsORNQrD+7+4JqbXZhXOazg
 sjdOhQYG8bB4NSoJrxMXT3/LA2xL/AVeY61QCJBPn7feP8OPBXclk6CQKrXYw+XwaY8M
 V2Z5qDlcDAks7/ZVpBQrskjG0fKoJr6NeWmnqXx5Zq879KEF7nza59fo72ev7EHZa7Qh
 KmMw6UahKqYjmRmnz+8HyV5/PPdsYG/Ij7a/Jiz9uWlh3NrElyjuHbQd7vVTpxuoNjcw
 uMSRlyIi0tgl1CKgOXjbbqSSYQGaNj5d/Hm3SBhrumJ43lHa2YWCDfpqfdrDGwfW3mjO
 yM1A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768824401; x=1769429201; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ACwFRoieI4ij14Qj0W7gUZjxgI5w2sVRGtU/Cw16WWU=;
 b=HOyCnEQ3eCzWQ86/sLAgOxYZEgUeI70IQdkozhnWe+CRHXkBWgE2LeijLQeRPjiCU+
 PC1BGztjZA46RIn1RVhz2BZ3dDLzQvk1Q9oIvumtj4dwoY0/YmkKWttCQUVlin4usBoJ
 okr8XYhO9nkRIulGziyqqVdZfEwhgpRd0CMzQEHyaMxz8aM5gThUYCOxbHS1GnC0Mapd
 rt3fbohIXFs4jIumr3dErhaCyW6biw8moQhuIoj0nQEWBMzqoZMYVNZv1+op1Xd9/8rw
 oHTMHI4rVd2BwVatrM6VtRRWub+0oHL1/UdvhLQ8r5vvHg51KFLKxkkagf/edtafI5GO
 h2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768824401; x=1769429201;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ACwFRoieI4ij14Qj0W7gUZjxgI5w2sVRGtU/Cw16WWU=;
 b=jEoQ+3T+pmpfp7CaownADFOVAaKrM3jC0k8gvEdjt0fKYiqaoLGlkisjWhBdk7ui+X
 nCTs7uYD+QhPsKubH20SoCNr7sm0gv34PxNWyNje7f/nIVIPIsJ4/sI/6ryHY/x48hWS
 uEJP9XDzrOqqSLofzPbESr1g0ALedD8tO2tlBXd05qHtepW7gRsqlspscOmiYBjAKCtF
 7K+X+0nxW8+SF1nZul5eAbKfUeLujlTZUcjrObS97vRxQeux1DcRFC/LBKU+LGSsoPiB
 D6oFMddXdqvAG6ni+7eibC43ztH5PkpfQKVZchDt/BG0Z/HjDgsYF0fqN0zI6H1TcENH
 9AtQ==
X-Gm-Message-State: AOJu0YyluojlebMzyoLiKtfsKLAYSf7TAeT/2teah+hYBCcSJTG5iNJr
 ZmLLPCnZCtpyEESmFKYhgXC/owCEd4F9PU8ni7i98mgzfjo6QzVrRR1Fa1vlhvnqlJTY0xI2vcz
 gqd2nSpxoY8vBhJMqQYg3Fnu73JgT5+scxOHrNr2wCpcM70XjgiSehpaYyiK2vP0u0LpiroCFW5
 GYfkHmsd5xCu3scPWH/wIFNwAFCFumebk=
X-Gm-Gg: AY/fxX5XLF6/JNIfkipNJQeYAAiaPScxAoUV/CvpYBH62TT0jzUVvHYzrJbmmcSBeoZ
 deeezJTXX4R0HuuhvUgi+EOx44ToLAhwRO55vciNPEgDkJue2YnJ86fw7ZcW5UNO5lLiM/UT2nF
 GzQj55DTcA0So7zIwjYk6QVwPOCXiNaYAQfyWMEejdDeIbJA7IEW2luJ+wP9wmqRdbCWNx1l1uw
 crlLuy+aH3Mtin+/HdvYXN1Lrw3QQ7VDnQgZdjNT4HQ5YjzH0r7oveP
X-Received: by 2002:a05:600c:4ec7:b0:47d:4fbe:e6cc with SMTP id
 5b1f17b1804b1-4801e30dc6fmr140164685e9.13.1768824400946; 
 Mon, 19 Jan 2026 04:06:40 -0800 (PST)
X-Received: by 2002:a05:600c:4ec7:b0:47d:4fbe:e6cc with SMTP id
 5b1f17b1804b1-4801e30dc6fmr140164085e9.13.1768824400456; Mon, 19 Jan 2026
 04:06:40 -0800 (PST)
MIME-Version: 1.0
References: <20260109124043.25019-1-farosas@suse.de>
 <20260109124043.25019-7-farosas@suse.de>
In-Reply-To: <20260109124043.25019-7-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 19 Jan 2026 17:36:23 +0530
X-Gm-Features: AZwV_Qg2gI66yJuUvNsLBRDTPTtiy9AWv0VpBSzEMyAgfKS00CzeVVPBRG_szFc
Message-ID: <CAE8KmOyZQgJx=JUE1fg9SpM3NweRQB57E-BueTX2LX4qijy=XA@mail.gmail.com>
Subject: Re: [PATCH v3 06/25] migration: Use migrate_mode() to query for
 cpr-transfer
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
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

Hi,

On Fri, 9 Jan 2026 at 18:12, Fabiano Rosas <farosas@suse.de> wrote:
> cpr_set_incoming_mode() is only called on the target side, so
> migrate_mode() on the source side is the same as s->parameters.mode.

* This message is a little confusing, as the connection between
cpr_set_incoming_mode() and migrate_mode() is not evident. IIUC,
during CPR migration mode is not set explicitly on the source side, so
cpr_get_incoming_mode() returns none, so migrate_mode() sets it to
s->parameters.mode and returns it. Ideally it should be set to
s->parameters.mode.  /* I wonder why we need such differention between
incoming and outgoing modes. */

> Use the function to reduce explicit access to s->parameters, we have
> options.c for that.
>
> Cc: Mark Kanda <mark.kanda@oracle.com>
> Cc: Ben Chaney <bchaney@akamai.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/cpr-exec.c  |  2 +-
>  migration/migration.c | 27 +++++++++++++--------------
>  migration/migration.h |  5 ++---
>  3 files changed, 16 insertions(+), 18 deletions(-)
>
> diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
> index da287d8031..e315a30f92 100644
> --- a/migration/cpr-exec.c
> +++ b/migration/cpr-exec.c
> @@ -164,7 +164,7 @@ static void cpr_exec_cb(void *opaque)
>      err = NULL;
>
>      /* Note, we can go from state COMPLETED to FAILED */

 /* Going from COMPLETED -> FAILED says something not right here,
maybe we are prematurely moving to COMPLETED state. */

> -    migration_call_notifiers(s, MIG_EVENT_PRECOPY_FAILED, NULL);
> +    migration_call_notifiers(MIG_EVENT_PRECOPY_FAILED, NULL);
>
>      if (!migration_block_activate(&err)) {
>          /* error was already reported */
> diff --git a/migration/migration.c b/migration/migration.c
> index 4af5baad59..388e0be5a2 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1534,7 +1534,7 @@ static void migration_cleanup(MigrationState *s)
>      }
>      type = migration_has_failed(s) ? MIG_EVENT_PRECOPY_FAILED :
>                                       MIG_EVENT_PRECOPY_DONE;
> -    migration_call_notifiers(s, type, NULL);
> +    migration_call_notifiers(type, NULL);
>      yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>  }
>
> @@ -1696,10 +1696,9 @@ void migration_remove_notifier(NotifierWithReturn *notify)
>      }
>  }
>
> -int migration_call_notifiers(MigrationState *s, MigrationEventType type,
> -                             Error **errp)
> +int migration_call_notifiers(MigrationEventType type, Error **errp)
>  {
> -    MigMode mode = s->parameters.mode;
> +    MigMode mode = migrate_mode();
>      MigrationEvent e;
>      NotifierWithReturn *notifier;
>      GSList *elem, *next;
> @@ -1780,9 +1779,9 @@ bool migration_thread_is_self(void)
>      return qemu_thread_is_self(&s->thread);
>  }
>
> -bool migrate_mode_is_cpr(MigrationState *s)
> +bool migrate_mode_is_cpr(void)
>  {
> -    MigMode mode = s->parameters.mode;
> +    MigMode mode = migrate_mode();
>      return mode == MIG_MODE_CPR_REBOOT ||
>             mode == MIG_MODE_CPR_TRANSFER ||
>             mode == MIG_MODE_CPR_EXEC;
> @@ -2136,7 +2135,7 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
>          }
>      }
>
> -    if (migrate_mode_is_cpr(s)) {
> +    if (migrate_mode_is_cpr()) {
>          const char *conflict = NULL;
>
>          if (migrate_postcopy()) {
> @@ -2252,7 +2251,7 @@ void qmp_migrate(const char *uri, bool has_channels,
>          return;
>      }
>
> -    if (s->parameters.mode == MIG_MODE_CPR_TRANSFER && !cpr_channel) {
> +    if (migrate_mode() == MIG_MODE_CPR_TRANSFER && !cpr_channel) {
>          error_setg(errp, "missing 'cpr' migration channel");
>          return;
>      }
> @@ -2277,7 +2276,7 @@ void qmp_migrate(const char *uri, bool has_channels,
>       * in which case the target will not listen for the incoming migration
>       * connection, so qmp_migrate_finish will fail to connect, and then recover.
>       */
> -    if (s->parameters.mode == MIG_MODE_CPR_TRANSFER) {
> +    if (migrate_mode() == MIG_MODE_CPR_TRANSFER) {

* Shouldn't we use migrate_mode_is_cpr() to avoid this comparison?

>          migrate_hup_add(s, cpr_state_ioc(), (GSourceFunc)qmp_migrate_finish_cb,
>                          QAPI_CLONE(MigrationAddress, addr));
>
> @@ -2852,7 +2851,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>       * at the transition to postcopy and after the device state; in particular
>       * spice needs to trigger a transition now
>       */
> -    migration_call_notifiers(ms, MIG_EVENT_PRECOPY_DONE, NULL);
> +    migration_call_notifiers(MIG_EVENT_PRECOPY_DONE, NULL);
>
>      migration_downtime_end(ms);
>
> @@ -2901,7 +2900,7 @@ fail:
>          migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
>      }
>      migration_block_activate(NULL);
> -    migration_call_notifiers(ms, MIG_EVENT_PRECOPY_FAILED, NULL);
> +    migration_call_notifiers(MIG_EVENT_PRECOPY_FAILED, NULL);
>      bql_unlock();
>      return -1;
>  }
> @@ -3003,7 +3002,7 @@ static int migration_completion_precopy(MigrationState *s)
>
>      bql_lock();
>
> -    if (!migrate_mode_is_cpr(s)) {
> +    if (!migrate_mode_is_cpr()) {
>          ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
>          if (ret < 0) {
>              goto out_unlock;
> @@ -4049,7 +4048,7 @@ void migration_connect(MigrationState *s, Error *error_in)
>          rate_limit = migrate_max_bandwidth();
>
>          /* Notify before starting migration thread */
> -        if (migration_call_notifiers(s, MIG_EVENT_PRECOPY_SETUP, &local_err)) {
> +        if (migration_call_notifiers(MIG_EVENT_PRECOPY_SETUP, &local_err)) {
>              goto fail;
>          }
>      }
> @@ -4085,7 +4084,7 @@ void migration_connect(MigrationState *s, Error *error_in)
>          return;
>      }
>
> -    if (migrate_mode_is_cpr(s)) {
> +    if (migrate_mode_is_cpr()) {
>          ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
>          if (ret < 0) {
>              error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
> diff --git a/migration/migration.h b/migration/migration.h
> index ccc4e536a5..8b55d4741a 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -538,8 +538,7 @@ bool migrate_has_error(MigrationState *s);
>
>  void migration_connect(MigrationState *s, Error *error_in);
>
> -int migration_call_notifiers(MigrationState *s, MigrationEventType type,
> -                             Error **errp);
> +int migration_call_notifiers(MigrationEventType type, Error **errp);
>
>  int migrate_init(MigrationState *s, Error **errp);
>  bool migration_is_blocked(Error **errp);
> @@ -548,7 +547,7 @@ bool migration_in_postcopy(void);
>  bool migration_postcopy_is_alive(MigrationStatus state);
>  MigrationState *migrate_get_current(void);
>  bool migration_has_failed(MigrationState *);
> -bool migrate_mode_is_cpr(MigrationState *);
> +bool migrate_mode_is_cpr(void);
>
>  uint64_t ram_get_total_transferred_pages(void);
>
> --

* Otherwise change looks okay. Needs minor fix above.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
   - Prasad


