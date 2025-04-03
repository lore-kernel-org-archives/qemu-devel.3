Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19783C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 13:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0KEa-0000BD-Lz; Thu, 03 Apr 2025 09:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u0KEC-00009z-V8
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 09:03:30 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u0KEA-0004F5-0g
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 09:03:27 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A7DF91F390;
 Thu,  3 Apr 2025 13:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743685404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GIzybNbW0J6xn+S+iRMhqeDby8lrCNZhtRLCxca2Ixg=;
 b=vx9zm075hY2/ZxBBazFynMOIQULKcNPRd0opgWdCZxbn8OHiSKv5dzaiqgehRXxYQumHOf
 uiwq3y/d0q1PtJui/8BluSQ8cy/X0PUS3OSLk4kXgipywHdFC49IVJeyalRlg8Y3MxQtl3
 kPeLZYJBg1Xrva4iQbsKugDJIw9vtqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743685404;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GIzybNbW0J6xn+S+iRMhqeDby8lrCNZhtRLCxca2Ixg=;
 b=yLhO2kLxFBgadnqa4XAS54VOk760oEgr3QqlOcYtGG6F/194PfZ2CxnC/uoOHgs9tNJUdi
 4ynptLxu839C6nBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743685404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GIzybNbW0J6xn+S+iRMhqeDby8lrCNZhtRLCxca2Ixg=;
 b=vx9zm075hY2/ZxBBazFynMOIQULKcNPRd0opgWdCZxbn8OHiSKv5dzaiqgehRXxYQumHOf
 uiwq3y/d0q1PtJui/8BluSQ8cy/X0PUS3OSLk4kXgipywHdFC49IVJeyalRlg8Y3MxQtl3
 kPeLZYJBg1Xrva4iQbsKugDJIw9vtqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743685404;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GIzybNbW0J6xn+S+iRMhqeDby8lrCNZhtRLCxca2Ixg=;
 b=yLhO2kLxFBgadnqa4XAS54VOk760oEgr3QqlOcYtGG6F/194PfZ2CxnC/uoOHgs9tNJUdi
 4ynptLxu839C6nBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F65A13A50;
 Thu,  3 Apr 2025 13:03:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lzrWMxuH7mfROQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 03 Apr 2025 13:03:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, Prasad
 Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v8 3/7] migration: enable multifd and postcopy together
In-Reply-To: <CAE8KmOzXMrdkgk+VH4_2s6p=UsP+ttr7TMyqT-fVFGB7DgyTfA@mail.gmail.com>
References: <20250318123846.1370312-1-ppandit@redhat.com>
 <20250318123846.1370312-4-ppandit@redhat.com> <87o6xhkyot.fsf@suse.de>
 <CAE8KmOzXMrdkgk+VH4_2s6p=UsP+ttr7TMyqT-fVFGB7DgyTfA@mail.gmail.com>
Date: Thu, 03 Apr 2025 10:03:21 -0300
Message-ID: <875xjll7mu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Prasad Pandit <ppandit@redhat.com> writes:

> On Mon, 31 Mar 2025 at 20:57, Fabiano Rosas <farosas@suse.de> wrote:
>> > --- a/migration/ram.c
>> > +++ b/migration/ram.c
>> > @@ -1297,7 +1297,7 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
>> >          pss->page = 0;
>> >          pss->block = QLIST_NEXT_RCU(pss->block, next);
>> >          if (!pss->block) {
>> > -            if (multifd_ram_sync_per_round()) {
>> > +            if (multifd_ram_sync_per_round() && !migration_in_postcopy()) {
>>
>> I'd rather not put this check here. multifd_ram_flush_and_sync() will
>> already return 0 if in postcopy.
>
> * IIRC, without it migration did not finish or was crashing. I don't
> recall if it was on Fedora or RHEL systems.
>

Maybe you hit the issue I reported? Let's not duplicate the in_postcopy
check unless it makes logical sense. If it crashes, we must figure out
why.

> Thank you.
> ---
>   - Prasad

