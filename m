Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2047C83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 08:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufEDq-0007Y1-6E; Fri, 25 Jul 2025 04:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufEDj-0007Ob-SD
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 04:56:04 -0400
Received: from p-west3-cluster2-host6-snip4-1.eps.apple.com ([57.103.74.54]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufEDg-0001rb-Tj
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 04:56:02 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-0 (Postfix) with ESMTPS id
 E315018000AA; Fri, 25 Jul 2025 08:55:54 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=VT+vLkQ2OgLpMtVF9hAuKVaGzZdWuCg5ciEij+c5zzI=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=f2ijtylkjuIVBTZJz8boFStCQDRG3MnmwM94cxDVsfdRdlIQ9QVbhWXryE66Fx4OuT+rbGIONgm9049yYgyC23r6/rBXXPPEw05lauLzGnscoVnlAUeXrO/ueTdxL1B24nBziYSR+nlGJmQhtd8fYHiLfi9oxutGvLgSe5Pcy2/wCuCQ3aBpxxsM4Fv4nvvWz5cPWPse+Mr85QqBD3vcxJ3yKBN3DHMc2nNzJh0JVZU9jkc/mxEiEl4gu+KCGP7umqbGiEaCfXSxIzjROozC9hoDQSo1WTRi4aLaC/AzS0O64KiEvooBnsV0XZ6f10rLutaHVFET0lBz/RhLmzscMQ==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (ms-asmtp-me-k8s.p00.prod.me.com
 [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-0 (Postfix) with ESMTPSA id
 2B5F41800209; Fri, 25 Jul 2025 08:55:50 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 1/9] target/arm: hvf: stubbing writes to LORC_EL1
Date: Fri, 25 Jul 2025 10:55:37 +0200
Message-Id: <20250725085545.93619-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250725085545.93619-1-mohamed@unpredictable.fr>
References: <20250725085545.93619-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bi8nbXj5c4zJsPIftg5GQsrkiBqckjcD
X-Proofpoint-ORIG-GUID: bi8nbXj5c4zJsPIftg5GQsrkiBqckjcD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA3NSBTYWx0ZWRfX9yLiFrBknFJZ
 1HsusMa2ogBx4zx+I8y5OC86LbQ4OyadXU1cJLXnsfrb8lfx7VnKWHV/lIkOMv3BAHmcdSRCCzd
 zi1XgWnfNDsKKB7iziaS5W386goq0IuQCJyHOy3oTkbOdsJIHSKyamy5GLOG90Oi+Lokwai17XG
 9+o65UsP6NNM+SErswQ6vsmL7UiKImdzTgE3P1twaGGZYpMVfLfQ/BKMNMIzjpAMR+uJhmnGBDs
 ZZ6dwvej+HO5Gd/gft2ifm88I3kADBLnIyW8/KDlntUQjSJqx6FGLsWYJn4Fs+MRFd/aQ37ho=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=797 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0
 clxscore=1030 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507250075
Received-SPF: pass client-ip=57.103.74.54;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


