Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2F1CD13D2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 19:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIAER-0001j1-Do; Wed, 29 Apr 2026 15:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wIAEP-0001iI-Tl
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:05:57 -0400
Received: from ms-2001d-snip4-2.eps.apple.com ([57.103.73.163]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wIAEN-0000KW-Uv
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:05:57 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-6 (Postfix) with ESMTPS id
 BCD0318000F6; Wed, 29 Apr 2026 19:05:50 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAE1fDl4fBBdGGVUERx5dVl4eGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCAEkKXQJYAF4LTgZeD0YHXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1777489554; x=1780081554;
 bh=Xwojjz3yhXK980QCgbfBRrp9bUp/38rhPoNhD1XZIzs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=Dw/+sarZUDBXCEhXMl3TFGG+HP6tJzA7Bw6UQOQGH0Srmn3H5Vw4eerNX4Pf50GzWJpzuS/nD9RgnNPK73XqpotuvrDTtuKpGdTxp7Dr0KGUpPSyNShlBUWC0iR6dH9tvs0Kz+IcFC66jzAXxfAshZJaTCqpK5o4f2aNGW2Fj/fSVHIJMMxbjKdChrayYd4cY/STa+PMgWJLiBbUAoH0mZg5OmIlBWdhEPsFwLM06GYS7UTBPMOSyXXbSFdghjrg7vhBLg3WDP5yRisF0+QeBvkZocMpOhV1GeF3zu5ItP0ILw+cDLWtC0v8gGI+fhj5xK7BM52fUo7q413+PXMaSw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-6 (Postfix) with ESMTPSA id
 5676E18000C9; Wed, 29 Apr 2026 19:05:47 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Alexander Graf <agraf@csgraf.de>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v21 04/15] target/arm: hvf: instantiate GIC early
Date: Wed, 29 Apr 2026 21:05:21 +0200
Message-ID: <20260429190532.26538-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260429190532.26538-1-mohamed@unpredictable.fr>
References: <20260429190532.26538-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE5MCBTYWx0ZWRfX+fVOTO/uTFvA
 qLFXLO/HiI6UcFYc3eVRpQoV+od7nEuqJxH1mb6VHy9OF4ZnwHAAW+xjz22bp29Q3UNB14Bnx3E
 n66nvHcVOtdg5kZd1QkQcw2E8O/+LDgvT7yrzkH2Q2asPYfMe7T7119v3MJImkbnz58QBhqId9v
 n/sJmzSDCNXT3kFKUsOs4yaGOsfaQo2lo3eEEs6qFSWmz+j3SsfwShO1DuYgGHk4XZq7q84fo0M
 xgl+h3CQZ6DAY1lC85+gK2xPxcSaq084n58xRIURp1O3avLeDwiEfW0Tyn5pfzhsizcxe5p1cEC
 o9mpLrQB3OQ0/WR6i3vfOqHqOB4CcjJHy9kIl0PbKE+ZDZ4rgucS6TzS8GqRDU=
X-Proofpoint-GUID: SyKwCBgXXH0NIwYFKXb4_uPFfybJWY5q
X-Proofpoint-ORIG-GUID: SyKwCBgXXH0NIwYFKXb4_uPFfybJWY5q
X-Authority-Info-Out: v=2.4 cv=Ur1u9uwB c=1 sm=1 tr=0 ts=69f25690
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=8CAvFU3GWpP82fccr8MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
Received-SPF: pass client-ip=57.103.73.163;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

While figuring out a better spot for it, put it in hv_arch_vm_create().

After hv_vcpu_create is documented as too late, and deferring
vCPU initialization isn't enough either.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index ef4c3671e9..a028c99e24 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1230,6 +1230,28 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
     chosen_ipa_bit_size = pa_range;
 
     ret = hv_vm_create(config);
+    if (hvf_irqchip_in_kernel()) {
+        if (__builtin_available(macOS 15.0, *)) {
+            /*
+             * Instantiate GIC.
+             * This must be done prior to the creation of any vCPU
+             * but past hv_vm_create()
+             */
+            hv_gic_config_t cfg = hv_gic_config_create();
+            hv_gic_config_set_distributor_base(cfg, 0x08000000);
+            hv_gic_config_set_redistributor_base(cfg, 0x080A0000);
+            ret = hv_gic_create(cfg);
+            if (ret != HV_SUCCESS) {
+                error_report("error creating platform VGIC");
+                goto cleanup;
+            }
+            os_release(cfg);
+        } else {
+            error_report("HVF: Unsupported OS for platform vGIC.");
+            ret = HV_UNSUPPORTED;
+            goto cleanup;
+        }
+    }
 
 cleanup:
     os_release(config);
-- 
2.50.1 (Apple Git-155)


