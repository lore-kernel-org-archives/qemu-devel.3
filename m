Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373E8C3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 16:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx6oU-0004Vp-43; Tue, 25 Mar 2025 12:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tx6o5-0004Th-Q2
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 12:07:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tx6o3-0007NJ-UT
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 12:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742918831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jhcRNjx2BrP+0kRyGk0tVLJsIELhnDkDYM8TRdfrTQA=;
 b=XdDtLRRg1aD81kcszyHJ4NB6JkFLEtCNUuWZgPjiTibzOVePm8c9A6VhDF07FsmIwj8ZZH
 WLPbxm6cpETnHB2OfyoL4fsCskGLOLIEr1x9/ChQg2KpJnvrnm4Cp1URqEDp+pNoIPRm+I
 ezuB80ZM3l05qeSDgOEWl7YSJ5qeOM0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-xxzk1bPrPd2iLJQ1RvTv3Q-1; Tue, 25 Mar 2025 12:07:09 -0400
X-MC-Unique: xxzk1bPrPd2iLJQ1RvTv3Q-1
X-Mimecast-MFC-AGG-ID: xxzk1bPrPd2iLJQ1RvTv3Q_1742918828
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39ac9b0cb6aso534651f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 09:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742918828; x=1743523628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jhcRNjx2BrP+0kRyGk0tVLJsIELhnDkDYM8TRdfrTQA=;
 b=UVBpmw7yNWhKzsLj8ylErD0nZjwbObHHQaC0slCFIeBJ5jAiuhxDJ98kvT7b9OE+Q6
 I5mswI/Mqu5CGsjRDP0IEv6Z/GRlDJE58qc7H90Gvl/mOowUvi8GqXFpGrTWp6A7Qeik
 HiGdidGvWu2iwyLJr3xtpidrKnuovclLM3J5dVK28y45B2vAiGuGs6gWR5OJj7WutFlg
 FMsHpNU02u/8KvspvW/juABemZrBgHfQdTKNbv1zsaOjkY3F+C1tSL3oiAXY60cE35TO
 LtbIkf+BRKOXb/ZQTK0dgvwSvL2Un9EtozupHeIjRd2EzYa5rbLdYCMXPHT4baCtDCp+
 ugPw==
X-Gm-Message-State: AOJu0YycD6XzOX0qGGoBHqouQvD/BP9R0WbMoNVqMW569Ae+Thvoc1CP
 p9TbFEn1RgSQkkac8Rf2VgZ9GsEKxh6sqzxlz2LhFMXbz3EtYBtfBhDud68nVfDPFZLLEl5vgl4
 4szujzIZjGOQjnpixL0DLmchwWI8X5uU8q6TPrIwFvz9Ft1PzJUMq
X-Gm-Gg: ASbGncucMXbBYv9uPJM3mLSRZLvvLLt5pHytSScjIQlQ9FyAb8crXjrAoYqA50Td1xk
 V5BCzi1hZG/yWFf6kQ0i/cOXisizUpYWi6ZSbD+ooAeO8yhnZSdC+rud+/WdoK5VQtCSgzdPCYH
 DcJJZy5htovHFIO1SSNzQmeG2SlvDkRj09c2xebdErQkBzOl9nFIozDo+PwhfTCR7+Lp3AgDATp
 VKjzkzw/fw08+YaENA3wgPpvsH1ruhUSh+sEMVNPz8ceUam8X+XONbSQvFZkbVeUVtlUhknOYoE
 Cpy0ziYnxXFuAqyG4j9s/5UnfxpQEg/M4a0SuZ8GQF/oN/Uz+eIUnyoPQ9ol1EqY6BxcyxMShQ=
 =
X-Received: by 2002:a05:6000:178c:b0:391:3207:2e75 with SMTP id
 ffacd0b85a97d-3997f8fc3cemr13654817f8f.18.1742918828337; 
 Tue, 25 Mar 2025 09:07:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCkrD/wzEorkAVHvh1K8UNAFCtoVb4CUf6LTpZKu2/s/1cTGrAe7sXbe3mn+oCr0e5ot2hJQ==
X-Received: by 2002:a05:6000:178c:b0:391:3207:2e75 with SMTP id
 ffacd0b85a97d-3997f8fc3cemr13654785f8f.18.1742918827936; 
 Tue, 25 Mar 2025 09:07:07 -0700 (PDT)
Received: from localhost
 (p200300cfd74f9db6ee8035b86ef736e5.dip0.t-ipconnect.de.
 [2003:cf:d74f:9db6:ee80:35b8:6ef7:36e5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9eef37sm13852281f8f.85.2025.03.25.09.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 09:07:04 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 05/15] fuse: Change setup_... to mount_fuse_export()
Date: Tue, 25 Mar 2025 17:06:45 +0100
Message-ID: <20250325160655.119407-4-hreitz@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325160529.117543-1-hreitz@redhat.com>
References: <20250325160529.117543-1-hreitz@redhat.com>
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

There is no clear separation between what should go into
setup_fuse_export() and what should stay in fuse_export_create().

Make it clear that setup_fuse_export() is for mounting only.  Rename it,
and move everything that has nothing to do with mounting up into
fuse_export_create().

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 49 ++++++++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 10606454c3..7bdec43b5c 100644
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
2.48.1


