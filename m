Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FE2D25B4F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 12:40:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl4j1-0007mo-R8; Wed, 28 Jan 2026 07:32:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vl4it-0007i9-Mc
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 07:32:40 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vl4ir-0001J0-5u
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 07:32:39 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 75C015BCDF;
 Wed, 28 Jan 2026 12:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769603554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8anmzH8ftS8DQ0Vz5SeyN2NxJPMR+UoBAFz8alm86eo=;
 b=dDK3FT21m5jRcTnepYdC1XWFJOnJ4zFoRFDQJsz2iS88K8y7m0J8B6x3MXvoXZ6iLWfbkk
 YBoSjJWEk6QkRsuYBDy0KPN6OOJqi0I0BIa+dU1xXqLMcPD7cEU4xCBIAZh4l+A/yu6egh
 ADaVJr/rXxS6guwzzzdP2i9huwBdl6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769603554;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8anmzH8ftS8DQ0Vz5SeyN2NxJPMR+UoBAFz8alm86eo=;
 b=FxIXg4zaeFfvOBKZ2fPEJ8/AaNCdN8Ri9nIu//FCZUnftZuiPAzsosISwQTzgop1J8fbcr
 GlYo4OMcVWKg/5Bw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dDK3FT21;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FxIXg4za
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769603554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8anmzH8ftS8DQ0Vz5SeyN2NxJPMR+UoBAFz8alm86eo=;
 b=dDK3FT21m5jRcTnepYdC1XWFJOnJ4zFoRFDQJsz2iS88K8y7m0J8B6x3MXvoXZ6iLWfbkk
 YBoSjJWEk6QkRsuYBDy0KPN6OOJqi0I0BIa+dU1xXqLMcPD7cEU4xCBIAZh4l+A/yu6egh
 ADaVJr/rXxS6guwzzzdP2i9huwBdl6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769603554;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8anmzH8ftS8DQ0Vz5SeyN2NxJPMR+UoBAFz8alm86eo=;
 b=FxIXg4zaeFfvOBKZ2fPEJ8/AaNCdN8Ri9nIu//FCZUnftZuiPAzsosISwQTzgop1J8fbcr
 GlYo4OMcVWKg/5Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDBBF3EA61;
 Wed, 28 Jan 2026 12:32:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tZ9hJ+EBemkkCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Jan 2026 12:32:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Hailiang
 Zhang <zhanghailiang@xfusion.com>, Markus Armbruster <armbru@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, "Dr. David Alan Gilbert"
 <dave@treblig.org>, Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v3 06/10] migration-test: Add COLO migration unit test
In-Reply-To: <20260125-colo_unit_test_multifd-v3-6-ae926ccd8eae@web.de>
References: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
 <20260125-colo_unit_test_multifd-v3-6-ae926ccd8eae@web.de>
Date: Wed, 28 Jan 2026 09:32:31 -0300
Message-ID: <87sebpgbog.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com,web.de];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 FREEMAIL_TO(0.00)[web.de,nongnu.org]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,xfusion.com,fujitsu.com,treblig.org,web.de];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[11]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:mid, suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 75C015BCDF
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Lukas Straub <lukasstraub2@web.de> writes:

