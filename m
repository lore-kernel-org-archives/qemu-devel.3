Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E69FE9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 13:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vshfb-000486-Dx; Wed, 18 Feb 2026 08:32:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfT-0003yj-OM
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfA-00052x-N6
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771421520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KIrJYrtnoXwxSw4V3NuTZZEpmlWDoM3vKo2sYuFFuvk=;
 b=iL6DYDVbeTt8yOV6GAWNwI2Jr5jJB+K0cVAn0xhJHC1Q5eLK7D8wjolMxRpOKj6AEqe7jR
 pl4dg7iat/25sd58maEiNwYz+CF6M8HfL5p6fwpR8PMaTOLalzgLc5zvsT6aAXVbXU+XFZ
 q4Ked2TghRNVifSPX18qpURYLIdICIA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-KFCd-gTGPL6FS4Anet0x1w-1; Wed, 18 Feb 2026 08:26:46 -0500
X-MC-Unique: KFCd-gTGPL6FS4Anet0x1w-1
X-Mimecast-MFC-AGG-ID: KFCd-gTGPL6FS4Anet0x1w_1771421205
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-436267b01c4so4787945f8f.0
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 05:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771421205; x=1772026005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KIrJYrtnoXwxSw4V3NuTZZEpmlWDoM3vKo2sYuFFuvk=;
 b=m3dskqsJNpNW1ywXhelYIoKfU9yUd4gdfbfXpFkS+mK/ePYMopLcRdGEtdXNJxjGsu
 /kv3p5F6SnWsydsFy3kiY4YT10gnJrv8YBTLmvimcAiCpv2yJmWkKEHsnavfENlJhrNm
 Y9g8kWvSY4hbAiWzUEaSlBzSRKEChzt+VlakiClYytJwmahfle4BrPDbhrB/fW5tFJ2j
 ainQyVTBggsMup/HRl8z/hETTaq4/TScRfbjxMGcNijM5WJ8TOwBz6vy0vVaTaXV14uM
 ApF68Qn7LBp30nmDF9H7N0IeQAs1d8KVnm0GXPhE+A2AFqTYHEhNz3CdE4rNgmh70bhi
 hIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771421205; x=1772026005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KIrJYrtnoXwxSw4V3NuTZZEpmlWDoM3vKo2sYuFFuvk=;
 b=oNOgGzDXPHELCRqDlr9CCWyUoHpNb+532dLB5Ks31OiqGH5Jr+13Qwf3J25L+ePK7q
 zAEqpu4cTM2N7VNPfbTOSwoVaXoPu3FZt45hSVhjH9X815LZ5yu6GALVRGgOeLqbFjI7
 O5tHlwR6f+1nuKFoKF1EFL1QLv7RF8+S6qhISj0V9U0HaTAbQlmVmgACDuN5UF0sEY1V
 RDOgJSQkZZMn9WaDHsQuM1zi3UAJV0n+z73HRTPb1zjeDDFL/yksm303EC0kTpZ7w3nB
 aCJ7J+tCAiWeKl8u6kU5jQzz5ff9/APE4ydGFhfzR0N0Ydz/RC6e1cezG6aPOACnYNAV
 KgLA==
X-Gm-Message-State: AOJu0YwNSwknT/Tca5BrPSywYWvSe8J5cMudBUDPG4MhRbQzXBp90p6B
 +VSwIQCT4SEewNbOj2yqIdd9Dkr6W0bx8rAMAsHya3Adud8zdRqdpAAwfYoEqc3MJmhZIphpTw8
 OgWMUlt5+u2MnrC6/6iM7dku39MmdEfWrqJHc5myKPO5fIRGEn3lcn1X+
X-Gm-Gg: AZuq6aKKOFglxmgd+HvlZ2gJOTNXgnhepeRSiakKn/pncGk6NPCZhzLd+DYAw/KRXMV
 VZ8Yn0RJxXbr5SGoo5s3drC5PAd38zxr/FeekJsyUPRl4J8sffyqxLzjh0H0zDzQEjKgLB4DLg9
 3VNY89063AlIwQ66kMnTMWqf8yZauvpTEB6ez/MLpr0ECHWG7tpNBVY2MBy7WCY/v/SIBf+SIv3
 K8UGQZnFQ13niTqEhWq0PwQKLAd125vlsyKmAJ/CqgCPNEH/6/JJkfPfBHTnxop/GNHFrmg+tz3
 v5eeFJE9R68EZHi6UTCubE9kdvAvn3Ls/xLerEgxkGobi/tqMEgVFwXYqOvz4OqWGDgGsyLFccV
 sTIiVrbS9pCuKUgCYFxAfWDcJdHvhB02SZUYLLeOghjSKEUF0XCzfAgxPyeJg2Virc8GTuHMFD0
 ectmcu
X-Received: by 2002:a05:600c:8219:b0:483:6bb1:117 with SMTP id
 5b1f17b1804b1-48398b7d878mr31983425e9.32.1771421204962; 
 Wed, 18 Feb 2026 05:26:44 -0800 (PST)
X-Received: by 2002:a05:600c:8219:b0:483:6bb1:117 with SMTP id
 5b1f17b1804b1-48398b7d878mr31982945e9.32.1771421204477; 
 Wed, 18 Feb 2026 05:26:44 -0800 (PST)
Received: from localhost
 (p200300cfd737d029edef7b8da7441ac2.dip0.t-ipconnect.de.
 [2003:cf:d737:d029:edef:7b8d:a744:1ac2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4837e565f5esm419468275e9.10.2026.02.18.05.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 05:26:42 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v4 01/24] fuse: Copy write buffer content before polling
Date: Wed, 18 Feb 2026 14:26:10 +0100
Message-ID: <20260218132633.29748-2-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218132633.29748-1-hreitz@redhat.com>
References: <20260218132633.29748-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 block/export/fuse.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 8cf4572f78..cea9de61f1 100644
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


