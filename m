Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F87606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 22:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OKPf4J/t
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMCRa-0001vC-Ht; Wed, 28 Oct 2026 18:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xMCRX-0001uJ-TU
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 18:48:28 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xMCRW-0007d6-C0
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 18:48:27 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 745CA435D3;
 Wed, 28 Oct 2026 22:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0151F01825;
 Wed, 28 Oct 2026 22:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793227705;
 bh=zf5ppi2teIHh97kn4uw3WTJifd4Yq00Q4xRpdEtBweI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OKPf4J/tp2W4MD2O1WIlRIUh1pSjo8CiA08GA/0I1rJ42Wc+iupX6VSDDR7NVi3dc
 cgy9upnDyZW0XVwrbcuTfVLn/zdnOuqeoV6sBJKyw8UH5b2kmtgD3l4H5cjK/Mv9Q4
 r0xs7/2cSiqrpDn+pEceQp3lbBa8KbNpsNrWO6R4J+6g4jLgp5yjuZcVfYkg/upAyL
 qruKLzqSB4nyLF9heBW1VHaRMHsM7VIWJq+YliPJ7Yl+K3BQM1K6FpZBa1oVo8Vzjh
 OaRCCtLIOKWvVP48vZL9c5Os4c+DVASvOSSheVxQ5cz95ZRo+j1ppclQSziA/l3dPS
 lB+tzdzF/qzlw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Keith Monahan <keith@techtravels.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 4/4] hw/misc: Harmony sound registers now handled by harmony
 driver
Date: Wed, 28 Oct 2026 23:48:15 +0100
Message-ID: <20261028224815.32502-5-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028224815.32502-1-deller@kernel.org>
References: <20261028224815.32502-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Helge Deller <deller@gmx.de>

No need to handle the LASI AUDIO registers here.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/misc/lasi.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/hw/misc/lasi.c b/hw/misc/lasi.c
index 76029804e1..d4ef832af1 100644
--- a/hw/misc/lasi.c
+++ b/hw/misc/lasi.c
@@ -86,13 +86,7 @@ static MemTxResult lasi_chip_read_with_attrs(void *opaque, hwaddr addr,
         val = s->iar;
         break;
 
-    case LASI_AUDIO ... LASI_AUDIO + 0xFF:
-        /*
-         * Harmony audio not yet emulated.  DIAG (0x3c) reports a running
-         * sample clock, which HP-UX 9 checks before using the beeper.
-         */
-        val = (addr == LASI_AUDIO + 0x3c);
-        break;
+    case LASI_AUDIO:    /* handled by harmony audio driver */
     case LASI_LPT:
     case LASI_UART:
     case LASI_LAN:
@@ -164,8 +158,8 @@ static MemTxResult lasi_chip_write_with_attrs(void *opaque, hwaddr addr,
     case LASI_LPT:
         /* XXX: reset parallel port */
         break;
-    case LASI_AUDIO ... LASI_AUDIO + 0xFF:
-        /* XXX: Harmony audio is not emulated */
+    case LASI_AUDIO:
+        /* handled by harmony audio driver */
         break;
     case LASI_UART:
         /* XXX: reset serial port */
-- 
2.54.0


