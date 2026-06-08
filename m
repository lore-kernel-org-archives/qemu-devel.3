Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEBCCD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWdDB-000163-Qi; Mon, 08 Jun 2026 12:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wWdDA-00015T-7N
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:52:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wWdD8-0007Qw-LW
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780937546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BdkstQtJlrBa9g+LfmT+wxquA4LIIzMoYHUWQrCrWMg=;
 b=iJaXZiy0lFZVJiJYiJ76lk6oKMlUctkQ6499as2W++H8SAgAaTDcynupPfuXWQBlpickQG
 kyi0p+Srsg9e5arf06z/VSDVZt0T3Q3d+HCWA6QAE3YwqDeS7y57B34tsf+MNa7MDchUeC
 +Ip+ylQGWLgqSrLTZsSGuLNTuPHJF7U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-Iftsn9zoOVaMd_bkKVgrWQ-1; Mon,
 08 Jun 2026 12:52:24 -0400
X-MC-Unique: Iftsn9zoOVaMd_bkKVgrWQ-1
X-Mimecast-MFC-AGG-ID: Iftsn9zoOVaMd_bkKVgrWQ_1780937543
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EFAD195411C; Mon,  8 Jun 2026 16:52:23 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.50.32])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2274C19540CB; Mon,  8 Jun 2026 16:52:21 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 6/8] block/export/fuse: set FUSE_DIRECT_IO_ALLOW_MMAP flag to
 fix regression
Date: Mon,  8 Jun 2026 18:52:05 +0200
Message-ID: <20260608165207.307488-7-kwolf@redhat.com>
In-Reply-To: <20260608165207.307488-1-kwolf@redhat.com>
References: <20260608165207.307488-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Fiona Ebner <f.ebner@proxmox.com>

Commit 8599559580 ("fuse: Set direct_io and parallel_direct_writes")
broke use cases that require mmap() with MAP_SHARED on the export. In
particular, swtpm_setup using its 'file://' protocol requires this.
From the kernel documentation [0]:

> To allow shared mmap, the FUSE_DIRECT_IO_ALLOW_MMAP flag may be
> enabled in the FUSE_INIT reply.

Set the FUSE_DIRECT_IO_ALLOW_MMAP flag to restore compatibility with
users requiring shared mmap. The FUSE_INIT_EXT flag needs to be set
for the flags2 member to have an effect.

[0]: https://www.kernel.org/doc/html/next/filesystems/fuse/fuse-io.html

Cc: qemu-stable@nongnu.org
Fixes: 8599559580 ("fuse: Set direct_io and parallel_direct_writes")
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20260506145424.10249-3-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/export/fuse.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 35218e31976..c0e8dfb6430 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -856,7 +856,8 @@ static ssize_t coroutine_fn GRAPH_RDLOCK
 fuse_co_init(FuseExport *exp, struct fuse_init_out *out,
              const struct fuse_init_in *in)
 {
-    const uint32_t supported_flags = FUSE_ASYNC_READ | FUSE_ASYNC_DIO;
+    uint32_t supported_flags = FUSE_ASYNC_READ | FUSE_ASYNC_DIO;
+    uint32_t flags2 = 0;
 
     if (in->major != 7) {
         error_report("FUSE major version mismatch: We have 7, but kernel has %"
@@ -871,13 +872,21 @@ fuse_co_init(FuseExport *exp, struct fuse_init_out *out,
         return -EINVAL;
     }
 
+    if (!using_old_fuse_init_in(in)) {
+        /* The flags2 flags must be shifted down by 32 bits. */
+        const uint32_t supported_flags2 = FUSE_DIRECT_IO_ALLOW_MMAP >> 32;
+        /* flags2 is only considered if FUSE_INIT_EXT is set. */
+        supported_flags = supported_flags | FUSE_INIT_EXT;
+        flags2 = in->flags2 & supported_flags2;
+    }
+
     *out = (struct fuse_init_out) {
         .major = 7,
         .minor = MIN(FUSE_KERNEL_MINOR_VERSION, in->minor),
         .max_readahead = in->max_readahead,
         .max_write = FUSE_MAX_WRITE_BYTES,
         .flags = in->flags & supported_flags,
-        .flags2 = 0,
+        .flags2 = flags2,
 
         /* libfuse maximum: 2^16 - 1 */
         .max_background = UINT16_MAX,
-- 
2.54.0


