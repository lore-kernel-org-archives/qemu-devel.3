Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF5C606A331
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TNSjKlsa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO5Bb-0004zB-E1; Mon, 02 Nov 2026 22:27:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5BP-0004ua-GD
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:27:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5BN-00061Y-Ux
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:27:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793676453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zwgA6kMBcwjCfqtjnHfwaiEa9/mhLo4QXMbA7haZZCI=;
 b=TNSjKlsa+pShrnJVygsPyGJXXcBg6Eq4eh5EfPt4q/sPIgtX83TbVIt4zT1j1XYgcw/kpP
 +pcfMxAygZN2HzOhSc7n6qZdAKCkR1h9+gw4WrCvRKzrxiw27u4k0pCAkOu8pfvwVuvkDJ
 6ktb3sxIo3DSEoY/+BJy7mdHNVIl4do=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-4G9_7GMsOz2LYy6odtszmw-1; Mon,
 02 Nov 2026 22:27:30 -0500
X-MC-Unique: 4G9_7GMsOz2LYy6odtszmw-1
X-Mimecast-MFC-AGG-ID: 4G9_7GMsOz2LYy6odtszmw_1793676448
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62BD41800A3F; Tue,  3 Nov 2026 03:27:28 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 506DA195608D; Tue,  3 Nov 2026 03:27:26 +0000 (UTC)
Date: Mon, 2 Nov 2026 21:27:23 -0600
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, 
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: Re: [PATCH v4 10/12] block/block-copy: replace zero_bitmap_valid
 with scan_done
Message-ID: <aulUdeoU11SZRKGQ@redhat.com>
References: <20261030010613.1612771-1-den@openvz.org>
 <20261030010613.1612771-11-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030010613.1612771-11-den@openvz.org>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

On Fri, Oct 30, 2026 at 02:06:10AM +0100, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> zero_bitmap_valid says more than its name: a task created once it is
> set skips its own block-status query, the sync=top skipping included,
> because the scan has already settled what to copy. And the end of the
> scan was announced twice, clearing skip_unallocated and then publishing
> zero_bitmap_valid, with an ordering rule in a comment tying the two.
> 
> Rename the flag to scan_done, and let block_copy_set_scan_done() clear
> skip_unallocated before publishing it, so backup_scan_source() makes one
> call and the order is kept in one place. skip_unallocated is left to
> mean that a sync=top scan is in progress. No behavior change.
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: John Snow <jsnow@redhat.com>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  block/backup.c             |  6 +-----
>  block/block-copy.c         | 19 ++++++++++++-------
>  include/block/block-copy.h |  2 +-
>  3 files changed, 14 insertions(+), 13 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


