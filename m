Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE7DC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 13:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1say6k-0006bF-KE; Mon, 05 Aug 2024 09:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1say6j-0006aj-1N
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 09:50:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1say6h-0007f8-C8
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 09:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722865837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bovb813v9NP8IwALMUoz/Y8sdaT8ZQBCkKcF+C33Le4=;
 b=Vn4Vuvb55VqaqlCJIlYbdthnVmPyakwMVvxx3kQLp5RS81ri4Gr3dbmzmt8Km+wFFtY1lT
 CnSvP5TLcRSc+9O6w8jNYh7aHEgNJgGF6q/89N4vjbeZ+6g01k6zIwzU+VfIF8nJ867TJu
 dfr1mSxWckWQbYu5szotvhz6QMeuks4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-S_bBVk7iOOyQcIC8FwwW7g-1; Mon,
 05 Aug 2024 09:50:36 -0400
X-MC-Unique: S_bBVk7iOOyQcIC8FwwW7g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD22119560B4; Mon,  5 Aug 2024 13:50:33 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.224])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E63451955F66; Mon,  5 Aug 2024 13:50:30 +0000 (UTC)
Date: Mon, 5 Aug 2024 15:50:28 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 vsementsov@yandex-team.ru, pbonzini@redhat.com, eesposit@redhat.com,
 den@virtuozzo.com
Subject: Re: [PATCH v3 2/3] iotests/298: add testcase for async writes with
 preallocation filter
Message-ID: <ZrDYpHLq4h5wwHRi@redhat.com>
References: <20240716144123.651476-1-andrey.drobyshev@virtuozzo.com>
 <20240716144123.651476-3-andrey.drobyshev@virtuozzo.com>
 <ZrC_6jb8M6YU1AfQ@redhat.com>
 <9b44493d-2955-4c8c-a6a3-367335cdb3e7@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b44493d-2955-4c8c-a6a3-367335cdb3e7@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 05.08.2024 um 14:56 hat Andrey Drobyshev geschrieben:
> On 8/5/24 3:04 PM, Kevin Wolf wrote:
> > Am 16.07.2024 um 16:41 hat Andrey Drobyshev geschrieben:
> >> The testcase simply creates a 64G image with 1M clusters, generates a list
> >> of 1M aligned offsets and feeds aio_write commands with those offsets to
> >> qemu-io run with '--aio native --nocache'.  Then we check the data
> >> written at each of the offsets.  Before the previous commit this could
> >> result into a race within the preallocation filter which would zeroize
> >> some clusters after actually writing data to them.
> >>
> >> Note: the test doesn't fail in 100% cases as there's a race involved,
> >> but the failures are pretty consistent so it should be good enough for
> >> detecting the problem.
> >>
> >> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> > 
> > I left it running in a loop for a while, but couldn't reproduce the bug
> > with this test.
> > 
> 
> Hmmm, it seems to have stopped failing on my setup as well, no matter
> how I increase the number of requests.  And it seems to be related to
> the interleaving 'write-zeroes' requests.  My initial attempt was to
> cover the case described by Vladimir here:
> https://lists.nongnu.org/archive/html/qemu-block/2024-07/msg00415.html
> Maybe we just leave it and try reproducing the corruption with just
> regular write requests?  At least with this version it seems to be
> failing pretty stably on my setup:
> 
> > +    def test_prealloc_async_writes(self):
> > +        requests = 2048 # Number of write/read requests to feed to qemu-io
> > +        total_clusters = 64 * 1024 # 64G / 1M
> > +
> > +        offsets = random.sample(range(0, total_clusters), requests)
> > +        aio_write_cmds = [f'aio_write -P 0xaa  {off}M 1M' for off in offsets]
> > +        read_cmds = [f'read -P 0xaa {off}M 1M' for off in offsets]
> > +
> > +        proc = iotests.QemuIoInteractive('--aio', 'native', '--nocache',
> > +                                         '--image-opts', drive_opts)
> > +        for cmd in aio_write_cmds:
> > +            proc.cmd(cmd)
> > +        proc.close()
> > +
> > +        proc = iotests.QemuIoInteractive('-f', iotests.imgfmt, disk)
> > +        for cmd in read_cmds:
> > +            out = proc.cmd(cmd)
> > +            self.assertFalse('Pattern verification failed' in str(out))
> > +        proc.close()
> > +

This doesn't seem to fail for me either. Neither on tmpfs nor in my home
directory (which is XFS on an encrypted LVM volume).

Are you using some more complicated setup than "./check -qcow2 298"?

Do you think we could use blkdebug to deterministically trigger the case
instead of trying to brute force it? If we can suspend the write_zeroes
request on the child node of preallocate, I think that's all we need to
reproduce the bug as described in the commit message of the fix.

Kevin


