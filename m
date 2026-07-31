Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154F5C55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpgFo-0002ll-Hc; Fri, 31 Jul 2026 01:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeM8-0005u7-SV; Thu, 30 Jul 2026 23:56:20 -0400
Received: from [115.124.30.112] (helo=out30-112.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <blduan@linux.alibaba.com>)
 id 1wpeM4-0002Io-L1; Thu, 30 Jul 2026 23:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1785470171; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=GQ/4VXmOCNFDf0yhmuSdsBqHH33B0VAJ2TNmvzzIRV0=;
 b=Ks+KPtX+SrBjPJ9epnoi3SwmAasSar4vft7wrOGqOx+wDe+lvplWeAo9ZkQfwxuq2t1K2d+la0dMe+5Jb9wKjcmiEkM8h5SjqR3hEKrJBZBZ7jdi4TYR8C2USnvL7I2cCYWmPdjQCIPuYvQJfkujPWQ0DQP3H9TLMUxO14/TypY=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032089153;
 MF=blduan@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0X86jwVB_1785469858; 
Received: from ea134-sw16.eng.xrvm.cn(mailfrom:blduan@linux.alibaba.com
 fp:SMTPD_---0X86jwVB_1785469858 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 31 Jul 2026 11:50:59 +0800
From: Baolong Duan <blduan@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair23@gmail.com, dbarboza@ventanamicro.com,
 cxx194832@alibaba-inc.com, zengxiangyi.zxy@alibaba-inc.com,
 Baolong Duan <blduan@linux.alibaba.com>
Subject: [RFC PATCH v1 12/17] hw/net/virtio-net: do not use vhost for a CoVE
 guest
Date: Fri, 31 Jul 2026 11:50:06 +0800
Message-Id: <20260731035011.4178103-13-blduan@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731035011.4178103-1-blduan@linux.alibaba.com>
References: <20260731035011.4178103-1-blduan@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.112 (deferred)
Received-SPF: pass client-ip=115.124.30.112;
 envelope-from=blduan@linux.alibaba.com;
 helo=out30-112.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 31 Jul 2026 01:57:33 -0400
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

The in-kernel vhost datapath has no access to the memory of a TEE VM, so
it cannot be used.

Signed-off-by: Baolong Duan <blduan@linux.alibaba.com>
---
 hw/net/virtio-net.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 814b99a43d..4f8db1a1aa 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -28,6 +28,7 @@
 #include "qemu/config-file.h"
 #include "qobject/qdict.h"
 #include "hw/virtio/virtio-net.h"
+#include "hw/riscv/cove.h"
 #include "net/vhost_net.h"
 #include "net/announce.h"
 #include "hw/virtio/virtio-bus.h"
@@ -326,6 +327,14 @@ static void virtio_net_vhost_status(VirtIONet *n, uint8_t status)
             }
         }
 
+        /*
+         * vhost cannot be used with a CoVE guest: the kernel datapath has no
+         * access to the memory of the TVM.
+         */
+        if (riscv_cove_vm_active()) {
+            return;
+        }
+
         n->vhost_started = 1;
         r = vhost_net_start(vdev, n->nic->ncs, queue_pairs, cvq);
         if (r < 0) {
-- 
2.34.1


