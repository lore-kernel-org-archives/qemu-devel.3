Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6076BC43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNx2-0007ow-QN; Sun, 05 Jul 2026 10:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNx1-0007OK-9F
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:36:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwy-0001To-Tq
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/hrhP2vErrhnWdlJ9qXwUQ+a7VJaYAqlc0qLDKyd82o=;
 b=iJNYvUlkTowvPLpWShOXi9xDE4gtQqHHzRZwtwKnUTh4Z7KZ4xwpRNrAjiypEyRkZULuu6
 r6mHcei9l32HDr9nHxmA+lYZBO3kqplHSkAYnrfACY+3EtEqX05mV8gC2DYUVH+cE2gsnZ
 kdDHwSvTiTXmpMnc6P/ME1TqynTBVWM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-5v0jtE-JMUGdHGT7tQE30Q-1; Sun, 05 Jul 2026 10:36:02 -0400
X-MC-Unique: 5v0jtE-JMUGdHGT7tQE30Q-1
X-Mimecast-MFC-AGG-ID: 5v0jtE-JMUGdHGT7tQE30Q_1783262161
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-472a798fc7cso1004196f8f.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262161; x=1783866961; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/hrhP2vErrhnWdlJ9qXwUQ+a7VJaYAqlc0qLDKyd82o=;
 b=goCmst/brLPMj8KmZ9ge60tLK6IeL7A+sQ2B/jaWnyOaZrVaGQBGUijmDbvyRD+nCO
 8lCrAB6gpWQz+M3lqF/fA4LM6jTtnpVIVd1zOZYsqOWalL0iBh4z7KEwqDzthRlkoEis
 ph6FutNt8qd0xUb4BApsgHkAVa64MTGa40WxKUZUc0wJ/0GM6nL7sN39KkT/hWWt/zRP
 PIbkYkNPtzrHHVHiS7xrrRuRAaF4p0d9jjdChCn58wQJXu8MrFviRK5YcqtrNzzOkORK
 Bow+PrDaplrF++b/O4jzQ8kvT2LZfwT9jYzRnK2y/KD7ZzB3u1TdX84PG3p3nir4hHHT
 DV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262161; x=1783866961;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/hrhP2vErrhnWdlJ9qXwUQ+a7VJaYAqlc0qLDKyd82o=;
 b=qigxIupcDIYgOF0nUgb6zLtgY7qqhA2eeQ+9qVkML1q8OPYRP+UWlc/XYHlUUjk2V2
 j2blPTXg071Bq/BjowW91NAI8FTYBelMtK5gKNWjEqNdRgYs2fLAkWJc77Aq/i5D64/u
 G8yeP10nMaF6rsmPI+oUTKv/ZeH8bB5ea191NgRVt3O3xfHXHfbDjYyUTxOiYd4fYsGJ
 Six5bc2MM2k9OsaAaeGs6viaJG1XoGXGCX8WhoB4+1TyHQpz5l2WYQR54MBY56AocBVl
 prsWSbdV9rTJHxKu2xiSVD93pW7nx7ldX7dLqkN0vHf8CSqBYoBbgsKxFDuomK6cCTD+
 dHVA==
X-Gm-Message-State: AOJu0YxXXcDw/CHILKE4rcw0Wio+EN4ofpdy5q68z64nnkgPj+HZKk0g
 Le7L3yGmThYrFB/4WxgjI/lBqwEU/Z2XJNN2z2SyO1SJ2zbiBiodjkx4yYb4bC5AQ5AWmV0gc0a
 STphW98O0RG1coErzf3Kec8GcWkARFb/a4ISJfs+DH63UzyHnebwSqT/y//1pYAubr2OMM9klB7
 tPESOvGVHOLDUVa+uCOeSgplYXepAWyavVNg==
X-Gm-Gg: AfdE7cm7CPrz2olx+7iqWe6PAg3ZuHA6f3SsNVt3orIDNwS4dHiCtGzMJiNZLjzO4hf
 34fAS5xczk9IumDIQa7xJcmxeatM8asXdsQfgX2AJnRs87Yx/81Gg9RK/qpOhIgQCJVfZkEDYQc
 AnG19IamCYRSxUH2KHW1FEtsw3KM01GP56UWVnL8sfGaK9Hq+mRr75QAHe8rfm3PWzb871KBn70
 VGDr+J0tFmwgSfRRsP+GZm3a+YrbVidnO3Orofrsw27wOQJZP3G1gu+BVlAXQrgCwL3tXPAVWqy
 rZYMGAxszNr+DswzAfhrDu8Dfn4LtH1U2Krv2nRhBlSD7j3QiPRU3mwaPPromU4omwDtR7mFHnn
 ifGm36zkElo7R2fJnYOq0BFCYW9bStyUb
