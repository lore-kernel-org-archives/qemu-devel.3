Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A06C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 21:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcWQL-0004iW-VJ; Mon, 27 Jan 2025 16:13:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tcWQE-0004Zm-QX
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 16:13:32 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tcWQB-0000lA-N0
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 16:13:30 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9A85D1F383;
 Mon, 27 Jan 2025 21:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738012404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SVgTa1yOzE0Y1vvLklyWntdwmoSRGc1Oef4CSK9qBBc=;
 b=vIXr6z5C13k3fpB68FJ+EOoQ2VQUWhY/OHgPmqerDMVFCk9uA4Vdea/uQsAE9MarXshkof
 jaMs5yz1beOCOM1ELbalb4xKU2xR9R3YO5mpSew5AVAJ8xZrAYJMwxIzR/e1FjmYoGJnmV
 5RORPB8FTsqPzdv170pnKwu4oNnCBco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738012404;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SVgTa1yOzE0Y1vvLklyWntdwmoSRGc1Oef4CSK9qBBc=;
 b=JoxStMsh4FhZILZ9T9o/5i7oD4QwPrmYNfwL9zJVti3nJR75Nsw/yzpdJPj0l3Zp9G49Ay
 dBUxmee/KXmTubDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738012404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SVgTa1yOzE0Y1vvLklyWntdwmoSRGc1Oef4CSK9qBBc=;
 b=vIXr6z5C13k3fpB68FJ+EOoQ2VQUWhY/OHgPmqerDMVFCk9uA4Vdea/uQsAE9MarXshkof
 jaMs5yz1beOCOM1ELbalb4xKU2xR9R3YO5mpSew5AVAJ8xZrAYJMwxIzR/e1FjmYoGJnmV
 5RORPB8FTsqPzdv170pnKwu4oNnCBco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738012404;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SVgTa1yOzE0Y1vvLklyWntdwmoSRGc1Oef4CSK9qBBc=;
 b=JoxStMsh4FhZILZ9T9o/5i7oD4QwPrmYNfwL9zJVti3nJR75Nsw/yzpdJPj0l3Zp9G49Ay
 dBUxmee/KXmTubDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05F1313715;
 Mon, 27 Jan 2025 21:13:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kFO+K/P2l2c4EQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Jan 2025 21:13:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com, Prasad Pandit
 <pjp@fedoraproject.org>
Subject: Re: [PATCH v4 4/4] tests/qtest/migration: add postcopy tests with
 multifd
In-Reply-To: <20250127120823.144949-5-ppandit@redhat.com>
References: <20250127120823.144949-1-ppandit@redhat.com>
 <20250127120823.144949-5-ppandit@redhat.com>
