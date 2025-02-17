Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8496AC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 15:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk2sG-0006xM-GX; Mon, 17 Feb 2025 10:17:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tk2sD-0006x4-M7
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 10:17:29 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tk2s9-0000lN-Ne
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 10:17:29 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5C0181F453;
 Mon, 17 Feb 2025 15:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739805440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qnSfQmIPr9kXuL1Tq9R9wCDw/alKcwOan5ENV8pKy+Q=;
 b=caKvgA7pF61XyDpf6Vw/wubrbFz3euEmS8x+iYBArjeUGJ7xm3RYyMtCEDS8xNCGwuyKif
 ZhcY9+bCaHXj3QujWmnsHVonW8enDKfS6AmBWGG7j17o/AVLRQfwo55DGzH+306m/tGZVv
 yHYuZXFcb3iXaQUPtFhToOxtMWLr8u8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739805440;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qnSfQmIPr9kXuL1Tq9R9wCDw/alKcwOan5ENV8pKy+Q=;
 b=7APaMfMBrUxi3ao0uLj26RhsSEnexgMML1msKHPsQf45t1qKrz6cRgnFHOL8NtVxvpbn7V
 GpSuV0Cj1kCtgGCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=caKvgA7p;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7APaMfMB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739805440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qnSfQmIPr9kXuL1Tq9R9wCDw/alKcwOan5ENV8pKy+Q=;
 b=caKvgA7pF61XyDpf6Vw/wubrbFz3euEmS8x+iYBArjeUGJ7xm3RYyMtCEDS8xNCGwuyKif
 ZhcY9+bCaHXj3QujWmnsHVonW8enDKfS6AmBWGG7j17o/AVLRQfwo55DGzH+306m/tGZVv
 yHYuZXFcb3iXaQUPtFhToOxtMWLr8u8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739805440;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qnSfQmIPr9kXuL1Tq9R9wCDw/alKcwOan5ENV8pKy+Q=;
 b=7APaMfMBrUxi3ao0uLj26RhsSEnexgMML1msKHPsQf45t1qKrz6cRgnFHOL8NtVxvpbn7V
 GpSuV0Cj1kCtgGCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 877791379D;
 Mon, 17 Feb 2025 15:17:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id G1hoEf9Ss2c2NQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 17 Feb 2025 15:17:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com, Prasad Pandit
 <pjp@fedoraproject.org>
Subject: Re: [PATCH v6 3/4] tests/qtest/migration: consolidate set capabilities
In-Reply-To: <20250215123119.814345-4-ppandit@redhat.com>
References: <20250215123119.814345-1-ppandit@redhat.com>
 <20250215123119.814345-4-ppandit@redhat.com>
Date: Mon, 17 Feb 2025 12:17:16 -0300
Message-ID: <874j0svbwj.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 5C0181F453
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
> Migration capabilities are set in multiple '.start_hook'
> functions for various tests. Instead, consolidate setting
> capabilities in 'set_migration_capabilities()' function
> which is called from various 'test_*_common()' functions.
> While simplifying the capabilities setting, it helps
> to declutter the qtest sources.
>
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>  tests/qtest/migration/compression-tests.c | 10 ++--
>  tests/qtest/migration/cpr-tests.c         |  4 +-
>  tests/qtest/migration/file-tests.c        | 44 +++++-------------
>  tests/qtest/migration/framework.c         | 56 +++++++++++++++++------
>  tests/qtest/migration/framework.h         |  4 +-
>  tests/qtest/migration/postcopy-tests.c    |  4 +-
>  tests/qtest/migration/precopy-tests.c     | 19 +++-----
>  tests/qtest/migration/tls-tests.c         | 11 ++++-
>  8 files changed, 80 insertions(+), 72 deletions(-)
>
> v6:
> - Reorder, make this the first qtest patch in this series.
>
> v5:
> - https://lore.kernel.org/qemu-devel/20250205122712.229151-1-ppandit@redhat.com/T/#t
>
> diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
> index 8b58401b84..4558a7b9ff 100644
> --- a/tests/qtest/migration/compression-tests.c
> +++ b/tests/qtest/migration/compression-tests.c
> @@ -35,6 +35,7 @@ static void test_multifd_tcp_zstd(void)
>  {
>      MigrateCommon args = {
>          .listen_uri = "defer",
> +        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
>          .start_hook = migrate_hook_start_precopy_tcp_multifd_zstd,
>      };
>      test_precopy_common(&args);
> @@ -56,6 +57,7 @@ static void test_multifd_tcp_qatzip(void)
>  {
>      MigrateCommon args = {
>          .listen_uri = "defer",
> +        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
>          .start_hook = migrate_hook_start_precopy_tcp_multifd_qatzip,
>      };
>      test_precopy_common(&args);
> @@ -74,6 +76,7 @@ static void test_multifd_tcp_qpl(void)
>  {
>      MigrateCommon args = {
>          .listen_uri = "defer",
> +        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
>          .start_hook = migrate_hook_start_precopy_tcp_multifd_qpl,
>      };
>      test_precopy_common(&args);
> @@ -92,6 +95,7 @@ static void test_multifd_tcp_uadk(void)
>  {
>      MigrateCommon args = {
>          .listen_uri = "defer",
> +        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
>          .start_hook = migrate_hook_start_precopy_tcp_multifd_uadk,
>      };
>      test_precopy_common(&args);
> @@ -103,10 +107,6 @@ migrate_hook_start_xbzrle(QTestState *from,
>                            QTestState *to)
>  {
>      migrate_set_parameter_int(from, "xbzrle-cache-size", 33554432);
> -
> -    migrate_set_capability(from, "xbzrle", true);
> -    migrate_set_capability(to, "xbzrle", true);
> -
>      return NULL;
>  }
>  
> @@ -118,6 +118,7 @@ static void test_precopy_unix_xbzrle(void)
>          .listen_uri = uri,
>          .start_hook = migrate_hook_start_xbzrle,
>          .iterations = 2,
> +        .caps[MIGRATION_CAPABILITY_XBZRLE] = true,
>          /*
>           * XBZRLE needs pages to be modified when doing the 2nd+ round
>           * iteration to have real data pushed to the stream.
> @@ -146,6 +147,7 @@ static void test_multifd_tcp_zlib(void)
>  {
>      MigrateCommon args = {
>          .listen_uri = "defer",
> +        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
>          .start_hook = migrate_hook_start_precopy_tcp_multifd_zlib,
>      };
>      test_precopy_common(&args);
> diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
> index 4758841824..a175646b57 100644
> --- a/tests/qtest/migration/cpr-tests.c
> +++ b/tests/qtest/migration/cpr-tests.c
> @@ -24,9 +24,6 @@ static void *migrate_hook_start_mode_reboot(QTestState *from, QTestState *to)
>      migrate_set_parameter_str(from, "mode", "cpr-reboot");
>      migrate_set_parameter_str(to, "mode", "cpr-reboot");
>  
> -    migrate_set_capability(from, "x-ignore-shared", true);
> -    migrate_set_capability(to, "x-ignore-shared", true);
> -
>      return NULL;
>  }
>  
> @@ -39,6 +36,7 @@ static void test_mode_reboot(void)
>          .connect_uri = uri,
>          .listen_uri = "defer",
>          .start_hook = migrate_hook_start_mode_reboot,
> +        .caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true,
>      };
>  
>      test_file_common(&args, true);
> diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/file-tests.c
> index f260e2871d..6253ece687 100644
> --- a/tests/qtest/migration/file-tests.c
> +++ b/tests/qtest/migration/file-tests.c
> @@ -107,15 +107,6 @@ static void test_precopy_file_offset_bad(void)
>      test_file_common(&args, false);
>  }
>  
> -static void *migrate_hook_start_mapped_ram(QTestState *from,
> -                                           QTestState *to)
> -{
> -    migrate_set_capability(from, "mapped-ram", true);
> -    migrate_set_capability(to, "mapped-ram", true);
> -
> -    return NULL;
> -}
> -
>  static void test_precopy_file_mapped_ram_live(void)
>  {
>      g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
> @@ -123,7 +114,7 @@ static void test_precopy_file_mapped_ram_live(void)
>      MigrateCommon args = {
>          .connect_uri = uri,
>          .listen_uri = "defer",
> -        .start_hook = migrate_hook_start_mapped_ram,
> +        .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
>      };
>  
>      test_file_common(&args, false);
> @@ -136,26 +127,12 @@ static void test_precopy_file_mapped_ram(void)
>      MigrateCommon args = {
>          .connect_uri = uri,
>          .listen_uri = "defer",
> -        .start_hook = migrate_hook_start_mapped_ram,
> +        .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
>      };
>  
>      test_file_common(&args, true);
>  }
>  
> -static void *migrate_hook_start_multifd_mapped_ram(QTestState *from,
> -                                                   QTestState *to)
> -{
> -    migrate_hook_start_mapped_ram(from, to);
> -
> -    migrate_set_parameter_int(from, "multifd-channels", 4);
> -    migrate_set_parameter_int(to, "multifd-channels", 4);
> -
> -    migrate_set_capability(from, "multifd", true);
> -    migrate_set_capability(to, "multifd", true);
> -
> -    return NULL;
> -}
> -
>  static void test_multifd_file_mapped_ram_live(void)
>  {
>      g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
> @@ -163,7 +140,8 @@ static void test_multifd_file_mapped_ram_live(void)
>      MigrateCommon args = {
>          .connect_uri = uri,
>          .listen_uri = "defer",
> -        .start_hook = migrate_hook_start_multifd_mapped_ram,
> +        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> +        .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
>      };
>  
>      test_file_common(&args, false);
> @@ -176,7 +154,8 @@ static void test_multifd_file_mapped_ram(void)
>      MigrateCommon args = {
>          .connect_uri = uri,
>          .listen_uri = "defer",
> -        .start_hook = migrate_hook_start_multifd_mapped_ram,
> +        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> +        .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
>      };
>  
>      test_file_common(&args, true);
> @@ -185,8 +164,6 @@ static void test_multifd_file_mapped_ram(void)
>  static void *migrate_hook_start_multifd_mapped_ram_dio(QTestState *from,
>                                                         QTestState *to)
>  {
> -    migrate_hook_start_multifd_mapped_ram(from, to);
> -
>      migrate_set_parameter_bool(from, "direct-io", true);
>      migrate_set_parameter_bool(to, "direct-io", true);
>  
> @@ -201,6 +178,8 @@ static void test_multifd_file_mapped_ram_dio(void)
>          .connect_uri = uri,
>          .listen_uri = "defer",
>          .start_hook = migrate_hook_start_multifd_mapped_ram_dio,
> +        .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
> +        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
>      };
>  
>      if (!probe_o_direct_support(tmpfs)) {
> @@ -246,7 +225,6 @@ static void *migrate_hook_start_multifd_mapped_ram_fdset_dio(QTestState *from,
>      fdset_add_fds(from, file, O_WRONLY, 2, true);
>      fdset_add_fds(to, file, O_RDONLY, 2, true);
>  
> -    migrate_hook_start_multifd_mapped_ram(from, to);
>      migrate_set_parameter_bool(from, "direct-io", true);
>      migrate_set_parameter_bool(to, "direct-io", true);
>  
> @@ -261,8 +239,6 @@ static void *migrate_hook_start_multifd_mapped_ram_fdset(QTestState *from,
>      fdset_add_fds(from, file, O_WRONLY, 2, false);
>      fdset_add_fds(to, file, O_RDONLY, 2, false);
>  
> -    migrate_hook_start_multifd_mapped_ram(from, to);
> -
>      return NULL;
>  }
>  
> @@ -275,6 +251,8 @@ static void test_multifd_file_mapped_ram_fdset(void)
>          .listen_uri = "defer",
>          .start_hook = migrate_hook_start_multifd_mapped_ram_fdset,
>          .end_hook = migrate_hook_end_multifd_mapped_ram_fdset,
> +        .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
> +        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
>      };
>  
>      test_file_common(&args, true);
> @@ -289,6 +267,8 @@ static void test_multifd_file_mapped_ram_fdset_dio(void)
>          .listen_uri = "defer",
>          .start_hook = migrate_hook_start_multifd_mapped_ram_fdset_dio,
>          .end_hook = migrate_hook_end_multifd_mapped_ram_fdset,
> +        .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
> +        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
>      };
>  
>      if (!probe_o_direct_support(tmpfs)) {
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> index 10e1d04b58..82aaa13e85 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -207,6 +207,31 @@ static QList *migrate_start_get_qmp_capabilities(const MigrateStart *args)
>      return capabilities;
>  }
>  
> +static void set_migration_capabilities(QTestState *from,
> +                                        QTestState *to, MigrateCommon *args)
> +{
> +    /*
> +     * MigrationCapability_lookup and MIGRATION_CAPABILITY_ constants
> +     * are from qapi-types-migration.h.
> +     */
> +    for (uint8_t i = 0; i < MIGRATION_CAPABILITY__MAX; i++)
> +    {
> +        if (!args->caps[i]) {
> +            continue;
> +        }
> +        if (from) {
> +            migrate_set_capability(from,
> +                            MigrationCapability_lookup.array[i], true);
> +        }
> +        if (to) {
> +            migrate_set_capability(to,
> +                            MigrationCapability_lookup.array[i], true);
> +        }
> +    }
> +
> +    return;
> +}
> +
>  int migrate_start(QTestState **from, QTestState **to, const char *uri,
>                    MigrateStart *args)
>  {
> @@ -440,17 +465,12 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
>          args->postcopy_data = args->start_hook(from, to);
>      }
>  
> -    migrate_set_capability(from, "postcopy-ram", true);
> -    migrate_set_capability(to, "postcopy-ram", true);
> -    migrate_set_capability(to, "postcopy-blocktime", true);
> -
> -    if (args->postcopy_preempt) {
> -        migrate_set_capability(from, "postcopy-preempt", true);
> -        migrate_set_capability(to, "postcopy-preempt", true);
> -    }
> +    /* set postcopy capabilities */
> +    args->caps[MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME] = true;
> +    args->caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true;
> +    set_migration_capabilities(from, to, args);
>  
>      migrate_ensure_non_converge(from);
> -
>      migrate_prepare_for_dirty_mem(from);
>      qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
>                               "  'arguments': { "
> @@ -717,6 +737,12 @@ void test_precopy_common(MigrateCommon *args)
>          return;
>      }
>  
> +    set_migration_capabilities(from, to, args);
> +    if (args->caps[MIGRATION_CAPABILITY_MULTIFD]) {
> +        migrate_set_parameter_int(from, "multifd-channels", 16);
> +        migrate_set_parameter_int(to, "multifd-channels", 16);
> +    }
> +
>      if (args->start_hook) {
>          data_hook = args->start_hook(from, to);
>      }
> @@ -888,6 +914,12 @@ void test_file_common(MigrateCommon *args, bool stop_src)
>       */
>      g_assert_false(args->live);
>  
> +    set_migration_capabilities(from, to, args);
> +    if (args->caps[MIGRATION_CAPABILITY_MULTIFD]) {
> +        migrate_set_parameter_int(from, "multifd-channels", 4);
> +        migrate_set_parameter_int(to, "multifd-channels", 4);
> +    }
> +
>      if (g_strrstr(args->connect_uri, "offset=")) {
>          check_offset = true;
>          /*
> @@ -948,15 +980,9 @@ void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
>                                                      QTestState *to,
>                                                      const char *method)
>  {
> -    migrate_set_parameter_int(from, "multifd-channels", 16);
> -    migrate_set_parameter_int(to, "multifd-channels", 16);
> -
>      migrate_set_parameter_str(from, "multifd-compression", method);
>      migrate_set_parameter_str(to, "multifd-compression", method);
>  
> -    migrate_set_capability(from, "multifd", true);
> -    migrate_set_capability(to, "multifd", true);
> -
>      /* Start incoming migration from the 1st socket */
>      migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
>  
> diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
> index e4a11870f6..74d53eee69 100644
> --- a/tests/qtest/migration/framework.h
> +++ b/tests/qtest/migration/framework.h
> @@ -12,6 +12,7 @@
>  #define TEST_FRAMEWORK_H
>  
>  #include "libqtest.h"
> +#include <qapi/qapi-types-migration.h>
>  
>  #define FILE_TEST_FILENAME "migfile"
>  #define FILE_TEST_OFFSET 0x1000
> @@ -207,8 +208,9 @@ typedef struct {
>  
>      /* Postcopy specific fields */
>      void *postcopy_data;
> -    bool postcopy_preempt;
>      PostcopyRecoveryFailStage postcopy_recovery_fail_stage;
> +
> +    bool caps[MIGRATION_CAPABILITY__MAX];

I just noticed this is way more suited to be at MigrateStart instead,
because then we can make the set_capabilities as part of migrate_start()
and move the events setting in there as well.

I also think we could just pick a default for multifd channels and avoid
setting it in most places. 4 is probably a good number.

-- >8 --
From 811eca2a333c98df7dd6ffe9af0c9ce81aef8731 Mon Sep 17 00:00:00 2001
From: Fabiano Rosas <farosas@suse.de>
Date: Mon, 17 Feb 2025 11:55:56 -0300
Subject: [PATCH] fixup! tests/qtest/migration: consolidate set capabilities

---
 tests/qtest/migration/compression-tests.c | 24 +++++++---
 tests/qtest/migration/cpr-tests.c         |  4 +-
 tests/qtest/migration/file-tests.c        | 38 ++++++++++-----
 tests/qtest/migration/framework.c         | 56 ++++++++++++-----------
 tests/qtest/migration/framework.h         |  9 +++-
 tests/qtest/migration/misc-tests.c        |  4 +-
 tests/qtest/migration/postcopy-tests.c    |  8 +++-
 tests/qtest/migration/precopy-tests.c     | 22 ++++++---
 tests/qtest/migration/tls-tests.c         | 30 ++++++++----
 9 files changed, 127 insertions(+), 68 deletions(-)

diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
index 4558a7b9ff..41e79f031b 100644
--- a/tests/qtest/migration/compression-tests.c
+++ b/tests/qtest/migration/compression-tests.c
@@ -35,7 +35,9 @@ static void test_multifd_tcp_zstd(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
         .start_hook = migrate_hook_start_precopy_tcp_multifd_zstd,
     };
     test_precopy_common(&args);
@@ -57,7 +59,9 @@ static void test_multifd_tcp_qatzip(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
         .start_hook = migrate_hook_start_precopy_tcp_multifd_qatzip,
     };
     test_precopy_common(&args);
@@ -76,7 +80,9 @@ static void test_multifd_tcp_qpl(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
         .start_hook = migrate_hook_start_precopy_tcp_multifd_qpl,
     };
     test_precopy_common(&args);
@@ -95,7 +101,9 @@ static void test_multifd_tcp_uadk(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
         .start_hook = migrate_hook_start_precopy_tcp_multifd_uadk,
     };
     test_precopy_common(&args);
@@ -118,7 +126,9 @@ static void test_precopy_unix_xbzrle(void)
         .listen_uri = uri,
         .start_hook = migrate_hook_start_xbzrle,
         .iterations = 2,
-        .caps[MIGRATION_CAPABILITY_XBZRLE] = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_XBZRLE] = true,
+        },
         /*
          * XBZRLE needs pages to be modified when doing the 2nd+ round
          * iteration to have real data pushed to the stream.
@@ -147,7 +157,9 @@ static void test_multifd_tcp_zlib(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
         .start_hook = migrate_hook_start_precopy_tcp_multifd_zlib,
     };
     test_precopy_common(&args);
diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index a175646b57..5536e14610 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -36,7 +36,9 @@ static void test_mode_reboot(void)
         .connect_uri = uri,
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_mode_reboot,
-        .caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true,
+        },
     };
 
     test_file_common(&args, true);
diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/file-tests.c
index 6253ece687..4d78ce0855 100644
--- a/tests/qtest/migration/file-tests.c
+++ b/tests/qtest/migration/file-tests.c
@@ -114,7 +114,9 @@ static void test_precopy_file_mapped_ram_live(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
+        },
     };
 
     test_file_common(&args, false);
@@ -127,7 +129,9 @@ static void test_precopy_file_mapped_ram(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
+        },
     };
 
     test_file_common(&args, true);
@@ -140,8 +144,10 @@ static void test_multifd_file_mapped_ram_live(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-        .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
+        },
     };
 
     test_file_common(&args, false);
@@ -154,8 +160,10 @@ static void test_multifd_file_mapped_ram(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-        .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
+        },
     };
 
     test_file_common(&args, true);
@@ -178,8 +186,10 @@ static void test_multifd_file_mapped_ram_dio(void)
         .connect_uri = uri,
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_mapped_ram_dio,
-        .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
-        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
     };
 
     if (!probe_o_direct_support(tmpfs)) {
@@ -251,8 +261,10 @@ static void test_multifd_file_mapped_ram_fdset(void)
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_mapped_ram_fdset,
         .end_hook = migrate_hook_end_multifd_mapped_ram_fdset,
-        .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
-        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
     };
 
     test_file_common(&args, true);
@@ -267,8 +279,10 @@ static void test_multifd_file_mapped_ram_fdset_dio(void)
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_mapped_ram_fdset_dio,
         .end_hook = migrate_hook_end_multifd_mapped_ram_fdset,
-        .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
-        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
     };
 
     if (!probe_o_direct_support(tmpfs)) {
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 82aaa13e85..be6c245843 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -30,6 +30,7 @@
 #define QEMU_VM_FILE_MAGIC 0x5145564d
 #define QEMU_ENV_SRC "QTEST_QEMU_BINARY_SRC"
 #define QEMU_ENV_DST "QTEST_QEMU_BINARY_DST"
+#define MULTIFD_TEST_CHANNELS 4
 
 unsigned start_address;
 unsigned end_address;
@@ -207,8 +208,8 @@ static QList *migrate_start_get_qmp_capabilities(const MigrateStart *args)
     return capabilities;
 }
 
-static void set_migration_capabilities(QTestState *from,
-                                        QTestState *to, MigrateCommon *args)
+static void migrate_start_set_capabilities(QTestState *from, QTestState *to,
+                                           MigrateStart *args)
 {
     /*
      * MigrationCapability_lookup and MIGRATION_CAPABILITY_ constants
@@ -229,6 +230,27 @@ static void set_migration_capabilities(QTestState *from,
         }
     }
 
+    /*
+     * Always enable migration events.  Libvirt always uses it, let's try
+     * to mimic as closer as that.
+     */
+    migrate_set_capability(from, "events", true);
+    if (!args->defer_target_connect) {
+        migrate_set_capability(to, "events", true);
+    }
+
+    /*
+     * Default number of channels should be fine for most
+     * tests. Individual tests can override by calling
+     * migrate_set_parameter() directly.
+     */
+    if (args->caps[MIGRATION_CAPABILITY_MULTIFD]) {
+        migrate_set_parameter_int(from, "multifd-channels",
+                                  MULTIFD_TEST_CHANNELS);
+        migrate_set_parameter_int(to, "multifd-channels",
+                                  MULTIFD_TEST_CHANNELS);
+    }
+
     return;
 }
 
@@ -404,14 +426,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
         unlink(shmem_path);
     }
 
