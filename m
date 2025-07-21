Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086A2C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 11:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udokf-0002Hx-OG; Mon, 21 Jul 2025 07:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udojJ-0000zM-DJ
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:30:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udojD-0000x6-P2
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753097442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e/bTnVzCJK1JGmEtQ/HulU6OEfafySNKkRXdrQD17Hc=;
 b=a7oMO7Tskoy1NNSgp5HyjRvpXhLi5umZRWuX4QvrgEYkClLwlSm/TrXcu0p9IALBk5N29u
 SXm+IZWXNE/m3NzWkldXn8iKT71rQBom/y+APICNj2MQp+MBj8qWH+iG+tEY+JPIJ3A2ZK
 wjvS9bz+DLufjqnrlXTBdZQ9HxsJ2lA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-R-VgRpQmN1u-I_5gCR8IWw-1; Mon, 21 Jul 2025 07:30:41 -0400
X-MC-Unique: R-VgRpQmN1u-I_5gCR8IWw-1
X-Mimecast-MFC-AGG-ID: R-VgRpQmN1u-I_5gCR8IWw_1753097440
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b38ec062983so2883069a12.3
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 04:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753097440; x=1753702240;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e/bTnVzCJK1JGmEtQ/HulU6OEfafySNKkRXdrQD17Hc=;
 b=mhOAwJsQ4uSgrarF3ZB1Fx4/2xHsMWHeAsOrHPSe3ktYnr+p9thOrbF+03MMRIGKRN
 jL9EbbZPxA5l9KNVr01Q2O5NUahPouOFsAuMD3nmFTFGvfXkTDHpyODAQ4XWVFNxJ5no
 UUsAV9KK4Lqnm21KiwwEftmGelRMeI78Hp63bn/s6vPQXqRleeCoOatohyTd1ThFBeAJ
 4pnysMoctMu+LMTgFzoclfH9hF4pP938w50WJwJHkB894dbvoklfSYwwW6wolUjoQp7r
 yATeH62cdsQd4fYPSob+FMb6rGNa1lUbU8meDcGitxGABGl1HIDfTYdPLuT73ac7ON4F
 NvJg==
X-Gm-Message-State: AOJu0YwZ7OgzQ0+yY66foWvmkhSYl0YHq6o5m4xfkrm5ukOR8zPK1F3w
 IHG2ihiUC5aJB74BqDEVdGV7rlBC2x+jJ9S/Db8w+7NiS0qPQMdaNe5H65bpDjfG+9Z0smA/fy1
 VXeciW5TMXAthSuYPyo7pfQswV0CU2wv9LbVafjp0T2+8x5YDjmhqzf5H
X-Gm-Gg: ASbGnctN7bAhrb9DgVdjvAFiqJxCI/XP9XIUK4PGpP33Bc5f8NyU7kje0LFwf8C7G+d
 BY/0JPU55pehIDjKNFQ/d64UDSLZb6NwE7CtJafKzKjfUEhSy5e/SSvBjd2mV87vMPNJj+Mx57Y
 yTrErWjqwbgY2IRFwDJxZpy41ShXXbVX9LSFwQGOMXcoaVkb7FBhXTLmi7UyNWdqcEXBX167iSH
 AHFEL7MOvwsqkQs727CZdo8FeG4wWDfj3k7IgHLMQRpB0bgwACGwGG4twzz3Cdg8iehTKDsrZla
 vUwxELGDwlj0za6zzX4KemWpWPwAS9DFr4VN4qGDBdpCPV4FQpbM
X-Received: by 2002:a17:903:b47:b0:23c:8f2d:5e23 with SMTP id
 d9443c01a7336-23e3b89a480mr178275555ad.52.1753097440272; 
 Mon, 21 Jul 2025 04:30:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBy3ihIJI7EX3r4ru+pi/i7Rc+iUvXcJoi2UwaEIxGhsHhLwedc4yXM53EJ3bbESnavhw95g==
X-Received: by 2002:a17:903:b47:b0:23c:8f2d:5e23 with SMTP id
 d9443c01a7336-23e3b89a480mr178274885ad.52.1753097439813; 
 Mon, 21 Jul 2025 04:30:39 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.21])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e3c89sm56150465ad.18.2025.07.21.04.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 04:30:39 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Mon, 21 Jul 2025 16:59:13 +0530
Subject: [PATCH v6 08/24] migration: push Error **errp into
 loadvm_process_command()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-propagate_tpm_error-v6-8-fef740e15e17@redhat.com>
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
In-Reply-To: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6363; i=armenon@redhat.com;
 h=from:subject:message-id; bh=p3UPLCpz/aJX2UcP9W/OTrqcaVqP4oRxsSLO4TGtDSY=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0adysRJ548+8pmnJxexcuu2m6Jmlc3FMqslXnNt79dyu
 /P/a8jMjlIWBjEuBlkxRZaGrwGyTQGFEZG2L6/DzGFlAhnCwMUpABMxUWb47yJVx3pns52n3XUx
 K4NP+3wFIr+2mh3+JnbQht2ueDHzd4b/UQq7Lm1a4dcUuLykJLMhm2GWMtu7exzfDn8KqW/m3VL
 KDAA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 migration/savevm.c | 87 +++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 66 insertions(+), 21 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 96af7b412f2ed43468f4bcac8b833cda223f8321..d8feb9e1599d019636cd400ee7ebe594df27bd1d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2546,12 +2546,13 @@ static int loadvm_postcopy_handle_switchover_start(void)
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
@@ -2562,16 +2563,16 @@ static int loadvm_process_command(QEMUFile *f)
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
 
@@ -2590,11 +2591,10 @@ static int loadvm_process_command(QEMUFile *f)
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
@@ -2604,39 +2604,84 @@ static int loadvm_process_command(QEMUFile *f)
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
@@ -3074,7 +3119,7 @@ retry:
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


