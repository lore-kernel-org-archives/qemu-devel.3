Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F3ECD4F4A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 16:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP1GJ-0000zd-OP; Mon, 18 May 2026 12:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1wP1G4-0000yG-EM
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:56:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1wP1G0-0001XO-1x
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779123351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zxiIezmhWvo1vQmcz+sSbwYS9pJB8pxyf4v7VdZrdbM=;
 b=cUDgxNp8NtOB0uvOksS2o2cF7Fba6rxF+1tBMy5Y+CoBB5TYPo3dsT2nh01lgm/WPDNP04
 vu8lTEb7hmRwSfbeS9ARRBKlYMvXGKP3+oHcAEEuXdfiieDoSzmfleCFSmyJ3qzQcKhCEU
 IDUBSk/zTCzWjrf+WXmIVmbGGmwuDhg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-A-TW6IGaNf6PyD-Oi_BqOw-1; Mon,
 18 May 2026 12:54:43 -0400
X-MC-Unique: A-TW6IGaNf6PyD-Oi_BqOw-1
X-Mimecast-MFC-AGG-ID: A-TW6IGaNf6PyD-Oi_BqOw_1779123282
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B352B18002D6; Mon, 18 May 2026 16:54:42 +0000 (UTC)
Received: from localhost (unknown [10.44.50.109])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F13AB1800673; Mon, 18 May 2026 16:54:41 +0000 (UTC)
Date: Mon, 18 May 2026 17:54:40 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, farosas@suse.de,
 pbonzini@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v2 1/2] Implement -run-with exit-with-parent=on
Message-ID: <20260518165440.GX1447@redhat.com>
References: <20251009161526.140497-1-rjones@redhat.com>
 <20251009161526.140497-2-rjones@redhat.com>
 <59f45360-5676-41a7-8c4a-577c3e645aa7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59f45360-5676-41a7-8c4a-577c3e645aa7@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, May 18, 2026 at 06:49:11PM +0200, Thomas Huth wrote:
> On 09/10/2025 18.12, Richard W.M. Jones wrote:
> >+static void *
> >+exit_with_parent_loop(void *vp)
> >+{
> >+    const pid_t ppid = getppid();
> >+    int fd;
> >+    struct kevent kev, res[1];
> >+    int r;
> >+
> >+    /* Register the kevent to wait for ppid to exit. */
> >+    fd = kqueue();
> >+    if (fd == -1) {
> >+        error_report("exit_with_parent_loop: kqueue: %m");
> >+        return NULL;
> >+    }
> >+    EV_SET(&kev, ppid, EVFILT_PROC, EV_ADD | EV_ENABLE, NOTE_EXIT, 0, NULL);
> >+    if (kevent(fd, &kev, 1, NULL, 0, NULL) == -1) {
> >+        error_report("exit_with_parent_loop: kevent: %m");
> >+        close(fd);
> 
> So in case of errors, fd is closed here ...
> 
> >+        return NULL;
> >+    }
> >+
> >+    /* Wait for the kevent to happen. */
> >+    r = kevent(fd, 0, 0, res, 1, NULL);
> >+    if (r == 1 && res[0].ident == ppid) {
> >+        /* Behave like Linux and FreeBSD above, as if SIGTERM was sent */
> >+        qemu_system_killed(SIGTERM, ppid);
> >+    }
> >+
> >+    return NULL;
> >+}
> ... but if everything goes well, fd does not get closed? Should
> there be a close(fd) after the kevent() here?

Yes .. although of course qemu as a whole will exit very soon
afterwards :-)

Do you want me to submit a patch or will you do it?

I'll fix the equivalent code in nbdkit.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
nbdkit - Flexible, fast NBD server with plugins
https://gitlab.com/nbdkit/nbdkit