-    /*
-     * Always enable migration events.  Libvirt always uses it, let's try
-     * to mimic as closer as that.
-     */
-    migrate_set_capability(*from, "events", true);
-    if (!args->defer_target_connect) {
-        migrate_set_capability(*to, "events", true);
-    }
+    migrate_start_set_capabilities(*from, *to, args);
 
     return 0;
 }
@@ -457,6 +472,10 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
 {
     QTestState *from, *to;
 
+    /* set postcopy capabilities */
+    args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME] = true;
+    args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true;
+
     if (migrate_start(&from, &to, "defer", &args->start)) {
         return -1;
     }
@@ -465,11 +484,6 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
         args->postcopy_data = args->start_hook(from, to);
     }
 
-    /* set postcopy capabilities */
-    args->caps[MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME] = true;
-    args->caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true;
-    set_migration_capabilities(from, to, args);
-
     migrate_ensure_non_converge(from);
     migrate_prepare_for_dirty_mem(from);
     qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
@@ -737,12 +751,6 @@ void test_precopy_common(MigrateCommon *args)
         return;
     }
 
-    set_migration_capabilities(from, to, args);
-    if (args->caps[MIGRATION_CAPABILITY_MULTIFD]) {
-        migrate_set_parameter_int(from, "multifd-channels", 16);
-        migrate_set_parameter_int(to, "multifd-channels", 16);
-    }
-
     if (args->start_hook) {
         data_hook = args->start_hook(from, to);
     }
