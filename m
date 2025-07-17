Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BA1C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 00:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucCiW-0007EH-8V; Wed, 16 Jul 2025 20:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCfz-0003zD-TE
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:40:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCfv-00052r-TS
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752712835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GyQ4VuTjfYDD78RlZ2vxmZgEQq/o05r7kRTnJkWk0Mw=;
 b=g+EXpwonZqwmrhh10BLJmVgSEQfdInmsYRfoJd7Q2lYAZkpmVxnjNqd93EAVUn0KLUV/z6
 Z0cKs1VBUqGvt9QuXr+nJwMs2UBDJRw+0xuJfEvAcWW1dimhKJitZCgyje8whwwaanjbeL
 lBT8s7oqt/sLYjNLZUpECaupz+DeFgc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-OiGzX_7WNVqDJ_q06U_mVQ-1; Wed, 16 Jul 2025 20:40:32 -0400
X-MC-Unique: OiGzX_7WNVqDJ_q06U_mVQ-1
X-Mimecast-MFC-AGG-ID: OiGzX_7WNVqDJ_q06U_mVQ_1752712831
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b31ca4b6a8eso260513a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 17:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752712831; x=1753317631;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GyQ4VuTjfYDD78RlZ2vxmZgEQq/o05r7kRTnJkWk0Mw=;
 b=CWI7HtuKlBcMdr8PgX6bWbmDCerBDU8sYQhofkwIjf2/JGTvOeZhowEa7zIDZdMr4f
 DNa5x9CX7P4nKcU3LKwS8QaQNXKn9ry9M+folR1uTQeqOOqSD8jAB4Ld+gnfIzQRWyDx
 1Yw/yD/Y5S0t543v8M+AFYUPGRwf7RWbioF7Q0gNSYDbQ+iwh4l+k5Nu1ZFa/RL0GOCR
 q3ifyouFmdp4EOa/BXTuE1a2Z7Hd3tX99qkqojq9ly1Rv7I6IWtzEY2tFPKbQBi3E0WP
 KNBbqrbt92BtunENw6m+a7yTmkA6ObKSH0YH41dptR3gFjv63bRAjuIh8YkKi6NVBaMq
 ildg==
X-Gm-Message-State: AOJu0Yzj0nLf5Ts7L26643FfJi26MaeXtzOPz3L9qQamA8pVMjpuwEeF
 IeHdWFySdcK8SBsjGnLOJecKZc92ACSmuCoFyFSn9S41UXNkJx3F2D484vXENtTA1sy7WcDbZnk
 ta4VgFvEacs+YvrOe7CbDztj3EfusqMXXKHMXxzFXk2PtjMXiMU8RmyU7
X-Gm-Gg: ASbGncs5XwIKvy65pfTPWClVFoqZrIM33F2zfQ5JqAJpqR3klIzMt2Ib3OJrqAEbUyy
 GAcN/HAyQsa9NDgWbmGXFNdXnypTnxNcJ06JW0wCJhJ1DdTuEn/2WKmd/HEo785auZdIHQH3xKJ
 qg4eeZBFKqz6SKbBGJRKZeRTsyhEyjcVXmDawuc3q/zEjfLLE+V9H5l6KDTVAmvfStkb7yzG2rG
 uwZxWUtLoSOcXldNIyTorBUq0kaQzax2WMI7z9nfRhPnwzUv5Aq8z8mU3q7pzuRZ3sSqATNOR3M
 9su0HKApNLvU8f0XCf4cRCuQDOhQbUNimfQB4yuGwRIhiz2ocVI1
X-Received: by 2002:a17:90b:5486:b0:313:2206:adf1 with SMTP id
 98e67ed59e1d1-31c9e6e3eb2mr7413303a91.4.1752712831253; 
 Wed, 16 Jul 2025 17:40:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgmX7kEBO+jbmRPWuOQw60VqvT3yOfYDv03xTpakt3A+e2DZQJdWmAjVZuP0FE7DtzAhbr7g==
X-Received: by 2002:a17:90b:5486:b0:313:2206:adf1 with SMTP id
 98e67ed59e1d1-31c9e6e3eb2mr7413263a91.4.1752712830804; 
 Wed, 16 Jul 2025 17:40:30 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9f287c19sm2214424a91.31.2025.07.16.17.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 17:40:30 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 17 Jul 2025 06:07:33 +0530
Subject: [PATCH v5 10/23] migration: push Error **errp into
 loadvm_postcopy_handle_advise()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-propagate_tpm_error-v5-10-1f406f88ee65@redhat.com>
