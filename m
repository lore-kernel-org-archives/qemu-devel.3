Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8905C54E41
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 21:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhFUd-0004Lc-5f; Mon, 04 Mar 2024 16:05:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rhFUb-0004Kf-9d
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 16:05:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rhFUZ-0005HH-8d
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 16:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709586298;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T03ZhoNf+ZhDOl/wx1tzj9m6pmyuSVyHXnxeh+xRdJ4=;
 b=fdQKu/ZcJ4fA4ZrtBOUe/3+vGR5dS47OuW6gc3U2zUbsxUm+KRgBfHreNJntWBSoin5PYK
 exs6yrK7siysie/S+UW3M00da9s0EJdZjPFhgnJaozZRvEKeKfYF0hXJEm7hQ4T+O+Nxbo
 o9m34MX6DldP9EnV/A8vzK8yRy4OtjA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-NyvXzgQDMoatYTgorp7EHg-1; Mon, 04 Mar 2024 16:04:54 -0500
X-MC-Unique: NyvXzgQDMoatYTgorp7EHg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F7FF1064DA4;
 Mon,  4 Mar 2024 21:04:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 362EA492BE2;
 Mon,  4 Mar 2024 21:04:53 +0000 (UTC)
Date: Mon, 4 Mar 2024 21:04:51 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v6 00/23] migration: File based migration with multifd
 and mapped-ram
Message-ID: <ZeY3c-zFV-i1mrrP@redhat.com>
References: <20240229153017.2221-1-farosas@suse.de> <ZeXAGEVFWt4Z8QeN@x1n>
 <ZeXBsR0ctl4evdYb@redhat.com> <ZeXEROyMmHffj1b2@x1n>
 <ZeXIoVho09HtXKQQ@x1n> <87r0gp21py.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r0gp21py.fsf@suse.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 04, 2024 at 05:15:05PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Mar 04, 2024 at 08:53:24PM +0800, Peter Xu wrote:
> >> On Mon, Mar 04, 2024 at 12:42:25PM +0000, Daniel P. Berrangé wrote:
> >> > On Mon, Mar 04, 2024 at 08:35:36PM +0800, Peter Xu wrote:
> >> > > Fabiano,
> >> > > 
> >> > > On Thu, Feb 29, 2024 at 12:29:54PM -0300, Fabiano Rosas wrote:
> >> > > > => guest: 128 GB RAM - 120 GB dirty - 1 vcpu in tight loop dirtying memory
> >> > > 
> >> > > I'm curious normally how much time does it take to do the final fdatasync()
> >> > > for you when you did this test.
> 
> I measured and it takes ~4s for the live migration and ~2s for the
> non-live. I didn't notice this before because the VM goes into
> postmigrate, so it's paused anyway.
> 
> >> > > 
> >> > > I finally got a relatively large system today and gave it a quick shot over
> >> > > 128G (100G busy dirty) mapped-ram snapshot with 8 multifd channels.  The
> >> > > migration save/load does all fine, so I don't think there's anything wrong
> >> > > with the patchset, however when save completes (I'll need to stop the
> >> > > workload as my disk isn't fast enough I guess..) I'll always hit a super
> >> > > long hang of QEMU on fdatasync() on XFS during which the main thread is in
> >> > > UNINTERRUPTIBLE state.
> >> > 
> >> > That isn't very surprising. If you don't have O_DIRECT enabled, then
> >> > all that disk I/O from the migrate is going to be in RAM, and thus the
> >> > fdatasync() is likely to trigger writing out alot of data.
> >> > 
> >> > Blocking the main QEMU thread though is pretty unhelpful. That suggests
> >> > the data sync needs to be moved to a non-main thread.
> >> 
> >> Perhaps migration thread itself can also be a candidate, then.
> >> 
> >> > 
> >> > With O_DIRECT meanwhile there should be essentially no hit from fdatasync.
> >> 
> >> The update of COMPLETED status can be a good place of a marker point to
> >> show such flush done if from the gut feeling of a user POV.  If that makes
> >> sense, maybe we can do that sync before setting COMPLETED.
> 
> At the migration completion I believe the multifd threads will have
> already cleaned up and dropped the reference to the channel, it might be
> too late then.
> 
> In the multifd threads, we'll be wasting (like we are today) the extra
> syscalls after the first sync succeeds.
> 
> >> 
> >> No matter which thread does that sync, it's still a pity that it'll go into
> >> UNINTERRUPTIBLE during fdatasync(), then whoever wants to e.g. attach a gdb
> >> onto it to have a look will also hang.
> >
> > Or... would it be nicer we get rid of the fdatasync() but leave that for
> > upper layers?  QEMU used to support file: migration already, it never
> > manage cache behavior; it does smell like something shouldn't be done in
> > QEMU when thinking about it, at least mapped-ram is nothing special to me
> > from this regard.
> >
> > User should be able to control that either manually (sync), or Libvirt can
> > do that after QEMU quits; after all Libvirt holds the fd itself?  It should
> > allow us to get rid of above UNINTERRUPTIBLE / un-debuggable period of QEMU
> > went away.  Another side benefit: rather than holding all of QEMU resources
> > (especially, guest RAM) when waiting for a super slow disk flush, Libvirt /
> > upper layer can do that separately after releasing all the QEMU resources
> > first.
> 
> I like the idea of QEMU having a self-contained
> implementation. Specially since we'll add O_DIRECT support, which is
> already quite heavy-handed if we're talking about managing cache
> behavior.
> 
> However, it's not trivial to find the right place to add the sync.
> Wherever we put it there will be some implications, such as ensuring the
> sync works even after migration failure, avoiding concurrent cleanup,
> etc.
> 
> In any case, I don't think it's correct to have the sync at
> qio_channel_close(), now that we've seen it might block for a long
> time. We could at the very least have a qio_channel_flush()[1] which the
> QIOChannelFile implements with fdatasync(). Then the clients can choose
> when to sync.

Yes, I agree with de-coupling it.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


