Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37057F3027F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 00:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1vSv-0004uq-Cf; Sun, 15 Mar 2026 20:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w1vSh-0004u3-Tp
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 20:05:36 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w1vSd-0004YX-0B
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 20:05:33 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8E09E596E04;
 Mon, 16 Mar 2026 01:05:25 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id N5Yfm_h0bLF3; Mon, 16 Mar 2026 01:05:23 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7FA3A596E00; Mon, 16 Mar 2026 01:05:23 +0100 (CET)
Message-ID: <0cc6620e1d15af6ef465e2322dce6d4c79ad0793.1773618848.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1773618848.git.balaton@eik.bme.hu>
References: <cover.1773618848.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 4/4] ati-vga: Avoid warning about sign extension
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Mon, 16 Mar 2026 01:05:23 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Coverity reports possible sign extension error (CID 1645615) when
reading DEFAULT_SC_BOTTOM_RIGHT register. It cannot happen because the
values are limited when writing the register but change the code to
match other similar registers and to avoid this warning.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 1a6a5ad4fd..d194f15002 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -513,8 +513,8 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
         val |= s->regs.default_tile << 16;
         break;
     case DEFAULT_SC_BOTTOM_RIGHT:
-        val = (s->regs.default_sc_bottom << 16) |
-              s->regs.default_sc_right;
+        val = s->regs.default_sc_right;
+        val |= s->regs.default_sc_bottom << 16;
         break;
     case SC_TOP:
         val = s->regs.sc_top;
-- 
2.41.3


