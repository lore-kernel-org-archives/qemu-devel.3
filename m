Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390F4C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLun-0007LD-Vv; Tue, 20 Feb 2024 03:55:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcLuS-0006r0-5r
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:55:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcLuQ-0000H8-5u
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708419325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9vkV3sEnLSykwaV3Bl8KUF+agsW/xGneNvBODKpFcVU=;
 b=fCWRyOVAFQhAF0J1253IkLNx3XGGQdTVPnl8wQOw3HFsP07uJpvdZhC2TKbfO4stXFL4jX
 AnnrOBzyvkCmKs/p5O9vkESNUFgob+ibcRpE6w3Dd2ynRJNSsA61jRLOdhxbmKLxpB/pZR
 EHlqeseEGgG83VJjJUbbzcRxgGBBbIM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-GSvnlPXlPv2XjIxCp_aYGg-1; Tue, 20 Feb 2024 03:55:21 -0500
X-MC-Unique: GSvnlPXlPv2XjIxCp_aYGg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D39185A58F;
 Tue, 20 Feb 2024 08:55:21 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CDB29492BE3;
 Tue, 20 Feb 2024 08:55:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: John Snow <jsnow@redhat.com>,
	qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org
Subject: [PATCH v2 6/7] hw/ide: Remove the include/hw/ide.h legacy file
Date: Tue, 20 Feb 2024 09:55:04 +0100
Message-ID: <20240220085505.30255-7-thuth@redhat.com>
In-Reply-To: <20240220085505.30255-1-thuth@redhat.com>
References: <20240220085505.30255-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

There was only one prototype left in this legacy file. Move it to
ide-dev.h to finally get rid of it.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS               | 1 -
 include/hw/ide.h          | 9 ---------
 include/hw/ide/ide-dev.h  | 2 ++
 include/hw/ide/internal.h | 3 +--
 4 files changed, 3 insertions(+), 12 deletions(-)
 delete mode 100644 include/hw/ide.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d61fb9319..f3cbfb8818 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1936,7 +1936,6 @@ IDE
 M: John Snow <jsnow@redhat.com>
 L: qemu-block@nongnu.org
 S: Odd Fixes
-F: include/hw/ide.h
 F: include/hw/ide/
 F: hw/ide/
 F: hw/block/block.c
diff --git a/include/hw/ide.h b/include/hw/ide.h
deleted file mode 100644
index db963bdb77..0000000000
--- a/include/hw/ide.h
+++ /dev/null
@@ -1,9 +0,0 @@
-#ifndef HW_IDE_H
-#define HW_IDE_H
-
-#include "exec/memory.h"
-
-/* ide/core.c */
-void ide_drive_get(DriveInfo **hd, int max_bus);
-
-#endif /* HW_IDE_H */
diff --git a/include/hw/ide/ide-dev.h b/include/hw/ide/ide-dev.h
index 1f62e58ebc..708cc0fda3 100644
--- a/include/hw/ide/ide-dev.h
+++ b/include/hw/ide/ide-dev.h
@@ -179,4 +179,6 @@ typedef struct IDEDrive {
 
 void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp);
 
+void ide_drive_get(DriveInfo **hd, int max_bus);
+
 #endif
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index d3ec16a945..20dde37f45 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -4,10 +4,9 @@
 /*
  * QEMU IDE Emulation -- internal header file
  * only files in hw/ide/ are supposed to include this file.
- * non-internal declarations are in hw/ide.h
+ * non-internal declarations are in hw/include/ide-*.h
  */
 
-#include "hw/ide.h"
 #include "hw/ide/ide-bus.h"
 
 /* debug IDE devices */
-- 
2.43.2


