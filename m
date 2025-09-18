Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC27CA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 15:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzGUv-0003dT-Sp; Thu, 18 Sep 2025 11:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGUt-0003cR-WE
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:24:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGUr-0002f5-Gk
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758209071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uj4H8KnUuiQwP+qdZY3377j43+Z3u9M3mu/jrKpfZ4I=;
 b=FHRWtpO4yI19yBrYlB1vgbUGDPun1Ud1rEv6uK2DpJXkJW1YQvStkbPEpdFozDJ+q0pHkV
 j/Enddx2ZGG6iNd9vT4EtPOc4k5D8ho4Q4I26DD9stZlwkwvWNvoHImLraceUkZsZS5muX
 sNcMValTKEhs1MsOhDtIO7Qk1OpU4Ds=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-tqDeDZqzP1aI1du7LM1jhw-1; Thu, 18 Sep 2025 11:24:30 -0400
X-MC-Unique: tqDeDZqzP1aI1du7LM1jhw-1
X-Mimecast-MFC-AGG-ID: tqDeDZqzP1aI1du7LM1jhw_1758209070
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-7725b77b795so1131024b3a.2
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 08:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758209069; x=1758813869;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uj4H8KnUuiQwP+qdZY3377j43+Z3u9M3mu/jrKpfZ4I=;
 b=X/gxO+B1N/lmy2EDJrRIs17xT6X+g8rk/2vhD2KC9wv/Ph6SQYFKHzlqmqfV14MnZ6
 /hAUwVTDXrrRvj3C3wegAHIDjiWk4e9rjNXFSraBAcoYoK0hNj41lY9JWBwfrTrlXvGC
 Yifml1EhFQpgWbr+lGf9+qdmXRNA0C3ARlZPBrbE+tKyF6BUXAPFUfdLLyeX+Ur82Eu2
 lT82bOcSDxCj/Af3dTYpKiyOjWVbHl6gy287cVXrOvzwYd6ws/cpeV4H9ZxfMryKwlzk
 Ui/gakpPDJ5CGSnITAV1ZQTeiWMHZsS1zdOgO9Tf0RLvVwPmmXddoCi1DL23oJSFvCOC
 5V0Q==
X-Gm-Message-State: AOJu0YxcvrzeWnsmVIEDrTudKi4z8P8ZrQD8iyqqPbNmgyqKEYE5M1mS
 GBCN8c0On9RE1kVL93Fvu8WwksKjCj4qBbTC+PIuRKpVA4z+s+1d9XmfNH8gLnMEEXTok7mTk4Y
 UtBgzUeHciORBlR6gRqKKb0NBfs2bHTxGIsoc6l5e2dAyoCsW4LO6MUJm
X-Gm-Gg: ASbGncvz4hzA5nk3sdTla4GKckjvX97nsUhh5lwMWeYMCg//BqTSjYiJXnW7j2vUFvA
 lrTiJQjVRBHGRZBLMm5aLUrKcMjCp5ii4a09rB5MmsUv4KxgC6C2uruLg34Abip2svm+Y/vPX05
 Ve340xGPzGoWPPHTetIz2emg9erT4werVx87f8qITquY6kBjUqwIc6DxgBC+th5R3WA9jlw/sH9
 brVxfzCz/zjxt7fscXDyjiXj9XAiBDmwtxoOp+kFh3Nffm0WcbaWxbBMEmpB8kX79rNm3ktZPJ4
 nTZpH3ftTT2zGqkzywcHrRsJl7XXBpZ/MEnKsslwy98BwCNNeYZn1g==
X-Received: by 2002:a05:6a00:1888:b0:776:1804:6fe with SMTP id
 d2e1a72fcca58-77bf6fcee5amr7514199b3a.7.1758209069482; 
 Thu, 18 Sep 2025 08:24:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQMCS8eer6M5gPpi3aRDPTEPN0EaVmvKvqg5D+qEIc8K0bW2kc4GJdcAg4Zsden+3/wHeYfQ==
X-Received: by 2002:a05:6a00:1888:b0:776:1804:6fe with SMTP id
 d2e1a72fcca58-77bf6fcee5amr7514153b3a.7.1758209069032; 
 Thu, 18 Sep 2025 08:24:29 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.110.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77cfc2481d7sm2675512b3a.32.2025.09.18.08.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 08:24:28 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 18 Sep 2025 20:53:22 +0530
Subject: [PATCH v14 05/27] migration: push Error **errp into
 loadvm_process_command()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250918-propagate_tpm_error-v14-5-36f11a6fb9d3@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7155; i=armenon@redhat.com;
 h=from:subject:message-id; bh=qSL0t7f4wG7F7+1wOstaO87epuFS+Gl9p/u+kXVLec8=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YZ5e/yURPMXZdZHz91+0t+kdqD+G2v2jPVV9xoU82P2
 K/MuvV+RykLgxgXg6yYIkvD1wDZpoDCiEjbl9dh5rAygQxh4OIUgImIHGVk6DDc7vX9Qu8CkY5w
 riS/2GnHzU71Ckz5nBC+cbpB8E2RRob/YXpKqTvNEvSNAp5zxC3ZJXMwz03tSl1ciSDv+n5t25M
 MAA==
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
It is ensured that loadvm_process_command() must report an error
in errp, in case of failure.

The errors are temporarily reported using error_report_err().
This is removed in the subsequent patches in this series
when we are actually able to propagate the error to the calling
function.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 86 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 63 insertions(+), 23 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 40dae406db22dc9ddbff2f5ada92a32626b58e3b..0e9935aea3e1a214cfa0ddd0e30fa5cf925373e3 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2546,32 +2546,37 @@ static int loadvm_postcopy_handle_switchover_start(void)
  * LOADVM_QUIT All good, but exit the loop
  * <0          Error
  */
