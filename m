Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C19C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 11:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJWEs-0004wy-JP; Mon, 26 May 2025 07:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uJWEn-0004wl-HW
 for qemu-devel@nongnu.org; Mon, 26 May 2025 07:43:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uJWEh-00047p-QE
 for qemu-devel@nongnu.org; Mon, 26 May 2025 07:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748259796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Nf1EwpaMQJ9eurpSk4Y2/D/g648qq3m1SyR1llBZHw=;
 b=e+yX+gP+z7ld9EU35Gxkorvv+itLrRSBNQ8Kb+aW/ACvmKJWc+aQ6BxzdZHDuu2KVeWCtu
 q4mtxMYkO1S0lpU+QecfekfkJ0Ntd0Ps0QuFB65d1WdaXh8qVynSkavbJ/apkDwKxavAB5
 Spwcyv9XEmgqq+N2yr+wP3YRmc/5XSM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-3ovvTQb0PZagNXDoOKev2g-1; Mon,
 26 May 2025 07:43:15 -0400
X-MC-Unique: 3ovvTQb0PZagNXDoOKev2g-1
X-Mimecast-MFC-AGG-ID: 3ovvTQb0PZagNXDoOKev2g_1748259793
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7CB2C1800256; Mon, 26 May 2025 11:43:12 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.150])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 07E7219560AB; Mon, 26 May 2025 11:43:01 +0000 (UTC)
Date: Mon, 26 May 2025 13:42:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 hreitz@redhat.com, stefanha@redhat.com, eblake@redhat.com,
 jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: Re: [PATCH v2 03/24] block/snapshot: move drain outside of
 read-locked bdrv_snapshot_delete()
Message-ID: <aDRTw0XMLog7vAOh@redhat.com>
References: <20250520103012.424311-1-f.ebner@proxmox.com>
 <20250520103012.424311-4-f.ebner@proxmox.com>
 <4fdff680-5e77-40f2-812b-70697ad8ae64@virtuozzo.com>
 <aDQwDbJLqPYVxgCN@redhat.com>
 <6c640f56-31b8-408d-b747-6f75cdfa7592@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c640f56-31b8-408d-b747-6f75cdfa7592@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 26.05.2025 um 12:33 hat Fiona Ebner geschrieben:
> Am 26.05.25 um 11:10 schrieb Kevin Wolf:
> > Am 23.05.2025 um 20:12 hat Andrey Drobyshev geschrieben:
> >> Okay, I've got a very simple and naive question to ask.  We've got this
> >> pattern recurring throughout the series:
> >>
> >>> GLOBAL_STATE_CODE();
> >>> bdrv_drain_all_begin();
> >>> bdrv_graph_rdlock_main_loop();
> >>>
> >>> ...
> >>>
> >>> bdrv_graph_rdunlock_main_loop();
> >>> bdrv_drain_all_end();
> >>
> >> bdrv_graph_rdlock_main_loop() doesn't actually take any locks, it
> >> asserts that we're running in the main thread and not in a coroutine.
> >> bdrv_graph_rdunlock_main_loop() does the same.
> >> GRAPH_RDLOCK_GUARD_MAINLOOP() does both those calls, in the beginning of
> >> a function and when leaving its scope, so essentially it also just does
> >> assert(qemu_in_main_thread() && !qemu_in_coroutine()).
> >>
> >> Therefore:
> >>
> >> 1. Is there any real benefit from using those
> >> {rdlock/rdunlock}_main_loop() constructions, or they're here due to
> >> historical reasons only?
> > 
> > It's the price we pay for the compiler to verify our locking rules.
> > 
> >> 2. Would it hurt if we only leave GRAPH_RDLOCK_GUARD_MAINLOOP() in all
> >> such occurrences?  At least when it's obvious we can't get out of the
> >> main thread.  That would simply deliver us from performing same checks
> >> several times, similar to what's done in commit 22/24 ("block/io: remove
> >> duplicate GLOBAL_STATE_CODE() in bdrv_do_drained_end()").
> > 
> > Once bdrv_drain_all_begin() is marked GRAPH_UNLOCKED, calling it after
> > GRAPH_RDLOCK_GUARD_MAINLOOP() would be wrong according to TSA rules
> > (which don't know anything about this being only a fake lock) and the
> > build would fail.
> 
> Note that I did not mark bdrv_drain_all_begin() as GRAPH_UNLOCKED in the
> series yet. The reason is that I wasn't fully sure if that is okay,
> given that it also can be called from a coroutine and does
> bdrv_co_yield_to_drain() then. But I suppose that doesn't do anything
> with the graph lock, so I'll add the GRAPH_UNLOCKED marker in v3.

I think it's still GRAPH_UNLOCKED even when called from a coroutine,
because otherwise the polling could wait for the calling coroutine to
make progress and release the lock, resulting in a deadlock.

Kevin


