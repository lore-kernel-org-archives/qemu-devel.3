Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6767606A339
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=gqZxdXVt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3OG-0003wJ-RG; Mon, 16 Nov 2026 15:33:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Kx-0008GX-Ih; Mon, 16 Nov 2026 15:30:08 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Kt-0001kG-T7; Mon, 16 Nov 2026 15:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860765; bh=pkq5tfbPmQbBI2X4M0xmvY070ehGpAh3bujgc5KePdw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gqZxdXVt3u/Jt3p2dPjD/KghdFpk+3v06clv6WdbVqxOTrLWEK77y1uo3/3Ry4s9l
 QWW4QbgHpW5UnYBPvUweopKQ268q3R+XL/P0FUfRrklQWh7keAm+JNqipWQkijwgp4
 LG/JBTWxDI/t0FAne+Dh/sSeWQCt+JnZWeZRx0MIjETxwZFfsw3oJSww4kodu7lJ4u
 7TYU0PvDc2UZK/v1VfMyyJr4P/UJQoGd1a+/eK5FjGgyvP0wBh3y9uRN7JvqRlSfbI
 7ZcO5y9atbwFOEh1wEMBQa90lIJD6QYYVStndTLd8ba6Zq0v9fFoZF9OUZD+ATuxyN
 eGS2e8qjQQQ2A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 827FC1E71C0;
 Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7F4D445FBEC;
 Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 4520EB8E9C; Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ferdinand Schober <schober@cs.fau.de>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 43/63] arm/cpu: fix GIC v3 flag for a64fx
Date: Mon, 16 Nov 2026 23:25:22 +0300
Message-ID: <20261116202554.535325-43-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ferdinand Schober <schober@cs.fau.de>

The a64fx CPU model wrongfully set GIC bits in the
processor feature register (ID_AA64PFR0).

I traced this back to e31c70ac04001df5e540b79843834277e283fa71,
where A64FX got added.

This bit is supposed to get set conditionally in id_aa64pfr0_read,
depending on whether or not a gicv3 is present, from what I can tell.
Qemu picks gic-version=2 by default, while v3 gets advertised due to this flag.
Recent EDK2 firmware accesses ICC_SRE_EL2 in this case and crashes.

Clear the GIC field, as the other CPU models do.

Cc: qemu-stable@nongnu.org
Fixes: e31c70ac0400 ("target-arm: Add support for Fujitsu A64FX")
Signed-off-by: Ferdinand Schober <schober@cs.fau.de>
Message-id: 20261103145254.1543907-1-schober@cs.fau.de
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit e7666745773fb6680e46f716335e18dc5102fe32)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 8a3ebf63213..40740b4d877 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -498,7 +498,8 @@ static void aarch64_a64fx_initfn(Object *obj)
     cpu->revidr = 0x00000000;
     cpu->ctr = 0x86668006;
     cpu->reset_sctlr = 0x30000180;
-    SET_IDREG(isar, ID_AA64PFR0, 0x0000000101111111); /* No RAS Extensions */
+    /* No RAS Extensions, GIC filled in later */
+    SET_IDREG(isar, ID_AA64PFR0, 0x0000000100111111);
     SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000000);
     SET_IDREG(isar, ID_AA64DFR0, 0x0000000010305408);
     SET_IDREG(isar, ID_AA64DFR1, 0x0000000000000000);
-- 
2.47.3


