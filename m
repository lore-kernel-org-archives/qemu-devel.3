Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0C7C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6lsG-0000pV-Ho; Wed, 16 Sep 2026 05:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1x6lsC-0000ol-Ji
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 05:24:12 -0400
Received: from [115.124.30.118] (helo=out30-118.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1x6ls8-0000vq-6o
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 05:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1789550624; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=TzcpWbB/mywt4qFXfS07N55BJh8v9Pgt50EmE+fPLd4=;
 b=L1oLS2nrBjh44SxaahHoNlbqkiSHlOFr8y9zNHud6MsLEKvAeVIqOgtE7+dUEN9ZhZfbVa0764mUV6eMeCdQlVcM9Lq3uk8FD7v+h8o7ldtvptORwpg5gNVi3o7Vg7n/jnJYbML6UEZpYhLm2d19SZbZUVKPSHi8EcCvA1ESMRI=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R761e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=1; SR=0;
 TI=SMTPD_---0XB4b6Di_1789550623; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0XB4b6Di_1789550623 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 16 Sep 2026 17:23:43 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/usb/u2f: validate ring buffer indices on migration load
Date: Wed, 16 Sep 2026 17:23:42 +0800
Message-ID: <20260916092342.2447-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.118 (deferred)
Received-SPF: pass client-ip=115.124.30.118;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-118.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

The U2F key pending_in ring buffer uses uint8_t start/end/num indices
over a 32-entry array, all serialized in the vmstate.  A malicious
migration stream can inject values >= U2FHID_PENDING_IN_NUM (32),
causing an out-of-bounds heap read in u2f_pending_in_get() on the
first USB IN token after migration completes.

Add a post_load callback to validate the restored indices and reset
the ring buffer to empty on any out-of-range value.  Pending packets
are non-critical (the device will regenerate them), so resetting the
ring is preferable to rejecting migration entirely.

As defense-in-depth, also add a bounds clamp in u2f_pending_in_get()
so that even if corrupted state somehow reaches the consumer path,
the index is folded into range before array access.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4483
Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 hw/usb/u2f.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/hw/usb/u2f.c b/hw/usb/u2f.c
index d6291852f6..9ca9879f3e 100644
--- a/hw/usb/u2f.c
+++ b/hw/usb/u2f.c
@@ -228,6 +228,11 @@ static uint8_t *u2f_pending_in_get(U2FKeyState *key)
         return NULL;
     }
 
+    /* Clamp to valid range in case of corrupted state (e.g. migration) */
+    if (key->pending_in_start >= U2FHID_PENDING_IN_NUM) {
+        key->pending_in_start %= U2FHID_PENDING_IN_NUM;
+    }
+
     index = key->pending_in_start;
     key->pending_in_start = (index + 1) % U2FHID_PENDING_IN_NUM;
     --key->pending_in_num;
@@ -301,10 +306,36 @@ static void u2f_key_realize(USBDevice *dev, Error **errp)
     key->ep = usb_ep_get(dev, USB_TOKEN_IN, 1);
 }
 
+static int u2f_key_post_load(void *opaque, int version_id)
+{
+    U2FKeyState *key = opaque;
+
+    /*
+     * Validate pending_in ring buffer indices restored from the migration
+     * stream.  An attacker-controlled stream could inject values >= 32
+     * (U2FHID_PENDING_IN_NUM), causing out-of-bounds heap access in
+     * u2f_pending_in_get() on the first IN token after migration.
+     *
+     * Reset the ring on any invalid value: pending packets are non-critical
+     * (they will be regenerated by the device), so rejecting migration
+     * entirely is not necessary.
+     */
+    if (key->pending_in_start >= U2FHID_PENDING_IN_NUM ||
+        key->pending_in_end >= U2FHID_PENDING_IN_NUM ||
+        key->pending_in_num > U2FHID_PENDING_IN_NUM) {
+        key->pending_in_start = 0;
+        key->pending_in_end = 0;
+        key->pending_in_num = 0;
+    }
+
+    return 0;
+}
+
 const VMStateDescription vmstate_u2f_key = {
     .name = "u2f-key",
     .version_id = 1,
     .minimum_version_id = 1,
+    .post_load = u2f_key_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_USB_DEVICE(dev, U2FKeyState),
         VMSTATE_UINT8(idle, U2FKeyState),
-- 
2.50.1 (Apple Git-155)


