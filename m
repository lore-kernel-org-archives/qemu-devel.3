Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1980CC0219D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 22:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgWPY-00047g-R2; Fri, 07 Feb 2025 17:01:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tgWPW-000476-BT
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 17:01:18 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tgWPS-0006Bt-B2
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 17:01:18 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ED05D21176;
 Fri,  7 Feb 2025 22:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738965671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eKwaBIh0Zc9m0ggHz+Vrklkoo2lub7cAcaeo84Fx+bI=;
 b=nNx3fZHxHfrglAfC+UXcTEKrukTAq3rtlFs6u+/ghRO82X5/iyCvHoL9zulfE8/8diWr2Q
 +uhLsnk8MT0mUFRFNjhvRYnSWjqpVU9tc+mmofrU6GJOyK7p2wnVYByI263ZyF0L1c75lL
 9oPChRz5j8FfBJ9YWQnxYg55VheXfVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738965671;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eKwaBIh0Zc9m0ggHz+Vrklkoo2lub7cAcaeo84Fx+bI=;
 b=K+p0nN4fcCdvDwB/JJyatVWk7T9BWgMYfzssAfxfdIb/Nv2ErEAK2Nu7JsW2VD38eugZam
 VHltZKDpWaQ+5JCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738965670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eKwaBIh0Zc9m0ggHz+Vrklkoo2lub7cAcaeo84Fx+bI=;
 b=lXFFQn8TjNZtfu2aL8zjNcdv8ivGsRCk/sZJQIJnZrOtPyUW6EzRDkPWkbAdaBVPOl4ZmI
 HdY7PHd1TN989AtODjgaaOp12M2MSjj0LCEPcy11I03coGH0tPd6mpiu2DFIw/rIZn7kUI
 e899yRRKrrqE6AzbcZzZSevpCnuwkWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738965670;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eKwaBIh0Zc9m0ggHz+Vrklkoo2lub7cAcaeo84Fx+bI=;
 b=rim18VfuIqq9kJnyxzim6gLXNf78u/5aYL7/3mQMPvO16Y209s/6NijE49QIrO6HWl4OWC
 xxIe1Ml7KHg53RBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6197C13AC0;
 Fri,  7 Feb 2025 22:01:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nMC/B6aCpmc8OwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 07 Feb 2025 22:01:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com, Prasad Pandit
 <pjp@fedoraproject.org>
Subject: Re: [PATCH v5 5/5] tests/qtest/migration: consolidate set capabilities
In-Reply-To: <20250205122712.229151-6-ppandit@redhat.com>
References: <20250205122712.229151-1-ppandit@redhat.com>
 <20250205122712.229151-6-ppandit@redhat.com>
Date: Fri, 07 Feb 2025 19:01:07 -0300
Message-ID: <874j15wh24.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
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
> Migration capabilities are set in multiple '.start_hook'
> functions for various tests. Instead, consolidate setting
> capabilities in 'set_migration_capabilities()' function
> which is called from various 'test_*_common()' functions.
> While simplifying the capabilities setting, it helps
> to declutter the test sources.
>
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>  tests/qtest/migration/compression-tests.c |  7 +--
>  tests/qtest/migration/cpr-tests.c         |  4 +-
>  tests/qtest/migration/file-tests.c        | 44 +++++-----------
>  tests/qtest/migration/framework.c         | 63 ++++++++++++++++-------
>  tests/qtest/migration/framework.h         |  8 ++-
>  tests/qtest/migration/postcopy-tests.c    | 10 ++--
>  tests/qtest/migration/precopy-tests.c     | 19 +++----

Isn't there a 16 channel multifd setup in this file? I don't see it in
this patch.

