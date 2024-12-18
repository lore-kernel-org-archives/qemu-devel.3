Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E00E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuKv-0001d6-3J; Wed, 18 Dec 2024 08:43:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKZ-0001Kj-AF
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:16 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKW-0005g7-Ai
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:14 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3ebadbb14dcso2195546b6e.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529390; x=1735134190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7otA0Xs37HZk5bLiR85IqtklV+XPFMVBtNOQNXWuvqQ=;
 b=oR1o/S85y3DQ3vqMmq7A6jhFtyfqeiHWQE/XqsU2a8RCSYf1BMo0K394+gWHWSPVJw
 mjDNCJMm4s/h2z2pINgvSfdHgZSEHR2ThTjdYwuO3OedX5SLYytmKsDyplmvFzlhBirB
 06NRDjv8oAI+zUmlMvMrwV6j1OOg675WGCZHh20V+tT+pl9J8KMBnpyrx9g9ShfUFJRW
 /YmD7lcxJpkMzY/RWlpq+efJEdsOr71kOLDN0QyGk2bJrVTpEUsbHqQMyaR5ksBVCWiI
 2Cj1QsvdXq0XtW1L1yqBh5r1Zc8b22/r/FWGIRkFTfiO+tTGXuMOOBRqvbgN0FS94lVV
 gFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529390; x=1735134190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7otA0Xs37HZk5bLiR85IqtklV+XPFMVBtNOQNXWuvqQ=;
 b=GANnTq3yR/9Tbm3Yf60OXt8dsK1KSNGiYh5nOm5Q330Wd3mQHLmWy736bsIqo8qv08
 UZeO90vRtzEyQ9EAiIrbu0IGEIkgpk7FUvSMYGOU8gH6WLqFQ2dNQY79+pYnr5g/QKFz
 X03hwNgUq4zADQaOegnHNlNSF5PlONyqY4HrMHlz+ZTYRBpjq92cyR7tLPxTb6L3yXwz
 WPhaTn3iK8KOuySfhEOiFzlTZfOrY2U50gbPsW88r5xDPKdOEykxadYs8+JkxaeJiI+v
 77IXgPOr7bHT3n3y0/ejPMcIsBNOuT4vbRnC0Z2JbMt+n33Degx9MXaW1AITcWmyuE7V
 rm1g==
X-Gm-Message-State: AOJu0YzBOqqDB99LUReEhO8xT2CTACYPAQWTajDp9LWhIIaYt/YxkDF9
 QmiZJ1E9jixncCOgJ04I00oBThqKFGH4i03cfOCJsHc0m2OwmRo/atmf9UfFeY7lHURV5ckHu4P
 fOlmPHYWh
X-Gm-Gg: ASbGnctJkvd8UByHxUxZkamLYfkLjCctiZ4Ie0gc5BHbW00CmgtzFsUC6vTCJ0f5R4S
 rzU9BiBu79BgXmkOzVsMpi1k07JXYFQtNsxasqLr1JykUzqwlKGVxu6dHiIHneOyo1Dcby60HPi
 HdmiXEGbZ6edVDvztJHyokwv4Syg0B5FuzFYd+qr9bjqEzIMMkwlcead/+95KC9g3lsMPb2oAzg
 7bCLAKVt8o2xXm45OwZUTCDqQ3fTyn1zRm5EOrCaUm1gtBJC9407BvwwphIhmPT
X-Google-Smtp-Source: AGHT+IHHPgJWtqc7Mm4YgLMJNiro4Ltq0dCspVGJOHWJgtXiGMbiZwpj1Sq5z023ocWmRjPmQtZkiw==
X-Received: by 2002:a05:6808:38cb:b0:3e6:35da:8f2b with SMTP id
 5614622812f47-3eccbf2d5c0mr2134084b6e.4.1734529390677; 
 Wed, 18 Dec 2024 05:43:10 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a502sm2870951b6e.9.2024.12.18.05.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 05:43:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 12/24] include/hw/qdev-core: Detect most empty Property
 lists at compile time
Date: Wed, 18 Dec 2024 07:42:39 -0600
Message-ID: <20241218134251.4724-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218134251.4724-1-richard.henderson@linaro.org>
References: <20241218134251.4724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

Add a macro expansion of device_class_set_props which can check
on the type and size of PROPS before calling the function.

Avoid the macro in migration.c because migration_properties
is defined externally with indeterminate size.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/qdev-core.h    | 17 +++++++++++++++++
 hw/core/qdev-properties.c |  2 +-
 migration/migration.c     |  2 +-
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 5be9844412..cbce3cf0b4 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -940,9 +940,26 @@ char *qdev_get_own_fw_dev_path_from_handler(BusState *bus, DeviceState *dev);
  * This will add a set of properties to the object. It will fault if
  * you attempt to add an existing property defined by a parent class.
  * To modify an inherited property you need to use????
+ *
+ * Validate that @props has at least one Property plus the terminator.
+ * Validate that the array is terminated at compile-time (with -O2),
+ * which requires the array to be const.
  */
 void device_class_set_props(DeviceClass *dc, const Property *props);
 
+#define device_class_set_props(dc, props) \
+    do {                                                                \
+        QEMU_BUILD_BUG_ON(sizeof(props) != sizeof(const Property *) &&  \
+                          sizeof(props) < 2 * sizeof(Property));        \
+        if (sizeof(props) != sizeof(const Property *)) {                \
+            size_t props_count_ = sizeof(props) / sizeof(Property) - 1; \
+            if ((props)[props_count_].name != NULL) {                   \
+                qemu_build_not_reached();                               \
+            }                                                           \
+        }                                                               \
+        (device_class_set_props)((dc), (props));                        \
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


