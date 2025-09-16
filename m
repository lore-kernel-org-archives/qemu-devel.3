Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C4ACAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 16:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyYtk-00036u-LO; Tue, 16 Sep 2025 12:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uyYte-0002XJ-ER
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:51:14 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uyYtb-0006sr-Cw
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:51:14 -0400
Received: from localhost.localdomain (unknown [167.220.208.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id 12C0F20154ED;
 Tue, 16 Sep 2025 09:51:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 12C0F20154ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1758041470;
 bh=FmUbb2ga9uGC9tNNJuupj1Ijs2+s359X0IOcEMWzf9o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Dd1zQw/0zgQE9g4DK6RgW8hsOXW6GmRGVnTzqzM5mKJdUSiPDrE5pf9eBuvYKvkML
 sgLS1gJIFrWIxYCGWz7/mZ9ppwt/3Uetxn1zelj4tHnp+9NgJMxARQ05oOeO54dowN
 5zp2EihfKA+Hl5qN0vcNvhnklXE9KwY/9ZZ3l64Y=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Eric Blake <eblake@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 21/27] target/i386/mshv: Write MSRs to the hypervisor
Date: Tue, 16 Sep 2025 18:48:41 +0200
Message-Id: <20250916164847.77883-22-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Push current model-specific register (MSR) values to MSHV's vCPUs as
part of setting state to the hypervisor.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/mshv/mshv-cpu.c | 68 +++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index ef0fce5719..6cb4473124 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -997,6 +997,65 @@ static int put_regs(const CPUState *cpu)
     return 0;
 }
 
+struct MsrPair {
+    uint32_t index;
+    uint64_t value;
+};
+
+static int put_msrs(const CPUState *cpu)
+{
+    int ret = 0;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    MshvMsrEntries *msrs = g_malloc0(sizeof(MshvMsrEntries));
+
+    struct MsrPair pairs[] = {
+        { MSR_IA32_SYSENTER_CS,    env->sysenter_cs },
+        { MSR_IA32_SYSENTER_ESP,   env->sysenter_esp },
+        { MSR_IA32_SYSENTER_EIP,   env->sysenter_eip },
+        { MSR_EFER,                env->efer },
+        { MSR_PAT,                 env->pat },
+        { MSR_STAR,                env->star },
+        { MSR_CSTAR,               env->cstar },
+        { MSR_LSTAR,               env->lstar },
+        { MSR_KERNELGSBASE,        env->kernelgsbase },
+        { MSR_FMASK,               env->fmask },
+        { MSR_MTRRdefType,         env->mtrr_deftype },
+        { MSR_VM_HSAVE_PA,         env->vm_hsave },
+        { MSR_SMI_COUNT,           env->msr_smi_count },
+        { MSR_IA32_PKRS,           env->pkrs },
+        { MSR_IA32_BNDCFGS,        env->msr_bndcfgs },
+        { MSR_IA32_XSS,            env->xss },
+        { MSR_IA32_UMWAIT_CONTROL, env->umwait },
+        { MSR_IA32_TSX_CTRL,       env->tsx_ctrl },
+        { MSR_AMD64_TSC_RATIO,     env->amd_tsc_scale_msr },
+        { MSR_TSC_AUX,             env->tsc_aux },
+        { MSR_TSC_ADJUST,          env->tsc_adjust },
+        { MSR_IA32_SMBASE,         env->smbase },
+        { MSR_IA32_SPEC_CTRL,      env->spec_ctrl },
+        { MSR_VIRT_SSBD,           env->virt_ssbd },
+    };
+
+    if (ARRAY_SIZE(pairs) > MSHV_MSR_ENTRIES_COUNT) {
+        error_report("MSR entries exceed maximum size");
+        g_free(msrs);
+        return -1;
+    }
+
+    for (size_t i = 0; i < ARRAY_SIZE(pairs); i++) {
+        MshvMsrEntry *entry = &msrs->entries[i];
+        entry->index = pairs[i].index;
+        entry->reserved = 0;
+        entry->data = pairs[i].value;
+        msrs->nmsrs++;
+    }
+
+    ret = mshv_configure_msr(cpu, &msrs->entries[0], msrs->nmsrs);
+    g_free(msrs);
+    return ret;
+}
+
+
 int mshv_arch_put_registers(const CPUState *cpu)
 {
     int ret;
@@ -1007,8 +1066,13 @@ int mshv_arch_put_registers(const CPUState *cpu)
         return -1;
     }
 
-    error_report("unimplemented");
-    abort();
+    ret = put_msrs(cpu);
+    if (ret < 0) {
+        error_report("Failed to put msrs");
+        return -1;
+    }
+
+    return 0;
 }
 
 void mshv_arch_amend_proc_features(
-- 
2.34.1


