Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE40C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 16:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEAHC-0004u5-RZ; Mon, 03 Jun 2024 12:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sEAHA-0004hk-EO
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 12:11:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sEAH0-0000zN-HZ
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 12:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717431049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UiER9LDxLkGMSdM6dYuG6GePJmgaWgqzbS30dVwDdDA=;
 b=OkhQpd8tZvwjlolmGeTOEQPbm+rJTsFnkUdk3cuC5z5eS32JKsrBkxzKtIYSuh3g2YOpwE
 cwEOaKfGJF6HCo3JDmiFepr5WrejpyaGAacVJol1KV/YhHN4pTPV2/RI7ee9vpTvElgwa5
 YNij1cw6eI6XMBHEDoNl6itd+Iyf7g4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447--Rp3PegROwiAwzwDn00YZQ-1; Mon, 03 Jun 2024 12:10:12 -0400
X-MC-Unique: -Rp3PegROwiAwzwDn00YZQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC947180D92F;
 Mon,  3 Jun 2024 16:10:00 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.235])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7349C200D8FD;
 Mon,  3 Jun 2024 16:09:58 +0000 (UTC)
Date: Mon, 3 Jun 2024 18:09:57 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 hreitz@redhat.com, vsementsov@yandex-team.ru, jsnow@redhat.com,
 f.weber@proxmox.com
Subject: Re: [PATCH] block/copy-before-write: use uint64_t for timeout in
 nanoseconds
Message-ID: <Zl3q1ccjpIOdOR_D@redhat.com>
References: <20240429141934.442154-1-f.ebner@proxmox.com>
 <ZlYA9QXVaDSfjxOT@redhat.com>
 <ea2c0988-9c29-44d0-828e-aa1d8f011ef1@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea2c0988-9c29-44d0-828e-aa1d8f011ef1@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 03.06.2024 um 16:45 hat Fiona Ebner geschrieben:
> Am 28.05.24 um 18:06 schrieb Kevin Wolf:
> > Am 29.04.2024 um 16:19 hat Fiona Ebner geschrieben:
> >> rather than the uint32_t for which the maximum is slightly more than 4
> >> seconds and larger values would overflow. The QAPI interface allows
> >> specifying the number of seconds, so only values 0 to 4 are safe right
> >> now, other values lead to a much lower timeout than a user expects.
> >>
> >> The block_copy() call where this is used already takes a uint64_t for
> >> the timeout, so no change required there.
> >>
> >> Fixes: 6db7fd1ca9 ("block/copy-before-write: implement cbw-timeout option")
> >> Reported-by: Friedrich Weber <f.weber@proxmox.com>
> >> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> > 
> > Thanks, applied to the block branch.
> > 
> > But I don't think our job is done yet with this. Increasing the limit is
> > good and useful, but even if it's now unlikely to hit with sane values,
> > we should still catch integer overflows in cbw_open() and return an
> > error on too big values instead of silently wrapping around.
> 
> NANOSECONDS_PER_SECOND is 10^9 and the QAPI type for cbw-timeout is
> uint32_t, so even with the maximum allowed value, there is no overflow.
> Should I still add such a check?

You're right, I missed that cbw_timeout is uint32_t. So uint64_t will be
always be enough to hold the result, and the calculation is also done in
64 bits because NANOSECONDS_PER_SECOND is long long. Then we don't need
a check.

Kevin


