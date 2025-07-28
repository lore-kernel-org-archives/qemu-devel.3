Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A130C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 06:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugGtI-00018k-7h; Mon, 28 Jul 2025 01:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugGrZ-0007J9-LK
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 01:57:30 -0400
Received: from p-east3-cluster6-host2-snip4-3.eps.apple.com ([57.103.85.144]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugGrX-0007FO-LF
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 01:57:29 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPS id
 9D02B1800150; Mon, 28 Jul 2025 05:57:23 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=UIKXY0OqrEJuez3FKmGasWYdj1FQIGCZkH6aUeSzLCA=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=Z64tlAby16YhfaiVy+Ysc+/iy8Nty/W7emt0bdtR+sYdD3ewMMUZr/IhclkYqe29xHcSUG8UEYdKg8t3bbk7Dlp21HPgI85O02l5aEaJ/QCgXkWbn1/oK9RDTkHEyAG923+NUxhCLilm/VssqoF7gfh5gl3WG69mtxYrLuQxCyaI/jW+8PBG72gBMAIQAasj82dXnmJZ3TSCbsPW9LjoP7WnD2Cr/omeMB01fpM2K8H2TzCZapVpqPk7D/0CkV/XQ/tb16Jg+15Tz4NA2k5ZxP0qRGrkUX8G/XZqjX/ajl6Ahz3qw/gM+KkO586pT1W2BdDLTHNHiQchpucSOon4bw==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPSA id
 18F301800135; Mon, 28 Jul 2025 05:57:21 +0000 (UTC)
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
Subject: [PATCH v4 09/15] target/arm: hvf: use LOG_UNIMP for
 CNTP_CVAL_EL0/SYSREG_CNTP_CTL_EL0
Date: Mon, 28 Jul 2025 07:56:55 +0200
Message-Id: <20250728055701.38975-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250728055701.38975-1-mohamed@unpredictable.fr>
References: <20250728055701.38975-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7AWGEd_kSgvYu7mHfxrrph9dNdbn2vvq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA0MyBTYWx0ZWRfX07q5cpUqu9bp
 3uvHUx+ZJf976VXZ9oZVB/bc2RtQFWsUlP6xD9ZuecwaWEbDJgYb8thaIaHwRyBFDr08RNB9sbK
 vMtJeBtPtzX6MROshVuaP7AZoP4Lnqn9ZI0SRVWgiW+jUhOAc/32yIFfl22N1CtaB/FvBL4pIoM
 dCSm3zvJgHz1H9pRiJu8ELKPpInXFqVCvWaGpg0L2DTwqCDmk4JNnEnsbC0zRdNrJi77WjUhb6k
 pDIHVEak3yfyMvFtAs0j1xlKuGDQgBfe4nr4pzmDdvAzDoPr46GOTQYOKbPoiCkZ/CharEvMg=
X-Proofpoint-GUID: 7AWGEd_kSgvYu7mHfxrrph9dNdbn2vvq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=617 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1030 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507280043
Received-SPF: pass client-ip=57.103.85.144;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
index 63b7967053..f17fb0695a 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -300,6 +300,7 @@ void hvf_arm_init_debug(void)
 /* EL2 registers */
 #define SYSREG_CNTHCTL_EL2    SYSREG(3, 4, 14, 1, 0)
 #define SYSREG_MDCCINT_EL1    SYSREG(2, 0, 0, 2, 0)
+#define SYSREG_CNTP_CVAL_EL0   SYSREG(3, 3, 14, 2, 2)
 
 #define WFX_IS_WFE (1 << 0)
 
@@ -1399,6 +1400,12 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
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
@@ -1719,6 +1726,9 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
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


