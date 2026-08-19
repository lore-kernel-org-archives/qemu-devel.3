Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F49C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 04:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwXeF-0004Tb-14; Wed, 19 Aug 2026 00:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wwXeD-0004TF-CK
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 00:11:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wwXeB-00070D-FX
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 00:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787112685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DiIwod5/S8mOjjS5uw8SZA/QvQKKRd1GWS+1TkqWjm4=;
 b=Qlms9jSoqmfwVKkFmtvtAeY4zBrHk79QdlGndszwuTesWCWkEs0vlXeIVTuggWQ2DAmV+u
 24NrkcOoAnuDtvP/SIZ2SMUborDj/WpyBfu6uH0lsE1a7pFL0m7UeKomV3CkFVhj0Bc2GH
 iJ4pjo1KnNz8Udlc5a8xI/P93x0R1PE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-BxoAGUNSMzKHPHjZ0BFDXg-1; Wed, 19 Aug 2026 00:11:22 -0400
X-MC-Unique: BxoAGUNSMzKHPHjZ0BFDXg-1
X-Mimecast-MFC-AGG-ID: BxoAGUNSMzKHPHjZ0BFDXg_1787112682
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e8e864ef0so1191205a91.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 21:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787112681; x=1787717481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DiIwod5/S8mOjjS5uw8SZA/QvQKKRd1GWS+1TkqWjm4=;
 b=migTcTgvgFaIkGTly47OOs9DP+mmrUvMz76oPntmyzrFpllDtGvKUbFdobI3qMD1Lz
 BaOYKztXVIXLFQzffojcK749TQKRnEGhpsQy2LMysTyeG0RzmkWyIrd3LmDG6S33yC13
 RFZaoVxd1U7ZvTTGVXz5qijERV/RrdWZMN8htmhU30NM2Hp8izRAQ68CoVnZ5GdeFsZ1
 T6ef24ybhIxFjePTJ4KcAXVz3emGuVoAuums2tHCCLNGWGgkkO0pajY2G1JakyfOrZuf
 LwCk/CA8lmswmR3qbifUYT8h5AndKCOGLDOBOSk2aVfkb4T1ay13VXPsHoBtxpPKApME
 edXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787112681; x=1787717481;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DiIwod5/S8mOjjS5uw8SZA/QvQKKRd1GWS+1TkqWjm4=;
 b=S0xMVCvy3IA+f/+6sFGNG5YtyLfeFixeNKk2w8GsenyH1bf0P2n4Z2uyzrNfKA35Vw
 IXMl8ItrEfa3BOF24Se1x5zYY4U9PhwWXnEnYg78eZPvtguE75HU9Jgi/VikTtAHQHew
 o1c6UGSADtGZkemDX1spBQyDfeSe3AMIFTndpxNW5LHAawg7ATwU37RMR8VWcPQ9ItJT
 7ylqs+jhJs3Tg0LGvFiZ2MQ44byobKeDbCXgtNQ5m4sWKGM0l43cUt5awTSkC1L5sLRL
 7aSq31/8V6I8byDKXxAXUwTaNsFeT1X6Ihxy24olFZpJZcra1TLvF4/4g3nHos7+KuYY
 QpLg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqOnSSt7d+EQOnSHuiVCRxSZWTIwWSbOpakzHzHBDY5ZBgg41dIEx3t3p9ARO2tBpkK8j+GswIRjYAE@nongnu.org
X-Gm-Message-State: AOJu0YwgHkx7LmpPSQ4tc/+s1PIt/S+dYbmSHZPyX7qe+FooOAZ75lqM
 X5OcBGq/s0KvNknbdCbhZdOqBKYw6gOQUJtOfF3iekNOkHSxUsjCUsc4Z23Bp8X+P8Ggma5VKKK
 tOeZhdk8mk8o8H9ueOiWVxmUVy24fo0/tcP1QzNnrfoDA6oXfvvObu6UV
X-Gm-Gg: AR+sD10cNELImt4jrK+s16qEqL9Ot3dRU2oEnt2IlZ4UJSwKeF+dKIlDE20WoezWVxa
 JDBs71Su0sxKPaTnmQsmLus9QdXI+eEGbhMNEYPVgTc4JkC9Aq0N4J6YXUv+TkpIsdnXXxmbJTj
 oKFzCVSkv7oJypeo9LtUIC3l8qslELuPvcKPxL0hldE+DMcrR+2eY3G9JxSGoXGMP/oPj6Tl9O6
 MGxSN5XAx7wg51oVQ8MSiSl7BuoPAz+FyM+w53O/DncCcTW/eYsDqGaqNWKSWbhsY4DeMyMx2mu
 ehRiCXM9tPi1QAC5iqLqueYNDjBAS76J65zYTpZb8WybU2n3KZk+c3k+c8XJ5J0IXRlLOKNWCNW
 pTHywHvJ42qPuLP375XIJOY77kM38W9k0Dg==
X-Received: by 2002:a17:90b:1f82:b0:38e:9e9d:9209 with SMTP id
 98e67ed59e1d1-3958110fe3emr3337345a91.17.1787112681504; 
 Tue, 18 Aug 2026 21:11:21 -0700 (PDT)
X-Received: by 2002:a17:90b:1f82:b0:38e:9e9d:9209 with SMTP id
 98e67ed59e1d1-3958110fe3emr3337277a91.17.1787112680968; 
 Tue, 18 Aug 2026 21:11:20 -0700 (PDT)
Received: from rhel9-box.lan ([106.219.133.98])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1416ad53874sm3126245c88.4.2026.08.18.21.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 21:11:20 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Ani Sinha <anisinha@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: agraf@csgraf.de,
	graf@amazon.com,
	qemu-devel@nongnu.org
Subject: [PATCH v7] hw/misc/vmlaunchupdate: add api header
Date: Wed, 19 Aug 2026 09:41:05 +0530
Message-ID: <20260819041105.110625-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a separate header file for guest usable api definitions.

CC: Alex Graf <graf@amazon.com>
CC: Gerd Hoffman <kraxel@redhat.com>
Reviewed-by: Alexander Graf <graf@amazon.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 .../standard-headers/misc/vmlaunchupdate.h    | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 include/standard-headers/misc/vmlaunchupdate.h

changelog:
v7: add specific values to enum as suggested by Gerd here
https://lists.gnu.org/archive/html/qemu-devel/2026-08/msg03621.html

diff --git a/include/standard-headers/misc/vmlaunchupdate.h b/include/standard-headers/misc/vmlaunchupdate.h
new file mode 100644
index 0000000000..7f8382a765
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
2.42.0


