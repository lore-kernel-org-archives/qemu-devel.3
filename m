Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F29CC6B2A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 12:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGyW3-0006oG-0x; Wed, 14 Oct 2026 08:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shmuelfomberg@gmail.com>)
 id 1xGyFG-0003zM-A7
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 08:38:10 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shmuelfomberg@gmail.com>)
 id 1xGyFD-0007JF-6b
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 08:38:09 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so353614f8f.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 05:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791981485; x=1792586285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Lsjn3LV7JBpZW2IxCjuKF63c/Yth+tJQr8znBD2cPwE=;
 b=gKdbrNJfbswaiAckNwvDTSzJfDt+pTJdEevYVHNhtch1ZjuiAuihP4nYo0H1YvyOqG
 qjFD8jmbvLUWlCf8O7Bt1TzSnWLeAUUmXL/PCJyb8+aW/MAc5CCm2Bbnwz9rKdNHsnNB
 X2/i5Wd76ZAuykOQnnaBeJegqDtbIlfS5H+E2Em0ymcGVkRDivcb+2IE0oXi5MiHyPkX
 VS8geKm4UGQaHu2NU/XQlpm8zk52tHBF0nJAeFNd+pzwpKJJGk4gaXCDmYI6Hmeq948s
 iHdWQcJ6rSNLLU1R4xv/ial+slysChWRWk2jR0CyfSl8jUViWD9/plFiqzp4RBqa3fco
 sFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791981485; x=1792586285;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lsjn3LV7JBpZW2IxCjuKF63c/Yth+tJQr8znBD2cPwE=;
 b=C75VaMDSVce+HLUVfwjzw5i5fU1y2u2L4V7LHDl/PFzguNIf9At0DPlQvDDsxGK115
 6gUgIe1v7yaXYQhjI3CsLrEUmqk8MPzKzXbMy7oznpszhTXsTed8O0chBfzBCmmBnD9j
 hCerM4D+umBA33hWVsxm3rS0OgYFRu7aoz3ohT+zPFEdBHCYS2DQ04D27PYawT+beRrV
 ipNn6T+1ngqE/E89ZGzB42XR/yDzoRs/WzsMDGO49Lj0wGEe8q9o6lb3dw0P4hNcJGfw
 +RWZVBYwuo19kw2qIh7zltcMQ3HbSjMn9iV5QkGZFBWv9Sy/mTlsBmJTgrZpeYWbT716
 Rbvw==
X-Forwarded-Encrypted: i=1;
 AKwUvByBPSP4P0g1yycKX1OHT4ApoWKTavkKkld/PrgtukmeUkJcCeMC8K4ZoGuPh+UFpdrfqOm430r7nNFJ@nongnu.org
X-Gm-Message-State: AFq9FYKA6cCJBbifN4PY/uxKpw4NMwgcMh3BOkalt7FHuQtKtLycCrJG
 ifThLR2u/gofruKIIONn53UZvyPURhHwcMXMHFAjIbGNnG2ak4jTjFCT
X-Gm-Gg: AYBFou1gcTyP0CouDLNHy4ypWQXyfrbLVf5Bs8Qp0DIRIbUHLmjbv0+qnwZIN2nzq17
 UJWofB7lHc5zMuegBbiyQ4zwt2OHHh+aeR0lUHFDQiI9gKFmZ82rMtlUt+wkwWROb7tTFMAxkLU
 qlm3IRwwTegQxmxrVbrSbUbSdhvOjr3kqfnthS+Oc2eMJpMOM5VPxoSWTA2p8yF9FriMDBvcS5W
 otlIseQ5KHZ5Qyf0WU/6IOddcFTWaf0zWXvHrLaYa1+tYbRqaYG8ItAaPkNBuPw4zEp3KBLW6fz
 GUdIm3oV4SLY+KMX246nsjtCm5YFhM2z5n1pZI6YIoZ923C5Og7CK4KX4v+amepARxbAysZXMVl
 wK2bZPV86VlQKeEKYJVmjGfj7gN5F3JhbDYk2gAfMUnUfdAjivHZjzqmEDvC0mOAerMYWY8Qukr
 22SM9kOe+YWKaFaOyYtb7mU0Sl7Djesfjc1TYhWFk2OeFvLIBJQryBeXtUXHKJLoCDtouOH92Sw
 2pLq2PVbaniBRTgq9mHmTXRJeObr0Kd3nY3pZrSFFyTBA==
