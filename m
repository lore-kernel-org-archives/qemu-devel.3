Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD083E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6JI-0002Tn-DT; Sun, 12 Jan 2025 17:19:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6In-0001Pk-Mt
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:19:28 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Ii-0006Ws-8c
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:19:22 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385e3621518so1913029f8f.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720358; x=1737325158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kHYhV6C4zvi9bV3gw8In1CJAbx66/tuqvnD3Exk/IRE=;
 b=BTkSB3yDGhN02LKeVGCMq17rJaV61mtjQvr9mnCntm50X1K5t3Y/eiDgualPRAPSqW
 L43ipEpxyRFw2nY0M8PKEe2Z57DfiCDBdRHH9GLiUKaTqWz3TkhbAZct4sy3sZTrzsK8
 5ptygU1YAKuOFTpDwmfWhozhEXln19uvojO2xSO1lB4uRUjmpxlqBa9UYJezZZUBCtbo
 1EiLnvVf9ViySqi3hBOw72apewD9NdFW/B8n6E0usZDs4ZU2+eWNteDHEwtLc0LmoU7f
 b1yuSl3XAvYJ8XWzcGJGYMiWIhae+3HmhlFPcy6kb30PPQvO1FK9AmPlO6AQPAZ3fKOg
 x20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720358; x=1737325158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kHYhV6C4zvi9bV3gw8In1CJAbx66/tuqvnD3Exk/IRE=;
 b=oWOuWpHtJwlojgs2ZS49oAUPxDiOEArAPIcE6KfSv3PhwbDmlm9If2tZOjZDdH30UC
 dZlaCvcURLmkn2zsf4HgQLWc60m6RBLDZXlPvckNR6CRhTXfwlhxylDU6v57vOJXLtGW
 2QRbOLq/gP9TB/CJO77inlwp+IOQKHvJyQeZ+9O58GGY1ofnpresGCvTgwOTI6iXlyQm
 EHOhprcSu0VO3gbUojVW8qLQ7pERQ/1UDLMF/eRMULuWNWDmDwcJc71SGNmgYcjBQTWG
 3zJBaBr2lMJQYyT41EICsxlPgde8hAjaq79XlEOzMECjpleHrGxpxPIMfw6h/6bFSSag
 L9mQ==
X-Gm-Message-State: AOJu0YzPPWR+ZSXEvl5qQkeclPlodfRd/fKWBpPlKfO7FgSjD5umX3lc
 hnGylFHenV395tNtQ3QUmjfg3v34ZCRbgRaftlm8PKaIvz1iOawI+2uVmsmUDIQxVo01MJb5lC+
 Fyks=
X-Gm-Gg: ASbGncsrpunMQZpqzh0AfNDGANbXV6Q+rK9aKAdlS8KaCPs0x6BWiuSeVKEeMWgdNCc
 FoltQbMVQvp5vIPC/KLqFi05MM5P2px0JvY2HYCh6lFDE7Q9F7lMccFpxZ+AuhITUEsiRK0sDZ1
 haVwXQz4qVOxiLunwyThSjrLCYzTIgCfT4pO1ndi+m+aqmAgN7UCeUrPLE5PsmKFktoaDCdPBod
 Lhcq5sVSyNYmvhUZICu4Xq+Mts7uNK2BOi6YmUhEqIIvIKFthcH98q/rD6zae62HxGXYeCPBFGD
 0XUgrOizdg5u8Rx0n5WRV7aac+o1X6I=
X-Google-Smtp-Source: AGHT+IGWWfJ7LukZ04s/pKO/VaYtQ6VWRo+iNz5ZdR3snLFPPMGkR4GcjL4vbkHrICCE7fHOXWjpXg==
X-Received: by 2002:a05:6000:2a3:b0:386:4a0d:bb21 with SMTP id
 ffacd0b85a97d-38a8730a11emr16529015f8f.22.1736720358331; 
 Sun, 12 Jan 2025 14:19:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38428bsm10610306f8f.37.2025.01.12.14.19.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:19:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 22/49] hw/misc/vmcoreinfo: Rename VMCOREINFO_DEVICE ->
 TYPE_VMCOREINFO
Date: Sun, 12 Jan 2025 23:16:58 +0100
Message-ID: <20250112221726.30206-23-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Follow the assumed QOM type definition style, prefixing with
'TYPE_', and dropping the '_DEVICE' suffix which doesn't add
any value.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20250102132624.53443-1-philmd@linaro.org>
---
 include/hw/misc/vmcoreinfo.h | 7 +++----
 hw/misc/vmcoreinfo.c         | 6 +++---
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/hw/misc/vmcoreinfo.h b/include/hw/misc/vmcoreinfo.h
index 0b7b55d400a..1aa44771632 100644
--- a/include/hw/misc/vmcoreinfo.h
+++ b/include/hw/misc/vmcoreinfo.h
@@ -16,10 +16,9 @@
 #include "standard-headers/linux/qemu_fw_cfg.h"
 #include "qom/object.h"
 
-#define VMCOREINFO_DEVICE "vmcoreinfo"
+#define TYPE_VMCOREINFO "vmcoreinfo"
 typedef struct VMCoreInfoState VMCoreInfoState;
-DECLARE_INSTANCE_CHECKER(VMCoreInfoState, VMCOREINFO,
-                         VMCOREINFO_DEVICE)
+DECLARE_INSTANCE_CHECKER(VMCoreInfoState, VMCOREINFO, TYPE_VMCOREINFO)
 
 typedef struct fw_cfg_vmcoreinfo FWCfgVMCoreInfo;
 
@@ -33,7 +32,7 @@ struct VMCoreInfoState {
 /* returns NULL unless there is exactly one device */
 static inline VMCoreInfoState *vmcoreinfo_find(void)
 {
-    Object *o = object_resolve_path_type("", VMCOREINFO_DEVICE, NULL);
+    Object *o = object_resolve_path_type("", TYPE_VMCOREINFO, NULL);
 
     return o ? VMCOREINFO(o) : NULL;
 }
diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
index b1fcc22e92b..145f13a65cf 100644
--- a/hw/misc/vmcoreinfo.c
+++ b/hw/misc/vmcoreinfo.c
@@ -47,13 +47,13 @@ static void vmcoreinfo_realize(DeviceState *dev, Error **errp)
      */
     if (!vmcoreinfo_find()) {
         error_setg(errp, "at most one %s device is permitted",
-                   VMCOREINFO_DEVICE);
+                   TYPE_VMCOREINFO);
         return;
     }
 
     if (!fw_cfg || !fw_cfg->dma_enabled) {
         error_setg(errp, "%s device requires fw_cfg with DMA",
-                   VMCOREINFO_DEVICE);
+                   TYPE_VMCOREINFO);
         return;
     }
 
@@ -95,7 +95,7 @@ static void vmcoreinfo_device_class_init(ObjectClass *klass, void *data)
 
 static const TypeInfo vmcoreinfo_types[] = {
     {
-        .name           = VMCOREINFO_DEVICE,
+        .name           = TYPE_VMCOREINFO,
         .parent         = TYPE_DEVICE,
         .instance_size  = sizeof(VMCoreInfoState),
         .class_init     = vmcoreinfo_device_class_init,
-- 
2.47.1


