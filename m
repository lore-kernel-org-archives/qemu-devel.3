Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A30C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 00:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucChf-00069E-QE; Wed, 16 Jul 2025 20:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCfT-0003XG-U0
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:40:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCfR-0004xB-OY
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752712808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vTeE8/9Lh4UccTl/MBa5F7ess9MS2pKCwA3QYt9z0AI=;
 b=M7EjyksGer0W/hGS5Lqt8TMlscKaw3IY+2Sg4ZuS+0z2kBc9ePUqRQF1hVsbZp+tU/leIG
 BgvbFaV/UfhP57eOPNo3493jR/0tttUavu7P5/0vUg3Y60apxZq0mV20i3EhcXzdG5VwsD
 WPquj0dFbNdSQvgalErlYlOV17Y1ocM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-pQeKBORANumoBoz41yCfGw-1; Wed, 16 Jul 2025 20:40:07 -0400
X-MC-Unique: pQeKBORANumoBoz41yCfGw-1
X-Mimecast-MFC-AGG-ID: pQeKBORANumoBoz41yCfGw_1752712806
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-313f702d37fso526849a91.3
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 17:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752712806; x=1753317606;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vTeE8/9Lh4UccTl/MBa5F7ess9MS2pKCwA3QYt9z0AI=;
 b=Y73OEnYmsob+Dzg8MmCgDBEmTBnYQg1VJGzhsEFpK/RmJzPt31b/HRv93SD+dRzI/X
 qdBg7SvCfFV+tT1gaAhGEerYPAZyPZdovmyvDiDMUzOBMwF7zpYgXph+m7CCN9zU+uj8
 hBWDz2JFRluTCJaVPCJ5HEHzLHacTHimJBrK9eP12pAyRMMEXr4cEGRU8lGSx5M9aIvd
 UHdGqeyJV4tNbstwAymiDNVUSj9DV3eZCo2bMshxgpfiyZ0FRrwnxx4EMYTHrZfguel4
 SU36nlz3q8v9FDdRLei9Oclq1xgezGA4j7sT/OtscJu4QmpJeCLIwkA7uh3ctHhF1kRC
 ZBtw==
X-Gm-Message-State: AOJu0YwaTSBmad2HFeucWgmhKV83hB5BAlo2dkKdtjFGqaGJJDcehITA
 ml0dErgTeQiRLQPIRTvS3yVX09YEMlQ2Ll65J1Wq3eAW6wU2s9FjYBwGI5Y0ZFwEEJanq/MAveO
 iGP331cBkvLsGDSZfkWzDEXFmKryIIl929We6mLUd0bczFOgnqw22o9WR
X-Gm-Gg: ASbGncuZp+T4vWVz/QEaHHfQC0wUXJP/bnvNUp8SlrxAfbjXTp7Z1qgXqBnD6lXdSVh
 r5rRFHxlw8bKUWtHzda7peODAIHX88tIx2VfVJPLZHTlKQpSW0HR0wklevS+p2n1yVdtETwtysx
 G3LMin8IhD0rPKWQ7mN2WdM4XQdb8+8gwiTC9EmIS57GXSRV4m6lP4Oj9tTDQx9EoJkVwsvUUzT
 +oYh78ZHrWlGV8RCDfIekm5/FlOxxj7KBPiwO9Wpx6m5oaZI19xox6PuaXPrFX8LFcu5Lmioea3
 R7p/gALeKAByrBpb8l5NSb6x6fOmztsVEe3lmh7AZChUMTYwE1j4
X-Received: by 2002:a17:90b:2ec7:b0:311:ef19:824d with SMTP id
 98e67ed59e1d1-31c9f435537mr5951196a91.2.1752712806285; 
 Wed, 16 Jul 2025 17:40:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXCiCjhf4E4OyV6KKYPshayVD8EIdfsc+zrX+ils8RiixiHS5Cg5zVLyLevpNv8mzMnhns8Q==
X-Received: by 2002:a17:90b:2ec7:b0:311:ef19:824d with SMTP id
 98e67ed59e1d1-31c9f435537mr5951134a91.2.1752712805890; 
 Wed, 16 Jul 2025 17:40:05 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9f287c19sm2214424a91.31.2025.07.16.17.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 17:40:05 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 17 Jul 2025 06:07:30 +0530
