Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C96CCF2CF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI9Zz-0008KR-DU; Sat, 17 Oct 2026 14:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9Zg-0008Bt-BR; Sat, 17 Oct 2026 14:56:11 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9Ze-0003bQ-9m; Sat, 17 Oct 2026 14:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792263359; bh=VizHhZ8is8WAjfuxExgoMd5lQnEZNAOVdpL1b1WDjpo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VYRBeAl8eedi7YOWloGFThKpkieyK7sd+4TApO9gCfduWy4NsaupqHPRX1AI0c8rb
 V6xqaY7bnwCosHYYjDnt/Zn5FXx+/+WTT5XyIxHMvuKrU2bwHDRFA/Ok6WcLPTaO23
 FqhgRWQJU9oK7/a+ehgwsa5LWkYIlhMf7ZavO4t1c6QVP1i26GMJMaNk0uMmd9MoME
 y9UupNrrZ6jbVhduv5I3555A/K8IC/UmmxAqzrdJ4sBvGxMDc8XHGTR2Qrk+H5a7Nr
 g4iuTntbu+5VT/n1ExaDx99/SZyMpBSsT1wDNjDCMseSGi9ySabgl1kXE22DHCrqou
 XrdB3NxRgHpcA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 204E31DE6A5;
 Sat, 17 Oct 2026 21:55:59 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0B97C443370;
 Sat, 17 Oct 2026 21:55:57 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 05/63] virtio-ccw: Limit ISC to MAX_ISC
Date: Sat, 17 Oct 2026 21:54:21 +0300
Message-ID: <20261017185528.722197-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
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

From: Eric Farman <farman@linux.ibm.com>

The interrupt subclass is often defined as a uint8, though in practice
it will be within the range of just 0-7. Ensure that a guest-supplied
subclass does not extend beyond its expected range, especially when
used as an array index.

Cc: qemu-stable@nongnu.org
Fixes: 25a08b8ded ("s390x/css: update css_adapter_interrupt")
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260922201526.2383047-2-farman@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit 92b935de2709cdbb1c4ee2b48814640a71e8a438)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 991fc12608..79a6c90175 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -680,8 +680,13 @@ void css_adapter_interrupt(CssIoAdapterType type, uint8_t isc)
     S390FLICState *fs = s390_get_flic();
     S390FLICStateClass *fsc = s390_get_flic_class(fs);
     uint32_t io_int_word = (isc << 27) | IO_INT_WORD_AI;
-    IoAdapter *adapter = channel_subsys.io_adapters[type][isc];
+    IoAdapter *adapter;
+
+    if (type >= CSS_IO_ADAPTER_TYPE_NUMS || isc > MAX_ISC) {
+        return;
+    }
 
+    adapter = channel_subsys.io_adapters[type][isc];
     if (!adapter) {
         return;
     }
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 43f3b162c8..5d7112b028 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -44,6 +44,10 @@ static int virtio_ccw_dev_post_load(void *opaque, int version_id)
     CcwDevice *ccw_dev = CCW_DEVICE(dev);
     CCWDeviceClass *ck = CCW_DEVICE_GET_CLASS(ccw_dev);
 
+    if (dev->thinint_isc > MAX_ISC) {
+        return -EINVAL;
+    }
+
     ccw_dev->sch->driver_data = dev;
     if (ccw_dev->sch->thinint_active) {
         dev->routes.adapter.adapter_id = css_get_adapter_id(
@@ -657,6 +661,8 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
         } else {
             if (ccw_dstream_read(&sch->cds, thinint)) {
                 ret = -EFAULT;
+            } else if (thinint.isc > MAX_ISC) {
+                ret = -ENOSYS;
             } else {
                 thinint.ind_bit = be64_to_cpu(thinint.ind_bit);
                 thinint.summary_indicator =
-- 
2.47.3


