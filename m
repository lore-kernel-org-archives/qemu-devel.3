Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A231EF54ADA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w554L-0004tR-4y; Tue, 24 Mar 2026 12:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5548-0004iN-Lr
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 12:57:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5546-0000YR-61
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 12:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774371431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qolVXTErP3rEARxzso+7cA4ZsYaKcIoCUVPKfyGf30s=;
 b=RUFmmKwbIWlbqmKnWX9tiXkMzRjsP7FKJtZVGfkH72lSRR17tC9cIjDaknVNAiMa0iaKl+
 3bcZoqOPIBPPTkKYvvCxnoRjkUsXAugHvSpxkcRsE7ugyLWmIBzH6g715m0SRd2jIr2ZVi
 IB48vxKRMP6gQR1xRxddfuFYjgA1oU4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-eijSrHk7OiCssKBec6J6qg-1; Tue, 24 Mar 2026 12:57:09 -0400
X-MC-Unique: eijSrHk7OiCssKBec6J6qg-1
X-Mimecast-MFC-AGG-ID: eijSrHk7OiCssKBec6J6qg_1774371428
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-485375aa56eso38397175e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 09:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774371428; x=1774976228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=qolVXTErP3rEARxzso+7cA4ZsYaKcIoCUVPKfyGf30s=;
 b=M8F5OvFJku4qzydFfRor8pXV8By6qpz17Y/rWfDvBgElK/o9kbp/ESvnh8PbBHBRQI
 tEGV9ol3bKu9Iz6383UY3RTHq7P9cJrqNr4e/5zcez8vVRuoXCz0cwzjPtvTsQNg+nPW
 KJqHi8rFIMRDdy0hRaR5xywmXECKubaVXd3Gg561gQfPWMmo2TlzpXyUoANd205jscp6
 t54+JzOvFz0GS+0+djFANHoEuKTdIB31FHiS2zYVv7IPvDuE7wMcR7LeC42PGnSz9usR
 gwdKo9YehYJLSWVXBsXBNH8R9vXVE6+xlcpa0itBctB+yz++E/bG3MwSTjNWRQk0OkJ8
 sHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774371428; x=1774976228;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qolVXTErP3rEARxzso+7cA4ZsYaKcIoCUVPKfyGf30s=;
 b=TyNpH5Q18Yawv/Jwf0y8WEybPmJes3sAS8OuyBkXbY8WtNtMb2R/2BfBHy3e80EuL4
 uU2zuREhzrCDTvM2NfEyrA75U52Iio3FgAOqdyW9bnlll0cRabOREDpK+WVz3J2W0AFX
 TqDdw9JHT+UGsUOtHKxSmwvm/QCeEJyVj8DoaD/vG8TT48e8ak5NpYxJr5xHH9IFqq8t
 YAvnZ2hPjB3HlpNIXKknQkVDy+4yoERbqeRXJlsM+JaBV8NeLk3odrNNhSY83wC+htp4
 8ClX7hw9nyk4TEw36J/sIbDbs19x5q45jlYrOteC93PVCFCkWbg3zCyh/3289ej30g1f
 ZPSw==
X-Gm-Message-State: AOJu0Yy1cc+T7Kd2JtaIybV3BpGOI75PgtcbLWCCdP5SbijG49QiAOvB
 L8j9V72tC7y3etM2ufX2y/USFq7fO12S10XdtJW3UNQGimMm8UJuWrSdGq6WL9Zm+OCNtvPfCkk
 QkM9tbXjfiFKjUQSDvSjgdG9ovYQCjd2EAO9vpRQyYn1dZ8Lk9YF2qmexffVcamBiQzpS6o9n53
 3LbWMtT/nSiBjtfSpI8+bPAsQewZvc69seXLeeeM1t
