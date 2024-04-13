Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B26C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2024 11:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvb7P-0000fC-Lu; Sat, 13 Apr 2024 07:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1rvb7L-0000bi-Jm; Sat, 13 Apr 2024 07:00:20 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1rvb7J-0002P7-VK; Sat, 13 Apr 2024 07:00:19 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 7AFF7C0023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1713006012;
 bh=hwh8A+mIgbj7v6jIURAlmJ5qJQ+hq1iDueKeSvQz0TA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=H72ZY+1lkAHAzc4aAxdAryPonIpP8RgcC2WZ8YQ4d4iRYWo0MfkMNkURFrDfnPDRz
 KoJqDaAW9CNiXv3QslY3xY4Iot/N7vYZrpGvvPKkLjlpz49w/wT/vXFgbXbWSwq8Gm
 nAMvB9ZOxoWMEwnxLsbyJgQnaZAXzmApAaWNq4Bg5xlAObjwCebCY0vbHyzvsMcQYI
 M6JbkySBBuPGmd7oRQXBEunfNgxIcvxP9j5n+FGoI47+4/fQ1ZCAErsZzsra+4PpjV
 O4PxI2/5VaZL8fDj5VqaWUvifIlFHMnczNcecInPQDCIsG/522wDOnve0RTRluURQb
 jHZjb6CQRzrvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1713006012;
 bh=hwh8A+mIgbj7v6jIURAlmJ5qJQ+hq1iDueKeSvQz0TA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=rNRlzqnf1hODj66Lfi9laMHgYNDTXHM24VzDfnycQw7nhPnn2tIcYWAMNcdcA2Nt9
 aR/sG31A0X/HtalafgZHZzjdy07XLwfBbWNxewnaBi6/ppjyIH8E3nv2gVaHJpPJSR
 zXxn4seEcRzTmQFDaZsxONW2ix/N0suIeLOMMgDwUcztHx6eRmfXztIUzHEaLt1BAt
 KgpFf7OoQ1x0KdHeT57tAnhHbPCboc3DzSRUYweHGnxU2ueGhUbIVH1hl2UWKECyDl
 Us/+12jfVv+sLpD3K6N/Q/nznjY7Cev2/mrzbUxRCpsxlvN96p6Tn747c7U/pMFNs9
 wQNrgIs2fDxpQ==
From: Alexei Filippov <alexei.filippov@syntacore.com>
To: <palmer@dabbelt.com>, <alistair.francis@wdc.com>,
 <bin.meng@windriver.com>, <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>
CC: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>, Alexei Filippov
 <alexei.filippov@syntacore.com>
Subject: [PATCH 2/2] target/riscv: do not set mtval2 for non guest-page faults
Date: Sat, 13 Apr 2024 13:59:29 +0300
Message-ID: <20240413105929.7030-2-alexei.filippov@syntacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240413105929.7030-1-alexei.filippov@syntacore.com>
References: <20240413105929.7030-1-alexei.filippov@syntacore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-06.corp.yadro.com (172.17.10.110) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=alexei.filippov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Previous patch fixed the PMP priority in raise_mmu_exception() but we're still
setting mtval2 incorrectly. In riscv_cpu_tlb_fill(), after pmp check in 2 stage
translation part, mtval2 will be set in case of successes 2 stage translation but
failed pmp check.

In this case we gonna set mtval2 via env->guest_phys_fault_addr in context of
riscv_cpu_tlb_fill(), as this was a guest-page-fault, but it didn't and mtval2
should be zero, according to RISCV privileged spec sect. 9.4.4: When a guest
page-fault is taken into M-mode, mtval2 is written with either zero or guest
physical address that faulted, shifted by 2 bits. *For other traps, mtval2
is set to zero...*

Signed-off-by: Alexei Filippov <alexei.filippov@syntacore.com>
---
 target/riscv/cpu_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 196166f8dd..89e659fe3a 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1410,17 +1410,17 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                               __func__, pa, ret, prot_pmp, tlb_size);
 
                 prot &= prot_pmp;
-            }
-
-            if (ret != TRANSLATE_SUCCESS) {
+            } else {
                 /*
                  * Guest physical address translation failed, this is a HS
                  * level exception
                  */
                 first_stage_error = false;
-                env->guest_phys_fault_addr = (im_address |
-                                              (address &
-                                               (TARGET_PAGE_SIZE - 1))) >> 2;
+                if (ret != TRANSLATE_PMP_FAIL) {
+                    env->guest_phys_fault_addr = (im_address |
+                                                  (address &
+                                                   (TARGET_PAGE_SIZE - 1))) >> 2;
+                }
             }
         }
     } else {
-- 
2.34.1


