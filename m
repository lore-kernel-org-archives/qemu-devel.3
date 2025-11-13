Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F365CD5BA0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 09:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJTIg-0004g9-Pk; Thu, 13 Nov 2025 04:07:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vJTIf-0004fL-3h
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 04:07:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vJTId-0006Gl-4b
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 04:07:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763024843;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=AdHSlZNLdNEXCHS+wkPv/CQN5ik2ky+PiU98l298csY=;
 b=UA3dE9xvqZhUSA2EDG4UFShhXn49Pn74IvSDeDfmu3C01ohdR4jnJlvJYvq/ZUt6Z6CA6/
 ulPEgMe3LBWfVkFYCdEWnmHBEDxbn0yLY/wIgP8Olk4w5X1gzETzzVQa9A5/a0gVDrFakR
 U9hWiH84pxrJK2FPuQNqykhb/+I93Cg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-QZu7uGZdObWy4PfOc1cdFw-1; Thu,
 13 Nov 2025 04:07:21 -0500
X-MC-Unique: QZu7uGZdObWy4PfOc1cdFw-1
X-Mimecast-MFC-AGG-ID: QZu7uGZdObWy4PfOc1cdFw_1763024841
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC30D180047F; Thu, 13 Nov 2025 09:07:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B14F218004A3; Thu, 13 Nov 2025 09:07:18 +0000 (UTC)
Date: Thu, 13 Nov 2025 09:07:14 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com
Subject: Re: [PATCH v3 for-10.2 00/13] Fix deadlock with bdrv_open of
 self-served NBD
Message-ID: <aRWfwmWz2LfgMKrs@redhat.com>
References: <20251113011625.878876-15-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251113011625.878876-15-eblake@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Seems you sent a v3 twice today. I reviewed the earlier v3 and
assume this v3 is an identical accident dupe. If this is actually
a v3 let me know and i'll review further...

On Wed, Nov 12, 2025 at 07:11:25PM -0600, Eric Blake wrote:
> v2 was here:
> https://lists.nongnu.org/archive/html/qemu-devel/2025-11/msg01243.html
> 
> Since then:
>  - drop patch 7/12; refcounting for GSource case is now unchanged
>  - add a couple of patches: fix a chardev leaky abstraction, and add a
>    mutex lock for cross-thread safety
>  - improve commit messages to document why NBD is safe now, even without
>    adding notify callbacks to AioContext
> 
> Now that the new behavior is opt-in rather than a change of defaults,
> and only NBD opts in, it should still be safe to include in 10.2.
> But the technical debt here means that we really should consider
> improving the AioContext API for 11.0 to allow for a notify function
> similar to what GSource provides.
> 
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream patch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively
> 
> 001/13:[----] [--] 'iotests: Drop execute permissions on vvfat.out'
> 002/13:[----] [--] 'qio: Add trace points to net_listener'
> 003/13:[----] [--] 'qio: Unwatch before notify in QIONetListener'
> 004/13:[----] [--] 'qio: Remember context of qio_net_listener_set_client_func_full'
> 005/13:[down] 'qio: Protect NetListener callback with mutex'
> 006/13:[----] [-C] 'qio: Minor optimization when callback function is unchanged'
> 007/13:[0042] [FC] 'qio: Factor out helpers qio_net_listener_[un]watch'
> 008/13:[down] 'chardev: Reuse channel's cached local address'
> 009/13:[0053] [FC] 'qio: Provide accessor around QIONetListener->sioc'
> 010/13:[0013] [FC] 'qio: Prepare NetListener to use AioContext'
> 011/13:[0041] [FC] 'qio: Add QIONetListener API for using AioContext'
> 012/13:[----] [--] 'nbd: Avoid deadlock in client connecting to same-process server'
> 013/13:[----] [--] 'iotests: Add coverage of recent NBD qio deadlock fix'
> 
> Eric Blake (13):
>   iotests: Drop execute permissions on vvfat.out
>   qio: Add trace points to net_listener
>   qio: Unwatch before notify in QIONetListener
>   qio: Remember context of qio_net_listener_set_client_func_full
>   qio: Protect NetListener callback with mutex
>   qio: Minor optimization when callback function is unchanged
>   qio: Factor out helpers qio_net_listener_[un]watch
>   chardev: Reuse channel's cached local address
>   qio: Provide accessor around QIONetListener->sioc
>   qio: Prepare NetListener to use AioContext
>   qio: Add QIONetListener API for using AioContext
>   nbd: Avoid deadlock in client connecting to same-process server
>   iotests: Add coverage of recent NBD qio deadlock fix
> 
>  include/io/channel-socket.h                   |   2 +-
>  include/io/net-listener.h                     |  71 ++++-
>  blockdev-nbd.c                                |   4 +-
>  chardev/char-socket.c                         |   2 +-
>  io/net-listener.c                             | 300 +++++++++++++-----
>  migration/socket.c                            |   4 +-
>  ui/vnc.c                                      |  34 +-
>  io/trace-events                               |   5 +
>  tests/qemu-iotests/tests/nbd-in-qcow2-chain   |  94 ++++++
>  .../qemu-iotests/tests/nbd-in-qcow2-chain.out |  75 +++++
>  tests/qemu-iotests/tests/vvfat.out            |   0
>  11 files changed, 498 insertions(+), 93 deletions(-)
>  create mode 100755 tests/qemu-iotests/tests/nbd-in-qcow2-chain
>  create mode 100644 tests/qemu-iotests/tests/nbd-in-qcow2-chain.out
>  mode change 100755 => 100644 tests/qemu-iotests/tests/vvfat.out
> 
> -- 
> 2.51.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


