Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8613C5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 13:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMoBc-0007wU-LQ; Wed, 04 Jun 2025 09:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoAr-0007A3-Er
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:29:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoAp-0004lc-UU
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749043735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/2MYp3UhabT2qS0mTPTCo+T0B/SM6NTgMC1jdFmgg9Q=;
 b=FkOLMGQZt1EmPFUE5DlpxZtfXKCoy7CwHfGSvTagSDllnM9NNVKqeI7CbvbTp9IUuJm+nQ
 ZaUR5r/ryPSmEt4sAES7rAGAnBUtbgGElTc/ZDyiDJBB/m6k3AYvQwbJyCJ5jNJLwcxEF5
 MWveq787DyXd9zIfQjkHtk8uO8SJoJ8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-LED5fRMyMX-VtLABjQLVjg-1; Wed, 04 Jun 2025 09:28:54 -0400
X-MC-Unique: LED5fRMyMX-VtLABjQLVjg-1
X-Mimecast-MFC-AGG-ID: LED5fRMyMX-VtLABjQLVjg_1749043733
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450db029f2aso25052365e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 06:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749043733; x=1749648533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/2MYp3UhabT2qS0mTPTCo+T0B/SM6NTgMC1jdFmgg9Q=;
 b=ONvLq0jv3D9KgUsSaZyCcgfofDCHArnIh9lvv051eZGRYZX2rIHDW5qsRa31jVZ8kE
 /Sho6GJhGpSUSBBvh++w39hMKJWZ5jGGL/IiXe8UPkYZG3GPN+ILaSPN5SGbdAMuPLN6
 0J6FncRi1uB8MbQCc7LdvHUg5CjwhmS1DK1CoeeRseOwU3fYPReMJi2wP6ldToNyNQhd
 ohlBkEs/fyceHh0cU94Q2F3d3/qWC6P405dEL89QuQCevJ86iDjCpyIYxot3uaUIS8fq
 ebY68eWtoWCm8QWfC8IJGb+xQC40XS2VYtzJ3NciTTs7MEUnC9BxyKW3z6ir5bVvDa5h
 4aAQ==
X-Gm-Message-State: AOJu0Yyl6fKlsfy1BVs1B/ijCSDeJjIF7NYiMwosHHmYGVlku9m+VENm
 zMWth3NuFsaTo/MbB6VTYVFZywAs4VSBtwF/vYbQqQAQpLOp3nXE74iW6AO1YjQ4Mp2VwDDNA3q
 4WjjHSwmoHbbesd5EoRlFmdHSzrTnbPllBtpbTJGP33oOhMV+BhjDDy6A
X-Gm-Gg: ASbGncvV8FNwQOXNaNt9RJZNB4Ma2FAW8IXoOMpGcPIOujlYQJo7fusH7XdkEi/XNW8
 vKNt/u3CyR9fYMEUKSQIWYyoi2ALZje53hlmqxz+QXx8rdFdNms1yvbSQvK/kyzFsUiyCJFhTI8
 hw+n3R9T+jV5K8/iooXXfB+Zxutx5WbYO1fmdOSB+8vO/i1g75+Go3eu71C5APsltd29+0Z6zXk
 t9zkgNk7Ig3sKbqUtcknhieT/Ci4UXy2Xz/V0KE39C5+yKluHHM7jBsYpf6IUa0vv0DDeITjBuV
 YWu8fpEXE5Wu3qEo+Bmfs4mtqeqdKsnCjIaYQ92waMWMBU0RyetGrJfH73wRVUX3pVa8XJSCdbD
 nv9jx
X-Received: by 2002:a05:600c:1c29:b0:43d:fa5d:9315 with SMTP id
 5b1f17b1804b1-451f0b3f724mr23329315e9.33.1749043732881; 
 Wed, 04 Jun 2025 06:28:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnts/kD0D1GKuZC6Ir2ybxZQVv6nwJiBUsmCm2gsaCcdaMb12ux+CfUepqnITMg22G6hjJng==
X-Received: by 2002:a05:600c:1c29:b0:43d:fa5d:9315 with SMTP id
 5b1f17b1804b1-451f0b3f724mr23329045e9.33.1749043732503; 
 Wed, 04 Jun 2025 06:28:52 -0700 (PDT)
Received: from localhost
 (p200300cfd700f306503d3c798c1bf214.dip0.t-ipconnect.de.
 [2003:cf:d700:f306:503d:3c79:8c1b:f214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8000e3esm199129705e9.22.2025.06.04.06.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 06:28:49 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v2 09/21] fuse: Introduce fuse_{inc,dec}_in_flight()
Date: Wed,  4 Jun 2025 15:28:01 +0200
Message-ID: <20250604132813.359438-10-hreitz@redhat.com>
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

This is how vduse-blk.c does it, and it does seem better to have
dedicated functions for it.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 15ec7a5c05..bcbeaf92f4 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -78,6 +78,25 @@ static void read_from_fuse_export(void *opaque);
 static bool is_regular_file(const char *path, Error **errp);
 
 
+static void fuse_inc_in_flight(FuseExport *exp)
+{
+    if (qatomic_fetch_inc(&exp->in_flight) == 0) {
+        /* Prevent export from being deleted */
+        blk_exp_ref(&exp->common);
+    }
+}
+
+static void fuse_dec_in_flight(FuseExport *exp)
+{
+    if (qatomic_fetch_dec(&exp->in_flight) == 1) {
+        /* Wake AIO_WAIT_WHILE() */
+        aio_wait_kick();
+
+        /* Now the export can be deleted */
+        blk_exp_unref(&exp->common);
+    }
+}
+
 static void fuse_attach_handlers(FuseExport *exp)
 {
     aio_set_fd_handler(exp->common.ctx,
@@ -297,9 +316,7 @@ static void read_from_fuse_export(void *opaque)
     FuseExport *exp = opaque;
     int ret;
 
-    blk_exp_ref(&exp->common);
-
-    qatomic_inc(&exp->in_flight);
+    fuse_inc_in_flight(exp);
 
     do {
         ret = fuse_session_receive_buf(exp->fuse_session, &exp->fuse_buf);
@@ -317,11 +334,7 @@ static void read_from_fuse_export(void *opaque)
     fuse_session_process_buf(exp->fuse_session, &exp->fuse_buf);
 
 out:
-    if (qatomic_fetch_dec(&exp->in_flight) == 1) {
-        aio_wait_kick(); /* wake AIO_WAIT_WHILE() */
-    }
-
-    blk_exp_unref(&exp->common);
+    fuse_dec_in_flight(exp);
 }
 
 static void fuse_export_shutdown(BlockExport *blk_exp)
-- 
2.49.0


