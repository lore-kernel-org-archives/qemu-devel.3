Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C94ECAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 13:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbWI-0007S2-Te; Fri, 19 Sep 2025 09:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uzbWG-0007RK-1A
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 09:51:24 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uzbW3-0001AX-JS
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 09:51:22 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 19F541F7E0;
 Fri, 19 Sep 2025 13:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758289860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J13kma0PSYLA2u2dd0h85y1DFHmxQHfrKz3I2TWF4Tg=;
 b=lW7bzsI2FeMWYl3CDjqpmjCFPHydlq5YINoJHL4x/iz/u6r3KUWJzxYVKQqFKdfFyy1/su
 ySQ6Y/m3PYlYl+s3loyZwYw8cocD4t+O56oPJkQPAA+kCzhILQLsOMGDD6JN7YS0fK6+92
 Faa1/lxZ/mpPRQW48fXQJgrQPOjuTog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758289860;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J13kma0PSYLA2u2dd0h85y1DFHmxQHfrKz3I2TWF4Tg=;
 b=gPv1oxWOmLdu5om7oFc73ydZNpCIJSN/43vUz+OKUFLNxCcV+5xRXDZSUmL00YqvrJvkdX
 nHvsZ/8lXKBxAPAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lW7bzsI2;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gPv1oxWO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758289860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J13kma0PSYLA2u2dd0h85y1DFHmxQHfrKz3I2TWF4Tg=;
 b=lW7bzsI2FeMWYl3CDjqpmjCFPHydlq5YINoJHL4x/iz/u6r3KUWJzxYVKQqFKdfFyy1/su
 ySQ6Y/m3PYlYl+s3loyZwYw8cocD4t+O56oPJkQPAA+kCzhILQLsOMGDD6JN7YS0fK6+92
 Faa1/lxZ/mpPRQW48fXQJgrQPOjuTog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758289860;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J13kma0PSYLA2u2dd0h85y1DFHmxQHfrKz3I2TWF4Tg=;
 b=gPv1oxWOmLdu5om7oFc73ydZNpCIJSN/43vUz+OKUFLNxCcV+5xRXDZSUmL00YqvrJvkdX
 nHvsZ/8lXKBxAPAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F89813A39;
 Fri, 19 Sep 2025 13:50:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iHBuFMNfzWgrHQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 19 Sep 2025 13:50:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v3 0/2] migration/tls: Graceful shutdowns for main and
 postcopy channels
In-Reply-To: <aMx9yi628fuXr_gH@x1.local>
References: <20250918203937.200833-1-peterx@redhat.com>
 <875xdfv4su.fsf@suse.de> <aMx9yi628fuXr_gH@x1.local>
Date: Fri, 19 Sep 2025 10:50:56 -0300
Message-ID: <871po2v9dr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 19F541F7E0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> On Thu, Sep 18, 2025 at 06:17:37PM -0300, Fabiano Rosas wrote:
>> > ============= ABOUT OLD PATCH 2 ===================
>> >
>> > I dropped it for now to unblock almost patch 1, because patch 1 will fix a
>> > real warning that can be triggered for not only qtest but also normal tls
>> > postcopy migration.
>> >
>> > While I was looking at temporary settings for multifd send iochannels to be
>> > blocking always, I found I cannot explain how migration_tls_channel_end()
>> > currently works, because it writes to the multifd iochannels while the
>> > channels should still be owned (and can be written at the same time?) by
>> > the sender threads.  It sounds like a thread-safety issue, or is it not?
>> >
>> 
>> IIUC, the multifd channels will be stuck at p->sem because this is the
>> success path so migration will have already finished when we reach
>> migration_cleanup(). The ram/device state migration will hold the main
>> thread until the multifd channels finish transferring.
>
> For success cases, indeed.  However this is not the success path?  After
> all, we check migration_has_failed().
>

My point is that when we reach here, if migration has succeeded, then it
should be ok. If not, then thread-safety doesn't matter because things
have already went bad, we'll lose the destination anyway.

> Should I then send a patch to only send bye() when succeeded?  Then I can
> also add some comment.  I wished we could assert.  Then the "temporarily
> changing nonblock mode" will also rely on this one, because ideally we
> shouldn't touch the fd nonblocking mode if some other thread is operating
> on it.
>

I don't know if it changes much. Currently we basically always ignore
the error from bye().

> The other thing is I also think we shouldn't rely on checking
> "p->tls_thread_created && p->thread_created" but only rely on channel type,
> which might be more straightforward (I almost did it in v1, but v2 rewrote
> things so it was lost).

Ok, but we may need to ensure bye() is not called before the session is
initiated. So thread_created may still be needed?