Subject: [PATCH v5 07/23] migration: push Error **errp into
 loadvm_process_command()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-propagate_tpm_error-v5-7-1f406f88ee65@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6701; i=armenon@redhat.com;
 h=from:subject:message-id; bh=HQPNJONVT9SivjK/oGYO7fxEoYCQ+al2/T3BQqpuGNk=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0aFm/xpPp46pz1Z+9/srfG5eu2QvnNVwIY3JRJXWQ6zb
 83zX1DbUcrCIMbFICumyNLwNUC2KaAwItL25XWYOaxMIEMYuDgFYCK3XBgZPmUlrHHlad2drvqT
 +VlZ9FZ3xf1TFQss+uxLxCV+ax5MZPgf9Lqav0e09uzNfd/E4t+p3vgi4my2W9/pvLn3i8xe2Xp
 +AA==
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
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
It is ensured that loadvm_process_command() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 89 ++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 67 insertions(+), 22 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 22d73999595384519c755c9416b74ba1263a8bb9..98711bb38a4548d4f168459f729f604a78716c25 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2540,12 +2540,13 @@ static int loadvm_postcopy_handle_switchover_start(void)
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
@@ -2556,16 +2557,16 @@ static int loadvm_process_command(QEMUFile *f)
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
 
@@ -2578,7 +2579,7 @@ static int loadvm_process_command(QEMUFile *f)
         }
         mis->to_src_file = qemu_file_get_return_path(f);
         if (!mis->to_src_file) {
-            error_report("CMD_OPEN_RETURN_PATH failed");
+            error_setg(errp, "CMD_OPEN_RETURN_PATH failed");
             return -1;
         }
 
@@ -2588,11 +2589,10 @@ static int loadvm_process_command(QEMUFile *f)
          * been created.
          */
         if (migrate_switchover_ack() && !mis->switchover_ack_pending_num) {
-            int ret = migrate_send_rp_switchover_ack(mis);
+            ret = migrate_send_rp_switchover_ack(mis);
             if (ret) {
-                error_report(
-                    "Could not send switchover ack RP MSG, err %d (%s)", ret,
-                    strerror(-ret));
+                error_setg(errp, "Could not send switchover ack "
+                           "RP MSG, err %d (%s)", ret, strerror(-ret));
                 return ret;
             }
         }
@@ -2602,39 +2602,84 @@ static int loadvm_process_command(QEMUFile *f)
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
+            return -1;
+        }
+        return ret;
 
     case MIG_CMD_POSTCOPY_ADVISE:
-        return loadvm_postcopy_handle_advise(mis, len);
+        ret = loadvm_postcopy_handle_advise(mis, len);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+            return -1;
+        }
+        return ret;
 
     case MIG_CMD_POSTCOPY_LISTEN:
-        return loadvm_postcopy_handle_listen(mis);
+        ret = loadvm_postcopy_handle_listen(mis);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+            return -1;
+        }
+        return ret;
 
     case MIG_CMD_POSTCOPY_RUN:
-        return loadvm_postcopy_handle_run(mis);
+        ret = loadvm_postcopy_handle_run(mis);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+            return -1;
+        }
+        return ret;
 
     case MIG_CMD_POSTCOPY_RAM_DISCARD:
-        return loadvm_postcopy_ram_handle_discard(mis, len);
+        ret = loadvm_postcopy_ram_handle_discard(mis, len);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+            return -1;
+        }
+        return ret;
 
     case MIG_CMD_POSTCOPY_RESUME:
-        return loadvm_postcopy_handle_resume(mis);
+        ret = loadvm_postcopy_handle_resume(mis);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+            return -1;
+        }
+        return ret;
 
     case MIG_CMD_RECV_BITMAP:
-        return loadvm_handle_recv_bitmap(mis, len);
+        ret = loadvm_handle_recv_bitmap(mis, len);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+            return -1;
+        }
+        return ret;
 
     case MIG_CMD_ENABLE_COLO:
-        return loadvm_process_enable_colo(mis);
+        ret = loadvm_process_enable_colo(mis);
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+            return -1;
+        }
+        return ret;
 
     case MIG_CMD_SWITCHOVER_START:
-        return loadvm_postcopy_handle_switchover_start();
+        ret = loadvm_postcopy_handle_switchover_start();
+        if (ret < 0) {
+            error_setg(errp, "Failed to load device state command: %d", ret);
+            return -1;
+        }
+        return ret;
     }
 
     return 0;
@@ -3071,7 +3116,7 @@ retry:
             }
             break;
         case QEMU_VM_COMMAND:
-            ret = loadvm_process_command(f);
+            ret = loadvm_process_command(f, NULL);
             trace_qemu_loadvm_state_section_command(ret);
             if ((ret < 0) || (ret == LOADVM_QUIT)) {
                 goto out;

-- 
2.50.0


