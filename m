Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAAAC04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 22:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s86Ik-00064a-2a; Fri, 17 May 2024 18:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s86Ii-000649-ME
 for qemu-devel@nongnu.org; Fri, 17 May 2024 18:43:44 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s86Ig-0004qn-6Y
 for qemu-devel@nongnu.org; Fri, 17 May 2024 18:43:44 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0BE0C22A59;
 Fri, 17 May 2024 22:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715985819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D0Qrm4TqRx83pPx1uUJayIFcyOLZLwTvxnSKYKZcWbA=;
 b=V/pj7MKpzmiW54ikWw7vg6GpCpwomHEgGNqMybZLWR9mgo0MbFv4OjwUnIcjqypESlnvI8
 4wIsbnfcUw1/i66Yuc+gPFciEMwp6aYV2M7GQAF5/3z+0sMGBCJ5GXBQzoP6nb7E00L4Ct
 vZTyfZSKDtE5twPipHYyizXWIK1RDvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715985819;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D0Qrm4TqRx83pPx1uUJayIFcyOLZLwTvxnSKYKZcWbA=;
 b=ZmFw+aQ2t6kpHz+VKbYhrn+7thjFpv8ES/q2TQ9vjGD6GbtODErOALM400UuQHphx1MEr6
 Wd7RSlPm77Tw0iCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="V/pj7MKp";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZmFw+aQ2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715985819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D0Qrm4TqRx83pPx1uUJayIFcyOLZLwTvxnSKYKZcWbA=;
 b=V/pj7MKpzmiW54ikWw7vg6GpCpwomHEgGNqMybZLWR9mgo0MbFv4OjwUnIcjqypESlnvI8
 4wIsbnfcUw1/i66Yuc+gPFciEMwp6aYV2M7GQAF5/3z+0sMGBCJ5GXBQzoP6nb7E00L4Ct
 vZTyfZSKDtE5twPipHYyizXWIK1RDvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715985819;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D0Qrm4TqRx83pPx1uUJayIFcyOLZLwTvxnSKYKZcWbA=;
 b=ZmFw+aQ2t6kpHz+VKbYhrn+7thjFpv8ES/q2TQ9vjGD6GbtODErOALM400UuQHphx1MEr6
 Wd7RSlPm77Tw0iCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DCEC13942;
 Fri, 17 May 2024 22:43:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id O0nlD5rdR2Z7WAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 17 May 2024 22:43:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH 8/9] migration: Add support for fdset with multifd + file
In-Reply-To: <ZjyD3RHdl-xybOWc@redhat.com>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-9-farosas@suse.de> <Zjs9nI_Wgi5UIJba@redhat.com>
 <ZjvDCA9QvTI-zFf9@x1n> <87cypwkpgm.fsf@suse.de>
 <ZjyD3RHdl-xybOWc@redhat.com>