References: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
In-Reply-To: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4654; i=armenon@redhat.com;
 h=from:subject:message-id; bh=qrmu0lMtuRfeJPWloZhTnUKABLhMfftFJRQYoRoQ/tM=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0aFmwL/wiLr94UW/Vu3nri9/uYKhpSnwZ4mLVpmTIpta
 7Z1OBR0lLIwiHExyIopsjR8DZBtCiiMiLR9eR1mDisTyBAGLk4BmMhVIUaGN7edWvP4N221XpPd
 7nLN9LjHw/efHFM+3nh01zPup65BNcNfGVsj20Nfevk9EsNm3cpKuKRhIrb207W9B3vm6swo+rW
 XFQA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that loadvm_postcopy_handle_advise() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 8eba151a693b7f2dc58853292c92024288eae81e..608560af35dc76813bf6e9b571df3bd343f0eeab 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1906,39 +1906,39 @@ enum LoadVMExitCodes {
  * quickly.
  */
 static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
-                                         uint16_t len)
+                                         uint16_t len, Error **errp)
 {
     PostcopyState ps = postcopy_state_set(POSTCOPY_INCOMING_ADVISE);
     uint64_t remote_pagesize_summary, local_pagesize_summary, remote_tps;
     size_t page_size = qemu_target_page_size();
-    Error *local_err = NULL;
 
     trace_loadvm_postcopy_handle_advise();
     if (ps != POSTCOPY_INCOMING_NONE) {
-        error_report("CMD_POSTCOPY_ADVISE in wrong postcopy state (%d)", ps);
+        error_setg(errp, "CMD_POSTCOPY_ADVISE in wrong postcopy "
+                   "state (%d)", ps);
         return -1;
     }
 
     switch (len) {
     case 0:
         if (migrate_postcopy_ram()) {
-            error_report("RAM postcopy is enabled but have 0 byte advise");
+            error_setg(errp, "RAM postcopy is enabled but have 0 byte advise");
             return -EINVAL;
         }
         return 0;
     case 8 + 8:
         if (!migrate_postcopy_ram()) {
-            error_report("RAM postcopy is disabled but have 16 byte advise");
+            error_setg(errp, "RAM postcopy is disabled but have 16 "
+                       "byte advise");
             return -EINVAL;
         }
         break;
     default:
-        error_report("CMD_POSTCOPY_ADVISE invalid length (%d)", len);
+        error_setg(errp, "CMD_POSTCOPY_ADVISE invalid length (%d)", len);
         return -EINVAL;
     }
 
-    if (!postcopy_ram_supported_by_host(mis, &local_err)) {
-        error_report_err(local_err);
+    if (!postcopy_ram_supported_by_host(mis, errp)) {
         postcopy_state_set(POSTCOPY_INCOMING_NONE);
         return -1;
     }
@@ -1961,9 +1961,9 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
          *      also fails when passed to an older qemu that doesn't
          *      do huge pages.
          */
-        error_report("Postcopy needs matching RAM page sizes (s=%" PRIx64
-                                                             " d=%" PRIx64 ")",
-                     remote_pagesize_summary, local_pagesize_summary);
+        error_setg(errp, "Postcopy needs matching RAM "
+                   "page sizes (s=%" PRIx64 " d=%" PRIx64 ")",
+                   remote_pagesize_summary, local_pagesize_summary);
         return -1;
     }
 
@@ -1973,17 +1973,17 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
          * Again, some differences could be dealt with, but for now keep it
          * simple.
          */
-        error_report("Postcopy needs matching target page sizes (s=%d d=%zd)",
-                     (int)remote_tps, page_size);
+        error_setg(errp, "Postcopy needs matching target "
+                   "page sizes (s=%d d=%zd)", (int)remote_tps, page_size);
         return -1;
     }
 
-    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_ADVISE, &local_err)) {
-        error_report_err(local_err);
+    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_ADVISE, errp)) {
         return -1;
     }
 
-    if (ram_postcopy_incoming_init(mis, NULL)) {
+    if (ram_postcopy_incoming_init(mis, errp)) {
+        error_prepend(errp, "PostCopy RAM incoming init failed ");
         return -1;
     }
 
@@ -2616,12 +2616,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_handle_cmd_packaged(mis, errp);
 
     case MIG_CMD_POSTCOPY_ADVISE:
-        ret = loadvm_postcopy_handle_advise(mis, len);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-            return -1;
-        }
-        return ret;
+        return loadvm_postcopy_handle_advise(mis, len, errp);
 
     case MIG_CMD_POSTCOPY_LISTEN:
         ret = loadvm_postcopy_handle_listen(mis);

-- 
2.50.0


