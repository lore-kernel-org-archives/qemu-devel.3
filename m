Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC870606A329
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 22:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LDPaPlj/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP60B-0004Bv-Nl; Thu, 05 Nov 2026 17:32:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xP5zY-00046s-G4
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 17:31:32 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xP5zX-0002K1-4S
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 17:31:32 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 821F9600C8;
 Thu,  5 Nov 2026 22:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301AC1F0089F;
 Thu,  5 Nov 2026 22:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793917890;
 bh=ybjiJfYGINCX2IQHZ+oOkMxw4oJE1b1IdHFkxReLVus=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LDPaPlj/aGV+uSoOrB7P0U2+cIJZlNfPRSXeblwpn1DGFjDvoKA1g76tvMQ8WS5Lk
 kUMidnz7F8YdJ8Ffun8QQG2ADpdkT+g0Ff/qeLWWel4O08Oe20IrUEwhC6LjmvHFve
 sKn2Q3sE6D+dlrJbMa4+QcZzHk/qemVFIaXbPuC41yDwW4PZFPt4RP31TZW7KK9ATd
 DyBaP+llyLtlzdW2uS1GpjForqd7pVoVmTpL2JcSXi/RQjBKJOS6WjIjybdFPwcPvv
 Dxn7tIacWwKHnrLoktiPyaIqk/woy81oIm4GKSG5N5nJ+E1Rg0WAbI6U8FEgtj5a/I
 C3vZ1MsPYkD/g==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL v2 3/8] lasi_i82596: Decode the PORT command from bits 3:0,
 not 7:0.
Date: Thu,  5 Nov 2026 23:31:17 +0100
Message-ID: <20261105223122.8729-4-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105223122.8729-1-deller@kernel.org>
References: <20261105223122.8729-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
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

It's sufficient to handle bits 3:0, decoding more breaks HP-UX 9.07.

Noticed-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/net/lasi_i82596.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/lasi_i82596.c b/hw/net/lasi_i82596.c
index 423a8676a0..5df1a59617 100644
--- a/hw/net/lasi_i82596.c
+++ b/hw/net/lasi_i82596.c
@@ -43,8 +43,8 @@ static void lasi_82596_mem_write(void *opaque, hwaddr addr,
         d->val_index++;
         if (d->val_index == 0) {
             uint32_t v = d->last_val | (val << 16);
-            v = v & ~0xff;
-            i82596_ioport_writew(&d->state, d->last_val & 0xff, v);
+            v = v & ~0xf;
+            i82596_ioport_writew(&d->state, d->last_val & 0xf, v);
         }
         d->last_val = val;
         break;
-- 
2.54.0


