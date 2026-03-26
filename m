Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2AF10AB80C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 19:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5qTM-0006fh-Ia; Thu, 26 Mar 2026 15:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5qTE-0006dm-EA
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 15:34:21 -0400
Received: from ci-2007f-snip4-5.eps.apple.com ([57.103.88.58]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5qT5-0001cF-50
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 15:34:15 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPS id
 21F7F1800200; Thu, 26 Mar 2026 19:34:07 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774553650; x=1777145650;
 bh=h0AP0KXJMes1uoIFMhmXcv+JibOYHNrqTSD7Amc8qDo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Eafj8EdQq18krVUsHscDtBmU1WRtB2dw1pfrveO2PjfbSfLis/A8nPxc8Bt5OSlC5VWpy5nbHGxhkkWGbHEWEa++nVMazM5b48YCRDMIkuDNIg8t3VKDHLDeNqTEU9yXTacMYETpvGwTwEcFQQxOdVb71eYE5dI9zJgRrQH/tbWyU+O7NEMo9QT3vwmS0Z2kBEMhcwXOxXskX7Nkr30VKHdSgHalRwqkISBMXkPbZtWdJYeTDne4xniBUbJXBAZgl1eFjMK/8Yw0+6h/jdvfAT5XdevMMaJa7zk1QfCCOpFXhZWdx3tmYa2NDGlREXG6lTGldhV3EcxDTvql0QrboA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPSA id
 1850B180023C; Thu, 26 Mar 2026 19:34:05 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v4 3/3] target/i386: emulate: LOG_GUEST_ERROR for read/write
 from unmapped MMIO
Date: Thu, 26 Mar 2026 20:33:58 +0100
Message-ID: <20260326193358.97858-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260326193358.97858-1-mohamed@unpredictable.fr>
References: <20260326193358.97858-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDE0MCBTYWx0ZWRfX7bkJg4KJjHqx
 Y2UlP036K545eB8QDnYsUn4X061uokenZrUHFhVW2J++l2O+mvmLqzSh/hrBMpsZPNSKv769DE1
 n2SrCRIcKVpBya0fhvgutaRbY+KC4or3Qr7jF5LYlQgnnorlQ2trvbrFcGEXfU5lWSZvK6tRb3W
 9r4KEVC0fYdJ4UL5sAq27yI3UWPaF86Ack8BDdWSwCwC1gzsNkfhEj+5DSeBY0PwElOG9e0RQuH
 DeBDf+Kp7s1MxXq5Le4ROZuDsjv3WI5FibNsncaBWqSeXq0+57AhlFdDB9FoKyHobvxqkbNUKWI
 9bc9LLe4cyhk7w+AWdJEY+uEy5jul1ilJm4dsq3lUAeE67Xz7oeSxs3XCxxYQQ=
X-Proofpoint-GUID: DflkSL2ILQZBND7uvsv4YPtxxvZ1pa8Q
X-Proofpoint-ORIG-GUID: DflkSL2ILQZBND7uvsv4YPtxxvZ1pa8Q
X-Authority-Info-Out: v=2.4 cv=QuJTHFyd c=1 sm=1 tr=0 ts=69c58a30
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=nKRBnGPCAAAA:8 a=Sxs32ympW3d1JLnkQCIA:9 a=JhrwjW1jOIvqYJKOqOMI:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=989 phishscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603260140
Received-SPF: pass client-ip=57.103.88.58;
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

ReactOS's install ISO does a bunch of 4-byte accesses
to 0xffdff124. This doesn't happen for the boot ISO.

It looks to be an access relative to the Windows KPCR
which is at 0xffdff000 but mistakenly done prior to
paging being on...

https://geoffchappell.com/studies/windows/km/ntoskrnl/inc/ntos/i386_x/kpcr.htm

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86_mmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index c69ae96acb..815d01d97f 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "system/address-spaces.h"
 #include "system/memory.h"
-#include "qemu/error-report.h"
+#include "qemu/log.h"
 #include "emulate/x86.h"
 #include "emulate/x86_emu.h"
 #include "emulate/x86_mmu.h"
@@ -287,7 +287,7 @@ static MMUTranslateResult x86_write_mem_ex(CPUState *cpu, void *data, target_ulo
                             MEMTXATTRS_UNSPECIFIED, data, copy);
 
         if (mem_tx_res == MEMTX_DECODE_ERROR) {
-            warn_report("write to unmapped mmio region gpa=0x%" PRIx64 " size=%i", gpa, bytes);
+            qemu_log_mask(LOG_GUEST_ERROR, "write to unmapped mmio region gpa=0x%" PRIx64 " size=%i", gpa, bytes);
             return MMU_TRANSLATE_GPA_UNMAPPED;
         } else if (mem_tx_res == MEMTX_ACCESS_ERROR) {
             return MMU_TRANSLATE_GPA_NO_WRITE_ACCESS;
@@ -339,7 +339,7 @@ static MMUTranslateResult x86_read_mem_ex(CPUState *cpu, void *data, target_ulon
                            data, copy);
 
         if (mem_tx_res == MEMTX_DECODE_ERROR) {
-            warn_report("read from unmapped mmio region gpa=0x%" PRIx64 " size=%i", gpa, bytes);
+            qemu_log_mask(LOG_GUEST_ERROR, "read from unmapped mmio region gpa=0x%" PRIx64 " size=%i", gpa, bytes);
             return MMU_TRANSLATE_GPA_UNMAPPED;
         } else if (mem_tx_res == MEMTX_ACCESS_ERROR) {
             return MMU_TRANSLATE_GPA_NO_READ_ACCESS;
-- 
2.50.1 (Apple Git-155)


