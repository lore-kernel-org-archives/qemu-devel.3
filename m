Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D304606A32F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h+4Aowok
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOH2V-0003ym-RI; Tue, 03 Nov 2026 11:07:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xOH2S-0003y2-GJ
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 11:07:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xOH2Q-0007JB-Fy
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 11:07:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793722024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X/xH7owUOWlecAyymfxk65DI0LsFF/g3YYyBZycan2Q=;
 b=h+4AowokdDNXloRY3w4WmWhUiZu96SJLLv9nWXE7D/RQzb/hC1BS2FyOLEW7QmAaG2s0FG
 iyhRpC19r6K0b2PI7jDFLD2csVaHF2jr0C+OQaPHJq+poqxIVvBml0m6AjIQ6f+IMAB5Ud
 f6rp+uobxgwdQZIvE3Zh1Kq4gjOsJoA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-BIW03FS9NnK4ToB53y5Xmg-1; Tue,
 03 Nov 2026 11:07:02 -0500
X-MC-Unique: BIW03FS9NnK4ToB53y5Xmg-1
X-Mimecast-MFC-AGG-ID: BIW03FS9NnK4ToB53y5Xmg_1793722021
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 111C71977421; Tue,  3 Nov 2026 16:06:45 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.52])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A7FC30002CF; Tue,  3 Nov 2026 16:06:42 +0000 (UTC)
Date: Tue, 3 Nov 2026 17:06:40 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Jean-Louis Dupond <jean-louis@dupond.be>
Cc: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 den@openvz.org
Subject: Re: [PATCH 2/3] qcow2: fix snapshot data corruption with
 discard-no-unref=on
Message-ID: <auoGkJ_RCxFRjh3U@redhat.com>
References: <20261027104441.830212-1-andrey.drobyshev@virtuozzo.com>
 <20261027104441.830212-3-andrey.drobyshev@virtuozzo.com>
 <713e8c49-5a9c-4d42-9038-8b6f9cc70260@dupond.be>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <713e8c49-5a9c-4d42-9038-8b6f9cc70260@dupond.be>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 29.10.2026 um 15:58 hat Jean-Louis Dupond geschrieben:
> 
> On 27/10/2026 11:44, Andrey Drobyshev wrote:
> > Whenever option discard-no-unref=on is enabled, we bypass refcount
> > machinery and unconditionally punch hole in the data on 'discard' and
> > 'write -z -u' paths.  However, when this same cluster is also referenced
> > by an internal snapshot, such operations lead to problems.  The active L2
> > table is copied before it is changed, so the snapshot metadata stays
> > correct, but the host range under it is punched out and the snapshot reads
> > zeroes there afterwards. qemu-img check finds nothing wrong.
> > 
> > Fix this by guarding the 'keep_reference' flag by the presence of the
> > QCOW_OFLAG_COPIED bit.  I.e. only proceed with unconditional data
> > punching if we own this cluster exclusively.
> > 
> > Fixes: 42a2890a76f4 ("qcow2: add discard-no-unref option")
> > Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> > ---
> >   block/qcow2-cluster.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> > index e02fae6a0c6..cc473c7c796 100644
> > --- a/block/qcow2-cluster.c
> > +++ b/block/qcow2-cluster.c
> > @@ -1953,6 +1953,7 @@ discard_in_l2_slice(BlockDriverState *bs, uint64_t offset, uint64_t nb_clusters,
> >           QCow2ClusterType cluster_type =
> >               qcow2_get_cluster_type(bs, old_l2_entry);
> >           bool keep_reference = (cluster_type != QCOW2_CLUSTER_COMPRESSED) &&
> > +                              (old_l2_entry & QCOW_OFLAG_COPIED) &&
> >                                 !full_discard &&
> >                                 (s->discard_no_unref &&
> >                                  type == QCOW2_DISCARD_REQUEST);
> 
> Wouldn't it be better to gate only qcow2_discard_cluster when the cluster is
> QCOW_OFLAG_COPIED?
> Cause with the above change, we fully clear/remove the offset of the
> cluster, causing fragmentation again in the image afterwards.
> And that was just the goal for discard-no-unref :)

I thought of this, too, but merely because it seems to be a closer match
for the expectation the name "discard-no-unref" sets.

In practice, I don't expect that you'd see any advantage from it.
Writing again to this cluster will cause COW, so you'll get
fragmentation either way.

Kevin


