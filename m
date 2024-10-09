Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A4BCEE359
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 22:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syeri-0005Ai-Lw; Wed, 09 Oct 2024 18:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1syerg-0005AZ-Vr
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 18:09:05 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1syere-0007s4-VT
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 18:09:04 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1FCD61F7BC;
 Wed,  9 Oct 2024 22:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728511741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E5N+utB1lCc8DDUPqjBqT91upKkQWDnpGGcYpQ7uFIA=;
 b=gykuw312xI+8Xwn0RP+XmOQ0hApbPYF6q0OUFjJKo8ubwsxefAye0psD4NNYJJYpeLpsVq
 SP9u3kvOW57DMysMGlo2q5CtoAxXtBnIT46bKoqgzBZSqaqSd0RMsPpzD9BfpmBySEe9CO
 5Nav4NesQJD8XFqN3eHomKtNQrAW0UI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728511741;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E5N+utB1lCc8DDUPqjBqT91upKkQWDnpGGcYpQ7uFIA=;
 b=Teg1uNp8i2w5paa3UC+qrezafO9EZkl7RHEMgMyvKuYgO16pU6j8E8V+AkC9wPPEim/vco
 HVgmCoPNTU3bx1DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728511741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E5N+utB1lCc8DDUPqjBqT91upKkQWDnpGGcYpQ7uFIA=;
 b=gykuw312xI+8Xwn0RP+XmOQ0hApbPYF6q0OUFjJKo8ubwsxefAye0psD4NNYJJYpeLpsVq
 SP9u3kvOW57DMysMGlo2q5CtoAxXtBnIT46bKoqgzBZSqaqSd0RMsPpzD9BfpmBySEe9CO
 5Nav4NesQJD8XFqN3eHomKtNQrAW0UI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728511741;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E5N+utB1lCc8DDUPqjBqT91upKkQWDnpGGcYpQ7uFIA=;
 b=Teg1uNp8i2w5paa3UC+qrezafO9EZkl7RHEMgMyvKuYgO16pU6j8E8V+AkC9wPPEim/vco
 HVgmCoPNTU3bx1DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A05B13A58;
 Wed,  9 Oct 2024 22:09:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id S7cfGPz+BmcaRQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 09 Oct 2024 22:09:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Philippe Mathieu-Daude <philmd@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 13/13] migration: cpr-transfer mode
In-Reply-To: <ZwbuNnFCgN_vjniX@x1n>
References: <ZwQ6GbVCmitlills@x1n>
 <eb41bce1-a776-4bb2-adb8-23fdc7cff1fb@oracle.com> <87ed4qtpo1.fsf@suse.de>
 <ZwV-NRICDNTajTRq@x1n> <877caitno5.fsf@suse.de> <ZwWMj4FYYpOSnPbe@x1n>
 <8b92a6ee-19f7-4483-9766-6b849cc04017@oracle.com> <ZwbUTXCxxl4heZYV@x1n>
 <Zwbgur3d0cImLV99@x1n> <97268719-56f3-4d7f-aa21-c04cd0262601@oracle.com>
 <ZwbuNnFCgN_vjniX@x1n>
Date: Wed, 09 Oct 2024 19:08:58 -0300
Message-ID: <87plo9rksl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; TAGGED_RCPT(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[10];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[nongnu.org,redhat.com,gmail.com,habkost.net,linaro.org];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

> On Wed, Oct 09, 2024 at 04:18:31PM -0400, Steven Sistare wrote:
>> Yes, I am also brainstorming along these lines, looking for more gotcha's,
>> but its a big design change. I don't love it so far.
>> 
>> These issues all creep in because of transfer mode.  Exec mode did not have this
>> problem, as cpr-state is written to an in-memory file.
>
> I understand.  Hopefully we're getting there very soon..
>
> I still have concern on having -global used in productions, and meanwhile

Agree, but for qtests it should be fine at least.

> it might still be challenging for handshake to work as early as cpr stage
> even for later, because at least in my mind the handshake still happens in
> the main migration channel (where it includes channel establishments etc,
> which is not proper during cpr stage).

I don't think any form of handshake will be implemented in a
month. Maybe it's best we keep that to the side for now.

(still, thinking about that virtio-net USO thread, an early handshake
could be a good idea, so we could perhaps inform about device
incompatibility, etc.)

>
> I don't really know whether that'll work at last..
>
> So in my mind the previous two-steps proposal is so far the only one that
> all seem to work, with no unpredictable side effects.
>
> Said that, maybe we can still think about simpler solutions in the
> following days or see others opinions, we don't need to make a decision
> today, so maybe there's still better way to go.

I thought of putting the caps on the configuration vmstate and using
that to set them on the destination, but there's a bit of a chicken and
egg problem because we need capabilities set as soon as
qemu_start_incoming_migration(). Unless we sent those via the cpr
channel. We could split migration_object_init() a bit so we can
instantiate some parts of the migration state earlier (I'm not even sure
what are the actual dependencies are).

