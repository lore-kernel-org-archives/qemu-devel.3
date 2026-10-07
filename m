Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0FECA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEUcl-0004jO-Ih; Wed, 07 Oct 2026 12:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUbW-00030O-8F
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUbP-0006NV-RF
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791390887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YpXHoTdAVpgqoHk/C8gDqtbYtH9QeYbVOrvBeGRIkJM=;
 b=YVmNw1EvqNMDStPTUeaZ7rnPNPJejG+Us5/9MSoHSzzb8HXJEQlLctVROg5igaL2AwJVHZ
 c6oCCmvUWUQpaFanCispOxa0r+pmitPrC7pCckpFitUG6z25Qwd283DM4iikGZE1QLNbJC
 XYSWaBO0+m3Uc2E8oUF4tt7lUHt3QG0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-sFQbAEXMNeOG_ECpoLMhUg-1; Wed,
 07 Oct 2026 12:34:45 -0400
X-MC-Unique: sFQbAEXMNeOG_ECpoLMhUg-1
X-Mimecast-MFC-AGG-ID: sFQbAEXMNeOG_ECpoLMhUg_1791390884
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E9F31955D80; Wed,  7 Oct 2026 16:34:44 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B33F51956087; Wed,  7 Oct 2026 16:34:42 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 17/21] file-posix: add statx(STATX_DIOALIGN) support
Date: Wed,  7 Oct 2026 18:32:58 +0200
Message-ID: <20261007163302.332250-18-kwolf@redhat.com>
In-Reply-To: <20261007163302.332250-1-kwolf@redhat.com>
References: <20261007163302.332250-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Linux v6.1 commit 825cf206ed51 ("statx: add direct I/O alignment
information") added an interface to fetch O_DIRECT alignment values for
block devices and file systems.

Prefer STATX_DIOALIGN to older interfaces and probing, but keep them as
fallbacks in case STATX_DIOALIGN cannot provide the information.

STATX_DIOALIGN support as of Linux 6.1:
- btrfs: no
- ext4: yes
- XFS: yes
- block devices: yes
- dm-crypt: yes

This change fixes #1290 ("IO alignment probing delivers incorrect
results on Linux when used with e.g. dm-crypt") on Linux host kernel
version 6.1 or later by avoiding the problematic probing code in
raw_probe_alignment(). It would be nice to fix the probing code but I
have not been able to reproduce it. Stable/LTS distros ship Linux 6.1+,
so the number of users without STATX_DIOALIGN is becoming small.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/1290
Cc: Eric Biggers <ebiggers@google.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20260922154351.226540-1-stefanha@redhat.com>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 56 +++++++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 39d6a34456c..328adb57233 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -426,28 +426,48 @@ static void raw_probe_alignment(BlockDriverState *bs, int fd, Error **errp)
 
     bs->bl.request_alignment = 0;
     s->buf_align = 0;
-    /* Let's try to use the logical blocksize for the alignment. */
-    if (probe_logical_blocksize(fd, &bs->bl.request_alignment) < 0) {
-        bs->bl.request_alignment = 0;
-    }
 
-#ifdef __linux__
+#if defined(__linux__) && defined(STATX_DIOALIGN)
+    struct statx stx;
+
     /*
-     * The XFS ioctl definitions are shipped in extra packages that might
-     * not always be available. Since we just need the XFS_IOC_DIOINFO ioctl
-     * here, we simply use our own definition instead:
+     * Linux 6.1 introduced an interface for both block devices and file
+     * systems. The system call returns with the STATX_DIOALIGN bit cleared
+     * when the information is unavailable.
      */
-    struct xfs_dioattr {
-        uint32_t d_mem;
-        uint32_t d_miniosz;
-        uint32_t d_maxiosz;
-    } da;
-    if (ioctl(fd, _IOR('X', 30, struct xfs_dioattr), &da) >= 0) {
-        bs->bl.request_alignment = da.d_miniosz;
-        /* The kernel returns wrong information for d_mem */
-        /* s->buf_align = da.d_mem; */
+    if (statx(fd, "", AT_EMPTY_PATH, STATX_DIOALIGN, &stx) == 0 &&
+        (stx.stx_mask & STATX_DIOALIGN)) {
+        bs->bl.request_alignment = stx.stx_dio_offset_align;
+        s->buf_align = stx.stx_dio_mem_align;
+    }
+#endif /* defined(__linux__) && defined(STATX_DIOALIGN) */
+
+#ifdef __linux__
+    if (!bs->bl.request_alignment) {
+        /*
+         * The XFS ioctl definitions are shipped in extra packages that might
+         * not always be available. Since we just need the XFS_IOC_DIOINFO ioctl
+         * here, we simply use our own definition instead:
+         */
+        struct xfs_dioattr {
+            uint32_t d_mem;
+            uint32_t d_miniosz;
+            uint32_t d_maxiosz;
+        } da;
+        if (ioctl(fd, _IOR('X', 30, struct xfs_dioattr), &da) >= 0) {
+            bs->bl.request_alignment = da.d_miniosz;
+            /* The kernel returns wrong information for d_mem */
+            /* s->buf_align = da.d_mem; */
+        }
+    }
+#endif /* __linux__ */
+
+    /* Let's try to use the logical blocksize for the alignment. */
+    if (!bs->bl.request_alignment) {
+        if (probe_logical_blocksize(fd, &bs->bl.request_alignment) < 0) {
+            bs->bl.request_alignment = 0;
+        }
     }
-#endif
 
     /*
      * If we could not get the sizes so far, we can only guess them. First try
-- 
2.56.0


