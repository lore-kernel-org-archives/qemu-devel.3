Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02778606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OTwoZtXs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVltd-0001lJ-4A; Tue, 24 Nov 2026 03:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xVltb-0001kz-KX
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 03:28:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xVltX-0004IV-Nn
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 03:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795508934;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=8vlzd6uHwoh+xF21Z+R95e12Aq4GFF9NZ1PooLwbtqI=;
 b=OTwoZtXsSpa8i28JPdDq2Z+tEXwdTEGhsLqn9oHY9wNC3MsIZEJsi8vsydoMFCcQ1iLnV0
 0tdY8pNYkamH+8SMcPZlLcixTVImtho1cxcP3SIV1STvSBU3kYCm3w/ZA6WXJnmugbN3Ix
 wLcVf93L7EIdqT5ZP63Q0WqtFpCerSU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-Tqaq5QgQPqCchwA5NwlesA-1; Tue,
 24 Nov 2026 08:28:49 +0000
X-MC-Unique: Tqaq5QgQPqCchwA5NwlesA-1
X-Mimecast-MFC-AGG-ID: Tqaq5QgQPqCchwA5NwlesA_1795508927
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5B4919540E2; Tue, 24 Nov 2026 08:28:46 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70D1B1956088; Tue, 24 Nov 2026 08:28:39 +0000 (UTC)
Date: Tue, 24 Nov 2026 08:28:36 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Filip Hejsek <filip.hejsek@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v4] treewide: use qemu_dup() instead of dup()
Message-ID: <awVKtNi4M_1BsZvt@redhat.com>
References: <20261112-use-qemu-dup-v4-1-c9032f94bc2c@gmail.com>
 <52cc9199-8043-4068-83a3-f5462a236e68@maciej.szmigiero.name>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <52cc9199-8043-4068-83a3-f5462a236e68@maciej.szmigiero.name>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 07:15:58PM +0100, Maciej S. Szmigiero wrote:
> On 12.11.2026 17:17, Filip Hejsek wrote:
> > Move qemu_dup() out of an #ifndef so it can be called from code that
> > runs on Windows. Then use it instead of dup() to ensure the cloexec
> > flag is set on dup'd fds.
> > 
> > The only direct users of dup() are now guest syscalls in the user
> > emulators and the implementation of qemu_dup() itself.
> > 
> > Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> > ---
> > I fixed the Windows build now, checked with docker-test-mingw. I had
> > to remove ENABLE_RUST=1 in fedora-win64-cross.docker, because Rust
> > cross-compilation was broken.
> > 
> > Changes in v4:
> > - Fix Windows build
> > - Link to v3: https://lore.kernel.org/qemu-devel/20261015-use-qemu-dup-v3-1-ca02b5927725@gmail.com
> > 
> > Changes in v3:
> > - Also replace the use in migration/cpr-exec.c and the tests
> > - Link to v2: https://lore.kernel.org/qemu-devel/20261013-use-qemu-dup-v2-1-12ecd94263b7@gmail.com
> > 
> > Changes in v2:
> > - Replace the use in qemu-nbd.c too
> > - Changed commit message
> > - Link to v1: https://lore.kernel.org/qemu-devel/20261012-use-qemu-dup-v1-1-03d94852a6c8@gmail.com
> > ---
> >   hw/virtio/virtio.c             |  2 +-
> >   include/qemu/osdep.h           |  2 +-
> >   io/channel-file.c              |  2 +-
> >   migration/cpr-exec.c           |  2 +-
> >   qemu-nbd.c                     |  2 +-
> >   system/vl.c                    |  9 +--------
> >   tests/qtest/bios-tables-test.c |  2 +-
> >   tests/unit/test-util-sockets.c |  6 +++---
> >   tests/unit/test-vmstate.c      |  2 +-
> >   ui/dmabuf.c                    |  2 +-
> >   util/osdep.c                   | 28 ++++++++++++++--------------
> >   11 files changed, 26 insertions(+), 33 deletions(-)
> > 
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index c9f9e5b511..70779fbd56 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -3204,7 +3204,7 @@ VirtioSharedMemoryMapping *virtio_shared_memory_mapping_new(uint8_t shmid,
> >           return NULL;
> >       }
> > -    fd = dup(fd);
> > +    fd = qemu_dup(fd);
> >       if (fd < 0) {
> >           error_report("Failed to duplicate fd: %s", strerror(errno));
> >           return NULL;
> > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > index b27d159d5b..b5dbfc8a8a 100644
> > --- a/include/qemu/osdep.h
> > +++ b/include/qemu/osdep.h
> > @@ -653,9 +653,9 @@ int qemu_open(const char *name, int flags, Error **errp);
> >   int qemu_create(const char *name, int flags, mode_t mode, Error **errp);
> >   int qemu_close(int fd);
> >   int qemu_unlink(const char *name);
> > +int qemu_dup(int fd);
> >   #ifndef _WIN32
> >   int qemu_dup_flags(int fd, int flags);
> > -int qemu_dup(int fd);
> >   int qemu_lock_fd(int fd, int64_t start, int64_t len, bool exclusive);
> >   int qemu_unlock_fd(int fd, int64_t start, int64_t len);
> >   int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
> > diff --git a/io/channel-file.c b/io/channel-file.c
> > index 4c9da6619b..548a633be8 100644
> > --- a/io/channel-file.c
> > +++ b/io/channel-file.c
> > @@ -54,7 +54,7 @@ qio_channel_file_new_fd(int fd)
> >   QIOChannelFile *
> >   qio_channel_file_new_dupfd(int fd, Error **errp)
> >   {
> > -    int newfd = dup(fd);
> > +    int newfd = qemu_dup(fd);
> >       if (newfd < 0) {
> >           error_setg_errno(errp, errno, "Could not dup FD %d", fd);
> > diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
> > index daa50916d2..2f38db30bb 100644
> > --- a/migration/cpr-exec.c
> > +++ b/migration/cpr-exec.c
> > @@ -44,7 +44,7 @@ bool cpr_exec_persist_state(QEMUFile *f, Error **errp)
> >   {
> >       QIOChannelFile *fioc = QIO_CHANNEL_FILE(qemu_file_get_ioc(f));
> >       /* coverity[leaked_storage] - mfd intentionally kept open across exec() */
> > -    int mfd = dup(fioc->fd);
> > +    int mfd = qemu_dup(fioc->fd);
> >       char val[16];
> >       /* Remember mfd in environment for post-exec load */
> The code below immediately clears that CLOEXEC flag on this new fd
> so I'm not sure if there's any value in switching to qemu_dup() here.

The benefit is that we eliminate all use of plain 'dup', such that
we know all FDs start with CLOEXEC set. Any code to then explicitly
clear CLOEXEC then stands out as a deliberate design choice, as
opposed to dup() usage which is mostly likely to be an accident.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