X-Gm-Gg: ATEYQzwK2USVNlCWLFTbig61ZhtON+4DpVba6fk9S6bxrWiuG6sFUMHCpZ1ov3wdiFZ
 wx7xae2vgKyacNtnpBChL6nyzS71u24pGw20wQFiMMH3a7gUnXgu0T6AeVlEfcwP5zIGhTXWJqf
 D2PTOJ3+hHIzlLbjw799CP3lSuTCMgNn1qNIU+H43hd7x6viRVVqQZSWSVZofbEIr1LXaHc3cBL
 kez4pMiO0MYFfvWMoJ0WnylCHovV1Js/NO77cSxBxPuwwFPakBf7TEvoHFsmkxsYNk8KbJRX3iJ
 NUFGxhyj5cLUwTKjnrD+5ofnbJk8oDFlMoVeVt372eRk1htNNfb5bn7Y6XoawHepU/NgVxQaGcu
 AWkT1dfcpm8Od7ELK9dYv2QafwAu3fmzc2gv3JwC3LxN4UeInWVTFzO2Y1pmTw/NBXjZ9gipafH
 U1sUSM70vrXmlb9fNia9OwNQEL
X-Received: by 2002:a05:600c:a40e:b0:485:4136:99a8 with SMTP id
 5b1f17b1804b1-48716042b35mr5058505e9.22.1774371427458; 
 Tue, 24 Mar 2026 09:57:07 -0700 (PDT)
X-Received: by 2002:a05:600c:a40e:b0:485:4136:99a8 with SMTP id
 5b1f17b1804b1-48716042b35mr5058145e9.22.1774371426698; 
 Tue, 24 Mar 2026 09:57:06 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871174f2desm79948305e9.9.2026.03.24.09.57.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 09:57:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] treewide: replace qemu_hw_version() with QEMU_HW_VERSION
