Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010CDC27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 17:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGj5w-0001AA-VO; Mon, 10 Jun 2024 13:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sGj5r-00018n-4T
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:46:09 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sGj5n-0007kr-EX
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:46:06 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4391B21FF2;
 Mon, 10 Jun 2024 17:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718041557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O7lPH/I24c+XhF5BkUQ7dnzU1V7TI1Wxgx1FgEO7WDI=;
 b=a3vEMmrGMgT2LH1sghUQ+lokNfq69UDPcwEzB0vU+LHNhtom1n7etecKCtyrkNh6OYX7HZ
 ifjiVbfpmWZY1AkoQ50jB4Es2m4BGODAj8ajGul+IKfHYH1zclpXOmnEgRF2mumu77xZYD
 UnzS9D05AbYhMpuXpzGAHJ3FacMwtYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718041557;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O7lPH/I24c+XhF5BkUQ7dnzU1V7TI1Wxgx1FgEO7WDI=;
 b=gZuWPbLvyBtefVvN2FC4byXEeges8pptN2FzGvXyzjJzCT5vzcObwtPAHtNzTQjLP5uYM3
 1y1Qy4FZbQCQxmCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=a3vEMmrG;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gZuWPbLv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718041557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O7lPH/I24c+XhF5BkUQ7dnzU1V7TI1Wxgx1FgEO7WDI=;
 b=a3vEMmrGMgT2LH1sghUQ+lokNfq69UDPcwEzB0vU+LHNhtom1n7etecKCtyrkNh6OYX7HZ
 ifjiVbfpmWZY1AkoQ50jB4Es2m4BGODAj8ajGul+IKfHYH1zclpXOmnEgRF2mumu77xZYD
 UnzS9D05AbYhMpuXpzGAHJ3FacMwtYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718041557;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O7lPH/I24c+XhF5BkUQ7dnzU1V7TI1Wxgx1FgEO7WDI=;
 b=gZuWPbLvyBtefVvN2FC4byXEeges8pptN2FzGvXyzjJzCT5vzcObwtPAHtNzTQjLP5uYM3
 1y1Qy4FZbQCQxmCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B323A13A7F;
 Mon, 10 Jun 2024 17:45:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oX5WHtQ7Z2ZXfQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 10 Jun 2024 17:45:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Claudio
 Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 18/18] migration/ram: Add direct-io support to
 precopy file migration
In-Reply-To: <ZmclVQw0x7KKLxmF@x1n>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-19-farosas@suse.de> <Zl9_ZiC6-743ZosG@x1n>
 <87y17gwq5g.fsf@suse.de> <ZmclVQw0x7KKLxmF@x1n>
Date: Mon, 10 Jun 2024 14:45:53 -0300
Message-ID: <87r0d4wv1q.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4391B21FF2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[9]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

> On Fri, Jun 07, 2024 at 03:42:35PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Thu, May 23, 2024 at 04:05:48PM -0300, Fabiano Rosas wrote:
>> >> We've recently added support for direct-io with multifd, which brings
>> >> performance benefits, but creates a non-uniform user interface by
>> >> coupling direct-io with the multifd capability. This means that users
>> >> cannot keep the direct-io flag enabled while disabling multifd.
>> >> 
>> >> Libvirt in particular already has support for direct-io and parallel
>> >> migration separately from each other, so it would be a regression to
>> >> now require both options together. It's relatively simple for QEMU to
>> >> add support for direct-io migration without multifd, so let's do this
>> >> in order to keep both options decoupled.
>> >> 
>> >> We cannot simply enable the O_DIRECT flag, however, because not all IO
>> >> performed by the migration thread satisfies the alignment requirements
>> >> of O_DIRECT. There are many small read & writes that add headers and
>> >> synchronization flags to the stream, which at the moment are required
>> >> to always be present.
>> >> 
>> >> Fortunately, due to fixed-ram migration there is a discernible moment
>> >> where only RAM pages are written to the migration file. Enable
>> >> direct-io during that moment.
>> >> 
>> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> >
>> > Is anyone going to consume this?  How's the performance?
>> 
>> I don't think we have a pre-determined consumer for this. This came up
>> in an internal discussion about making the interface simpler for libvirt
>> and in a thread on the libvirt mailing list[1] about using O_DIRECT to
>> keep the snapshot data out of the caches to avoid impacting the rest of
>> the system. (I could have described this better in the commit message,
>> sorry).
>> 
>> Quoting Daniel:
>> 
>>   "Note the reason for using O_DIRECT is *not* to make saving / restoring
>>    the guest VM faster. Rather it is to ensure that saving/restoring a VM
>>    does not trash the host I/O / buffer cache, which will negatively impact
>>    performance of all the *other* concurrently running VMs."
>> 
>> 1- https://lore.kernel.org/r/87sez86ztq.fsf@suse.de
>> 
>> About performance, a quick test on a stopped 30G guest, shows
>> mapped-ram=on direct-io=on it's 12% slower than mapped-ram=on
>> direct-io=off.
>
> Yes, this makes sense.
>
>> 
>> >
>> > It doesn't look super fast to me if we need to enable/disable dio in each
>> > loop.. then it's a matter of whether we should bother, or would it be
>> > easier that we simply require multifd when direct-io=on.
>> 
>> AIUI, the issue here that users are already allowed to specify in
>> libvirt the equivalent to direct-io and multifd independent of each
>> other (bypass-cache, parallel). To start requiring both together now in
>> some situations would be a regression. I confess I don't know libvirt
>> code to know whether this can be worked around somehow, but as I said,
>> it's a relatively simple change from the QEMU side.
>
> Firstly, I definitely want to already avoid all the calls to either
> migration_direct_io_start() or *_finish(), now we already need to
> explicitly call them in three paths, and that's not intuitive and less
> readable, just like the hard coded rdma codes.

