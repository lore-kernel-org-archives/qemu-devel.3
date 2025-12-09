Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6568CD3B7FF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 16:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT0bm-0007u0-2Y; Tue, 09 Dec 2025 11:30:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT0aX-0006IA-KO
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:29:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT0aW-000259-3f
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:29:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765297759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z7jQ1Ro3XHBHAN4glqyPH+4uaEXdDbHZfNgePeIyTCY=;
 b=OXxLWVSJc9g501q+THf1ELmk/oEg7VHJvz/mQ+Yu5QNT/YwqQqL158q2LpvHivenjGOJu3
 is9hdyKE+hK430PyikNXB0ryzfoGJAf+f4mOVdd8mXwcQvrnkq8089ZlO0/P+A98Lv2axc
 PeMt8inhZkAxw6aY84lpV1uZFPu1eAY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-XcKII_ETMXSo7YsXfo2KgA-1; Tue, 09 Dec 2025 11:29:18 -0500
X-MC-Unique: XcKII_ETMXSo7YsXfo2KgA-1
X-Mimecast-MFC-AGG-ID: XcKII_ETMXSo7YsXfo2KgA_1765297758
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-880501dcc67so220900506d6.3
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 08:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765297757; x=1765902557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z7jQ1Ro3XHBHAN4glqyPH+4uaEXdDbHZfNgePeIyTCY=;
 b=JeXO3sMyyinxQ2g5bC1xh0PS/xUcNp3pjNelVe/Rgb10tslRzGNJ8YUc1pW7BHB9nn
 AAMtu6GDVsPbGS5O9maCUTsgMbdVZjCUzZLDQFv/SfPaxOnmqIqlfJtJCLqA7eZDgt1z
 ff+/mIB1muFvF/k92V2uB0rTh/azl73as2kOMhYOKweULhBvWbAei4eBC59iVCD2EEnu
 UjM6ajN1adTFJqGfFAZgj77xwCfyg7o23v1vtai9QBL2Sov4Y+F3VtT4z+nQkKc1aSqE
 iswa0dlb5TX+PqQUcIlDPF6asOzeFG8XBJu5LUiebVuEU8pQXWJg/aZ8kno3m6Vaj9Cy
 DaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765297757; x=1765902557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z7jQ1Ro3XHBHAN4glqyPH+4uaEXdDbHZfNgePeIyTCY=;
 b=a839WPS6uOcTDwp8P3Kd7S151kLCjdze36fV+AgB1x/7HBTIcnCy/RL7q9SZHYBbaZ
 SVijGFSMYc4rX0V9Dou88/NckEiK808H0DrR2/csUVsMkS3msdzimRhleG9nIRGlPy3Z
 FzAMBh9ac7ybL4rNg9LeidzMpO/g9WQeYs9d5CdDs4VeAghjrkeRtci5UiAiO4q/D5n3
 6OdovtITvcIiauJkFohh+E7TujAXjJvDUPSVOIn+GDW3PMBAukX0VL79NSrGh3X2A71m
 hXjdXKB0gZWPUxfyI4a+4mvRyY5ReVUEYP2PP5GHRSChnUobQo2k9vsDf59jK4mlAeO1
 giRw==
X-Gm-Message-State: AOJu0YzzNiyEWUahk9UFvixCK/P0BnfJq7rrIUR0Pemjtl+uJ2mmPW+8
 6IfxKp4j7qTCKzzMV9OA1E0N7hpreyGvB+UG7lsMV8uBhJmtJ/b70hP9FgzxIe1Rmt3RhhaTUjE
 lj7mOAMjgfxhlhfIzsJl7OTUJaq37T2moztK2swLZeUh1jHvAA3kmblW+IYUb5LU/4+X/vQB02n
 w9+yHFWMa/nYtzCmDExBKZnruS1X67Luu8Db6mcA==
X-Gm-Gg: AY/fxX7xdD3SzcfH1LZ2zWbnTZDEnVFgMRpwD28juFWMIQ3MSBVKyqX4m9Lq8gfuera
 PFNnK7Uj9coP8kqlo12jz8MnBf/wWwM5Dv01fwIHWZJMKXRytojPHEUMkKX3DwxXokP515L4BBx
 HIOZRDE1C/ZXe72E1OXoOcrL3yYvzqqSKlPr4u6cJUDhKeC3fAjSOisGKjhbsu+d0UFEG1nQlHK
 cwfhzEPNwMELH9rNXmwPGgnXMruZcUf8z5Q0R46sutqxVV23O4oTL+cECFFvh88j6eU8BoiL74V
 ssuzhEGYLtbHNtPnUwz9z8eJF8+aX72C0Zfhdv+so1gTVFK0/gnu22zU5PAmpoI6cJhW7hrgAFD
 Ilmc=
X-Received: by 2002:a05:6214:b6a:b0:880:4a49:75d0 with SMTP id
 6a1803df08f44-8883d94192emr192660896d6.0.1765297757095; 
 Tue, 09 Dec 2025 08:29:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFFMz4KKumktf3jxEBNVVE9xPMV6bi2mKl+Lf9PRoevelHuf2KFaZ+tSylO++yS/SknhHUVA==
X-Received: by 2002:a05:6214:b6a:b0:880:4a49:75d0 with SMTP id
 6a1803df08f44-8883d94192emr192660096d6.0.1765297756486; 
 Tue, 09 Dec 2025 08:29:16 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88827f334d8sm131110256d6.10.2025.12.09.08.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 08:29:15 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH RFC 09/10] qdev: Refactor and rename of
 qdev_class_add_property()
Date: Tue,  9 Dec 2025 11:28:56 -0500
Message-ID: <20251209162857.857593-10-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251209162857.857593-1-peterx@redhat.com>
References: <20251209162857.857593-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Firstly, qdev_class_add_property() function almost has nothing to do with
DeviceClass, it's a bridge between Property and object properties.

Change the 1st parameter of it, so that it can be used without DeviceClass
context at all. When at it, remove the "name" field because it's always
prop->name.

Export it for non-qdev use cases.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/hw/qdev-properties.h | 10 ++++++++++
 hw/core/qdev-properties.c    |  7 +++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index f064992ba3..bf90cac810 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -241,6 +241,16 @@ void error_set_from_qdev_prop_error(Error **errp, int ret, Object *obj,
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
index 7d1a443266..ede173d57b 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1108,10 +1108,9 @@ void qdev_property_add_static(DeviceState *dev, const Property *prop)
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
@@ -1188,7 +1187,7 @@ void device_class_set_props_n(DeviceClass *dc, const Property *props, size_t n)
         const Property *prop = &props[i];
         assert(prop->name);
         qdev_class_add_legacy_property(dc, prop);
-        qdev_class_add_property(dc, prop->name, prop);
+        object_class_add_property(OBJECT_CLASS(dc), prop);
     }
 }
 
-- 
2.50.1