X-Received: by 2002:a05:6000:46d6:b0:48d:c20c:cc4d with SMTP id
 ffacd0b85a97d-48dc20cccd2mr16032950f8f.23.1791981484430; 
 Wed, 14 Oct 2026 05:38:04 -0700 (PDT)
Received: from sfomberg-mac.redhat.corp
 ([2a06:c701:7925:8a00:fca2:9f5c:1c03:33ff])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bd1843sm11798082f8f.56.2026.10.14.05.38.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 14 Oct 2026 05:38:03 -0700 (PDT)
From: Shmuel Fomberg <shmuelfomberg@gmail.com>
To: shmuelfomberg@gmail.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH] Adding support for hyper-v enlightments hv-extcalls and
 hv-memory-hint (hypercall HvExtCallMemoryHeatHint)
Date: Wed, 14 Oct 2026 15:37:47 +0300
Message-ID: <20261014123748.95097-1-shmuelfomberg@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=shmuelfomberg@gmail.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 14 Oct 2026 08:54:54 -0400
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

Signed-off-by: Shmuel Fomberg <shmuelfomberg@gmail.com>
---
 hw/hyperv/hv-gpa-range.c                      |  59 ++++
 include/hw/hyperv/hv-gpa-range.h              |  52 ++++
 .../functional/x86_64/test_hyperv_extcalls.py | 101 +++++++
 tests/unit/test-hv-gpa-range.c                | 271 ++++++++++++++++++
 4 files changed, 483 insertions(+)
 create mode 100644 hw/hyperv/hv-gpa-range.c
 create mode 100644 include/hw/hyperv/hv-gpa-range.h
 create mode 100644 tests/functional/x86_64/test_hyperv_extcalls.py
 create mode 100644 tests/unit/test-hv-gpa-range.c

