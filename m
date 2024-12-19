Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B1EE7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJIp-0002Be-BE; Thu, 19 Dec 2024 11:23:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOId5-0004vb-5X
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:39:59 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOId3-0004ZZ-Cj
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:39:58 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38632b8ae71so741999f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 07:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734622795; x=1735227595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8jM7iK7CzjLBlq0GL2o2lmBr4BfhFWF4uDH24qr2bSs=;
 b=iqajmz2Tx9hR5muu1ccV6gqGBpBLH6QT5nNHZiqcYXc28xWOQq9toGzfqrOjACuTd0
 T4bZGS0RQ7ClcCMJIlh/IxNrdiGI7WicqHLj0tnvvRKyYunz2P65J6ZZV8nv4CBd3beB
 HRx7gQ4/fSQV/5ZXXtKadvEiAjbhM+ZPsekUaN14LY9YtdvTSGQ94RnbEq9dAmavgoeN
 bt3YsYtFBt3vDOy0zUagKiUhX+Nn2BqKSXW5MTxETBhQl7FSF14tVaYfuJoeTGcZaDQ2
 DrlzlUrZha1+Roj9p2ukXTM30nts2wJSCithlp+lmkQbOxVliVszkXOLpVTzvprXNtpu
 KZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734622795; x=1735227595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8jM7iK7CzjLBlq0GL2o2lmBr4BfhFWF4uDH24qr2bSs=;
 b=hVFtiE/5ionemynn5AgUyUL+8X4Ez+2OTHu1Y5kj3UKWBR9g4YqccD1qfDG3G7eASN
 HknC2HgscIKCQFTdTeV4rYTxDkj/KOfsg2XggA9KWVFlzrdlcUrQgYYYVZSutnDY8hF2
 E57IZ/JUgpb2kD8sSw/lAnMXe8GyCMKvXvNDoo1rki5OkppizSMmqpGB/a5Y79ID1hgw
 Kpa4MCVDu+VLWjsbZixFGXg7dDUJzJk1SBwZ+vGiH8zqSsZRp8dyxlGVhPW2ckCtx8oj
 y2Nu1S+oeejPAJqEs97si2Ct27+XPqcfJVhpb4xamUCRt2rD6YcxvpDBCC8U3HYJQbso
 eWeA==
X-Gm-Message-State: AOJu0Yx10wCowDmu0D4H7kwKqkL4phT2mYlOVgD5K+1Io4SOcfBrutOg
 T6156hyCUODe7elcTbU7yuxs18i/AIp7UGUp4/7qE7MEe+uJ30hqyFnX7xqjRe/6RXHl4AmV1hG
 q
X-Gm-Gg: ASbGnctqKeMN/yAVg5aSelYk89fHdkgZanivYKCdCaeCwxy5cU6Rg2xFDtLg3rU3tix
 +GEexLDyciPCBANR1gJc4AYxL/jrOmPhahmm306ynaJHtsLSh9j/7zs2KapVtvwfHNdU2u4Vty1
 0P8YdfoH7hBITsQbUndTcavUsPNhPmflTjJ5ICOuQjglG/PfEb45xJJUY9HPLus7Lb7VggQXJgn
 +EbxvPZVSw/RLZke0k52ITdrCWTnhqBno6NN7ZKAZaK/msfv8ow74r2SWav0/WDGpG1Bln8bjsk
 McoP
X-Google-Smtp-Source: AGHT+IFDP3fNJA6xBv/hfaKPgC0bZEnVC+6UMLDZJxil0bxoO2WYS57R0WmK+DgL2vSBssckSHhikA==
X-Received: by 2002:a05:6000:178b:b0:386:3835:9fec with SMTP id
 ffacd0b85a97d-388e4d8fbc0mr7568848f8f.44.1734622795613; 
 Thu, 19 Dec 2024 07:39:55 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4364a376846sm79508525e9.0.2024.12.19.07.39.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Dec 2024 07:39:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-10.2 10/10] hw/misc/vmcoreinfo: Remove legacy '-device
 vmcoreinfo'
Date: Thu, 19 Dec 2024 16:38:57 +0100
Message-ID: <20241219153857.57450-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219153857.57450-1-philmd@linaro.org>
References: <20241219153857.57450-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst       |  5 ----
 docs/about/removed-features.rst |  5 ++++
 include/hw/misc/vmcoreinfo.h    |  3 +--
 hw/misc/vmcoreinfo.c            | 44 ++++++---------------------------
 4 files changed, 13 insertions(+), 44 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 57a3d734081..d6809f94ea1 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -79,11 +79,6 @@ described with -smp are supported by the target machine.
 
 Use ``-run-with user=..`` instead.
 
-``-device vmcoreinfo`` (since 10.0)
-'''''''''''''''''''''''''''''''''''
-
-Use ``-object vmcore-info`` instead.
-
 
 User-mode emulator command line arguments
 -----------------------------------------
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index cb1388049a8..6fedf13c133 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -555,6 +555,11 @@ to produce an odd effect (rotating input but not display output). But
 this was never intended or documented behaviour, so we have dropped
 the options along with the machine models they were intended for.
 
+``-device vmcoreinfo`` (removed in 10.2)
+''''''''''''''''''''''''''''''''''''''''
+
+``-device vmcoreinfo`` has been replaced by ``-object vmcore-info``.
+
 User-mode emulator command line arguments
 -----------------------------------------
 
