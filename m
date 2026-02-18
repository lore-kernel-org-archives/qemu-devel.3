Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF03BE9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 13:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vshfW-00040A-SS; Wed, 18 Feb 2026 08:32:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfQ-0003xa-9z
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfA-0005J8-Gs
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771421532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=muqu2YymWMHLeGtaHW7SS1VV742IfcBS+uS47ikVE8o=;
 b=e02Y8LjI2RxtKD85DIy+v56MLqQ4+ZnO7q7U0OxnB3kqUYzxe7kSO7DEPk9qi0Ygqgn3Vo
 xxd4SPQ4BYkwnoO7I3o4MAYhwD0MxXeYoqq/Rb07GqYIRRcfklZYQcHcW5fmcLpH0nYAAr
 MNltzX8cEA1FQ1ckUuAQtjziAFp3jEw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-BybK5eeIODuikDuU6cejDw-1; Wed, 18 Feb 2026 08:27:08 -0500
X-MC-Unique: BybK5eeIODuikDuU6cejDw-1
X-Mimecast-MFC-AGG-ID: BybK5eeIODuikDuU6cejDw_1771421227
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836bf1a920so61261805e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 05:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771421226; x=1772026026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=muqu2YymWMHLeGtaHW7SS1VV742IfcBS+uS47ikVE8o=;
 b=Z3nfce7LEJ3MDE7lLXvSOEmOAxIE8Kp0vC6j2SLx+iTSG5onfaI2YijdKMHvYfMBjI
 lPF2Iw0vfaDO5T/9Bh+yD4kdOGpkKthIjKT5l5hk67inTFtE2rRo6OIC44CcR9+wqWso
 qfCk7VrROKcFALYc2D/ZVRktsYltA3Q5TlzDuxrUOoT3HxyrE2DoEOgX1r7P3vmoL6g1
 3hLIL+MpGyWqNt1d2XBJgJR9SOseoTfU4sxn4rZs8C6XfXjSeN//kFblw7MXTlDSJ+IL
 HVEUjmt99VdZiVgPgfXMN0CTLbrOlu4ZDg3Oe2etMLjaXu3G50PBFCSZykt3ZxZExDHN
 uZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771421226; x=1772026026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=muqu2YymWMHLeGtaHW7SS1VV742IfcBS+uS47ikVE8o=;
 b=TW+VAMgbdQg78oskHUDodt8gngfCmerl0id+XBqMOtFWovNWMq6GWuMa9NgcazCB2E
 gq0A65RmwkXkcxWt1TijJb6VuGSuRxSIBXYyiTwdNjSbr5UAJbdDiDk0LhNOzORdPfrl
 ol71kxlq8JbVxZULNWxsqOkUZzJUeXCbikpHFGqm3dMK547CBlm3wx0EuJnV6s4HMnRH
 5ClB/bhkPTVtDbXJzGqAfzfSMWgJMyjUhzwOY91XDCEgKtekIpU5ZiBisol73bSP72wX
 iVGRPGJ4xP0NXDJXVFhq355CLY8OU4jc6Rxsl8g83+t2RCRgPHW+uaqmpJJSm6J3PqbP
 iOKQ==
X-Gm-Message-State: AOJu0YyJL+s9GDpmim/NNihMw0G2X+du626k7WCjx2HezsElBmXigMFQ
 UikAD+yOgOKn/ttsL32qfNiHWjIxGm/xK+5M8/T1qSbfA3j/bKxXVIZLaeI45Q+kb1h8XJ5SCG9
 WUJ+nFkS0EXmm5AESUQ8thi+T74y0iGMHY9nxBJjMuvbN5BElWxqj5R7A2CAHdF+k
X-Gm-Gg: AZuq6aLMe43z4SBU9OA5L7a2uDA2vfxHWYQRcRLLotfJzXGhJsHO0UkuTIwFI9DKA4g
 o/yqfzSHeyWlYnIlrLKFq39G1JUHDeXIAqRPw6E39r30kGoj2iMbDCW3iJ4HgBPqJCWus12qOhd
 kWRf+BPAXJQwla7riFGgw12DBZVkC465PlFHMHcpYLmzpzPMtgKkknPCcUOiBSsCH/3qE617cIN
 vemcEJcgQIa9VP27XOgNXkw7AFpgmVSd/ZjNchASiWcZ007omlRANBdUfTQZUo2r1VxaaTc3WQ2
 SFw4ihybjkUYZJhviwHYKa8/bhOVkORGsFm1cU53HZy7fN2FTZqmayb3WaJwi3kVH/n8sH4Qtfo
 mNsfYGWrdFKCecZyKeN2rGMAsZ1yW1bT7PYRJFABvVmFLn3yPAP+rjbHWajMQkuDeKslmM4bktW
 uH6wJf
X-Received: by 2002:a05:600c:4744:b0:482:f564:d613 with SMTP id
 5b1f17b1804b1-48379ba8f46mr247682125e9.15.1771421226446; 
 Wed, 18 Feb 2026 05:27:06 -0800 (PST)
X-Received: by 2002:a05:600c:4744:b0:482:f564:d613 with SMTP id
 5b1f17b1804b1-48379ba8f46mr247681715e9.15.1771421226021; 
 Wed, 18 Feb 2026 05:27:06 -0800 (PST)
Received: from localhost
 (p200300cfd737d029edef7b8da7441ac2.dip0.t-ipconnect.de.
 [2003:cf:d737:d029:edef:7b8d:a744:1ac2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4839839d960sm29902525e9.3.2026.02.18.05.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 05:27:04 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v4 09/24] fuse: Introduce fuse_{at,de}tach_handlers()
Date: Wed, 18 Feb 2026 14:26:18 +0100
Message-ID: <20260218132633.29748-10-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218132633.29748-1-hreitz@redhat.com>
References: <20260218132633.29748-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Pull setting up and tearing down the AIO context handlers into two
dedicated functions.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index d0e3c6bf61..5953407f20 100644
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
@@ -335,10 +338,7 @@ static void fuse_export_shutdown(BlockExport *blk_exp)
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
2.53.0


