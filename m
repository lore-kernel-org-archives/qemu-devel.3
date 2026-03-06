Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38310F513F9
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 04:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyMdf-0005jJ-PG; Thu, 05 Mar 2026 23:18:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyMde-0005id-6o
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 23:18:10 -0500
Received: from p-west2-cluster1-host1-snip4-8.eps.apple.com ([57.103.68.11]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyMdc-0002TG-Pa
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 23:18:09 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPS id
 83E5F1800127; Fri,  6 Mar 2026 04:18:07 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772770687; x=1775362687;
 bh=o4Lxm1TA6Kcx7liGCFRS9hTpKNWDkwXTIIQbMAQVIyk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=VrrNZJmwRJNPODLwOYQLZKPELliLeeipFEOxN9RLAPG8dnVXbvfEeVIloPMODXy5GKgBc3n7q2OV43DkfQ7pQKJTEdTjKpB+2GHphNFkWoCEvLXhjEMlPGuHROYZ6vFIkADfHnsBb2/EgC2SGG+6vEH0ZFCdzbZrWWdk6tgG32x/dvcE215pg82EshIiAg6XgFLdpJK629tno938MrxTvedZr5uSA95XRkQzrd/kpfJJ67IPAHsz+oxZajzdiBt5NjoULKEUJb4qvV+tzzVBqU/57+Mf4VV1sfS6ZmxwX9W7AuJFv4TA0F4SGzMgatqeDgw/K5DH5fKQs8b9KVFo/g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPSA id
 5953E180013D; Fri,  6 Mar 2026 04:18:05 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v12 06/15] target/arm: hvf: instantiate GIC early
Date: Fri,  6 Mar 2026 05:17:37 +0100
Message-ID: <20260306041747.54554-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306041747.54554-1-mohamed@unpredictable.fr>
References: <20260306041747.54554-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PdGONin3DjB6oJ9XofeTYApSTO2wAVHT
X-Proofpoint-ORIG-GUID: PdGONin3DjB6oJ9XofeTYApSTO2wAVHT
X-Authority-Info-Out: v=2.4 cv=d5f4CBjE c=1 sm=1 tr=0 ts=69aa557f
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=iW0rYzIOeSeTUJq9hTUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDAzOCBTYWx0ZWRfX7P/7+A3fGirf
 OFzB/0MEbFhzf0JwSMH7EM70Jp/eLgH0SqlL0RII+U3MYzgweENsRLFKSOYDjz0XKMraonjTjcj
 SqzpV0vbqjud7RDZCfmlRcdX5u9BP5iVhkTWz+uWqx/BVydBXzo4NZegLzPCrv4tQ0TXy6uvMN4
 wQoaDTz0h8EooHf9MmAPISMJXMEuiio2IdjveHmPYi1jlbTkyweb64P3Gtzrh0okrrlqECTfVsI
 EaTg+C4uwGyHPDsUEvqhWSbHAtEZUhVoM/nECD0oJG+JpSBPEbjZxfG5UCv4HipzjTJBMVIWE6J
 LJKDUZVGnTB7gr9YDCOB31z8fNc1qrvkFMwWq0rSFrQqiSf/ZFEm/J2Zkuv3t4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_01,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=731 phishscore=0 clxscore=1030
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060038
X-JNJ: AAAAAAABG2CoTkiqgyCMLHkvK2Vaj5udOfJvqwqH0xmuQcXKRwa3cIrZMTqaKeUh+7EUnFrsdlVIrnPQk2T2p46TZvWBJDAfZI6WKLnL8L7pXOoD7ZAOancmI6h1vm2R3PstImx5b51cdz0AhIdIse4s01ENlYOqwXMXBafJVETiR8tQgdzhAR1utesmw16KV9+J8rYNj9sOznFNJEvcECWQbPVu1n11jpvru+fkBIKXfhi0F94lkhKdU28PGrUDZREFPIOraXdP2+wU90JFKj5HyCSl4zqHlQ/VhgmX0+KSbFpshOE06JEiW4d+5NOoE0WIoBtM1iRoQiZaVLQPb0eLONt1gFU+oLgzzE3pY6Qk6zRPQa4fbqfXeHiSY32PlJxhA3JupI9Xz67OePYFp78UEkHivqBaKQ4QStfvdYSU9KgYnhqBKQ24DzJB1aNxDo5v4UnOtOjZ0biwdi6grBAOZive9y0rCQOUcU+kOxVnWBQLcdJRfGUsYSWE0W4O08nbi+T1lXvkK8KAtt4SLElBdyYwiyI8uKWe9PzVXlyJQV3qtst1FY3O4PCemq6jr6GITP+b9fP8q/u1V14stNPC0ZgOW+K526crFUeWr2g1ARMsQhI32zVDGX5uBlgMLeD9hNu4UGK9p2c3OXMqZwsBmS1L7mtscTy/wv7ENtFvc+XhYYL1jzf261Vgp/XjcVbZZkrihmGuWcVt9Sl+hahjpLnpZITHa8BdxapIm/iiFoyi
Received-SPF: pass client-ip=57.103.68.11;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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
 target/arm/hvf/hvf.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index c9787b3ea1..c37493b92a 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1212,6 +1212,22 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
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
+        }
+        os_release(cfg);
+    }
 
 cleanup:
     os_release(config);
-- 
2.50.1 (Apple Git-155)


