Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1B510AB82F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 23:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5uB2-00086y-3S; Thu, 26 Mar 2026 19:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5uAz-000861-Ia
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 19:31:45 -0400
Received: from ci-2002j-snip4-2.eps.apple.com ([57.103.88.223]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5uAx-0003oq-Tj
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 19:31:45 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-0 (Postfix) with ESMTPS id
 00F2A180012C; Thu, 26 Mar 2026 23:31:40 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774567903; x=1777159903;
 bh=5S7KGKEy49UgCD0FUZ1I15cZ4AJCf9WeQ1uRb+nbjmM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Jcn9OREU1CnMnJs6trW93ueKWHWv+cAsK2PDPPQpFhtbQqpmEfr9ji82xHhvA2YQX9LlSvJk4rIIWosqI3YG66Uhr3v1/g9dRM1PC8Ps9Izgl0kLSPanCIvA0OfRk9Rf6IvofP+57fjrqUT3kyDQ6gI7e3Y/bY1ppnoavGtekPipPhnTltMPoEA1fv4iiPcgEpG2XilYFAH4HIs6rWiRTmNH/XOtmc4XDhwWEMaBVHj+jk/Q8RFXXTMN4wzg8JrTelK3JJNjWkEHSGGPPHgwBvtuuKH6c4jNzldL6OolImHUctabxB+kVTd5sCf59k3/T6unla6VGKuQPoIts5w0ww==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-0 (Postfix) with ESMTPSA id
 C2EBE1800882; Thu, 26 Mar 2026 23:31:38 +0000 (UTC)
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
Subject: [PATCH v5 3/6] target/i386: emulate: remove redundant logging for
 unmapped MMIO access
Date: Fri, 27 Mar 2026 00:31:27 +0100
Message-ID: <20260326233130.59392-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260326233130.59392-1-mohamed@unpredictable.fr>
References: <20260326233130.59392-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _XKE4OoeBJKK3QsSFE-ap5RVSRUZ6v5d
X-Proofpoint-ORIG-GUID: _XKE4OoeBJKK3QsSFE-ap5RVSRUZ6v5d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDE2NyBTYWx0ZWRfX3yqA+VQjdWPI
 heSK/drucxbirO01Gemv8lVj8CpDV71RvGTvOtgmQ+r9jg9eBO8j25yMHqZG8FTXj5pu0Fn2HxO
 4E0Hp9I2N5mG3TWsTYcL6F5CtYWQYTWksyHo2QzIYw+7Du2cPicsbBQPjuuUu9qz6K3wwOIRdHf
 1WnfIGQIOYG1JoGynwkb287fFS8A8b/Ne2/zbIxJopIV/kf1FWNNm3Fp1dFeNZV4CYXnSpL3Iqo
 ca6Clv9EN2qizrxCIYKyWHER3RS48Fua+FIKa5eBQrNRTLWSyBmhLAdr2Vxm3NMmnVo4Np/0A9d
 uG/PhMLZJdLxfLf+oC4AP1JUTF/vNzXhsL2g/Z3Oys2F5hmpjfmUD1dcrUMViE=
X-Authority-Info-Out: v=2.4 cv=BJi+bVQG c=1 sm=1 tr=0 ts=69c5c1de
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=nKRBnGPCAAAA:8 a=Pf3sjxmatUTUh5CUccMA:9 a=JhrwjW1jOIvqYJKOqOMI:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603260167
Received-SPF: pass client-ip=57.103.88.223;
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

As this logging is redundant with -d invalid_mem,
remove it.

https://geoffchappell.com/studies/windows/km/ntoskrnl/inc/ntos/i386_x/kpcr.htm

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86_mmu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index c69ae96acb..007de582de 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -21,7 +21,6 @@
 #include "cpu.h"
 #include "system/address-spaces.h"
 #include "system/memory.h"
-#include "qemu/error-report.h"
 #include "emulate/x86.h"
 #include "emulate/x86_emu.h"
 #include "emulate/x86_mmu.h"
@@ -287,7 +286,6 @@ static MMUTranslateResult x86_write_mem_ex(CPUState *cpu, void *data, target_ulo
                             MEMTXATTRS_UNSPECIFIED, data, copy);
 
         if (mem_tx_res == MEMTX_DECODE_ERROR) {
-            warn_report("write to unmapped mmio region gpa=0x%" PRIx64 " size=%i", gpa, bytes);
             return MMU_TRANSLATE_GPA_UNMAPPED;
         } else if (mem_tx_res == MEMTX_ACCESS_ERROR) {
             return MMU_TRANSLATE_GPA_NO_WRITE_ACCESS;
@@ -339,7 +337,6 @@ static MMUTranslateResult x86_read_mem_ex(CPUState *cpu, void *data, target_ulon
                            data, copy);
 
         if (mem_tx_res == MEMTX_DECODE_ERROR) {
-            warn_report("read from unmapped mmio region gpa=0x%" PRIx64 " size=%i", gpa, bytes);
             return MMU_TRANSLATE_GPA_UNMAPPED;
         } else if (mem_tx_res == MEMTX_ACCESS_ERROR) {
             return MMU_TRANSLATE_GPA_NO_READ_ACCESS;
-- 
2.50.1 (Apple Git-155)


