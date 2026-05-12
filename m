Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E870BCD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuHl-0007hi-Is; Tue, 12 May 2026 17:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuGM-0001o8-8Y; Tue, 12 May 2026 17:03:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuGK-0007uu-8S; Tue, 12 May 2026 17:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619279; bh=PB4u+XmKjWYxlifJ9ZAPe5qLq6Km8O5AkJn0KxIN3p4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LOa1rL7KnTJVvir64RlB5fs/41UqsjT2x1+YrgIg5DJgEK+p33t5fSQf3wzw2GgAU
 FOuiZE2faanpwaojI7bGcDV6n/s28CsBwzTJu6cJcSLSxEUltxT6zrhuA1R2O17h9n
 vErCspNRPbiEhbyvtjOUT5B/MP/JaNchmv+EYcpWtlGFhna2bd7rPvwilVif85tuku
 LCiLCzW/oLkERW6M3HPzdyqq6H9HLeNB0ZAg3AP9ycHjGgaUk5qoi4luJ3OKhtKTHa
 hZf3SYFwe4mIL9jSB8DtjvcuG7hB2U/8kc3yvWw9+cXp4XO/YrkFyHUKIQSnrVmDoh
 GpJMXgQWh0RAw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1DB031AA323;
 Tue, 12 May 2026 23:54:39 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 287D23ABC94;
 Tue, 12 May 2026 23:54:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Nutty Liu <nutty.liu@hotmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 087/107] target/riscv: Don't OR mip.SEIP when mvien
 is one
Date: Tue, 12 May 2026 23:54:14 +0300
Message-ID: <20260512205437.360850-87-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Alistair Francis <alistair.francis@wdc.com>

The RISC-V spec states that

"""
But when bit 9 of mvien is one, bit SEIP in mip is read-only and does
not include the value of bit 9 of mvip. Rather, the value of mip.SEIP
is simply the supervisor external interrupt signal from the hart’s
external interrupt controller (APLIC or IMSIC).
"""

As such let's mark the mip.SEIP in rmw_mip64().

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2828
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Message-ID: <20260415233740.3027321-4-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 175afdb0d155a7429e2ac0c568c1c807953444a4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 76e77ae2d1..7d4191c792 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3633,6 +3633,14 @@ static RISCVException rmw_mip64(CPURISCVState *env, int csrno,
     uint64_t old_mip, mask = wr_mask & delegable_ints;
     uint32_t gin;
 
+    /*
+     * When mvien[9]=1, mip.SEIP is read-only and reflects only
+     * the external interrupt signal from the interrupt controller.
+     */
+    if (env->mvien & MIP_SEIP) {
+        mask &= ~MIP_SEIP;
+    }
+
     if (mask & MIP_SEIP) {
         env->software_seip = new_val & MIP_SEIP;
         new_val |= env->external_seip * MIP_SEIP;
-- 
2.47.3


