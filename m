Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658A0606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GSLPbmxz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOENL-00057y-GQ; Tue, 03 Nov 2026 08:16:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xOENH-00056s-1t
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 08:16:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xOENF-0003Ti-6P
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 08:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793711783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ONqIAINPfLA3LlThHTgOK3kOrsxy1Mp6jlVvCsdU97I=;
 b=GSLPbmxz0SUQu94HZeRzIFBgKMt75yvtu2SL3H6vZomq+UbwXJ1ZhX/ZgaO9otN/FqrXvS
 HkdOIYy+in8JHTmLrw+bSx1NcOcAoW1w952zzQjAERzESuEt+wCCtViHmNMukdwYXPO/zi
 4A9L+K3/8atiUQSbTyLX5ieKhk+7XCM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-KokiWS5_O-yExYZqruDaXg-1; Tue,
 03 Nov 2026 08:16:22 -0500
X-MC-Unique: KokiWS5_O-yExYZqruDaXg-1
X-Mimecast-MFC-AGG-ID: KokiWS5_O-yExYZqruDaXg_1793711781
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67268180060D; Tue,  3 Nov 2026 13:16:20 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.52])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E98F61955F01; Tue,  3 Nov 2026 13:16:17 +0000 (UTC)
Date: Tue, 3 Nov 2026 14:16:15 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 06/13] iotests/298: add testcase for async writes with
 preallocation filter
Message-ID: <aunen7IblBe9-QFk@redhat.com>
References: <20260930165000.303236-1-den@openvz.org>
 <20260930165000.303236-7-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930165000.303236-7-den@openvz.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 30.09.2026 um 18:49 hat Denis V. Lunev geschrieben:
> From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> 
> The testcase creates a 64G image with 1M clusters, generates a list of
> 1M aligned offsets and feeds aio_write commands with those offsets to
> qemu-io run with '--aio native --nocache'. Then we check the data
> written at each of the offsets. Before this series this could result
> in a race within the preallocation filter which would zeroize some
> clusters after actually writing data to them.
> 
> Note: the test does not fail every time as there's a race involved, but
> the failures are pretty consistent so it should be good enough for
> detecting the problem.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

FWIW, this doesn't seem to fail at all for me even without the fixes. I
kept it running in a loop for a while, but it always passed.

What is the bug this triggered for you? I don't think it can't be the
locking one because qemu-io tests are always single threaded.

If it is what patch 2 addressed, shouldn't a deterministic test be
possible in which you set a blkdebug breakpoint that suspends the
bdrv_co_pwrite_zeroes() before you launch another write?

Kevin


