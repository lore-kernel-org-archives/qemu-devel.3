Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF37CA5FD7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viG6p-0002S2-0e; Tue, 20 Jan 2026 13:05:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1viG6m-0002Rm-I4
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:05:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1viG6j-0000uQ-Gw
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:05:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768932335;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/xJWznVGppdGpEyprXWmr4vNbSBiqj8pRUJzWOqzHkw=;
 b=ic+8h/HoOPOujAqgqUEDKQ01haMIOmuBLLfSxWWvsBb6orCHy9hZbTKJmVHIYaQwCuGCi/
 7EXPZ9QT2eStQdTpDzCtelUlVFrY2Zpkz/8Ydt2OYo+qFmbPOYgW6CUGodRzVwK2dSlOiM
 JM9TU7d+IQ9jmCd2y6OhdWv15scfBN0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-ICeU_Z99MjCRreG0BryJ0w-1; Tue,
 20 Jan 2026 13:05:23 -0500
X-MC-Unique: ICeU_Z99MjCRreG0BryJ0w-1
X-Mimecast-MFC-AGG-ID: ICeU_Z99MjCRreG0BryJ0w_1768932322
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B18E19560B1; Tue, 20 Jan 2026 18:05:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.89])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FE8B19560A2; Tue, 20 Jan 2026 18:05:18 +0000 (UTC)
Date: Tue, 20 Jan 2026 18:05:15 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@trasno.org>
Subject: Re: [PATCH v2 4/8] multifd: Add COLO support
Message-ID: <aW_D2-EEE_aSC_rJ@redhat.com>
References: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
 <20260117-colo_unit_test_multifd-v2-4-ab521777fa51@web.de>
 <aW-31rQky14G8_lq@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aW-31rQky14G8_lq@x1.local>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Tue, Jan 20, 2026 at 12:13:58PM -0500, Peter Xu wrote:
> On Sat, Jan 17, 2026 at 03:09:11PM +0100, Lukas Straub wrote:
> > Like in the normal ram_load() path, put the received pages into the
> > colo cache and mark the pages in the bitmap so that they will be
> > flushed to the guest later.
> > 
> > Multifd with COLO is useful to reduce the VM pause time during checkpointing
> > for latency sensitive workloads. In such workloads the worst-case latency
> > is especially important.
> > 
> > Also, multifd migration is the preferred way to do migration nowadays and this
> > allows to use multifd compression with COLO.
> > 
> > Benchmark:
> > Cluster nodes
> >  - Intel Xenon E5-2630 v3
> >  - 48Gb RAM
> >  - 10G Ethernet
> > Guest
> >  - Windows Server 2016
> >  - 6Gb RAM
> >  - 4 cores
> > Workload
> >  - Upload a file to the guest with SMB to simulate moderate
> >    memory dirtying
> >  - Measure the memory transfer time portion of each checkpoint
> >  - 600ms COLO checkpoint interval
> > 
> > Results
> > Plain
> >  idle mean: 4.50ms 99per: 10.33ms
> >  load mean: 24.30ms 99per: 78.05ms
> > Multifd-4
> >  idle mean: 6.48ms 99per: 10.41ms
> >  load mean: 14.12ms 99per: 31.27ms
> 
> Thanks for the numbers.  They're persuasive at least from 1st look.
> 
> Said that, one major question is, multifd should only help with throughput
> when cpu is a bottleneck sending, in your case it's 10Gbps NIC.  Normally
> any decent cpu should be able to push closer to 10Gbps even without
> multifd.

That assumes the CPUs used by migration are otherwise idle though. If the
host is busy running guest workloads, only small timeslices may be available
for use by migration threads. Using multifd would better utilize what's
available if multiple host CPUs have partial availability.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


