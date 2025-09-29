Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2877CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 20:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3KXo-0001wZ-5Q; Mon, 29 Sep 2025 16:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v3KXk-0001wK-Dg
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 16:32:20 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v3KXc-0006Ek-G7
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 16:32:19 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 921E73368B;
 Mon, 29 Sep 2025 20:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759177925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yHtShfECynTXuB9goGwLGzQs89SDwKu37AtcvYOzJ7s=;
 b=A5kq62Aae+6H9kgmiwrlffzpNWMi81vcoqR8PYNi05hYA/+BQox2FK+5PhCta6qQD+AlfF
 c64mQ3DcAQP0bvrOUBWG8zRN4mpnIoc9Rm6mHOOMGZPPwGfUFoLj+0VwgrSU/oi4+MO4Ln
 otc+jLL5PmnyXoY4uW+m5ZHsIGXmCps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759177925;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yHtShfECynTXuB9goGwLGzQs89SDwKu37AtcvYOzJ7s=;
 b=ekCJe57t5SA9AETEmra9rSI+JNkIr4BkhFeUNOb1iO2VwuvLWedK3hdg1W4WTFQbvquVmb
 eqpRUKro7gWePJCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FXXvgUDX;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gfky+Sor
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759177924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yHtShfECynTXuB9goGwLGzQs89SDwKu37AtcvYOzJ7s=;
 b=FXXvgUDXOgV/tstC7bzZpwQ4g71IyPZgLg8B3aTwa1zn6SeoRCb+ZvhOKa3YjaLkCGCkTl
 YXa+SAvTvOB+sN7SVxv/IG603eEx/B9fBJVCDXuZoPk0uESRlAC0sXkVhsqt7PtTop44lw
 mgS0WrrzgnxcnyXUXco/Rg7MkNCzoT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759177924;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yHtShfECynTXuB9goGwLGzQs89SDwKu37AtcvYOzJ7s=;
 b=gfky+SorzpAeYVSKfYV6FiKzx6nWUYbG57zTX6HZDxO7Xgw5Qsfr60jMj2/l6IMNUHnDVk
 cPNxHe+rBgIMQgCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B5E013A21;
 Mon, 29 Sep 2025 20:32:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id irF9L8Ps2mhmHAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 29 Sep 2025 20:32:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Steve Sistare
 <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 09/11] migration-test: migrate_args
In-Reply-To: <1758291153-349744-10-git-send-email-steven.sistare@oracle.com>
References: <1758291153-349744-1-git-send-email-steven.sistare@oracle.com>
 <1758291153-349744-10-git-send-email-steven.sistare@oracle.com>
Date: Mon, 29 Sep 2025 17:32:01 -0300
Message-ID: <87ikh1uhj2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 921E73368B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,oracle.com:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:mid, suse.de:email,
 oracle.com:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Define the subroutine migrate_args to return the arguments that are