Date: Tue, 24 Mar 2026 17:57:05 +0100
Message-ID: <20260324165705.785605-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The version is never set on 2.5+ machine types, so qemu_hw_version() and
qemu_set_hw_version() are not needed anymore.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/core/boards.h  |  6 ------
 include/qemu/hw-version.h | 15 ---------------
 hw/ide/core.c             |  2 +-
 hw/scsi/megasas.c         |  2 +-
 hw/scsi/scsi-bus.c        |  2 +-
 hw/scsi/scsi-disk.c       |  2 +-
 system/vl.c               |  4 ----
 target/s390x/cpu_models.c |  2 +-
 util/osdep.c              | 12 ------------
 9 files changed, 5 insertions(+), 42 deletions(-)

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index f85f31bd90d..b8dad0a1074 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -197,11 +197,6 @@ typedef struct {
  *    used to provide @cpu_index to socket number mapping, allowing
  *    a machine to group CPU threads belonging to the same socket/package
  *    Returns: socket number given cpu_index belongs to.
- * @hw_version:
- *    Value of QEMU_VERSION when the machine was added to QEMU.
- *    Set only by old machines because they need to keep
- *    compatibility on code that exposed QEMU_VERSION to guests in
- *    the past (and now use qemu_hw_version()).
  * @possible_cpu_arch_ids:
  *    Returns an array of @CPUArchId architecture-dependent CPU IDs
  *    which includes CPU IDs for present and possible to hotplug CPUs.
@@ -297,7 +292,6 @@ struct MachineClass {
     const char *default_display;
     const char *default_nic;
     GPtrArray *compat_props;
-    const char *hw_version;
     ram_addr_t default_ram_size;
     const char *default_cpu_type;
     bool default_kernel_irqchip_split;
diff --git a/include/qemu/hw-version.h b/include/qemu/hw-version.h
index 730a8c904d9..a40a6c204a6 100644
--- a/include/qemu/hw-version.h
+++ b/include/qemu/hw-version.h
@@ -7,21 +7,6 @@
 #ifndef QEMU_HW_VERSION_H
 #define QEMU_HW_VERSION_H
 
-/*
- * Starting on QEMU 2.5, qemu_hw_version() returns "2.5+" by default
- * instead of QEMU_VERSION, so setting hw_version on MachineClass
- * is no longer mandatory.
- *
- * Do NOT change this string, or it will break compatibility on all
- * machine classes that don't set hw_version.
- */
 #define QEMU_HW_VERSION "2.5+"
 
-/* QEMU "hardware version" setting. Used to replace code that exposed
- * QEMU_VERSION to guests in the past and need to keep compatibility.
- * Do not use qemu_hw_version() in new code.
- */
-void qemu_set_hw_version(const char *);
-const char *qemu_hw_version(void);
-
 #endif
diff --git a/hw/ide/core.c b/hw/ide/core.c
index b45abf067b2..d6719dbf31d 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -2660,7 +2660,7 @@ int ide_init_drive(IDEState *s, IDEDevice *dev, IDEDriveKind kind, Error **errp)
     if (dev->version) {
         pstrcpy(s->version, sizeof(s->version), dev->version);
     } else {
-        pstrcpy(s->version, sizeof(s->version), qemu_hw_version());
+        pstrcpy(s->version, sizeof(s->version), QEMU_HW_VERSION);
     }
 
     ide_reset(s);
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index f62e420a91e..0276886d594 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -782,7 +782,7 @@ static int megasas_ctrl_get_info(MegasasState *s, MegasasCmd *cmd)
 
     memcpy(info.product_name, base_class->product_name, 24);
     snprintf(info.serial_number, 32, "%s", s->hba_serial);
-    snprintf(info.package_version, 0x60, "%s-QEMU", qemu_hw_version());
+    snprintf(info.package_version, 0x60, "%s-QEMU", QEMU_HW_VERSION);
     memcpy(info.image_component[0].name, "APP", 3);
     snprintf(info.image_component[0].version, 10, "%s-QEMU",
              base_class->product_version);
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 9b8656dd832..1a6b181b9d6 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -703,7 +703,7 @@ static bool scsi_target_emulate_inquiry(SCSITargetReq *r)
         r->buf[7] = 0x10 | (r->req.bus->info->tcq ? 0x02 : 0); /* Sync, TCQ.  */
         memcpy(&r->buf[8], "QEMU    ", 8);
         memcpy(&r->buf[16], "QEMU TARGET     ", 16);
-        pstrcpy((char *) &r->buf[32], 4, qemu_hw_version());
+        pstrcpy((char *) &r->buf[32], 4, QEMU_HW_VERSION);
     }
     return true;
 }
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index a5201855352..5ba5b46c4f4 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2543,7 +2543,7 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
     }
 
     if (!s->version) {
-        s->version = g_strdup(qemu_hw_version());
+        s->version = g_strdup(QEMU_HW_VERSION);
     }
     if (!s->vendor) {
         s->vendor = g_strdup("QEMU");
diff --git a/system/vl.c b/system/vl.c
index 38d7b849e0a..246623b3196 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2212,10 +2212,6 @@ static void qemu_create_machine(QDict *qdict)
 
     cpu_exec_init_all();
 
-    if (machine_class->hw_version) {
-        qemu_set_hw_version(machine_class->hw_version);
-    }
-
     /*
      * Get the default machine options from the machine if it is not already
      * specified either by the configuration file or by the command line.
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 954a7a99a9e..0b88868289b 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -955,7 +955,7 @@ static void s390_qemu_cpu_model_class_init(ObjectClass *oc, const void *data)
 
     xcc->is_migration_safe = true;
     xcc->desc = g_strdup_printf("QEMU Virtual CPU version %s",
-                                qemu_hw_version());
+                                QEMU_HW_VERSION);
 }
 
 static void s390_max_cpu_model_class_init(ObjectClass *oc, const void *data)
diff --git a/util/osdep.c b/util/osdep.c
index 000e7daac8b..4a8b8b5a90f 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -31,8 +31,6 @@
 #include "qemu/hw-version.h"
 #include "monitor/monitor.h"
 
-static const char *hw_version = QEMU_HW_VERSION;
-
 int socket_set_cork(int fd, int v)
 {
 #if defined(SOL_TCP) && defined(TCP_CORK)
@@ -533,16 +531,6 @@ ssize_t qemu_send_full(int s, const void *buf, size_t count)
     return total;
 }
 
-void qemu_set_hw_version(const char *version)
-{
-    hw_version = version;
-}
-
-const char *qemu_hw_version(void)
-{
-    return hw_version;
-}
-
 #ifdef _WIN32
 static void socket_cleanup(void)
 {
-- 
2.53.0


