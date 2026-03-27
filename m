Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A0310AB83A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 01:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5vkC-0005HK-Ns; Thu, 26 Mar 2026 21:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5vk8-0005GK-T0
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 21:12:08 -0400
Received: from ci-2006a-snip4-8.eps.apple.com ([57.103.90.139]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5vk6-0006Ka-9C
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 21:12:08 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-8 (Postfix) with ESMTPS id
 D9265180017B; Fri, 27 Mar 2026 01:11:59 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774573920; x=1777165920;
 bh=qw4/IAc2AfUQIdDNEDfodceVulsJFzoRk9abAUbHx/U=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=HRsJTQt8A3pZYog/zIMSjpUI1bkmZb8McDKqbbHDnW3tdm/W1B67NzfhW5YfH4A9jcUDfAZxw6BoaxDnVG8t4zAd//l2Mwe4MtVdjRb7dSL3yO3DRVKc7GUcEprcGaLYT4DO5G8zTASN1BEmV8pWWjC3AURdtrijeE8ENcLpCfqIIfAB4ME9Abx7Rbu9FA2AoaP8L/Xp9zZgZ9sjIHbxm2Vx2FTySOUf5Ap3MrVnIqhj/s+H5sMKfgVlQ1vqbnuAHXw/iD9oS2AXoq6FQI4HLkUZpVzWSZxaXEqf5kG+1Z+pvJ3NvOKY6KSDLNTci/nydWAJeITyFwSdpnPyGNDMtQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-8 (Postfix) with ESMTPSA id
 AFD0F18004A1; Fri, 27 Mar 2026 01:11:58 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v6 3/4] whpx: i386: trace unsupported MSR accesses
Date: Fri, 27 Mar 2026 02:11:51 +0100
Message-ID: <20260327011152.4126-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260327011152.4126-1-mohamed@unpredictable.fr>
References: <20260327011152.4126-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HtwbSatEsSMGbOZodrfhbmo1EjFuHRMT
X-Authority-Info-Out: v=2.4 cv=M8dA6iws c=1 sm=1 tr=0 ts=69c5d960
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=BggPbTrBReIH5vXiFLoA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: HtwbSatEsSMGbOZodrfhbmo1EjFuHRMT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDAwOCBTYWx0ZWRfXyLpnSgj8Daxt
 VyWuxXH2f98gvIdqr58GalP7UEkpTENvMV/+zJkbRl/QCLiOXOaUwZTgS5gLpxoxZOK/AcKS85m
 J8xE43TbGa/bE2scwPmFcuZBnksew3N2dXemDJyBRhx4QrlkDT7FQrFzFuGYWgKWLvcW2dLgYs/
 ATfbHcFZxxfgW6mblGNg9MdP7cTGaKKPAY/KmKsgByjm2uTBsvvAlBAbtQNIlG5zDFy/DFa43VQ
 6Ub+W+74o8Uc8J+RyrvXwxyKE97LAwhEPgMALhuE2oCc598NykR5rWr24hq80Sd4zVK+HuTmBUT
 RdXo9Nqr257mnD1L2Un8xPt1XziexRa9PqMZsv4oiuQXxYK7lF80hO8QvcQvwI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxlogscore=289 lowpriorityscore=0 clxscore=1030 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603270008
Received-SPF: pass client-ip=57.103.90.139;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
index 6f77309075..8bf1da3169 100644
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
index e8fe65f581..9a405118c5 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -41,6 +41,7 @@
 #include "emulate/x86_emu.h"
 #include "emulate/x86_flags.h"
 #include "emulate/x86_mmu.h"
+#include "trace.h"
 
 #include <winhvplatform.h>
 
@@ -1931,8 +1932,8 @@ int whpx_vcpu_run(CPUState *cpu)
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


