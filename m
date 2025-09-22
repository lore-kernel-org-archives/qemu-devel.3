Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D29CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 21:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0oIF-0006ZO-KU; Mon, 22 Sep 2025 17:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v0oIE-0006Z3-AY
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 17:41:54 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v0oIB-0008A0-OZ
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 17:41:54 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B13EA22A6E;
 Mon, 22 Sep 2025 21:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758577306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uG7JMTmr/OaQ5xr3ZNfYFw4ESbDLilbT+HMeN7L4RiY=;
 b=v17zIiw0KyrdvXBWIFiqfZtprFssi+MJAclZACcOuC3H1GxMKIvIDz0DwqPun9o8rYNhGx
 Sr/qLOoe5FoxCgL58fjpFEVv5QZuWEw8GkfHbKQ5vzjnuvtqLvNrAe3dRBXkv8jVt9zo8+
 xXiib55VZqNNMMh3Ui/+J3VX8MGyOp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758577306;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uG7JMTmr/OaQ5xr3ZNfYFw4ESbDLilbT+HMeN7L4RiY=;
 b=V4Q5bIHA7mTd/ieYNjFIElCoLPWkoVXrPuHcQM4X4XaE8CwA4s/xdWuiLOBRQSnnfBzbUs
 dUf1/S4p3oIXcjCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758577306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uG7JMTmr/OaQ5xr3ZNfYFw4ESbDLilbT+HMeN7L4RiY=;
 b=v17zIiw0KyrdvXBWIFiqfZtprFssi+MJAclZACcOuC3H1GxMKIvIDz0DwqPun9o8rYNhGx
 Sr/qLOoe5FoxCgL58fjpFEVv5QZuWEw8GkfHbKQ5vzjnuvtqLvNrAe3dRBXkv8jVt9zo8+
 xXiib55VZqNNMMh3Ui/+J3VX8MGyOp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758577306;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uG7JMTmr/OaQ5xr3ZNfYFw4ESbDLilbT+HMeN7L4RiY=;
 b=V4Q5bIHA7mTd/ieYNjFIElCoLPWkoVXrPuHcQM4X4XaE8CwA4s/xdWuiLOBRQSnnfBzbUs
 dUf1/S4p3oIXcjCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 272D81388C;
 Mon, 22 Sep 2025 21:41:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aRW9NZnC0Wg9EQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 22 Sep 2025 21:41:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v3 0/2] migration/tls: Graceful shutdowns for main and
 postcopy channels
In-Reply-To: <aNGvGDShRyBI80XK@x1.local>
References: <20250918203937.200833-1-peterx@redhat.com>
 <875xdfv4su.fsf@suse.de> <aMx9yi628fuXr_gH@x1.local>
 <871po2v9dr.fsf@suse.de> <aNGvGDShRyBI80XK@x1.local>
Date: Mon, 22 Sep 2025 18:41:43 -0300
Message-ID: <874isumag8.fsf@suse.de>
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
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
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

> On Fri, Sep 19, 2025 at 10:50:56AM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Thu, Sep 18, 2025 at 06:17:37PM -0300, Fabiano Rosas wrote:
>> >> > ============= ABOUT OLD PATCH 2 ===================
>> >> >
>> >> > I dropped it for now to unblock almost patch 1, because patch 1 will fix a
>> >> > real warning that can be triggered for not only qtest but also normal tls
>> >> > postcopy migration.
>> >> >
>> >> > While I was looking at temporary settings for multifd send iochannels to be
>> >> > blocking always, I found I cannot explain how migration_tls_channel_end()
>> >> > currently works, because it writes to the multifd iochannels while the
>> >> > channels should still be owned (and can be written at the same time?) by
>> >> > the sender threads.  It sounds like a thread-safety issue, or is it not?
>> >> >
>> >> 
>> >> IIUC, the multifd channels will be stuck at p->sem because this is the
>> >> success path so migration will have already finished when we reach
>> >> migration_cleanup(). The ram/device state migration will hold the main
>> >> thread until the multifd channels finish transferring.
>> >
>> > For success cases, indeed.  However this is not the success path?  After
>> > all, we check migration_has_failed().
>> >
>> 
>> My point is that when we reach here, if migration has succeeded, then it
>> should be ok. If not, then thread-safety doesn't matter because things
>> have already went bad, we'll lose the destination anyway.
>
> I'm not sure if it matters or not, maybe it depends on how bad it is when a
> race happened.
>
> If it's a tcp channel, it might be easier; the worst case is we write()
> concurrently in two threads and the output stream, IIUC, can be interleaved
> with the two buffers we write.  Not an issue if migration failed anyway.
>
> However this is only needed for TLS, hence I have no idea what happens if
> gnutls writes concurrently.  I don't think GnuTLS supports concurrent
> writters.  I'm not sure if it means there's still chance src QEMU (when
> having a failed live migration) can crash.
>
> So.. I still think it might be wise we only bye() after knowing it is a
> success, not only because that looks like the only way to make sure it's
> thread-safe, but also because a bye() is only needed if it didn't fail.
> Sending it ignoring error is another way of doing so, but it doesn't avoid
> the possible result of a race (even if I totally agree it is unlikely..).
>

ok

>> 
>> > Should I then send a patch to only send bye() when succeeded?  Then I can
>> > also add some comment.  I wished we could assert.  Then the "temporarily
>> > changing nonblock mode" will also rely on this one, because ideally we
>> > shouldn't touch the fd nonblocking mode if some other thread is operating
>> > on it.
>> >
>> 
>> I don't know if it changes much. Currently we basically always ignore
>> the error from bye().
>> 
>> > The other thing is I also think we shouldn't rely on checking
>> > "p->tls_thread_created && p->thread_created" but only rely on channel type,
>> > which might be more straightforward (I almost did it in v1, but v2 rewrote
>> > things so it was lost).
>> 
>> Ok, but we may need to ensure bye() is not called before the session is
>> initiated. So thread_created may still be needed?
>
> In v1, I was using "object_dynamic_cast((Object *)c, TYPE_QIO_CHANNEL_TLS)":
>
> https://lore.kernel.org/all/20250910160144.1762894-4-peterx@redhat.com/
>
> Would that work the same, but without relying on "thread_created"
> vars?

Ok, I'm convinced. migration_cleanup() -> multifd_send_shutdown() ->
bye() cannot happen before thread_create=true because
multifd_send_setup() blocks the migration_thread until the channels have
been fully created. Go ahead then!

