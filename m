Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5603FD0040
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 22:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwSUY-0002S7-0l; Sat, 28 Feb 2026 17:08:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwSUV-0002QL-C7
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 17:08:51 -0500
Received: from qs-2004f-snip4-10.eps.apple.com ([57.103.84.62]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwSUT-0005mD-5L
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 17:08:51 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPS id
 9EDA6180012B; Sat, 28 Feb 2026 22:08:47 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772316528; x=1774908528;
 bh=jEliWNbG5rK2neC0IONI5zdAOP0QxrLReQSeKNzFrQA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=IVLuC4tMT5w+c6O8mYRvN1g4hB2bheB2bi4LcLsjgRxFuKbQQEeRqayyRTy8pdXX0nvGrrBvtsi4QmdipSpjPJBx4RIpP+QnSF8OTJMk/D83fSrcwnsSKAQN7aBBhSmbBtv7SYSvDgGynElnn2bvr2gOhfmfEuRN5j1xhyPKUYInJG39hoFDoB1GYz1ANVqXWV10R2CfmAQi6LO1mFET8FTsPA981q7XPm7OZAdCuc1rfU/Lp7UFPzOL1GEXUsTQQadluZcz8WdxjYZ8SIUcvT0LyIcQ6LwQFwct551gU0U3d/mbq0qHlw4cBjSrMZUkW+GVnJw7DY9xh2rVJk2ZxA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPSA id
 ECFD01800396; Sat, 28 Feb 2026 22:08:45 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v11 04/12] target/arm: hvf: instantiate GIC early
Date: Sat, 28 Feb 2026 23:08:29 +0100
Message-ID: <20260228220837.35275-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260228220837.35275-1-mohamed@unpredictable.fr>
References: <20260228220837.35275-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: oTjzJtN-G1k3tv86Xg1oOdYsA-v16yc4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDIwNyBTYWx0ZWRfX1dpMKtMG8XU4
 WaFD8C9yzttyR+pEclrz8ubmzlDhb7jY3ejdNfmvxEeqMJCncBUOV035Xr7uXPUKPFlcjcUhUp8
 PCLGtFVyTe6HneGdirGtX9kCNre1y5QejrySjluDJ7thnNnmkPw9G6xMpISlAG+D6mZoZ03BPac
 m3W4qn6eq5x9sWnf5fah0kyNKQgxW/NWWgeaDPObzB187pQRazMI7cuUahKKrEU/g3ZTmp0qbL2
 F248ADkEoSskrFMYqQxb4h3XrP7r/xaSclg6+uYmzVNyiiHyx3L5Xf4zbtJXXhMobNMJ7Pzvwuk
 GPaCJLhqW5yTxeiBLPBcGhDdAkLDwSOLORWrRpDYjI+ViHr4meYDOTmYwxT4f4=
X-Authority-Info-Out: v=2.4 cv=fPw0HJae c=1 sm=1 tr=0 ts=69a3676f
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=iW0rYzIOeSeTUJq9hTUA:9
X-Proofpoint-ORIG-GUID: oTjzJtN-G1k3tv86Xg1oOdYsA-v16yc4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_07,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1030
 suspectscore=0 mlxlogscore=691 adultscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602280207
X-JNJ: AAAAAAABZZmGKhP2kCqh5aDFIL8suc/QT99FmcT90SgYXVGaeht6z8kr7Um8knO08Xkk/jNj7r1QU33/7sil8RoOLd8WRE3xhnjcYBIIyOEYlTSybFrpGtO4P22X7sqVU3cU3onQpNOJxpGuu7vnlOt5qAR9W22H5nTK3SyOmsOiIcTnSX+8546EsI1lnJSdjkWlopV51Mlwy4dXqM69R4wrBaa1Dvx5aVZnByKcAeZiu6NO++PELDZAQ/Nm8dkZP8zI8lAHciC4Nfem/59f77HE1lynz3tq/954T8XMtf6SyZQmcP62ZxhS6ExqQlRo/2qLZNKwmz5KPcx0ZUOUoF0WrH9b0EaFt2owFizDA3oepOWC2UGtV/CELZpSx/UpuxiyAfnlfKjR+PscdLprnAYp94uwjtNvhdNp4vm03MeH1Q00/Lxvc40pALAOb1uTfY0fKMPGtevF1bPkGnkFyPY3KcdXJuCfGyVyE39k6rLi1tvWlBob6QPucLnzTqzrWWs3Ts1cH3eM4xFXsOFL4ZENpKTWu+xzdeBUDny2myXSZ5w1u3BfubdKqJhTmGS/PBqnoEb2Pxar3OLTIgILG05/xodnVDMsGXvvtaJzWFiGlKbbH6CCaSh9e2KtT6YDS4QriUUR5AQncUnZKuXPM7yg1rCDqHDMD8UUUzBo9HAnBAD3DWVp1gxCBhzRnqUYO+c7Yr9PM4RD
Received-SPF: pass client-ip=57.103.84.62;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.966, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.722,
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
---
 target/arm/hvf/hvf.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index d79469ca27..a22b544afe 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -961,6 +961,22 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
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


