Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECCDEA8531
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 16:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzGcY-0001Pb-U1; Sun, 08 Mar 2026 12:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1vzGcR-0001If-GZ
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 12:04:41 -0400
Received: from v54.v54282eed.euw1.send.eu.mailgun.net ([185.250.239.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1vzGcP-0001DX-1p
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 12:04:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt;
 s=email; t=1772985872; x=1772993072; 
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Subject:
 Cc: To: To: From: From: Sender: Sender; 
 bh=dJ2R1CMjxYo7prT2KJ7Frt04kJRwhDOvWhu8+GuKbMI=;
 b=Ln7tZ7R43s/oa0M8VIrvK64uoibdwVhU7vdmQVtR5PZfX8jFssdk38aLCIE6nEZsWOCNhnDqz4PwgK1ju6HigfoOtEKv9GXyQj20FpXmtGq7zo2WbuyzQwLGhVLSis7NVBDADfBl1gJn1o66XxbnV4aVdMZ3aKNZtGIsSFYxGgf5Jn9dJWdATzB9URXoGWUceOHeDsgdRLPntYa3hK97fnEc0mNyDVA2BDFzFXPvcDmm0fKRFH+qr2vhtWZly+llK3en00qCNnd3imcyTLnieZ/+33p7cGaEz30YPlrn/cTKX2vWXGhiZxCUFs0lTGPl4df0duthP1/rG6eykdxh2A==
X-Mailgun-Sid: WyJiNjdhNCIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjU0ZWY0Il0=
Received: from fedora (pub158181109038.dh-hfc.datazug.ch [158.181.109.38]) by
 820e6a982281072c0d8054a8b0ebf264f6462bee9871bbd6a674b9b471d2980c
 with SMTP id 69ad9e1089b476602e9875fd; Sun, 08 Mar 2026 16:04:32 GMT
X-Mailgun-Sending-Ip: 185.250.239.4
From: Alessandro Ratti <alessandro@0x65c.net>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, berrange@redhat.com, mst@redhat.com,
 pbonzini@redhat.com, Alessandro Ratti <alessandro@0x65c.net>
Subject: [PATCH] qdev: Consolidate qdev_get_human_name() into
 qdev_get_printable_name()
Date: Sun,  8 Mar 2026 17:00:41 +0100
Message-ID: <20260308160040.354186-2-alessandro@0x65c.net>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.250.239.4;
 envelope-from=bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net;
 helo=v54.v54282eed.euw1.send.eu.mailgun.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hello,

This patch consolidates qdev_get_human_name() and qdev_get_printable_name()
into a single function, as suggested by Peter Maydell here [1]

This patch is based on Peter's recent series and should be applied after [2]:
- "hw/qdev: Document qdev_get_dev_path()"  
- "hw: Make qdev_get_printable_name() consistently return freeable string"

Thank you for your time and consideration.

Best regards
Alessandro

[1]: https://lore.kernel.org/qemu-devel/aNLIHOwcGB47qbUY@redhat.com/T/#m89da9b4e30b7c84713ca4b6c323514c72897e649
[2]: https://lore.kernel.org/qemu-devel/20260307155046.3940197-1-peter.maydell@linaro.org/T/#m962127cb58192e0b2095039cb2fb79145f2a7388

---
Remove qdev_get_human_name() and use qdev_get_printable_name() for all
device identification in error messages.

Both functions now behave similarly, with qdev_get_printable_name()
preferring bus-specific paths (e.g., PCI addresses) when available
before falling back to QOM canonical paths. This provides better
context in error messages while maintaining the same level of detail.

Error messages will now show device identifiers in this priority:
1. User-specified device IDs (e.g., -device virtio-blk,id=foo)
2. Bus-specific identifiers (e.g., PCI addresses like 0000:00:04.0)
3. QOM canonical paths as a last resort

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
---
 hw/block/block.c       |  5 ++---
 hw/core/qdev.c         | 19 ++++++++-----------
 include/hw/core/qdev.h | 13 -------------
 3 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/hw/block/block.c b/hw/block/block.c
index f187fa025d..84e5298e2f 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -65,7 +65,6 @@ bool blk_check_size_and_read_all(BlockBackend *blk, DeviceState *dev,
 {
     int64_t blk_len;
     int ret;
-    g_autofree char *dev_id = NULL;
 
     if (cpr_is_incoming()) {
         return true;
@@ -78,7 +77,7 @@ bool blk_check_size_and_read_all(BlockBackend *blk, DeviceState *dev,
         return false;
     }
     if (blk_len != size) {
-        dev_id = qdev_get_human_name(dev);
+        g_autofree const char *dev_id = qdev_get_printable_name(dev);
         error_setg(errp, "%s device '%s' requires %" HWADDR_PRIu
                    " bytes, %s block backend provides %" PRIu64 " bytes",
                    object_get_typename(OBJECT(dev)), dev_id, size,
@@ -95,7 +94,7 @@ bool blk_check_size_and_read_all(BlockBackend *blk, DeviceState *dev,
     assert(size <= BDRV_REQUEST_MAX_BYTES);
     ret = blk_pread_nonzeroes(blk, size, buf);
     if (ret < 0) {
-        dev_id = qdev_get_human_name(dev);
+        g_autofree const char *dev_id = qdev_get_printable_name(dev);
         error_setg_errno(errp, -ret, "can't read %s block backend"
                          " for %s device '%s'",
                          blk_name(blk), object_get_typename(OBJECT(dev)),
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index e48616b2c6..9ee98a0c39 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -434,10 +434,15 @@ const char *qdev_get_printable_name(DeviceState *vdev)
     }
 
     /*
-     * Final fallback: if all else fails, return a placeholder string.
-     * This ensures the error message always contains a valid string.
+     * Final fallback: return the canonical QOM path.
+     * While verbose (e.g., /machine/peripheral-anon/device[0]), this
+     * provides accurate device identification when neither a user-specified
+     * ID nor a bus-specific path is available. Only falls back to
+     * <unknown device> in the extremely rare case where even the QOM
+     * path is unavailable.
      */
-    return g_strdup("<unknown device>");
+    char *qom_path = object_get_canonical_path(OBJECT(vdev));
+    return qom_path ? qom_path : g_strdup("<unknown device>");
 }
 
 void qdev_add_unplug_blocker(DeviceState *dev, Error *reason)
@@ -867,14 +872,6 @@ Object *machine_get_container(const char *name)
     return container;
 }
 
-char *qdev_get_human_name(DeviceState *dev)
-{
-    g_assert(dev != NULL);
-
-    return dev->id ?
-           g_strdup(dev->id) : object_get_canonical_path(OBJECT(dev));
-}
-
 static MachineInitPhase machine_phase;
 
 bool phase_check(MachineInitPhase phase)
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index f99a8979cc..09dafd3d59 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -1045,19 +1045,6 @@ void qdev_create_fake_machine(void);
  */
 Object *machine_get_container(const char *name);
 
-/**
- * qdev_get_human_name() - Return a human-readable name for a device
- * @dev: The device. Must be a valid and non-NULL pointer.
- *
- * .. note::
- *    This function is intended for user friendly error messages.
- *
- * Returns: A newly allocated string containing the device id if not null,
- * else the object canonical path.
- *
- * Use g_free() to free it.
- */
-char *qdev_get_human_name(DeviceState *dev);
 
 /* FIXME: make this a link<> */
 bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp);
-- 
2.53.0


