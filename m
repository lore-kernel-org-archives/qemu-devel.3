Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71C6FD4F04
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 16:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzv9-0003L8-77; Tue, 10 Mar 2026 12:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzv6-0003Hl-2k
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:26:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzv4-0000tU-LL
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773160014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CFwxAjeLT8PRQo1K5MQJorT6GXi794PGg1MNpaE1iJA=;
 b=ASDlx6loe/OnGVPFQU6o4XxEmlyntgUOOIHUena+9oIV+NN9JctCwLvE/Tln/Xbxd3qRFY
 mHY/dIQF9YkGXhC23gVZ0yZkWvBIezmpv04tNswVZYH9faR+CQoN9JtzzqWZdpcE39snrM
 ROMvgqUtc3vH05VaJo36b/i/DbtJESU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-5pfRH50xN3G0jBvJ7XpA9Q-1; Tue,
 10 Mar 2026 12:26:51 -0400
X-MC-Unique: 5pfRH50xN3G0jBvJ7XpA9Q-1
X-Mimecast-MFC-AGG-ID: 5pfRH50xN3G0jBvJ7XpA9Q_1773160010
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDEFC1800756; Tue, 10 Mar 2026 16:26:49 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.224.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C97F219560A6; Tue, 10 Mar 2026 16:26:48 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 12/28] fuse: fuse_{read,write}: Rename length to blk_len
Date: Tue, 10 Mar 2026 17:26:06 +0100
Message-ID: <20260310162622.333137-13-kwolf@redhat.com>
In-Reply-To: <20260310162622.333137-1-kwolf@redhat.com>
References: <20260310162622.333137-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Hanna Czenczek <hreitz@redhat.com>

The term "length" is ambiguous, use "blk_len" instead to be clear.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20260309150856.26800-13-hreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/export/fuse.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index f6a5f4fa0a0..d45c6b814fe 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -637,7 +637,7 @@ static void fuse_read(fuse_req_t req, fuse_ino_t inode,
                       size_t size, off_t offset, struct fuse_file_info *fi)
 {
     FuseExport *exp = fuse_req_userdata(req);
-    int64_t length;
+    int64_t blk_len;
     void *buf;
     int ret;
 
@@ -651,14 +651,14 @@ static void fuse_read(fuse_req_t req, fuse_ino_t inode,
      * Clients will expect short reads at EOF, so we have to limit
      * offset+size to the image length.
      */
-    length = blk_getlength(exp->common.blk);
-    if (length < 0) {
-        fuse_reply_err(req, -length);
+    blk_len = blk_getlength(exp->common.blk);
+    if (blk_len < 0) {
+        fuse_reply_err(req, -blk_len);
         return;
     }
 
-    if (offset + size > length) {
-        size = length - offset;
+    if (offset + size > blk_len) {
+        size = blk_len - offset;
     }
 
     buf = qemu_try_blockalign(blk_bs(exp->common.blk), size);
@@ -685,7 +685,7 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
 {
     FuseExport *exp = fuse_req_userdata(req);
     QEMU_AUTO_VFREE void *copied = NULL;
-    int64_t length;
+    int64_t blk_len;
     int ret;
 
     /* Limited by max_write, should not happen */
@@ -711,13 +711,13 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
      * Clients will expect short writes at EOF, so we have to limit
      * offset+size to the image length.
      */
-    length = blk_getlength(exp->common.blk);
-    if (length < 0) {
-        fuse_reply_err(req, -length);
+    blk_len = blk_getlength(exp->common.blk);
+    if (blk_len < 0) {
+        fuse_reply_err(req, -blk_len);
         return;
     }
 
-    if (offset + size > length) {
+    if (offset + size > blk_len) {
         if (exp->growable) {
             ret = fuse_do_truncate(exp, offset + size, true, PREALLOC_MODE_OFF);
             if (ret < 0) {
@@ -725,7 +725,7 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
                 return;
             }
         } else {
-            size = length - offset;
+            size = blk_len - offset;
         }
     }
 
-- 
2.53.0


