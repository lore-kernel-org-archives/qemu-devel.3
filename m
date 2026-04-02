Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501CCD39408
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 09:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8EiU-0006vD-OL; Thu, 02 Apr 2026 05:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w8EiT-0006uw-Da
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 05:51:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w8EiS-0008R9-1f
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 05:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775123515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ifGxciXy4r1cBFdgwsNUn3esmmMxTsd1o+9eR3AZdCY=;
 b=dv1YI4XrKEmMX/Zt2Oo13rUJH4BE6rgNyaSFSxxmRGMPiWmiHiZ3s2/X0VrU4W2rypdUYy
 lfUPm3NCwulFrj4pjCA1TYlulPAYZ5jfOgypX/0NyyFPAmtm+gSRPmvIKymJt0rk0IgTVO
 q/ClnUfj9sgv5oDQfZcBKJOtz4STjp8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-7nke4crjMUKsWlTaIIdl0Q-1; Thu,
 02 Apr 2026 05:51:52 -0400
X-MC-Unique: 7nke4crjMUKsWlTaIIdl0Q-1
X-Mimecast-MFC-AGG-ID: 7nke4crjMUKsWlTaIIdl0Q_1775123511
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FAB818002C9; Thu,  2 Apr 2026 09:51:51 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.44])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 92CDB196B088; Thu,  2 Apr 2026 09:51:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 03/10] target-info: Add functions for querying whether the
 target is i386 or x86_64
Date: Thu,  2 Apr 2026 11:51:25 +0200
Message-ID: <20260402095132.29245-4-thuth@redhat.com>
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

As we already have functions for querying whether the target architecture
is one of the various ppc, arm or s390x flavours, add now some functions
for x86, too, which will come in handy to decide during runtime whether
we are running in 32 or 64-bit mode in the x86 targets.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/qemu/target-info.h | 21 +++++++++++++++++++++
 target-info.c              | 21 +++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 23c997de541..0713ab4bb16 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -99,4 +99,25 @@ bool target_ppc64(void);
  */
 bool target_s390x(void);
 
+/**
+ * target_base_x86:
+ *
+ * Returns whether the target architecture is x86 (32-bit or 64-bit).
+ */
+bool target_base_x86(void);
+
+/**
+ * target_i386:
+ *
+ * Returns whether the target architecture is x86 32-bit.
+ */
+bool target_i386(void);
+
+/**
+ * target_x86_64:
+ *
+ * Returns whether the target architecture is x86 64-bit.
+ */
+bool target_x86_64(void);
+
 #endif
diff --git a/target-info.c b/target-info.c
index 28c458fc7a7..dea73b5fbca 100644
--- a/target-info.c
+++ b/target-info.c
@@ -93,3 +93,24 @@ bool target_s390x(void)
 {
     return target_arch() == SYS_EMU_TARGET_S390X;
 }
+
+bool target_base_x86(void)
+{
+    switch (target_arch()) {
+    case SYS_EMU_TARGET_I386:
+    case SYS_EMU_TARGET_X86_64:
+        return true;
+    default:
+        return false;
+    }
+}
+
+bool target_i386(void)
+{
+    return target_arch() == SYS_EMU_TARGET_I386;
+}
+
+bool target_x86_64(void)
+{
+    return target_arch() == SYS_EMU_TARGET_X86_64;
+}
-- 
2.53.0


