Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A263AC5DF74
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxWW-0005VP-Jc; Mon, 17 Aug 2026 09:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxWV-0005PC-0M; Mon, 17 Aug 2026 09:37:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxWT-0007Rw-2w; Mon, 17 Aug 2026 09:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786973727; bh=2ouC61ctOyoSBSyOt4PVzXQEzhdWrdRyILRRjg0KjG8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OR8OZTPjXnMaoJWLgqNyctQywWwo1/7yMkgMUqnBGZvFJGsb9cCIdw3hcFVmgDxPD
 HzN4rjQMw/KoOiOBNtDMaboFtbj6JmaSrf6+Bw7bFB2Nwvj7isrpkjRyPa6WPC7zX8
 jkSSfaW2A6fp+OIL3vIEK+CbwMIzQcf3yB+DNx3KjTn1lBXlJ25SYlFmZPgJc/7+bm
 H1OXio/91LN6SCK8bwomCyFWys/OdV/HcERYo9lcOyF6RshzecBNPcZkYLD0b8GVi/
 x9gvz5f8SM/NVFgKungHw+wXBEYwE42W2t1t77ChcGt3EE145nouzP5qANBNjAYuoh
 NrZnj0tgZtvRw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 537591CBCC7;
 Mon, 17 Aug 2026 16:35:27 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8E6C340D424;
 Mon, 17 Aug 2026 16:35:48 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id BBE8030F98; Mon, 17 Aug 2026 16:35:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Xu <peterx@redhat.com>,
 Yuan Liu <yuan1.liu@intel.com>, Yichen Wang <yichen.wang@bytedance.com>,
 Fabiano Rosas <farosas@suse.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v2 120/135] migration/multifd: Replace assert() with
 error_setg() in recv paths
Date: Mon, 17 Aug 2026 16:34:30 +0300
Message-ID: <20260817133451.2384630-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260817151855@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260817151855@cover.tls.msk.ru>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Peter Xu <peterx@redhat.com>

QPL and UADK multifd backends use assert() to validate wire-controlled
fields like per-page compressed lengths and packet size consistency.  These
asserts will stop working with -DNDEBUG builds, so may stop working.

Replace all assert() calls in the receive path with proper error_setg() so
validation failures are reported gracefully rather than crashing or
silently ignored.

While at it, touch up an assert() in qatzip recv path too.

Cc: qemu-stable <qemu-stable@nongnu.org>
Cc: Yuan Liu <yuan1.liu@intel.com>
Cc: Yichen Wang <yichen.wang@bytedance.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20260728210417.1925078-4-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit cf45083edc2b760a952836187aba7ec4139418c0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/multifd-qatzip.c b/migration/multifd-qatzip.c
index 6a0e989fae8..2f9b573e292 100644
--- a/migration/multifd-qatzip.c
+++ b/migration/multifd-qatzip.c
@@ -348,7 +348,10 @@ static int qatzip_recv(MultiFDRecvParams *p, Error **errp)
 
     multifd_recv_zero_page_process(p);
     if (!p->normal_num) {
-        assert(in_size == 0);
+        if (in_size != 0) {
+            error_setg(errp, "multifd %u: expected empty packet", p->id);
+            return -1;
+        }
         return 0;
     }
 
diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
index 88e2344af2f..ea2fd1b9f95 100644
--- a/migration/multifd-qpl.c
+++ b/migration/multifd-qpl.c
@@ -664,26 +664,42 @@ static int multifd_qpl_recv(MultiFDRecvParams *p, Error **errp)
     }
     multifd_recv_zero_page_process(p);
     if (!p->normal_num) {
-        assert(in_size == 0);
+        if (in_size != 0) {
+            error_setg(errp, "multifd %u: expected empty packet", p->id);
+            return -1;
+        }
         return 0;
     }
 
     /* read compressed page lengths */
     len = p->normal_num * sizeof(uint32_t);
-    assert(len < in_size);
+    if (len >= in_size) {
+        error_setg(errp, "multifd %u: header len %"PRIu32
+                   " >= packet size %"PRIu32, p->id, len, in_size);
+        return -1;
+    }
     ret = qio_channel_read_all(p->c, (void *) qpl->zlen, len, errp);
     if (ret != 0) {
         return ret;
     }
     for (int i = 0; i < p->normal_num; i++) {
         qpl->zlen[i] = be32_to_cpu(qpl->zlen[i]);
-        assert(qpl->zlen[i] <= multifd_ram_page_size());
+        if (qpl->zlen[i] > multifd_ram_page_size()) {
+            error_setg(errp, "multifd %u: page %d compressed len %"
+                       PRIu32" too large", p->id, i, qpl->zlen[i]);
+            return -1;
+        }
         zbuf_len += qpl->zlen[i];
         ramblock_recv_bitmap_set_offset(p->block, p->normal[i]);
     }
 
     /* read compressed pages */
-    assert(in_size == len + zbuf_len);
+    if (in_size != len + zbuf_len) {
+        error_setg(errp, "multifd %u: packet size %"PRIu32
+                   " != header %"PRIu32" + data %"PRIu32,
+                   p->id, in_size, len, zbuf_len);
+        return -1;
+    }
     ret = qio_channel_read_all(p->c, (void *) qpl->zbuf, zbuf_len, errp);
     if (ret != 0) {
         return ret;
diff --git a/migration/multifd-uadk.c b/migration/multifd-uadk.c
index 6895c1f65ab..75a9ffcf44f 100644
--- a/migration/multifd-uadk.c
+++ b/migration/multifd-uadk.c
@@ -245,12 +245,19 @@ static int multifd_uadk_recv(MultiFDRecvParams *p, Error **errp)
 
     multifd_recv_zero_page_process(p);
     if (!p->normal_num) {
-        assert(in_size == 0);
+        if (in_size != 0) {
+            error_setg(errp, "multifd %u: expected empty packet", p->id);
+            return -1;
+        }
         return 0;
     }
 
     /* read compressed data lengths */
-    assert(hdr_len < in_size);
+    if (hdr_len >= in_size) {
+        error_setg(errp, "multifd %u: header len %"PRIu32
+                   " >= packet size %"PRIu32, p->id, hdr_len, in_size);
+        return -1;
+    }
     ret = qio_channel_read_all(p->c, (void *) uadk_data->buf_hdr,
                                hdr_len, errp);
     if (ret != 0) {
@@ -259,12 +266,21 @@ static int multifd_uadk_recv(MultiFDRecvParams *p, Error **errp)
 
     for (int i = 0; i < p->normal_num; i++) {
         uadk_data->buf_hdr[i] = be32_to_cpu(uadk_data->buf_hdr[i]);
+        if (uadk_data->buf_hdr[i] > page_size) {
+            error_setg(errp, "multifd %u: page %d compressed len %"PRIu32
+                       " too large", p->id, i, uadk_data->buf_hdr[i]);
+            return -1;
+        }
         data_len += uadk_data->buf_hdr[i];
-        assert(uadk_data->buf_hdr[i] <= page_size);
     }
 
     /* read compressed data */
-    assert(in_size == hdr_len + data_len);
+    if (in_size != hdr_len + data_len) {
+        error_setg(errp, "multifd %u: packet size %"PRIu32
+                   " != header %"PRIu32" + data %"PRIu32,
+                   p->id, in_size, hdr_len, data_len);
+        return -1;
+    }
     ret = qio_channel_read_all(p->c, (void *)buf, data_len, errp);
     if (ret != 0) {
         return ret;
-- 
2.47.3


