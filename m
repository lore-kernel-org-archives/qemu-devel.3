Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADB3C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNwK-0005Nm-VV; Sun, 05 Jul 2026 10:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwI-0005IK-Pp
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwH-0001Ms-4A
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tt/+h8SYwu/l7AdrLBpXz0yzDqrDTzChIc9yr8nOxw0=;
 b=YjrjsJsIod+HqCUjLAqauEnkwut66M/zf1YbLlms1xpYkH8t/vNIBOQki7J0z2H2D+nAoG
 4IUH0R366JzXg4AoTsJzcwagZGY9ThbS37VUiIaGZh1K3u3SGl87k8dxmDeTzVvPftENye
 j1zoS9BtikZ9nN++RJ99d9rLseI6BoQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-WaUtGU1BNqeBgXbtrjWJGQ-1; Sun, 05 Jul 2026 10:35:19 -0400
X-MC-Unique: WaUtGU1BNqeBgXbtrjWJGQ-1
X-Mimecast-MFC-AGG-ID: WaUtGU1BNqeBgXbtrjWJGQ_1783262118
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-493b0fe95b6so11367755e9.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262118; x=1783866918; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Tt/+h8SYwu/l7AdrLBpXz0yzDqrDTzChIc9yr8nOxw0=;
 b=kTWAl9UgbTKPFFN/A/rMxjG2tszyAlEIydNHdWcGEX1c0RnCcv4SbImmsKvRZHiSf3
 tl+9Ui3UeiKAzxukj6LN2m+h6EYvZbbutzcoloaM55NlS7g400Aev0uO+Y2uM4DGx9At
 cg3hUnFbbl1DPSFqfJEMHtyS5bDFy1nF2qj7v1mPYXbk0xM36ZhqR0CABR0yeB+XdzgJ
 zvcXxzXZu3I4Iznj+0EYqQhWKOvy64ZCI6WoopSvWmFwFbgRJHQ+q0aOM5HfLYfe+XYi
 7tinztQm+dnvBQ+2wyDqQjM7eaFMGkzA+csVVCXvdCYyirwzgew7OKgNXtyuejDe2B6y
 q+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262118; x=1783866918;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Tt/+h8SYwu/l7AdrLBpXz0yzDqrDTzChIc9yr8nOxw0=;
 b=FF/3vG/Ypsrs1uMmcnQGdpTUbqI/I0BG+nPVwW5mbaPKswCTG+N2Mgj2kSECWyXbt+
 b5Aw1K+rZ/Kony83pVaMsXQSnffemsz+uHZwZeU5EtIJpD/NPqC2gzBbpIMxa6h55Vf3
 IvFsxFVjs4fc86pGIiTkqLGUQouR706yKwZK54yZJ2b4SutvND85CM7WAZkLN8bZhEoB
 ToYqdvTjakCeusjqfw2ocfxZcTfdoEQS32TO1lAKVmnSJbFGHLGWU6EzHeIwbwwaCpgK
 C6TatPzeMogdaMR6HEW5kj1qFH/SfQ1M1CvnWivXrGmWca+/sPgFOxxurWL5RGrI7nUn
 rNpw==
X-Gm-Message-State: AOJu0Yy7KYSK+aO4y5HhJHNqd2zRZ1L5L0/6GNTMsPmrpaGhhJ+gvbZA
 tk1JML15EDPn0WO8vibHW8dwrix2qsw5H/ooRsghECtXkhg6WukddBgp0HOSnjGYwzkBBrDkzPu
 Kg03qF9NemsFZ4pshKjDoog9qxT1jkpdFLqd4OuFefRzVwr5Ly8WTXF1DfLe1GA4dLMhf6Z9VCa
 Ap34d1TNc24HcdF5t/C55c1+wyp/fT/BYjpA==
X-Gm-Gg: AfdE7cneUVXNiwYXQq8k+0KNFvLYtTdT25gHz/R+kYyNooaFBCqGxZv9PuAhfAlZ2Jk
 RaAmMOL9ZD260TndmpYi6uZ1niHdeCn4B3CBeGyduHdKBOwIlZw5WH39YPkMiUEiSTpybBeV1wW
 W7dn+DrVERBt8wsBwF3TenqKk0hR6tkel8fYBNN3R6Me97jBev6jxKeRqLc4xCwMMQmGGUa7KrX
 kVZxKggBTKz+TEi+cllCtZLLiZvhO11cQtS62fr7TE+Yp9xUzD35k+bIqUpEHxS0b3Z1Q0O35+8
 JyEzENgPpiVH7AAHF95cfdpoWZTubkclaOuNhuvwgoHOULGONht08QAovtBw7yv6xB0k6pDcSEY
 Jk8L8JxPbJo2pgcngoBz9Nxt6+DfAEqTT
X-Received: by 2002:a05:600c:5790:b0:493:aa0a:45b0 with SMTP id
 5b1f17b1804b1-493d11f3656mr55947535e9.23.1783262117656; 
 Sun, 05 Jul 2026 07:35:17 -0700 (PDT)
