Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD759CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 15:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzGXC-00017o-J5; Thu, 18 Sep 2025 11:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGX8-0000om-64
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:26:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGX5-0003E3-Az
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758209210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hJPSGag0Qjlv9+IbFHR1Wh7Da0AbXrIq0eHPPw0rJ78=;
 b=LQanTP3VU/JyVTBBS63bECK+gY+FrhrFKVkFZPlEqnadgITtkVm0tJtezrMtOgs5o5W1FS
 rtefQreJNkTw7AiWnmvbDh6yKO3jvSFfA4thzlaMDeLuvqzbfxduZaw+/F3FclQLLbdIiw
 Q7wpSpQsSuLEFKEKNh9HMAdjbIvj70I=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-3SrjWYHON5ycZqyaAQpn5A-1; Thu, 18 Sep 2025 11:26:48 -0400
X-MC-Unique: 3SrjWYHON5ycZqyaAQpn5A-1
X-Mimecast-MFC-AGG-ID: 3SrjWYHON5ycZqyaAQpn5A_1758209208
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-77dab334f78so450849b3a.3
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 08:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758209208; x=1758814008;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hJPSGag0Qjlv9+IbFHR1Wh7Da0AbXrIq0eHPPw0rJ78=;
 b=Z5jkCpTTlIdChJ5HkhpRuUm6B2nXaw/GvxQFEi/99OpWFKW4dzj+SkTJ6aI3VmeuWv
 Syt2qHZxJ68Cx5Oz2VB+UFQCqDt1QXOsgHlfvSrhWApFT/biQFcWWCNQtXWeZtduMrDK
 2H0TF27iDYecDKwuz4yH4gtmEj36hbyI/7XBPQQJB6JufmMZjy9XJ1rHJXtd96djyRyU
 JvyP4W+/MLkch7McYf8/FrnUNdpbQ6GDnGv+OzVu5yUhrUdWLRxitxT3HJXcjbMZVLy1
 Xxf8X8iyDVypqnS8zx3TrI/BbG5/SL4DuUGc+/V4iLncflvwuVuiKgEsP1NfhSId55In
 6MjA==
X-Gm-Message-State: AOJu0YyR1ee7P+8450NNdd8AuUsKTciITOwd622xNWPOnH3C77RY7A2A
 k3HhprqUmYjmoKcI0E5Gav0JLPggd2k17ybBCTCGFUQscP+XmxUVhDl2bstGbZXx/G8yxrgSzka
 OMkTRV1+F2Goq9p+Dc6ad1WHfLRWUTxU+pQJjUbN/mqlPVVGML5dW16NI
X-Gm-Gg: ASbGncuLo6D+lUH+GfeQ70Ege3017u0RwJPmXEJcK32+TMYvx1iPsHS9uoalWa26urQ
 IC0AQcFe8/saMyW3qHDEbk3D1tyOZfaTnERGJxDgxPT6MVbaeWaLtrUlz2P9NOZXHlcEm5MoEAD
 63dlAUDw65qXhMz3RLibJmiEWZVgPUyiLL3qQqjm3GidhU3vxCKEsQkLY3akt+YVz0kEQ3Txb/o
 a+KOjTVV4m9LAWi7TeIm8MVPDfI8OqaFo0z1Kwp8ClwHxKu8iOknI8c6itAVdIpxHNmYDHHQgHj
 Ka1PokJX0Xvk5f4RcZuJOa700PLqS8xpZ6C0/kPTNTqtu7oDPXrfJg==
X-Received: by 2002:a05:6a20:2443:b0:253:2fae:5291 with SMTP id
 adf61e73a8af0-27aa1e62df2mr9640057637.29.1758209207754; 
 Thu, 18 Sep 2025 08:26:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEil1nSM7Za4+Dq1ZKXMd7wBNWkzFLqwXQm4kJozI1bjGEi4sykjWy4izr3AN/N8ZZmoyKi1A==
X-Received: by 2002:a05:6a20:2443:b0:253:2fae:5291 with SMTP id
 adf61e73a8af0-27aa1e62df2mr9640000637.29.1758209207337; 
 Thu, 18 Sep 2025 08:26:47 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.110.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77cfc2481d7sm2675512b3a.32.2025.09.18.08.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 08:26:46 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 18 Sep 2025 20:53:38 +0530
Subject: [PATCH v14 21/27] migration: push Error **errp into
 loadvm_process_enable_colo()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250918-propagate_tpm_error-v14-21-36f11a6fb9d3@redhat.com>
References: <20250918-propagate_tpm_error-v14-0-36f11a6fb9d3@redhat.com>
In-Reply-To: <20250918-propagate_tpm_error-v14-0-36f11a6fb9d3@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6000; i=armenon@redhat.com;
 h=from:subject:message-id; bh=+LtLa1s3KBCwKzISTFaaE+ziTA/jwk32Bx4Oc//mt74=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YZ5R/pLEHsZ8LTO39u5LMOZznwut7uzdawVJ6yKZeFP
 YwU+Js6SlkYxLgYZMUUWRq+Bsg2BRRGRNq+vA4zh5UJZAgDF6cATKTuOSPD1kz7vQ8lzT9+7+L9
 yFVxO+at5Zy76zeLcLTF2Mzb8sO4neG/T3X94QsZy9+cnPVONPVXfNI3vxlSlRMrj6XplW0RnFT
 KCQA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
