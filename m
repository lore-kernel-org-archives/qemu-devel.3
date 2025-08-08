Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17110C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 07:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukH7i-0006vx-H0; Fri, 08 Aug 2025 03:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ukH7B-0006Ai-41
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:02:09 -0400
Received: from p-east3-cluster5-host8-snip4-10.eps.apple.com ([57.103.86.211]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ukH78-0005Gg-Kg
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:02:08 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-5 (Postfix) with ESMTPS id
 A54E3180016B; Fri,  8 Aug 2025 07:02:03 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=UCrlDN4F3RzofcrNT7qklF4nN62t3UNBnscwkRliVxc=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=LljGLFag5SjQ4+A9gCOrN1Wd4IFO43lciiqERcJNae8ANgTvsNmAlpm/cQnFzoF6KkPqtvzC9++krLaQnFGgMM0gGtH1yrgerc4Y5nPVSfEHb3mCXBU5Npj2eyQZOw8QNJbUJb8oIy46knTpS7D1GpQQz2nFopv1QqELKvlxkYdgDZr4J8wF8WqVzbU5Xb6wRdQ3jXdmpeEBqyBUEyRBZpA4Q9j5K9rHQOSGjdglzbvae3RB6iVy0kJOt3KTEL6B7Yh0mtiY3KqV2QdKGVN2AGnvtYu7sRHd8jh+dkTE7/tr53fyE9SMRWVQ9vx309ckYcyQuh9Wmvdx2KKM5gj/sw==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-5 (Postfix) with ESMTPSA id
 7B9E01800102; Fri,  8 Aug 2025 07:02:01 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v6 12/13] target/arm: hvf: instantiate GIC early
Date: Fri,  8 Aug 2025 09:01:36 +0200
Message-Id: <20250808070137.48716-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250808070137.48716-1-mohamed@unpredictable.fr>
References: <20250808070137.48716-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HlwvqLQWyy7PExrF7QvIw8aZ51v74J-G
X-Proofpoint-ORIG-GUID: HlwvqLQWyy7PExrF7QvIw8aZ51v74J-G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA1NyBTYWx0ZWRfXwLKq+G7YA7mF
 5rHZtNAPQ2wie0Nb57RTNiOyTkB+QOYgXu1eaBlP4vE61DQAEzmOgBMhkD+zqrRz+Dc2y41WGmQ
 aK+zixLX1qGubC+oHiSMyfHDy4ph8rGmSCs3MlJe+pum11dCX/BNzJzHbuIrK4/CTtNBYK/DKBQ
 xhcdBRsgTcPRZqLNhlkgYtVnJ2hQfXj25OHlaf4ACqUdJDgeOUiFv4R7BBgvcVuxYhC7BhbpFEp
 4spComJLMjo+wTIZ9HTZ/1Uj3WHi13n7TtUIoX8tHWUApqPFwO6cVToRezusCdbGTGaGUtPXg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1030 mlxlogscore=732 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2508080057
Received-SPF: pass client-ip=57.103.86.211;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

While figuring out a better spot for it, put it in hv_arch_vm_create().

After hv_vcpu_create is documented as too late, and deferring
vCPU initialization isn't enough either.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 6da636724b..bb7b84ff35 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1084,6 +1084,21 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
     }
 
     ret = hv_vm_create(config);
+    if (hvf_irqchip_in_kernel()) {
+        /*
+         * Instantiate GIC.
+         * This must be done prior to the creation of any vCPU
+         * but past hv_vm_create()
+         */
+        hv_gic_config_t cfg = hv_gic_config_create();
+        hv_gic_config_set_distributor_base(cfg, 0x08000000);
+        hv_gic_config_set_redistributor_base(cfg, 0x080A0000);
+        hv_return_t err = hv_gic_create(cfg);
+        if (err != HV_SUCCESS) {
+            error_report("error creating platform VGIC");
+            goto cleanup;
+         }
+    }
 
 cleanup:
     os_release(config);
-- 
2.39.5 (Apple Git-154)


