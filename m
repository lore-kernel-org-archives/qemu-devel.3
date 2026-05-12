Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9B8CD4F3D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuI5-0000li-K2; Tue, 12 May 2026 17:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuHn-00083H-G0; Tue, 12 May 2026 17:05:03 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuHl-0000dV-Qw; Tue, 12 May 2026 17:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619280; bh=cELnmoErs9KMFB4E7GoUF8HDV6d7Qtq6N+nR7aXB3vg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=voocRGzGp+omTi3A17conA0Uj+6U63xrLIrbQeWhf3ty2GkVk0GHzrmlshN2nCgO2
 bIwcelbwkzZlppDHXNWGtd0pxH/vTFoqY30DOO0nPhzfgTstY3WJi6lnVoRLRLPtD2
 2IhactfZ640wEQtZoHFiIvBbOK2/yRfkM8sa7A/FKDygcE4gsZNS+Y5aLI5M2iSIe7
 JFs2lpt1B01E5FxafY7cRltEOtH5gKhf8gGdv5N06Nyi55wO82Bf4Ly78V7TacaJTG
 yv+lRl+uu1vqrG22OtmLyBZW4eBq4/QgZ8vyiZVnj8nO38vhiP+gE33P5otQz6uJN9
 qceip/hWniwKw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 37D801AA333;
 Tue, 12 May 2026 23:54:40 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 390293ABCA4;
 Tue, 12 May 2026 23:54:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Katherine Leaver <katherine.j.leaver@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 103/107] hw/uefi: verify pio_xfer_offset before
 calculating buffer checksum
Date: Tue, 12 May 2026 23:54:30 +0300
Message-ID: <20260512205437.360850-103-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
MIME-Version: 1.0
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

Without that it is possible to do trigger OOB reads by first
advancing offset, then making the buffer smaller, finally
asking for a checksum.

Fixes: CVE-2026-41436
Fixes: 90ca4e03c27d ("hw/uefi: add var-service-core.c")
Reported-by: Katherine Leaver <katherine.j.leaver@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260422092910.444997-3-kraxel@redhat.com>
(cherry picked from commit 94d9a8b2c9e6962aa7f7673229d2db7b110cfac6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/uefi/var-service-core.c b/hw/uefi/var-service-core.c
index 0a05ec4c9c..1b9ca3dc77 100644
--- a/hw/uefi/var-service-core.c
+++ b/hw/uefi/var-service-core.c
@@ -229,6 +229,10 @@ static uint64_t uefi_vars_read(void *opaque, hwaddr addr, unsigned size)
         uv->pio_xfer_offset += size;
         break;
     case UEFI_VARS_REG_PIO_BUFFER_CRC32C:
+        if (uv->pio_xfer_offset > uv->buf_size) {
+            retval = 0;
+            break;
+        }
         retval = crc32c(0xffffffff, uv->pio_xfer_buffer, uv->pio_xfer_offset);
         break;
     case UEFI_VARS_REG_FLAGS:
-- 
2.47.3


