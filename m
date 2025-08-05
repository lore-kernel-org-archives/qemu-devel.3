Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31356C87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 10:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujEbx-0001JI-Un; Tue, 05 Aug 2025 06:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujEbs-0001CA-GD
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 06:09:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujEbn-0003Nh-O3
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 06:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754388565;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vCnnQgS+4HIa6476ghN29Y8P0AFR25d6u/uzELIa42g=;
 b=M/rSPSpleE9/NG4EudrxHFpoucq7BMY1dEEUY+Hfgr0R5CAxtDW1bGiNsGPVOyKj3QFbn0
 psfCbBPTy6lU1U8c01kOjTTzkvNTDg6iRz0bvecSWFrC8zsZKQcz9Ys3bLZwziJe31Wydb
 23uba0Oto+R3l1CmV49P1Wf8iPaPuMk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-RUj0VxQuNMC9o3Qi-AkmIA-1; Tue,
 05 Aug 2025 06:09:22 -0400
X-MC-Unique: RUj0VxQuNMC9o3Qi-AkmIA-1
X-Mimecast-MFC-AGG-ID: RUj0VxQuNMC9o3Qi-AkmIA_1754388561
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CF4B1800447; Tue,  5 Aug 2025 10:09:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.80])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3EA5F1954B06; Tue,  5 Aug 2025 10:09:18 +0000 (UTC)
Date: Tue, 5 Aug 2025 11:09:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH for-10.1 0/2] migration: actually make gnutls workaround
 functional
Message-ID: <aJHYSwGXTOF4o00n@redhat.com>
References: <20250801170212.54409-1-berrange@redhat.com>
 <d5xctfzcrtbanvkndamonxgqo3tc5nejhyrvh54m3y5bhg4cms@ue7siue2yw7o>
 <87jz3i3n0u.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jz3i3n0u.fsf@suse.de>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 04, 2025 at 04:27:45PM -0300, Fabiano Rosas wrote:
> Juraj Marcin <jmarcin@redhat.com> writes:
> 
> > Hi Daniel,
> >
> > On 2025-08-01 18:02, Daniel P. Berrangé wrote:
> >> This is a followup to previously merged patches that claimed to
> >> workaround the gnutls bug impacting migration, but in fact were
> >> essentially non-functional. Juraj Marcin pointed this out, and
> >> this new patch tweaks the workaround to make it actually do
> >> something useful.
> >> 
> >> Daniel P. Berrangé (2):
> >>   migration: simplify error reporting after channel read
> >>   migration: fix workaround for gnutls thread safety
> >> 
> >>  crypto/tlssession.c   | 16 ----------------
> >>  migration/qemu-file.c | 22 +++++++++++++++++-----
> >>  2 files changed, 17 insertions(+), 21 deletions(-)
> >> 
> >
> > thanks for finding a fix for the workaround. I have tested it and it
> > resolves the issue.
> >
> > However, it significantly slows down migration, even with the workaround
> > disabled (and thus no locking). When benchmarking, I used the fixed
> > version of GNUTLS, VM with 20GB of RAM which were fully written to
> > before starting a normal migration with no workload during the
> > migration.
> >
> > Test cases:
> > [1]: before this patchset
> > [2]: with this patchset applied and GNUTLS workaround enabled
> > [2]: with this patchset applied and GNUTLS workaround disabled
> >
> >   | Total time | Throughput | Transfered bytes |
> > --+------------+------------+------------------+
> > 1 |  31 192 ms |  5450 mpbs |   21 230 973 763 |
> > 2 |  74 147 ms |  2291 mbps |   21 232 849 066 |
> > 3 |  72 426 ms |  2343 mbps |   21 215 009 392 |
> 
> Thanks testing this. I had just managed to convince myself that there
> wouldn't be any performance issues.
> 
> The yield at every buffer fill on the incoming side is probably way more
> impactful than the poll on the RP.

Yeah, that's an unacceptable penalty on the incoming side for sure.

How about we simply change the outbound migration channel to be in
non-blocking mode ?   I originally put it in blocking mode way back
in 9e4d2b98ee98f4cee50d671e500eceeefa751ee0, but if I look at the
QEMUFile impl of qemu_fill_buffer and qemu_fflush, but should be
coping with a non-blocking socket. qemu_fill_buffer has explicit
code to wait, and qemu_fflush uses the _all() variant whcih has
built-in support for waiting. So I'm not seeing an obvious need
to run the channel in blocking mode.

Using non-blocking will prevent the return path thuread setting
in a read() call, so we won't have mutual exclusion between read
and write which this patch was trying to avoid

ie, this delta on top of this patch:

diff --git a/migration/migration.c b/migration/migration.c
index 10c216d25d..1eaabc1f19 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -4002,7 +4002,7 @@ void migration_connect(MigrationState *s, Error *error_in)
     }
 
     migration_rate_set(rate_limit);
-    qemu_file_set_blocking(s->to_dst_file, true);
+    qemu_file_set_blocking(s->to_dst_file, false);
 
     /*
      * Open the return path. For postcopy, it is used exclusively. For
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index cf6115e699..8ee44c5ac9 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -338,22 +338,6 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
         return 0;
     }
 
-    /*
-     * This feature triggers acquisition of mutexes around every
-     * read and write. Thus we must not sit in a blocking read
-     * if this is set, but must instead poll proactively. This
-     * does not work with some channel types, however, so must
-     * only pre-poll when the featre is set.
-     */
-    if (qio_channel_has_feature(f->ioc,
-                                QIO_CHANNEL_FEATURE_CONCURRENT_IO)) {
-        if (qemu_in_coroutine()) {
-            qio_channel_yield(f->ioc, G_IO_IN);
-        } else {
-            qio_channel_wait(f->ioc, G_IO_IN);
-        }
-    }
-
     do {
         struct iovec iov = { f->buf + pending, IO_BUF_SIZE - pending };
         len = qio_channel_readv_full(f->ioc, &iov, 1, pfds, pnfd, 0,


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


