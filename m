Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAB0C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 10:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2qCL-0004YW-Mq; Fri, 03 May 2024 06:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1s2qCA-0004WS-HZ; Fri, 03 May 2024 06:31:23 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1s2qC8-0007Wr-5X; Fri, 03 May 2024 06:31:14 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com E7F01C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1714732260;
 bh=2ltdpGzF4/l+I/60FCNynGzcPJE6xKTQJ4rwzf4RiIE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=qeHX49RdCZJt7jRur60FA2lp0PcO0aIMIceOX2v4/oD5x2I0hlYlwfRDK72XEsqWE
 JCHC3INZ8FKo915OLPgpQuf9yqCQZK3tEunyYfZ544jAaGALTN5aQggqJA8qSBEziT
 v3GWnCTROuWosvOcXI+FKOdSbc4pl6YnkimgVXFEQz5FpJfD6AXID+jzJ86TpybS4v
 yecp6h+Uh807IQlu01JK0Ixld4mIZyejg63m/65FzzmI6n7pKfkP5Q/dEIY81u79mr
 9ZTlA+FYgKIFZN8PY+9kI9uPLwnUCVVk7MVb9vgFlXa5mREabFDLx1ditakYiJpHMw
 z2Y9t5kFMkukA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1714732260;
 bh=2ltdpGzF4/l+I/60FCNynGzcPJE6xKTQJ4rwzf4RiIE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=YuucGcl68agqbL9HboFwGn1MKZmnDHoXppGBCHZTfmhtmxC5BW8h1XkkrXrP2YFbT
 KkJnVmG2ZmL+dj6CW7XW9Gpnhpqq3F7nqIJACYP4YZ1A2y6vZwxgHNKRAJ1MBzslJx
 eHyDVYtYQ31tO+soChUsJrWIU5q6hyOF29HqkNP2nScRkmbYc4cbUVY/gg96Fx8bh6
 qV3R3G6gx7KUKxOCm0+An6gJ7x9/B91157I4+5nGA0o9T+HacA2b0kP3nuY2YtiWUq
 dW5WYfWkXPi1LK/G777fPs8LIC9Q/s4njrNUC/wjZ1TZtrm6rVnV2WyFBXwysVA0Ab
 IG2P3Z9myzrTw==
From: Alexei Filippov <alexei.filippov@syntacore.com>
To: <dbarboza@ventanamicro.com>
CC: <alexei.filippov@syntacore.com>, <alistair.francis@wdc.com>,
 <bin.meng@windriver.com>, <liwei1518@gmail.com>, <palmer@dabbelt.com>,
 <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>,
 <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v2 2/2] target/riscv: do not set mtval2 for non guest-page
 faults
Date: Fri, 3 May 2024 13:30:52 +0300
Message-ID: <20240503103052.6819-1-alexei.filippov@syntacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ca275792-36c9-4ccd-b7b2-24d9fd837b24@ventanamicro.com>
References: <ca275792-36c9-4ccd-b7b2-24d9fd837b24@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-09.corp.yadro.com (172.17.11.59) To
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
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
Changes since v1:
		-Added Reviewed-by tag.
 target/riscv/cpu_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e3a7797d00..484edad900 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1375,17 +1375,17 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
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


