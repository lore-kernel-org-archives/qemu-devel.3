Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DD7C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 09:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXGi0-0003sN-LC; Thu, 03 Jul 2025 05:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uXGhj-0003ql-Kn
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:58:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uXGhh-0002el-6e
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751536682;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eu3f8TKUDSobiZb8drjff43yb7OuQF6VYWaMZbEUE08=;
 b=QLjtVyhCbVh4ptEgLLhDcWRHZUpKw+hGuaKtVpOseqTiSQ8ihkbIe93zUltJqCfU7zQybw
 sWw1LpW426WEbbO23pQnlTAFAZx3Rjuuhjs6WlL88ld4xF8ByFu88439eQOsmhSO2a5Unr
 Zo+RY5nqfi9qxbqTvNlNuVmGauubaKg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-eEWgvv3SPgi2a21nvAAgtQ-1; Thu,
 03 Jul 2025 05:58:00 -0400
X-MC-Unique: eEWgvv3SPgi2a21nvAAgtQ-1
X-Mimecast-MFC-AGG-ID: eEWgvv3SPgi2a21nvAAgtQ_1751536679
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7C7F1956096; Thu,  3 Jul 2025 09:57:59 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.49])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F4023000218; Thu,  3 Jul 2025 09:57:57 +0000 (UTC)
Date: Thu, 3 Jul 2025 10:57:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Daniel Kahn Gillmor <dkg@fifthhorseman.net>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] Socket activation: enable spice listener.
Message-ID: <aGZUIXcw5oKPy6Ue@redhat.com>
References: <20250627180331.1370235-1-dkg@fifthhorseman.net>
 <20250627180331.1370235-3-dkg@fifthhorseman.net>
 <aGOsek0xeyXk3G6y@redhat.com> <871pqz6b8i.fsf@fifthhorseman.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871pqz6b8i.fsf@fifthhorseman.net>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Jul 01, 2025 at 02:02:05PM -0400, Daniel Kahn Gillmor wrote:
> On Tue 2025-07-01 10:38:02 +0100, Daniel P. Berrangé wrote:
> > Primarily this comes down to having logic present in the socket_get_fd
> > method, such that when there is no current monitor, we use the systemd
> > named sockets.
> 
> I'm not sure how the monitor plays a role here.  Are you talking about
> having a socket-activated monitor specifically, or do you see the
> monitor playing some special role in socket activation beyond just being
> yet another file descriptor that might be passed in via systemd-style
> supervision?  why wouldn't it be OK to have a monitor *and* use systemd
> named sockets? Looking at socket_get_fd, i see that it's resolving the
> fdstr differently if there is a current monitor; is that codepath only
> active after all command-line arguments have been processed?

The monitor is involved in so much as the socket_get_fd() method
is what internal QEMU code uses to resolve FD names into FD numbers.

The first thing it does is check whether the caller is runing in
the context of a monitor command. If so, it resolves FD names using
the monitor, otherwise it'll assume an FD has been passed in by the
parent process.  The latter codepath is the one we need to enhance
to use systemd named FDs. Essentially this latter codepath will only
run during initial QEMU startup, as at runtimne, all callers will
be in the context of the monitor.

> > We should also have logic to validate that we have consumed all
> > systemd sockets, before we move out of startup phase, in order to
> > detect config errors. This indicates should we proactively parse
> > the socket activation env at starutp and record all FDs, and keep
> > track of which are consumed by the config.
> 
> Could you be a bit more specific about how the "startup phase" is
> delimited within the codebase?  I'd be happy to try to build out
> something similar to what you describe here, if you think that would be
> useful.  I'd want to make sure i place the check for all passed file
> descriptors being accounted for in the right place.

In system/vl.c  the 'qemu_init' method takes care of system
startup - so at the very end of that method we should check
for unclaimed FDs.

> > And then there are some hard questions about how we integrate this with
> > the various helper programs like qemu-nbd, and friends, which all
> > already support systemd socket activation but fail to validate the
> > names, making it hard to add propert support while retaining back compat.
> 
> Understood -- from looking at the sources i think that means this
> specific list of four helper programs:
> 
>  - qemu-nbd (network block device server)
>  - qemu-ga (the qemu guest agent)
>  - qemu-pr-helper (qemu SCSI persistent reservation helper)
>  - qemu-vmsr-helper (i386 only?)
> 
> all of these processes currently just accept a single listening socket,
> and ignore the names.  They all abort if they are passed more than one
> socket via systemd-style supervision.  With the exception of qga, they
> all abort with an error if they are passed listener configuration
> information while also being launched under systemd-style supervision
> with a socket.
> 
> I don't see this narrow scope of functionality as being a difficult to
> maintain for backward-compatibility.
> 
> We can simply offer a mechanism that these tools can use with the
> semantics of "if only one socket-activated listener, claim it".
> 
> As far as i can tell, none of these four helper daemons is designed to
> listen on more than one socket anyway.

Well that's their current impl, but conceptually it is interesting
to be able to listen on multiple sockets, so that machines with
multiple public facing IP addresses can be made to listen on a
selection of IPs, instead of the wildcard address, or a single
address. So it is an interesting facility to gain if it is easy.

>    The idea is that rather than just being able to pass a file
>    descriptor by name anywhere that you can pass a file descriptor by
>    number, qemu could use the name of the file descriptor to decide what
>    to do with it.
> 
>    So, for example, rather than running:
> 
>       qemu -chardev socket,id=foo,opt=123,server=on ...
> 
>    the administrator could set up a systemd .socket file with:
> 
>       FileDescriptorName=id=foo,opt=123
> 
>    and have the corresponding systemd .service file would launch:
> 
>       ExecStart=/usr/bin/qemu ...
> 
>    One of the logistical challenges for that is that the colon (":")
>    isn't permitted in FileDescriptorName, and some qemu options might
>    want a colon in them.  And, this approach with -chardev doesn't
>    necessarily translate well to all the various places that might also
>    want a file descriptor (e.g. -incoming, -object, -spice, etc).
> 
>    So like i said, probably too radical, but i thought i'd mention it.

It gets even more troublesome when we consider our long term direction
is to support JSON documents for command line args. The plain FD names
are a good decoupling of CLI syntax from the service manager.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


