Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B616AC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 11:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWZQI-0005Fo-Q4; Tue, 01 Jul 2025 07:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQB-0005BZ-Hl
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQ8-0003H3-K0
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751370302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VhSz5JkY5LLfO9JP0DfYyzUrOP4ozA4C0+gHoyFHmps=;
 b=Vqc7y5O3z3gtT5lE44aKUPdf0C5xp/oe+o2e7aFxJI++EPdlBa3hM34+tU46AmaFJwO17p
 EFGuvbxVpQYjMiHaVKkiMA5Pizi1PthaLgGRa49dbQP++uBKC4ZzGMsJZPhQFMXWZtgW9j
 PeFHI0xngFA5kCxVY9hSZunZvLx9UkQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-uzNVJGa2PEWTrAYqB2Jc7g-1; Tue, 01 Jul 2025 07:45:01 -0400
X-MC-Unique: uzNVJGa2PEWTrAYqB2Jc7g-1
X-Mimecast-MFC-AGG-ID: uzNVJGa2PEWTrAYqB2Jc7g_1751370300
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a3696a0d3aso1464747f8f.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 04:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751370299; x=1751975099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VhSz5JkY5LLfO9JP0DfYyzUrOP4ozA4C0+gHoyFHmps=;
 b=DSufQhPMfBKFE6GXdzQ+NwQy/1GHQa7uuAXilEzyj7kKZk5U8u+yxH8l0x/X7saOin
 E6mYVOEx2Bqbyv3Co3/njlybH/F8pN5GhCM/MYfFg7xqOn029YNx7jYMu5kloS5AUSpO
 9uDygcMIrrQRluSj/HIo/4Uh/uTOPpg/thAhujKmj7XkFrmQf17W2J2QUUDfXeDcG2oB
 aEJfTfKn7dI8mZPPe4RvHYZke6olq4G3s2rME7sQezHjY47AmJKA6tQWj/3zN8l18OPP
 EinkAVReeMcx+WPwMPvJ7UqfN9eD8Zb1s5Gj8thRYMRvmG/L2i+6DuwWkh9gyLWzAsg7
 NRbg==
X-Gm-Message-State: AOJu0YzZHhiLH4Kv2RMKfyu7Ec25iYVu2JlCnfx6i/tLn3uwR+n8rZTa
 M0LIt2IUmTZpi5KjcXb5jMSe5r5gTVTuH222yqhLkmgXN4ei8srQzoTqKdC9MUrtKCQE2ArKPao
 V9EmgcZ9nJ/7lLDQFRjf8ZAScxgTRGQKkkhSfpeH22/dUYGs1GizgyZQp
X-Gm-Gg: ASbGncsNnRCx9yDReAPUi/K1jQAI6XD8BTvyhb5dwCCooUmt5HW8SCCigb8RzA71VVd
 AgHZPsqoI9CrFRAQbxtAdss2buMXmGxZu2YB8c7h3uKN1Votx1uc/ElFR+OjjPGcwAh5LQsX6mh
 VMMlFH8uyTVBE1Q9Mnt7QsQSFnmAK9JJunx+CdMVWXXPhynx2UWabjnP22YfNeF+XG2R26oTg2y
 49pbWNOAfkX384u9SQzAWeObjhxinh2HvqyAmKrtdIAiVvwN3kqPe9fo9/isfouQLcioWYfzHfz
 MdJ3pVVsm1+pbeiBMkiSW0uNzdPseG8ois3NOuLEbBTBZijA+wF6kJKuDzWysdwVvFhgUEGzlpV
 a8iD+
X-Received: by 2002:a05:6000:2b09:b0:3a5:2cb5:642f with SMTP id
 ffacd0b85a97d-3a8fe5b1d4dmr8934138f8f.34.1751370299357; 
 Tue, 01 Jul 2025 04:44:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSum46C+sIOIctlh83vD/7gJP3Uw8Y5RQY+cY8sucAuXy+g5PqLHUlhMDYGnEjEVVgSLjtwg==
X-Received: by 2002:a05:6000:2b09:b0:3a5:2cb5:642f with SMTP id
 ffacd0b85a97d-3a8fe5b1d4dmr8934123f8f.34.1751370298879; 
 Tue, 01 Jul 2025 04:44:58 -0700 (PDT)
Received: from localhost
 (p200300cfd700f38d3df6a1ca7d40fe1f.dip0.t-ipconnect.de.
 [2003:cf:d700:f38d:3df6:a1ca:7d40:fe1f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5963csm13041023f8f.79.2025.07.01.04.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 04:44:57 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v3 05/21] fuse: Change setup_... to mount_fuse_export()
Date: Tue,  1 Jul 2025 13:44:21 +0200
Message-ID: <20250701114437.207419-6-hreitz@redhat.com>
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
index 60d68d8fdd..01a5716bdd 100644
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
2.49.0


