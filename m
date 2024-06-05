Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6D3C27C50
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 00:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEeZY-0006q6-3D; Tue, 04 Jun 2024 20:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1sEeZW-0006m0-21; Tue, 04 Jun 2024 20:32:10 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1sEeZT-0004mm-8d; Tue, 04 Jun 2024 20:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=tQpXbNkA30Qz5DmX8PuGmtXnW+AZm949wAtD2btAurw=; b=Dav1hDoTy/SZ+cW1
 PWufQYK4MxwPvVMaeWSV0O181Ie85LyzV5KCrb6T9YTNfTrEFkKJ65QvXTCX3ReLC3DEm1LY04rkJ
 nrB9ZgITyHONNZ6XkGRF+lHkLQYi3ctZLyrXfAiv6mp2thJWxRPF73dupEfgXu2s0AoWNw+aeMZln
 C5pKhWPXR0PG1TAkLxmWPSP5f94VilM67WXg0zGSPm/70jyvUhtcb2JQcNiARNqhnVDzizZEnqSDT
 dcLffvj81LtvD3SD+sEfrVxglLXWXezPgcesnOCRJtSNaUMsG3HNSPoqJG6q1Znk5MNOs33w59vHH
 FYJgycXO0RDJ5TR34Q==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1sEeZI-004JsB-0l;
 Wed, 05 Jun 2024 00:31:56 +0000
Date: Wed, 5 Jun 2024 00:31:56 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Michael Galaxy <mgalaxy@akamai.com>
Cc: Zheng Chuan <zhengchuan@huawei.com>, Peter Xu <peterx@redhat.com>,
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
Message-ID: <Zl-x_Az8i4jOwitt@gallifrey>
References: <Zi-1OvxA5MIHjklU@x1n> <877cgfe2yw.fsf@pond.sub.org>
 <ZjClMb-6MddpvHqQ@redhat.com> <ZjJgQcPQ29HJsTpY@x1n>
 <7e902e4e576a4e199e36d28f99bd55e5@huawei.com>
 <Zjj0xa-3KrFHTK0S@x1n>
 <addaa8d094904315a466533763689ead@huawei.com>
 <ZjpWmG2aUJLkYxJm@x1n>
 <13ce4f9e-1e7c-24a9-0dc9-c40962979663@huawei.com>
 <cd93922f-cf58-4a42-854d-0b39c6941905@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd93922f-cf58-4a42-854d-0b39c6941905@akamai.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 00:21:50 up 27 days, 11:35,  2 users,  load average: 0.00, 0.00, 0.00
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

* Michael Galaxy (mgalaxy@akamai.com) wrote:
> One thing to keep in mind here (despite me not having any hardware to test)
> was that one of the original goals here
> in the RDMA implementation was not simply raw throughput nor raw latency,
> but a lack of CPU utilization in kernel
> space due to the offload. While it is entirely possible that newer hardware
> w/ TCP might compete, the significant
> reductions in CPU usage in the TCP/IP stack were a big win at the time.
> 
> Just something to consider while you're doing the testing........

