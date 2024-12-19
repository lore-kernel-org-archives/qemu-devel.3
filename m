Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48360E7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJIX-0000cC-5e; Thu, 19 Dec 2024 11:22:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOIcu-0004q4-LG
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:39:48 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOIcs-0004Y4-SQ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:39:48 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385deda28b3so664876f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 07:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734622785; x=1735227585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ISSyZu80+Z0LOt9qrMxsW+Lah1hE0o+0ErPwOcAlXN4=;
 b=tV/VXglmIF027UnmiObX02RWTvIWB2IeOErnf+nEh3k42wAvXhQi+BHvFReGtE4o2d
 NUhDZ8FVj3foKFXkkMOGKu9Df5EyfNUndrH82+4hHgTXylTckZpyBuN65tSM2Ef26Eon
 8FLbB5ibhC34D0R7glNGhaI4fqHxCxkMKqDkBaUoRgBKrRuBEaWD8YN5MJob6QcHhO5r
 nf7h6EwCUTj2QLt6Nvj9ggxxLo5g9f9kkX6joCauID8Lf1i0MDkKdd3+bme7j9/tQon0
 +j/txj/NXVPBZrCQl11wSTH64Jb/Exc9XKgfeuHKtTN5k1wHR8GGmO75Oc8s/8OSKtvS
 mVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734622785; x=1735227585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ISSyZu80+Z0LOt9qrMxsW+Lah1hE0o+0ErPwOcAlXN4=;
 b=XrYs17oe17u4lgcptoAzm028K0y7p7iiYbjD2iaslakhSuqMoDCXb5sHu+grkqoBK2
 PDca/OSq25OcOgK47OV6jHlKGNsRu1crFGMIqaWx9jCzLQdRqinU6VfUZmzAdz9lXwMc
 ZKikpNdqnQuaDUawtnYqTC/sahrJ8bLSyOSblZvbErz2N/C+mSkGytr24uTT+/l7sFgZ
 Smst/G4xvGPwxYm17je59yFR6squGM9NFTCGcgvEqEUkAAGyWhbDjrYRlypTisYrMDCG
 HZ/CRc0wX/vLUzdEP/qQRNwWbXyxcNtMysM/qin46YlRIyiwPtVSwCOFaTbDMtTosray
 ApqA==
X-Gm-Message-State: AOJu0YxcjUQAV/4uAOED6eb9Du2vi2zDr80J8UzjSoFjs1GgLdiCMAh4
 XVbSsCGOSihlOqDuW0C3hdu4/RLvTdtx5egR26giqLLBmZw5edavvBO9sgEald0o5kQNfqwHt0E
 +
X-Gm-Gg: ASbGncukkxq8h+eaLnG5e4kcvSlEK4MIB7FcWu5zoCL8gxTeGVWkXMFh+XF03TK+jG9
 PFJJ/ZZHcq2gDXN7iWKoDl1fA1//G5WxqKvGKkSeUvsyathUBSv3VvZw6O3otTRj/XEaAm6bTlE
 6EYxEw3AiaWPs2Z8Zz5DUDqJ4uqMUPHXNYbTrVOahm6V5DZoAdYhjC/6rIgfUhPvD6IxtFmxKXH
 1gP131pEiWSs3RL0ykuPES+VjAxr6iyQHylupqcagEvRY0fuZnem+gmtMKRqQ36iyYGcdFzGTKG
 v/OF
X-Google-Smtp-Source: AGHT+IGsBFx3gRdGZ8dbbmXiiGC5S8eUniiw7NRzNAZmFthEqd6n6t7RPGfaSDyl3FduFf+EbjAdGg==
X-Received: by 2002:a5d:47c8:0:b0:382:3754:38fa with SMTP id
 ffacd0b85a97d-388e4d96c35mr8177590f8f.51.1734622785043; 
 Thu, 19 Dec 2024 07:39:45 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c828ba0sm1802220f8f.14.2024.12.19.07.39.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Dec 2024 07:39:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 08/10] hw/misc/vmcoreinfo: Implement 'vmcore-info' object
Date: Thu, 19 Dec 2024 16:38:55 +0100
Message-ID: <20241219153857.57450-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219153857.57450-1-philmd@linaro.org>
References: <20241219153857.57450-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

'vmcore-info' object allow to transition from '-device'
to 'object', following the deprecation process.

