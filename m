Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45F0F506CB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 13:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w27fV-0000rn-Dh; Mon, 16 Mar 2026 09:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w27fT-0000qL-IO
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 09:07:35 -0400
Received: from p-west1-cluster3-host6-snip4-10.eps.apple.com ([57.103.66.23]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w27fR-0003av-S3
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 09:07:35 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-3 (Postfix) with ESMTPS id
 F13111803D2D; Mon, 16 Mar 2026 13:07:30 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773666451; x=1776258451;
 bh=I39KlZsy6P5F3w8BmyZE0FxzdEcPXKIH1UdSg5cxOh0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=GUjxjlLwCkdu7rN94yk45d8cgeRAwbXejUAMnTKTfy7p2KgjlSmI/4MyzlnX7spIdrjG8Y3H6ey08uhN5Lh84cmsjEggawr70TyDP2Dg5nJhZyIbiJhh/h04ZNkprGOBMywMPk1gC5weQcu117RS5VooqwNMh8BxndDXN2z7p3MPzbmNXV/uerSUrA5aQ/FCinTFJZtIjxkvwux7PkjZyCS9Uj25v6LfvJ5hYVsp9GWQEGr+yNVtYAUGY8C4C9FwBlZlWHKJaTlW1HRDrdOEiGghG4ACmeeKrMsLBmcQdT6sLUJk8yg6YKMTw1ubWEy7gEamUOByzc1Pm9MX7T+HPw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-3 (Postfix) with ESMTPSA id
 154381803652; Mon, 16 Mar 2026 13:06:56 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v20 04/15] target/arm: hvf: instantiate GIC early
Date: Mon, 16 Mar 2026 14:06:31 +0100
Message-ID: <20260316130642.13246-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260316130642.13246-1-mohamed@unpredictable.fr>
References: <20260316130642.13246-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=L/QQguT8 c=1 sm=1 tr=0 ts=69b80093
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=8CAvFU3GWpP82fccr8MA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEwMCBTYWx0ZWRfX7y3s8QZLJXVU
 xaRMwjtTZfJOJ2dJxPN+2VBX7JxlbKKPllCc4044uW8r1kkccTs9SybkhkF/h1tly1AEXC3eA3m
 z2xrKcUfvhvK7630D2coppEQCOfJPtw9S+OQUqyQKU6+FC84bC/q2zLFm2hcjESqqOZ2YDm9dMz
 k2rb/hnHRLaZLCndctUvmcqz+WPMlnIfEJ4w/X+g9SiLnGkHjx6EOzTM9lHShH4jwFV9k4/gehz
 Krzra2tKPq/v08lAkLee1fWN09pMBSeEvQBQooJ4YZqjgHcfTREvBuQ7GuFJIUTzpX1TWdNOV4e
 5YJ0gQgjBshXcmc6kgrKuuiDOMIK2KHCzr88NEdd1DLMxH/6yTEwtbkK362xc8=
X-Proofpoint-GUID: o_NMEyDmVxfJjVnLScaXVldMKQqwFTI8
X-Proofpoint-ORIG-GUID: o_NMEyDmVxfJjVnLScaXVldMKQqwFTI8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=699
 bulkscore=0 spamscore=0 mlxscore=0 clxscore=1030 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603160100
Received-SPF: pass client-ip=57.103.66.23;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index 5fc8f6bbbd..d431d96ba3 100644
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


