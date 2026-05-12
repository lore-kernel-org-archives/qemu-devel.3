Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD174CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuE7-0006yH-T7; Tue, 12 May 2026 17:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuCt-0003hS-9f; Tue, 12 May 2026 16:59:59 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuCp-0005aT-MP; Tue, 12 May 2026 16:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619276; bh=rJL1iSZupBtbEXDSlv7iUJmz8SeU3kNlkyt8hqBdeNg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EwLM+c2x5y/FIif1wj7lKnm/5MHYPVlsXp5YSarS3Dzp8NHt2If/cpf4DSJzCVf3n
 H/Efv911MncqZrC44uII0F/WQRRC5K59YY1zjuNssQ13JA6QQMoLCpYlepPlTScW/C
 tLwNSAfn24WGFES0PFgkFA/lYKIBk3KFlCYWbKfbC8gbVygSyld6K+ZJFgis+J8sgE
 4oixNMv83Jv5wAbIQvHanQRa10io154Z68aCpWSFEY35zY1eNw5oRTmEtQORQORKQz
 tFGje/WOJwVVCd1MkQRYNrCYE8JxCrJJlWjpu11qlbxAxcep5tTi2/szQgOGcG2p9k
 jVAioKH89YfxQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AF4451AA301;
 Tue, 12 May 2026 23:54:36 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B93CD3ABC72;
 Tue, 12 May 2026 23:54:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Yuma Kurogome <yumak@ricsec.co.jp>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 053/107] hw/uefi: fix heap overflow (CVE-2026-5744)
Date: Tue, 12 May 2026 23:53:40 +0300
Message-ID: <20260512205437.360850-53-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
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

From: Gerd Hoffmann <kraxel@redhat.com>

When copying the request response into the pio transfer buffer the code
skips the 'struct mm_header' but does not consider that when calculating
transfer size, so it will copy 24 (== sizeof(struct mm_header)) extra
bytes, which can overflow uv->pio_xfer_buffer.

Fix that by copying the complete buffer, including the header, which
also makes the pio code path consistent with the (unaffected) dma code
path.

Fixes: CVE-2026-5744
Fixes: 90ca4e03c27d ("hw/uefi: add var-service-core.c")
Reported-by: Yuma Kurogome <yumak@ricsec.co.jp>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20260408073403.3410541-1-kraxel@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit af74c9e46bb55e2da042315a0c65666f59c61686)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/uefi/var-service-core.c b/hw/uefi/var-service-core.c
index 92fc121fe7..0a05ec4c9c 100644
--- a/hw/uefi/var-service-core.c
+++ b/hw/uefi/var-service-core.c
@@ -133,9 +133,8 @@ static uint32_t uefi_vars_cmd_mm(uefi_vars_state *uv, bool dma_mode)
                          uv->buffer, sizeof(*mhdr) + mhdr->length,
                          MEMTXATTRS_UNSPECIFIED);
     } else {
-        memcpy(uv->pio_xfer_buffer + sizeof(*mhdr),
-               uv->buffer + sizeof(*mhdr),
-               sizeof(*mhdr) + mhdr->length);
+        memcpy(uv->pio_xfer_buffer,
+               uv->buffer, sizeof(*mhdr) + mhdr->length);
     }
 
     return retval;
-- 
2.47.3


