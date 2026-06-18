Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA9ACD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 16:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waFX7-0003rK-7F; Thu, 18 Jun 2026 12:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waFX4-0003qn-Vy
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 12:23:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waFX3-00035A-3s
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 12:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781799836;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=EGM3VatnGIXX5wmO/1xDf2B8DTVXQHLqvzrc27qUzDc=;
 b=UqYpt04n0h+6vLdf8mBpTrun1HV+mdTGTCwHYWet4Jiqw5D84Ky6iWaYI+18jvuSZTSHMK
 wiloyPih9kel7bLTZTj3+n+zPX+p5jpNmV1cE+ZV354YKlHT0S6+AOoTjaSzDLBxBEHDu5
 qYpU5/fQ5mTl+Y+lFjy9riPhRo/GpLw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-eEi7ylAwNWGCdMVIf4vMnQ-1; Thu,
 18 Jun 2026 12:23:52 -0400
X-MC-Unique: eEi7ylAwNWGCdMVIf4vMnQ-1
X-Mimecast-MFC-AGG-ID: eEi7ylAwNWGCdMVIf4vMnQ_1781799831
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C39FE19541B0; Thu, 18 Jun 2026 16:23:50 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.28])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7DCF30000DB; Thu, 18 Jun 2026 16:23:47 +0000 (UTC)
Date: Thu, 18 Jun 2026 17:23:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] virtio-blk: store the zone-append sector as little-endian
Message-ID: <ajQbkHFIMcuA6r-Y@redhat.com>
References: <20260617151739.4072252-1-michael.bommarito@gmail.com>
 <20260618152059.GF720244@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260618152059.GF720244@fedora>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Jun 18, 2026 at 11:20:59AM -0400, Stefan Hajnoczi wrote:
> On Wed, Jun 17, 2026 at 11:17:39AM -0400, Michael Bommarito wrote:
> > The zone-append completion path writes the append sector back to the
> > guest with virtio_stq_p(), the VIRTIO_F_VERSION_1-aware accessor,
> > while the rest of the zoned reply path (the zone report descriptors
> > and the report header) stores its fields with cpu_to_le64(). The
> > zoned feature is only defined for VIRTIO 1.x devices and the virtio
> > specification defines all of its fields as little-endian, so store the
> > append sector with stq_le_p() too, for a single spec-matching
> > convention across the zoned path.
> > 
> > This is not a functional change for a VIRTIO 1.x device, where
> > virtio_stq_p() already stores little-endian; it only removes the mixed
> > convention within the zoned reply path.
> > 
> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > Assisted-by: Claude:claude-opus-4-8

^^^^^^^  strictly speaking this may not be compatible with our
policy if Claude was used to write the patch.  If Claude was
merely used for research or testing, that's fine.

If it did write the patch, we could make an exception on the
basis that there is only a single way to write this trivial fix.

None the less the Assisted-by advertizing hoarding should be
removed before merging, as even our new proposed looser policy,
rejects use of Assisted-by.

> > Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> > ---
> > Testing: builds (qemu-system-x86_64) and the qos-test virtio-blk cases
> > (basic, indirect, config, resize, msix, idx, nxvirtq, hotplug) pass
> > against the patched binary. No functional change on a
> > VIRTIO_F_VERSION_1 device, where virtio_stq_p() already stores
> > little-endian.
> > 
> >  hw/block/virtio-blk.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>



With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


