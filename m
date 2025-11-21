Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD58CFC504
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcxa-0002fO-7Y; Fri, 21 Nov 2025 21:02:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vMcB8-0007DM-SP
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:12:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vMcAx-0004xC-19
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763773933;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=P4NxXTDRiWe6iZUoA3bppHcb6EEGrWyTpkU1pvcMxcM=;
 b=XwCFc6GCwf9RF4xqsdnx2Srwtuq2zjve0TFFtOYU5ErLhlYuA8BeiDU/wwXulK0x1zZ58T
 UBe6Kr4bghLwfoUYoIOC3SDbiFa9FNeJxR/+GGdldvWz2/WSacK3WNEjUaPpGkfZLeVMx4
 7ZeHL6s5V2j4oHtGdum4ph+sKeW2m4Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-FXZ77TMePRin77aD4SXS5A-1; Fri,
 21 Nov 2025 11:54:31 -0500
X-MC-Unique: FXZ77TMePRin77aD4SXS5A-1
X-Mimecast-MFC-AGG-ID: FXZ77TMePRin77aD4SXS5A_1763744070
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5E5B1956096; Fri, 21 Nov 2025 16:54:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.184])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BFE741940E82; Fri, 21 Nov 2025 16:54:26 +0000 (UTC)
Date: Fri, 21 Nov 2025 16:54:23 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Ben Chaney <bchaney@akamai.com>, farosas@suse.de, armbru@redhat.com,
 mark.kanda@oracle.com, qemu-devel@nongnu.org, johunt@akamai.com,
 mtottenh@akamai.com, nhudson@akamai.com
Subject: Re: [PATCH] migration: cpr socket permissions fix
Message-ID: <aSCZP_mkjYD7e7nP@redhat.com>
References: <20251120185733.141912-1-bchaney@akamai.com>
 <aSCOVNMJ-NK_9PuH@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aSCOVNMJ-NK_9PuH@x1.local>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

