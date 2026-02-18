Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF54DE9A049
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 13:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vshfC-0003rZ-M3; Wed, 18 Feb 2026 08:32:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfB-0003pa-4L
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshf2-0005GZ-HR
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771421527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BOixUczgf/re8Xp6Djr53L45pCSu7AEC5w4EK2f/CNY=;
 b=cAO5cgZRzvNYp9QZORU0O6EbC9d06zYUXCdWIxrd18bhWNJh1pY+QuNPQxBFguUoExcTE5
 IsksItraou6oIRP9A9XTatwCzSL6OrzBZzh065Smq3YPAzij7FTKXUQXPPTJ1KZ0G8U95s
 AFSYbOdrKbRByNJ9WHYSMv+nyjCwZFE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-MYc6KdwxPwWBjvj89X6qLw-1; Wed, 18 Feb 2026 08:26:57 -0500
X-MC-Unique: MYc6KdwxPwWBjvj89X6qLw-1
X-Mimecast-MFC-AGG-ID: MYc6KdwxPwWBjvj89X6qLw_1771421216
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48379489438so43583655e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 05:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771421216; x=1772026016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BOixUczgf/re8Xp6Djr53L45pCSu7AEC5w4EK2f/CNY=;
 b=d07ER0GU+tvnG9/0oDjiFekc5wUhaRtQ4GEqIlma1DjV1cVxO7lFx2wJyWkUd4znUR
 k7CAkfLXNP6k8YUn0IrZobMnARZgJkT+0hUjjnNWNDVAcPwhYA4JOtheA/DtDeE67D+7
 IAkdiHf14ATvgMWfq97BHgJHAg00QJ9tZghC2kSpuslzk7M+TS8TVGwKlLEjddtTdCrH
 8JKMG5xBTiTv39BtcXj+l9gzQEQqLjcutjly6MuQAYSr4cgWuktoFWpUCCUcX0I3JNS8
 82cFxlnacvbfOJNAPjc6e3t4PgdJqvxaJ6/qI/MhNRt6DUo0U623DP9Eet2T19mS9kgV
 bRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771421216; x=1772026016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BOixUczgf/re8Xp6Djr53L45pCSu7AEC5w4EK2f/CNY=;
 b=eAHZuyH54f1mwV4HnAdqa33+3PT+m2fb4uILfB28oX6KHUVaicuUbxSOPVxiNnmbJ/
 hzGGJ8H4oLu4BFh0tRv6P8am25A/UDayBCAvnltciNDML2DKCRFqUqJ+ii+2hHCU+ynM
 oYcEpzTxBSULgE3hd+1XPkJo1Uax5Bo/9ZfK3aSPEnjFVu1Pw1huDmES/bp+zlN+aeaX
 5AsWb6NiGFrun8vA5yNBpO6NS4/q6JTFml/W0cOvLtifYsh2VxXQrvDN3vrQJExu94P8
 3+E9t0HnEpu3NPn+LbmmbWV6z+69Z7Q+NF27pFpy3tGcnDusgA4lbXIR7bOokgEz5SW0
 r8Pg==
X-Gm-Message-State: AOJu0YxyRwjeYK/YFZmqYaqb6/24JCOlBW+cbW5YqOHT/54hWO1CF0vv
 85SqwSddyoHvGthaWCyCk4MpLNcmQlyEXtCD1fWHEwBjiHr6Jj+NoNVeTZd0uOA1N21cFN4RwqY
 eYhX0aphgXviXLgenQdKVklgRO80SclUt38hnTCq9VkUp6cRGPTB+RJaS
X-Gm-Gg: AZuq6aJxiyoTDzKlDyHnFYNWe4MjPfauhrZ5wOs2w9uw6YNx1wKe7Af0K1WfSUYWQ/9
 5WO0P5O8urO3GDsRtLEVailhBKItUcvmkiec5G1qoqBMmhA1eykWFGM2N3npgsVbTDSgyenPWWN
 xRMqF8k/yiDFEyHnY8dA7bwf679510cZIxVI/huhHp0envZtF0j+AN8bky97zzLGrQQUFbJXdw/
 ydXPa0+iwwzHoZmsNbNzdGkH5qsfciiqgnf72/lvns0Jo24TWLHuOHB7OMzP6ygly+Wzyi/KzAB
 MXz6sbEXFPPAv9+lZG6EDhgHaqEiTSNWe3vGatlgr2q4tfuS1EyvkJ+1s5c76c+Kx+h+aHw3VpD
 5S2Iu8doocsD/XgJiKPMrmOI1cm9wA3fLi9wXvniKZ9iTik5f4zjA7XrJCgJD+QC8P5AaS22rPz
 VeYLM1
X-Received: by 2002:a05:600c:5295:b0:483:9139:4c29 with SMTP id
 5b1f17b1804b1-48398a48450mr31689685e9.2.1771421215725; 
 Wed, 18 Feb 2026 05:26:55 -0800 (PST)
X-Received: by 2002:a05:600c:5295:b0:483:9139:4c29 with SMTP id
 5b1f17b1804b1-48398a48450mr31689335e9.2.1771421215201; 
 Wed, 18 Feb 2026 05:26:55 -0800 (PST)
Received: from localhost
 (p200300cfd737d029edef7b8da7441ac2.dip0.t-ipconnect.de.
 [2003:cf:d737:d029:edef:7b8d:a744:1ac2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d482480sm624827305e9.0.2026.02.18.05.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 05:26:54 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v4 05/24] fuse: Change setup_... to mount_fuse_export()
Date: Wed, 18 Feb 2026 14:26:14 +0100
Message-ID: <20260218132633.29748-6-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218132633.29748-1-hreitz@redhat.com>
References: <20260218132633.29748-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


