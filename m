Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9F1C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 15:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk37V-0002KX-Cb; Mon, 17 Feb 2025 10:33:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tk37S-0002K1-Pn
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 10:33:16 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tk37O-0003Bk-6k
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 10:33:12 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D47EE21167;
 Mon, 17 Feb 2025 15:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739806386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q3No0asvmWbPmMJaDRuUacl1UCbWpTNF1eoo1H4DdLI=;
 b=g36JL4xEWM7dCh9ExSdZ96cusijhOUAVLqzrjN/RVjbnGjs+KW8WklP6LQ0bgtTkeg5cxX
 Ug7Q4z2F0y09eFtgH7H8TMzGbNzfQ1KZlOTfSGHUD1vWvad0vX5njpdX+UZsNrP0tDTSL7
 0qgYie+9U9cJafvIZ1no1PmECnRocWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739806386;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q3No0asvmWbPmMJaDRuUacl1UCbWpTNF1eoo1H4DdLI=;
 b=TRvvCwWEQjGABWOrlg5sP3j4jYwP1NeDGFFtjMBc7iUXbbcsInTRC1Jyo2dOewDHt1pKRw
 yTnPrKmhqZh4PmAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=op5IY5V3;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rDUKI0Rl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739806385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q3No0asvmWbPmMJaDRuUacl1UCbWpTNF1eoo1H4DdLI=;
 b=op5IY5V3ajRsMsIcBaLFLJRymAmcS42Wx/d6o1Fpe4U47Hn487fSar11jXa4FlBkAXk5/3
 LcEWdhNZ1/7hssLzAjhAjvyir1v1wroWOxQK5rxQ09rFdRFARAgScPYxFSnaB7aEp3PvWP
 bZJDfyGOBUEXU+Tgp/pfgL+afQkC/UE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739806385;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q3No0asvmWbPmMJaDRuUacl1UCbWpTNF1eoo1H4DdLI=;
 b=rDUKI0Rl7LqxyQLdu3NeXCqxb3pgI4gvK9QnYfcE+TOEREM26LPWTPHJ1I+XzuIU7sCD/H
 Jk7DmqsyPwCyUGBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45A281379D;
 Mon, 17 Feb 2025 15:33:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id h9aEAbFWs2esOgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 17 Feb 2025 15:33:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com, Prasad Pandit
 <pjp@fedoraproject.org>
Subject: Re: [PATCH v6 4/4] tests/qtest/migration: add postcopy tests with
 multifd
In-Reply-To: <20250215123119.814345-5-ppandit@redhat.com>
References: <20250215123119.814345-1-ppandit@redhat.com>
 <20250215123119.814345-5-ppandit@redhat.com>
Date: Mon, 17 Feb 2025 12:33:02 -0300
Message-ID: <871pvwvb69.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: D47EE21167
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Prasad Pandit <ppandit@redhat.com> writes:

> From: Prasad Pandit <pjp@fedoraproject.org>
>
> Add new qtests to run postcopy migration with multifd
> channels enabled.
>
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>  tests/qtest/migration/compression-tests.c | 13 ++++++++
>  tests/qtest/migration/framework.c         |  4 +++
>  tests/qtest/migration/postcopy-tests.c    | 23 +++++++++++++
>  tests/qtest/migration/precopy-tests.c     | 19 +++++++++++
>  tests/qtest/migration/tls-tests.c         | 40 +++++++++++++++++++++++
>  5 files changed, 99 insertions(+)
>
> v6:
> - Reorder, make this the second patch in this series.
>
> v5:
> - https://lore.kernel.org/qemu-devel/20250205122712.229151-1-ppandit@redhat.com/T/#t
>
> diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
> index 4558a7b9ff..d4d6b3c4de 100644
> --- a/tests/qtest/migration/compression-tests.c
> +++ b/tests/qtest/migration/compression-tests.c
> @@ -40,6 +40,17 @@ static void test_multifd_tcp_zstd(void)
>      };
>      test_precopy_common(&args);
>  }
> +
> +static void test_multifd_postcopy_tcp_zstd(void)
> +{
> +    MigrateCommon args = {
> +        .listen_uri = "defer",
> +        .caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true,
> +        .start_hook = migrate_hook_start_precopy_tcp_multifd_zstd,
> +    };
> +
> +    test_precopy_common(&args);
> +}
>  #endif /* CONFIG_ZSTD */
>  
>  #ifdef CONFIG_QATZIP
> @@ -172,6 +183,8 @@ void migration_test_add_compression(MigrationTestEnv *env)
>  #ifdef CONFIG_ZSTD
>      migration_test_add("/migration/multifd/tcp/plain/zstd",
>                         test_multifd_tcp_zstd);
> +    migration_test_add("/migration/multifd+postcopy/tcp/plain/zstd",
> +                       test_multifd_postcopy_tcp_zstd);
>  #endif
>  
>  #ifdef CONFIG_QATZIP
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> index 82aaa13e85..2396405b51 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -469,6 +469,10 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
>      args->caps[MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME] = true;
>      args->caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true;
>      set_migration_capabilities(from, to, args);
> +    if (args->caps[MIGRATION_CAPABILITY_MULTIFD]) {
> +        migrate_set_parameter_int(from, "multifd-channels", 8);
> +        migrate_set_parameter_int(to, "multifd-channels", 8);
> +    }
>  
>      migrate_ensure_non_converge(from);
>      migrate_prepare_for_dirty_mem(from);
> diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
> index b0e70a6367..32fe7b0324 100644
> --- a/tests/qtest/migration/postcopy-tests.c
> +++ b/tests/qtest/migration/postcopy-tests.c
> @@ -90,6 +90,25 @@ static void migration_test_add_postcopy_smoke(MigrationTestEnv *env)
>      }
>  }
>  
> +static void test_multifd_postcopy(void)
> +{
> +    MigrateCommon args = {
> +        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> +    };
> +
> +    test_postcopy_common(&args);
> +}
> +
> +static void test_multifd_postcopy_preempt(void)
> +{
> +    MigrateCommon args = {
> +        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> +        .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
> +    };
> +
> +    test_postcopy_common(&args);
> +}
> +
>  void migration_test_add_postcopy(MigrationTestEnv *env)
>  {
>      migration_test_add_postcopy_smoke(env);
> @@ -110,6 +129,10 @@ void migration_test_add_postcopy(MigrationTestEnv *env)
>              "/migration/postcopy/recovery/double-failures/reconnect",
>              test_postcopy_recovery_fail_reconnect);
>  
> +        migration_test_add("/migration/multifd+postcopy/plain",
> +                           test_multifd_postcopy);
> +        migration_test_add("/migration/multifd+postcopy/preempt/plain",
> +                           test_multifd_postcopy_preempt);

For postcopy-tests.c I'd use /migration/postcopy/multifd so we can run
them all via command-line. These are also the only ones actually doing
postcopy migration. We need to distinguish multifd+postcopy proper from
merely postcopy-ram=true.