diff --git a/hw/hyperv/hv-gpa-range.c b/hw/hyperv/hv-gpa-range.c
new file mode 100644
index 0000000000..e6d3d3eb42
--- /dev/null
+++ b/hw/hyperv/hv-gpa-range.c
@@ -0,0 +1,59 @@
+/*
+ * Hyper-V extended memory heat-hint GPA range helpers.
+ *
+ * Copyright (c) 2015-2018 Virtuozzo International GmbH.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/hyperv/hv-gpa-range.h"
+#include "hw/hyperv/hyperv-proto.h"
+
+bool hv_decode_gpa_page_range(uint64_t raw, hwaddr *gpa, hwaddr *len)
+{
+    uint64_t pages = (raw & HV_GPA_PAGE_RANGE_ADDITIONAL_MASK) + 1;
+
+    if (raw & HV_GPA_PAGE_RANGE_LARGEPAGE) {
+        if (raw & HV_GPA_PAGE_RANGE_PAGE_SIZE_1GB) {
+            *gpa = raw & HV_GPA_PAGE_RANGE_1G_GPA_MASK;
+            *len = pages << 30;
+        } else {
+            *gpa = raw & HV_GPA_PAGE_RANGE_2M_GPA_MASK;
+            *len = pages << 21;
+        }
+    } else {
+        *gpa = raw & HV_GPA_PAGE_RANGE_4K_GPA_MASK;
+        *len = pages << 12;
+    }
+
+    return *len != 0;
+}
+
+bool hv_madvise_walk_step(hwaddr *gpa, hwaddr *len,
+                          hwaddr section_start, hwaddr section_size,
+                          hwaddr *out_gpa, hwaddr *out_len)
+{
+    hwaddr skip;
+
+    /*
+     * A hole with no memory region makes the section start past the
+     * cursor; a zero-size section means there is nothing left to find.
+     * Either way, stop -- do not advise or advance past the gap.
+     */
+    if (!section_size || section_start < *gpa) {
+        return false;
+    }
+
+    skip = section_start - *gpa;
+    if (skip >= *len || section_size > *len - skip) {
+        return false;
+    }
+
+    *out_gpa = section_start;
+    *out_len = section_size;
+
+    *gpa = section_start + section_size;
+    *len -= skip + section_size;
+    return true;
+}
diff --git a/include/hw/hyperv/hv-gpa-range.h b/include/hw/hyperv/hv-gpa-range.h
new file mode 100644
index 0000000000..b1cf6664b8
--- /dev/null
+++ b/include/hw/hyperv/hv-gpa-range.h
@@ -0,0 +1,52 @@
+/*
+ * Hyper-V extended memory heat-hint GPA range helpers.
+ *
+ * These are small, dependency-free helpers factored out of hyperv.c so
+ * that the bit-decoding and walk-cursor bookkeeping can be exercised
+ * directly by unit tests (see tests/unit/test-hv-gpa-range.c) without
+ * requiring a real MemoryRegion/MemoryRegionSection or any KVM/system
+ * emulation plumbing.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_HYPERV_HV_GPA_RANGE_H
+#define HW_HYPERV_HV_GPA_RANGE_H
+
+#include "exec/hwaddr.h"
+
+/*
+ * Decode one HV_GPA_PAGE_RANGE qword (as found in
+ * struct hyperv_memory_heat_hint.ranges[]) into a GPA and byte length.
+ *
+ * Returns false if the decoded length is zero (nothing to do for this
+ * range); true otherwise, with *gpa and *len filled in.
+ *
+ * Visible for testing.
+ */
+bool hv_decode_gpa_page_range(uint64_t raw, hwaddr *gpa, hwaddr *len);
+
+/*
+ * Validate a MemoryRegionSection found by memory_region_find() for the
+ * current walk cursor (*gpa, *len), and advance the cursor past it.
+ *
+ * @section_start/@section_size are the section's
+ * offset_within_address_space and size, as returned by
+ * memory_region_find().
+ *
+ * On success, returns true and fills in @out_gpa/@out_len with the GPA
+ * and length that the caller should actually act upon (e.g. madvise()),
+ * and advances *gpa and *len past the section.
+ *
+ * Returns false, without touching *gpa or *len, if the section does not
+ * fit within the remaining [*gpa, *gpa + *len) range -- e.g. because
+ * memory_region_find() skipped over a hole and returned a section that
+ * starts past the cursor, or a section that runs past the requested
+ * range. The caller should stop walking in that case.
+ *
+ * Visible for testing.
+ */
+bool hv_madvise_walk_step(hwaddr *gpa, hwaddr *len,
+                          hwaddr section_start, hwaddr section_size,
+                          hwaddr *out_gpa, hwaddr *out_len);
+
+#endif /* HW_HYPERV_HV_GPA_RANGE_H */
diff --git a/tests/functional/x86_64/test_hyperv_extcalls.py b/tests/functional/x86_64/test_hyperv_extcalls.py
new file mode 100644
index 0000000000..c48f59d554
--- /dev/null
+++ b/tests/functional/x86_64/test_hyperv_extcalls.py
@@ -0,0 +1,101 @@
+#!/usr/bin/env python3
+#
+# Validation of the hv-extcalls / hv-memory-hint CPU properties.
+#
+# hv-extcalls gates the Hyper-V extended hypercalls (HV_ENABLE_EXTENDED_
+# HYPERCALLS, HV_CPUID_FEATURES.EBX bit 20); hv-memory-hint additionally
+# gates whether HvExtCallQueryCapabilities advertises, and
+# HvExtCallMemoryHeatHint accepts, the memory heat-hint calls.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+
+from qemu_test import QemuSystemTest
+
+
+class HypervExtCallsProps(QemuSystemTest):
+    """
+    Validation of the hv-extcalls and hv-memory-hint CPU properties.
+    """
+
+    def get_cpu_prop(self, prop):
+        cpu_path = self.vm.cmd('query-cpus-fast')[0].get('qom-path')
+        return self.vm.cmd('qom-get', path=cpu_path, property=prop)
+
+    def launch_with_cpu_props(self, cpu_props):
+        self.set_machine('pc')
+        self.vm.add_args('-S')
+        self.set_vm_arg('-cpu', 'qemu64' + cpu_props)
+        self.vm.launch()
+
+    def test_defaults_off(self):
+        """
+        Neither property is requested: both must default to off, in
+        particular hv-extcalls (which was deliberately made default-off
+        so that enabling the extended hypercalls is an explicit opt-in).
+        """
+        self.launch_with_cpu_props('')
+        self.assertFalse(self.get_cpu_prop('hv-extcalls'),
+                         'hv-extcalls must default to off')
+        self.assertFalse(self.get_cpu_prop('hv-memory-hint'),
+                         'hv-memory-hint must default to off')
+
+    def test_hv_extcalls_on(self):
+        """
+        hv-extcalls=on by itself must not implicitly turn on
+        hv-memory-hint.
+        """
+        self.launch_with_cpu_props(',hv-extcalls=on')
+        self.assertTrue(self.get_cpu_prop('hv-extcalls'),
+                        'hv-extcalls=on must be reflected on the CPU')
+        self.assertFalse(self.get_cpu_prop('hv-memory-hint'),
+                         'hv-extcalls=on must not imply hv-memory-hint')
+
+    def test_hv_memory_hint_on(self):
+        """
+        hv-memory-hint=on without hv-extcalls must still parse/boot (the
+        combination is a no-op at runtime -- kvm_hv_handle_exit() gates
+        *all* extended hypercalls, including the capabilities query, on
+        hv-extcalls -- but QEMU must not reject it at CPU-realize time).
+        """
+        self.launch_with_cpu_props(',hv-memory-hint=on')
+        self.assertFalse(self.get_cpu_prop('hv-extcalls'))
+        self.assertTrue(self.get_cpu_prop('hv-memory-hint'),
+                        'hv-memory-hint=on must be reflected on the CPU')
+
+    def test_both_on(self):
+        """
+        The intended "fully enabled" configuration: both properties on.
+        """
+        self.launch_with_cpu_props(',hv-extcalls=on,hv-memory-hint=on')
+        self.assertTrue(self.get_cpu_prop('hv-extcalls'))
+        self.assertTrue(self.get_cpu_prop('hv-memory-hint'))
+
+
+class HypervExtCallsModelExpansion(QemuSystemTest):
+    """
+    Confirm hv-extcalls/hv-memory-hint are discoverable via
+    query-cpu-model-expansion, the mechanism management layers (e.g.
+    libvirt) use to probe which CPU properties/features are supported
+    before adding them to a domain definition.
+    """
+
+    def test(self):
+        self.set_machine('none')
+        self.vm.add_args('-S')
+        self.vm.launch()
+
+        model = {'name': 'qemu64',
+                'props': {'hv-extcalls': True, 'hv-memory-hint': True}}
+        e = self.vm.cmd('query-cpu-model-expansion', model=model,
+                        type='full')
+        props = e['model']['props']
+
+        self.assertIn('hv-extcalls', props)
+        self.assertIn('hv-memory-hint', props)
+        self.assertTrue(props['hv-extcalls'])
+        self.assertTrue(props['hv-memory-hint'])
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/unit/test-hv-gpa-range.c b/tests/unit/test-hv-gpa-range.c
new file mode 100644
index 0000000000..70196f271b
--- /dev/null
+++ b/tests/unit/test-hv-gpa-range.c
@@ -0,0 +1,271 @@
+/*
+ * Unit tests for the Hyper-V extended memory heat-hint GPA range helpers
+ * (hw/hyperv/hv-gpa-range.c).
+ *
+ * These exercise:
+ *  - hv_decode_gpa_page_range(): decoding of the HV_GPA_PAGE_RANGE qwords
+ *    found in a HvExtCallMemoryHeatHint[Async] input buffer.
+ *  - hv_madvise_walk_step(): the walk-cursor bookkeeping used by
+ *    hv_madvise_gpa_range() to turn a sequence of memory_region_find()
+ *    results into the correct set of (host, len) madvise() targets, in
+ *    particular across holes in the GPA space.  This directly covers the
+ *    "madvise walk can log/act on the wrong GPA" regression.
+ *
+ * Copyright (c) 2015-2018 Virtuozzo International GmbH.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/hyperv/hyperv-proto.h"
+#include "hw/hyperv/hv-gpa-range.h"
+
+#define KiB (1024ULL)
+#define MiB (1024 * KiB)
+#define GiB (1024 * MiB)
+
+/*
+ * ---------------------------------------------------------------------
+ * hv_decode_gpa_page_range()
+ * ---------------------------------------------------------------------
+ */
+
+static void test_decode_4k_single_page(void)
+{
+    hwaddr gpa, len;
+    /* pfn = 5, additional_pages = 0 -> one 4K page at GPA 0x5000 */
+    uint64_t raw = (5ULL << 12);
+
+    g_assert_true(hv_decode_gpa_page_range(raw, &gpa, &len));
+    g_assert_cmphex(gpa, ==, 5 * 4 * KiB);
+    g_assert_cmphex(len, ==, 4 * KiB);
+}
+
+static void test_decode_4k_additional_pages(void)
+{
+    hwaddr gpa, len;
+    /* pfn = 7, additional_pages = 3 -> 4 consecutive 4K pages */
+    uint64_t raw = (7ULL << 12) | 3;
+
+    g_assert_true(hv_decode_gpa_page_range(raw, &gpa, &len));
+    g_assert_cmphex(gpa, ==, 7 * 4 * KiB);
+    g_assert_cmphex(len, ==, 4 * 4 * KiB);
+}
+
+static void test_decode_4k_max_additional_pages(void)
+{
+    hwaddr gpa, len;
+    /* additional_pages field is 11 bits: max value 0x7ff -> 2048 pages */
+    uint64_t raw = (1ULL << 20) | HV_GPA_PAGE_RANGE_ADDITIONAL_MASK;
+
+    g_assert_true(hv_decode_gpa_page_range(raw, &gpa, &len));
+    g_assert_cmphex(len, ==, 2048 * 4 * KiB);
+}
+
+static void test_decode_2m_large_page(void)
+{
+    hwaddr gpa, len;
+    /* pfn (2M units) = 3, additional_pages = 1 -> two 2M pages */
+    uint64_t raw = (3ULL << 21) | HV_GPA_PAGE_RANGE_LARGEPAGE | 1;
+
+    g_assert_true(hv_decode_gpa_page_range(raw, &gpa, &len));
+    g_assert_cmphex(gpa, ==, 3 * 2 * MiB);
+    g_assert_cmphex(len, ==, 2 * 2 * MiB);
+}
+
+static void test_decode_1g_large_page(void)
+{
+    hwaddr gpa, len;
+    /* pfn (1G units) = 2, additional_pages = 0 -> one 1G page */
+    uint64_t raw = (2ULL << 30) | HV_GPA_PAGE_RANGE_LARGEPAGE |
+                   HV_GPA_PAGE_RANGE_PAGE_SIZE_1GB;
+
+    g_assert_true(hv_decode_gpa_page_range(raw, &gpa, &len));
+    g_assert_cmphex(gpa, ==, 2 * GiB);
+    g_assert_cmphex(len, ==, 1 * GiB);
+}
+
+static void test_decode_masks_strip_low_bits(void)
+{
+    hwaddr gpa, len;
+    /*
+     * For a 2M large page, everything below bit 21 other than the
+     * LARGEPAGE flag (bit 11) and additional_pages (bits 0-10) must not
+     * leak into the decoded GPA.
+     */
+    uint64_t raw = (5ULL << 21) | HV_GPA_PAGE_RANGE_LARGEPAGE | 0x3ff;
+
+    g_assert_true(hv_decode_gpa_page_range(raw, &gpa, &len));
+    g_assert_cmphex(gpa, ==, 5 * 2 * MiB);
+    g_assert_cmphex(gpa & ((2 * MiB) - 1), ==, 0);
+}
+
+/*
+ * ---------------------------------------------------------------------
+ * hv_madvise_walk_step()
+ * ---------------------------------------------------------------------
+ */
+
+static void test_walk_full_match(void)
+{
+    hwaddr gpa = 0x1000, len = 0x1000;
+    hwaddr out_gpa, out_len;
+
+    /* memory_region_find() returned exactly the requested range */
+    g_assert_true(hv_madvise_walk_step(&gpa, &len, 0x1000, 0x1000,
+                                       &out_gpa, &out_len));
+    g_assert_cmphex(out_gpa, ==, 0x1000);
+    g_assert_cmphex(out_len, ==, 0x1000);
+    g_assert_cmphex(gpa, ==, 0x2000);
+    g_assert_cmphex(len, ==, 0);
+}
+
+static void test_walk_partial_section_no_skip(void)
+{
+    /* Section starts exactly at the cursor but is smaller than @len */
+    hwaddr gpa = 0x1000, len = 0x3000;
+    hwaddr out_gpa, out_len;
+
+    g_assert_true(hv_madvise_walk_step(&gpa, &len, 0x1000, 0x1000,
+                                       &out_gpa, &out_len));
+    g_assert_cmphex(out_gpa, ==, 0x1000);
+    g_assert_cmphex(out_len, ==, 0x1000);
+    /* cursor must advance past exactly the found section, nothing more */
+    g_assert_cmphex(gpa, ==, 0x2000);
+    g_assert_cmphex(len, ==, 0x2000);
+}
+
+/*
+ * Regression test for "the madvise walk can log/act on the wrong GPA":
+ * memory_region_find() skips over a hole and returns a section that
+ * starts *past* the walk cursor.  The reported/advised GPA must be the
+ * section's real start, not the stale search cursor, and the hole must
+ * be consumed without being advised.
+ */
+static void test_walk_hole_before_section(void)
+{
+    /* Looking for RAM in [0, 0x3000); nothing mapped until 0x1000 */
+    hwaddr gpa = 0, len = 0x3000;
+    hwaddr out_gpa, out_len;
+
+    g_assert_true(hv_madvise_walk_step(&gpa, &len, 0x1000, 0x1000,
+                                       &out_gpa, &out_len));
+    /* Must report the section's actual GPA, not the original cursor (0) */
+    g_assert_cmphex(out_gpa, ==, 0x1000);
+    g_assert_cmphex(out_len, ==, 0x1000);
+    /* Cursor must account for the 0x1000 hole *and* the 0x1000 section */
+    g_assert_cmphex(gpa, ==, 0x2000);
+    g_assert_cmphex(len, ==, 0x1000);
+}
+
+/*
+ * Drive two consecutive steps the way hv_madvise_gpa_range()'s while loop
+ * does: a hole, then a directly-adjacent section, then end of range.
+ * Confirms the cursor neither double-processes the boundary nor drifts.
+ */
+static void test_walk_hole_then_adjacent_section(void)
+{
+    hwaddr gpa = 0, len = 0x3000;
+    hwaddr out_gpa, out_len;
+
+    /* Step 1: hole [0,0x1000), section [0x1000,0x2000) */
+    g_assert_true(hv_madvise_walk_step(&gpa, &len, 0x1000, 0x1000,
+                                       &out_gpa, &out_len));
+    g_assert_cmphex(out_gpa, ==, 0x1000);
+    g_assert_cmphex(gpa, ==, 0x2000);
+    g_assert_cmphex(len, ==, 0x1000);
+
+    /* Step 2: section starts exactly at the new cursor, no further skip */
+    g_assert_true(hv_madvise_walk_step(&gpa, &len, 0x2000, 0x1000,
+                                       &out_gpa, &out_len));
+    g_assert_cmphex(out_gpa, ==, 0x2000);
+    g_assert_cmphex(out_len, ==, 0x1000);
+    g_assert_cmphex(gpa, ==, 0x3000);
+    g_assert_cmphex(len, ==, 0);
+}
+
+static void test_walk_section_past_requested_range(void)
+{
+    /* Section is larger than what's left to process -> stop, don't act */
+    hwaddr gpa = 0x1000, len = 0x1000;
+    hwaddr out_gpa = 0xdead, out_len = 0xdead;
+
+    g_assert_false(hv_madvise_walk_step(&gpa, &len, 0x1000, 0x2000,
+                                        &out_gpa, &out_len));
+    /* cursor and outputs must be left untouched on failure */
+    g_assert_cmphex(gpa, ==, 0x1000);
+    g_assert_cmphex(len, ==, 0x1000);
+    g_assert_cmphex(out_gpa, ==, 0xdead);
+    g_assert_cmphex(out_len, ==, 0xdead);
+}
+
+static void test_walk_section_before_cursor(void)
+{
+    /* Defensive case: section starts before the cursor -> stop */
+    hwaddr gpa = 0x2000, len = 0x1000;
+    hwaddr out_gpa, out_len;
+
+    g_assert_false(hv_madvise_walk_step(&gpa, &len, 0x1000, 0x1000,
+                                        &out_gpa, &out_len));
+    g_assert_cmphex(gpa, ==, 0x2000);
+    g_assert_cmphex(len, ==, 0x1000);
+}
+
+static void test_walk_zero_size_section(void)
+{
+    hwaddr gpa = 0, len = 0x1000;
+    hwaddr out_gpa, out_len;
+
+    g_assert_false(hv_madvise_walk_step(&gpa, &len, 0, 0, &out_gpa, &out_len));
+    g_assert_cmphex(gpa, ==, 0);
+    g_assert_cmphex(len, ==, 0x1000);
+}
+
+static void test_walk_skip_equals_len(void)
+{
+    /* The whole remaining range is a hole; section starts right at the end */
+    hwaddr gpa = 0, len = 0x1000;
+    hwaddr out_gpa, out_len;
+
+    g_assert_false(hv_madvise_walk_step(&gpa, &len, 0x1000, 0x1000,
+                                        &out_gpa, &out_len));
+    g_assert_cmphex(gpa, ==, 0);
+    g_assert_cmphex(len, ==, 0x1000);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    g_test_add_func("/hv-gpa-range/decode/4k-single-page",
+                    test_decode_4k_single_page);
+    g_test_add_func("/hv-gpa-range/decode/4k-additional-pages",
+                    test_decode_4k_additional_pages);
+    g_test_add_func("/hv-gpa-range/decode/4k-max-additional-pages",
+                    test_decode_4k_max_additional_pages);
+    g_test_add_func("/hv-gpa-range/decode/2m-large-page",
+                    test_decode_2m_large_page);
+    g_test_add_func("/hv-gpa-range/decode/1g-large-page",
+                    test_decode_1g_large_page);
+    g_test_add_func("/hv-gpa-range/decode/masks-strip-low-bits",
+                    test_decode_masks_strip_low_bits);
+
+    g_test_add_func("/hv-gpa-range/walk/full-match",
+                    test_walk_full_match);
+    g_test_add_func("/hv-gpa-range/walk/partial-section-no-skip",
+                    test_walk_partial_section_no_skip);
+    g_test_add_func("/hv-gpa-range/walk/hole-before-section",
+                    test_walk_hole_before_section);
+    g_test_add_func("/hv-gpa-range/walk/hole-then-adjacent-section",
+                    test_walk_hole_then_adjacent_section);
+    g_test_add_func("/hv-gpa-range/walk/section-past-requested-range",
+                    test_walk_section_past_requested_range);
+    g_test_add_func("/hv-gpa-range/walk/section-before-cursor",
+                    test_walk_section_before_cursor);
+    g_test_add_func("/hv-gpa-range/walk/zero-size-section",
+                    test_walk_zero_size_section);
+    g_test_add_func("/hv-gpa-range/walk/skip-equals-len",
+                    test_walk_skip_equals_len);
+
+    return g_test_run();
+}
-- 
2.54.0 (Apple Git-157)


