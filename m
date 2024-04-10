Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D112CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 13:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruXn0-0000y3-6d; Wed, 10 Apr 2024 09:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ruXmw-0000ui-LX
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 09:14:54 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ruXmu-0005ly-NO
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 09:14:54 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CE9493521A;
 Wed, 10 Apr 2024 13:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712754891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K6bFtlBeBAAXKSAgIXO1A3XWag2/UPTJAKMWWuuK34A=;
 b=PlGqEdqQHodXUD8oGL0zBT3Jnjcyc+qWAq2Q5s1QrlRZ/5rduEGz301JRe2/xjFu4rBLUI
 uGFxkJM7kERWNBIzqpgcOZ3oiKLNfkh7DwKK/JPFTYNX8FhcFtYtHtXYuBJGil41GBivH9
 GiQCYsvzvbexA27Lu18d10yCc2rDXeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712754891;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K6bFtlBeBAAXKSAgIXO1A3XWag2/UPTJAKMWWuuK34A=;
 b=fHOUjoDRTjll3CFW8MKCOIEvsufyIXHv9AyxQh3Fmu6pkbhivf1J8oviokK+WHcy0alEZx
 5L6RWCIgGUlAsZBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712754890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K6bFtlBeBAAXKSAgIXO1A3XWag2/UPTJAKMWWuuK34A=;
 b=bCyeDZyzfHhbUIGDIFCazXoMBENuTdSAcOaw8Gfaso9/X5orRCxCSnmFn6+AMbnvyjDOJJ
 JCgD1uv6dTvncgAGK44VVkmqutofcwHbsIu5F3xSONovRIFDiGOso3pmipNVChSTIfDK2L
 WC15tffwmhRfPYXnd5GfgRlEDxavii4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712754890;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K6bFtlBeBAAXKSAgIXO1A3XWag2/UPTJAKMWWuuK34A=;
 b=SMGr+jaupewXovfAR7uEsPB8I+iIkthCeA2CJCh7/hKFcwSSqoxmALEpjpR/nIXpTrxBqN
 DvQHv4XTENIGVLBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59BF513691;
 Wed, 10 Apr 2024 13:14:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UDJeCMqQFmZFDAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 10 Apr 2024 13:14:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com, prerna.saxena@nutanix.com, Het Gala
 <het.gala@nutanix.com>
Subject: Re: [PATCH 3/4] tests/qtest/migration: Add channels parameter in
 migrate_incoming_qmp
In-Reply-To: <20240410111541.188504-4-het.gala@nutanix.com>
References: <20240410111541.188504-1-het.gala@nutanix.com>
 <20240410111541.188504-4-het.gala@nutanix.com>
Date: Wed, 10 Apr 2024 10:14:47 -0300
Message-ID: <87y19ltl4o.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
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

Het Gala <het.gala@nutanix.com> writes:

