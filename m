Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBAAC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 15:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx4SI-0003KI-TX; Thu, 20 Aug 2026 11:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wx4SH-0003K9-FT
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 11:13:21 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wx4SE-00019Q-KM
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 11:13:21 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F34423EA4;
 Thu, 20 Aug 2026 15:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787238791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zoB2G6ZLSJvl2Dk24plEaEMUiW2DyCvyqZgT/T7sSwU=;
 b=rG/8U5qhLeLuOTjCJH2EinkFjh0oV58aB21Sv8ZVCCl0qmx5mIv4EukjRjnNorxRRBSGhq
 j5ewkSDEG6KDZEekQ0iY/XxI4BEu1o58nHQKpXg/EeWVOTEh1429qqBpcUAGHq0diIz/Q4
 M2XysAdRQzMbardicDnN60Ok7G+x+hU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787238791;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zoB2G6ZLSJvl2Dk24plEaEMUiW2DyCvyqZgT/T7sSwU=;
 b=7CI61y883sJRE0jDJ9vQZ6Cb6TiNny+K6iPw78M6MuriGDwNQS0i29w862lYBbkMnbLHZF
 eX8pRlypZZB0eTAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HRaWBtZQ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vqWHxQaz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787238787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zoB2G6ZLSJvl2Dk24plEaEMUiW2DyCvyqZgT/T7sSwU=;
 b=HRaWBtZQ5WWzCeRKI3J97uC1Roe2Cey9IdvFJMFBYwLpS82v4TXmRl84O+rHJW3iS0D2XF
 3SHwjWXKspegVBdFoKdsyT0+aJfS7NFyiSnD9Kzvh+QBkgnSxrbOt+Oad2jIOsxoCf+MrJ
 UeeoSXgI0aM/xGH2md+Ac8Ctm4Lhm5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787238787;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zoB2G6ZLSJvl2Dk24plEaEMUiW2DyCvyqZgT/T7sSwU=;
 b=vqWHxQazfYZDNiYxbd8XkThOg+DgPLjsZ/WgDX5aY2AJxYvWZ3IWsuSXEG8lalk5zHMHQR
 A4rnUGyhUQ3ybzAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95BDC27A8;
 Thu, 20 Aug 2026 15:13:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E1DEGYIZh2p1GgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 20 Aug 2026 15:13:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: phind.uet@gmail.com, Peter Xu <peterx@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/3] tests/migration: Factor out per-process launch and
 setup helpers
In-Reply-To: <20260709130032.58667-2-phind.uet@gmail.com>
References: <20260709130032.58667-1-phind.uet@gmail.com>
 <20260709130032.58667-2-phind.uet@gmail.com>
