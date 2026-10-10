Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95625CA9EBE
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 13:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFXH5-0001aQ-OW; Sat, 10 Oct 2026 09:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xFXH4-0001a5-4W
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 09:38:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xFXH2-0004Xl-MK
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 09:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791639484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ndOYHicgpkf8J4BJA1GdVtzODpq198mdZFqFo2vB6hU=;
 b=NTF3JOFid9tKu8bWC5F2XJJKLyN9QZSq0Sgij+TQu6s0pyGRbhUk8ek8LZ1CfnEIhgGav7
 uYvj+KrQ1dMDvmID0BuUo02Vb58ddvW2W8rsk2UDp9l8WOHumA9vJbE7qKCTqyoqKNQpMd
 djPjJ3kDAgjpQkvd0i5yvCAwMbrmbOs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-wGnPjsC8MuCGi3ChAOznRw-1; Sat,
 10 Oct 2026 13:38:02 +0000
X-MC-Unique: wGnPjsC8MuCGi3ChAOznRw-1
X-Mimecast-MFC-AGG-ID: wGnPjsC8MuCGi3ChAOznRw_1791639480
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CAC01944B11; Sat, 10 Oct 2026 13:38:00 +0000 (UTC)
Received: from laptop.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8DD1130000E5; Sat, 10 Oct 2026 13:37:55 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com,
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org,
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [PATCH v10 05/26] arm/cpu: Add infra to handle generated ID register
 definitions
Date: Sat, 10 Oct 2026 15:36:09 +0200
Message-ID: <20261010133725.642498-6-eric.auger@redhat.com>
In-Reply-To: <20261010133725.642498-1-eric.auger@redhat.com>
References: <20261010133725.642498-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Introduce an infrastructure to store the definition of all ID regs:
This include their name, index array of named fields and enum values
if any.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Co-authored-by: Khushit Shah <khushit.shah@nutanix.com>
Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>

---
v9 -> v10:
- commit description and comment slight rewording
- store RangeValues instead of Values

v7 -> v8:
- remove typedef struct ArmIdRegArchVal

v5 -> v6:
- add ArmIdRegArchVal
---
 target/arm/cpu-idregs.h | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 target/arm/cpu-idregs.h

diff --git a/target/arm/cpu-idregs.h b/target/arm/cpu-idregs.h
new file mode 100644
index 0000000000..e0399e251b
--- /dev/null
+++ b/target/arm/cpu-idregs.h
@@ -0,0 +1,41 @@
+/*
+ * ID registers and their field definition
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef TARGET_ARM_CPU_IDREGS_H
+#define TARGET_ARM_CPU_IDREGS_H
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "cpu.h"
+#include "cpu-sysregs.h"
+
+typedef struct ARM64SysRegArchValueRange {
+    uint64_t lo;
+    uint64_t hi;
+} ARM64SysRegArchValueRange;
+
+typedef struct ARM64SysRegField {
+    const char *name; /* name of the field, for instance CTR_EL0_IDC */
+    ARMIDRegisterIdx index; /* parent register, e.g. CTR_EL0_IDX */
+    int shift; /* lsb of the field in the register */
+    int length; /* highest bit number */
+    const ARM64SysRegArchValueRange *arch_value_ranges;
+    uint32_t arch_value_ranges_count;
+} ARM64SysRegField;
+
+typedef struct ARM64SysReg {
+    const char *name;   /* name of the sysreg, for instance CTR_EL0 */
+    ARMIDRegisterIdx index; /* register index, e.g. CTR_EL0_IDX */
+    struct ARM64SysRegField *fields;
+    uint32_t fields_count;
+    uint64_t writable_mask;
+} ARM64SysReg;
+
+/*
+ * List of exposed ID regs (automatically populated from AARCHMRS Registers.json)
+ */
+extern ARM64SysReg arm64_id_regs[NUM_ID_IDX];
+
+#endif
-- 
2.53.0


