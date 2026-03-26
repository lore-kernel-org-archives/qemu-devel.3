Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39A810A3D96
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5pZW-0001NQ-MR; Thu, 26 Mar 2026 14:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5pZS-0001Mj-Ra
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 14:36:43 -0400
Received: from ci-2003c-snip4-11.eps.apple.com ([57.103.91.161]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5pZR-0008Sn-AT
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 14:36:42 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-5 (Postfix) with ESMTPS id
 1CC761800315; Thu, 26 Mar 2026 18:36:36 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774550198; x=1777142198;
 bh=o/R2DGy6ntht8zjLtkax4gwL+IkVrUBZLrFH7yPSkgI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=SfgrTVplZuaA5YDPt9IUjnITyE0IKtSw+qERxosLHpn1vPCqKK3SIfYe75b41+JqgsAFf4JTOc2h4R2hzJDI+eCv0nAD6mxVaJ7zRWja2orIKHdsVv7MGjO/AQ4AGn2qpz9oqI896MLVs53MNw+pykKDvkMTDTFfyrLawSH+XNscEUtQuwy8A1JiLW/zqt8puEC0xgs5qMAUgh4OuBX0V3m1I15Gph7j5gMb16mKCeFI4iPfrexXvKmBC4uFPYOfn83OKWAILBxT7RVf3P04bX5k6DTbUyRKRbZwWvUl8GZeC8MtI/ElER9/K6jfNb0Ja4pXt86pKjx4GeIVQVk+CQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-5 (Postfix) with ESMTPSA id
 3ABDD1800178; Thu, 26 Mar 2026 18:36:34 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v3 2/3] target/i386: emulate: make unmapped GPA warnings a
 trace
Date: Thu, 26 Mar 2026 19:36:27 +0100
Message-ID: <20260326183628.79281-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260326183628.79281-1-mohamed@unpredictable.fr>
References: <20260326183628.79281-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=IZeKmGqa c=1 sm=1 tr=0 ts=69c57cb4
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=j-Qzp9laiEuN6BHQYxAA:9
X-Proofpoint-ORIG-GUID: vxBcRGldGUQ3IoElZKZ9HFNJT1xHXVeR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEzMyBTYWx0ZWRfX0Jse/deb3sCd
 lTsq+7e+XBs066lAXtsCb36+aUiR9ZCqa7qbKt8GQZBVIFpSpjGUS+qfCZim3jm8wIGwDqjRpB5
 BNNdyiwXJAp8XHRm0X/TBVlgK24AqzMCNNft5sXsf6jVpmGhswxWySog+lTZUR3MW+5Y3zhAdyL
 61RRBXMqszxFchmSalYbsfjRVuC3Mg8TBHJRJ+9gaD+6IvlcyP4FM73YuHsMTNQJGOYBLe0FSaB
 ECZVevgrhzUVQfATgZN5IhBOp86PmINKaU/TiWUCookzELb0iSa2X0Xi4jd9o04qnbyTbHQlTPU
 OLT5vL3dV+ofUQdVMX8vYOCfvR01Qbl73EQYtjHq7Dm1/xKDWym0pO0h+ko8Hg=
X-Proofpoint-GUID: vxBcRGldGUQ3IoElZKZ9HFNJT1xHXVeR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=463
 spamscore=0 malwarescore=0 clxscore=1030 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603260133
Received-SPF: pass client-ip=57.103.91.161;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Some guest OSes trigger them way too often.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 meson.build                      | 1 +
 target/i386/emulate/trace-events | 2 ++
 target/i386/emulate/trace.h      | 2 ++
 target/i386/emulate/x86_mmu.c    | 5 +++--
 4 files changed, 8 insertions(+), 2 deletions(-)
 create mode 100644 target/i386/emulate/trace-events
 create mode 100644 target/i386/emulate/trace.h

diff --git a/meson.build b/meson.build
index e6f17dd5f7..5a2e7a491d 100644
--- a/meson.build
+++ b/meson.build
@@ -3691,6 +3691,7 @@ if have_system or have_user
     'target/arm/hvf',
     'target/hppa',
     'target/i386',
+    'target/i386/emulate',
     'target/i386/kvm',
     'target/loongarch',
     'target/mips/tcg',
diff --git a/target/i386/emulate/trace-events b/target/i386/emulate/trace-events
new file mode 100644
index 0000000000..e353969661
--- /dev/null
+++ b/target/i386/emulate/trace-events
@@ -0,0 +1,2 @@
+x86_unhandled_memory_read(uint64_t gpa, int bytes) "read from unmapped mmio region gpa=0x%" PRIx64 " size=%i"
+x86_unhandled_memory_write(uint64_t gpa, int bytes) "write to unmapped mmio region gpa=0x%" PRIx64 " size=%i"
diff --git a/target/i386/emulate/trace.h b/target/i386/emulate/trace.h
new file mode 100644
index 0000000000..8c2317b152
--- /dev/null
+++ b/target/i386/emulate/trace.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+#include "trace/trace-target_i386_emulate.h"
diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index c69ae96acb..e5f4dd8a65 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -25,6 +25,7 @@
 #include "emulate/x86.h"
 #include "emulate/x86_emu.h"
 #include "emulate/x86_mmu.h"
+#include "trace.h"
 
 #define pte_present(pte) (pte & PT_PRESENT)
 #define pte_write_access(pte) (pte & PT_WRITE)
@@ -287,7 +288,7 @@ static MMUTranslateResult x86_write_mem_ex(CPUState *cpu, void *data, target_ulo
                             MEMTXATTRS_UNSPECIFIED, data, copy);
 
         if (mem_tx_res == MEMTX_DECODE_ERROR) {
-            warn_report("write to unmapped mmio region gpa=0x%" PRIx64 " size=%i", gpa, bytes);
+            trace_x86_unhandled_memory_write(gpa, bytes);
             return MMU_TRANSLATE_GPA_UNMAPPED;
         } else if (mem_tx_res == MEMTX_ACCESS_ERROR) {
             return MMU_TRANSLATE_GPA_NO_WRITE_ACCESS;
@@ -339,7 +340,7 @@ static MMUTranslateResult x86_read_mem_ex(CPUState *cpu, void *data, target_ulon
                            data, copy);
 
         if (mem_tx_res == MEMTX_DECODE_ERROR) {
-            warn_report("read from unmapped mmio region gpa=0x%" PRIx64 " size=%i", gpa, bytes);
+            trace_x86_unhandled_memory_read(gpa, bytes);
             return MMU_TRANSLATE_GPA_UNMAPPED;
         } else if (mem_tx_res == MEMTX_ACCESS_ERROR) {
             return MMU_TRANSLATE_GPA_NO_READ_ACCESS;
-- 
2.50.1 (Apple Git-155)


