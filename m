Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9B9EF5879
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 11:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vraGW-0005JB-Ht; Sun, 15 Feb 2026 06:26:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vraGP-0005G0-I5
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 06:26:09 -0500
Received: from p-west2-cluster1-host3-snip4-10.eps.apple.com ([57.103.68.73]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vraGL-0007y0-5x
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 06:26:06 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPS id
 EF574180009F; Sun, 15 Feb 2026 11:25:59 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771154761; x=1773746761;
 bh=jEliWNbG5rK2neC0IONI5zdAOP0QxrLReQSeKNzFrQA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Bx2Wbb2JX3q+ZdezV60MCoaikB/2WnEfmbrqWcnRrbjpAZtvtMEWczFt/VKGvsPKfNIE64s4mnGHRm6Qq2HhOZeY4dO/l4dZMIeCr9F/ykszmdGOpLFg/VUboxw/3NFg4WaXrirM8BNhJ+sivCFJRLWjHPXLrjf2C7EnZxuRjhUG8Jeqd1473PvzaI2hMqC2htZ0Csq23aZlyCEgkVnhEOofJ0tgaXm4GpK8l2SouEkRsRvI1QjAbW3ajYSlhquo+cA0Yu8ESbop7UmGhKcyIo4Km5jK5yD7riVMTcas6V8TYJajo/VHYrpRE0ML8v3Y1EhsYjTXman5/j2m25ZJjQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPSA id
 7603218004D7; Sun, 15 Feb 2026 11:25:57 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v10 05/14] target/arm: hvf: instantiate GIC early
Date: Sun, 15 Feb 2026 12:25:34 +0100
Message-ID: <20260215112543.4817-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260215112543.4817-1-mohamed@unpredictable.fr>
References: <20260215112543.4817-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: eKOHIjoIrMMu7HcQefLCBoasEr-p0jKC
X-Authority-Info-Out: v=2.4 cv=BNm+bVQG c=1 sm=1 tr=0 ts=6991ad48
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=iW0rYzIOeSeTUJq9hTUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDA5MiBTYWx0ZWRfX5IyViUQpgoi3
 B8wYbLt46YM5tSVc+wBvGVRSNssodWAFVl+d7OfH0dSHzpakuIKdIGxDLbL739ScpDdfYnrl6TI
 d9kpEg13WFN00eISeTK1v7Q1Q/vRIfg0NzZyMV6YeMR16p8qYvhwJQskI/yNbURidkxKntZxI5o
 m6r85PrgV0Zo/a15TDmxMEVOwn8evQfJ4RpQjha/4DrDuYy2ipzyBo3bdeb7SjoRbgI1GzZuk+Q
 51R70U1YskpngWTCAcDZOYWya4e/9OpQ2Y7HKX7oIytUnmRmnWWgooG/arKypz0fofYxb8nB90K
 YOjiTX8Rdjfgt1bsWWIwpF4ja8/6qBAfkegR5sQL7f0Tdw40pA0MlXOUZBMwXc=
X-Proofpoint-ORIG-GUID: eKOHIjoIrMMu7HcQefLCBoasEr-p0jKC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_04,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 mlxscore=0 bulkscore=0 clxscore=1030
 adultscore=0 spamscore=0
 mlxlogscore=665 suspectscore=0 lowpriorityscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602150092
X-JNJ: AAAAAAABxpXSOlNVX7Jos6m6gFn/f3xWCuzqeEOdvwXcq16zFVQh67hBxUrtuSS7ZuCEsmMviHKdSQOsrkdyuE/y7tX6gU5FJD1rXi7OB+9bratcEteA+C/i9pTpze0dEWZM6yUlkO1B+kDK4B2+AoQl2XbkleEIYeQm5R1HSb3m2LkUuv6GpJgae1U/ftQQY1XiMbhh0Hh9OVQWdGClhRY7+jffoJmQxCcteNeO9DJSFh9tkm7Dx1hZbkaovge+TvlxKZwX2dptx28QbXrTbqKFtSj0p82gH9kQqgmsiMJa2RdlipipSIbfE9T44xf+lF3w7wUFgIpk2CJMxQoY/2gE28EhM71WQxkW//IIyx8wtbiHJpYjJpGkejEvWX9BZ1J+6lyBZ5aE70LnMOHZc47zhkvNvbcPWaugLF0SqAdAqLUzSwUq4sXSohQIUaBtNXiu0njIt0DFPwsL4PDgIWCgnAHYkuHtwSGdc3hI8FWYbXgsmvOn4tu0v1dx2/LMXOargqLgYGi4TpFVXsB8w3GhlLZ3uEoSkteGA7RuN0tA0DWWBCdGNIHhnbaeoS2wQbFPJpKFk5cKPLJRILUxbSEKWCa9T5um7lpvMCZ8JhCECHgoHwNkGGguQEwZRbJygdcYNtScp10ZKpkY7QCzNmiZhQzjdML0vvOTCi9wXSpw1pYsrixaII4wXQzNWD6Nb1nBJuR+Xnc=
Received-SPF: pass client-ip=57.103.68.73;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