@@ -914,12 +922,6 @@ void test_file_common(MigrateCommon *args, bool stop_src)
      */
     g_assert_false(args->live);
 
-    set_migration_capabilities(from, to, args);
-    if (args->caps[MIGRATION_CAPABILITY_MULTIFD]) {
-        migrate_set_parameter_int(from, "multifd-channels", 4);
-        migrate_set_parameter_int(to, "multifd-channels", 4);
-    }
-
     if (g_strrstr(args->connect_uri, "offset=")) {
         check_offset = true;
         /*
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 74d53eee69..01e425e64e 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -121,6 +121,13 @@ typedef struct {
 
     /* Do not connect to target monitor and qtest sockets in qtest_init */
     bool defer_target_connect;
+
+    /*
+     * Migration capabilities to be set in both source and
+     * destination. For unilateral capabilities, use
+     * migration_set_capabilities().
+     */
+    bool caps[MIGRATION_CAPABILITY__MAX];
 } MigrateStart;
 
 typedef enum PostcopyRecoveryFailStage {
@@ -209,8 +216,6 @@ typedef struct {
     /* Postcopy specific fields */
     void *postcopy_data;
     PostcopyRecoveryFailStage postcopy_recovery_fail_stage;
-
-    bool caps[MIGRATION_CAPABILITY__MAX];
 } MigrateCommon;
 
 void wait_for_serial(const char *side);
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 2e612d9e38..54995256d8 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -98,6 +98,7 @@ static void test_ignore_shared(void)
     QTestState *from, *to;
     MigrateStart args = {
         .use_shmem = true,
+        .caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true,
     };
 
     if (migrate_start(&from, &to, uri, &args)) {
@@ -107,9 +108,6 @@ static void test_ignore_shared(void)
     migrate_ensure_non_converge(from);
     migrate_prepare_for_dirty_mem(from);
 
-    migrate_set_capability(from, "x-ignore-shared", true);
-    migrate_set_capability(to, "x-ignore-shared", true);
-
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
index b0e70a6367..483e3ff99f 100644
--- a/tests/qtest/migration/postcopy-tests.c
+++ b/tests/qtest/migration/postcopy-tests.c
@@ -39,7 +39,9 @@ static void test_postcopy_suspend(void)
 static void test_postcopy_preempt(void)
 {
     MigrateCommon args = {
-        .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
+        },
     };
 
     test_postcopy_common(&args);
@@ -73,7 +75,9 @@ static void test_postcopy_recovery_fail_reconnect(void)
 static void test_postcopy_preempt_recovery(void)
 {
     MigrateCommon args = {
-        .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
+        },
     };
 
     test_postcopy_recovery_common(&args);
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index a0399b78d6..f8404793b8 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -112,8 +112,10 @@ static void test_precopy_tcp_switchover_ack(void)
 {
     MigrateCommon args = {
         .listen_uri = "tcp:127.0.0.1:0",
-        .caps[MIGRATION_CAPABILITY_RETURN_PATH] = true,
-        .caps[MIGRATION_CAPABILITY_SWITCHOVER_ACK] = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_RETURN_PATH] = true,
+            .caps[MIGRATION_CAPABILITY_SWITCHOVER_ACK] = true,
+        },
         /*
          * Source VM must be running in order to consider the switchover ACK
          * when deciding to do switchover or not.
@@ -382,7 +384,9 @@ static void test_multifd_tcp_uri_none(void)
     MigrateCommon args = {
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_precopy_tcp_multifd,
-        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
         /*
          * Multifd is more complicated than most of the features, it
          * directly takes guest page buffers when sending, make sure
@@ -398,7 +402,9 @@ static void test_multifd_tcp_zero_page_legacy(void)
     MigrateCommon args = {
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_precopy_tcp_multifd_zero_page_legacy,
-        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
         /*
          * Multifd is more complicated than most of the features, it
          * directly takes guest page buffers when sending, make sure
@@ -414,7 +420,9 @@ static void test_multifd_tcp_no_zero_page(void)
     MigrateCommon args = {
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_precopy_tcp_multifd_no_zero_page,
-        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
         /*
          * Multifd is more complicated than most of the features, it
          * directly takes guest page buffers when sending, make sure
@@ -431,7 +439,9 @@ static void test_multifd_tcp_channels_none(void)
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_precopy_tcp_multifd,
         .live = true,
-        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
         .connect_channels = ("[ { 'channel-type': 'main',"
                              "    'addr': { 'transport': 'socket',"
                              "              'type': 'inet',"
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 30ab79e058..72f44defbb 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -377,7 +377,9 @@ static void test_postcopy_preempt_tls_psk(void)
     MigrateCommon args = {
         .start_hook = migrate_hook_start_tls_psk_match,
         .end_hook = migrate_hook_end_tls_psk,
-        .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
+        },
     };
 
     test_postcopy_common(&args);
@@ -399,7 +401,9 @@ static void test_postcopy_preempt_all(void)
     MigrateCommon args = {
         .start_hook = migrate_hook_start_tls_psk_match,
         .end_hook = migrate_hook_end_tls_psk,
-        .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
+        },
     };
 
     test_postcopy_recovery_common(&args);
@@ -631,7 +635,9 @@ static void test_multifd_tcp_tls_psk_match(void)
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_tcp_tls_psk_match,
         .end_hook = migrate_hook_end_tls_psk,
-        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
     };
     test_precopy_common(&args);
 }
@@ -641,12 +647,12 @@ static void test_multifd_tcp_tls_psk_mismatch(void)
     MigrateCommon args = {
         .start = {
             .hide_stderr = true,
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
         },
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_tcp_tls_psk_mismatch,
         .end_hook = migrate_hook_end_tls_psk,
         .result = MIG_TEST_FAIL,
-        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
     };
     test_precopy_common(&args);
 }
@@ -658,7 +664,9 @@ static void test_multifd_tcp_tls_x509_default_host(void)
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_tls_x509_default_host,
         .end_hook = migrate_hook_end_tls_x509,
-        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
     };
     test_precopy_common(&args);
 }
@@ -669,7 +677,9 @@ static void test_multifd_tcp_tls_x509_override_host(void)
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_tls_x509_override_host,
         .end_hook = migrate_hook_end_tls_x509,
-        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
     };
     test_precopy_common(&args);
 }
@@ -692,12 +702,12 @@ static void test_multifd_tcp_tls_x509_mismatch_host(void)
     MigrateCommon args = {
         .start = {
             .hide_stderr = true,
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
         },
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_tls_x509_mismatch_host,
         .end_hook = migrate_hook_end_tls_x509,
         .result = MIG_TEST_FAIL,
-        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
     };
     test_precopy_common(&args);
 }
@@ -708,7 +718,9 @@ static void test_multifd_tcp_tls_x509_allow_anon_client(void)
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_tls_x509_allow_anon_client,
         .end_hook = migrate_hook_end_tls_x509,
-        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
     };
     test_precopy_common(&args);
 }
@@ -718,12 +730,12 @@ static void test_multifd_tcp_tls_x509_reject_anon_client(void)
     MigrateCommon args = {
         .start = {
             .hide_stderr = true,
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
         },
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_tls_x509_reject_anon_client,
         .end_hook = migrate_hook_end_tls_x509,
         .result = MIG_TEST_FAIL,
-        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
     };
     test_precopy_common(&args);
 }
-- 
2.35.3


