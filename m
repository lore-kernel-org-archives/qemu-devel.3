Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A148D3C921
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2024 16:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2CUy-00021w-Vz; Sat, 19 Oct 2024 12:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1t2CUs-0001vX-Ts
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 12:40:10 -0400
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1t2CUq-0003gr-2F
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 12:40:10 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 3B4681802EC
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2024 18:39:58 +0200 (CEST)
Received: (qmail 9732 invoked by uid 990); 19 Oct 2024 16:39:58 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sat, 19 Oct 2024 18:39:57 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH v2 2/7] plugins: add hooks for new trap related callbacks
Date: Sat, 19 Oct 2024 18:39:35 +0200
Message-ID: <7ac6b4373e393e99070470818f6197fa34f9e3a9.1729355735.git.neither@nut.email>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729355735.git.neither@nut.email>
References: <20231021122502.26746-1-neither@nut.email>
 <cover.1729355735.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ----
X-Rspamd-Report: REPLY(-4) SUSPICIOUS_RECIPS(1.5) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) BAYES_HAM(-2.999999) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -4.099999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=2PREUqFIHRAtdmmzZJyaj9MVcqZad6TdGsxcSG5umK0=;
 b=PMi/3/uaxWjE6nzJF/yJC5e+P9c+r3VFvQcRZ+1Gx/D2sw31UPrBhhCPYHxz4H0t9lk95IARPd
 jARxKLEk+vnOFtVICZKH1gB1wugBdISWL0d2FACRpCbiXh2+JTBvppZcpXrooDe/QCfGKVLFDrtn
 asbRMeqDUxFqHnQ7LO72hrQMSwGe4c0SUQ8eQ5eINjL90GzD3kwzpIUafvpMUzlLmsh6zPpRzMq8
 e2GIdzw1eYuDw8cMdFxMx7rEoup0CMGqclsco2N7w36tZyi0G4TwuW4xLdgDoJCAwoZrd9iLh2No
 9ZX/DKRcoYkeKEtFO/tzEaMAJnGTxalgcHQlAbHVnLkNu1qaseZ2Cyw85JZS+6cL+oU+u6B2+tDV
 BjbT8lOG7QUvwV1SSjrB81Q0ka4MQpESZjH34VsNGJXs8F+3sT7fpc/EAg5au2oWgrPMAJtjy/j9
 /oTdCasD+Fhq3ulvXSqGJ7Rx1w3N04295pFxeb7IJ9scrEkFLrv09noQu3GfCKuocxJD+Mvo777Y
 7niwnl+cOUlBlatrlsgUW6RVRGeMTyOZj7Os+6UxSII+1NmdieT74IVWGrW9e+VxCsi/DORBE6Ju
 T321xahybeJZvBRwE0w0lgzlcyu1I3k7+vVidVy5r9bVfCsh/UqiBbQ9Zkk9hsfBXlpJ8mNuoZUw
 k=
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=neither@nut.email; helo=mailgate02.uberspace.is
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

The plugin API allows registration of callbacks for a variety of VCPU
related events, such as VCPU reset, idle and resume. In addition, we
recently introduced API for registering callbacks for trap events,
specifically for interrupts, exceptions and semihosting events.

This change introduces the corresponding hooks called from target
specific code inside qemu.

Signed-off-by: Julian Ganz <neither@nut.email>
---
 include/qemu/plugin.h | 12 ++++++++++++
 plugins/core.c        | 24 ++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 9726a9ebf3..71f03b83f4 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -160,6 +160,9 @@ void qemu_plugin_vcpu_exit_hook(CPUState *cpu);
 void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb);
 void qemu_plugin_vcpu_idle_cb(CPUState *cpu);
 void qemu_plugin_vcpu_resume_cb(CPUState *cpu);
+void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu);
+void qemu_plugin_vcpu_exception_cb(CPUState *cpu);
+void qemu_plugin_vcpu_semihosting_cb(CPUState *cpu);
 void
 qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1,
                          uint64_t a2, uint64_t a3, uint64_t a4, uint64_t a5,
@@ -242,6 +245,15 @@ static inline void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
 static inline void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
 { }
 
+void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu)
+{ }
+
+void qemu_plugin_vcpu_exception_cb(CPUState *cpu)
+{ }
+
+void qemu_plugin_vcpu_semihosting_cb(CPUState *cpu)
+{ }
+
 static inline void
 qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
                          uint64_t a3, uint64_t a4, uint64_t a5, uint64_t a6,
diff --git a/plugins/core.c b/plugins/core.c
index 9de997069c..4f80f1cb72 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -100,6 +100,9 @@ static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
     case QEMU_PLUGIN_EV_VCPU_EXIT:
     case QEMU_PLUGIN_EV_VCPU_IDLE:
     case QEMU_PLUGIN_EV_VCPU_RESUME:
+    case QEMU_PLUGIN_EV_VCPU_INTERRUPT:
+    case QEMU_PLUGIN_EV_VCPU_EXCEPTION:
+    case QEMU_PLUGIN_EV_VCPU_SEMIHOSTING:
         /* iterate safely; plugins might uninstall themselves at any time */
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
             qemu_plugin_vcpu_simple_cb_t func = cb->f.vcpu_simple;
@@ -547,6 +550,27 @@ void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
     }
 }
 
+void qemu_plugin_vcpu_interrupt_cb(CPUState *cpu)
+{
+    if (cpu->cpu_index < plugin.num_vcpus) {
+        plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_INTERRUPT);
+    }
+}
+
+void qemu_plugin_vcpu_exception_cb(CPUState *cpu)
+{
+    if (cpu->cpu_index < plugin.num_vcpus) {
+        plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_EXCEPTION);
+    }
+}
+
+void qemu_plugin_vcpu_semihosting_cb(CPUState *cpu)
+{
+    if (cpu->cpu_index < plugin.num_vcpus) {
+        plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_SEMIHOSTING);
+    }
+}
+
 void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
                                        qemu_plugin_vcpu_simple_cb_t cb)
 {
-- 
2.45.2