X-Received: by 2002:a05:6000:61e:b0:475:f0f0:9eca with SMTP id
 ffacd0b85a97d-47aad35e8b4mr8420846f8f.53.1783262161362; 
 Sun, 05 Jul 2026 07:36:01 -0700 (PDT)
X-Received: by 2002:a05:6000:61e:b0:475:f0f0:9eca with SMTP id
 ffacd0b85a97d-47aad35e8b4mr8420803f8f.53.1783262160780; 
 Sun, 05 Jul 2026 07:36:00 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039ad21sm16547173f8f.20.2026.07.05.07.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:36:00 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:35:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 32/44] acpi: introduce WDAT table for GWDT
Message-ID: <beadd272c10289c0086d66fc5d1a0c5229127916.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Igor Mammedov <imammedo@redhat.com>

Add build_gwdt_wdat() to generate a Watchdog Action Table
designed for SBSA Generic Watchdog Timer.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260702145856.1539572-7-imammedo@redhat.com>
---
 include/hw/acpi/wdat-gwdt.h | 19 +++++++
 hw/acpi/wdat-gwdt-stub.c    | 16 ++++++
 hw/acpi/wdat-gwdt.c         | 99 +++++++++++++++++++++++++++++++++++++
 hw/acpi/meson.build         |  2 +
 4 files changed, 136 insertions(+)
 create mode 100644 include/hw/acpi/wdat-gwdt.h
 create mode 100644 hw/acpi/wdat-gwdt-stub.c
 create mode 100644 hw/acpi/wdat-gwdt.c

