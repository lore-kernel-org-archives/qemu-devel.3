Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD81C282C1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 15:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to21v-0002QM-TL; Fri, 28 Feb 2025 10:12:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1to21q-0002OW-VM
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 10:11:55 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1to21o-00005K-2n
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 10:11:54 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0193C1F38F;
 Fri, 28 Feb 2025 15:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1740755510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cjaTQFnRc6ONIGxq5A6/5iooa03KAU5cRgj4Y/wsaGY=;
 b=jv9zF5BcEtn7TQ/+Qb1WQs45jBLuDx2RoXDp0+ZnxUw1UHttTEEfxGAIcUUs1f3I2z2ROj
 D+lVonNdiiSjd8iAMbOhD2w3QaKp9BITZKHMXQdrQ6jMRVo0C4TZHGYHe74fzqfd8l4uhu
 qTNjaWoxlyPm+5zaD/BJVeCckIfKB80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1740755510;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cjaTQFnRc6ONIGxq5A6/5iooa03KAU5cRgj4Y/wsaGY=;
 b=6UPV+7UdygU2KrHr5iSs5OO58dN7dWsCPNmsQL7JUq8L28eDTcR2fGSWWGL3chR/K0ydal
 4xh7xFB+IUcRoZAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1740755510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cjaTQFnRc6ONIGxq5A6/5iooa03KAU5cRgj4Y/wsaGY=;
 b=jv9zF5BcEtn7TQ/+Qb1WQs45jBLuDx2RoXDp0+ZnxUw1UHttTEEfxGAIcUUs1f3I2z2ROj
 D+lVonNdiiSjd8iAMbOhD2w3QaKp9BITZKHMXQdrQ6jMRVo0C4TZHGYHe74fzqfd8l4uhu
 qTNjaWoxlyPm+5zaD/BJVeCckIfKB80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1740755510;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cjaTQFnRc6ONIGxq5A6/5iooa03KAU5cRgj4Y/wsaGY=;
 b=6UPV+7UdygU2KrHr5iSs5OO58dN7dWsCPNmsQL7JUq8L28eDTcR2fGSWWGL3chR/K0ydal
 4xh7xFB+IUcRoZAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BCC31344A;
 Fri, 28 Feb 2025 15:11:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2HnYCTXSwWc/RQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 28 Feb 2025 15:11:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com, Prasad Pandit
 <pjp@fedoraproject.org>
Subject: Re: [PATCH v7 4/5] tests/qtest/migration: add postcopy tests with
 multifd
In-Reply-To: <20250228121749.553184-5-ppandit@redhat.com>
References: <20250228121749.553184-1-ppandit@redhat.com>
 <20250228121749.553184-5-ppandit@redhat.com>
