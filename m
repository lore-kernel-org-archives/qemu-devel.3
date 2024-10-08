Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F94CEFC43
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 19:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syFce-0000o0-Bk; Tue, 08 Oct 2024 15:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1syFcZ-0000nr-4R
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 15:11:47 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1syFcW-0004QW-LC
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 15:11:46 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 646F621DA9;
 Tue,  8 Oct 2024 19:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728414701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cKysmZ310nRt5wHieSZwZ7yH5oUqKDxr49v/Vg8a4e0=;
 b=NTgK6GpCXWRVILlTgalhKNIWvrSn6jo68rDcaSZulnyGW+4o1zyCW+iYuJvpxXqBQOUGE8
 wcGPfy/WO2hpL3G4UaWoTJKVyknQ+v7YXIsu1cUMf7HlNH0Ew3gbt0TTnw2EMWrxi2y1jv
 Lf6nfE3suEuGYk4KqxySHmOFhY0Ybdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728414701;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cKysmZ310nRt5wHieSZwZ7yH5oUqKDxr49v/Vg8a4e0=;
 b=UkHgipmsXhOYDb3pOClLQ9uOdJCluHceVmSHmC9Mk2pX8Ynbz/t96UmuU8Q4dk+w7nB+qX
 CQGXNI6mWpxtHaAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728414701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cKysmZ310nRt5wHieSZwZ7yH5oUqKDxr49v/Vg8a4e0=;
 b=NTgK6GpCXWRVILlTgalhKNIWvrSn6jo68rDcaSZulnyGW+4o1zyCW+iYuJvpxXqBQOUGE8
 wcGPfy/WO2hpL3G4UaWoTJKVyknQ+v7YXIsu1cUMf7HlNH0Ew3gbt0TTnw2EMWrxi2y1jv
 Lf6nfE3suEuGYk4KqxySHmOFhY0Ybdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728414701;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cKysmZ310nRt5wHieSZwZ7yH5oUqKDxr49v/Vg8a4e0=;
 b=UkHgipmsXhOYDb3pOClLQ9uOdJCluHceVmSHmC9Mk2pX8Ynbz/t96UmuU8Q4dk+w7nB+qX
 CQGXNI6mWpxtHaAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D552B137CF;
 Tue,  8 Oct 2024 19:11:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id H2CuJuyDBWeLdQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 08 Oct 2024 19:11:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org, David
 Hildenbrand <david@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Markus
 Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 13/13] migration: cpr-transfer mode
In-Reply-To: <ZwV-NRICDNTajTRq@x1n>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-14-git-send-email-steven.sistare@oracle.com>
 <ZwQ6GbVCmitlills@x1n> <eb41bce1-a776-4bb2-adb8-23fdc7cff1fb@oracle.com>
 <87ed4qtpo1.fsf@suse.de> <ZwV-NRICDNTajTRq@x1n>
Date: Tue, 08 Oct 2024 16:11:38 -0300
Message-ID: <877caitno5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; TAGGED_RCPT(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[10];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[oracle.com,nongnu.org,redhat.com,gmail.com,habkost.net,linaro.org];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
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

> On Tue, Oct 08, 2024 at 03:28:30PM -0300, Fabiano Rosas wrote:
>> >>> +    /* Close cpr socket to tell source that we are listening */
>> >>> +    cpr_state_close();
>> >> 
>> >> Would it be possible to use some explicit reply message to mark this?  
>> >
>> > In theory yes, but I fear that using a return channel with message parsing and
>> > dispatch adds more code than it is worth.
>> 
>> I think this approach is fine for now, but I wonder whether we could
>> reuse the current return path (RP) by starting it earlier and take
>> benefit from it already having the message passing infrastructure in
>> place. I'm actually looking ahead to the migration handshake thread[1],
>> which could be thought to have some similarity with the early cpr
>> channel. So having a generic channel in place early on to handle
>> handshake, CPR, RP, etc. could be a good idea.
>
> The current design relies on CPR stage happens before device realize()s, so
> I assume migration channel (including RP) isn't easily applicable at as
> early as this stage.

Well, what is the dependency for the RP? If we can send CPR state, we
can send QEMU_VM_COMMAND, no?

>
> However I think dest qemu can directly write back to the cpr_uri channel
> instead if we want and then follow a protocol simple enough (even though
> it'll be separate from the migration stream protocol).
>
> What worries me more (besides using HUP as of now..) is cpr_state_save() is
> currently synchronous and can block the main iothread.  It means if cpr
> destination is not properly setup, it can hang the main thread (including
> e.g. QMP monitor) at qio_channel_socket_connect_sync().  Ideally we
> shouldn't block the main thread.
>
> If async-mode can be done, it might be even easier, e.g. if we do
> cpr_state_save() in a thread, after qemu_put*() we can directly qemu_get*()
> in the same context with the pairing return qemufile.
>
> But maybe we can do it in two steps, merging HUP first.  Then when a better
> protocol (plus async mode) ready, one can boost QEMU_CPR_FILE_VERSION.
> I'll see how Steve wants to address it.

I agree HUP is fine at the moment.

>
>> 
>> Anyway, I'm probing on this a bit so I can start drafting something. I
>> got surprised that we don't even have the capability bits in the stream
>> in a useful way (currently, configuration_validate_capabilities() does
>> kind of nothing).
>> 
>> 1- https://wiki.qemu.org/ToDo/LiveMigration#Migration_handshake
>
> Happy to know this. I was thinking whether I should work on this even
> earlier, so if you're looking at that it'll be great.

As of half an hour ago =) We could put a feature branch up and work
together, if you have more concrete thoughts on how this would look like
let me know.

>
> The major pain to me is the channel establishment part where we now have
> all kinds of channels, so we should really fix that sooner (e.g., we hope
> to enable multifd + postcopy very soon, that requires multifd and preempt
> channels appear in the same time).  It was reasonable the vfio/multifd
> series tried to fix it.