Date: Thu, 20 Aug 2026 12:13:00 -0300
Message-ID: <87o6ewltab.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FREEMAIL_TO(0.00)[gmail.com,redhat.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[gmail.com,nongnu.org]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 TAGGED_RCPT(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: F34423EA4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

phind.uet@gmail.com writes:

> From: Nguyen Dinh Phi <phind.uet@gmail.com>
>

Hi, sorry for the delay, this series conflicts with some ongoing work
I'm doing so I had to find time to double check.

> migrate_start() always spawned source and destination together, and
> migrate_start_set_capabilities() required both QTestState pointers at
> once. This coupling prevents launching a third QEMU instance or
> re-configuring an existing destination as a new source.
>

What about migrate_end? Don't you need to allow instances to be freed
individually as well?

> Split the logic into three public helpers:
>
>   migrate_launch_source() / migrate_launch_dest()
>     Spawn a single QEMU process and record its serial file path on
>     the returned QTestState.
>
>   migrate_setup_instance()
>     Register the event callback and apply migration capabilities to
>     one already-running process.  Can be called again to re-wire the
>     same process for a different role.
>
> migrate_start() is kept for backward compatibility and now delegates
> to these helpers internally.
>
> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> ---
>  tests/qtest/migration/framework.c | 253 +++++++++++++++++-------------
>  tests/qtest/migration/framework.h |  18 ++-
>  2 files changed, 165 insertions(+), 106 deletions(-)
>
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> index a830b96f41..305b8968ff 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -208,9 +208,11 @@ static QList *migrate_start_get_qmp_capabilities(const MigrateStart *args)
>      return capabilities;
>  }
>  
> -static void migrate_start_set_capabilities(QTestState *from, QTestState *to,
> -                                           MigrateStart *args)
> +void migrate_setup_instance(QTestState *who, QTestMigrationState *state,
> +                   MigrateStart *args)
>  {
> +    qtest_qmp_set_event_callback(who, migrate_watch_for_events, state);

You could pass in a defer_connect boolean in here and exit at this
point, no need to set the callback operation in the caller as well.

> +    *state = (QTestMigrationState) { .suspend_me = args->suspend_me };
>      /*
>       * MigrationCapability_lookup and MIGRATION_CAPABILITY_ constants
>       * are from qapi-types-migration.h.
> @@ -220,25 +222,13 @@ static void migrate_start_set_capabilities(QTestState *from, QTestState *to,
>       * Enable return path first, since other features depend on it.
>       */
>      if (args->caps[MIGRATION_CAPABILITY_RETURN_PATH]) {
> -        if (from) {
> -            migrate_set_capability(from, "return-path", true);
> -        }
> -        if (to) {
> -            migrate_set_capability(to, "return-path", true);
> -        }
> +        migrate_set_capability(who, "return-path", true);
>      }
>  
>      for (uint8_t i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
> -        if (!args->caps[i]) {
> -            continue;
> -        }
> -        if (from) {
> -            migrate_set_capability(from,
> -                            MigrationCapability_lookup.array[i], true);
> -        }
> -        if (to) {
> -            migrate_set_capability(to,
> -                            MigrationCapability_lookup.array[i], true);
> +        if (args->caps[i]) {
> +            migrate_set_capability(who, MigrationCapability_lookup.array[i],
> +                                   true);
>          }
>      }
>  
> @@ -246,26 +236,17 @@ static void migrate_start_set_capabilities(QTestState *from, QTestState *to,
>       * Always enable migration events.  Libvirt always uses it, let's try
>       * to mimic as closer as that.
>       */
> -    migrate_set_capability(from, "events", true);
> -    if (!args->defer_target_connect && to) {
> -        migrate_set_capability(to, "events", true);
> -    }
> +    migrate_set_capability(who, "events", true);
>  
> -    /*
> +     /*

Please keep the open comment mark in the correct place.

>       * Default number of channels should be fine for most
>       * tests. Individual tests can override by calling
>       * migrate_set_parameter() directly.
>       */
>      if (args->caps[MIGRATION_CAPABILITY_MULTIFD]) {
> -        migrate_set_parameter_int(from, "multifd-channels",
> +        migrate_set_parameter_int(who, "multifd-channels",
>                                    MULTIFD_TEST_CHANNELS);
> -        if (to) {
> -            migrate_set_parameter_int(to, "multifd-channels",
> -                                      MULTIFD_TEST_CHANNELS);
> -        }
>      }
> -
> -    return;
>  }
>  
>  static char *test_shmem_path(void)
> @@ -308,12 +289,28 @@ static char *migrate_mem_type_get_opts(MemType type, const char *memory_size)
>      return opts;
>  }
>  
> -int migrate_args(char **from, char **to, MigrateStart *args)
> +/*
> + * Build a QEMU command line for one migration participant.
> + *
> + * @serial_name  : serial output file basename under tmpfs
> + * @is_target    : set to true if the new qemu process is destination side

If we now have launch_source|dest, we shouldn't need to pass this flag in.

> + * @extra_opts   : extra arguments
> + * @defer_events : when true and is_target is set, use the command-line
> + *                 event flag instead of the QMP capability (for deferred
> + *                 monitor connections)

Same here.

> + * @args         : common process settings
> + *
> + * Returns 0 and sets *cmd_out on success.  Returns -1 and calls
> + * g_test_skip() if the machine type is not available.
> + */
> +static int migrate_build_cmd(const char *serial_name,
> +                             bool is_target,
> +                             const char *extra_opts,
> +                             bool defer_events,
> +                             MigrateStart *args,
> +                             char **cmd_out)
>  {
> -    /* options for source and target */
>      g_autofree gchar *arch_opts = NULL;
> -    gchar *cmd_source = NULL;
> -    gchar *cmd_target = NULL;
>      const gchar *ignore_stderr;
>      g_autofree char *mem_object = NULL;
>      const char *kvm_opts = NULL;
> @@ -323,16 +320,10 @@ int migrate_args(char **from, char **to, MigrateStart *args)
>      g_autofree char *machine = NULL;
>      const char *bootpath = bootfile_get();
>      g_autofree char *memory_backend = NULL;
> -    const char *events;
>  
>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
>          memory_size = "150M";
> -
> -        if (g_str_equal(arch, "i386")) {
> -            machine_alias = "pc";
> -        } else {
> -            machine_alias = "q35";
> -        }
> +        machine_alias = g_str_equal(arch, "i386") ? "pc" : "q35";

We usually wouldn't include changes of this kind among other
things. This could be an individual patch if you think it's worth it.
(I think we should just leave it alone)

>          arch_opts = g_strdup_printf(
>              "-drive if=none,id=d0,file=%s,format=raw "
>              "-device ide-hd,drive=d0,secs=1,cyls=1,heads=1", bootpath);
> @@ -346,13 +337,13 @@ int migrate_args(char **from, char **to, MigrateStart *args)
>          end_address = S390_TEST_MEM_END;
>      } else if (strcmp(arch, "ppc64") == 0) {
>          memory_size = "256M";
> -        start_address = PPC_TEST_MEM_START;
> -        end_address = PPC_TEST_MEM_END;
>          machine_alias = "pseries";
>          machine_opts = "vsmt=8";
>          arch_opts = g_strdup_printf(
>              "-nodefaults -machine " PSERIES_DEFAULT_CAPABILITIES " "
>              "-bios %s", bootpath);
> +        start_address = PPC_TEST_MEM_START;
> +        end_address = PPC_TEST_MEM_END;

This moved for no reason...

>      } else if (strcmp(arch, "aarch64") == 0) {
>          memory_size = "150M";
>          machine_alias = "virt";
> @@ -394,53 +385,103 @@ int migrate_args(char **from, char **to, MigrateStart *args)
>      }
>  
>      if (!qtest_has_machine(machine_alias)) {
> -        g_autofree char *msg = g_strdup_printf("machine %s not supported", machine_alias);
> +        g_autofree char *msg = g_strdup_printf("machine %s not supported",
> +                                               machine_alias);

Same here, this can stay as it is.

>          g_test_skip(msg);
>          return -1;
>      }
>  
>      machine = resolve_machine_version(machine_alias, QEMU_ENV_SRC,
>                                        QEMU_ENV_DST);
> -
>      g_test_message("Using machine type: %s", machine);
>  
> -    cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
> -                                 "-machine %s,%s "
> -                                 "-name source,debug-threads=on "
> -                                 "%s "
> -                                 "-serial file:%s/src_serial "
> -                                 "%s %s %s",
> -                                 kvm_opts ? kvm_opts : "",
> -                                 machine, machine_opts,
> -                                 memory_backend, tmpfs,
> -                                 arch_opts ? arch_opts : "",
> -                                 args->opts_source ? args->opts_source : "",
> -                                 ignore_stderr);
> +    if (is_target) {
> +        /*
> +         * If the monitor connection is deferred, enable events on the command
> +         * line so none are missed. This is for testing only, do not set
> +         * migration options like this in general.
> +         */
> +        const char *events = defer_events ? "-global migration.x-events=on"
> +                                          : "";
> +        *cmd_out = g_strdup_printf(
> +            "-accel kvm%s -accel tcg "
> +            "-machine %s,%s "
> +            "-name target,debug-threads=on "
> +            "%s "
> +            "-serial file:%s/%s "
> +            "-incoming defer "
> +            "%s %s %s %s",
> +            kvm_opts ? kvm_opts : "",
> +            machine, machine_opts,
> +            memory_backend, tmpfs, serial_name,
> +            events,
> +            arch_opts ? arch_opts : "",
> +            extra_opts ? extra_opts : "",
> +            ignore_stderr);
> +    } else {
> +        *cmd_out = g_strdup_printf(
> +            "-accel kvm%s -accel tcg "
> +            "-machine %s,%s "
> +            "-name source,debug-threads=on "
> +            "%s "
> +            "-serial file:%s/%s "
> +            "%s %s %s",
> +            kvm_opts ? kvm_opts : "",
> +            machine, machine_opts,
> +            memory_backend, tmpfs, serial_name,
> +            arch_opts ? arch_opts : "",
> +            extra_opts ? extra_opts : "",
> +            ignore_stderr);
> +    }

Let's move all the instance-specific information into the upper levels,
this conditional can go away, all information comes in via extra_opts:

    *cmd_out = g_strdup_printf(
        "-accel kvm%s -accel tcg "
        "-machine %s,%s "
        "%s "
        "-serial file:%s/%s "
        "%s %s %s",
        kvm_opts ? kvm_opts : "",
        machine, machine_opts,
        memory_backend, tmpfs, serial_name,
        arch_opts ? arch_opts : "",
        extra_opts ? extra_opts : "",
        ignore_stderr);

>  
> -    /*
> -     * If the monitor connection is deferred, enable events on the command line
> -     * so none are missed.  This is for testing only, do not set migration
> -     * options like this in general.
> -     */
> -    events = args->defer_target_connect ? "-global migration.x-events=on" : "";
> -
> -    cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
> -                                 "-machine %s,%s "
> -                                 "-name target,debug-threads=on "
> -                                 "%s "
> -                                 "-serial file:%s/dest_serial "
> -                                 "-incoming defer "
> -                                 "%s %s %s %s",
> -                                 kvm_opts ? kvm_opts : "",
> -                                 machine, machine_opts,
> -                                 memory_backend, tmpfs,
> -                                 events,
> -                                 arch_opts ? arch_opts : "",
> -                                 args->opts_target ? args->opts_target : "",
> -                                 ignore_stderr);
> -
> -    *from = cmd_source;
> -    *to = cmd_target;
> +    return 0;
> +}
> +
> +/*
> + * Launch a QEMU process as a migration source.
> + * Returns the QTestState on success, or NULL otherwise
> + */
> +QTestState *migrate_launch_source(const char *serial_name, MigrateStart *args)