>          if (env->is_x86) {
>              migration_test_add("/migration/postcopy/suspend",
>                                 test_postcopy_suspend);
> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> index e5d8c49dbe..2126cb8e2c 100644
> --- a/tests/qtest/migration/precopy-tests.c
> +++ b/tests/qtest/migration/precopy-tests.c
> @@ -33,6 +33,7 @@
>  #define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
>  
>  static char *tmpfs;
> +static bool postcopy_ram = false;
>  
>  static void test_precopy_unix_plain(void)
>  {
> @@ -465,6 +466,11 @@ static void test_multifd_tcp_cancel(void)
>      migrate_ensure_non_converge(from);
>      migrate_prepare_for_dirty_mem(from);
>  
> +    if (postcopy_ram) {
> +        migrate_set_capability(from, "postcopy-ram", true);
> +        migrate_set_capability(to, "postcopy-ram", true);
> +    }
> +
>      migrate_set_parameter_int(from, "multifd-channels", 16);
>      migrate_set_parameter_int(to, "multifd-channels", 16);
>  
> @@ -506,6 +512,10 @@ static void test_multifd_tcp_cancel(void)
>          return;
>      }
>  
> +    if (postcopy_ram) {
> +        migrate_set_capability(to2, "postcopy-ram", true);
> +    }
> +
>      migrate_set_parameter_int(to2, "multifd-channels", 16);
>  
>      migrate_set_capability(to2, "multifd", true);
> @@ -529,6 +539,13 @@ static void test_multifd_tcp_cancel(void)
>      migrate_end(from, to2, true);
>  }
>  
> +static void test_multifd_postcopy_tcp_cancel(void)
> +{
> +    postcopy_ram = true;
> +    test_multifd_tcp_cancel();
> +    postcopy_ram = false;

You could pass this in, there's just one other caller.

> +}
> +
>  static void calc_dirty_rate(QTestState *who, uint64_t calc_time)
>  {
>      qtest_qmp_assert_success(who,
> @@ -1001,6 +1018,8 @@ void migration_test_add_precopy(MigrationTestEnv *env)
>                         test_multifd_tcp_zero_page_legacy);
>      migration_test_add("/migration/multifd/tcp/plain/zero-page/none",
>                         test_multifd_tcp_no_zero_page);
> +    migration_test_add("migration/multifd+postcopy/tcp/plain/cancel",
> +                       test_multifd_postcopy_tcp_cancel);
>      if (g_str_equal(env->arch, "x86_64")
>          && env->has_kvm && env->has_dirty_ring) {
>  
> diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
> index 30ab79e058..ce57f0cb5d 100644
> --- a/tests/qtest/migration/tls-tests.c
> +++ b/tests/qtest/migration/tls-tests.c
> @@ -393,6 +393,17 @@ static void test_postcopy_recovery_tls_psk(void)
>      test_postcopy_recovery_common(&args);
>  }
>  
> +static void test_multifd_postcopy_recovery_tls_psk(void)
> +{
> +    MigrateCommon args = {
> +        .start_hook = migrate_hook_start_tls_psk_match,
> +        .end_hook = migrate_hook_end_tls_psk,
> +        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> +    };
> +
> +    test_postcopy_recovery_common(&args);
> +}
> +
>  /* This contains preempt+recovery+tls test altogether */
>  static void test_postcopy_preempt_all(void)
>  {
> @@ -405,6 +416,17 @@ static void test_postcopy_preempt_all(void)
>      test_postcopy_recovery_common(&args);
>  }
>  
> +static void test_multifd_postcopy_preempt_recovery_tls_psk(void)
> +{
> +    MigrateCommon args = {
> +        .start_hook = migrate_hook_start_tls_psk_match,
> +        .end_hook = migrate_hook_end_tls_psk,
> +        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> +    };
> +
> +    test_postcopy_recovery_common(&args);
> +}
> +
>  static void test_precopy_unix_tls_psk(void)
>  {
>      g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
> @@ -651,6 +673,18 @@ static void test_multifd_tcp_tls_psk_mismatch(void)
>      test_precopy_common(&args);
>  }
>  
> +static void test_multifd_postcopy_tcp_tls_psk_match(void)
> +{
> +    MigrateCommon args = {
> +        .listen_uri = "defer",
> +        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> +        .start_hook = migrate_hook_start_multifd_tcp_tls_psk_match,
> +        .end_hook = migrate_hook_end_tls_psk,
> +    };
> +
> +    test_precopy_common(&args);
> +}
> +
>  #ifdef CONFIG_TASN1
>  static void test_multifd_tcp_tls_x509_default_host(void)
>  {
> @@ -762,6 +796,10 @@ void migration_test_add_tls(MigrationTestEnv *env)
>                             test_postcopy_preempt_tls_psk);
>          migration_test_add("/migration/postcopy/preempt/recovery/tls/psk",
>                             test_postcopy_preempt_all);
> +        migration_test_add("/migration/multifd+postcopy/recovery/tls/psk",
> +                           test_multifd_postcopy_recovery_tls_psk);
> +        migration_test_add("/migration/multifd+postcopy/preempt/recovery/tls/psk",
> +                           test_multifd_postcopy_preempt_recovery_tls_psk);
>      }
>  #ifdef CONFIG_TASN1
>      migration_test_add("/migration/precopy/unix/tls/x509/default-host",
> @@ -793,6 +831,8 @@ void migration_test_add_tls(MigrationTestEnv *env)
>                         test_multifd_tcp_tls_psk_match);
>      migration_test_add("/migration/multifd/tcp/tls/psk/mismatch",
>                         test_multifd_tcp_tls_psk_mismatch);
> +    migration_test_add("/migration/multifd+postcopy/tcp/tls/psk/match",
> +                       test_multifd_postcopy_tcp_tls_psk_match);
>  #ifdef CONFIG_TASN1
>      migration_test_add("/migration/multifd/tcp/tls/x509/default-host",
>                         test_multifd_tcp_tls_x509_default_host);
> --
> 2.48.1

