Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E43E606A326
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QVRKcVSP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO5AJ-0003xl-EY; Mon, 02 Nov 2026 22:26:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5AC-0003sL-0u
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:26:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5AA-0005vZ-K1
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:26:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793676377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NU5ngdvUBRSpabAA6T1cDf9tGmVnnBEjUfxiddLSPrA=;
 b=QVRKcVSPVw/eGlJPQtbOuStUgpImfDS4XUvMg3ND+GWybHI1Q4rRtz9WmC5+qmXpgc3oE8
 2oa8pv2js8rEMAveGApzgdOa2EmOihbrx9YSdQIJJ3rNx0em+DIdrH7W5HSbRKsZwsR5Zi
 ML5VUYx/RPgCk0y8WGiwINrFexCOOM0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-DP2FFnMZOdKpBOf6hiIITA-1; Mon,
 02 Nov 2026 22:26:12 -0500
X-MC-Unique: DP2FFnMZOdKpBOf6hiIITA-1
X-Mimecast-MFC-AGG-ID: DP2FFnMZOdKpBOf6hiIITA_1793676371
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D68C18001FB; Tue,  3 Nov 2026 03:26:11 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D40441800446; Tue,  3 Nov 2026 03:26:08 +0000 (UTC)
Date: Mon, 2 Nov 2026 21:26:06 -0600
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, 
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: Re: [PATCH v4 09/12] block/block-copy: merge the two backup scan
 steps into block_copy_prescan()
Message-ID: <aulT1xOoSYFPdsI7@redhat.com>
References: <20261030010613.1612771-1-den@openvz.org>
 <20261030010613.1612771-10-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030010613.1612771-10-den@openvz.org>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 02:06:09AM +0100, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> block_copy_reset_unallocated() and block_copy_calculate_zero_bitmap()
> are both one step of the same scan and differ only in what they do with
> the answer. Fold them into block_copy_prescan(), which drops unallocated
> clusters from copy_bitmap while skip_unallocated is set, so
> backup_scan_source() loses its per-mode branch.
> 
> sync=top now walks the dirty areas the way full and bitmap do, so it no
> longer queries what copy-before-write has already copied during the
> scan. A failed query still fails sync=top, as nothing else can tell
> which clusters to skip, and still leaves the area to be copied as data
> otherwise.
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: John Snow <jsnow@redhat.com>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  block/backup.c             |  7 +----
>  block/block-copy.c         | 63 ++++++++++++++------------------------
>  include/block/block-copy.h |  9 ++----
>  3 files changed, 27 insertions(+), 52 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


