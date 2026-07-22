Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B0DC44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 11:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmVT1-0000TZ-1o; Wed, 22 Jul 2026 07:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wmVSu-0000Qs-RW
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 07:50:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wmVSs-000237-HH
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 07:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784721017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=AVGSHleBfORJOvg313j5rY9Ke5yvZQg2KXDx+RC4Ios=;
 b=E3ffwKOoW9bOZyYtxSiFk0Pakin1SnDYo7GPxw6t8Hwqr5xvOE9FJIbQi+r8Hz82KlW/gM
 65ORiA+BZ2h/jHIx6m0v0Nhf2/hUllwJaGy+oSEX94xv8xckg2yPt1pIdRL+WkRaJkLqEu
 vNvC2YjI8Nxu1gpMlEfAst1QoJc9p3Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-QFCCemoUOV6IXZm0XTF4dQ-1; Wed,
 22 Jul 2026 07:50:14 -0400
X-MC-Unique: QFCCemoUOV6IXZm0XTF4dQ-1
X-Mimecast-MFC-AGG-ID: QFCCemoUOV6IXZm0XTF4dQ_1784721013
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EFFE182A110; Wed, 22 Jul 2026 11:50:13 +0000 (UTC)
Received: from lenovo-t14s.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 52C853004082; Wed, 22 Jul 2026 11:50:09 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH] hw/net/virtio-net: check packet size before VLAN tag access
 in receive_filter()
Date: Wed, 22 Jul 2026 13:50:08 +0200
Message-ID: <20260722115008.1570510-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=lvivier@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

receive_filter() reads ptr[14..15] to extract the VLAN ID without
checking the packet is large enough. A short frame with VLAN TPID
at bytes 12-13 but no VLAN TCI causes a 2-byte out-of-bounds read.

Add size checks before accessing the Ethernet header and the VLAN
tag fields.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3788
Fixes: f21c0ed97c97 ("qemu:virtio-net: Add VLAN filtering (Alex Williamson)")
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/net/virtio-net.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index f0e3beb29032..b5b4f025c7c9 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1745,9 +1745,20 @@ static int receive_filter(VirtIONet *n, const uint8_t *buf, int size)
         return 1;
 
     ptr += n->host_hdr_len;
+    size -= n->host_hdr_len;
+
+    if (size < sizeof(struct eth_header)) {
+        return 0;
+    }
 
     if (!memcmp(&ptr[12], vlan, sizeof(vlan))) {
-        int vid = lduw_be_p(ptr + 14) & 0xfff;
+        int vid;
+
+        if (size < 16) {
+            return 0;
+        }
+
+        vid = lduw_be_p(ptr + 14) & 0xfff;
         if (!(n->vlans[vid >> 5] & (1U << (vid & 0x1f))))
             return 0;
     }
-- 
2.54.0


