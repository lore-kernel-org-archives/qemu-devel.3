Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8A4C54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 19:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmfWP-0000EO-GQ; Tue, 19 Mar 2024 15:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmfWN-0000E8-Qd
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 15:53:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmfWL-0002Wv-Ug
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 15:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710877992;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ipNVNVh0PVDjyOfi/LUI7HBCeDThBHx/w871huSWljM=;
 b=FSp0GEmGutVV9IT6Rox2AGureLw6EyKpQyQRMsU396K/8U6df3UlTHR24V6bnzPgCY7/x2
 6TWkob3zZdD1YqRiCgkDGSq/fytVyQrHIO3HtBabetLZzFkF8SlmkjvLi4exFcHPLIELlN
 qELu7tHo7EEByBrN7o4fKm3UcMCmV7k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-neNn-DIEN369eViSdVJevQ-1; Tue,
 19 Mar 2024 15:53:10 -0400
X-MC-Unique: neNn-DIEN369eViSdVJevQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3901A3C0D7C1;
 Tue, 19 Mar 2024 19:53:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 70C4F40C6DB5;
 Tue, 19 Mar 2024 19:53:09 +0000 (UTC)
Date: Tue, 19 Mar 2024 19:52:47 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC PATCH v3 3/3] migration: Add fd to FileMigrationArgs
Message-ID: <ZfntD00Mz3i9vOky@redhat.com>
References: <20240315032040.7974-1-farosas@suse.de>
 <20240315032040.7974-4-farosas@suse.de>
 <ZfQNDv--4BnN5zYx@redhat.com> <ZfRxwml7m0DQVO2b@x1n>
 <87y1aj74t6.fsf@suse.de> <ZfS1g8YvZ7if9j5M@x1n>
 <Zfm8fCqyNMfkq9Jw@redhat.com> <Zfnmni5bZ7q_UQcx@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zfnmni5bZ7q_UQcx@x1n>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

On Tue, Mar 19, 2024 at 03:25:18PM -0400, Peter Xu wrote:
> On Tue, Mar 19, 2024 at 04:25:32PM +0000, Daniel P. Berrangé wrote:
> > On Fri, Mar 15, 2024 at 04:54:27PM -0400, Peter Xu wrote:
> > > On Fri, Mar 15, 2024 at 03:01:09PM -0300, Fabiano Rosas wrote:
> > > > Peter Xu <peterx@redhat.com> writes:
> > > > 
> > > > > [I queued patch 1-2 into -stable, leaving this patch for further
> > > > >  discussions]
> > > > >
> > > > > On Fri, Mar 15, 2024 at 08:55:42AM +0000, Daniel P. Berrangé wrote:
> > > > >> The 'file:' protocol eventually calls into qemu_open, and this
> > > > >> transparently allows for FD passing using /dev/fdset/NNN syntax
> > > > >> to pass in FDs. 
> > > > >
> > > > > If it always use /dev/fdsets for files, does it mean that the newly added
> > > > > SOCKET_ADDRESS_TYPE_FD support on mapped-ram will never be used (so we can
> > > > > drop them)?
> > > > 
> > > > We already have SOCKET_ADDRESS_TYPE_FD + file since 8.2 when the
> > > > MigrationAddress was added. So this:
> > > > 
> > > > 'channels': [ { 'channel-type': 'main',
> > > >                 'addr': { 'transport': 'socket',
> > > >                 'type': 'fd',
> > > >                 'str': 'fdname' } } ]
> > > > 
> > > > works without multifd and without mapped-ram if the fd is a file or
> > > > socket.
> > > > 
> > > > So yes, you're correct, but given we already have this^ it would be
> > > > perhaps more confusing for users to allow it, but not allow the very
> > > > same JSON when multifd=true, mapped-ram=true.
> > > 
> > > I don't think the fd: protocol (no matter the old "fd:", or the new JSON
> > > format) is trivial to use. If libvirt didn't use it I won't be surprised to
> > > see nobody using it.  I want us to avoid working on things that nobody is
> > > using, or has a better replacement.
> > > 
> > > So even if Libvirt supports both, I'm wondering whether /dev/fdset/ works
> > > for all the cases that libvirt needs.  I am aware that the old getfd has
> > > the monitor limitation so that if the QMP disconnected and reconnect, the
> > > fd can be gone.  However I'm not sure whether that's the only reason to
> > > have add-fd, and also not sure whether it means add-fd is always preferred,
> > > so that maybe we can consider obsolete getfd?
> > 
> > Historically libvirt primariily uses the 'fd:' protocol, with a
> > socket FD. It never gives QEMU a plain file FD, since it has
> > always added its "iohelper" as a MITM, in order to add O_DIRECT
> > on top.
> > 
> > The 'getfd' command is something that is needed when talking to
> > QEMU for any API that involves a "SocketAddress" QAPI type,
> > which is applicable for migration.
> > 
> > With the introduction of 'MigrationAddress', the 'socket' protocol
> > is backed by 'SocketAddress' and thus supports FD passing for
> > sockets (or potentally pipes too), in combination with 'getfd'.
> > 
> > With the 'file' protocol in 'MigrationAddress', since it gets
> > backed by qemu_open(), then /dev/fdset/NN and 'add-fd' provide
> > passing for plain files.
> 
> I see.  I assume it means we still have multiple users of getfd so it's
> still in use where add-fd is not yet avaiable.
> 
> But then, SOCKET_ADDRESS_TYPE_FD is then not used for libvirt in the whole
> mapped-ram effort, neither do we need any support on file migrations over
> "fd", e.g. fd_start_incoming_migration() for files. So we can drop these
> parts, am I right?

Correct, libvirt hasn't got any impl for 'mapped-ram' yet, at least
not something merged.

Since this is new functionality, libvirt could go straight for the
'file' protocol / address type.

At some point I think we can stop using 'fd' for traditional migration
too and pass the socket address to QEMU and let QEMU open the socket.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


