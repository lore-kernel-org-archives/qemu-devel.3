Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFD6C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 12:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWxvb-0004xW-1c; Thu, 25 Jul 2024 08:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1sWxvZ-0004wt-Nb
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 08:50:37 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1sWxvW-00068f-87
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 08:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=c2mnESUl0XpE3OMDJLCZTQOiq5g1IRDc64H0K8lN270=; b=n8EO1VaTFz2tCwLN
 RJt0qrNayGTBgPuzugwxohq9JO5tsMP2Fbn0m0tZpL03ah/Ko9zwv6sfBDoYku58il8XlLptRBckc
 C+BeaKkr3ZLFduzikgEhq8adWoi0eAsIqvq2crbknzOEou+L2aYx6XeK/LVNaazRXDjSSKQ5RwH7o
 AoWLuKdz+e6G7DP8e514+SLLWdbeiiWQhMaHFWnc2sdVQ0VeetdZOIsDk+5MTAB4dNofk/CMsx6G2
 n8AOfSQfAhJAmGFvYhF0Q1e7ft3YzNLWy0ktp2Eq7FuzeOmK3flRVoJIzSkJ6nqyhsSctNi4+4F4M
 CO8YMBO2oR766sn8ig==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1sWxvQ-00DBkV-2X;
 Thu, 25 Jul 2024 12:50:28 +0000
Date: Thu, 25 Jul 2024 12:50:28 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Guoyi Tu <tugy@chinatelecom.cn>,
 Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 dengpc12@chinatelecom.cn, zhangl161@chinatelecom.cn,
 Paolo Bonzini <pbonzini@redhat.com>, Yang Zhong <yang.zhong@intel.com>
Subject: Re: [PATCH] misc: introduce strim-memory qapi to support free memory
 trimming
Message-ID: <ZqJKFOswMTANFJiq@gallifrey>
References: <0370576b-0660-4fb0-ac70-5b31ad6e3dbf@chinatelecom.cn>
 <87h6cdogau.fsf@pond.sub.org> <ZqI9tgHzWudxBUn9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZqI9tgHzWudxBUn9@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 12:49:20 up 78 days, 3 min, 1 user, load average: 0.09, 0.03, 0.01
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

* Daniel P. Berrangé (berrange@redhat.com) wrote:
> On Thu, Jul 25, 2024 at 01:35:21PM +0200, Markus Armbruster wrote:
> > Guoyi Tu <tugy@chinatelecom.cn> writes:
> > 
> > > In the test environment, we conducted IO stress tests on all storage disks
> > > within a virtual machine that had five storage devices mounted.During 
> > > testing,
> > > we found that the qemu process allocated a large amount of memory (~800MB)
> > > to handle these IO operations.
> > >
> > > When the test ended, although qemu called free() to release the allocated
> > > memory, the memory was not actually returned to the operating system, as
> > > observed via the top command.
> > >
> > > Upon researching the glibc memory management mechanism, we found that when
> > > small chunks of memory are allocated in user space and then released with
> > > free(),  the glibc memory management mechanism does not necessarily return
> > > this memory to the operating system. Instead, it retains the memory until
> > > certain conditions are met for release.
> > 
> > Yes.
> 
> Looking at mallopt(3) man page, the M_TRIM_THRESHOLD is said to control
> when glibc releases the top of the heap back to the OS. It is said to
> default to 128 kb.
> 
> I'm curious how we get from that default, to 800 MB of unused memory ?
> Is it related to the number of distinct malloc arenas that are in use ?

I wonder which IO mechanism was being used - the 'iothreads' used to sometimes
blow up and start 100s of threads; is that the case here?

> I'm curious what malloc_stats() would report before & after malloc_trim
> when QEMU is in this situation with lots of wasted memory.

Yes; maybe also trying valgrind's massif:
   https://valgrind.org/docs/manual/ms-manual.html

(if it works on Qemu!)
might help say where it's going?

Dave

> > 
> > > For virtual machines that only have business operations during specific
> > > periods,  they remain idle most of the time. However, the qemu process
> > > still occupies a large amount of memory resources, leading to significant
> > > memory resource waste.
> > 
> > Mitigation: the memory free()'s but not returned to the OS can be paged
> > out.
> > 
> > > To address this issue, this patch introduces an API to actively reclaim
> > > idle memory within the qemu process. This API effectively calls 
> > > malloc_trim()
> > > to notify glibc to trim free memory. With this api, the management tool
> > > can monitor the virtual machine's state and call this API during idle times
> > > to free up the memory occupied by the virtual machine, thereby allowing more
> > > virtual machines to be provisioned.
> > 
> > How does this affect the test case you described above?
> > 
> > There's an existing use of malloc_trim() in util/rcu.c's
> > call_rcu_thread().  It's from commit 5a22ab71623:
> > 
> >     rcu: reduce more than 7MB heap memory by malloc_trim()
> >     
> >     Since there are some issues in memory alloc/free machenism
> >     in glibc for little chunk memory, if Qemu frequently
> >     alloc/free little chunk memory, the glibc doesn't alloc
> >     little chunk memory from free list of glibc and still
> >     allocate from OS, which make the heap size bigger and bigger.
> >     
> >     This patch introduce malloc_trim(), which will free heap
> >     memory when there is no rcu call during rcu thread loop.
> >     malloc_trim() can be enabled/disabled by --enable-malloc-trim/
> >     --disable-malloc-trim in the Qemu configure command. The
> >     default malloc_trim() is enabled for libc.
> >     
> >     Below are test results from smaps file.
> >     (1)without patch
> >     55f0783e1000-55f07992a000 rw-p 00000000 00:00 0  [heap]
> >     Size:              21796 kB
> >     Rss:               14260 kB
> >     Pss:               14260 kB
> >     
> >     (2)with patch
> >     55cc5fadf000-55cc61008000 rw-p 00000000 00:00 0  [heap]
> >     Size:              21668 kB
> >     Rss:                6940 kB
> >     Pss:                6940 kB
> >     
> >     Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> >     Message-Id: <1513775806-19779-1-git-send-email-yang.zhong@intel.com>
> >     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > 
> > How would the malloc_trim() you propose interact with this one?
> 
> The above usage is automatic, while this proposal requires that
> an external mgmt app monitor QEMU and tell it to free memory.
> I'm wondering if the latter is really desirable, or whether QEMU
> can call this itself when reasonable ?
> 
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

