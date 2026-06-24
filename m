Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F61FCDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcFqt-0003Bj-LY; Wed, 24 Jun 2026 01:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFq1-0002XJ-4q; Wed, 24 Jun 2026 01:07:50 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFpx-0005nk-Gk; Wed, 24 Jun 2026 01:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782277622; bh=gHDs/HtfRmKLqu7Xc07ZeNMMhlhMCC/Q7xG8i/OcEfs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LNbN6M41reFWJhR2LH6Rna3bmEJB1+1knFPZqB/isHjKh2WgBHk0owGXk76UsIC+a
 +Eym19IpWgeQnYvDwXgdv2MefH99rnK5KLX0VVInOtV3N3ZR31/9cLK+TDBfDszKH8
 blSXhJdNoU3CmyGW17ZNXPnANIo17R/x8pYGa2k9pbn0oJ8zMBJfq4rTFUQ5YEz5Hm
 g7ExB0szkqTkLlT4vTBKAFCqZpovs9eY0aRMRw1hSLFcDVdg11oftYhS94Dz6n4L9h
 B2H4UCwl43KfQw3xla1DWRZYVdFZI6OJzNioEYwQMKtxELz2ximHzMu9Sisu5WxtJ0
 QC7upU56vikqQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7810A1BA662;
 Wed, 24 Jun 2026 08:07:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5E8E63DDAFF;
 Wed, 24 Jun 2026 08:07:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 DARKNAVY <vr@darknavy.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 68/95] libvduse: fix buffer overflow in
 vduse_queue_read_indirect_desc()
Date: Wed, 24 Jun 2026 08:05:03 +0300
Message-ID: <20260624050541.395079-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Stefano Garzarella <sgarzare@redhat.com>

vduse_queue_read_indirect_desc() copies an indirect descriptor table
into a buffer in chunks when the table crosses a memory region
boundary. The destination is a struct vring_desc pointer but is
advanced by a byte count, so each increment moves the pointer by
read_len elements instead of read_len bytes, writing beyond the
buffer.

Use a char pointer for the destination so that the arithmetic
advances correctly.

While at it, change the source from a struct vring_desc pointer
to a void pointer: when the table is split across regions,
iova_to_va() can return a pointer into the middle of a descriptor,
so casting it to a struct vring_desc pointer is wrong. The pointer is
only used as a memcpy() source, so a void pointer is fine.

Fixes: CVE-2026-6425
Fixes: a6caeee811 ("libvduse: Add VDUSE (vDPA Device in Userspace) library")
Cc: qemu-stable@nongnu.org
Reported-by: DARKNAVY <vr@darknavy.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260417132645.121192-3-sgarzare@redhat.com>
(cherry picked from commit 9f1b6d013d42b112680b435af9a9dff331b3fbaf)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/subprojects/libvduse/libvduse.c b/subprojects/libvduse/libvduse.c
index 21ffbb5b8d..df9ca5e56f 100644
--- a/subprojects/libvduse/libvduse.c
+++ b/subprojects/libvduse/libvduse.c
@@ -465,8 +465,9 @@ static int
 vduse_queue_read_indirect_desc(VduseDev *dev, struct vring_desc *desc,
                                uint64_t addr, size_t len)
 {
-    struct vring_desc *ori_desc;
+    char *dst_desc = (char *)desc;
     uint64_t read_len;
+    void *ori_desc;
 
     if (len > (VIRTQUEUE_MAX_SIZE * sizeof(struct vring_desc))) {
         return -1;
@@ -483,10 +484,10 @@ vduse_queue_read_indirect_desc(VduseDev *dev, struct vring_desc *desc,
             return -1;
         }
 
-        memcpy(desc, ori_desc, read_len);
+        memcpy(dst_desc, ori_desc, read_len);
         len -= read_len;
         addr += read_len;
-        desc += read_len;
+        dst_desc += read_len;
     }
 
     return 0;
-- 
2.47.3


