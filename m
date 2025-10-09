Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3130CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 16:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6tyb-0000cI-Rb; Thu, 09 Oct 2025 12:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v6tyO-0000Sn-4C
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:58:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v6tyE-00072i-Sr
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760029101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iRBp7pvyn7+3A0nl920ZvT3yLlCsEma8MAwmOKe3OdE=;
 b=PXYGIMPA3/0iRlTaZvdSj3A607Nv3WhSHAw6tDe0gZp1Ngf3svS3CMgwsgfj+qajW5XPZk
 v/CuBzi5wTAxyKVtrXtpFhU9+K1qVd3jvv3GNY/Sebkk4TeZ86sgHNHUvtsAXPgJJHN5W3
 kwRXs2leybGJtyhpiJXsa4fP718eqVs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-jI-dFarmPEaQLZVDS5uSaQ-1; Thu, 09 Oct 2025 12:58:20 -0400
X-MC-Unique: jI-dFarmPEaQLZVDS5uSaQ-1
X-Mimecast-MFC-AGG-ID: jI-dFarmPEaQLZVDS5uSaQ_1760029099
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8787a94467cso41389646d6.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 09:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760029099; x=1760633899;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iRBp7pvyn7+3A0nl920ZvT3yLlCsEma8MAwmOKe3OdE=;
 b=Wi52426f3re1rivpvUoq6mRrefhcWifd5E2aRg/URNQIrgFzzhNCcsfhO4NpfX7AVI
 CJkwwgg7kUsaQoxcMqwq2x1s87eEfK87bHT2EtjSDScRE+6/7KIhD1o404pKhP8JwpEn
 66fsKWQ2KInDUslZ21UK+py9USYytrH5Kx0/FcPxCsEQPnGESzXdhE9ZGeZxZE8OzpVS
 MzasLyKp+wtO/n4NnI1y2WxBJP175Xd1xl1anSHQ4cDhNZ7PAwGHc53m9021Vm3I7VmJ
 /wXMMBktSNQ32aLe4qds1UpSWdklz15awhvmf41lzDxbDjRcBggc9Mj4M25kj9zZNjd5
 JBng==
X-Gm-Message-State: AOJu0YzxTXTD6QIYavcjfXzOFa2HwddCPWGqs74qRhmN3tYaBo/drrvk
 wVkxdSn8axtkLFJW43BHFPxXPV/Rg0JQ6Gc0lDWkdypE3iP9CiFhn0Y8LkcfyuvF+WwM1GCkvPd
 SooBLiOg4UnsBmcyPdyet3TOH7wXLHkyYvqxjks3mMHNYRLa/rZgot02d
X-Gm-Gg: ASbGncuKaABd1lM+Zk7jIzKbZmUI/q4I5kEEJlETyJiH1LZxrdqBn7QqEvU1Gbs4jpL
 iDP1Pe2e5YjaoHU5T11Koa0gmdRUPjiI/AN73FAsmMkNuBlvoiYrCRNFyNZXTT0bbgpC2pL5Qr6
 f+RhwCUQb4CkXTYYAL4VnpyXa6Rmfol9BXKqVVP5CI/dyGzeDWA48z8v3uUjs4xwX8c6KeJLC/2
 pa9P9v1QHva36flFnIH+O/An4hFG6QuyiCpRwUe5nYz1TWq0HLTgwiVezNsRUDu1JZ0o3R9UuLH
 edMJYPPSS8Bp7b3wFXRQaYlXFKlCQmnZaCrKQA==
X-Received: by 2002:ad4:5f45:0:b0:82d:f77f:28c3 with SMTP id
 6a1803df08f44-87b21092a00mr125664386d6.30.1760029099315; 
 Thu, 09 Oct 2025 09:58:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEejER2wZmSqx8KTlzVDzMBOfBFVxh98M+dc4YWhUtgzINr+ylZnHlieku6bYbqJ65YLd0S+A==
X-Received: by 2002:ad4:5f45:0:b0:82d:f77f:28c3 with SMTP id
 6a1803df08f44-87b21092a00mr125663646d6.30.1760029098668; 
 Thu, 09 Oct 2025 09:58:18 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bdf52e64sm183809426d6.52.2025.10.09.09.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 09:58:17 -0700 (PDT)
Date: Thu, 9 Oct 2025 12:58:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dave@treblig.org>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Prasad Pandit <ppandit@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC 0/9] migration: Threadify loadvm process
Message-ID: <aOfpp41s5rFt-Qzk@x1.local>
References: <20250827205949.364606-1-peterx@redhat.com>
 <87zfau13sk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zfau13sk.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Sep 16, 2025 at 06:32:59PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > [this is an early RFC, not for merge, but to collect initial feedbacks]
> >
> > Background
> > ==========
> >
> > Nowadays, live migration heavily depends on threads. For example, most of
> > the major features that will be used nowadays in live migration (multifd,
> > postcopy, mapped-ram, vfio, etc.) all work with threads internally.
> >
> > But still, from time to time, we'll see some coroutines floating around the
> > migration context.  The major one is precopy's loadvm, which is internally
> > a coroutine.  It is still a critical path that any live migration depends on.
> >
> 
> I always wanted to be an archaeologist:
> 
> https://lists.gnu.org/archive/html/qemu-devel//2012-08/msg01136.html
> 
> I was expecting to find some complicated chain of events leading to the
> choice of using a coroutine, but no.

