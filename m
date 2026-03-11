Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77777112583A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LLb-0002IQ-Bm; Wed, 11 Mar 2026 11:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w0LKv-0001lj-86; Wed, 11 Mar 2026 11:19:05 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w0LKt-0000yp-EU; Wed, 11 Mar 2026 11:19:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1773242216; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZKUH6WVvHkW1AuRCF9w/JglwnWTh+qCM6LHxhgHc7Obbfsjsath7WKPJHrv+DJ25GXbc1jqnYol1yvQuBDPwPhurRgtSbYACNxBEIfQEBq/KdOb0J3tcClpnaDOTtKeD57K7y/BXGVDPSFEIO7QA2SQ3lb6lKqBbcDAbx3wbFtA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773242216;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=cJm6+7br/MxErMIJhKP8pJ1zRDWklyGIsndwzWkRdF0=; 
 b=To7Cb1yNJFY/xUTSZtygIjBA0ajYv0VWU76dGBd8kZUIV/GAKYzD+PXlz2RvW8Xdt79LlI/2oUJ+gKa0V7G5b5SmW2Cb9Ttvt2dXHD17KVwctpoVVXyrTqqXTmptQEcKQVxCEOJDm7aSW4JAZNJLSZ1iTEtToU5TJpfu03Ryv84=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=anirudhrb.com;
 spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
 dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773242216; 
 s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=cJm6+7br/MxErMIJhKP8pJ1zRDWklyGIsndwzWkRdF0=;
 b=glSR/BH+qLXMLnfrygyiPAmj4I7w/BoGIDbK25+Gy4M3keMuyF9A6knqhgVhNUWt
 IyY7Q7SOl9FQVPyNd6uDsQtjr7OhpDnUO0RbGijaxZwJSIjEukEIkUYjDLWomnj1+bh
 CqqGtlCMKmUAKPSgJOUv9cmcHV/oCnkCT3hb6J4I=
Received: by mx.zohomail.com with SMTPS id 1773242213096753.7357082658008;
 Wed, 11 Mar 2026 08:16:53 -0700 (PDT)
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
Date: Wed, 11 Mar 2026 15:15:37 +0000
Subject: [PATCH 10/14] accel/mshv: implement cpu_thread_is_idle() hook
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-mshv_accel_arm64_supp-v1-10-c31699b7bc1f@anirudhrb.com>
References: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
In-Reply-To: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Anirudh Rayabharam <anirudh@anirudhrb.com>, 
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org
X-Mailer: b4 0.14.3
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.54;
 envelope-from=anirudh@anirudhrb.com; helo=sender4-of-o54.zoho.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

In MSHV the hypervisor APIC is always used, so we to implement this hook
to make sure the AP's vcpu thread is not blocked waiting for an INIT SIPI
by the BSP. Without this change soft reboots with -smp cpus>=2 will
hang.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mshv-all.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 563599ef6a..9a101d51ff 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -747,11 +747,23 @@ static const TypeInfo mshv_accel_type = {
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
2.43.0


