Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2982DCD6E6E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 23:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVHDz-0007HC-2W; Thu, 04 Jun 2026 19:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVHDx-0007Gz-GJ
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:11:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVHDw-0006Mg-1C
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780614699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R4A39g0spLiznd90/Jk/6It+g1eygjhYpKlTbFN6CEk=;
 b=g3ENMcg4zPIRlpnwP4JFpnQ6x+UFVW7ovjvfUG6Dpow0rUlIK/60BT8UISeG3xHF+ISwPm
 VIkIcr5sxcKUovWyIqkG8nJ2MEVs8a/dFkuY5qJygE8/aVN4wy5mcQtSCFPjKRTQXmpBQI
 WSZ4orvl1zEjmTFPjXOMlaBpGmoaCQY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-nMtt85VUPZy4j5thQ2C9vQ-1; Thu, 04 Jun 2026 19:11:35 -0400
X-MC-Unique: nMtt85VUPZy4j5thQ2C9vQ-1
X-Mimecast-MFC-AGG-ID: nMtt85VUPZy4j5thQ2C9vQ_1780614695
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-91574ad6871so263662485a.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 16:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780614695; x=1781219495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R4A39g0spLiznd90/Jk/6It+g1eygjhYpKlTbFN6CEk=;
 b=HKjuDturlpxhAtyX91MtGRT3ndvKCOgnP3edfCmd60JE13Fje8tEn100cBBGQmvtu9
 XoAO4dcJGi0h0vahMJZjXUTh7tnCZfuMedvR8Dd7UQvL10B/2RNESkrznjbX6ggUt3Hi
 3o4x6RrzSKTyqvUgK9bMd4stF67RkazBD9YM1jD1FNnLciOnvW91eYHD6TkHmvK0rwCU
 K5ZG2fpjQ6whBWzxDu3TizqpuusezVv9qZ0tk/f0IVLB9qcb7CxQ7TatsPaa/vGdq57M
 rYtTdJq25/LDydWA1xeFxSYzIK9Q34tum2IIESeGlxoVT4EpcK3USM5A19C1EBd0NntL
 BtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780614695; x=1781219495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R4A39g0spLiznd90/Jk/6It+g1eygjhYpKlTbFN6CEk=;
 b=AEdJrCpS7VGYsNlGKq1ENEZgJj9+8rcff5Rbbp9+qv4Yew/M8W6+jKMD2fjuNwX46g
 MGMx8Tr0fvcU90m/sRyAJCEXqAQ7wF9R/Hf6vaScRddpLjcE/9Zmff8Ryn6jPUefxyIg
 ZC7qkuQS7zWqJmxH/Dwi9Mvq0wzvzKOhvdXtdd0jiW4O5sxF4aGCKLk7YZ1K/0Slmifh
 faqeJNGfzng+MtZUPDv1oHbTNfXJmCn028yCO+QfMp1AbDQQl+zDCXNeya7PgpX5UqSH
 xP0ze0Vrouhwp0catA5Nm4vqut8d3UclVrHCXahLuHUnWX9Nsjz9d+wfS1wrSjlDeGAS
 OgAA==
X-Gm-Message-State: AOJu0YwtVWkWYPrmBGs5EmTjjxC4Th5QgFqk/IELMDqAka4OV1BTTnrD
 HzgmGL1CZAjEGPzwCNe4HVB0eV0k2iJ7588P2EADBBqJJDiR5iKtpgJyHFVlE7E8BHcLedPzHqR
 ipIbeo2aSOCxkgxKpf3a5msytRS8fkHrifqd5l7Q1Q/y9LVFyhFDYtj78RE/eN+/diKpKbQIHsU
 U2WgEkimbf/mnnStRsJrBCZubWp+KCCfYvg7RLpg==
