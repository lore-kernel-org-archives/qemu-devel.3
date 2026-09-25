Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA5AC98321
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 11:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA4WU-00085r-K3; Fri, 25 Sep 2026 07:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <logic@deltaq.org>)
 id 1xA2qB-0006mO-Jh; Fri, 25 Sep 2026 06:07:39 -0400
Received: from pmg-auth-smtp2.teksavvy.com ([76.10.175.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <logic@deltaq.org>)
 id 1xA2qA-0000HH-0h; Fri, 25 Sep 2026 06:07:39 -0400
Received: from pmg-auth-smtp2.teksavvy.com (localhost.localdomain [127.0.0.1])
 by pmg-auth-smtp2.teksavvy.com (Proxmox) with ESMTP id C84F6813AA;
 Fri, 25 Sep 2026 06:07:34 -0400 (EDT)
Received: from visor.logiclrd.cx (unknown [104.246.135.111])
 by pmg-auth-smtp2.teksavvy.com (Proxmox) with ESMTPSA;
 Fri, 25 Sep 2026 06:07:33 -0400 (EDT)
From: Jonathan Gilbert <logic@deltaq.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jonathan Gilbert <logic@deltaq.org>
Subject: [PATCH] hw/misc/bcm2835_cprman: correct register index in test for
 mux update
Date: Fri, 25 Sep 2026 05:07:26 -0500
Message-ID: <20260925100726.1546566-1-logic@deltaq.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=76.10.175.140; envelope-from=logic@deltaq.org;
 helo=pmg-auth-smtp2.teksavvy.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:55:25 -0400
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

After each register write handled by cprman_write, function update_mux
checks each of the clocks to see whether the supplied register index
applies to it, calling clock_mux_update if so. Each clock has two
registers, so it needs to check the base cm_offset for CM_CTL and then
the next slot for CM_DIV. But, it was checking for cm_offset plus 4, as
though it were a byte offset when it's a logical index.

Signed-off-by: Jonathan Gilbert <logic@deltaq.org>
---
 hw/misc/bcm2835_cprman.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
index 8220f7a6b4..f9a77ff9bb 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -508,7 +508,7 @@ static inline void update_mux_from_cm(BCM2835CprmanState *s, size_t idx)
 
     for (i = 0; i < CPRMAN_NUM_CLOCK_MUX; i++) {
         if ((CLOCK_MUX_INIT_INFO[i].cm_offset == idx) ||
-            (CLOCK_MUX_INIT_INFO[i].cm_offset + 4 == idx)) {
+            (CLOCK_MUX_INIT_INFO[i].cm_offset + 1 == idx)) {
             /* matches CM_CTL or CM_DIV mux register */
             clock_mux_update(&s->clock_muxes[i]);
             return;
-- 
2.53.0



