Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11778D39406
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 09:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Eia-0006vf-1F; Thu, 02 Apr 2026 05:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w8EiY-0006vW-Ky
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 05:52:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w8EiX-0008RS-BA
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 05:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775123520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qIToqHE3DYdE6OROkXm1aZvJg+93ZnbgMttNmMm5Ihs=;
 b=LwfkUB5zjDgTVaF4ePdBgggVyo8rTYJALKQHLJXzhEngR+oxGUK0M/y0xBnLA1wZIjG3a9
 uPTlQPMZUiEymMGSjqOdV7bvOSl+zfltWr8WWD7mEQ/wDou83U+NeewShCFlMdxUFTRtce
 UbsPjxJX/gk0NO1huhp9s5ha/0DO9ls=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-BFZieF7GP8-DbkfgPZqHTQ-1; Thu,
 02 Apr 2026 05:51:56 -0400
X-MC-Unique: BFZieF7GP8-DbkfgPZqHTQ-1
X-Mimecast-MFC-AGG-ID: BFZieF7GP8-DbkfgPZqHTQ_1775123515
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3F4618005BD; Thu,  2 Apr 2026 09:51:55 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.44])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1360C196B088; Thu,  2 Apr 2026 09:51:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 04/10] cpu: Add a way to detect 32-bit mode from argv0
Date: Thu,  2 Apr 2026 11:51:26 +0200
Message-ID: <20260402095132.29245-5-thuth@redhat.com>
In-Reply-To: <20260402095132.29245-1-thuth@redhat.com>
References: <20260402095132.29245-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

In the future, we might want to avoid compiling certain targets separately
for 32-bit mode (i.e. -i386, -arm and -ppc) where the 64-bit variant is a
superset of the 32-bit variant. But it would be good to provide a way to
mimic the 32-bit behavior via the program name in case the users need this
compatibility for some scenarios. Thus add a function that checks
for the old 32-bit program names and sets a flag accordingly.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/qemu/target-info.h |  7 +++++++
 system/vl.c                |  1 +
 target-info.c              | 20 ++++++++++++++++++--
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 0713ab4bb16..aa9b2e9b0cf 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -9,6 +9,13 @@
 #ifndef QEMU_TARGET_INFO_H
 #define QEMU_TARGET_INFO_H
 
+/**
+ * target_info_adjust:
+ *
+ * Returns: Adjust the target according to the binary name of the executable.
+ */
+void target_info_adjust(const char *argv0);
+
 /**
  * target_name:
  *
diff --git a/system/vl.c b/system/vl.c
index 246623b3196..45c9f5d5c7a 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2884,6 +2884,7 @@ void qemu_init(int argc, char **argv)
 
     error_init(argv[0]);
     qemu_init_exec_dir(argv[0]);
+    target_info_adjust(argv[0]);
 
     os_setup_limits();
 
diff --git a/target-info.c b/target-info.c
index dea73b5fbca..b18fd4e0060 100644
--- a/target-info.c
+++ b/target-info.c
@@ -12,6 +12,21 @@
 #include "qemu/target-info-impl.h"
 #include "qapi/error.h"
 
+static bool force_32bit;
+
+void target_info_adjust(const char *argv0)
+{
+    switch (target_arch()) {
+    case SYS_EMU_TARGET_X86_64:
+        if (g_str_has_suffix(argv0, "-i386")) {
+            force_32bit = true;
+        }
+        break;
+    default:
+        break;
+    }
+}
+
 const char *target_name(void)
 {
     return target_info()->target_name;
@@ -107,10 +122,11 @@ bool target_base_x86(void)
 
 bool target_i386(void)
 {
-    return target_arch() == SYS_EMU_TARGET_I386;
+    return target_arch() == SYS_EMU_TARGET_I386 ||
+           (target_arch() == SYS_EMU_TARGET_X86_64 && force_32bit);
 }
 
 bool target_x86_64(void)
 {
-    return target_arch() == SYS_EMU_TARGET_X86_64;
+    return target_arch() == SYS_EMU_TARGET_X86_64 && !force_32bit;
 }
-- 
2.53.0


