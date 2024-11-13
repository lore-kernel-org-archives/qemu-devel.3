Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E1CD41C3E
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 13:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBCzD-0007Aa-20; Wed, 13 Nov 2024 08:00:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1tBCz1-000793-Bb
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 08:00:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1tBCyz-0006mw-6Q
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 08:00:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731502828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8Hb+hBMBJV+0BwXq9RpkhqYkD3AvBLNOOjmLahSWfvc=;
 b=Pvho4+TPlMnCulegetP7sKz1yssqwKKGgp76SMvAZUI6YH4PP34i729S/tVJVQp+TKs1wF
 UayJfwdJ8bkVPDSND5sIe/FYpnzUclGTiQdqQVFZ5Ou8ZIizZvSZlwZNxd7mV79kaLNNYD
 tNdsMKG44mZwDQg6dnlLOWSsMZJPPos=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-LQKpUecrPEa2nqmt6KhHLQ-1; Wed,
 13 Nov 2024 08:00:25 -0500
X-MC-Unique: LQKpUecrPEa2nqmt6KhHLQ-1
X-Mimecast-MFC-AGG-ID: LQKpUecrPEa2nqmt6KhHLQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E62DF19560A3; Wed, 13 Nov 2024 13:00:23 +0000 (UTC)
Received: from localhost (unknown [10.42.28.15])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7AAA919560A3; Wed, 13 Nov 2024 13:00:22 +0000 (UTC)
Date: Wed, 13 Nov 2024 13:00:21 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, jjelen@redhat.com, mpitt@redhat.com
Subject: Re: [PATCH ssh] ssh: Do not switch session to non-blocking mode
Message-ID: <20241113130021.GA20898@redhat.com>
References: <20241113115000.2494785-1-rjones@redhat.com>
 <0371e3cc-1ed5-4685-835a-5378dd4dfbb7@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0371e3cc-1ed5-4685-835a-5378dd4dfbb7@tls.msk.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Nov 13, 2024 at 03:02:59PM +0300, Michael Tokarev wrote:
> Heh. I was creating a qemu bug report on gitlab when this email arrived :)
> 
> 13.11.2024 14:49, Richard W.M. Jones wrote:
> >From: Jakub Jelen <jjelen@redhat.com>
> >
> >The libssh does not handle non-blocking mode in SFTP correctly. The
> >driver code already changes the mode to blocking for the SFTP
> >initialization, but for some reason changes to non-blocking mode.
> 
> "changes to non-blocking mode LATER", I guess, - or else it's a bit
> difficult to read.  But this works too.
> 
> >This used to work accidentally until libssh in 0.11 branch merged
> >the patch to avoid infinite looping in case of network errors:
> >
> >https://gitlab.com/libssh/libssh-mirror/-/merge_requests/498
> >
> >Since then, the ssh driver in qemu fails to read files over SFTP
> >as the first SFTP messages exchanged after switching the session
> >to non-blocking mode return SSH_AGAIN, but that message is lost
> >int the SFTP internals and interpretted as SSH_ERROR, which is
> >returned to the caller:
> >
> >https://gitlab.com/libssh/libssh-mirror/-/issues/280
> >
> >This is indeed an issue in libssh that we should address in the
> >long term, but it will require more work on the internals. For
> >now, the SFTP is not supported in non-blocking mode.
> 
> The comment at init where the code sets socket to blocking mode, says:
> 
>     /*
>      * Make sure we are in blocking mode during the connection and
>      * authentication phases.
>      */
>     ssh_set_blocking(s->session, 1);
> 
> 
> There are a few other places where the code expect "some" blocking
> mode, changes it to blocking, and restores the mode later, - eg,
> see ssh_grow_file().  It looks all this has to be fixed too.

I'll just note that I'm only forwarding on the patch from Jakub.
I didn't write it.

I did lightly test it, and it seems to work.  However it seems also
likely that it is causing qemu to block internally.  Probably not
noticable for light use, but not something that we'd want for serious
use.  However if libssh doesn't support non-blocking SFTP there's not
much we can do about that in qemu.

I would recommend using nbdkit-ssh-plugin instead anyway as it is much
more featureful and doesn't have this problem as we use real threads
instead of coroutines.

> I wonder if qemu ssh driver needs to mess with blocking mode of this
> socket in the first place, ever.  Is there a way qemu can get non-blocking
> socket in this context?  I can only think of fd=NNN, but is it
> possible for this socket to be non-blocking?
> 
> >Fixes: https://gitlab.com/libssh/libssh-mirror/-/issues/280
> >Signed-off-by: Jakub Jelen <jjelen@redhat.com>
> >Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> >---
> >  block/ssh.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> >diff --git a/block/ssh.c b/block/ssh.c
> >index 9f8140bcb6..e1529cfda9 100644
> >--- a/block/ssh.c
> >+++ b/block/ssh.c
> >@@ -866,8 +866,6 @@ static int ssh_open(BlockDriverState *bs, QDict *options, int bdrv_flags,
> >          goto err;
> >      }
> >-    /* Go non-blocking. */
> >-    ssh_set_blocking(s->session, 0);
> >      if (s->attrs->type == SSH_FILEXFER_TYPE_REGULAR) {
> >          bs->supported_truncate_flags = BDRV_REQ_ZERO_WRITE;
> 
> Please remove the empty line too.

I posted a v2 which removes the blank line but is otherwise the same.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW


