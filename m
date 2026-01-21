Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34918C4453A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 14:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viYjo-0000K8-4m; Wed, 21 Jan 2026 08:59:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYjM-0008W0-ON
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:58:50 -0500
Received: from p-west3-cluster6-host7-snip4-5.eps.apple.com ([57.103.75.48]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYjL-0007Jm-6p
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:58:44 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-3 (Postfix) with ESMTPS id
 D87BF180104E; Wed, 21 Jan 2026 13:58:39 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769003922; x=1771595922;
 bh=+zWOPbxWDtHSavbbA10eiU29UuEooZpNTWoNrlVi+54=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=X7qaJ1EnckcVGzyC3q25uf8POdFto2fRoy02PNzn4QIYHPxzWJA2wGLsMyt/8cU0bqF4tGqgT6cKQiuJw6yMQ6TIbh4qb1ncIryjPrnH7tQPtEHd++RolJADWHo+DYmu9GxYRLpRdU17D+RMCyojrXGcV7f/WhdUM1thetsOLZr3nyvFmwE3s7+L1d5IumDQjtbuQ+yyHpsYjL2yJZSgFWS6Eu1LcCu7nNwi/jWu4tIyMWTi5QtHYAU1sFeUjBEf+GRvd1X3gUoBaiROLa5Cq0O5nocYQke8UiweC0O4qb84EQON5+2F+LlEDi8rPYCdZBaG/12vkkhzXHQbliIgmA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-3 (Postfix) with ESMTPSA id
 464911801060; Wed, 21 Jan 2026 13:58:37 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v8 08/11] target/arm: hvf: instantiate GIC early
Date: Wed, 21 Jan 2026 14:58:13 +0100
Message-ID: <20260121135816.21258-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121135816.21258-1-mohamed@unpredictable.fr>
References: <20260121135816.21258-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDExOCBTYWx0ZWRfX23x/tIszvm+y
 IRlvYzVREgGDBVXbqetNMUnavN5xvBCJmrGNnYSQ3noX9wqq3YEMCBKK4U5uyELakrYmYYCuUzQ
 JuX5aY53o2DtjK9mmFvAauuQ5Y0pQHlECcie8dAvU1kR/YztRYZ//jhnSeVDOIUzrWeMo7W67TI
 7c7lmpu5RvSK+zimr0iffrcrvaH/py4OGRSFXgypPLkdhmwJWNwhP3Xq0DAXvfDF9nPpM8Hkgv1
 yuI5i/bxdBuDIJIO5QyrLn+DOHyTgmA9aUJTcOxhNq4VFTj2oDEPQk+6twA8tpn0F7FnLAT/TBm
 0ocaXuZ7DK1E6yMfdkv9wFgbsMhNU3Cl7Dec/Tq1z39eKI9UQUdjYoc+X9r9uQ=
X-Proofpoint-ORIG-GUID: m5kMwJpQS8O6UEeMlwDiK-Sv_7Xod2MP
X-Authority-Info-Out: v=2.4 cv=Y/X1cxeN c=1 sm=1 tr=0 ts=6970db91
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iW0rYzIOeSeTUJq9hTUA:9
X-Proofpoint-GUID: m5kMwJpQS8O6UEeMlwDiK-Sv_7Xod2MP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 clxscore=1030 spamscore=0 suspectscore=0
 mlxlogscore=657
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601080000
 definitions=main-2601210118
X-JNJ: AAAAAAABER0xa0Qbn2x50mqeeWhuYm04vssrhiihZJy2l1qZDUvee+JhoeblgY2zVnZBP7ffhhan+ABx1DFPHjDexEBJwthyYPdo9Rrrpx2tcDknUxHGrq5PEed9IxPsfgggqABGjHwsrIZ9CxJdlSQ7VoOoVIf2nSe4YIyiKD2XJs9cM4X1AMlbM2QP5COZmbQJOaGV+NBmX1CVz740yvZ3RUDawEYet63IXLc+dhK6iV5DgUGpnp4DisFinjOSZ3SZHdhx7rykkHqIUSchrNhqsPyead864XCbPzLYRA4KbkCFWi6276dC328ISRgklG0ELB/VixfLGrmY3XZ5HxZUPMqInmPJ/s8XfeAoqcT4Fx7Ihfa+ZTLaqU1atkduowvlpzpyA4WE4aix1cr9WyeaCY2LxE5B38h2XFDPFAOqeuFewtG76W/Zn2/G1lKoTzFfAwP6muePaEhTBk1X99AuSE7+Khf3lnexHTixQiUxEK6OT6jM11sGPYwa2OHIae1p7XJeHnfyFuqrZJgcHC0xx7g3z0FGafegjaXILhGVntbLTAjbcISsDnvQ3jn6574FSjfqhskF0+/IOMC+Ahm7cbfZ1dHszco+EBbodpBrZ8P2QhGNtF9prpc2qgN4vnxQ2n0qcZATuuMlLpPCjcMXaxi3ouHaPhNMR4J+7J0wb5NExE3iv6CD67uME3Yzd1A1
Received-SPF: pass client-ip=57.103.75.48;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

While figuring out a better spot for it, put it in hv_arch_vm_create().

After hv_vcpu_create is documented as too late, and deferring
vCPU initialization isn't enough either.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 0d46073fd2..0e7b8f3431 100644
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


