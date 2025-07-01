Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A01C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 11:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWZQG-0005DQ-37; Tue, 01 Jul 2025 07:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQ5-00059o-AW
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZPx-0003EX-Bi
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751370290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u4jDpSscWb0JSj8RJizyplK1NIFS8/wzix5MvD06Lss=;
 b=GtLFUVU19XOPu+PqZiFB3rFKO3mGGwcxjd4vDRTx8dX5wcp7vI63GSj4CdwPvMce9TveFC
 AH0upkpiGOk+7C6Ke4CwHgJJ45xDGSnYuKqCf/sd59aMOF63sr2P1XdOJuHy8E2g/COKGV
 jzlWcjvCGDuI3JlnSgxTf/87gE6AYU8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-DYVcDE4TPwKCySOT0MiZxQ-1; Tue, 01 Jul 2025 07:44:49 -0400
X-MC-Unique: DYVcDE4TPwKCySOT0MiZxQ-1
X-Mimecast-MFC-AGG-ID: DYVcDE4TPwKCySOT0MiZxQ_1751370288
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f85f31d9so2290617f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 04:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751370288; x=1751975088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u4jDpSscWb0JSj8RJizyplK1NIFS8/wzix5MvD06Lss=;
 b=QIJ/0GSfGAFWr8QgE0jqGHIMdLm5W15LdEVEjfQ2zmV+DFNaE6qWh+OqtznXTUFIRB
 53dT1+fIS8p2TOdGXsvPZaEPMV0wkiwmInppmBkXHW9Oj+VdVmGqSZdwdfPWdSU9RBTZ
 c7OIKNSJzzZmSVQ8bPWOqAQ/kVBL2UVmNzNgVCk67hHdfydP6+AuikHNkVhGr01OkFib
 qsP43C9LnDIFqRnLkFp1vNt2xK2xAOUH66tztjqzcN4ibRRYzvFVPb8azrw215Tpl1k3
 NoD2zHrVbUziadjKd7WgeofOcIyOVwU4zFd0Vfiqv6eMQuKP68areo1DZobg7GC79nJn
 +XDw==
X-Gm-Message-State: AOJu0YzxOFk9l4rUCUI3czjsyllvWYuv1G8atNfTM4zZqconDY1YHKs5
 qsaDOjHZlywt849pZ1j9vI8haGcJQxnnpV8Ct6qmADz/hPytnLF4GYuO1S+bLBgImuIeXgkeo3L
 6zQvu7x05gDY/v7dxd1uASSnTLV1cXy0mpb83zzjQq5KQRK/5eFFhqglp
X-Gm-Gg: ASbGncujQyPkWb4itC145815IN/WotBhGSwsFEUogVj7RU6baNcIDC0LdcO40XaL2pD
 NPJAYhrZhnyg9IYtVme043lzCXWqkZD23eiyLuHTw/GA9lU5Z3cheaNUCmC7zucP4tgFHVbDQnc
 5NaZOGMDOYKQAd7OO85kH/W1LdurgmUmNf3osHkx7qsWSwPk8MIrmB+MTo7PIXDrHM7OKPCK96+
 M93aqeaf8CF9ALlgzLGaDngWsOz54oFWVRSbzWakX+TMlNO0LUTUnuPp52ZYqHzNmxlVEf6VfS+
 +Urnqb6rPMSjooWGT7HhxMrPBrjTcmgcptdcJuJzB1Qd1pQUMSrIo2Fd0yRVLlEz127QGE0rfsM
 i79rb
X-Received: by 2002:a05:6000:22c2:b0:3a5:1c71:432a with SMTP id
 ffacd0b85a97d-3a8fe1deba9mr12962593f8f.14.1751370287701; 
 Tue, 01 Jul 2025 04:44:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/1qzFgbegKk/5YP7M7Mip9i03TsCFGkjhTBd3WAllWjteIMDpFIhnzs8IDLvbUy+3qFx0dw==
X-Received: by 2002:a05:6000:22c2:b0:3a5:1c71:432a with SMTP id
 ffacd0b85a97d-3a8fe1deba9mr12962563f8f.14.1751370287140; 
 Tue, 01 Jul 2025 04:44:47 -0700 (PDT)
Received: from localhost
 (p200300cfd700f38d3df6a1ca7d40fe1f.dip0.t-ipconnect.de.
 [2003:cf:d700:f38d:3df6:a1ca:7d40:fe1f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e6f8bsm13451388f8f.17.2025.07.01.04.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 04:44:45 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v3 01/21] fuse: Copy write buffer content before polling
Date: Tue,  1 Jul 2025 13:44:17 +0200
Message-ID: <20250701114437.207419-2-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701114437.207419-1-hreitz@redhat.com>
References: <20250701114437.207419-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
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


