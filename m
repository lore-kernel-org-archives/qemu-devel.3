Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9476D2FED2
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vko4p-0000XN-Rq; Tue, 27 Jan 2026 13:46:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vko4R-0000M9-2W
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:45:51 -0500
Received: from p-east2-cluster6-host1-snip4-3.eps.apple.com ([57.103.76.174]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vko4E-0007bI-U6
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:45:37 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 471C718012C4; Tue, 27 Jan 2026 18:45:32 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769539532; x=1772131532;
 bh=92tMQEO+Nusd8p2euFUQP0+NnAb+pyxEihNPlH8e/TY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=AjJexl1FF9Hu4TfjGvcCbsEYsZnbTBo2CT+bT8Ej+6t1ouz+MgnRCJqYjTTAYuy7Kx6WF8d/rNG6OvOEb0cHhD9y2bnA44QbkM/QUnAqYll9PSPKskYPWcCH+c1uWRhHZwjik8I6GgRRpEm4IgFvTPMV3kEE/DZ5D1iGa3WdnXn9wQri+kKzZ0+AI80hQHpD5WPGXaijsD72aA1kRZQ6hHfBgbU8U7hETwbtbhQnoRYfd+ZjS5Zi3cK/uVbHkNLY1y5pZRzgEou5dHsYvAjaBUOHzjDz19oiQtc/H2iPuSwilmSAhMhhSSbHapdVg2gz716DsRW3OrMVxICcQjMqXQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 9C2911800675; Tue, 27 Jan 2026 18:45:30 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v9 03/12] target/arm: hvf: instantiate GIC early
Date: Tue, 27 Jan 2026 19:45:14 +0100
Message-ID: <20260127184523.5357-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127184523.5357-1-mohamed@unpredictable.fr>
References: <20260127184523.5357-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _yij1Sco5CFxIymCt6TobVxmnjwC34Z0
X-Proofpoint-GUID: _yij1Sco5CFxIymCt6TobVxmnjwC34Z0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE1MyBTYWx0ZWRfX7vYgfzdiqwmK
 FaJMJWwCC4PWM0IuUHO2Khf8FdrhL0N3D8zFX8g51BK4yWyo6Y88X7tJ1BqzjITDMHJyZ9DmheG
 nxMHKCLd4QzwE99UdBczSw1FBm0T+MtcrsqTZT+6psRB/XnxRy5aDpPNizZxpIkxBfRn9X2gVil
 b3EYV9vsp+dHGbaLCbiY8QrKtnB/+/H79OwGNy0CmciNrKRy05hemZzgig2oKaVORoBg9LDh3nI
 MhqHkeBZti8mgaFC8jz8/LcuuYp4S9Zt2DTLLCvpnTgNFQKHK5Lddt36jT2XyJytoS4HBM4UEEK
 +qX/Q9dmYMvKHziidNL
X-Authority-Info-Out: v=2.4 cv=Zq/g6t7G c=1 sm=1 tr=0 ts=697907cc
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iW0rYzIOeSeTUJq9hTUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=698 spamscore=0
 bulkscore=0 clxscore=1030 suspectscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601270153
X-JNJ: AAAAAAAB1+yNv8F0WnX0tupHFwAzBYlJs5+kMZhsxtOWw6/iaWuhWAU0NnWks+zogVO8A42NOyLHKTOW4N3Gr3478UD4AS0k91penZdbWG98M0zPbEBQM2AOwk8qJETtkt3aRBqdgHOzS8978oLE2jmn80mKRs6BWKtepjJY/5v89/E1/xZ+IFxcUCIM/pASOB8LqdSlYD05WI4S0MdsjTy63jCoBm3nVO2h5cMFau20PMOlopCxzdSLiJsXpJngv3JAvRIpEFNtUCAN8516u60tEswy0vFSiH9x6SufcKdATxSVgBclMEZKC9ufJYRUqjj0mjgTa9/RyBN9XrlAYhjqT6n0j7id3NcsR0lvt+yxKnaRi+THkCeXtwaHhsKHCZHmjN6sLWNgf7+8r7h0BpwXOzDB43ELHex0iRQ6vZP7Ud9k3y2WZ9ewh38KHbaxitSGiSKfjr0h+p4NoS/JYTLRGm0CcpPLajpTWaRh8O+4Kb9XvCvYBIMLBUVqkiiTSfpOFNMyWikA51hqRUIHitueXnxpwVZD+FsW6I9vPCMPHnlLnNL60OnF5iCdMxQ45ktewpWWRflL1HZ8ht143psLAczzw1hH9Y2H+jc+i7UgX+2OFSOumBUawqTdkd0rXDfuT2cPiZHGSeEaJFrtq0vkB3MYWwx/bwv/J7+JAilQ6R9fNoNdQD86KNz2OiTqhClknh8LHE8myxg=
Received-SPF: pass client-ip=57.103.76.174;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 74b6f5e7db..77ab56778d 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -890,6 +890,22 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
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


