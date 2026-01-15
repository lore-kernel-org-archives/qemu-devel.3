Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CE6D3CCAF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 04:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgFKH-0004lD-8p; Wed, 14 Jan 2026 23:51:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgFKF-0004kL-BJ
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 23:51:15 -0500
Received: from p-west3-cluster2-host10-snip4-4.eps.apple.com ([57.103.74.17]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgFKD-000663-VN
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 23:51:15 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-10-percent-0 (Postfix) with ESMTPS id
 4F844180013D; Thu, 15 Jan 2026 04:51:10 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=t0pie9ykznTRBEgE7ddD3LUH8QD+vRo3vydTMSYIXOU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=JLWzcmnp2N+0zYJ7vFqdQBPIoL7cxO7IUTR4LOs4xGv02EIIcGm2jcak/CZeZQcknrjVX4yQvVM9xlU6NLC/ZmI49a7xtFMGyfiCP35AC6dwEtDy1XSv+qQhpBDFMBie1yeyjg/mJ5nFYXdgmUKRy4PnVg13lOYd+KuM0TULCEvi+z4dH8GZh20EM++GqhOf0WVS+S1KKXhCthYrpZ7xx+pudaDgd7fKmiafZBK82W9JuTHZ4o04SK9ujy1iuMbsvCIxXgCYv4YpGRXhtDOHBQBmgYtuRcrIRXNTylKaJ5q5vh/MJeNoPt+VlTa5yBiHf+12MYnNAWaSZ+quxChpuA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-10-percent-0 (Postfix) with ESMTPSA id
 7F841180011B; Thu, 15 Jan 2026 04:51:06 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v7 08/10] target/arm: hvf: instantiate GIC early
Date: Thu, 15 Jan 2026 05:50:40 +0100
Message-ID: <20260115045042.70086-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260115045042.70086-1-mohamed@unpredictable.fr>
References: <20260115045042.70086-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: SpPyU6nD1BqH8b87tf6h7ItkgbzEn3M0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDAyOSBTYWx0ZWRfXz/YU1GdLL7AE
 n4DcTSy/zyiFzj5Vpr7ibW3fONNPilykIPsXA0HqCbGq65tFnx+Zca6+jy6Xx1Sjir49Lqdd18/
 S1P+xaNodo+gUMKy5b6J5ZpTT764CnZoaZtExuw5j3ZEfLNjNjdaU7RYtCSst1edqk+OZRYBdMH
 u6426RTjMxeA02DwtaOIqoCvlL7YtrPvKaknoFnlOfameTugfSQlf19DTKIC74bOVrIjvSNDiUp
 bk11wvVMXAbPQRms5g/0jxcwK1okG6Hr2UXbikX5zbOT97V/VBiCfDZrGInfHFq0NVFFvAAMHKo
 xe82EggpYbIgghkU/yi
X-Authority-Info: v=2.4 cv=fqjRpV4f c=1 sm=1 tr=0 ts=6968723f
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iW0rYzIOeSeTUJq9hTUA:9
X-Proofpoint-GUID: SpPyU6nD1BqH8b87tf6h7ItkgbzEn3M0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_01,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 malwarescore=0 clxscore=1030 mlxscore=0 spamscore=0
 mlxlogscore=655 adultscore=0 bulkscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601150029
X-JNJ: AAAAAAABmsTDjx9uurwp8yal/tPlGMx/rrnEzG2ukqTWQ/Xc/wJvDcOPESvhI1Gb2Jq9jw4nA1hHIsIh7vTylUiAdNABYEyXsWrcctIXhgMEsN0gsAPNHqQYRG1K+gLQU33L79DZjzE1E9zfnC3dDaXIlSmqMA/19sVmPa+1rpkpaQ/B2POiD24f1+GgI5kS2BzwHdr35ub0+rE58aueR2kBYKU72m0UZk9iGefzdsDd+GV0bPX5ydLFmvnwECJAWck38tsFDYmu7Og4Aou2kwQnqf16F9qX0vnhuSY4MSjq1giHO1Il9C2DuBUtIeUBz5szLFQGA2wNoZNWK1GEQDbbUpdEEBqv24ArtOGjJ/n6KctUpyHoqcLCvXX8wSYdHBNkCCD68ANwylFHqxTXVKsYxfMWMYfiudsjawHfpuw3miMKcODm7Pohj+am3eGyL2pdG5FmdNHuKBeVAXmxs7yxw4lz9F2HDpgBvSiHORXXnmy+F9zR9X6c5ih0VXHLi2quBEKU3uxIx18fTx9zTlD/XMr8hZakNOMwkkSKtYG7UNQQK3qJu6qxt0anRxjSR/CipxUU3fWako1enhEpSQm5nAT2MusmeO30mha5Bbap2AT+sOtNtSaI42GkhBkqQTZa6VrrbfvI95VuhT2eAT5kL/y4yYOXV0j+8EYt31z2ZwP26RMvM/hycwejg04o
Received-SPF: pass client-ip=57.103.74.17;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/arm/hvf/hvf.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index de40a866e0..f9e9f7cce0 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -921,6 +921,22 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
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
+        }
+        os_release(cfg);
+    }
 
 cleanup:
     os_release(config);
-- 
2.50.1 (Apple Git-155)