> Add a COLO migration test for COLO migration and failover.
>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  MAINTAINERS                        |   1 +
>  tests/qtest/meson.build            |   7 +-
>  tests/qtest/migration-test.c       |   1 +
>  tests/qtest/migration/colo-tests.c | 199 +++++++++++++++++++++++++++++++++++++
>  tests/qtest/migration/framework.h  |   5 +
>  5 files changed, 212 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 883f0a8f4eb92d0bf0f89fcab4674ccc4aed1cc1..2a8b9b2d051883c1b7adce9c1afec80d16a317f8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3856,6 +3856,7 @@ F: migration/colo*
>  F: migration/multifd-colo.*
>  F: include/migration/colo.h
>  F: include/migration/failover.h
> +F: tests/qtest/migration/colo-tests.c
>  F: docs/COLO-FT.txt
>  
>  COLO Proxy
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index dfb83650c643d884daad53a66034ab7aa8c45509..624f7744ec9bd81c8823075b966bc95f7750a667 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -371,6 +371,11 @@ if gnutls.found()
>    endif
>  endif
>  
> +migration_colo_files = []
> +if get_option('replication').allowed()
> +  migration_colo_files = [files('migration/colo-tests.c')]
> +endif
> +
>  qtests = {
>    'aspeed_hace-test': files('aspeed-hace-utils.c', 'aspeed_hace-test.c'),
>    'aspeed_smc-test': files('aspeed-smc-utils.c', 'aspeed_smc-test.c'),
> @@ -382,7 +387,7 @@ qtests = {
>                               'migration/migration-util.c') + dbus_vmstate1,
>    'erst-test': files('erst-test.c'),
>    'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
> -  'migration-test': test_migration_files + migration_tls_files,
> +  'migration-test': test_migration_files + migration_tls_files + migration_colo_files,
>    'pxe-test': files('boot-sector.c'),
>    'pnv-xive2-test': files('pnv-xive2-common.c', 'pnv-xive2-flush-sync.c',
>                            'pnv-xive2-nvpg_bar.c'),
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 08936871741535c926eeac40a7d7c3f461c72fd0..e582f05c7dc2673dbd05a936df8feb6c964b5bbc 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -55,6 +55,7 @@ int main(int argc, char **argv)
>      migration_test_add_precopy(env);
>      migration_test_add_cpr(env);
>      migration_test_add_misc(env);
> +    migration_test_add_colo(env);
>  
>      ret = g_test_run();
>  
> diff --git a/tests/qtest/migration/colo-tests.c b/tests/qtest/migration/colo-tests.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..0586970e206f01ed6e7aa3429321aefc1de7be37
> --- /dev/null
> +++ b/tests/qtest/migration/colo-tests.c
> @@ -0,0 +1,199 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * QTest testcases for COLO migration
> + *
> + * Copyright (c) 2025 Lukas Straub <lukasstraub2@web.de>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "migration/framework.h"
> +#include "migration/migration-qmp.h"
> +#include "migration/migration-util.h"
> +#include "qemu/module.h"
> +
> +static int test_colo_common(MigrateCommon *args,
> +                            bool failover_during_checkpoint,
> +                            bool primary_failover)
> +{
> +    QTestState *from, *to;
> +    void *data_hook = NULL;
> +
> +    /*
> +     * For the COLO test, both VMs will run in parallel. Thus both VMs want to
> +     * open the image read/write at the same time. Using read-only=on is not
> +     * possible here, because ide-hd does not support read-only backing image.
> +     *
> +     * So use -snapshot, where each qemu instance creates its own writable
> +     * snapshot internally while leaving the real image read-only.
> +     */
> +    args->start.opts_source = "-snapshot";
> +    args->start.opts_target = "-snapshot";
> +
> +    /*
> +     * COLO migration code logs many errors when the migration socket
> +     * is shut down, these are expected so we hide them here.
> +     */
> +    args->start.hide_stderr = true;
> +
> +    args->start.oob = true;
> +    args->start.caps[MIGRATION_CAPABILITY_X_COLO] = true;
> +
> +    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
> +        return -1;
> +    }
> +
> +    migrate_set_parameter_int(from, "x-checkpoint-delay", 300);
> +
> +    if (args->start_hook) {
> +        data_hook = args->start_hook(from, to);
> +    }
> +
> +    migrate_ensure_converge(from);
> +    wait_for_serial("src_serial");
> +
> +    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
> +
> +    wait_for_migration_status(from, "colo", NULL);
> +    wait_for_resume(to, get_dst());
> +
> +    wait_for_serial("src_serial");
> +    wait_for_serial("dest_serial");
> +
> +    /* wait for 3 checkpoints */
> +    for (int i = 0; i < 3; i++) {
> +        qtest_qmp_eventwait(to, "RESUME");
> +        wait_for_serial("src_serial");
> +        wait_for_serial("dest_serial");
> +    }
> +
> +    if (failover_during_checkpoint) {
> +        qtest_qmp_eventwait(to, "STOP");
> +    }
> +    if (primary_failover) {
> +        qtest_qmp_assert_success(from, "{'exec-oob': 'yank', 'id': 'yank-cmd', "
> +                                            "'arguments': {'instances':"
> +                                                "[{'type': 'migration'}]}}");
> +        qtest_qmp_assert_success(from, "{'execute': 'x-colo-lost-heartbeat'}");
> +        wait_for_serial("src_serial");
> +    } else {
> +        qtest_qmp_assert_success(to, "{'exec-oob': 'yank', 'id': 'yank-cmd', "
> +                                        "'arguments': {'instances':"
> +                                            "[{'type': 'migration'}]}}");
> +        qtest_qmp_assert_success(to, "{'execute': 'x-colo-lost-heartbeat'}");
> +        wait_for_serial("dest_serial");
> +    }
> +
> +    if (args->end_hook) {
> +        args->end_hook(from, to, data_hook);
> +    }
> +
> +    migrate_end(from, to, !primary_failover);
> +
> +    return 0;
> +}
> +
> +static void test_colo_plain_common(MigrateCommon *args,
> +                                   bool failover_during_checkpoint,
> +                                   bool primary_failover)
> +{
> +    args->listen_uri = "tcp:127.0.0.1:0";
> +    test_colo_common(args, failover_during_checkpoint, primary_failover);
> +}
> +
> +static void *hook_start_multifd(QTestState *from, QTestState *to)
> +{
> +    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
> +}
> +
> +static void test_colo_multifd_common(MigrateCommon *args,
> +                                     bool failover_during_checkpoint,
> +                                     bool primary_failover)
> +{
> +    args->listen_uri = "defer";
> +    args->start_hook = hook_start_multifd;
> +    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
> +    test_colo_common(args, failover_during_checkpoint, primary_failover);
> +}
> +
> +static void test_colo_plain_primary_failover(char *name, MigrateCommon *args)
> +{
> +    test_colo_plain_common(args, false, true);
> +}
> +
> +static void test_colo_plain_secondary_failover(char *name, MigrateCommon *args)
> +{
> +    test_colo_plain_common(args, false, false);
> +}
> +
> +static void test_colo_multifd_primary_failover(char *name, MigrateCommon *args)
> +{
> +    test_colo_multifd_common(args, false, true);
> +}
> +
> +static void test_colo_multifd_secondary_failover(char *name,
> +                                                 MigrateCommon *args)
> +{
> +    test_colo_multifd_common(args, false, false);
> +}
> +
> +static void test_colo_plain_primary_failover_checkpoint(char *name,
> +                                                        MigrateCommon *args)
> +{
> +    test_colo_plain_common(args, true, true);
> +}
> +
> +static void test_colo_plain_secondary_failover_checkpoint(char *name,
> +                                                          MigrateCommon *args)
> +{
> +    test_colo_plain_common(args, true, false);
> +}
> +
> +static void test_colo_multifd_primary_failover_checkpoint(char *name,
> +                                                          MigrateCommon *args)
> +{
> +    test_colo_multifd_common(args, true, true);
> +}
> +
> +static void test_colo_multifd_secondary_failover_checkpoint(char *name,
> +                                                            MigrateCommon *args)
> +{
> +    test_colo_multifd_common(args, true, false);
> +}
> +
> +void migration_test_add_colo(MigrationTestEnv *env)
> +{
> +    if (!env->has_kvm) {
> +        g_test_skip("COLO requires KVM accelerator");
> +        return;
> +    }
> +
> +    if (!env->full_set) {
> +        return;
> +    }
> +
> +    migration_test_add("/migration/colo/plain/primary_failover",
> +                       test_colo_plain_primary_failover);
> +    migration_test_add("/migration/colo/plain/secondary_failover",
> +                       test_colo_plain_secondary_failover);
> +
> +    migration_test_add("/migration/colo/multifd/primary_failover",
> +                       test_colo_multifd_primary_failover);
> +    migration_test_add("/migration/colo/multifd/secondary_failover",
> +                       test_colo_multifd_secondary_failover);
> +
> +    migration_test_add("/migration/colo/plain/primary_failover_checkpoint",
> +                       test_colo_plain_primary_failover_checkpoint);
> +    migration_test_add("/migration/colo/plain/secondary_failover_checkpoint",
> +                       test_colo_plain_secondary_failover_checkpoint);
> +
> +    migration_test_add("/migration/colo/multifd/primary_failover_checkpoint",
> +                       test_colo_multifd_primary_failover_checkpoint);
> +    migration_test_add("/migration/colo/multifd/secondary_failover_checkpoint",
> +                       test_colo_multifd_secondary_failover_checkpoint);
> +}
> diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
> index 40984d04930da2d181326d9f6a742bde49018103..80eef758932ce9c301ed6c0f6383d18756144870 100644
> --- a/tests/qtest/migration/framework.h
> +++ b/tests/qtest/migration/framework.h
> @@ -264,5 +264,10 @@ void migration_test_add_file(MigrationTestEnv *env);
>  void migration_test_add_precopy(MigrationTestEnv *env);
>  void migration_test_add_cpr(MigrationTestEnv *env);
>  void migration_test_add_misc(MigrationTestEnv *env);
> +#ifdef CONFIG_REPLICATION
> +void migration_test_add_colo(MigrationTestEnv *env);
> +#else
> +static inline void migration_test_add_colo(MigrationTestEnv *env) {};
> +#endif
>  
>  #endif /* TEST_FRAMEWORK_H */

It survived my stress run. It hit once the race at migration_shutdown()
where current_migration is already freed, but we can ignore that because
it's preexisting.

Tested-by: Fabiano Rosas <farosas@suse.de>

