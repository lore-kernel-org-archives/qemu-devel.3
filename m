Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6C8C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 15:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfLCO-0006rk-K3; Tue, 04 Feb 2025 10:50:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tfLCM-0006mq-0Z
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:50:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tfLCK-0008VJ-HS
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:50:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738684247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZLbKO2t09fWqFQkVNQD4gYJ2U1XDLk9UlpUrnRxot6s=;
 b=dD1ZA4yyE4o0EzHhmyz6rq2EBTAvOBB2OyhpeOAX2OqscqcmDQd/TP0qSk+UqPDsy34oej
 y8iG69vJCiAS0T5WPv6SPH4llXtqjRW5NJ3MVy27xHcqwLMbxdsLWAzhepkdTjbv/gIr8N
 EjNjgl0yEq56TqNUByrOIyN776ggy6Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-gyAw78HxO0u__VvwjRG9PQ-1; Tue,
 04 Feb 2025 10:50:46 -0500
X-MC-Unique: gyAw78HxO0u__VvwjRG9PQ-1
X-Mimecast-MFC-AGG-ID: gyAw78HxO0u__VvwjRG9PQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C0A919560BB; Tue,  4 Feb 2025 15:50:45 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.100])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2439B195608E; Tue,  4 Feb 2025 15:50:40 +0000 (UTC)
Date: Tue, 4 Feb 2025 16:50:38 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, stefanha@redhat.com,
 pkrempa@redhat.com, peterx@redhat.com, farosas@suse.de,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 03/15] migration/block-active: Remove global active flag
Message-ID: <Z6I3Th0jMdVvmEeo@redhat.com>
References: <20250130171240.286878-1-kwolf@redhat.com>
 <20250130171240.286878-4-kwolf@redhat.com>
 <w4os6ygobpsglo4h4a6gmg35sv4wzqvww4jzviqsjwwmjdywvh@nzdyfj3ybiar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w4os6ygobpsglo4h4a6gmg35sv4wzqvww4jzviqsjwwmjdywvh@nzdyfj3ybiar>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 30.01.2025 um 20:50 hat Eric Blake geschrieben:
> On Thu, Jan 30, 2025 at 06:12:34PM +0100, Kevin Wolf wrote:
> > Block devices have an individual active state, a single global flag
> > can't cover this correctly. This becomes more important as we allow
> > users to manually manage which nodes are active or inactive.
> > 
> > Now that it's allowed to call bdrv_inactivate_all() even when some
> > nodes are already inactive, we can remove the flag and just
> 
> Is this commit out of order with 5/15 that removes the assertion
> failure for inactivating an already-inactive device?

It is. Looks like I moved things around a bit too much in this series.
5/15 doesn't seem to depend on anything else,m so I'll move it before
this one to fix the ordering.

Kevin

> But in the long run, the sentiment is correct, even if the wording is
> inaccurate for a window of a couple of patches, so I'm not sure it is
> worth a slight rewording to s/it's allows/it will soon be allowed/.
> 
> > unconditionally call bdrv_inactivate_all() and, more importantly,
> > bdrv_activate_all() before we make use of the nodes.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  migration/migration.h    |  3 ---
> >  migration/block-active.c | 46 ----------------------------------------
> >  migration/migration.c    |  8 -------
> >  3 files changed, 57 deletions(-)
> >
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.
> Virtualization:  qemu.org | libguestfs.org
> 