> Alter migrate_incoming_qmp() to allow both uri and channels
> independently. For channels, convert string to a QDict.
>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> ---
>  tests/qtest/migration-helpers.c   | 13 +++++++++++--
>  tests/qtest/migration-helpers.h   |  4 ++--
>  tests/qtest/migration-test.c      | 12 ++++++------
>  tests/qtest/virtio-net-failover.c |  8 ++++----
>  4 files changed, 23 insertions(+), 14 deletions(-)
>
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index 3b72cad6c1..cbd91719ae 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -245,7 +245,8 @@ void migrate_set_capability(QTestState *who, const char *capability,
>                               capability, value);
>  }
>  
> -void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
> +void migrate_incoming_qmp(QTestState *to, const char *uri,
> +                          const char *channels, const char *fmt, ...)
>  {
>      va_list ap;
>      QDict *args, *rsp, *data;
> @@ -255,7 +256,15 @@ void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
>      va_end(ap);
>  
>      g_assert(!qdict_haskey(args, "uri"));
> -    qdict_put_str(args, "uri", uri);
> +    if (uri) {
> +        qdict_put_str(args, "uri", uri);
> +    }
> +
> +    g_assert(!qdict_haskey(args, "channels"));
> +    if (channels) {
> +        QObject *channels_obj = qobject_from_json(channels, &error_abort);
> +        qdict_put_obj(args, "channels", channels_obj);
> +    }

Do you think it makes sense to have channels take precedence here? It
would make the next patch cleaner without having to check for channels
presence. I don't think we need a 'both' test for incoming.

>  
>      migrate_set_capability(to, "events", true);
>  
> diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
> index 1339835698..9f74281aea 100644
> --- a/tests/qtest/migration-helpers.h
> +++ b/tests/qtest/migration-helpers.h
> @@ -29,9 +29,9 @@ G_GNUC_PRINTF(5, 6)
>  void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
>                   const char *channels, const char *fmt, ...);
>  
> -G_GNUC_PRINTF(3, 4)
> +G_GNUC_PRINTF(4, 5)
>  void migrate_incoming_qmp(QTestState *who, const char *uri,
> -                          const char *fmt, ...);
> +                          const char *channels, const char *fmt, ...);
>  
>  G_GNUC_PRINTF(4, 5)
>  void migrate_qmp_fail(QTestState *who, const char *uri,
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index f2c27d611c..fa8a860811 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1296,7 +1296,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
>      migrate_ensure_non_converge(from);
>  
>      migrate_prepare_for_dirty_mem(from);
> -    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
> +    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
>  
>      /* Wait for the first serial output from the source */
>      wait_for_serial("src_serial");
> @@ -1824,7 +1824,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
>       * We need to wait for the source to finish before starting the
>       * destination.
>       */
> -    migrate_incoming_qmp(to, args->connect_uri, "{}");
> +    migrate_incoming_qmp(to, args->connect_uri, NULL, "{}");
>      wait_for_migration_complete(to);
>  
>      if (stop_src) {
> @@ -2405,7 +2405,7 @@ static void *test_migrate_fd_start_hook(QTestState *from,
>      close(pair[0]);
>  
>      /* Start incoming migration from the 1st socket */
> -    migrate_incoming_qmp(to, "fd:fd-mig", "{}");
> +    migrate_incoming_qmp(to, "fd:fd-mig", NULL, "{}");
>  
>      /* Send the 2nd socket to the target */
>      qtest_qmp_fds_assert_success(from, &pair[1], 1,
> @@ -2715,7 +2715,7 @@ test_migrate_precopy_tcp_multifd_start_common(QTestState *from,
>      migrate_set_capability(to, "multifd", true);
>  
>      /* Start incoming migration from the 1st socket */
> -    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
> +    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
>  
>      return NULL;
>  }
> @@ -3040,7 +3040,7 @@ static void test_multifd_tcp_cancel(void)
>      migrate_set_capability(to, "multifd", true);
>  
>      /* Start incoming migration from the 1st socket */
> -    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
> +    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
>  
>      /* Wait for the first serial output from the source */
>      wait_for_serial("src_serial");
> @@ -3068,7 +3068,7 @@ static void test_multifd_tcp_cancel(void)
>      migrate_set_capability(to2, "multifd", true);
>  
>      /* Start incoming migration from the 1st socket */
> -    migrate_incoming_qmp(to2, "tcp:127.0.0.1:0", "{}");
> +    migrate_incoming_qmp(to2, "tcp:127.0.0.1:0", NULL, "{}");
>  
>      wait_for_migration_status(from, "cancelled", NULL);
>  
> diff --git a/tests/qtest/virtio-net-failover.c b/tests/qtest/virtio-net-failover.c
> index 73dfabc272..e263ecd80e 100644
> --- a/tests/qtest/virtio-net-failover.c
> +++ b/tests/qtest/virtio-net-failover.c
> @@ -772,7 +772,7 @@ static void test_migrate_in(gconstpointer opaque)
>      check_one_card(qts, true, "standby0", MAC_STANDBY0);
>      check_one_card(qts, false, "primary0", MAC_PRIMARY0);
>  
> -    migrate_incoming_qmp(qts, uri, "{}");
> +    migrate_incoming_qmp(qts, uri, NULL, "{}");
>  
>      resp = get_failover_negociated_event(qts);
>      g_assert_cmpstr(qdict_get_str(resp, "device-id"), ==, "standby0");
> @@ -894,7 +894,7 @@ static void test_off_migrate_in(gconstpointer opaque)
>      check_one_card(qts, true, "standby0", MAC_STANDBY0);
>      check_one_card(qts, true, "primary0", MAC_PRIMARY0);
>  
> -    migrate_incoming_qmp(qts, uri, "{}");
> +    migrate_incoming_qmp(qts, uri, NULL, "{}");
>  
>      check_one_card(qts, true, "standby0", MAC_STANDBY0);
>      check_one_card(qts, true, "primary0", MAC_PRIMARY0);
> @@ -1021,7 +1021,7 @@ static void test_guest_off_migrate_in(gconstpointer opaque)
>      check_one_card(qts, true, "standby0", MAC_STANDBY0);
>      check_one_card(qts, false, "primary0", MAC_PRIMARY0);
>  
> -    migrate_incoming_qmp(qts, uri, "{}");
> +    migrate_incoming_qmp(qts, uri, NULL, "{}");
>  
>      check_one_card(qts, true, "standby0", MAC_STANDBY0);
>      check_one_card(qts, false, "primary0", MAC_PRIMARY0);
> @@ -1746,7 +1746,7 @@ static void test_multi_in(gconstpointer opaque)
>      check_one_card(qts, true, "standby1", MAC_STANDBY1);
>      check_one_card(qts, false, "primary1", MAC_PRIMARY1);
>  
> -    migrate_incoming_qmp(qts, uri, "{}");
> +    migrate_incoming_qmp(qts, uri, NULL, "{}");
>  
>      resp = get_failover_negociated_event(qts);
>      g_assert_cmpstr(qdict_get_str(resp, "device-id"), ==, "standby0");

