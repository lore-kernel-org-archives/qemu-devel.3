Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5347C606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=V6TMvQOV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTIcJ-0000mi-Ms; Tue, 17 Nov 2026 07:48:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xTIcF-0000mK-8Y
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 07:48:52 -0500
Received: from mxhk.zte.com.cn ([160.30.148.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xTIcB-0008Gt-OJ
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 07:48:51 -0500
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jTPfv6DCQz6FMyy;
 Tue, 17 Nov 2026 20:48:39 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
 s=z202610; t=1794919719;
 bh=iJ9TM0+H/rS1pkx7IQnevurTjAT9c9FM1QAc52GaBj8=;
 h=From:To:Cc:Subject:Date;
 b=V6TMvQOVJGYKnWhdPoJgkni3P82sUDzgzJ2eN67uKOyaB9Utchedvk9zhiI2VCy/C
 3rs3FqZ4OLnMUF5XOmA10hqP0nb0eJeFFU0GJ5jZXqGXC9aDX6J2XdFmK47UxXn3QA
 MKpCbwSVxk6IEYwD53Lv2UVydaCoWwRGanU5hG01ZfUOV9hYH9dcCI3cbkIJwyayxs
 jasvnAbvmR9ithzp5SpTzbpE3GRsI6Td8k46HdEhdHbz/RLX/cswnxCK+Bvu13NE4f
 QbFF0tTl2mG5h1SG4nGeeuE73+ZWjWPHvi1rxrhnlxStAV/4gjQ1Vm/WFnxGtO+UYT
 v8gPhQ6m3ERkQ==
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
 by mse-fl2.zte.com.cn with SMTP id 6AHCmTie018799;
 Tue, 17 Nov 2026 20:48:29 +0800 (+08)
 (envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
 by smtp (Zmail) with SMTP; Tue, 17 Nov 2026 20:48:32 +0800
X-Zmail-TransId: 3e816afc4d1f02e-6f5f4
X-Zmail-LocalSMTP: 1
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
X-Zmail-RealSender: wang.yechao255@zte.com.cn
From: Wang Yechao <wang.yechao255@zte.com.cn>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>
Cc: qemu-devel@nongnu.org, Wang Yechao <wang.yechao255@zte.com.cn>
Subject: [PATCH] virtio-net: drop redundant tx_queue_size clamp
Date: Tue, 17 Nov 2026 20:44:52 +0800
Message-ID: <20261117124454.3917052-1-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl2.zte.com.cn 6AHCmTie018799
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 17 Nov 2026 20:48:39 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AFC4D27.001/4jTPfv6DCQz6FMyy
Received-SPF: pass client-ip=160.30.148.34;
 envelope-from=wang.yechao255@zte.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 4271f40383 ("virtio-net: correctly report maximum
tx_queue_size value") made virtio_net_device_realize() validate
tx_queue_size against virtio_net_max_tx_queue_size(), so the value
is already guaranteed not to exceed that limit when the subsequent

    n->net_conf.tx_queue_size = MIN(virtio_net_max_tx_queue_size(n),
                                    n->net_conf.tx_queue_size);

runs.  The MIN() can therefore never lower the value and is
redundant.  Drop it.

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 hw/net/virtio-net.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 36edb768b1..5d1d2e2d7c 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -4110,9 +4110,6 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         error_printf("Defaulting to \"bh\"");
     }
 
-    n->net_conf.tx_queue_size = MIN(virtio_net_max_tx_queue_size(n),
-                                    n->net_conf.tx_queue_size);
-
     virtio_net_add_queue(n, 0);
 
     n->ctrl_vq = virtio_add_queue(vdev, 64, virtio_net_handle_ctrl);
-- 
2.27.0