Date: Mon, 27 Jan 2025 18:13:20 -0300
Message-ID: <874j1kufin.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.987]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_FIVE(0.00)[5]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
> Add new postcopy tests to run postcopy migration with
> multifd channels enabled. Add a boolean fields 'multifd'
> and 'postcopy_ram' to the MigrateCommon structure.
> It helps to enable multifd channels and postcopy-ram
> during migration tests.
>
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>  tests/qtest/migration/compression-tests.c | 13 ++++++++
>  tests/qtest/migration/framework.c         | 13 ++++++++
>  tests/qtest/migration/framework.h         |  4 +++
>  tests/qtest/migration/postcopy-tests.c    | 23 +++++++++++++
>  tests/qtest/migration/precopy-tests.c     | 19 +++++++++++
>  tests/qtest/migration/tls-tests.c         | 40 +++++++++++++++++++++++
>  6 files changed, 112 insertions(+)
>
> v3: Add more qtests to cover precopy with 'postcopy-ram' attribute
>     and postcopy with multifd channels enabled.
> - https://lore.kernel.org/qemu-devel/20250121131032.1611245-1-ppandit@redhat.com/T/#t
>
> diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
> index d78f1f11f1..3252ba2f73 100644
> --- a/tests/qtest/migration/compression-tests.c
> +++ b/tests/qtest/migration/compression-tests.c
> @@ -39,6 +39,17 @@ static void test_multifd_tcp_zstd(void)
>      };
>      test_precopy_common(&args);
>  }
> +
> +static void test_multifd_postcopy_tcp_zstd(void)
> +{
> +    MigrateCommon args = {
> +        .postcopy_ram = true,
> +        .listen_uri = "defer",
> +        .start_hook = migrate_hook_start_precopy_tcp_multifd_zstd,
> +    };
> +
> +    test_precopy_common(&args);
> +}
>  #endif /* CONFIG_ZSTD */
>  
>  #ifdef CONFIG_QATZIP
> @@ -158,6 +169,8 @@ void migration_test_add_compression(MigrationTestEnv *env)
>  #ifdef CONFIG_ZSTD
>      migration_test_add("/migration/multifd/tcp/plain/zstd",
>                         test_multifd_tcp_zstd);
> +    migration_test_add("/migration/multifd+postcopy/tcp/plain/zstd",
> +                       test_multifd_postcopy_tcp_zstd);
>  #endif
>  
>  #ifdef CONFIG_QATZIP
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> index 4550cda129..00776f858c 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -427,6 +427,14 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
>          migrate_set_capability(to, "postcopy-preempt", true);
>      }
>  
> +    if (args->multifd) {
> +        migrate_set_capability(from, "multifd", true);
> +        migrate_set_capability(to, "multifd", true);

This is slightly backwards because currently that's what the hooks are
for. I don't see the need for separate flags for multifd and
postcopy. This also makes the code less maintainable because it creates
two different ways of doing the same thing (hooks vs. args).

I suggest to keep with the hooks. Alternatively, we could add a more
generic args->caps and have every test set the capabilities it wants and
the _common code to iterate over those and set them to true. Something
like this perhaps:

    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
        return;
    }

    for (int i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
        if (args->caps[i]) {
            migrate_set_capability(from, MigrationCapability_str(args->caps[i]), true);
            migrate_set_capability(to, MigrationCapability_str(args->caps[i]), true);
        }
    }

    if (args->start_hook) {
        data_hook = args->start_hook(from, to);
    }

We could also set the number of channels as a default value. The tests
could overwrite it from the hook if needed.

