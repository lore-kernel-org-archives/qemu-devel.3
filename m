Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70ACC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6kL9-0008Hl-Ol; Wed, 16 Sep 2026 03:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kL5-00087p-6E; Wed, 16 Sep 2026 03:45:57 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kL1-0005GH-Lk; Wed, 16 Sep 2026 03:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789544614; bh=9aGAooK8Nt4RPf5peIsc3pD3/VjmBeHXz+eMVfaYOxg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=b5D5vSzYU6EJppza0kTsrUMIvB63zTxpS5Us2VgubTwp2ly2owGJW/u/69CoNyNWX
 4Hpx1njnRCeAqMZq0o3Nblk+cd+E/keOIIR9O5scMIvb8Bv81iP/46KHAWcS3zw7c+
 +qBnazVg4f37EbdiEbsAdiXCZP0NZ9pQ9+p7Lc2bv+0N1al3aio2MFpJQd3GCLyPFL
 FNUBWmamhj94rYIODxovIfIemG0lefHtdgQtyxu6R7DVePOC/BikwbKPQ8R9U13zS3
 fsLiu2TuxZ1W82xQp7rjfOu9kBqkk/BHiTK60UusnsdE8q8Ru5/c7bPsCiGdkpv7Qw
 VhUF68gfhZ43w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D09661D55A5;
 Wed, 16 Sep 2026 10:43:34 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 605E5429B4C;
 Wed, 16 Sep 2026 10:44:17 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 54A2C5A6EF; Wed, 16 Sep 2026 10:44:17 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alexandre Frey <alexandre.frey@nxp.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 23/49] target/arm: fix TTA instruction S bit for
 IDAU-exempt addresses
Date: Wed, 16 Sep 2026 10:42:41 +0300
Message-ID: <20260916074346.671467-23-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
References: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
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

From: Alexandre Frey <alexandre.frey@nxp.com>

The TTA (Test Target Alternate Domain) instruction is specific to
ARMv8-M processors with the Security Extension (TrustZone). It allows
Secure code to query the security attributes and access permissions of
a memory address as seen from the Non-secure domain, and is typically
used by Secure code to validate pointers received from Non-secure
callers before dereferencing them.

The TTA instruction incorrectly reports the S bit (bit 22) of the
result register for IDAU-exempt addresses when executed from Secure
state.

According to the ARMv8-M Architecture Reference Manual (DDI0553B.z),
the TTResp() pseudocode (E2.1.408) always calls SecurityCheck() with
the current security state, regardless of the alt flag:

  sAttributes = SecurityCheck(address, FALSE, IsSecure());

The alt flag only affects which MPU bank is queried for the R/RW/MREGION
fields. It does not affect the SAU/IDAU security attribute lookup that
determines the S bit.

For an IDAU-exempt address, SecurityCheck() (E2.1.366) sets:

  result.ns = !isSecure;  // isSecure = current CPU security state

So TTA executed from Secure state on an IDAU-exempt address should
return S=1. This is confirmed by testing on real Cortex-M33 hardware.

QEMU currently passes targetsec (which is flipped to !env->v7m.secure
when alt=true) to v8m_security_lookup(), causing the IDAU-exempt path
to set sattrs->ns = TRUE and return S=0 instead.

Fix this by always passing the current security state to
v8m_security_lookup(), as the spec requires.

Cc: qemu-stable@nongnu.org
Fixes: 5158de241b0f ("target/arm: Implement TT instruction")
(the is_secure argument to v8m_security_lookup() was only added in
dbf2a71ad62b992 ("target/arm: Add is_secure parameter to
v8m_security_lookup"), but the code before that implicitly had the
equivalent bug.)
Signed-off-by: Alexandre Frey <alexandre.frey@nxp.com>
Message-id: ZR6PR04MB44238851A057F385D7EECEAD3599AE2@ZR6PR04MB442388.eurprd04.prod.outlook.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: added comment]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit f63124af78462f2210b90b07ef62a74bc32281a3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index f7354f3c6e0..71c300edcb6 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -2839,8 +2839,9 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
     }
 
     if (env->v7m.secure) {
+        /* Note that security check is done as Secure even if alt is true */
         v8m_security_lookup(env, addr, MMU_DATA_LOAD, mmu_idx,
-                            targetsec, &sattrs);
+                            env->v7m.secure, &sattrs);
         nsr = sattrs.ns && r;
         nsrw = sattrs.ns && rw;
     } else {
-- 
2.47.3


