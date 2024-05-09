Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C00CC10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 08:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4ypM-0006Ja-3a; Thu, 09 May 2024 04:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s4ypK-0006JO-Ba
 for qemu-devel@nongnu.org; Thu, 09 May 2024 04:08:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s4ypI-00077U-3I
 for qemu-devel@nongnu.org; Thu, 09 May 2024 04:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715242106;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6GsND87OhTLBl2BL0V51pjQHUsCNjVeSwxmQJ98sxto=;
 b=ikMY7DzyvzV8E9WsO62Xcv2KUh9CSIig7qqzgMHKzT06hhDMzJ0AHDAhp+KsQlXTwVa4Le
 EL6r7YEtfvl60KDcTQgKJ8oMy4R/1QpXW9itTA/8SfG9naNHG4fD0/iatC0lVTc2g/0AE/
 HHVIDI+Cv7EX5UO9lWMEdXGph7UM2Mc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-f0WO5aRcNTyDXp_V2kk4Ig-1; Thu,
 09 May 2024 04:08:22 -0400
X-MC-Unique: f0WO5aRcNTyDXp_V2kk4Ig-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 40B1F3C0008D;
 Thu,  9 May 2024 08:08:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA1FC2026D68;
 Thu,  9 May 2024 08:08:20 +0000 (UTC)
Date: Thu, 9 May 2024 09:08:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH 8/9] migration: Add support for fdset with multifd + file
Message-ID: <ZjyD3RHdl-xybOWc@redhat.com>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-9-farosas@suse.de>
 <Zjs9nI_Wgi5UIJba@redhat.com> <ZjvDCA9QvTI-zFf9@x1n>
 <87cypwkpgm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cypwkpgm.fsf@suse.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.582,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, May 08, 2024 at 05:39:53PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, May 08, 2024 at 09:53:48AM +0100, Daniel P. Berrangé wrote:
> >> On Fri, Apr 26, 2024 at 11:20:41AM -0300, Fabiano Rosas wrote:
> >> > Allow multifd to use an fdset when migrating to a file. This is useful
> >> > for the scenario where the management layer wants to have control over
> >> > the migration file.
> >> > 
> >> > By receiving the file descriptors directly, QEMU can delegate some
> >> > high level operating system operations to the management layer (such
> >> > as mandatory access control). The management layer might also want to
> >> > add its own headers before the migration stream.
> >> > 
> >> > Enable the "file:/dev/fdset/#" syntax for the multifd migration with
> >> > mapped-ram. The requirements for the fdset mechanism are:
> >> > 
> >> > On the migration source side:
> >> > 
> >> > - the fdset must contain two fds that are not duplicates between
> >> >   themselves;
> >> > - if direct-io is to be used, exactly one of the fds must have the
> >> >   O_DIRECT flag set;
> >> > - the file must be opened with WRONLY both times.
> >> > 
> >> > On the migration destination side:
> >> > 
> >> > - the fdset must contain one fd;
> >> > - the file must be opened with RDONLY.
> >> > 
> >> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> > ---
> >> >  docs/devel/migration/main.rst       | 18 ++++++++++++++
> >> >  docs/devel/migration/mapped-ram.rst |  6 ++++-
> >> >  migration/file.c                    | 38 ++++++++++++++++++++++++++++-
> >> >  3 files changed, 60 insertions(+), 2 deletions(-)
> >> > 
> >> > diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
> >> > index 54385a23e5..50f6096470 100644
> >> > --- a/docs/devel/migration/main.rst
> >> > +++ b/docs/devel/migration/main.rst
> >> > @@ -47,6 +47,24 @@ over any transport.
> >> >    QEMU interference. Note that QEMU does not flush cached file
> >> >    data/metadata at the end of migration.
> >> >  
> >> > +  The file migration also supports using a file that has already been
> >> > +  opened. A set of file descriptors is passed to QEMU via an "fdset"
> >> > +  (see add-fd QMP command documentation). This method allows a
> >> > +  management application to have control over the migration file
> >> > +  opening operation. There are, however, strict requirements to this
> >> > +  interface:
> >> > +
> >> > +  On the migration source side:
> >> > +    - if the multifd capability is to be used, the fdset must contain
> >> > +      two file descriptors that are not duplicates between themselves;
> >> > +    - if the direct-io capability is to be used, exactly one of the
> >> > +      file descriptors must have the O_DIRECT flag set;
> >> > +    - the file must be opened with WRONLY.
> >> > +
> >> > +  On the migration destination side:
> >> > +    - the fdset must contain one file descriptor;
> >> > +    - the file must be opened with RDONLY.
> >> > +
> >> >  In addition, support is included for migration using RDMA, which
> >> >  transports the page data using ``RDMA``, where the hardware takes care of
> >> >  transporting the pages, and the load on the CPU is much lower.  While the
> >> > diff --git a/docs/devel/migration/mapped-ram.rst b/docs/devel/migration/mapped-ram.rst
> >> > index fa4cefd9fc..e6505511f0 100644
> >> > --- a/docs/devel/migration/mapped-ram.rst
> >> > +++ b/docs/devel/migration/mapped-ram.rst
> >> > @@ -16,7 +16,7 @@ location in the file, rather than constantly being added to a
> >> >  sequential stream. Having the pages at fixed offsets also allows the
> >> >  usage of O_DIRECT for save/restore of the migration stream as the
> >> >  pages are ensured to be written respecting O_DIRECT alignment
> >> > -restrictions (direct-io support not yet implemented).
> >> > +restrictions.
> >> >  
> >> >  Usage
> >> >  -----
> >> > @@ -35,6 +35,10 @@ Use a ``file:`` URL for migration:
> >> >  Mapped-ram migration is best done non-live, i.e. by stopping the VM on
> >> >  the source side before migrating.
> >> >  
> >> > +For best performance enable the ``direct-io`` capability as well:
> >> > +
> >> > +    ``migrate_set_capability direct-io on``
> >> > +
> >> >  Use-cases
> >> >  ---------
> >> >  
> >> > diff --git a/migration/file.c b/migration/file.c
> >> > index b9265b14dd..3bc8bc7463 100644
> >> > --- a/migration/file.c
> >> > +++ b/migration/file.c
> >> > @@ -17,6 +17,7 @@
> >> >  #include "io/channel-file.h"
> >> >  #include "io/channel-socket.h"
> >> >  #include "io/channel-util.h"
> >> > +#include "monitor/monitor.h"
> >> >  #include "options.h"
> >> >  #include "trace.h"
> >> >  
> >> > @@ -54,10 +55,18 @@ static void file_remove_fdset(void)
> >> >      }
> >> >  }
> >> >  
> >> > +/*
> >> > + * With multifd, due to the behavior of the dup() system call, we need
> >> > + * the fdset to have two non-duplicate fds so we can enable direct IO
> >> > + * in the secondary channels without affecting the main channel.
> >> > + */
> >> >  static bool file_parse_fdset(const char *filename, int64_t *fdset_id,
> >> >                               Error **errp)
> >> >  {
> >> > +    FdsetInfoList *fds_info;
> >> > +    FdsetFdInfoList *fd_info;
> >> >      const char *fdset_id_str;
> >> > +    int nfds = 0;
> >> >  
> >> >      *fdset_id = -1;
> >> >  
> >> > @@ -71,6 +80,32 @@ static bool file_parse_fdset(const char *filename, int64_t *fdset_id,
> >> >          return false;
> >> >      }
> >> >  
> >> > +    if (!migrate_multifd() || !migrate_direct_io()) {
> >> > +        return true;
> >> > +    }
> >> > +
> >> > +    for (fds_info = qmp_query_fdsets(NULL); fds_info;
> >> > +         fds_info = fds_info->next) {
> >> > +
> >> > +        if (*fdset_id != fds_info->value->fdset_id) {
> >> > +            continue;
> >> > +        }
> >> > +
> >> > +        for (fd_info = fds_info->value->fds; fd_info; fd_info = fd_info->next) {
> >> > +            if (nfds++ > 2) {
> >> > +                break;
> >> > +            }
> >> > +        }
> >> > +    }
> >> > +
> >> > +    if (nfds != 2) {
> >> > +        error_setg(errp, "Outgoing migration needs two fds in the fdset, "
> >> > +                   "got %d", nfds);
> >> > +        qmp_remove_fd(*fdset_id, false, -1, NULL);
> >> > +        *fdset_id = -1;
> >> > +        return false;
> >> > +    }
> >> > +
> >> >      return true;
> >> >  }
> >> 
> >> Related to my thoughts in an earlier patch, where I say that use of fdsets
> >> ought to be transparent to QEMU code, I'm not a fan of having this logic
> >> in migration code.
> >> 
> >> IIUC, the migration code will call  qio_channel_file_new_path twice,
> >> once with O_DIRECT and once without. This should trigger two calls
> >> into monitor_fdset_dup_fd_add with different flags. If we're matching
> >> flags in that monitor_fdset_dup_fd_add(), then if only 1 FD was
> >> provided, are we not able to report an error there ?
> >
> > Right, this sounds working.
> 
> It works, but due to how low-level fdset is, it's difficult to match the
> low level error to anything meaningful we can report to the user. I'll
> have to add an errp to monitor_fdset_dup_fd_add(). Its returns are not
> very useful.
> 
> -1 with no errno
> -1 with EACCES (should actually be EBADF)
> -1 with ENOENT
> 
> There has been some discusstion around this before actually:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2021-08/msg02544.html

The only caller of monitor_fdset_dup_fd_add is qemu_open_internal
and that has a "Error **errp" parameter.  We should rewrite
monitor_fdset_dup_fd_add to also have an "Error **errp" at which
point we can actually report useful, actionable error messages
from it. Errnos be gone !

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


