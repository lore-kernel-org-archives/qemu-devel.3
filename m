Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345F4CCD1AA
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 14:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqvGw-0003HH-H7; Wed, 18 Sep 2024 10:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.makarov@syntacore.com>)
 id 1sqvGm-0002yP-0l; Wed, 18 Sep 2024 10:03:00 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.makarov@syntacore.com>)
 id 1sqvGk-0002b5-2B; Wed, 18 Sep 2024 10:02:59 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 93970C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1726668175;
 bh=5W/qhfnBCdxvMNbbU8sTMOE6s1XNy+wv4Jmtt9p3OhQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=o2I9OWGlRPvWFrwoJ3l2U4shDBdhHvKfOBH6RJ6wCrYHR/qh4daX12QVEroJvZGg7
 Rs/jL2Elhc79PKq+Du5E4u+DE3TrpYJZwLPUcJgAkIUb/tPGrbGpP1nNc3AcnJgm7S
 fh9DIdv0FUMXR36hu18aKrppq1zlQAHz/Mdc2kXNgkNbavrhcxNMeIE8Rpej+eZ6P1
 bMjdbS6Teu1H6J64mAuVe1hMQS+pT6PeUXWreuyJyuhQd6Fl3at7rmNgoqYlGevdAb
 23pyX3NJqcqw5nqQCuCLM8k/sVfYYCozos7H2hlr87G/g1lD2/+bSSp6D2zljTlQYZ
 EftoiFzZE71ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1726668175;
 bh=5W/qhfnBCdxvMNbbU8sTMOE6s1XNy+wv4Jmtt9p3OhQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=iApSwrVc5Ue/6Wrw3SgaZFcsxNGeLBeRjNRUXoiwChujX90C1qPBpPCgJLedq5sd8
 eFzMdO4nSi5ek94g6WUtHjWtcTSDnR9tueocZeq81OEEsQ+YG2j++OZ3CiwRnhV7JF
 ahFhS75A2OoCXtamZDD5ke3mI+mKqTo/jhy2WJEDlPq9ZSXc63FmszBVLNhr/BC7aC
 ob1FXcwi6DrzzO88RR+4hTu5BEljagMaOgNm5aFlLL2Q/k+yC25JxBVCYfHxJVcqk8
 lQ2FRRPpDo4tBXhkj8Ux119gYyZfBWzlwhwPZ1rC8bzAPZ9X57/H+QWd7vhoNCKljN
 AZ5Dc2NuH6Sgg==
From: Sergey Makarov <s.makarov@syntacore.com>
To: <Alistar.Francis@wdc.com>
CC: <s.makarov@syntacore.com>, <bmeng.cn@gmail.com>, <palmer@dabbelt.com>,
 <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [PATCH 1/2] hw/intc: Make zeroth priority register read-only
Date: Wed, 18 Sep 2024 17:02:28 +0300
Message-ID: <20240918140229.124329-2-s.makarov@syntacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240918140229.124329-1-s.makarov@syntacore.com>
References: <20240918140229.124329-1-s.makarov@syntacore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-Exch-05.corp.yadro.com (172.17.10.109) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=s.makarov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

According to PLIC specification chapter 4, zeroth
priority register is reserved. Discard writes to
this register.

Signed-off-by: Sergey Makarov <s.makarov@syntacore.com>
---
 hw/intc/sifive_plic.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
index e559f11805..3f3ee96ebc 100644
--- a/hw/intc/sifive_plic.c
+++ b/hw/intc/sifive_plic.c
@@ -189,8 +189,13 @@ static void sifive_plic_write(void *opaque, hwaddr addr, uint64_t value,
 
     if (addr_between(addr, plic->priority_base, plic->num_sources << 2)) {
         uint32_t irq = (addr - plic->priority_base) >> 2;
-
-        if (((plic->num_priorities + 1) & plic->num_priorities) == 0) {
+        if (irq == 0) {
+            /* IRQ 0 source prioority is reserved */
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Invalid source priority write 0x%"
+                          HWADDR_PRIx "\n", __func__, addr);
+            return;
+        } else if (((plic->num_priorities + 1) & plic->num_priorities) == 0) {
             /*
              * if "num_priorities + 1" is power-of-2, make each register bit of
              * interrupt priority WARL (Write-Any-Read-Legal). Just filter
-- 
2.34.1


