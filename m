Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9402DC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 14:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxSjk-00030p-ES; Thu, 18 Apr 2024 10:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rxSjf-00030R-Vp
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 10:27:37 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rxSjd-0002Iz-MU
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 10:27:35 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6AFD221BCE;
 Thu, 18 Apr 2024 14:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713450448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oEAy1X93BN8dJ4qYwoeSpoKRP8AxPnrwKi41VlVQJ0Y=;
 b=uqlnpJAjzelpui4NycyYdvMeMtgiQYCVw6ctmQVQaEF7YWpEC70AgfFNFZUsL9nl0LL4+E
 oaCWtBoi5m8uOFj+oNrUpd+fgGae+YWA1ZfI7SO07GLb33qKa9iarQWAmlL6xVGuSp8v8X
 kwl0FPl2mOIC0lIYTnVjrInntsOtYJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713450448;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oEAy1X93BN8dJ4qYwoeSpoKRP8AxPnrwKi41VlVQJ0Y=;
 b=8wOjXsUpV8kSGMqjxkR3DaugcsaiMRA5vTSPP33aWLAfdC1/gKEZnViPv7Jv6yCdiHzJyM
 itGxwL+oTHjtbuDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uqlnpJAj;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8wOjXsUp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713450448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oEAy1X93BN8dJ4qYwoeSpoKRP8AxPnrwKi41VlVQJ0Y=;
 b=uqlnpJAjzelpui4NycyYdvMeMtgiQYCVw6ctmQVQaEF7YWpEC70AgfFNFZUsL9nl0LL4+E
 oaCWtBoi5m8uOFj+oNrUpd+fgGae+YWA1ZfI7SO07GLb33qKa9iarQWAmlL6xVGuSp8v8X
 kwl0FPl2mOIC0lIYTnVjrInntsOtYJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713450448;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oEAy1X93BN8dJ4qYwoeSpoKRP8AxPnrwKi41VlVQJ0Y=;
 b=8wOjXsUpV8kSGMqjxkR3DaugcsaiMRA5vTSPP33aWLAfdC1/gKEZnViPv7Jv6yCdiHzJyM
 itGxwL+oTHjtbuDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAA6F13687;
 Thu, 18 Apr 2024 14:27:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id U3/FK88tIWaVJAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 18 Apr 2024 14:27:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, peterx@redhat.com
Cc: vsementsov@yandex-team.ru, yc-core@yandex-team.ru, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org,
 pkrempa@redhat.com
Subject: Re: [PATCH] migration: do not exit on incoming failure
In-Reply-To: <20240417221329.248803-1-vsementsov@yandex-team.ru>
References: <20240417221329.248803-1-vsementsov@yandex-team.ru>
Date: Thu, 18 Apr 2024 11:27:25 -0300
Message-ID: <87ttjyiw4y.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6AFD221BCE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[9]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> We do set MIGRATION_FAILED state, but don't give a chance to
> orchestrator to query migration state and get the error.
>
> Let's report an error through QAPI like we do on outgoing migration.
>
> migration-test is updated correspondingly.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>
> Doubt: is exiting on failure a contract? Will this commit break
> something in Libvirt? Finally, could we just change the logic, or I need
> and additional migration-parameter for new behavior?

It seems we depend on the non-zero value:

  4aead69241 ("migration: reflect incoming failure to shell")
  Author: Eric Blake <eblake@redhat.com>
  Date:   Tue Apr 16 15:50:41 2013 -0600
  
      migration: reflect incoming failure to shell
      
      Management apps like libvirt don't know to pay attention to
      stderr unless there is a non-zero exit status.
      
      * migration.c (process_incoming_migration_co): Exit with non-zero
      status on failure.
      
      Signed-off-by: Eric Blake <eblake@redhat.com>
      Message-id: 1366149041-626-1-git-send-email-eblake@redhat.com
      Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

One idea would be to plumb the s->error somehow through
migration_shutdown() and allow qemu_cleanup() to change the status
value.

>  migration/migration.c           | 22 +++++++---------------
>  tests/qtest/migration-helpers.c | 13 ++++++++++---
>  tests/qtest/migration-helpers.h |  3 ++-
>  tests/qtest/migration-test.c    | 14 +++++++-------
>  4 files changed, 26 insertions(+), 26 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 86bf76e925..3c203e767d 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -738,11 +738,12 @@ process_incoming_migration_co(void *opaque)
>      MigrationIncomingState *mis = migration_incoming_get_current();
>      PostcopyState ps;
>      int ret;
> +    Error *local_err = NULL;
>  
>      assert(mis->from_src_file);
>  
>      if (compress_threads_load_setup(mis->from_src_file)) {
> -        error_report("Failed to setup decompress threads");
> +        error_setg(&local_err, "Failed to setup decompress threads");
>          goto fail;
>      }
>  
> @@ -779,32 +780,23 @@ process_incoming_migration_co(void *opaque)
>      }
>  
>      if (ret < 0) {
> -        MigrationState *s = migrate_get_current();
> -
> -        if (migrate_has_error(s)) {
> -            WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
> -                error_report_err(s->error);
> -            }
> -        }
> -        error_report("load of migration failed: %s", strerror(-ret));
> +        error_setg(&local_err, "load of migration failed: %s", strerror(-ret));
>          goto fail;
>      }
>  
>      if (colo_incoming_co() < 0) {
> +        error_setg(&local_err, "colo incoming failed");
>          goto fail;
>      }
>  
>      migration_bh_schedule(process_incoming_migration_bh, mis);
>      return;
>  fail:
> +    migrate_set_error(migrate_get_current(), local_err);
> +    error_report_err(local_err);

