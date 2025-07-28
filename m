Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D313C87FCE
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 06:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugGtD-00012P-Ud; Mon, 28 Jul 2025 01:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugGrd-0007Kf-49
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 01:57:40 -0400
Received: from p-east3-cluster2-host5-snip4-10.eps.apple.com ([57.103.87.181]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugGra-0007G9-C6
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 01:57:32 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPS id
 9AFED180010B; Mon, 28 Jul 2025 05:57:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=m5yjYmCYNH90EJVxeL8leflY4NUxU/PF6QRQfToy6ZU=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=GtVP/Hn4a3gb6NrP0/AUyXlE2uHvlMBVSVcOCkMTO2B1SX7Lp956zswwrlIKukImYASULWU5Tz7EwE3E9OH5TEVTFOV3JTjWIjzuoqmcj3I2V/5zY2VOq3+7NZ9rtvUJM541tPAQ8Axqx9hJFT1e38pfop3b6aqo6KJgHddbwzVeKkOPLev6N+GmvEZKM5imBHYuMGvUjBHFX6qFZGVKKyt2DtnCD658y+6vQT/mgGFsXoHwH91uR3mZr5u8M7r6agFJ9y7KyaYJtevqtzxecOtcg9Njco3MaBVrBMFO+uaECn3fOwfAp9QUpbLd852uyn0fYGGiBTAKM0UIWmSw8Q==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPSA id
 84A16180014D; Mon, 28 Jul 2025 05:57:26 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v4 12/15] target/arm: hvf: when the platform irqchip is used,
 abort on writes to the ptimer
Date: Mon, 28 Jul 2025 07:56:58 +0200
Message-Id: <20250728055701.38975-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250728055701.38975-1-mohamed@unpredictable.fr>
References: <20250728055701.38975-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: G-F_arxhLC5Km0J3S-uywZB-6_5rMWji
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA0MyBTYWx0ZWRfX6ZeKXeNqQPUP
 s0yUTurt/QKIuH+ZZPAio1Pxp5yyqsZMTm6Eh9npUAAZQV2KnKgwdVq5M+7i04/ri0sLgIUUElu
 srGygeK0XJO/3MpCbm8M7qpV2S43dWTd7hzafXe2HaztV4PBxd742hc2TN9WW5ib9Pw2PpCJmmx
 ddTNivNjTc+kVC8qPKFwjc7sIdSOKX6vjlcEAIewd/VM8wxeVd3ZO/wyThjm/+pqrhfCWnZvK2R
 S0I4/NbLkFGlnAuR+iSppBAKe230qgABkwA5sSa0MlkB29VTZnBxQze746fRDu2QqvTuCLgRU=
X-Proofpoint-ORIG-GUID: G-F_arxhLC5Km0J3S-uywZB-6_5rMWji
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 bulkscore=0 mlxscore=0 mlxlogscore=584 spamscore=0 suspectscore=0
 phishscore=0 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507280043
Received-SPF: pass client-ip=57.103.87.181;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

In that case, this code path should never be triggerable as timer emulation is handled by the platform.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index afe09a216e..64cca9aa18 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1401,9 +1401,15 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
         assert_hvf_ok(hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTHCTL_EL2, val));
         return 0;
     case SYSREG_CNTP_CTL_EL0:
+        if (hvf_irqchip_in_kernel()) {
+            abort();
+        }
         qemu_log_mask(LOG_UNIMP, "Unsupported read from CNTP_CTL_EL0\n");
         return 0;
     case SYSREG_CNTP_CVAL_EL0:
+        if (hvf_irqchip_in_kernel()) {
+            abort();
+        }
         qemu_log_mask(LOG_UNIMP, "Unsupported read from CNTP_CVAL_EL0\n");
         return 0;
     case SYSREG_MDCCINT_EL1:
@@ -1720,6 +1726,9 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
         env->cp15.oslsr_el1 = val & 1;
         return 0;
     case SYSREG_CNTP_CTL_EL0:
+        if (hvf_irqchip_in_kernel()) {
+            abort();
+        }
         /*
          * Guests should not rely on the physical counter, but macOS emits
          * disable writes to it. Let it do so, but ignore the requests.
@@ -1727,6 +1736,9 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
         qemu_log_mask(LOG_UNIMP, "Unsupported write to CNTP_CTL_EL0\n");
         return 0;
     case SYSREG_CNTP_CVAL_EL0:
+        if (hvf_irqchip_in_kernel()) {
+            abort();
+        }
         qemu_log_mask(LOG_UNIMP, "Unsupported write to CNTP_CVAL_EL0\n");
         return 0;
     case SYSREG_OSDLR_EL1:
-- 
2.39.5 (Apple Git-154)