Date: Fri, 17 May 2024 19:43:35 -0300
Message-ID: <87o794jbzc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0BE0C22A59
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,gnu.org:url];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, May 08, 2024 at 05:39:53PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>>=20
>> > On Wed, May 08, 2024 at 09:53:48AM +0100, Daniel P. Berrang=C3=A9 wrot=
e:
>> >> On Fri, Apr 26, 2024 at 11:20:41AM -0300, Fabiano Rosas wrote:
>> >> > Allow multifd to use an fdset when migrating to a file. This is use=
ful
>> >> > for the scenario where the management layer wants to have control o=
ver
>> >> > the migration file.
>> >> >=20
>> >> > By receiving the file descriptors directly, QEMU can delegate some
>> >> > high level operating system operations to the management layer (such
>> >> > as mandatory access control). The management layer might also want =
to
>> >> > add its own headers before the migration stream.
>> >> >=20
>> >> > Enable the "file:/dev/fdset/#" syntax for the multifd migration with
>> >> > mapped-ram. The requirements for the fdset mechanism are:
>> >> >=20
>> >> > On the migration source side:
>> >> >=20
>> >> > - the fdset must contain two fds that are not duplicates between
>> >> >   themselves;
>> >> > - if direct-io is to be used, exactly one of the fds must have the
>> >> >   O_DIRECT flag set;
>> >> > - the file must be opened with WRONLY both times.
>> >> >=20
>> >> > On the migration destination side:
>> >> >=20
>> >> > - the fdset must contain one fd;
>> >> > - the file must be opened with RDONLY.
>> >> >=20
>> >> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> >> > ---
>> >> >  docs/devel/migration/main.rst       | 18 ++++++++++++++
>> >> >  docs/devel/migration/mapped-ram.rst |  6 ++++-
>> >> >  migration/file.c                    | 38 +++++++++++++++++++++++++=
+++-
>> >> >  3 files changed, 60 insertions(+), 2 deletions(-)
>> >> >=20
>> >> > diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/m=
ain.rst
>> >> > index 54385a23e5..50f6096470 100644
>> >> > --- a/docs/devel/migration/main.rst
>> >> > +++ b/docs/devel/migration/main.rst
>> >> > @@ -47,6 +47,24 @@ over any transport.
>> >> >    QEMU interference. Note that QEMU does not flush cached file
>> >> >    data/metadata at the end of migration.
>> >> >=20=20
>> >> > +  The file migration also supports using a file that has already b=
een
>> >> > +  opened. A set of file descriptors is passed to QEMU via an "fdse=
t"
>> >> > +  (see add-fd QMP command documentation). This method allows a
>> >> > +  management application to have control over the migration file
>> >> > +  opening operation. There are, however, strict requirements to th=
is
>> >> > +  interface:
>> >> > +
>> >> > +  On the migration source side:
>> >> > +    - if the multifd capability is to be used, the fdset must cont=
ain
>> >> > +      two file descriptors that are not duplicates between themsel=
ves;
>> >> > +    - if the direct-io capability is to be used, exactly one of the
>> >> > +      file descriptors must have the O_DIRECT flag set;
>> >> > +    - the file must be opened with WRONLY.
>> >> > +
>> >> > +  On the migration destination side:
>> >> > +    - the fdset must contain one file descriptor;
>> >> > +    - the file must be opened with RDONLY.
>> >> > +
>> >> >  In addition, support is included for migration using RDMA, which
>> >> >  transports the page data using ``RDMA``, where the hardware takes =
care of
>> >> >  transporting the pages, and the load on the CPU is much lower.  Wh=
ile the
>> >> > diff --git a/docs/devel/migration/mapped-ram.rst b/docs/devel/migra=
tion/mapped-ram.rst
>> >> > index fa4cefd9fc..e6505511f0 100644
>> >> > --- a/docs/devel/migration/mapped-ram.rst
>> >> > +++ b/docs/devel/migration/mapped-ram.rst
>> >> > @@ -16,7 +16,7 @@ location in the file, rather than constantly bein=
g added to a
>> >> >  sequential stream. Having the pages at fixed offsets also allows t=
he
>> >> >  usage of O_DIRECT for save/restore of the migration stream as the
>> >> >  pages are ensured to be written respecting O_DIRECT alignment
>> >> > -restrictions (direct-io support not yet implemented).
>> >> > +restrictions.
>> >> >=20=20
>> >> >  Usage
>> >> >  -----
>> >> > @@ -35,6 +35,10 @@ Use a ``file:`` URL for migration:
>> >> >  Mapped-ram migration is best done non-live, i.e. by stopping the V=
M on
>> >> >  the source side before migrating.
>> >> >=20=20
>> >> > +For best performance enable the ``direct-io`` capability as well:
>> >> > +
>> >> > +    ``migrate_set_capability direct-io on``
>> >> > +
>> >> >  Use-cases
>> >> >  ---------
>> >> >=20=20
>> >> > diff --git a/migration/file.c b/migration/file.c
>> >> > index b9265b14dd..3bc8bc7463 100644
>> >> > --- a/migration/file.c
>> >> > +++ b/migration/file.c
>> >> > @@ -17,6 +17,7 @@
>> >> >  #include "io/channel-file.h"
>> >> >  #include "io/channel-socket.h"
>> >> >  #include "io/channel-util.h"
>> >> > +#include "monitor/monitor.h"
>> >> >  #include "options.h"
>> >> >  #include "trace.h"
>> >> >=20=20
>> >> > @@ -54,10 +55,18 @@ static void file_remove_fdset(void)
>> >> >      }
>> >> >  }
>> >> >=20=20
>> >> > +/*
>> >> > + * With multifd, due to the behavior of the dup() system call, we =
need
>> >> > + * the fdset to have two non-duplicate fds so we can enable direct=
 IO
>> >> > + * in the secondary channels without affecting the main channel.
>> >> > + */
>> >> >  static bool file_parse_fdset(const char *filename, int64_t *fdset_=
id,
>> >> >                               Error **errp)
>> >> >  {
>> >> > +    FdsetInfoList *fds_info;
>> >> > +    FdsetFdInfoList *fd_info;
>> >> >      const char *fdset_id_str;
>> >> > +    int nfds =3D 0;
>> >> >=20=20
>> >> >      *fdset_id =3D -1;
>> >> >=20=20
>> >> > @@ -71,6 +80,32 @@ static bool file_parse_fdset(const char *filenam=
e, int64_t *fdset_id,
>> >> >          return false;
>> >> >      }
>> >> >=20=20
>> >> > +    if (!migrate_multifd() || !migrate_direct_io()) {
>> >> > +        return true;
>> >> > +    }
>> >> > +
>> >> > +    for (fds_info =3D qmp_query_fdsets(NULL); fds_info;
>> >> > +         fds_info =3D fds_info->next) {
>> >> > +
>> >> > +        if (*fdset_id !=3D fds_info->value->fdset_id) {
>> >> > +            continue;
>> >> > +        }
>> >> > +
>> >> > +        for (fd_info =3D fds_info->value->fds; fd_info; fd_info =
=3D fd_info->next) {
>> >> > +            if (nfds++ > 2) {
>> >> > +                break;
>> >> > +            }
>> >> > +        }
>> >> > +    }
>> >> > +
>> >> > +    if (nfds !=3D 2) {
>> >> > +        error_setg(errp, "Outgoing migration needs two fds in the =
fdset, "
>> >> > +                   "got %d", nfds);
>> >> > +        qmp_remove_fd(*fdset_id, false, -1, NULL);
>> >> > +        *fdset_id =3D -1;
>> >> > +        return false;
>> >> > +    }
>> >> > +
>> >> >      return true;
>> >> >  }
>> >>=20
>> >> Related to my thoughts in an earlier patch, where I say that use of f=
dsets
>> >> ought to be transparent to QEMU code, I'm not a fan of having this lo=
gic
>> >> in migration code.
>> >>=20
>> >> IIUC, the migration code will call  qio_channel_file_new_path twice,
>> >> once with O_DIRECT and once without. This should trigger two calls
>> >> into monitor_fdset_dup_fd_add with different flags. If we're matching
>> >> flags in that monitor_fdset_dup_fd_add(), then if only 1 FD was
>> >> provided, are we not able to report an error there ?
>> >
>> > Right, this sounds working.
>>=20
>> It works, but due to how low-level fdset is, it's difficult to match the
>> low level error to anything meaningful we can report to the user. I'll
>> have to add an errp to monitor_fdset_dup_fd_add(). Its returns are not
>> very useful.
>>=20
>> -1 with no errno
>> -1 with EACCES (should actually be EBADF)
>> -1 with ENOENT
>>=20
>> There has been some discusstion around this before actually:
>>=20
>> https://lists.gnu.org/archive/html/qemu-devel/2021-08/msg02544.html
>
> The only caller of monitor_fdset_dup_fd_add is qemu_open_internal
> and that has a "Error **errp" parameter.  We should rewrite
> monitor_fdset_dup_fd_add to also have an "Error **errp" at which
> point we can actually report useful, actionable error messages
> from it. Errnos be gone !

