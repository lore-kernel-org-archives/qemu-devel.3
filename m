Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315D3C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 22:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufQyI-0007Rk-NV; Fri, 25 Jul 2025 18:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufQx0-0006ft-3s
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 18:31:39 -0400
Received: from p-east3-cluster3-host1-snip4-10.eps.apple.com ([57.103.86.13]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufQwd-0003nL-9b
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 18:31:23 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 17D8E18000B8; Fri, 25 Jul 2025 22:30:55 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=sTkhAREw5qzfUMDqzzGfU9wJ1Et+5aYd4xmkFKWmcl8=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=GzqeUNdBagpxwqDnymQT4vZZWi1upqyvoOmpyJS+kqARrBdKBU1A1pkxI3Nk0EtzYzweKNYdMzSkB3QeTbURs8G2yMlX3Di17B44tp+AvdOsu8XxOvVhReqhJvEftVkbN9ky3LMwxo5x0u7C+JHqjgruYJtCz6iuclsWMpIAatIOAVd1mh91aTlJSGhM7u+BviGeVcUre7Nwbpz+vfM6GEdhGjxEywZhmnNsYVYKy739Q2CEMFaQ0a+Oj4bd1WTGlCBw3w2z6r0NKGxa/T7ikg0pfkeCz0JpgudY0uhxzhUu5G/yOZhj8wlbaBSQH0CL0FZ5XNshWjO7/Z7oZBQ8sQ==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 19F0F180015E; Fri, 25 Jul 2025 22:30:53 +0000 (UTC)
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
Subject: [PATCH v3 8/9] target/arm: hvf: use LOG_UNIMP for
 CNTP_CVAL_EL0/SYSREG_CNTP_CTL_EL0
Date: Sat, 26 Jul 2025 00:30:34 +0200
Message-Id: <20250725223035.52284-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250725223035.52284-1-mohamed@unpredictable.fr>
References: <20250725223035.52284-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Y3Nwe5gY6Y-EMt-2ujlJ2JI8Qi5WF2fL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDE5NSBTYWx0ZWRfX2u5tg4EbuCmw
 5haT47H/nH0JuMCSFAw8UgbKMVV5XitHC5f1UmuKlP4iJZLdIxshkmMQYTBjIMNYzfznxPogGG3
 PapFfs28q/F2ArQAFi4XoapOL5xI8yn1HkePptCjPog790tBdhQp2PFJQiJN90RRxJ0dWj+kmTX
 cKg6l4Ypxxz9kbCzazzKzWB1dK2ERJvgrWfZEAh7ep40f6MRty17/kTKjJMemJhQrVRncXzKixk
 uZ+qYTE+zLVhBfzD93JNJM1B/h1YWKujqTb5s2dlSs77qgZJU9wD4MuYHg/RlKOsi6jAKQxgY=
X-Proofpoint-GUID: Y3Nwe5gY6Y-EMt-2ujlJ2JI8Qi5WF2fL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_06,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 mlxlogscore=618 mlxscore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507250195
Received-SPF: pass client-ip=57.103.86.13;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Instead of considering reads there to be fatal, mark it as unimplemented.

This is to allow experimentation on using configurations other than the Apple vGIC.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index f5b82cdce1..c3df7e07e8 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -299,6 +299,7 @@ void hvf_arm_init_debug(void)
 /* EL2 registers */
 #define SYSREG_CNTHCTL_EL2    SYSREG(3, 4, 14, 1, 0)
 #define SYSREG_MDCCINT_EL1    SYSREG(2, 0, 0, 2, 0)
+#define SYSREG_CNTP_CVAL_EL0   SYSREG(3, 3, 14, 2, 2)
 
 #define WFX_IS_WFE (1 << 0)
 
@@ -1398,6 +1399,12 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_CNTHCTL_EL2:
         assert_hvf_ok(hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTHCTL_EL2, val));
         return 0;
+    case SYSREG_CNTP_CTL_EL0:
+        qemu_log_mask(LOG_UNIMP, "Unsupported read from CNTP_CTL_EL0\n");
+        return 0;
+    case SYSREG_CNTP_CVAL_EL0:
+        qemu_log_mask(LOG_UNIMP, "Unsupported read from CNTP_CVAL_EL0\n");
+        return 0;
     case SYSREG_MDCCINT_EL1:
         assert_hvf_ok(hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_MDCCINT_EL1, val));
         return 0;
@@ -1718,6 +1725,9 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
          */
         qemu_log_mask(LOG_UNIMP, "Unsupported write to CNTP_CTL_EL0\n");
         return 0;
+    case SYSREG_CNTP_CVAL_EL0:
+        qemu_log_mask(LOG_UNIMP, "Unsupported write to CNTP_CVAL_EL0\n");
+        return 0;
     case SYSREG_OSDLR_EL1:
         /* Dummy register */
         return 0;
-- 
2.39.5 (Apple Git-154)


