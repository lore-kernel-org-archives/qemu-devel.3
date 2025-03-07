Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748EBC28B2E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 22:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqg01-0001sV-7d; Fri, 07 Mar 2025 17:16:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tqfzy-0001og-Vu
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:16:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tqfzx-0007lo-BD
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:16:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741385811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ssrIQGIGLIZjM8D3cgY9CWyZR3nU0yBcOBud7wV8Tr8=;
 b=EM4Gi9NUhqHbOUS8UvkFE/uOvC0avLkE2yLSZ1J1erbE13JuhlnfAg0rKKIrKi2hpAz6Dh
 xykLDbWbE8WRs8PrCMB8rmBLXkn+lkVD3lMzfjEZBjieOYrcNSzs8AnHPoiYWfecr2SAEB
 tKy1T/njcMP78ItzRJDh4Yw1QcIMtxs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-206B4rWTNrahTSyqwpOtvw-1; Fri,
 07 Mar 2025 17:16:48 -0500
X-MC-Unique: 206B4rWTNrahTSyqwpOtvw-1
X-Mimecast-MFC-AGG-ID: 206B4rWTNrahTSyqwpOtvw_1741385807
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3506018001FC; Fri,  7 Mar 2025 22:16:47 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.226.27])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 86B2318009AE; Fri,  7 Mar 2025 22:16:44 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 afaria@redhat.com, hreitz@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 0/5] block: Improve writethrough performance
Date: Fri,  7 Mar 2025 23:16:29 +0100
Message-ID: <20250307221634.71951-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Write requests in writethrough mode mean that QEMU sends a separate
flush request (i.e. fdatasync) after each completed write request.
This is unnecessary overhead when we can just pass a flag for the write
request that gives us the desired FUA semantics.

Unfortunately, this made a problem in the adaptive polling algorithm
apparent that would result in a performance regression in some cases
with FUA support in file-posix. Therefore, adaptive polling is changed
in this series, too, to avoid the regression.

Kevin Wolf (5):
  file-posix: Support FUA writes
  block/io: Ignore FUA with cache.no-flush=on
  aio: Create AioPolledEvent
  aio-posix: Factor out adjust_polling_time()
  aio-posix: Separate AioPolledEvent per AioHandler

 include/block/aio.h     |  5 ++-
 include/block/raw-aio.h |  8 +++-
 util/aio-posix.h        |  1 +
 block/file-posix.c      | 26 ++++++++----
 block/io.c              |  4 ++
 block/io_uring.c        | 13 +++---
 block/linux-aio.c       | 24 +++++++++--
 util/aio-posix.c        | 94 ++++++++++++++++++++++++++---------------
 util/async.c            |  1 -
 meson.build             |  4 ++
 10 files changed, 125 insertions(+), 55 deletions(-)

-- 
2.48.1


