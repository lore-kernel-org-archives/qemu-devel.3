Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC17FCDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNsI-0001Dx-G4; Wed, 24 Jun 2026 09:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNs3-000100-Nn; Wed, 24 Jun 2026 09:42:30 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNs1-0001w4-Ha; Wed, 24 Jun 2026 09:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782308001; bh=r8gg0U3DYFSvCPdz+8ffEzJTMnzSG3354csObtAj96I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ld38ZUW9bYf06RICJOR+PXDTuw+BJrWmD3T6E067Yv3/8WDxJ3XfZVfXxgzBIff+z
 PWatCW4TFshAZ+QEUVfRGRtw/kY5jOcqqtRshewGIELx4X8pv1jnEcT8pXWKA1g2mR
 cvPoIulB9SXnr9AMlIu/L9uwzlj1wLVsUmG7/5TxLWMQK+OMeTiVRL/ls4Uo3rMeNg
 b4rcwis3Co2cPboLNvg91CK5At4cK9vNyQ/O//d7s0HygNn2McMlpe0Swp1fJzUlCN
 a6iJOzSzPeXQ4urxvR9k9XXGdxcb536jmPTxVVIwmMO7z1LuDhDveXmDm219bHxYb7
 Pj0dvoG5En0ng==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B77661BAA0F;
 Wed, 24 Jun 2026 16:33:21 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 49EA83DEA5E;
 Wed, 24 Jun 2026 16:33:27 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Abhigyan Kumar <314abh@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 093/107] target/riscv: mask vxrm csrw write to the low
 2 bits
Date: Wed, 24 Jun 2026 16:31:38 +0300
Message-ID: <20260624133301.403266-93-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Abhigyan Kumar <314abh@gmail.com>

Citing the RISC-V specification:

    "The vector fixed-point rounding-mode register holds a two-bit
    read-write rounding-mode field in the least-significant bits
    (vxrm[1:0]). The upper bits, vxrm[XLEN-1:2], should be written as
    zeros."

QEMU wrote full value into env->vxrm causing read of upper bits too.
Used existing macros for bit-masking. Previous had a hard-coded value.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3470
Signed-off-by: Abhigyan Kumar <314abh@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260530102100.78150-1-314abh@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 9f550a0b630672f4831d9115e66d208ed71cf252)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 78dd4e0070..60dba08b99 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -960,7 +960,7 @@ static RISCVException write_vxrm(CPURISCVState *env, int csrno,
 #if !defined(CONFIG_USER_ONLY)
     env->mstatus |= MSTATUS_VS;
 #endif
-    env->vxrm = val;
+    env->vxrm = val & (VCSR_VXRM >> VCSR_VXRM_SHIFT);
     return RISCV_EXCP_NONE;
 }
 
-- 
2.47.3


