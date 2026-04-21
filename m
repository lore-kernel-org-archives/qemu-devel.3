Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBB0F588C9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3Zw-0008IQ-N9; Tue, 21 Apr 2026 01:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wF3Yi-0007aB-7C; Tue, 21 Apr 2026 01:22:05 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wF3Ye-0000kl-VC; Tue, 21 Apr 2026 01:22:03 -0400
Received: from localhost (unknown [131.107.147.136])
 by linux.microsoft.com (Postfix) with ESMTPSA id 89B5220B6F22;
 Mon, 20 Apr 2026 22:21:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 89B5220B6F22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1776748919;
 bh=Lda5boUb4MXundo8aUjZAsYLSyCiH0MhXZAZjJi/qsk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=K6JLuj169VDCAKRhZalcvS7LIO7cWsvEU4B4YAIhfY9pOnqlffRNym8ALNK7IAK/D
 H/9/vgF99FiQiynCjKdkhXcAMlTi2APhOn+cTr5CAiy53SN1CgKCzfCS0vMCGk621P
 aZc0JDjfpHFH2bI6U/yLcVS5nrCdbgq0P18y+JBM=
From: Aastha Rawat <aastharawat@linux.microsoft.com>
Date: Tue, 21 Apr 2026 05:21:54 +0000
Subject: [PATCH v3 09/14] accel/mshv: implement cpu_thread_is_idle() hook
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-mshv_accel_arm64_supp-v3-9-469f544778ba@linux.microsoft.com>
References: <20260421-mshv_accel_arm64_supp-v3-0-469f544778ba@linux.microsoft.com>
In-Reply-To: <20260421-mshv_accel_arm64_supp-v3-0-469f544778ba@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Anirudh Rayabharam <anirudh@anirudhrb.com>, 
 Aastha Rawat <aastharawat@linux.microsoft.com>, 
 Magnus Kulke <magnus.kulke@linux.microsoft.com>, qemu-arm@nongnu.org, 
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=aastharawat@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

In MSHV the hypervisor APIC is always used, so we to implement this hook
to make sure the AP's vcpu thread is not blocked waiting for an INIT SIPI
by the BSP. Without this change soft reboots with -smp cpus>=2 will
hang.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/mshv/mshv-all.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 5ce76e86db..6c0ddbf3ca 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -704,11 +704,23 @@ static const TypeInfo mshv_accel_type = {
     .instance_size = sizeof(MshvState),
 };
 
+/*
+ * MSHV manages the LAPIC in the hypervisor. SIPI for APs are handled
+ * internally. Halted vCPUs must still enter mshv_cpu_exec() so that
+ * MSHV_RUN_VP is called and the hypervisor will deliver SIPI to wake APs.
+ */
+
+static bool mshv_vcpu_thread_is_idle(CPUState *cpu)
+{
+    return false;
+}
+
 static void mshv_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
     ops->create_vcpu_thread = mshv_start_vcpu_thread;
+    ops->cpu_thread_is_idle = mshv_vcpu_thread_is_idle;
     ops->synchronize_post_init = mshv_cpu_synchronize_post_init;
     ops->synchronize_post_reset = mshv_cpu_synchronize_post_reset;
     ops->synchronize_state = mshv_cpu_synchronize;

-- 
2.45.4


