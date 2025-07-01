Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C62C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 11:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWZQQ-0005N8-OV; Tue, 01 Jul 2025 07:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQK-0005HV-Ox
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQI-0003VG-F6
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751370312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iBWE4FPpwD87XkHHPVGSv5gJzue+dVBIat7kcbz/nkQ=;
 b=RI6z4t+yd6QTOelpXtAij0vpo4DN454w4d7ZVLJA03Afwc+p/7y1+F5+MxvXyy3ZoSEUf3
 Z19GezT3UVkdsvjeaLz4asqMpxHy+b/VZWZN2pgEIjw7E/hcfN+PbwBuPRclTtxE/gg1v4
 mrTXYL5T0/bVPkrctv1u2KOqSuPVqTU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-LWzM9_UwNZu4J7MF3SZ37A-1; Tue, 01 Jul 2025 07:45:11 -0400
X-MC-Unique: LWzM9_UwNZu4J7MF3SZ37A-1
X-Mimecast-MFC-AGG-ID: LWzM9_UwNZu4J7MF3SZ37A_1751370310
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4535ee06160so23943755e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 04:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751370310; x=1751975110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iBWE4FPpwD87XkHHPVGSv5gJzue+dVBIat7kcbz/nkQ=;
 b=N53/HEVFqONnaweopmzxJw/X/11/IKoxtoqnIFj/zqI/gdEzmOEtMTN7WW3YlCfodu
 STKf3K9ENH2DBUdkzTGEO7w6XBzHQwTBo9kJdsxk1YoW9SJG3r/9G8qxWnyKdXHS1aQ4
 cCv+OpClVYCDfaQsaKs8vRzp6YY2eAMskNRHj13CDRMM0VPCaTGUlu3jbGwCWEtVBhk3
 qk2fTYKTjcKVg9/CHc1FNC+l72meZ5o5jlJ8iaVw6eET68pCXcxDZW2Rpswid1hfp1jA
 84di9LRU2hT+13KE7FRYOYPOO2mddJPuX7dbeiFRc0moG6TIiaRG2jZ5BT+jtIA3GmUx
 ULhQ==
X-Gm-Message-State: AOJu0YwpOvZ/RbA7i7iIDGyd9/FXHdnRXWP81znb4l6V4oC9saCwZTo9
 H6qZU6ll9gCagZoUf3vtJ9c3uXYDgFhwXAAO6O8Eg7ry/1TXIv2LuPALCRpWhZd4+xUKVKBq4zD
 DDDaCiv+xgGnrrSHag9cBU95dIjGgZAzklwKmnfKueD2IEyYt6RlhwsjC
X-Gm-Gg: ASbGncvtWmT283NyCvsiRm1zHHgu7fOe2qeePLaRN/1A43Gd//PG9+IjuUNKe2iBkYa
 ZfSG0/2cf5VV8PhHRxigurZ+YDIXpCdH5fzv6Gurk9ilEHjZqtCgpQZf3QW5YrfGM2++IX9TbOe
 Jn6nnsuz6D6OBMGa+LstwlWyi092yIr4isk171Z8llq6ctSg/BcJDIYNFIBnXSW2/RaiEiiFLf3
 6oxhBmpd7hKKhBQ6R1Mb5VaNKo6sANa17qal2sD7BTWKt4nsZQpQ34TbxEgUqfBD9pNESE/YE/8
 88H3dJpqUZdvwmhSxK9FVSZDL3rpgSofrZKaNa6KNfSz9TzF/cBDN/OP3BEyHsIXsbzJm+iyR8t
 Wm1rt
X-Received: by 2002:a05:600c:1d18:b0:444:34c7:3ed9 with SMTP id
 5b1f17b1804b1-4538ee7995emr158470745e9.26.1751370309633; 
 Tue, 01 Jul 2025 04:45:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElVEXsmx8FELqsitwXiXkQCojBQWjSiXX6hTs1cbcuGPjoW3Jmx2KoPkV4xwdmu6nlVnnWKA==
X-Received: by 2002:a05:600c:1d18:b0:444:34c7:3ed9 with SMTP id
 5b1f17b1804b1-4538ee7995emr158470175e9.26.1751370308836; 
 Tue, 01 Jul 2025 04:45:08 -0700 (PDT)
Received: from localhost
 (p200300cfd700f38d3df6a1ca7d40fe1f.dip0.t-ipconnect.de.
 [2003:cf:d700:f38d:3df6:a1ca:7d40:fe1f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52b9esm13187556f8f.61.2025.07.01.04.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 04:45:06 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v3 08/21] fuse: Introduce fuse_{at,de}tach_handlers()
Date: Tue,  1 Jul 2025 13:44:24 +0200
Message-ID: <20250701114437.207419-9-hreitz@redhat.com>
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

Pull setting up and tearing down the AIO context handlers into two
dedicated functions.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index e1134a27d6..15ec7a5c05 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -78,27 +78,34 @@ static void read_from_fuse_export(void *opaque);
 static bool is_regular_file(const char *path, Error **errp);
 
 
-static void fuse_export_drained_begin(void *opaque)
+static void fuse_attach_handlers(FuseExport *exp)
 {
-    FuseExport *exp = opaque;
+    aio_set_fd_handler(exp->common.ctx,
+                       fuse_session_fd(exp->fuse_session),
+                       read_from_fuse_export, NULL, NULL, NULL, exp);
+    exp->fd_handler_set_up = true;
+}
 
+static void fuse_detach_handlers(FuseExport *exp)
+{
     aio_set_fd_handler(exp->common.ctx,
                        fuse_session_fd(exp->fuse_session),
                        NULL, NULL, NULL, NULL, NULL);
     exp->fd_handler_set_up = false;
 }
 
+static void fuse_export_drained_begin(void *opaque)
+{
+    fuse_detach_handlers(opaque);
+}
+
 static void fuse_export_drained_end(void *opaque)
 {
     FuseExport *exp = opaque;
 
     /* Refresh AioContext in case it changed */
     exp->common.ctx = blk_get_aio_context(exp->common.blk);
-
-    aio_set_fd_handler(exp->common.ctx,
-                       fuse_session_fd(exp->fuse_session),
-                       read_from_fuse_export, NULL, NULL, NULL, exp);
-    exp->fd_handler_set_up = true;
+    fuse_attach_handlers(exp);
 }
 
 static bool fuse_export_drained_poll(void *opaque)
@@ -209,11 +216,7 @@ static int fuse_export_create(BlockExport *blk_exp,
 
     g_hash_table_insert(exports, g_strdup(exp->mountpoint), NULL);
 
-    aio_set_fd_handler(exp->common.ctx,
-                       fuse_session_fd(exp->fuse_session),
-                       read_from_fuse_export, NULL, NULL, NULL, exp);
-    exp->fd_handler_set_up = true;
-
+    fuse_attach_handlers(exp);
     return 0;
 
 fail:
@@ -329,10 +332,7 @@ static void fuse_export_shutdown(BlockExport *blk_exp)
         fuse_session_exit(exp->fuse_session);
 
         if (exp->fd_handler_set_up) {
-            aio_set_fd_handler(exp->common.ctx,
-                               fuse_session_fd(exp->fuse_session),
-                               NULL, NULL, NULL, NULL, NULL);
-            exp->fd_handler_set_up = false;
+            fuse_detach_handlers(exp);
         }
     }
 
-- 
2.49.0


