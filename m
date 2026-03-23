Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3ABF46122
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 14:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4fqs-0001aL-1L; Mon, 23 Mar 2026 10:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1w4fog-0000Sx-Op
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:59:42 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1w4fod-0006xu-RP
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:59:38 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
 by linux.microsoft.com (Postfix) with ESMTPSA id 4AD4820B6F1F;
 Mon, 23 Mar 2026 06:59:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4AD4820B6F1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1774274365;
 bh=ASHwIUqJhX6VXNhjtPjQt2QC4yNFkvq7Vac2whkLBwE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AEtv4OcTVKomZFVNK/kGBko1z4d0IDgkNtbtPVl/n7a9C/U4RgbmeMHzA3L53fdpy
 n+T0JSs5ZkVnVDg3u0KUJDwGSPdjtQmD6HS0CIXxU5EgywxL8v2H5RAWwYdtwz+hG/
 layGbJuszzJhBQ9zC2SFfpMvc5bxICZWPAQzBwMY=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Wei Liu <liuwe@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Wei Liu <wei.liu@kernel.org>, Alex Williamson <alex@shazbot.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC 18/32] target/i386/mshv: expose msvh_get_generic_regs
Date: Mon, 23 Mar 2026 14:57:58 +0100
Message-Id: <20260323135812.383509-19-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
References: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

We expose the fn, so we can call them from the other source files
(msr.c).

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 include/system/mshv_int.h   |  2 ++
 target/i386/mshv/mshv-cpu.c | 15 ++++++---------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 2b6d7b2f35..2c5d16bf9a 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -81,6 +81,8 @@ int mshv_configure_vcpu(const CPUState *cpu);
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit);
 int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
                           size_t n_regs);
+int mshv_get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
+                          size_t n_regs);
 int mshv_arch_store_vcpu_state(const CPUState *cpu);
 int mshv_arch_load_vcpu_state(CPUState *cpu);
 void mshv_arch_init_vcpu(CPUState *cpu);
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 906f5b0c3d..ecb4711b95 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -108,9 +108,6 @@ static enum hv_register_name FPU_REGISTER_NAMES[26] = {
 };
 
 static int set_special_regs(const CPUState *cpu);
-static int get_generic_regs(CPUState *cpu,
-                            struct hv_register_assoc *assocs,
-                            size_t n_regs);
 
 static int get_lapic(CPUState *cpu)
 {
@@ -187,7 +184,7 @@ static int get_fpu(CPUState *cpu)
     for (size_t i = 0; i < n_regs; i++) {
         assocs[i].name = FPU_REGISTER_NAMES[i];
     }
-    ret = get_generic_regs(cpu, assocs, n_regs);
+    ret = mshv_get_generic_regs(cpu, assocs, n_regs);
     if (ret < 0) {
         error_report("failed to get special registers");
         return -errno;
@@ -207,7 +204,7 @@ static int get_xc_reg(CPUState *cpu)
 
     assocs[0].name = HV_X64_REGISTER_XFEM;
 
-    ret = get_generic_regs(cpu, assocs, 1);
+    ret = mshv_get_generic_regs(cpu, assocs, 1);
     if (ret < 0) {
         error_report("failed to get xcr0");
         return -1;
@@ -300,8 +297,8 @@ int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
     return 0;
 }
 
-static int get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
-                            size_t n_regs)
+int mshv_get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
+                          size_t n_regs)
 {
     int cpu_fd = mshv_vcpufd(cpu);
     int vp_index = cpu->cpu_index;
@@ -450,7 +447,7 @@ static int get_standard_regs(CPUState *cpu)
     for (size_t i = 0; i < n_regs; i++) {
         assocs[i].name = STANDARD_REGISTER_NAMES[i];
     }
-    ret = get_generic_regs(cpu, assocs, n_regs);
+    ret = mshv_get_generic_regs(cpu, assocs, n_regs);
     if (ret < 0) {
         error_report("failed to get standard registers");
         return -1;
@@ -527,7 +524,7 @@ static int get_special_regs(CPUState *cpu)
     for (size_t i = 0; i < n_regs; i++) {
         assocs[i].name = SPECIAL_REGISTER_NAMES[i];
     }
-    ret = get_generic_regs(cpu, assocs, n_regs);
+    ret = mshv_get_generic_regs(cpu, assocs, n_regs);
     if (ret < 0) {
         error_report("failed to get special registers");
         return -errno;
-- 
2.34.1


