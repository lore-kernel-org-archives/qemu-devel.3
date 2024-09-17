Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD21CAC596
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 19:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqduC-0002za-Ik; Tue, 17 Sep 2024 15:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sqdta-0002Fd-C8; Tue, 17 Sep 2024 15:29:54 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sqdtX-0006ON-HQ; Tue, 17 Sep 2024 15:29:54 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 474C322464;
 Tue, 17 Sep 2024 19:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726601389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3cijoSnKf+Tv2+dE7EhlJetbakcGeE44AhabJGtwzbQ=;
 b=LbrTVibx0hdgokm0O551TE5diWA9xzcxSIeDVToNfL2zIoCcZW0KUmGq3IlGvRZzjpYSRy
 21RPy6OjYgtgtKvgmO9mRz/DeRaatw5Y/XeDlMc8fCWJg9UdG2IWZRtcDaKEwNTHnjOfiT
 wyIMa0eDyhACswEcfC7Vx2TCgo/vsV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726601389;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3cijoSnKf+Tv2+dE7EhlJetbakcGeE44AhabJGtwzbQ=;
 b=Ks0t6DKs23zO8YHQxMzqvJSslNAwCrdasbkKoKqR88/AnbymqBhKegesbycLRnb4uNualo
 3FSA6oICR/q3JXAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LbrTVibx;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Ks0t6DKs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726601389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3cijoSnKf+Tv2+dE7EhlJetbakcGeE44AhabJGtwzbQ=;
 b=LbrTVibx0hdgokm0O551TE5diWA9xzcxSIeDVToNfL2zIoCcZW0KUmGq3IlGvRZzjpYSRy
 21RPy6OjYgtgtKvgmO9mRz/DeRaatw5Y/XeDlMc8fCWJg9UdG2IWZRtcDaKEwNTHnjOfiT
 wyIMa0eDyhACswEcfC7Vx2TCgo/vsV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726601389;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3cijoSnKf+Tv2+dE7EhlJetbakcGeE44AhabJGtwzbQ=;
 b=Ks0t6DKs23zO8YHQxMzqvJSslNAwCrdasbkKoKqR88/AnbymqBhKegesbycLRnb4uNualo
 3FSA6oICR/q3JXAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0E26139CE;
 Tue, 17 Sep 2024 19:29:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mu8fIazY6WYoFgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Sep 2024 19:29:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH 2/2] migration/multifd: Fix rb->receivedmap cleanup race
In-Reply-To: <ZunWarI8toCsqAVL@x1n>
References: <20240917185802.15619-1-farosas@suse.de>
 <20240917185802.15619-3-farosas@suse.de> <ZunWarI8toCsqAVL@x1n>
Date: Tue, 17 Sep 2024 16:29:46 -0300
Message-ID: <877cbayt79.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 474C322464
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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

> On Tue, Sep 17, 2024 at 03:58:02PM -0300, Fabiano Rosas wrote:
>> Fix a segmentation fault in multifd when rb->receivedmap is cleared
>> too early.
>> 
>> After commit 5ef7e26bdb ("migration/multifd: solve zero page causing
>> multiple page faults"), multifd started using the rb->receivedmap
>> bitmap, which belongs to ram.c and is initialized and *freed* from the
>> ram SaveVMHandlers.
>> 
>> Multifd threads are live until migration_incoming_state_destroy(),
>> which is called after qemu_loadvm_state_cleanup(), leading to a crash
>> when accessing rb->receivedmap.
>> 
>> process_incoming_migration_co()        ...
>>   qemu_loadvm_state()                  multifd_nocomp_recv()
>>     qemu_loadvm_state_cleanup()          ramblock_recv_bitmap_set_offset()
>>       rb->receivedmap = NULL               set_bit_atomic(..., rb->receivedmap)
>>   ...
>>   migration_incoming_state_destroy()
>>     multifd_recv_cleanup()
>>       multifd_recv_terminate_threads(NULL)
>> 
>> Move the loadvm cleanup into migration_incoming_state_destroy(), after
>> multifd_recv_cleanup() to ensure multifd threads have already exited
>> when rb->receivedmap is cleared.
>> 
>> Adjust the postcopy listen thread comment to indicate that we still
>> want to skip the cpu synchronization.
>> 
>> CC: qemu-stable@nongnu.org
>> Fixes: 5ef7e26bdb ("migration/multifd: solve zero page causing multiple page faults")
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> One trivial question below..
>
>> ---
>>  migration/migration.c | 1 +
>>  migration/savevm.c    | 6 ++++--
>>  2 files changed, 5 insertions(+), 2 deletions(-)
>> 
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 3dea06d577..b190a574b1 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -378,6 +378,7 @@ void migration_incoming_state_destroy(void)
>>      struct MigrationIncomingState *mis = migration_incoming_get_current();
>>  
>>      multifd_recv_cleanup();
>
> Would you mind I add a comment squashed here when queue?
>
>        /*
>         * RAM state cleanup needs to happen after multifd cleanup, because
>         * multifd threads can use some of its states (receivedmap).
>         */

Yeah, that's ok.

>
>> +    qemu_loadvm_state_cleanup();
>>  
>>      if (mis->to_src_file) {
>>          /* Tell source that we are done */
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index d0759694fd..7e1e27182a 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -2979,7 +2979,10 @@ int qemu_loadvm_state(QEMUFile *f)
>>      trace_qemu_loadvm_state_post_main(ret);
>>  
>>      if (mis->have_listen_thread) {
>> -        /* Listen thread still going, can't clean up yet */
>> +        /*
>> +         * Postcopy listen thread still going, don't synchronize the
>> +         * cpus yet.
>> +         */
>>          return ret;
>>      }
>>  
>> @@ -3022,7 +3025,6 @@ int qemu_loadvm_state(QEMUFile *f)
>>          }
>>      }
>>  
>> -    qemu_loadvm_state_cleanup();
>>      cpu_synchronize_all_post_init();
>>  
>>      return ret;
>> -- 
>> 2.35.3
>> 

