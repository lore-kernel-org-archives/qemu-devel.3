Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D89C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 20:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sExYz-0003ta-NK; Wed, 05 Jun 2024 16:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1sExYy-0003tF-IV; Wed, 05 Jun 2024 16:48:52 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1sExYo-0005HY-SO; Wed, 05 Jun 2024 16:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=/yG/yRAfw/0ekPH5xva8Nfx6rcf1uufXZdAZwLn3TwI=; b=sbXERvMYloAA+WhR
 RNaATnzUGR1lcIpr3OF6l6nH3ATnoTyehQkY2f1/34otq6crOawH/SaDPS47RkOuQOGr5JCcnxdyy
 UhgdKE0o4nTH+e4BIqyOzND3fDyitst+UFOtxunuJqUsPW9M6ZVQlbSgnpbpX3aMiOAkhqkqRRUa2
 IiF7+UKJqzFKpkTkc3Dv4lnD+JmOb0Bv98Em7PAO/lZlxRef4u6ah5DrE3dtZzlTwUc1BhOvaXW5z
 NaEbzXwEjYRYLSaVcqQQt2aSdxTlS50QMfsjm2jVMCUWyt3L7BOH1tXzoYz19e4UWRIwfJiO6bruY
 FoWF0mdl8E0RYr6i/Q==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1sExYa-004ZRD-2y;
 Wed, 05 Jun 2024 20:48:28 +0000
Date: Wed, 5 Jun 2024 20:48:28 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Peter Xu <peterx@redhat.com>
Cc: Michael Galaxy <mgalaxy@akamai.com>, Zheng Chuan <zhengchuan@huawei.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Yu Zhang <yu.zhang@ionos.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Jinpu Wang <jinpu.wang@ionos.com>, Elmar Gerdes <elmar.gerdes@ionos.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Prasanna Kumar Kalever <prasanna4324@gmail.com>,
 "integration@gluster.org" <integration@gluster.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Song Gao <gaosong@loongson.cn>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pannengyuan <pannengyuan@huawei.com>,
 Xiexiangyou <xiexiangyou@huawei.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Message-ID: <ZmDPHKLkzBO47XRc@gallifrey>
References: <ZjClMb-6MddpvHqQ@redhat.com> <ZjJgQcPQ29HJsTpY@x1n>
 <7e902e4e576a4e199e36d28f99bd55e5@huawei.com>
 <Zjj0xa-3KrFHTK0S@x1n>
 <addaa8d094904315a466533763689ead@huawei.com>
 <ZjpWmG2aUJLkYxJm@x1n>
 <13ce4f9e-1e7c-24a9-0dc9-c40962979663@huawei.com>
 <cd93922f-cf58-4a42-854d-0b39c6941905@akamai.com>
 <Zl-x_Az8i4jOwitt@gallifrey> <ZmBx8UDDmO-C1Oqu@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ZmBx8UDDmO-C1Oqu@x1n>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 20:41:46 up 28 days, 7:55, 1 user, load average: 0.01, 0.02, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

* Peter Xu (peterx@redhat.com) wrote:
> Hey, Dave!

Hey!

> On Wed, Jun 05, 2024 at 12:31:56AM +0000, Dr. David Alan Gilbert wrote:
> > * Michael Galaxy (mgalaxy@akamai.com) wrote:
> > > One thing to keep in mind here (despite me not having any hardware to test)
> > > was that one of the original goals here
> > > in the RDMA implementation was not simply raw throughput nor raw latency,
> > > but a lack of CPU utilization in kernel
> > > space due to the offload. While it is entirely possible that newer hardware
> > > w/ TCP might compete, the significant
> > > reductions in CPU usage in the TCP/IP stack were a big win at the time.
> > > 
> > > Just something to consider while you're doing the testing........
> > 
> > I just noticed this thread; some random notes from a somewhat
> > fragmented memory of this:
> > 
> >   a) Long long ago, I also tried rsocket; 
> >       https://lists.gnu.org/archive/html/qemu-devel/2015-01/msg02040.html
> >      as I remember the library was quite flaky at the time.
> 
> Hmm interesting.  There also looks like a thread doing rpoll().

Yeh, I can't actually remember much more about what I did back then!

> Btw, not sure whether you noticed, but there's the series posted for the
> latest rsocket conversion here:
> 
> https://lore.kernel.org/r/1717503252-51884-1-git-send-email-arei.gonglei@huawei.com

Oh I hadn't; I think all of the stack of qemu's file abstractions had
changed in the ~10 years since I wrote my version!

> I hope Lei and his team has tested >4G mem, otherwise definitely worth
> checking.  Lei also mentioned there're rsocket bugs they found in the cover
> letter, but not sure what's that about.

It would probably be a good idea to keep track of what bugs
are in flight with it, and try it on a few RDMA cards to see
what problems get triggered.
I think I reported a few at the time, but I gave up after
feeling it was getting very hacky.

> Yes, and zero-copy requires multifd for now. I think it's because we didn't
> want to complicate the header processings in the migration stream where it
> may not be page aligned.

Ah yes.

> > 
> >   e) Someone made a good suggestion (sorry can't remember who) - that the
> >      RDMA migration structure was the wrong way around - it should be the
> >      destination which initiates an RDMA read, rather than the source
> >      doing a write; then things might become a LOT simpler; you just need
> >      to send page ranges to the destination and it can pull it.
> >      That might work nicely for postcopy.
> 
> I'm not sure whether it'll still be a problem if rdma recv side is based on
> zero-copy.  It would be a matter of whether atomicity can be guaranteed so
> that we don't want the guest vcpus to see a partially copied page during
> on-flight DMAs.  UFFDIO_COPY (or friend) is currently the only solution for
> that.

Yes, but even ignoring that (and the UFFDIO_CONTINUE idea you mention), if
the destination can issue an RDMA read itself, it doesn't need to send messages
to the source to ask for a page fetch; it just goes and grabs it itself,
that's got to be good for latency.

Dave

> 
> Thanks,
> 
> -- 
> Peter Xu
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