On Fri, Nov 21, 2025 at 11:07:48AM -0500, Peter Xu wrote:
> On Thu, Nov 20, 2025 at 01:57:33PM -0500, Ben Chaney wrote:
> > Fix an issue where cpr transfer fails when running with the
> > -run-with user=$USERID with a permission denied error. This issue
> > occurs because the destination host creates the transfer sockets before
> > it drops permissions while the source host tries to connect after
> > dropping permissions. Fix this by changing the ownership of the cpr
> > socket to the lower level so it is accessible to both parties.
> > 
> > Resolves: https://lore.kernel.org/all/3D32B62F-29E2-4470-86A5-9A2B3B29E371@akamai.com/
> > Signed-off-by: Ben Chaney <bchaney@akamai.com>
> > ---
> >  include/system/os-posix.h |  1 +
> >  include/system/os-wasm.h  |  1 +
> >  include/system/os-win32.h |  1 +
> >  os-posix.c                | 12 ++++++++++++
> >  stubs/meson.build         |  1 +
> >  stubs/os-file.c           |  6 ++++++
> >  util/qemu-sockets.c       |  6 ++++++
> >  7 files changed, 28 insertions(+)
> >  create mode 100644 stubs/os-file.c
> > 
> > diff --git a/include/system/os-posix.h b/include/system/os-posix.h
> > index ce5b3bccf8..e4b69fc316 100644
> > --- a/include/system/os-posix.h
> > +++ b/include/system/os-posix.h
> > @@ -54,6 +54,7 @@ void os_set_chroot(const char *path);
> >  void os_setup_limits(void);
> >  void os_setup_post(void);
> >  int os_mlock(bool on_fault);
> > +void os_set_socket_permissions(const char *path);
> >  
> >  /**
> >   * qemu_alloc_stack:
> > diff --git a/include/system/os-wasm.h b/include/system/os-wasm.h
> > index 3abb3aaa03..eeac092183 100644
> > --- a/include/system/os-wasm.h
> > +++ b/include/system/os-wasm.h
> > @@ -57,6 +57,7 @@ static inline int os_set_daemonize(bool d)
> >  };
> >  bool is_daemonized(void);
> >  static inline void os_daemonize(void) {}
> > +static inline void os_set_socket_permissions(const char *dummy) {};
> >  
> >  /**
> >   * qemu_alloc_stack:
> > diff --git a/include/system/os-win32.h b/include/system/os-win32.h
> > index 22d72babdf..79e42ec297 100644
> > --- a/include/system/os-win32.h
> > +++ b/include/system/os-win32.h
> > @@ -103,6 +103,7 @@ static inline void os_setup_post(void) {}
> >  static inline void os_set_proc_name(const char *dummy) {}
> >  void os_set_line_buffering(void);
> >  void os_setup_early_signal_handling(void);
> > +static inline void os_set_socket_permissions(const char *dummy) {};
> >  
> >  int getpagesize(void);
> >  
> > diff --git a/os-posix.c b/os-posix.c
> > index 52925c23d3..bbd17ff2b9 100644
> > --- a/os-posix.c
> > +++ b/os-posix.c
> > @@ -94,6 +94,18 @@ static struct passwd *user_pwd;    /*   NULL   non-NULL   NULL   */
> >  static uid_t user_uid = (uid_t)-1; /*   -1      -1        >=0    */
> >  static gid_t user_gid = (gid_t)-1; /*   -1      -1        >=0    */
> >  
> > +void os_set_socket_permissions(const char *path)
> > +{
> > +    uid_t uid = user_pwd ? user_pwd->pw_uid : user_uid;
> > +    gid_t gid = user_pwd ? user_pwd->pw_gid : user_gid;
> > +
> > +    if (chown(path, uid, gid) < 0) {
> > +        error_report("Failed to chown socket %s: %s", path, strerror(errno));
> > +        exit(1);
> > +    }
> > +}
> > +
> > +
> >  /*
> >   * Prepare to change user ID. user_id can be one of 3 forms:
> >   *   - a username, in which case user ID will be changed to its uid,
> > diff --git a/stubs/meson.build b/stubs/meson.build
> > index 0b2778c568..4a4342344b 100644
> > --- a/stubs/meson.build
> > +++ b/stubs/meson.build
> > @@ -24,6 +24,7 @@ if have_block
> >    stub_ss.add(files('ram-block.c'))
> >    stub_ss.add(files('runstate-check.c'))
> >    stub_ss.add(files('uuid.c'))
> > +  stub_ss.add(files('os-file.c'))
> >  endif
> >  
> >  if have_block or have_ga
> > diff --git a/stubs/os-file.c b/stubs/os-file.c
> > new file mode 100644
> > index 0000000000..c32cbc7efa
> > --- /dev/null
> > +++ b/stubs/os-file.c
> > @@ -0,0 +1,6 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +#include "qemu/osdep.h"
> > +
> > +void os_set_socket_permissions(const char *dummy)
> > +{
> > +}
> > diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> > index 4773755fd5..77b2d9287b 100644
> > --- a/util/qemu-sockets.c
> > +++ b/util/qemu-sockets.c
> > @@ -1026,6 +1026,12 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
> >          error_setg_errno(errp, errno, "Failed to bind socket to %s", path);
> >          goto err;
> >      }
> > +    /*
> > +     * Change the permissions on the socket to match the permission of the
> > +     * counterparty process
> > +     */
> > +    os_set_socket_permissions(un.sun_path);
> 
> QEMU's -run-with described user= as:
> 
>   user=username or user=uid:gid can be used to drop root privileges before
>   starting guest execution. QEMU will use the setuid and setgid system
>   calls to switch to the specified identity...
> 
> So it explicitly mentioned "before starting guest execution", hence at
> least from that doc it's hard to say if unix socket should be created with
> the privilege or after dropped..  Here I believe cpr socket should be the
> case for latter, however when it's a generic change to unix listening
> ports, I wonder if there's other unwanted side effects.
> 
> Considering unix socket itself doesn't really have a UID attached to it,
> it's only the unix path that needs a chmod(), meanwhile the mgmt of course
> knows both the right UID (as specified in -run-with) and the path, would it
> make sense if the mgmt chmod() after it starts dest QEMU?  That'll reduce
> the scope of impact to minimum.

My guiding principal is that the behaviour of cold-plugging a backend
on the CLI and hot-plugging a backend via QMP should be the same, since
we want to eventually get to a point where everything can be configured
via QMP and zero CLI except for basic process related things.

hot-plugging will honour -run-with setting, therefore cold-plugging
should do the same.

Having said that, the run-with setting impl is very clearcut however
that it is intended to run *after* all cold-plug setup is complete.
IOW, it is inherantly intending to have differnt behaviour for cold
plug vs hotplug.

There's a very real risk we'll cause regressions if we change how
permissions are handled implicitly on any backends.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