This will report an different error from the QMP one if s->error happens
to be already set. Either use s->error here or prepend the "load of
migration..." error to the s->error above.

>      migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>                        MIGRATION_STATUS_FAILED);
> -    qemu_fclose(mis->from_src_file);
> -
> -    multifd_recv_cleanup();
> -    compress_threads_load_cleanup();
> -
> -    exit(EXIT_FAILURE);
> +    migration_incoming_state_destroy();
>  }
>  
>  /**
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index e451dbdbed..91c13bd566 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -211,7 +211,8 @@ void wait_for_migration_complete(QTestState *who)
>      wait_for_migration_status(who, "completed", NULL);
>  }
>  
> -void wait_for_migration_fail(QTestState *from, bool allow_active)
> +void wait_for_migration_fail(QTestState *from, bool allow_active,
> +                             bool is_incoming)
>  {
>      g_test_timer_start();
>      QDict *rsp_return;
> @@ -236,8 +237,14 @@ void wait_for_migration_fail(QTestState *from, bool allow_active)
>      /* Is the machine currently running? */
>      rsp_return = qtest_qmp_assert_success_ref(from,
>                                                "{ 'execute': 'query-status' }");
> -    g_assert(qdict_haskey(rsp_return, "running"));
> -    g_assert(qdict_get_bool(rsp_return, "running"));
> +    if (is_incoming) {
> +        if (qdict_haskey(rsp_return, "running")) {
> +            g_assert(!qdict_get_bool(rsp_return, "running"));
> +        }
> +    } else {
> +        g_assert(qdict_haskey(rsp_return, "running"));
> +        g_assert(qdict_get_bool(rsp_return, "running"));
> +    }
>      qobject_unref(rsp_return);
>  }
>  
> diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
> index 3bf7ded1b9..7bd07059ae 100644
> --- a/tests/qtest/migration-helpers.h
> +++ b/tests/qtest/migration-helpers.h
> @@ -46,7 +46,8 @@ void wait_for_migration_status(QTestState *who,
>  
>  void wait_for_migration_complete(QTestState *who);
>  
> -void wait_for_migration_fail(QTestState *from, bool allow_active);
> +void wait_for_migration_fail(QTestState *from, bool allow_active,
> +                             bool is_incoming);
>  
>  char *find_common_machine_version(const char *mtype, const char *var1,
>                                    const char *var2);
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 1d2cee87ea..e00b755f05 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1670,7 +1670,7 @@ static void test_baddest(void)
>          return;
>      }
>      migrate_qmp(from, "tcp:127.0.0.1:0", "{}");
> -    wait_for_migration_fail(from, false);
> +    wait_for_migration_fail(from, false, false);
>      test_migrate_end(from, to, false);
>  }
>  
> @@ -1781,10 +1781,10 @@ static void test_precopy_common(MigrateCommon *args)
>  
>      if (args->result != MIG_TEST_SUCCEED) {
>          bool allow_active = args->result == MIG_TEST_FAIL;
> -        wait_for_migration_fail(from, allow_active);
> +        wait_for_migration_fail(from, allow_active, false);
>  
>          if (args->result == MIG_TEST_FAIL_DEST_QUIT_ERR) {
> -            qtest_set_expected_status(to, EXIT_FAILURE);
> +            wait_for_migration_fail(to, true, true);
>          }
>      } else {
>          if (args->live) {
> @@ -2571,8 +2571,8 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
>      migrate_qmp(from, uri, "{}");
>  
>      if (should_fail) {
> -        qtest_set_expected_status(to, EXIT_FAILURE);
> -        wait_for_migration_fail(from, true);
> +        wait_for_migration_fail(to, true, true);
> +        wait_for_migration_fail(from, true, false);
>      } else {
>          wait_for_migration_complete(from);
>      }
> @@ -3047,8 +3047,8 @@ static void test_multifd_tcp_cancel(void)
>      migrate_cancel(from);
>  
>      /* Make sure QEMU process "to" exited */
> -    qtest_set_expected_status(to, EXIT_FAILURE);
> -    qtest_wait_qemu(to);
> +    wait_for_migration_fail(to, true, true);
> +    qtest_quit(to);
>  
>      args = (MigrateStart){
>          .only_target = true,

