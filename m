Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7679AD2127F
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 11:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1OpB-0008Rs-0f; Thu, 17 Oct 2024 07:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1Om6-00042n-JJ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 07:34:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1Om1-0005wM-Gi
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 07:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729164872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1d4iX6Pf/NWlsbTPiodlZ9enIXT/LGLAwSUkDqB8jO0=;
 b=OgFBV6N0DMdSk1s9uIEWhMPCSBGrFWattuiYHWp5JWHuZlue18gued7R0siKbNjXeesHjB
 4focIQLv27m2HJNEnwaQKy+3IAeo1nYKhnxhWOkbYi0txipG20eY46WXPH/0H54Vv6K9d7
 klAZuPvqokA0Lwc7Wc+GNqNo9KmayFY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-BMbAGY4UPL6bzgDVFr5KBg-1; Thu,
 17 Oct 2024 07:34:31 -0400
X-MC-Unique: BMbAGY4UPL6bzgDVFr5KBg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91B7F1956058
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 11:34:30 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.94])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5424119560A2; Thu, 17 Oct 2024 11:34:29 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 24/31] target: adapt to new import path for qobject data
 type headers
Date: Thu, 17 Oct 2024 12:33:36 +0100
Message-ID: <20241017113344.883424-25-berrange@redhat.com>
In-Reply-To: <20241017113344.883424-1-berrange@redhat.com>
References: <20241017113344.883424-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The qobject data type headers have moved from qapi/qmp/ to
qobject/.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 target/arm/arm-qmp-cmds.c             | 2 +-
 target/i386/cpu-apic.c                | 2 +-
 target/i386/cpu-sysemu.c              | 2 +-
 target/i386/monitor.c                 | 2 +-
 target/loongarch/loongarch-qmp-cmds.c | 2 +-
 target/ppc/cpu_init.c                 | 2 +-
 target/riscv/riscv-qmp-cmds.c         | 4 ++--
 target/s390x/cpu_models_sysemu.c      | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 3cc8cc738b..c89fd3258f 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -28,7 +28,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-commands-machine-target.h"
 #include "qapi/qapi-commands-misc-target.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qom/qom-qobject.h"
 
 static GICCapability *gic_cap_new(int version)
diff --git a/target/i386/cpu-apic.c b/target/i386/cpu-apic.c
index d397ec94dc..9fd4d6eab5 100644
--- a/target/i386/cpu-apic.c
+++ b/target/i386/cpu-apic.c
@@ -7,7 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/error.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp-target.h"
diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
index 227ac021f6..96b8006b27 100644
--- a/target/i386/cpu-sysemu.c
+++ b/target/i386/cpu-sysemu.c
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-run-state.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qom/qom-qobject.h"
 #include "qapi/qapi-commands-machine-target.h"
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 2d766b2637..3ea92b066e 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -27,7 +27,7 @@
 #include "monitor/monitor.h"
 #include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc-target.h"
 #include "qapi/qapi-commands-misc.h"
diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
index 8721a5eb13..f45c532e42 100644
--- a/target/loongarch/loongarch-qmp-cmds.c
+++ b/target/loongarch/loongarch-qmp-cmds.c
@@ -10,7 +10,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine-target.h"
 #include "cpu.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qom/qom-qobject.h"
 
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 23881d09e9..b62c49b6d5 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -32,7 +32,7 @@
 #include "qemu/module.h"
 #include "qemu/qemu-print.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qnull.h"
+#include "qobject/qnull.h"
 #include "qapi/visitor.h"
 #include "hw/qdev-properties.h"
 #include "hw/ppc/ppc.h"
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index d363dc318d..aff59b83c6 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -26,8 +26,8 @@
 
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine-target.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qbool.h"
+#include "qobject/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/visitor.h"
 #include "qom/qom-qobject.h"
diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
index f6df691b66..ea595a00d4 100644
--- a/target/s390x/cpu_models_sysemu.c
+++ b/target/s390x/cpu_models_sysemu.c
@@ -18,7 +18,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qapi/qobject-input-visitor.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/qapi-commands-machine-target.h"
 
 static void list_add_feat(const char *name, void *opaque);
-- 
2.46.0