Date: Fri, 28 Feb 2025 12:11:46 -0300
Message-ID: <87cyf22jf1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
>  tests/qtest/migration/compression-tests.c | 15 ++++++++
>  tests/qtest/migration/postcopy-tests.c    | 27 +++++++++++++
>  tests/qtest/migration/precopy-tests.c     | 19 ++++++++++
>  tests/qtest/migration/tls-tests.c         | 46 +++++++++++++++++++++++
>  4 files changed, 107 insertions(+)
>
> v6: Move .caps initialisations to .start object.
> - https://lore.kernel.org/qemu-devel/20250215123119.814345-1-ppandit@redhat.com/T/#t
>
> diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
> index 41e79f031b..592e85d69d 100644
> --- a/tests/qtest/migration/compression-tests.c
> +++ b/tests/qtest/migration/compression-tests.c
> @@ -42,6 +42,19 @@ static void test_multifd_tcp_zstd(void)
>      };
>      test_precopy_common(&args);
>  }
> +
> +static void test_multifd_postcopy_tcp_zstd(void)
> +{
> +    MigrateCommon args = {
> +        .listen_uri = "defer",
> +        .start = {
> +            .caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true,
> +        },
> +        .start_hook = migrate_hook_start_precopy_tcp_multifd_zstd,
> +    };
> +
> +    test_precopy_common(&args);
> +}
>  #endif /* CONFIG_ZSTD */
>  
>  #ifdef CONFIG_QATZIP
> @@ -184,6 +197,8 @@ void migration_test_add_compression(MigrationTestEnv *env)
>  #ifdef CONFIG_ZSTD
>      migration_test_add("/migration/multifd/tcp/plain/zstd",
>                         test_multifd_tcp_zstd);
> +    migration_test_add("/migration/multifd+postcopy/tcp/plain/zstd",
> +                       test_multifd_postcopy_tcp_zstd);
>  #endif
>  
>  #ifdef CONFIG_QATZIP
> diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
> index 483e3ff99f..eb637f94f7 100644
> --- a/tests/qtest/migration/postcopy-tests.c
> +++ b/tests/qtest/migration/postcopy-tests.c
> @@ -94,6 +94,29 @@ static void migration_test_add_postcopy_smoke(MigrationTestEnv *env)
>      }
>  }
>  
> +static void test_multifd_postcopy(void)
> +{
> +    MigrateCommon args = {
> +        .start = {
> +            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> +        },
> +    };
> +
> +    test_postcopy_common(&args);
> +}
> +
> +static void test_multifd_postcopy_preempt(void)
> +{
> +    MigrateCommon args = {
> +        .start = {
> +            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> +            .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
> +        },
> +    };
> +
> +    test_postcopy_common(&args);
> +}
> +
>  void migration_test_add_postcopy(MigrationTestEnv *env)
>  {
>      migration_test_add_postcopy_smoke(env);
> @@ -114,6 +137,10 @@ void migration_test_add_postcopy(MigrationTestEnv *env)
>              "/migration/postcopy/recovery/double-failures/reconnect",
>              test_postcopy_recovery_fail_reconnect);
>  
> +        migration_test_add("/migration/postcopy/multifd/plain",
> +                           test_multifd_postcopy);
> +        migration_test_add("/migration/postcopy/multifd/preempt/plain",
> +                           test_multifd_postcopy_preempt);
>          if (env->is_x86) {
>              migration_test_add("/migration/postcopy/suspend",
>                                 test_postcopy_suspend);
> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> index f8404793b8..b2b0db8076 100644
> --- a/tests/qtest/migration/precopy-tests.c
> +++ b/tests/qtest/migration/precopy-tests.c
> @@ -34,6 +34,7 @@
>  #define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
>  
>  static char *tmpfs;
> +static bool postcopy_ram = false;
>  
>  static void test_precopy_unix_plain(void)
>  {
> @@ -476,6 +477,11 @@ static void test_multifd_tcp_cancel(void)
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
> @@ -517,6 +523,10 @@ static void test_multifd_tcp_cancel(void)
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
> @@ -540,6 +550,13 @@ static void test_multifd_tcp_cancel(void)
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
>  static void test_cancel_src_after_failed(QTestState *from, QTestState *to,
>                                           const char *uri, const char *phase)
>  {
> @@ -1127,6 +1144,8 @@ static void migration_test_add_precopy_smoke(MigrationTestEnv *env)
>                         test_multifd_tcp_uri_none);
>      migration_test_add("/migration/multifd/tcp/plain/cancel",
>                         test_multifd_tcp_cancel);
> +    migration_test_add("/migration/multifd+postcopy/tcp/plain/cancel",
> +                       test_multifd_postcopy_tcp_cancel);
>  }
>  
>  void migration_test_add_precopy(MigrationTestEnv *env)
> diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
> index 72f44defbb..81a2faf4c0 100644
> --- a/tests/qtest/migration/tls-tests.c
> +++ b/tests/qtest/migration/tls-tests.c
> @@ -395,6 +395,19 @@ static void test_postcopy_recovery_tls_psk(void)
>      test_postcopy_recovery_common(&args);
>  }
>  
> +static void test_multifd_postcopy_recovery_tls_psk(void)
> +{
> +    MigrateCommon args = {
> +        .start_hook = migrate_hook_start_tls_psk_match,
> +        .end_hook = migrate_hook_end_tls_psk,
> +        .start = {
> +            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> +        },
> +    };
> +
> +    test_postcopy_recovery_common(&args);
> +}
> +
>  /* This contains preempt+recovery+tls test altogether */
>  static void test_postcopy_preempt_all(void)
>  {
> @@ -409,6 +422,19 @@ static void test_postcopy_preempt_all(void)
>      test_postcopy_recovery_common(&args);
>  }
>  
> +static void test_multifd_postcopy_preempt_recovery_tls_psk(void)
> +{
> +    MigrateCommon args = {
> +        .start_hook = migrate_hook_start_tls_psk_match,
> +        .end_hook = migrate_hook_end_tls_psk,
> +        .start = {
> +            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> +        },
> +    };
> +
> +    test_postcopy_recovery_common(&args);
> +}
> +
>  static void test_precopy_unix_tls_psk(void)
>  {
>      g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
> @@ -657,6 +683,20 @@ static void test_multifd_tcp_tls_psk_mismatch(void)
>      test_precopy_common(&args);
>  }
>  
> +static void test_multifd_postcopy_tcp_tls_psk_match(void)
> +{
> +    MigrateCommon args = {
> +        .start = {
> +            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,

Missing POSTCOPY_RAM here, no?

> +        },
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
> @@ -774,6 +814,10 @@ void migration_test_add_tls(MigrationTestEnv *env)
>                             test_postcopy_preempt_tls_psk);
>          migration_test_add("/migration/postcopy/preempt/recovery/tls/psk",
>                             test_postcopy_preempt_all);
> +        migration_test_add("/migration/postcopy/multifd/recovery/tls/psk",
> +                           test_multifd_postcopy_recovery_tls_psk);
> +        migration_test_add("/migration/postcopy/multifd/preempt/recovery/tls/psk",
> +                           test_multifd_postcopy_preempt_recovery_tls_psk);
>      }
>  #ifdef CONFIG_TASN1
>      migration_test_add("/migration/precopy/unix/tls/x509/default-host",
> @@ -805,6 +849,8 @@ void migration_test_add_tls(MigrationTestEnv *env)
>                         test_multifd_tcp_tls_psk_match);
>      migration_test_add("/migration/multifd/tcp/tls/psk/mismatch",
>                         test_multifd_tcp_tls_psk_mismatch);
> +    migration_test_add("/migration/multifd+postcopy/tcp/tls/psk/match",
> +                       test_multifd_postcopy_tcp_tls_psk_match);
>  #ifdef CONFIG_TASN1
>      migration_test_add("/migration/multifd/tcp/tls/x509/default-host",
>                         test_multifd_tcp_tls_x509_default_host);

