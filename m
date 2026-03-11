Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8D5103E2E9
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 21:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0RRl-0003Q8-PV; Wed, 11 Mar 2026 17:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1w0RRj-0003Pi-3d
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 17:50:27 -0400
Received: from v54.v54282eed.euw1.send.eu.mailgun.net ([185.250.239.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1w0RRe-0000pS-2K
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 17:50:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt;
 s=email; t=1773265817; x=1773273017; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender; 
 bh=7ULm3lnL97ovESWdrTPJzjzFHX6YYBenCeG4JXSX7uE=;
 b=nU8yf7u0XzxBvMIG/C8adRgF6Fjus4CTaLFWRiIBBjaF6Qd15UOLEvy9T2Locqctscae6l3wFda8zqmYzQ2htcEe+ZUJ3DBkg20JSxk/WICGrl4WlD981VNG6ZdCidrhoHtZOZshqPEqdW3cpt9n0d3DV+/5S24UEz2Vtc4wi9VpnCQHGOc7Cfk2MX3GrFUaKLFVJYvsrN9DOVYk1Rx3HrpcNotOTItBMBOESxOhS51U937lMWyFIfZxpqsCIdH2DHJZEFbswFzb19JkLsoOl85Ej/D9LPuUDlNTajZixqrw1qoqNPbjY/pBvEPiD8ozAv9lQpE/2bMthd7EOzhovA==
X-Mailgun-Sid: WyJiNjdhNCIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjU0ZWY0Il0=
Received: from fedora (pub158181109038.dh-hfc.datazug.ch [158.181.109.38]) by
 712eb054bc9015b0ebda65af28a98072b50f328f288845fcd2556865c8031c9b
 with SMTP id 69b1e399ad2ee93738937675; Wed, 11 Mar 2026 21:50:17 GMT
X-Mailgun-Sending-Ip: 185.250.239.4
From: Alessandro Ratti <alessandro@0x65c.net>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, peter.maydell@linaro.org, berrange@redhat.com,
 mst@redhat.com, pbonzini@redhat.com,
 Alessandro Ratti <alessandro@0x65c.net>
Subject: [PATCH v2 1/2] hw/qdev: Clarify fallback order in
 qdev_get_printable_name()
Date: Wed, 11 Mar 2026 22:50:02 +0100
Message-ID: <20260311215003.664815-2-alessandro@0x65c.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311215003.664815-1-alessandro@0x65c.net>
References: <20260311215003.664815-1-alessandro@0x65c.net>
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
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Replace the uninformative "<unknown device>" final fallback with the
canonical QOM path (e.g. /machine/peripheral-anon/device[0]).

Also clean up comments to accurately describe qdev_get_dev_path()
behavior, drop an unnecessary comment on the dev->id check, rename
the @vdev parameter to @dev for consistency with surrounding code,
and add g_assert(dev) to match qdev_get_human_name()'s precondition.

Update the doc comment in qdev.h to reflect the new fallback chain.

Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
---
 hw/core/qdev.c         | 29 ++++++++++++-----------------
 include/hw/core/qdev.h | 11 +++++------
 2 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index e48616b2c6..f9fb7966dd 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -411,33 +411,28 @@ char *qdev_get_dev_path(DeviceState *dev)
     return NULL;
 }
 
-const char *qdev_get_printable_name(DeviceState *vdev)
+const char *qdev_get_printable_name(DeviceState *dev)
 {
-    /*
-     * Return device ID if explicity set
-     * (e.g. -device virtio-blk-pci,id=foo)
-     * This allows users to correlate errors with their custom device
-     * names.
-     */
-    if (vdev->id) {
-        return g_strdup(vdev->id);
+    g_assert(dev != NULL);
+
+    if (dev->id) {
+        return g_strdup(dev->id);
     }
+
     /*
-     * Fall back to the canonical QOM device path (eg. ID for PCI
-     * devices).
-     * This ensures the device is still uniquely and meaningfully
-     * identified.
+     * Fall back to a bus-specific device path, if the bus
+     * provides one (e.g. PCI address "0000:00:04.0").
      */
-    const char *path = qdev_get_dev_path(vdev);
+    const char *path = qdev_get_dev_path(dev);
     if (path) {
         return path;
     }
 
     /*
-     * Final fallback: if all else fails, return a placeholder string.
-     * This ensures the error message always contains a valid string.
+     * Final fallback: return the canonical QOM path
+     * (e.g. /machine/peripheral-anon/device[0]).
      */
-    return g_strdup("<unknown device>");
+    return object_get_canonical_path(OBJECT(dev));
 }
 
 void qdev_add_unplug_blocker(DeviceState *dev, Error *reason)
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index f99a8979cc..2da7327144 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -1087,18 +1087,17 @@ char *qdev_get_dev_path(DeviceState *dev);
 
 /**
  * qdev_get_printable_name: Return human readable name for device
- * @dev: Device to get name of
+ * @dev: Device to get name of. Must not be NULL.
  *
  * Returns: A newly allocated string containing some human
  * readable name for the device, suitable for printing in
- * user-facing error messages. The function will never return NULL,
- * so the name can be used without further checking or fallbacks.
+ * user-facing error messages.
  *
  * If the device has an explicitly set ID (e.g. by the user on the
  * command line via "-device thisdev,id=myid") this is preferred.
- * Otherwise we try the canonical QOM device path (which will be
- * the PCI ID for PCI devices, for example). If all else fails
- * we will return the placeholder "<unknown device">.
+ * Otherwise we try the bus-specific device path (which will be
+ * the PCI address for PCI devices, for example). If all else fails
+ * we return the canonical QOM path.
  */
 const char *qdev_get_printable_name(DeviceState *dev);
 
-- 
2.53.0


