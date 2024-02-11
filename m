Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5D6C4829B
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Feb 2024 12:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZ8xd-000671-GW; Sun, 11 Feb 2024 07:29:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rZ8xc-00066j-HZ
 for qemu-devel@nongnu.org; Sun, 11 Feb 2024 07:29:28 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rZ8xa-0006FU-4R
 for qemu-devel@nongnu.org; Sun, 11 Feb 2024 07:29:27 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8A9AF60C56;
 Sun, 11 Feb 2024 12:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC436C433F1;
 Sun, 11 Feb 2024 12:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707654562;
 bh=FaxA3mFrSxmY5kTESFNBYrTItNp7faYaL5jQs64YYHE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PKu9KHhx8io9Jlg9RvfX5Rg6PAKQ/xEMz7/jTF/0pUdp8tUpURHtyn5zrDcYZKShC
 krXRderYZoqppZqkKLYOPcsm8/gADSp6/2864XCJJVc9HHUbp1SqbIlsfPaR1ejeF2
 uqocH3wD3JUzdG6QhOB42+lOxwDsqIZplOY1DX5EVTCakcpMqju3o9vQV4utoPx3uc
 GPmenh9u34yufWb37HhJeEW0FILXMTFQduslXnGmISWTo24cG6Nt0kb3OzooZpeOXf
 Q9cuXXS3xAqZEc3FciOl4DVbVpakQ7qJNq5Clph5DC5Tx7QZNzpTc45O/guw9NFpsn
 vSpPbgYSABvkA==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sven Schnelle <svens@stackframe.org>, Jason Wang <jasowang@redhat.com>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 05/12] lasi: allow access to LAN MAC address registers
Date: Sun, 11 Feb 2024 13:29:02 +0100
Message-ID: <20240211122909.5807-6-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211122909.5807-1-deller@kernel.org>
References: <20240211122909.5807-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -77
X-Spam_score: -7.8
X-Spam_bar: -------
X-Spam_report: (-7.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.677,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Firmware and qemu reads and writes the MAC address for the LASI LAN via
registers in LASI. Allow those accesses and return zero even if LASI
LAN isn't enabled to avoid HPMCs (=crashes).

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/misc/lasi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/misc/lasi.c b/hw/misc/lasi.c
index 003f5b5ed8..9cfa5bb316 100644
--- a/hw/misc/lasi.c
+++ b/hw/misc/lasi.c
@@ -38,6 +38,7 @@ static bool lasi_chip_mem_valid(void *opaque, hwaddr addr,
     case LASI_LPT:
     case LASI_UART:
     case LASI_LAN:
+    case LASI_LAN + 12: /* LASI LAN MAC */
     case LASI_RTC:
 
     case LASI_PCR ... LASI_AMR:
@@ -78,6 +79,7 @@ static MemTxResult lasi_chip_read_with_attrs(void *opaque, hwaddr addr,
     case LASI_LPT:
     case LASI_UART:
     case LASI_LAN:
+    case LASI_LAN + 12:
         val = 0;
         break;
     case LASI_RTC:
-- 
2.43.0


