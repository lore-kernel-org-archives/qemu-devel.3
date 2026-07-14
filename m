Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E8AC44509
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 02:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjTAB-0008Ob-N5; Mon, 13 Jul 2026 22:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wjTA6-0008OL-10
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 22:46:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wjTA4-0006bm-Gx
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 22:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783997179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NH4CLgXr7cIs8gXKijQBNsDJjUwYRjOfRXe/kgW1Yys=;
 b=WKoaxXDa0WthYT/LWcHPiX1nY0frVSn4EKlZtdlWBDK582eAJgtnAkF9RD20M2qYgq293X
 quethBIGnMsjkCwQAm+Y9187iNKm4u6zprRZN4uzQwGsB4tQJIu8S6zTHZ8cOd7MzBxfki
 RTg/PaLEdX+yY8cW3p9u1mFmlju6EII=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-0_uMqlDCPZCDjPUlUtD_Pw-1; Mon, 13 Jul 2026 22:46:18 -0400
X-MC-Unique: 0_uMqlDCPZCDjPUlUtD_Pw-1
X-Mimecast-MFC-AGG-ID: 0_uMqlDCPZCDjPUlUtD_Pw_1783997177
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c860544c077so1055285a12.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 19:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783997177; x=1784601977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NH4CLgXr7cIs8gXKijQBNsDJjUwYRjOfRXe/kgW1Yys=;
 b=phIbm6d75pxXh25olzrP344l+WAx6bN8uNZlxnuEcGL+7F+j7LZYenmwXq8f4kKglI
 Di2pCj8c4VB5ibK3lGQMncfEksTyImuj7tBc73HIbqQ5IrOf9rwTKwFhniOCyF9++Jyd
 j4jdq3MUvVcBhjgF/KZ9CPNq8rC6ipbuNw3UwPhVGCb4ISF2Psc4sHiyHZAtJkhrTQLe
 Y8UxbbNV6OaoQpAs38+/BqkLD0x+zzbmNMvd35uSOEw4I6ApGnFfKPkx7GSLGGHdtrof
 +++Yy0EqxPoqMvHoRV6jWKAdfN9srSadjMo8WeSNwy5fjstwt5ISMTSLvgtClDKwPGBw
 YCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783997177; x=1784601977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NH4CLgXr7cIs8gXKijQBNsDJjUwYRjOfRXe/kgW1Yys=;
 b=kp2N8v6YZ1bESz5x7RdyqyoGjRDcIXT9BAAjmIIG3TTsxEp1fdaCyooGGWg1sZyxiW
 nmYwO/SiLor6u2fKiIEUGHTruq37x1NpmTBQxBnv8K/VpJPTRc52SHiUn0p1nxK5bGRB
 3bGcSybu2iPdxbDVeszIvzg8Uwx/WW/oTXtSU6VUlQCT8/koV1kHwjOCSdcOBcuI1Gtr
 P6uCuqNwAU1+wrhhuS+ruZ26zOU0qa4Fb8qkbh02sa+I4411W8JnMu5kMlIVw3SxpXHA
 iaCwLg/qAJnsynNPw3uDgTrQRa4lXVdEjbu2B4nAjxIaCTdNuWb5QJR6Sa4mnM+UG9Mj
 qMXg==
X-Gm-Message-State: AOJu0Yxxu5Tbu/L0/6BeSy+XXpMMVKFHVpn819TH1te94cPo0aAQbwgH
 nd9kfGc6UGx+ogB+mHk0ahDfhtfxyhlxp1qHPNNv/v07a6PEHaghH8miWFrbATwhfkxaCboH3t/
 tgBepL4Y8iG5055quhe3j9nhjAshbkzxdW9uE6L3vQkbXoHFf3kruIxRd
X-Gm-Gg: AfdE7cnOvxgGqYoGWEQlZPTvdc9GARqIa01cJUhpqITCnLeEiipyW+UxP+wgVJOyDml
 NqLC1NEMElXnUPMk6/L7p9rY03afojYHfUSPCnSBlvVzlr+e7UzIkRW2I1A+ObDmOYZK56BrUXL
 F7PVHAEkaJi30zeyUUClzga8mpPgrF95EvLLzRFv69KWgnMGZRO8XE6DRaK8qoXFrZw1BUcGl+Q
 +bqRFDun9bDTP5A3+6K4D9zDgRduCq/uCoUASGR2QsAHGHV0L9d+cWL6JsfNJDTNnPVO+5f1bKP
 11O0CtTucURJJ6K2P/de2sO5Z7POV4C8kiV7/jEh0wO2Cl57Eo18J1B+Nafcn2V5PuTzIn+Csr5
 K1UM2k7qRvpODwss11jhm4+7VUKHRkvM/mzXAMt9QanHSXQ==
X-Received: by 2002:a05:6372:a80b:b0:3c2:dcdd:a861 with SMTP id
 adf61e73a8af0-3c2dcddc2eemr6701119637.43.1783997177238; 
 Mon, 13 Jul 2026 19:46:17 -0700 (PDT)
X-Received: by 2002:a05:6372:a80b:b0:3c2:dcdd:a861 with SMTP id
 adf61e73a8af0-3c2dcddc2eemr6701097637.43.1783997176784; 
 Mon, 13 Jul 2026 19:46:16 -0700 (PDT)
Received: from rhel9-box.lan ([223.236.229.143])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-13b924258a2sm60184658c88.1.2026.07.13.19.46.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 19:46:16 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Ani Sinha <anisinha@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 4/9] hw/misc/vmlaunchupdate: add api header
Date: Tue, 14 Jul 2026 08:15:23 +0530
Message-ID: <20260714024557.204578-5-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260714024557.204578-1-anisinha@redhat.com>
References: <20260714024557.204578-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=anisinha@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 .../standard-headers/misc/vmlaunchupdate.h    | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 include/standard-headers/misc/vmlaunchupdate.h

diff --git a/include/standard-headers/misc/vmlaunchupdate.h b/include/standard-headers/misc/vmlaunchupdate.h
new file mode 100644
index 0000000000..9845721ea5
--- /dev/null
+++ b/include/standard-headers/misc/vmlaunchupdate.h
@@ -0,0 +1,73 @@
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
+/* status code */
+enum VMLaunchUpdateStatus {
+    VM_LAUNCHUPDATE_SUCCESS,
+    VM_LAUNCHUPDATE_LOAD_FAIL,
+    VM_LAUNCHUPDATE_NOT_IGVM_INIT,
+};
+
+typedef struct {
+    /* api version */
+    uint16_t version;
+
+    /*
+     * The guest can read this in order to determine if loading new IGVM
+     * succeeded.
+     */
+    uint16_t status;
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


