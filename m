Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D53FC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 11:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkMPm-00084E-GM; Wed, 13 Mar 2024 07:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rkMPj-00083r-DO
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 07:04:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rkMPh-0000U2-4k
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 07:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710327886;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xTr+njGk3GsFdCw6MLtnpMXfqrNez0s9HGsAL4rnVTo=;
 b=QAU5OzaQ3mGm8KzXVQhqOYbJhAiAIsdWmfy0j/kVFm5mF2vaduEnNepoYytNNfb1wf5yVT
 T1Iqpd/xKo6mx4ugVKtxyFVe+OPsCQ2+ZCCbCavUoO+TtImL5k08KjNLmihHpzFHvzgNpg
 ndt1A6adPtzbCyU1rlXeRRZN6SA2IAI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-33eKy8ZtNnm_B8Yf6Oiy3g-1; Wed, 13 Mar 2024 07:04:44 -0400
X-MC-Unique: 33eKy8ZtNnm_B8Yf6Oiy3g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A95DC87280D
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 11:04:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8929F492BC7;
 Wed, 13 Mar 2024 11:04:43 +0000 (UTC)
Date: Wed, 13 Mar 2024 11:04:41 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anthony Harivel <aharivel@redhat.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 vchundur@redhat.com
Subject: Re: [PATCH v3 3/3] Add support for RAPL MSRs in KVM/Qemu
Message-ID: <ZfGIScbYp3htVRMi@redhat.com>
References: <20240125072214.318382-1-aharivel@redhat.com>
 <20240125072214.318382-4-aharivel@redhat.com>
 <ZbjDtytv-_-Bz4-S@redhat.com> <CZRQCYCXNTF2.1I5CNECSOB6IL@fedora>
 <ZfB5eBwWXL45sN_K@redhat.com> <CZSKAAQ3HE0Q.32DYA8Y3PX16V@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CZSKAAQ3HE0Q.32DYA8Y3PX16V@fedora>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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

On Wed, Mar 13, 2024 at 11:48:19AM +0100, Anthony Harivel wrote:
> Hi Daniel,
> 
> Daniel P. Berrangé, Mar 12, 2024 at 16:49:
> 
> > The point still stands though. NUMA node ID numbers are not
> > guaranteed to be the same as socket ID numbers. Very often
> > then will be the same (which makes it annoying to test as it
> > is easy to not realize the difference), but we can't rely on
> > that.
> >
> > > I'm using functions of libnuma to populate the maxpkgs of the host. 
> > > I tested this on different Intel CPU with multiple packages and this 
> > > has always returned the good number of packages. A false positive ?
> >
> > maxpkgs comes from vmsr_get_max_physical_package() which you're
> > reading from sysfs, rather than libnuma.
> >
> > > So here I'm checking if the thread has run on the package number 'i'. 
> > > I populate 'numa_node_id' with numa_node_of_cpu().
> > > 
> > > I did not wanted to reinvent the wheel and the only lib that was talking 
> > > about "node" was libnuma.
> >
> > I'm not actually convinced we need to use libnuma at all. IIUC, you're
> > just trying to track all CPUs within the same physical socket (package).
> > I don't think we need to care about NUMA nodes to do that tracking.
> >
> 
> Alright, having a deeper look I'm actually using NUMA for 2 info:
> 
> - How many cpu per Package: this helps me calculate the ratio.
> 
> - To whom package the cpu belongs: to calculate the ratio with the right 
>   package energy counter.
> 
> Without libnuma, I'm bit confused on how to handle this. 
> 
> Should I parse /sys/bus/node/devices/node* to know how many packages ?
> Should I parse /sys/bus/node/devices/node0/cpu0/topology/core_cpus_list 
> to handle which cpu belongs to which package ?

You don't need to access it via the /node/ hierarchy

The canonical path for CPUs would be

  /sys/devices/system/cpu/cpuNNN/topology

The core_cpus_list file is giving you hyper-thread siblings within
a core, which I don't think is what you want.

If you're after discrete physical packages, then 'package_cpus_list'
gives you all CPUs within a physical socket (package) I believe.

> Would that be too cumbusome for the user to enter the detail about how
> many packages and how many cpu per pakages ? 
> 
> i.e: 
> -kvm,rapl=true,maxpkgs=2,cpupkgs=8,rapl-helper-socket=/path/sock.sock

That won't cope with asymmetrical CPU configurations, so I think it
is preferrable to read the info from sysfs.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


