Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE73CD98CF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY6fU-0003Md-AP; Fri, 12 Jun 2026 14:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <7c4e53eb73c0580d7a321dbf3823ba5647652298@kylie.crudebyte.com>)
 id 1wY6fM-0003L4-63; Fri, 12 Jun 2026 14:31:40 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <7c4e53eb73c0580d7a321dbf3823ba5647652298@kylie.crudebyte.com>)
 id 1wY6fH-0000qj-43; Fri, 12 Jun 2026 14:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=LwNhhI3hE8IqgimhjcIWZMiFUZFgeoXrAM8FKvGMPZM=; b=ceXq2
 Iu1T9ML0mHSY3V3SPuojr47Td0vR1gj/V+Fftr13yQ9ddGwxJ6T67Wv4b0opg1uKlp/r4knbp1ZJ4
 qgLVvNM+AUGuovZbtMU7JqaZEujLEbn+bt/ESpZRiQm95dlDwYqeNjYUsXz3trf/yf575HInDoYh9
 YK7ami/kh45/GkqqQPubn9/cZ1h6oQZ8HDVR365WL2wxcPppUHKYW4DRKJHZU8jqJHpvq++ZYYUqC
 Lqag1MFKzoFvX3sehdFiywPPJRRV8k2cfl1/gXlxQkmmbJZf51ZMN3eII7WBbrqalWhmQ/M6vquGW
 Qu0MwVNc9q0WdBLBfO0sdTUS0UDJOyDv5kWaav5pM2RUpvMIiwHmycjcLDyZzSGvBicXCGFZolV6t
 7S3hAzeQKs0LV9tmaaxcCuUSS3jLvesArFEMXgiWK2kTFRcF3npgLLs6+EhsbcbhbnMhFx8jA0nnF
 1nHG7eS5c/Wm3RYwiQ5X4n77zEaFfvpRDkyihvXsc4d9RKARCTYTfsBo5M4aBnwSLc8oE+QShzL29
 TWgt7xrivoyLclrlHZsn3SPEX2Z5/CujQNTN6BWxSXB8xLmQN0FefBiVyZgE5DASyMNGAE4YtxOKw
 J6g8sMfjhIZ9xc4GhcnmInuQZql+uSLhwNr9mjaO/5HwUouX/6QG3+pEhoagWc=;
Message-ID: <7c4e53eb73c0580d7a321dbf3823ba5647652298.1781287774.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1781287774.git.qemu_oss@crudebyte.com>
References: <cover.1781287774.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 12 Jun 2026 20:22:52 +0200
Subject: [PATCH v2 1/8] hw/9pfs: add msize_limit transport callback
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Feifan Qian <bea1e@proton.me>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=7c4e53eb73c0580d7a321dbf3823ba5647652298@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Add a new callback 'msize_limit' to the V9fsTransport structure.

This allows each transport implementation to provide its theoretical
maximum 'msize' value, which will be used to cap the negotiated
msize during Tversion handshake.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 65cc45e344..14111e041a 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -481,6 +481,7 @@ struct V9fsTransport {
     void        (*init_out_iov_from_pdu)(V9fsPDU *pdu, struct iovec **piov,
                                          unsigned int *pniov, size_t size);
     void        (*push_and_notify)(V9fsPDU *pdu);
+    size_t      (*msize_limit)(V9fsState *s);
 };
 
 #endif
-- 
2.47.3


