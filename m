Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3002AC5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 08:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOXXD-0007bh-V2; Mon, 09 Jun 2025 04:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uOXWu-0007bJ-GM
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 04:06:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uOXWq-0001U4-9b
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 04:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749456405;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q6gOm0kvsCGQMbB2fBb4F5w8+pqLh/2dANilG9Er4kg=;
 b=BG7S9uuFkHzMKuO7U31o/NJk2fVLSb8GEtARZ3U4Inc5g2uO18/ccWqUlr2/wmh+sABtSn
 z/Mtegc+VJt+CM3S3rHZFwueTGhbxB0/wZl1dJfKgKkPu40NB02r1MbNHaFMz/92dv4qOa
 Xn4n3lCVqq5j6Jhd9uU+qL0izAexU90=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-t6y64eZpM2GAGXnkWtTkOQ-1; Mon,
 09 Jun 2025 04:06:43 -0400
X-MC-Unique: t6y64eZpM2GAGXnkWtTkOQ-1
X-Mimecast-MFC-AGG-ID: t6y64eZpM2GAGXnkWtTkOQ_1749456402
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B1761800288; Mon,  9 Jun 2025 08:06:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.45])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75F53195608F; Mon,  9 Jun 2025 08:06:39 +0000 (UTC)
Date: Mon, 9 Jun 2025 09:06:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: JAEHOON KIM <jhkim@linux.ibm.com>, qemu-devel@nongnu.org,
 jjherne@linux.ibm.com, peterx@redhat.com, farosas@suse.de
Subject: Re: [PATCH v1] migration: Wait for cpr.sock file to appear before
 connecting
Message-ID: <aEaWC_Lc6c1g821f@redhat.com>
References: <2f36bf89-9664-4552-86c0-646db01b7f1f@oracle.com>
 <2c8d3cb2-b3ee-4738-871a-0dea2bff0e84@linux.ibm.com>
 <3004c91e-d515-4e22-902c-42cea83ce64b@oracle.com>
 <760af012-1265-4845-b7d2-793fe75c3a51@linux.ibm.com>
 <aEMMjtsKZLX_Bi03@redhat.com>
 <7dc8d42d-47f1-49c1-9bff-ab2d09d0b6f3@oracle.com>
 <aEMR6Xjs8tRJ8_sp@redhat.com>
 <b2d90921-0991-4a57-a141-ad0c830f8618@oracle.com>
 <5f211f67-17f7-4b1d-a60a-4ff62645fbfa@linux.ibm.com>
 <ad638089-af36-4f3e-8f3d-61549e9bed06@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad638089-af36-4f3e-8f3d-61549e9bed06@oracle.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jun 06, 2025 at 03:37:56PM -0400, Steven Sistare wrote:
> On 6/6/2025 2:06 PM, JAEHOON KIM wrote:
> > On 6/6/2025 12:04 PM, Steven Sistare wrote:
> > > On 6/6/2025 12:06 PM, Daniel P. Berrangé wrote:
> > > > On Fri, Jun 06, 2025 at 11:50:10AM -0400, Steven Sistare wrote:
> > > > > On 6/6/2025 11:43 AM, Daniel P. Berrangé wrote:
> > > > > > On Fri, Jun 06, 2025 at 10:37:28AM -0500, JAEHOON KIM wrote:
> > > > > > > On 6/6/2025 10:12 AM, Steven Sistare wrote:
> > > > > > > > On 6/6/2025 11:06 AM, JAEHOON KIM wrote:
> > > > > > > > > On 6/6/2025 9:14 AM, Steven Sistare wrote:
> > > > > > > > > > On 6/6/2025 9:53 AM, Daniel P. Berrangé wrote:
> > > > > > > > > > > On Thu, Jun 05, 2025 at 06:08:08PM -0500, Jaehoon Kim wrote:
> > > > > > > > > > > > When the source VM attempts to connect to the destination VM's Unix
> > > > > > > > > > > > domain socket(cpr.sock) during CPR transfer, the socket
> > > > > > > > > > > > file might not
> > > > > > > > > > > > yet be exist if the destination side hasn't completed the bind
> > > > > > > > > > > > operation. This can lead to connection failures when
> > > > > > > > > > > > running tests with
> > > > > > > > > > > > the qtest framework.
> > > > > > > > > > > 
> > > > > > > > > > > This sounds like a flawed test impl to me - whatever is initiating
> > > > > > > > > > > the cpr operation on the source has done so prematurely - it should
> > > > > > > > > > > ensure the dest is ready before starting the operation.
> > > > > > > > > > > 
> > > > > > > > > > > > To address this, add cpr_validate_socket_path(), which wait for the
> > > > > > > > > > > > socket file to appear. This avoids intermittent qtest
> > > > > > > > > > > > failures caused by
> > > > > > > > > > > > early connection attempts.
> > > > > > > > > > > 
> > > > > > > > > > > IMHO it is dubious to special case cpr in this way.
> > > > > > > > > > 
> > > > > > > > > > I agree with Daniel, and unfortunately it is not just a test issue;
> > > > > > > > > > every management framework that supports cpr-transfer must add logic to
> > > > > > > > > > wait for the cpr socket to appear in the target before proceeding.
> > > > > > > > > > 
> > > > > > > > > > This is analogous to waiting for the monitor socket to appear before
> > > > > > > > > > connecting to it.
> > > > > > > > > > 
> > > > > > > > > > - Steve
> > > > > > > > > 
> > > > > > > > > Thank you very much for your valuable review and feedback.
> > > > > > > > > 
> > > > > > > > > Just to clarify, the added cpr_validate_socket_path() function is
> > > > > > > > > not limited to the test framework.
> > > > > > > > > It is part of the actual CPR implementation and is intended to
> > > > > > > > > ensure correct behavior in all cases, including outside of tests.
> > > > > > > > > 
> > > > > > > > > I mentioned the qtest failure simply as an example where this issue
> > > > > > > > > became apparent.
> > > > > > > > 
> > > > > > > > Yes, I understand that you understand :)
> > > > > > > > Are you willing to move your fix to the qtest?
> > > > > > > > 
> > > > > > > > - Steve
> > > > > > > 
> > > > > > > Thank you for your question and feedback.
> > > > > > > 
> > > > > > > I agree that the issue could be addressed within the qtest framework to
> > > > > > > improve stability.
> > > > > > > 
> > > > > > > However, this socket readiness check is a fundamental part of CPR transfer
> > > > > > > process,
> > > > > > > and I believe that incorporating cpr_validate_socket_path() directly into
> > > > > > > the CPR implementation helps ensure more reliable behavior
> > > > > > > across all environments - not only during testing.
> > > > > > > 
> > > > > > > Just from my perspective, adding this logic to the CPR code does not
> > > > > > > introduce significant overhead or side effects.
> > > > > > > I would appreciate if you could share more details about your concerns, so I
> > > > > > > can better address them.
> > > > > > 
> > > > > > Requiring a busy wait like this is a sign of a design problem.
> > > > > > 
> > > > > > There needs to be a way to setup the incoming socket listener
> > > > > > without resorting to busy waiting - that's showing a lack of
> > > > > > synchronization.
> > > > > 
> > > > > How is this a design problem?  If I start a program that creates a listening unix
> > > > > domain socket, I cannot attempt to connect to it until the socket is created and
> > > > > listening. Clients face the same issue when starting qemu and connecting to the
> > > > > monitor socket.
> > > > 
> > > > Yes, the monitor has the same conceptual problem, and this caused problems
> > > > for libvirt starting QEMU for many years.
> > > > 
> > > > With the busy wait you risk looping forever if the child (target) QEMU
> > > > already exited for some reason without ever creating the socket. You
> > > > can mitigate this by using 'kill($PID, 0)' in the loop and looking
> > > > for -ERSCH, but this only works if you know the pid involved.
> > > > 
> > > > One option is to use 'daemonize' such that when the parent sees the initial
> > > > QEMU process leader exit, the parent has a guarantee that the daemonized
> > > > QEMU already has the UNIX listener open, and any failure indicates QEMU
> > > > already quit.
> > > > 
> > > > The other option is to use FD passing such that QEMU is not responsible
> > > > for opening the listener socket - it gets passed a pre-opened listener
> > > > FD, so the parent has a guarantee it can successfull connect immediately
> > > > and any failure indicates QEMU already quit.
> > > > 
> > > > For the tests, passing a pre-opened UNIX socket FD could work, but I'm
> > > > still curious why this is only a problem for the CPR tests, and not
> > > > the other migration tests which don't use 'defer'. What has made CPR
> > > > special to expose a race ?
> > > 
> > > For normal migration, target qemu listens on the migration socket, then listens
> > > on the monitor.  After the client connects to the monitor (waiting for it to appear
> > > as needed), them the migration socket already exists.
> > > 
> > > For cpr, target qemu creates the cpr socket and listens before the monitor is
> > > started, which is necessary because cpr state is needed before backends or
> > > devices are created.
> > > 
> > > A few months back I sent a series to start the monitor first (I think I called
> > > it the precreate phase), but it was derailed over discussions about allowing
> > > qemu to start with no arguments and be configured exclusively via the monitor.
> > > 
> > > - Steve
> > 
> > Thank you for sharing your thoughts.
> > 
> > I agree that busy waiting is not ideal.
> > However, considering the timing of when target QEMU creates and begins listening on the socket,
> > I think there is currently no reliable way for the host to check the socket's listening state.
> > This also implies that FD passing is not a viable option in this case.
> > 
> > As for the 'defer' option in qtest,
> > it doesn't cause race-condition issues because the target enters the listening state during the option processing.
> > 
> > Of course, to address this issue,
> > I could create a wait_for_socket() function similar to wait_for_serial() in qtest framework.
> > Since the socket might already be created, I cannot simply wait for the file to appear using file system notification APIs like inotify,
> > so busy-waiting would still be necessary.
> > 
> > I would appreciate hearing any further thoughts you might have on this.
> 
> The easiest solution, with no interface changes, is adding wait_for_socket() in qtest,
> with this addition from Daniel:
> 
>   "With the busy wait you risk looping forever if the child (target) QEMU
>   already exited for some reason without ever creating the socket. You
>   can mitigate this by using 'kill($PID, 0)' in the loop and looking
>   for -ERSCH, but this only works if you know the pid involved."
> 
> Daniel also suggested:
>   "For the tests, passing a pre-opened UNIX socket FD could work"
> 
> Note we can not use any of the standard chardev options to specify such a socket,
> because the cpr socket is created before chardevs are created.
> 
> Perhaps we could specify the fd in an extension of the MigrationChannel MigrationAddress.
> { 'union': 'MigrationAddress',
>   'base': { 'transport' : 'MigrationAddressType'},
>   'discriminator': 'transport',
>   'data': {
>     'socket': 'SocketAddress',
>     'exec': 'MigrationExecCommand',
>     'rdma': 'InetSocketAddress',
>     'file': 'FileMigrationArgs',
>     'fd':   'FdMigrationArgs' } }           <-- add this
> 
> That would be useful for all clients, but this is asking a lot from you,
> when you are just trying to fix the tests.

Note, 'SocketAddress' already has an option for declaring a FD that
represents a socket.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


