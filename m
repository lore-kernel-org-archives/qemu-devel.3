Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA01CF41808
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcEh-0000qw-Cw; Mon, 09 Mar 2026 11:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcEf-0000pk-H4
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcEd-0008MM-Jw
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773068971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=muqu2YymWMHLeGtaHW7SS1VV742IfcBS+uS47ikVE8o=;
 b=EwRKwkotEfmgv2X2UuWNe1SPBx9dmQX6TpqOpOLAg/ZjFowi1SGuByhXQS+bU+VC5AbJU2
 m7NLib9gOJTyYlIQRbawxoGLyYKcP8UNzZqGYSFXvFG3lzjRpP8TNlmqyUgQO4NDEUsGGB
 knPNAfJ688ToftvKmkTANjhYzipN70E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-5QBF8yHlNoCSF5dToU7oBg-1; Mon, 09 Mar 2026 11:09:29 -0400
X-MC-Unique: 5QBF8yHlNoCSF5dToU7oBg-1
X-Mimecast-MFC-AGG-ID: 5QBF8yHlNoCSF5dToU7oBg_1773068968
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4853f33b7dbso5964955e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773068968; x=1773673768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=muqu2YymWMHLeGtaHW7SS1VV742IfcBS+uS47ikVE8o=;
 b=JIQCkWaXzmhpf/vM3CccmGzbg8IZRJ8xkSz1KBfJGdZp6rBMyYnkTxuii2LBbubudA
 dJdOxLWZRRCoZqDjZH5H1B5foarKdIJQoYZm1qZyH570ql0TEr7ERK1QZUu+tV40bfdt
 QOOeeIrOSjJOJSVWl0tR9bRKx/gjJQSlWXAkgEvaTucRE9nCSckqkiYpFcmVxH3mCESr
 +ntN0DJ2129Wd6esb6Z/ONDBjQz7HEj5wDJmEV3h9kqeEi/kW8MwGUNP1aK6sxcgQlas
 JIkma26LQpGwjrvMQIdZhfy2pe/YTM1NzM/b5DlqZnULIwklAsXNy0moyCc0d3KT3TEJ
 wQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773068968; x=1773673768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=muqu2YymWMHLeGtaHW7SS1VV742IfcBS+uS47ikVE8o=;
 b=TfUnV2YoIwTRnjIvsdQaA0S9NM6vAF4QCrd8OnrXVDo/qKJN8MeAEiscNNt8XypSHm
 sPChW2v+2idn+nyfgvKNczcktxrwNHu9yMWmxAzivTOoF87DGEfVVJD92msOTaagP3D0
 +x1attz8qzSWV0QzHQkpjq1yH+nCbD4EhcpqTo50cMUKwjngurWO8CddhSX7H5J02cId
 qhv5qc3aAiaq0Mc8+hD56IXL8wnH7V5az8PP+hVzi3HiOq+h4Utz3CwzEoz/fMd0VNEa
 AsZh3jvF9/gePpBblui/ri30yVtq+OrtVTypx9gg+Pt8CoAxl/3D5yTqKT1KqnjbhKvI
 9dUA==
X-Gm-Message-State: AOJu0YxJXv+hA4LcOfqI89OPItmaqkwJ/iIVMkyh9c+Evv3ASe59CbHy
 Qlj8hZPpytrifDUIy0BgGCPrXhftdAVuQTn2O5SR9977ZMVOOGX2MIYcYoAUEONrdLtNBPJkMua
 qfpPLgK2B2NcClqWuf6tP6HI/ObBlgEVqp1Q+UfWEbNX4G2V9Kq2gA+Z1
X-Gm-Gg: ATEYQzyV76Ouf2NCVDd0P7VD2f0D+Hx8Psu2rTMitZkcFTF3mDb5u1EGh7Ff8tQgIMw
 iKN9wMOuQLT9rq4YEKbcJI4MNqhOIfprLVIUMFCfNhrT7NJsVT8imwmCrMYdXk6FAENT0SU1jK6
 5jnx6bcePmskJQTRnCdrLKoCWMbW3XcX/q/Vk5k1vRz48BxOhDTZCNlmC5gnlbI4MPm0V8R2Nzn
 XObpkhD+Nvv7IC+tCMa2u2nFUfuMz13MPg2/YYcTdDPYbxqKdh6T/DHxUsBDMha/K3V8STUH6S2
 4VYa1/kAbjcLco5cr3WrJn/fYgdstz+GlxXplLG34OWiaq94OvnCJKhDedgDDX0Y8yFOFGHkQlU
 PWAT3T05W2lwtcoKQFkTsyh7rgL0Vz87ANHPYUhpCPzgMbkdUILHxOU4S40DbouCqXAH096yv8C
 2MT0Qq
X-Received: by 2002:a05:600c:1d0b:b0:485:4136:99a8 with SMTP id
 5b1f17b1804b1-48541369c0cmr8706585e9.22.1773068968106; 
 Mon, 09 Mar 2026 08:09:28 -0700 (PDT)
X-Received: by 2002:a05:600c:1d0b:b0:485:4136:99a8 with SMTP id
 5b1f17b1804b1-48541369c0cmr8705915e9.22.1773068967670; 
 Mon, 09 Mar 2026 08:09:27 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0cf29d515fbd6051d53.dip0.t-ipconnect.de.
 [2003:cf:d737:d0cf:29d5:15fb:d605:1d53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fae00absm345991855e9.4.2026.03.09.08.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:09:26 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v5 09/25] fuse: Introduce fuse_{at,de}tach_handlers()
Date: Mon,  9 Mar 2026 16:08:40 +0100
Message-ID: <20260309150856.26800-10-hreitz@redhat.com>
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


