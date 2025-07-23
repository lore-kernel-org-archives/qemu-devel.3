Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4F9C83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 09:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueVOH-0004Ka-Lj; Wed, 23 Jul 2025 05:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1ueVOE-0004Ie-TA
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 05:03:55 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1ueVOB-0003l8-TR
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 05:03:54 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c43:4603:0:640:d209:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 1094D883C8;
 Wed, 23 Jul 2025 12:03:44 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown
 [2a02:6bf:8080:579::1:1b])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id r2PVuT4GkKo0-SbLA6MBc; Wed, 23 Jul 2025 12:03:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1753261423;
 bh=ANM8p/WEI4AJZu+LWD0ZuhVXcnI4St4LBMeX6354I7E=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=ODyjGQMnjBv45JrhEXInwbU7nv6iws5NoZdwyHmKzcawpsds9ouFihtpI0W3PbTRf
 WhhBkB37m6c7EGi/hzDL4vAB5G+AWIjSrawftE/RRO0r9WR3ewOcibXG9+Evzb7gIU
 5txknHh02U18dJlRN9qRwaPX76bCEvvnjI3ms4Ng=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH] hw/smbios: add an ability to set extension bytes in the type0
 table
Date: Wed, 23 Jul 2025 12:01:28 +0300
Message-Id: <20250723090128.977364-1-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This is useful to be able to indicate various supported features to the
guest, or freeze a specific version of SeaBIOS to prevent guest visible
changes between BIOS updates. This is currently not possible since the
extension bytes indicated by SeaBIOS are slightly different than those
QEMU sets by default.

Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 hw/smbios/smbios.c           | 66 +++++++++++++++++++++++++++++++++---
 include/hw/firmware/smbios.h |  3 ++
 2 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index ad4cd6721e..73699e8a62 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -178,6 +178,14 @@ static const QemuOptDesc qemu_smbios_type0_opts[] = {
         .name = "uefi",
         .type = QEMU_OPT_BOOL,
         .help = "uefi support",
+    },{
+        .name = "extension_byte_1",
+        .type = QEMU_OPT_NUMBER,
+        .help = "BIOS characteristics extension byte 1"
+    },{
+        .name = "extension_byte_2",
+        .type = QEMU_OPT_NUMBER,
+        .help = "BIOS characteristics extension byte 2"
     },
     { /* end of list */ }
 };
@@ -572,10 +580,23 @@ static void smbios_build_type_0_table(void)
     t->bios_rom_size = 0; /* hardcoded in SeaBIOS with FIXME comment */
 
     t->bios_characteristics = cpu_to_le64(0x08); /* Not supported */
-    t->bios_characteristics_extension_bytes[0] = 0;
-    t->bios_characteristics_extension_bytes[1] = 0x14; /* TCD/SVVP | VM */
-    if (smbios_type0.uefi) {
-        t->bios_characteristics_extension_bytes[1] |= 0x08; /* |= UEFI */
+
+    if (smbios_type0.have_extension_bytes[0]) {
+        t->bios_characteristics_extension_bytes[0] =
+            smbios_type0.extension_bytes[0];
+    } else {
+        t->bios_characteristics_extension_bytes[0] = 0;
+    }
+
+    if (smbios_type0.have_extension_bytes[1]) {
+        t->bios_characteristics_extension_bytes[1] =
+            smbios_type0.extension_bytes[1];
+    } else {
+        t->bios_characteristics_extension_bytes[1] = 0x14; /* TCD/SVVP | VM */
+
+        if (smbios_type0.uefi) {
+            t->bios_characteristics_extension_bytes[1] |= 0x08; /* |= UEFI */
+        }
     }
 
     if (smbios_type0.have_major_minor) {
@@ -1403,7 +1424,42 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
             save_opt(&smbios_type0.vendor, opts, "vendor");
             save_opt(&smbios_type0.version, opts, "version");
             save_opt(&smbios_type0.date, opts, "date");
-            smbios_type0.uefi = qemu_opt_get_bool(opts, "uefi", false);
+
+            if (qemu_opt_get(opts, "extension_byte_1")) {
+                uint64_t ex_val;
+
+                ex_val = qemu_opt_get_number(opts, "extension_byte_1", 0);
+                if (ex_val > 0xFF) {
+                    error_setg(errp, "Invalid extension_byte_1");
+                    return;
+                }
+
+                smbios_type0.extension_bytes[0] = ex_val;
+                smbios_type0.have_extension_bytes[0] = true;
+            }
+
+            if (qemu_opt_get(opts, "extension_byte_2")) {
+                uint64_t ex_val;
+
+                ex_val = qemu_opt_get_number(opts, "extension_byte_2", 0);
+                if (ex_val > 0xFF) {
+                    error_setg(errp, "Invalid extension_byte_2");
+                    return;
+                }
+
+                smbios_type0.extension_bytes[1] = ex_val;
+                smbios_type0.have_extension_bytes[1] = true;
+            }
+
+            if (qemu_opt_get(opts, "uefi")) {
+                if (smbios_type0.have_extension_bytes[1]) {
+                    error_setg(errp, "'uefi' and 'extension_byte_2' are "
+                                     "mutually exclusive");
+                    return;
+                }
+
+                smbios_type0.uefi = qemu_opt_get_bool(opts, "uefi", false);
+            }
 
             val = qemu_opt_get(opts, "release");
             if (val) {
diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
index f066ab7262..67b3b28471 100644
--- a/include/hw/firmware/smbios.h
+++ b/include/hw/firmware/smbios.h
@@ -24,6 +24,9 @@ typedef struct {
     const char *vendor, *version, *date;
     bool have_major_minor, uefi;
     uint8_t major, minor;
+
+    bool have_extension_bytes[2];
+    uint8_t extension_bytes[2];
 } smbios_type0_t;
 extern smbios_type0_t smbios_type0;
 
-- 
2.34.1


