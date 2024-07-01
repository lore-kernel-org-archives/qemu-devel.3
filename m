Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40354C30659
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 13:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOH4C-0005Hf-2I; Mon, 01 Jul 2024 09:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sOH3z-0005GC-Nr
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:27:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sOH3l-00030c-3i
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719840424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=N6cnottun+iMZmb6yYvzFL/OwwLnhULHbKpfkC3/hgw=;
 b=Vp+bcqduItHRsVyi7D/RvVPYw16rTich0571kbCdyluHOgmhjmKf31wXnBeTEWfRUcrCOQ
 b0nJvOkJowtUkJq5w6V969IQpU3hGcwLrCyd/cH3WZRo0lICOdSpFy3e+Wo2RCrKj9hal+
 Ou48KCdgF3j252fBo79MySVzWoNq+IQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-BI_FzLZ4PAqenTNucD2WBA-1; Mon,
 01 Jul 2024 09:26:58 -0400
X-MC-Unique: BI_FzLZ4PAqenTNucD2WBA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9109D1944D28; Mon,  1 Jul 2024 13:26:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.71])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6D55419560A3; Mon,  1 Jul 2024 13:26:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Jiri Slaby <jslaby@suse.cz>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-trivial@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH] Remove inclusion of hw/hw.h from files that don't need it
Date: Mon,  1 Jul 2024 15:26:49 +0200
Message-ID: <20240701132649.58345-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

hw/hw.h only contains the prototype of hw_error() nowadays, so
files that don't use this function don't need to include this
header.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/misc/xlnx-cfi-if.h | 1 -
 hw/misc/edu.c                 | 1 -
 hw/vfio/container.c           | 1 -
 3 files changed, 3 deletions(-)

diff --git a/include/hw/misc/xlnx-cfi-if.h b/include/hw/misc/xlnx-cfi-if.h
index f9bd12292d..5010401517 100644
--- a/include/hw/misc/xlnx-cfi-if.h
+++ b/include/hw/misc/xlnx-cfi-if.h
@@ -11,7 +11,6 @@
 #define XLNX_CFI_IF_H 1
 
 #include "qemu/help-texts.h"
-#include "hw/hw.h"
 #include "qom/object.h"
 
 #define TYPE_XLNX_CFI_IF "xlnx-cfi-if"
diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index fa052c44db..504178b4a2 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -26,7 +26,6 @@
 #include "qemu/log.h"
 #include "qemu/units.h"
 #include "hw/pci/pci.h"
-#include "hw/hw.h"
 #include "hw/pci/msi.h"
 #include "qemu/timer.h"
 #include "qom/object.h"
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 2e7ecdf10e..88ede913d6 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -26,7 +26,6 @@
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
 #include "exec/ram_addr.h"
-#include "hw/hw.h"
 #include "qemu/error-report.h"
 #include "qemu/range.h"
 #include "sysemu/reset.h"
-- 
2.45.2


