Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A46C606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=RJ+TzULl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp8i-0007xu-19; Fri, 27 Nov 2026 01:08:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp6k-0004vA-8L; Fri, 27 Nov 2026 01:06:56 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp6h-0002Fz-4D; Fri, 27 Nov 2026 01:06:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759047; bh=xTwlYvt3h0Q5ZIiwyheHxQi1L8KS+ZiB5s6tMnLpl5I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RJ+TzULl93PYeky6IkVLNuyZTQdbSfaLNJw35Q8Pkn4XV8kJ0UF/XZSfV9iw3tiGR
 nJ9Eh9Y8VAzzNltG1vqevrTy8M9BFEd7d2ZuSobC67rQ+Fh7UrXf2DgtZq3p3flEcm
 DxXfsi1ITPq9gwlgm5r6xoCqjZTQ5mEqSSIOMcDS1Vh5RBY1pOpj1bsYzCFLxHw7Je
 eUmQkTKC5LtrfW70rHUJ4bE0pF0HXFQJN+pKqqKlWPiDX6hZQBGGBZ4nofMM4bFAOg
 jpiyiUS+FWeV/yKzPzBd8PvHLmtTPwyHyW/CCSqWdQaEZnYlTTdgNJcMjm5CCSodix
 9G2XS79aJpM6w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E33531EA35C;
 Fri, 27 Nov 2026 08:57:27 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E0F12469987;
 Fri, 27 Nov 2026 08:57:27 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D94BECF306; Fri, 27 Nov 2026 08:57:27 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 106/152] block/vhdx-log: Improve sanity checks to
 avoid OOB accesses with bad images
Date: Fri, 27 Nov 2026 08:54:04 +0300
Message-ID: <20261127055709.39630-43-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Thomas Huth <thuth@redhat.com>

The multiplication "hdr->descriptor_count * sizeof(VHDXLogDescriptor)" in
vhdx_log_hdr_is_valid() can overflow on 32-bit systems, so this function
could mark bad images as valid when the truncated result is smaller than
hdr->entry_length. Switch to a division on the right hand side instead to
avoid the overflow problems.

The second problem is in vhdx_log_read_desc(): desc_sectors is a 32-bit
value, thus the multiplication "desc_sectors * VHDX_LOG_SECTOR_SIZE" is
also done with 32 bit arithmetics, and the result is used as "size_t"
parameter for qemu_try_blockalign(), i.e. the parameter here is also
only 32 bits on 32-bit systems. Let's add a sanity check here to avoid
the overflow problem that could lead to trouble later.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3860
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20261111150659.253918-1-thuth@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 95c27a042a78947f92c5b5d95be690e76698db5d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index 4385a2d4f62..5c20468e1e6 100644
--- a/block/vhdx-log.c
+++ b/block/vhdx-log.c
@@ -246,7 +246,7 @@ static bool vhdx_log_hdr_is_valid(VHDXLogEntries *log, VHDXLogEntryHeader *hdr,
         goto exit;
     }
 
-    if (hdr->descriptor_count * sizeof(VHDXLogDescriptor) > hdr->entry_length) {
+    if (hdr->descriptor_count > hdr->entry_length / sizeof(VHDXLogDescriptor)) {
         goto exit;
     }
 
@@ -360,6 +360,10 @@ vhdx_log_read_desc(BlockDriverState *bs, BDRVVHDXState *s, VHDXLogEntries *log,
     }
 
     desc_sectors = vhdx_compute_desc_sectors(hdr.descriptor_count);
+    if (desc_sectors > UINT32_MAX / VHDX_LOG_SECTOR_SIZE) {
+        ret = -EINVAL;
+        goto exit;
+    }
     desc_entries = qemu_try_blockalign(bs->file->bs,
                                        desc_sectors * VHDX_LOG_SECTOR_SIZE);
     if (desc_entries == NULL) {
-- 
2.47.3


