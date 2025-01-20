Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BB1C0218B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 04:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZjZM-0004AV-Bk; Sun, 19 Jan 2025 23:39:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tZjZK-0004AL-KP
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 23:39:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tZjZJ-000052-37
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 23:39:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737347959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vwiXxTc7xFDKV1c7kXLl1EzuQbCxBUqxjJnvRGVrIss=;
 b=Kh3ytsIVy8GARhJSq8qWp+AKXZviwxNAU9dJWn0ZF2zQn1evJgmJHw/YoLN55J70YfPDqE
 8UlpPvnuULyL0V6DkmkgvQa24jH2wMeJSMPNaeDx12s41Nf96HbtODy9ZcEyy1kScrstZT
 QME+nTFs9ue9TPMZ/NLoltprQcxzErs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-63Cr7D_JNpqKYnnmC2JR7g-1; Sun, 19 Jan 2025 23:39:14 -0500
X-MC-Unique: 63Cr7D_JNpqKYnnmC2JR7g-1
X-Mimecast-MFC-AGG-ID: 63Cr7D_JNpqKYnnmC2JR7g
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ef9dbeb848so7591733a91.0
 for <qemu-devel@nongnu.org>; Sun, 19 Jan 2025 20:39:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737347953; x=1737952753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vwiXxTc7xFDKV1c7kXLl1EzuQbCxBUqxjJnvRGVrIss=;
 b=KlqPdrre9ahMSCUnEcFVkG7jsuxjU7+nRBIgTVKUCr4V1yKwdakPgqLrXF3lhAyfkJ
 LxOGV16BzSiVZHFwA0EmgbqRuaS4TR+beLvqWjKZW3DbR8SaE8zZcMNoC1PylOpwF6fu
 crPkT3MaMgbozkp/D7YF+/RQXgi3NtKxEi5qvaMkHJkIXm0ZlVCGHL2e/nvIuRmDYR0B
 YvaEZMJlzcUuy1MJkad4SmhFAP03vQTE748+HSxF1boJcBJg6jzyhyYd2l43d/4TpCoX
 dsQgE78doDa+KlkVpyrQhYNDfEHXKhaK596Wq0P7uHwEc4Rk+qIY3gJS6Z+VhkqH1Fjs
 qyAA==
X-Gm-Message-State: AOJu0YzWZ6PsB+GOXNub4m7IUehc/E1+LkvwTPXsZbJkCFUYFVd/6qL3
 cLl9uJymzhbYLNxw1URe4M4mnkufpbEjaB/zPirA401asiMtI4MJ6rBI+OXC202ohcJUU5b2JKU
 ThXnXNl8uY3vWM+wkH8M21/1TPj0xaD3o0Ry+jHaU5xIBUGB+uqU4
X-Gm-Gg: ASbGncvBNYdJAzMPIWD2ahrrorzrVvtLHDNrS1PytRryHc8o6gnaS9vu9ds85z+FKu8
 TKBz+sWZURyoXvS4owUj2bc7Kt1+Zd/e7tKhr+j5Q++4gyyPvrRzV5FuLp/p16DV7wbpqagwCcy
 oUusq2V0fUCkYT7raCE+IyCvWGW2MoIxIJte+t4nm77pKFy9KMyMNdLNrR+CQ488RhtjXIk+qNm
 VAZIt63u0JsrVjXrsk09XTVLpBpZikYZPmxyGI84AXGrlZuFZPRNzipdTdDk9lYvHRxvM37mg0I
 n0AqGlhWTFGxaX+u
X-Received: by 2002:a17:90a:c883:b0:2ee:b2be:f390 with SMTP id
 98e67ed59e1d1-2f782d37d55mr16960303a91.28.1737347952887; 
 Sun, 19 Jan 2025 20:39:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/LLVNdSVYHUzksYfnrqOjOTr5MyK4oVWBqScHPNmHMLpefkCEwE5saBhiUFItI2773g4LFw==
X-Received: by 2002:a17:90a:c883:b0:2ee:b2be:f390 with SMTP id
 98e67ed59e1d1-2f782d37d55mr16960274a91.28.1737347952440; 
 Sun, 19 Jan 2025 20:39:12 -0800 (PST)
Received: from localhost.localdomain ([115.96.115.34])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-a9bcc3232a4sm5889604a12.30.2025.01.19.20.39.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jan 2025 20:39:11 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v6 3/3] tests/qtest/vmcoreinfo: add a unit test to exercize
 basic vmcoreinfo function
Date: Mon, 20 Jan 2025 10:08:34 +0530
Message-ID: <20250120043847.954881-4-anisinha@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250120043847.954881-1-anisinha@redhat.com>
References: <20250120043847.954881-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A new qtest is written that exercizes the fw-cfg DMA based read and write ops
to write values into vmcoreinfo fw-cfg file and read them back and verify that
they are the same.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 MAINTAINERS                   |  2 +
 tests/qtest/meson.build       |  1 +
 tests/qtest/vmcoreinfo-test.c | 90 +++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)
 create mode 100644 tests/qtest/vmcoreinfo-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 846b81e3ec..57167c3c73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3016,6 +3016,7 @@ F: include/system/device_tree.h
 Dump
 S: Supported
 M: Marc-André Lureau <marcandre.lureau@redhat.com>
