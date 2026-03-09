Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7905F4180B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcEW-0000jH-Q5; Mon, 09 Mar 2026 11:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcEV-0000iQ-70
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcET-0008Kb-LF
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773068961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BOixUczgf/re8Xp6Djr53L45pCSu7AEC5w4EK2f/CNY=;
 b=IL/NiesQolOZsmjsU/zNXLPbzYT5ocUA+/m0VHpRXrMVlA5zbTTPtAwVJ2iGFCdpSIM7VZ
 lf+1lRISiElCeLwgxOYLXA2mtCleJtOiqmnOtHrrZg/GYKtSO4g1oij1S393Dak0pwbRbd
 BVfiRF8PcXUIhPjlTR6QSALa51ORfvU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-yjC4y0fyNcmh6QQ4iHLgdQ-1; Mon, 09 Mar 2026 11:09:19 -0400
X-MC-Unique: yjC4y0fyNcmh6QQ4iHLgdQ-1
X-Mimecast-MFC-AGG-ID: yjC4y0fyNcmh6QQ4iHLgdQ_1773068959
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836abfc742so100207075e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773068958; x=1773673758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BOixUczgf/re8Xp6Djr53L45pCSu7AEC5w4EK2f/CNY=;
 b=EE8M+llhI2zbYOtXeKkAif2wwRUKk1aL+TcSKjNVhg7yd29Ojtc/FGonS8cHwiRTf5
 fSwBMrKqm8Kal/Yd1O3zZJjfTCVtspQVenx1y5BAY7fj7dI8QdQJcp9Bg68l1Gb5KQDY
 YiN0q+8TYNfPJeK13buQ6jaTsl9CY41WBkbp/PFZURrK4VRu3lWfwVCq8rXAGf+trmZ3
 fvzvC7qTLx9RNuXPbUr5ucsNvdVKEdQVYB1ANcCmMUFItKYtiw7JiZxTpOPzQRJTkoED
 1RhUM/d4QurT+b4xVLU20CxaAYHtrq6QjIpFsj3peJrburCE+sfpXbbwwQFO6J/CDyBa
 xMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773068958; x=1773673758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BOixUczgf/re8Xp6Djr53L45pCSu7AEC5w4EK2f/CNY=;
 b=u+0D8tr8Mxik/OsCeNj5LjyHqmpe6fotbgtmxpLXoGC/7RpdWuuN8eW4FGXyCT49SU
 hTXatMeSLxzoO5Qi2qJ2mYGt8WJYWUVXet+NiuKVtqZkwVRWw5dhUmHQ9uJe+2pAqdCr
 ltv7SWYun3S3bEbPUXFFQ1+DKLN2EDwYaSip219jb/ttmdHK3HUGod2vTZN6UbEK+1mJ
 6ay8jJ+jw4RY5to5g1niLCjoNqJ93DgKjSTz+xj14N2/1PURCDWWLxATTGhhERT0J3vG
 eKOJmR3TqrvuZIopcdAW5e0ipMp/ro0j8oap3nyqYwqP4dyXW7dxOsQH49FnD1CITUER
 Di2g==
X-Gm-Message-State: AOJu0YxHxH+h2UpZmN64ErqDe3vNme0Dpv1JtEPo8G2uDPnSpPahUHda
 YqxUfC3xxUr5ja1+HAzk+NsEPXLFS/qdfhQnvpztGrWjqy49miORUxIuFP1sG32I4fdi7teHhuE
 WwRTlyllMrW6IVXdGdI0HGR5S/dtQ6LBAugcK4ZNBmF9pl/6xYjXz9F5H
X-Gm-Gg: ATEYQzxutyH6m+t2z17Wce5MR3kiTnbDWDA2LZ8lWh9GDJwZ7VxzNAtQM6NXZRe5PW5
 Nqrn2F/Y6PJFBIo0SGj/QFLg5iGqZ77+/LiNy7fdmvUsdB15fjt78WRrrHU9L9jw5pBIIkMh+Wj
 h+S1aa+PcVa2hrFiDs5oCfTOD0meO6xWWc2hGFhudgazA80qBGRMfqwiUFdQh093s+pnjAVd8Hk
 A7N99W/jSr2YXogrTdH9VqYHq49evH2bj9QKzB1FVmDSewCK+OcW7yB4Szj+vrN9UXy66gUqkje
 zRhN4H75D4VpStuGUTmKEavMIfZj7r9rzBM6lBaQ+q0faBWlH3aix82a5fkWToWrR43dS4Yu7eS
 FgoMhfZIWOzPTY39ITSnYMbxfll90gM8+qKbqzRzbWYdX7yo93L1cnFjssLqqnSBKv74b1+VLQk
 KT/y2n
X-Received: by 2002:a05:600c:3114:b0:485:40c6:f516 with SMTP id
 5b1f17b1804b1-48540c6f648mr18378885e9.33.1773068958360; 
 Mon, 09 Mar 2026 08:09:18 -0700 (PDT)
