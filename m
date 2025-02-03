Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425FBC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 17:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teznb-0006CY-Ux; Mon, 03 Feb 2025 11:59:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tezna-0006BI-Lb
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:59:50 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1teznY-0001NT-Ns
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:59:50 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 83FCD1F381;
 Mon,  3 Feb 2025 16:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738601987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OmHuD75OpXLe1iwiCge0smuv5ceTKz9zfyIrk9gDRa4=;
 b=tGW1sD3yO6lGJ0s0vXsePiHBXprAJDnC8OPbuzklkAfQvZpvARzU924T23rHH2m1s+QhqG
 2JJSFdQZ0/6KebGuaB1t240cs6mjXSMEu7pbrVMFzLmyUkQSxu5YPpLebJS9SQwB/A93ZK
 hyxEqXASeZDKN1+UNxDub2288wONSCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738601987;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OmHuD75OpXLe1iwiCge0smuv5ceTKz9zfyIrk9gDRa4=;
 b=WO86BEYykb2tRxDF7D6Nb0S8QpKJlQZoWlf5/caK69Fc2jS+fXDijTCfRNKPAJh4ySl1Uc
 S+9dgfVXS6EOCuBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738601987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OmHuD75OpXLe1iwiCge0smuv5ceTKz9zfyIrk9gDRa4=;
 b=tGW1sD3yO6lGJ0s0vXsePiHBXprAJDnC8OPbuzklkAfQvZpvARzU924T23rHH2m1s+QhqG
 2JJSFdQZ0/6KebGuaB1t240cs6mjXSMEu7pbrVMFzLmyUkQSxu5YPpLebJS9SQwB/A93ZK
 hyxEqXASeZDKN1+UNxDub2288wONSCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738601987;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OmHuD75OpXLe1iwiCge0smuv5ceTKz9zfyIrk9gDRa4=;
 b=WO86BEYykb2tRxDF7D6Nb0S8QpKJlQZoWlf5/caK69Fc2jS+fXDijTCfRNKPAJh4ySl1Uc
 S+9dgfVXS6EOCuBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F13813A78;
 Mon,  3 Feb 2025 16:59:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WHd/CwL2oGfDdgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 03 Feb 2025 16:59:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 3/6] tests/qtest/vmcoreinfo: add a unit test to exercize basic
 vmcoreinfo function
Date: Mon,  3 Feb 2025 13:59:35 -0300
Message-Id: <20250203165938.14320-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250203165938.14320-1-farosas@suse.de>
References: <20250203165938.14320-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Ani Sinha <anisinha@redhat.com>

A new qtest is written that exercizes the fw-cfg DMA based read and write ops
to write values into vmcoreinfo fw-cfg file and read them back and verify that
they are the same.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Message-ID: <20250120043847.954881-4-anisinha@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 MAINTAINERS                   |  2 +
 tests/qtest/meson.build       |  1 +
 tests/qtest/vmcoreinfo-test.c | 90 +++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)
 create mode 100644 tests/qtest/vmcoreinfo-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bf737eb6db..0cf37fce7b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3019,6 +3019,7 @@ F: include/system/device_tree.h
 Dump
 S: Supported
 M: Marc-André Lureau <marcandre.lureau@redhat.com>
+R: Ani Sinha <anisinha@redhat.com>
 F: dump/
 F: hw/misc/vmcoreinfo.c
 F: include/hw/misc/vmcoreinfo.h
@@ -3029,6 +3030,7 @@ F: qapi/dump.json
 F: scripts/dump-guest-memory.py
 F: stubs/dump.c
 F: docs/specs/vmcoreinfo.rst
+F: tests/qtest/vmcoreinfo-test.c
 
 Error reporting
 M: Markus Armbruster <armbru@redhat.com>
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index e60e92fe9d..5e062c752a 100644
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
2.35.3


