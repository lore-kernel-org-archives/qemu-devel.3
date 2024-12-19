Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D755E7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOBy7-0004bG-Sj; Thu, 19 Dec 2024 03:33:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBy4-0004am-R2
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBy3-00059Y-9f
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uej8kMO7NCkobLHrnQz1TU29MyTwJWko3Jex+3x88Oc=;
 b=azw6T7YTS1KqvF/pltIk/ANJxGWRZJwQgBeI2xVWNZ4oO9EFieQ17DaQJgN4D2zFVenrKK
 +UCcZed/AjcOcgL/vFzZbcvCJIywET3wlvv2QV26xyQdTjbvzl8KseUZ4FdUkb4HM2vkc3
 DVy6Rq8E024fDlVlEDqNisD/fRyoJ/s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-g2X_1CkCP_ajmaPxF22G4Q-1; Thu, 19 Dec 2024 03:33:09 -0500
X-MC-Unique: g2X_1CkCP_ajmaPxF22G4Q-1
X-Mimecast-MFC-AGG-ID: g2X_1CkCP_ajmaPxF22G4Q
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4362b9c15d8so2896065e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:33:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597187; x=1735201987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uej8kMO7NCkobLHrnQz1TU29MyTwJWko3Jex+3x88Oc=;
 b=NxBEurRdFgouSzWcX+gSfpm+F+7Z4PkT6Ib7+DKq71bQMfheEgsHY1TkdYbHeP8pTF
 nN9BiJeAv1LggqncJ8gJ+f9B74+lz4bjB1DwmI/8b4hJS5lO1L9LKCfiGiH3N5u+WVbB
 LfllJqGPl5L3HDZO4MIG4HtfR4mMULezvA1nNIlVEl71JcznotofsycuZeJJP93UZw7I
 5baJF0UASrfTIw3nXdVbUZGj+jZUiEvFTSIfVSFFJHNeZf/s+uE4tmG2kzR7TXD/XRF6
 ypkFg84pZy0UuE3JWDpPYkTZkA9j0Um7Imi+0l0CNRwPnU+T3u1h2I0xFL5qhTRIgrWD
 dv2A==
X-Gm-Message-State: AOJu0YwaUvQ9ZHCyOxqXpJEG7nr4toznHrpZ1VAQAvvh3qKpJoyZDG33
 qTF9s58XoUc9Y7DTkM1hfguncZNDQa4jV7/hQr0CX3LGeWha9xcyTgF8GNFTBfBDjeoA2R4g6pm
 GaGvtiWe8QWEC+qC+79AcdoXLxNJb8VWvbEonxQv6/NlOEZiIHFK0m/k5JngbBCIkwBvyqcG1G2
 d4izpmkwPFzL9mN/BnlaD8I5etK4MMWVf0YJtw
X-Gm-Gg: ASbGncsqkgx1PMcNO8/ea2V9sOAtI4GI3/gewq5B9RE8LqvOPvOfTk6ro5cyfQVnCA7
 KxpGg4GyERf36lwuWWhEwyjCWnCwfwCZlWPY08oMb/i3ylfEPTxBhMxqQK8yB2QE7XWbU1owhBa
 PwLauFKjuW8KGLCTMJfiA3S6L59Uqt+Fky5i5VVgIX46jfJ9dfBoFBj7sdy5KphKdCOqufh14z8
 j+e/GZ0fafCSO7IErP2u/c9Gf8dqIN+Bh8S+CUq64+eSHhsEkrNucixijbH
X-Received: by 2002:a05:600c:510f:b0:436:1b08:4c78 with SMTP id
 5b1f17b1804b1-43655401b49mr58588065e9.31.1734597187090; 
 Thu, 19 Dec 2024 00:33:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuDqkZNP9JNxZMMT+1kXsDPde+6BfP4PEWrSyz5Xen2nIGPkpognO7hlfhI5420tdMt6GHBg==
X-Received: by 2002:a05:600c:510f:b0:436:1b08:4c78 with SMTP id
 5b1f17b1804b1-43655401b49mr58587725e9.31.1734597186686; 
 Thu, 19 Dec 2024 00:33:06 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b119d7sm44931385e9.20.2024.12.19.00.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:33:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 18/41] hw/core: Replace device_class_set_props with a macro
Date: Thu, 19 Dec 2024 09:32:05 +0100
Message-ID: <20241219083228.363430-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Use ARRAY_SIZE to implement as device_class_set_props_n.
Remove any DEFINE_PROP_END_OF_LIST terminator from the count.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20241216035109.3486070-19-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/qdev-core.h    | 21 +++++++++++++--------
 hw/core/qdev-properties.c | 16 ----------------
 2 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index cd0ddf84ca5..5dc46402585 100644
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


