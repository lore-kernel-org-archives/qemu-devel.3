Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D8BFF6E97
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 23:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2dtr-0000yo-6m; Tue, 17 Mar 2026 19:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w2dtp-0000xn-8w
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 19:32:33 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w2dtn-0006ah-2A
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 19:32:33 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C6B2A596E02;
 Wed, 18 Mar 2026 00:32:29 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id uTfLki-LBhVG; Wed, 18 Mar 2026 00:32:27 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 98F72596A4E; Wed, 18 Mar 2026 00:32:27 +0100 (CET)
Message-ID: <b3af90af051762d7fcbb4393ba9c0714282ea903.1773789314.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1773789314.git.balaton@eik.bme.hu>
References: <cover.1773789314.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 2/5] ati-vga: Also switch mode on HW cursor enable bit
 change
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Wed, 18 Mar 2026 00:32:27 +0100 (CET)
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

This does nothing for most drivers but works around issue and fixes
output with the Solaris R128 driver that only sets display parameters
after enabling CRT controller which we would miss otherwise.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Tested-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index c165434938..8286f67c1c 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -632,6 +632,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         ati_reg_write_offs(&s->regs.crtc_gen_cntl,
                            addr - CRTC_GEN_CNTL, data, size);
         if ((val & CRTC2_CUR_EN) != (s->regs.crtc_gen_cntl & CRTC2_CUR_EN)) {
+            ati_vga_switch_mode(s);
             if (s->cursor_guest_mode) {
                 s->vga.force_shadow = !!(s->regs.crtc_gen_cntl & CRTC2_CUR_EN);
             } else {
-- 
2.41.3


