Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9FEC3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 16:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx6qd-0007D3-0B; Tue, 25 Mar 2025 12:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tx6ox-0005Tz-4n
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 12:08:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tx6ot-0007Z4-HX
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 12:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742918882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vMGs3E6Ei0m6WABpctn8IHBAUugpx7h6jWwNQOkWU5M=;
 b=bM15d98EwDwnq3JswC1SurV+wvlmxiZVK3h92R7tc+kkS4R6OFhyyr4WwcHPY4IHCzoq5z
 hUGaoOKMXqTGAIbZGAxTsbfbTIqor+bi3maMFR2VAsBUFotKf+Sd/wXUXpHEQBUaoZhuTz
 ofSqEXR997r1gIQSuTspgW9tP1UgOXM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-E_QsW6--Pd2H0sbhOk-UMg-1; Tue, 25 Mar 2025 12:06:41 -0400
X-MC-Unique: E_QsW6--Pd2H0sbhOk-UMg-1
X-Mimecast-MFC-AGG-ID: E_QsW6--Pd2H0sbhOk-UMg_1742918800
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf327e9a2so46327995e9.3
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 09:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742918800; x=1743523600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vMGs3E6Ei0m6WABpctn8IHBAUugpx7h6jWwNQOkWU5M=;
 b=uoyg0MV56P5xYgbbuKgFLKi6maqFBV+tXWQIZ/X9ng3kNn1f7G7H9euDiI+lB58N8C
 zbTyBC44cZ+eDRaP8k/0U2WLCedXzpBWJ3wrZXFPTAU0nJpZDS1aS0w5B76v0k9bQReS
 ncA8VQDrZ3bs0YR+8yl1jR1agbDzLoza0hRXNUlxZl0QEnTy/+dH9REu6MxGPFpUuSsI
 OMlIfoXNFOm2w89aRyA7SuPVDNKdUG7pSrnjYlRmqc8dq/Kiwp3ex4+6s4hFsB06A9Q1
 SI1/qB9DqYVqiTwZgW+LFiDx0HXu4YK4p4ohd/5ZzOKp5GpN3f2x2sKdhNl6xn8LbQV0
 NKKw==
X-Gm-Message-State: AOJu0YwOGy04sgv7ajk+WsDAoVb81Kj12gI6bv1BJoA9TDQplnnWk0lx
 z0cKz/Ptv37sg/YVZ04ZHRNbUtohL/1YbXQGU6VR6aAl4HAb81t4Zo5p5BD4QGvQxaiCOObC1IJ
 V2dERIwyOn4e935SFWiDhA5dq8yeuzMENe5IWfMCnD3wSvO61HAi/
X-Gm-Gg: ASbGncvlKVvRYTMZ4pp/raAN3e7r45LTXB3mARLeKjIHCWXH0ViKpbMuRYXsy9pXE8g
 pXtG8Hkbo4k3gs5utUVzmiMdse8Z2uoAxB7O2eW2Iq3emcQXgIXKWWgmbNYpdljAAVJUYnkSldG
 AeK2mbH8eaIqQ8JAVoa+Z2IssTpzHDPiIq8p/DkidwHwIISwQ8egm9AMzsty3NWrd+SXbs//31a
 gyhcKsOAFBbcFVza+0ZP/KGHqNiFCZlBR3rPl1YkuqfT4w/uXedJ3MCibH2Fktdzur3uPGtnOmr
 lD77EqLeddoZILdxOT/+6LuYYu+NqAmNCTdbTuIV9XU3MVaaNJrrES1OlIlIRGgoxZzCO3NVdw=
 =
X-Received: by 2002:a05:600c:b8d:b0:43b:ce08:c382 with SMTP id
 5b1f17b1804b1-43d509f6797mr176878155e9.16.1742918798719; 
 Tue, 25 Mar 2025 09:06:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkCedYmAoZ641KoSS1am6gtapvsT19N1TBNd5OEUdcmp12ej5vJPMbwQWip3GAukepRcpNYQ==
X-Received: by 2002:a05:600c:b8d:b0:43b:ce08:c382 with SMTP id
 5b1f17b1804b1-43d509f6797mr176876355e9.16.1742918797260; 
 Tue, 25 Mar 2025 09:06:37 -0700 (PDT)
Received: from localhost
 (p200300cfd74f9db6ee8035b86ef736e5.dip0.t-ipconnect.de.
 [2003:cf:d74f:9db6:ee80:35b8:6ef7:36e5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fd277d5sm155950915e9.19.2025.03.25.09.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 09:06:36 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH 01/15] fuse: Copy write buffer content before polling
Date: Tue, 25 Mar 2025 17:06:35 +0100
Message-ID: <20250325160635.118812-1-hreitz@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325160529.117543-1-hreitz@redhat.com>
References: <20250325160529.117543-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Polling in I/O functions can lead to nested read_from_fuse_export()
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
index 465cc9891d..a12f479492 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -301,6 +301,12 @@ static void read_from_fuse_export(void *opaque)
         goto out;
     }
 
+    /*
+     * Note that polling in any request-processing function can lead to a nested
+     * read_from_fuse_export() call, which will overwrite the contents of
+     * exp->fuse_buf.  Anything that takes a buffer needs to take care that the
+     * content is copied before potentially polling.
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
+     * Heed the note on read_from_fuse_export(): If we poll (which any blk_*()
+     * I/O function may do), read_from_fuse_export() may be nested, overwriting
+     * the request buffer content.  Therefore, we must copy it here.
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
2.48.1


