Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C7CCCF9E4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 15:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stU0I-0002an-Kg; Wed, 25 Sep 2024 11:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1stU0H-0002aF-DX
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:32:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1stU0E-0003Aa-U3
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727278349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SA3khWCJtd2Yt26eALpsIUkM9FfCr4q0RNLGPS6r/WU=;
 b=RUw9csBScB9V3AXHpU4Ie7YSrk/mbmVnQBUKyZIKKAeKh6GYkXNKS71do7mVBe2gTNLjfF
 YYbQOWmyrnrr/6+t8mfHzvBGby6AbqpyBcuH81tDsDGiIGqJQxhGyDdxphRpN84WbXVXPQ
 yrw7BjFDgTRka2yhZmVHYc0NAquLw7M=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-2bbkw_IrOnaFNPSvLVZKBw-1; Wed, 25 Sep 2024 11:32:27 -0400
X-MC-Unique: 2bbkw_IrOnaFNPSvLVZKBw-1
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-3a0cd6a028bso55780055ab.0
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 08:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727278345; x=1727883145;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SA3khWCJtd2Yt26eALpsIUkM9FfCr4q0RNLGPS6r/WU=;
 b=TcXHfCuPYb0cKOasrH6UGmPBJ8O0Cx3CK/w0PXou2x1E6SiZdvkJ3ajcU5Tht63w+1
 4sPLRsiNeqamYuQLw5Sa8SF6or8agm608PM4gARucuPwKpdI4gAFwzapzyOgS26EKAND
 EeDblaHgW8C2oToBFY8owgZRHdE2ItrvzJ0V+tOnIMxFDFZnZyelb8oWqL9GK9C7k7LZ
 oEvsNLqKikNsEPbJZU5/UA3cKbSCJi3J/itckL4Iv5+l8Zi+mXm6RUiyYVnJtZLgx/7E
 bxaYEmxnWicYV48WXzL/o05jt7+zIAKyP/7L9/Kb3Camj/+HyNXxtvQ8HtP5x40yVawR
 0O+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0XpPqrOjM+i3ru4f2WeOtzBphlXI5UJiW/KMhany/dtMD3AV7xqlGfss3RhXAHX8hNHFNPsB4KXsk@nongnu.org
X-Gm-Message-State: AOJu0YzXIHOkYNbdT4eosd1WzlX9fp6YXkU3PnPMt8gILJ4KSw7s8+77
 +CPwUhf4SyecigpNwYgpIfRemhEAvfdpCpyKdYp99vskcmHaiJ1Hx0AMb9aLbRnPrVJAZsZV1o/
 O9Um2vGq/tHJpvLhkHqQAJfOuNjHKsuLPxmIbxL9QQ7uq3ccmfWnW
X-Received: by 2002:a05:6e02:1aaf:b0:39f:53b3:ca63 with SMTP id
 e9e14a558f8ab-3a26d6f972dmr35920565ab.3.1727278345366; 
 Wed, 25 Sep 2024 08:32:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOyJfD+G1NilbaoBdg+uQkRiuoCy7mZLo539TJDam5rB8b43dbhJflsbr2FwK4SJjPjNumlQ==
X-Received: by 2002:a05:6e02:1aaf:b0:39f:53b3:ca63 with SMTP id
 e9e14a558f8ab-3a26d6f972dmr35920225ab.3.1727278344875; 
 Wed, 25 Sep 2024 08:32:24 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e6b7c7cd40sm2870302a12.88.2024.09.25.08.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 08:32:24 -0700 (PDT)
Date: Wed, 25 Sep 2024 11:32:21 -0400
From: Peter Xu <peterx@redhat.com>
To: Yuchen <yu.chen@h3c.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRD?=
 =?utf-8?Q?H=5D_migration=2Fmultifd?= =?utf-8?Q?=3A?= receive channel socket
 needs to be set to non-blocking
Message-ID: <ZvQtBYENrSlLAWit@x1n>
References: <37febc26060949f891aedea01de724fc@h3c.com> <Zu2aYw4BOXE4KXQG@x1n>
 <28e81cd8edfd4aaa9e6648e742f37d45@h3c.com>
 <ZvGeRLOWJc7-E_cr@redhat.com>
 <88ce6d7a8a4f4b7088f9c6194a83db22@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88ce6d7a8a4f4b7088f9c6194a83db22@h3c.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Sep 24, 2024 at 08:25:22AM +0000, Yuchen wrote:
