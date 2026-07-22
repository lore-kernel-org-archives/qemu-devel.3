Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE866C4453E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWUL-0002Rk-Il; Wed, 22 Jul 2026 08:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWT7-0006wa-Pn; Wed, 22 Jul 2026 08:54:37 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWT6-00034g-1D; Wed, 22 Jul 2026 08:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724575; bh=e5X1kc2l6pqy33fkHlFwYxzGxR+LN7cHstgTMsKXiLM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=c2InxO2hGm5nJM3YxF5XHSQgt4PIY/yxYLv7FDJVZVpVGQRZxKAe1wRoZ5G+U8zI8
 vq0yOmlV/T7Rk3WrRRHnWWLrBnRiToemyQ61VjtMkhYZPp7MNoSi/nzdJElmFrw55J
 zuYYxSLcQ7scxIiLI/j1RzguS7OcfwSKrEl2NFe6B9rCb/ZsyIy0p4ouHDY6rFSyqM
 wWnFlZCfDycGrzD4ZYHvXclHXXniFHhioZqWsolptzOl1wOyhiuo3LIqbcRBvofYa3
 hbwYBsnOTGfRjf+uHOKKFB9aiPEa7Y/7/h5TVKKAdYpH+4LFJx9ZqQgEzRwJeOgG5t
 fsNC9dFEF5JGg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 348BC1C3B4F;
 Wed, 22 Jul 2026 15:49:35 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7D9CC3F379F;
 Wed, 22 Jul 2026 15:49:52 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id E02CB17F73; Wed, 22 Jul 2026 15:49:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Feifan Qian <bea1e@proton.me>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 v2 114/127] hw/usb/xhci: clamp interval exponent to
 avoid UB shift in xhci_init_epctx()
Date: Wed, 22 Jul 2026 15:48:39 +0300
Message-ID: <20260722124859.32371-33-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Feifan Qian <bea1e@proton.me>

The xHCI endpoint context dword 0 bits 23:16 ("Interval") are written
by the guest and passed directly as the shift amount in:

    epctx->interval = 1 << ((ctx[0] >> 16) & 0xff);

The shift amount can be 0-255.  Shifting a 32-bit `int` left by >= 32
is undefined behaviour under C11 §6.5.7p4.  With UBSan
(halt_on_error=1) this causes QEMU to abort; with aggressive compiler
optimisations that assume UB is unreachable the result is
unpredictable.

Clamp the exponent to [0, 18] with MIN() before the shift, and use
`1u` (unsigned) to avoid shifting a signed integer.  The xHCI
specification defines a maximum meaningful Interval value of 18 for
most endpoint types; thus clamping to 18 is a safe fix that
preserves the full unsigned 32-bit range for any compliant value.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3703
Reported-by: Feifan Qian <bea1e@proton.me>
Signed-off-by: Feifan Qian <bea1e@proton.me>
[thuth: Clamp to 18 instead of 31]
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 12d8ee9d5358cd8cdd2c2193081b4d7fea4b6098)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index f5bb7d25600..7f236b7f0c3 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1122,7 +1122,7 @@ static void xhci_init_epctx(XHCIEPContext *epctx,
         epctx->ring.ccs = ctx[2] & 1;
     }
 
-    epctx->interval = 1 << ((ctx[0] >> 16) & 0xff);
+    epctx->interval = 1u << MIN((ctx[0] >> 16) & 0xffu, 18u);
 }
 
 static TRBCCode xhci_enable_ep(XHCIState *xhci, unsigned int slotid,
-- 
2.47.3


