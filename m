Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F35E77183
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 03:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN292-0007Ka-0J; Sun, 15 Dec 2024 22:51:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN28z-0007JG-7z
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:41 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN28x-000601-PG
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:41 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-71e17ab806bso2057954a34.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 19:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734321098; x=1734925898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KGgYfZIWXE3DZiMY5yn3WIrPYpF5c3+wzoPPw4T2PUk=;
 b=BDbkSqqt3blRE4+BFl9FhCnWNwaDAqLQT1loSjprnp9yyHkr4/vET3he1EMchU+ncT
 VHh85yGSzkGy1lHSOvX+CKfNtUYAF4flKxmo6wlACmbTvu5QePA6Hwb7TkDQhrusGoDR
 Bm7pkRP32UjeuXmXlutECFvlosdpkwjVi2E1flom5/2q0xh6psI6yLfmVsAGcWpQ+VJ8
 ly0SyAJzFlOds9DoMWrkitk07AUC0qh/EWSKpmyAaziQJwxqP+lszAWLgyKv5NmEfae0
 1ft4b5aYztdA/xldIqVs07gJEVet5zDqB0VVgkVM+uVJrBRWojvC5TG6tdEFvOMHaJGw
 1HBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734321098; x=1734925898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KGgYfZIWXE3DZiMY5yn3WIrPYpF5c3+wzoPPw4T2PUk=;
 b=K3F7MwyJPpokG3zbXJ8YLII9GTOvNKJkjJNLBEH50G/NoDDfDA3v+U/Zjoa4Ue6Bu2
 MNVK1NuQrUAL8uS5nQPf8877OExFg+tD8lLKjXy5rfpbLO+18/KDR6liM5QFMOgifNF2
 cc2BfFZ/mgivFPHuliHnlfDI5xgOClp5OQV8D0GI35TaGVMylhACWXtNPSi6RQYx0/dv
 48fLBxSsojJF19JRQtdb4n/YC0IIv4XtAKb6S4xw44bnhJiUjQFfbfMVEyX/pUIszxEU
 IqVbFpF2FOve3ubK1MIeRDroq0njc+xB/xbrGrMY+ptQ70gjCMfvd8mt4Xac9iIAlD6p
 eBNw==
X-Gm-Message-State: AOJu0Yy3/VP4LFiPRrxNuYayWQnAW+sIlTd309g9ABSUyiEMZUlu/ybH
 dwS/nhHbXvZPl9EfAhUZKUSiFF85bYi98VBOnbTjayNrqt4BAYIO2IUbYkyFeGvFPmIUifko2k3
 2l2BT1hQj
X-Gm-Gg: ASbGnct+oOixyHLelgFxdqCAUcdAQbwJfwd23s/wZ4G8vmyI8hnOQ1rBdO8zA04KHIH
 +kZes2vh+uSZAPflCpqTBq2AP3ZD0o8SdZH954kM//HwEqrLECs+YfpM3dQvFSvNL6uuZlm1AM2
 CRKmgugoHq9sALjURvgWHEZG5PJpE0Fyq47K2/I/mhH3xUVcu0HURNpF/eOzz8vISs7TPi1BgIL
 ZIWmiLP3bvM8jGah7tsl8Btg/iQHxu8y9lpXwLJMCU1vj7ux8HDHe2l/45AiLX03yrWP7wajeIL
 GMy5sn/LVJ2fKk/LSUq5b4lyA6KXOv5rnRO5t8jAOV0=
X-Google-Smtp-Source: AGHT+IGs4P/Bs1TZeDRhVX9/h5BOjZLCru1kUYYkE84mJCmsJk6rxHHDDoKGB6CPFIO/KM7uedc39A==
X-Received: by 2002:a05:6830:2aa7:b0:71d:62ad:5262 with SMTP id
 46e09a7af769-71e3b8762c6mr6142388a34.10.1734321098456; 
 Sun, 15 Dec 2024 19:51:38 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f33a93a6d1sm1287493eaf.33.2024.12.15.19.51.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 19:51:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/24] include/hw/qdev-core: Detect most empty Property lists
 at compile time
Date: Sun, 15 Dec 2024 21:50:57 -0600
Message-ID: <20241216035109.3486070-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216035109.3486070-1-richard.henderson@linaro.org>
References: <20241216035109.3486070-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/qdev-core.h    | 8 ++++++++
 hw/core/qdev-properties.c | 2 +-
 migration/migration.c     | 2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 5be9844412..b2859d1e39 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -943,6 +943,14 @@ char *qdev_get_own_fw_dev_path_from_handler(BusState *bus, DeviceState *dev);
  */
 void device_class_set_props(DeviceClass *dc, const Property *props);
 
+/* Validate at least one Property, plus the terminator. */
+#define device_class_set_props(DC, PROPS) \
+    do {                                                                \
+        QEMU_BUILD_BUG_ON(sizeof(PROPS) != sizeof(const Property *) &&  \
+                          sizeof(PROPS) < 2 * sizeof(Property));        \
+        (device_class_set_props)(DC, PROPS);                            \
+    } while (0)
+
 /**
  * device_class_set_parent_realize() - set up for chaining realize fns
  * @dc: The device class
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 315196bd85..de618a964a 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1061,7 +1061,7 @@ static void qdev_class_add_legacy_property(DeviceClass *dc, const Property *prop
         NULL, NULL, (Property *)prop);
 }
 
-void device_class_set_props(DeviceClass *dc, const Property *props)
+void (device_class_set_props)(DeviceClass *dc, const Property *props)
 {
     const Property *prop;
 
diff --git a/migration/migration.c b/migration/migration.c
index 8c5bd0a75c..6b3b85d31e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3822,7 +3822,7 @@ static void migration_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->user_creatable = false;
-    device_class_set_props(dc, migration_properties);
+    (device_class_set_props)(dc, migration_properties);
 }
 
 static void migration_instance_finalize(Object *obj)
-- 
2.43.0


