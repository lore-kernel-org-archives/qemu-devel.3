Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE682E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJFR-0001mS-Oh; Thu, 19 Dec 2024 11:19:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOIcT-0004bQ-85
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:39:21 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOIcR-0004Rg-OP
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:39:21 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4361fe642ddso9578555e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 07:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734622758; x=1735227558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fSUrXqY3vKb6Y+xc3NUnoWjHDPec55tB8oXd/H8ApGI=;
 b=LgDSwqTUptkWoSEP2LpMySbEDAwN/XC0aVneMvdtHhMW23R2273cc0aw4AewyrNgzS
 nKM7vSR+W0EDxCt9l1BpYmVAjziPpNghuB5acCVxzugll8LlsDC4LfDWi06iFTzj3sOP
 b7I1mazZNPNqLsBdteXm21rANWMJNs282K97gqIBzREANRNN2+rjeSB+QiM6IkPzmjKy
 mYynOY1dL+k7uz2SvAnjt7YmJWYiIvT5sers7pU4i5pgiGaFwP0nkoX9ixflhwX+XBgq
 DvCr5tAIJpX21Ylkcw/rdf9+CROkj3rVagJSUuhQsQPJq9xLViNniVbXg60rRQWUOWqn
 1L2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734622758; x=1735227558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fSUrXqY3vKb6Y+xc3NUnoWjHDPec55tB8oXd/H8ApGI=;
 b=kfKMe8IrksycSkXzZWbV147lxJ47Onv8+mIFsnR080AbW12OMqWFYV0Kf1/fm7Saqr
 8+PqSDR0nOfIWc06XJIiBFFbQQDF3Ypmb/SPpkkF+FHpw2D8wq8BoITV8Ol0FF3YSwtw
 ql57U/CmeDTMOEPXdMtJXJB+1Bm7DuHZgurFT4xPvIxuJTjlbjpPBebHn2mbli1J6R9Q
 CgQVIvLcA47FREhdru9LXcHbt/GMPCvrpVmlmbaDRWrR8CQ9C0J8Yu7dopboJ0kBhjcx
 uQWeucjKglSI9BLwC4zzGObGqzxbhDZrZzbqEMTWWqf1WRKoJOkGRkdEOD6DtOGpZcSa
 NmXA==
X-Gm-Message-State: AOJu0YzDwxytzi8o6ekx+OBLr6pjaeAcnjEBJ3FVgzVf1IbmCt/3QsTe
 GOABZYrVX8QNhdvkm1DxQmCqDV/fxdGAK5PejO7130knppCVJJBwEXo4KJPz/d2l1JGjnoZPkZK
 p
X-Gm-Gg: ASbGncvtjiscO1KorKguCYve6OTA+ipZWEf6ZQJJ/bk2w2tvmW1kxLjzVus7JqakAZn
 GsyxwFj5QetSHs0MeIqONJswv5lTPT0gfFd1uOyrsz/1rmjjhN+VFZ1gFf8B/nHun+D4c9uBa/P
 Z6slMiLsyUttj6YnKZxVWsww9aHwfCwmUGMnoZuHZd6MBV+FxhH+KeSyOCjl7JGEKP9gzMBtxgX
 0nqXb0FWzKx4QyTf5IF9R2qeQfSfoWfWQxggLo35H2rozDZvnwOBBRKiobKYXyVfvfxysFoPh/0
 +vn9
X-Google-Smtp-Source: AGHT+IGvWED1Jq74g7NcAbgkQDk9YzBZGMpsFWZ3LtiDorAumzm0I2si7sK1vs6So0DMLBM16lnmYw==
X-Received: by 2002:a05:600c:524f:b0:434:fddf:5c0a with SMTP id
 5b1f17b1804b1-436553452d7mr74615505e9.3.1734622758007; 
 Thu, 19 Dec 2024 07:39:18 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8471dcsm1822152f8f.48.2024.12.19.07.39.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Dec 2024 07:39:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 03/10] hw/misc/vmcoreinfo: Un-inline vmcoreinfo_find()
Date: Thu, 19 Dec 2024 16:38:50 +0100
Message-ID: <20241219153857.57450-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219153857.57450-1-philmd@linaro.org>
References: <20241219153857.57450-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
 include/hw/misc/vmcoreinfo.h | 13 ++++++-------
 hw/misc/vmcoreinfo.c         | 16 +++++++++++++---
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/include/hw/misc/vmcoreinfo.h b/include/hw/misc/vmcoreinfo.h
index 0b7b55d400a..da1066d540c 100644
--- a/include/hw/misc/vmcoreinfo.h
+++ b/include/hw/misc/vmcoreinfo.h
@@ -30,12 +30,11 @@ struct VMCoreInfoState {
     FWCfgVMCoreInfo vmcoreinfo;
 };
 
-/* returns NULL unless there is exactly one device */
-static inline VMCoreInfoState *vmcoreinfo_find(void)
-{
-    Object *o = object_resolve_path_type("", VMCOREINFO_DEVICE, NULL);
-
-    return o ? VMCOREINFO(o) : NULL;
-}
+/**
+ * vmcoreinfo_find:
+ *
+ * Returns NULL unless there is exactly one instance.
+ */
+VMCoreInfoState *vmcoreinfo_find(void);
 
 #endif
diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
index ad5a4dec596..c5bb5c9fa52 100644
--- a/hw/misc/vmcoreinfo.c
+++ b/hw/misc/vmcoreinfo.c
@@ -42,11 +42,12 @@ static void vmcoreinfo_realize(DeviceState *dev, Error **errp)
     /* for gdb script dump-guest-memory.py */
     static VMCoreInfoState * volatile vmcoreinfo_state G_GNUC_UNUSED;
 
-    /* Given that this function is executing, there is at least one VMCOREINFO
-     * device. Check if there are several.
+    /*
+     * Given that this function is executing, there is at least one
+     * VMCOREINFO instance. Check if there are several.
      */
     if (!vmcoreinfo_find()) {
-        error_setg(errp, "at most one %s device is permitted",
+        error_setg(errp, "at most one %s instance is permitted",
                    VMCOREINFO_DEVICE);
         return;
     }
@@ -103,3 +104,12 @@ static const TypeInfo vmcoreinfo_types[] = {
 };
 
 DEFINE_TYPES(vmcoreinfo_types)
+
+VMCoreInfoState *vmcoreinfo_find(void)
+{
+    Object *obj;
+
+    obj = object_resolve_path_type("", TYPE_VMCOREINFO_DEVICE, NULL);
+
+    return obj ? (VMCoreInfoState *)obj : NULL;
+}
-- 
2.47.1


