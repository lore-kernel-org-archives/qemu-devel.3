Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D525D66B85
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 21:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVyi2-0004sS-Vq; Wed, 17 Dec 2025 16:05:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVyi1-0004rG-It
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 16:05:21 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVyhz-0000qv-9Q
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 16:05:21 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 174F15BD24;
 Wed, 17 Dec 2025 21:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766005515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Ixyjm1ug6/JYN4yNDFubtTtD93/rj5RlIAXaIh1hXc=;
 b=NbmrZoQ70XPp2yDkKZTWoKuB8wxax7TGwF/LVhvQdPdG29Zlhy7/+z9Gwl1nlK9uVe9tR+
 vASBcNSzURWeqfcFh8SBbDtB+B8sfLLnuW6+YMaZb86x8k5rDb4sEcg2YceOe039ifEFie
 keJ74V+O73XtjdkDpHKtut1g6HQH1OQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766005515;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Ixyjm1ug6/JYN4yNDFubtTtD93/rj5RlIAXaIh1hXc=;
 b=TF362hPm0/k6n1dFd66eDX3aTANGADhJUJ80ys0kqmWvk/JciOXcXTT/2PcbryzDwN9/1L
 3j8GxjMg8iUlcpAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NbmrZoQ7;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TF362hPm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766005515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Ixyjm1ug6/JYN4yNDFubtTtD93/rj5RlIAXaIh1hXc=;
 b=NbmrZoQ70XPp2yDkKZTWoKuB8wxax7TGwF/LVhvQdPdG29Zlhy7/+z9Gwl1nlK9uVe9tR+
 vASBcNSzURWeqfcFh8SBbDtB+B8sfLLnuW6+YMaZb86x8k5rDb4sEcg2YceOe039ifEFie
 keJ74V+O73XtjdkDpHKtut1g6HQH1OQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766005515;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Ixyjm1ug6/JYN4yNDFubtTtD93/rj5RlIAXaIh1hXc=;
 b=TF362hPm0/k6n1dFd66eDX3aTANGADhJUJ80ys0kqmWvk/JciOXcXTT/2PcbryzDwN9/1L
 3j8GxjMg8iUlcpAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89B723EA63;
 Wed, 17 Dec 2025 21:05:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zw+rEgobQ2kadQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 17 Dec 2025 21:05:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 28/51] tests/qtest/migration: Stop invoking
 migrate_incoming from hooks