X-Gm-Gg: Acq92OGJWUPN0kVB8KHPldVFHWdK/Ia/weRNSb+yeZIjcFLmkxRUY2xDB30iVRmKeHG
 QFDK/WTOD7xIVZf3PI4g2L0VJ6IeTE56KSGieBlVgCK07FIAUrH/5xjI5PeKWrNaEGrp8Q9PO8f
 RPrW5L21FehSxmkl/9g/xGrneMbIEIS09rAYGy5b6+flVdWVy10H6ygFeNxbuRpUd9n0QU2RjDu
 Gn3V2aVQLtwPe00V26syRa+N4K6m8elisg2mAcbbMnCrvwXri4KZKtQa/TGB/Zncq8WJTfgwo/H
 teuQy16dUi/ZYjyzJl2eNEP0CpHkMw4VTMQyTmcrP1esKQCTEKxmRKIHI5Ix5bFUpr+AHl/1pVD
 qi5ZBdY+rs8mAVkQWWOOzctY=
X-Received: by 2002:a05:620a:17a2:b0:915:7f7d:e61c with SMTP id
 af79cd13be357-915a9e16842mr228276985a.53.1780614695112; 
 Thu, 04 Jun 2026 16:11:35 -0700 (PDT)
X-Received: by 2002:a05:620a:17a2:b0:915:7f7d:e61c with SMTP id
 af79cd13be357-915a9e16842mr228267385a.53.1780614694466; 
 Thu, 04 Jun 2026 16:11:34 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a37cab6sm707617285a.22.2026.06.04.16.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 16:11:33 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Sana Sharma <sansshar@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 3/4] qdev: Refactor and rename of qdev_class_add_property()
Date: Thu,  4 Jun 2026 19:11:17 -0400
Message-ID: <20260604231118.1584889-4-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604231118.1584889-1-peterx@redhat.com>
References: <20260604231118.1584889-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Firstly, qdev_class_add_property() function almost has nothing to do with
DeviceClass, it's a bridge between Property and object properties.

Change the 1st parameter of it, so that it can be used without DeviceClass
context at all. When at it, remove the "name" field because it's always
prop->name.

Export it for non-qdev use cases.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/hw/core/qdev-properties.h | 10 ++++++++++
 hw/core/qdev-properties.c         |  7 +++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
index 779acb31b6..fec2aaac4d 100644
--- a/include/hw/core/qdev-properties.h
+++ b/include/hw/core/qdev-properties.h
@@ -283,6 +283,16 @@ void error_set_from_qdev_prop_error(Error **errp, int ret, Object *obj,
  */
 void qdev_property_add_static(DeviceState *dev, const Property *prop);
 
+/**
+ * object_class_add_property:
+ * @oc: Object class to operate on.
+ * @prop: The qdev property definition.
+ *
+ * Add a Property to @oc.  This is the bridge to convert a Property into
+ * an object class property (as in ObjectClass.properties).
+ */
+void object_class_add_property(ObjectClass *oc, const Property *prop);
+
 /**
  * qdev_alias_all_properties: Create aliases on source for all target properties
  * @target: Device which has properties to be aliased
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index a91c2ad101..ab828bb612 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1188,10 +1188,9 @@ void qdev_property_add_static(DeviceState *dev, const Property *prop)
     }
 }
 
-static void qdev_class_add_property(DeviceClass *klass, const char *name,
-                                    const Property *prop)
+void object_class_add_property(ObjectClass *oc, const Property *prop)
 {
-    ObjectClass *oc = OBJECT_CLASS(klass);
+    const char *name = prop->name;
     ObjectProperty *op;
 
     if (prop->info->create) {
@@ -1222,7 +1221,7 @@ void device_class_set_props_n(DeviceClass *dc, const Property *props, size_t n)
     for (size_t i = 0; i < n; ++i) {
         const Property *prop = &props[i];
         assert(prop->name);
-        qdev_class_add_property(dc, prop->name, prop);
+        object_class_add_property(OBJECT_CLASS(dc), prop);
     }
 }
 
-- 
2.53.0


