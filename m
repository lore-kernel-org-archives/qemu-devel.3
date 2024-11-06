Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F138D59F4A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 16:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8iSm-0002gv-DW; Wed, 06 Nov 2024 11:00:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t8iSk-0002fM-J9
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 11:00:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t8iSS-00038o-2Y
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 11:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730908835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LhCG23UdjzGAPAAPEIRjcVF3Gh6Q/kASSdy2wTPQY70=;
 b=dqq95+lrewtOgPwD57zSQQkx1K443rzr4P2pkj6VjRvwcxgvD6jlax/1uH7hw7zP4IPQer
 YbBE5vvMfoa60GR/WSjCbFhDlt2MMgswCPCgUmiCwerE7x7QWnkV2GlDKMS33eD7Lx2lNz
 6j9sEfCJKlvFaFPJNaFf6rqeVfVFZbw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-L1NQEtLTOceAF_oGPbftnw-1; Wed,
 06 Nov 2024 11:00:32 -0500
X-MC-Unique: L1NQEtLTOceAF_oGPbftnw-1
X-Mimecast-MFC-AGG-ID: L1NQEtLTOceAF_oGPbftnw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4860B19560BF; Wed,  6 Nov 2024 16:00:30 +0000 (UTC)
Received: from redhat.com (dhcp-192-228.str.redhat.com [10.33.192.228])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 23FA71956088; Wed,  6 Nov 2024 16:00:26 +0000 (UTC)
Date: Wed, 6 Nov 2024 17:00:24 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: Dmitry Frolov <frolov@swemel.ru>, stefanha@redhat.com, den@openvz.org,
 sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH] block: fix possible int overflow
Message-ID: <ZyuSmIR0hL4pzieK@redhat.com>
References: <20241106080521.219255-2-frolov@swemel.ru>
 <Zys8tLcKjADMtkqn@redhat.com>
 <cbd949dd-673d-46cb-8cd7-9fc94515afc0@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbd949dd-673d-46cb-8cd7-9fc94515afc0@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 06.11.2024 um 16:45 hat Denis V. Lunev geschrieben:
> On 11/6/24 10:53, Kevin Wolf wrote:
> > [ Cc: qemu-block ]
> > 
> > Am 06.11.2024 um 09:04 hat Dmitry Frolov geschrieben:
> > > The sum "cluster_index + count" may overflow uint32_t.
> > > 
> > > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > > 
> > > Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> > Thanks, applied to the block branch.
> > 
> > While trying to check if this can be triggered in practice, I found this
> > line in parallels_fill_used_bitmap():
> > 
> >      s->used_bmap_size = DIV_ROUND_UP(payload_bytes, s->cluster_size);
> > 
> > s->used_bmap_size is unsigned long, payload_bytes is the int64_t result
> > of bdrv_getlength() for the image file, which could certainly be made
> > more than 4 GB * cluster_size. I think we need an overflow check there,
> > too.
> > 
> > When allocate_clusters() calculates new_usedsize, it doesn't seem to
> > consider the overflow case either.
> > 
> > Denis, can you take a look?
> > 
> > Kevin
> > 
> Hi, Kevin, Dmitry!
> 
> In general, the situation is the following.
> 
> On-disk format heavily uses offsets from the beginning of the disk
> denominated in clusters. These offsets are saved in uint32 on disk.
> This means that the image with 4T virtual size and 1M cluster size
> will use offsets from 0 to 4 * 2^10 in different tables on disk.
> 
> There is existing problem in the format specification that we
> can not easily apply limits to the virtual size of the disk as
> we also can have arbitrary size growing metadata like CBT, which
> is kept in the same address space (cluster offsets).
> 
> Though in reality I have never seen images with non-1 Mb cluster
> size and in order to nearly overflow them we would need really
> allocated images of 4 PB.
> 
> Theoretically the problem is possible but it looks impractical
> to me in the real life so far.

It probably won't happen with normal images, but we need to consider
malicious images, and I think they could be constructed in a way that
causes integer overflows here.

At least the one that directly takes bdrv_getlength() should be trivial
to trigger, you just need to extend the file size enough outside of
QEMU.

Kevin


