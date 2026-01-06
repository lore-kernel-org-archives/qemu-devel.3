Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31E6C47BE2
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 10:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd4dl-00061h-6Y; Tue, 06 Jan 2026 05:50:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vd4dh-0005lb-1n
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 05:50:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vd4df-0003Dm-00
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 05:50:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767696605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=41vxE4MdIUc3xUg0yLsWnj6aiPZAPPHhdKczgbm9A20=;
 b=B1ux1qfv2+poV33lOvPZMN+IgKH+eVTtmXLn7HURQ1E9vSlYOnA3fqUjXLObvwdlIvHigL
 ftH+qxzAXlnAbNzmKJS4Z9oV7llte7BMgtTlZzc+D0gRhGq/j3mRMHA3/GHEREdZ+HPU92
 Wi53eyTFjV6QZSnPyHsUczNdcgFbli4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-3cw6X2nSPXi-ACtEGG-jsg-1; Tue, 06 Jan 2026 05:50:04 -0500
X-MC-Unique: 3cw6X2nSPXi-ACtEGG-jsg-1
X-Mimecast-MFC-AGG-ID: 3cw6X2nSPXi-ACtEGG-jsg_1767696603
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47d62cc05daso5311145e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 02:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767696603; x=1768301403; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=41vxE4MdIUc3xUg0yLsWnj6aiPZAPPHhdKczgbm9A20=;
 b=msaDDubJrRMFj8AAosXSBgrnR2a6vownDOwx8r2n0lvvOky6AwKwgBEw7588Ip3XIz
 0T3f62sRtVVLRVW/gvZ4+69F4pD9eYi8CG4tJLgrvSKkHEX8vbRPq1CGV/dbqNN3u7JV
 3fm8JOq+XZfxvA4ocASkjfrO/Yj0yICbW53zn0HPCVAitRxLVxOz5RWfPtsTskhZCh0L
 oJeHBKRdjvf64nFwpF6OcXb4YOgcV79+g7pbNIo35EICKHfmmBSlSoEXrGexR9v9ZuXB
 QWCnwZNX56SLRy50Rdp/6TGWRfStrIZCjVEdUj/V39VYUFk8MSwACEwjNE0w2PLwYXfV
 px9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767696603; x=1768301403;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=41vxE4MdIUc3xUg0yLsWnj6aiPZAPPHhdKczgbm9A20=;
 b=o4LUzuCclTQSkqUxo4Gh4J3hgqsxtLvxUQiSXkpl0GfA41KLWk2bZ1gvasmh/OJ2Cq
 IRJHSj/nCxjpR0iDnZohqGUHUVopqVRbrTld5WBJB6My4UFkK3Vx1pU7yfgwdK3GqTmz
 BRfFculjTlNDDzqW4dykN8B50NhTC+l2b+BDsPkoCGqu1+MN+8hWCBYA3mW7zbuauQJe
 rE3ZyYhbTMUinljoi3tJn1iYBIq2ILmtRvgjdhzLHjX5FwQxyeU9G/THfsVwt7Gs2dNn
 G0Czj7U1Q0++GKPgjRhom1vjmbv0kGWf8gDd0JK3xaK/I4umUwjGWAavwxhY61li4Vnl
 PpoQ==
X-Gm-Message-State: AOJu0YzCFva9Lwn5rQ62lTuhId/M1Z5GXOFzZohRCMcwYkOqQ5HKliii
 Ye+bZPYnKUSCpk8pB6pNKE7GqD29qQn6W8YA3OkJWerXxwHTnWki9lUVjTz4hdJTbOLXxp6BzLI
 ILKU6AdAYTRjNXSLHMTQKfz2pTuaY8P6ASe/MLZlb/EYXbgSDUD5eIP5j/WmwWEenwAB+WM2APx
 1z4/FqIAUaykmNyESpHvMsX/KJixLpg9E=