X-Received: by 2002:a05:600c:5790:b0:493:aa0a:45b0 with SMTP id
 5b1f17b1804b1-493d11f3656mr55947215e9.23.1783262117110; 
 Sun, 05 Jul 2026 07:35:17 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccdab3a8sm231771455e9.6.2026.07.05.07.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:35:16 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:35:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 fanhuang <FangSheng.Huang@amd.com>, Igor Mammedov <imammedo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 14/44] tests/qtest: add e820 fw_cfg test
Message-ID: <0819ca9dbd882fff0a1cf9a241a444b4bd34ebbd.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

From: fanhuang <FangSheng.Huang@amd.com>

Add a qtest that reads the "etc/e820" fw_cfg table and checks its
structural invariants: the file is a whole number of e820 entries and
every entry has a non-zero length. The baseline q35 case asserts the
guest sees RAM and, with no sp-mem device, no SOFT_RESERVED range.

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260623075051.3797975-10-FangSheng.Huang@amd.com>
---
 tests/qtest/e820-test.c | 95 +++++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build |  1 +
 2 files changed, 96 insertions(+)
 create mode 100644 tests/qtest/e820-test.c

diff --git a/tests/qtest/e820-test.c b/tests/qtest/e820-test.c
new file mode 100644
index 0000000000..1db0744c08
--- /dev/null
+++ b/tests/qtest/e820-test.c
@@ -0,0 +1,95 @@
+/*
+ * qtest e820 fw_cfg test case
+ *
+ * Validate the "etc/e820" fw_cfg table that QEMU hands to the firmware.
+ *
+ * Copyright (c) 2026 Advanced Micro Devices, Inc.
+ *
+ * Authors:
+ *  FangSheng Huang <FangSheng.Huang@amd.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "libqtest.h"
+#include "libqos/fw_cfg.h"
+#include "qemu/bswap.h"
+
+/* e820 entry layout and types (cf. hw/i386/e820_memory_layout.h) */
+#define E820_RAM            1
+#define E820_SOFT_RESERVED  0xefffffff
+
+struct e820_entry {
+    uint64_t address;
+    uint64_t length;
+    uint32_t type;
+} QEMU_PACKED;
+
+#define E820_MAX_ENTRIES    128
+
+/*
+ * Read and structurally validate "etc/e820": the file is a packed array
+ * of struct e820_entry, so its size must be a whole multiple of the entry
+ * size and every entry must have a non-zero length. Returns the entry
+ * count and fills @table.
+ */
+static size_t get_e820_table(QFWCFG *fw_cfg, struct e820_entry *table)
+{
+    size_t filesize, n, i;
+
+    filesize = qfw_cfg_get_file(fw_cfg, "etc/e820", table,
+                                E820_MAX_ENTRIES * sizeof(*table));
+    g_assert_cmpint(filesize, >, 0);
+    g_assert_cmpint(filesize % sizeof(struct e820_entry), ==, 0);
+
+    n = filesize / sizeof(struct e820_entry);
+    g_assert_cmpint(n, <=, E820_MAX_ENTRIES);
+
+    for (i = 0; i < n; i++) {
+        g_assert_cmpint(le64_to_cpu(table[i].length), >, 0);
+    }
+
+    return n;
+}
+
+static void test_e820_basic(void)
+{
+    struct e820_entry table[E820_MAX_ENTRIES];
+    QFWCFG *fw_cfg;
+    QTestState *s;
+    size_t n, i;
+    bool found_ram = false, found_soft_reserved = false;
+
+    s = qtest_init("-machine q35 -m 256M");
+    fw_cfg = pc_fw_cfg_init(s);
+
+    n = get_e820_table(fw_cfg, table);
+    for (i = 0; i < n; i++) {
+        switch (le32_to_cpu(table[i].type)) {
+        case E820_RAM:
+            found_ram = true;
+            break;
+        case E820_SOFT_RESERVED:
+            found_soft_reserved = true;
+            break;
+        }
+    }
+
+    /* baseline: RAM present, no SOFT_RESERVED range */
+    g_assert_true(found_ram);
+    g_assert_false(found_soft_reserved);
+
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("e820/basic", test_e820_basic);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 5e18b947c7..93175baa87 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -58,6 +58,7 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_AHCI_ICH9') ? ['tco-test'] : []) +                    \
   (config_all_devices.has_key('CONFIG_FDC_ISA') ? ['fdc-test'] : []) +                      \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['fw_cfg-test'] : []) +                    \
+  (config_all_devices.has_key('CONFIG_Q35') ? ['e820-test'] : []) +                          \
   (config_all_devices.has_key('CONFIG_FW_CFG_DMA') ? ['vmcoreinfo-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_Q35') ? ['dump-test'] : []) +                         \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['i440fx-test'] : []) +                    \
-- 
MST


