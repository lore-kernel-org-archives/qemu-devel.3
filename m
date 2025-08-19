Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C26CA0EED
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 10:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoJcf-0003IV-Jj; Tue, 19 Aug 2025 06:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoJcd-0003Ht-TH
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 06:31:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoJcb-0007n6-L1
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 06:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755599474;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=3nmqpu2qd0dJDqbZzPGD4yXZwWm+HaSWyj7LBY4GAQU=;
 b=Nc9vrFJSIBebnXOZQiFyCA1IKH5DeBk0DZ5vvTraKe8N0yp9Kt5QK/yBCzWLSi0oJLpzQD
 kumnryUdA2E0aYsX5OTU/rXKJwuSS4+orz2PVFmTT/2F/TT0FtZ3e4OKx6+vZHD230sk70
 sGHwAdZvpU0/iF+YGpr/TePZv718+So=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-5STzQj-IOVu3FaTP958nFg-1; Tue,
 19 Aug 2025 06:31:10 -0400
X-MC-Unique: 5STzQj-IOVu3FaTP958nFg-1
X-Mimecast-MFC-AGG-ID: 5STzQj-IOVu3FaTP958nFg_1755599469
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89ED9195F167; Tue, 19 Aug 2025 10:31:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.237])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2336C180028A; Tue, 19 Aug 2025 10:31:06 +0000 (UTC)
Date: Tue, 19 Aug 2025 11:31:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Yong Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] multifd: Make the main thread yield periodically to the
 main loop
Message-ID: <aKRSZ7jCfIzvv4jW@redhat.com>
References: <5512220e1005ae2bc7357b2def32639d164e84eb.1754534263.git.yong.huang@smartx.com>
 <20250807113639.66d1c5bf@penguin>
 <CAK9dgmZb=5uEwVq65Ygcza0+qtng+-5zmtQRdviX2npg_qhJRQ@mail.gmail.com>
 <20250808090054.13cb8342@penguin>
 <CAK9dgmbybw+WkC2C_qdZnwSYjGn3Q2Du4yjLOz+EmCx1po8YPg@mail.gmail.com>
 <87o6sp2a0i.fsf@suse.de> <aJYZs9NnAOqVMcd1@x1.local>
 <20250811090345.4360fec4@penguin> <878qjq0xtk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878qjq0xtk.fsf@suse.de>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 11, 2025 at 10:53:11AM -0300, Fabiano Rosas wrote:
> Lukas Straub <lukasstraub2@web.de> writes:
> 
> > On Fri, 8 Aug 2025 11:37:23 -0400
> > Peter Xu <peterx@redhat.com> wrote:
> >
> >> On Fri, Aug 08, 2025 at 10:55:25AM -0300, Fabiano Rosas wrote:
> >> > Please work with Lukas to figure out whether yank can be used here. I
> >> > think that's the correct approach. If the main loop is blocked, then
> >> > some out-of-band cancellation routine is needed. migrate_cancel() could
> >> > be it, but at the moment it's not. Yank is the second best thing.  
> >> 
> >> I agree.
> >> 
> >> migrate_cancel() should really be an OOB command..  It should be a superset
> >> of yank features, plus anything migration speficic besides yanking the
> >> channels, for example, when migration thread is blocked in PRE_SWITCHOVER.
> >
> > Hmm, I think the migration code should handle this properly even if the
> > yank command is used. From the POV of migration, it sees that the
> > connection broke with connection reset. That is the same error as if the
> > other side crashes/is killed or a NAT/stateful firewall in between
> > reboots.
> >
> 
> That should all work just fine. After yank or after a detectable network
> failure. The issue here seems to be that the destination recv is hanging
> indefinitely. I don't think we ever played with socket timeout
> configurations, or even switching to non-blocking during the sync. This
> is actually (AFAIK) the first time we get a hang that's not "just" a
> synchronization issue in the migration code.

Based on the stack trace, whether the socket is blocking or not isn't a
problem - QEMU is stuck in a  sem_wait call that will delay the coroutine,
and thus the thread, indefinitely. IMHO the semaphore usage needs to be
removed in favour of a synchronization mechanism that can integrate with
event loop such that the coroutine does not block.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


