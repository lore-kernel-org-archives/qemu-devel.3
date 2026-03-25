Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F7C109C045
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RLy-0004oL-UY; Wed, 25 Mar 2026 12:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RLw-0004n9-MA
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RLu-0004bC-SH
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774457106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UUgZYDFnXbpRFKsK/7IcqnW5+bod3HtrYWPP2Q8eSRg=;
 b=bh2zjm5zsU4Gi6ljWp8w5zXDPqYKuxETzVvBJKeCxX/xP11ZfSmDabQ4BmTNuKj+LuZ0HD
 eHvO6NZm5SyWY55+3rvB1StzcKSbPcHbn3OKS5s3WecRDhNj64u8/BCdYxUCHPlljhJuxl
 pMbrF5siEstSXGFDfCzhPIbdbnH3+Ok=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-IapqCzNyMH-qUQuL1xdv4g-1; Wed, 25 Mar 2026 12:45:04 -0400
X-MC-Unique: IapqCzNyMH-qUQuL1xdv4g-1
X-Mimecast-MFC-AGG-ID: IapqCzNyMH-qUQuL1xdv4g_1774457104
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48532df52c5so555945e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 09:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774457103; x=1775061903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UUgZYDFnXbpRFKsK/7IcqnW5+bod3HtrYWPP2Q8eSRg=;
 b=XVs/j2ITGuaU4stnOZNxaOTo/z0mKaPsyUzx4cFImSyV3GTXzAaVwRy3BEnDnmf/kx
 YxcQMzOSKHDhhd5fTJUF1uPv/qg+GCPZqStKBcrXNPq+zVKxwcJheqFYQ9k2w+RIj5Px
 Ih3o9zJSBLWtP3Pag93zyKEbc/6nOPyCifMurscbXUey+GG5tIA1YFbvgoLOWEbxpyqF
 CalerPBiy1Y3C1Z+hXxYbajWWxAFQQBVmbRA2Rj7/MtQxCEpgwdoeGy4DwKbvf7nx1QV
 gJVgG/iHiiYAzzCw9eERX4gUQX69DJ7/SZ3jwHlnqTof6cg/X2ygohrI05s72lP/KzPk
 049A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457103; x=1775061903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UUgZYDFnXbpRFKsK/7IcqnW5+bod3HtrYWPP2Q8eSRg=;
 b=qCel54JpthKpzH424QOt/walp+np+ypg9E6B+WwEU2akDQWUWQTmXo3SHtOW7XBObD
 EHmn1GclqrR3jkTaFVO9auReoB4gCkMSaPmFwrq+GwN3s8Gh2KIhKIR8lSJEJHmmPZKi
 Zt5MiHfiQhgFdAZQwhlxm0Y8gfgYvzA7IuRobNMYBfKBX/p6xI0jH52HQj0q8PPLlNNJ
 K3HKi/WjQhRFtgh/aCZoxgrPxlYDM5sM8xL8aIgaaVd3yX0iLICRsfsoN1ZqnxFzrecK
 lgPKVat1e68NxO/H1/fqXKJ6pAr8POO78YUvq8GwuqHvKL+xtkPXLpZbUIBYpJ1CgDOx
 WaSg==
X-Gm-Message-State: AOJu0YxsAoSxfshnuIQ/cOAT2uLCE5/oALE4qDfe5UHI1BU16EQcG0td
 uTkR7SCoSyeJNSisVnpmxXfic7TDjhLvTFO0Qgk31Pl6vxXzBDkU/9ut5gvaZ63jOq/VwgaSJaD
 aM7fhqtN4gY/18osik12v/js5R9DTZtRW21tqDxAxGdvch8N95VRFlhtVxrW/z/95a9K4FZP8Ui
 14dTQFoi6Rv4RjqibvxQuo79qI/cM9vVZfAp1956Yn
X-Gm-Gg: ATEYQzwZU2b9uQHjxlUkY6D5rlOACJuQZdgOHcNAHwnSdxmvgmLUo7ed+Vov0gxTgr2
 X288dhoKSlloyroqstxr3HqB5DCgwjk+PEHkcDp+zvqJyDzAJ5k9AbhucLxv675HekCfvlT0U4V
 Z7oJXMo38KOGuCikDOMWv+Erj7ptpaChpgsC7DXL8b5vJqMRpzMp+4WtNnjOVP8uCMTC61lm8Pu
 Z3WnlJzGYXaYO+E8eHHHdH3NKZnIvRmKaDHrHSej7xKEJkj6TvJec3H7arsDQy0J4/pTtW9yrlP
 Zhet1ZxFyPTyQ6EB5C8ccN56UuNOYGj5xpvXxE4ZoVtOACLW1WUy+RQXipdeDlF4QoAu8HCtEjg
 8wqaSA/ADN7QL/hgOSX1k4qwKBZ3SgYBissjqZDMsdB1HjuEKduP1KpzQu+vWyEoMTBfkZNwu9P
 SUTvekB/xmQ+C7lUj/cUl/I3w/
X-Received: by 2002:a05:600c:4705:b0:485:a4de:f4f9 with SMTP id
 5b1f17b1804b1-4871608406dmr68358185e9.27.1774457102406; 
 Wed, 25 Mar 2026 09:45:02 -0700 (PDT)
X-Received: by 2002:a05:600c:4705:b0:485:a4de:f4f9 with SMTP id
 5b1f17b1804b1-4871608406dmr68357455e9.27.1774457101754; 
 Wed, 25 Mar 2026 09:45:01 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871e5ec998sm6608935e9.6.2026.03.25.09.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:45:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 03/19] treewide: replace qemu_hw_version() with QEMU_HW_VERSION
Date: Wed, 25 Mar 2026 17:44:37 +0100
Message-ID: <20260325164453.72127-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325164453.72127-1-pbonzini@redhat.com>
References: <20260325164453.72127-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/core/boards.h  |  6 ------
 include/qemu/hw-version.h | 18 ++++--------------
 hw/ide/core.c             |  2 +-
 hw/scsi/megasas.c         |  2 +-
 hw/scsi/scsi-bus.c        |  2 +-
 hw/scsi/scsi-disk.c       |  2 +-
 system/vl.c               |  4 ----
 target/s390x/cpu_models.c |  2 +-
 util/osdep.c              | 12 ------------
 9 files changed, 9 insertions(+), 41 deletions(-)

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
index 730a8c904d9..ce318cd8435 100644
--- a/include/qemu/hw-version.h
+++ b/include/qemu/hw-version.h
@@ -1,5 +1,5 @@
 /*
- * QEMU "hardware version" machinery
+ * QEMU "hardware version" constant
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
@@ -8,20 +8,10 @@
 #define QEMU_HW_VERSION_H
 
 /*
- * Starting on QEMU 2.5, qemu_hw_version() returns "2.5+" by default
- * instead of QEMU_VERSION, so setting hw_version on MachineClass
- * is no longer mandatory.
- *
- * Do NOT change this string, or it will break compatibility on all
- * machine classes that don't set hw_version.
+ * Starting on QEMU 2.5, devices with a version string in their
+ * identification data return "2.5+" instead of QEMU_VERSION.  Do
+ * NOT change this string as it is visible to guests.
  */
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


