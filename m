Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36652C3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 16:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx6pV-0005no-K4; Tue, 25 Mar 2025 12:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tx6oN-0004X2-C5
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 12:07:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tx6oH-0007RS-Kb
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 12:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742918844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eTb0IClszg1ZXtQsdOfv/iJZx5LC/obmIaW+5tk5J0E=;
 b=R6Ui93I0ztI/6iXuM6lucs0A02ZwZN0iq70NSm2cZty6a6+qEpqcfjQMp0+O4gkkGw3lvJ
 JfDO9GFJndV4cJXqjp2xuKfMEL/2whu7mFywBUWm4asjPX+Bwg7FrG95V9etPigknRsxwI
 OIL2B6HtoidyygLL45lU8hKv+GSYzu4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-eTdPcjjjM0WJxc5I1-NRCg-1; Tue, 25 Mar 2025 12:07:21 -0400
X-MC-Unique: eTdPcjjjM0WJxc5I1-NRCg-1
X-Mimecast-MFC-AGG-ID: eTdPcjjjM0WJxc5I1-NRCg_1742918840
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cf44b66f7so41134895e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 09:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742918840; x=1743523640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eTb0IClszg1ZXtQsdOfv/iJZx5LC/obmIaW+5tk5J0E=;
 b=byiqWSnZ31Esjy6xDN5VDvKnNvFBIVYEr/jZDkY5VTD6ATwhBkQtp/rCLeTiVPaU2w
 mR80WgN+ReIjfF06kUU15wo1VLAl5+xfmDb/uJ9W4iOdC23oON/jeQO2GqHyMcBkZ3Y3
 xRHTh/ZATqgjzzm4DjUJsolLdMDCC1rqx/y78ve0gF9VwT3V/K9InXiY+cNHHkmI3Cbv
 GiGIrcsr0SYX0t1xRt1LXpNogL0B6rJ6NGQ7oaORabZCRjJKVlgzQd8FhYOO41u09wCb
 UxwSvz+5wIlcr0jUXc6JiZnBFKfhqZ4uZ0oCyXk6HqMCrJZeuZKb+Sod9HKn/AESIpAy
 zzbg==
X-Gm-Message-State: AOJu0YyyGmefokxEIwoaNau/m0kMo9/cefjpZSe9OO30tht716h/Iu0a
 kni4aJv99hAAc01jzMR2e0BK9aMu3OAi754IWs48eIIib2FmWZgWcf88yhTp05UAVhdxAFDs4xu
 op0f6doV6r/mAMNXjjJ/JbXMxbcOXxFxwchx2qQMjqdW0Ao3C86hC
X-Gm-Gg: ASbGncteL6D9r+YcljNSiLGN+MWTcKldcIErdG7WPW3beUYAfY1BZMeuvk1TlyPQEY4
 SbRc//K6nnWWkgORbm+7GoLUhO2hV3vou3mJcIfzWVHlrZiykleeSwt5/Hr33NTkSL5Em9GqIrl
 nCy/C7qKYBd+PEBYfjBfOuksAFXGwfhDZJfSTO02kHwYRXs97JTCgUOVBJGQtNmADirk2f3CNmS
 tyA6CVDa+sxkHjHi/lUS7JSdquJCjeudpz6B0ie1WpmjdZ5SZMh4JDeFplsPYLu3ZstsDRqQej6
 t1CBkWiVJoTncaOtctzobP3AM4sqF6W6nZv77OMre3/EDrvaa0OVwpdQGcfO7UsLdy0ghfrnTQ=
 =
X-Received: by 2002:a5d:64af:0:b0:38f:3e39:20ae with SMTP id
 ffacd0b85a97d-3997f92dbd3mr17016508f8f.43.1742918839938; 
 Tue, 25 Mar 2025 09:07:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHANclsPL2CceE+DE+AM3Qu+t4mRm34pTVahJ91iUH7g4cB8v3lzoZWphWlfzFLkzgX5jlICg==
X-Received: by 2002:a5d:64af:0:b0:38f:3e39:20ae with SMTP id
 ffacd0b85a97d-3997f92dbd3mr17016462f8f.43.1742918839477; 
 Tue, 25 Mar 2025 09:07:19 -0700 (PDT)
Received: from localhost
 (p200300cfd74f9db6ee8035b86ef736e5.dip0.t-ipconnect.de.
 [2003:cf:d74f:9db6:ee80:35b8:6ef7:36e5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9a6326sm13775029f8f.29.2025.03.25.09.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 09:07:17 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 08/15] fuse: Introduce fuse_{at,de}tach_handlers()
Date: Tue, 25 Mar 2025 17:06:48 +0100
Message-ID: <20250325160655.119407-7-hreitz@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 2df6297d61..bd98809d71 100644
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
2.48.1