I can do that, but qemu_open_old() does not pass the error in. Please
see if this works for you:

-->8--
From 16e333cc5aeca1fab3f75f79048c0ab0d62d5b08 Mon Sep 17 00:00:00 2001
From: Fabiano Rosas <farosas@suse.de>
Date: Fri, 17 May 2024 19:30:39 -0300
Subject: [PATCH] io: Stop using qemu_open_old in channel-file

We want to make use of the Error object to report fdset errors from
qemu_open_internal() and passing the error pointer to qemu_open_old()
would require changing all callers. Move the file channel to the new
API instead.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 io/channel-file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/io/channel-file.c b/io/channel-file.c
index 6436cfb6ae..2ea8d08360 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -68,11 +68,13 @@ qio_channel_file_new_path(const char *path,
=20
     ioc =3D QIO_CHANNEL_FILE(object_new(TYPE_QIO_CHANNEL_FILE));
=20
-    ioc->fd =3D qemu_open_old(path, flags, mode);
+    if (flags & O_CREAT) {
+        ioc->fd =3D qemu_create(path, flags & ~O_CREAT, mode, errp);
+    } else {
+        ioc->fd =3D qemu_open(path, flags, errp);
+    }
     if (ioc->fd < 0) {
         object_unref(OBJECT(ioc));
-        error_setg_errno(errp, errno,
-                         "Unable to open %s", path);
         return NULL;
     }
=20
--=20
2.35.3


