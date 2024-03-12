Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DB8C54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 15:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk4Nc-0003SC-7K; Tue, 12 Mar 2024 11:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rk4NZ-0003Or-6m
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:49:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rk4NT-0003MV-ML
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710258558;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zWfaJVPx1CoRHlHyBqaMb7m5AEjSRZEe6IjIjh7v+d0=;
 b=KCJagowTHlvgOEMgt7H1uaTzCKeXyii2M/smY+w7FbZQmE0Y7/okwhKQoNBAJQ1o13OrAp
 4wBGtuo+aCORo+ILGaBCljELAm3b4284/cOJkgKeHFNno3f3QiXJtxoewafqN66NXKIvXK
 lVSot0vQruSdXjdLxweKS14ihgpftgc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-zm1VO8zdMhqOjkHQ7u658A-1; Tue, 12 Mar 2024 11:49:16 -0400
X-MC-Unique: zm1VO8zdMhqOjkHQ7u658A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2CE1101CC70
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:49:15 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB93D492BD0;
 Tue, 12 Mar 2024 15:49:14 +0000 (UTC)
Date: Tue, 12 Mar 2024 15:49:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anthony Harivel <aharivel@redhat.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 vchundur@redhat.com
Subject: Re: [PATCH v3 3/3] Add support for RAPL MSRs in KVM/Qemu
Message-ID: <ZfB5eBwWXL45sN_K@redhat.com>
References: <20240125072214.318382-1-aharivel@redhat.com>
 <20240125072214.318382-4-aharivel@redhat.com>
 <ZbjDtytv-_-Bz4-S@redhat.com> <CZRQCYCXNTF2.1I5CNECSOB6IL@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CZRQCYCXNTF2.1I5CNECSOB6IL@fedora>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Mar 12, 2024 at 12:21:14PM +0100, Anthony Harivel wrote:

> Daniel P. Berrangé, Jan 30, 2024 at 10:39:
> > > +    rcu_register_thread();
> > > +
> > > +    /* Get QEMU PID*/
> > > +    pid = getpid();
> > > +
> > > +    /* Nb of CPUS per packages */
> > > +    maxcpus = vmsr_get_maxcpus(0);
> > > +
> > > +    /* Nb of Physical Packages on the system */
> > > +    maxpkgs = vmsr_get_max_physical_package(maxcpus);
> >
> > This function can fail so this needs to be checked & reported.
> >
> > > +
> > > +    /* Those MSR values should not change as well */
> > > +    vmsr->msr_unit  = vmsr_read_msr(MSR_RAPL_POWER_UNIT, 0, pid,
> > > +                                    s->msr_energy.socket_path);
> > > +    vmsr->msr_limit = vmsr_read_msr(MSR_PKG_POWER_LIMIT, 0, pid,
> > > +                                    s->msr_energy.socket_path);
> > > +    vmsr->msr_info  = vmsr_read_msr(MSR_PKG_POWER_INFO, 0, pid,
> > > +                                    s->msr_energy.socket_path);
> >
> > This function can fail for a variety of reasons, most especially if someone
> > gave an incorrect socket path, or if the daemon is not running. This is not
> > getting diagnosed, and even if we try to report it here, we're in a background
> > thread at this point.
> >
> > I think we need to connect and report errors before even starting this
> > thread, so that QEMU startup gets aborted upon configuration error.
> >
> 
> Fair enough. Would it be ok to do the sanity check before 
> rcu_register_thread() and "return NULL;" in case of error or would you 
> prefer me to check all of this before even calling the 
> qemu_thread_create() ?

I think it is best to initialize in kvm_msr_energy_thread_init(),
prior to thread creation, as that avoids some complexity cleaning
up and reporting errors.

> > > +            thd_stat[i].numa_node_id = numa_node_of_cpu(thd_stat[i].cpu_id);
> > > +        }
> > > +
> > > +        /* Retrieve all packages power plane energy counter */
> > > +        for (int i = 0; i <= maxpkgs; i++) {
> > > +            for (int j = 0; j < num_threads; j++) {
> > > +                /*
> > > +                 * Use the first thread we found that ran on the CPU
> > > +                 * of the package to read the packages energy counter
> > > +                 */
> > > +                if (thd_stat[j].numa_node_id == i) {
> >
> > 'i' is a CPU ID value, while 'numa_node_id' is a NUMA node ID value.
> > I don't think it is semantically valid to compare them for equality.
> >
> > I'm not sure the NUMA node is even relevant, since IIUC from the docs
> > earlier, the power values are scoped per package, which would mean per
> > CPU socket.
> >
> 
> 'i' here is the package number on the host.

Opps, yes, 'maxpkgs' is iterating over CPU /socket/ ID numbers

The point still stands though. NUMA node ID numbers are not
guaranteed to be the same as socket ID numbers. Very often
then will be the same (which makes it annoying to test as it
is easy to not realize the difference), but we can't rely on
that.

> I'm using functions of libnuma to populate the maxpkgs of the host. 
> I tested this on different Intel CPU with multiple packages and this 
> has always returned the good number of packages. A false positive ?

maxpkgs comes from vmsr_get_max_physical_package() which you're
reading from sysfs, rather than libnuma.

> So here I'm checking if the thread has run on the package number 'i'. 
> I populate 'numa_node_id' with numa_node_of_cpu().
> 
> I did not wanted to reinvent the wheel and the only lib that was talking 
> about "node" was libnuma.

I'm not actually convinced we need to use libnuma at all. IIUC, you're
just trying to track all CPUs within the same physical socket (package).
I don't think we need to care about NUMA nodes to do that tracking.

> Maybe I'm wrong assuming that a "node" (defined as an area where all 
> memory has the same speed as seen from a particular CPU) could lead me 
> to the packages number ?

Historically you could have multiple sockets in the same NUMA node
ie a m:1 mapping.

These days with AMD sockets, you can have 1 socket compromising
many NUMA nodes, as individual dies within a socket are each their
own NUMA node. So a 1:m mapping

On Intel I think it is still typical to have 1 socket per numa
node, but again I don't think we can rely on that 1:1 mapping.

Fortunately I don't think it matters, since it looks like you
don't really need to track NUMA nodes, only sockets (phnysical
package IDs)

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


