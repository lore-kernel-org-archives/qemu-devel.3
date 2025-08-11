Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64BEC87FDB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 10:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulPVo-000762-LY; Mon, 11 Aug 2025 06:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1ulPVl-00075J-DZ
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 06:12:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1ulPVh-0007GU-AV
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 06:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754907119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xF5yoHc+2beu6J3VT/748F6+IGRKBcTxaiNePhTe8mQ=;
 b=CIZrNPHXcFkRd+AP0dwdSdX42rFAtuvY4cFfh1gP+Akf/68oA9LhZaSgPaFH370C7ap10f
 a45jrSF6T/ZlPKEAWxkOO5t6xSzxtYMV5P2jEPXCfL7MOQ18edDHV5hbzBZIGhEwf09yOk
 e8sfKAAAGFIASacz1a79bGrOSrarNsI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-BXeEPZCqMgqhyMUXzYei1w-1; Mon,
 11 Aug 2025 06:11:56 -0400
X-MC-Unique: BXeEPZCqMgqhyMUXzYei1w-1
X-Mimecast-MFC-AGG-ID: BXeEPZCqMgqhyMUXzYei1w_1754907115
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E7F71956088; Mon, 11 Aug 2025 10:11:55 +0000 (UTC)
Received: from fedora (unknown [10.45.225.64])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 68D5518003FC; Mon, 11 Aug 2025 10:11:53 +0000 (UTC)
From: Mauro Matteo Cascella <mcascell@redhat.com>
To: qemu-devel@nongnu.org
Cc: mcascell@redhat.com,
	zdi-disclosures@trendmicro.com,
	kraxel@redhat.com
Subject: [PATCH] hw/uefi: clear uefi-vars buffer in uefi_vars_write callback
Date: Mon, 11 Aug 2025 12:11:24 +0200
Message-ID: <20250811101128.17661-1-mcascell@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 hw/uefi/var-service-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/uefi/var-service-core.c b/hw/uefi/var-service-core.c
index feec5a5958..6ab8df091a 100644
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
2.50.1