X-Received: by 2002:a05:600c:3114:b0:485:40c6:f516 with SMTP id
 5b1f17b1804b1-48540c6f648mr18378305e9.33.1773068957923; 
 Mon, 09 Mar 2026 08:09:17 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0cf29d515fbd6051d53.dip0.t-ipconnect.de.
 [2003:cf:d737:d0cf:29d5:15fb:d605:1d53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485276b7547sm287648645e9.12.2026.03.09.08.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:09:16 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v5 05/25] fuse: Change setup_... to mount_fuse_export()
Date: Mon,  9 Mar 2026 16:08:36 +0100
Message-ID: <20260309150856.26800-6-hreitz@redhat.com>
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

There is no clear separation between what should go into
setup_fuse_export() and what should stay in fuse_export_create().

Make it clear that setup_fuse_export() is for mounting only.  Rename it,
and move everything that has nothing to do with mounting up into
fuse_export_create().

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 49 ++++++++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index a56f645c05..00bb2ffee4 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -72,8 +72,7 @@ static void fuse_export_delete(BlockExport *exp);
 
 static void init_exports_table(void);
 
-static int setup_fuse_export(FuseExport *exp, const char *mountpoint,
-                             bool allow_other, Error **errp);
+static int mount_fuse_export(FuseExport *exp, Error **errp);
 static void read_from_fuse_export(void *opaque);
 
 static bool is_regular_file(const char *path, Error **errp);
@@ -193,23 +192,32 @@ static int fuse_export_create(BlockExport *blk_exp,
     exp->st_gid = getgid();
 
     if (args->allow_other == FUSE_EXPORT_ALLOW_OTHER_AUTO) {
-        /* Ignore errors on our first attempt */
-        ret = setup_fuse_export(exp, args->mountpoint, true, NULL);
-        exp->allow_other = ret == 0;
+        /* Try allow_other == true first, ignore errors */
+        exp->allow_other = true;
+        ret = mount_fuse_export(exp, NULL);
         if (ret < 0) {
-            ret = setup_fuse_export(exp, args->mountpoint, false, errp);
+            exp->allow_other = false;
+            ret = mount_fuse_export(exp, errp);
         }
     } else {
         exp->allow_other = args->allow_other == FUSE_EXPORT_ALLOW_OTHER_ON;
-        ret = setup_fuse_export(exp, args->mountpoint, exp->allow_other, errp);
+        ret = mount_fuse_export(exp, errp);
     }
     if (ret < 0) {
         goto fail;
     }
 
+    g_hash_table_insert(exports, g_strdup(exp->mountpoint), NULL);
+
+    aio_set_fd_handler(exp->common.ctx,
+                       fuse_session_fd(exp->fuse_session),
+                       read_from_fuse_export, NULL, NULL, NULL, exp);
+    exp->fd_handler_set_up = true;
+
     return 0;
 
 fail:
+    fuse_export_shutdown(blk_exp);
     fuse_export_delete(blk_exp);
     return ret;
 }
@@ -227,10 +235,10 @@ static void init_exports_table(void)
 }
 
 /**
- * Create exp->fuse_session and mount it.
+ * Create exp->fuse_session and mount it.  Expects exp->mountpoint,
+ * exp->writable, and exp->allow_other to be set as intended for the mount.
  */
-static int setup_fuse_export(FuseExport *exp, const char *mountpoint,
-                             bool allow_other, Error **errp)
+static int mount_fuse_export(FuseExport *exp, Error **errp)
 {
     const char *fuse_argv[4];
     char *mount_opts;
@@ -243,7 +251,7 @@ static int setup_fuse_export(FuseExport *exp, const char *mountpoint,
      */
     mount_opts = g_strdup_printf("max_read=%zu,default_permissions%s",
                                  FUSE_MAX_BOUNCE_BYTES,
-                                 allow_other ? ",allow_other" : "");
+                                 exp->allow_other ? ",allow_other" : "");
 
     fuse_argv[0] = ""; /* Dummy program name */
     fuse_argv[1] = "-o";
@@ -256,30 +264,17 @@ static int setup_fuse_export(FuseExport *exp, const char *mountpoint,
     g_free(mount_opts);
     if (!exp->fuse_session) {
         error_setg(errp, "Failed to set up FUSE session");
-        ret = -EIO;
-        goto fail;
+        return -EIO;
     }
 
-    ret = fuse_session_mount(exp->fuse_session, mountpoint);
+    ret = fuse_session_mount(exp->fuse_session, exp->mountpoint);
     if (ret < 0) {
         error_setg(errp, "Failed to mount FUSE session to export");
-        ret = -EIO;
-        goto fail;
+        return -EIO;
     }
     exp->mounted = true;
 
-    g_hash_table_insert(exports, g_strdup(mountpoint), NULL);
-
-    aio_set_fd_handler(exp->common.ctx,
-                       fuse_session_fd(exp->fuse_session),
-                       read_from_fuse_export, NULL, NULL, NULL, exp);
-    exp->fd_handler_set_up = true;
-
     return 0;
-
-fail:
-    fuse_export_shutdown(&exp->common);
-    return ret;
 }
 
 /**
-- 
2.53.0


