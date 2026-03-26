Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065A810AB827
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 21:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5s15-0000fv-2M; Thu, 26 Mar 2026 17:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w5s13-0000fi-M7
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 17:13:21 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w5s12-00056Z-0D
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 17:13:21 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B024D4D3F8;
 Thu, 26 Mar 2026 21:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774559597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r6b/wOXevHUOfuIzyBaJyhhqOPC9uh/lCYba2n+rfLA=;
 b=ajtKb2j+TETQ10e95QhsGnS+lqxhEINrJxMq/3EPp7lULniyr8j5tDX7tmA9QeJUdlybuu
 cKmh2BM76ctk1f/GJQxFm9wd7dW+kaqC+qp48x93+Gl5YpICpLUmdxbHQxbzPtxxGHFPNs
 fDZrb3Y8thklxY5p/bo4sOR4rfvwvn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774559597;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r6b/wOXevHUOfuIzyBaJyhhqOPC9uh/lCYba2n+rfLA=;
 b=bItrK41sNCjomgr2HqGsLq2IF6scEwKCGQwW0/PBdGMchf8Yhp3r3hTRvZJlEzP6hOdFaw
 OqaMocbz3ye6PDDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774559596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r6b/wOXevHUOfuIzyBaJyhhqOPC9uh/lCYba2n+rfLA=;
 b=RLymWVNxl54ZhAVdOQGwpSgUd0KLsaD2inL4d6MVcsJm42CJ7d3Fs8bbzqCck70PJYx7e7
 AlrhtF93Ys67aBW2EsUBZsro+KiXBiw5V55+DeMO2tnWyrAB/M/l7HpAyHIv+Bq+LZZqws
 JWdlUgfQVFFXwQEsXG1g5VzX6Q4+cBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774559596;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r6b/wOXevHUOfuIzyBaJyhhqOPC9uh/lCYba2n+rfLA=;
 b=IkTs/Pc2v2JK+DtSv1Sv/2mheLQko/aT1mZtnL7BBl1r4n9KAU5NIGC4IkJE0xQbBXbTqT
 1zb8gp1pYNVrbgAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DA194A0A3;
 Thu, 26 Mar 2026 21:13:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Aua6B2yhxWnxRgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 26 Mar 2026 21:13:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1] tests/qtest/migration: Fix slow test dirty_limit
In-Reply-To: <acV4N7ENkELzx5V9@x1.local>
References: <20260326164405.1626-1-farosas@suse.de> <acV4N7ENkELzx5V9@x1.local>
Date: Thu, 26 Mar 2026 18:13:14 -0300
Message-ID: <877bqyjnv9.fsf@suse.de>
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
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> On Thu, Mar 26, 2026 at 01:44:05PM -0300, Fabiano Rosas wrote:
>> After the referenced commit, the incoming side doesn't exit
>> automatically after a failure. Tests that expect the destination to
>> fail should use -incoming defer, issue QMP migrate-incoming, wait for
>> the failure event and issue QMP quit.
>> 
>> Fix the dirty_limit test which wasn't updated properly.
>> 
>> Fixes: 4e8c4dda97 ("tests/qtest/migration: Force exit-on-error=false")
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> Highly likely I missed something, but could you remind me what is the
> problem before the change, and why "defer" fixes it?
>

The original issue was that on failure the incoming side exits abruptly
and leaves resources in the io/channel.c and io/task.c without freeing
and that triggers ASAN (when in use). The fix was to set
exit-on-error=false always. -incoming defer is needed because -incoming
uri has no means of setting the exit-on-error flag, we need an explicit
call to migrate-incoming to be able to set the flag.

The dirty_limit test was not updated properly because it's under g_slow
and I forgot to test it. I removed the qtest_set_expected_status(to,
EXIT_FAILURE) line, but didn't make sure exit-on-error is set to false
for this test. So it's now aborting with "expected 0, got 1".

> The current failure path in this test is:
>
>     /* Now cancel migrate and wait for dirty limit throttle switch off */
>     migrate_cancel(from);
>     wait_for_migration_status(from, "cancelled", NULL);
>
>     /* destination always fails after cancel */
>     migration_event_wait(to, "failed");
>     qtest_set_expected_status(to, EXIT_FAILURE);
>     qtest_quit(to);
>
> It waits for "failed", so IIUC after switching to exit-on-error it'll make
> sure things got gracefully shutdown before qtest_quit().  So I'm a bit lost
> on what we're fixing.
>
> PS: a nitpick is if we could always attach a "Link:" to the commit message,
> it might help a bit on knowing the original report too.
>
>> ---
>>  tests/qtest/migration/precopy-tests.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
>> index c6c8ae3004..a0e3ff0547 100644
>> --- a/tests/qtest/migration/precopy-tests.c
>> +++ b/tests/qtest/migration/precopy-tests.c
>> @@ -1070,11 +1070,10 @@ static void test_dirty_limit(char *name, MigrateCommon *args)
>>      args->start.hide_stderr = true;
>>      args->start.use_dirty_ring = true;
>>  
>> -    args->listen_uri = uri;
>>      args->connect_uri = uri;
>>  
>>      /* Start src, dst vm */
>> -    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
>> +    if (migrate_start(&from, &to, "defer", &args->start)) {
>>          return;
>>      }
>>  
>> @@ -1082,6 +1081,7 @@ static void test_dirty_limit(char *name, MigrateCommon *args)
>>      migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
>>  
>>      /* Start migrate */
>> +    migrate_incoming_qmp(to, args->connect_uri, NULL, "{}");
>>      migrate_qmp(from, to, args->connect_uri, NULL, "{}");
>>  
>>      /* Wait for dirty limit throttle begin */
>> -- 
>> 2.51.0
>> 

