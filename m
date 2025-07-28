Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F60BC87FCE
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 06:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugGst-0000Q9-5t; Mon, 28 Jul 2025 01:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugGrN-0007C6-Gm
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 01:57:17 -0400
Received: from p-east3-cluster6-host1-snip4-4.eps.apple.com ([57.103.85.135]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugGrK-0007Bs-9q
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 01:57:17 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPS id
 211EC180012F; Mon, 28 Jul 2025 05:57:12 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=HezpjLM2oi9haxQ0U3B8WellGbsu/AWM4D3KpVu2U/E=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=WuLc3+quiMv1mxDFSFw72ZhrybhaX4Z8kb42hcMHRr2Uui8lObILTBgwqjrcxJItx7UaMHlbqdHaf+OlurBq2aITmp/Gjw3guBb5M6TMPhas6ZOPxCFSCzqh2rgsCi6SHws4chdo0hq3ZRbYI78TcnRXH9sMIwDRbe43wk5wdnw/GLdlYBh6TvXlRWsELqsrct+UfH5ix9ydA8O2hIwpa/sEYnEMs4BLr1EUCy+ahpd9DGgcxldjBI0VQ2fbgTHDyUSiGcTZlnHRv4VyZT/2JgLPiuPCmdJxbbb0HTTgVbdY6m8d0Rp35RRyAEzM15WhzjL5lfvopMIF8WZfqXyOSg==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPSA id
 1EAB218000B0; Mon, 28 Jul 2025 05:57:10 +0000 (UTC)
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
Subject: [PATCH v4 03/15] target/arm: hvf: add asserts for code paths not
 leveraged when using the vGIC
Date: Mon, 28 Jul 2025 07:56:49 +0200
Message-Id: <20250728055701.38975-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250728055701.38975-1-mohamed@unpredictable.fr>
References: <20250728055701.38975-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA0MyBTYWx0ZWRfX0cIN9ajzFdPl
 VkA01/5hKeVtgjtyUHa5ouCWR9XHWRriNUNAHfX82gjKOujo+f30D16E1uf7Kj5ppVDCG5phXs8
 l9LZQ1AyU6utUYxBKgGEtSREvzDHbJDxldSGlj3tNU5/Pod8fg6VHsvVR7nZCb2xAJJdgHKVcLs
 vz2HCCkmKZY/cvZ+DPnxHZd9/svq14d6+cp9oELTIT3MVHz9wR97V4Iy+qBBndVM4CXQbN4k8Hd
 /wJ4cPAm3Tobt2vz5qX526ZT8wXPhIfqZsEGOzp6jFjrjAe7755DZ7PVMp+nqrJdw5wXIkpKI=
X-Proofpoint-ORIG-GUID: GdMFnko3xMRG9On8d_xqRPmUrFljSfjf
X-Proofpoint-GUID: GdMFnko3xMRG9On8d_xqRPmUrFljSfjf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 clxscore=1030 bulkscore=0 adultscore=0 mlxlogscore=610 suspectscore=0
 spamscore=0 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507280043
Received-SPF: pass client-ip=57.103.85.135;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

When using the vGIC, timers are directly handled by the platform.
No vmexits ought to happen in that case. Abort if reaching those code paths.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 3ba74b8daa..7beb47caad 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1382,6 +1382,9 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
     case SYSREG_ICC_CTLR_EL1:
+        if (hvf_irqchip_in_kernel()) {
+            abort();
+        }
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_read_cp(cpu, reg, val)) {
             return 0;
@@ -1702,6 +1705,9 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_ICC_SGI0R_EL1:
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
+        if (hvf_irqchip_in_kernel()) {
+            abort();
+        }
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_write_cp(cpu, reg, val)) {
             return 0;
@@ -1965,6 +1971,10 @@ int hvf_vcpu_exec(CPUState *cpu)
         /* This is the main one, handle below. */
         break;
     case HV_EXIT_REASON_VTIMER_ACTIVATED:
+        /* This is only for when a user-mode irqchip is used. */
+        if (hvf_irqchip_in_kernel()) {
+            assert("vtimer activated vmexit when using platform GIC");
+        }
         qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
         cpu->accel->vtimer_masked = true;
         return 0;
-- 
2.39.5 (Apple Git-154)


