Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2932EE64007
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 19:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tECks-0006Ly-Vz; Thu, 21 Nov 2024 14:22:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tECkm-0006Jr-0U
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:22:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tECkk-0002Vf-6D
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732216928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q5jUbQ+yr7D30yRp58pGypHuu7/mFZdfnjPhz1jbr+M=;
 b=DGY1o+FpFQTe+0T4dOBMhGlWa8JR9/JTKclaECRqcGIuTqMv9TaPvXNZ+R3lvnr/d4EcCW
 QmtHRX4mmbdWQQ6F1XMkiQTOirmpGr7cQ33vP0D/X3iW/KXBvJI1k0Nn5Y+9zwN3IjugMg
 Q/1bRQYdfdRV4gOzcwEd0d7pLLblk98=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-Ds2dCPNmOGigCVueNBGksQ-1; Thu, 21 Nov 2024 14:22:07 -0500
X-MC-Unique: Ds2dCPNmOGigCVueNBGksQ-1
X-Mimecast-MFC-AGG-ID: Ds2dCPNmOGigCVueNBGksQ
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-83ac354a75fso136797239f.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 11:22:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732216926; x=1732821726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q5jUbQ+yr7D30yRp58pGypHuu7/mFZdfnjPhz1jbr+M=;
 b=EydCXb+BXBrXulFiTaqWufN7+yKz9Rrqf62Cw18Yb+r9qw21qWZbA/CfaqGVdG8UHe
 O7SCkblLOH3GGQi5uuDJRNLtj5Sadn5br7jDRj2ndfu/NEQAG4xoULdd+LFSRi/5Ebtl
 LbW1CQ59D4+h3lGpbpmX4WCu8tlNF9btnM3u6ClMUlS19/KYEYfCMc6bvmx7shDyvDg2
 qJSGEHcAtxIKZg2QY8YUdvWeUAapq61Tb0vUgzdkl0L5vip2HOBDOLGKYDXkvKb32HVE
 9lq0fB+VKLhkkkoUgnpuyfXzJv4xYNJerLETj14oMFaNcHfgOYhBgGF57UnxgI5FNf+W
 u31g==
X-Gm-Message-State: AOJu0YwxGwA3PzftrEq7zevxfBMDcprkiydiKA4Cnlhn2ppbQ9ghBpi/
 Ezv1y/Pu4Q4xNRfGJpSldiFh1c3teBeEgDPqSflYjXaYSNKUy4Mtwbfdg7bALVXqhmM+UM+xhRT
 LSerfr+BTIbwAxl9VUGZ/I2yRWatnfxTqfqacdDV+IlEVp7QmXPKUp+ukyATNzUXO0JEsIMd5rP
 ADHUAdh76JUGiqR5IuVNZIRDLjnEfdbGjsWA==
X-Gm-Gg: ASbGncuXTF701o/5uKy1oLhZEDIGc4z7ZvXwuT9/e+r1sSO7+fp2iYUxFREiXJVeMGm
 Ij4bG4k1IhPp06qg375SVZzvnlBQuAamIs21K0CCW7p4ChySHoZz0j1mPhyAa0bUYS6bvirGmpC
 SCcfzWp3YJQHPmQWdjV4BHGUM8BhhdPxiURfvWM8lDVGFlsgf/6icFDNQpifGApnjwcEXb1CL73
 blnczjqZ06Vjy4IOoJ6AtWmL9k8hkqToUuxMx/vblrfTZDm7Z64bnDHmB+OSp0cvAVrrBMcH1cP
 KXWZij2WKoJ8ZtvCQ7jTDguFKg==
X-Received: by 2002:a05:6602:6010:b0:83a:a96b:8825 with SMTP id
 ca18e2360f4ac-83ecdb2f0e2mr17085439f.0.1732216926508; 
 Thu, 21 Nov 2024 11:22:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXildkvXhpAGQK8aQuCiKNMlcM4vAJ2ggFaEQ8aeXQ9r2Wr7h7q8d7Z7os/XWtWCjc1sF7WA==
X-Received: by 2002:a05:6602:6010:b0:83a:a96b:8825 with SMTP id
 ca18e2360f4ac-83ecdb2f0e2mr17082839f.0.1732216926216; 
 Thu, 21 Nov 2024 11:22:06 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e1cfe345f0sm102939173.45.2024.11.21.11.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 11:22:05 -0800 (PST)
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
Subject: [PATCH v2 01/13] qom: Add TYPE_CONTAINER macro
Date: Thu, 21 Nov 2024 14:21:50 -0500
Message-ID: <20241121192202.4155849-2-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241121192202.4155849-1-peterx@redhat.com>
References: <20241121192202.4155849-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Provide a macro for the container type across QEMU source tree, rather than
hard code it every time.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qom/object.h | 1 +
 hw/arm/stellaris.c   | 2 +-
 qom/container.c      | 4 ++--
 qom/object.c         | 4 ++--
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 43c135984a..3ba370ce9b 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -26,6 +26,7 @@ typedef struct InterfaceClass InterfaceClass;
 typedef struct InterfaceInfo InterfaceInfo;
 
 #define TYPE_OBJECT "object"
+#define TYPE_CONTAINER "container"
 
 typedef struct ObjectProperty ObjectProperty;
 
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 376746251e..6d518b9cde 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1053,7 +1053,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     flash_size = (((board->dc0 & 0xffff) + 1) << 1) * 1024;
     sram_size = ((board->dc0 >> 18) + 1) * 1024;
 
-    soc_container = object_new("container");
+    soc_container = object_new(TYPE_CONTAINER);
     object_property_add_child(OBJECT(ms), "soc", soc_container);
 
     /* Flash programming is done via the SCU, so pretend it is ROM.  */
diff --git a/qom/container.c b/qom/container.c
index 455e8410c6..cfec92a944 100644
--- a/qom/container.c
+++ b/qom/container.c
@@ -15,7 +15,7 @@
 #include "qemu/module.h"
 
 static const TypeInfo container_info = {
-    .name          = "container",
+    .name          = TYPE_CONTAINER,
     .parent        = TYPE_OBJECT,
 };
 
@@ -37,7 +37,7 @@ Object *container_get(Object *root, const char *path)
     for (i = 1; parts[i] != NULL; i++, obj = child) {
         child = object_resolve_path_component(obj, parts[i]);
         if (!child) {
-            child = object_new("container");
+            child = object_new(TYPE_CONTAINER);
             object_property_add_child(obj, parts[i], child);
             object_unref(child);
         }
diff --git a/qom/object.c b/qom/object.c
index 9edc06d391..214d6eb4c1 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1739,7 +1739,7 @@ Object *object_get_root(void)
     static Object *root;
 
     if (!root) {
-        root = object_new("container");
+        root = object_new(TYPE_CONTAINER);
     }
 
     return root;
@@ -1755,7 +1755,7 @@ Object *object_get_internal_root(void)
     static Object *internal_root;
 
     if (!internal_root) {
-        internal_root = object_new("container");
+        internal_root = object_new(TYPE_CONTAINER);
     }
 
     return internal_root;
-- 
2.45.0


