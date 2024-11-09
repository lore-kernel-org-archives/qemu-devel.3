Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A27DD5E36C
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 12:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kR9-0001ve-HW; Sat, 09 Nov 2024 07:19:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kQE-0007dJ-Py; Sat, 09 Nov 2024 07:18:35 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kQA-0005LR-Iy; Sat, 09 Nov 2024 07:18:33 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D4BC7A164C;
 Sat,  9 Nov 2024 15:08:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 9C6D9167FD2;
 Sat,  9 Nov 2024 15:09:03 +0300 (MSK)
Received: (nullmailer pid 3296232 invoked by uid 1000);
 Sat, 09 Nov 2024 12:09:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.2 34/58] target/riscv/kvm: set 'aia_mode' to default in
 error path
Date: Sat,  9 Nov 2024 15:08:35 +0300
Message-Id: <20241109120901.3295995-34-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
References: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

When failing to set the selected AIA mode, 'aia_mode' is left untouched.
This means that 'aia_mode' will not reflect the actual AIA mode,
retrieved in 'default_aia_mode',

This is benign for now, but it will impact QMP query commands that will
expose the 'aia_mode' value, retrieving the wrong value.

Set 'aia_mode' to 'default_aia_mode' if we fail to change the AIA mode
in KVM.

While we're at it, rework the log/warning messages to be a bit less
verbose. Instead of:

KVM AIA: default mode is emul
qemu-system-riscv64: warning: KVM AIA: failed to set KVM AIA mode

We can use a single warning message:

qemu-system-riscv64: warning: KVM AIA: failed to set KVM AIA mode 'auto', using default host mode 'emul'

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241028182037.290171-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit d201a127e164b1683df5e7c93c6d42a74122db99)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index f6e3156b8d..b264760752 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1710,18 +1710,26 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
         error_report("KVM AIA: failed to get current KVM AIA mode");
         exit(1);
     }
-    qemu_log("KVM AIA: default mode is %s\n",
-             kvm_aia_mode_str(default_aia_mode));
 
-    if (default_aia_mode != aia_mode) {
+    if (default_aia_mode == aia_mode) {
+        qemu_log("KVM AIA: using default host mode '%s'\n",
+                  kvm_aia_mode_str(default_aia_mode));
+    } else {
         ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
                                 KVM_DEV_RISCV_AIA_CONFIG_MODE,
                                 &aia_mode, true, NULL);
-        if (ret < 0)
-            warn_report("KVM AIA: failed to set KVM AIA mode");
-        else
-            qemu_log("KVM AIA: set current mode to %s\n",
+        if (ret < 0) {
+            warn_report("KVM AIA: failed to set KVM AIA mode '%s', using "
+                        "default host mode '%s'",
+                        kvm_aia_mode_str(aia_mode),
+                        kvm_aia_mode_str(default_aia_mode));
+
+            /* failed to change AIA mode, use default */
+            aia_mode = default_aia_mode;
+        } else {
+            qemu_log("KVM AIA: setting current mode to %s\n",
                      kvm_aia_mode_str(aia_mode));
+        }
     }
 
     ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
-- 
2.39.5


