Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D78FC9EDE
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 09:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vync8-0006gN-9d; Sat, 07 Mar 2026 04:06:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vync4-0006ed-P8
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 04:06:20 -0500
Received: from qs-2007i-snip4-2.eps.apple.com ([57.103.84.213]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vync2-0000xl-SR
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 04:06:20 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPS id
 0F0E91800120; Sat,  7 Mar 2026 09:06:16 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772874378; x=1775466378;
 bh=eJB3IuLEqPjgyixFo7qaEcwJGAeuNrjFWqtH2jy/vaQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=LYgVxa62QMDmUQbu461kRtCiXgkRIFf+YWuEKffRltE0dS4jlXLgGBoYjeJuCZ5W2oS/JAqo/Ff5iPsJnU7E7wOBqdtyjkyXoAELStpAgCP4cNQ2IRuW4QYxnURC1jkF2Ddx6VustGwd19QEMSBbA5ejnffUjQNBoQXnhOStr7HWHu32UUL8tPkOasntStXkhd1DPKq6TFEbKyhBIyZJa/4y8LPmtEkBhPxxCoxTZlYVxfic/EyTJAzlm31VtaC6nEodHKtlwALnTd6NSn4GIU/b8IOu1m1RgxFiiPdCmAidHhOb1uW08YHztlQQYtRhmRdaQ0EbFtQ7KrplKcgmuQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPSA id
 5E8981800132; Sat,  7 Mar 2026 09:06:15 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v17 04/14] target/arm: hvf: instantiate GIC early
Date: Sat,  7 Mar 2026 10:05:56 +0100
Message-ID: <20260307090606.95300-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307090606.95300-1-mohamed@unpredictable.fr>
References: <20260307090606.95300-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 877EMMDnfl_sTIgTcyuEQAnw5UgJY6Nb
X-Proofpoint-GUID: 877EMMDnfl_sTIgTcyuEQAnw5UgJY6Nb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDA4MyBTYWx0ZWRfX8IDewjCO79+z
 BLk+Fb46brawpXhz7QEJsj8azGL2el5Ek+n7q3484wtr9LBkz1gXb+v/d9eZ8Upp4XG4Mp07vwZ
 xQjo9nP6T9qyVTrTRTOoURdkF7cTRswbiDp4Tw3sVQnpMfEJ0hfdC6it5gFfgxLMHoCRorCUzcQ
 /Trf8PUnf1aKN1cXrPoyIoYz975cyp5VcW/8EqNUR5BmciY5pQVxw4ZU/P98q0R9jU38sGpCVNG
 +bARJ8JDlxelffHh1keq7bEMQpZjHH/ElvmWJ6zh40ambmXCOawnHD8WMIW2jdBvWIDpXLny7sJ
 vR6Auxvbh6RaUiv1jb5PPPsYupi27sxcU0FhKzqVErgW1M0plhrKpOTSFhtiOQ=
X-Authority-Info-Out: v=2.4 cv=DMeCIiNb c=1 sm=1 tr=0 ts=69abea89
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gV1jYa02L3q0mTRDDQ4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 spamscore=0 mlxlogscore=618 phishscore=0 bulkscore=0 clxscore=1030
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2603070083
X-JNJ: AAAAAAAB2jTt/VcY7BJ8gQhRW4d+bh6IsKsEi7q7IWEBjMJiIdvMm/DlG6NFC4nMBpLY7PF1GRzYq6Pg9cUtHEeBItGsoztEqgIXWy01YbnhqS+bAsDnpWkS7zRBtIj9nM19mzIuMZzgzhqH5JEGJe0Rr4uB9WfwU0NIhH/ZG31gN5fWnx4ONmXVLs2C5fc54SOpOo/5pd9N9oQOeG3PT+kuvhnzpTJx/y1hGURGybqG+mFahI/KrETXutw+3lrvFirRODCFbi+QpRf5Y3/SDMMPVBb91nZDatkYjaHmvanx0ww372pyucOvZv8XSDMF2nC+JF4GdWlK64mO7gTmuVU1iObfJRKNPelXN+pRHqliDmBADMqvHNluKmat+AL8pW4HxPtHw2K3OMsOXTNPqkda8d8phefvfeSUQBb9IWCsmEDMWnKdH9NA0Ij/CoaKKo+lXJFRtizXtxtofeXjiHUTEbmg1fWKJMn0arb90aANH5ptKmJKRa+nOA4otQLG+13bj0LP5kb+wAWvuxFo9m1BhBQN8cPtFThfmd73MqyJnZPXUGC49EdCe/a2LkYKx1iDaAFXMzqRziARZ5gwC9BO5cfrtnRyTVIn7CtXKs+bdtNO08bvMHfDdOiF3h/p1mqjCabnjGaLRSAdKokQfM/ceob7HVxsgCaeI/Vq2sbthze2pSR/lJGLa0pDUl6hfIhXRy9TDoI3pcWBMhNWTt960tjYzWv497xfx9RowX1g6OOXGh4VlJYu
Received-SPF: pass client-ip=57.103.84.213;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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
 target/arm/hvf/hvf.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5fc8f6bbbd..22d476cda9 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1230,6 +1230,28 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
     chosen_ipa_bit_size = pa_range;
 
     ret = hv_vm_create(config);
+    if (hvf_irqchip_in_kernel()) {
+        if (__builtin_available(macOS 15.0, *)) {
+            /*
+            * Instantiate GIC.
+            * This must be done prior to the creation of any vCPU
+            * but past hv_vm_create()
+            */
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