diff --git a/include/hw/misc/vmcoreinfo.h b/include/hw/misc/vmcoreinfo.h
index d4cce42cee6..56af12d33a4 100644
--- a/include/hw/misc/vmcoreinfo.h
+++ b/include/hw/misc/vmcoreinfo.h
@@ -12,7 +12,6 @@
 #ifndef VMCOREINFO_H
 #define VMCOREINFO_H
 
-#include "hw/qdev-core.h"
 #include "standard-headers/linux/qemu_fw_cfg.h"
 #include "qom/object.h"
 
@@ -26,7 +25,7 @@ DECLARE_INSTANCE_CHECKER(VMCoreInfoState, VMCOREINFO_DEVICE,
 typedef struct fw_cfg_vmcoreinfo FWCfgVMCoreInfo;
 
 struct VMCoreInfoState {
-    DeviceState parent_obj;
+    Object parent_obj;
 
     bool has_vmcoreinfo;
     FWCfgVMCoreInfo vmcoreinfo;
diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
index e2258e08fb1..36d1143722e 100644
--- a/hw/misc/vmcoreinfo.c
+++ b/hw/misc/vmcoreinfo.c
@@ -54,8 +54,9 @@ static void vmcoreinfo_reset_hold(Object *obj, ResetType type)
     s->vmcoreinfo.host_format = cpu_to_le16(FW_CFG_VMCOREINFO_FORMAT_ELF);
 }
 
-static void vmcoreinfo_realize(VMCoreInfoState *s, Error **errp)
+static void vmcoreinfo_complete(UserCreatable *uc, Error **errp)
 {
+    VMCoreInfoState *s = VMCOREINFO(uc);
     FWCfgState *fw_cfg = fw_cfg_find();
     /* for gdb script dump-guest-memory.py */
     static VMCoreInfoState * volatile vmcoreinfo_state G_GNUC_UNUSED;
@@ -76,6 +77,10 @@ static void vmcoreinfo_realize(VMCoreInfoState *s, Error **errp)
         return;
     }
 
+    if (vmstate_register_any(VMSTATE_IF(s), &vmstate_vmcoreinfo, s) < 0) {
+        error_setg(errp, "%s: Failed to register vmstate", TYPE_VMCOREINFO);
+    }
+
     fw_cfg_add_file_callback(fw_cfg, FW_CFG_VMCOREINFO_FILENAME,
                              NULL, fw_cfg_vmci_write, s,
                              &s->vmcoreinfo, sizeof(s->vmcoreinfo), false);
@@ -88,25 +93,11 @@ static void vmcoreinfo_realize(VMCoreInfoState *s, Error **errp)
     vmcoreinfo_state = s;
 }
 
-static void vmcoreinfo_device_realize(DeviceState *dev, Error **errp)
-{
-    vmcoreinfo_realize(VMCOREINFO_DEVICE(dev), errp);
-}
-
 static bool vmcoreinfo_can_be_deleted(UserCreatable *uc)
 {
     return false;
 }
 
-static void vmcoreinfo_complete(UserCreatable *uc, Error **errp)
-{
-    if (vmstate_register_any(VMSTATE_IF(uc), &vmstate_vmcoreinfo, uc) < 0) {
-        error_setg(errp, "%s: Failed to register vmstate", TYPE_VMCOREINFO);
-    }
-
-    vmcoreinfo_realize(VMCOREINFO(uc), errp);
-}
-
 static void vmcoreinfo_class_init(ObjectClass *oc, void *data)
 {
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
@@ -119,25 +110,7 @@ static void vmcoreinfo_class_init(ObjectClass *oc, void *data)
     rc->phases.hold = vmcoreinfo_reset_hold;
 }
 
-static void vmcoreinfo_device_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    ResettableClass *rc = RESETTABLE_CLASS(klass);
-
-    dc->vmsd = &vmstate_vmcoreinfo;
-    dc->realize = vmcoreinfo_device_realize;
-    dc->hotpluggable = false;
-    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-    rc->phases.hold = vmcoreinfo_reset_hold;
-}
-
 static const TypeInfo vmcoreinfo_types[] = {
-    {
-        .name           = TYPE_VMCOREINFO_DEVICE,
-        .parent         = TYPE_DEVICE,
-        .instance_size  = sizeof(VMCoreInfoState),
-        .class_init     = vmcoreinfo_device_class_init,
-    },
     {
         .name           = TYPE_VMCOREINFO,
         .parent         = TYPE_OBJECT,
@@ -158,10 +131,7 @@ VMCoreInfoState *vmcoreinfo_find(void)
 {
     Object *obj;
 
-    obj = object_resolve_path_type("", TYPE_VMCOREINFO_DEVICE, NULL);
-    if (!obj) {
-        obj = object_resolve_path_type("", TYPE_VMCOREINFO, NULL);
-    }
+    obj = object_resolve_path_type("", TYPE_VMCOREINFO, NULL);
 
     return obj ? (VMCoreInfoState *)obj : NULL;
 }
-- 
2.47.1


