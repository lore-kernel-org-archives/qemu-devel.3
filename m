Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9166A1094468
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 10:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3tBx-0003h5-Un; Sat, 21 Mar 2026 06:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1w3tBv-0003g9-Iy
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 06:04:23 -0400
Received: from v54.v54282eed.euw1.send.eu.mailgun.net ([185.250.239.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1w3tBt-0002wZ-RG
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 06:04:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt;
 s=email; t=1774087459; x=1774094659; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender; 
 bh=C6q7t67jlFGF1sb20kXq8E0dionftyjcl4lKtqCKFXw=;
 b=WxEQr3bdUWl73DkEXXZZZK8nUxeV9YTfJAKjOfMkoGl7rMQQoxQjy8npHVZGWnJbuk0ha2btw6uA6lahiOf5rE03N1RZdosesgaf5ZAPGaUdcuNAgjsfZnaa8mDG2HXieIbq5Mt5E4lg8UUfzfh/jERx/oMwkzXyRXN3AbV8FoTIpTkaGp96wGc8Wc+bnXHyT5VPYm+SsVwP4s3F8NKS+0ZS2K5ZewzNGKWmmkftZb9Fz3og8EmNY644YGvbsfEomihNhWxOs79+/mp6yR4fmLfTOxfjfuwv6oVSyt6+Anbetx1meK7jhYBK1dCjIy8G6WQ8khk1hTFSSkQCdGXOJw==
X-Mailgun-Sid: WyJiNjdhNCIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjU0ZWY0Il0=
Received: from fedora (pub158181109038.dh-hfc.datazug.ch [158.181.109.38]) by
 712eb054bc9015b0ebda65af28a98072b50f328f288845fcd2556865c8031c9b
 with SMTP id 69be6d23116b32221fb88b4c; Sat, 21 Mar 2026 10:04:19 GMT
X-Mailgun-Sending-Ip: 185.250.239.4
From: Alessandro Ratti <alessandro@0x65c.net>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, peter.maydell@linaro.org, berrange@redhat.com,
 mst@redhat.com, pbonzini@redhat.com,
 Alessandro Ratti <alessandro@0x65c.net>
Subject: [PATCH v3 2/3] hw/qdev: Prefix bus type in qdev_get_printable_name()
 device paths
Date: Sat, 21 Mar 2026 11:04:04 +0100
Message-ID: <20260321100405.1525059-3-alessandro@0x65c.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321100405.1525059-1-alessandro@0x65c.net>
References: <20260321100405.1525059-1-alessandro@0x65c.net>
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

Raw get_dev_path() output (e.g. "0000:00:04.0", "/1") is ambiguous
without knowing which bus produced it. Prefix the path with the bus
type name so error messages become self-describing.

Examples:
  - PCIE device 0000:00:04.0
  - virtio-pci-bus device 0000:00:03.0

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
---
 hw/core/qdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index c44616b4b8..904e710f8e 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -418,11 +418,13 @@ const char *qdev_get_printable_name(DeviceState *dev)
     }
     /*
      * Fall back to a bus-specific device path, if the bus
-     * provides one (e.g. PCI address "0000:00:04.0").
+     * provides one (e.g. "PCI device 0000:00:04.0").
      */
-    const char *path = qdev_get_dev_path(dev);
+    g_autofree char *path = qdev_get_dev_path(dev);
     if (path) {
-        return path;
+        const char *bus_type = object_get_typename(OBJECT(dev->parent_bus));
+        char *name = g_strdup_printf("%s device %s", bus_type, path);
+        return name;
     }
 
     return object_get_canonical_path(OBJECT(dev));
-- 
2.53.0


