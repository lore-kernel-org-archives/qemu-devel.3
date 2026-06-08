Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2AD1CD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWZzH-0000Ev-HV; Mon, 08 Jun 2026 09:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wWZzF-0000EB-Iu
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:25:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wWZzD-0008T8-Tj
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780925150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QacUtpu9mGw44ZmVTNI8OyXBWgeJQcc56jtqDPj9X3E=;
 b=Dr0Rf2CBOcgYFL+VgzO9McPTGm4wBhljQpkOi9ilHdFRaunkSfxAy+7FRt0wxYd30T9oZE
 E61MgF+f92n7r0V91TPYA1SqFvp6M9tmTdXSvKOfHGR36bxi++dbSNf8tlEf1n0cLaANyO
 BfQDmNlacUSOap8K1HgYN08t50xcGdM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-ycxv5AANNFSjZALPrM9ZoQ-1; Mon,
 08 Jun 2026 09:25:49 -0400
X-MC-Unique: ycxv5AANNFSjZALPrM9ZoQ-1
X-Mimecast-MFC-AGG-ID: ycxv5AANNFSjZALPrM9ZoQ_1780925147
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6A8A195608F; Mon,  8 Jun 2026 13:25:46 +0000 (UTC)
Received: from localhost (unknown [10.2.16.156])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0CC111800347; Mon,  8 Jun 2026 13:25:45 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>,
 qemu-stable@nongnu.org
Subject: [PULL 1/2] block/io: fallback to bounce buffer if BLKZEROOUT is not
 supported because of alignment
Date: Mon,  8 Jun 2026 09:25:23 -0400
Message-ID: <20260608132524.470459-2-stefanha@redhat.com>
In-Reply-To: <20260608132524.470459-1-stefanha@redhat.com>
References: <20260608132524.470459-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Fiona Ebner <f.ebner@proxmox.com>

Commit 5634622bcb ("file-posix: allow BLKZEROOUT with -t writeback")
enables the BLKZEROOUT ioctl when using 'writeback' cache, regressing
certain 'qemu-img convert' invocations, because of a pre-existing
issue. Namely, the BLKZEROOUT ioctl might fail with errno EINVAL when
the request is shorter than the block size of the block device.
Fallback to the bounce buffer, similar to when the ioctl is not
supported at all, rather than treating such an error as fatal.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3257
Resolves: https://bugzilla.proxmox.com/show_bug.cgi?id=7197
Cc: qemu-stable@nongnu.org
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20260105143416.737482-1-f.ebner@proxmox.com>
[Added TODO comment describing a larger fix that could be implemented in
the future.
--Stefan]
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index e8fb4ede4d..6c0bbdcf1e 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1918,7 +1918,18 @@ bdrv_co_do_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int64_t bytes,
             assert(!bs->supported_zero_flags);
         }
 
-        if (ret == -ENOTSUP && !(flags & BDRV_REQ_NO_FALLBACK)) {
+        /*
+         * TODO The ret == -EINVAL && num < alignment case is a workaround for
+         * when request_alignment is 1 on files with cache=writeback. The Linux
+         * ioctl(BLKZEROOUT) requires block alignment and will fail with
+         * EINVAL. The block layer should align the request to
+         * write_zeroes_alignment instead of trying the syscall, failing, and
+         * falling back to a bounce buffer. Doing that is not easy so for now
+         * we use a bounce buffer:
+         * https://lore.kernel.org/qemu-devel/20260109120837.2772961-1-f.ebner@proxmox.com/
+         */
+        if ((ret == -ENOTSUP || (ret == -EINVAL && num < alignment)) &&
+            !(flags & BDRV_REQ_NO_FALLBACK)) {
             /* Fall back to bounce buffer if write zeroes is unsupported */
             BdrvRequestFlags write_flags = flags & ~BDRV_REQ_ZERO_WRITE;
 
-- 
2.54.0