X-Gm-Gg: AY/fxX6x/AQdRTmkuJkhTOL+a7Ijo2czWkArvRlFjTYTF1IC4/caFMVSiYJtMZjjFrA
 KjNOPHKaE3aMuzMdvs/rPqxDd1Fo211O5HuWSeS1xObNiVK0p3Klb9uj56Opx5XCKx7/I+xl96V
 pGCI15WJlvp8kH3fZrAtTBx6hoQaFNVvOXhI7YoeSFyKD6hbPHwAaxdxlKjVTVqzWXZ7Y=
X-Received: by 2002:a05:600c:a41:b0:477:7d94:5d0e with SMTP id
 5b1f17b1804b1-47d7f09b48emr30595395e9.27.1767696602627; 
 Tue, 06 Jan 2026 02:50:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJXSOaeQmdU1+pFB//BgOybMYyk4KMwGoAqxy8gHE7gtE48dF+rZ1x3dHXjogwfnno5i+LVNO4oaR/jwbvgI0=
X-Received: by 2002:a05:600c:a41:b0:477:7d94:5d0e with SMTP id
 5b1f17b1804b1-47d7f09b48emr30595095e9.27.1767696602228; Tue, 06 Jan 2026
 02:50:02 -0800 (PST)
MIME-Version: 1.0
References: <20251222114822.327623-1-ppandit@redhat.com>
 <aUqyfkOtXwl6cy9A@x1.local>
In-Reply-To: <aUqyfkOtXwl6cy9A@x1.local>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 6 Jan 2026 16:19:44 +0530
X-Gm-Features: AQt7F2rrrUxyQ8vHZTrYR3P_3pJqssutDmppANt9joAhX1HwnU1GMXUtINAceuE
Message-ID: <CAE8KmOwnPYoK0i53LB8nO95gC53QK4FoNvMrbb9anR3OB+RS4Q@mail.gmail.com>
Subject: Re: [PATCH] migration: introduce MIGRATION_STATUS_FAILING
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
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

Hello Peter, Fabiano,

* Thank you for the comments.

On Tue, 23 Dec 2025 at 20:47, Peter Xu <peterx@redhat.com> wrote:
> I raised a request while I was discussing with you internally, I didn't see
> this, I will request again:
>
> Would you please list where you decided to switch from FAILED -> FAILING,
> and where you decided not, with justifications for each of them?
>
> Let me give a detailed example in this patch, please see below.
> This is the first real change that we'll switch to FAILING when
> migration_connect_set_error() is invoked and migration failed.
>
> Please justify why setting FAILING is correct here.
>
> This function is invoked in three callers:
>
> qmp_migrate[2302]              migration_connect_set_error(s, local_err);
> qmp_migrate_finish[2347]       migration_connect_set_error(s, local_err);
> migration_connect[4047]        migration_connect_set_error(s, error_in);
>
> At least from the initial two callers, I don't see migration_cleanup()
> invoked after setting FAILING.  Could this cause migration to get into
> FAILING status forever without finally move to FAILED?

* Ah, sorry about this; I missed removing this and
qmp_migrate_finish() change from this patch. Idea was to switch to the
interim FAILING state wherever execution follows the
migration_iteration_finish() OR bg_migration_iteration_finish() path
and leads to migration_cleanup() setting the final state to FAILED. (I
create/test patches on a pair of machines and then copy them to the
local repository on my laptop to send upstream, can not do git
send-email from test machines, these discrepancies fall through at
times)

* As you requested, please see below the list of calls where the
change was applied and where it was not. Justification for changing to
the interim 'FAILING' state is that execution follows through to
migration_cleanup() path. And Justification for not changing the state
is that execution does not follow through to the migration_cleanup()
path.
===
01  void migration_channel_process_incoming(QIOChannel *ioc)
      ...
        error_report_err(local_err);
        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);

02  static void cpr_exec_cb(void *opaque)
      ...
        error_report_err(error_copy(err));
        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);

03  static void coroutine_fn process_incoming_migration_co(void *opaque)
      ...
      fail:
         migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                           MIGRATION_STATUS_FAILED);
         migrate_error_propagate(s, local_err);

