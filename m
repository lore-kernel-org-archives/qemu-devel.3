Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6FDFEA82E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 07:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5IdY-0000Vd-FC; Wed, 25 Mar 2026 03:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1w5IdS-0000UQ-VB
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 03:26:38 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1w5IdP-00042G-IC
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 03:26:38 -0400
DKIM-Signature: a=rsa-sha256; bh=HZ75dORxjIw1V8rr7cp27pcFAphouxw/JWwEuEBTdgw=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1774423590; v=1;
 b=Nnc2SHOuNWrpJIP7lwVV8rDw2k07ie1mAMCaWHE3qqsoexlMIiXmktqz2OwJ7qYmTbzrtQ77
 rLjQP51JWG/CKyM5wrLGYhcSfpEk1M8u5yu+H5h+21O+fv0yJeBOAmlFIuhKZhpzKb4tmxuwTMg
 ES4KHe6c3XWLZfxix+2dSFbc49JWb7FT7dTq/1lscdiahahbd2OLtl936TgFPe6miz/RThjL9dn
 ppE8m4v5aPZ2OcpVVEJ6q51yAxjoIlNXb5R2Em9nPZJEKA3iMgxONbReJiUq1SJDTEe1V/pRUdX
 X+Lei4dRMCQZTwId2aSGGj9SJ68GvGxN4cCfjP3Zx2GPA==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id A6A0A204D3;
 Wed, 25 Mar 2026 07:26:30 +0000 (UTC)
From: ~liuxu <liuxu@git.sr.ht>
Date: Wed, 25 Mar 2026 14:31:56 +0800
Subject: [PATCH qemu] hw/intc: Call sifive_plic_update() after writing
 interrupt enable
Message-ID: <177442359063.1954.8266696018975379698-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~liuxu <liuxu@nucleisys.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: lxx <1733205434@qq.com>

When a guest writes to the interrupt enable register, the PLIC state
is updated but sifive_plic_update() is not called to re-evaluate the
interrupt line to the hart. This causes a lost interrupt when the
pending bit is set before the enable bit is written.

This is a level-triggered condition that must be re-evaluated whenever
any of the three factors change: pending bits, enable bits, or
threshold/priority. All other register writes that affect interrupt
delivery (priority, pending, threshold) already call
sifive_plic_update() after the write. Fix the enable register write
handler to do the same.

Signed-off-by: LIU Xu <liuxu@nucleisys.com>
---
 hw/intc/sifive_plic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
index 9c84ff06a9f..f893384e4df 100644
--- a/hw/intc/sifive_plic.c
+++ b/hw/intc/sifive_plic.c
@@ -219,6 +219,7 @@ static void sifive_plic_write(void *opaque, hwaddr addr, =
uint64_t value,
=20
         if (wordid < plic->bitfield_words) {
             plic->enable[addrid * plic->bitfield_words + wordid] =3D value;
+            sifive_plic_update(plic);
         } else {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: Invalid enable write 0x%" HWADDR_PRIx "\n",
--=20
2.49.1

