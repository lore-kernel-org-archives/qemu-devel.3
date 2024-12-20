Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70ABE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 14:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOe5W-000491-Nm; Fri, 20 Dec 2024 09:34:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOe5U-00047f-Di
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:34:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOe5P-00089y-VG
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734705279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TO7s1KHMmsDRBPigNh0a2V9+8y5swV6pox2K3t+SKNA=;
 b=cSyZJXZSrpjqRzkEfrKJX6kXkRQpk9EzdfCQT+KLfOQjXmYD/NWgeS7cWePBFTTNC4olmt
 aDZB+2Otbjar8+EdjV3Xx9cNakyVCsZHfP5RwZIrK35n5NanvKhsTvP8Z3RtD0D1T2fRor
 5Gqy+w1ho7HKURTiyGBa0W4J3+g/rhU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-ASydR1OpMSOY2yoyPOfOUw-1; Fri, 20 Dec 2024 09:34:36 -0500
X-MC-Unique: ASydR1OpMSOY2yoyPOfOUw-1
X-Mimecast-MFC-AGG-ID: ASydR1OpMSOY2yoyPOfOUw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4362f893bfaso11596595e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 06:34:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734705274; x=1735310074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TO7s1KHMmsDRBPigNh0a2V9+8y5swV6pox2K3t+SKNA=;
 b=erkPptzHt3uJxSUEalfBCDO2K/GmOZh3qQXVfzFbQHVlNh3TV0Jh272a5UhV9U4yz0
 4difZH5SoB0fK5qNia2zCMRmOTCZJJPLk/KZQ8n2mT8ZFeIA3fb++mIrj5xYPYyMuJIv
 /yfpxol38XtudRA5C8JCXcVBC72cPujaY/VYStAOi6q1GfywXbtv8/d1myRf5EbrjDMq
 mE9Jh8KpBzABgf6csPXv8Q73ZU9CNjmdqzgHo0RHvq+nUol1pvC6bMwXPLXI1u/A4fq7
 2Bj0I5YTagyQK6ucV6zpfirUNir6aXXClFSrLlDjVhLNiFNUsn9cp61gUpz3DSlnSwcs
 yzig==
X-Gm-Message-State: AOJu0Yzlb7CphXkG8jy2v4wcV7C9GAYzLo/WNbRBc5CrrXWnZaTradV/
 TpPdimc5hChT/rim6mW+jfNUTgAG1q4LDxsBRf3EsppKSJt6tjJAMjoqgHLsBJh9qm7ra208OjF
 y2/Q57cs6kmUz7goLzDPhZVBDNXRncMVoTnP9cE+sdkOZ1xB0iKSIHzRpGyGPUcG0JaWAMVfwTq
 SXiUSDUHNWz4zjZ+kBhvK96L7iUrJw61n+sM7q
X-Gm-Gg: ASbGncsCqrND1baJZjbRvBTg0aMRhS9Y8CwuEqwXT5OrQ+7Ub/AtXwItk1pR2IhrAUb
 nDWZm57uvXrFjmBj90gfx8BATq+73G+cQCyZP1SbBDlQImCCWrBjOY4hy35gRHi1cSrOUlzmJGN
 FIpS4n1BlOb/mLmZ/tS20xZy0IoKsmad4wGDilDRAjmpsQza3mh/8j3HCXZKGP3hA8SoEVAcEz/
 2THHcekWuhZTPXPqFBLT5Q5VpGVdWdmo9Utzc5BDgWcM7Jnnyz75ADw++cT
X-Received: by 2002:a7b:c855:0:b0:434:e8cf:6390 with SMTP id
 5b1f17b1804b1-4367124b510mr6441195e9.6.1734705274539; 
 Fri, 20 Dec 2024 06:34:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsQcBhGC5T/5apL9+CX6D+pk1lQyAyoZq6FdpOgz5Tf93TffJQIh83dRKjquaNPXguIv/Mzg==
X-Received: by 2002:a7b:c855:0:b0:434:e8cf:6390 with SMTP id
 5b1f17b1804b1-4367124b510mr6440955e9.6.1734705274070; 
 Fri, 20 Dec 2024 06:34:34 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656af6aeesm81888825e9.6.2024.12.20.06.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 06:34:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Lei Yang <leiyang@redhat.com>
Subject: [PULL 12/42] include/hw/qdev-core: Detect most empty Property lists
 at compile time
Date: Fri, 20 Dec 2024 15:34:29 +0100
Message-ID: <20241220143431.653644-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220143431.653644-1-pbonzini@redhat.com>
References: <20241220143431.653644-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Add a macro expansion of device_class_set_props which can check
on the type and size of PROPS before calling the function.

Avoid the macro in migration.c because migration_properties
is defined externally with indeterminate size.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Lei Yang <leiyang@redhat.com>
Link: https://lore.kernel.org/r/20241218134251.4724-13-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/qdev-core.h    | 17 +++++++++++++++++
 hw/core/qdev-properties.c |  2 +-
 migration/migration.c     |  2 +-
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 5be9844412f..cbce3cf0b40 100644
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
index 315196bd85a..de618a964a9 100644
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
index 8c5bd0a75c8..6b3b85d31e5 100644
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
2.47.1