04  static void migration_connect_error_propagate(MigrationState *s,
Error *error)
      ...
        case MIGRATION_STATUS_SETUP:
            next = MIGRATION_STATUS_FAILED;
            break;
        migrate_error_propagate(s, error);

05  static void qmp_migrate_finish(MigrationAddress *addr, ...)
      ...
        else {
            error_setg(&local_err, "uri is not a valid migration protocol");
            migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                              MIGRATION_STATUS_FAILED);

06  static void multifd_recv_terminate_threads(Error *err)
      ...
        if (s->state == MIGRATION_STATUS_SETUP ||
            s->state == MIGRATION_STATUS_ACTIVE) {
            migrate_set_state(&s->state, s->state,
                              MIGRATION_STATUS_FAILED);

07  static void *postcopy_listen_thread(void *opaque)
      ...
        error_report_err(local_err);
        migrate_set_state(&mis->state, mis->state, MIGRATION_STATUS_FAILED);
        goto out;

08  static int qemu_savevm_state(QEMUFile *f, Error **errp)
      ...
      cleanup:
        if (ret != 0) {
          status = MIGRATION_STATUS_FAILED;
        } else {
          status = MIGRATION_STATUS_COMPLETED;
        }
        migrate_set_state(&ms->state, MIGRATION_STATUS_SETUP, status);

* Above MIGRATION_STATUS_FAILED instances are _not_ changed because
they do not follow the migration_cleanup() path. The instances below
are changed to the interim FAILING state because execution follows
through the migration_cleanup() path, wherein the interim state
changes to the FAILED state.

09  static int postcopy_start(MigrationState *ms, Error **errp)
      ...
        if (ms->state != MIGRATION_STATUS_CANCELLING) {
           migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);

      ...
      fail:
        if (ms->state != MIGRATION_STATUS_CANCELLING) {
            migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
        }

10  static void migration_completion(MigrationState *s)
      ...
      fail:
        if (s->state != MIGRATION_STATUS_CANCELLING) {
            migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
        }

11  static void bg_migration_completion(MigrationState *s)
      ...
      fail:
        migrate_set_state(&s->state, current_active_state,
MIGRATION_STATUS_FAILED);

12  static MigThrError migration_detect_error(MigrationState *s)
      ...
        migrate_set_state(&s->state, state, MIGRATION_STATUS_FAILED);
        /* Time to stop the migration, now. */
        return MIG_THR_ERR_FATAL;

13  static void *migration_thread(void *opaque)
      ...
        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
MIGRATION_STATUS_FAILED);
        goto out;

14  static void *bg_migration_thread(void *opaque)
      ...
        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
MIGRATION_STATUS_FAILED);
        goto fail_setup;

      fail:
        if (early_fail) {
            migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
MIGRATION_STATUS_FAILED);
        }
      fail_setup:
        bg_migration_iteration_finish(s);

15  void migration_connect(MigrationState *s, Error *error_in)
      ...
        if (s->state != MIGRATION_STATUS_CANCELLING) {
            migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
        }
        migration_cleanup(s);

16  static void multifd_send_error_propagate(Error *err)
      ...
        s->state == MIGRATION_STATUS_DEVICE ||
        s->state == MIGRATION_STATUS_ACTIVE) {
            migrate_set_state(&s->state, s->state,
                              MIGRATION_STATUS_FAILED);

17  bool multifd_send_setup(void)
      ...
      err:
        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                      MIGRATION_STATUS_FAILED);
      return false;
===

* As proposed earlier, I'll request to divide this patchset into two
(or even) more patches as:
    - One patch to fix the race condition issue at hand, by way of
introducing the interim FAILING state.
    - One or more patches to use the interim FAILING state, where we
currently set the FAILED state.
That should help us to do/test/review these changes. It is complicated
how this state change is done/handled and IIUC, migration code seems
to serve multiple use cases: one is live VM migration between two
machines, second is taking snapshots of a VM, third is migrating a VM
to a new QEMU process in the same host. Doing such a change in a
single large patch seems risky.

Thank you.
---
  - Prasad