>  tests/qtest/migration/tls-tests.c         | 11 ++--
>  8 files changed, 79 insertions(+), 87 deletions(-)
>
> diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
> index 3252ba2f73..13a2b2d74f 100644
> --- a/tests/qtest/migration/compression-tests.c
> +++ b/tests/qtest/migration/compression-tests.c
> @@ -43,7 +43,7 @@ static void test_multifd_tcp_zstd(void)
>  static void test_multifd_postcopy_tcp_zstd(void)
>  {
>      MigrateCommon args = {
> -        .postcopy_ram = true,
> +        .caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true,
>          .listen_uri = "defer",
>          .start_hook = migrate_hook_start_precopy_tcp_multifd_zstd,
>      };
> @@ -114,10 +114,6 @@ migrate_hook_start_xbzrle(QTestState *from,
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
> @@ -129,6 +125,7 @@ static void test_precopy_unix_xbzrle(void)
>          .listen_uri = uri,
>          .start_hook = migrate_hook_start_xbzrle,
>          .iterations = 2,
> +        .caps[MIGRATION_CAPABILITY_XBZRLE] = true,
>          /*
>           * XBZRLE needs pages to be modified when doing the 2nd+ round
>           * iteration to have real data pushed to the stream.
> diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
> index 44ce89aa5b..818fa95133 100644
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
> index 84225c8c33..bc551949f9 100644
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
> +        .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
> +        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
>      };
>  
>      test_file_common(&args, false);
> @@ -176,7 +154,8 @@ static void test_multifd_file_mapped_ram(void)
>      MigrateCommon args = {
>          .connect_uri = uri,
>          .listen_uri = "defer",
> -        .start_hook = migrate_hook_start_multifd_mapped_ram,
> +        .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
> +        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
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
> index 00776f858c..a858b6ffec 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -204,6 +204,30 @@ static QList *migrate_start_get_qmp_capabilities(const MigrateStart *args)
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
> +    for(uint8_t i = 0; i < MIGRATION_CAPABILITY__MAX; i++)
> +    {
> +        if(args->caps[i]) {
> +            if (from) {
> +                migrate_set_capability(from,
> +                    MigrationCapability_lookup.array[i], true);
> +            }
> +            if (to) {
> +                migrate_set_capability(to,
> +                    MigrationCapability_lookup.array[i], true);
> +            }
> +        }
> +    }
> +
> +    return;
> +}
> +
>  int migrate_start(QTestState **from, QTestState **to, const char *uri,
>                    MigrateStart *args)
>  {
> @@ -418,19 +442,8 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
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
> -
> -    if (args->multifd) {
> -        migrate_set_capability(from, "multifd", true);
> -        migrate_set_capability(to, "multifd", true);
> -
> +    set_migration_capabilities(from, to, args);
> +    if (args->caps[MIGRATION_CAPABILITY_MULTIFD]) {
>          migrate_set_parameter_int(from, "multifd-channels", 8);
>          migrate_set_parameter_int(to, "multifd-channels", 8);
>      }
> @@ -491,6 +504,10 @@ void test_postcopy_common(MigrateCommon *args)
>  {
>      QTestState *from, *to;
>  
> +    /* set postcopy capabilities */
> +    args->caps[MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME] = true;
> +    args->caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true;
> +
>      if (migrate_postcopy_prepare(&from, &to, args)) {
>          return;
>      }
> @@ -631,6 +648,10 @@ void test_postcopy_recovery_common(MigrateCommon *args)
>      /* Always hide errors for postcopy recover tests since they're expected */
>      args->start.hide_stderr = true;
>  
> +    /* set postcopy capabilities */
> +    args->caps[MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME] = true;
> +    args->caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true;
> +

Why not keep them inside migrate_postcopy_prepare()?

>      if (migrate_postcopy_prepare(&from, &to, args)) {
>          return;
>      }
> @@ -699,9 +720,10 @@ void test_precopy_common(MigrateCommon *args)
>          return;
>      }
>  
> -    if (args->postcopy_ram) {
> -        migrate_set_capability(from, "postcopy-ram", true);
> -        migrate_set_capability(to, "postcopy-ram", true);
> +    set_migration_capabilities(from, to, args);
> +    if (args->caps[MIGRATION_CAPABILITY_MULTIFD]) {
> +        migrate_set_parameter_int(from, "multifd-channels", 4);
> +        migrate_set_parameter_int(to, "multifd-channels", 4);
>      }
>  
>      if (args->start_hook) {
> @@ -847,6 +869,12 @@ void test_file_common(MigrateCommon *args, bool stop_src)
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
> @@ -913,9 +941,6 @@ void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
>      migrate_set_parameter_str(from, "multifd-compression", method);
>      migrate_set_parameter_str(to, "multifd-compression", method);
>  
> -    migrate_set_capability(from, "multifd", true);
> -    migrate_set_capability(to, "multifd", true);
> -
>      /* Start incoming migration from the 1st socket */
>      migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
>  
> diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
> index 214288ca42..cc1ea4d82b 100644
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
> @@ -193,14 +194,11 @@ typedef struct {
>       */
>      bool live;
>  
> -    /* set multifd on */
> -    bool multifd;
> -
>      /* Postcopy specific fields */
> -    bool postcopy_ram;
>      void *postcopy_data;
> -    bool postcopy_preempt;
>      PostcopyRecoveryFailStage postcopy_recovery_fail_stage;
> +
> +    bool caps[MIGRATION_CAPABILITY__MAX];
>  } MigrateCommon;
>  
>  void wait_for_serial(const char *side);
> diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
> index 212a5ea600..fa8815175f 100644
> --- a/tests/qtest/migration/postcopy-tests.c
> +++ b/tests/qtest/migration/postcopy-tests.c
> @@ -39,7 +39,7 @@ static void test_postcopy_suspend(void)
>  static void test_postcopy_preempt(void)
>  {
>      MigrateCommon args = {
> -        .postcopy_preempt = true,
> +        .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
>      };
>  
>      test_postcopy_common(&args);
> @@ -73,7 +73,7 @@ static void test_postcopy_recovery_fail_reconnect(void)
>  static void test_postcopy_preempt_recovery(void)
>  {
>      MigrateCommon args = {
> -        .postcopy_preempt = true,
> +        .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
>      };
>  
>      test_postcopy_recovery_common(&args);
> @@ -82,7 +82,7 @@ static void test_postcopy_preempt_recovery(void)
>  static void test_multifd_postcopy(void)
>  {
>      MigrateCommon args = {
> -        .multifd = true,
> +        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
>      };
>  
>      test_postcopy_common(&args);
> @@ -91,8 +91,8 @@ static void test_multifd_postcopy(void)
>  static void test_multifd_postcopy_preempt(void)
>  {
>      MigrateCommon args = {
> -        .multifd = true,
> -        .postcopy_preempt = true,
> +        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
> +        .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
>      };
>  
>      test_postcopy_common(&args);
> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> index b1a4e7bbb1..80c8f2a9d2 100644
> --- a/tests/qtest/migration/precopy-tests.c
> +++ b/tests/qtest/migration/precopy-tests.c
> @@ -108,23 +108,12 @@ static void test_precopy_tcp_plain(void)
>      test_precopy_common(&args);
>  }
>  
> -static void *migrate_hook_start_switchover_ack(QTestState *from, QTestState *to)
> -{
> -
> -    migrate_set_capability(from, "return-path", true);
> -    migrate_set_capability(to, "return-path", true);
> -
> -    migrate_set_capability(from, "switchover-ack", true);
> -    migrate_set_capability(to, "switchover-ack", true);
> -
> -    return NULL;
> -}
> -
>  static void test_precopy_tcp_switchover_ack(void)
>  {
>      MigrateCommon args = {
>          .listen_uri = "tcp:127.0.0.1:0",
> -        .start_hook = migrate_hook_start_switchover_ack,
> +        .caps[MIGRATION_CAPABILITY_RETURN_PATH] = true,
> +        .caps[MIGRATION_CAPABILITY_SWITCHOVER_ACK] = true,
>          /*
>           * Source VM must be running in order to consider the switchover ACK
>           * when deciding to do switchover or not.
> @@ -393,6 +382,7 @@ static void test_multifd_tcp_uri_none(void)
>      MigrateCommon args = {
>          .listen_uri = "defer",
>          .start_hook = migrate_hook_start_precopy_tcp_multifd,
> +        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
>          /*
>           * Multifd is more complicated than most of the features, it
>           * directly takes guest page buffers when sending, make sure
> @@ -408,6 +398,7 @@ static void test_multifd_tcp_zero_page_legacy(void)
>      MigrateCommon args = {
>          .listen_uri = "defer",
>          .start_hook = migrate_hook_start_precopy_tcp_multifd_zero_page_legacy,
> +        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
>          /*
>           * Multifd is more complicated than most of the features, it
>           * directly takes guest page buffers when sending, make sure
> @@ -423,6 +414,7 @@ static void test_multifd_tcp_no_zero_page(void)
>      MigrateCommon args = {
>          .listen_uri = "defer",
>          .start_hook = migrate_hook_start_precopy_tcp_multifd_no_zero_page,
> +        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
>          /*
>           * Multifd is more complicated than most of the features, it
>           * directly takes guest page buffers when sending, make sure
> @@ -439,6 +431,7 @@ static void test_multifd_tcp_channels_none(void)
>          .listen_uri = "defer",
>          .start_hook = migrate_hook_start_precopy_tcp_multifd,
>          .live = true,
> +        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
>          .connect_channels = ("[ { 'channel-type': 'main',"
>                               "    'addr': { 'transport': 'socket',"
>                               "              'type': 'inet',"
> diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
> index 094dc1d814..429fd797c0 100644
> --- a/tests/qtest/migration/tls-tests.c
> +++ b/tests/qtest/migration/tls-tests.c
> @@ -375,9 +375,9 @@ static void test_postcopy_tls_psk(void)
>  static void test_postcopy_preempt_tls_psk(void)
>  {
>      MigrateCommon args = {
> -        .postcopy_preempt = true,
>          .start_hook = migrate_hook_start_tls_psk_match,
>          .end_hook = migrate_hook_end_tls_psk,
> +        .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
>      };
>  
>      test_postcopy_common(&args);
> @@ -398,7 +398,7 @@ static void test_multifd_postcopy_recovery_tls_psk(void)
>      MigrateCommon args = {
>          .start_hook = migrate_hook_start_tls_psk_match,
>          .end_hook = migrate_hook_end_tls_psk,
> -        .multifd = true,
> +        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
>      };
>  
>      test_postcopy_recovery_common(&args);
> @@ -408,9 +408,9 @@ static void test_multifd_postcopy_recovery_tls_psk(void)
>  static void test_postcopy_preempt_all(void)
>  {
>      MigrateCommon args = {
> -        .postcopy_preempt = true,
>          .start_hook = migrate_hook_start_tls_psk_match,
>          .end_hook = migrate_hook_end_tls_psk,
> +        .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
>      };
>  
>      test_postcopy_recovery_common(&args);
> @@ -421,7 +421,7 @@ static void test_multifd_postcopy_preempt_recovery_tls_psk(void)
>      MigrateCommon args = {
>          .start_hook = migrate_hook_start_tls_psk_match,
>          .end_hook = migrate_hook_end_tls_psk,
> -        .multifd = true,
> +        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
>      };
>  
>      test_postcopy_recovery_common(&args);
> @@ -674,8 +674,8 @@ static void test_multifd_tcp_tls_psk_mismatch(void)
>  static void test_multifd_postcopy_tcp_tls_psk_match(void)
>  {
>      MigrateCommon args = {
> -        .multifd = true,
>          .listen_uri = "defer",
> +        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
>          .start_hook = migrate_hook_start_multifd_tcp_tls_psk_match,
>          .end_hook = migrate_hook_end_tls_psk,
>      };
> @@ -727,6 +727,7 @@ static void test_multifd_tcp_tls_x509_mismatch_host(void)
>          .start_hook = migrate_hook_start_multifd_tls_x509_mismatch_host,
>          .end_hook = migrate_hook_end_tls_x509,
>          .result = MIG_TEST_FAIL,
> +        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
>      };
>      test_precopy_common(&args);
>  }

