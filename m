Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DCEC5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 13:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOcRA-0004sG-Ds; Mon, 09 Jun 2025 09:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uOcR5-0004rf-VX
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 09:21:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uOcR3-0007I1-04
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 09:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749475266;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ot59GsmA0h1+ooIuG8wBIHrM4zzwGkJA1OziySa4kA=;
 b=Ukx4k2n++GOxeiIhqJWKyYjJL+RCAU8fxFI3X2E335tPyzHg8JNLbuWwre9nLxMp/3kJqD
 spFye+9FSJRkfhmc/sx+X44yfA8TDfDiLqIQ6N2b4HR8ujfMXOqHjebOa5fwxg+FBK5aUG
 xL4hD/7jiBF1iUGqF/jqPthb/x6+ZNE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-r6ENYNb1POClnLOHwrqjSw-1; Mon,
 09 Jun 2025 09:21:03 -0400
X-MC-Unique: r6ENYNb1POClnLOHwrqjSw-1
X-Mimecast-MFC-AGG-ID: r6ENYNb1POClnLOHwrqjSw_1749475262
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3170619560A2; Mon,  9 Jun 2025 13:21:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.45])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B198B180045C; Mon,  9 Jun 2025 13:20:59 +0000 (UTC)
Date: Mon, 9 Jun 2025 14:20:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: JAEHOON KIM <jhkim@linux.ibm.com>, qemu-devel@nongnu.org,
 jjherne@linux.ibm.com, peterx@redhat.com, farosas@suse.de
Subject: Re: [PATCH v1] migration: Wait for cpr.sock file to appear before
 connecting
Message-ID: <aEbfuM681MJh2S-b@redhat.com>
References: <3004c91e-d515-4e22-902c-42cea83ce64b@oracle.com>
 <760af012-1265-4845-b7d2-793fe75c3a51@linux.ibm.com>
 <aEMMjtsKZLX_Bi03@redhat.com>
 <7dc8d42d-47f1-49c1-9bff-ab2d09d0b6f3@oracle.com>
 <aEMR6Xjs8tRJ8_sp@redhat.com>
 <b2d90921-0991-4a57-a141-ad0c830f8618@oracle.com>
 <5f211f67-17f7-4b1d-a60a-4ff62645fbfa@linux.ibm.com>
 <ad638089-af36-4f3e-8f3d-61549e9bed06@oracle.com>
 <aEaWC_Lc6c1g821f@redhat.com>
 <f46393bb-115a-489f-aa8d-08348e89d25e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f46393bb-115a-489f-aa8d-08348e89d25e@oracle.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 09, 2025 at 09:12:27AM -0400, Steven Sistare wrote:
> On 6/9/2025 4:06 AM, Daniel P. Berrangé wrote:
> > On Fri, Jun 06, 2025 at 03:37:56PM -0400, Steven Sistare wrote:
> > > 
> > > The easiest solution, with no interface changes, is adding wait_for_socket() in qtest,
> > > with this addition from Daniel:
> > > 
> > >    "With the busy wait you risk looping forever if the child (target) QEMU
> > >    already exited for some reason without ever creating the socket. You
> > >    can mitigate this by using 'kill($PID, 0)' in the loop and looking
> > >    for -ERSCH, but this only works if you know the pid involved."
> > > 
> > > Daniel also suggested:
> > >    "For the tests, passing a pre-opened UNIX socket FD could work"
> > > 
> > > Note we can not use any of the standard chardev options to specify such a socket,
> > > because the cpr socket is created before chardevs are created.
> > > 
> > > Perhaps we could specify the fd in an extension of the MigrationChannel MigrationAddress.
> > > { 'union': 'MigrationAddress',
> > >    'base': { 'transport' : 'MigrationAddressType'},
> > >    'discriminator': 'transport',
> > >    'data': {
> > >      'socket': 'SocketAddress',
> > >      'exec': 'MigrationExecCommand',
> > >      'rdma': 'InetSocketAddress',
> > >      'file': 'FileMigrationArgs',
> > >      'fd':   'FdMigrationArgs' } }           <-- add this
> > > 
> > > That would be useful for all clients, but this is asking a lot from you,
> > > when you are just trying to fix the tests.
> > 
> > Note, 'SocketAddress' already has an option for declaring a FD that
> > represents a socket.
> 
> Yes, but if I understand, you proposed passing an fd that represents a
> pre-listened socket, which requires target qemu to accept() first.  The
> existing FdSocketAddress is ready to read.  We could add a boolean to enable
> the new behavior.

It can do both actually - it depends on what APIs the QEMU uses the
SocketAddress with.

If it is used with qio_channel_socket_connect* the FD must be an
active peer connection.

If it is used with qio_channel_socket_listen*/qio_net_listener* the
FD must be listener socket.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


