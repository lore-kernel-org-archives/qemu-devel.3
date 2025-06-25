Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3877C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 21:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUY69-0007KM-8P; Wed, 25 Jun 2025 17:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uUY65-0007J5-De
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 17:56:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uUY61-00083v-Da
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 17:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750888556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=30U/2EadVs/QEDxpbfiZxEUuQUSscA01ZE+O2kk5DRU=;
 b=OqTK9zXxIIQ6FyGyPxL2k+q7WHnjao5jGtJVLOWkAMKB6+oQJ4SIf+HN05tVA5gpNhUAFh
 UnyBQ5qNAGR6BrmyVa/Ck56oN4qugBauiJldatWGUGufY4OnIy4vAFAa8azsW/fN6u6lDe
 I/Gc09hhIYg/ZsFbg0khJu5YA6NOZ0E=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-yFxTt7F8NdafGCKP0R8inA-1; Wed,
 25 Jun 2025 17:55:53 -0400
X-MC-Unique: yFxTt7F8NdafGCKP0R8inA-1
X-Mimecast-MFC-AGG-ID: yFxTt7F8NdafGCKP0R8inA_1750888552
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5353D19560B0; Wed, 25 Jun 2025 21:55:52 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.27])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFFCC1956096; Wed, 25 Jun 2025 21:55:49 +0000 (UTC)
Date: Wed, 25 Jun 2025 16:55:47 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, afaria@redhat.com, timao@redhat.com, 
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] file-posix: Fix aio=threads performance regression after
 enablign FUA
Message-ID: <ulpzd3sujt42toy4jbvojabatt4vv6267iwta7ga7j2k4y4nvi@vrbpho2uh6od>
References: <20250625085019.27735-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625085019.27735-1-kwolf@redhat.com>
User-Agent: NeoMutt/20250510
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Jun 25, 2025 at 10:50:19AM +0200, Kevin Wolf wrote:
> For aio=threads, we're currently not implementing REQ_FUA in any useful
> way, but just do a separate raw_co_flush_to_disk() call. This changes
> behaviour compared to the old state, which used bdrv_co_flush() with its
> optimisations. As a quick fix, call bdrv_co_flush() again like before.
> Eventually, we can use pwritev2() to make use of RWF_DSYNC if available,
> but we'll still have to keep this code path as a fallback, so this fix
> is required either way.
> 
> While the fix itself is a one-liner, some new graph locking annotations
> are needed to convince TSA that the locking is correct.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 984a32f17e8d ("file-posix: Support FUA writes")
> Buglink: https://issues.redhat.com/browse/RHEL-96854
> Reported-by: Tingting Mao <timao@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/file-posix.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


