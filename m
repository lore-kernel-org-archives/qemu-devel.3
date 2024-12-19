Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99CDE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOBxt-0004X6-1s; Thu, 19 Dec 2024 03:33:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBxr-0004W6-4P
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:32:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBxp-00057G-IL
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:32:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DHSMfA4p8emdOQqYqGttRQGDx+jWhVOuqAnBtD1lJmc=;
 b=F9Eg08Gu/My/SBjChcEsAba6D38DPuuaAZbP/jdoYxL69Diu52v/t+I1iRuNabaKt6iP6P
 uX/2OT66agDRwJLMBtGuooE0hVm/wnoYEM81nWYVa2yYGy08RshJr5vCbMz8Lj9dc0JRa7
 2n2uM8AbVJYV8P+Ocr7Dh4Oys3UXPrI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-_vHX8csXO9eKvQ8A6EoJRg-1; Thu, 19 Dec 2024 03:32:55 -0500
X-MC-Unique: _vHX8csXO9eKvQ8A6EoJRg-1
X-Mimecast-MFC-AGG-ID: _vHX8csXO9eKvQ8A6EoJRg
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3862b364578so826203f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:32:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597174; x=1735201974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DHSMfA4p8emdOQqYqGttRQGDx+jWhVOuqAnBtD1lJmc=;
 b=Uvxru+Fg6eNDIcbzzIyrZnXfgCboaeneKpQKkJ6OXqBbY3RddBDSy5AnqGsFMszDpw
 H0zJ7gXaroke+ipVzDt6Lujx0RjOgIc7Y3Dgz79h+HaqSzw8+jpWENDlEg+OECbwkAv+
 ffUKWuUez+VGyPzh8lN0gB8qnDweHNuhe9mRq7DtrNlbZcNoICQrAF5Xd3PWYOkEvlT6
 uW6YGhMkuSSY6j6XbZmfFvHQFsc5a2EugmPAD7FrGTRA0bJgSe6wwN3Tedw9gLUemiNy
 Rrzm3xAcwqEcUYoFvPnS9Ld0+RT2q42PAuw0GVYxh/4983c12v9QEphSa+3xp71sjXvw
 d5UA==
X-Gm-Message-State: AOJu0Yy5YNsvZ84cN+fAusuHLH3oyHyYXJcl9n15UE/yhsKV5O271ABw
 6l58OzQFkpzzcMoqAux2M39tZ3il5O4hodjc4E954KDddATs+ZiqAR+CSsoduTGEA0LeTCg1lEY
 d1ROmEDzkD0NW0bMdrYpfX8etdTqOMhn8FSGCmdtDkUpo8hNJmiaFEk2V4NX2Be97QwKxdv+8y9
 YqfvNiRD9VJJBJp8J0ZLsuQNYuvULhAtpIK8pm
X-Gm-Gg: ASbGncuvvyXs0Gn1vbpJ9cdFQE7NR+uaiwxJcaSjmN1Mvi18Hn7egrcL+Ti95nN5Cla
 73Fqx7y6mntiLNtF61cK/uoDqER9QxTHq4jdsNW2CaEmET/cstZYz4SS2kgSHw+LepZIuKgpo4N
 cjYXjczWY5kxMkJyseL9EQlA/qErSenpEJGrE+9jpLqv9dyJtaOrWbh8jgqv8BEqNi1372kPyBV
 k+Fa/j3YPdNps9JTkmD/zM59qGs0fD2u7jSt56Y39k/nixUpkz8GB0H0dXZ
X-Received: by 2002:a5d:6c64:0:b0:385:e90a:b7de with SMTP id
 ffacd0b85a97d-38a1a1f9f38mr1570178f8f.5.1734597173846; 
 Thu, 19 Dec 2024 00:32:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpzVp+rdUfEwhoS9mPfpLdBoyJEXuXG6TC4MXMoEbWgKhwSaBr1kmImIx1MuCXBch0+1WNpQ==
X-Received: by 2002:a5d:6c64:0:b0:385:e90a:b7de with SMTP id
 ffacd0b85a97d-38a1a1f9f38mr1570157f8f.5.1734597173446; 
 Thu, 19 Dec 2024 00:32:53 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8acc02sm971232f8f.104.2024.12.19.00.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:32:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 12/41] include/hw/qdev-core: Detect most empty Property lists
 at compile time
Date: Thu, 19 Dec 2024 09:31:59 +0100
Message-ID: <20241219083228.363430-13-pbonzini@redhat.com>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20241216035109.3486070-13-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/qdev-core.h    | 8 ++++++++
 hw/core/qdev-properties.c | 2 +-
 migration/migration.c     | 2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 5be9844412f..b2859d1e39e 100644
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


