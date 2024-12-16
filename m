Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB60EE77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 03:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN29A-0007OG-FS; Sun, 15 Dec 2024 22:51:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN297-0007NC-4X
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:49 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN295-00061Q-Jo
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:48 -0500
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-71e1d7130a5so1828593a34.0
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 19:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734321106; x=1734925906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1oXFqOkhT6DaTbVsGylyQNbBUTG5JzXi4jRR+/4cnEM=;
 b=HITAyQa8fYQf0MSxuem3jtlSq/6USuSgu49ssZ1c4dsxTholHsQwKWngpbZhbYd24X
 BVZvJ+RZe+m3hXXQZ/XAvoXkXy/ZLdA19qORRXMHdeuOVdaXMrLe07NwFAKvC7AHiZAT
 lew70zEoZmYZ1m/DnStLXsmUseppfIagbsNA7SiA4gErnowUYijbmBSr2/KVSwrV93vK
 9DCbGz52b6z/5kEAjDAmnlxpStMwbKngN0inHiMlLvJGLXf7QTXpdtKSDJ9j0Qh++iTp
 B+23LS1TSZeQ+HA3/roT7e5GuC45qUEEmyN4RzP/iMb4GvZdPUp4yTvAVCWrYbhuw2Rc
 EFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734321106; x=1734925906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1oXFqOkhT6DaTbVsGylyQNbBUTG5JzXi4jRR+/4cnEM=;
 b=ntvEIQS4Np5rMpDn49IB8+X1DKYs+wlgs2uid/bWxzxfqVyil0orLs/sBngDInutKO
 7LLaVXfznQVIH7zgxS2t+6Qsq71aeglsLplbbhsqfcZROC6yeJPnkrMAQJM/R1haJ+VM
 5iBfSwPYCGdRbMPNOwYn+adIxq2txhHGrEYEZ6i2zbOTowgNrVmfHGq6KVVoy8pIAwv2
 L7d+U9Kwe+ikOSJulaG5ShOYk1f3vt0rbsvtoqP48papXoAp/tvPk1GE00CaMful+fjz
 AQoka6xUIiSrmuRoF5bo/wB/f0hi+EA4ygaOVyUPDd37oxd90wSFzjH4Z4WI/iAvs/zO
 ZyPw==
X-Gm-Message-State: AOJu0YwLs3h0vDmmOBBSFUPkAS+eq94S8VmmEGUE+ozPdoqhz0JRgA4T
 Q+BTjg3Sy9me5zsiOjg0TuZD8jpT/8NHYYWQBKyZAlNKeGU9TbSL5A0o017AtPHDyZo7p2DA2wI
 21uJQvRo6
X-Gm-Gg: ASbGncvYG3ehSLpq/dxbD4ZHBOxIw+h72fwh464vncDvSW3MZUqbPHSBayn4mOrULgN
 6xO+Yv3bGfxNu5fZOT/54jSb54KGjv3g5vJjDolRNxg+dRACoipdzEaZbFXOinYgJyYfTpn7asV
 StjjvIKOR/e6cHdzPz9LyQI10fDYZC6aoSpA5l7PwKK5NqzryA1LqO6C+SrIt3+gwp/98Cj9FIy
 vigYOszTxI0V0C6ZnCV6xkgc5Pst45viDR5P06Rs7Z0Gmp8nr2Umaxs+2wdLt6L8TEK7Ok/oqy0
 sfbBkkigrjOtmPLz+1Xfj0cOC7BYOD8UP23s2Wo1WAY=
X-Google-Smtp-Source: AGHT+IHygaHvhL8Nfae9fW3F1gOrvttA55LHrMWHTPl+a6kV6cxVdCq5MUAhUMopr1DL2gdRMAQm2w==
X-Received: by 2002:a05:6830:2107:b0:71d:415a:5d18 with SMTP id
 46e09a7af769-71e3b82a420mr6827838a34.3.1734321104951; 
 Sun, 15 Dec 2024 19:51:44 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f33a93a6d1sm1287493eaf.33.2024.12.15.19.51.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 19:51:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/24] hw/core: Replace device_class_set_props with a macro
Date: Sun, 15 Dec 2024 21:51:03 -0600
Message-ID: <20241216035109.3486070-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216035109.3486070-1-richard.henderson@linaro.org>
References: <20241216035109.3486070-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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

Use ARRAY_SIZE to implement as device_class_set_props_n.
Remove any DEFINE_PROP_END_OF_LIST terminator from the count.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/qdev-core.h    | 21 +++++++++++++--------
 hw/core/qdev-properties.c | 16 ----------------
 2 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index cd0ddf84ca..5dc4640258 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -941,20 +941,25 @@ char *qdev_get_own_fw_dev_path_from_handler(BusState *bus, DeviceState *dev);
 /**
  * device_class_set_props(): add a set of properties to an device
  * @dc: the parent DeviceClass all devices inherit
- * @props: an array of properties, terminate by DEFINE_PROP_END_OF_LIST()
+ * @props: an array of properties
  *
  * This will add a set of properties to the object. It will fault if
  * you attempt to add an existing property defined by a parent class.
  * To modify an inherited property you need to use????
+ *
+ * Validate that @props has at least one Property plus the terminator.
+ * Validate that @props is an array, not a pointer, via ARRAY_SIZE.
+ * Validate that the array is terminated at compile-time (with -O2),
+ * which requires the array to be const.
  */
-void device_class_set_props(DeviceClass *dc, const Property *props);
-
-/* Validate at least one Property, plus the terminator. */
-#define device_class_set_props(DC, PROPS) \
+#define device_class_set_props(dc, props) \
     do {                                                                \
-        QEMU_BUILD_BUG_ON(sizeof(PROPS) != sizeof(const Property *) &&  \
-                          sizeof(PROPS) < 2 * sizeof(Property));        \
-        (device_class_set_props)(DC, PROPS);                            \
+        QEMU_BUILD_BUG_ON(sizeof(props) < 2 * sizeof(Property));        \
+        size_t props_count_ = ARRAY_SIZE(props) - 1;                    \
+        if ((props)[props_count_].name != NULL) {                       \
+            qemu_build_not_reached();                                   \
+        }                                                               \
+        device_class_set_props_n((dc), (props), props_count_);          \
     } while (0)
 
 /**
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 31e3072b55..a3d49e2020 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1058,22 +1058,6 @@ static void qdev_class_add_legacy_property(DeviceClass *dc, const Property *prop
         NULL, NULL, (Property *)prop);
 }
 
-void (device_class_set_props)(DeviceClass *dc, const Property *props)
-{
-    const Property *prop;
-    size_t n;
-
-    dc->props_ = props;
-    for (prop = props, n = 0; prop && prop->name; prop++, n++) {
-        qdev_class_add_legacy_property(dc, prop);
-        qdev_class_add_property(dc, prop->name, prop);
-    }
-
-    /* We used a hole in DeviceClass because that's still a lot. */
-    assert(n <= UINT16_MAX);
-    dc->props_count_ = n;
-}
-
 void device_class_set_props_n(DeviceClass *dc, const Property *props, size_t n)
 {
     /* We used a hole in DeviceClass because that's still a lot. */
-- 
2.43.0