In-Reply-To: <aUMR699ZHbiF7_lh@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-29-farosas@suse.de> <aUMR699ZHbiF7_lh@x1.local>
Date: Wed, 17 Dec 2025 18:05:11 -0300
Message-ID: <87ecos2514.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 174F15BD24
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> On Mon, Dec 15, 2025 at 07:00:14PM -0300, Fabiano Rosas wrote:
>> Now that the listen_uri is being properly used, tests can stop calling
>> migrate_incoming from their hooks. The _common functions and
>> migrate_start should take care of that.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> IMHO this patch is almost fine,
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> still, some thoughts inline.
>
>> ---
>>  tests/qtest/migration/compression-tests.c |  6 ++++++
>>  tests/qtest/migration/framework.c         | 14 +++++++++++---
>>  tests/qtest/migration/precopy-tests.c     |  7 ++++---
>>  tests/qtest/migration/tls-tests.c         |  8 ++++++++
>>  4 files changed, 29 insertions(+), 6 deletions(-)
>> 
>> diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
>> index eb0b7d6b4b..bed39dece0 100644
>> --- a/tests/qtest/migration/compression-tests.c
>> +++ b/tests/qtest/migration/compression-tests.c
>> @@ -33,6 +33,7 @@ migrate_hook_start_precopy_tcp_multifd_zstd(QTestState *from,
>>  
>>  static void test_multifd_tcp_zstd(char *name, MigrateCommon *args)
>>  {
>> +    args->listen_uri = "tcp:127.0.0.1:0";
>
> Definitely a step forward to unify migrate_incoming into the precopy
> framework, however lots duplication of this "tcp:*" string..
>
> Shall we provide some migrate_common_set_listen_uri_default()?
>

Yeah, this one was bothering me. Maybe we should default to that string
and let the tests override? But then there are other duplications with
unix sockets and the like. This one is definitely the major offender
though.

>>      args->start_hook = migrate_hook_start_precopy_tcp_multifd_zstd;
>>  
>>      args->start.incoming_defer = true;
>> @@ -43,6 +44,7 @@ static void test_multifd_tcp_zstd(char *name, MigrateCommon *args)
>>  
>>  static void test_multifd_postcopy_tcp_zstd(char *name, MigrateCommon *args)
>>  {
>> +    args->listen_uri = "tcp:127.0.0.1:0";
>>      args->start_hook = migrate_hook_start_precopy_tcp_multifd_zstd,
>>  
>>      args->start.incoming_defer = true;
>> @@ -66,6 +68,7 @@ migrate_hook_start_precopy_tcp_multifd_qatzip(QTestState *from,
>>  
>>  static void test_multifd_tcp_qatzip(char *name, MigrateCommon *args)
>>  {
>> +    args->listen_uri = "tcp:127.0.0.1:0";
>>      args->start_hook = migrate_hook_start_precopy_tcp_multifd_qatzip;
>>  
>>      args->start.incoming_defer = true;
>> @@ -85,6 +88,7 @@ migrate_hook_start_precopy_tcp_multifd_qpl(QTestState *from,
>>  
>>  static void test_multifd_tcp_qpl(char *name, MigrateCommon *args)
>>  {
>> +    args->listen_uri = "tcp:127.0.0.1:0";
>>      args->start_hook = migrate_hook_start_precopy_tcp_multifd_qpl;
>>  
>>      args->start.incoming_defer = true;
>> @@ -104,6 +108,7 @@ migrate_hook_start_precopy_tcp_multifd_uadk(QTestState *from,
>>  
>>  static void test_multifd_tcp_uadk(char *name, MigrateCommon *args)
>>  {
>> +    args->listen_uri = "tcp:127.0.0.1:0";
>>      args->start_hook = migrate_hook_start_precopy_tcp_multifd_uadk;
>>  
>>      args->start.incoming_defer = true;
>> @@ -156,6 +161,7 @@ migrate_hook_start_precopy_tcp_multifd_zlib(QTestState *from,
>>  
>>  static void test_multifd_tcp_zlib(char *name, MigrateCommon *args)
>>  {
>> +    args->listen_uri = "tcp:127.0.0.1:0";
>>      args->start_hook = migrate_hook_start_precopy_tcp_multifd_zlib;
>>  
>>      args->start.incoming_defer = true;
>> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
>> index e811945122..199e439263 100644
>> --- a/tests/qtest/migration/framework.c
>> +++ b/tests/qtest/migration/framework.c
>> @@ -820,6 +820,9 @@ int test_precopy_common(MigrateCommon *args)
>>      QObject *out_channels = NULL;
>>  
>>      g_assert(!args->cpr_channel || args->connect_channels);
>> +    if (args->start.incoming_defer) {
>> +        g_assert(args->listen_uri || args->connect_channels);
>> +    }
>>  
>>      if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
>>          return -1;
>> @@ -829,6 +832,14 @@ int test_precopy_common(MigrateCommon *args)
>>          data_hook = args->start_hook(from, to);
>>      }
>>  
>> +    if (args->start.incoming_defer && !args->start.defer_target_connect) {
>> +        if (args->connect_channels) {
>> +            in_channels = qobject_from_json(args->connect_channels,
>> +                                            &error_abort);
>> +        }
>> +        migrate_incoming_qmp(to, args->listen_uri, in_channels, "{}");
>> +    }
>
> The changes here in the framework code looks all correct, even though I
> don't think "connect_channels" is used here in this patch.
>
> Said that, IMHO the channel management is chaos right now in our qtest..
> At least it took me some time staring at this path when reviewing.
>

I had bugs around here when working on this series, so I agree. The
semantics of defer_target_connect are a bit confusing I think. Maybe
that logic could be moved into some CPR specific routine. I need to
check.

> IMHO a major reason is due to the cpr complexities.
>
> E.g. test_mode_transfer_common() used different things to specify incoming
> channels (cpr_channel, opts_target, connect_channels).  We should clean
> them up at some point..
>

Yes, although it's a good test that the various ways of passing channels
are working

>> +
>>      /* Wait for the first serial output from the source */
>>      if (args->result == MIG_TEST_SUCCEED) {
>>          wait_for_serial("src_serial");
>> @@ -1060,9 +1071,6 @@ void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
>>      migrate_set_parameter_str(from, "multifd-compression", method);
>>      migrate_set_parameter_str(to, "multifd-compression", method);
>>  
>> -    /* Start incoming migration from the 1st socket */
>> -    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
>> -
>>      return NULL;
>>  }
>>  
>> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
>> index d9c463dd0f..ab5789717f 100644
>> --- a/tests/qtest/migration/precopy-tests.c
>> +++ b/tests/qtest/migration/precopy-tests.c
>> @@ -239,9 +239,6 @@ static void *migrate_hook_start_fd(QTestState *from,
>>                                   "  'arguments': { 'fdname': 'fd-mig' }}");
>>      close(pair[0]);
>>  
>> -    /* Start incoming migration from the 1st socket */
>> -    migrate_incoming_qmp(to, "fd:fd-mig", NULL, "{}");
>> -
>>      /* Send the 2nd socket to the target */
>>      qtest_qmp_fds_assert_success(from, &pair[1], 1,
>>                                   "{ 'execute': 'getfd',"
>> @@ -283,6 +280,7 @@ static void migrate_hook_end_fd(QTestState *from,
>>  static void test_precopy_fd_socket(char *name, MigrateCommon *args)
>>  {
>>      args->connect_uri = "fd:fd-mig";
>> +    args->listen_uri = "fd:fd-mig";
>>      args->start_hook = migrate_hook_start_fd;
>>      args->end_hook = migrate_hook_end_fd;
>>  
>> @@ -484,6 +482,7 @@ static void test_multifd_tcp_uri_none(char *name, MigrateCommon *args)
>>       * everything will work alright even if guest page is changing.
>>       */
>>      args->live = true;
>> +    args->listen_uri = "tcp:127.0.0.1:0";
>>  
>>      args->start.incoming_defer = true;
>>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
>> @@ -500,6 +499,7 @@ static void test_multifd_tcp_zero_page_legacy(char *name, MigrateCommon *args)
>>       * everything will work alright even if guest page is changing.
>>       */
>>      args->live = true;
>> +    args->listen_uri = "tcp:127.0.0.1:0";
>>  
>>      args->start.incoming_defer = true;
>>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
>> @@ -516,6 +516,7 @@ static void test_multifd_tcp_no_zero_page(char *name, MigrateCommon *args)
>>       * everything will work alright even if guest page is changing.
>>       */
>>      args->live = true;
>> +    args->listen_uri = "tcp:127.0.0.1:0";
>>  
>>      args->start.incoming_defer = true;
>>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
>> diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
>> index 166f27f478..f63f37132a 100644
>> --- a/tests/qtest/migration/tls-tests.c
>> +++ b/tests/qtest/migration/tls-tests.c
>> @@ -677,6 +677,7 @@ static void test_multifd_tcp_tls_psk_match(char *name, MigrateCommon *args)
>>  {
>>      args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_match;
>>      args->end_hook = migrate_hook_end_tls_psk;
>> +    args->listen_uri = "tcp:127.0.0.1:0";
>>  
>>      args->start.incoming_defer = true;
>>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
>> @@ -689,6 +690,7 @@ static void test_multifd_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
>>      args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_mismatch;
>>      args->end_hook = migrate_hook_end_tls_psk;
>>      args->result = MIG_TEST_FAIL;
>> +    args->listen_uri = "tcp:127.0.0.1:0";
>>  
>>      args->start.hide_stderr = true;
>>      args->start.incoming_defer = true;
>> @@ -702,6 +704,7 @@ static void test_multifd_postcopy_tcp_tls_psk_match(char *name,
>>  {
>>      args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_match;
>>      args->end_hook = migrate_hook_end_tls_psk;
>> +    args->listen_uri = "tcp:127.0.0.1:0";
>>  
>>      args->start.incoming_defer = true;
>>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
>> @@ -716,6 +719,7 @@ static void test_multifd_tcp_tls_x509_default_host(char *name,
>>  {
>>      args->start_hook = migrate_hook_start_multifd_tls_x509_default_host;
>>      args->end_hook = migrate_hook_end_tls_x509;
>> +    args->listen_uri = "tcp:127.0.0.1:0";
>>  
>>      args->start.incoming_defer = true;
>>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
>> @@ -728,6 +732,7 @@ static void test_multifd_tcp_tls_x509_override_host(char *name,
>>  {
>>      args->start_hook = migrate_hook_start_multifd_tls_x509_override_host;
>>      args->end_hook = migrate_hook_end_tls_x509;
>> +    args->listen_uri = "tcp:127.0.0.1:0";
>>  
>>      args->start.incoming_defer = true;
>>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
>> @@ -754,6 +759,7 @@ static void test_multifd_tcp_tls_x509_mismatch_host(char *name,
>>      args->start_hook = migrate_hook_start_multifd_tls_x509_mismatch_host;
>>      args->end_hook = migrate_hook_end_tls_x509;
>>      args->result = MIG_TEST_FAIL;
>> +    args->listen_uri = "tcp:127.0.0.1:0";
>>  
>>      args->start.incoming_defer = true;
>>      args->start.hide_stderr = true;
>> @@ -767,6 +773,7 @@ static void test_multifd_tcp_tls_x509_allow_anon_client(char *name,
>>  {
>>      args->start_hook = migrate_hook_start_multifd_tls_x509_allow_anon_client;
>>      args->end_hook = migrate_hook_end_tls_x509;
>> +    args->listen_uri = "tcp:127.0.0.1:0";
>>  
>>      args->start.incoming_defer = true;
>>      args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
>> @@ -780,6 +787,7 @@ static void test_multifd_tcp_tls_x509_reject_anon_client(char *name,
>>      args->start_hook = migrate_hook_start_multifd_tls_x509_reject_anon_client;
>>      args->end_hook = migrate_hook_end_tls_x509;
>>      args->result = MIG_TEST_FAIL;
>> +    args->listen_uri = "tcp:127.0.0.1:0";
>>  
>>      args->start.incoming_defer = true;
>>      args->start.hide_stderr = true;
>> -- 
>> 2.51.0
>> 

