Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39A4D59D68
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 19:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFeyR-0000TS-Br; Mon, 25 Nov 2024 14:42:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tFeyK-0000T6-W7
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:42:14 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tFeyG-00025w-Jx
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:42:10 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6016421185;
 Mon, 25 Nov 2024 19:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732563725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kdkcJH6qJKmFIAKL+aDp7iB2ioYIyvqEGq44TfLfnlM=;
 b=FTzWLg5Z+21Ddq4b3DZnimE/i5TTxcxiiegxiOh/KS9d7TkTBzHJ0bYGhpSge8CspGKI51
 JnjSTw3h1VpMY17kKr7S0sopKd/a66wZ//zaSxKN1DP9yiziRuApfWofRvDDZ2zLdkP7lo
 INm7ibMgyrv2zFpkxwEyvIxGyihxm9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732563725;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kdkcJH6qJKmFIAKL+aDp7iB2ioYIyvqEGq44TfLfnlM=;
 b=Re73HPjGQcaoxB/H6Jd6lGnTuIitT9QtOIa5kUNhetcp4c5b1OsCMtjt29Tn3ic2MQd1HZ
 +KBYb5MxYUQG6ACg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FTzWLg5Z;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Re73HPjG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732563725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kdkcJH6qJKmFIAKL+aDp7iB2ioYIyvqEGq44TfLfnlM=;
 b=FTzWLg5Z+21Ddq4b3DZnimE/i5TTxcxiiegxiOh/KS9d7TkTBzHJ0bYGhpSge8CspGKI51
 JnjSTw3h1VpMY17kKr7S0sopKd/a66wZ//zaSxKN1DP9yiziRuApfWofRvDDZ2zLdkP7lo
 INm7ibMgyrv2zFpkxwEyvIxGyihxm9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732563725;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kdkcJH6qJKmFIAKL+aDp7iB2ioYIyvqEGq44TfLfnlM=;
 b=Re73HPjGQcaoxB/H6Jd6lGnTuIitT9QtOIa5kUNhetcp4c5b1OsCMtjt29Tn3ic2MQd1HZ
 +KBYb5MxYUQG6ACg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CAECB13890;
 Mon, 25 Nov 2024 19:42:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8EIuIwzTRGfKLAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 25 Nov 2024 19:42:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: Fix extra cleanup at postcopy listen
In-Reply-To: <Z0TP6Wmv6DnDPLES@x1n>
References: <20241125191128.9120-1-farosas@suse.de> <Z0TP6Wmv6DnDPLES@x1n>
Date: Mon, 25 Nov 2024 16:42:02 -0300
Message-ID: <87iksbnlrp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 6016421185
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

> On Mon, Nov 25, 2024 at 04:11:28PM -0300, Fabiano Rosas wrote:
>> After fixing the loadvm cleanup race the qemu_loadvm_state_cleanup()
>> is now being called twice in the postcopy listen thread.
>> 
>> Fixes: 4ce5622908 ("migration/multifd: Fix rb->receivedmap cleanup race")
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> This is so far harmless, right?  I think we can still queue this for 9.2,
> but I'd just like to double check..
>

I believe so, yes.

>> ---
>>  migration/savevm.c | 1 -
>>  1 file changed, 1 deletion(-)
>> 
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index f4e4876f72..98821c8120 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -2057,7 +2057,6 @@ static void *postcopy_ram_listen_thread(void *opaque)
>>       * got a bad migration state).
>>       */
>>      migration_incoming_state_destroy();
>> -    qemu_loadvm_state_cleanup();
>>  
>>      rcu_unregister_thread();
>>      mis->have_listen_thread = false;
>> -- 
>> 2.35.3
>> 

