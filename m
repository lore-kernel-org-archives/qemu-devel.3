Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C170AFEC118
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 20:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w58hC-0001CD-84; Tue, 24 Mar 2026 16:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w58hA-000137-K0
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 16:49:48 -0400
Received: from p-west2-cluster2-host8-snip4-9.eps.apple.com ([57.103.68.140]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w58h9-0004hw-3K
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 16:49:48 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-0 (Postfix) with ESMTPS id
 758AD180047E; Tue, 24 Mar 2026 20:49:44 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774385386; x=1776977386;
 bh=O6Kttnx9nqVllO63zwZbNg+Hw9L0+qrkNMfXO8Fz1Lw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=DVZQViyt4ublsqNm5gJD828rzTYxSHs9lcp8XMe9+1THzBjAItc4SlW4074feQCS26QhOKoBVaQGtvRWUhWHn4KPCVR1/Ekr/424IyzrjFKLKCQmSj8q8BcKk7d4nemnEgvBn75CcPLcNMG3wC3uIS5Y21FQXYmQk1EpdJG4w4d3MjN8yxbsLXfkT7UCR1aJA1tLH8wUKSXTTM1WxmE8sxvuTX2d0kXEZgl/G+gE05it59N++xd3c7QxlFbRhvw/BG+vXEucb6mbDOIgJDTroU/OBWbXeQMcSt8A4i+fohe2XtvUAI+613m/fKMMBNIO7Mjerd3UCymWCS9ydmDV+A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-0 (Postfix) with ESMTPSA id
 32DF6180017D; Tue, 24 Mar 2026 20:49:39 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Peter Xu <peterx@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Roman Bolshakov <rbolshakov@ddn.com>,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [RFC PATCH v7 7/7] hvf: do not merge: enable private ISA
Date: Tue, 24 Mar 2026 21:48:55 +0100
Message-ID: <20260324204855.29759-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260324204855.29759-1-mohamed@unpredictable.fr>
References: <20260324204855.29759-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE2MSBTYWx0ZWRfX7Dl+rUrgOvdE
 rm8ihZg/XAEIXCoEPLqdwIfVRNMch5PWXwvXYRNodXsVLwlUL6hm+BIs97HNSFjWjpxyPisjPcF
 R0JTPZmS6MML1UyP8VaoN/j195AA7Aj5jK3mOAYswzrU8bjZcMkwQPooi+V66QD8h5oqBbSxUFZ
 HWxUbG2hyRx8GpgUHHDor34wRKrcGs+1ls0TwHwSvX1my4sqhhI0Nxzl72AH6AI7o/p27ZbRC1S
 GVC8QOAtyq4nnGq9ACqrnZMoUFkawLVCs6C8PNoFjaLDcN9mB5KYBlafaord6j9K1WJ30nJhI28
 gU/U4mwBvvjv//+FgeTUjAtKgiRKqYWxRueVtAPQGn1PNyx47mWD+o+pFtOCr8=
X-Proofpoint-ORIG-GUID: wbgtyF_BgaubWpRo8r_EjYq0WAnXC9NH
X-Authority-Info-Out: v=2.4 cv=TaybdBQh c=1 sm=1 tr=0 ts=69c2f8e9
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=-PnSl7ADAAAA:20 a=t-IPkPogAAAA:8 a=qAl5iOcGTlDWK1lW5BMA:9
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: wbgtyF_BgaubWpRo8r_EjYq0WAnXC9NH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=768
 mlxscore=0 spamscore=0 clxscore=1030 malwarescore=0
 lowpriorityscore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603240161
Received-SPF: pass client-ip=57.103.68.140;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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

Booting macOS Tahoe.

There in the series to show that's all it takes, but not
mergable as is. Testing this requires SIP to be disabled
and AMFI to be bypassed to be able to launch the executable.

Note that macOS Tahoe uses ISV=0, and the corresponding series
is needed too.

The script to do so:
https://gist.githubusercontent.com/zhaofengli/1df11ae3f0dd4e2c872a12ef849f7371/raw/b0ef43f2168600e8810d35a3e70d9a1eb39929e2/amfid-allow.py

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/hvf/entitlements.plist | 2 +-
 target/arm/hvf/hvf.c         | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/accel/hvf/entitlements.plist b/accel/hvf/entitlements.plist
index 154f3308ef..b1a25a2319 100644
--- a/accel/hvf/entitlements.plist
+++ b/accel/hvf/entitlements.plist
@@ -2,7 +2,7 @@
 <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
 <plist version="1.0">
 <dict>
-    <key>com.apple.security.hypervisor</key>
+    <key>com.apple.private.hypervisor</key>
     <true/>
 </dict>
 </plist>
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 000e54bd16..5d23aa8ae4 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1219,6 +1219,8 @@ void hvf_arch_vcpu_destroy(CPUState *cpu)
     assert_hvf_ok(ret);
 }
 
+hv_return_t _hv_vm_config_set_isa(hv_vm_config_t cfg, int isa);
+
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
 {
     hv_return_t ret;
@@ -1230,6 +1232,12 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
     }
     chosen_ipa_bit_size = pa_range;
 
+    ret = _hv_vm_config_set_isa(config, 3);
+    if (ret != HV_SUCCESS) {
+        error_report("error setting private ISA");
+        goto cleanup;
+    }
+
     ret = hv_vm_create(config);
 
 cleanup:
-- 
2.50.1 (Apple Git-155)