+R: Ani Sinha <anisinha@redhat.com>
 F: dump/
 F: hw/misc/vmcoreinfo.c
 F: include/hw/misc/vmcoreinfo.h
@@ -3026,6 +3027,7 @@ F: qapi/dump.json
 F: scripts/dump-guest-memory.py
 F: stubs/dump.c
 F: docs/specs/vmcoreinfo.rst
+F: tests/qtest/vmcoreinfo-test.c
 
 Error reporting
 M: Markus Armbruster <armbru@redhat.com>
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 94b28e5a53..fc669336a6 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -57,6 +57,7 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_AHCI_ICH9') ? ['tco-test'] : []) +                    \
   (config_all_devices.has_key('CONFIG_FDC_ISA') ? ['fdc-test'] : []) +                      \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['fw_cfg-test'] : []) +                    \
+  (config_all_devices.has_key('CONFIG_FW_CFG_DMA') ? ['vmcoreinfo-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['i440fx-test'] : []) +                    \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['ide-test'] : []) +                       \
   (config_all_devices.has_key('CONFIG_I440FX') ? ['numa-test'] : []) +                      \
diff --git a/tests/qtest/vmcoreinfo-test.c b/tests/qtest/vmcoreinfo-test.c
new file mode 100644
index 0000000000..dcf3b5ae05
--- /dev/null
+++ b/tests/qtest/vmcoreinfo-test.c
@@ -0,0 +1,90 @@
+/*
+ * qtest vmcoreinfo test case
+ *
+ * Copyright Red Hat. 2025.
+ *
+ * Authors:
+ *  Ani Sinha   <anisinha@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "libqos/libqos-pc.h"
+#include "libqtest.h"
+#include "standard-headers/linux/qemu_fw_cfg.h"
+#include "libqos/fw_cfg.h"
+#include "qemu/bswap.h"
+#include "hw/misc/vmcoreinfo.h"
+
+static void test_vmcoreinfo_write_basic(void)
+{
+    QFWCFG *fw_cfg;
+    QOSState *qs;
+    FWCfgVMCoreInfo info;
+    size_t filesize;
+    uint16_t guest_format;
+    uint16_t host_format;
+    uint32_t size;
+    uint64_t paddr;
+
+    qs = qtest_pc_boot("-device vmcoreinfo");
+    fw_cfg = pc_fw_cfg_init(qs->qts);
+
+    memset(&info, 0 , sizeof(info));
+    /* read vmcoreinfo and read back the host format */
+    filesize = qfw_cfg_read_file(fw_cfg, qs, FW_CFG_VMCOREINFO_FILENAME,
+                                &info, sizeof(info));
+    g_assert_cmpint(filesize, ==, sizeof(info));
+
+    host_format = le16_to_cpu(info.host_format);
+    g_assert_cmpint(host_format, ==, FW_CFG_VMCOREINFO_FORMAT_ELF);
+
+    memset(&info, 0 , sizeof(info));
+    info.guest_format = cpu_to_le16(FW_CFG_VMCOREINFO_FORMAT_ELF);
+    info.size = cpu_to_le32(1 * MiB);
+    info.paddr = cpu_to_le64(0xffffff00);
+    info.host_format = cpu_to_le16(host_format);
+
+    /* write the values to the host */
+    filesize = qfw_cfg_write_file(fw_cfg, qs, FW_CFG_VMCOREINFO_FILENAME,
+                                  &info, sizeof(info));
+    g_assert_cmpint(filesize, ==, sizeof(info));
+
+    memset(&info, 0 , sizeof(info));
+
+    /* now read back the values we wrote and compare that they are the same */
+    filesize = qfw_cfg_read_file(fw_cfg, qs, FW_CFG_VMCOREINFO_FILENAME,
+                                &info, sizeof(info));
+    g_assert_cmpint(filesize, ==, sizeof(info));
+
+    size = le32_to_cpu(info.size);
+    paddr = le64_to_cpu(info.paddr);
+    guest_format = le16_to_cpu(info.guest_format);
+
+    g_assert_cmpint(size, ==, 1 * MiB);
+    g_assert_cmpint(paddr, ==, 0xffffff00);
+    g_assert_cmpint(guest_format, ==, FW_CFG_VMCOREINFO_FORMAT_ELF);
+
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_shutdown(qs);
+}
+
+int main(int argc, char **argv)
+{
+    const char *arch = qtest_get_arch();
+
+    g_test_init(&argc, &argv, NULL);
+
+    if (strcmp(arch, "i386") && strcmp(arch, "x86_64")) {
+        /* skip for non-x86 */
+        exit(EXIT_SUCCESS);
+    }
+
+    qtest_add_func("vmcoreinfo/basic-write",
+                   test_vmcoreinfo_write_basic);
+
+    return g_test_run();
+}
-- 
2.45.2


