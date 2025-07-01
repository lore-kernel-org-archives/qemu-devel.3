Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C784C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 11:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWZQO-0005JB-Ik; Tue, 01 Jul 2025 07:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQJ-0005Fn-Ka
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQD-0003UD-Fn
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751370308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B9wF3F+3bQ/mxGLpNGnaivuKHU4J9Rkz4uaRH9vksus=;
 b=hBQmVBTrJW8THF02YA16sxBSaE5oh9Muve0OimSK1cE7Qcv8dCd2kPxwqmT+FnQBuBMpJj
 Bz3mD+m/Gu9mwC5hTEBhBDIhic93VcnxTWkMa4a8h5NJVsl82Kthsovf7ilM9IXYqM4i06
 EdJ/nGFa2gwmvzDgk8Cab09qUn2fCGc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-6K8QkWwdPnG1k35Bm97J8w-1; Tue, 01 Jul 2025 07:45:07 -0400
X-MC-Unique: 6K8QkWwdPnG1k35Bm97J8w-1
X-Mimecast-MFC-AGG-ID: 6K8QkWwdPnG1k35Bm97J8w_1751370306
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-450d290d542so35349755e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 04:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751370306; x=1751975106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B9wF3F+3bQ/mxGLpNGnaivuKHU4J9Rkz4uaRH9vksus=;
 b=X9hdgSIGmSZC4/b47uxwo6tk0HMiFeErY1fFWi/+QzGrV2O7bm6rruuDn02qarhRWU
 83NiENcXGH5+4ZgKAl2siY2hDkdfdp4wnmS/hGpnG3n3PUcw7W3/fbPBfU6hAqdXk95U
 PabzHi/GVEO5mFaO4G7/7xk0afjWblXMQGEBhlm9A7qliHVITy8D5CmqDAxyUwPPEaQ1
 guglzCIj3MXwyzoRWjm1YXJfR+h+L2k63nNqVgNFSqTRaDpX2s1EAtr0Ot5Plg0c09Tw
 cYJ/TcGO4f4I3+v3we1Z987jy6qsXFY/Hjw8VkJu+wkNctC2VLfOsNdw98OYnYQq/Mj2
 fo7w==
X-Gm-Message-State: AOJu0YyxQ5l6oTHgz+oq3W5rHmLXSztbUD45XYk4RecjHuvBkCu4WG4N
 PRIkQgV7rzJc1Sg38cxDHNtZlcR3AyqerQu4KQxjVeawU9TeiM5pHfFEwvzJ4/pGceb0qnn38qE
 xlRbQ+3NZoOoglZLbm1/Md3XFEeiwLbaDgoSP2gl18FakYT77hnxS8A85
X-Gm-Gg: ASbGnct9YK95n+XHDx27v/oJi2QoLiX9Bh60sGtJihCHyO1WGgcylv1eeZrMblFGgDi
 dQB3FospiDFKY05D7YEVZ05hIOfcnJOseOm1wBJh7VRInvB1OmaB7FeyigZFg0HTpBsOGOiurJn
 VRLc40piEn1FSBbi45C0/1Vf7WTBPsfJho37+0NT9aZlwA/8sOGhFXDlGCjaBJ60nR7djwkT3K/
 92wujNg9/8OcH++0YCEkdd/NVAob1PTWALCKV7+AOSmiRhxAF7nI1QrC01YIxhcc4IPLczd03Li
 5F0TjPV1WGYIiCa8MpRS/kzg1dG/+jJehwDlbFvgjC38DMnMYqaUG89l16aERf8hpvtifemuPOz
 yyWLx
X-Received: by 2002:a05:600c:4eca:b0:453:78f:fa9f with SMTP id
 5b1f17b1804b1-4538ee5e82amr169827625e9.11.1751370306062; 
 Tue, 01 Jul 2025 04:45:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMhd21T9277IdZYSF4DhSxosr6zQDzNI/f5HhtW60GKMwy//k3k/ElVlNSAo70ots5b5hD1w==
X-Received: by 2002:a05:600c:4eca:b0:453:78f:fa9f with SMTP id
 5b1f17b1804b1-4538ee5e82amr169827205e9.11.1751370305601; 
 Tue, 01 Jul 2025 04:45:05 -0700 (PDT)
Received: from localhost
 (p200300cfd700f38d3df6a1ca7d40fe1f.dip0.t-ipconnect.de.
 [2003:cf:d700:f38d:3df6:a1ca:7d40:fe1f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453835798acsm192848075e9.10.2025.07.01.04.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 04:45:03 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v3 07/21] fuse: Set direct_io and parallel_direct_writes
Date: Tue,  1 Jul 2025 13:44:23 +0200
Message-ID: <20250701114437.207419-8-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701114437.207419-1-hreitz@redhat.com>
References: <20250701114437.207419-1-hreitz@redhat.com>
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
---
 block/export/fuse.c        | 2 ++
 tests/qemu-iotests/308.out | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 9d110ce949..e1134a27d6 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -576,6 +576,8 @@ static void fuse_setattr(fuse_req_t req, fuse_ino_t inode, struct stat *statbuf,
 static void fuse_open(fuse_req_t req, fuse_ino_t inode,
                       struct fuse_file_info *fi)
 {
+    fi->direct_io = true;
+    fi->parallel_direct_writes = true;
     fuse_reply_open(req, fi);
 }
 
diff --git a/tests/qemu-iotests/308.out b/tests/qemu-iotests/308.out
index aa96faab6d..2d7a38d63d 100644
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
2.49.0


