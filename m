Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5327606A8B3
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Za2mghXz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUtx-0005wN-9c; Thu, 12 Nov 2026 08:31:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUtt-0005ut-9C
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUtr-0002go-Mm
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794490294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UNNq8oixdBHXOAhHUjtXqdWFxGzS3Ad+oPsMBMZL+EA=;
 b=Za2mghXzwRk8AkdS6fgLQBVi15ZgFbHxOtX/3ZLNRxe2i0B+HR8B7bb6f7jTqCGXCc5J7D
 +Am18ZUwfw2Nn36644PROppDXbMQqbZTo5c3ymcpIjQU9cHDov9sy13maE/TFKx642GI7D
 zns0Tbxsu0zLtj8ThByba8WoRv1q3j4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-9Y0tR6d8Puu9MjmE7V2aCA-1; Thu,
 12 Nov 2026 08:31:30 -0500
X-MC-Unique: 9Y0tR6d8Puu9MjmE7V2aCA-1
X-Mimecast-MFC-AGG-ID: 9Y0tR6d8Puu9MjmE7V2aCA_1794490289
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42D3918301B7; Thu, 12 Nov 2026 13:31:29 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C20651956089; Thu, 12 Nov 2026 13:31:27 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 17/48] hw/m68k: convert machines to use AliasedClass interface
Date: Thu, 12 Nov 2026 13:30:23 +0000
Message-ID: <20261112133054.1977618-18-berrange@redhat.com>
In-Reply-To: <20261112133054.1977618-1-berrange@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Stop setting 'alias' in the MachineClass and instead set
'aliases' in the AliasedClass.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/m68k/virt.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 2418bd3d503..487d9bcc8d0 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -36,6 +36,7 @@
 #include "hw/intc/goldfish_pic.h"
 #include "hw/virtio/virtio-mmio.h"
 #include "hw/virtio/virtio-blk.h"
+#include "qom/object_interfaces.h"
 
 /*
  * 6 goldfish-pic for CPU IRQ #1 to IRQ #6
@@ -362,10 +363,19 @@ type_init(virt_machine_register_types)
     } \
     type_init(MACHINE_VER_SYM(register, virt, __VA_ARGS__));
 
+#define DEFINE_VIRT_MACHINE_ALIASES_LATEST(...) \
+    AliasedClass *alc = ALIASED_CLASS(oc); \
+    static const char *const MACHINE_VER_SYM(aliases, virt, __VA_ARGS__)[] = \
+    { \
+        MACHINE_TYPE_NAME("virt"), \
+        NULL, \
+    }; \
+    alc->aliases = MACHINE_VER_SYM(aliases, virt, __VA_ARGS__)
+
 #define DEFINE_VIRT_MACHINE_AS_LATEST(major, minor) \
     DEFINE_VIRT_MACHINE_IMPL({ \
-            mc->alias = "virt"; \
-    }, major, minor)
+            DEFINE_VIRT_MACHINE_ALIASES_LATEST(major, minor); \
+        }, major, minor)
 #define DEFINE_VIRT_MACHINE(major, minor) \
     DEFINE_VIRT_MACHINE_IMPL({}, major, minor)
 
-- 
2.56.1


