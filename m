Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C391C87FC5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 19:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf1wD-0003wA-Re; Thu, 24 Jul 2025 15:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1uf1v3-00038C-13
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 15:47:57 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1uf1uz-0000AL-8r
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 15:47:55 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 02B59C01DC;
 Thu, 24 Jul 2025 22:47:45 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown [2a02:6bf:8080:734::1:1])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ala7ls3Gp4Y0-f2mYfAC8; Thu, 24 Jul 2025 22:47:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1753386464;
 bh=51Mhz7TojAAv7XHT5YTayvO/6cwBBL7DFBAmuLmrCos=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=QVcsS2BrsOtUDje7XEmZNUjHmwFvOlIttWl+r+CRi5QQ0bpFiihjYVHe1jDrEhOEk
 7DPO8lddZMW59PbqrSycEvWuHMy4qxDHAf0Gb9xZleGkukOzH0x5OVwZZtJjQLiQCM
 uT00fjLRze0NH1ZkzjixWXvu6sREtHrPwSyn00bM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH] hw/smbios: allow clearing the VM bit in SMBIOS table 0
Date: Thu, 24 Jul 2025 22:47:31 +0300
Message-Id: <20250724194731.42701-1-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This is useful to be able to freeze a specific version of SeaBIOS to
prevent guest visible changes between BIOS updates. This is currently
not possible since the extension byte 2 provided by SeaBIOS does not
set the VM bit, whereas QEMU sets it unconditionally.

Allowing to clear it also seems useful if we want to hide the fact that
the guest system is running inside a virtual machine.

Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---

After talking to Michael:
Supersedes: <20250723090128.977364-1-d-tatianin@yandex-team.ru>

---
 hw/smbios/smbios.c           | 11 ++++++++++-
 include/hw/firmware/smbios.h |  2 +-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 1ac063cfb4..13e21a9c43 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -179,6 +179,10 @@ static const QemuOptDesc qemu_smbios_type0_opts[] = {
         .name = "uefi",
         .type = QEMU_OPT_BOOL,
         .help = "uefi support",
+    },{
+        .name = "vm",
+        .type = QEMU_OPT_BOOL,
+        .help = "virtual machine",
     },
     { /* end of list */ }
 };
@@ -574,10 +578,14 @@ static void smbios_build_type_0_table(void)
 
     t->bios_characteristics = cpu_to_le64(0x08); /* Not supported */
     t->bios_characteristics_extension_bytes[0] = 0;
-    t->bios_characteristics_extension_bytes[1] = 0x14; /* TCD/SVVP | VM */
+
+    t->bios_characteristics_extension_bytes[1] = 0x04; /* TCD/SVVP */
     if (smbios_type0.uefi) {
         t->bios_characteristics_extension_bytes[1] |= 0x08; /* |= UEFI */
     }
+    if (smbios_type0.vm) {
+        t->bios_characteristics_extension_bytes[1] |= 0x10; /* |= VM */
+    }
 
     if (smbios_type0.have_major_minor) {
         t->system_bios_major_release = smbios_type0.major;
@@ -1405,6 +1413,7 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
             save_opt(&smbios_type0.version, opts, "version");
             save_opt(&smbios_type0.date, opts, "date");
             smbios_type0.uefi = qemu_opt_get_bool(opts, "uefi", false);
+            smbios_type0.vm = qemu_opt_get_bool(opts, "vm", true);
 
             val = qemu_opt_get(opts, "release");
             if (val) {
diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
index f066ab7262..3ea732f4e6 100644
--- a/include/hw/firmware/smbios.h
+++ b/include/hw/firmware/smbios.h
@@ -22,7 +22,7 @@ extern GArray *usr_blobs_sizes;
 
 typedef struct {
     const char *vendor, *version, *date;
-    bool have_major_minor, uefi;
+    bool have_major_minor, uefi, vm;
     uint8_t major, minor;
 } smbios_type0_t;
 extern smbios_type0_t smbios_type0;
-- 
2.34.1


