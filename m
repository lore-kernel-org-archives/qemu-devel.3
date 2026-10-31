Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EC4606A31C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 06:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZK652bPt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN33C-0002bL-UH; Sat, 31 Oct 2026 02:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN33B-0002aw-93
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:58:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN338-0002iv-4G
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793429925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c+1AVwNJCpsulXVGbjhiPPmj53nq4PCAXr5SNS1DESA=;
 b=ZK652bPt0OHEo/AQpbu2z0s4fR6Dra5EIDd7yO3CaTZXYk3lGL6SFPuSIQz5fi/QviGbyI
 eLrl1qd1L+nOdzpkzZzZ3YpGEiEtS4twe2XJvxjnw58IaZwmaUM4s2HKHjw9f/hIEDirvv
 LKeUfQBUon5LWd0YDbyrxqtuQPSpruA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-ymMFp7ZmMsy2qhNLbQ3d3g-1; Sat,
 31 Oct 2026 02:58:43 -0400
X-MC-Unique: ymMFp7ZmMsy2qhNLbQ3d3g-1
X-Mimecast-MFC-AGG-ID: ymMFp7ZmMsy2qhNLbQ3d3g_1793429922
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03EB01956051; Sat, 31 Oct 2026 06:58:42 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E77831800677; Sat, 31 Oct 2026 06:58:39 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 03/34] hw/block/m25p80: Add Winbond W25Q33PW flash
Date: Sat, 31 Oct 2026 07:57:52 +0100
Message-ID: <20261031065823.191966-4-clg@redhat.com>
In-Reply-To: <20261031065823.191966-1-clg@redhat.com>
References: <20261031065823.191966-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jamin Lin <jamin_lin@aspeedtech.com>

The W25Q32DW and W25Q33PW use the same JEDEC ID (0xef6016), but
have different part names.

Add the SFDP data table for the Winbond W25Q33PW flash device. The table
was generated from a real device under Linux by dumping the SFDP content
using the following command:

Example:

```
hexdump -v -e '8/1 "0x%02x, " "\n"' \
    /sys/bus/spi/devices/spi1.0/spi-nor/sfdp
```

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261028023154.48395-4-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/block/m25p80_sfdp.h |  1 +
 hw/block/m25p80.c      |  2 ++
 hw/block/m25p80_sfdp.c | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/hw/block/m25p80_sfdp.h b/hw/block/m25p80_sfdp.h
index c1e532de5aeb..61544fb7cc69 100644
--- a/hw/block/m25p80_sfdp.h
+++ b/hw/block/m25p80_sfdp.h
@@ -23,6 +23,7 @@ uint8_t m25p80_sfdp_mx25l25635e(uint32_t addr);
 uint8_t m25p80_sfdp_mx25l25635f(uint32_t addr);
 uint8_t m25p80_sfdp_mx66l1g45g(uint32_t addr);
 
+uint8_t m25p80_sfdp_w25q33pw(uint32_t addr);
 uint8_t m25p80_sfdp_w25q256(uint32_t addr);
 uint8_t m25p80_sfdp_w25q512jv(uint32_t addr);
 uint8_t m25p80_sfdp_w25q80bl(uint32_t addr);
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 545e0b572859..baf798c6b5cc 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -354,6 +354,8 @@ static const FlashPartInfo known_devices[] = {
     { INFO("w25x32",      0xef3016,      0,  64 << 10,  64, ER_4K) },
     { INFO("w25q32",      0xef4016,      0,  64 << 10,  64, ER_4K) },
     { INFO("w25q32dw",    0xef6016,      0,  64 << 10,  64, ER_4K) },
+    { INFO("w25q33pw",    0xef6016,      0,  64 << 10,  64, ER_4K | ER_32K),
+      .sfdp_read = m25p80_sfdp_w25q33pw },
     { INFO("w25x64",      0xef3017,      0,  64 << 10, 128, ER_4K) },
     { INFO("w25q64",      0xef4017,      0,  64 << 10, 128, ER_4K) },
     { INFO("w25q80",      0xef5014,      0,  64 << 10,  16, ER_4K) },
diff --git a/hw/block/m25p80_sfdp.c b/hw/block/m25p80_sfdp.c
index 87878c2bf0fa..8ac603e21267 100644
--- a/hw/block/m25p80_sfdp.c
+++ b/hw/block/m25p80_sfdp.c
@@ -296,6 +296,42 @@ define_sfdp_read(mx66l1g45g);
  * Windbond
  */
 
+static const uint8_t sfdp_w25q33pw[] = {
+    0x53, 0x46, 0x44, 0x50, 0x0a, 0x01, 0x00, 0xff,
+    0x00, 0x08, 0x01, 0x17, 0x80, 0x00, 0x00, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xe5, 0x20, 0xf9, 0xff, 0xff, 0xff, 0xff, 0x01,
+    0x44, 0xeb, 0x08, 0x6b, 0x08, 0x3b, 0x42, 0xbb,
+    0xfe, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
+    0xff, 0xff, 0x44, 0xeb, 0x0c, 0x20, 0x0f, 0x52,
+    0x10, 0xd8, 0x00, 0x00, 0x14, 0x32, 0x01, 0x01,
+    0x81, 0xe3, 0x14, 0xc2, 0xe9, 0x63, 0x76, 0x33,
+    0x7a, 0x75, 0x7a, 0x75, 0xf7, 0xa9, 0xd5, 0x5c,
+    0x39, 0xf6, 0x6d, 0xff, 0xe9, 0x30, 0xf8, 0x80,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xac, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0xf7, 0xf5, 0xff, 0xff,
+    0x0f, 0x00, 0x00, 0x00, 0x06, 0x0d, 0x44, 0xbd,
+    0x27, 0xed, 0x08, 0x0d, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+};
+define_sfdp_read(w25q33pw);
+
 static const uint8_t sfdp_w25q256[] = {
     0x53, 0x46, 0x44, 0x50, 0x00, 0x01, 0x00, 0xff,
     0x00, 0x00, 0x01, 0x09, 0x80, 0x00, 0x00, 0xff,
-- 
2.56.0