Right, but that's just a side-effect of how the code is structured and
the fact that writes to the stream happen in small chunks. Setting
O_DIRECT needs to happen around aligned IO. We could move the calls
further down into qemu_put_buffer_at(), but that would be four fcntl()
calls for every page.

A tangent:
 one thing that occured to me now is that we may be able to restrict
 calls to qemu_fflush() to internal code like add_to_iovec() and maybe
 use that function to gather the correct amount of data before writing,
 making sure it disables O_DIRECT in case alignment is about to be
 broken?

>
> I also worry we may overlook the complexity here, and pinning buffers
> definitely need more thoughts on its own.  It's easier to digest when using
> multifd and when QEMU only pins guest pages just like tcp-zerocopy does,
> which are naturally host page size aligned, and also guaranteed to not be
> freed (while reused / modified is fine here, as dirty tracking guarantees a
> new page will be migrated soon again).

I don't get this at all, sorry. What is different from multifd here?
We're writing on the same HVA as the one that would be given to multifd
(if it were enabled) and dirty tracking is working the same.

> IMHO here the "not be freed / modified" is even more important than
> "alignment": the latter is about perf, the former is about correctness.
> When we do directio on random buffers, AFAIU we don't want to have the
> buffer modified before flushed to disk, and that's IMHO not easy to
> guarantee.
>
> E.g., I don't think this guarantees a flush on the buffer usages:
>
>   migration_direct_io_start()
>     /* flush any potentially unaligned IO before setting O_DIRECT */
>     qemu_fflush(file);
>
> qemu_fflush() internally does writev(), and that "flush" is about "flushing
> qemufile iov[] to fd", not "flushing buffers to disk".  I think it means
> if we do qemu_fflush() then we modify QEMUFile.buf[IO_BUF_SIZE] we're
> doomed: we will never know whether dio has happened, and which version of
> buffer will be sent; I don't think it's guaranteed it will always be the
> old version of the buffer.
>
> However the issue is, QEMUFile defines qemu_fflush() as: after call, the
> buf[] can be reused!  It suggests breaking things I guess in dio context.

I think you're mixing the usage of qemu_put_byte()/qemu_put_buffer()
with the usage of qemu_put_buffer_at(). The former two use the
QEMUFile.buf without O_DIRECT and the latter writes directly to the fd
at the page offset. So there's no issue in reusing buf before writes
have reached the disk. All writes going through buf are serialized and
all writes going through qio_channel_pwrite() go to a different offset.

I included all of these assert(!f->dio) to ensure that we don't use the
two APIs incorrectly. Mainly that we don't try to write to buf while
O_DIRECT is set.

>
> IIUC currently mapped-ram is ok because mapped-ram is just special that it
> doesn't have page headers, so it doesn't use the buf[] during iterations;
> while for zeropage it uses file_bmap bitmap and that's separate too and
> does not generate any byte on the wire either.

Right. This is all mapped-ram. I'm not proposing to enable O_DIRECT for
any migration.

>
> xbzrle could use that buf[], but maybe mapped-ram doesn't work anyway with
> xbzrle.
>
> Everything is just very not obvious and tricky to me.  This still looks
> pretty dangerous to me.  Would migration_direct_io_finish() guarantee
> something like a fdatasync()?  If so it looks safer, but still within the
> start() and finish() if someone calls qemu_fflush() and reuse the buffer we
> can still get hard to debug issues (as the outcome would be that we saw
> corrupted migration files).
>
>> 
>> Another option which would be for libvirt to keep using multifd, but
>> make it 1 channel only if --parallel is not specified. That might be
>> enough to solve the interface issues. Of course, it's a different code
>> altogether than the usual precopy code that gets executed when
>> multifd=off, I don't know whether that could be an issue somehow.
>
> Would there be any comment from Libvirt side?  This sounds like a good
> solution if my above concern is real; as long as we always stick dio with
> guest pages we'll be all fine.
>
> Thanks,

