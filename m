Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4729CCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 15:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHnZ-0006VV-GX; Wed, 27 Aug 2025 11:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHlb-0000x9-G6; Wed, 27 Aug 2025 11:08:52 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHlZ-0005te-RD; Wed, 27 Aug 2025 11:08:51 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5006F14C561;
 Wed, 27 Aug 2025 18:03:00 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3D70D269868;
 Wed, 27 Aug 2025 18:03:27 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mauro Matteo Cascella <mcascell@redhat.com>,
 ZDI <zdi-disclosures@trendmicro.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.4 56/59] hw/uefi: clear uefi-vars buffer in
 uefi_vars_write callback
Date: Wed, 27 Aug 2025 18:03:01 +0300
Message-ID: <20250827150323.2694101-56-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Mauro Matteo Cascella <mcascell@redhat.com>

When the guest writes to register UEFI_VARS_REG_BUFFER_SIZE, the .write
callback `uefi_vars_write` is invoked. The function allocates a
heap buffer without zeroing the memory, leaving the buffer filled with
residual data from prior allocations. When the guest later reads from
register UEFI_VARS_REG_PIO_BUFFER_TRANSFER, the .read callback
`uefi_vars_read` returns leftover metadata or other sensitive process
memory from the previously allocated buffer, leading to an information
disclosure vulnerability.

Fixes: CVE-2025-8860
Fixes: 90ca4e03c27d ("hw/uefi: add var-service-core.c")
Reported-by: ZDI <zdi-disclosures@trendmicro.com>
Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
Message-ID: <20250811101128.17661-1-mcascell@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
(cherry picked from commit f757d9d90d19b914d4023663bfc4da73bbbf007e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/uefi/var-service-core.c b/hw/uefi/var-service-core.c
index 4836a0cb81..92fc121fe7 100644
--- a/hw/uefi/var-service-core.c
+++ b/hw/uefi/var-service-core.c
@@ -259,8 +259,8 @@ static void uefi_vars_write(void *opaque, hwaddr addr, uint64_t val, unsigned si
         uv->buf_size = val;
         g_free(uv->buffer);
         g_free(uv->pio_xfer_buffer);
-        uv->buffer = g_malloc(uv->buf_size);
-        uv->pio_xfer_buffer = g_malloc(uv->buf_size);
+        uv->buffer = g_malloc0(uv->buf_size);
+        uv->pio_xfer_buffer = g_malloc0(uv->buf_size);
         break;
     case UEFI_VARS_REG_DMA_BUFFER_ADDR_LO:
         uv->buf_addr_lo = val;
-- 
2.47.2


