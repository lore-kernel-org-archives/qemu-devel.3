Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91846606A332
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JGNYtt9i
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM8zz-0000jT-Le; Wed, 28 Oct 2026 15:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xM8zW-00006I-UI
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:07:21 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xM8zV-0004L8-CA
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:07:18 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 77E2C43802;
 Wed, 28 Oct 2026 19:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC481F01825;
 Wed, 28 Oct 2026 19:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793214436;
 bh=TdxpH9LqEk8teunsiMxYnCMRFckdheAuMSAcz8Ybunk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JGNYtt9iOFGD7txxqX+efq/E+czjZ3BoWcHCINhQEvtodBXW0oy+om/5BqGBNsKlc
 IELoicHQpeJGsCc/BXmXRzjdAMU/2clPXiS1aIxkArXepy2D1tYHITx+c8qNgHC7hh
 mjhlp0Dt3mv9IMdD8UKxLMw+brwjIh2xDux0ja5dogV/D9uv+eCuIN1siR/QfOSbRg
 G8Uyw8IjSe1VjKupGvCm/KM0AXAjz3d7PoNEwgMBlaFXwCvxhMe+yDYluT+FJRbI+l
 wa0SMBuhoYmVL7zpwm7qC7qGcG8aWFbaZtPDZD4jhFfXH9UaM30sNf1W0d7lDpbVne
 7lKA3wbQzDlsA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, "Kirill A . Korinsky" <kirill@korins.ky>
Subject: [PULL v2 7/9] hw/misc/lasi: LASI Harmony Audio presence emulation
Date: Wed, 28 Oct 2026 20:06:59 +0100
Message-ID: <20261028190701.17272-8-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028190701.17272-1-deller@kernel.org>
References: <20261028190701.17272-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
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

HP-UX 9 beeps through the harmony audio chip, and it panics if there
isn't one, because the 715/64 has no HIL keyboard to beep through
instead. Emulate the bare minimum of the chip's registers and report a
running audio clock. There's still no sound.
In the long run we plan to add a Harmony driver, but for now this is
sufficient.

Suggested-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/misc/lasi.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/misc/lasi.c b/hw/misc/lasi.c
index f0dfd78b4d..76029804e1 100644
--- a/hw/misc/lasi.c
+++ b/hw/misc/lasi.c
@@ -36,8 +36,7 @@ static bool lasi_chip_mem_valid(void *opaque, hwaddr addr,
     case LASI_IAR:
 
     case LASI_LPT:
-    case LASI_AUDIO:
-    case LASI_AUDIO + 4:
+    case LASI_AUDIO ... LASI_AUDIO + 0xFF:
     case LASI_UART:
     case LASI_LAN:
     case LASI_LAN + 12: /* LASI LAN MAC */
@@ -87,6 +86,13 @@ static MemTxResult lasi_chip_read_with_attrs(void *opaque, hwaddr addr,
         val = s->iar;
         break;
 
+    case LASI_AUDIO ... LASI_AUDIO + 0xFF:
+        /*
+         * Harmony audio not yet emulated.  DIAG (0x3c) reports a running
+         * sample clock, which HP-UX 9 checks before using the beeper.
+         */
+        val = (addr == LASI_AUDIO + 0x3c);
+        break;
     case LASI_LPT:
     case LASI_UART:
     case LASI_LAN:
@@ -158,9 +164,8 @@ static MemTxResult lasi_chip_write_with_attrs(void *opaque, hwaddr addr,
     case LASI_LPT:
         /* XXX: reset parallel port */
         break;
-    case LASI_AUDIO:
-    case LASI_AUDIO + 4:
-        /* XXX: reset audio port */
+    case LASI_AUDIO ... LASI_AUDIO + 0xFF:
+        /* XXX: Harmony audio is not emulated */
         break;
     case LASI_UART:
         /* XXX: reset serial port */
-- 
2.54.0


