Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE2FCD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuii-0004V8-0G; Tue, 12 May 2026 17:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuhG-0003TJ-EI; Tue, 12 May 2026 17:31:26 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuYB-0000uw-5f; Tue, 12 May 2026 17:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619499; bh=/6JwHIiWOaqsyYTTl/tshHbNobFM37fOo4/dYaRhKic=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VUyGVrO3CJ3gPrbTVmzF7mq6rfA+062xj9tOxUAt+u2qgCrdfDM0qsGqlANBOLb2r
 uXkwGhML++BZivykL5ptC4SaH3zacOHE2hGcahvWup0F1H3teiLW+thpFUQ6RYeKkm
 DlWlmDrBrRaN28HmwkptDfc2G3pNmZEHLR/xYvazCuVb79DTRsNuNo6JaF8BxCtwU7
 PXVEPh+r/+ekC9yF+9IbRuYkgPdiFqO5zj6W7oWKQPhd0FFFg9Eq80gIPD6F/8z0Ne
 QNDL6T7P4ZVnn6l8UA+9+EhuW91GV+MwjuMG0nJKnzl7FeG/NS4jzeayVkNk2JNHlQ
 rXIi9Cmy6fziQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5EF491AA3F0;
 Tue, 12 May 2026 23:58:19 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6B8523ABD48;
 Tue, 12 May 2026 23:58:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Nutty Liu <nutty.liu@hotmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 37/58] target/riscv: Don't OR mip.SEIP when mvien is
 one
Date: Tue, 12 May 2026 23:57:58 +0300
Message-ID: <20260512205820.361821-37-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
References: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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
index a75281539b..29dd596ae4 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3671,6 +3671,14 @@ static RISCVException rmw_mip64(CPURISCVState *env, int csrno,
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


