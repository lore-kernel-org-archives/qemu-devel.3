Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7BBF5141C
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytdM-00016X-KH; Sat, 07 Mar 2026 10:32:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytdL-00015d-C0
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:32:03 -0500
Received: from p-west2-cluster5-host6-snip4-1.eps.apple.com ([57.103.71.54]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytdJ-0000NS-Tb
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:32:03 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPS id
 9A585180017D; Sat,  7 Mar 2026 15:31:58 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772897520; x=1775489520;
 bh=eYeB014LhZHAV9CwpOPxRgAEb60+L8+Y/QgrP5UgqAk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=VbJJXP0xqLo/DzfWT+7Qa4caSLUkoNpuEaKbvJt6XliMxPd9Un9NQObT0+645UGcNt1TKtqXoFUKO/gkd9j2l7LJA6gAPjoFQg6CXlWQsIDQ/9MhAdnhcrK2/bTsQeLYUb+wuJ7Fpx3Fg3BkLpbeBV/5vsc83Y3lPTSl4w5BkcMZEue0fA+6Rq6U9XNc2XtPyJUL5iLUSNJaLvbkBrU9m4tiZmR8ozR1DARQVnEdqGnlNNNlKG0S2HM/4gW5Vhedh8zB4gxN59yZdwllQJCPK5JIF87I/tXL50H+EEeWLD6gyluDF7FR8Dv3r40nnEmXVuJfGaNv7utvJl7Vjk3M/w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPSA id
 0C52E1800855; Sat,  7 Mar 2026 15:31:55 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v18 04/13] target/arm: hvf: instantiate GIC early
Date: Sat,  7 Mar 2026 16:31:34 +0100
Message-ID: <20260307153143.76893-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307153143.76893-1-mohamed@unpredictable.fr>
References: <20260307153143.76893-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fi91gC0J7W60CZfoSgIU_SP4IcQS399q
X-Proofpoint-ORIG-GUID: fi91gC0J7W60CZfoSgIU_SP4IcQS399q
X-Authority-Info-Out: v=2.4 cv=TZObdBQh c=1 sm=1 tr=0 ts=69ac44ef
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gV1jYa02L3q0mTRDDQ4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE0NyBTYWx0ZWRfXzSe6DOpxGgtY
 6R6Xaihat+qzSVjm3hsvPiZOox07jjPVDhV8ebiCs7Yzf5LNQR0iioILjuQ8GLWeOrpDJrC1Nzk
 7o1/VAh7F2toUn5n4PWGr3VNFx7B4kiyI7oMyxnA0ZEYE7u1FQRCNITjzfab/Y88QoyDMY8aTPJ
 m6eOXNvdLT9Q5nN853cT6myPtPAmfUr6rTVQHILEy50ri8CIigOfQhmFw2WDiD1nXKjFCViDc3+
 a1sSntRbX2Gow1YZc9x7Si2xLAqC+ux0qA05L0pKA9VIpX2dKg6Gz5JLxy5Yat5Yptd60zVdLA0
 SiLXfH7UV8+mKiKtrzV9PCfR9PHBlcXPMgCjvxPK4Zgbz33Mr5DnFQILJazza4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=554 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070147
X-JNJ: AAAAAAAB9USg/DPU08XFK4vDO20BEL27hof51FWhDDuADiwapgFuMIMxd1FztpPW8EzR6srRNPoj6zKa0cppLHxRN6mHovXxSx6LpEADXXd+nhLqFjahRwBLB82tNgbsZf3lQ6pUrHyAh6Q861sUtJuMyGFAq1V4dtTF5NpOIVZwKbGKos0b9slPYqggRdOd7ckb5Gh73InnWOzffyYOnGX3+vqlyqbGp4BS7tqGcIVJykiRTNwWwX7e0isPkHcMc06+B39fDQD70vnASd5RjM+RvJ1zxg6iy0zUej2u6il8BMbZ4K3ZE9o4tPsBSh9pTZYjJ6n+yhJSkMTTA3HtXjLPmikfdkRRtvcjHMJg6jHrQScDZaRU21msCFBGXy2kFSYwQvFYEZPMkxXvfCnobB1TmLNq7smYMsRcc32XTQK7wryPorEeRNqaxglzgkESIgZn/4NyGdJK+h7d1Vu0lZDj0vYr0rFRyiQLhdED/JQtE/V8cuk9QIMd8hHir2H/eeX7OJn59vAp3cRr6Cbm+NstS5G69qn9qeZ4lXw80kdGzSqQGud2IgwipqGC2++P64R5nULuEg6iy41oVDCl1VQ1v0CjASPK70ZETRzmR0WzPdS00Kuf2B56zsdAKbHj9zhcc3rN4BkrvL1XWW0gARjJ7elO2N2iyMwwwGiUw2CEv8cLQAu2XxOcrDEBdM53XE2EWCsBsfh2IBG9xevhqvCfQK+BS9XFS0n5Vw==
Received-SPF: pass client-ip=57.103.71.54;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


