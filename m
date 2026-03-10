Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2377DFD4F3F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 21:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w04PW-0000Dv-Ry; Tue, 10 Mar 2026 17:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w04PV-0000DY-42
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 17:14:37 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w04PT-0002Zt-Gp
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 17:14:36 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8D03A5BD0B;
 Tue, 10 Mar 2026 21:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773177273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mfDWrOjQ59MpKgqVcEJcXt/CkGUrLeRRJZS/QumwaYM=;
 b=Q1c2uROSyiV29MJbYYHf9/ooKxJ/6upDY2ZYRVOD/cc9A3geBnKk97AzVKoNyw6EYj8eCY
 HPS37ItH0UIDgXT/bHmJ6iatp5x/dK5vEWDIp5P9pXvD7xAXz1io/G9rHb2Rd/eb3LT/J9
 NJBkGSKk/NasNd6TAXEnXgqLJhXbe6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773177273;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mfDWrOjQ59MpKgqVcEJcXt/CkGUrLeRRJZS/QumwaYM=;
 b=8wgWxjXE+wjgA2FivKoMX8n9uOL3fwXNd95Uzl9HuQcwmL7RqaSRxHX02rGXzegc4mfC5M
 wZgSzMug9gnREYBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773177273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mfDWrOjQ59MpKgqVcEJcXt/CkGUrLeRRJZS/QumwaYM=;
 b=Q1c2uROSyiV29MJbYYHf9/ooKxJ/6upDY2ZYRVOD/cc9A3geBnKk97AzVKoNyw6EYj8eCY
 HPS37ItH0UIDgXT/bHmJ6iatp5x/dK5vEWDIp5P9pXvD7xAXz1io/G9rHb2Rd/eb3LT/J9
 NJBkGSKk/NasNd6TAXEnXgqLJhXbe6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773177273;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mfDWrOjQ59MpKgqVcEJcXt/CkGUrLeRRJZS/QumwaYM=;
 b=8wgWxjXE+wjgA2FivKoMX8n9uOL3fwXNd95Uzl9HuQcwmL7RqaSRxHX02rGXzegc4mfC5M
 wZgSzMug9gnREYBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1294D3F66C;
 Tue, 10 Mar 2026 21:14:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HCmxMriJsGkQPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 10 Mar 2026 21:14:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 5/8] tests/qtest/migration: Force exit-on-error=false
 when appropriate
In-Reply-To: <abCDJyknIzzX8dUy@x1.local>
References: <20260310135540.8679-1-farosas@suse.de>
 <20260310135540.8679-5-farosas@suse.de> <abCDJyknIzzX8dUy@x1.local>
Date: Tue, 10 Mar 2026 18:14:30 -0300
Message-ID: <87o6kvz8sp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, Mar 10, 2026 at 10:55:37AM -0300, Fabiano Rosas wrote:
>> Some tests can cause QEMU to exit(1) too early while the incoming
>> coroutine has not yielded for a first time yet. This trips ASAN
>> because resources related to dispatching the incoming process will
>> still be allocated in the io/channel.c layer without a
>> straight-forward way for the migration code to clean them up.
>> 
>> Since this is an issue only affecting testing and leak detection,
>> let's make sure tests only use MIG_TEST_FAIL_DEST_QUIT_ERR when
>> strictly necessary.
>> 
>> To make this process easier, force exit-on-error=false for precopy
>> whenever the expected test result is MIG_TEST_FAIL. The distinction
>> between the two return codes is exactly that, the latter should never
>> cause exit(1).
>> 
>> The affected tests for now are the TLS tests "no_hostname" and
>> "mismatch_host".
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  tests/qtest/migration/framework.c | 5 ++++-
>>  tests/qtest/migration/tls-tests.c | 6 ++++--
>>  2 files changed, 8 insertions(+), 3 deletions(-)
>> 
>> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
>> index 4cc63bba7b..cfb8409d33 100644
>> --- a/tests/qtest/migration/framework.c
>> +++ b/tests/qtest/migration/framework.c
>> @@ -854,7 +854,10 @@ int test_precopy_common(MigrateCommon *args)
>>              in_channels = qobject_from_json(args->connect_channels,
>>                                              &error_abort);
>>          }
>> -        migrate_incoming_qmp(to, args->listen_uri, in_channels, "{}");
>> +
>> +        migrate_incoming_qmp(to, args->listen_uri, in_channels,
>> +                             args->result == MIG_TEST_FAIL ?
>> +                             "{ 'exit-on-error': false }" : "{}");
>
> Can we set exit-on-error unconditionally?
>

Yeah, what about I just remove MIG_TEST_FAIL_DEST_QUIT_ERR entirely?
Aside from the ones mentioned in this series, there's only one other TLS
test using it. There are two tests setting qtest_set_expected_status(to,
EXIT_FAILURE); after migrate_cancel, but we can just wait for FAILED and
then qtest_quit(to);

> In all cases:
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
>>      }
>>  
>>      /* Wait for the first serial output from the source */
>> diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
>> index f636802642..6274906ad9 100644
>> --- a/tests/qtest/migration/tls-tests.c
>> +++ b/tests/qtest/migration/tls-tests.c
>> @@ -525,7 +525,8 @@ static void test_precopy_tcp_tls_no_hostname(char *name, MigrateCommon *args)
>>      args->listen_uri = "tcp:127.0.0.1:0";
>>      args->start_hook = migrate_hook_start_tls_x509_no_host;
>>      args->end_hook = migrate_hook_end_tls_x509;
>> -    args->result = MIG_TEST_FAIL_DEST_QUIT_ERR;
>> +    args->result = MIG_TEST_FAIL;
>> +    args->start.incoming_defer = true;
>>  
>>      args->start.hide_stderr = true;
>>  
>> @@ -559,7 +560,8 @@ static void test_precopy_tcp_tls_x509_mismatch_host(char *name,
>>      args->listen_uri = "tcp:127.0.0.1:0";
>>      args->start_hook = migrate_hook_start_tls_x509_mismatch_host;
>>      args->end_hook = migrate_hook_end_tls_x509;
>> -    args->result = MIG_TEST_FAIL_DEST_QUIT_ERR;
>> +    args->result = MIG_TEST_FAIL;
>> +    args->start.incoming_defer = true;
>>  
>>      args->start.hide_stderr = true;
>>  
>> -- 
>> 2.51.0
>> 

