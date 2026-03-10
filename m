Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8079EFD4F06
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 16:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzv7-0003Jk-RU; Tue, 10 Mar 2026 12:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzur-0003Dl-8P
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:26:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzuo-0000nv-AZ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773159997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RQkpAxemdsSNz/LwAsMYWb7MqtumwB5V5YwGFJBCEjs=;
 b=HHjConBzw+z8yH6afEO2nB1Ia/F5xf/DLN1tY3C/EogVkFZltFDUREDT8quacrNP5ZJd50
 wnlf2DvRi/R0RIHhJo2xyu1sM6CUjht5vjB7mlUFw5FVJHGLJL+gBpviqxf27wOkZYtZld
 J/dbcY9GiJnET70c6vVnNEX+n1OgYnY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-DlLSiRyVOV6GMuziqKv9Gw-1; Tue,
 10 Mar 2026 12:26:33 -0400
X-MC-Unique: DlLSiRyVOV6GMuziqKv9Gw-1
X-Mimecast-MFC-AGG-ID: DlLSiRyVOV6GMuziqKv9Gw_1773159992
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C73CE19560AF; Tue, 10 Mar 2026 16:26:31 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.224.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A0D3C19560B7; Tue, 10 Mar 2026 16:26:30 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 01/28] fuse: Copy write buffer content before polling
Date: Tue, 10 Mar 2026 17:25:55 +0100
Message-ID: <20260310162622.333137-2-kwolf@redhat.com>
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

aio_poll() in I/O functions can lead to nested read_from_fuse_export()
calls, overwriting the request buffer's content.  The only function
affected by this is fuse_write(), which therefore must use a bounce
buffer or corruption may occur.

Note that in addition we do not know whether libfuse-internal structures
can cope with this nesting, and even if we did, we probably cannot rely
on it in the future.  This is the main reason why we want to remove
libfuse from the I/O path.

I do not have a good reproducer for this other than:

$ dd if=/dev/urandom of=image bs=1M count=4096
$ dd if=/dev/zero of=copy bs=1M count=4096
$ touch fuse-export
$ qemu-storage-daemon \
    --blockdev file,node-name=file,filename=copy \
    --export \
    fuse,id=exp,node-name=file,mountpoint=fuse-export,writable=true \
    &

Other shell:
$ qemu-img convert -p -n -f raw -O raw -t none image fuse-export
$ killall -SIGINT qemu-storage-daemon
$ qemu-img compare image copy
Content mismatch at offset 0!

(The -t none in qemu-img convert is important.)

I tried reproducing this with throttle and small aio_write requests from
another qemu-io instance, but for some reason all requests are perfectly
serialized then.

I think in theory we should get parallel writes only if we set
fi->parallel_direct_writes in fuse_open().  In fact, I can confirm that
if we do that, that throttle-based reproducer works (i.e. does get
parallel (nested) write requests).  I have no idea why we still get
parallel requests with qemu-img convert anyway.

Also, a later patch in this series will set fi->parallel_direct_writes
and note that it makes basically no difference when running fio on the
current libfuse-based version of our code.  It does make a difference
without libfuse.  So something quite fishy is going on.

I will try to investigate further what the root cause is, but I think
for now let's assume that calling blk_pwrite() can invalidate the buffer
contents through nested polling.

Cc: qemu-stable@nongnu.org
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20260309150856.26800-2-hreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/export/fuse.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 8cf4572f78d..cea9de61f1d 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -301,6 +301,12 @@ static void read_from_fuse_export(void *opaque)
         goto out;
     }
 
+    /*
+     * Note that aio_poll() in any request-processing function can lead to a
+     * nested read_from_fuse_export() call, which will overwrite the contents of
+     * exp->fuse_buf.  Anything that takes a buffer needs to take care that the
+     * content is copied before potentially polling via aio_poll().
+     */
     fuse_session_process_buf(exp->fuse_session, &exp->fuse_buf);
 
 out:
@@ -624,6 +630,7 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
                        size_t size, off_t offset, struct fuse_file_info *fi)
 {
     FuseExport *exp = fuse_req_userdata(req);
+    QEMU_AUTO_VFREE void *copied = NULL;
     int64_t length;
     int ret;
 
@@ -638,6 +645,14 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
         return;
     }
 
+    /*
+     * Heed the note on read_from_fuse_export(): If we call aio_poll() (which
+     * any blk_*() I/O function may do), read_from_fuse_export() may be nested,
+     * overwriting the request buffer content.  Therefore, we must copy it here.
+     */
+    copied = blk_blockalign(exp->common.blk, size);
+    memcpy(copied, buf, size);
+
     /**
      * Clients will expect short writes at EOF, so we have to limit
      * offset+size to the image length.
@@ -660,7 +675,7 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
         }
     }
 
-    ret = blk_pwrite(exp->common.blk, offset, size, buf, 0);
+    ret = blk_pwrite(exp->common.blk, offset, size, copied, 0);
     if (ret >= 0) {
         fuse_reply_write(req, size);
     } else {
-- 
2.53.0