I actually didn't see that previously..  I'll add this link into that major
patch commit message, to make future archaeology work easier.

> 
> > A mixture of using both coroutines and threads is prone to issues.  Some
> > examples can refer to commit e65cec5e5d ("migration/ram: Yield periodically
> > to the main loop") or commit 7afbdada7e ("migration/postcopy: ensure
> > preempt channel is ready before loading states").
> >
> > Overview
> > ========
> >
> > This series tries to move migration further into the thread-based model, by
> > allowing the loadvm process to happen in a thread rather than in the main
> > thread with a coroutine.
> >
> > Luckily, since the qio channel code is always ready for both cases, IO
> > paths should all be fine.
> >
> > Note that loadvm for postcopy already happens in a ram load thread which is
> > separate.  However, RAM is just the simple case here, even it has its own
> > challenges (on atomically update of the pgtables), its complexity lies in
> > the kernel.
> >
> > For precopy, loadvm has quite a few operations that will need BQL.  The
> > question is we can't take BQL for the whole process of loadvm, because
> > that'll block the main thread from executions (e.g. QMP hangs).  Here, the
> > finer granule we can push BQL the better.  This series so far chose
> > somewhere in the middle, by taking BQL on majorly these two places:
> >
> >   - CPU synchronizations
> >   - Device START/FULL sections
> >
> > After this series applied, most of the rest loadvm path will run without
> > BQL anymore.  There is a more detailed discussion / todo in the commit
> > message of patch "migration: Thread-ify precopy vmstate load process"
> > explaning how to further split the BQL critical sections.
> >
> > I was trying to split the patches into smaller ones if possible, but it's
> > still quite challenging so there's one major patch that does the work.
> >
> > After the series applied, the only leftover pieces in migration/ that would
> > use a coroutine is snapshot save/load/delete jobs.
> >
> 
> Which are then fine because the work itself runs on the main loop,
> right? So the bottom-half scheduling could be left as a coroutine.

Correct, iochannel works for both cases.

For coroutines, it can properly register the fd and yield like before for
snapshot save/load.  It used to do the same for live loadvm, but now after
moving to a thread it will start to use qio_channel_wait() instead.

I think we could also move back to blocking mode for live migration
incoming side after make it a thread, which might be slightly more
efficient to directly block in recvmsg() rather than return+poll.  But it
is trivial comparing to "moving to thread" change, and it can be done for
later even if it works.

> 
> > Tests
> > =====
> >
> > Default CI passes.
> >
> > RDMA unit tests pass as usual. I also tried out cancellation / failure
> > tests over RDMA channels, making sure nothing is stuck.
> >
> > I also roughly measured how long it takes to run the whole 80+ migration
> > qtest suite, and see no measurable difference before / after this series.
> >
> > Risks
> > =====
> >
> > This series has the risk of breaking things.  I would be surprised if it
> > didn't..
> >
> > I confess I didn't test anything on COLO but only from code observations
> > and analysis.  COLO maintainers: could you add some unit tests to QEMU's
> > qtests?
> >
> > The current way of taking BQL during FULL section load may cause issues, it
> > means when the IOs are unstable we could be waiting for IO (in the new
> > migration incoming thread) with BQL held.  This is low possibility, though,
> > only happens when the network halts during flushing the device states.
> > However still possible.  One solution is to further breakdown the BQL
> > critical sections to smaller sections, as mentioned in TODO.
> >
> > Anything more than welcomed: suggestions, questions, objections, tests..
> >
> > Todo
> > ====
> >
> > - Test COLO?
> > - Finer grained BQL breakdown
> > - More..
> >
> > Thanks,
> >
> > Peter Xu (9):
> >   migration/vfio: Remove BQL implication in
> >     vfio_multifd_switchover_start()
> >   migration/rdma: Fix wrong context in qio_channel_rdma_shutdown()
> >   migration/rdma: Allow qemu_rdma_wait_comp_channel work with thread
> >   migration/rdma: Change io_create_watch() to return immediately
> >   migration: Thread-ify precopy vmstate load process
> >   migration/rdma: Remove coroutine path in qemu_rdma_wait_comp_channel
> >   migration/postcopy: Remove workaround on wait preempt channel
> >   migration/ram: Remove workaround on ram yield during load
> >   migration/rdma: Remove rdma_cm_poll_handler
> >
> >  include/migration/colo.h    |   6 +-
> >  migration/migration.h       |  52 +++++++--
> >  migration/savevm.h          |   5 +-
> >  hw/vfio/migration-multifd.c |   9 +-
> >  migration/channel.c         |   7 +-
> >  migration/colo-stubs.c      |   2 +-
> >  migration/colo.c            |  23 +---
> >  migration/migration.c       |  62 ++++++++---
> >  migration/ram.c             |  13 +--
> >  migration/rdma.c            | 206 ++++++++----------------------------
> >  migration/savevm.c          |  85 +++++++--------
> >  migration/trace-events      |   4 +-
> >  12 files changed, 196 insertions(+), 278 deletions(-)
> 

-- 
Peter Xu


