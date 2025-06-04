Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD8BC5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 13:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMoAS-0006ll-6q; Wed, 04 Jun 2025 09:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoAQ-0006kl-9F
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:28:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoAN-0004hg-FR
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749043706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UdhxmSMIigdfDBG3myh3u7+y/4wvqLHaBzHtYCbE2nM=;
 b=bgWO4uzI2jelzm8JDif/za6G2y7rcInXKUyzkGemMoOYPW4qbpkWgk/m2AMLB7zxw2fipT
 HtHxv+27yOyV3K0scfPkol7vPQ43SxHB1b1hlBrpj62JEP8EgNrXHfTXudDghazRFjJsS+
 IxY5fz24FUwRqx3hDa6tZm2tQsvUEc0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-5gjy1j_AO6CnkahwGmddYA-1; Wed, 04 Jun 2025 09:28:25 -0400
X-MC-Unique: 5gjy1j_AO6CnkahwGmddYA-1
X-Mimecast-MFC-AGG-ID: 5gjy1j_AO6CnkahwGmddYA_1749043704
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-440667e7f92so47731875e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 06:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749043704; x=1749648504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UdhxmSMIigdfDBG3myh3u7+y/4wvqLHaBzHtYCbE2nM=;
 b=kC7gncmBqILyPH8tDQTt8vrN0wOmQRdiVL192aAylwz3OEZYd7WaXTd3BOy0hmY8U9
 NEucsPkkYxnORyICkcarr7apfGfxyiPZ4AbO/Od2J/RJxx9gmt1iNdwJA4/aMKxaIxNu
 jzTLNpBta0YCsFiDPnDgEPx+ENFmv6N207EDIdMTfaBzDJUTu8z/9XgJTOGugyIbwE44
 8w2R7E6dpus9pYviqDhQCB5OMvOJkUjkw53d0K+wu8SqVEKAMtJOZvRHd8uSfh6WFo5p
 I6Dv1ZXJiBVYdsVB8LGqGKs2rHX0NjvXU4sUWTQkvJDz8JNtO/1wQiYqeR2aY/4jA91N
 4hMw==
X-Gm-Message-State: AOJu0YxqtpycJW87SJ11wGDznnpVrWs+E7+0wCiGjxm2O5Wx9QRL2pQ2
 FrMRRF5JN2/8/euoASk0/Awehrk23XCK5AoyZSM1u4QjB1A1mTE/umZccksfVmh8CKTmrnICxEm
 Cm7D6VAc5vAHjPzbx42xzzDOJYErb1UdJmNaXSBt0XAHRyrfffFbbowKSMqFw1Q9B
X-Gm-Gg: ASbGnctQt5RV0daO02QpGEgrvEaOJMIFN93fp5UO7Rt5q93C2SX2r/1OkkCY/YwgqPd
 t9+cB4nsY9dpXeTKqpQpHk9vwsg3wcWPNlnUPtgz8Jn51aF0yat+5TEWoX/jZ4AGMKrBI2QTxha
 Ij46rscRMroihyfcHBCjnykomS4k3Z7rvswidoBbgX3/LeVILYnRB/kqOYYPFGeukid2NpeYnHq
 rO4VwkUFJwWbBxF0Ug/LXd6dzxjt6qH6asaOLjW0fnZtXSX83hVunlCTYVD9n/cL1csh5H+M2y3
 pHLEwUUa7SOaa3l9i/gQwMBVGK791karujGdBlztZkmHcT5EXmKOgaSgElUcBo9Y7kR0+A==
X-Received: by 2002:a05:600c:820b:b0:442:f4d4:522 with SMTP id
 5b1f17b1804b1-451f0a63525mr26141095e9.5.1749043703660; 
 Wed, 04 Jun 2025 06:28:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYu0XSg5ZWFG4YAQy0OdrYakP6DXb0gAhoO6svUjZktdT1KsV5ZWNSFgpIMaq+ahAvDXoklQ==
X-Received: by 2002:a05:600c:820b:b0:442:f4d4:522 with SMTP id
 5b1f17b1804b1-451f0a63525mr26140775e9.5.1749043703249; 
 Wed, 04 Jun 2025 06:28:23 -0700 (PDT)
Received: from localhost
 (p200300cfd700f306503d3c798c1bf214.dip0.t-ipconnect.de.
 [2003:cf:d700:f306:503d:3c79:8c1b:f214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8012adesm202010345e9.36.2025.06.04.06.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 06:28:21 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v2 01/21] fuse: Copy write buffer content before polling
Date: Wed,  4 Jun 2025 15:27:53 +0200
Message-ID: <20250604132813.359438-2-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604132813.359438-1-hreitz@redhat.com>
References: <20250604132813.359438-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 465cc9891d..b967e88d2b 100644
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
+    void *copied;
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
@@ -645,7 +660,7 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
     length = blk_getlength(exp->common.blk);
     if (length < 0) {
         fuse_reply_err(req, -length);
-        return;
+        goto free_buffer;
     }
 
     if (offset + size > length) {
@@ -653,19 +668,22 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
             ret = fuse_do_truncate(exp, offset + size, true, PREALLOC_MODE_OFF);
             if (ret < 0) {
                 fuse_reply_err(req, -ret);
-                return;
+                goto free_buffer;
             }
         } else {
             size = length - offset;
         }
     }
 
-    ret = blk_pwrite(exp->common.blk, offset, size, buf, 0);
+    ret = blk_pwrite(exp->common.blk, offset, size, copied, 0);
     if (ret >= 0) {
         fuse_reply_write(req, size);
     } else {
         fuse_reply_err(req, -ret);
     }
+
+free_buffer:
+    qemu_vfree(copied);
 }
 
 /**
-- 
2.49.0


