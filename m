Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D2CC47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 19:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUXho-0004qY-9p; Mon, 29 Jan 2024 14:54:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rUXhk-0004qE-PF
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 14:54:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rUXhi-0008UB-1t
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 14:54:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706558040;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=psFZ6BVihfnvKkp7BogxDmMySxqqOe5ltqcFQdEIo68=;
 b=emrcxc+O1FvwVGkzAo9uxtlI0wUIlxZcCW899EnsEcMyp2FFS/XDg0u7sRpwWJxeji+PHq
 +tldyhQReXKrRzaOd+JdmuDJgmK4mX3HhooBeksszXUjThITEi6P90THAMhTvmVvzHOzju
 ngMfrkffXdSoD1afdgKRHUZ1lFt2V1k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-5dnmvYXuOKy-9E8l3m2UDw-1; Mon, 29 Jan 2024 14:53:58 -0500
X-MC-Unique: 5dnmvYXuOKy-9E8l3m2UDw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4015385A58B
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 19:53:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D9F83492BE2;
 Mon, 29 Jan 2024 19:53:56 +0000 (UTC)
Date: Mon, 29 Jan 2024 19:53:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Harivel <aharivel@redhat.com>, mtosatti@redhat.com,
 qemu-devel@nongnu.org, vchundur@redhat.com
Subject: Re: [PATCH v3 2/3] tools: build qemu-vmsr-helper
Message-ID: <ZbgCUpVTYg9VU4b-@redhat.com>
References: <20240125072214.318382-1-aharivel@redhat.com>
 <20240125072214.318382-3-aharivel@redhat.com>
 <Zbf0Fbhmg0tvMbxK@redhat.com>
 <CABgObfaRGL8eOs6NRBjEMjTa_7UGyAn+Pic2GP=XbE+Qg-oBCQ@mail.gmail.com>
 <ZbgAb3m6-rwUFxOO@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbgAb3m6-rwUFxOO@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
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

On Mon, Jan 29, 2024 at 07:45:51PM +0000, Daniel P. Berrangé wrote:
> On Mon, Jan 29, 2024 at 08:33:21PM +0100, Paolo Bonzini wrote:
> > On Mon, Jan 29, 2024 at 7:53 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > > diff --git a/meson.build b/meson.build
> > > > index d0329966f1b4..93fc233b0891 100644
> > > > --- a/meson.build
> > > > +++ b/meson.build
> > > > @@ -4015,6 +4015,11 @@ if have_tools
> > > >                 dependencies: [authz, crypto, io, qom, qemuutil,
> > > >                                libcap_ng, mpathpersist],
> > > >                 install: true)
> > > > +
> > > > +    executable('qemu-vmsr-helper', files('tools/i386/qemu-vmsr-helper.c'),
> > >
> > > I'd suggest 'tools/x86/' since this works fine on 64-bit too
> > 
> > QEMU tends to use i386 in the source to mean both 32- and 64-bit.
> 
> One day we should rename that to x86 too :-)
> 
> > > You never answered my question from the previous posting of this
> > >
> > > This check is merely validating the the thread ID in the message
> > > is a child of the process ID connected to the socket. Any process
> > > on the entire host can satisfy this requirement.
> > >
> > > I don't see what is limiting this to only QEMU as claimed by the
> > > commit message, unless you're expecting the UNIX socket permissions
> > > to be such that only processes under the qemu:qemu user:group pair
> > > can access to the socket ? That would be a libvirt based permissions
> > > assumption though.
> > 
> > Yes, this is why the systemd socket uses 600, like
> > contrib/systemd/qemu-pr-helper.socket. The socket can be passed via
> > SCM_RIGHTS by libvirt, or its permissions can be changed (e.g. 660 and
> > root:kvm would make sense on a Debian system), or a separate helper
> > can be started by libvirt.
> > 
> > Either way, the policy is left to the user rather than embedding it in
> > the provided systemd unit.
> 
> Ok, this code needs a comment to explain that we're relying on
> socket permissions to control who/what can access the daemon,
> combined with this PID+TID check to validate it is not spoofing
> its identity, as without context the TID check looks pointless.

Looking again, the TID is never used after being checked. QEMU sends
the TID, but the helper never does anything with this information
except to check the TID belongs the PID.  Why are we sending the TID ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


