Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B2BCD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWbn3-0001vk-D1; Mon, 08 Jun 2026 11:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joro@8bytes.org>) id 1wWbn1-0001tp-EF
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:21:23 -0400
Received: from mail.8bytes.org ([2a01:238:42d9:3f00:e505:6202:4f0c:f051])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joro@8bytes.org>) id 1wWbmz-0007se-G5
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:21:23 -0400
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de
 [79.254.29.48])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id 72292202946;
 Mon,  8 Jun 2026 17:21:15 +0200 (CEST)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: philmd@linaro.org, marcel.apfelbaum@gmail.com, zhao1.liu@intel.com,
 berrange@redhat.com, mst@redhat.com, cohuck@redhat.com,
 mtosatti@redhat.com, Tom Lendacky <thomas.lendacky@amd.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, coconut-svsm@lists.linux.dev,
 joerg.roedel@amd.com
Subject: [RFC PATCH 05/10] accel/kvm: Support nr_planes call-back
Date: Mon,  8 Jun 2026 17:21:04 +0200
Message-ID: <20260608152109.356783-6-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608152109.356783-1-joro@8bytes.org>
References: <20260608152109.356783-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051;
 envelope-from=joro@8bytes.org; helo=mail.8bytes.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Joerg Roedel <joerg.roedel@amd.com>

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 accel/kvm/kvm-all.c | 19 +++++++++++++++++++
 dtc                 |  1 +
 ui/keycodemapdb     |  1 +
 3 files changed, 21 insertions(+)
 create mode 160000 dtc
 create mode 160000 ui/keycodemapdb

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 7429e2be8ba9..dbfef63a84b0 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -4247,6 +4247,24 @@ static bool kvm_accel_has_memory(AccelState *accel, AddressSpace *as,
     return false;
 }
 
+static uint8_t kvm_nr_planes(AccelState *accel, MachineState *ms)
+{
+    uint8_t nr_planes = 1;
+
+    // Planes are only supported with in-kernel APIC
+    if (kvm_irqchip_in_kernel()) {
+	    int ret;
+        KVMState *kvm = KVM_STATE(accel);
+
+        ret = kvm_vm_ioctl(kvm, KVM_CHECK_EXTENSION, KVM_CAP_PLANES);
+        if (ret > 0) {
+            nr_planes = ret;
+        }
+    }
+
+    return nr_planes;
+}
+
 static void kvm_get_kvm_shadow_mem(Object *obj, Visitor *v,
                                    const char *name, void *opaque,
                                    Error **errp)
@@ -4437,6 +4455,7 @@ static void kvm_accel_class_init(ObjectClass *oc, const void *data)
     ac->init_machine = kvm_init;
     ac->rebuild_guest = kvm_reset_vmfd;
     ac->has_memory = kvm_accel_has_memory;
+    ac->nr_planes = kvm_nr_planes;
     ac->allowed = &kvm_allowed;
     ac->gdbstub_supported_sstep_flags = kvm_gdbstub_sstep_flags;
 
diff --git a/dtc b/dtc
new file mode 160000
index 000000000000..b6910bec1161
--- /dev/null
+++ b/dtc
@@ -0,0 +1 @@
+Subproject commit b6910bec11614980a21e46fbccc35934b671bd81
diff --git a/ui/keycodemapdb b/ui/keycodemapdb
new file mode 160000
index 000000000000..d21009b1c9f9
--- /dev/null
+++ b/ui/keycodemapdb
@@ -0,0 +1 @@
+Subproject commit d21009b1c9f94b740ea66be8e48a1d8ad8124023
-- 
2.53.0


