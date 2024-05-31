Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B3CC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 16:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD4hg-0003D2-6W; Fri, 31 May 2024 12:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sD4he-00035B-7Q
 for qemu-devel@nongnu.org; Fri, 31 May 2024 12:02:02 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sD4hc-0005ym-8K
 for qemu-devel@nongnu.org; Fri, 31 May 2024 12:02:01 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4F3CE1FB90;
 Fri, 31 May 2024 16:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717171317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=elTQQg7XPbYyIy4NxWuRUa1F2PrGaSDRmOHftEEBU3k=;
 b=i7jStklFzK+2Dva+MTwA0Qa3p8PL4IL/XaSXSB39FCsRldX30repnA2Vw1TF/SJiEzgVSQ
 lrarBnJbPdtF8FyZPEa8HN+IlLcl5a/OIeY9X/Wv6JqYeMu2rGwXC+fWrSzNrcZONlbpHd
 f8IkphiJACeDPnNm3/dirQyl4tJyhYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717171317;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=elTQQg7XPbYyIy4NxWuRUa1F2PrGaSDRmOHftEEBU3k=;
 b=EkrtRbIHmamgU3rL0DGwupwihWjHXM9yBDjuRyI3lyefPgYKk8Q5WNYJYXbnewKFYZ2NFL
 Bg+okpi/eA6frGBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=i7jStklF;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EkrtRbIH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717171317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=elTQQg7XPbYyIy4NxWuRUa1F2PrGaSDRmOHftEEBU3k=;
 b=i7jStklFzK+2Dva+MTwA0Qa3p8PL4IL/XaSXSB39FCsRldX30repnA2Vw1TF/SJiEzgVSQ
 lrarBnJbPdtF8FyZPEa8HN+IlLcl5a/OIeY9X/Wv6JqYeMu2rGwXC+fWrSzNrcZONlbpHd
 f8IkphiJACeDPnNm3/dirQyl4tJyhYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717171317;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=elTQQg7XPbYyIy4NxWuRUa1F2PrGaSDRmOHftEEBU3k=;
 b=EkrtRbIHmamgU3rL0DGwupwihWjHXM9yBDjuRyI3lyefPgYKk8Q5WNYJYXbnewKFYZ2NFL
 Bg+okpi/eA6frGBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CCEFC132C2;
 Fri, 31 May 2024 16:01:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FzGlJHT0WWY4FQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 31 May 2024 16:01:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 4/4] tests/qtest/migration-test: Add a postcopy
 memfile test
In-Reply-To: <ZlnRy0PS17qa2aqb@x1n>
References: <20240530095408.31608-1-npiggin@gmail.com>
 <20240530095408.31608-5-npiggin@gmail.com> <ZlnRy0PS17qa2aqb@x1n>
Date: Fri, 31 May 2024 13:01:54 -0300
Message-ID: <87bk4mkm19.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_TO(0.00)[redhat.com,gmail.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4F3CE1FB90
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Thu, May 30, 2024 at 07:54:07PM +1000, Nicholas Piggin wrote:
>> Postcopy requires userfaultfd support, which requires tmpfs if a memory
>> file is used.
>> 
>> This adds back support for /dev/shm memory files, but adds preallocation
>> to skip environments where that mount is limited in size.
>> 
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>
> Thanks for doing this regardless.
>
>> ---
>>  tests/qtest/migration-test.c | 77 ++++++++++++++++++++++++++++++++----
>>  1 file changed, 69 insertions(+), 8 deletions(-)
>> 
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index 86eace354e..5078033ded 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -11,6 +11,7 @@
>>   */
>>  
>>  #include "qemu/osdep.h"
>> +#include "qemu/cutils.h"
>>  
>>  #include "libqtest.h"
>>  #include "qapi/qmp/qdict.h"
>> @@ -553,6 +554,7 @@ typedef struct {
>>       */
>>      bool hide_stderr;
>>      bool use_memfile;
>> +    bool use_shm_memfile;
>
> Nitpick: when having both, it's slightly confusing on the name, e.g. not
> clear whether use_memfile needs to be set to true too if use_shm_memfile=true.
>
> Maybe "use_tmpfs_memfile" and "use_shm_memfile"?
>
>>      /* only launch the target process */
>>      bool only_target;
>>      /* Use dirty ring if true; dirty logging otherwise */
>> @@ -739,7 +741,62 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>>          ignore_stderr = "";
>>      }
>>  
>> -    if (args->use_memfile) {
>> +    if (!qtest_has_machine(machine_alias)) {
>> +        g_autofree char *msg = g_strdup_printf("machine %s not supported",
>> +                                               machine_alias);
>> +        g_test_skip(msg);
>> +        return -1;
>> +    }
>> +
>> +    if (args->use_shm_memfile) {
>> +#if defined(__NR_userfaultfd) && defined(__linux__)
>
> IIUC we only need defined(__linux__) as there's nothing to do with uffd yet?
>
>> +        int fd;
>> +        uint64_t size;
>> +
>> +        if (getenv("GITLAB_CI")) {
>> +            /*
>> +             * Gitlab runners are limited to 64MB shm size and despite
>> +             * pre-allocation there is concern that concurrent tests
>> +             * could result in nondeterministic failures. Until all shm
>> +             * usage in all CI tests is found to fail gracefully on
>> +             * ENOSPC, it is safer to avoid large allocations for now.
>> +             *
>> +             * https://lore.kernel.org/qemu-devel/875xuwg4mx.fsf@suse.de/
>> +             */
>> +            g_test_skip("shm tests are not supported in Gitlab CI environment");
>> +            return -1;
>> +        }
>
> I'm not sure whether this is Fabiano's intention.  I'm wondering whether we
> can drop this and just let it still run there.
>

It was my intention. But I overlooked the fact that the current shm
cannot even run one migration test already.

> Other tests not detecting avaiablility of shmem looks like a separate issue
> to be fixed to me, regardless of this.
>
> My wild guess is since we're doing memory_size+64K below then if test won't
> fail others won't either, as normally the shmem quota should normally be
> power of 2 anyway.. then it should always fit another few MBs if this one.
> While this test is ready to fail gracefully now.
>

I agree. Let's drop this part then.