> 
> 
> > -----邮件原件-----
> > 发件人: Daniel P. Berrangé <berrange@redhat.com>
> > 发送时间: 2024年9月24日 0:59
> > 收件人: yuchen (CCSPL) <yu.chen@h3c.com>
> > 抄送: Peter Xu <peterx@redhat.com>; farosas@suse.de;
> > qemu-devel@nongnu.org
> > 主题: Re: 回复: [PATCH] migration/multifd: receive channel socket needs to
> > be set to non-blocking
> >
> > On Mon, Sep 23, 2024 at 01:33:13AM +0000, Yuchen wrote:
> > >
> > >
> > > > -----邮件原件-----
> > > > 发件人: Peter Xu <peterx@redhat.com>
> > > > 发送时间: 2024年9月20日 23:53
> > > > 收件人: yuchen (CCSPL) <yu.chen@h3c.com>
> > > > 抄送: farosas@suse.de; qemu-devel@nongnu.org
> > > > 主题: Re: [PATCH] migration/multifd: receive channel socket needs to
> > > > be set to non-blocking
> > > >
> > > > On Fri, Sep 20, 2024 at 10:05:42AM +0000, Yuchen wrote:
> > > > > When the migration network is disconnected, the source qemu can
> > > > > exit normally with an error, but the destination qemu is always
> > > > > blocked in recvmsg(), causes the destination qemu main thread to be
> > blocked.
> > > > >
> > > > > The destination qemu block stack:
> > > > > Thread 13 (Thread 0x7f0178bfa640 (LWP 1895906) "multifdrecv_6"):
> > > > > #0  0x00007f041b5af56f in recvmsg ()
> > > > > #1  0x000055573ebd0b42 in qio_channel_socket_readv
> > > > > #2  0x000055573ebce83f in qio_channel_readv
> > > > > #3  qio_channel_readv_all_eof
> > > > > #4  0x000055573ebce909 in qio_channel_readv_all
> > > > > #5  0x000055573eaa1b1f in multifd_recv_thread
> > > > > #6  0x000055573ec2f0b9 in qemu_thread_start
> > > > > #7  0x00007f041b52bf7a in start_thread
> > > > > #8  0x00007f041b5ae600 in clone3
> > > > >
> > > > > Thread 1 (Thread 0x7f0410c62240 (LWP 1895156) "kvm"):
> > > > > #0  0x00007f041b528ae2 in __futex_abstimed_wait_common ()
> > > > > #1  0x00007f041b5338b8 in __new_sem_wait_slow64.constprop.0
> > > > > #2  0x000055573ec2fd34 in qemu_sem_wait (sem=0x555742b5a4e0)
> > > > > #3  0x000055573eaa2f09 in multifd_recv_sync_main ()
> > > > > #4  0x000055573e7d590d in ram_load_precopy
> > > > (f=f@entry=0x555742291c20)
> > > > > #5  0x000055573e7d5cbf in ram_load (opaque=<optimized out>,
> > > > > version_id=<optimized out>, f=0x555742291c20)
> > > > > #6  ram_load_entry (f=0x555742291c20, opaque=<optimized out>,
> > > > > version_id=<optimized out>)
> > > > > #7  0x000055573ea932e7 in qemu_loadvm_section_part_end
> > > > > (mis=0x555741136c00, f=0x555742291c20)
> > > > > #8  qemu_loadvm_state_main (f=f@entry=0x555742291c20,
> > > > > mis=mis@entry=0x555741136c00)
> > > > > #9  0x000055573ea94418 in qemu_loadvm_state (f=0x555742291c20,
> > > > > mode=mode@entry=VMS_MIGRATE)
> > > > > #10 0x000055573ea88be1 in process_incoming_migration_co
> > > > > (opaque=<optimized out>)
> > > > > #11 0x000055573ec43d13 in coroutine_trampoline (i0=<optimized
> > > > > out>, i1=<optimized out>)
> > > > > #12 0x00007f041b4f5d90 in ?? () from target:/usr/lib64/libc.so.6
> > > > > #13 0x00007ffc11890270 in ?? ()
> > > > > #14 0x0000000000000000 in ?? ()
> > > > >
> > > > > Setting the receive channel to non-blocking can solve the problem.
> > > >
> > > > Multifd threads are real threads and there's no coroutine, I'm
> > > > slightly confused why it needs to use nonblock.
> > > >
> > > > Why recvmsg() didn't get kicked out when disconnect?  Is it a
> > > > generic Linux kernel are you using?
> > > >
> > > My steps to reproduce:
> > > ifdown migration network, or disable migration network using iptables.
> > > The probability of recurrence of these two methods is very high.
> > >
> > > My test environment uses is linux-5.10.136.
> > >
> > > multifd thread block in kernel:
> > > # cat /proc/3416190/stack
> > > [<0>] wait_woken+0x43/0x80
> > > [<0>] sk_wait_data+0x123/0x140
> > > [<0>] tcp_recvmsg+0x4f8/0xa50
> > > [<0>] inet6_recvmsg+0x5e/0x120
> > > [<0>] ____sys_recvmsg+0x87/0x180
> > > [<0>] ___sys_recvmsg+0x82/0x110
> > > [<0>] __sys_recvmsg+0x56/0xa0
> > > [<0>] do_syscall_64+0x3d/0x80
> > > [<0>] entry_SYSCALL_64_after_hwframe+0x61/0xc6
> > >
> > > > I wonder whether that's the expected behavior for sockets.  E.g., we
> > > > do have multifd/cancel test (test_multifd_tcp_cancel) and I think
> > > > that runs this path too with it always in block mode as of now..
> > > >
> > > My previous statement may not be accurate. The migration network socket is
> > not disconnected.
> > > I use ifdown or iptables to simulate the network card failure.
> > > Because the TCP connection was not disconnected, so recvmsg() was
> > blocked.
> >
> > How long did you wait after doing ifdown ?   TCP is intended to wait if
> 
> I waited about 15 minutes, the source qemu migration threads quit, but
> the destination qemu migration threads is still there.
> 
> > there is an interruption.... only eventually after relevant TCP timeouts are hit, it
> > will terminate the connection.  QEMU shouldn't proactively give up if the TCP
> > conn is still in an active state as reported by the kernel, even if traffic isn't
> > currently flowing.
> >
> >
> 
> Daniel, I agree with what you said, But in fact, the destination migration connection is not disconnected
> and is in the close wait state.
> 
> The source qemu process lsof and top:
> # lsof -p 384509
> ...
> kvm     384509 root  112u     sock                0,8         0t0 157321811 protocol: TCP
> kvm     384509 root  113u     sock                0,8         0t0 157321813 protocol: TCP
> kvm     384509 root  114u     sock                0,8         0t0 157321815 protocol: TCP
> kvm     384509 root  115u     sock                0,8         0t0 157321817 protocol: TCP
> kvm     384509 root  116u     sock                0,8         0t0 157321819 protocol: TCP
> kvm     384509 root  117u     sock                0,8         0t0 157321821 protocol: TCP
> kvm     384509 root  118u     sock                0,8         0t0 157321823 protocol: TCP
> kvm     384509 root  119u     sock                0,8         0t0 157321825 protocol: TCP
> 
> # top -H -p 384509
> top - 15:10:22 up 5 days, 18:54,  3 users,  load average: 5.16, 4.61, 4.50
> Threads:   8 total,   3 running,   5 sleeping,   0 stopped,   0 zombie
> %Cpu(s):  5.2 us,  5.2 sy,  0.0 ni, 89.3 id,  0.0 wa,  0.1 hi,  0.1 si,  0.0 st
> MiB Mem : 128298.7 total,  41490.2 free,  89470.2 used,   2168.0 buff/cache
> MiB Swap:  42922.0 total,  42910.4 free,     11.6 used.  38828.5 avail Mem
>     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>  384596 root      20   0   11.9g  93516  40112 R  98.7   0.1 261:13.24 CPU 1/KVM
>  384595 root      20   0   11.9g  93516  40112 R  98.0   0.1  56:44.31 CPU 0/KVM
>  384509 root      20   0   11.9g  93516  40112 R   1.3   0.1   7:38.73 kvm
>  384563 root      20   0   11.9g  93516  40112 S   0.0   0.1   0:00.05 kvm
>  384598 root      20   0   11.9g  93516  40112 S   0.0   0.1   0:01.00 vnc_worker
> 1544593 root      20   0   11.9g  93516  40112 S   0.0   0.1   0:00.00 worker
> 
> The destination qemu process lsof and top:
> # lsof -p 3236693
> kvm     3236693 root   29u     IPv6          159227758         0t0       TCP node18:49156->2.2.2.6:41880 (CLOSE_WAIT)
> kvm     3236693 root   30u     IPv6          159227759         0t0       TCP node18:49156->2.2.2.6:41890 (ESTABLISHED)
> kvm     3236693 root   31u     IPv6          159227760         0t0       TCP node18:49156->2.2.2.6:41902 (ESTABLISHED)
> kvm     3236693 root   32u     IPv6          159227762         0t0       TCP node18:49156->2.2.2.6:41912 (ESTABLISHED)
> kvm     3236693 root   33u     IPv6          159227761         0t0       TCP node18:49156->2.2.2.6:41904 (ESTABLISHED)
> kvm     3236693 root   34u     IPv6          159227763         0t0       TCP node18:49156->2.2.2.6:41918 (ESTABLISHED)
> kvm     3236693 root   35u     IPv6          159227764         0t0       TCP node18:49156->2.2.2.6:41924 (ESTABLISHED)
> kvm     3236693 root   36u     IPv6          159227765         0t0       TCP node18:49156->2.2.2.6:41934 (ESTABLISHED)
> kvm     3236693 root   37u     IPv6          159227766         0t0       TCP node18:49156->2.2.2.6:41942 (ESTABLISHED)
> 
> # top -H -p 3236693
> top - 15:09:25 up 5 days, 19:12,  2 users,  load average: 0.63, 0.68, 0.89
> Threads:  15 total,   0 running,  15 sleeping,   0 stopped,   0 zombie
> %Cpu(s):  1.3 us,  0.5 sy,  0.0 ni, 98.1 id,  0.0 wa,  0.0 hi,  0.1 si,  0.0 st
> MiB Mem : 128452.1 total,  43515.4 free,  87291.7 used,   2527.4 buff/cache
> MiB Swap:  42973.0 total,  42968.4 free,      4.6 used.  41160.4 avail Mem
>     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
> 3236693 root      20   0   11.3g 100192  38508 S   0.0   0.1   0:00.41 kvm
> 3236714 root      20   0   11.3g 100192  38508 S   0.0   0.1   0:00.00 kvm
> 3236745 root      20   0   11.3g 100192  38508 S   0.0   0.1   0:00.00 CPU 0/KVM
> 3236746 root      20   0   11.3g 100192  38508 S   0.0   0.1   0:00.00 CPU 1/KVM
> 3236748 root      20   0   11.3g 100192  38508 S   0.0   0.1   0:00.00 vnc_worker
> 3236750 root      20   0   11.3g 100192  38508 S   0.0   0.1   0:01.45 multifdrecv_4
> 3236751 root      20   0   11.3g 100192  38508 S   0.0   0.1   0:01.42 multifdrecv_5
> 3236752 root      20   0   11.3g 100192  38508 S   0.0   0.1   0:01.35 multifdrecv_6
> 3236753 root      20   0   11.3g 100192  38508 S   0.0   0.1   0:01.49 multifdrecv_7
> 3236754 root      20   0   11.3g 100192  38508 S   0.0   0.1   0:01.45 multifdrecv_1
> 3236755 root      20   0   11.3g 100192  38508 S   0.0   0.1   0:01.43 multifdrecv_2
> 3236756 root      20   0   11.3g 100192  38508 S   0.0   0.1   0:01.45 multifdrecv_3
> 3236757 root      20   0   11.3g 100192  38508 S   0.0   0.1   0:01.44 multifdrecv_0
> 
> So we should still set the multifd channel socket to non-blocking ?

Have you looked at why the timeout didn't work?

After all, QEMU is not the only application that uses recvmsg() like this,
so I wonder whether it's intended or it's a kernel bug that recvmsg()
didn't get kicked out.

> 
> > With regards,
> > Daniel
> > --
> > |: https://berrange.com      -o-
> > https://www.flickr.com/photos/dberrange :|
> > |: https://libvirt.org         -o-
> > https://fstop138.berrange.com :|
> > |: https://entangle-photo.org    -o-
> > https://www.instagram.com/dberrange :|
> 
> -------------------------------------------------------------------------------------------------------------------------------------
> 本邮件及其附件含有新华三集团的保密信息，仅限于发送给上面地址中列出
> 的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制、
> 或散发）本邮件中的信息。如果您错收了本邮件，请您立即电话或邮件通知发件人并删除本
> 邮件！
> This e-mail and its attachments contain confidential information from New H3C, which is
> intended only for the person or entity whose address is listed above. Any use of the
> information contained herein in any way (including, but not limited to, total or partial
> disclosure, reproduction, or dissemination) by persons other than the intended
> recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender
> by phone or email immediately and delete it!

-- 
Peter Xu