It is ensured that loadvm_process_enable_colo() must report an error
in errp, in case of failure.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 include/migration/colo.h |  2 +-
 migration/migration.c    | 12 ++++++------
 migration/ram.c          |  8 ++++----
 migration/ram.h          |  2 +-
 migration/savevm.c       | 26 ++++++++++++++------------
 5 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/include/migration/colo.h b/include/migration/colo.h
index 43222ef5ae6adc3f7d8aa6a48bef79af33d09208..d4fe422e4d335d3bef4f860f56400fcd73287a0e 100644
--- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -25,7 +25,7 @@ void migrate_start_colo_process(MigrationState *s);
 bool migration_in_colo_state(void);
 
 /* loadvm */
-int migration_incoming_enable_colo(void);
+int migration_incoming_enable_colo(Error **errp);
 void migration_incoming_disable_colo(void);
 bool migration_incoming_colo_enabled(void);
 bool migration_incoming_in_colo_state(void);
diff --git a/migration/migration.c b/migration/migration.c
index 16250faed91781843a572fe1ad4d71a37a2847a4..5d17e65bbf4c044ad9aac0f5f3fc9f5fefd71230 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -623,22 +623,22 @@ void migration_incoming_disable_colo(void)
     migration_colo_enabled = false;
 }
 
-int migration_incoming_enable_colo(void)
+int migration_incoming_enable_colo(Error **errp)
 {
 #ifndef CONFIG_REPLICATION
-    error_report("ENABLE_COLO command come in migration stream, but the "
-                 "replication module is not built in");
+    error_setg(errp, "ENABLE_COLO command come in migration stream, but the "
+               "replication module is not built in");
     return -ENOTSUP;
 #endif
 
     if (!migrate_colo()) {
-        error_report("ENABLE_COLO command come in migration stream, but x-colo "
-                     "capability is not set");
+        error_setg(errp, "ENABLE_COLO command come in migration stream"
+                   ", but x-colo capability is not set");
         return -EINVAL;
     }
 
     if (ram_block_discard_disable(true)) {
-        error_report("COLO: cannot disable RAM discard");
+        error_setg(errp, "COLO: cannot disable RAM discard");
         return -EBUSY;
     }
     migration_colo_enabled = true;
diff --git a/migration/ram.c b/migration/ram.c
index 163265a57f26fb1dc88d9797629d58c278e9afb7..a8e8d2cc6790336625de626fee070ecc51327200 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3578,7 +3578,7 @@ static void colo_init_ram_state(void)
  *
  * Returns zero to indicate success or -1 on error.
  */
-int colo_init_ram_cache(void)
+int colo_init_ram_cache(Error **errp)
 {
     RAMBlock *block;
 
@@ -3587,9 +3587,9 @@ int colo_init_ram_cache(void)
             block->colo_cache = qemu_anon_ram_alloc(block->used_length,
                                                     NULL, false, false);
             if (!block->colo_cache) {
-                error_report("%s: Can't alloc memory for COLO cache of block %s,"
-                             "size 0x" RAM_ADDR_FMT, __func__, block->idstr,
-                             block->used_length);
+                error_setg(errp, "Can't alloc memory for COLO cache of "
+                           "block %s, size 0x" RAM_ADDR_FMT,
+                           block->idstr, block->used_length);
                 RAMBLOCK_FOREACH_NOT_IGNORED(block) {
                     if (block->colo_cache) {
                         qemu_anon_ram_free(block->colo_cache, block->used_length);
diff --git a/migration/ram.h b/migration/ram.h
index 275709a99187f9429ccb4111e05281ec268ba0db..24cd0bf585762cfa1e86834dc03c6baeea2f0627 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -109,7 +109,7 @@ void ramblock_set_file_bmap_atomic(RAMBlock *block, ram_addr_t offset,
                                    bool set);
 
 /* ram cache */
-int colo_init_ram_cache(void);
+int colo_init_ram_cache(Error **errp);
 void colo_flush_ram_cache(void);
 void colo_release_ram_cache(void);
 void colo_incoming_start_dirty_log(void);
diff --git a/migration/savevm.c b/migration/savevm.c
index 13a809564aebf6346228f46fd60f611ba6104bea..8e891243dc1e7f5d3bc3a4326c6c4a2f5c32e1a2 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2515,15 +2515,21 @@ static int loadvm_handle_recv_bitmap(MigrationIncomingState *mis,
     return 0;
 }
 
-static int loadvm_process_enable_colo(MigrationIncomingState *mis)
+static int loadvm_process_enable_colo(MigrationIncomingState *mis,
+                                      Error **errp)
 {
-    int ret = migration_incoming_enable_colo();
+    ERRP_GUARD();
+    int ret;
 
-    if (!ret) {
-        ret = colo_init_ram_cache();
-        if (ret) {
-            migration_incoming_disable_colo();
-        }
+    ret = migration_incoming_enable_colo(errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = colo_init_ram_cache(errp);
+    if (ret) {
+        error_prepend(errp, "failed to init colo RAM cache: %d: ", ret);
+        migration_incoming_disable_colo();
     }
     return ret;
 }
@@ -2646,11 +2652,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_handle_recv_bitmap(mis, len, errp);
 
     case MIG_CMD_ENABLE_COLO:
-        ret = loadvm_process_enable_colo(mis);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_process_enable_colo(mis, errp);
 
     case MIG_CMD_SWITCHOVER_START:
         ret = loadvm_postcopy_handle_switchover_start();

-- 
2.51.0


