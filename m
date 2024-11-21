Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC84DE6400C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 19:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tECku-0006Mc-48; Thu, 21 Nov 2024 14:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tECkn-0006KF-5N
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:22:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tECkl-0002Vo-PS
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:22:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732216930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=arcBPmf8wzRlgW3nU1LndcjIfMFJuvboEpJ64NoZeIM=;
 b=CjV99JgjH0nZKoGC9bWmbAmSODVRyKEWkRav32eg5T1uVZoXXzNmXKWMeJBvKb1SdNEDmT
 F8kKow+i6oYyKR96AqGUgjI0DAFApwHkqiQ+91oXo6UQ+AcRYeeKOfjxFG9EX7bPqjGb3G
 FjMy51gXLfutWrtGlvyE/0LX5KpngUA=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-UE9zdm2jO9akU6Mfp3TYPg-1; Thu, 21 Nov 2024 14:22:09 -0500
X-MC-Unique: UE9zdm2jO9akU6Mfp3TYPg-1
X-Mimecast-MFC-AGG-ID: UE9zdm2jO9akU6Mfp3TYPg
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-83abe8804a5so125091539f.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 11:22:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732216928; x=1732821728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=arcBPmf8wzRlgW3nU1LndcjIfMFJuvboEpJ64NoZeIM=;
 b=pkuYgoMmNCpTeXdL4/TII3UB6wxvaBoDNs6H5UHcCfNqhKrsWWHnaZqxTG0aE1ZOXt
 QPpbsz0Bgged+zoBYlclCdtWbV7xIdElArKVs/+BkRR2NOtptVEpXcx8mb2iGiBP17ZP
 tXDK3YEfseh151/WvkOq94a7zkUNbAoNHIDsOerild72gaBEbGoidqAY4o1W1y0Huf9W
 WWmSBuFjFD+3EGvost1M4Ok2mP9cOO6tjjU6SacDhrp2/IPTJcLfjTJZDzJ6I17kZtcA
 /moDRmzGC7TgdIYk23bc/tPLzJVVmNnEGBXh8zm+Y5u/zNMJG4Xs4laXZomLVJJpEYBK
 4d7g==
X-Gm-Message-State: AOJu0YyMfPRWWkxYAmDCspe9OzrqRVwV7gLfmgHiUeUr8WqVjyv6ja/S
 0LhAM5CHDHLeIJb0EjRA8Tea21gv9N3+KqDnh4iBHt27r3RbI2kDNYy+Fhw23MAkydEJwtH4rt9
 NzvWKQ+CJF9LGtLIH5/dnGWkppevunm37yVdzOWqM1MErU8stDT3uXg2flEsY8/yEDAdiE/7C/N
 aK+qYGT20vtCr561GP5Jmite4PQovyTHP9rw==
X-Gm-Gg: ASbGnctkXO292ZHoEqBfKE91gp/Duvq2NGChwoGIWlh455+do+qKUdMrZ485jV97MeR
 wp3V3L3uVp1nVZXP6AmA4nDwk4HlFfelu7hcYxmgogjUao5HSLAoZnfwvDXXsJQyuk7XkAsNJvc
 fl5P2KIhvnoPCEbM3ypJXtcYUKJ8jOTvcEHRB4slh2HAbQiaE5k4ZSpUnSJtv1ZnX9o6OCsirjI
 kwug6d56U+X+QnSGU0/hRhyizfShzVJiGE6oFGvpiy5RHAYiX3/VuovhCefOj99IuUAz7VuNj6d
 hwy4LnyuQfwsi4LpM8SLgORwlQ==
X-Received: by 2002:a05:6602:608b:b0:83a:9f64:6c75 with SMTP id
 ca18e2360f4ac-83ecdc515famr12124639f.3.1732216928079; 
 Thu, 21 Nov 2024 11:22:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGm2roxzJg58laCb6r40bwkfzwJFUWdbEinhTY1AluIOOVeX80rme6EypEEPceq5GomYZ9SMw==
X-Received: by 2002:a05:6602:608b:b0:83a:9f64:6c75 with SMTP id
 ca18e2360f4ac-83ecdc515famr12120239f.3.1732216927609; 
 Thu, 21 Nov 2024 11:22:07 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e1cfe345f0sm102939173.45.2024.11.21.11.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 11:22:06 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 02/13] qom: New object_property_add_new_container()
Date: Thu, 21 Nov 2024 14:21:51 -0500
Message-ID: <20241121192202.4155849-3-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241121192202.4155849-1-peterx@redhat.com>
References: <20241121192202.4155849-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

To move towards explicit creations of containers, starting that by
providing a helper for creating container objects.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qom/object.h | 12 ++++++++++++
 qom/container.c      | 14 +++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 3ba370ce9b..597e961b8c 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2033,6 +2033,18 @@ int object_child_foreach_recursive(Object *obj,
  */
 Object *container_get(Object *root, const char *path);
 
+/**
+ * object_property_add_new_container:
+ * @obj: the parent object
+ * @name: the name of the parent object's property to add
+ *
+ * Add a newly created container object to a parent object.
+ *
+ * Returns: the newly created container object.  Its reference count is 1,
+ * and the reference is owned by the parent object.
+ */
+Object *object_property_add_new_container(Object *obj, const char *name);
+
 /**
  * object_property_help:
  * @name: the name of the property
diff --git a/qom/container.c b/qom/container.c
index cfec92a944..20ab74b0e8 100644
--- a/qom/container.c
+++ b/qom/container.c
@@ -24,6 +24,16 @@ static void container_register_types(void)
     type_register_static(&container_info);
 }
 
+Object *object_property_add_new_container(Object *obj, const char *name)
+{
+    Object *child = object_new(TYPE_CONTAINER);
+
+    object_property_add_child(obj, name, child);
+    object_unref(child);
+
+    return child;
+}
+
 Object *container_get(Object *root, const char *path)
 {
     Object *obj, *child;
@@ -37,9 +47,7 @@ Object *container_get(Object *root, const char *path)
     for (i = 1; parts[i] != NULL; i++, obj = child) {
         child = object_resolve_path_component(obj, parts[i]);
         if (!child) {
-            child = object_new(TYPE_CONTAINER);
-            object_property_add_child(obj, parts[i], child);
-            object_unref(child);
+            child = object_property_add_new_container(obj, parts[i]);
         }
     }
 
-- 
2.45.0


