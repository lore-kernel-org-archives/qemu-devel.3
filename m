Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18BBCA0EDC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 10:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ullp5-0002FJ-4W; Tue, 12 Aug 2025 06:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ullp2-0002EW-1k
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 06:01:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ullos-0004vu-H6
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 06:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754992879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jN2ij8af1dnCmSc1kGgSBlKEEnJ3MJUar/jrXC2tiMQ=;
 b=Rw3O+TJaAjbsuB2i4lVQaDiFlxtJ0gpzGadOmKwPLFhah+djLCUla+S80sxPvAekmdRLV4
 cEP4zwPuoK2AmOhgSDmo8wSpQxXgZ7+QzbAWXpXKRQEjR0fi7Qsgph4l5PpjPRELeZ1LGd
 +yC2L28PaGIjkjFr6YGQiHGDL0y5FdY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-R4sqTIZPP7u2e0ubHNXNdw-1; Tue,
 12 Aug 2025 06:01:15 -0400
X-MC-Unique: R4sqTIZPP7u2e0ubHNXNdw-1
X-Mimecast-MFC-AGG-ID: R4sqTIZPP7u2e0ubHNXNdw_1754992874
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 893511800292; Tue, 12 Aug 2025 10:01:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.64])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC5C7180028A; Tue, 12 Aug 2025 10:01:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 47B9F18000B4; Tue, 12 Aug 2025 12:01:11 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 ZDI <zdi-disclosures@trendmicro.com>
Subject: [PULL 1/4] hw/uefi: clear uefi-vars buffer in uefi_vars_write callback
Date: Tue, 12 Aug 2025 12:01:07 +0200
Message-ID: <20250812100111.1520917-2-kraxel@redhat.com>
In-Reply-To: <20250812100111.1520917-1-kraxel@redhat.com>
References: <20250812100111.1520917-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
---
 hw/uefi/var-service-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/uefi/var-service-core.c b/hw/uefi/var-service-core.c
index feec5a59583b..6ab8df091aaf 100644
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