I just noticed this thread; some random notes from a somewhat
fragmented memory of this:

  a) Long long ago, I also tried rsocket; 
      https://lists.gnu.org/archive/html/qemu-devel/2015-01/msg02040.html
     as I remember the library was quite flaky at the time.

  b) A lot of the complexity in the rdma migration code comes from
    emulating a stream to carry the migration control data and interleaving
    that with the actual RAM copy.   I believe the original design used
    a separate TCP socket for the control data, and just used the RDMA
    for the data - that should be a lot simpler (but alas was rejected
    in review early on)

  c) I can't rememmber the last benchmarks I did; but I think I did
    manage to beat RDMA with multifd; but yes, multifd does eat host CPU
    where as RDMA barely uses a whisper.

  d) The 'zero-copy-send' option in migrate may well get some of that
     CPU time back; but if I remember we were still bottle necked on
     the receive side. (I can't remember if zero-copy-send worked with
     multifd?)

  e) Someone made a good suggestion (sorry can't remember who) - that the
     RDMA migration structure was the wrong way around - it should be the
     destination which initiates an RDMA read, rather than the source
     doing a write; then things might become a LOT simpler; you just need
     to send page ranges to the destination and it can pull it.
     That might work nicely for postcopy.

Dave

> - Michael
> 
> On 5/9/24 03:58, Zheng Chuan wrote:
> > Hi, Peter，Lei，Jinpu.
> > 
> > On 2024/5/8 0:28, Peter Xu wrote:
> > > On Tue, May 07, 2024 at 01:50:43AM +0000, Gonglei (Arei) wrote:
> > > > Hello,
> > > > 
> > > > > -----Original Message-----
> > > > > From: Peter Xu [mailto:peterx@redhat.com]
> > > > > Sent: Monday, May 6, 2024 11:18 PM
> > > > > To: Gonglei (Arei) <arei.gonglei@huawei.com>
> > > > > Cc: Daniel P. Berrangé <berrange@redhat.com>; Markus Armbruster
> > > > > <armbru@redhat.com>; Michael Galaxy <mgalaxy@akamai.com>; Yu Zhang
> > > > > <yu.zhang@ionos.com>; Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>; Jinpu Wang
> > > > > <jinpu.wang@ionos.com>; Elmar Gerdes <elmar.gerdes@ionos.com>;
> > > > > qemu-devel@nongnu.org; Yuval Shaia <yuval.shaia.ml@gmail.com>; Kevin Wolf
> > > > > <kwolf@redhat.com>; Prasanna Kumar Kalever
> > > > > <prasanna.kalever@redhat.com>; Cornelia Huck <cohuck@redhat.com>;
> > > > > Michael Roth <michael.roth@amd.com>; Prasanna Kumar Kalever
> > > > > <prasanna4324@gmail.com>; integration@gluster.org; Paolo Bonzini
> > > > > <pbonzini@redhat.com>; qemu-block@nongnu.org; devel@lists.libvirt.org;
> > > > > Hanna Reitz <hreitz@redhat.com>; Michael S. Tsirkin <mst@redhat.com>;
> > > > > Thomas Huth <thuth@redhat.com>; Eric Blake <eblake@redhat.com>; Song
> > > > > Gao <gaosong@loongson.cn>; Marc-André Lureau
> > > > > <marcandre.lureau@redhat.com>; Alex Bennée <alex.bennee@linaro.org>;
> > > > > Wainer dos Santos Moschetta <wainersm@redhat.com>; Beraldo Leal
> > > > > <bleal@redhat.com>; Pannengyuan <pannengyuan@huawei.com>;
> > > > > Xiexiangyou <xiexiangyou@huawei.com>
> > > > > Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
> > > > > 
> > > > > On Mon, May 06, 2024 at 02:06:28AM +0000, Gonglei (Arei) wrote:
> > > > > > Hi, Peter
> > > > > Hey, Lei,
> > > > > 
> > > > > Happy to see you around again after years.
> > > > > 
> > > > Haha, me too.
> > > > 
> > > > > > RDMA features high bandwidth, low latency (in non-blocking lossless
> > > > > > network), and direct remote memory access by bypassing the CPU (As you
> > > > > > know, CPU resources are expensive for cloud vendors, which is one of
> > > > > > the reasons why we introduced offload cards.), which TCP does not have.
> > > > > It's another cost to use offload cards, v.s. preparing more cpu resources?
> > > > > 
> > > > Software and hardware offload converged architecture is the way to go for all cloud vendors
> > > > (Including comprehensive benefits in terms of performance, cost, security, and innovation speed),
> > > > it's not just a matter of adding the resource of a DPU card.
> > > > 
> > > > > > In some scenarios where fast live migration is needed (extremely short
> > > > > > interruption duration and migration duration) is very useful. To this
> > > > > > end, we have also developed RDMA support for multifd.
> > > > > Will any of you upstream that work?  I'm curious how intrusive would it be
> > > > > when adding it to multifd, if it can keep only 5 exported functions like what
> > > > > rdma.h does right now it'll be pretty nice.  We also want to make sure it works
> > > > > with arbitrary sized loads and buffers, e.g. vfio is considering to add IO loads to
> > > > > multifd channels too.
> > > > > 
> > > > In fact, we sent the patchset to the community in 2021. Pls see:
> > > > https://urldefense.com/v3/__https://lore.kernel.org/all/20210203185906.GT2950@work-vm/T/__;!!GjvTz_vk!VfP_SV-8uRya7rBdopv8OUJkmnSi44Ktpqq1E7sr_Xcwt6zvveW51qboWOBSTChdUG1hJwfAl7HZl4NUEGc$
> > Yes, I have sent the patchset of multifd support for rdma migration by taking over my colleague, and also
> > sorry for not keeping on this work at that time due to some reasons.
> > And also I am strongly agree with Lei that the RDMA protocol has some special advantages against with TCP
> > in some scenario, and we are indeed to use it in our product.
> > 
> > > I wasn't aware of that for sure in the past..
> > > 
> > > Multifd has changed quite a bit in the last 9.0 release, that may not apply
> > > anymore.  One thing to mention is please look at Dan's comment on possible
> > > use of rsocket.h:
> > > 
> > > https://urldefense.com/v3/__https://lore.kernel.org/all/ZjJm6rcqS5EhoKgK@redhat.com/__;!!GjvTz_vk!VfP_SV-8uRya7rBdopv8OUJkmnSi44Ktpqq1E7sr_Xcwt6zvveW51qboWOBSTChdUG1hJwfAl7HZ0CFSE-o$
> > > 
> > > And Jinpu did help provide an initial test result over the library:
> > > 
> > > https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/CAMGffEk8wiKNQmoUYxcaTHGtiEm2dwoCF_W7T0vMcD-i30tUkA@mail.gmail.com/__;!!GjvTz_vk!VfP_SV-8uRya7rBdopv8OUJkmnSi44Ktpqq1E7sr_Xcwt6zvveW51qboWOBSTChdUG1hJwfAl7HZxPNcdb4$
> > > 
> > > It looks like we have a chance to apply that in QEMU.
> > > 
> > > > 
> > > > > One thing to note that the question here is not about a pure performance
> > > > > comparison between rdma and nics only.  It's about help us make a decision
> > > > > on whether to drop rdma, iow, even if rdma performs well, the community still
> > > > > has the right to drop it if nobody can actively work and maintain it.
> > > > > It's just that if nics can perform as good it's more a reason to drop, unless
> > > > > companies can help to provide good support and work together.
> > > > > 
> > > > We are happy to provide the necessary review and maintenance work for RDMA
> > > > if the community needs it.
> > > > 
> > > > CC'ing Chuan Zheng.
> > > I'm not sure whether you and Jinpu's team would like to work together and
> > > provide a final solution for rdma over multifd.  It could be much simpler
> > > than the original 2021 proposal if the rsocket API will work out.
> > > 
> > > Thanks,
> > > 
> > That's a good news to see the socket abstraction for RDMA!
> > When I was developed the series above, the most pain is the RDMA migration has no QIOChannel abstraction and i need to take a 'fake channel'
> > for it which is awkward in code implementation.
> > So, as far as I know, we can do this by
> > i. the first thing is that we need to evaluate the rsocket is good enough to satisfy our QIOChannel fundamental abstraction
> > ii. if it works right, then we will continue to see if it can give us opportunity to hide the detail of rdma protocol
> >      into rsocket by remove most of code in rdma.c and also some hack in migration main process.
> > iii. implement the advanced features like multi-fd and multi-uri for rdma migration.
> > 
> > Since I am not familiar with rsocket, I need some times to look at it and do some quick verify with rdma migration based on rsocket.
> > But, yes, I am willing to involved in this refactor work and to see if we can make this migration feature more better:）
> > 
> > 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

