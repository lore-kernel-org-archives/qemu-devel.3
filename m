Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D834BC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 22:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufQy6-0007LE-Eb; Fri, 25 Jul 2025 18:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufQwd-0006cf-Mb
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 18:31:21 -0400
Received: from p-east3-cluster2-host4-snip4-5.eps.apple.com ([57.103.87.166]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufQwC-0003kF-UT
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 18:31:14 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 50DC71800121; Fri, 25 Jul 2025 22:30:44 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=zCg14wMZjFzEnr/keWTZsISkJSQFDfxeZKB2UAhnTgc=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=CIGFF5j0kwHmYQX16+GQTFPSLhvpDXEWVZO8jnC8XENOp+WcXJDf0HXUhMIUJJB3KnpLQFrgixYZrESRVDoH034yCrsWUpo2HhPJ32Z00yT38N7/VnCRDYFkNinmUcFzV+LZ7Tce235sAqwSwobdVqFmD9GhNLfk4hR14h43qIaFvP/ka+OnuCPURKsc/kIYikz26wVPQ8iYpqmfKEpbNCFL93kDdZqi0TsNFIkrng3GxBiHG5dT3zdfngcs0lbCO0FQmliRCAcrXS0ZvBoUHr2tsR/+DJBxRZLKGGRZAKpLYFLRSZFIc8xsovDNSx6ajtt8JynjKFLIzUqFrSZErw==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 BD28718000A6; Fri, 25 Jul 2025 22:30:41 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v3 2/9] target/arm: hvf: instantiate GIC early
Date: Sat, 26 Jul 2025 00:30:28 +0200
Message-Id: <20250725223035.52284-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250725223035.52284-1-mohamed@unpredictable.fr>
References: <20250725223035.52284-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: t6sXW1uDajC5zsIVa-1GqJcfvepzpbCi
X-Proofpoint-ORIG-GUID: t6sXW1uDajC5zsIVa-1GqJcfvepzpbCi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDE5NSBTYWx0ZWRfX6rH2TG2EAZea
 AFZf1JE95TMpYlXqi18KzAsyINmGKG180sZSjjHmOELLia40LLZpmeOsfeHGue6gUFeVd7foeqC
 4v7LVDtLK+aIs4IJtI0k/w9E3wxqbAi5wL8nXxYrK14R+om1bcqS8MgXFPkqXaO7PyjBgZEDrrP
 eotDA4W6p8N16GFr2hf13sLNLW2/z4sWtLwkzw97wz8De18A2UM9pKNEpS/0vql2Q2bhXz1mQ7D
 3d8OtpdiIXHKwxRiohdfcmPQJf4QwpKJAxwi0bxsYgv8lMX+WUp+QxpBx+e0mmZQQxAfyuZfo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_06,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=616
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 bulkscore=0
 suspectscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2507250195
Received-SPF: pass client-ip=57.103.87.166;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 47b0cd3a35..3ba74b8daa 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1001,6 +1001,21 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
     chosen_ipa_bit_size = pa_range;
 
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


