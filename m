Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F05D5E364
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 10:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9icz-0000Ot-DV; Sat, 09 Nov 2024 05:23:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9iXw-0001cx-5N; Sat, 09 Nov 2024 05:18:24 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9iXu-0008Ct-7m; Sat, 09 Nov 2024 05:18:23 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 999D0A140F;
 Sat,  9 Nov 2024 13:13:51 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 47898167EFA;
 Sat,  9 Nov 2024 13:14:46 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.8 42/49] target/riscv/kvm: clarify how 'riscv-aia'
 default works
Date: Sat,  9 Nov 2024 13:14:33 +0300
Message-Id: <20241109101443.312701-42-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-8.2.8-20241109131339@cover.tls.msk.ru>
References: <qemu-stable-8.2.8-20241109131339@cover.tls.msk.ru>
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

We do not have control in the default 'riscv-aia' default value. We can
try to set it to a specific value, in this case 'auto', but there's no
guarantee that the host will accept it.

Couple with this we're always doing a 'qemu_log' to inform whether we're
ended up using the host default or if we managed to set the AIA mode to
the QEMU default we wanted to set.

Change the 'riscv-aia' description to better reflect how the option
works, and remove the two informative 'qemu_log' that are now unneeded:
if no message shows, riscv-aia was set to the default or uset-set value.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241028182037.290171-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit fd16cfb2995e9196b579d8885145c4247dfa6058)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index daff517896..852e0cede4 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1335,9 +1335,9 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
     object_class_property_add_str(oc, "riscv-aia", riscv_get_kvm_aia,
                                   riscv_set_kvm_aia);
     object_class_property_set_description(oc, "riscv-aia",
-                                          "Set KVM AIA mode. Valid values are "
-                                          "emul, hwaccel, and auto. Default "
-                                          "is auto.");
+        "Set KVM AIA mode. Valid values are 'emul', 'hwaccel' and 'auto'. "
+        "Changing KVM AIA modes relies on host support. Defaults to 'auto' "
+        "if the host supports it");
     object_property_set_default_str(object_class_property_find(oc, "riscv-aia"),
                                     "auto");
 }
@@ -1370,10 +1370,7 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
         exit(1);
     }
 
-    if (default_aia_mode == aia_mode) {
-        qemu_log("KVM AIA: using default host mode '%s'\n",
-                  kvm_aia_mode_str(default_aia_mode));
-    } else {
+    if (default_aia_mode != aia_mode) {
         ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
                                 KVM_DEV_RISCV_AIA_CONFIG_MODE,
                                 &aia_mode, true, NULL);
@@ -1385,9 +1382,6 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
 
             /* failed to change AIA mode, use default */
             aia_mode = default_aia_mode;
-        } else {
-            qemu_log("KVM AIA: setting current mode to %s\n",
-                     kvm_aia_mode_str(aia_mode));
         }
     }
 
-- 
2.39.5


