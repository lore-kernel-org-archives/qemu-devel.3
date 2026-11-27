Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD9C606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=uoS5rZqX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWpAK-0005e9-9t; Fri, 27 Nov 2026 01:10:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp9f-0005YM-Mj; Fri, 27 Nov 2026 01:09:57 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp9d-0004BZ-5Z; Fri, 27 Nov 2026 01:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759049; bh=cGoZn5SSLRaGa9u4WBdEL+KHbtH5JmySfpzhB7uSYbE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=uoS5rZqXY4uplzLARaMXpRZWXBvuxmTnvPJjsxMr15AhG7lM7kOk8Yeg5i1v2UkV6
 m1CIWWj1p+E7rwBEWJZQIdb7SivmCs8g+PxiACKc19y7GbrnekOWGpPxVGIGezWvp1
 +tPesuU1SDAEejh5XUJzgyEjPjSxJo9TFNsIMM+iq8zulfLc3/Y95OYJJycRfz5Ct8
 Ic90Q23xLCouMnosJncBcXEJJ19jNZtl1gbGSx4kcWgCNLA3H5mKDUo74vBMuvRIUX
 bmAAG+T6UQQykVTrjfeP3Iy+L1RWeAfkdFt3qK6J1No/LwrWMqU1E1S5u4rQ7ziiPv
 Mu8Zl6znlz+vw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 79AF51EA379;
 Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7742B4699A4;
 Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 6C249CF340; Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zenghui Yu <zenghui.yu@linux.dev>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 135/152] hw/intc/arm_gicv5: Fix value of the
 IRS_DEVARCH register
Date: Fri, 27 Nov 2026 08:54:33 +0300
Message-ID: <20261127055709.39630-72-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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

From: Zenghui Yu <zenghui.yu@linux.dev>

The GICv5 spec says bits [31:21] of IRS_DEVARCH are 0x23b. We wrongly
shifted it by 31 instead of 21, so guests read 0x80105a19 rather than
0x47705a19.

Cc: qemu-stable@nongnu.org
Fixes: 22232793ecb8 ("hw/intc/arm_gicv5: Implement CoreSight ID registers")
Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20261124120509.19746-1-zenghui.yu@linux.dev
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit c020bf46966ae4dbbf82efbc4c5f3435a2fda42f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index fd9e647ea67..2db73dd1ec5 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -318,7 +318,7 @@ FIELD(ICSR, HM, 5, 1)
 FIELD(ICSR, PRIORITY, 11, 5)
 FIELD(ICSR, IAFFID, 32, 16)
 
-#define IRS_DEVARCH_VALUE ((0x23b << 31) | (0x1 << 20) | 0x5a19)
+#define IRS_DEVARCH_VALUE ((0x23b << 21) | (0x1 << 20) | 0x5a19)
 
 static uint32_t gicv5_idreg(int regoffset)
 {
-- 
2.47.3


