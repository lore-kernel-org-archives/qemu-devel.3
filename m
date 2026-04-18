Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF20BF99C98
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEEFR-0000KW-Id; Sat, 18 Apr 2026 18:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEFP-0008QK-9A
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:43 -0400
Received: from p-east2-cluster1-host6-snip4-8.eps.apple.com ([57.103.76.101]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEFN-0005G9-LL
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:42 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 22EE718000E2; Sat, 18 Apr 2026 22:34:32 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776551680; x=1779143680;
 bh=Jrr2HbYb7vJ4wfjMglfbzSz74bDnkcrrxHCDfoOvAtE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=M4lO701fFWvcEOuOyjRpdDBSe23wd7QSkE1l/XZNL2gmrvI31nP3d/By77vo8EI2CINCHzREld2sE/vj2ke+WUfkkvcu57r34nawYgHwOSP8mM+TUrxvDNP0l0BQ406DRm3t3Do1rS4J9cFW7TIk3x+Vfr339ONQkEwDmVck57fsE+jd9dal0+78v40QU8/1KIQwtuqNRPxSqkdy1T0q1EjIq0guoGq7K+o5yj9dZ9fv5oJMfj1NWNGk7VunXjor/jQcEyuuR1oS+NHSk2ksum/CI6ramd4ZLS5R+AVcHah+YBGa+U+Tn9ErPSA/u0ZgVKJf1h3xBaimS3fB04RTPA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 EC7061800200; Sat, 18 Apr 2026 22:34:30 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 37/38] whpx: i386: intercept CPUID 0xD too
Date: Sun, 19 Apr 2026 00:33:19 +0200
Message-ID: <20260418223320.51330-38-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260418223320.51330-1-mohamed@unpredictable.fr>
References: <20260418223320.51330-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fYKU3_LEMS1ZFi5XLamKHf63XH9gci88
X-Authority-Info-Out: v=2.4 cv=L6MQguT8 c=1 sm=1 tr=0 ts=69e406fe
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7r31mvdhAh4OVJ8YR2QA:9
X-Proofpoint-ORIG-GUID: fYKU3_LEMS1ZFi5XLamKHf63XH9gci88
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDIyOSBTYWx0ZWRfX/jUqKB2fB3bc
 FkRh0FzcuoYndeD7o0vv/8xYujs+fxoqktvTRt73s4JL3NdbI0jBNw+GHeGjtvfr/duo0v/LpMT
 IiL3Sefbq+HpeZTZEiN1i1P550dlc7tweFyFouhkGC0oCSz67qTf4OSf7rr0rd1Wtpo/PZpB46p
 zsOINere2YOnVqUJwdxvhF8oIsbVBVwUOlfTY1yssluroavK57BjELLJs2JRRx+wRbuybqXDco6
 8qATku8WKITdd+OpdcNq+PSI/xLpb2wYUfghAnX1Qr4MZOE5Nh7/s4HUWpv/WN62KHlMHKMvmUG
 uXlGNwo0TwSFJDeXZm9aoGDEl7TmdhKcu9Vfr7TUqUjlhrOhl5qdUDGTVD6qtY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_06,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 mlxlogscore=869 adultscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604180229
Received-SPF: pass client-ip=57.103.76.101;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

To have a more accurate CPU model.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index e79d085da8..d50f0a57fa 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2565,6 +2565,14 @@ int whpx_vcpu_run(CPUState *cpu)
                 }
             }
 
+            /* CPUID[0xD,{1,2}].EBX are dynamic depending on guest features. */
+            if (vcpu->exit_ctx.CpuidAccess.Rax == 0xd) {
+                if (vcpu->exit_ctx.CpuidAccess.Rcx == 1
+                    || vcpu->exit_ctx.CpuidAccess.Rcx == 2) {
+                    reg_values[4].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
+                }
+            }
+
             /* OSXSAVE is dynamic. Do this instead of syncing CR4 */
             if (vcpu->exit_ctx.CpuidAccess.Rax == 1) {
                 if (vcpu->exit_ctx.CpuidAccess.DefaultResultRcx
@@ -2866,7 +2874,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     WHV_PROCESSOR_FEATURES_BANKS processor_features;
     WHV_PROCESSOR_PERFMON_FEATURES perfmon_features;
 
-    UINT32 cpuidExitList[] = {0x0, 0x1, 0x6, 0x7, 0xb, 0x14, 0x24, 0x29, 0x1E,
+    UINT32 cpuidExitList[] = {0x0, 0x1, 0x6, 0x7, 0xb, 0xd, 0x14, 0x24, 0x29, 0x1E,
         0x40000000, 0x40000001, 0x40000010, 0x80000000, 0x80000001,
         0x80000002, 0x80000003, 0x80000004, 0x80000007, 0x80000008,
         0x8000000A, 0x80000021, 0x80000022, 0xC0000000, 0xC0000001};
-- 
2.50.1 (Apple Git-155)


