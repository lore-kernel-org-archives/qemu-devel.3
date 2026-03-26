Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0432510AB82E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 23:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5uB8-00087T-5C; Thu, 26 Mar 2026 19:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5uAy-00085w-Ju
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 19:31:45 -0400
Received: from ci-2002d-snip4-11.eps.apple.com ([57.103.88.171]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5uAw-0003o0-9P
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 19:31:44 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-0 (Postfix) with ESMTPS id
 27F5A1800104; Thu, 26 Mar 2026 23:31:38 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774567901; x=1777159901;
 bh=FKSxblGBMJN9gDudhiJ4g/hzQy9Cx9uqiZTr40R8kdo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Pnj+oVH7TD9BLHkamFEX9/20PV81u+dhczWAqnTQp5XoF7IXlrFB7oyvdnN9WXZSrP2ajUUFr1Fj99G3Cf0Iz687LeJaMiKhz1bORnn6jZOhSJQRZHW6GD6VJEeeaP2ZO5emNmyW4E8bx7RQlkw/hMiAsj7n9cN8wxXdZqcTIIMSbPN6v1JQTqUldwfzevu605XlC86HYT1Z6kn2G2qbQDNlCUeZ/LMYwCOV8Qnd8O7KxWKz2Dwdwl/3l9rwKcmUXwjYVNUOwjwk0YY+SDp/ggnZ8MCCnjqLCyMTYiJf1VqRLYpsmU/ir725F/O0quyOpPh/KKAIBpsb7yrcacgcOw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-0 (Postfix) with ESMTPSA id
 EB78A180011A; Thu, 26 Mar 2026 23:31:36 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v5 2/6] whpx: i386: trace unsupported MSR accesses
Date: Fri, 27 Mar 2026 00:31:26 +0100
Message-ID: <20260326233130.59392-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260326233130.59392-1-mohamed@unpredictable.fr>
References: <20260326233130.59392-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: TBVAe0hvEA2jvCIQcagDeC6QmVKrUiTq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDE2NyBTYWx0ZWRfXwsKOX8hc4HEo
 s2E9Xa5vLpI9XaqiFl5/BTgEnbUclFM8EGI/3MAQz2iCC5dkPtumTk/KRtijJewWEdkzW2UBb9m
 6gm16ho97pjcoy17XZ9eJUWzbvJjwRcCZ31iVA7c/ApYmFHaRmdHNlJEcTXnYIcI5RZ+l2GV3k+
 sYHgCin1Lbp0rzlq8ILDGtQAjII+h5LW+GSlkPaWZtlbwI+6djoA4b+MD+mBekQvouPuO2cZURF
 WJTOkSyaX+wQF+IKUrhrWACcCSKAsoAjiPOkWcsXaw8x/vg2iifVXDwlfULeEYhPAVbvYUjLNV2
 Vb8mZCy+NHMKwtvTHNxHHBY+GGfi435nwCXvND+ShozrfjZa2x1XJnidlfyv7w=
X-Authority-Info-Out: v=2.4 cv=ffCgCkQF c=1 sm=1 tr=0 ts=69c5c1dc
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=BggPbTrBReIH5vXiFLoA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: TBVAe0hvEA2jvCIQcagDeC6QmVKrUiTq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0
 clxscore=1030 mlxlogscore=388 mlxscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603260167
Received-SPF: pass client-ip=57.103.88.171;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Not actionable information for users, so stop
having it displayed unconditionally.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build                   | 1 +
 target/i386/whpx/trace-events | 1 +
 target/i386/whpx/trace.h      | 2 ++
 target/i386/whpx/whpx-all.c   | 5 +++--
 4 files changed, 7 insertions(+), 2 deletions(-)
 create mode 100644 target/i386/whpx/trace-events
 create mode 100644 target/i386/whpx/trace.h

diff --git a/meson.build b/meson.build
index e6f17dd5f7..c19c5afa46 100644
--- a/meson.build
+++ b/meson.build
@@ -3692,6 +3692,7 @@ if have_system or have_user
     'target/hppa',
     'target/i386',
     'target/i386/kvm',
+    'target/i386/whpx',
     'target/loongarch',
     'target/mips/tcg',
     'target/ppc',
diff --git a/target/i386/whpx/trace-events b/target/i386/whpx/trace-events
new file mode 100644
index 0000000000..ebdfa34b28
--- /dev/null
+++ b/target/i386/whpx/trace-events
@@ -0,0 +1 @@
+whpx_unsupported_msr_access(uint32_t msr, int is_write) "WHPX: Unsupported MSR access (0x%x), IsWrite=%i"
diff --git a/target/i386/whpx/trace.h b/target/i386/whpx/trace.h
new file mode 100644
index 0000000000..b7c090deff
--- /dev/null
+++ b/target/i386/whpx/trace.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include "trace/trace-target_i386_whpx.h"
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index acae61e089..e56ae2b343 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -41,6 +41,7 @@
 #include "emulate/x86_emu.h"
 #include "emulate/x86_flags.h"
 #include "emulate/x86_mmu.h"
+#include "trace.h"
 
 #include <winhvplatform.h>
 
@@ -1921,8 +1922,8 @@ int whpx_vcpu_run(CPUState *cpu)
                         1 : 3;
 
             if (!is_known_msr) {
-                warn_report("WHPX: Unsupported MSR access (0x%x), IsWrite=%i", 
-                vcpu->exit_ctx.MsrAccess.MsrNumber, vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite);
+                trace_whpx_unsupported_msr_access(vcpu->exit_ctx.MsrAccess.MsrNumber,
+                    vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite);
             }
 
             hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
-- 
2.50.1 (Apple Git-155)