No need to modify VMCoreInfoState since DeviceState
already inherits from Object state.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/misc/vmcoreinfo.h |  4 ++-
 hw/misc/vmcoreinfo.c         | 48 +++++++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/include/hw/misc/vmcoreinfo.h b/include/hw/misc/vmcoreinfo.h
index 122c69686b0..d4cce42cee6 100644
--- a/include/hw/misc/vmcoreinfo.h
+++ b/include/hw/misc/vmcoreinfo.h
@@ -16,8 +16,10 @@
 #include "standard-headers/linux/qemu_fw_cfg.h"
 #include "qom/object.h"
 
+#define TYPE_VMCOREINFO "vmcore-info"
+OBJECT_DECLARE_SIMPLE_TYPE(VMCoreInfoState, VMCOREINFO)
+
 #define TYPE_VMCOREINFO_DEVICE "vmcoreinfo"
-typedef struct VMCoreInfoState VMCoreInfoState;
 DECLARE_INSTANCE_CHECKER(VMCoreInfoState, VMCOREINFO_DEVICE,
                          TYPE_VMCOREINFO_DEVICE)
 
diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
index a0511ea0da4..e2258e08fb1 100644
--- a/hw/misc/vmcoreinfo.c
+++ b/hw/misc/vmcoreinfo.c
@@ -12,11 +12,11 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu/module.h"
 #include "sysemu/reset.h"
 #include "hw/nvram/fw_cfg.h"
 #include "migration/vmstate.h"
 #include "hw/misc/vmcoreinfo.h"
+#include "qom/object_interfaces.h"
 
 static const VMStateDescription vmstate_vmcoreinfo = {
     .name = "vmcoreinfo",
@@ -32,6 +32,11 @@ static const VMStateDescription vmstate_vmcoreinfo = {
     },
 };
 
+static char *vmcoreinfo_get_vmstate_id(VMStateIf *vmif)
+{
+    return g_strdup(TYPE_VMCOREINFO);
+}
+
 static void fw_cfg_vmci_write(void *opaque, off_t offset, size_t len)
 {
     VMCoreInfoState *s = opaque;
@@ -88,6 +93,32 @@ static void vmcoreinfo_device_realize(DeviceState *dev, Error **errp)
     vmcoreinfo_realize(VMCOREINFO_DEVICE(dev), errp);
 }
 
+static bool vmcoreinfo_can_be_deleted(UserCreatable *uc)
+{
+    return false;
+}
+
+static void vmcoreinfo_complete(UserCreatable *uc, Error **errp)
+{
+    if (vmstate_register_any(VMSTATE_IF(uc), &vmstate_vmcoreinfo, uc) < 0) {
+        error_setg(errp, "%s: Failed to register vmstate", TYPE_VMCOREINFO);
+    }
+
+    vmcoreinfo_realize(VMCOREINFO(uc), errp);
+}
+
+static void vmcoreinfo_class_init(ObjectClass *oc, void *data)
+{
+    UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
+    VMStateIfClass *vc = VMSTATE_IF_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
+
+    ucc->complete = vmcoreinfo_complete;
+    ucc->can_be_deleted = vmcoreinfo_can_be_deleted;
+    vc->get_id = vmcoreinfo_get_vmstate_id;
+    rc->phases.hold = vmcoreinfo_reset_hold;
+}
+
 static void vmcoreinfo_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -106,6 +137,18 @@ static const TypeInfo vmcoreinfo_types[] = {
         .parent         = TYPE_DEVICE,
         .instance_size  = sizeof(VMCoreInfoState),
         .class_init     = vmcoreinfo_device_class_init,
+    },
+    {
+        .name           = TYPE_VMCOREINFO,
+        .parent         = TYPE_OBJECT,
+        .instance_size  = sizeof(VMCoreInfoState),
+        .class_init     = vmcoreinfo_class_init,
+        .interfaces = (InterfaceInfo[]) {
+            { TYPE_RESETTABLE_INTERFACE },
+            { TYPE_USER_CREATABLE },
+            { TYPE_VMSTATE_IF },
+            { }
+        }
     }
 };
 
@@ -116,6 +159,9 @@ VMCoreInfoState *vmcoreinfo_find(void)
     Object *obj;
 
     obj = object_resolve_path_type("", TYPE_VMCOREINFO_DEVICE, NULL);
+    if (!obj) {
+        obj = object_resolve_path_type("", TYPE_VMCOREINFO, NULL);
+    }
 
     return obj ? (VMCoreInfoState *)obj : NULL;
 }
-- 
2.47.1