If this is "launch_source" we already know the serial name is
"src_serial", no need to pass in.

The launch_* functions could return bool and receive the **qts as first
argument.

> +{
> +    g_autofree char *cmd = NULL;
> +    g_autoptr(QList) capabilities = migrate_start_get_qmp_capabilities(args);
> +
> +    if (migrate_build_cmd(serial_name, false, args->opts_source,
> +                          false, args, &cmd)) {

Here's what I'm thinking to remove the instance-specific information
from migrate_build_cmd:

static bool migrate_launch_instance(QTestState **qts, MigrateStart *args,
                                    QTestMigrationState *state, const char *env,
                                    bool defer_connect, char *cmd)
{
    g_autoptr(QList) capabilities = migrate_start_get_qmp_capabilities(args);

    *qts = qtest_init_ext(env, cmd, capabilities, !defer_connect);
    if (*qts) {
        migrate_setup_instance(*qts, state, args, defer_connect);
    }

    return !!*qts;
}

static bool migrate_build_dest(MigrateStart *args, char **cmd)
{
    g_autofree char *opts = NULL;
    int r;

    if (args->only_source) {
        return true;
    }

    /*
     * If the monitor connection is deferred, enable events on the command
     * line so none are missed. This is for testing only, do not set
     * migration options like this in general.
     */

    opts = g_strdup_printf(
        "-name target,debug-threads=on "
        "-incoming defer "
        "%s %s",
        args->defer_target_connect ? "-global migration.x-events=on" : "",
        args->opts_target ?: "");

    r = migrate_build_cmd("dest_serial", opts, args, cmd);
    return r == 0;
}

static bool migrate_launch_dest(QTestState **qts, MigrateStart *args)
{
    g_autofree char *cmd = NULL;

    if (!migrate_build_dest(args, &cmd)){
        return false;
    }

    if (cmd && !migrate_launch_instance(qts, args, &dst_state, QEMU_ENV_DST,
                                        args->defer_target_connect, cmd)) {
        return false;
    }

    return true;
}

migrate_args -> migrate_build_dest
migrate_start -> migrate_launch_dest -> migrate_build_dest

And similarly for the source.

What do you think?

> +        return NULL;
> +    }
> +    return qtest_init_ext(QEMU_ENV_SRC, cmd, capabilities, true);
> +}
> +
> +/*
> + * Launch a QEMU process as a migration destination.
> + * Returns the QTestState on success, or NULL otherwise
> + */
> +QTestState *migrate_launch_dest(const char *serial_name, MigrateStart *args)
> +{
> +    g_autofree char *cmd = NULL;
> +    g_autoptr(QList) capabilities = migrate_start_get_qmp_capabilities(args);
> +
> +    if (migrate_build_cmd(serial_name, true, args->opts_target,
> +                          args->defer_target_connect, args, &cmd)) {
> +        return NULL;
> +    }
> +    return qtest_init_ext(QEMU_ENV_DST, cmd, capabilities,
> +                          !args->defer_target_connect);
> +}
> +
> +int migrate_args(char **from, char **to, MigrateStart *args)
> +{
> +    if (migrate_build_cmd("src_serial", false, args->opts_source,
> +                          false, args, from)) {
> +        return -1;
> +    }
> +    if (migrate_build_cmd("dest_serial", true, args->opts_target,
> +                          args->defer_target_connect, args, to)) {
> +        g_free(*from);
> +        *from = NULL;
> +        return -1;
> +    }
>      return 0;
>  }
>  
> @@ -482,43 +523,45 @@ static void migrate_mem_type_cleanup(MemType type)
>  
>  int migrate_start(QTestState **from, QTestState **to, MigrateStart *args)
>  {
> -    g_autofree gchar *cmd_source = NULL;
> -    g_autofree gchar *cmd_target = NULL;
> -    g_autoptr(QList) capabilities = migrate_start_get_qmp_capabilities(args);
> -
>      if (!migrate_mem_type_prepare(args->mem_type)) {
>          return -1;
>      }
>  
> -    dst_state = (QTestMigrationState) { };
> -    src_state = (QTestMigrationState) { };
> +    src_state = (QTestMigrationState){};
> +    dst_state = (QTestMigrationState){};
>      bootfile_create(qtest_get_arch(), tmpfs, args->suspend_me);
> -    src_state.suspend_me = args->suspend_me;
> -
> -    if (migrate_args(&cmd_source, &cmd_target, args)) {
> -        return -1;
> -    }
>  
>      if (!args->only_target) {

The only_* checks can go into the _launch_source level, keeps this
function cleaner.

> -        *from = qtest_init_ext(QEMU_ENV_SRC, cmd_source, capabilities, true);
> -        qtest_qmp_set_event_callback(*from,
> -                                     migrate_watch_for_events,
> -                                     &src_state);
> +        *from = migrate_launch_source("src_serial", args);
> +        if (!*from) {
> +            return -1;
> +        }
> +        migrate_setup_instance(*from, &src_state, args);
>      }
>  
>      if (!args->only_source) {
> -        *to = qtest_init_ext(QEMU_ENV_DST, cmd_target, capabilities,
> -                             !args->defer_target_connect);
> -        qtest_qmp_set_event_callback(*to,
> -                                     migrate_watch_for_events,
> -                                     &dst_state);
> +        *to = migrate_launch_dest("dest_serial", args);
> +        if (!*to) {
> +            if (!args->only_target) {
> +                qtest_quit(*from);
> +            }
> +            return -1;
> +        }
> +        if (!args->defer_target_connect) {

This check would move into migrate_setup_instance.

> +            migrate_setup_instance(*to, &dst_state, args);
> +        } else {
> +            /*
> +             * The monitor is not connected yet; only register the event
> +             * callback so no events are missed.
> +             * The caller must call migrate_setup_instance() after
> +             * qtest_connect() if it wants to setup any capability
> +             */
> +            qtest_qmp_set_event_callback(*to, migrate_watch_for_events,
> +                                         &dst_state);
> +        }
>      }
>  
>      migrate_mem_type_cleanup(args->mem_type);
> -    migrate_start_set_capabilities(*from,
> -                                   args->only_source ? NULL : *to,
> -                                   args);
> -
>      return 0;
>  }
>  
> diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
> index 941cbd7102..f054ef8f4d 100644
> --- a/tests/qtest/migration/framework.h
> +++ b/tests/qtest/migration/framework.h
> @@ -225,10 +225,27 @@ typedef struct {
>      bool live;
>  } MigrateCommon;
>  
> +typedef struct QTestMigrationState QTestMigrationState;
> +
>  void wait_for_serial(const char *side);
>  void migrate_prepare_for_dirty_mem(QTestState *from);
>  void migrate_wait_for_dirty_mem(QTestState *from, QTestState *to);
>  
> +/*
> + * Start a QEMU process which has serial set to @serial_name
> + */
> +QTestState *migrate_launch_source(const char *serial_name, MigrateStart *args);
> +/*
> + * Start a QEMU process which has serial set to @serial_name
> + */
> +QTestState *migrate_launch_dest(const char *serial_name, MigrateStart *args);
> +/*
> + * Registers the event callback and sets migration capabilities on an
> + * already-running process
> + */
> +void migrate_setup_instance(QTestState *who, QTestMigrationState *state,
> +                   MigrateStart *args);

These don't need to be exported, keep them static.

> +
>  int migrate_args(char **from, char **to, MigrateStart *args);
>  int migrate_start(QTestState **from, QTestState **to, MigrateStart *args);
>  void migrate_end(QTestState *from, QTestState *to, bool test_dest);
> @@ -240,7 +257,6 @@ int test_precopy_common(MigrateCommon *args);
>  void test_precopy_unix_common(MigrateCommon *args);
>  void test_file_common(MigrateCommon *args, bool stop_src);
>  
> -typedef struct QTestMigrationState QTestMigrationState;
>  QTestMigrationState *get_src(void);
>  QTestMigrationState *get_dst(void);

