Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADBBC25B4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 20:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4o57-0001fY-F4; Wed, 08 May 2024 16:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s4o54-0001fC-NE
 for qemu-devel@nongnu.org; Wed, 08 May 2024 16:40:03 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s4o50-0001B9-U2
 for qemu-devel@nongnu.org; Wed, 08 May 2024 16:40:02 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 365575D048;
 Wed,  8 May 2024 20:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715200796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZRLXutuxAgm1cMwd75Z/vgDNpgFQpT92wEMb1SB27dw=;
 b=dSyG0roaAigefyUWEG8MAh+sO1CRg/BOIMzM47wQP8+QilnK6vhdhhepLOV9rOxnwhBAIC
 EpzaMd8VOKFpQVPHQV1d1LStGnpo3sg+fninJxgjlgMnXVLKNvg4ucMMz9TWx5C17bCCvF
 5c7Ta+qwbHCJzEVNZAnEMuSxD1386ps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715200796;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZRLXutuxAgm1cMwd75Z/vgDNpgFQpT92wEMb1SB27dw=;
 b=UA5Qv8BCulbOELYlzw1nhSLPopQ4kTH0+FrkUp/HRsk0R6AM3RXIXSaBY7wepcOKORucLv
 OchvxbnBljyWiCDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715200796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZRLXutuxAgm1cMwd75Z/vgDNpgFQpT92wEMb1SB27dw=;
 b=dSyG0roaAigefyUWEG8MAh+sO1CRg/BOIMzM47wQP8+QilnK6vhdhhepLOV9rOxnwhBAIC
 EpzaMd8VOKFpQVPHQV1d1LStGnpo3sg+fninJxgjlgMnXVLKNvg4ucMMz9TWx5C17bCCvF
 5c7Ta+qwbHCJzEVNZAnEMuSxD1386ps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715200796;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZRLXutuxAgm1cMwd75Z/vgDNpgFQpT92wEMb1SB27dw=;
 b=UA5Qv8BCulbOELYlzw1nhSLPopQ4kTH0+FrkUp/HRsk0R6AM3RXIXSaBY7wepcOKORucLv
 OchvxbnBljyWiCDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B17061386E;
 Wed,  8 May 2024 20:39:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WP7wHRvjO2YFaQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 08 May 2024 20:39:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Claudio Fontana
 <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH 8/9] migration: Add support for fdset with multifd + file
In-Reply-To: <ZjvDCA9QvTI-zFf9@x1n>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-9-farosas@suse.de> <Zjs9nI_Wgi5UIJba@redhat.com>
 <ZjvDCA9QvTI-zFf9@x1n>
Date: Wed, 08 May 2024 17:39:53 -0300
Message-ID: <87cypwkpgm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, May 08, 2024 at 09:53:48AM +0100, Daniel P. Berrang=C3=A9 wrote:
>> On Fri, Apr 26, 2024 at 11:20:41AM -0300, Fabiano Rosas wrote:
>> > Allow multifd to use an fdset when migrating to a file. This is useful
>> > for the scenario where the management layer wants to have control over
>> > the migration file.
>> >=20
>> > By receiving the file descriptors directly, QEMU can delegate some
>> > high level operating system operations to the management layer (such
>> > as mandatory access control). The management layer might also want to
>> > add its own headers before the migration stream.
>> >=20
>> > Enable the "file:/dev/fdset/#" syntax for the multifd migration with
>> > mapped-ram. The requirements for the fdset mechanism are:
>> >=20
>> > On the migration source side:
>> >=20
>> > - the fdset must contain two fds that are not duplicates between
>> >   themselves;
>> > - if direct-io is to be used, exactly one of the fds must have the
>> >   O_DIRECT flag set;
>> > - the file must be opened with WRONLY both times.
>> >=20
>> > On the migration destination side:
>> >=20
>> > - the fdset must contain one fd;
>> > - the file must be opened with RDONLY.
>> >=20
>> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> > ---
>> >  docs/devel/migration/main.rst       | 18 ++++++++++++++
>> >  docs/devel/migration/mapped-ram.rst |  6 ++++-
>> >  migration/file.c                    | 38 ++++++++++++++++++++++++++++-
>> >  3 files changed, 60 insertions(+), 2 deletions(-)
>> >=20
>> > diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main=
.rst
>> > index 54385a23e5..50f6096470 100644
>> > --- a/docs/devel/migration/main.rst
>> > +++ b/docs/devel/migration/main.rst
>> > @@ -47,6 +47,24 @@ over any transport.
>> >    QEMU interference. Note that QEMU does not flush cached file
>> >    data/metadata at the end of migration.
>> >=20=20
>> > +  The file migration also supports using a file that has already been
>> > +  opened. A set of file descriptors is passed to QEMU via an "fdset"
>> > +  (see add-fd QMP command documentation). This method allows a
>> > +  management application to have control over the migration file
>> > +  opening operation. There are, however, strict requirements to this
>> > +  interface:
>> > +
>> > +  On the migration source side:
>> > +    - if the multifd capability is to be used, the fdset must contain
>> > +      two file descriptors that are not duplicates between themselves;
>> > +    - if the direct-io capability is to be used, exactly one of the
>> > +      file descriptors must have the O_DIRECT flag set;
>> > +    - the file must be opened with WRONLY.
>> > +
>> > +  On the migration destination side:
>> > +    - the fdset must contain one file descriptor;
>> > +    - the file must be opened with RDONLY.
>> > +
>> >  In addition, support is included for migration using RDMA, which
>> >  transports the page data using ``RDMA``, where the hardware takes car=
e of
>> >  transporting the pages, and the load on the CPU is much lower.  While=
 the
