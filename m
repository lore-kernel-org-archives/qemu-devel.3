Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF9EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 13:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZVby-0004dX-5H; Thu, 01 Aug 2024 09:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZVbw-0004cy-02
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 09:12:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZVbt-00079T-G0
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 09:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722517967;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3d9PS99d8JEVxWcg9SDJCK6dVGZwWdVUWcN5RFWSsyE=;
 b=I61K/hNSWnOcM8yeRC2kj+okW208FFU9QIIS4icWHyZNotTQ0vwzqQMSMYI9FsZJlYI8VB
 b99ECO+wLCJ2vIJN1dikS1B1TrUQ7qiGSA3hFn8eWNWMJ3D/NzOw6+ayevj3b1id1pJluL
 i1OB8YJxDpICYQkEVn3Uvd+BarVohSA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-U_PG6_SVPYiH5dTIW2ftOg-1; Thu,
 01 Aug 2024 09:12:42 -0400
X-MC-Unique: U_PG6_SVPYiH5dTIW2ftOg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C7811955F3B; Thu,  1 Aug 2024 13:12:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.109])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67D6F3000198; Thu,  1 Aug 2024 13:12:34 +0000 (UTC)
Date: Thu, 1 Aug 2024 14:12:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Guoyi Tu <tugy@chinatelecom.cn>
Cc: Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 dengpc12@chinatelecom.cn, zhangl161@chinatelecom.cn,
 Paolo Bonzini <pbonzini@redhat.com>, Yang Zhong <yang.zhong@intel.com>
Subject: Re: [PATCH] misc: introduce strim-memory qapi to support free memory
 trimming
Message-ID: <ZquJv9ZwzPX0hIj6@redhat.com>
References: <0370576b-0660-4fb0-ac70-5b31ad6e3dbf@chinatelecom.cn>
 <87h6cdogau.fsf@pond.sub.org> <ZqI9tgHzWudxBUn9@redhat.com>
 <80321ce6-1596-460d-b4e1-622a0b69f8e1@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80321ce6-1596-460d-b4e1-622a0b69f8e1@chinatelecom.cn>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Jul 27, 2024 at 01:18:32PM +0800, Guoyi Tu wrote:
> On 2024/7/25 19:57, Daniel P. Berrangé wrote:
> > On Thu, Jul 25, 2024 at 01:35:21PM +0200, Markus Armbruster wrote:
> > > Guoyi Tu <tugy@chinatelecom.cn> writes:
> > > 
> > > > In the test environment, we conducted IO stress tests on all storage disks
> > > > within a virtual machine that had five storage devices mounted.During
> > > > testing,
> > > > we found that the qemu process allocated a large amount of memory (~800MB)
> > > > to handle these IO operations.
> > > > 
> > > > When the test ended, although qemu called free() to release the allocated
> > > > memory, the memory was not actually returned to the operating system, as
> > > > observed via the top command.
> > > > 
> > > > Upon researching the glibc memory management mechanism, we found that when
> > > > small chunks of memory are allocated in user space and then released with
> > > > free(),  the glibc memory management mechanism does not necessarily return
> > > > this memory to the operating system. Instead, it retains the memory until
> > > > certain conditions are met for release.
> > > 
> > > Yes.
> > 
> > Looking at mallopt(3) man page, the M_TRIM_THRESHOLD is said to control
> > when glibc releases the top of the heap back to the OS. It is said to
> > default to 128 kb.
> Yes, the M_TRIM_THRESHOLD option can control glibc to release the free
> memory at the top of the heap, but glibc will not release the free
> memory in the middle of the heap.
> 
> > I'm curious how we get from that default, to 800 MB of unused memory > Is it related to the number of distinct malloc arenas that are in use ?
> 
> At least 600MB of memory is free, and this memory might be in the middle of
> the heap and cannot be automatically released.
> 
> > I'm curious what malloc_stats() would report before & after malloc_trim
> > when QEMU is in this situation with lots of wasted memory.
> Here is the test case:

snip

That looks like an artifical reproducer, rather than the real world
QEMU scenario.

What's the actual I/O stress test scenario you use to reproduce the
problem in QEMU, and how have you configured QEMU (ie what CLI args) ?

I'm fairly inclined to suggest that having such a huge amount of
freed memory is a glibc bug, but to escalate this to glibc requires
us to provide them better real world examples of the problems.

> > The above usage is automatic, while this proposal requires that
> > an external mgmt app monitor QEMU and tell it to free memory.
> > I'm wondering if the latter is really desirable, or whether QEMU
> > can call this itself when reasonable ?
> 
> Yes, I have also considered implementing an automatic memory release
> function within qemu. This approach would require qemu to periodically
> monitor the IO load of all backend storage, and if the IO load is very
> low over a period of time, it would proactively release memory.

I would note that in systemd they have logic which is monitoring
either /proc/pressure/memory or $CGROUP/memory.pressure, and in
response to events on that, it will call malloc_trim

  https://github.com/systemd/systemd/blob/main/docs/MEMORY_PRESSURE.md
  https://docs.kernel.org/accounting/psi.html

Something like that might be better, as it lets us hide the specific
design & impl choices inside QEMU, letting us change/evolve them at
will without impacting public API designs.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


