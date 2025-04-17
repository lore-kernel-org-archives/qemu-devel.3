Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B46CC369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 21:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5WW3-0005oG-AX; Thu, 17 Apr 2025 17:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u5WVj-0005hI-Gt
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 17:11:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u5WVg-00040e-Ps
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 17:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744924260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7pqbBncs4V+SEDkICJlqa8chCxJKrfcfYWPXIcEE80A=;
 b=FhqOBM5CWwzykoTR+afGcH4bGRfyhs0I9AV77z/RELid7y+0CiXUzREzqehnHHbQqHflnt
 aCXuomwnFP0dHs1/dJbcPyFJfmv5+rovz9pCZ75tgXzjdW0IkP2s9+F2mMCxOwvNCkIoBl
 qurxREJd8SPKeNzt9WuNGcz4Bs7Y83M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-JzLR8leJO1GIfsAg5Gcygg-1; Thu,
 17 Apr 2025 17:10:56 -0400
X-MC-Unique: JzLR8leJO1GIfsAg5Gcygg-1
X-Mimecast-MFC-AGG-ID: JzLR8leJO1GIfsAg5Gcygg_1744924255
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 93EAD1956094; Thu, 17 Apr 2025 21:10:55 +0000 (UTC)
Received: from localhost (unknown [10.2.16.64])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BAB591800D9E; Thu, 17 Apr 2025 21:10:54 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] block/file-posix: allow BLKZEROOUT with -t writeback
Date: Thu, 17 Apr 2025 17:10:53 -0400
Message-ID: <20250417211053.98700-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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

The Linux BLKZEROOUT ioctl is only invoked when BDRV_O_NOCACHE is set
because old kernels did not invalidate the page cache. In that case
mixing BLKZEROOUT with buffered I/O could lead to corruption.

However, Linux 4.9 commit 22dd6d356628 ("block: invalidate the page
cache when issuing BLKZEROOUT") made BLKZEROOUT coherent with the page
cache.

I have checked that Linux 4.9+ kernels are shipped at least as far back
as Debian 10 (buster), openSUSE Leap 15.2, and RHEL/CentOS 8.

Use BLKZEROOUT with buffered I/O, mostly so `qemu-img ... -t
writeback` can offload write zeroes.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/file-posix.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 56d1972d15..9ba0b68958 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -781,17 +781,6 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     }
 #endif
 
-    if (S_ISBLK(st.st_mode)) {
-#ifdef __linux__
-        /* On Linux 3.10, BLKDISCARD leaves stale data in the page cache.  Do
-         * not rely on the contents of discarded blocks unless using O_DIRECT.
-         * Same for BLKZEROOUT.
-         */
-        if (!(bs->open_flags & BDRV_O_NOCACHE)) {
-            s->has_write_zeroes = false;
-        }
-#endif
-    }
 #ifdef __FreeBSD__
     if (S_ISCHR(st.st_mode)) {
         /*
-- 
2.49.0


