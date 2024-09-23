Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9651CF9C72
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 16:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssmOw-00012q-Qf; Mon, 23 Sep 2024 12:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ssmOt-00012L-C5
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:59:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ssmOl-0004OT-Kq
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727110734;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=axNm1FVkvoverFiwquTeH8yGt4zB6H2vK8F6S4RQCCA=;
 b=FtexzPoSmPPefxiVaKIucXEK/CYzajlYkqKybDs8HC768NZt1yx9BzA67/QF0gjt7POBwb
 dT0SkUuzdXINRw8nV17RBpKPxWKflijOfNl2FDF20byb3dlri5mfXKnQUTn/XJFHK+WLFo
 a/0MShNNy9e0k6A+V+jr3yoQeQJVN7U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-JQt6dGXENg-BXjBbuwjFCA-1; Mon,
 23 Sep 2024 12:58:52 -0400
X-MC-Unique: JQt6dGXENg-BXjBbuwjFCA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8DF1719300E6; Mon, 23 Sep 2024 16:58:51 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.47])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE1D0195608A; Mon, 23 Sep 2024 16:58:48 +0000 (UTC)
Date: Mon, 23 Sep 2024 18:58:44 +0200
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yuchen <yu.chen@h3c.com>
Cc: Peter Xu <peterx@redhat.com>, "farosas@suse.de" <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIG1pZ3Jh?=
 =?utf-8?Q?tion=2Fmultifd?= =?utf-8?Q?=3A?= receive channel socket needs to
 be set to non-blocking
Message-ID: <ZvGeRLOWJc7-E_cr@redhat.com>
References: <37febc26060949f891aedea01de724fc@h3c.com> <Zu2aYw4BOXE4KXQG@x1n>
 <28e81cd8edfd4aaa9e6648e742f37d45@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28e81cd8edfd4aaa9e6648e742f37d45@h3c.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Sep 23, 2024 at 01:33:13AM +0000, Yuchen wrote:
> 
> 
> > -----邮件原件-----
> > 发件人: Peter Xu <peterx@redhat.com>
> > 发送时间: 2024年9月20日 23:53
> > 收件人: yuchen (CCSPL) <yu.chen@h3c.com>
> > 抄送: farosas@suse.de; qemu-devel@nongnu.org
> > 主题: Re: [PATCH] migration/multifd: receive channel socket needs to be set to
> > non-blocking
> > 
> > On Fri, Sep 20, 2024 at 10:05:42AM +0000, Yuchen wrote:
> > > When the migration network is disconnected, the source qemu can exit
> > > normally with an error, but the destination qemu is always blocked in
> > > recvmsg(), causes the destination qemu main thread to be blocked.
> > >
> > > The destination qemu block stack:
> > > Thread 13 (Thread 0x7f0178bfa640 (LWP 1895906) "multifdrecv_6"):
> > > #0  0x00007f041b5af56f in recvmsg ()
> > > #1  0x000055573ebd0b42 in qio_channel_socket_readv
> > > #2  0x000055573ebce83f in qio_channel_readv
> > > #3  qio_channel_readv_all_eof
> > > #4  0x000055573ebce909 in qio_channel_readv_all
> > > #5  0x000055573eaa1b1f in multifd_recv_thread
> > > #6  0x000055573ec2f0b9 in qemu_thread_start
> > > #7  0x00007f041b52bf7a in start_thread
> > > #8  0x00007f041b5ae600 in clone3
> > >
> > > Thread 1 (Thread 0x7f0410c62240 (LWP 1895156) "kvm"):
> > > #0  0x00007f041b528ae2 in __futex_abstimed_wait_common ()
> > > #1  0x00007f041b5338b8 in __new_sem_wait_slow64.constprop.0
> > > #2  0x000055573ec2fd34 in qemu_sem_wait (sem=0x555742b5a4e0)
> > > #3  0x000055573eaa2f09 in multifd_recv_sync_main ()
> > > #4  0x000055573e7d590d in ram_load_precopy
> > (f=f@entry=0x555742291c20)
> > > #5  0x000055573e7d5cbf in ram_load (opaque=<optimized out>,
> > > version_id=<optimized out>, f=0x555742291c20)
> > > #6  ram_load_entry (f=0x555742291c20, opaque=<optimized out>,
> > > version_id=<optimized out>)
> > > #7  0x000055573ea932e7 in qemu_loadvm_section_part_end
> > > (mis=0x555741136c00, f=0x555742291c20)
> > > #8  qemu_loadvm_state_main (f=f@entry=0x555742291c20,
> > > mis=mis@entry=0x555741136c00)
> > > #9  0x000055573ea94418 in qemu_loadvm_state (f=0x555742291c20,
> > > mode=mode@entry=VMS_MIGRATE)
> > > #10 0x000055573ea88be1 in process_incoming_migration_co
> > > (opaque=<optimized out>)
> > > #11 0x000055573ec43d13 in coroutine_trampoline (i0=<optimized out>,
> > > i1=<optimized out>)
> > > #12 0x00007f041b4f5d90 in ?? () from target:/usr/lib64/libc.so.6
> > > #13 0x00007ffc11890270 in ?? ()
> > > #14 0x0000000000000000 in ?? ()
> > >
> > > Setting the receive channel to non-blocking can solve the problem.
> > 
> > Multifd threads are real threads and there's no coroutine, I'm slightly confused
> > why it needs to use nonblock.
> > 
> > Why recvmsg() didn't get kicked out when disconnect?  Is it a generic Linux
> > kernel are you using?
> > 
> My steps to reproduce:
> ifdown migration network, or disable migration network using iptables. 
> The probability of recurrence of these two methods is very high.
> 
> My test environment uses is linux-5.10.136.
> 
> multifd thread block in kernel:
> # cat /proc/3416190/stack 
> [<0>] wait_woken+0x43/0x80
> [<0>] sk_wait_data+0x123/0x140
> [<0>] tcp_recvmsg+0x4f8/0xa50
> [<0>] inet6_recvmsg+0x5e/0x120
> [<0>] ____sys_recvmsg+0x87/0x180
> [<0>] ___sys_recvmsg+0x82/0x110
> [<0>] __sys_recvmsg+0x56/0xa0
> [<0>] do_syscall_64+0x3d/0x80
> [<0>] entry_SYSCALL_64_after_hwframe+0x61/0xc6
> 
> > I wonder whether that's the expected behavior for sockets.  E.g., we do have
> > multifd/cancel test (test_multifd_tcp_cancel) and I think that runs this path too
> > with it always in block mode as of now..
> > 
> My previous statement may not be accurate. The migration network socket is not disconnected. 
> I use ifdown or iptables to simulate the network card failure. 
> Because the TCP connection was not disconnected, so recvmsg() was blocked.

How long did you wait after doing ifdown ?   TCP is intended to wait if
there is an interruption.... only eventually after relevant TCP timeouts
are hit, it will terminate the connection.  QEMU shouldn't proactively
give up if the TCP conn is still in an active state as reported by the
kernel, even if traffic isn't currently flowing.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


