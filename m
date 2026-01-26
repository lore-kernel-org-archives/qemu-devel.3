Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073CAD1951A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 22:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkUdD-0000Vb-EP; Mon, 26 Jan 2026 17:00:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vkUd7-0000Tf-TX
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 17:00:18 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vkUd6-0000Pi-4p
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 17:00:17 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1CDAC33781;
 Mon, 26 Jan 2026 22:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769464814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PJAC+NLJXNbisLbtrYGoUOmbTTUYhQ8g9z9UhqSXk1A=;
 b=KCU+gu3hYWij8b56gF2rNmUfPuDAq1iDW8lI60DHw6/6lk0mEO8zHGnfm5jVGyBNEqSlm4
 FpDaiE8OMr5g9O4H+zEL8TK1I/Q4UwpIx6ernOvzPfgSexOejxpFpHDiJv9TsNsAF4bypa
 NaQX6fOB+HtJ+T1L5bkoMRTni5WaFrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769464814;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PJAC+NLJXNbisLbtrYGoUOmbTTUYhQ8g9z9UhqSXk1A=;
 b=BIxl2kVrYBLdor25RNwbIWvgZyjPqS5rJ4jc/7/h672tMSPlxz6SHUTEDs5JrJI3yAwCO9
 kvBY5DnoS5ArmjAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KCU+gu3h;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BIxl2kVr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769464814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PJAC+NLJXNbisLbtrYGoUOmbTTUYhQ8g9z9UhqSXk1A=;
 b=KCU+gu3hYWij8b56gF2rNmUfPuDAq1iDW8lI60DHw6/6lk0mEO8zHGnfm5jVGyBNEqSlm4
 FpDaiE8OMr5g9O4H+zEL8TK1I/Q4UwpIx6ernOvzPfgSexOejxpFpHDiJv9TsNsAF4bypa
 NaQX6fOB+HtJ+T1L5bkoMRTni5WaFrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769464814;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PJAC+NLJXNbisLbtrYGoUOmbTTUYhQ8g9z9UhqSXk1A=;
 b=BIxl2kVrYBLdor25RNwbIWvgZyjPqS5rJ4jc/7/h672tMSPlxz6SHUTEDs5JrJI3yAwCO9
 kvBY5DnoS5ArmjAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 819A9139E9;
 Mon, 26 Jan 2026 22:00:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cdueEO3jd2mjXQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 26 Jan 2026 22:00:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Prasad Pandit <ppandit@redhat.com>, Lukas Straub
 <lukasstraub2@web.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 04/10] migration/savevm: Remove SaveStateEntry.is_ram
In-Reply-To: <aXfEMcFNL_YPjgzg@x1.local>
References: <20260121223336.3381912-1-peterx@redhat.com>
 <20260121223336.3381912-5-peterx@redhat.com> <87fr7wigpt.fsf@suse.de>
 <aXfEMcFNL_YPjgzg@x1.local>
Date: Mon, 26 Jan 2026 19:00:10 -0300
Message-ID: <874io8ghlh.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_ENVRCPT(0.00)[web.de];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[nongnu.org,redhat.com,web.de];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 1CDAC33781
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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

> On Fri, Jan 23, 2026 at 10:47:10AM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > It's neither accurate nor necessary.  Use a proper helper to detect if it's
>> > an iterable savevm state entry instead.
>> 
>> Could you explain what exactly is_ram was supposed to mean?
>
> IIUC when introduced it was trying to capture the ram only, and that's also
> why I said it's inaccurate, because ram is not the only thing that can
> provide a save_setup() nowadays..
>
>> 
>> >
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >  migration/savevm.c | 15 ++++++++-------
>> >  1 file changed, 8 insertions(+), 7 deletions(-)
>> >
>> > diff --git a/migration/savevm.c b/migration/savevm.c
>> > index 61e873d90c..f1cd8c913d 100644
>> > --- a/migration/savevm.c
>> > +++ b/migration/savevm.c
>> > @@ -249,7 +249,6 @@ typedef struct SaveStateEntry {
>> >      const VMStateDescription *vmsd;
>> >      void *opaque;
>> >      CompatEntry *compat;
>> > -    int is_ram;
>> >  } SaveStateEntry;
>> >  
>> >  typedef struct SaveState {
>> > @@ -816,10 +815,6 @@ int register_savevm_live(const char *idstr,
>> >      se->ops = ops;
>> >      se->opaque = opaque;
>> >      se->vmsd = NULL;
>> > -    /* if this is a live_savem then set is_ram */
>> > -    if (ops->save_setup != NULL) {
>> > -        se->is_ram = 1;
>> > -    }
>> >  
>> >      pstrcat(se->idstr, sizeof(se->idstr), idstr);
>> >  
>> > @@ -1866,6 +1861,12 @@ void qemu_savevm_live_state(QEMUFile *f)
>> >      qemu_put_byte(f, QEMU_VM_EOF);
>> >  }
>> >  
>> > +/* Is a save state entry iterable (e.g. RAM)? */
>> > +static bool qemu_savevm_se_iterable(SaveStateEntry *se)
>> > +{
>> > +    return se->ops && se->ops->save_setup;
>> 
>> So it could be iterable and not have .save_live_iterate?
>> 
>> Also, what's the deal with slirp? AIUI, it would be considered is_ram?
>
> I guess no. Either in term of when it's introduced, or in theory of how I
> understand this piece of code should work.. Because savevm_slirp_state
> doesn't provide save_setup().
>

Oops, I misread save_state vs. save_setup.

> Note that this patch didn't really change the fact on how it works, even if
> I _think_ this is broken..  I want to leave it for later, making sure this
> patch (while doing the cleanup) doesn't introduce functional changes.
>

That's always fine.

> So I expect things to break if e.g. COLO is used with VFIO devices (that
> supports migrations), where it also provides save_setup(), but actually
> COLO will not properly sync VFIO states.  Likely nobody is using it anyway.
>
> It's also the same to Xen's xen-save-devices-state QMP command.  It looks
> to me Xen is playing some "split savevm" work here, however I don't know
> whether it'll always workout these days when there're special devices that
> provide save_setup().
>

Hm, ok. Let's leave it then.

>> 
>> > +}
>> > +
>> >  int qemu_save_device_state(QEMUFile *f)
>> >  {
>> >      Error *local_err = NULL;
>> > @@ -1876,7 +1877,7 @@ int qemu_save_device_state(QEMUFile *f)
>> >      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> >          int ret;
>> >  
>> > -        if (se->is_ram) {
>> > +        if (qemu_savevm_se_iterable(se)) {
>> 
>> Hmm, qemu_savevm_state_setup has:
>> 
>>     if (!se->ops || !se->ops->save_setup) {
>>             continue;
>>     }
>> 
>> therefore:
>> 
>>     if (!qemu_savevm_se_iterable(se)) {
>>             continue;
>>     }
>> 
>> Maybe it would be more practical to put these in a separate list already
>> while registering.
>
> This is a question about performance, my gut feeling is looping over with
> one queue would be fine for now, but even if not, it'll be further question
> to ask after above (on correctness..).
>
> So I plan to be focused on the cleanup part for now in this series..
>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