>> > diff --git a/docs/devel/migration/mapped-ram.rst b/docs/devel/migratio=
n/mapped-ram.rst
>> > index fa4cefd9fc..e6505511f0 100644
>> > --- a/docs/devel/migration/mapped-ram.rst
>> > +++ b/docs/devel/migration/mapped-ram.rst
>> > @@ -16,7 +16,7 @@ location in the file, rather than constantly being a=
dded to a
>> >  sequential stream. Having the pages at fixed offsets also allows the
>> >  usage of O_DIRECT for save/restore of the migration stream as the
>> >  pages are ensured to be written respecting O_DIRECT alignment
>> > -restrictions (direct-io support not yet implemented).
>> > +restrictions.
>> >=20=20
>> >  Usage
>> >  -----
>> > @@ -35,6 +35,10 @@ Use a ``file:`` URL for migration:
>> >  Mapped-ram migration is best done non-live, i.e. by stopping the VM on
>> >  the source side before migrating.
>> >=20=20
>> > +For best performance enable the ``direct-io`` capability as well:
>> > +
>> > +    ``migrate_set_capability direct-io on``
>> > +
>> >  Use-cases
>> >  ---------
>> >=20=20
>> > diff --git a/migration/file.c b/migration/file.c
>> > index b9265b14dd..3bc8bc7463 100644
>> > --- a/migration/file.c
>> > +++ b/migration/file.c
>> > @@ -17,6 +17,7 @@
>> >  #include "io/channel-file.h"
>> >  #include "io/channel-socket.h"
>> >  #include "io/channel-util.h"
>> > +#include "monitor/monitor.h"
>> >  #include "options.h"
>> >  #include "trace.h"
>> >=20=20
>> > @@ -54,10 +55,18 @@ static void file_remove_fdset(void)
>> >      }
>> >  }
>> >=20=20
>> > +/*
>> > + * With multifd, due to the behavior of the dup() system call, we need
>> > + * the fdset to have two non-duplicate fds so we can enable direct IO
>> > + * in the secondary channels without affecting the main channel.
>> > + */
>> >  static bool file_parse_fdset(const char *filename, int64_t *fdset_id,
>> >                               Error **errp)
>> >  {
>> > +    FdsetInfoList *fds_info;
>> > +    FdsetFdInfoList *fd_info;
>> >      const char *fdset_id_str;
>> > +    int nfds =3D 0;
>> >=20=20
>> >      *fdset_id =3D -1;
>> >=20=20
>> > @@ -71,6 +80,32 @@ static bool file_parse_fdset(const char *filename, =
int64_t *fdset_id,
>> >          return false;
>> >      }
>> >=20=20
>> > +    if (!migrate_multifd() || !migrate_direct_io()) {
>> > +        return true;
>> > +    }
>> > +
>> > +    for (fds_info =3D qmp_query_fdsets(NULL); fds_info;
>> > +         fds_info =3D fds_info->next) {
>> > +
>> > +        if (*fdset_id !=3D fds_info->value->fdset_id) {
>> > +            continue;
>> > +        }
>> > +
>> > +        for (fd_info =3D fds_info->value->fds; fd_info; fd_info =3D f=
d_info->next) {
>> > +            if (nfds++ > 2) {
>> > +                break;
>> > +            }
>> > +        }
>> > +    }
>> > +
>> > +    if (nfds !=3D 2) {
>> > +        error_setg(errp, "Outgoing migration needs two fds in the fds=
et, "
>> > +                   "got %d", nfds);
>> > +        qmp_remove_fd(*fdset_id, false, -1, NULL);
>> > +        *fdset_id =3D -1;
>> > +        return false;
>> > +    }
>> > +
>> >      return true;
>> >  }
>>=20
>> Related to my thoughts in an earlier patch, where I say that use of fdse=
ts
>> ought to be transparent to QEMU code, I'm not a fan of having this logic
>> in migration code.
>>=20
>> IIUC, the migration code will call  qio_channel_file_new_path twice,
>> once with O_DIRECT and once without. This should trigger two calls
>> into monitor_fdset_dup_fd_add with different flags. If we're matching
>> flags in that monitor_fdset_dup_fd_add(), then if only 1 FD was
>> provided, are we not able to report an error there ?
>
> Right, this sounds working.

It works, but due to how low-level fdset is, it's difficult to match the
low level error to anything meaningful we can report to the user. I'll
have to add an errp to monitor_fdset_dup_fd_add(). Its returns are not
very useful.

-1 with no errno
-1 with EACCES (should actually be EBADF)
-1 with ENOENT

There has been some discusstion around this before actually:

https://lists.gnu.org/archive/html/qemu-devel/2021-08/msg02544.html

Or, you know, let the management layer figure it out. We seem to be
heading in this direction already. I imagine once the code is written to
interact with QEMU, it would not have any reason to change, so it might
be ok to replace some of the code I'm adding in this series with
documentation and call it a day. I don't like this approach very much,
but it would definitely make this series way simpler.

>
> For a real sanity check, we may want to somehow check the two fds returned
> from qio_channel_file_new_path() to point to the same file underneath.
>
> What mentioned in the other thread (kcmp with KCMP_FILE) might not work, =
as
> the whole purpose of having two fds is to make sure they have different
> struct file to back the fd (and only one of them has O_DIRECT).  fstat()
> might work in this case over the st_ino field, etc. maybe fstatfs() too b=
ut
> perhaps that's over cautious.  Just a pain to use two fds as a start..
>
> Thanks,

