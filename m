Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12DBC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifnj-0001Fk-77; Sat, 11 Jul 2026 18:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifng-00016N-P9; Sat, 11 Jul 2026 18:03:56 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifnf-0000Fk-5r; Sat, 11 Jul 2026 18:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807181; bh=FaJS5R+gKCiWVlVkXPRzdxDXSytnyRiohqszJtJk9MQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TApWUXKCEF+8DLiou+0SebQXoGrvCv6tBmdtMbjjWWWFXUjyf7PkZQcQTegF6Bf75
 dXbcvz3KO4y5wDXf5VEeBKRAa+r/5nKQXovIIlKoftBXgBF3Xx8u8GNqsqwdt83Bs6
 jXWBKLyVkdj6oZSSbhIiHh9V9pgK7iK/KH84Wm/C+++oEn/Aya1K4eKx/9QU+VS2cE
 CcFI5fW3vTQ0kcaR/47LXLQQarkSLSF/1CSkXsa3F7hRoGad4iYFjTS79TkuFKAQ4K
 pa57HaTE335xRFh9NhhnNmwAa4EFQoEjmgpG9eXTay+QG+Hth4WIqFHwUjgtl8fBUl
 1Tt0Igc39xTwg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 336131C0ABA;
 Sun, 12 Jul 2026 00:59:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id DE8D93EAF45;
 Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A8C4913341; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Junjie Cao <junjie.cao@intel.com>,
 Feifan Qian <bea1e@proton.me>, Chad Jablonski <chad@jablonski.xyz>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 47/81] hw/display/ati: guard against zero bpp in
 ati_host_data_flush
Date: Sun, 12 Jul 2026 00:58:25 +0300
Message-ID: <20260711215904.3757-47-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Junjie Cao <junjie.cao@intel.com>

ati_bpp_from_datatype() returns 0 for unrecognized dp_datatype nibble
values (0, 1, or >= 7). ati_host_data_flush() only guards against the
bpp == 24 case but not bpp == 0, leading to:

  1. Division by zero at "pix_count /= ctx.bpp" (SIGFPE) when
     src_datatype is SRC_COLOR.
  2. g_assert_not_reached() in stn_he_p() when bypp (= bpp/8 = 0)
     hits the default case of the size switch.

Both are guest-triggerable via MMIO writes to the dp_datatype register
while a HOST_DATA blit is active.

Add an explicit bpp == 0 check with LOG_GUEST_ERROR before proceeding
with the blit, consistent with the existing check in ati_2d_do_blt().

Cc: qemu-stable@nongnu.org
Reported-by: Feifan Qian <bea1e@proton.me>
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Chad Jablonski <chad@jablonski.xyz>
Message-ID: <20260519023937.439077-3-junjie.cao@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 90f8e5c307679b7468f73924e63682567a10564d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 8ef82bb87fd..22dd811bd85 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -377,6 +377,11 @@ bool ati_host_data_flush(ATIVGAState *s)
 
     setup_2d_blt_ctx(s, &ctx);
 
+    if (!ctx.bpp) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "host_data_blt: invalid bpp from datatype\n");
+        return false;
+    }
     if (ctx.bpp == 24) {
         qemu_log_mask(LOG_UNIMP,
                       "host_data_blt: unsupported in 24 bits mode\n");
-- 
2.47.3


