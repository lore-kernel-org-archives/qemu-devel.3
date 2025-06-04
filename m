Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E052C5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 13:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMoBD-0007RR-7y; Wed, 04 Jun 2025 09:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoAp-00079i-EO
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:29:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoAn-0004lJ-Qy
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749043733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iBWE4FPpwD87XkHHPVGSv5gJzue+dVBIat7kcbz/nkQ=;
 b=bJnAimTKHaBh4YVrDbxGteIEtMtsT4a/cJn3exq9gRQIC7BMZq7M9fEP4GGhVA7bN/JYvE
 JC2HVB/9YLRLfHlVp56J6eDZ0on6xIraLoqdteogbOT45FOS39gJzORY279o4QeNXLVSJ/
 omXvKquPRucGZhytDJFq8hsaehFp248=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-WpD7TICdNIWKFcIqaTsA6A-1; Wed, 04 Jun 2025 09:28:50 -0400
X-MC-Unique: WpD7TICdNIWKFcIqaTsA6A-1
X-Mimecast-MFC-AGG-ID: WpD7TICdNIWKFcIqaTsA6A_1749043729
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-450d244bfabso50953555e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 06:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749043729; x=1749648529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iBWE4FPpwD87XkHHPVGSv5gJzue+dVBIat7kcbz/nkQ=;
 b=BX3AWyo53z78Y7hT4f8ubQFQzioi2SW61T7YFi2mYQUvGfpJTAUu3D90el2BAqJ4YJ
 o325IykNHTwV8PkC8TT57CGuEUpp3i9BJNtSgMazGHYjOyl78w+5AqK7MkoWoG81J9ur
 /cTvrV1XgYzyrIeZc8vmmoup4TBnLHeWrXzFPANmfP6fh1h1e0bgiatPomx44/qHdimU
 QA47VqkSPxhFKytoJgOkcFlYuynK81PcSObB2QKHUqPQ0URo3pjT3bUw4JZPnlA12IaJ
 Hr86mEJd0NTYrSgDUK4ZtLmUcKXJIPqbHEcn+zHYlP1UTOTe6AxGiZ8hhcwZCx8TGPu1
 xbsQ==
X-Gm-Message-State: AOJu0YwZ+4/F3uWhMXigI9eCQXsU0PSZ8rEDKhIpDTOXChk4pEp6qkdu
 fJkg73vosdKaPFv9hGkLKm2AswQhfNrOBpJP/P0HguygdeGBt7KGzmV0wAyRFKcEMiwdtoWLCm9
 0OFeFMspzT6yfGPRBlKvHQPH7+UtHIDAfu245ZcMbJyCMRhCV2uxFyKJN
X-Gm-Gg: ASbGncu4PcI05PRb0Ewjh4i0rWZSxNMJIhy4w3le67O+RsNHSOncpTpX1ts6WrKIf8r
 ljyf54iynjX5bYskcah0s74se3rL86ZE6aGcErOsGr3guZiKeJXtCegepqkOe65uBYLEqEKOknq
 NhJr/QvIBGiKxfADE0HclX33HpEZmQJRoS7wGY7KcdVmKGXdc9eceQ8cLkoMEtYJpt8Mnbb/sUk
 XaGNbU9maV97P8GplaPmBW6acQkp7/KAcB9h+dQpBZsuWAabgXCxW1RelKXo2SqiQv1bzJ56tCj
 /xtXFg13c4mgcpQzjOl/IMAC0/Te9liw/lYe4hKKLxSZAuFv87tX6dJnYjjT2YNmVPDFonWbqKU
 rj6Zt
X-Received: by 2002:a05:600c:1e08:b0:441:d438:505c with SMTP id
 5b1f17b1804b1-451f0b54b6fmr25681655e9.32.1749043729421; 
 Wed, 04 Jun 2025 06:28:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjCziu0bTeb/MJ2hGI7TDTIwhbWKGcXichG7/GmKzc8U0sNYvy2KiZ+ROw3vMJZjRpIn4MZw==
X-Received: by 2002:a05:600c:1e08:b0:441:d438:505c with SMTP id
 5b1f17b1804b1-451f0b54b6fmr25681415e9.32.1749043728983; 
 Wed, 04 Jun 2025 06:28:48 -0700 (PDT)
Received: from localhost
 (p200300cfd700f306503d3c798c1bf214.dip0.t-ipconnect.de.
 [2003:cf:d700:f306:503d:3c79:8c1b:f214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fa2541sm195657605e9.15.2025.06.04.06.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 06:28:47 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v2 08/21] fuse: Introduce fuse_{at,de}tach_handlers()
Date: Wed,  4 Jun 2025 15:28:00 +0200
Message-ID: <20250604132813.359438-9-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604132813.359438-1-hreitz@redhat.com>
References: <20250604132813.359438-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


