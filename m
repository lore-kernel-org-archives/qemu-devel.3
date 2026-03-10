Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C415FD4F05
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 16:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzvC-0003NR-LL; Tue, 10 Mar 2026 12:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzv1-0003G2-27
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:26:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzuz-0000rb-Gs
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773160008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ohf+Uy3Gosq8fyVKO9vyFqlFBUKgEQiVJI0uE3Z6pYA=;
 b=XspwunbP2wQ9dwU7CgG6S+/+wtxHzxfWcU7HeepZZZ91EYlR7Ba3F9KnVBcVJHSiKPJpxz
 vPqGu6+Md1Cg6K4wxCn+atXIQDjnPRGbAeTUFLUTadPyIvv/wfUzADhVF674ksV25Uvof+
 p0bngP4V2K5/AKGUJ3Mji8HzDg5A4g0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-MOSoUY96MY2-nt3yy0UQ6g-1; Tue,
 10 Mar 2026 12:26:44 -0400
X-MC-Unique: MOSoUY96MY2-nt3yy0UQ6g-1
X-Mimecast-MFC-AGG-ID: MOSoUY96MY2-nt3yy0UQ6g_1773160003
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7DBCE195609E; Tue, 10 Mar 2026 16:26:43 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.224.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 585E119560A6; Tue, 10 Mar 2026 16:26:42 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 08/28] fuse: Set direct_io and parallel_direct_writes
Date: Tue, 10 Mar 2026 17:26:02 +0100
Message-ID: <20260310162622.333137-9-kwolf@redhat.com>
In-Reply-To: <20260310162622.333137-1-kwolf@redhat.com>
References: <20260310162622.333137-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In fuse_open(), set these flags:
- direct_io: We probably actually don't want to have the host page cache
  be used for our exports.  QEMU block exports are supposed to represent
  the image as-is (and thus potentially changing).
  This causes a change in iotest 308's reference output.

- parallel_direct_writes: We can (now) cope with parallel writes, so we
  should set this flag.  For some reason, it doesn't seem to make an
  actual performance difference with libfuse, but it does make a
  difference without it, so let's set it.
  (See "fuse: Copy write buffer content before polling" for further
  discussion.)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20260309150856.26800-9-hreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/export/fuse.c        | 2 ++
 tests/qemu-iotests/308.out | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 0422cf4b8af..d0e3c6bf61f 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -582,6 +582,8 @@ static void fuse_setattr(fuse_req_t req, fuse_ino_t inode, struct stat *statbuf,
 static void fuse_open(fuse_req_t req, fuse_ino_t inode,
                       struct fuse_file_info *fi)
 {
+    fi->direct_io = true;
+    fi->parallel_direct_writes = true;
     fuse_reply_open(req, fi);
 }
 
diff --git a/tests/qemu-iotests/308.out b/tests/qemu-iotests/308.out
index aa96faab6d0..2d7a38d63d2 100644
--- a/tests/qemu-iotests/308.out
+++ b/tests/qemu-iotests/308.out
@@ -131,7 +131,7 @@ wrote 65536/65536 bytes at offset 1048576
 
 --- Try growing non-growable export ---
 (OK: Lengths of export and original are the same)
-dd: error writing 'TEST_DIR/t.IMGFMT.fuse': Input/output error
+dd: error writing 'TEST_DIR/t.IMGFMT.fuse': No space left on device
 1+0 records in
 0+0 records out
 
-- 
2.53.0


