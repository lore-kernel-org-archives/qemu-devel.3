Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE2F7C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 19:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5qz5-0002iV-K2; Fri, 18 Apr 2025 15:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u5qz4-0002fu-8V
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 15:02:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u5qz1-0003eR-6I
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 15:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745002957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K3jpry0o8nsRbnXEyDGnY4hXLxHPSTmnZActzOGbcrs=;
 b=iKsR0Nb6aFddUELD5PkSmGbbF4nyDIIQV7e6JUbtF9dNkE0UHmhkgSTBQr42bf3f3FUZI6
 SHDLgpRV6Cqv79E3hcKxAz+vgde6PWso8Y6mo9NlUpHOOSj7CpZHvmoHYIcEbdH5pO15jL
 /7nReqlnyy4h8dl14KmEg2n+VLduueE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-2mBMJly4OraxbIRlYBsIaA-1; Fri,
 18 Apr 2025 15:02:34 -0400
X-MC-Unique: 2mBMJly4OraxbIRlYBsIaA-1
X-Mimecast-MFC-AGG-ID: 2mBMJly4OraxbIRlYBsIaA_1745002952
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BB88195608C; Fri, 18 Apr 2025 19:02:30 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.121])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B679119560BA; Fri, 18 Apr 2025 19:02:23 +0000 (UTC)
Date: Fri, 18 Apr 2025 14:02:20 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 vsementsov@yandex-team.ru, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 John Snow <jsnow@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Lieven <pl@dlhnet.de>, 
 "Denis V. Lunev" <den@openvz.org>, Alberto Garcia <berto@igalia.com>, 
 Ilya Dryomov <idryomov@gmail.com>, Stefan Weil <sw@weilnetz.de>, 
 "open list:GLUSTER" <integration@gluster.org>
Subject: Re: [PATCH v2 01/11] block: Expand block status mode from bool to enum
Message-ID: <gbu62ipbe2qsqham2stapswrhyv3s2fbpqrbqninmuuznllj2n@gk2cje7zon2m>
References: <20250417184133.105746-13-eblake@redhat.com>
 <20250417184133.105746-14-eblake@redhat.com>
 <20250417201755.GA85491@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417201755.GA85491@fedora>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Apr 17, 2025 at 04:17:55PM -0400, Stefan Hajnoczi wrote:
> On Thu, Apr 17, 2025 at 01:39:06PM -0500, Eric Blake wrote:
> > This patch is purely mechanical, changing bool want_zero into a new
> > enum BlockStatusMode.  As of this patch, all implementations are
> > unchanged (the old want_zero==true is now mode==BDRV_BSTAT_PRECISE),
> > but the callers in io.c are set up so that future patches will be able
> > to differente between whether the caller cares more about allocation
> 
> differentiate
> 
> > or about reads-as-zero, for driver implementations that will actually
> > want to behave differently for those more-specific hints.
> > 
> > As for the background why this patch is useful: right now, the
> > file-posix driver recognizes that if allocation is being queried, the
> > entire image can be reported as allocated (there is no backing file to
> > refer to) - but this throws away information on whether the entire
> > image reads as zero (trivially true if lseek(SEEK_HOLE) at offset 0
> > returns -ENXIO, a bit more complicated to prove if the raw file was
> > created with 'qemu-img create' since we intentionally allocate a small
> > chunk of all-zero data to help with alignment probing).  The next
> > patches will add a generic algorithm for seeing if an entire file
> > reads as zeroes, as well as tweak the file-posix driver to react to
> > the new hints.
> > 

> > +/* Modes for block status calls */
> > +enum BlockStatusMode {
> > +    /*
> > +     * Status should be as accurate as possible: _OFFSET_VALID
> > +     * and_OFFSET_ZERO should each be set where efficiently possible,
> 
> "and _OFFSET_ZERO"
> 
> > +     * extents may be smaller, and iteration through the entire block
> > +     * device may take more calls.
> > +     */
> > +    BDRV_BSTAT_PRECISE,
> > +
> > +    /*
> > +     * The caller is primarily concerned about overall allocation:
> > +     * favor larger *pnum, perhaps by coalescing extents and reporting
> > +     * _DATA instead of _ZERO, and without needing to read data or
> > +     * bothering with _OFFSET_VALID.
> > +     */
> > +    BDRV_BSTAT_ALLOCATED,
> > +
> > +    /*
> > +     * The caller is primarily concerned about whether the device
> > +     * reads as zero: favor a result of _ZERO, even if it requires
> > +     * reading a few sectors to verify, without needing _OFFSET_VALID.
> > +     */
> > +    BDRV_BSTAT_ZERO,
> > +};
> 
> I have trouble understanding what the exact semantics are of these modes
> are. Would it be possible to pass flags to block status calls that can
> be ORed together instead: WANT_OFFSET_VALID, WANT_ZERO, etc? The flags
> would be orthogonal and easier to understand than modes that seem to
> combine multiple flag behaviors.

I can give that a try.  If I'm understanding the request correctly, I
would map it as follows:

BDRV_BSTAT_PRECISE => WANT_ZERO | WANT_OFFSET_VALID | WANT_ALLOCATED
BDRV_BSTAT_ALLOCATED => WANT_ALLOCATED
BDRV_BSTAT_ZERO => WANT_ZERO

while still trying to keep it a mechanical conversion in this patch.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


