Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E98CD1280
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 12:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp6A5-0007DK-Ta; Tue, 26 Mar 2024 08:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rp6A3-0007Cm-SY
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:44:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rp6A1-0002Pk-UX
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711457053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g80XP/Oz8c5Koy+LxFsiMs5PhQ4a17IbA7RAbNrNW4A=;
 b=EtLyx2HujdEDW8K7bUPqIXkBipu6TNQ8G5e8mo/Uyh28bCrLrdJiyqDH0KzdMkNcCtVY27
 LCUmzz+2YJ/rHcJwl91y2DoPvaRw0zN/EqTtHZ6/0+UB7u+RZ+8GRoOyUhQFU+hssYksDL
 iqnU0PBONuuD9VNokQs5PxEE3+8oOio=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-PCISl6kUOqCxQDAILlgZFA-1; Tue,
 26 Mar 2024 08:44:09 -0400
X-MC-Unique: PCISl6kUOqCxQDAILlgZFA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9039B3CBD50E;
 Tue, 26 Mar 2024 12:44:08 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C41E61074E;
 Tue, 26 Mar 2024 12:44:06 +0000 (UTC)
Date: Tue, 26 Mar 2024 13:44:01 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 hreitz@redhat.com, fam@euphon.net, stefanha@redhat.com,
 t.lamprecht@proxmox.com, w.bumiller@proxmox.com
Subject: Re: [PATCH v3 2/4] block-backend: fix edge case in bdrv_next() where
 BDS associated to BB changes
Message-ID: <ZgLDEdmI0rBcJcGh@redhat.com>
References: <20240322095009.346989-1-f.ebner@proxmox.com>
 <20240322095009.346989-3-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322095009.346989-3-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 22.03.2024 um 10:50 hat Fiona Ebner geschrieben:
> The old_bs variable in bdrv_next() is currently determined by looking
> at the old block backend. However, if the block graph changes before
> the next bdrv_next() call, it might be that the associated BDS is not
> the same that was referenced previously. In that case, the wrong BDS
> is unreferenced, leading to an assertion failure later:
> 
> > bdrv_unref: Assertion `bs->refcnt > 0' failed.

Your change makes sense, but in theory it shouldn't make a difference.
The real bug is in the caller, you can't allow graph modifications while
iterating the list of nodes. Even if it doesn't crash (like after your
patch), you don't have any guarantee that you will have seen every node
that exists that the end - and maybe not even that you don't get the
same node twice.

> In particular, this can happen in the context of bdrv_flush_all(),
> when polling for bdrv_co_flush() in the generated co-wrapper leads to
> a graph change (for example with a stream block job [0]).

The whole locking around this case is a bit tricky and would deserve
some cleanup.

The basic rule for bdrv_next() callers is that they need to hold the
graph reader lock as long as they are iterating the graph, otherwise
it's not safe. This implies that the ref/unref pairs in it should never
make a difference either - which is important, because at least
releasing the last reference is forbidden while holding the graph lock.
I intended to remove the ref/unref for bdrv_next(), but I didn't because
I realised that the callers need to be audited first that they really
obey the rules. You found one that would be problematic.

The thing that bdrv_flush_all() gets wrong is that it promises to follow
the graph lock rules with GRAPH_RDLOCK_GUARD_MAINLOOP(), but then calls
something that polls. The compiler can't catch this because bdrv_flush()
is a co_wrapper_mixed_bdrv_rdlock. The behaviour for these functions is:

- If called outside of coroutine context, they are GRAPH_UNLOCKED
- If called in coroutine context, they are GRAPH_RDLOCK

We should probably try harder to get rid of the mixed functions, because
a synchronous co_wrapper_bdrv_rdlock could actually be marked
GRAPH_UNLOCKED in the code and then the compiler could catch this case.

The fix for bdrv_flush_all() is probably to make it bdrv_co_flush_all()
with a coroutine wrapper so that the graph lock is held for the whole
function. Then calling bdrv_co_flush() while iterating the list is safe
and doesn't allow concurrent graph modifications.

Kevin


