Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13593F4180B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcEP-0000bg-JC; Mon, 09 Mar 2026 11:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcEO-0000as-7L
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcEL-0008Hq-AA
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773068952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KIrJYrtnoXwxSw4V3NuTZZEpmlWDoM3vKo2sYuFFuvk=;
 b=fQuAqKsBF/vIIZy86DtNIN5I6NHNtmCE+oFFfcJKOePkeppGdBwchfY0ueoA3i48xAfdfZ
 cgUhRk1gAEcOnHTkndQIdqOikyA50mpb0V57oviw58UKABsXfWjuftFDFpCvdb730L9i98
 x0E0LKs6eGsloYLKb+Atna6uIDcIMqk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-nPU_imrOOH6DdHWrn6IHfQ-1; Mon, 09 Mar 2026 11:09:11 -0400
X-MC-Unique: nPU_imrOOH6DdHWrn6IHfQ-1
X-Mimecast-MFC-AGG-ID: nPU_imrOOH6DdHWrn6IHfQ_1773068950
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b8f848ebcbbso815831266b.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773068950; x=1773673750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KIrJYrtnoXwxSw4V3NuTZZEpmlWDoM3vKo2sYuFFuvk=;
 b=nPhAm6FIKMcNP0uDsbBUV2NLSYkAyZ2P0IYWEOrIzeGWj5INHF9ffu0ImIhKcyupMN
 VvNoVLUXeneqwszyP2eCvMB2nOmCylIgGxYFSz6zE/SfWWIBweNc2nEu6xZch0oOxWuO
 WusvtBjyUZE9U1BPv7fPeJddqxk5FMtq/onlYux5aVpU+30V4BFCwrhJwUS4LF4lLiNJ
 na3WJL++ryeQa5XZSfV+FgcSuJS1PYBjjUjWXAqLeNV01yDnxQwDGIlFHaypJBgfHWgU
 4UNgx+3YyJHWJfa4lXxrf4hrxaXth9nDS7lyNhZnDfpp6Fob6Il5C2VoiIk/sgW86XLs
 vG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773068950; x=1773673750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KIrJYrtnoXwxSw4V3NuTZZEpmlWDoM3vKo2sYuFFuvk=;
 b=b0BQX7o83xwH2guOmUtgtF99wX4hv3v2f+D0meF5M1jqI7I88kYnLBJ2xo/BUgSPuF
 6n0mgOiRCyDxwrhNrIHPDrUhUiRuem56MfZnE+5gGqWArlnl0qX9NsBrP9LtllrlyUgm
 A0ITEG2Uo2NlODCi+FYU7gP3UfI4A/Mf63aBWk77DvOF+tjZuK3O+etbMLs+PN4g4vgi
 ohe9yZCremSDXSaGAAM+xB7f6KWLS/b1Qx3Z7AEskrhtVBrTc1WcpSVBgeitcOPANzxA
 JEeYlDFzL6GQ7JfUApetnl0xhwhyCR9/pK9u3rT9LUsRBOJiytj7nrHhVZxINYe117lG
 C/Qw==
X-Gm-Message-State: AOJu0Yzx65BuW6qyFZ/eNfYRw768EgN3XApu1gcz6Q4BrzYq3r3VcbWh
 0vfoWioNgwU3eGkr4abXQ74IdvHA3vPBctybPKDx8p29ELRIr+lkacoEM35wJoYZRlpMNxTENOp
 Xpva1huzRmx7laQhPB4gnpDxyUqk6xIxHM8FIe6kXTsXDR5bXX64Q6D1B6/ZtxY/p
X-Gm-Gg: ATEYQzwQ2aI2+86Z9LVbYj1SP1cei1t9sZeciirm15PxIz2zsIub/peIJvtuOOEk6SI
 1gyf2HOy4Gw628ONpwgXRTZ+dRpqKBt9619NDDTSybxNUSeB/NzSCiQ8vPTZesIDxJ5eiYQRt+4
 muw37raqZ5tKNrX2tjPMetyP1mjTS00JoP4CDeKHXi0gczvlp2kB//KYP1tz/TVs7frFBHWQ8Tj
 ducReEzp3svsiaogce6oWE5m7GVcioKwIY7JNZhuuvF/FYBuBxnBCcOjZk0Q3k2aBHFfTgiovQx
 J3poD+nT6jqyZezJG/1fAzWnzSTrgMnUouj5M/QKNnI/zYJfpf34zPjga9PEBzfb9/kQcQNNG8b
 DQP9+yItv2sYY/fhCrAuRzHBylX8Z8c40gQbksxKEr3ACsrGWNC5HPz6AOJLFqgEJyZuZ2sI9UD
 WD1IFz
X-Received: by 2002:a17:906:fe4c:b0:b87:1fe6:f223 with SMTP id
 a640c23a62f3a-b942dbafa2emr620155266b.6.1773068949892; 
 Mon, 09 Mar 2026 08:09:09 -0700 (PDT)
X-Received: by 2002:a17:906:fe4c:b0:b87:1fe6:f223 with SMTP id
 a640c23a62f3a-b942dbafa2emr620153166b.6.1773068949296; 
 Mon, 09 Mar 2026 08:09:09 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0cf29d515fbd6051d53.dip0.t-ipconnect.de.
 [2003:cf:d737:d0cf:29d5:15fb:d605:1d53])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2ba5bsm24847050f8f.22.2026.03.09.08.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:09:08 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v5 01/25] fuse: Copy write buffer content before polling
Date: Mon,  9 Mar 2026 16:08:32 +0100
Message-ID: <20260309150856.26800-2-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309150856.26800-1-hreitz@redhat.com>
References: <20260309150856.26800-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
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