> used to exec the source or target qemu process.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  tests/qtest/migration/framework.h |  2 ++
>  tests/qtest/migration/framework.c | 64 ++++++++++++++++++++++++---------------
>  2 files changed, 41 insertions(+), 25 deletions(-)
>
> diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
> index 7ff3187..51a8a7e 100644
> --- a/tests/qtest/migration/framework.h
> +++ b/tests/qtest/migration/framework.h
> @@ -226,6 +226,8 @@ typedef struct {
>  void wait_for_serial(const char *side);
>  void migrate_prepare_for_dirty_mem(QTestState *from);
>  void migrate_wait_for_dirty_mem(QTestState *from, QTestState *to);
> +
> +void migrate_args(char **from, char **to, const char *uri, MigrateStart *args);
>  int migrate_start(QTestState **from, QTestState **to, const char *uri,
>                    MigrateStart *args);
>  void migrate_end(QTestState *from, QTestState *to, bool test_dest);
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> index 8f9e359..2dfb1ee 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -258,13 +258,12 @@ static char *test_shmem_path(void)
>      return g_strdup_printf("/dev/shm/qemu-%d", getpid());
>  }
>  
> -int migrate_start(QTestState **from, QTestState **to, const char *uri,
> -                  MigrateStart *args)
> +void migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
>  {
>      /* options for source and target */
>      g_autofree gchar *arch_opts = NULL;
> -    g_autofree gchar *cmd_source = NULL;
> -    g_autofree gchar *cmd_target = NULL;
> +    gchar *cmd_source = NULL;
> +    gchar *cmd_target = NULL;
>      const gchar *ignore_stderr;
>      g_autofree char *shmem_opts = NULL;
>      g_autofree char *shmem_path = NULL;
> @@ -273,23 +272,10 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
>      const char *memory_size;
>      const char *machine_alias, *machine_opts = "";
>      g_autofree char *machine = NULL;
> -    const char *bootpath;
> -    g_autoptr(QList) capabilities = migrate_start_get_qmp_capabilities(args);
> +    const char *bootpath = bootfile_get();
>      g_autofree char *memory_backend = NULL;
>      const char *events;
>  
> -    if (args->use_shmem) {
> -        if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
> -            g_test_skip("/dev/shm is not supported");
> -            return -1;
> -        }
> -    }
> -
> -    dst_state = (QTestMigrationState) { };
> -    src_state = (QTestMigrationState) { };
> -    bootpath = bootfile_create(arch, tmpfs, args->suspend_me);
> -    src_state.suspend_me = args->suspend_me;
> -
>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
>          memory_size = "150M";
>  
> @@ -365,7 +351,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
>      if (!qtest_has_machine(machine_alias)) {
>          g_autofree char *msg = g_strdup_printf("machine %s not supported", machine_alias);
>          g_test_skip(msg);
> -        return -1;
> +        return;
>      }
>  
>      machine = resolve_machine_version(machine_alias, QEMU_ENV_SRC,
> @@ -386,12 +372,6 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
>                                   shmem_opts ? shmem_opts : "",
>                                   args->opts_source ? args->opts_source : "",
>                                   ignore_stderr);
> -    if (!args->only_target) {
> -        *from = qtest_init_ext(QEMU_ENV_SRC, cmd_source, capabilities, true);
> -        qtest_qmp_set_event_callback(*from,
> -                                     migrate_watch_for_events,
> -                                     &src_state);
> -    }
>  
>      /*
>       * If the monitor connection is deferred, enable events on the command line
> @@ -415,6 +395,39 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
>                                   shmem_opts ? shmem_opts : "",
>                                   args->opts_target ? args->opts_target : "",
>                                   ignore_stderr);
> +
> +    *from = cmd_source;
> +    *to = cmd_target;
> +}
> +
> +int migrate_start(QTestState **from, QTestState **to, const char *uri,
> +                  MigrateStart *args)
> +{
> +    g_autofree gchar *cmd_source = NULL;
> +    g_autofree gchar *cmd_target = NULL;
> +    g_autoptr(QList) capabilities = migrate_start_get_qmp_capabilities(args);
> +
> +    if (args->use_shmem) {
> +        if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
> +            g_test_skip("/dev/shm is not supported");
> +            return -1;
> +        }
> +    }
> +
> +    dst_state = (QTestMigrationState) { };
> +    src_state = (QTestMigrationState) { };
> +    bootfile_create(qtest_get_arch(), tmpfs, args->suspend_me);
> +    src_state.suspend_me = args->suspend_me;

I've been thinking of moving QTestState inside QTestMigrationState, so
these variables are not loosely kept without a accompanying
QTestState. When implementing ping-pong tests the current code got a bit
out of hand. Also the "src_serial" problem later on would be resolved by
a new qtms->serial.

What's stopping me at the moment is the amount of churn. If you spot a
better solution let be know.

> +
> +    migrate_args(&cmd_source, &cmd_target, uri, args);
> +
> +    if (!args->only_target) {
> +        *from = qtest_init_ext(QEMU_ENV_SRC, cmd_source, capabilities, true);
> +        qtest_qmp_set_event_callback(*from,
> +                                     migrate_watch_for_events,
> +                                     &src_state);
> +    }
> +
>      if (!args->only_source) {
>          *to = qtest_init_ext(QEMU_ENV_DST, cmd_target, capabilities,
>                               !args->defer_target_connect);
> @@ -428,6 +441,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
>       * It's valid because QEMU has already opened this file
>       */
>      if (args->use_shmem) {
> +        g_autofree char *shmem_path = test_shmem_path();
>          unlink(shmem_path);
>      }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