diff --git a/include/hw/acpi/wdat-gwdt.h b/include/hw/acpi/wdat-gwdt.h
new file mode 100644
index 0000000000..42339e031e
--- /dev/null
+++ b/include/hw/acpi/wdat-gwdt.h
@@ -0,0 +1,19 @@
+/*
+ * GWDT Watchdog Action Table (WDAT) definition
+ *
+ * Copyright Red Hat, Inc. 2026
+ * Author(s): Igor Mammedov <imammedo@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef QEMU_HW_ACPI_WDAT_GWDT_H
+#define QEMU_HW_ACPI_WDAT_GWDT_H
+
+#include "hw/acpi/aml-build.h"
+#include "hw/watchdog/sbsa_gwdt.h"
+
+void build_gwdt_wdat(GArray *table_data, BIOSLinker *linker, const char *oem_id,
+                     const char *oem_table_id, uint64_t rbase, uint64_t cbase,
+                     uint64_t freq);
+
+#endif /* QEMU_HW_ACPI_WDAT_GWDT_H */
diff --git a/hw/acpi/wdat-gwdt-stub.c b/hw/acpi/wdat-gwdt-stub.c
new file mode 100644
index 0000000000..4d43783f70
--- /dev/null
+++ b/hw/acpi/wdat-gwdt-stub.c
@@ -0,0 +1,16 @@
+/*
+ * Copyright Red Hat, Inc. 2026
+ * Author(s): Igor Mammedov <imammedo@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/acpi/wdat-gwdt.h"
+
+void build_gwdt_wdat(GArray *table_data, BIOSLinker *linker, const char *oem_id,
+                     const char *oem_table_id, uint64_t rbase, uint64_t cbase,
+                     uint64_t freq)
+{
+    g_assert_not_reached();
+}
diff --git a/hw/acpi/wdat-gwdt.c b/hw/acpi/wdat-gwdt.c
new file mode 100644
index 0000000000..b30566ef6a
--- /dev/null
+++ b/hw/acpi/wdat-gwdt.c
@@ -0,0 +1,99 @@
+/*
+ * SBSA GWDT Watchdog Action Table (WDAT)
+ *
+ * Copyright Red Hat, Inc. 2026
+ * Author(s): Igor Mammedov <imammedo@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/acpi/aml-build.h"
+#include "hw/acpi/wdat-gwdt.h"
+#include "hw/acpi/wdat.h"
+#include "hw/watchdog/sbsa_gwdt.h"
+
+#define GWDT_REG(base, reg_offset, reg_width) { \
+                 .space_id = AML_AS_SYSTEM_MEMORY, \
+                 .address = base + reg_offset, .bit_width = reg_width, \
+                 .access_width = AML_DWORD_ACC };
+
+/*
+ *   "Hardware Watchdog Timers Design Specification"
+ *       https://uefi.org/acpi 'Watchdog Action Table (WDAT)'
+ */
+void build_gwdt_wdat(GArray *table_data, BIOSLinker *linker, const char *oem_id,
+                     const char *oem_table_id, uint64_t rbase, uint64_t cbase,
+                     uint64_t freq)
+{
+    AcpiTable table = { .sig = "WDAT", .rev = 1, .oem_id = oem_id,
+                        .oem_table_id = oem_table_id };
+
+    struct AcpiGenericAddress wrr =  GWDT_REG(rbase, 0x0, 32);
+    struct AcpiGenericAddress wor_l =  GWDT_REG(cbase, SBSA_GWDT_WOR, 32);
+    struct AcpiGenericAddress wcs =  GWDT_REG(cbase, SBSA_GWDT_WCS, 32);
+
+    acpi_table_begin(&table, table_data);
+    build_append_int_noprefix(table_data, 0x20, 4); /* Watchdog Header Length */
+    /*
+     * PCI location fields are set to 0xff to indicate
+     * that the watchdog is not a PCI device.
+     */
+    build_append_int_noprefix(table_data, 0xff, 2); /* PCI Segment */
+    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Bus Number */
+    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Device Number */
+    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Function Number */
+    build_append_int_noprefix(table_data, 0, 3);    /* Reserved */
+    /*
+     * WDAT spec: "The clock interval that the WDT uses must be
+     * greater than or equal to 1 millisecond."
+     */
+    g_assert(freq <= 1000);
+    /* Timer Period, ms */
+    build_append_int_noprefix(table_data, 1000 / freq, 4);
+    /*
+     * WDAT spec: "The time-out period before the WDT fires is recommended
+     * to be at least 5 minutes."
+     * Set max count to 10min and min count to 5sec.
+     */
+    build_append_int_noprefix(table_data, 600 * freq, 4); /* Maximum Count */
+    build_append_int_noprefix(table_data, 5 * freq, 4);   /* Minimum Count */
+    /*
+     * WATCHDOG_ENABLED | WATCHDOG_STOPPED_IN_SLEEP_STATE
+     */
+    build_append_int_noprefix(table_data, 0x81, 1); /* Watchdog Flags */
+    build_append_int_noprefix(table_data, 0, 3);    /* Reserved */
+    /*
+     * watchdog instruction entries
+     */
+    build_append_int_noprefix(table_data, 8, 4);
+    /* Action table: WCS (control/status) register actions */
+    build_append_wdat_ins(table_data, WDAT_ACTION_QUERY_RUNNING_STATE,
+        WDAT_INS_READ_VALUE,
+        wcs, 0x1, 0x1);
+    build_append_wdat_ins(table_data, WDAT_ACTION_SET_RUNNING_STATE,
+        WDAT_INS_WRITE_VALUE | WDAT_INS_PRESERVE_REGISTER,
+        wcs, 1, 0x00000001);
+    build_append_wdat_ins(table_data, WDAT_ACTION_QUERY_STOPPED_STATE,
+        WDAT_INS_READ_VALUE,
+        wcs, 0x0, 0x00000001);
+    build_append_wdat_ins(table_data, WDAT_ACTION_SET_STOPPED_STATE,
+        WDAT_INS_WRITE_VALUE | WDAT_INS_PRESERVE_REGISTER,
+        wcs, 0x0, 0x00000001);
+    build_append_wdat_ins(table_data, WDAT_ACTION_QUERY_WATCHDOG_STATUS,
+        WDAT_INS_READ_VALUE,
+        wcs, 0x4, 0x00000004);
+    /* WOR (offset) and WRR (refresh) register actions */
+    build_append_wdat_ins(table_data, WDAT_ACTION_SET_COUNTDOWN_PERIOD,
+        WDAT_INS_WRITE_COUNTDOWN,
+        wor_l, 0, 0xffffffff);
+    /* WRR: any write refreshes the watchdog, value is ignored */
+    build_append_wdat_ins(table_data, WDAT_ACTION_RESET,
+        WDAT_INS_WRITE_VALUE,
+        wrr, 0x1, 0x1);
+    build_append_wdat_ins(table_data, WDAT_ACTION_SET_WATCHDOG_STATUS,
+        WDAT_INS_WRITE_VALUE | WDAT_INS_PRESERVE_REGISTER,
+        wrr, 0x4, 0x4);
+
+    acpi_table_end(linker, &table);
+}
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index 0c7bfb278a..09ad488a04 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -31,11 +31,13 @@ acpi_ss.add(when: 'CONFIG_ACPI_ERST', if_true: files('erst.c'))
 acpi_ss.add(when: 'CONFIG_IPMI', if_true: files('ipmi.c'))
 stub_ss.add(files('ipmi-stub.c'))
 stub_ss.add(files('acpi-x86-stub.c'))
+acpi_ss.add(when: 'CONFIG_WDT_SBSA', if_true: files('wdat-gwdt.c'))
 if have_tpm
   acpi_ss.add(files('tpm.c'))
 endif
 stub_ss.add(files('acpi-stub.c', 'aml-build-stub.c', 'ghes-stub.c'))
 stub_ss.add(files('pci-bridge-stub.c'))
+stub_ss.add(files('wdat-gwdt-stub.c'))
 system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
 system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
 stub_ss.add(files('ghes_cper_stub.c'))
-- 
MST


