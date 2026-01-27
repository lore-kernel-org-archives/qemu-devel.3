Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78764D2FEDC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vko5Q-0001QP-PE; Tue, 27 Jan 2026 13:46:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vko4i-0000WR-HX
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:46:08 -0500
Received: from p-east2-cluster6-host2-snip4-10.eps.apple.com ([57.103.76.191]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vko4e-0007fE-VQ
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:46:04 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 372891800641; Tue, 27 Jan 2026 18:45:47 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769539551; x=1772131551;
 bh=ANEd5ApEEDeGsnYek9oXj3jAXvhp0RKscjMa/tquPUU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=VckSKkYcDNVdTaQ+3JXLiHIQdtxheZcoHoeGnpTWVPFbpf5rN6iNSHckhKg748x0ktVENa8WLAD+z/QPnnhdHxiH/emcTxsfDS2k18OHQ2pveLz0991qPamizPftVcc0gibMjp3QjK8ZvCRwuTQrbN3sLrjAUrdoSjfcYtQGw3nlrzlm81TutrdniQzx9YwMDW+tIyKph2MWgEeduqzpM7enRhhkulbjERO321GgWh6ooCxp/4io2ExAJEHGEkens/DjsPd4zH4ni6kPyVK8RVRUtxPhn6DDWegsq/OQVQYDYUgb265HhQOc2W9uCasFsZFFan+/VBymRGCn367z+Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 D38B918021E0; Tue, 27 Jan 2026 18:45:45 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v9 12/12] hvf: enable nested virtualisation support
Date: Tue, 27 Jan 2026 19:45:23 +0100
Message-ID: <20260127184523.5357-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127184523.5357-1-mohamed@unpredictable.fr>
References: <20260127184523.5357-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tiNOxKbh-dz8StGsefLLxhfh8aparo0s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE1MyBTYWx0ZWRfX0k8O2BPElM8X
 5lZHs4Ok1i8B/S1S8bGHSD9NBtDEboPZcYrRLKCeZdzToHvZ4QOyC8KiDJXO0EB1izKUtuhhjWs
 T+fI9zxbl+UAdEZwfOB/PPJAcI4r43RxdP2S1v+IJjz72+VfoyMvFbb03SXIewDTGBV8mwLgAMo
 3fg5PGaz2CO5kGD8qhVqCRWXInm2dR9bcCaHyUxTYsN4mKguVzahtJXzb+IQ06LjQ5ki60l65y9
 4sNTZrCGzgNsvMVpzr1XpA88bRPzreXkO696AGkMWURf8SCXT4KmxPC7Vyu1Tad+9hzZzLNwlht
 ZtdaE8l7gqSGWOsFhvuvo8MT/wUePCZLJL0HJUL2WQ1YyLPGwm80aS6T8O4tfM=
X-Authority-Info-Out: v=2.4 cv=ZeUQ98VA c=1 sm=1 tr=0 ts=697907dd
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gc5wapfoLYamzdkEL9IA:9
X-Proofpoint-GUID: tiNOxKbh-dz8StGsefLLxhfh8aparo0s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 mlxlogscore=917 clxscore=1030 mlxscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270153
X-JNJ: AAAAAAABvN4cqWEVRQAsN7SyHNPB9EUrtm0pdHIRphtVWzIDaMP7udvoC9W6DCXWWjC+sycaXBoyakFg4JAVqTHqZDmkGYnTqAGexynTiC6PYbh/vdFbKh8BUHmWLWuB6PdeAegWx7sFeobY7xI+tw1KqK2gngaumH1dOl8mDZ7CGCpApmXvZVMcIFtCpjuUxnj0xSP/dbAFnRH4uKy4XW0vIerAAoB5A9KqzcBLB24pMxrzCiE1A/lRQNE1oTQ5sTSkqK2etItBYQ+cxVLKZsjT4zj8/BuKRplXkESE5Khohsa3xRofaTgo4vX76oC22bL3PecCfxG942rzRl4xKksNhLNMz4cwi+u1oILWlmSIowTOwJKepYnonktFZ0ZYdKL9nJhsTj776OHtVN4g1DamcR4p+nTcyGbRpotk54l+AIf2cm92NVwc1OvHdUyVFx+VeihgjupPZOfPexOeLDYXU89rV82VBfIcjqsa7Rs+zajZUMxW2SGkAg8vbyPu8LtCcVEd2k33Ap9F3W/VYlZSwltaGkbWUfNDYySekCdFxZ5+lMwIhSFX/+2gmBXSWhUDYMBwDElxPwagtKEV9f8WuCGYx2qYcm9oR6jSwFaW48BZA2x+ncv9o0prdPD1SReQ1WEABIEyMtF3YQU4Qthrvs5hoIdr7HDpMW/c8UucW8r9onE3pbxeTSus4YpaROFQ2sN7CsQKlxlm3/rrKxM1JHxyUA==
Received-SPF: pass client-ip=57.103.76.191;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/arm/virt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6ba7d6a6ef..0f4537dae4 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2383,7 +2383,8 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->virt && !kvm_enabled() && !tcg_enabled() && !qtest_enabled()) {
+    if (vms->virt && !kvm_enabled() && !tcg_enabled()
+       && !hvf_enabled() && !qtest_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "Virtualization extensions to the guest CPU",
                      current_accel_name());
-- 
2.50.1 (Apple Git-155)


