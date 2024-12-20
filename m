Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE53E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 14:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOe5V-00047w-4x; Fri, 20 Dec 2024 09:34:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOe5U-00047e-B2
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:34:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOe5R-0008AP-Oh
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734705281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bfkTe0JNpLA7RGXcBkcS5J3fSCwSWyZnazMZm6jnkR0=;
 b=NLFI6qiFjMy/r2xS89LMhyVtpxtyYGdcEi2++yZa+TrMAxzr4UwvTLNGhsaE30uBHaEAvC
 qLIISmiitkGgpe0bPMVHc3kDWGeGML0LNXA/q9jqjTpy3S/fH/8AydzPT3HrqEvh028BZD
 A56Jp/30qCHSpOf3magn6rEbJZjAdk8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-n5dLZJfLN52-DNcn2jbGSw-1; Fri, 20 Dec 2024 09:34:39 -0500
X-MC-Unique: n5dLZJfLN52-DNcn2jbGSw-1
X-Mimecast-MFC-AGG-ID: n5dLZJfLN52-DNcn2jbGSw
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3862c67763dso958678f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 06:34:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734705277; x=1735310077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bfkTe0JNpLA7RGXcBkcS5J3fSCwSWyZnazMZm6jnkR0=;
 b=EohaUmAewjf2XNMacXKyfFilpWm0g4UqmFiNI1LRwU7F4wkSYWiniyhdHEn9pb4iU8
 uLFe8utuXSEPFFXcpWF1tMrVq+h1VIV5+TRfL1l1WDUyGhJ+0IP0g1YJ53LZUwELNdmz
 clif2AzzBefJdG6VdKCqrBGTjrg0+oDzOzkwLnt52IjI4EHxJdwcibybTDEl/D0wBjHI
 off6LedFbwbzO0VCt/ZbOcQwaBZRvBlyJ3gpj2esFyw9rg7HLod/a/G0SthMMDvuCKG/
 Y2VWSWXV1vfybix+XtMwvYqkWJEXo5esqvfRAjumMxxLAiA0YyUOWFV+s6UUubIej0H1
 qfmA==
X-Gm-Message-State: AOJu0YzwSfx6g1aB+pSLc6TE1ZPkRAwHP125ZzMq8EaS6L7k4Y8pIh+s
 Z+CYyObrLSXjPFbwa8kEh7jmAXQk3T4TCQtgsvWK3aYL3X2yRUu/GahfjnDMDB4wzs/nMfkPiYH
 iGZb5qYthop0HqITOq3Dx/qXYO8y/DCnnx7mcTVuKp3xCYcdSPUM/C+8Zx9SwCadaZyHY4WpLwj
 kUm8FbTDmgZ6ydk8jZlOBmRlgrn5rTb8u9qH73
X-Gm-Gg: ASbGncsVrpotsKVO8JDMtqg+60LwTwu6DJlGkasE4VKuwoc5aWKRn6iETW5uHYEfTce
 r5dLxpFePHJH4h8qTsYTPgMWfOZKzU4EkUbPcfsu/zOn9zQoBH5qtmEORcH1i4P7cQWbnfjcH72
 QHiTfQcD1ASrR81PngtV/VlfF4hi/46l4pSXTumSoqgW1Y7LpldOCOft6ST9mkOQNnNMO87jOrf
 IuY44YODkFMz6F+b//lvaY/k8OI3P53d5BqMqNTQjLj+mX4OwSz74S6rBXR
X-Received: by 2002:a05:6000:480b:b0:385:fb34:d585 with SMTP id
 ffacd0b85a97d-38a221fa418mr3062472f8f.34.1734705277155; 
 Fri, 20 Dec 2024 06:34:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRMSiTjL0utFLUtMQKGX8yvbpHXjCpNVQf/Ova+rayE+ysBxOsJSFDbnmd+brjohmlvyqPww==
X-Received: by 2002:a05:6000:480b:b0:385:fb34:d585 with SMTP id
 ffacd0b85a97d-38a221fa418mr3062445f8f.34.1734705276758; 
 Fri, 20 Dec 2024 06:34:36 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b11aecsm80941745e9.23.2024.12.20.06.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 06:34:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Lei Yang <leiyang@redhat.com>
Subject: [PULL 18/42] hw/core: Remove device_class_set_props function
Date: Fri, 20 Dec 2024 15:34:30 +0100
Message-ID: <20241220143431.653644-3-pbonzini@redhat.com>
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

All uses of device_class_set_props() are now using arrays.
Validate this compile-time in the device_class_set_props macro and
call device_class_set_props_n using the known size of the array.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Lei Yang <leiyang@redhat.com>
Link: https://lore.kernel.org/r/20241218134251.4724-19-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/qdev-core.h    | 16 ++++++----------
 hw/core/qdev-properties.c | 16 ----------------
 2 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index e9b4891f55a..afa667b68f3 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -948,22 +948,18 @@ char *qdev_get_own_fw_dev_path_from_handler(BusState *bus, DeviceState *dev);
  * To modify an inherited property you need to use????
  *
  * Validate that @props has at least one Property plus the terminator.
+ * Validate that @props is an array, not a pointer, via ARRAY_SIZE.
  * Validate that the array is terminated at compile-time (with -O2),
  * which requires the array to be const.
  */
-void device_class_set_props(DeviceClass *dc, const Property *props);
-
 #define device_class_set_props(dc, props) \
     do {                                                                \
-        QEMU_BUILD_BUG_ON(sizeof(props) != sizeof(const Property *) &&  \
-                          sizeof(props) < 2 * sizeof(Property));        \
-        if (sizeof(props) != sizeof(const Property *)) {                \
-            size_t props_count_ = sizeof(props) / sizeof(Property) - 1; \
-            if ((props)[props_count_].name != NULL) {                   \
-                qemu_build_not_reached();                               \
-            }                                                           \
+        QEMU_BUILD_BUG_ON(sizeof(props) == 0);                          \
+        size_t props_count_ = ARRAY_SIZE(props) - 1;                    \
+        if ((props)[props_count_].name != NULL) {                       \
+            qemu_build_not_reached();                                   \
         }                                                               \
-        (device_class_set_props)((dc), (props));                        \
+        device_class_set_props_n((dc), (props), props_count_);          \
     } while (0)
 
 /**
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 31e3072b559..a3d49e20202 100644
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
2.47.1


