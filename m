Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DCAC83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 08:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufDtL-0005hI-HH; Fri, 25 Jul 2025 04:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufDtI-0005az-Il
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 04:34:56 -0400
Received: from p-west3-cluster2-host5-snip4-10.eps.apple.com ([57.103.74.53]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufDtA-0003MQ-Uk
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 04:34:56 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-2 (Postfix) with ESMTPS id
 EAAAB1800165; Fri, 25 Jul 2025 08:34:42 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=VT+vLkQ2OgLpMtVF9hAuKVaGzZdWuCg5ciEij+c5zzI=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=IJkeCS/yOcYNETpjRlXyZHVXK3qcwcE9MpiSLH7tyow1mQ5yb1EMfOxkaXpKcfq8AEsw0EobuzBt/QSJ4eflU0UgrMPtgyRZ47gKKFJreTesnFEqGNbJMrCnIzcCUY5SRhPOMM4fdYTFlzYeUoarWDkm8RGHxd22+T0JXLt68gW/QJDpIFQZ74Vhpcui97hCRlLFhFIhT0KR3FAn+BCK4SqSzKYh6XAzysVJ9iBxaSvLh60lK49fyr0h89l01rsn02N12F9d50bl5MhsoaP8i98Z3hmdjSBPIDbDyC0tpOe2acTjfBvYZrsELyxAVkJn39rMRETxlQZFvS5IJ03niQ==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (ms-asmtp-me-k8s.p00.prod.me.com
 [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-2 (Postfix) with ESMTPSA id
 B96021800169; Fri, 25 Jul 2025 08:34:39 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Alexander Graf <agraf@csgraf.de>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH 1/9] target/arm: hvf: stubbing writes to LORC_EL1
Date: Fri, 25 Jul 2025 10:34:23 +0200
Message-Id: <20250725083431.91450-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250725083431.91450-1-mohamed@unpredictable.fr>
References: <20250725083431.91450-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XmQdcGJSVoAMdW7_oSrX6Rmv_lomlkwY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA3MiBTYWx0ZWRfX2kkuU9/+3NA1
 yb1kctes5alDjHn6EqEMBl2zTdj20x4GFWAznefvdRXW0G2CSZ7gy8hCc7O5P5StPSjqgOdoqpL
 xJKC1cuxKH0rpyakod1/l2l7I1ApL1ConPNP8MUxzvS8cj6yyeAyAZGQhtUwvbIgcUTSQ87fAE0
 XmD9gF0G0rPfTgXM8NS4iCkMR6gHsmNqwvc3D5rNfiwThRupTJSbEbGcpy0e73XHmYU+WBUL7R3
 RsfHd75BfUBhmihaCFCN3eqWIFMDgCqnlDxE00rMlIbVMFRI1vha3EoKCtvr9R7lOe9x8OvWM=
X-Proofpoint-ORIG-GUID: XmQdcGJSVoAMdW7_oSrX6Rmv_lomlkwY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 clxscore=1030 suspectscore=0 spamscore=0 mlxlogscore=797
 adultscore=0 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507250072
Received-SPF: pass client-ip=57.103.74.53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Linux zeroes LORC_EL1 on boot at EL2, without further interaction with FEAT_LOR afterwards.

Stub out LORC_EL1 accesses as FEAT_LOR is a mandatory extension on Armv8.1+.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index c9cfcdc08b..edfd29de75 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -186,6 +186,7 @@ void hvf_arm_init_debug(void)
 #define SYSREG_OSLAR_EL1      SYSREG(2, 0, 1, 0, 4)
 #define SYSREG_OSLSR_EL1      SYSREG(2, 0, 1, 1, 4)
 #define SYSREG_OSDLR_EL1      SYSREG(2, 0, 1, 3, 4)
+#define SYSREG_LORC_EL1       SYSREG(3, 0, 10, 4, 3)
 #define SYSREG_CNTPCT_EL0     SYSREG(3, 3, 14, 0, 1)
 #define SYSREG_CNTP_CTL_EL0   SYSREG(3, 3, 14, 2, 1)
 #define SYSREG_PMCR_EL0       SYSREG(3, 3, 9, 12, 0)
@@ -1650,6 +1651,9 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_OSDLR_EL1:
         /* Dummy register */
         return 0;
+    case SYSREG_LORC_EL1:
+        /* Dummy register */
+        return 0;
     case SYSREG_ICC_AP0R0_EL1:
     case SYSREG_ICC_AP0R1_EL1:
     case SYSREG_ICC_AP0R2_EL1:
-- 
2.39.5 (Apple Git-154)


