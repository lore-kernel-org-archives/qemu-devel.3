Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F6CC79F8C
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 12:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vck8M-0003kb-5z; Mon, 05 Jan 2026 07:56:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck8I-0003is-AG
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:56:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck8F-0007WW-9Y
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:56:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767617782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YVC0io8V1/7I6Ovz7Uc7Z6X6LdwYayG3/6XfBBUwGQo=;
 b=FsPooHYkAW1T953orjsaBU1OKE1xKOqX5SRvsWSwYRyMtSWxFRTibmQ8xCjrKfrWH43dvS
 /IkELTW61I7yC1GFCUcoP0NhAdM0Z5zKrPqhe988/1URkq23BiodMZ0thQ9EbsPKJKgQ39
 PgKgO/2lsnFp+Jc1AA/nMBJ+bWi/U5E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-FuazBHxzNaK7bVrur4cIvg-1; Mon,
 05 Jan 2026 07:56:20 -0500
X-MC-Unique: FuazBHxzNaK7bVrur4cIvg-1
X-Mimecast-MFC-AGG-ID: FuazBHxzNaK7bVrur4cIvg_1767617780
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BAC8C195605A; Mon,  5 Jan 2026 12:56:19 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2A16619560A7; Mon,  5 Jan 2026 12:56:17 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 01/36] hw/block/m25p80: Add SFDP table for Winbond W25Q02JVM
 flash
Date: Mon,  5 Jan 2026 13:55:38 +0100
Message-ID: <20260105125613.622667-2-clg@redhat.com>
In-Reply-To: <20260105125613.622667-1-clg@redhat.com>
References: <20260105125613.622667-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Add the SFDP data table for Winbond W25Q02JVM flash device. The table
was generated under Linux kernel by dumping the SFDP content using
the following command:

```
hexdump -v -e '8/1 "0x%02x, " "\n"' \
    /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
```

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251112030553.291734-3-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/block/m25p80_sfdp.h |  1 +
 hw/block/m25p80.c      |  2 ++
 hw/block/m25p80_sfdp.c | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/hw/block/m25p80_sfdp.h b/hw/block/m25p80_sfdp.h
index 35785686a0ec..c1e532de5aeb 100644
--- a/hw/block/m25p80_sfdp.h
+++ b/hw/block/m25p80_sfdp.h
@@ -27,6 +27,7 @@ uint8_t m25p80_sfdp_w25q256(uint32_t addr);
 uint8_t m25p80_sfdp_w25q512jv(uint32_t addr);
 uint8_t m25p80_sfdp_w25q80bl(uint32_t addr);
 uint8_t m25p80_sfdp_w25q01jvq(uint32_t addr);
+uint8_t m25p80_sfdp_w25q02jvm(uint32_t addr);
 
 uint8_t m25p80_sfdp_is25wp256(uint32_t addr);
 
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 4a758f83dc7c..b8a2543c0bdc 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -364,6 +364,8 @@ static const FlashPartInfo known_devices[] = {
       .sfdp_read = m25p80_sfdp_w25q512jv },
     { INFO("w25q01jvq",   0xef4021,      0,  64 << 10, 2048, ER_4K),
       .sfdp_read = m25p80_sfdp_w25q01jvq },
+    { INFO("w25q02jvm",   0xef7022,      0,  64 << 10, 4096, ER_4K),
+      .sfdp_read = m25p80_sfdp_w25q02jvm },
 
     /* Microchip */
     { INFO("25csm04",      0x29cc00,      0x100,  64 << 10,  8, 0) },
diff --git a/hw/block/m25p80_sfdp.c b/hw/block/m25p80_sfdp.c
index a03a291a09b5..87878c2bf0fa 100644
--- a/hw/block/m25p80_sfdp.c
+++ b/hw/block/m25p80_sfdp.c
@@ -440,6 +440,42 @@ static const uint8_t sfdp_w25q80bl[] = {
 };
 define_sfdp_read(w25q80bl);
 
+static const uint8_t sfdp_w25q02jvm[] = {
+    0x53, 0x46, 0x44, 0x50, 0x06, 0x01, 0x01, 0xff,
+    0x00, 0x06, 0x01, 0x10, 0x80, 0x00, 0x00, 0xff,
+    0x84, 0x00, 0x01, 0x02, 0xd0, 0x00, 0x00, 0xff,
+    0x03, 0x00, 0x01, 0x02, 0xf0, 0x00, 0x00, 0xff,
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
+    0xe5, 0x20, 0xfb, 0xff, 0xff, 0xff, 0xff, 0x7f,
+    0x44, 0xeb, 0x08, 0x6b, 0x08, 0x3b, 0x42, 0xbb,
+    0xfe, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
+    0xff, 0xff, 0x40, 0xeb, 0x0c, 0x20, 0x0f, 0x52,
+    0x10, 0xd8, 0x00, 0x00, 0x36, 0x02, 0xa6, 0x00,
+    0x82, 0xea, 0x14, 0xe2, 0xe9, 0x63, 0x76, 0x33,
+    0x7a, 0x75, 0x7a, 0x75, 0xf7, 0xa2, 0xd5, 0x5c,
+    0x19, 0xf7, 0x4d, 0xff, 0xe9, 0x70, 0xf9, 0xa5,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0x0a, 0xf0, 0xff, 0x21, 0xff, 0xdc, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+};
+define_sfdp_read(w25q02jvm);
+
 /*
  * Integrated Silicon Solution (ISSI)
  */
-- 
2.52.0


