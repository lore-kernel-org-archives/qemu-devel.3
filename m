Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF7CC44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 06:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkbqA-0007h0-6T; Fri, 17 Jul 2026 02:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wkbq8-0007g2-Am; Fri, 17 Jul 2026 02:14:28 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wkbq5-0001V6-5O; Fri, 17 Jul 2026 02:14:28 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2a25:0:640:ba29:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id CE741809F9;
 Fri, 17 Jul 2026 09:14:16 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d6a::1:11] (unknown
 [2a02:6bf:8080:d6a::1:11])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id FEL0s91aDOs0-O3pqMyf2; Fri, 17 Jul 2026 09:14:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1784268856;
 bh=86w4yWul9kr8GROtSVHbT4XcsvpMuz7QR19nH0NGmfY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=q7w65GieabEma/oNNQpU8Nsz3+y7pw7gCAaIl4C83qDojUeVW8YdSV56dhwBJ2gOY
 7S31xj0DyaWAJ5x+gq++EtP4cjbgGuBfm48AYh5U1E5JGE2Sefp0szSB0MVrEvEHic
 y+I2bVWoZNcvsceAwjTxUUoWWXYU+tFaP7+ngCuQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <3a6ba8c2-99d8-4567-aefe-6945adf7c15f@yandex-team.ru>
Date: Fri, 17 Jul 2026 09:14:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] block/monitor: reject persistent bitmap add on a
 read-only node
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
References: <20260716112242.3000035-1-den@openvz.org>
 <20260716112242.3000035-2-den@openvz.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260716112242.3000035-2-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16.07.26 14:22, Denis V. Lunev wrote:
> qmp_block_dirty_bitmap_add() marks a new bitmap persistent without
> checking write access to its node. bdrv_create_dirty_bitmap() always
> creates bitmaps writable, so a persistent bitmap added to an
> already read-only node stays writable in memory on a node that can
> never store it, and the next global inactivation fails:
> 
>    Lost persistent bitmaps during inactivation of node '<node>': No write access
>    migration_block_inactivate: bdrv_inactivate_all() failed: -22
> 
> Forcing it read-only instead does not help: it was never stored,
> so it stays unpromotable on the next reopen to read-write and can
> trip bdrv_set_dirty()'s readonly assert on the first write. Reject
> the add instead, for both read-only and inactive nodes -- an
> already-inactive node skips qcow2_inactivate() on close, so a
> bitmap added during that window would never get stored either.
> Wrapped in a transaction, this denies the whole transaction, since
> qmp_transaction() is already all-or-none.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Eric Blake <eblake@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: John Snow <jsnow@redhat.com>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>


Could it be a scenario, when user intentionally create bitmap in
read-only image, and expect, that it would become writeable soon?
For example before block-commit.

I don't think that useful.

For usual backup scenario, user will just move bitmaps from top to
base, no need to make a bitmap, dirtied by the block-commit operation
itself.

If, for some reason we don't have bitmap in top image, but have in
base (top is a kind of temporary snapshot), bitmaps in base would
become writeable and accept new dirty bits as expected.

Creating a new bitmap, to become actually a block-status bitmap of
merged top base seems a strange case.. A kind of combination of
snapshot-based and backup-based backup processes?

Anyway, I think, it's quite correct immediately store an empty
bitmap to the qcow2 image when creating it with persistent=true,
which of course fails if image is read-only. So, I think the change
is correct:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>


-- 
Best regards,
Vladimir