-static int loadvm_process_command(QEMUFile *f)
+static int loadvm_process_command(QEMUFile *f, Error **errp)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     uint16_t cmd;
     uint16_t len;
     uint32_t tmp32;
+    int ret;
 
     cmd = qemu_get_be16(f);
     len = qemu_get_be16(f);
 
     /* Check validity before continue processing of cmds */
-    if (qemu_file_get_error(f)) {
-        return qemu_file_get_error(f);
+    ret = qemu_file_get_error(f);
+    if (ret) {
+        error_setg(errp,
+                   "Failed to load VM process command: stream error: %d",
+                   ret);
+        return ret;
     }
 
     if (cmd >= MIG_CMD_MAX || cmd == MIG_CMD_INVALID) {
-        error_report("MIG_CMD 0x%x unknown (len 0x%x)", cmd, len);
+        error_setg(errp, "MIG_CMD 0x%x unknown (len 0x%x)", cmd, len);
         return -EINVAL;
     }
 
     trace_loadvm_process_command(mig_cmd_args[cmd].name, len);
 
     if (mig_cmd_args[cmd].len != -1 && mig_cmd_args[cmd].len != len) {
-        error_report("%s received with bad length - expecting %zu, got %d",
-                     mig_cmd_args[cmd].name,
-                     (size_t)mig_cmd_args[cmd].len, len);
+        error_setg(errp, "%s received with bad length - expecting %zu, got %d",
+                   mig_cmd_args[cmd].name,
+                   (size_t)mig_cmd_args[cmd].len, len);
         return -ERANGE;
     }
 
@@ -2584,7 +2589,7 @@ static int loadvm_process_command(QEMUFile *f)
         }
         mis->to_src_file = qemu_file_get_return_path(f);
         if (!mis->to_src_file) {
-            error_report("CMD_OPEN_RETURN_PATH failed");
+            error_setg(errp, "CMD_OPEN_RETURN_PATH failed");
             return -1;
         }
 
@@ -2594,11 +2599,10 @@ static int loadvm_process_command(QEMUFile *f)
          * been created.
          */
         if (migrate_switchover_ack() && !mis->switchover_ack_pending_num) {
-            int ret = migrate_send_rp_switchover_ack(mis);
+            ret = migrate_send_rp_switchover_ack(mis);
             if (ret) {
-                error_report(
-                    "Could not send switchover ack RP MSG, err %d (%s)", ret,
-                    strerror(-ret));
+                error_setg_errno(errp, -ret,
+                                 "Could not send switchover ack RP MSG");
                 return ret;
             }
         }
@@ -2608,39 +2612,71 @@ static int loadvm_process_command(QEMUFile *f)
         tmp32 = qemu_get_be32(f);
         trace_loadvm_process_command_ping(tmp32);
         if (!mis->to_src_file) {
-            error_report("CMD_PING (0x%x) received with no return path",
-                         tmp32);
+            error_setg(errp, "CMD_PING (0x%x) received with no return path",
+                       tmp32);
             return -1;
         }
         migrate_send_rp_pong(mis, tmp32);
         break;
 
     case MIG_CMD_PACKAGED:
-        return loadvm_handle_cmd_packaged(mis);
+        ret = loadvm_handle_cmd_packaged(mis);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+        }
+        return ret;
 
     case MIG_CMD_POSTCOPY_ADVISE:
-        return loadvm_postcopy_handle_advise(mis, len);
+        ret = loadvm_postcopy_handle_advise(mis, len);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+        }
+        return ret;
 
     case MIG_CMD_POSTCOPY_LISTEN:
-        return loadvm_postcopy_handle_listen(mis);
+        ret = loadvm_postcopy_handle_listen(mis);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+        }
+        return ret;
 
     case MIG_CMD_POSTCOPY_RUN:
-        return loadvm_postcopy_handle_run(mis);
+        ret = loadvm_postcopy_handle_run(mis);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+        }
+        return ret;
 
     case MIG_CMD_POSTCOPY_RAM_DISCARD:
-        return loadvm_postcopy_ram_handle_discard(mis, len);
+        ret = loadvm_postcopy_ram_handle_discard(mis, len);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+        }
+        return ret;
 
     case MIG_CMD_POSTCOPY_RESUME:
         return loadvm_postcopy_handle_resume(mis);
 
     case MIG_CMD_RECV_BITMAP:
-        return loadvm_handle_recv_bitmap(mis, len);
+        ret = loadvm_handle_recv_bitmap(mis, len);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+        }
+        return ret;
 
     case MIG_CMD_ENABLE_COLO:
-        return loadvm_process_enable_colo(mis);
+        ret = loadvm_process_enable_colo(mis);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+        }
+        return ret;
 
     case MIG_CMD_SWITCHOVER_START:
-        return loadvm_postcopy_handle_switchover_start();
+        ret = loadvm_postcopy_handle_switchover_start();
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+        }
+        return ret;
     }
 
     return 0;
@@ -3049,6 +3085,7 @@ int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
 {
     uint8_t section_type;
     int ret = 0;
+    Error *local_err = NULL;
 
 retry:
     while (true) {
@@ -3076,7 +3113,10 @@ retry:
             }
             break;
         case QEMU_VM_COMMAND:
-            ret = loadvm_process_command(f);
+            ret = loadvm_process_command(f, &local_err);
+            if (ret < 0) {
+                error_report_err(local_err);
+            }
             trace_qemu_loadvm_state_section_command(ret);
             if ((ret < 0) || (ret == LOADVM_QUIT)) {
                 goto out;

-- 
2.51.0


