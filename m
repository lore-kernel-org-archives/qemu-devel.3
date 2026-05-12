Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FB3CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 12:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMm9E-0007Og-Nx; Tue, 12 May 2026 08:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wMm8i-0007NN-VJ
 for qemu-devel@nongnu.org; Tue, 12 May 2026 08:23:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wMm8b-0006w4-5y
 for qemu-devel@nongnu.org; Tue, 12 May 2026 08:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778588578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rmUszY8Ay3e5iEQfb45OQFt940K5N8zmKwgSlWjYZCM=;
 b=WFFbrWVrzLz3pCuppMhsGl6QlxJn3ypSyWLk3P4pBNGtTcMP8rKs1rizJURZbWKgV/HHOp
 XqEs3UDIU91S4ceJBrSU4/y5oiGwU51s4cqRC/MMb9Fjht2g33NkMM7XvpwL8EwzfkWBC2
 hJGre/E7AG+WeGDennK6bTbdtv/O3XA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-vWhkNvv5Nvmrs_h9Vaemjg-1; Tue,
 12 May 2026 08:22:56 -0400
X-MC-Unique: vWhkNvv5Nvmrs_h9Vaemjg-1
X-Mimecast-MFC-AGG-ID: vWhkNvv5Nvmrs_h9Vaemjg_1778588575
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EB361956095; Tue, 12 May 2026 12:22:55 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.152])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CE1118004A3; Tue, 12 May 2026 12:22:52 +0000 (UTC)
Date: Tue, 12 May 2026 14:22:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, den@openvz.org,
 stefanha@redhat.com, qemu-stable@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 3/4] qcow2: Fix corruption on discard during write with COW
Message-ID: <agMbmZvW3MCSX3BF@redhat.com>
References: <20260427170520.101242-1-kwolf@redhat.com>
 <20260427170520.101242-4-kwolf@redhat.com>
 <76eb4371-8cfe-4d9f-870f-56c9a6dda334@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76eb4371-8cfe-4d9f-870f-56c9a6dda334@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 29.04.2026 um 17:28 hat Fiona Ebner geschrieben:
> Am 27.04.26 um 7:04 PM schrieb Kevin Wolf:
> > @@ -2000,6 +2028,15 @@ int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
> >      int64_t cleared;
> >      int ret;
> >  
> > +    /*
> > +     * If we're touching a cluster for which allocating writes are in flight,
> > +     * wait for them to complete to avoid conflicting metadata updates.
> > +     *
> > +     * We don't need to allocate a QCowL2Meta for the discard operation because
> > +     * s->lock is held for the duration of the whole operation.
> 
> The caller in qcow2_make_empty() does not acquire s->lock AFAICS. Can
> that be a problem?

This is the case the comment inside wait_for_dependencies() is about:

    /*
     * Discard has some non-coroutine callers (creating internal snapshots and
     * make empty). They are calling from qemu-img or in a drained section, so
     * we know that no writes can be in progress.
     */

So it should be fine in practice because we know a bigger hammer is
already in use for synchronisation.

Kevin

> > +     */
> > +    wait_for_dependencies(bs, offset, bytes);
> > +
> >      /* Caller must pass aligned values, except at image end */
> >      assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
> >      assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size) ||


