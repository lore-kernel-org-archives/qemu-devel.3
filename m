Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFD4C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 07:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA1xF-0001tb-70; Wed, 30 Apr 2025 03:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uA1x5-0001rc-TV
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 03:33:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uA1x3-0005Ad-0h
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 03:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745998430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TRtlN03Xk9j6x08OjywlsF2iAH94kppZyXL1dqptxdE=;
 b=LxOkAFZIX0FgCZeghskOigGYkpRj4jqDPDugVw8pi+4mdXVgSZo50y4DejMb0Gs5hE0HAT
 FYUcWx8nghj5TYRXvaQXeKKwcvzpYI4UxDbf9885nn1PmQXKmZCZ22PZw3C8n1Iq3rS17e
 OyAF41NY6hzSCChHKAvdTUVouIU5oYo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-vUMCGGM6MHOaNMru3K_Kzw-1; Wed,
 30 Apr 2025 03:33:48 -0400
X-MC-Unique: vUMCGGM6MHOaNMru3K_Kzw-1
X-Mimecast-MFC-AGG-ID: vUMCGGM6MHOaNMru3K_Kzw_1745998427
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E7E91800879; Wed, 30 Apr 2025 07:33:47 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.195])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 24BBB1800352; Wed, 30 Apr 2025 07:33:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] tests/qtest/libqos: Avoid double swapping when using modern
 virtio
Date: Wed, 30 Apr 2025 09:33:43 +0200
Message-ID: <20250430073343.526867-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

The logic in the qvirtio_read/write function is rather a headache,
involving byte-swapping when the target is big endian, just to
maybe involve another byte-swapping  in the qtest_read/write
function immediately afterwards (on the QEMU side). Let's do it in
a more obvious way here: For virtio 1.0, we know that the values have
to be little endian, so let's read/write the bytes in that well known
order here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 This also decreases our usage of qtest_big_endian() which might (or
 might not) get helpful for the universal binary one day...

 tests/qtest/libqos/virtio.c | 61 ++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 17 deletions(-)

diff --git a/tests/qtest/libqos/virtio.c b/tests/qtest/libqos/virtio.c
index 2e7979652fd..078adf3c8dc 100644
--- a/tests/qtest/libqos/virtio.c
+++ b/tests/qtest/libqos/virtio.c
@@ -25,49 +25,76 @@
  */
 static uint16_t qvirtio_readw(QVirtioDevice *d, QTestState *qts, uint64_t addr)
 {
-    uint16_t val = qtest_readw(qts, addr);
+    uint8_t buf[2];
 
-    if (d->features & (1ull << VIRTIO_F_VERSION_1) && qtest_big_endian(qts)) {
-        val = bswap16(val);
+    if (d->features & (1ull << VIRTIO_F_VERSION_1)) {
+        qtest_memread(qts, addr, buf, sizeof(buf));
+        return (buf[1] << 8) | buf[0];
+    } else {
+        return qtest_readw(qts, addr);
     }
-    return val;
 }
 
 static uint32_t qvirtio_readl(QVirtioDevice *d, QTestState *qts, uint64_t addr)
 {
-    uint32_t val = qtest_readl(qts, addr);
+    uint8_t buf[4];
 
-    if (d->features & (1ull << VIRTIO_F_VERSION_1) && qtest_big_endian(qts)) {
-        val = bswap32(val);
+    if (d->features & (1ull << VIRTIO_F_VERSION_1)) {
+        qtest_memread(qts, addr, buf, sizeof(buf));
+        return (buf[3] << 24) | (buf[2] << 16) | (buf[1] << 8) | buf[0];
+    } else {
+        return qtest_readl(qts, addr);
     }
-    return val;
 }
 
 static void qvirtio_writew(QVirtioDevice *d, QTestState *qts,
                            uint64_t addr, uint16_t val)
 {
-    if (d->features & (1ull << VIRTIO_F_VERSION_1) && qtest_big_endian(qts)) {
-        val = bswap16(val);
+    uint8_t buf[2];
+
+    if (d->features & (1ull << VIRTIO_F_VERSION_1)) {
+        buf[0] = val;
+        buf[1] = val >> 8;
+        qtest_memwrite(qts, addr, buf, sizeof(buf));
+    } else {
+        qtest_writew(qts, addr, val);
     }
-    qtest_writew(qts, addr, val);
 }
 
 static void qvirtio_writel(QVirtioDevice *d, QTestState *qts,
                            uint64_t addr, uint32_t val)
 {
-    if (d->features & (1ull << VIRTIO_F_VERSION_1) && qtest_big_endian(qts)) {
-        val = bswap32(val);
+    uint8_t buf[4];
+
+    if (d->features & (1ull << VIRTIO_F_VERSION_1)) {
+        buf[0] = val;
+        buf[1] = val >> 8;
+        buf[2] = val >> 16;
+        buf[3] = val >> 24;
+        qtest_memwrite(qts, addr, buf, sizeof(buf));
+    } else {
+        qtest_writel(qts, addr, val);
     }
-    qtest_writel(qts, addr, val);
 }
 
 static void qvirtio_writeq(QVirtioDevice *d, QTestState *qts,
                            uint64_t addr, uint64_t val)
 {
-    if (d->features & (1ull << VIRTIO_F_VERSION_1) && qtest_big_endian(qts)) {
-        val = bswap64(val);
+    uint8_t buf[8];
+
+    if (d->features & (1ull << VIRTIO_F_VERSION_1)) {
+        buf[0] = val;
+        buf[1] = val >> 8;
+        buf[2] = val >> 16;
+        buf[3] = val >> 24;
+        buf[4] = val >> 32;
+        buf[5] = val >> 40;
+        buf[6] = val >> 48;
+        buf[7] = val >> 56;
+        qtest_memwrite(qts, addr, buf, sizeof(buf));
+    } else {
+        qtest_writeq(qts, addr, val);
     }
-    qtest_writeq(qts, addr, val);
 }
 
 uint8_t qvirtio_config_readb(QVirtioDevice *d, uint64_t addr)
-- 
2.49.0


