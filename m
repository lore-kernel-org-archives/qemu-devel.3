Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35729C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 13:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugO7s-0003zJ-CS; Mon, 28 Jul 2025 09:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugO6s-0005BK-Bh
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 09:41:46 -0400
Received: from p-east3-cluster5-host3-snip4-10.eps.apple.com ([57.103.86.161]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugO6p-0004KD-Ge
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 09:41:46 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPS id
 7373B1819D0A; Mon, 28 Jul 2025 13:41:40 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=Ssd6YNHgtSnjqPta+M8MbDoQ9g9wz27kHCDbsfNdBos=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=HGBLiUl3GNb6k0GKTObw46HDSgexxFwvbCHXzkV/tugo0tqDR2zNJrFKsccxXW65EyBBcq0EfyaljydJ/OwVhXP7D2QBBlzTS41AywPpu4OFhN7WYNoFgO03ncPXj+VHi+ZLEpb83tIJVmrlw1rPuCxjruzRrSt6+uGCtiPIZPDSxvAEMmsUMMtIVcO+/mNmMFyJ20/POBOmKkULW5Kzn4l7FhcGqF39NOo56oi9EAIMFGOBrNCuRRmY3kEDKNHMNB6/xxdbLbJSWSfmpq64IwCoelX5UDWxR45wIp8bHJdSZTMvNtkuvbj9RtIw6iGBXfGpWIWV+pQpaXBxa3qWBA==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPSA id
 43FD81800219; Mon, 28 Jul 2025 13:41:38 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v5 12/13] target/arm: hvf: instantiate GIC early
Date: Mon, 28 Jul 2025 15:41:13 +0200
Message-Id: <20250728134114.77545-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250728134114.77545-1-mohamed@unpredictable.fr>
References: <20250728134114.77545-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDEwMSBTYWx0ZWRfX4RDHg2TP2nZg
 WnrkzLeAgJ0FgxIydcgsCyet69GE/MRmqa4TPb4U+Nbg5LuOmZXwxGQRiafig1NXb59vMn4XiZr
 FSwCPFJlYJbt3p1pQ1mbhd++VFjHNdB56DOwifH2w0g+cEg4Fj47hTiTN+CcKFis6nNfIBai9Iy
 ETfHiX4Vn6CFpwv8DsOhlDU6hp4u6WRax2DpO6hI2oJabZ0cXNBiIHfGOlP+SGQ8KVPcQlSzcZ3
 fbPY3hNTPvon7d5yG9O5hC0wauhaQME879IGyP3m1SkJOS548au6a3MVJssZHzeDQoKRtwyng=
X-Proofpoint-GUID: a7O7H2l8ysik6BdoXL8lHuvV0RJ-z63x
X-Proofpoint-ORIG-GUID: a7O7H2l8ysik6BdoXL8lHuvV0RJ-z63x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=732 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507280101
Received-SPF: pass client-ip=57.103.86.161;
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
index f70870fb62..1fd9517f3e 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1083,6 +1083,21 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
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


