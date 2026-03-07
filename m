Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1597CF513F1
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytdh-0001GY-Vm; Sat, 07 Mar 2026 10:32:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytdW-0001C5-7E
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:32:14 -0500
Received: from p-west2-cluster5-host4-snip4-6.eps.apple.com ([57.103.71.99]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytdU-0000Pj-NA
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:32:13 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPS id
 1DD611800878; Sat,  7 Mar 2026 15:32:09 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772897531; x=1775489531;
 bh=sRTxu5Fw8UCuti2v1JoZDXJD4wZeEKjL5lX/8pIOKiM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=UwIpZWtKMCootBU62e8gsofC/NCDsr2EMnFLWxiwvC/jtQrNE3jMsHW+on/gW9Tb2nzCj9EXvM9FyGy8LvLlffOt26lBOfZk1iZ9R64OgbBHfCdOsQ6OSxi54FU0DPAT4HBeGx51IdjfOz6mqQNFDdmqwW+YdTYYgMCQTvtgOj+VbFk3Cr+8uMcr8boqEsbGGTG6AGlmhhkOqJuS38FXkeKVhKgkolUzZ7Ynw4m3jsyfT2C+g4sfERAR6icbO61sIAq2o0JiivYEMVoSq2MuIxlJWPrQ4kw+c1X+bq/57YOURosU+QtX9Ea9kh7fIzTh0/2NOpwcJ/gqa0ywjBbSEw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPSA id
 713C71800865; Sat,  7 Mar 2026 15:32:07 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v18 09/13] target/arm: hvf: add asserts for code paths not
 leveraged when using the vGIC
Date: Sat,  7 Mar 2026 16:31:39 +0100
Message-ID: <20260307153143.76893-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307153143.76893-1-mohamed@unpredictable.fr>
References: <20260307153143.76893-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Tv5aXZ9kopbgb10IljWS-YeLvAPgZcCJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE0NyBTYWx0ZWRfX/ngHhqCxXQE4
 jiwwQZDpc59cR7BqaBOWwzV9/56row3w/+KjmzyMZHJLwUaKNyW7Sb5DWBm6ysLfcywg2sVhAVb
 qQ6EfgysKQmimPUrKGQpqiuxUnDel6xVTyIyOb8lQZ2qvsxqEF4w8uAXi8XqmeuuItDtgiaaa0X
 enkAXc5F3wokYAj4kyavHBBTfF2KjQCsgUml1GrbovdyG0b6Lv/E6YGEq/wBsOSpI40SuX5X+aY
 3pvAAjZYnHxop+K0E9IBckGzwNe6YPl5x5E4JPbRlpZF2PYZlHbR98ks3Mk/ysTsETjNRQ6U3g2
 Igw8Jr84gW4o1oIq2/ixxGnBLRuEIdNAOQ6u3o6YUnkxXz/omhFpR+PHPFxjEw=
X-Proofpoint-ORIG-GUID: Tv5aXZ9kopbgb10IljWS-YeLvAPgZcCJ
X-Authority-Info-Out: v=2.4 cv=ArvjHe9P c=1 sm=1 tr=0 ts=69ac44fb
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=vbFX7M0ab_H1AmF9bzsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=526 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070147
X-JNJ: AAAAAAABiPqQBi3M7xzZTOHATh6gGizmQoj3fhOOOM+XPRrG+ROAOYAV4eHuUhEcLGZZ5T5ukIoGMz8yxItDH0CPl0W9U77C2rLAD3Z2gUge4NOXGHuzIf4JdNQ8S27sXPQ5Hncze6c70+83lwf636auj1G6NbNzZEavy1pXnvr7Y4gpBSYd5sdS+8qmDB877nGKGI+ru5lG3qHm9KqjmKfRYe+Nr5FhHxN3qALS2G1I+nrKuyHcf2cHmd6kbZ7nsZtdQe5d2pNPhQLLeinxgH7L+x7AKHqR5h4oUT5Dwr7dxiem+GFQTBa8A6hbkXe8hG+PYFtu41T5BqjxNJHiSMhjuaDHHtFaoSySaXW7mPVZe9EoFAai95ZUzo1tIlqwaQ0jHaFv7vTWOcUt0Cfejm0I6TDNTEOEZM8pmQOHxH+0ev3mFZIeHkRBPwWpDov23OFJ5GgBdchJdGLsS2iLSVM0J1Edl5BLlvx0Hj70nXbjNBNpdFz9OYSL542F/C5UAfNpi7OVqBo1A6LPq6pzrFLygQ+jB7j36s0OZCfOVIYQHgojsJVqdQDnUAarBqzTYGcGt+OEz/++/Fr8E6rLUd6k+RUrIa1QEOwCAjfFaYzc3tLRR/4JXR4fsPmolPsisNbWlyvlvPTOridgis8grALAtvd+sA4NhQ5QdpQnGt9tyx6IVjPErXzg37aHBt+rIL9+QBMmifNK8UpIvEGxyMnkt8TcsJLVyZBFCdixWk1GGQIi1scB09yI+lETIa+M0A==
Received-SPF: pass client-ip=57.103.71.99;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

When using the vGIC, timers are directly handled by the platform.
No vmexits ought to happen in that case. Abort if reaching those code paths.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 8c568d60bd..fe5a376aee 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1681,6 +1681,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
     case SYSREG_ICC_CTLR_EL1:
+        assert(!hvf_irqchip_in_kernel());
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_read_cp(cpu, "GICv3", reg, val)) {
             return 0;
@@ -1971,6 +1972,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_ICC_SGI0R_EL1:
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
+        assert(!hvf_irqchip_in_kernel());
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_write_cp(cpu, "GICv3", reg, val)) {
             return 0;
@@ -2378,6 +2380,7 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
         ret = hvf_handle_exception(cpu, &exit->exception);
         break;
     case HV_EXIT_REASON_VTIMER_ACTIVATED:
+        assert(!hvf_irqchip_in_kernel());
         qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
         cpu->accel->vtimer_masked = true;
         break;
-- 
2.50.1 (Apple Git-155)


