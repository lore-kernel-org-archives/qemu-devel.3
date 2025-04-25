Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3504C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 17:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8NEf-00011I-Vj; Fri, 25 Apr 2025 13:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u8NEZ-0000rY-DO
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 13:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u8NEX-0007PK-1z
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 13:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745603584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kv9qDhyGRrIkUDKuFAfwQPGjpFR2P3l+wcvXDRuef2I=;
 b=XkRv2JLUxmOfpEIoNy/4XjuW8CyfEO4RltNfUQgwO8aZOx2PoitCgHvWgoWmIbAumUZsFf
 7xyHONAg1PKLIfk4fRUPF0e4wS7iYN26AcLF71ycVUcsBMAl+Wxu74vIGz18F5GDUF5H/j
 VHN4dtbBY7RH0i1MX6GqEMIsMmmextQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-0mD2A_sCPbimHnQoP3chSg-1; Fri,
 25 Apr 2025 13:53:01 -0400
X-MC-Unique: 0mD2A_sCPbimHnQoP3chSg-1
X-Mimecast-MFC-AGG-ID: 0mD2A_sCPbimHnQoP3chSg_1745603580
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28DCD180034E; Fri, 25 Apr 2025 17:53:00 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.225.183])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C88E81800D97; Fri, 25 Apr 2025 17:52:58 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 2/4] block/io: skip head/tail requests on EINVAL
Date: Fri, 25 Apr 2025 19:52:50 +0200
Message-ID: <20250425175252.316807-3-kwolf@redhat.com>
In-Reply-To: <20250425175252.316807-1-kwolf@redhat.com>
References: <20250425175252.316807-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
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

When guests send misaligned discard requests, the block layer breaks
them up into a misaligned head, an aligned main body, and a misaligned
tail.

The file-posix block driver on Linux returns -EINVAL on misaligned
discard requests. This causes bdrv_co_pdiscard() to fail and guests
configured with werror=stop will pause.

Add a special case for misaligned head/tail requests. Simply continue
when EINVAL is encountered so that the aligned main body of the request
can be completed and the guest is not paused. This is the best we can do
when guest discard limits do not match the host discard limits.

Fixes: https://issues.redhat.com/browse/RHEL-86032
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20250417150528.76470-3-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/block/io.c b/block/io.c
index 1ba8d1aeea..ccec11386b 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3109,11 +3109,12 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
     /* Invalidate the cached block-status data range if this discard overlaps */
     bdrv_bsc_invalidate_range(bs, offset, bytes);
 
-    /* Discard is advisory, but some devices track and coalesce
+    /*
+     * Discard is advisory, but some devices track and coalesce
      * unaligned requests, so we must pass everything down rather than
-     * round here.  Still, most devices will just silently ignore
-     * unaligned requests (by returning -ENOTSUP), so we must fragment
-     * the request accordingly.  */
+     * round here.  Still, most devices reject unaligned requests with
+     * -EINVAL or -ENOTSUP, so we must fragment the request accordingly.
+     */
     align = MAX(bs->bl.pdiscard_alignment, bs->bl.request_alignment);
     assert(align % bs->bl.request_alignment == 0);
     head = offset % align;
@@ -3180,7 +3181,11 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
             }
         }
         if (ret && ret != -ENOTSUP) {
-            goto out;
+            if (ret == -EINVAL && (offset % align != 0 || num % align != 0)) {
+                /* Silently skip rejected unaligned head/tail requests */
+            } else {
+                goto out; /* bail out */
+            }
         }
 
         offset += num;
-- 
2.49.0


