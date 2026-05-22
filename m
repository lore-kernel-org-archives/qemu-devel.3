Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E23DCD5BB1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 13:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQPrC-0002YV-VB; Fri, 22 May 2026 09:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wQPr9-0002YD-HB
 for qemu-devel@nongnu.org; Fri, 22 May 2026 09:24:03 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wQPr5-0005Db-J6
 for qemu-devel@nongnu.org; Fri, 22 May 2026 09:24:01 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 034116B8EE;
 Fri, 22 May 2026 13:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779456235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qt6Gh4S0yHuRpCBPmi2DUKdW4ce9/mceMICsNLXwhm8=;
 b=tJvOWCTcN2VGS3hcrNMsgXsdZUIMrj5RFt0SbPFUZcgkL+TKqbKwYRZ8bC0OWIh/BgO82K
 Z5FPc753v996AEcRjpgeqWgfC3hc4jbomOC/+UDhdK1ChLzyv0Syzy/Lfi95LoJveMw9hS
 2ZbugY9sihZ4EYbSjhjb3TT3Sf+O3jg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779456235;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qt6Gh4S0yHuRpCBPmi2DUKdW4ce9/mceMICsNLXwhm8=;
 b=x5PxLosnmnGkUBzD3GHTPGD1YlMULBz9qPY0aR39qlccCJqAZn9GmvRXji72vEUD8WMOp2
 h77uxF3ppeEWAeAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tJvOWCTc;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=x5PxLosn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779456235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qt6Gh4S0yHuRpCBPmi2DUKdW4ce9/mceMICsNLXwhm8=;
 b=tJvOWCTcN2VGS3hcrNMsgXsdZUIMrj5RFt0SbPFUZcgkL+TKqbKwYRZ8bC0OWIh/BgO82K
 Z5FPc753v996AEcRjpgeqWgfC3hc4jbomOC/+UDhdK1ChLzyv0Syzy/Lfi95LoJveMw9hS
 2ZbugY9sihZ4EYbSjhjb3TT3Sf+O3jg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779456235;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qt6Gh4S0yHuRpCBPmi2DUKdW4ce9/mceMICsNLXwhm8=;
 b=x5PxLosnmnGkUBzD3GHTPGD1YlMULBz9qPY0aR39qlccCJqAZn9GmvRXji72vEUD8WMOp2
 h77uxF3ppeEWAeAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96E80593A8;
 Fri, 22 May 2026 13:23:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YhzsGepYEGpyLgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 22 May 2026 13:23:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Mark Kanda <mark.kanda@oracle.com>, Ben Chaney
 <bchaney@akamai.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v1 11/15] tests/qtest/migration: Use defer for cpr-tests
In-Reply-To: <ag3xQBVVv74srgKo@x1.local>
References: <20260505160915.25558-1-farosas@suse.de>
 <20260505160915.25558-12-farosas@suse.de> <ag3xQBVVv74srgKo@x1.local>
Date: Fri, 22 May 2026 10:23:48 -0300
Message-ID: <87pl2n60ij.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 034116B8EE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
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

> On Tue, May 05, 2026 at 01:09:10PM -0300, Fabiano Rosas wrote:
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  tests/qtest/migration/cpr-tests.c | 21 ++++++++++++---------
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> Only one thing to double check:
>
>>  1 file changed, 12 insertions(+), 9 deletions(-)
>> 
>> diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
>> index 18217f0460..9091a84213 100644
>> --- a/tests/qtest/migration/cpr-tests.c
>> +++ b/tests/qtest/migration/cpr-tests.c
>> @@ -60,7 +60,7 @@ static int test_transfer(MigrateCommon *args, const char *cpr_channel,
>>      obj = migrate_str_to_channel(cpr_channel);
>>      qlist_append(channels_list, obj);
>>  
>> -    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
>> +    if (migrate_start(&from, &to, "defer", &args->start)) {
>>          return -1;
>>      }
>>  
>> @@ -128,11 +128,17 @@ static void test_mode_transfer_common(MigrateCommon *args, bool incoming_defer)
>>      int cpr_sockfd = qtest_socket_server(cpr_path);
>>      g_assert(cpr_sockfd >= 0);
>>  
>> -    opts_target = g_strdup_printf("-incoming cpr,addr.transport=socket,"
>> -                                  "addr.type=fd,addr.str=%d %s",
>> -                                  cpr_sockfd, opts);
>> +    if (incoming_defer) {
>> +        opts_target = g_strdup_printf("-incoming cpr,addr.transport=socket,"
>> +                                      "addr.type=fd,addr.str=%d %s",
>> +                                      cpr_sockfd, opts);
>> +    } else {
>> +        opts_target = g_strdup_printf("-incoming %s "
>> +                                      "-incoming cpr,addr.transport=socket,"
>> +                                      "addr.type=fd,addr.str=%d %s",
>> +                                      uri, cpr_sockfd, opts);
>
> IIUC now in this path qtest will ultimately generate cmdline like this for
> dest:
>
>   -incoming defer \
>   -incoming unix:... \
>   -incoming cpr,addr...
>
> I am not sure if this is the intention, but it looks working indeed where
> the 1st defer will be an no-op, and "-incoming" allows overwrites.
>

Yes, it's on purpose, I think I remember some discussion at the time
about this and we decided it was ok.

In any case, it's probably good to have some variability because that
parsing code at vl.c is quite fragile in my opinion. Better to find a
breakage during testing than in production.

> We'll just need to remember this and be careful in the future on the order
> of these parameters. Say, if we accidentally move the first "-incoming
> defer" parameter to be after opts_target, then it might break, because then
> it's not no-op anymore but freeing the main channel we just set.
>
> But I think it's ok for now.
>
>> +    }
>>  
>> -    args->listen_uri = incoming_defer ? "defer" : uri;
>>      args->connect_channels = connect_channels;
>>  
>>      args->start.opts_source = opts;
>> @@ -224,7 +230,7 @@ static void test_cpr_exec(MigrateCommon *args)
>>      g_autofree char *filename = g_strdup_printf("%s/%s", tmpfs,
>>                                                  FILE_TEST_FILENAME);
>>  
>> -    if (migrate_start(&from, NULL, args->listen_uri, &args->start)) {
>> +    if (migrate_start(&from, NULL, "defer", &args->start)) {
>>          return;
>>      }
>>  
>> @@ -274,10 +280,7 @@ static void test_mode_exec(char *name, MigrateCommon *args)
>>  {
>>      g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
>>                                             FILE_TEST_FILENAME);
>> -    g_autofree char *listen_uri = g_strdup_printf("defer");
>> -
>>      args->connect_uri = uri;
>> -    args->listen_uri = listen_uri;
>>      args->start_hook = test_mode_exec_start;
>>  
>>      args->start.only_source = true;
>> -- 
>> 2.51.0
>> 

