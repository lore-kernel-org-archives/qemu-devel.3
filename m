Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD74CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4huI-0004yh-IB; Fri, 03 Oct 2025 11:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htP-0004ja-TW
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htC-0007Oc-Oy
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+ex488mX5IGmS9jg+WlubJIlm7XHzVTBkhQfIVSjn4U=;
 b=Pc8xLpCmEt8ttiftKwzPjrJkdYZBJyTSBIidbsW2/1JrhGzxjxo5EAJMxOz3WRlSTJW2yh
 JQhy8FHvRNe3kSJmnkcwQLcTjmy/UEkSV5Ehk+hd2FaQgxeC9an79JfQ6HzPU/NbCbJbKb
 8EE4IDMFq80fzo166+14Qcxijn4gKec=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-SThgoTNWOw6coG_K12vqsw-1; Fri, 03 Oct 2025 11:40:01 -0400
X-MC-Unique: SThgoTNWOw6coG_K12vqsw-1
X-Mimecast-MFC-AGG-ID: SThgoTNWOw6coG_K12vqsw_1759506001
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-876ee102b44so66391626d6.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506001; x=1760110801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ex488mX5IGmS9jg+WlubJIlm7XHzVTBkhQfIVSjn4U=;
 b=N0tx0gW0N2iq4YSXXD43ExFYqPkkp/1u7vvfoZDTZBt4jrnIzkOUQuW40xcLUN9RLX
 HLllVx7NCe3omGpabA1/+PLlQ1C7P6b6x99pj+XN1OdxbBQ484CNOXGGu5ywEv43ZvtV
 /zY6O9YuWuHEtAU/HaDTG2gJk5ZX0K94AU25VKoBCTFo/h/iXPmoG2Sw0VAD5MWnPs57
 ZpAG5EXVYIt92uFmApzpNWcKpZzd1hNJFw+HmXynp/cZVeEtE2lRoBIHuP1HeZYEojdK
 6ixW6bS9nhmK7kxz0r+oO66Ap9wuytVa0Bfxbjmu2GeBBukhPDGowvoF6ZTrf2A7Y/p9
 ZkHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYK5zg3C3P3gXbsVpC0Oqmob+N+sqFzsRVPpdSBG/YtdDiUWiGLyJ8N1t/cv0kRptR2yOAkAU21uY2@nongnu.org
X-Gm-Message-State: AOJu0YzQYtwKV5gJknHKQ9m54E616znMAyEJ0nvCUx6BZRYTqsXPZnHv
 DWnACEXMnicRiQFpZHFGFhfFPT5fQ5tC2ofvTwWdNfcm1IoNPPvuT8KyT29Y8xzKJfjyxDQDSH4
 GTRVWgRenNyY5lnUPWpmnN2qxHABfptUUDmAAbxeHk97WW536XMINy7we
X-Gm-Gg: ASbGnctV85d1DjTWU/IekrGJRDGar2+QkTXnzv8lNDU85wcfYrxeeRtCufoAshJV6zr
 uFVuVYUU1RTpWUfHrzsYsZSpOBoGUmZybmtQIpWrehoyqEs0SJ9PLzWmpWs+3V/CO7aBBJYjsyv
 FTiFaJPApdMBI/B+PhlcP/Dax56LQQlpGZn2q4jXE1Y/xLTs2d/b1+6PiDdnVaVZHBaUvmY2LBe
 TsJ6iIGNn37dpFdXt21vGkNN1NvLf4bDVIy5GNDluOROaTqIHJq1arzkVoisHXLNCW8YSUFc3W1
 Cs6W2CsfyRmw8qFzCqucijf4sMBEYv2McWvlVg==
X-Received: by 2002:a05:6214:2428:b0:788:82e0:3a9 with SMTP id
 6a1803df08f44-879dc443233mr39525456d6.21.1759506000555; 
 Fri, 03 Oct 2025 08:40:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOhwdZYy52hWmVhuexgSFQN1MS8FtD0GjuDVGw59J3VlD6Fpfhsw5KrphguH6hPFZlyFuEag==
X-Received: by 2002:a05:6214:2428:b0:788:82e0:3a9 with SMTP id
 6a1803df08f44-879dc443233mr39524956d6.21.1759505999902; 
 Fri, 03 Oct 2025 08:39:59 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:39:59 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Arun Menon <armenon@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 05/45] migration: push Error **errp into
 loadvm_process_command()
Date: Fri,  3 Oct 2025 11:39:08 -0400
Message-ID: <20251003153948.1304776-6-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Arun Menon <armenon@redhat.com>

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
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/20250918-propagate_tpm_error-v14-5-36f11a6fb9d3@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 86 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 63 insertions(+), 23 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index fffea57cd9..d1ed2e1cde 100644
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
2.50.1


