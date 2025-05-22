Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFBDC54ED0
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 18:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIAhz-0005oT-Vi; Thu, 22 May 2025 14:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uIAhf-0005nA-5t
 for qemu-devel@nongnu.org; Thu, 22 May 2025 14:31:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uIAhX-0000OI-WC
 for qemu-devel@nongnu.org; Thu, 22 May 2025 14:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747938691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EoG2vVF1mLkEop2GmLcTYDfoevSG58BUGG0ufuqbsyE=;
 b=dU/1U5h8QpiwMrt5lc4HqYnyBScxKTUVWiK4PETMgyRgTykBMzDPnz0PXiiFYsT8DU88+n
 CBvUjkhj32uWbQad+CvdNC5rGFrLPYUfJDwiYW7qLyzs/TFJrmkZ5kAi7I2LrOi+vhkmOS
 xfAOsvuWgDOJR8VxkiZcOah9hVCTAf8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-2gpnAbIzNp6LiGBWBt2ggQ-1; Thu,
 22 May 2025 14:31:27 -0400
X-MC-Unique: 2gpnAbIzNp6LiGBWBt2ggQ-1
X-Mimecast-MFC-AGG-ID: 2gpnAbIzNp6LiGBWBt2ggQ_1747938686
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D147F180036F; Thu, 22 May 2025 18:31:26 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.226.76])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8DE0D1944DFF; Thu, 22 May 2025 18:31:25 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 4/5] file-posix: allow BLKZEROOUT with -t writeback
Date: Thu, 22 May 2025 20:31:14 +0200
Message-ID: <20250522183115.246746-5-kwolf@redhat.com>
In-Reply-To: <20250522183115.246746-1-kwolf@redhat.com>
References: <20250522183115.246746-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

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
Message-ID: <20250417211053.98700-1-stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index ec95b74869..5a3532e40b 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -785,17 +785,6 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
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


