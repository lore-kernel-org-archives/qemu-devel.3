Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A64C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 16:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxRpy-0006Xs-43; Fri, 21 Aug 2026 12:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wxRpu-0006Vd-TL
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 12:11:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wxRps-0001Yw-Mz
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 12:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787328676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UHHbXCFXSIBwhZO+RcdwANDP52+6cNIBxovkI1SsLo8=;
 b=NX4o5MzUed3Ynn/V8LB1x5CmmtTJubmHwfVoKmcNeRljmI0aEJH/iDZ1OqAXKsAxrAXZhS
 2P7R870cUOKTYDZlth0FVH+FdTzx0n3AL4LBXTVQtZDKU7WrCqXiLJmIsCd2Nezb15XP6k
 qivL6ZCGJ/gv9xWMztVZurk27vX+fGs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-XbiGUgXYNBa9VbvfCnYJHQ-1; Fri,
 21 Aug 2026 12:11:11 -0400
X-MC-Unique: XbiGUgXYNBa9VbvfCnYJHQ-1
X-Mimecast-MFC-AGG-ID: XbiGUgXYNBa9VbvfCnYJHQ_1787328670
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 186E61953985; Fri, 21 Aug 2026 16:11:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.30])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C54401800257; Fri, 21 Aug 2026 16:11:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C6E9D1800D49; Fri, 21 Aug 2026 18:11:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Gerd Hoffman <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Alex Graf <graf@amazon.com>
Subject: [PULL 07/12] hw/misc/vmlaunchupdate: add api header
Date: Fri, 21 Aug 2026 18:10:55 +0200
Message-ID: <20260821161103.3489298-8-kraxel@redhat.com>
In-Reply-To: <20260821161103.3489298-1-kraxel@redhat.com>
References: <20260821161103.3489298-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

From: Ani Sinha <anisinha@redhat.com>

Add a separate header file for guest usable api definitions.

CC: Alex Graf <graf@amazon.com>
CC: Gerd Hoffman <kraxel@redhat.com>
Reviewed-by: Alexander Graf <graf@amazon.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Message-ID: <20260819041105.110625-1-anisinha@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 .../standard-headers/misc/vmlaunchupdate.h    | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 include/standard-headers/misc/vmlaunchupdate.h

diff --git a/include/standard-headers/misc/vmlaunchupdate.h b/include/standard-headers/misc/vmlaunchupdate.h
new file mode 100644
index 000000000000..7f8382a765d1
--- /dev/null
+++ b/include/standard-headers/misc/vmlaunchupdate.h
@@ -0,0 +1,102 @@
+/*
+ * Guest driven VM launch state update device via IGVM.
+ * The definitions in this header defines the API for the hypervisor interface.
+ * For details and specification, please look at docs/specs/vmlaunchupdate.rst.
+ *
+ * Copyright (C) 2026 Red Hat, Inc.
+ *
+ * Authors: Ani Sinha <anisinha@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+#ifndef VMLAUNCHUPDATE_API_H
+#define VMLAUNCHUPDATE_API_H
+
+/* fw-cfg file definition */
+#define FILE_VMLAUNCHUPDATE "etc/vmlaunchupdate"
+
+/* version */
+#define VM_LAUNCHUPDATE_VERSION 0x01
+
+/* format bits, used by both 'capabilities' and 'control'  */
+
+/* igvm */
+#define VM_LAUNCHUPDATE_FORMAT_IGVM           (1ULL << 32)
+
+/* 'control' field bits  */
+
+/* disable vmlaunchupdate interface */
+#define VM_LAUNCHUPDATE_CTL_DISABLE            (1 << 0)
+/* revert to the original host provided igvm */
+#define VM_LAUNCHUPDATE_CTL_HOST_IGVM          (1 << 1)
+
+/* The combination of the above two ctl interfaces work as
+ * follows:
+ *
+ * A) CTL_HOST_IGVM=off CTL_DISABLE=off
+ *
+ * Supplied IGVM file replaces the firmware permanently.  Updating the
+ * firmware again is possible.
+ *
+ * B) CTL_HOST_IGVM=off CTL_DISABLE=on
+ *
+ * Supplied IGVM file replaces the firmware permanently.  Updating the
+ * firmware again is not possible.
+ *
+ * C) CTL_HOST_IGVM=on CTL_DISABLE=off
+ *
+ * Supplied IGVM file replaces the firmware for one reset.  Resetting
+ * again will switch back to the original firmware.  Updating the
+ * firmware again is possible.
+ *
+ * D) CTL_HOST_IGVM=on CTL_DISABLE=on
+ *
+ * Supplied IGVM file replaces the firmware for one reset.  Resetting
+ * again will switch back to the original firmware.  Updating the
+ * firmware again is NOT possible.
+ *
+ */
+
+/* status code */
+enum VMLaunchUpdateStatus {
+    VM_LAUNCHUPDATE_SUCCESS = 0,
+    VM_LAUNCHUPDATE_LOAD_FAIL = 1,
+    VM_LAUNCHUPDATE_NOT_IGVM_INIT = 2,
+};
+
+typedef struct QEMU_PACKED {
+    /* api version */
+    uint16_t version;
+
+    /*
+     * The guest can read this in order to determine if loading new IGVM
+     * succeeded.
+     */
+    uint16_t status;
+
+    uint32_t _padding;
+
+    /* VMM capabilities, read-only. */
+    uint64_t capabilities;
+    /* control bits, see VMFWUPDATE_CTL_* */
+    uint64_t control;
+
+    /*
+     * address and size of the IGVM image.  Will be cleared when
+     * the write completes successfully and IGVM file is correctly parsed.
+     */
+    uint64_t fw_image_addr;
+    uint64_t fw_image_size;
+
+    /*
+     * address + size of opaque blob.  The guest can use this to pass on
+     * information, for example which memory region the linux kernel has been
+     * loaded to.  writable, will be kept intact on firmware update.
+     */
+    uint64_t opaque_addr;
+    uint64_t opaque_size;
+
+} VMLaunchUpdate;
+
+#endif
-- 
2.55.0


