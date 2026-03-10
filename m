Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1DDEB1073
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzFz-000654-QR; Tue, 10 Mar 2026 11:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vzzFv-000641-BW; Tue, 10 Mar 2026 11:44:24 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vzzFt-0001jh-DF; Tue, 10 Mar 2026 11:44:23 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 9909887365;
 Tue, 10 Mar 2026 16:44:18 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 zhao1.liu@intel.com, peterx@redhat.com, farosas@suse.de,
 wangxinxin.wang@huawei.com
Subject: [PATCH v2] target/i386: add compat for migrating error code
Date: Tue, 10 Mar 2026 16:43:23 +0100
Message-ID: <20260310154348.495332-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1773157424299
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: 28
X-Spam_score: 2.8
X-Spam_bar: ++
X-Spam_report: (2.8 / 5.0 requ) BAYES_00=-1.9, HEXHASH_WORD=2.999,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

If cpu->env.has_error_code is true, backwards migration of a VM from
a QEMU binary with commit 27535e9cca to a QEMU binary without commit
27535e9cca will fail:

> kvm: error while loading state for instance 0x0 of device 'cpu'

In practice, wrongly setting the error code to 0 on the target is
often unproblematic, so additionally checking error_code != 0 in
cpu_errcode_needed() is not enough to mitigate the issue. Instead, add
proper machine version compat handling.

Cc: qemu-stable@nongnu.org
Fixes: 27535e9cca ("target/i386: Add support for save/load of exception error code")
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Changes in v2:
* Add proper machine version compat rather than just checking if
  error_code != 0.

 hw/i386/pc.c          | 1 +
 target/i386/cpu.c     | 1 +
 target/i386/cpu.h     | 1 +
 target/i386/machine.c | 2 +-
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index addf602da0..4b53b5be4a 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -78,6 +78,7 @@ const size_t pc_compat_10_2_len = G_N_ELEMENTS(pc_compat_10_2);
 
 GlobalProperty pc_compat_10_1[] = {
     { "mch", "extended-tseg-mbytes", "16" },
+    { TYPE_X86_CPU, "x-migrate-error-code", "false" },
 };
 const size_t pc_compat_10_1_len = G_N_ELEMENTS(pc_compat_10_1);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0a29ff805f..abf129c7d5 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10561,6 +10561,7 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
     DEFINE_PROP_BOOL("x-migrate-smi-count", X86CPU, migrate_smi_count,
                      true),
+    DEFINE_PROP_BOOL("x-migrate-error-code", X86CPU, migrate_error_code, true),
     /*
      * lecacy_cache defaults to true unless the CPU model provides its
      * own cache information (see x86_cpu_load_def()).
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 5a62aa6157..ecae8593c8 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2361,6 +2361,7 @@ struct ArchCPU {
     bool expose_tcg;
     bool migratable;
     bool migrate_smi_count;
+    bool migrate_error_code;
     uint32_t apic_id;
 
     /* Enables publishing of TSC increment and Local APIC bus frequencies to
diff --git a/target/i386/machine.c b/target/i386/machine.c
index c913961281..48a2a4b319 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -466,7 +466,7 @@ static bool cpu_errcode_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
 
-    return cpu->env.has_error_code != 0;
+    return cpu->env.has_error_code != 0 && cpu->migrate_error_code;
 }
 
 static const VMStateDescription vmstate_error_code = {
-- 
2.47.3