> +
> +        migrate_set_parameter_int(from, "multifd-channels", 8);
> +        migrate_set_parameter_int(to, "multifd-channels", 8);
> +    }
> +
>      migrate_ensure_non_converge(from);
>  
>      migrate_prepare_for_dirty_mem(from);
> @@ -691,6 +699,11 @@ void test_precopy_common(MigrateCommon *args)
>          return;
>      }
>  
> +    if (args->postcopy_ram) {
> +        migrate_set_capability(from, "postcopy-ram", true);
> +        migrate_set_capability(to, "postcopy-ram", true);
> +    }
> +
>      if (args->start_hook) {
>          data_hook = args->start_hook(from, to);
>      }
> diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
> index 7991ee56b6..214288ca42 100644
> --- a/tests/qtest/migration/framework.h
> +++ b/tests/qtest/migration/framework.h
> @@ -193,7 +193,11 @@ typedef struct {
>       */
>      bool live;
>  
> +    /* set multifd on */
> +    bool multifd;
> +
>      /* Postcopy specific fields */
> +    bool postcopy_ram;
>      void *postcopy_data;
>      bool postcopy_preempt;
>      PostcopyRecoveryFailStage postcopy_recovery_fail_stage;
> diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
> index daf7449f2c..212a5ea600 100644
> --- a/tests/qtest/migration/postcopy-tests.c
> +++ b/tests/qtest/migration/postcopy-tests.c
> @@ -79,6 +79,25 @@ static void test_postcopy_preempt_recovery(void)
>      test_postcopy_recovery_common(&args);
>  }
>  
> +static void test_multifd_postcopy(void)
> +{
> +    MigrateCommon args = {
> +        .multifd = true,
> +    };
> +
> +    test_postcopy_common(&args);
> +}
> +
> +static void test_multifd_postcopy_preempt(void)
> +{
> +    MigrateCommon args = {
> +        .multifd = true,
> +        .postcopy_preempt = true,
> +    };
> +
> +    test_postcopy_common(&args);
> +}
> +
>  void migration_test_add_postcopy(MigrationTestEnv *env)
>  {
>      if (env->has_uffd) {
> @@ -98,6 +117,10 @@ void migration_test_add_postcopy(MigrationTestEnv *env)
>              "/migration/postcopy/recovery/double-failures/reconnect",
>              test_postcopy_recovery_fail_reconnect);
>  
> +        migration_test_add("/migration/multifd+postcopy/plain",
> +                           test_multifd_postcopy);
> +        migration_test_add("/migration/multifd+postcopy/preempt/plain",
> +                           test_multifd_postcopy_preempt);
>          if (env->is_x86) {
>              migration_test_add("/migration/postcopy/suspend",
>                                 test_postcopy_suspend);
> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> index 23599b29ee..b1a4e7bbb1 100644
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
> @@ -472,6 +473,11 @@ static void test_multifd_tcp_cancel(void)
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
> @@ -513,6 +519,10 @@ static void test_multifd_tcp_cancel(void)
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
> @@ -536,6 +546,13 @@ static void test_multifd_tcp_cancel(void)
>      migrate_end(from, to2, true);
>  }
>  
> +static void test_multifd_postcopy_tcp_cancel(void)
> +{
> +    postcopy_ram = true;
> +    test_multifd_tcp_cancel();
> +    postcopy_ram = false;
> +}
> +
>  static void calc_dirty_rate(QTestState *who, uint64_t calc_time)
>  {
>      qtest_qmp_assert_success(who,
> @@ -999,6 +1016,8 @@ void migration_test_add_precopy(MigrationTestEnv *env)
>                         test_multifd_tcp_no_zero_page);
>      migration_test_add("/migration/multifd/tcp/plain/cancel",
>                         test_multifd_tcp_cancel);
> +    migration_test_add("migration/multifd+postcopy/tcp/plain/cancel",
> +                       test_multifd_postcopy_tcp_cancel);
>      if (g_str_equal(env->arch, "x86_64")
>          && env->has_kvm && env->has_dirty_ring) {
>  
> diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
> index 5704a1f992..094dc1d814 100644
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
> +        .multifd = true,
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
> +        .multifd = true,
> +    };
> +
> +    test_postcopy_recovery_common(&args);
> +}
> +
>  static void test_precopy_unix_tls_psk(void)
>  {
>      g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
> @@ -649,6 +671,18 @@ static void test_multifd_tcp_tls_psk_mismatch(void)
>      test_precopy_common(&args);
>  }
>  
> +static void test_multifd_postcopy_tcp_tls_psk_match(void)
> +{
> +    MigrateCommon args = {
> +        .multifd = true,
> +        .listen_uri = "defer",
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
> @@ -743,6 +777,10 @@ void migration_test_add_tls(MigrationTestEnv *env)
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
> @@ -776,6 +814,8 @@ void migration_test_add_tls(MigrationTestEnv *env)
>                         test_multifd_tcp_tls_psk_match);
>      migration_test_add("/migration/multifd/tcp/tls/psk/mismatch",
>                         test_multifd_tcp_tls_psk_mismatch);
> +    migration_test_add("/migration/multifd+postcopy/tcp/tls/psk/match",
> +                       test_multifd_postcopy_tcp_tls_psk_match);
>  #ifdef CONFIG_TASN1
>      migration_test_add("/migration/multifd/tcp/tls/x509/default-host",
>                         test_multifd_tcp_tls_x509_default_host);

